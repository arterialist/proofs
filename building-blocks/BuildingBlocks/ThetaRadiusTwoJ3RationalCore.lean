import Mathlib.Tactic

namespace BuildingBlocks.ThetaRadiusTwoJ3RationalCore

open Finset

def eLower : ℚ := 2721 / 1001
def eUpper : ℚ := 1457 / 536

def eLowerSeries : ℚ :=
  ∑ k ∈ range 11, 1 / (k.factorial : ℚ)

def eUpperSeries : ℚ :=
  (∑ k ∈ range 10, 1 / (k.factorial : ℚ)) + 11 / (10 * (Nat.factorial 10 : ℚ))

def atanLower (q : ℚ) : ℚ :=
  q - q ^ 3 / 3 + q ^ 5 / 5 - q ^ 7 / 7

def atanUpper (q : ℚ) : ℚ :=
  atanLower q + q ^ 9 / 9

def piLower : ℚ := 16 * atanLower (1 / 5) - 4 * atanUpper (1 / 239)
def piUpper : ℚ := 16 * atanUpper (1 / 5) - 4 * atanLower (1 / 239)

def denominatorLower : ℚ :=
  (333 / 106) * (2 * (333 / 106) * eLower ^ 6 - 3)

/-- The lower exponential enclosure is below its finite positive series. -/
theorem e_lower_series_certificate : eLower < eLowerSeries := by
  norm_num [eLower, eLowerSeries, Nat.factorial]

/-- The finite series plus its geometric tail bound is below the chosen upper
enclosure. -/
theorem e_upper_series_certificate : eUpperSeries < eUpper := by
  norm_num [eUpperSeries, eUpper, Nat.factorial]

/-- Exact rational comparison supplied by the four/five-term Machin checker. -/
theorem machin_lower_certificate : (333 / 106 : ℚ) < piLower := by
  norm_num [piLower, atanLower, atanUpper]

/-- Exact rational comparison supplied by the four/five-term Machin checker. -/
theorem machin_upper_certificate : piUpper < (355 / 113 : ℚ) := by
  norm_num [piUpper, atanLower, atanUpper]

/-- The rational exponent bound used after inserting the upper enclosures for
`π` and `e`. -/
theorem rational_exponent_certificate :
    (355 / 113 : ℚ) * eUpper ^ 6 < 2535 / 2 := by
  norm_num [eUpper]

/-- Positivity of the retained lower denominator. -/
theorem denominatorLower_pos : 0 < denominatorLower := by
  norm_num [denominatorLower, eLower]

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
/-- The final exact rational comparison; clearing denominators is precisely the
large integer inequality checked by the companion script. -/
theorem final_power_certificate :
    eUpper ^ 2523 < denominatorLower ^ 2 * 10 ^ 1088 := by
  norm_num [eUpper, denominatorLower, eLower, pow_succ]

/-- Abstract propagation of the rational normalization enclosure into the
radius-two spectral gap. The analytic facts about `J` and `gap` remain explicit
hypotheses. -/
theorem normalization_bound_implies_gap
    {J gap : ℝ} (hJ : 0 < J) (hJupper : J < 10 ^ (544 : ℕ))
    (hgap : 143 / (5120 * J) < gap) :
    ((10 : ℝ) ^ (546 : ℕ))⁻¹ < gap := by
  have hden : 0 < 5120 * J := by positivity
  have hscale : ((10 : ℝ) ^ (546 : ℕ))⁻¹ < 143 / (5120 * J) := by
    apply (lt_div_iff₀ hden).2
    have hpow : (0 : ℝ) < 10 ^ (544 : ℕ) := by positivity
    have hinv : ((10 : ℝ) ^ (546 : ℕ))⁻¹ * (5120 * J) < 143 := by
      calc
        ((10 : ℝ) ^ (546 : ℕ))⁻¹ * (5120 * J) <
            ((10 : ℝ) ^ (546 : ℕ))⁻¹ * (5120 * 10 ^ (544 : ℕ)) := by
              gcongr
        _ = 1280 / 25 := by
          rw [show (546 : ℕ) = 544 + 2 by norm_num, pow_add]
          field_simp
          ring
        _ < 143 := by norm_num
    exact hinv
  exact hscale.trans hgap

/-- The proposed barrier amplitude clears the propagated tail-to-gap ratio by
an exact power-of-ten comparison. -/
theorem barrier_amplitude_certificate :
    (2 : ℝ) * ((10 : ℝ) ^ (47 : ℕ))⁻¹ /
        ((10 : ℝ) ^ (546 : ℕ))⁻¹ < (10 : ℝ) ^ (500 : ℕ) := by
  rw [show (546 : ℕ) = 47 + 499 by norm_num,
    show (500 : ℕ) = 1 + 499 by norm_num, pow_add, pow_add]
  field_simp
  nlinarith [show (0 : ℝ) < 10 ^ (499 : ℕ) by positivity]

#print axioms e_lower_series_certificate
#print axioms e_upper_series_certificate
#print axioms machin_lower_certificate
#print axioms machin_upper_certificate
#print axioms rational_exponent_certificate
#print axioms denominatorLower_pos
#print axioms final_power_certificate
#print axioms normalization_bound_implies_gap
#print axioms barrier_amplitude_certificate

end BuildingBlocks.ThetaRadiusTwoJ3RationalCore
