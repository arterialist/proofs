import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic

/-!
# Finite endpoint identity for a weighted prime cross

This file formalizes the finite integration step behind the endpoint collar
identity for the chirped Weil prime kernel. Analytic facts about the packet
correlation and its primitive remain separate.
-/

open MeasureTheory
open scoped Interval BigOperators

namespace BuildingBlocks.CriticalChirpedEndpointFinite

noncomputable section







private theorem exp_weight_identity (r d : ℝ) :
    Real.exp (-r / 2) * Real.exp ((r - d) / 2) = Real.exp (-d / 2) := by
  rw [← Real.exp_add]
  congr 1
  ring

/-- The exact endpoint integral for one logarithmic prime-power location. -/
theorem one_location (C F : ℝ → ℂ) (r D : ℝ)
    (hF : ∀ v, HasDerivAt F (((Real.exp (v / 2) : ℝ) : ℂ) * C v) v)
    (hInt : IntervalIntegrable
      (fun d : ℝ => ((Real.exp (-d / 2) : ℝ) : ℂ) * C (r - d)) volume 0 D)
    (hr : F r = 0) :
    (∫ d in (0 : ℝ)..D, ((Real.exp (-d / 2) : ℝ) : ℂ) * C (r - d)) =
      -((Real.exp (-r / 2) : ℝ) : ℂ) * F (r - D) := by
  let G : ℝ → ℂ := fun d => ((Real.exp (-r / 2) : ℝ) : ℂ) * F (r - d)
  have hG (d : ℝ) : HasDerivAt G
      (-(((Real.exp (-d / 2) : ℝ) : ℂ) * C (r - d))) d := by
    have hh := HasDerivAt.const_mul ((Real.exp (-r / 2) : ℝ) : ℂ)
      (HasDerivAt.comp_const_sub r d (hF (r - d)))
    convert hh using 1
    rw [mul_neg, ← mul_assoc, ← Complex.ofReal_mul, exp_weight_identity]
  have hFTC : (∫ d in (0 : ℝ)..D,
      -(((Real.exp (-d / 2) : ℝ) : ℂ) * C (r - d))) = G D - G 0 :=
    intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun d _ => hG d) (by simpa using hInt.neg)
  calc
    (∫ d in (0 : ℝ)..D, ((Real.exp (-d / 2) : ℝ) : ℂ) * C (r - d)) =
        -(∫ d in (0 : ℝ)..D,
          -(((Real.exp (-d / 2) : ℝ) : ℂ) * C (r - d))) := by
          rw [intervalIntegral.integral_neg]
          ring
    _ = -(G D - G 0) := by rw [hFTC]
    _ = -((Real.exp (-r / 2) : ℝ) : ℂ) * F (r - D) := by
      simp [G, hr]

/-- Finite interchange and exact endpoint cancellation, with arbitrary
complex weights. The finite set can include every prime power up to a literal
cutoff. -/
theorem finite_locations {ι : Type*} (s : Finset ι) (r : ι → ℝ)
    (weights : ι → ℂ) (C F : ℝ → ℂ) (D : ℝ)
    (hF : ∀ v, HasDerivAt F (((Real.exp (v / 2) : ℝ) : ℂ) * C v) v)
    (hInt : ∀ i ∈ s, IntervalIntegrable
      (fun d : ℝ => ((Real.exp (-d / 2) : ℝ) : ℂ) * C (r i - d)) volume 0 D)
    (hzero : ∀ i ∈ s, F (r i) = 0) :
    (∫ d in (0 : ℝ)..D,
      ∑ i ∈ s, weights i * (((Real.exp (-d / 2) : ℝ) : ℂ) * C (r i - d))) =
      -∑ i ∈ s, weights i *
        (((Real.exp (-r i / 2) : ℝ) : ℂ) * F (r i - D)) := by
  classical
  rw [intervalIntegral.integral_finset_sum (s := s)
    (f := fun i d => weights i *
      (((Real.exp (-d / 2) : ℝ) : ℂ) * C (r i - d)))
    (fun i hi => (hInt i hi).const_mul (weights i))]
  simp_rw [intervalIntegral.integral_const_mul]
  calc
    (∑ i ∈ s, weights i *
      (∫ d in (0 : ℝ)..D,
        ((Real.exp (-d / 2) : ℝ) : ℂ) * C (r i - d))) =
      ∑ i ∈ s, weights i *
        (-(((Real.exp (-r i / 2) : ℝ) : ℂ) * F (r i - D))) := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [one_location C F (r i) D hF (hInt i hi) (hzero i hi)]
      ring
    _ = -∑ i ∈ s, weights i *
        (((Real.exp (-r i / 2) : ℝ) : ℂ) * F (r i - D)) := by
      simp only [mul_neg, ← Finset.sum_neg_distrib]

/-- The finite actual-prime-power cross, before the Weil separation weight. -/
def actualCrossFinite (N : ℕ) (C : ℝ → ℂ) (d : ℝ) : ℂ :=
  ∑ n ∈ Finset.Icc 2 N,
    (((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
      C (Real.log (n : ℝ) - d))

/-- Once the cutoff has passed the largest possible prime-power location
for every separation `d ≤ D`, enlarging it changes no term. -/
theorem actual_cross_cutoff_stable (N M : ℕ) (C : ℝ → ℂ)
    (w D d : ℝ) (hNM : N ≤ M)
    (hN : Real.exp (D + w) ≤ (N : ℝ)) (hd : d ≤ D)
    (hC : ∀ y, w ≤ y → C y = 0) :
    actualCrossFinite M C d = actualCrossFinite N C d := by
  classical
  have hsubset : Finset.Icc 2 N ⊆ Finset.Icc 2 M := by
    intro n hn
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hNM⟩
  have hsum := Finset.sum_subset hsubset
    (f := fun n : ℕ =>
      (((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
        C (Real.log (n : ℝ) - d)))
    (by
      intro n hn hnot
      have hnlarge : N < n := by
        by_contra h
        exact hnot (Finset.mem_Icc.mpr
          ⟨(Finset.mem_Icc.mp hn).1, Nat.le_of_not_gt h⟩)
      have hnpos : (0 : ℝ) < (n : ℝ) := by
        exact_mod_cast (show 0 < n by omega)
      have hNn : Real.exp (D + w) < (n : ℝ) :=
        lt_of_le_of_lt hN (by exact_mod_cast hnlarge)
      have hlog : D + w < Real.log (n : ℝ) :=
        (Real.lt_log_iff_exp_lt hnpos).mpr hNn
      have hy : w ≤ Real.log (n : ℝ) - d := by linarith
      dsimp
      rw [hC _ hy, mul_zero])
  exact hsum.symm

private theorem mangoldt_weight_simplify (n : ℕ) (hn : 2 ≤ n) :
    ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) *
      Real.exp (-Real.log (n : ℝ) / 2) =
        ArithmeticFunction.vonMangoldt n / (n : ℝ) := by
  have hnpos : (0 : ℝ) < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hsqrt : Real.sqrt (n : ℝ) =
      Real.exp (Real.log (n : ℝ) / 2) := by
    rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos hnpos]
    congr 1
    ring
  have hroot : Real.sqrt (n : ℝ) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hnpos)
  rw [show -Real.log (n : ℝ) / 2 = -(Real.log (n : ℝ) / 2) by ring,
    Real.exp_neg, ← hsqrt]
  calc
    ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) *
        (Real.sqrt (n : ℝ))⁻¹ =
        ArithmeticFunction.vonMangoldt n / (Real.sqrt (n : ℝ))^2 := by
          field_simp [hroot]
    _ = ArithmeticFunction.vonMangoldt n / (n : ℝ) := by
      rw [Real.sq_sqrt hnpos.le]

private theorem log_collar_iff_exp_collar (n : ℕ) (hn : 2 ≤ n)
    (w D : ℝ) :
    (-w < Real.log (n : ℝ) - D ∧ Real.log (n : ℝ) - D < w) ↔
      (Real.exp (D - w) < (n : ℝ) ∧ (n : ℝ) < Real.exp (D + w)) := by
  have hnpos : (0 : ℝ) < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  constructor
  · rintro ⟨hleft, hright⟩
    constructor
    · apply (Real.lt_log_iff_exp_lt hnpos).mp
      linarith
    · apply (Real.log_lt_iff_lt_exp hnpos).mp
      linarith
  · rintro ⟨hleft, hright⟩
    constructor
    · have := (Real.lt_log_iff_exp_lt hnpos).mpr hleft
      linarith
    · have := (Real.log_lt_iff_lt_exp hnpos).mpr hright
      linarith

/-- The finite endpoint identity with every actual von Mangoldt weight retained.
The support hypothesis is exactly what kills the upper primitive endpoint
for all `n ≥ 2`. -/
theorem actual_cross_finite_endpoint (N : ℕ) (C F : ℝ → ℂ)
    (w D : ℝ) (hw : w < Real.log 2)
    (hF : ∀ v, HasDerivAt F (((Real.exp (v / 2) : ℝ) : ℂ) * C v) v)
    (hInt : ∀ n ∈ Finset.Icc 2 N, IntervalIntegrable
      (fun d : ℝ => ((Real.exp (-d / 2) : ℝ) : ℂ) *
        C (Real.log (n : ℝ) - d)) volume 0 D)
    (hright : ∀ v, w ≤ v → F v = 0) :
    (∫ d in (0 : ℝ)..D,
      ((Real.exp (-d / 2) : ℝ) : ℂ) * actualCrossFinite N C d) =
      -∑ n ∈ Finset.Icc 2 N,
        (((ArithmeticFunction.vonMangoldt n / (n : ℝ) : ℝ) : ℂ) *
          F (Real.log (n : ℝ) - D)) := by
  classical
  have hzero : ∀ n ∈ Finset.Icc 2 N, F (Real.log (n : ℝ)) = 0 := by
    intro n hn
    apply hright
    have hnreal : (2 : ℝ) ≤ (n : ℝ) := by
      exact_mod_cast (Finset.mem_Icc.mp hn).1
    have hlog : Real.log (2 : ℝ) ≤ Real.log (n : ℝ) :=
      Real.log_le_log (by norm_num) hnreal
    exact le_trans hw.le hlog
  have hfun : (fun d : ℝ => ((Real.exp (-d / 2) : ℝ) : ℂ) *
      actualCrossFinite N C d) =
      (fun d : ℝ => ∑ n ∈ Finset.Icc 2 N,
        (((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
          (((Real.exp (-d / 2) : ℝ) : ℂ) *
            C (Real.log (n : ℝ) - d)))) := by
    funext d
    simp only [actualCrossFinite, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n hn
    ring
  rw [hfun]
  have hbase := finite_locations (Finset.Icc 2 N) (fun n => Real.log (n : ℝ))
    (fun n => ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ))
    C F D hF hInt hzero
  rw [hbase]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  rw [← mul_assoc, ← Complex.ofReal_mul,
    mangoldt_weight_simplify n (Finset.mem_Icc.mp hn).1]

/-- Literal endpoint version: terms at either collar boundary vanish, so only
prime powers strictly inside the moving logarithmic collar remain. -/
theorem actual_cross_finite_collar (N : ℕ) (C F : ℝ → ℂ)
    (w D : ℝ) (hw : w < Real.log 2)
    (hF : ∀ v, HasDerivAt F (((Real.exp (v / 2) : ℝ) : ℂ) * C v) v)
    (hInt : ∀ n ∈ Finset.Icc 2 N, IntervalIntegrable
      (fun d : ℝ => ((Real.exp (-d / 2) : ℝ) : ℂ) *
        C (Real.log (n : ℝ) - d)) volume 0 D)
    (hleft : ∀ v, v ≤ -w → F v = 0)
    (hright : ∀ v, w ≤ v → F v = 0) :
    (∫ d in (0 : ℝ)..D,
      ((Real.exp (-d / 2) : ℝ) : ℂ) * actualCrossFinite N C d) =
      -∑ n ∈ (Finset.Icc 2 N).filter
        (fun n : ℕ => -w < Real.log (n : ℝ) - D ∧
          Real.log (n : ℝ) - D < w),
        (((ArithmeticFunction.vonMangoldt n / (n : ℝ) : ℝ) : ℂ) *
          F (Real.log (n : ℝ) - D)) := by
  classical
  rw [actual_cross_finite_endpoint N C F w D hw hF hInt hright]
  congr 1
  have hsum := Finset.sum_subset
    (Finset.filter_subset
      (fun n : ℕ => -w < Real.log (n : ℝ) - D ∧ Real.log (n : ℝ) - D < w)
      (Finset.Icc 2 N))
    (f := fun n =>
      (((ArithmeticFunction.vonMangoldt n / (n : ℝ) : ℝ) : ℂ) *
        F (Real.log (n : ℝ) - D)))
    (by
      intro n hn hnot
      have hnot' : ¬(-w < Real.log (n : ℝ) - D ∧
          Real.log (n : ℝ) - D < w) := by
        intro hh
        exact hnot (Finset.mem_filter.mpr ⟨hn, hh⟩)
      rcases le_or_gt (Real.log (n : ℝ) - D) (-w) with hle | hgt
      · dsimp
        rw [hleft _ hle, mul_zero]
      · rcases lt_or_ge (Real.log (n : ℝ) - D) w with hlt | hge
        · exact False.elim (hnot' ⟨hgt, hlt⟩)
        · dsimp
          rw [hright _ hge, mul_zero])
  exact hsum.symm

/-- The same exact collar with literal exponential endpoints, as in the
written actual-prime identity. Equality at either endpoint contributes zero. -/
theorem actual_cross_finite_exp_collar (N : ℕ) (C F : ℝ → ℂ)
    (w D : ℝ) (hw : w < Real.log 2)
    (hF : ∀ v, HasDerivAt F (((Real.exp (v / 2) : ℝ) : ℂ) * C v) v)
    (hInt : ∀ n ∈ Finset.Icc 2 N, IntervalIntegrable
      (fun d : ℝ => ((Real.exp (-d / 2) : ℝ) : ℂ) *
        C (Real.log (n : ℝ) - d)) volume 0 D)
    (hleft : ∀ v, v ≤ -w → F v = 0)
    (hright : ∀ v, w ≤ v → F v = 0) :
    (∫ d in (0 : ℝ)..D,
      ((Real.exp (-d / 2) : ℝ) : ℂ) * actualCrossFinite N C d) =
      -∑ n ∈ (Finset.Icc 2 N).filter
        (fun n : ℕ => Real.exp (D - w) < (n : ℝ) ∧
          (n : ℝ) < Real.exp (D + w)),
        (((ArithmeticFunction.vonMangoldt n / (n : ℝ) : ℝ) : ℂ) *
          F (Real.log (n : ℝ) - D)) := by
  classical
  have hfilter :
      (Finset.Icc 2 N).filter
        (fun n : ℕ => -w < Real.log (n : ℝ) - D ∧
          Real.log (n : ℝ) - D < w) =
      (Finset.Icc 2 N).filter
        (fun n : ℕ => Real.exp (D - w) < (n : ℝ) ∧
          (n : ℝ) < Real.exp (D + w)) := by
    apply Finset.filter_congr
    intro n hn
    exact log_collar_iff_exp_collar n (Finset.mem_Icc.mp hn).1 w D
  simpa only [hfilter] using
    (actual_cross_finite_collar N C F w D hw hF hInt hleft hright)

/-- Continuous kernels automatically meet the finite interval-integrability
hypothesis in `actual_cross_finite_exp_collar`. -/
theorem actual_cross_finite_exp_collar_of_continuous (N : ℕ) (C F : ℝ → ℂ)
    (w D : ℝ) (hw : w < Real.log 2)
    (hC : Continuous C)
    (hF : ∀ v, HasDerivAt F (((Real.exp (v / 2) : ℝ) : ℂ) * C v) v)
    (hleft : ∀ v, v ≤ -w → F v = 0)
    (hright : ∀ v, w ≤ v → F v = 0) :
    (∫ d in (0 : ℝ)..D,
      ((Real.exp (-d / 2) : ℝ) : ℂ) * actualCrossFinite N C d) =
      -∑ n ∈ (Finset.Icc 2 N).filter
        (fun n : ℕ => Real.exp (D - w) < (n : ℝ) ∧
          (n : ℝ) < Real.exp (D + w)),
        (((ArithmeticFunction.vonMangoldt n / (n : ℝ) : ℝ) : ℂ) *
          F (Real.log (n : ℝ) - D)) := by
  apply actual_cross_finite_exp_collar N C F w D hw hF ?_ hleft hright
  intro n hn
  have hcont : Continuous (fun d : ℝ =>
      ((Real.exp (-d / 2) : ℝ) : ℂ) * C (Real.log (n : ℝ) - d)) := by
    fun_prop
  exact hcont.intervalIntegrable 0 D

#print axioms actual_cross_cutoff_stable
#print axioms actual_cross_finite_exp_collar_of_continuous

end
end BuildingBlocks.CriticalChirpedEndpointFinite
