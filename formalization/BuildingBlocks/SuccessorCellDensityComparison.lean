import BuildingBlocks.SuccessorCoarseParentSignedAbel
import Mathlib.Analysis.SumIntegralComparisons
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic

/-!
# Integer density versus continuous density in successor cells

The signed Abel comparison for the actual von Mangoldt source leaves a
unit-density sum. This file bounds that sum against the continuous
inverse-square-root density, with the strict lower and closed upper
integer endpoints used by successor cells. Fractional cell endpoints
are handled separately in the written analytic proof.
-/

namespace BuildingBlocks.SuccessorCellDensityComparison

open Finset Set MeasureTheory
open scoped BigOperators Interval
open BuildingBlocks.MertensTransfer
open BuildingBlocks.SuccessorCoarseParentSignedAbel
open BuildingBlocks.SuccessorHighParentPrimeRow

private theorem sum_Ico_succ_eq_Ioc (g : ℕ → ℝ) (a b : ℕ) :
    (∑ i ∈ Finset.Ico a b, g (i + 1)) = ∑ d ∈ Finset.Ioc a b, g d := by
  rw [Finset.sum_Ico_add' g a b 1]
  simp only [Finset.Ico_add_one_right_eq_Icc,
    Finset.Icc_add_one_left_eq_Ioc]

private theorem weight_diff_telescopes (w : ℕ → ℝ)
    {a b : ℕ} (hab : a ≤ b) :
    (∑ i ∈ Finset.Ico a b, (w i - w (i + 1))) = w a - w b := by
  induction b, hab using Nat.le_induction with
  | base => simp
  | succ b hab ih =>
      rw [Finset.sum_Ico_succ_top hab, ih]
      ring

private theorem inv_sqrt_antitoneOn {a b : ℕ} (ha : 1 ≤ a) :
    AntitoneOn (fun x : ℝ => 1 / Real.sqrt x) (Set.Icc (a : ℝ) (b : ℝ)) := by
  intro x hx y _ hxy
  have hapos : (0 : ℝ) < a := by exact_mod_cast (show 0 < a by omega)
  have hxpos : 0 < x := lt_of_lt_of_le hapos hx.1
  exact one_div_le_one_div_of_le (Real.sqrt_pos.2 hxpos) (Real.sqrt_le_sqrt hxy)

/-- The right-endpoint unit-density sum lies below the continuous density.
The excess integral is at most the left weight minus the right weight. -/
theorem inv_sqrt_integer_density_error
    {a b : ℕ} (ha : 1 ≤ a) (hab : a ≤ b) :
    0 ≤ (∫ x in (a : ℝ)..(b : ℝ), 1 / Real.sqrt x) -
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) ∧
    (∫ x in (a : ℝ)..(b : ℝ), 1 / Real.sqrt x) -
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) ≤
        1 / Real.sqrt (a : ℝ) - 1 / Real.sqrt (b : ℝ) := by
  have hf := inv_sqrt_antitoneOn (b := b) ha
  have hl := hf.sum_le_integral_Ico hab
  have hu := hf.integral_le_sum_Ico hab
  have hshift :
      (∑ i ∈ Finset.Ico a b,
        (1 : ℝ) / Real.sqrt ((i + 1 : ℕ) : ℝ)) =
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) :=
    sum_Ico_succ_eq_Ioc (fun d => 1 / Real.sqrt (d : ℝ)) a b
  rw [hshift] at hl
  have htel := weight_diff_telescopes
    (fun n => (1 : ℝ) / Real.sqrt (n : ℝ)) hab
  have hupper :
      (∑ i ∈ Finset.Ico a b, 1 / Real.sqrt (i : ℝ)) -
      (∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ)) =
        1 / Real.sqrt (a : ℝ) - 1 / Real.sqrt (b : ℝ) := by
    rw [← hshift, ← Finset.sum_sub_distrib]
    exact htel
  constructor <;> linarith

private theorem sqrt_increment_bounds {x y : ℝ} (hx : 0 < x) (hxy : x ≤ y) :
    (y - x) / Real.sqrt y ≤ 2 * (Real.sqrt y - Real.sqrt x) ∧
      2 * (Real.sqrt y - Real.sqrt x) ≤ (y - x) / Real.sqrt x := by
  have hy : 0 < y := lt_of_lt_of_le hx hxy
  have hsx : 0 < Real.sqrt x := Real.sqrt_pos.2 hx
  have hsy : 0 < Real.sqrt y := Real.sqrt_pos.2 hy
  have hxsq := Real.sq_sqrt hx.le
  have hysq := Real.sq_sqrt hy.le
  constructor
  · apply (div_le_iff₀ hsy).2
    nlinarith [sq_nonneg (Real.sqrt y - Real.sqrt x)]
  · apply (le_div_iff₀ hsx).2
    nlinarith [sq_nonneg (Real.sqrt y - Real.sqrt x)]

private theorem sum_Ioc_sqrt_diff (w : ℕ → ℝ)
    {a b : ℕ} (hab : a ≤ b) :
    (∑ d ∈ Finset.Ioc a b, (w d - w (d - 1))) = w b - w a := by
  induction b, hab using Nat.le_induction with
  | base => simp
  | succ b hab ih =>
      rw [Finset.sum_Ioc_succ_top hab, ih]
      have hprev : b + 1 - 1 = b := by omega
      rw [hprev]
      ring

private theorem sum_Ioc_reverse_diff (w : ℕ → ℝ)
    {a b : ℕ} (hab : a ≤ b) :
    (∑ d ∈ Finset.Ioc a b, (w (d - 1) - w d)) = w a - w b := by
  have h := sum_Ioc_sqrt_diff w hab
  calc
    (∑ d ∈ Finset.Ioc a b, (w (d - 1) - w d)) =
        -(∑ d ∈ Finset.Ioc a b, (w d - w (d - 1))) := by
      rw [← Finset.sum_neg_distrib]
      apply Finset.sum_congr rfl
      intro d _
      ring
    _ = w a - w b := by rw [h]; ring

/-- Exact integer-boundary comparison with the continuous inverse-square-root
primitive. The right-endpoint sum underestimates the primitive by at most one
telescoping boundary weight. -/
theorem inv_sqrt_sum_sqrt_integer_error
    {a b : ℕ} (ha : 1 ≤ a) (hab : a ≤ b) :
    0 ≤ 2 * (Real.sqrt (b : ℝ) - Real.sqrt (a : ℝ)) -
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) ∧
    2 * (Real.sqrt (b : ℝ) - Real.sqrt (a : ℝ)) -
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) ≤
        1 / Real.sqrt (a : ℝ) - 1 / Real.sqrt (b : ℝ) := by
  have hstep : ∀ d ∈ Finset.Ioc a b,
      1 / Real.sqrt (d : ℝ) ≤
        2 * (Real.sqrt (d : ℝ) - Real.sqrt ((d - 1 : ℕ) : ℝ)) ∧
      2 * (Real.sqrt (d : ℝ) - Real.sqrt ((d - 1 : ℕ) : ℝ)) ≤
        1 / Real.sqrt ((d - 1 : ℕ) : ℝ) := by
    intro d hd
    have hda : a < d := (Finset.mem_Ioc.mp hd).1
    have hdpos : 0 < d - 1 := by omega
    have hx : (0 : ℝ) < (d - 1 : ℕ) := by exact_mod_cast hdpos
    have hxy : (((d - 1 : ℕ) : ℝ)) ≤ (d : ℝ) := by
      exact_mod_cast (show d - 1 ≤ d by omega)
    have hdiff : (d : ℝ) - ((d - 1 : ℕ) : ℝ) = 1 := by
      have hdn : d - 1 + 1 = d := by omega
      rw [← hdn]
      push_cast
      ring
    simpa only [hdiff] using (sqrt_increment_bounds hx hxy)
  have hsumlo :
      (∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ)) ≤
      ∑ d ∈ Finset.Ioc a b,
        2 * (Real.sqrt (d : ℝ) - Real.sqrt ((d - 1 : ℕ) : ℝ)) := by
    exact Finset.sum_le_sum (fun d hd => (hstep d hd).1)
  have hsumhi :
      (∑ d ∈ Finset.Ioc a b,
        2 * (Real.sqrt (d : ℝ) - Real.sqrt ((d - 1 : ℕ) : ℝ))) ≤
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt ((d - 1 : ℕ) : ℝ) := by
    exact Finset.sum_le_sum (fun d hd => (hstep d hd).2)
  have htel_sqrt := sum_Ioc_sqrt_diff (fun d => Real.sqrt (d : ℝ)) hab
  have htel_weight := sum_Ioc_reverse_diff (fun d => (1 : ℝ) / Real.sqrt (d : ℝ)) hab
  have hmiddle :
      (∑ d ∈ Finset.Ioc a b,
        2 * (Real.sqrt (d : ℝ) - Real.sqrt ((d - 1 : ℕ) : ℝ))) =
        2 * (Real.sqrt (b : ℝ) - Real.sqrt (a : ℝ)) := by
    rw [← Finset.mul_sum, htel_sqrt]
  have hright :
      (∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt ((d - 1 : ℕ) : ℝ)) -
      (∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ)) =
        1 / Real.sqrt (a : ℝ) - 1 / Real.sqrt (b : ℝ) := by
    rw [← Finset.sum_sub_distrib]
    exact htel_weight
  constructor <;> linarith

private theorem sqrt_fractional_increment_le
    {A : ℕ} {x : ℝ} (hA : 1 ≤ A)
    (hx0 : (A : ℝ) ≤ x) (hx1 : x ≤ (A : ℝ) + 1) :
    0 ≤ 2 * (Real.sqrt x - Real.sqrt (A : ℝ)) ∧
      2 * (Real.sqrt x - Real.sqrt (A : ℝ)) ≤
        1 / Real.sqrt (A : ℝ) := by
  have hApos : (0 : ℝ) < A := by exact_mod_cast (show 0 < A by omega)
  have hsApos : 0 < Real.sqrt (A : ℝ) := Real.sqrt_pos.2 hApos
  have hsle := Real.sqrt_le_sqrt hx0
  have hinc := (sqrt_increment_bounds hApos hx0).2
  have hspan : x - (A : ℝ) ≤ 1 := by linarith
  have hdiv : (x - (A : ℝ)) / Real.sqrt (A : ℝ) ≤
      1 / Real.sqrt (A : ℝ) :=
    div_le_div_of_nonneg_right hspan hsApos.le
  constructor
  · linarith
  · exact hinc.trans hdiv

/-- Fractional lower and upper endpoints incur at most one left inverse-square-root
unit. This is the exact deterministic density comparison used when a successor
child interval has real endpoints but integer dilation labels. -/
theorem inv_sqrt_fractional_density_error
    {A B : ℕ} {a b : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B)
    (ha0 : (A : ℝ) ≤ a) (ha1 : a ≤ (A : ℝ) + 1)
    (hb0 : (B : ℝ) ≤ b) (hb1 : b ≤ (B : ℝ) + 1) :
    |2 * (Real.sqrt b - Real.sqrt a) -
      ∑ d ∈ Finset.Ioc A B, 1 / Real.sqrt (d : ℝ)| ≤
        1 / Real.sqrt (A : ℝ) := by
  have hB : 1 ≤ B := hA.trans hAB
  obtain ⟨hintlo, hinthi⟩ := inv_sqrt_sum_sqrt_integer_error hA hAB
  obtain ⟨hainc0, hainc1⟩ := sqrt_fractional_increment_le hA ha0 ha1
  obtain ⟨hbinc0, hbinc1⟩ := sqrt_fractional_increment_le hB hb0 hb1
  have hApos : (0 : ℝ) < A := by exact_mod_cast (show 0 < A by omega)
  have hABreal : (A : ℝ) ≤ (B : ℝ) := by exact_mod_cast hAB
  have hweight : 1 / Real.sqrt (B : ℝ) ≤ 1 / Real.sqrt (A : ℝ) :=
    one_div_le_one_div_of_le (Real.sqrt_pos.2 hApos)
      (Real.sqrt_le_sqrt hABreal)
  have hsplit :
      2 * (Real.sqrt b - Real.sqrt a) -
        (∑ d ∈ Finset.Ioc A B, 1 / Real.sqrt (d : ℝ)) =
      (2 * (Real.sqrt (B : ℝ) - Real.sqrt (A : ℝ)) -
        ∑ d ∈ Finset.Ioc A B, 1 / Real.sqrt (d : ℝ)) +
        2 * (Real.sqrt b - Real.sqrt (B : ℝ)) -
        2 * (Real.sqrt a - Real.sqrt (A : ℝ)) := by ring
  rw [hsplit]
  apply abs_le.mpr
  constructor <;> linarith

/-- Evaluation of the exact continuous density integral on its positive
domain. This identifies the square-root primitive with the continuous
operator used in the successor-cell residual. -/
theorem inverse_sqrt_interval_integral {a b : ℝ}
    (ha : 0 < a) (hab : a ≤ b) :
    (∫ x in a..b, 1 / Real.sqrt x) =
      2 * (Real.sqrt b - Real.sqrt a) := by
  have hcongr : Set.EqOn (fun x : ℝ => 1 / Real.sqrt x)
      (fun x : ℝ => x ^ (-(1 / 2 : ℝ))) (Set.uIcc a b) := by
    intro x hx
    have hx0 : 0 ≤ x := by
      rw [Set.uIcc_of_le hab] at hx
      exact (ha.trans_le hx.1).le
    change 1 / Real.sqrt x = x ^ (-(1 / 2 : ℝ))
    rw [Real.sqrt_eq_rpow, Real.rpow_neg hx0]
    ring
  rw [intervalIntegral.integral_congr hcongr]
  rw [integral_rpow (Or.inl (by norm_num : (-1 : ℝ) < -(1 / 2 : ℝ)))]
  have hr : -(1 / 2 : ℝ) + 1 = 1 / 2 := by ring
  rw [hr, ← Real.sqrt_eq_rpow, ← Real.sqrt_eq_rpow]
  ring

/-- The actual von Mangoldt mass, with every prime power included, is paired
with the continuous square-root density before taking an absolute value.
Only a local Chebyshev-error envelope is assumed. -/
theorem actual_prime_continuous_density_bound
    {A B : ℕ} {a b : ℝ} (hA : 1 ≤ A) (hAB : A < B)
    (ha0 : (A : ℝ) ≤ a) (ha1 : a ≤ (A : ℝ) + 1)
    (hb0 : (B : ℝ) ≤ b) (hb1 : b ≤ (B : ℝ) + 1)
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc A B, |integerError k| ≤ H) :
    |(∑ d ∈ Finset.Ioc A B,
        ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      2 * (Real.sqrt b - Real.sqrt a)| ≤
      2 * H / Real.sqrt (A + 1 : ℕ) +
        1 / Real.sqrt (A : ℝ) := by
  have hprime := actual_prime_discrepancy_Ioc_inv_sqrt_bound hAB hH hE
  have hdensity := inv_sqrt_fractional_density_error hA hAB.le ha0 ha1 hb0 hb1
  have hsum :
      (∑ d ∈ Finset.Ioc A B,
          ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) =
      (∑ d ∈ Finset.Ioc A B,
          (ArithmeticFunction.vonMangoldt d - 1) / Real.sqrt (d : ℝ)) +
      (∑ d ∈ Finset.Ioc A B, 1 / Real.sqrt (d : ℝ)) := by
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro d _
    ring
  rw [hsum]
  have htri := abs_add_le
    (∑ d ∈ Finset.Ioc A B,
        (ArithmeticFunction.vonMangoldt d - 1) / Real.sqrt (d : ℝ))
    (-(2 * (Real.sqrt b - Real.sqrt a) -
      ∑ d ∈ Finset.Ioc A B, 1 / Real.sqrt (d : ℝ)))
  simp only [abs_neg] at htri
  convert htri.trans (add_le_add hprime hdensity) using 1; ring_nf

private theorem nat_div_real_bracket (r q : ℕ) (hq : 0 < q) :
    (((r / q : ℕ) : ℝ)) ≤ (r : ℝ) / (q : ℝ) ∧
      (r : ℝ) / (q : ℝ) ≤ (((r / q : ℕ) : ℝ)) + 1 := by
  have hqR : (0 : ℝ) < q := by exact_mod_cast hq
  have hlo : (((r / q : ℕ) : ℝ)) ≤ (r : ℝ) / (q : ℝ) := Nat.cast_div_le
  have hnat : r < (r / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).mp (Nat.lt_succ_self (r / q))
  have hnatR : (r : ℝ) < ((((r / q : ℕ) : ℝ)) + 1) * (q : ℝ) := by
    exact_mod_cast hnat
  have hhi : (r : ℝ) / (q : ℝ) ≤ (((r / q : ℕ) : ℝ)) + 1 :=
    (div_lt_iff₀ hqR).2 hnatR |>.le
  exact ⟨hlo, hhi⟩

/-- Exact coarse-parent successor-cell comparison, with the real quotient
endpoints and the literal integer child labels. This is the deterministic
signed inequality used before inserting the unconditional PNT error. -/
theorem child_dilation_continuous_density_bound
    {r n D : ℕ} (hn : 0 < n)
    (hA : 1 ≤ r / (n + 1))
    (hAB : r / (n + 1) < r / n)
    (hD : D ≤ r / (n + 1))
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc (r / (n + 1)) (r / n),
      |integerError k| ≤ H) :
    |(∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      2 * (Real.sqrt ((r : ℝ) / (n : ℝ)) -
        Real.sqrt ((r : ℝ) / ((n + 1 : ℕ) : ℝ)))| ≤
      2 * H / Real.sqrt (r / (n + 1) + 1 : ℕ) +
        1 / Real.sqrt ((r / (n + 1) : ℕ) : ℝ) := by
  obtain ⟨ha0, ha1⟩ := nat_div_real_bracket r (n + 1) (by omega)
  obtain ⟨hb0, hb1⟩ := nat_div_real_bracket r n hn
  rw [child_dilations_eq_quotient_Ioc hn hD]
  exact actual_prime_continuous_density_bound hA hAB ha0 ha1 hb0 hb1 hH hE

/-- The same child comparison with the continuous density written as the
literal interval integral, preserving the real quotient endpoints. -/
theorem child_dilation_integral_density_bound
    {r n D : ℕ} (hn : 0 < n)
    (hA : 1 ≤ r / (n + 1))
    (hAB : r / (n + 1) < r / n)
    (hD : D ≤ r / (n + 1))
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc (r / (n + 1)) (r / n),
      |integerError k| ≤ H) :
    |(∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      (∫ x in ((r : ℝ) / ((n + 1 : ℕ) : ℝ))..((r : ℝ) / (n : ℝ)),
        1 / Real.sqrt x)| ≤
      2 * H / Real.sqrt (r / (n + 1) + 1 : ℕ) +
        1 / Real.sqrt ((r / (n + 1) : ℕ) : ℝ) := by
  obtain ⟨ha0, ha1⟩ := nat_div_real_bracket r (n + 1) (by omega)
  obtain ⟨hb0, _⟩ := nat_div_real_bracket r n hn
  have hApos : (0 : ℝ) < (r / (n + 1) : ℕ) := by
    exact_mod_cast (show 0 < r / (n + 1) by omega)
  have ha : 0 < (r : ℝ) / ((n + 1 : ℕ) : ℝ) :=
    lt_of_lt_of_le hApos ha0
  have hsucc : (((r / (n + 1) : ℕ) : ℝ)) + 1 ≤
      (((r / n : ℕ) : ℝ)) := by
    exact_mod_cast Nat.succ_le_of_lt hAB
  have hab : (r : ℝ) / ((n + 1 : ℕ) : ℝ) ≤ (r : ℝ) / (n : ℝ) := by
    linarith
  rw [inverse_sqrt_interval_integral ha hab]
  exact child_dilation_continuous_density_bound hn hA hAB hD hH hE

/-- The preceding signed comparison with the exact physical logarithmic-cell
normalization. It compares the actual prime row with the continuous density
row before the final continuous-cell geometry correction. -/
theorem normalized_child_dilation_continuous_density_bound
    {r n D : ℕ} (hn : 0 < n)
    (hA : 1 ≤ r / (n + 1))
    (hAB : r / (n + 1) < r / n)
    (hD : D ≤ r / (n + 1))
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc (r / (n + 1)) (r / n),
      |integerError k| ≤ H) :
    |Real.sqrt (cellLength r / cellLength n) *
        (∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      Real.sqrt (cellLength r / cellLength n) *
        (2 * (Real.sqrt ((r : ℝ) / (n : ℝ)) -
          Real.sqrt ((r : ℝ) / ((n + 1 : ℕ) : ℝ))))| ≤
      Real.sqrt (cellLength r / cellLength n) *
        (2 * H / Real.sqrt (r / (n + 1) + 1 : ℕ) +
          1 / Real.sqrt ((r / (n + 1) : ℕ) : ℝ)) := by
  have h := child_dilation_continuous_density_bound hn hA hAB hD hH hE
  rw [← mul_sub, abs_mul, abs_of_nonneg (Real.sqrt_nonneg _)]
  exact mul_le_mul_of_nonneg_left h (Real.sqrt_nonneg _)

/-- The exact signed row estimate in the physical cell normalization, with
the continuous density kept as an interval integral. -/
theorem normalized_child_dilation_integral_density_bound
    {r n D : ℕ} (hn : 0 < n)
    (hA : 1 ≤ r / (n + 1))
    (hAB : r / (n + 1) < r / n)
    (hD : D ≤ r / (n + 1))
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc (r / (n + 1)) (r / n),
      |integerError k| ≤ H) :
    |Real.sqrt (cellLength r / cellLength n) *
        (∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      Real.sqrt (cellLength r / cellLength n) *
        (∫ x in ((r : ℝ) / ((n + 1 : ℕ) : ℝ))..((r : ℝ) / (n : ℝ)),
          1 / Real.sqrt x)| ≤
      Real.sqrt (cellLength r / cellLength n) *
        (2 * H / Real.sqrt (r / (n + 1) + 1 : ℕ) +
          1 / Real.sqrt ((r / (n + 1) : ℕ) : ℝ)) := by
  have h := child_dilation_integral_density_bound hn hA hAB hD hH hE
  rw [← mul_sub, abs_mul, abs_of_nonneg (Real.sqrt_nonneg _)]
  exact mul_le_mul_of_nonneg_left h (Real.sqrt_nonneg _)

#print axioms inv_sqrt_integer_density_error
#print axioms inv_sqrt_sum_sqrt_integer_error
#print axioms inv_sqrt_fractional_density_error
#print axioms inverse_sqrt_interval_integral
#print axioms actual_prime_continuous_density_bound
#print axioms child_dilation_continuous_density_bound
#print axioms child_dilation_integral_density_bound
#print axioms normalized_child_dilation_continuous_density_bound
#print axioms normalized_child_dilation_integral_density_bound

end BuildingBlocks.SuccessorCellDensityComparison
