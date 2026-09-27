import BuildingBlocks.PrimeHistoryDivisorResponse
import BuildingBlocks.DensityPrimeCovarianceFinite
import Mathlib.Tactic

/-! Exact all-real Volterra identity for the actual cutoff density and complete
prime-power score. This file proves the finite integral identity; it does not
formalize the prime number theorem or infer an RH-sign inequality. -/

namespace BuildingBlocks.ActualVolterraIdentity

open intervalIntegral MeasureTheory
open scoped Interval

noncomputable section

private def primitiveB (a y : ℝ) : ℝ :=
  Real.log y / (2 * a * Real.sqrt a) + 1 / (Real.sqrt a * y) -
    Real.sqrt a / (4 * y ^ 2)

private def kernelB (a y : ℝ) : ℝ :=
  (y - a) ^ 2 / (2 * a * Real.sqrt a * y ^ 3)

private theorem kernelB_integrable {a x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    IntervalIntegrable (kernelB a) volume a x := by
  have hcont : ContinuousOn (kernelB a) (Set.Icc a x) := by
    intro y hy
    have hy0 : y ≠ 0 := ne_of_gt (ha.trans_le hy.1)
    apply ContinuousAt.continuousWithinAt
    unfold kernelB
    fun_prop (disch := positivity)
  exact hcont.intervalIntegrable_of_Icc hax

private theorem primitiveB_hasDerivAt {a y : ℝ} (ha : 0 < a) (hy : 0 < y) :
    HasDerivAt (primitiveB a) (kernelB a y) y := by
  have ha0 : a ≠ 0 := ne_of_gt ha
  have hsa : Real.sqrt a ≠ 0 := (Real.sqrt_pos.2 ha).ne'
  have hy0 : y ≠ 0 := ne_of_gt hy
  have hsq : (Real.sqrt a) ^ 2 = a := Real.sq_sqrt ha.le
  have hlog := (Real.hasDerivAt_log hy0).div_const (2 * a * Real.sqrt a)
  have hinv : HasDerivAt (fun z : ℝ => 1 / (Real.sqrt a * z))
      (-1 / (Real.sqrt a * y ^ 2)) y := by
    convert (hasDerivAt_inv hy0).const_mul (1 / Real.sqrt a) using 1 <;>
      field_simp
  have hinv2 : HasDerivAt (fun z : ℝ => Real.sqrt a / (4 * z ^ 2))
      (-Real.sqrt a / (2 * y ^ 3)) y := by
    convert ((((hasDerivAt_id y).pow 2).inv (pow_ne_zero 2 hy0)).const_mul
      (Real.sqrt a / 4)) using 1
    · funext z
      simp [pow_two, div_eq_mul_inv, mul_comm, mul_assoc]
    · simp only [Pi.pow_apply, id_eq]
      field_simp
      ring
  convert (hlog.add hinv).sub hinv2 using 1 <;>
    simp only [kernelB] <;> field_simp <;> nlinarith [hsq]

private theorem integral_kernelB {a x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    (∫ y in a..x, kernelB a y) = primitiveB a x - primitiveB a a := by
  apply integral_eq_sub_of_hasDerivAt
  · intro y hy
    rw [Set.uIcc_of_le hax] at hy
    exact primitiveB_hasDerivAt ha (ha.trans_le hy.1)
  · exact kernelB_integrable ha hax

private def primitiveM (a s y : ℝ) : ℝ :=
  s / Real.sqrt a * (-1 / y + a / (2 * y ^ 2))

private def kernelM (a s y : ℝ) : ℝ :=
  s * (y - a) / (Real.sqrt a * y ^ 3)

private theorem kernelM_integrable {a s x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    IntervalIntegrable (kernelM a s) volume a x := by
  have hcont : ContinuousOn (kernelM a s) (Set.Icc a x) := by
    intro y hy
    have hy0 : y ≠ 0 := ne_of_gt (ha.trans_le hy.1)
    apply ContinuousAt.continuousWithinAt
    unfold kernelM
    fun_prop (disch := positivity)
  exact hcont.intervalIntegrable_of_Icc hax

private theorem primitiveM_hasDerivAt {a s y : ℝ} (ha : 0 < a) (hy : 0 < y) :
    HasDerivAt (primitiveM a s) (kernelM a s y) y := by
  have hy0 : y ≠ 0 := ne_of_gt hy
  have hsa : Real.sqrt a ≠ 0 := (Real.sqrt_pos.2 ha).ne'
  have h1 := (hasDerivAt_inv hy0).neg
  have h2 := ((((hasDerivAt_id y).pow 2).inv (pow_ne_zero 2 hy0)).const_mul
    (a / 2))
  have h := (h1.add h2).const_mul (s / Real.sqrt a)
  convert h using 1
  · funext z
    simp [primitiveM, pow_two, div_eq_mul_inv, mul_comm, mul_assoc]
    left
    ring
  · simp only [Pi.pow_apply, id_eq]
    simp only [kernelM]
    field_simp
    ring

private theorem integral_kernelM {a s x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    (∫ y in a..x, kernelM a s y) = primitiveM a s x - primitiveM a s a := by
  apply integral_eq_sub_of_hasDerivAt
  · intro y hy
    rw [Set.uIcc_of_le hax] at hy
    exact primitiveM_hasDerivAt ha (ha.trans_le hy.1)
  · exact kernelM_integrable ha hax

private theorem baseline_scalar {a x : ℝ} (ha : 0 < a) (hax : a < x) :
    x ^ 2 * (primitiveB a x - primitiveB a a) =
      (x - a) / Real.sqrt a *
        PrimeHistoryDivisorResponse.R (x / a - 1) := by
  have ha0 : a ≠ 0 := ne_of_gt ha
  have hx0 : x ≠ 0 := ne_of_gt (ha.trans hax)
  have hsa : Real.sqrt a ≠ 0 := (Real.sqrt_pos.2 ha).ne'
  have hz : x / a - 1 ≠ 0 := ne_of_gt (sub_pos.mpr ((one_lt_div ha).mpr hax))
  have hxa : x - a ≠ 0 := ne_of_gt (sub_pos.mpr hax)
  have hsq : (Real.sqrt a) ^ 2 = a := Real.sq_sqrt ha.le
  unfold primitiveB PrimeHistoryDivisorResponse.R
  have hh : 1 + (x / a - 1) = x / a := by ring
  rw [hh, Real.log_div hx0 ha0]
  field_simp [ha0, hx0, hsa, hz, hxa]
  rw [hsq]
  ring

private theorem density_scalar {a s x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    x ^ 2 * (primitiveM a s x - primitiveM a s a) =
      s * (x - a) ^ 2 / (2 * a * Real.sqrt a) := by
  have ha0 : a ≠ 0 := ne_of_gt ha
  have hx0 : x ≠ 0 := ne_of_gt (ha.trans_le hax)
  have hsa : Real.sqrt a ≠ 0 := (Real.sqrt_pos.2 ha).ne'
  unfold primitiveM
  field_simp [ha0, hx0, hsa]
  ring

private theorem baseline_integral_scalar {a x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    x ^ 2 * (∫ y in a..x, kernelB a y) =
      (if a < x then (x - a) / Real.sqrt a *
        PrimeHistoryDivisorResponse.R (x / a - 1) else 0) := by
  rw [integral_kernelB ha hax]
  rcases hax.lt_or_eq with hlt | heq
  · rw [if_pos hlt]
    exact baseline_scalar ha hlt
  · rw [← heq, if_neg (not_lt.mpr le_rfl)]
    ring

private theorem density_integral_scalar {a s x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    x ^ 2 * (∫ y in a..x, kernelM a s y) =
      s * (x - a) ^ 2 / (2 * a * Real.sqrt a) := by
  rw [integral_kernelM ha hax]
  exact density_scalar ha hax

private theorem activation_integrable {a x : ℝ} (ha1 : 1 ≤ a) (hax : a ≤ x)
    (K : ℝ → ℝ) (hKint : IntervalIntegrable K volume a x) :
    IntervalIntegrable (fun y => if a < y then K y else 0) volume 1 x := by
  let f : ℝ → ℝ := fun y => if a < y then K y else 0
  have hleft : IntervalIntegrable f volume 1 a := by
    have h0 : IntervalIntegrable (fun _ : ℝ => (0 : ℝ)) volume 1 a :=
      by simp
    apply h0.congr
    intro y hy
    rw [Set.uIoc_of_le ha1] at hy
    simp [f, not_lt.mpr hy.2]
  have hright : IntervalIntegrable f volume a x := by
    apply hKint.congr
    intro y hy
    rw [Set.uIoc_of_le hax] at hy
    simp [f, hy.1]
  exact hleft.trans hright

private theorem integral_activation {a x : ℝ} (ha1 : 1 ≤ a) (hax : a ≤ x)
    (K : ℝ → ℝ) (hKa : K a = 0)
    (hKint : IntervalIntegrable K volume a x) :
    (∫ y in (1 : ℝ)..x, if a < y then K y else 0) =
      ∫ y in a..x, K y := by
  let f : ℝ → ℝ := fun y => if a < y then K y else 0
  have hleft : IntervalIntegrable f volume 1 a := by
    have h0 : IntervalIntegrable (fun _ : ℝ => (0 : ℝ)) volume 1 a := by simp
    apply h0.congr
    intro y hy
    rw [Set.uIoc_of_le ha1] at hy
    simp [f, not_lt.mpr hy.2]
  have hright : IntervalIntegrable f volume a x := by
    apply hKint.congr
    intro y hy
    rw [Set.uIoc_of_le hax] at hy
    simp [f, hy.1]
  have hsplit := integral_add_adjacent_intervals hleft hright
  have hzero : (∫ y in (1 : ℝ)..a, f y) = 0 := by
    calc
      _ = ∫ y in (1 : ℝ)..a, (0 : ℝ) := by
        apply integral_congr
        intro y hy
        rw [Set.uIcc_of_le ha1] at hy
        simp [f, not_lt.mpr hy.2]
      _ = 0 := by simp
  have heq : (∫ y in a..x, f y) = ∫ y in a..x, K y := by
    apply integral_congr
    intro y hy
    rw [Set.uIcc_of_le hax] at hy
    rcases hy.1.lt_or_eq with hlt | heq
    · simp [f, hlt]
    · rw [← heq]
      simp [f, hKa]
  change (∫ y in (1 : ℝ)..x, f y) = _
  calc
    _ = (∫ y in (1 : ℝ)..a, f y) + ∫ y in a..x, f y := by
      simpa using hsplit.symm
    _ = _ := by rw [hzero, zero_add, heq]

private def combinedKernel (a s y : ℝ) : ℝ := kernelB a y - kernelM a s y

private def activatedKernel (a s y : ℝ) : ℝ :=
  if a < y then combinedKernel a s y else 0

private theorem combinedKernel_integrable {a s x : ℝ} (ha : 0 < a) (hax : a ≤ x) :
    IntervalIntegrable (combinedKernel a s) volume a x := by
  exact (kernelB_integrable ha hax).sub (kernelM_integrable ha hax)

private theorem combinedKernel_at (a s : ℝ) :
    combinedKernel a s a = 0 := by
  simp [combinedKernel, kernelB, kernelM]

private theorem activatedKernel_integrable {a s x : ℝ} (ha1 : 1 ≤ a) (hax : a ≤ x) :
    IntervalIntegrable (activatedKernel a s) volume 1 x := by
  exact activation_integrable ha1 hax (combinedKernel a s)
    (combinedKernel_integrable (lt_of_lt_of_le zero_lt_one ha1) hax)

private theorem activatedKernel_integral {a s x : ℝ} (ha1 : 1 ≤ a) (hax : a ≤ x) :
    x ^ 2 * (∫ y in (1 : ℝ)..x, activatedKernel a s y) =
      (if a < x then (x - a) / Real.sqrt a *
        PrimeHistoryDivisorResponse.R (x / a - 1) else 0) -
      s * (x - a) ^ 2 / (2 * a * Real.sqrt a) := by
  have ha : 0 < a := lt_of_lt_of_le zero_lt_one ha1
  change x ^ 2 * (∫ y in (1 : ℝ)..x,
    if a < y then combinedKernel a s y else 0) = _
  rw [integral_activation ha1 hax (combinedKernel a s)
    (combinedKernel_at a s) (combinedKernel_integrable ha hax)]
  rw [show (∫ y in a..x, combinedKernel a s y) =
    (∫ y in a..x, kernelB a y) - ∫ y in a..x, kernelM a s y from by
      exact integral_sub (kernelB_integrable ha hax) (kernelM_integrable ha hax)]
  rw [mul_sub, baseline_integral_scalar ha hax, density_integral_scalar ha hax]

open ActualPrimeCutoffCovarianceFinite DensityPrimeCovarianceFinite

def completeScore (n : ℕ) : ℝ :=
  ∑ p ∈ n.primeFactors, fullPrimeScore p n

def RnumOn (N : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N,
    cutoffWeight x n * PrimeHistoryDivisorResponse.R (x / n - 1)

def DnumOn (N : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N,
    cutoffWeight x n * densityScore x n * completeScore n

def ArawOn (N : ℕ) (y : ℝ) : ℝ :=
  densityMass N y / 2 -
    ∑ n ∈ Finset.Icc 1 N, cutoffWeight y n * completeScore n

def AintOn (N : ℕ) (y : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, activatedKernel n (completeScore n) y

private theorem cutoff_term_eq_integral {n : ℕ} {x : ℝ}
    (hn : 1 ≤ n) (hnx : (n : ℝ) ≤ x) :
    cutoffWeight x n * PrimeHistoryDivisorResponse.R (x / n - 1) -
      cutoffWeight x n * densityScore x n * completeScore n / 2 =
      x ^ 2 * (∫ y in (1 : ℝ)..x,
        activatedKernel n (completeScore n) y) := by
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn
  have hpos : (0 : ℝ) < n := lt_of_lt_of_le zero_lt_one hnR
  have hroot : Real.sqrt (n : ℝ) ≠ 0 := (Real.sqrt_pos.2 hpos).ne'
  have hn0 : (n : ℝ) ≠ 0 := ne_of_gt hpos
  rw [activatedKernel_integral hnR hnx]
  by_cases hlt : (n : ℝ) < x
  · rw [if_pos hlt]
    simp only [cutoffWeight, if_pos hlt, densityScore]
    field_simp [hn0, hroot]
  · have heq : (n : ℝ) = x := le_antisymm hnx (le_of_not_gt hlt)
    rw [← heq]
    simp [cutoffWeight, hpos.ne', densityScore]

/-- Exact finite Fubini row with every actual prime power retained in `completeScore`. -/
theorem finite_volterra {N : ℕ} {x : ℝ} (hNx : (N : ℝ) ≤ x) :
    RnumOn N x - DnumOn N x / 2 =
      x ^ 2 * (∫ y in (1 : ℝ)..x, AintOn N y) := by
  have hInt : ∀ n ∈ Finset.Icc 1 N,
      IntervalIntegrable (activatedKernel n (completeScore n)) volume 1 x := by
    intro n hn
    have hn1 := (Finset.mem_Icc.mp hn).1
    have hnN : (n : ℝ) ≤ N := by exact_mod_cast (Finset.mem_Icc.mp hn).2
    have hnr : (n : ℝ) ≤ x := hnN.trans hNx
    exact activatedKernel_integrable (by exact_mod_cast hn1) hnr
  unfold RnumOn DnumOn AintOn
  rw [intervalIntegral.integral_finset_sum hInt, Finset.mul_sum]
  rw [Finset.sum_div, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hn1 := (Finset.mem_Icc.mp hn).1
  have hnN : (n : ℝ) ≤ N := by exact_mod_cast (Finset.mem_Icc.mp hn).2
  have hnr : (n : ℝ) ≤ x := hnN.trans hNx
  simpa [mul_div_assoc] using cutoff_term_eq_integral hn1 hnr

private theorem raw_term_eq_activated {n : ℕ} {y : ℝ}
    (hn : 1 ≤ n) (hy : 0 < y) :
    cutoffWeight y n * densityScore y n / 2 -
      cutoffWeight y n * completeScore n =
      y ^ 3 * activatedKernel n (completeScore n) y := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hn0 : (n : ℝ) ≠ 0 := ne_of_gt hnR
  have hroot : Real.sqrt (n : ℝ) ≠ 0 := (Real.sqrt_pos.2 hnR).ne'
  have hy0 : y ≠ 0 := ne_of_gt hy
  by_cases hlt : (n : ℝ) < y
  · simp only [cutoffWeight, if_pos hlt, densityScore, activatedKernel,
      combinedKernel, kernelB, kernelM]
    field_simp [hn0, hroot, hy0]
  · simp [cutoffWeight, hlt, activatedKernel]

/-- The integrated finite source is literally the density-half minus the
complete all-prime-power score numerator, with no normalization division. -/
theorem ArawOn_div_eq_AintOn {N : ℕ} {y : ℝ} (hy : 0 < y) :
    ArawOn N y / y ^ 3 = AintOn N y := by
  unfold ArawOn AintOn densityMass
  rw [Finset.sum_div, ← Finset.sum_sub_distrib, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro n hn
  rw [raw_term_eq_activated (Finset.mem_Icc.mp hn).1 hy]
  field_simp [ne_of_gt hy]

/-- The exact finite all-real Volterra/Fubini identity for the actual
complete prime-score numerator. For `N=⌊x⌋₊`, these are precisely the
cutoff numerators and the running density/prime means in the written formula. -/
theorem finite_volterra_actual {N : ℕ} {x : ℝ}
    (hx : 1 ≤ x) (hNx : (N : ℝ) ≤ x) :
    RnumOn N x - DnumOn N x / 2 =
      x ^ 2 * (∫ y in (1 : ℝ)..x, ArawOn N y / y ^ 3) := by
  rw [finite_volterra hNx]
  congr 1
  apply integral_congr
  intro y hy
  rw [Set.uIcc_of_le hx] at hy
  exact (ArawOn_div_eq_AintOn (lt_of_lt_of_le zero_lt_one hy.1)).symm

private theorem scoreMass_stable {M N : ℕ} {y : ℝ}
    (hMN : M ≤ N) (hy : y ≤ (M : ℝ) + 1) :
    (∑ n ∈ Finset.Icc 1 N, cutoffWeight y n * completeScore n) =
      ∑ n ∈ Finset.Icc 1 M, cutoffWeight y n * completeScore n := by
  symm
  apply Finset.sum_subset
  · intro n hn
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hMN⟩
  · intro n hnN hnM
    have hnlarge : M < n := by
      have hnlo := (Finset.mem_Icc.mp hnN).1
      have hnot : ¬n ≤ M := by
        intro hnle
        exact hnM (Finset.mem_Icc.mpr ⟨hnlo, hnle⟩)
      omega
    have hnot : ¬(n : ℝ) < y := by
      have hcast : (M : ℝ) + 1 ≤ n := by exact_mod_cast hnlarge
      exact not_lt.mpr (hy.trans hcast)
    simp [cutoffWeight, hnot]

private theorem ArawOn_stable {M N : ℕ} {y : ℝ}
    (hMN : M ≤ N) (hy : y ≤ (M : ℝ) + 1) :
    ArawOn N y = ArawOn M y := by
  unfold ArawOn
  rw [densityMass_stable hMN hy, scoreMass_stable hMN hy]

def Rnum (x : ℝ) : ℝ := RnumOn ⌊x⌋₊ x
def Dnum (x : ℝ) : ℝ := DnumOn ⌊x⌋₊ x
def Araw (y : ℝ) : ℝ := ArawOn ⌊y⌋₊ y
def Z (y : ℝ) : ℝ := cutoffMass ⌊y⌋₊ y
def beta (y : ℝ) : ℝ := densityMean ⌊y⌋₊ y
def mu (y : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 ⌊y⌋₊, cutoffWeight y n * completeScore n) / Z y

private theorem Araw_eq_Z_beta_mu {y : ℝ} (hy : 1 < y) :
    Araw y = Z y * (beta y / 2 - mu y) := by
  have hN : 1 ≤ ⌊y⌋₊ := by
    apply (Nat.le_floor_iff (by linarith : 0 ≤ y)).2
    simpa using hy.le
  have hZ : Z y ≠ 0 := by
    exact (cutoffMass_pos hN hy).ne'
  change cutoffMass ⌊y⌋₊ y ≠ 0 at hZ
  simp only [Araw, ArawOn, Z, beta, mu]
  rw [densityMass_eq_mass_mul_densityMean]
  field_simp [hZ]

private theorem Araw_eq_Z_beta_mu_one :
    Araw 1 = Z 1 * (beta 1 / 2 - mu 1) := by
  simp [Araw, ArawOn, Z, beta, mu, densityMass, cutoffMass,
    cutoffWeight, densityMean]

/-- Exact all-real running-cutoff identity; the source uses every prime
power through the full score. The theorem is finite and unconditional,
but makes no signed estimate for the resulting integral or residual. -/
theorem volterra_actual_all_real {x : ℝ} (hx : 1 ≤ x) :
    Rnum x - Dnum x / 2 =
      x ^ 2 * (∫ y in (1 : ℝ)..x, Araw y / y ^ 3) := by
  have hfloor : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le (by linarith)
  unfold Rnum Dnum
  rw [finite_volterra_actual hx hfloor]
  congr 1
  apply integral_congr
  intro y hy
  rw [Set.uIcc_of_le hx] at hy
  have hy0 : 0 ≤ y := by linarith [hy.1]
  have hfloor_mono : ⌊y⌋₊ ≤ ⌊x⌋₊ := Nat.floor_mono hy.2
  have hybound : y ≤ (⌊y⌋₊ : ℝ) + 1 := (Nat.lt_floor_add_one y).le
  simp only [Araw]
  rw [ArawOn_stable hfloor_mono hybound]

#print axioms volterra_actual_all_real

/-- The target Volterra identity in the original mean notation. The
one-point lower endpoint is handled explicitly; all admitted prime powers
remain in `completeScore`. -/
theorem volterra_Z_beta_mu {x : ℝ} (hx : 1 ≤ x) :
    Rnum x - Dnum x / 2 =
      x ^ 2 * (∫ y in (1 : ℝ)..x,
        (Z y * (beta y / 2 - mu y)) / y ^ 3) := by
  rw [volterra_actual_all_real hx]
  congr 1
  apply integral_congr
  intro y hy
  rw [Set.uIcc_of_le hx] at hy
  change Araw y / y ^ 3 = (Z y * (beta y / 2 - mu y)) / y ^ 3
  rcases hy.1.lt_or_eq with hlt | heq
  · rw [Araw_eq_Z_beta_mu hlt]
  · rw [← heq, Araw_eq_Z_beta_mu_one]

#print axioms volterra_Z_beta_mu

#print axioms finite_volterra_actual

end
end BuildingBlocks.ActualVolterraIdentity
