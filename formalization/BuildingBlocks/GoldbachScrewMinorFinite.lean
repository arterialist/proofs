import BuildingBlocks.GoldbachHeatConvolution
import Mathlib.Analysis.Complex.ExponentialBounds

/-!
# Lowest screw and moment minors for the Goldbach comparison

This file keeps two positivity mechanisms separate.  The first is the
two-point principal minor of an even screw kernel.  The second is the
ordinary weighted moment inequality, valid for every finite nonnegative
packet (and hence for finite Dirichlet packets in their absolute-convergence
half-plane).

The last results compute the first three nonzero uncentred Goldbach
coefficients.  Their smallest Hankel determinant is negative, so those raw
additive coefficients cannot themselves be substituted for the moments of
the Matsumoto--Suzuki distribution.
-/

namespace BuildingBlocks.GoldbachScrewMinorFinite

open scoped BigOperators ArithmeticFunction
open BuildingBlocks.GoldbachHeat

noncomputable section

/-- The translation-normalized kernel attached to a candidate screw
function. -/
def screwKernel (g : ℝ → ℝ) (t u : ℝ) : ℝ :=
  g (t - u) - g t - g (-u) + g 0

theorem screwKernel_diagonal {g : ℝ → ℝ}
    (heven : ∀ x, g (-x) = g x) (t : ℝ) :
    screwKernel g t t = -2 * (g t - g 0) := by
  rw [screwKernel, sub_self, heven]
  ring

theorem screwKernel_dyadic_cross {g : ℝ → ℝ}
    (heven : ∀ x, g (-x) = g x) (t : ℝ) :
    screwKernel g t (2 * t) = -(g (2 * t) - g 0) := by
  rw [screwKernel]
  have hsub : t - 2 * t = -t := by ring
  rw [hsub, heven t, heven (2 * t)]
  ring

/-- The exact determinant of the dyadic two-point screw minor. -/
theorem dyadic_minor_determinant (a b : ℝ) :
    (-2 * a) * (-2 * b) - (-b) ^ 2 = b * (4 * a - b) := by
  ring

/-- The one-point and dyadic two-point PSD conditions force the lowest
nontrivial screw inequality `4(g(t)-g(0)) ≤ g(2t)-g(0) ≤ 0`. -/
theorem dyadic_screw_inequality {a b : ℝ}
    (ha : a ≤ 0) (hb : b ≤ 0)
    (hdet : 0 ≤ b * (4 * a - b)) :
    4 * a ≤ b ∧ b ≤ 0 := by
  refine ⟨?_, hb⟩
  rcases hb.eq_or_lt with rfl | hbneg
  · linarith
  · by_contra h
    have hpos : 0 < 4 * a - b := by linarith
    have : b * (4 * a - b) < 0 := mul_neg_of_neg_of_pos hbneg hpos
    linarith

/-- Half weight at the moving endpoint.  If the endpoint is not a prime
power its von Mangoldt coefficient is zero, so this is exactly the primed
sum convention in the explicit formula. -/
def endpointWeight (N n : ℕ) : ℝ := if n = N then 1 / 2 else 1

/-- The complete finite von Mangoldt row in the unconditional explicit
formula for `H₁(N)`.  It includes every prime power and the primed endpoint. -/
noncomputable def hOnePrimeRow (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N,
    endpointWeight N n * ArithmeticFunction.vonMangoldt n / Real.sqrt n *
      (Real.sqrt ((N : ℝ) / n) - Real.sqrt ((n : ℝ) / N))

/-- The archimedean correction in the same explicit formula. -/
noncomputable def hOneArchimedean (x : ℝ) : ℝ :=
  Real.sqrt x * (Real.log x - Real.eulerMascheroniConstant - 1) +
    (Real.log (2 * Real.pi) +
      (1 / 2) * Real.log (1 - x⁻¹ ^ 2) +
      (x / 2) * Real.log ((x + 1) / (x - 1)) - 1) / Real.sqrt x

/-- The literal finite arithmetic side of Matsumoto--Suzuki Proposition
6.1 at an integer `N>1`: `H₁(N) = row - archimedean`. -/
noncomputable def hOneArithmetic (N : ℕ) : ℝ :=
  hOnePrimeRow N - hOneArchimedean N

/-- Once the one- and two-point screw minors are supplied for the actual
arithmetic values, their exact finite consequence is the dyadic inequality
between the complete rows at `N` and `N²`.  The hypotheses are deliberately
explicit: proving them uniformly would be an RH-level sign input. -/
theorem hOne_dyadic_finite_consumer (N : ℕ) (origin : ℝ)
    (hN : hOneArithmetic N - origin ≤ 0)
    (hN2 : hOneArithmetic (N ^ 2) - origin ≤ 0)
    (hminor : 0 ≤ (hOneArithmetic (N ^ 2) - origin) *
      (4 * (hOneArithmetic N - origin) -
        (hOneArithmetic (N ^ 2) - origin))) :
    4 * (hOneArithmetic N - origin) ≤
        hOneArithmetic (N ^ 2) - origin ∧
      hOneArithmetic (N ^ 2) - origin ≤ 0 :=
  dyadic_screw_inequality hN hN2 hminor

/-- Finite weighted Cauchy--Schwarz in moment form.  No analytic
continuation is involved. -/
theorem finite_moment_minor_nonnegative {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (w x : ι → ℝ) (hw : ∀ i ∈ s, 0 ≤ w i) :
    (∑ i ∈ s, w i * x i) ^ 2 ≤
      (∑ i ∈ s, w i) * ∑ i ∈ s, w i * x i ^ 2 := by
  let f : ι → ℝ := fun i => Real.sqrt (w i)
  let h : ι → ℝ := fun i => Real.sqrt (w i) * x i
  have hcs := Finset.sum_mul_sq_le_sq_mul_sq s f h
  have hsqrt : ∀ i ∈ s, (Real.sqrt (w i)) ^ 2 = w i := by
    intro i hi
    exact Real.sq_sqrt (hw i hi)
  have hmiddle : (∑ i ∈ s, f i * h i) = ∑ i ∈ s, w i * x i := by
    apply Finset.sum_congr rfl
    intro i hi
    dsimp [f, h]
    rw [← mul_assoc, ← pow_two, hsqrt i hi]
  have hleft : (∑ i ∈ s, f i ^ 2) = ∑ i ∈ s, w i := by
    apply Finset.sum_congr rfl
    intro i hi
    exact hsqrt i hi
  have hright : (∑ i ∈ s, h i ^ 2) = ∑ i ∈ s, w i * x i ^ 2 := by
    apply Finset.sum_congr rfl
    intro i hi
    dsimp [h]
    rw [mul_pow, hsqrt i hi]
  rwa [hmiddle, hleft, hright] at hcs

/-- The literal finite additive von Mangoldt prefix used in the
Matsumoto--Suzuki Goldbach formula.  The index `k` represents the additive
total `k+2`, so all ordered pairs and all prime powers are retained. -/
noncomputable def inverseSquareGoldbachPrefix (N : ℕ) : ℝ :=
  ∑ k ∈ Finset.range (N - 1),
    shiftedPrimeGoldbach k / (((k + 2 : ℕ) : ℝ) ^ 2)

/-- Exact algebraic translation of the dyadic screw inequality through a
Goldbach-prefix formula with its remainder retained.  Suppressing either
`errN` or `errN2` would be an additional analytic assertion. -/
theorem goldbach_prefix_dyadic_translation (N : ℕ)
    (constant errN errN2 origin HN HN2 : ℝ)
    (hN : HN = Real.sqrt N / 2 *
      (inverseSquareGoldbachPrefix N - Real.log N - constant - errN))
    (hN2 : HN2 = (N : ℝ) / 2 *
      (inverseSquareGoldbachPrefix (N ^ 2) - Real.log (N ^ 2) -
        constant - errN2))
    (hminor : 4 * (HN - origin) ≤ HN2 - origin) :
    2 * Real.sqrt N *
        (inverseSquareGoldbachPrefix N - Real.log N - constant - errN) -
      (N : ℝ) / 2 *
        (inverseSquareGoldbachPrefix (N ^ 2) - Real.log (N ^ 2) -
          constant - errN2) ≤
      3 * origin := by
  rw [hN, hN2] at hminor
  linarith

private lemma mangoldt_two : ArithmeticFunction.vonMangoldt 2 = Real.log 2 :=
  ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two

private lemma mangoldt_three : ArithmeticFunction.vonMangoldt 3 = Real.log 3 :=
  ArithmeticFunction.vonMangoldt_apply_prime (by decide)

private lemma mangoldt_four : ArithmeticFunction.vonMangoldt 4 = Real.log 2 := by
  change ArithmeticFunction.vonMangoldt (2 ^ 2) = _
  rw [ArithmeticFunction.vonMangoldt_apply_pow (by norm_num), mangoldt_two]

/-- The first nonzero uncentred additive von Mangoldt coefficient, total
four.  The endpoint convention is the complete ordered antidiagonal. -/
theorem prime_goldbach_four : shiftedPrimeGoldbach 2 = (Real.log 2) ^ 2 := by
  have ha : Finset.antidiagonal 2 = {(0, 2), (1, 1), (2, 0)} := by decide
  simp [shiftedPrimeGoldbach, ha, mangoldt_two]
  ring

/-- The complete ordered coefficient at total five. -/
theorem prime_goldbach_five :
    shiftedPrimeGoldbach 3 = 2 * Real.log 2 * Real.log 3 := by
  have ha : Finset.antidiagonal 3 = {(0, 3), (1, 2), (2, 1), (3, 0)} := by decide
  simp [shiftedPrimeGoldbach, ha, mangoldt_two, mangoldt_three]
  ring

/-- The complete ordered coefficient at total six, including the prime
power `4=2^2` and the diagonal `3+3`. -/
theorem prime_goldbach_six :
    shiftedPrimeGoldbach 4 = 2 * (Real.log 2) ^ 2 + (Real.log 3) ^ 2 := by
  have ha : Finset.antidiagonal 4 =
      {(0, 4), (1, 3), (2, 2), (3, 1), (4, 0)} := by decide
  simp [shiftedPrimeGoldbach, ha, mangoldt_two, mangoldt_three, mangoldt_four]
  ring

private lemma log_three_gt_one : (1 : ℝ) < Real.log 3 := by
  rw [Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)]
  exact Real.exp_one_lt_d9.trans (by norm_num)

/-- The raw uncentred Goldbach coefficients are not a Hankel moment
sequence.  The first minor made entirely from nonzero coefficients, at
totals `4,5,6`, is already strictly negative. -/
theorem first_nonzero_goldbach_hankel_minor_neg :
    shiftedPrimeGoldbach 2 * shiftedPrimeGoldbach 4 -
      shiftedPrimeGoldbach 3 ^ 2 < 0 := by
  rw [prime_goldbach_four, prime_goldbach_five, prime_goldbach_six]
  have h2pos : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h2hi : Real.log 2 < (7 / 10 : ℝ) := by
    linarith [Real.log_two_lt_d9]
  have h3lo := log_three_gt_one
  have h2sq : (Real.log 2) ^ 2 < (49 / 100 : ℝ) := by nlinarith
  have h3sq : (1 : ℝ) < (Real.log 3) ^ 2 := by nlinarith
  have hbracket : 2 * (Real.log 2) ^ 2 - 3 * (Real.log 3) ^ 2 < 0 := by
    nlinarith
  have heq :
      (Real.log 2) ^ 2 * (2 * (Real.log 2) ^ 2 + (Real.log 3) ^ 2) -
          (2 * Real.log 2 * Real.log 3) ^ 2 =
        (Real.log 2) ^ 2 *
          (2 * (Real.log 2) ^ 2 - 3 * (Real.log 3) ^ 2) := by ring
  rw [heq]
  exact mul_neg_of_pos_of_neg (sq_pos_of_pos h2pos) hbracket

/-- Consequently, coefficientwise Goldbach existence or positivity cannot
provide the lowest moment minor required by a positive measure. -/
theorem raw_goldbach_not_hankel_positive :
    ¬ (∀ k : ℕ,
      shiftedPrimeGoldbach (k + 1) ^ 2 ≤
        shiftedPrimeGoldbach k * shiftedPrimeGoldbach (k + 2)) := by
  intro h
  have h2 := h 2
  linarith [first_nonzero_goldbach_hankel_minor_neg]

end
end BuildingBlocks.GoldbachScrewMinorFinite

#print axioms BuildingBlocks.GoldbachScrewMinorFinite.screwKernel_diagonal
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.screwKernel_dyadic_cross
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.dyadic_minor_determinant
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.dyadic_screw_inequality
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.hOne_dyadic_finite_consumer
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.finite_moment_minor_nonnegative
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.goldbach_prefix_dyadic_translation
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.prime_goldbach_four
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.prime_goldbach_five
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.prime_goldbach_six
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.first_nonzero_goldbach_hankel_minor_neg
#print axioms BuildingBlocks.GoldbachScrewMinorFinite.raw_goldbach_not_hankel_positive
