import BuildingBlocks.FloorCorrection
import BuildingBlocks.HyperbolaProduct
import Mathlib.Analysis.SumIntegralComparisons
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.NumberTheory.Harmonic.Bounds
import Mathlib.Tactic.NormNum

open Finset Filter Set MeasureTheory
open BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct
open scoped BigOperators Topology Interval

namespace BuildingBlocks.MertensTransfer

def factorRectangle (N a b : ℕ) : Finset (ℕ × ℕ) :=
  ((Finset.Icc 1 a) ×ˢ (Finset.Icc 1 b)).filter (fun p => p.1 * p.2 ≤ N)

theorem mem_factorRectangle (N a b : ℕ) (p : ℕ × ℕ) :
    p ∈ factorRectangle N a b ↔
      1 ≤ p.1 ∧ p.1 ≤ a ∧ 1 ≤ p.2 ∧ p.2 ≤ b ∧ p.1 * p.2 ≤ N := by
  simp only [factorRectangle, Finset.mem_filter, Finset.mem_product, Finset.mem_Icc]
  tauto

theorem factorRectangle_card (N m : ℕ) :
    (factorRectangle N m N).card = ∑ a ∈ Finset.Icc 1 m, N / a := by
  classical
  simp only [factorRectangle, Finset.card_eq_sum_ones, Finset.sum_filter, Finset.sum_product]
  apply Finset.sum_congr rfl
  intro a ha
  have ha0 : 0 < a := (Finset.mem_Icc.mp ha).1
  have he : (Finset.Icc 1 N).filter (fun b => a * b ≤ N) = Finset.Icc 1 (N / a) := by
    ext b
    simp only [Finset.mem_filter, Finset.mem_Icc]
    constructor
    · rintro ⟨⟨hb, _⟩, hab⟩
      exact ⟨hb, (Nat.le_div_iff_mul_le ha0).mpr (by simpa [mul_comm] using hab)⟩
    · rintro ⟨hb, hba⟩
      exact ⟨⟨hb, hba.trans (Nat.div_le_self N a)⟩,
        by simpa [mul_comm] using (Nat.le_div_iff_mul_le ha0).mp hba⟩
  change (∑ b ∈ Finset.Icc 1 N, if a * b ≤ N then 1 else 0) = N / a
  calc
    _ = ((Finset.Icc 1 N).filter (fun b => a * b ≤ N)).card := by
      simp only [Finset.card_eq_sum_ones, Finset.sum_filter]
    _ = (Finset.Icc 1 (N / a)).card := congrArg Finset.card he
    _ = N / a := by simp

theorem factorRectangle_card_swap (N a b : ℕ) :
    (factorRectangle N a b).card = (factorRectangle N b a).card := by
  apply Finset.card_bij (fun p _ => p.swap)
  · intro p hp
    rw [mem_factorRectangle] at hp ⊢
    exact ⟨hp.2.2.1, hp.2.2.2.1, hp.1, hp.2.1, by simpa [mul_comm] using hp.2.2.2.2⟩
  · intro p _ q _ he
    exact Prod.swap_injective he
  · intro p hp
    refine ⟨p.swap, ?_, Prod.swap_swap p⟩
    rw [mem_factorRectangle] at hp ⊢
    exact ⟨hp.2.2.1, hp.2.2.2.1, hp.1, hp.2.1, by simpa [mul_comm] using hp.2.2.2.2⟩

theorem floor_sum_hyperbola (N m : ℕ) (hm : m ≤ N)
    (hm2 : m * m ≤ N) (hN : N < (m + 1) * (m + 1)) :
    (∑ a ∈ Finset.Icc 1 N, N / a) + m * m =
      2 * (∑ a ∈ Finset.Icc 1 m, N / a) := by
  classical
  have hu : factorRectangle N m N ∪ factorRectangle N N m = factorRectangle N N N := by
    ext p
    simp only [Finset.mem_union, mem_factorRectangle]
    constructor
    · intro hp
      rcases hp with hp | hp
      · exact ⟨hp.1, hp.2.1.trans hm, hp.2.2.1, hp.2.2.2.1, hp.2.2.2.2⟩
      · exact ⟨hp.1, hp.2.1, hp.2.2.1, hp.2.2.2.1.trans hm, hp.2.2.2.2⟩
    · intro hp
      by_cases hpa : p.1 ≤ m
      · exact Or.inl ⟨hp.1, hpa, hp.2.2.1, hp.2.2.2.1, hp.2.2.2.2⟩
      · have hpb : p.2 ≤ m := by
          by_contra hh
          have ha : m + 1 ≤ p.1 := by omega
          have hb : m + 1 ≤ p.2 := by omega
          have hab := Nat.mul_le_mul ha hb
          omega
        exact Or.inr ⟨hp.1, hp.2.1, hp.2.2.1, hpb, hp.2.2.2.2⟩
  have hi : factorRectangle N m N ∩ factorRectangle N N m =
      (Finset.Icc 1 m) ×ˢ (Finset.Icc 1 m) := by
    ext p
    simp only [Finset.mem_inter, mem_factorRectangle, Finset.mem_product, Finset.mem_Icc]
    constructor
    · rintro ⟨ha, hb⟩
      exact ⟨⟨ha.1, ha.2.1⟩, ⟨hb.2.2.1, hb.2.2.2.1⟩⟩
    · rintro ⟨⟨ha1, ham⟩, ⟨hb1, hbm⟩⟩
      have hp : p.1 * p.2 ≤ N := (Nat.mul_le_mul ham hbm).trans hm2
      exact ⟨⟨ha1, ham, hb1, hbm.trans hm, hp⟩, ⟨ha1, ham.trans hm, hb1, hbm, hp⟩⟩
  have hh := Finset.card_union_add_card_inter (factorRectangle N m N) (factorRectangle N N m)
  rw [hu, hi, Finset.card_product, factorRectangle_card,
    factorRectangle_card_swap N N m, factorRectangle_card] at hh
  simpa [two_mul] using hh

theorem floor_sum_hyperbola_sqrt (N : ℕ) :
    (∑ a ∈ Finset.Icc 1 N, N / a) + N.sqrt * N.sqrt =
      2 * (∑ a ∈ Finset.Icc 1 N.sqrt, N / a) :=
  floor_sum_hyperbola N N.sqrt (Nat.sqrt_le_self N) (Nat.sqrt_le N) (Nat.lt_succ_sqrt N)

theorem log_successor_gap_le {m : ℕ} (hm : 1 ≤ m) :
    Real.log ((m : ℝ) + 1) - Real.log m ≤ 1 / (m : ℝ) := by
  have hm0 : (0 : ℝ) < m := by exact_mod_cast (show 0 < m by omega)
  calc
    _ = Real.log (((m : ℝ) + 1) / m) := by
      rw [Real.log_div (by positivity) hm0.ne']
    _ ≤ ((m : ℝ) + 1) / m - 1 :=
      Real.log_le_sub_one_of_pos (div_pos (by positivity) hm0)
    _ = 1 / (m : ℝ) := by field_simp; ring

theorem harmonic_euler_error_bounds {m : ℕ} (hm : 1 ≤ m) :
    0 ≤ (harmonic m : ℝ) - Real.log m - Real.eulerMascheroniConstant ∧
    (harmonic m : ℝ) - Real.log m - Real.eulerMascheroniConstant ≤ 1 / (m : ℝ) := by
  have h0 := Real.eulerMascheroniConstant_lt_eulerMascheroniSeq' m
  have h1 := Real.eulerMascheroniSeq_lt_eulerMascheroniConstant m
  simp only [Real.eulerMascheroniSeq', if_neg (show m ≠ 0 by omega)] at h0
  simp only [Real.eulerMascheroniSeq] at h1
  have hg := log_successor_gap_le hm
  constructor <;> linarith

theorem floor_sum_harmonic_bounds (N m : ℕ) :
    (N : ℝ) * harmonic m - m ≤ (∑ a ∈ Finset.Icc 1 m, ((N / a : ℕ) : ℝ)) ∧
    (∑ a ∈ Finset.Icc 1 m, ((N / a : ℕ) : ℝ)) ≤ (N : ℝ) * harmonic m := by
  have hlo : ∀ a ∈ Finset.Icc 1 m, (N : ℝ) / a - 1 ≤ ((N / a : ℕ) : ℝ) := by
    intro a ha
    have ha0 : 0 < a := (Finset.mem_Icc.mp ha).1
    have har : (0 : ℝ) < a := by exact_mod_cast ha0
    have hn : N < (N / a + 1) * a :=
      (Nat.div_lt_iff_lt_mul ha0).mp (Nat.lt_succ_self (N / a))
    have hnr : (N : ℝ) < (((N / a : ℕ) : ℝ) + 1) * a := by exact_mod_cast hn
    have hh := (div_lt_iff₀ har).mpr hnr
    linarith
  have hup : ∀ a ∈ Finset.Icc 1 m, ((N / a : ℕ) : ℝ) ≤ (N : ℝ) / a :=
    fun _ _ => Nat.cast_div_le
  have hs : (∑ a ∈ Finset.Icc 1 m, (N : ℝ) / a) = (N : ℝ) * harmonic m := by
    simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast,
      Finset.mul_sum, div_eq_mul_inv]
  have hl := Finset.sum_le_sum hlo
  have hu := Finset.sum_le_sum hup
  rw [Finset.sum_sub_distrib, hs] at hl
  rw [hs] at hu
  simpa using And.intro hl hu

theorem divisorSum_hyperbola (N : ℕ) :
    divisorSum N + (N.sqrt : ℝ) ^ 2 =
      2 * (∑ a ∈ Finset.Icc 1 N.sqrt, ((N / a : ℕ) : ℝ)) := by
  have hh := floor_sum_hyperbola_sqrt N
  have hc := congrArg (fun n : ℕ => (n : ℝ)) hh
  simpa [divisorSum, pow_two] using hc

theorem divisorSum_error_le {N : ℕ} (hN : 1 ≤ N) :
    |divisorSum N - ((N : ℝ) * Real.log N +
      (2 * Real.eulerMascheroniConstant - 1) * N)| ≤ 10 * (N.sqrt : ℝ) := by
  let m : ℕ := N.sqrt
  have hm1 : 1 ≤ m := Nat.le_sqrt.mpr (by simpa using hN)
  have hm : (1 : ℝ) ≤ m := by exact_mod_cast hm1
  have hm0 : (0 : ℝ) < m := by linarith
  have hn : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hsq : (m : ℝ) ^ 2 ≤ N := by exact_mod_cast Nat.sqrt_le' N
  have hnear : (N : ℝ) ≤ (m : ℝ) ^ 2 + 2 * m := by
    have hh := Nat.sqrt_le_add N
    dsimp only [m]
    exact_mod_cast (by nlinarith [hh] : N ≤ N.sqrt ^ 2 + 2 * N.sqrt)
  have hupper : (N : ℝ) ≤ ((m : ℝ) + 1) ^ 2 := by nlinarith
  have hloglo : 2 * Real.log m ≤ Real.log N := by
    have hh := Real.log_le_log (by positivity : (0 : ℝ) < (m : ℝ) ^ 2) hsq
    simpa [Real.log_pow] using hh
  have hloghi : Real.log N ≤ 2 * Real.log ((m : ℝ) + 1) := by
    have hh := Real.log_le_log hn hupper
    simpa [Real.log_pow] using hh
  obtain ⟨hgam0, hgam1⟩ := harmonic_euler_error_bounds hm1
  have hgap := log_successor_gap_le hm1
  have hb : |2 * (harmonic m : ℝ) - 2 * Real.eulerMascheroniConstant - Real.log N| ≤
      2 / (m : ℝ) := by
    rw [abs_le]
    simp only [div_eq_mul_inv, one_mul] at hgam1 hgap ⊢
    constructor <;> linarith
  have hNm : (N : ℝ) / m ≤ 3 * m := by
    apply (div_le_iff₀ hm0).mpr
    nlinarith
  have hbN := mul_le_mul_of_nonneg_left hb hn.le
  have hbN' : (N : ℝ) *
      |2 * (harmonic m : ℝ) - 2 * Real.eulerMascheroniConstant - Real.log N| ≤ 6 * m := by
    calc
      _ ≤ (N : ℝ) * (2 / m) := hbN
      _ = 2 * ((N : ℝ) / m) := by ring
      _ ≤ _ := by linarith
  have hbl := neg_abs_le (2 * (harmonic m : ℝ) - 2 * Real.eulerMascheroniConstant - Real.log N)
  have hbu := le_abs_self (2 * (harmonic m : ℝ) - 2 * Real.eulerMascheroniConstant - Real.log N)
  have hblN := mul_le_mul_of_nonneg_left hbl hn.le
  have hbuN := mul_le_mul_of_nonneg_left hbu hn.le
  have hhyper := divisorSum_hyperbola N
  obtain ⟨hfloorlo, hfloorhi⟩ := floor_sum_harmonic_bounds N m
  change divisorSum N + (m : ℝ) ^ 2 = _ at hhyper
  change |divisorSum N - ((N : ℝ) * Real.log N +
    (2 * Real.eulerMascheroniConstant - 1) * N)| ≤ 10 * (m : ℝ)
  rw [abs_le]
  constructor <;> nlinarith

theorem logFactorial_integral_bounds {N : ℕ} (hN : 1 ≤ N) :
    (N : ℝ) * Real.log N - N + 1 ≤ logFactorial N ∧
    logFactorial N ≤ (N : ℝ) * Real.log N - N + 1 + Real.log N := by
  have hm : MonotoneOn Real.log (Set.Icc (1 : ℝ) N) := by
    intro x hx y _ hxy
    exact Real.log_le_log (by linarith [hx.1]) hxy
  have hl := MonotoneOn.sum_le_integral_Ico (f := Real.log) hN (by simpa using hm)
  have hu := MonotoneOn.integral_le_sum_Ico (f := Real.log) hN (by simpa using hm)
  simp only [Nat.cast_one] at hl hu
  have hi : (∫ x in (1 : ℝ)..N, Real.log x) =
      (N : ℝ) * Real.log N - N + 1 := by simp [integral_log]
  have hleft : (∑ i ∈ Finset.Ico 1 N, Real.log (i : ℕ)) + Real.log N =
      logFactorial N := Finset.sum_Ico_add_eq_sum_Icc hN
  have hright : (∑ i ∈ Finset.Ico 1 N, Real.log (i + 1 : ℕ)) =
      logFactorial N := by
    rw [Finset.sum_Ico_add' (fun i : ℕ => Real.log i) 1 N 1]
    have he : Finset.Ico (1 + 1) (N + 1) = Finset.Ioc 1 N := by
      ext i
      simp only [Finset.mem_Ico, Finset.mem_Ioc]
      omega
    rw [he]
    have hh := Finset.add_sum_Ioc_eq_sum_Icc (f := fun i : ℕ => Real.log i) hN
    simpa [logFactorial] using hh
  rw [hi] at hl hu
  rw [hright] at hu
  constructor <;> linarith

theorem logFactorial_error_le {N : ℕ} (hN : 1 ≤ N) :
    |logFactorial N - ((N : ℝ) * Real.log N - N)| ≤ 1 + Real.log N := by
  obtain ⟨hl, hu⟩ := logFactorial_integral_bounds hN
  have hlog : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg (by exact_mod_cast hN)
  rw [abs_le]
  constructor <;> linarith

theorem centeredDivisorForcing_error_le {N : ℕ} (hN : 1 ≤ N) :
    |centeredDivisorForcing N| ≤ 10 * (N.sqrt : ℝ) + 1 + Real.log N := by
  have he : centeredDivisorForcing N =
      (logFactorial N - ((N : ℝ) * Real.log N - N)) -
      (divisorSum N - ((N : ℝ) * Real.log N +
        (2 * Real.eulerMascheroniConstant - 1) * N)) := by
    unfold centeredDivisorForcing
    ring
  rw [he]
  have hh := (abs_sub _ _).trans
    (add_le_add (logFactorial_error_le hN) (divisorSum_error_le hN))
  linarith

theorem centeredDivisorForcing_sqrt_bound {N : ℕ} (hN : 1 ≤ N) :
    |centeredDivisorForcing N| ≤ 13 * Real.sqrt N := by
  have hn : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hs : (N.sqrt : ℝ) ≤ Real.sqrt N := by
    apply (Real.le_sqrt (Nat.cast_nonneg _) (Nat.cast_nonneg _)).mpr
    exact_mod_cast Nat.sqrt_le' N
  have hs1 : (1 : ℝ) ≤ Real.sqrt N := by
    simpa using Real.sqrt_le_sqrt hn
  have hlog : Real.log (N : ℝ) ≤ 2 * Real.sqrt N := by
    have hh := Real.log_le_rpow_div (Nat.cast_nonneg N) (by norm_num : (0 : ℝ) < 1 / 2)
    rw [← Real.sqrt_eq_rpow] at hh
    linarith
  have hh := centeredDivisorForcing_error_le hN
  linarith

end BuildingBlocks.MertensTransfer
