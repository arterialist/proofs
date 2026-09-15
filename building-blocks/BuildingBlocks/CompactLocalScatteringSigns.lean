import BuildingBlocks.ChargeFrozenFourier
import Mathlib.Data.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Data.Real.Sqrt
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/- Inputs for r39-compact-local-scattering-no-contraction.md.
   The compact-test limit is not formalized here. Agent3 supplied the finite-phase proofs; RH Proof supplied the original complex-power dictionary. -/
namespace BuildingBlocks.CompactLocalScatteringSigns

theorem attenuation {d : ℝ} (hd : 0 < d) (hd2 : d < 2) :
    Complex.normSq (1 - (d : ℂ)) < 1 := by
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.one_re,
    Complex.ofReal_re, Complex.sub_im, Complex.one_im, Complex.ofReal_im]
  nlinarith [mul_pos hd (show 0 < 2 - d by linarith)]

theorem amplification {d : ℂ} (hd : d.re < 0) :
    1 < Complex.normSq (1 - d) := by
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.one_re,
    Complex.sub_im, Complex.one_im]
  nlinarith [sq_nonneg d.re, sq_nonneg d.im]

theorem negative_tail_re {a : ℝ} (ha : 0 < a) {w : ℂ} (hw : 0 < w.re) :
    (-(a : ℂ) / w).re < 0 := by
  have hw0 : w ≠ 0 := by
    intro h
    simp [h] at hw
  have hn : 0 < Complex.normSq w := Complex.normSq_pos.mpr hw0
  simp only [Complex.div_re, Complex.neg_re, Complex.ofReal_re,
    Complex.neg_im, Complex.ofReal_im, neg_zero, zero_mul, zero_div, add_zero]
  exact div_neg_of_neg_of_pos (mul_neg_of_neg_of_pos (neg_neg_of_pos ha) hw) hn

theorem amplification_phase {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (M : ℕ) (theta : ℝ) :
    1 < Complex.normSq
      (1 - (-( ((1 - r ^ 2) * r ^ M : ℝ) : ℂ) /
        (1 - (r : ℂ) * (⟨Real.cos theta, Real.sin theta⟩ : ℂ)))) := by
  have ha : 0 < (1 - r ^ 2) * r ^ M := by
    apply mul_pos _ (pow_pos hr M)
    nlinarith
  apply amplification
  apply negative_tail_re ha
  simp only [Complex.sub_re, Complex.one_re, Complex.mul_re,
    Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero]
  have hc := Real.cos_le_one theta
  nlinarith

theorem attenuation_zero {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (hr2 : r ^ 2 ≤ 1 / 2) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (1 - (((1 + r) * r ^ M : ℝ) : ℂ)) < 1 := by
  apply attenuation (mul_pos (by linarith) (pow_pos hr M))
  obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : M ≠ 0)
  have hp : r ^ k ≤ 1 := pow_le_one₀ (le_of_lt hr) (le_of_lt hr1)
  have hb : r ^ (k + 1) ≤ r := by
    rw [pow_succ]
    nlinarith
  have hm : (1 + r) * r ^ (k + 1) ≤ (1 + r) * r :=
    mul_le_mul_of_nonneg_left hb (by linarith)
  change (1 + r) * r ^ (k + 1) < 2
  nlinarith

/-- Exact numerator identity for the unchanged finite history filter;
    x is r / q and y is r * q, hence x*y = r^2. -/
theorem finite_history_numerator (x y : ℂ) (M : ℕ) :
    (-y + (1 - x * y) * ∑ j ∈ Finset.range M, x ^ j) * (1 - x) =
      (1 - y) - (1 - x * y) * x ^ M := by
  have hg := geom_sum_mul_neg x M
  calc
    _ = -y * (1 - x) + (1 - x * y) *
        ((∑ j ∈ Finset.range M, x ^ j) * (1 - x)) := by ring
    _ = -y * (1 - x) + (1 - x * y) * (1 - x ^ M) := by rw [hg]
    _ = _ := by ring

theorem finite_history_factorization {x y : ℂ} (hx : 1 - x ≠ 0)
    (hy : 1 - y ≠ 0) (M : ℕ) :
    -y + (1 - x * y) * ∑ j ∈ Finset.range M, x ^ j =
      ((1 - y) / (1 - x)) * (1 - (1 - x * y) * x ^ M / (1 - y)) := by
  calc
    _ = ((1 - y) - (1 - x * y) * x ^ M) / (1 - x) :=
      (eq_div_iff hx).mpr (finite_history_numerator x y M)
    _ = _ := by field_simp

theorem reciprocal_sqrt_bounds {p : ℝ} (hp : 2 ≤ p) :
    0 < 1 / Real.sqrt p ∧ 1 / Real.sqrt p < 1 ∧
      (1 / Real.sqrt p) ^ 2 ≤ 1 / 2 := by
  have hp0 : 0 ≤ p := by linarith
  have hs : 0 < Real.sqrt p := Real.sqrt_pos.mpr (by linarith)
  have hss := Real.sq_sqrt hp0
  have hs1 : 1 < Real.sqrt p := by nlinarith
  have hr : 0 < 1 / Real.sqrt p := div_pos (by norm_num) hs
  have hr1 : 1 / Real.sqrt p < 1 := by
    apply (div_lt_iff₀ hs).mpr
    simpa using hs1
  have hh : (1 / Real.sqrt p) * Real.sqrt p = 1 :=
    div_mul_cancel₀ 1 (ne_of_gt hs)
  have he : (1 / Real.sqrt p) ^ 2 * p = 1 := by
    calc
      _ = (1 / Real.sqrt p) ^ 2 * (Real.sqrt p) ^ 2 := by rw [hss]
      _ = ((1 / Real.sqrt p) * Real.sqrt p) ^ 2 := by ring
      _ = 1 := by rw [hh]; norm_num
  have hc := mul_le_mul_of_nonneg_left hp (sq_nonneg (1 / Real.sqrt p))
  exact ⟨hr, hr1, by nlinarith⟩

theorem actual_prime_attenuation (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (1 -
      (((1 + 1 / Real.sqrt (p : ℝ)) * (1 / Real.sqrt (p : ℝ)) ^ M : ℝ) : ℂ)) < 1 := by
  have hb := reciprocal_sqrt_bounds (show (2 : ℝ) ≤ p by exact_mod_cast hp.two_le)
  exact attenuation_zero hb.1 hb.2.1 hb.2.2 hM

theorem scattering_phase_unit {r : ℝ} (hr : 0 < r) (hr1 : r < 1) (theta : ℝ) :
    Complex.normSq
      ((1 - (r : ℂ) * (⟨Real.cos theta, Real.sin theta⟩ : ℂ)) /
        (1 - (r : ℂ) * (⟨Real.cos theta, -Real.sin theta⟩ : ℂ))) = 1 := by
  let z : ℂ := 1 - (r : ℂ) * (⟨Real.cos theta, Real.sin theta⟩ : ℂ)
  have hzre : 0 < z.re := by
    simp only [z, Complex.sub_re, Complex.one_re, Complex.mul_re,
      Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero]
    nlinarith [Real.cos_le_one theta]
  have hz0 : z ≠ 0 := by intro h; simp [h] at hzre
  have he : (1 - (r : ℂ) * (⟨Real.cos theta, -Real.sin theta⟩ : ℂ)) =
      (starRingEnd ℂ) z := by
    apply Complex.ext <;> simp [z]
  change Complex.normSq (z / _) = 1
  rw [he, Complex.normSq_div, Complex.normSq_conj]
  exact div_self (ne_of_gt (Complex.normSq_pos.mpr hz0))

noncomputable def phase (theta : ℝ) : ℂ := ⟨Real.cos theta, Real.sin theta⟩

noncomputable def compactPhase (r theta : ℝ) (M : ℕ) : ℂ :=
  -(r : ℂ) * phase theta + (1 - (r : ℂ) ^ 2) *
    ∑ j ∈ Finset.range M, ((r : ℂ) * (starRingEnd ℂ) (phase theta)) ^ j

theorem phase_normSq (theta : ℝ) : Complex.normSq (phase theta) = 1 := by
  simp only [Complex.normSq_apply, phase]
  nlinarith [Real.sin_sq_add_cos_sq theta]

theorem phase_denominator_nonzero {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (theta : ℝ) : 1 - (r : ℂ) * phase theta ≠ 0 := by
  have h : 0 < (1 - (r : ℂ) * phase theta).re := by
    simp only [Complex.sub_re, Complex.one_re, Complex.mul_re, phase,
      Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero]
    nlinarith [Real.cos_le_one theta]
  intro he
  simp [he] at h

theorem compact_phase_factorization {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (theta : ℝ) (M : ℕ) :
    compactPhase r theta M =
      ((1 - (r : ℂ) * phase theta) /
        (1 - (r : ℂ) * (starRingEnd ℂ) (phase theta))) *
      (1 - (1 - (r : ℂ) ^ 2) *
        ((r : ℂ) * (starRingEnd ℂ) (phase theta)) ^ M /
        (1 - (r : ℂ) * phase theta)) := by
  have hxy : ((r : ℂ) * (starRingEnd ℂ) (phase theta)) *
      ((r : ℂ) * phase theta) = (r : ℂ) ^ 2 := by
    calc
      _ = (r : ℂ) ^ 2 * (phase theta * (starRingEnd ℂ) (phase theta)) := by ring
      _ = _ := by rw [Complex.mul_conj, phase_normSq]; simp
  have hx : 1 - (r : ℂ) * (starRingEnd ℂ) (phase theta) ≠ 0 := by
    have he : (starRingEnd ℂ) (phase theta) = phase (-theta) := by
      apply Complex.ext <;> simp [phase]
    rw [he]
    exact phase_denominator_nonzero hr hr1 (-theta)
  have h := finite_history_factorization hx (phase_denominator_nonzero hr hr1 theta) M
  rw [hxy] at h
  simpa only [compactPhase, neg_mul] using h

theorem phase_eq_exp (theta : ℝ) : phase theta = Complex.exp ((theta : ℂ) * Complex.I) := by
  apply Complex.ext <;> simp [phase, Complex.exp_mul_I,
    ← Complex.ofReal_cos, ← Complex.ofReal_sin]

theorem phase_special_power {M : ℕ} (hM : 1 ≤ M) :
    phase (Real.pi / (M : ℝ)) ^ M = -1 := by
  have hm : M ≠ 0 := by omega
  have hmc : (M : ℂ) ≠ 0 := by exact_mod_cast hm
  rw [phase_eq_exp, ← Complex.exp_nat_mul]
  have he : (M : ℂ) * (((Real.pi / (M : ℝ) : ℝ) : ℂ) * Complex.I) =
      (Real.pi : ℂ) * Complex.I := by
    push_cast
    field_simp
  rw [he]
  exact Complex.exp_pi_mul_I

theorem compact_zero_value {r : ℝ} (hr1 : r < 1) (M : ℕ) :
    compactPhase r 0 M = 1 - (((1 + r) * r ^ M : ℝ) : ℂ) := by
  have hx : 1 - (r : ℂ) ≠ 0 := by
    intro h
    have he := congrArg Complex.re h
    simp at he
    linarith
  apply mul_right_cancel₀ hx
  have hn := finite_history_numerator (r : ℂ) (r : ℂ) M
  have hz : phase 0 = 1 := by apply Complex.ext <;> simp [phase]
  calc
    compactPhase r 0 M * (1 - (r : ℂ)) =
        (1 - (r : ℂ)) - (1 - (r : ℂ) ^ 2) * (r : ℂ) ^ M := by
      simpa [compactPhase, hz, neg_mul, pow_two] using hn
    _ = (1 - (((1 + r) * r ^ M : ℝ) : ℂ)) * (1 - (r : ℂ)) := by
      push_cast
      ring

theorem compact_attenuation_zero {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (hr2 : r ^ 2 ≤ 1 / 2) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (compactPhase r 0 M) < 1 := by
  rw [compact_zero_value hr1]
  exact attenuation_zero hr hr1 hr2 hM

theorem compact_amplification_special {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    {M : ℕ} (hM : 1 ≤ M) :
    1 < Complex.normSq (compactPhase r (Real.pi / (M : ℝ)) M) := by
  let theta : ℝ := Real.pi / (M : ℝ)
  have hc : ((starRingEnd ℂ) (phase theta)) ^ M = -1 := by
    rw [← map_pow, phase_special_power hM]
    simp
  have he : (1 - (r : ℂ) ^ 2) *
      ((r : ℂ) * (starRingEnd ℂ) (phase theta)) ^ M =
      -(((1 - r ^ 2) * r ^ M : ℝ) : ℂ) := by
    rw [mul_pow, hc]
    push_cast
    ring
  have hu : Complex.normSq ((1 - (r : ℂ) * phase theta) /
      (1 - (r : ℂ) * (starRingEnd ℂ) (phase theta))) = 1 := by
    simpa [phase] using scattering_phase_unit hr hr1 theta
  change 1 < Complex.normSq (compactPhase r theta M)
  rw [compact_phase_factorization hr hr1, map_mul, hu, one_mul, he]
  exact amplification_phase hr hr1 M theta

theorem actual_prime_compact_signs (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (compactPhase (1 / Real.sqrt (p : ℝ)) 0 M) < 1 ∧
    1 < Complex.normSq
      (compactPhase (1 / Real.sqrt (p : ℝ)) (Real.pi / (M : ℝ)) M) := by
  have hb := reciprocal_sqrt_bounds (show (2 : ℝ) ≤ p by exact_mod_cast hp.two_le)
  exact ⟨compact_attenuation_zero hb.1 hb.2.1 hb.2.2 hM,
    compact_amplification_special hb.1 hb.2.1 hM⟩

#print axioms compact_zero_value
#print axioms compact_attenuation_zero
#print axioms compact_amplification_special
#print axioms actual_prime_compact_signs
#print axioms phase_eq_exp
#print axioms phase_special_power
#print axioms phase_normSq
#print axioms phase_denominator_nonzero
#print axioms compact_phase_factorization
#print axioms attenuation
#print axioms amplification
#print axioms negative_tail_re
#print axioms amplification_phase
#print axioms attenuation_zero
#print axioms finite_history_numerator
#print axioms finite_history_factorization
#print axioms reciprocal_sqrt_bounds
#print axioms actual_prime_attenuation
#print axioms scattering_phase_unit

theorem half_decay_exp {p : ℝ} (hp : 0 < p) :
    Complex.exp (-(1 / 2 : ℂ) * (Real.log p : ℂ)) =
      ((1 / Real.sqrt p : ℝ) : ℂ) := by
  have he : Real.exp (-(1 / 2 : ℝ) * Real.log p) = 1 / Real.sqrt p := by
    rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos hp]
    simp only [one_div]
    rw [← Real.exp_neg]
    congr 1
    ring
  rw [show -(1 / 2 : ℂ) * (Real.log p : ℂ) =
      ((-(1 / 2 : ℝ) * Real.log p : ℝ) : ℂ) by push_cast; ring,
    ← Complex.ofReal_exp, he]

theorem original_power_phase {p : ℝ} (hp : 0 < p) (t : ℝ) :
    (p : ℂ) ^ (Complex.I * (t : ℂ) - 1 / 2) =
      ((1 / Real.sqrt p : ℝ) : ℂ) * phase (t * Real.log p) := by
  rw [BuildingBlocks.ChargeFrozenFourier.real_cpow_eq_exp_log hp]
  rw [show (Complex.I * (t : ℂ) - 1 / 2) * (Real.log p : ℂ) =
      -(1 / 2 : ℂ) * (Real.log p : ℂ) +
        ((t * Real.log p : ℝ) : ℂ) * Complex.I by push_cast; ring,
    Complex.exp_add, half_decay_exp hp, phase_eq_exp]

noncomputable def originalCompact (p t : ℝ) (M : ℕ) : ℂ :=
  -(p : ℂ) ^ (Complex.I * (t : ℂ) - 1 / 2) +
    (1 - (p : ℂ)⁻¹) * ∑ j ∈ Finset.range M,
      (p : ℂ) ^ (-(j : ℂ) * (Complex.I * (t : ℂ) + 1 / 2))

theorem original_compact_eq_phase {p : ℝ} (hp : 0 < p) (t : ℝ) (M : ℕ) :
    originalCompact p t M = compactPhase (1 / Real.sqrt p) (t * Real.log p) M := by
  have hn : (p : ℂ) ^ (-Complex.I * (t : ℂ) - 1 / 2) =
      ((1 / Real.sqrt p : ℝ) : ℂ) * (starRingEnd ℂ) (phase (t * Real.log p)) := by
    have h := original_power_phase hp (-t)
    have hc : phase (-(t * Real.log p)) = (starRingEnd ℂ) (phase (t * Real.log p)) := by
      apply Complex.ext <;> simp [phase]
    simpa [neg_mul, hc] using h
  have hr : (((1 / Real.sqrt p : ℝ) : ℂ)) ^ 2 = (p : ℂ)⁻¹ := by
    have he : (1 / Real.sqrt p : ℝ) ^ 2 = p⁻¹ := by
      rw [div_pow, one_pow, Real.sq_sqrt hp.le]
      simp
    exact_mod_cast he
  unfold originalCompact compactPhase
  rw [original_power_phase hp, hr, neg_mul]
  congr 2
  apply Finset.sum_congr rfl
  intro j hj
  rw [show -(j : ℂ) * (Complex.I * (t : ℂ) + 1 / 2) =
      (j : ℂ) * (-Complex.I * (t : ℂ) - 1 / 2) by ring,
    Complex.cpow_nat_mul, hn]

theorem original_prime_compact_signs (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (originalCompact p 0 M) < 1 ∧
      1 < Complex.normSq
        (originalCompact p (Real.pi / ((M : ℝ) * Real.log (p : ℝ))) M) := by
  have hpos : 0 < (p : ℝ) := by exact_mod_cast hp.pos
  have hlog : Real.log (p : ℝ) ≠ 0 :=
    ne_of_gt (Real.log_pos (by exact_mod_cast hp.one_lt))
  have hfreq : (Real.pi / ((M : ℝ) * Real.log (p : ℝ))) * Real.log (p : ℝ) =
      Real.pi / (M : ℝ) := by
    field_simp
  rw [original_compact_eq_phase hpos, original_compact_eq_phase hpos, hfreq]
  simpa only [zero_mul] using actual_prime_compact_signs p hp hM

#print axioms original_prime_compact_signs
#print axioms half_decay_exp
#print axioms original_power_phase
#print axioms original_compact_eq_phase
end BuildingBlocks.CompactLocalScatteringSigns
