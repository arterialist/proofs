import BuildingBlocks.EtaRieszKernel
import BuildingBlocks.DistinctPrimeRieszMellin
import BuildingBlocks.SummableIntegrals
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Algebra.Order.Floor.Ring

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.EtaRieszDirichlet

open EtaRieszKernel

/-- The eta cross-kernel sum over the actual positive integers revealed by `x`.
The coefficient at one and every zero-weight integer birth are retained. -/
noncomputable def cutoffSum (c : ℕ → ℂ) (x : ℝ) : ℂ :=
  ∑ n ∈ Finset.range ⌊x⌋₊, c (n + 1) * EtaRieszKernel.kernel (n + 1) x

theorem kernel_eq_zero_outside_cutoff (x : ℝ) {n : ℕ}
    (hn : n ∉ Finset.range ⌊x⌋₊) : EtaRieszKernel.kernel (n + 1) x = 0 := by
  have hn0 : ⌊x⌋₊ ≤ n := Nat.le_of_not_gt (by simpa using hn)
  have hnr : (⌊x⌋₊ : ℝ) ≤ n := by exact_mod_cast hn0
  have hx := Nat.lt_floor_add_one x
  have hxle : x - ((n : ℝ) + 1) ≤ 0 := by linarith
  exact EtaRieszKernel.kernel_eq_zero (by linarith)

theorem tsum_tents_eq_cutoff (c : ℕ → ℂ) (x : ℝ) :
    (∑' n : ℕ, c (n + 1) * EtaRieszKernel.kernel (n + 1) x) = cutoffSum c x := by
  apply tsum_eq_sum
  intro n hn
  rw [kernel_eq_zero_outside_cutoff x hn, mul_zero]

noncomputable def kernel (c : ℕ → ℂ) (s : ℂ) (n : ℕ) (x : ℝ) : ℂ :=
  (x : ℂ) ^ (-s - 2) * (c (n + 1) * EtaRieszKernel.kernel (n + 1) x)

theorem tsum_kernel (c : ℕ → ℂ) (s : ℂ) (x : ℝ) :
    (∑' n : ℕ, kernel c s n x) = (x : ℂ) ^ (-s - 2) * cutoffSum c x := by
  rw [tsum_eq_sum (s := Finset.range ⌊x⌋₊)]
  · simp only [cutoffSum, kernel, Finset.mul_sum]
  · intro n hn
    simp [kernel, kernel_eq_zero_outside_cutoff x hn]

theorem weighted_hasMellin {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re)
    (c : ℂ) :
    HasMellin (fun x => c * EtaRieszKernel.kernel a x) (-s - 1)
      (c * (a : ℂ)^(-s) / ((s-1)*(s+1))) := by
  have h := hasMellin_kernel ha hs
  constructor
  · exact h.1.const_smul c
  · rw [show (fun x => c * EtaRieszKernel.kernel a x) =
        (fun x => c • EtaRieszKernel.kernel a x) by rfl,
      mellin_const_smul, h.2]
    simp only [smul_eq_mul, mul_div_assoc]

theorem kernel_integrable (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re) (n : ℕ) :
    IntegrableOn (kernel c s n) (Ioi 0) := by
  have h := weighted_hasMellin (show (0 : ℝ) < n + 1 by positivity) hs (c (n + 1))
  simpa only [MellinConvergent, kernel, smul_eq_mul,
    show (-s - 1) - 1 = -s - 2 by ring] using h.1

theorem integral_kernel (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re) (n : ℕ) :
    (∫ x : ℝ in Ioi 0, kernel c s n x) =
      c (n + 1) * ((n + 1 : ℝ) : ℂ) ^ (-s) / ((s-1) * (s + 1)) := by
  have h := weighted_hasMellin (show (0 : ℝ) < n + 1 by positivity) hs (c (n + 1))
  simpa only [mellin, kernel, smul_eq_mul,
    show (-s - 1) - 1 = -s - 2 by ring] using h.2

theorem integral_norm_kernel (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re) (n : ℕ) :
    (∫ x : ℝ in Ioi 0, ‖kernel c s n x‖) =
      (‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re)) / ((s.re - 1) * (s.re + 1)) := by
  have he (x : ℝ) : kernel c s n x =
      c (n + 1) * ((x : ℂ) ^ (-s - 2) * EtaRieszKernel.kernel (n + 1) x) := by
    unfold kernel
    ring
  have hn (x : ℝ) : ‖kernel c s n x‖ =
      ‖c (n + 1)‖ * ‖(x : ℂ) ^ (-s - 2) * EtaRieszKernel.kernel (n + 1) x‖ := by
    rw [he]
    exact norm_mul _ _
  simp_rw [hn]
  rw [integral_const_mul, EtaRieszKernel.integral_norm_kernel (by positivity) hs, mul_div_assoc]

/-- An ordinary absolute Dirichlet bound supplies every Fubini norm estimate.
There is no assumption concerning zeros, cancellation, or eventual sign. -/
theorem kernel_norm_integrals_summable (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re)
    (hc : Summable (fun n : ℕ => ‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re))) :
    Summable (fun n : ℕ => ∫ x : ℝ in Ioi 0, ‖kernel c s n x‖) := by
  simpa only [integral_norm_kernel c hs] using hc.div_const ((s.re - 1) * (s.re + 1))

/-- Absolute convergence of the coefficient Dirichlet series justifies the
infinite eta-kernel Mellin identity. The readout is still the actual finite
sum at each real cutoff, rather than a separately postulated infinite function. -/
theorem hasMellin_cutoffSum (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re)
    (hc : Summable (fun n : ℕ => ‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re))) :
    HasMellin (cutoffSum c) (-s - 1)
      ((∑' n : ℕ, c (n + 1) * ((n + 1 : ℝ) : ℂ) ^ (-s)) / ((s - 1) * (s + 1))) := by
  have hF : ∀ n : ℕ, Integrable (kernel c s n) (volume.restrict (Ioi 0)) :=
    kernel_integrable c hs
  have hnorm := kernel_norm_integrals_summable c hs hc
  have heq : (fun x : ℝ => ∑' n : ℕ, kernel c s n x) =
      (fun x : ℝ => (x : ℂ) ^ (-s - 2) * cutoffSum c x) := by
    funext x
    exact tsum_kernel c s x
  have hint := SummableIntegrals.integrable_tsum_of_summable_integral_norm hF hnorm
  rw [heq] at hint
  constructor
  · simpa only [MellinConvergent, smul_eq_mul,
      show (-s - 1) - 1 = -s - 2 by ring] using hint
  · have hswap := integral_tsum_of_summable_integral_norm hF hnorm
    rw [heq] at hswap
    unfold mellin
    simp only [smul_eq_mul, show (-s - 1) - 1 = -s - 2 by ring]
    rw [← hswap]
    simp_rw [integral_kernel c hs]
    exact tsum_div_const

/-- Actual von Mangoldt coefficients, including every prime power. -/
noncomputable def crossTerm (x : ℝ) : ℂ :=
  cutoffSum (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) x

theorem hasMellin_crossTerm {s : ℂ} (hs : 1 < s.re) :
    HasMellin crossTerm (-s-1)
      ((-deriv riemannZeta s / riemannZeta s) / ((s-1)*(s+1))) := by
  have hl : LSeriesHasSum (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s
      (-deriv riemannZeta s / riemannZeta s) :=
    LSeriesHasSum_iff.mpr ⟨ArithmeticFunction.LSeriesSummable_vonMangoldt hs,
      ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs⟩
  have h := hasMellin_cutoffSum _ hs
    (DistinctPrimeRieszMellin.summable_norm_succ_of_LSeriesSummable hl.LSeriesSummable)
  rw [DistinctPrimeRieszMellin.tsum_succ_eq_of_LSeriesHasSum hl] at h
  exact h

end BuildingBlocks.EtaRieszDirichlet
