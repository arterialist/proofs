import BuildingBlocks.GoldbachScrewMinorFinite

/-!
# Finite Matsumoto-Suzuki H₁ row and the factorial ground

This file proves the finite algebra behind Proposition 6.1 (6.2):
the complete von Mangoldt row in hOneArithmetic equals the
right-continuous factorial-ground expression at every integer N ≥ 2.
At a prime-power endpoint, the summand is zero, so the explicit formula's
half-weight convention agrees with the unprimed factorial-ground sums.

This is an unconditional arithmetic identity. It neither formalizes the
zeta-zero explicit formula nor proves an RH-scale bound on the ground.
-/

namespace BuildingBlocks.FactorialHOneFinite

private theorem summand (x y a : ℝ) (hx : 0 < x) (hy : 0 < y) :
    a / Real.sqrt y * (Real.sqrt (x / y) - Real.sqrt (y / x)) =
      Real.sqrt x * (a / y) - a / Real.sqrt x := by
  have hsx : Real.sqrt x ≠ 0 := Real.sqrt_ne_zero'.mpr hx
  have hsy : Real.sqrt y ≠ 0 := Real.sqrt_ne_zero'.mpr hy
  have hsx2 : Real.sqrt x ^ 2 = x := Real.sq_sqrt hx.le
  have hsy2 : Real.sqrt y ^ 2 = y := Real.sq_sqrt hy.le
  rw [Real.sqrt_div hx.le, Real.sqrt_div hy.le]
  field_simp
  rw [hsx2, hsy2]
  ring

open scoped BigOperators ArithmeticFunction

/-- Complete Chebyshev prime-power prefix at an integer endpoint. -/
noncomputable def psiFinite (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n

/-- The weighted prime-power prefix in the factorial ground. -/
noncomputable def logPrimeFinite (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)

/-- The original factorial ground at a positive integer. -/
noncomputable def fFinite (N : ℕ) : ℝ :=
  Real.log N - logPrimeFinite N + psiFinite N / N

/-- The primed H₁ prime row equals the two unprimed factorial-ground
prefixes. The endpoint term vanishes exactly. -/
theorem primeRow_eq (N : ℕ) (hN : 0 < N) :
    GoldbachScrewMinorFinite.hOnePrimeRow N =
      Real.sqrt N * logPrimeFinite N - psiFinite N / Real.sqrt N := by
  have hNr : 0 < (N : ℝ) := by exact_mod_cast hN
  rw [GoldbachScrewMinorFinite.hOnePrimeRow]
  calc
    (∑ n ∈ Finset.Icc 1 N,
      GoldbachScrewMinorFinite.endpointWeight N n * ArithmeticFunction.vonMangoldt n /
        Real.sqrt n *
        (Real.sqrt ((N : ℝ) / n) - Real.sqrt ((n : ℝ) / N))) =
      ∑ n ∈ Finset.Icc 1 N,
        (Real.sqrt N * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
          ArithmeticFunction.vonMangoldt n / Real.sqrt N) := by
          apply Finset.sum_congr rfl
          intro n hn
          have hn0 : 0 < n := by
            have hbounds := Finset.mem_Icc.mp hn
            omega
          have hnr : 0 < (n : ℝ) := by exact_mod_cast hn0
          have ht := summand (N : ℝ) (n : ℝ) (ArithmeticFunction.vonMangoldt n) hNr hnr
          by_cases heq : n = N
          · subst n
            have hz : Real.sqrt (N : ℝ) *
                (ArithmeticFunction.vonMangoldt N / (N : ℝ)) -
                ArithmeticFunction.vonMangoldt N / Real.sqrt N = 0 := by
              rw [← ht]
              simp
            simp [GoldbachScrewMinorFinite.endpointWeight, hz]
          · simp only [GoldbachScrewMinorFinite.endpointWeight, if_neg heq, one_mul]
            exact ht
    _ = Real.sqrt N * logPrimeFinite N - psiFinite N / Real.sqrt N := by
      simp [logPrimeFinite, psiFinite, Finset.sum_sub_distrib, Finset.mul_sum,
        Finset.sum_div]

/-- The elementary archimedean correction in the H₁ formula. -/
noncomputable def tCorrection (x : ℝ) : ℝ :=
  (1 / 2) * Real.log (1 - x⁻¹ ^ 2) +
    (x / 2) * Real.log ((x + 1) / (x - 1)) - 1

/-- Exact finite identity between the published H₁ arithmetic expression
and the original factorial ground, including all prime powers and the
archimedean correction. -/
theorem hOneArithmetic_eq_ground (N : ℕ) (hN : 1 < N) :
    GoldbachScrewMinorFinite.hOneArithmetic N =
      Real.sqrt N * (1 + Real.eulerMascheroniConstant - fFinite N) -
        (Real.log (2 * Real.pi) + tCorrection N) / Real.sqrt N := by
  have hN0 : 0 < N := by omega
  have hNr : 0 < (N : ℝ) := by exact_mod_cast hN0
  have hsN : Real.sqrt (N : ℝ) ≠ 0 := Real.sqrt_ne_zero'.mpr hNr
  have hsN2 : Real.sqrt (N : ℝ) ^ 2 = N := Real.sq_sqrt hNr.le
  rw [GoldbachScrewMinorFinite.hOneArithmetic, primeRow_eq N hN0]
  simp only [GoldbachScrewMinorFinite.hOneArchimedean, fFinite, tCorrection]
  field_simp
  rw [hsN2]
  ring

end BuildingBlocks.FactorialHOneFinite
