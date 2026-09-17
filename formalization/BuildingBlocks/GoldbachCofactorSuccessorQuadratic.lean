import BuildingBlocks.GoldbachCofactorSuccessorFinite
import Mathlib.NumberTheory.Harmonic.Bounds
import Mathlib.Tactic

/-!
# Quadratic logarithmic successor bound for the actual Goldbach cofactor

Retaining the new von Mangoldt birth inside the complementary
reciprocal sum saves one logarithm compared with the pointwise
birth bound. Every prime power and the new two-leg endpoint remain.
-/

namespace BuildingBlocks.GoldbachCofactorSuccessorQuadratic

open Finset Real Classical
open scoped BigOperators

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n
abbrev ψ (n : ℕ) : ℝ := BuildingBlocks.CoarsePrimitive.psi n
abbrev q (n : ℕ) : ℝ := BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError n
abbrev Q (s : ℕ) : ℝ := BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s

def reciprocalPrimePrefix (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 N, Λ n / (n : ℝ)

/-- Exact finite summation by parts for complete von Mangoldt
births. The source prefix is the actual Chebyshev function. -/
theorem reciprocalPrimePrefix_partial (N : ℕ) :
    reciprocalPrimePrefix (N + 1) =
      ψ (N + 1) / ((N + 1 : ℕ) : ℝ) +
        ∑ n ∈ Icc 1 N, ψ n /
          ((n : ℝ) * (((n + 1 : ℕ) : ℝ))) := by
  induction N with
  | zero =>
      simp [reciprocalPrimePrefix, ψ, Λ,
        BuildingBlocks.CoarsePrimitive.psi, Finset.sum_range_succ,
        ArithmeticFunction.vonMangoldt_apply, not_isPrimePow_zero]
  | succ N ih =>
      have hM : reciprocalPrimePrefix (N + 1 + 1) =
          reciprocalPrimePrefix (N + 1) +
            Λ (N + 1 + 1) / (((N + 1 + 1 : ℕ) : ℝ)) := by
        unfold reciprocalPrimePrefix
        rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1 + 1)]
      have hsum :
          (∑ n ∈ Icc 1 (N + 1), ψ n /
            ((n : ℝ) * (((n + 1 : ℕ) : ℝ)))) =
          (∑ n ∈ Icc 1 N, ψ n /
            ((n : ℝ) * (((n + 1 : ℕ) : ℝ)))) +
            ψ (N + 1) /
              ((((N + 1 : ℕ) : ℝ)) * (((N + 1 + 1 : ℕ) : ℝ))) := by
        rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]
      have hbirth : Λ (N + 1 + 1) = ψ (N + 1 + 1) - ψ (N + 1) := by
        have h := BuildingBlocks.CoarsePrimitive.psi_succ (N + 1)
        dsimp [ψ, Λ]
        linarith
      have hpos1 : (0 : ℝ) < ((N + 1 : ℕ) : ℝ) := by positivity
      have hpos2 : (0 : ℝ) < ((N + 1 + 1 : ℕ) : ℝ) := by positivity
      rw [hM, ih, hsum, hbirth]
      push_cast
      field_simp
      ring

/-- Chebyshev's linear bound controls the complete reciprocal
von Mangoldt mass by one logarithm. -/
theorem reciprocalPrimePrefix_le_log (N : ℕ) :
    reciprocalPrimePrefix (N + 1) ≤
      (4 * Real.log 2) * (2 + Real.log (((N + 1 : ℕ) : ℝ))) := by
  let C : ℝ := 4 * Real.log 2
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have htop : ψ (N + 1) / (((N + 1 : ℕ) : ℝ)) ≤ C := by
    have hψ := BuildingBlocks.CoarsePrimitive.psi_le_linear (N + 1)
    have hd : 0 < (((N + 1 : ℕ) : ℝ)) := by positivity
    exact (div_le_iff₀ hd).2 (by simpa [C, mul_comm] using hψ)
  have hterm : ∀ n ∈ Icc 1 N,
      ψ n / ((n : ℝ) * (((n + 1 : ℕ) : ℝ))) ≤ C * (n : ℝ)⁻¹ := by
    intro n hn
    have hn1 : 1 ≤ n := (mem_Icc.mp hn).1
    have hnpos : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
    have hden : 0 < (n : ℝ) * (((n + 1 : ℕ) : ℝ)) := by positivity
    have hψ := BuildingBlocks.CoarsePrimitive.psi_le_linear n
    have hratio : ψ n / ((n : ℝ) * (((n + 1 : ℕ) : ℝ))) ≤
        C / (((n + 1 : ℕ) : ℝ)) := by
      calc
        _ ≤ (C * (n : ℝ)) /
            ((n : ℝ) * (((n + 1 : ℕ) : ℝ))) :=
          div_le_div_of_nonneg_right (by simpa [C] using hψ) hden.le
        _ = _ := by field_simp
    have hnle : (n : ℝ) ≤ (((n + 1 : ℕ) : ℝ)) := by
      exact_mod_cast (show n ≤ n + 1 by omega)
    have hrec : (((n + 1 : ℕ) : ℝ))⁻¹ ≤ (n : ℝ)⁻¹ :=
      by simpa only [one_div] using one_div_le_one_div_of_le hnpos hnle
    have hmul := mul_le_mul_of_nonneg_left hrec hC
    calc
      _ ≤ C / (((n + 1 : ℕ) : ℝ)) := hratio
      _ ≤ C * (n : ℝ)⁻¹ := by simpa only [div_eq_mul_inv] using hmul
  have hsubset : Icc 1 N ⊆ Icc 1 (N + 1) := by
    intro n hn
    simp only [mem_Icc] at hn ⊢
    omega
  have hrecSum : (∑ n ∈ Icc 1 N, (n : ℝ)⁻¹) ≤
      (harmonic (N + 1) : ℝ) := by
    have h : (∑ n ∈ Icc 1 N, (n : ℝ)⁻¹) ≤
        ∑ n ∈ Icc 1 (N + 1), (n : ℝ)⁻¹ :=
      Finset.sum_le_sum_of_subset_of_nonneg hsubset
        (by intro n hn hnot; positivity)
    simpa only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv,
      Rat.cast_natCast] using h
  have hsum :
      (∑ n ∈ Icc 1 N, ψ n /
        ((n : ℝ) * (((n + 1 : ℕ) : ℝ)))) ≤
        C * (harmonic (N + 1) : ℝ) := by
    calc
      _ ≤ ∑ n ∈ Icc 1 N, C * (n : ℝ)⁻¹ := Finset.sum_le_sum hterm
      _ = C * (∑ n ∈ Icc 1 N, (n : ℝ)⁻¹) := by rw [Finset.mul_sum]
      _ ≤ _ := mul_le_mul_of_nonneg_left hrecSum hC
  have hH := harmonic_le_one_add_log (N + 1)
  have hHmul := mul_le_mul_of_nonneg_left hH hC
  rw [reciprocalPrimePrefix_partial]
  dsimp [C] at *
  nlinarith

/-- Reversing the complementary Goldbach leg embeds its actual
von Mangoldt reciprocal weights in the complete prime prefix. -/
theorem complementaryPrimePrefix_le (s : ℕ) (hs : 4 ≤ s) :
    (∑ m ∈ Icc 2 (s - 2),
      Λ (s + 1 - m) / (((s + 1 - m : ℕ) : ℝ))) ≤
        reciprocalPrimePrefix s := by
  have hreverse :
      (∑ m ∈ Icc 2 (s - 2),
        Λ (s + 1 - m) / (((s + 1 - m : ℕ) : ℝ))) =
      ∑ y ∈ Icc 3 (s - 1), Λ y / (y : ℝ) := by
    apply Finset.sum_bij (fun m _ => s + 1 - m)
    · intro m hm
      simp only [mem_Icc] at hm ⊢
      omega
    · intro m hm n hn hmn
      simp only [mem_Icc] at hm hn
      omega
    · intro y hy
      simp only [mem_Icc] at hy
      refine ⟨s + 1 - y, ?_, ?_⟩
      · simp only [mem_Icc]
        omega
      · omega
    · intro m hm
      rfl
  have hsubset : Icc 3 (s - 1) ⊆ Icc 1 s := by
    intro y hy
    simp only [mem_Icc] at hy ⊢
    omega
  rw [hreverse]
  unfold reciprocalPrimePrefix
  exact Finset.sum_le_sum_of_subset_of_nonneg hsubset
    (by
      intro y hy hnot
      exact div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Nat.cast_nonneg _))

/-- Keep the actual prime-power birth in the ratio step until after
summation. This is the source of the saved logarithm. -/
theorem ratioError_step_abs_le_birth (y : ℕ) (hy : 1 ≤ y) :
    |q (y + 1) - q y| ≤
      (Λ (y + 1) + 4 * Real.log 2 + 2) /
        (((y + 1 : ℕ) : ℝ)) := by
  have hypos : 0 < (y : ℝ) := by exact_mod_cast (show 0 < y by omega)
  have hdpos : 0 < (((y + 1 : ℕ) : ℝ)) := by positivity
  have hdpos' : 0 < (y : ℝ) + 1 := by positivity
  have hΛ0 : 0 ≤ Λ (y + 1) := ArithmeticFunction.vonMangoldt_nonneg
  have habsΛ : |Λ (y + 1) - 1| ≤ Λ (y + 1) + 1 := by
    simpa [abs_of_nonneg hΛ0] using
      (abs_sub_le (Λ (y + 1)) (0 : ℝ) (1 : ℝ))
  have hE :=
    BuildingBlocks.GoldbachCofactorSuccessorFinite.abs_primeError_le_linear y
  have hden : 0 < (y : ℝ) * (((y + 1 : ℕ) : ℝ)) := mul_pos hypos hdpos
  rw [BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError_succ y hy]
  calc
    |(Λ (y + 1) - 1) / (((y + 1 : ℕ) : ℝ)) -
        BuildingBlocks.GoldbachCofactorVolterraFinite.primeError y /
          ((y : ℝ) * (((y + 1 : ℕ) : ℝ)))| ≤
      |Λ (y + 1) - 1| / (((y + 1 : ℕ) : ℝ)) +
        |BuildingBlocks.GoldbachCofactorVolterraFinite.primeError y| /
          ((y : ℝ) * (((y + 1 : ℕ) : ℝ))) := by
      simpa [Nat.cast_add, abs_div, abs_mul,
        abs_of_pos hypos, abs_of_pos hdpos'] using
        (abs_sub_le
          ((Λ (y + 1) - 1) / (((y + 1 : ℕ) : ℝ)))
          (0 : ℝ)
          (BuildingBlocks.GoldbachCofactorVolterraFinite.primeError y /
            ((y : ℝ) * (((y + 1 : ℕ) : ℝ)))))
    _ ≤ (Λ (y + 1) + 1) / (((y + 1 : ℕ) : ℝ)) +
          ((4 * Real.log 2 + 1) * (y : ℝ)) /
            ((y : ℝ) * (((y + 1 : ℕ) : ℝ))) := by
      exact add_le_add (div_le_div_of_nonneg_right habsΛ hdpos.le)
        (div_le_div_of_nonneg_right hE hden.le)
    _ = _ := by
      field_simp
      ring

/-- The complete actual signed Goldbach cofactor has a quadratic
logarithmic one-step modulus. This controls changes, not the
cofactor's absolute size. -/
theorem signedCofactorError_step_abs_le_quadratic (s : ℕ) (hs : 4 ≤ s) :
    |Q (s + 1) - Q s| ≤
      Real.log (s : ℝ) *
        (|q 2| +
          (4 * Real.log 2) * (2 + Real.log (s : ℝ)) +
          (4 * Real.log 2 + 2) * (1 + Real.log (s : ℝ))) := by
  let L : ℝ := Real.log (s : ℝ)
  let C : ℝ := 4 * Real.log 2
  have hsone : 1 ≤ (s : ℝ) := by
    exact_mod_cast (show 1 ≤ s by omega)
  have hL : 0 ≤ L := Real.log_nonneg hsone
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hC2 : 0 ≤ C + 2 := by positivity
  have hend : |Λ (s - 1) * q 2| ≤ L * |q 2| := by
    have hΛ0 : 0 ≤ Λ (s - 1) := ArithmeticFunction.vonMangoldt_nonneg
    have hΛle : Λ (s - 1) ≤ L :=
      ArithmeticFunction.vonMangoldt_le_log.trans
        (Real.log_le_log
          (by exact_mod_cast (show 0 < s - 1 by omega))
          (by exact_mod_cast (show s - 1 ≤ s by omega)))
    rw [abs_mul, abs_of_nonneg hΛ0]
    exact mul_le_mul_of_nonneg_right hΛle (abs_nonneg _)
  have hterm : ∀ m ∈ Icc 2 (s - 2),
      |Λ m * (q (s + 1 - m) - q (s - m))| ≤
        L * ((Λ (s + 1 - m) + C + 2) /
          (((s + 1 - m : ℕ) : ℝ))) := by
    intro m hm
    obtain ⟨hm2, hmle⟩ := mem_Icc.mp hm
    have hΛ0 : 0 ≤ Λ m := ArithmeticFunction.vonMangoldt_nonneg
    have hΛle : Λ m ≤ L :=
      ArithmeticFunction.vonMangoldt_le_log.trans
        (Real.log_le_log
          (by exact_mod_cast (show 0 < m by omega))
          (by exact_mod_cast (show m ≤ s by omega)))
    have hy : 1 ≤ s - m := by omega
    have hstep : s + 1 - m = (s - m) + 1 := by omega
    have hden : 0 < (((s + 1 - m : ℕ) : ℝ)) := by
      exact_mod_cast (show 0 < s + 1 - m by omega)
    have hnum : 0 ≤ Λ (s + 1 - m) + C + 2 := by
      have := ArithmeticFunction.vonMangoldt_nonneg (n := s + 1 - m)
      positivity
    have hratio := ratioError_step_abs_le_birth (s - m) hy
    rw [← hstep] at hratio
    have hbound : |q (s + 1 - m) - q (s - m)| ≤
        (Λ (s + 1 - m) + C + 2) /
          (((s + 1 - m : ℕ) : ℝ)) := by
      simpa [C] using hratio
    calc
      |Λ m * (q (s + 1 - m) - q (s - m))| =
          Λ m * |q (s + 1 - m) - q (s - m)| := by
            rw [abs_mul, abs_of_nonneg hΛ0]
      _ ≤ Λ m * ((Λ (s + 1 - m) + C + 2) /
          (((s + 1 - m : ℕ) : ℝ))) :=
        mul_le_mul_of_nonneg_left hbound hΛ0
      _ ≤ _ :=
        mul_le_mul_of_nonneg_right hΛle (div_nonneg hnum hden.le)
  have hM : reciprocalPrimePrefix s ≤ C * (2 + L) := by
    have hsm : s - 1 + 1 = s := by omega
    have h := reciprocalPrimePrefix_le_log (s - 1)
    rw [hsm] at h
    simpa [C, L] using h
  have hprime :
      (∑ m ∈ Icc 2 (s - 2),
        Λ (s + 1 - m) / (((s + 1 - m : ℕ) : ℝ))) ≤
          C * (2 + L) :=
    (complementaryPrimePrefix_le s hs).trans hM
  have hrec :
      (∑ m ∈ Icc 2 (s - 2),
        ((((s + 1 - m : ℕ) : ℝ))⁻¹)) ≤ 1 + L :=
    (BuildingBlocks.GoldbachCofactorSuccessorFinite.reciprocal_complement_le_harmonic
      s hs).trans (by simpa [L] using harmonic_le_one_add_log s)
  have hsum :
      |∑ m ∈ Icc 2 (s - 2),
        Λ m * (q (s + 1 - m) - q (s - m))| ≤
          L * (C * (2 + L) + (C + 2) * (1 + L)) := by
    calc
      _ ≤ ∑ m ∈ Icc 2 (s - 2),
        |Λ m * (q (s + 1 - m) - q (s - m))| :=
          Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ m ∈ Icc 2 (s - 2),
        L * ((Λ (s + 1 - m) + C + 2) /
          (((s + 1 - m : ℕ) : ℝ))) :=
          Finset.sum_le_sum hterm
      _ = L * (∑ m ∈ Icc 2 (s - 2),
        (Λ (s + 1 - m) + C + 2) /
          (((s + 1 - m : ℕ) : ℝ))) := by rw [Finset.mul_sum]
      _ = L * ((∑ m ∈ Icc 2 (s - 2),
        Λ (s + 1 - m) / (((s + 1 - m : ℕ) : ℝ))) +
          (C + 2) * (∑ m ∈ Icc 2 (s - 2),
            ((((s + 1 - m : ℕ) : ℝ))⁻¹))) := by
        congr 1
        calc
          (∑ m ∈ Icc 2 (s - 2),
            (Λ (s + 1 - m) + C + 2) /
              (((s + 1 - m : ℕ) : ℝ))) =
          ∑ m ∈ Icc 2 (s - 2),
            (Λ (s + 1 - m) / (((s + 1 - m : ℕ) : ℝ)) +
              (C + 2) * ((((s + 1 - m : ℕ) : ℝ))⁻¹)) := by
                apply Finset.sum_congr rfl
                intro m hm
                rw [div_eq_mul_inv, div_eq_mul_inv]
                ring
          _ = (∑ m ∈ Icc 2 (s - 2),
                Λ (s + 1 - m) / (((s + 1 - m : ℕ) : ℝ))) +
              ∑ m ∈ Icc 2 (s - 2),
                (C + 2) * ((((s + 1 - m : ℕ) : ℝ))⁻¹) := by
                  rw [Finset.sum_add_distrib]
          _ = _ := by rw [Finset.mul_sum]
      _ ≤ _ := by
        apply mul_le_mul_of_nonneg_left _ hL
        exact add_le_add hprime (mul_le_mul_of_nonneg_left hrec hC2)
  rw [BuildingBlocks.GoldbachCofactorSuccessorFinite.signedCofactorError_succ s hs]
  have htri := abs_add_le (Λ (s - 1) * q 2)
    (∑ m ∈ Icc 2 (s - 2),
      Λ m * (q (s + 1 - m) - q (s - m)))
  calc
    _ ≤ |Λ (s - 1) * q 2| +
      |∑ m ∈ Icc 2 (s - 2),
        Λ m * (q (s + 1 - m) - q (s - m))| := htri
    _ ≤ L * |q 2| + L * (C * (2 + L) + (C + 2) * (1 + L)) :=
      add_le_add hend hsum
    _ = _ := by dsimp [L, C]; ring

#print axioms reciprocalPrimePrefix_partial
#print axioms reciprocalPrimePrefix_le_log
#print axioms complementaryPrimePrefix_le
#print axioms ratioError_step_abs_le_birth
#print axioms signedCofactorError_step_abs_le_quadratic

end
end BuildingBlocks.GoldbachCofactorSuccessorQuadratic
