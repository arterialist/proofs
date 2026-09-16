import Mathlib.Tactic

/-!
# Elementary core of the compact-strip theta payment

The theta lower rate, Schur integral estimate, and resolvent estimate enter below as
named hypotheses. This file proves only the order/rational algebra which turns those
analytic inputs into the advertised coercivity and explicit constants.
-/

namespace BuildingBlocks.ThetaCompactStripRationalCore

noncomputable section

/-- The rational cutoff used after choosing an integer exponent. -/
def epsilonOf (B : ℕ) : ℝ := 1 / (2 * (3 : ℝ) ^ B)

lemma epsilonOf_pos (B : ℕ) : 0 < epsilonOf B := by
  unfold epsilonOf
  positivity

lemma half_div_epsilonOf (B : ℕ) : (1 / 2 : ℝ) / epsilonOf B = (3 : ℝ) ^ B := by
  rw [epsilonOf]
  field_simp

lemma log_half_div_epsilonOf (B : ℕ) :
    Real.log ((1 / 2 : ℝ) / epsilonOf B) =
      (B : ℝ) * Real.log 3 := by
  rw [half_div_epsilonOf, Real.log_pow]

lemma quarter_inv_epsilonOf (B : ℕ) :
    (1 : ℝ) / (4 * epsilonOf B) = (3 : ℝ) ^ B / 2 := by
  rw [epsilonOf]
  field_simp
  norm_num

/-- The order-theoretic compact-strip payment. `harrival` is the analytic
continuous-arrival estimate and `hstrip` is the compact-strip lower bound. -/
theorem compact_payment
    {L δ M strip arrival total w : ℝ}
    (hδ : 0 ≤ δ) (hwM : w ≤ M)
    (hstrip : -L ≤ strip)
    (hrate : L + δ * M < arrival)
    (hdecomp : total = strip + arrival) :
    δ * w < total := by
  have hδw : δ * w ≤ δ * M := mul_le_mul_of_nonneg_left hwM hδ
  rw [hdecomp]
  linarith

/-- A weak-rate version, useful when the analytic input is non-strict. -/
theorem compact_payment_le
    {L δ M strip arrival total w : ℝ}
    (hδ : 0 ≤ δ) (hwM : w ≤ M)
    (hstrip : -L ≤ strip)
    (hrate : L + δ * M ≤ arrival)
    (hdecomp : total = strip + arrival) :
    δ * w ≤ total := by
  have hδw : δ * w ≤ δ * M := mul_le_mul_of_nonneg_left hwM hδ
  rw [hdecomp]
  linarith

/-- The elementary Schur substitution. The estimate `C ≤ r/4` is the named
analytic Schur hypothesis; `r ≤ 1/ε` is the elementary kernel bound. -/
theorem schur_substitution
    {C r ε : ℝ}
    (hschur : C ≤ r / 4) (hr : r ≤ 1 / ε) :
    C ≤ 1 / (4 * ε) := by
  calc
    C ≤ r / 4 := hschur
    _ ≤ (1 / ε) / 4 := div_le_div_of_nonneg_right hr (by norm_num)
    _ = 1 / (4 * ε) := by ring

theorem schur_at_epsilonOf
    {C r : ℝ} {B : ℕ}
    (hschur : C ≤ r / 4) (hr : r ≤ 1 / epsilonOf B) :
    C ≤ (3 : ℝ) ^ B / 2 := by
  calc
    C ≤ 1 / (4 * epsilonOf B) := schur_substitution hschur hr
    _ = (3 : ℝ) ^ B / 2 := quarter_inv_epsilonOf B

/-- Pure resolvent algebra at the rational cutoff. `hresolvent` is the
operator estimate supplied by the analytic argument. -/
theorem resolvent_substitution
    {P C M δ : ℝ} {B : ℕ}
    (hM : 0 ≤ M) (hδ : 0 < δ)
    (hresolvent : P ≤ M * C / δ)
    (hC : C ≤ (3 : ℝ) ^ B / 2) :
    P ≤ M * ((3 : ℝ) ^ B / 2) / δ := by
  calc
    P ≤ M * C / δ := hresolvent
    _ ≤ M * ((3 : ℝ) ^ B / 2) / δ := by
      gcongr

/-- The constants from the note. The giant exponents remain symbolic. -/
opaque stripY : ℕ := 4 * 3 ^ 51640013
opaque stripH : ℕ := stripY + 12910003
opaque stripExponent : ℕ := stripH - 2

def cStar : ℝ := 1 / (3 : ℝ) ^ stripExponent
def deltaStar : ℝ := 1 / (8 * (10 : ℝ) ^ 546)
def stripL : ℝ := (10 : ℝ) ^ 503
def barrierM : ℝ := (10 : ℝ) ^ 500

def explicitB : ℕ := 5 * 10 ^ 503 * 3 ^ stripExponent
def epsilonStar : ℝ := epsilonOf explicitB

lemma explicitB_pos : 0 < explicitB := by
  unfold explicitB
  positivity

lemma epsilonStar_formula :
    epsilonStar = 1 / (2 * (3 : ℝ) ^ explicitB) := rfl

lemma cStar_pos : 0 < cStar := by
  unfold cStar
  positivity

lemma deltaStar_pos : 0 < deltaStar := by
  unfold deltaStar
  positivity

lemma deltaStar_mul_barrierM :
    deltaStar * barrierM = 1 / (8 * (10 : ℝ) ^ 46) := by
  unfold deltaStar barrierM
  rw [show (10 : ℝ) ^ 546 = (10 : ℝ) ^ 500 * (10 : ℝ) ^ 46 by
    rw [← pow_add]
    ]
  field_simp

lemma explicitB_cStar :
    (explicitB : ℝ) * cStar = 5 * (10 : ℝ) ^ 503 := by
  rw [explicitB, cStar, Nat.cast_mul, Nat.cast_mul, Nat.cast_pow]
  norm_num only [Nat.cast_ofNat]
  have h3 : (3 : ℝ) ^ stripExponent ≠ 0 := by positivity
  field_simp
  norm_cast

lemma explicit_payment_margin :
    stripL + deltaStar * barrierM <
      cStar * (explicitB : ℝ) / 4 := by
  rw [deltaStar_mul_barrierM]
  rw [show cStar * (explicitB : ℝ) = 5 * (10 : ℝ) ^ 503 by
    rw [mul_comm, explicitB_cStar]]
  unfold stripL
  have hpow : 1 ≤ (10 : ℝ) ^ 503 := one_le_pow₀ (by norm_num)
  have htiny : (1 : ℝ) / (8 * 10 ^ 46) < 1 / 4 := by norm_num
  have htiny' : (1 : ℝ) / (8 * 10 ^ 46) < (10 : ℝ) ^ 503 / 4 := by
    have : (1 : ℝ) / 4 ≤ (10 : ℝ) ^ 503 / 4 := by
      exact (div_le_div_iff_of_pos_right (by norm_num)).2 hpow
    exact lt_of_lt_of_le htiny this
  rw [show 5 * (10 : ℝ) ^ 503 / 4 =
      (10 : ℝ) ^ 503 + (10 : ℝ) ^ 503 / 4 by ring]
  exact add_lt_add_left htiny' _

/-- Direct explicit payment, with the theta logarithmic-rate evaluation kept as
an analytic named hypothesis. -/
theorem explicit_theta_payment
    {q : ℝ}
    (hthetaRate : cStar * (explicitB : ℝ) / 4 ≤ q) :
    stripL + deltaStar * barrierM < q := by
  exact lt_of_lt_of_le explicit_payment_margin hthetaRate

/-- The explicit `B_*` pays the full strip deficit once one supplies the
elementary transcendental comparison `1 < log 3`. -/
theorem explicit_logarithmic_payment
    (hlog3 : (1 : ℝ) < Real.log 3) :
    stripL + deltaStar * barrierM <
      cStar / 4 * Real.log ((1 / 2 : ℝ) / epsilonStar) := by
  rw [epsilonStar, log_half_div_epsilonOf]
  have hbase : 0 < cStar * (explicitB : ℝ) / 4 := by
    have hB : (0 : ℝ) < explicitB := by exact_mod_cast explicitB_pos
    exact div_pos (mul_pos cStar_pos hB) (by norm_num)
  calc
    stripL + deltaStar * barrierM < cStar * (explicitB : ℝ) / 4 :=
      explicit_payment_margin
    _ = (cStar * (explicitB : ℝ) / 4) * 1 := by ring
    _ < (cStar * (explicitB : ℝ) / 4) * Real.log 3 :=
      mul_lt_mul_of_pos_left hlog3 hbase
    _ = cStar / 4 * ((explicitB : ℝ) * Real.log 3) := by ring

/-- The final arrival payment. `hthetaRate` is exactly the analytic theta-rate
hypothesis at the rational cutoff `epsilonStar`. -/
theorem explicit_arrival_payment
    {q : ℝ}
    (hlog3 : (1 : ℝ) < Real.log 3)
    (hthetaRate :
      cStar / 4 * Real.log ((1 / 2 : ℝ) / epsilonStar) ≤ q) :
    stripL + deltaStar * barrierM < q :=
  lt_of_lt_of_le (explicit_logarithmic_payment hlog3) hthetaRate

/-- The exact coarse resolvent coefficient after substituting `M` and `δ_*`. -/
lemma explicit_resolvent_coefficient (B : ℕ) :
    barrierM * ((3 : ℝ) ^ B / 2) / deltaStar =
      4 * (10 : ℝ) ^ 1046 * (3 : ℝ) ^ B := by
  unfold barrierM deltaStar
  have h10 : (10 : ℝ) ^ 546 ≠ 0 := by positivity
  rw [show (10 : ℝ) ^ 1046 = (10 : ℝ) ^ 500 * (10 : ℝ) ^ 546 by
    rw [← pow_add]
    ]
  field_simp
  ring

theorem explicit_resolvent_bound
    {P C : ℝ} {B : ℕ}
    (hresolvent : P ≤ barrierM * C / deltaStar)
    (hC : C ≤ (3 : ℝ) ^ B / 2) :
    P ≤ 4 * (10 : ℝ) ^ 1046 * (3 : ℝ) ^ B := by
  have hM : 0 ≤ barrierM := by unfold barrierM; positivity
  have h := resolvent_substitution (P := P) (C := C) (M := barrierM)
    (δ := deltaStar) (B := B) hM deltaStar_pos hresolvent hC
  rw [explicit_resolvent_coefficient] at h
  exact h

/-! ## Rational checks used in the radius-two strip estimate -/

lemma theta_envelope_first_term_check :
    128 * 243 * 64 < (2 : ℕ) ^ 21 := by norm_num

lemma departure_constant_check : (4 : ℕ) * 3 * 3 * 16 = 576 := by norm_num

lemma theta_sum_check :
    2 * ((7 : ℚ) + 2 / 64) < 16 := by norm_num

lemma strip_scale_check :
    (577 : ℕ) * 10 ^ 500 < 10 ^ 503 := by
  calc
    (577 : ℕ) * 10 ^ 500 < 1000 * 10 ^ 500 := by gcongr <;> norm_num
    _ = 10 ^ 503 := by
      rw [show (1000 : ℕ) = 10 ^ 3 by norm_num, ← pow_add]

/-- Algebraic aggregation of the continuous, prime-power, and spectral losses.
The two generator estimates are explicit hypotheses. -/
theorem aggregate_strip_lower
    {M d0 w Dc Dp total : ℝ}
    (hM : 0 ≤ M) (hd0 : 0 ≤ d0) (hdhalf : d0 < 1 / 2)
    (hw0 : 0 ≤ w) (hwM : w ≤ M)
    (hcontinuous : -M / 2 ≤ Dc)
    (hprime : -576 * M < Dp)
    (hdecomp : total = Dc + Dp - (1 / 2 - d0) * w) :
    -577 * M < total := by
  have hspectral : -(1 / 2 - d0) * w ≥ -M / 2 := by
    have hcoef : 0 ≤ 1 / 2 - d0 := le_of_lt (sub_pos.mpr hdhalf)
    have hhalf : 1 / 2 - d0 ≤ (1 / 2 : ℝ) := by linarith
    have hmul : (1 / 2 - d0) * w ≤ (1 / 2 : ℝ) * M := by
      calc
        (1 / 2 - d0) * w ≤ (1 / 2 - d0) * M :=
          mul_le_mul_of_nonneg_left hwM hcoef
        _ ≤ (1 / 2 : ℝ) * M := mul_le_mul_of_nonneg_right hhalf hM
    linarith
  rw [hdecomp]
  linarith

/-- The final decimal strip bound once `M = 10^500`. -/
theorem explicit_strip_lower
    {d0 w Dc Dp total : ℝ}
    (hd0 : 0 ≤ d0) (hdhalf : d0 < 1 / 2)
    (hw0 : 0 ≤ w) (hwM : w ≤ barrierM)
    (hcontinuous : -barrierM / 2 ≤ Dc)
    (hprime : -576 * barrierM < Dp)
    (hdecomp : total = Dc + Dp - (1 / 2 - d0) * w) :
    -stripL < total := by
  have hcoarse := aggregate_strip_lower (M := barrierM) (d0 := d0)
    (w := w) (Dc := Dc) (Dp := Dp) (total := total)
    (by unfold barrierM; positivity) hd0 hdhalf hw0 hwM hcontinuous hprime hdecomp
  have hscale : (577 : ℝ) * barrierM < stripL := by
    unfold barrierM stripL
    calc
      (577 : ℝ) * 10 ^ 500 < 1000 * 10 ^ 500 := by
        exact mul_lt_mul_of_pos_right (by norm_num) (by positivity)
      _ = 10 ^ 503 := by
        rw [show (1000 : ℝ) = 10 ^ 3 by norm_num, ← pow_add]
  linarith

end
end BuildingBlocks.ThetaCompactStripRationalCore

#print axioms BuildingBlocks.ThetaCompactStripRationalCore.compact_payment
#print axioms BuildingBlocks.ThetaCompactStripRationalCore.schur_at_epsilonOf
#print axioms BuildingBlocks.ThetaCompactStripRationalCore.explicit_theta_payment
#print axioms BuildingBlocks.ThetaCompactStripRationalCore.explicit_arrival_payment
#print axioms BuildingBlocks.ThetaCompactStripRationalCore.explicit_resolvent_bound
#print axioms BuildingBlocks.ThetaCompactStripRationalCore.aggregate_strip_lower
#print axioms BuildingBlocks.ThetaCompactStripRationalCore.explicit_strip_lower
