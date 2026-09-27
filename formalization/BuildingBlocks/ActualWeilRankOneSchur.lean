import Mathlib.Tactic

/-!
Algebraic audit of the radius-one rank-one Schur argument.

The analytic facts about the actual Weil gamma multiplier, the five prime powers,
the explicit smooth pole-null carrier, and high-moment leakage are *hypotheses* here.
This file proves only their finite-dimensional scalar consequence. It does not
formalize those analytic estimates, global Weil positivity, or RH.
-/

namespace ActualWeilRankOneSchur

/-- The scalar consequence of the radius-one high-moment Fourier leakage
bound. `m` is low-frequency mass, `N` is total L² mass, and `qLow`, `qHigh`
are the two parts of the complete signed Weil form. The bounds on the
digamma/prime symbol and on `m` are named analytic hypotheses. -/
theorem conditional_highMoment_positive
    {N m qLow qHigh : ℝ}
    (hN : 0 ≤ N)
    (hLeak : m ≤ N / 1000000)
    (hLow : -(593 / 50 : ℝ) * m ≤ qLow)
    (hHigh : (3 / 25 : ℝ) * (N - m) ≤ qHigh) :
    N / 10 ≤ qLow + qHigh := by
  linarith

/-- The complete mixed arithmetic row below `exp 2` has five terms. The last
argument is the active `n = 7` mixed contribution, even when the `n = 7`
self-correlation of the chosen carrier vanishes. Each prime argument already
includes its logarithmic weight and both correlation orientations. -/
def fullMixedFivePrimeRow
    (gamma p2 p3 p4 p5 p7 : ℝ) : ℝ :=
  gamma - (p2 + p3 + p4 + p5 + p7)

theorem fullMixedFivePrimeRow_expanded
    (gamma p2 p3 p4 p5 p7 : ℝ) :
    fullMixedFivePrimeRow gamma p2 p3 p4 p5 p7 =
      gamma - p2 - p3 - p4 - p5 - p7 := by
  unfold fullMixedFivePrimeRow
  ring

/-- The high-band Cauchy estimate, followed by a sharp Young allocation.
Here `G` is the high-band carrier energy divided by the carrier's total
L² mass, `highV` is the high-band tail energy, and `crossHigh` already
includes the scalar multiplying the carrier. -/
theorem highCross_young
    {a G highV crossHigh : ℝ}
    (hG : 0 ≤ G) (hHighV : 0 ≤ highV)
    (hCauchy : crossHigh ^ 2 ≤ G * a ^ 2 * highV) :
    -(highV / 2 + 2 * G * a ^ 2) ≤ 2 * crossHigh := by
  have ha2 : 0 ≤ a ^ 2 := sq_nonneg a
  have hGa : 0 ≤ G * a ^ 2 := mul_nonneg hG ha2
  have hD : 0 ≤ highV / 2 + 2 * G * a ^ 2 := by positivity
  have hSquare := sq_nonneg (highV / 2 - 2 * G * a ^ 2)
  nlinarith

/-- Scalar hypotheses supplied by the separate analytic source proof.

`self` is the *actual* full five-prime carrier self-form. `lowV` and `highV`
are the tail form split at frequency 2500. `lowCross + highCross` is the
actual full mixed Weil form, whose arithmetic part is
`fullMixedFivePrimeRow gamma p2 p3 p4 p5 p7` with `p7` retained.
`a = |c|*||g||₂`, `b = ||v||₂`, and `G` is the normalized high-band
carrier energy in the application. -/
theorem conditional_rankOne_schur
    {a b self lowV highV lowCross highCross G : ℝ}
    (hSelf : (243 / 125 : ℝ) * a ^ 2 ≤ self)
    (hLowV : -(12 / 1000000 : ℝ) * b ^ 2 ≤ lowV)
    (hHighV : (3 / 25 : ℝ) * (1 - 1 / 1000000) * b ^ 2 ≤ highV)
    (hG0 : 0 ≤ G) (hG : G ≤ (1 / 1000000000000 : ℝ))
    (hLowCross : -(3 / 250 : ℝ) * a * b ≤ lowCross)
    (hHighCauchy : highCross ^ 2 ≤ G * a ^ 2 * highV) :
    (19 / 10 : ℝ) * a ^ 2 + (1 / 20 : ℝ) * b ^ 2 ≤
      self + lowV + highV + 2 * (lowCross + highCross) := by
  have hb2 : 0 ≤ b ^ 2 := sq_nonneg b
  have ha2 : 0 ≤ a ^ 2 := sq_nonneg a
  have hHighV0 : 0 ≤ highV := by nlinarith [hHighV]
  have hHighCross := highCross_young hG0 hHighV0 hHighCauchy
  have hGscaled : G * a ^ 2 ≤ (1 / 1000000000000 : ℝ) * a ^ 2 :=
    mul_le_mul_of_nonneg_right hG ha2
  have hYoung := sq_nonneg (a - (3 / 5 : ℝ) * b)
  nlinarith

/-- The same Schur bound stated with the actual complete mixed arithmetic
row. The `p7` argument cannot be omitted: it contains both `n = 7` mixed
orientations even though the chosen carrier's `n = 7` self term is zero. -/
theorem conditional_actual_five_prime_row_schur
    {a b self lowV highV lowCross highCross G gamma p2 p3 p4 p5 p7 : ℝ}
    (hSelf : (243 / 125 : ℝ) * a ^ 2 ≤ self)
    (hLowV : -(12 / 1000000 : ℝ) * b ^ 2 ≤ lowV)
    (hHighV : (3 / 25 : ℝ) * (1 - 1 / 1000000) * b ^ 2 ≤ highV)
    (hG0 : 0 ≤ G) (hG : G ≤ (1 / 1000000000000 : ℝ))
    (hLowCross : -(3 / 250 : ℝ) * a * b ≤ lowCross)
    (hHighCauchy : highCross ^ 2 ≤ G * a ^ 2 * highV)
    (hActualRow : lowCross + highCross =
      fullMixedFivePrimeRow gamma p2 p3 p4 p5 p7) :
    (19 / 10 : ℝ) * a ^ 2 + (1 / 20 : ℝ) * b ^ 2 ≤
      self + lowV + highV +
        2 * fullMixedFivePrimeRow gamma p2 p3 p4 p5 p7 := by
  rw [← hActualRow]
  exact conditional_rankOne_schur hSelf hLowV hHighV hG0 hG
    hLowCross hHighCauchy

/-- The norm comparison is just `||cg+v||² ≤ 2(||cg||²+||v||²)`.
The resulting `1/40` coercivity is conditional on the preceding analytic
estimates and applies only to the specified restricted test space. -/
theorem conditional_rankOne_norm_bound
    {a b q normF : ℝ}
    (hQ : (19 / 10 : ℝ) * a ^ 2 + (1 / 20 : ℝ) * b ^ 2 ≤ q)
    (hNorm : normF ^ 2 ≤ 2 * (a ^ 2 + b ^ 2)) :
    (1 / 40 : ℝ) * normF ^ 2 ≤ q := by
  nlinarith [sq_nonneg a]

end ActualWeilRankOneSchur

#print axioms ActualWeilRankOneSchur.conditional_highMoment_positive
#print axioms ActualWeilRankOneSchur.conditional_actual_five_prime_row_schur
#print axioms ActualWeilRankOneSchur.conditional_rankOne_norm_bound
