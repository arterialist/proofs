import BuildingBlocks.ActualVolterraIdentity
import BuildingBlocks.PrimeHistoryDivisorResponse
import BuildingBlocks.PrimePrimitiveFormula
import Mathlib.Tactic

/-! An exact finite arithmetic bridge from the actual cutoff density/score
source to the centered Chebyshev prime-error primitive. No analytic estimate
is assumed or proved here. -/

namespace BuildingBlocks.ActualPrimeErrorBridge

open Finset
open ActualPrimeCutoffCovarianceFinite
open DensityPrimeCovarianceFinite
open ActualVolterraIdentity
open PrimeHistoryDivisorResponse
open PrimeScoreDivisorIdentity

noncomputable section

def Jfinite (u : ℝ) : ℝ :=
  (∑ q ∈ Finset.Icc 1 ⌊u⌋₊,
    ArithmeticFunction.vonMangoldt q * (u - q)) - (u ^ 2 - 1) / 2

theorem Jfinite_eq_actual_integral {u : ℝ} (hu : 1 ≤ u) :
    Jfinite u = ∫ t in (1 : ℝ)..u, CoarsePrimitive.primeErrorReal t := by
  rw [BuildingBlocks.integral_primeErrorReal_eq_area hu]
  rw [BuildingBlocks.primePrimitiveArea_eq_weighted_sum]
  unfold Jfinite
  apply congrArg (fun z : ℝ => z - (u ^ 2 - 1) / 2)
  apply Finset.sum_congr rfl
  intro q hq
  ring

def AoldOn (N : ℕ) (x : ℝ) : ℝ :=
  (∑ d ∈ Finset.Icc 1 N, ∑ q ∈ Finset.Icc 1 (N / d),
    Real.sqrt d * ArithmeticFunction.vonMangoldt q * (x / d - q)) -
  ∑ d ∈ Finset.Icc 1 N,
    Real.sqrt d * ((x / d) ^ 2 - 1) / 2

def Aold (x : ℝ) : ℝ := AoldOn ⌊x⌋₊ x

private theorem prime_row_reindex (N : ℕ) (x : ℝ) (hNx : (N : ℝ) ≤ x) :
    (∑ d ∈ Finset.Icc 1 N, ∑ q ∈ Finset.Icc 1 (N / d),
      Real.sqrt d * ArithmeticFunction.vonMangoldt q * (x / d - q)) =
    ∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * completeScore n := by
  classical
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d q => Real.sqrt d * ArithmeticFunction.vonMangoldt q * (x / d - q))]
  apply Finset.sum_congr rfl
  intro n hn
  obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
  have hnNR : (n : ℝ) ≤ N := by exact_mod_cast hnN
  have hnx : (n : ℝ) ≤ x := hnNR.trans hNx
  have hdiv : (∑ d ∈ n.divisors,
      Real.sqrt (n / d : ℕ) * ArithmeticFunction.vonMangoldt (n / d)) =
      ∑ q ∈ n.divisors, Real.sqrt q * ArithmeticFunction.vonMangoldt q :=
    Nat.sum_div_divisors n
      (fun q => Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q)
  calc
    (∑ d ∈ n.divisors,
      Real.sqrt d * ArithmeticFunction.vonMangoldt (n / d) *
        (x / d - (n / d : ℕ))) =
      ∑ d ∈ n.divisors,
        cutoffWeight x n * Real.sqrt (n / d : ℕ) *
          ArithmeticFunction.vonMangoldt (n / d) := by
        apply Finset.sum_congr rfl
        intro d hdmem
        obtain ⟨hdvd, _⟩ := Nat.mem_divisors.mp hdmem
        have hd : 0 < d := Nat.pos_of_dvd_of_pos hdvd hn1
        have hq : 0 < n / d := Nat.div_pos (Nat.le_of_dvd hn1 hdvd) hd
        have hmul : d * (n / d) = n := by
          simpa [Nat.mul_comm] using Nat.div_mul_cancel hdvd
        have hcut : (d : ℝ) * (n / d : ℕ) ≤ x := by
          have hmulR : (d : ℝ) * (n / d : ℕ) = n := by exact_mod_cast hmul
          rw [hmulR]
          exact hnx
        have hh := cofactor_tent_weight
          (fun q : ℕ => ArithmeticFunction.vonMangoldt q)
          hd hq hcut
        simpa [mul_comm, mul_left_comm, mul_assoc, hmul] using hh
    _ = cutoffWeight x n *
        (∑ q ∈ n.divisors,
          Real.sqrt q * ArithmeticFunction.vonMangoldt q) := by
        simp_rw [mul_assoc]
        rw [← Finset.mul_sum, hdiv]
    _ = cutoffWeight x n * completeScore n := by
        congr 1
        exact weighted_divisor_prime_score (Nat.ne_of_gt hn1)

private theorem density_row (N : ℕ) (x : ℝ) (hNx : (N : ℝ) ≤ x) :
    (∑ d ∈ Finset.Icc 1 N,
      Real.sqrt d * ((x / d) ^ 2 - 1) / 2) =
    cutoffMass N x + densityMass N x / 2 := by
  unfold cutoffMass densityMass
  simp only [Finset.sum_div]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd1
  have hroot : Real.sqrt (d : ℝ) ≠ 0 := (Real.sqrt_pos.2 hdR).ne'
  have hsq : (Real.sqrt (d : ℝ)) ^ 2 = d := Real.sq_sqrt hdR.le
  have hdNR : (d : ℝ) ≤ N := by exact_mod_cast hdN
  have hdx : (d : ℝ) ≤ x := hdNR.trans hNx
  by_cases hlt : (d : ℝ) < x
  · simp only [cutoffWeight, if_pos hlt, densityScore]
    field_simp [hdR.ne', hroot]
    nlinarith [hsq]
  · have heq : (d : ℝ) = x := le_antisymm hdx (le_of_not_gt hlt)
    rw [← heq]
    simp [cutoffWeight, densityScore, hdR.ne']

/-- The old macroscopic prime-error kernel is exactly the negative of the
new density-half/prime-score source, up to the original cutoff mass. -/
theorem ArawOn_eq_neg_mass_sub_AoldOn (N : ℕ) (x : ℝ)
    (hNx : (N : ℝ) ≤ x) :
    ArawOn N x = -cutoffMass N x - AoldOn N x := by
  unfold ArawOn AoldOn
  rw [prime_row_reindex N x hNx, density_row N x hNx]
  ring

/-- The two-index old kernel uses exactly the finite integrated Chebyshev
prime-error primitive, including the `-1` origin normalization. -/
theorem Aold_eq_Jfinite (x : ℝ) :
    Aold x = ∑ d ∈ Finset.Icc 1 ⌊x⌋₊,
      Real.sqrt d * Jfinite (x / d) := by
  unfold Aold AoldOn
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  unfold Jfinite
  rw [Nat.floor_div_natCast]
  simp only [mul_sub, Finset.mul_sum]
  congr 1
  apply Finset.sum_congr rfl
  intro q hq
  ring
  all_goals ring

/-- The old carrier is literally a convolution of the original, right-
continuous Chebyshev error with the harmonic cutoff; this is not a surrogate
prime source and keeps the origin value at one. -/
theorem Aold_eq_actual_prime_error {x : ℝ} (hx : 1 ≤ x) :
    Aold x = ∑ d ∈ Finset.Icc 1 ⌊x⌋₊,
      Real.sqrt d *
        (∫ t in (1 : ℝ)..x / d, CoarsePrimitive.primeErrorReal t) := by
  rw [Aold_eq_Jfinite]
  apply Finset.sum_congr rfl
  intro d hd
  obtain ⟨hd1, hdfloor⟩ := Finset.mem_Icc.mp hd
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd1
  have hdx : (d : ℝ) ≤ x := by
    have hreal : (d : ℝ) ≤ ⌊x⌋₊ := by exact_mod_cast hdfloor
    exact hreal.trans (Nat.floor_le (by linarith : 0 ≤ x))
  rw [Jfinite_eq_actual_integral ((one_le_div hdR).mpr hdx)]

/-- The actual running cutoff gap from the new Volterra theorem is exactly
the old prime-error kernel plus the origin/cutoff-mass term, at every real
cutoff above one and across integer seams. -/
theorem Araw_eq_neg_Z_sub_Aold {x : ℝ} (hx : 1 ≤ x) :
    Araw x = -Z x - Aold x := by
  have hfloor : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le (by linarith)
  exact ArawOn_eq_neg_mass_sub_AoldOn ⌊x⌋₊ x hfloor

/-- The published all-real Volterra row, now reduced to the original
von-Mangoldt prime-error primitive and the exact origin mass. This is the
actual `R-D/2` part of the signed W expression, not a model functional. -/
theorem volterra_actual_prime_error {x : ℝ} (hx : 1 ≤ x) :
    Rnum x - Dnum x / 2 =
      -(x ^ 2 * (∫ y in (1 : ℝ)..x, (Z y + Aold y) / y ^ 3)) := by
  rw [volterra_actual_all_real hx]
  have hint : (∫ y in (1 : ℝ)..x, Araw y / y ^ 3) =
      ∫ y in (1 : ℝ)..x, -((Z y + Aold y) / y ^ 3) := by
    apply intervalIntegral.integral_congr
    intro y hy
    rw [Set.uIcc_of_le hx] at hy
    change Araw y / y ^ 3 = -((Z y + Aold y) / y ^ 3)
    rw [Araw_eq_neg_Z_sub_Aold hy.1]
    ring
  rw [hint, intervalIntegral.integral_neg]
  ring

#print axioms ArawOn_eq_neg_mass_sub_AoldOn
#print axioms Jfinite_eq_actual_integral
#print axioms Aold_eq_Jfinite
#print axioms Aold_eq_actual_prime_error
#print axioms Araw_eq_neg_Z_sub_Aold
#print axioms volterra_actual_prime_error

end
end BuildingBlocks.ActualPrimeErrorBridge
