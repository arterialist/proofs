import Mathlib.Tactic

namespace PaidThetaCompensation

/-!
Finite two-block algebra for the constrained coherent port certificate.
Analytic matrix entries, spectral floors, and tail norms are explicit inputs.
-/

/-- A low port ratio `r`, tail ratio `beta`, and the normalized Cauchy mixed
bound imply the coefficient-one comparison when `r + beta ≤ 1`. -/
theorem low_tail_sum_certificate
    {aLow aTail pLow pTail mixed total r beta : ℝ}
    (haLow : 0 ≤ aLow) (haTail : 0 ≤ aTail)
    (hpLow : pLow ≤ r * aLow)
    (hpTail : pTail ≤ beta * aTail)
    (hmixed : 2 * mixed ≤ beta * aLow + r * aTail)
    (htotal : total = pLow + pTail + 2 * mixed)
    (hrb : r + beta ≤ 1) :
    total ≤ aLow + aTail := by
  rw [htotal]
  have hsum : total ≤ (r + beta) * (aLow + aTail) := by
    rw [htotal]
    nlinarith
  have hscale : (r + beta) * (aLow + aTail) ≤ aLow + aTail := by
    have hn : 0 ≤ aLow + aTail := add_nonneg haLow haTail
    nlinarith
  linarith

/-- Sharper Schur-margin certificate with an independently bounded mixed
block. -/
theorem schur_margin_certificate
    {lowSq tailSq total m t d : ℝ}
    (hlow : 0 ≤ lowSq) (htail : 0 ≤ tailSq)
    (hm : 0 ≤ m) (ht : 0 ≤ t) (hd : 0 ≤ d)
    (hdet : d^2 ≤ m * t)
    (htotal : total ≥ m * lowSq + t * tailSq -
      2 * d * Real.sqrt lowSq * Real.sqrt tailSq) :
    0 ≤ total := by
  have hsL : 0 ≤ Real.sqrt lowSq := Real.sqrt_nonneg _
  have hsT : 0 ≤ Real.sqrt tailSq := Real.sqrt_nonneg _
  have hsL2 : (Real.sqrt lowSq)^2 = lowSq := Real.sq_sqrt hlow
  have hsT2 : (Real.sqrt tailSq)^2 = tailSq := Real.sq_sqrt htail
  by_cases hm0 : m = 0
  · have hd0 : d = 0 := by nlinarith
    rw [hm0, hd0] at htotal
    nlinarith
  · have hmpos : 0 < m := lt_of_le_of_ne hm (Ne.symm hm0)
    let X := Real.sqrt lowSq
    let Y := Real.sqrt tailSq
    have hid :
        m * (m * X^2 + t * Y^2 - 2 * d * X * Y) =
          (m * X - d * Y)^2 + (m * t - d^2) * Y^2 := by ring
    have hrhs : 0 ≤ (m * X - d * Y)^2 + (m * t - d^2) * Y^2 := by
      have hmt : 0 ≤ m * t - d^2 := by linarith
      positivity
    have hquad : 0 ≤ m * X^2 + t * Y^2 - 2 * d * X * Y := by
      nlinarith [hid, hrhs]
    dsimp [X, Y] at hquad
    rw [hsL2, hsT2] at hquad
    linarith

/-- Interval enclosures for a generalized Rayleigh quotient: an upper port
quadratic and positive lower supply quadratic bound the exact quotient. -/
theorem generalized_quotient_interval
    {port supply portHi supplyLo : ℝ}
    (hsupply : supplyLo ≤ supply) (hpositive : 0 < supplyLo)
    (hport0 : 0 ≤ port) (hport : port ≤ portHi) :
    port / supply ≤ portHi / supplyLo := by
  have hspos : 0 < supply := lt_of_lt_of_le hpositive hsupply
  have hp : 0 ≤ portHi := le_trans hport0 hport
  calc
    port / supply ≤ portHi / supply := div_le_div_of_nonneg_right hport hspos.le
    _ ≤ portHi / supplyLo := div_le_div_of_nonneg_left hp hpositive hsupply

/-- A global port ceiling and a complement spectral floor yield a tail
Rayleigh bound. -/
theorem spectral_floor_tail_ratio
    {port supply normSq P lambda alpha beta : ℝ}
    (hnorm : 0 ≤ normSq) (hgap : 0 < lambda - alpha)
    (hport : port ≤ P * normSq)
    (hsupply : (lambda - alpha) * normSq ≤ supply)
    (hbeta : P / (lambda - alpha) ≤ beta)
    (hP : 0 ≤ P) :
    port ≤ beta * supply := by
  have hfirst : port ≤ (P / (lambda - alpha)) * supply := by
    calc
      port ≤ P * normSq := hport
      _ = (P / (lambda - alpha)) * ((lambda - alpha) * normSq) := by
        field_simp [hgap.ne']
      _ ≤ (P / (lambda - alpha)) * supply :=
        mul_le_mul_of_nonneg_left hsupply (div_nonneg hP hgap.le)
  have hsnonneg : 0 ≤ supply := le_trans (mul_nonneg hgap.le hnorm) hsupply
  exact le_trans hfirst (mul_le_mul_of_nonneg_right hbeta hsnonneg)

end PaidThetaCompensation
