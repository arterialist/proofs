import Mathlib.Tactic

namespace PaidThetaCompensation

/-!
Exact finite algebra for a constrained core-to-port comparison.  The analytic
consumer supplies the finite-dimensional coordinate map and the two quadratic
forms.  No spectral or theta assertion is built into this module.
-/

/-- The constrained finite compression of a quadratic form. -/
def compressedForm {V W : Type*} (q : V → ℝ) (Z : W → V) (c : W) : ℝ :=
  q (Z c)

/-- Positivity of the compressed difference is exactly domination of the
compressed port form by the compressed core supply. -/
theorem compressed_difference_nonnegative_iff
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) :
    (∀ c, 0 ≤ compressedForm supply Z c - compressedForm port Z c) ↔
      (∀ c, compressedForm port Z c ≤ compressedForm supply Z c) := by
  simp [compressedForm, sub_nonneg]

/-- A single rigorously enclosed coordinate with port larger than supply is a
valid counterexample to the named finite compression. -/
theorem compressed_failure_witness
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) (c : W)
    (h : supply (Z c) < port (Z c)) :
    ¬ (∀ d, 0 ≤ compressedForm supply Z d - compressedForm port Z d) := by
  intro hall
  have hc := hall c
  simp only [compressedForm] at hc
  linarith

/-- With positive supply denominator, the generalized Rayleigh quotient is at
most one exactly when the port value is at most the supply value. -/
theorem generalizedRayleigh_le_one_iff
    {supply port : ℝ} (hs : 0 < supply) :
    port / supply ≤ 1 ↔ port ≤ supply := by
  constructor
  · intro h
    have hm := (div_le_iff₀ hs).mp h
    simpa using hm
  · intro h
    exact (div_le_iff₀ hs).2 (by simpa using h)

/-- A uniform generalized eigenvalue bound `lambda ≤ 1` pays the port form on
all constrained coordinates. -/
theorem generalizedEigenvalue_certificate
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) (lambda : ℝ)
    (hs : ∀ c, 0 ≤ supply (Z c))
    (hp : ∀ c, port (Z c) ≤ lambda * supply (Z c))
    (hlambda : lambda ≤ 1) :
    ∀ c, port (Z c) ≤ supply (Z c) := by
  intro c
  calc
    port (Z c) ≤ lambda * supply (Z c) := hp c
    _ ≤ 1 * supply (Z c) := mul_le_mul_of_nonneg_right hlambda (hs c)
    _ = supply (Z c) := one_mul _

/-- Interval-enclosure version: a certified upper enclosure of the port value
and lower enclosure of the supply value suffice coordinatewise. -/
theorem interval_coordinate_certificate
    {supply port supplyLo portHi : ℝ}
    (hs : supplyLo ≤ supply) (hp : port ≤ portHi) (hbox : portHi ≤ supplyLo) :
    port ≤ supply := by
  linarith

/-- Trial-plus-complement algebra.  `a` is the certified trial-block margin,
`d` the complement margin, and `b` an absolute mixed-block bound. -/
theorem trial_complement_young_certificate
    {trialSq tailSq total : ℝ} {a b d eps : ℝ}
    (ht : 0 ≤ trialSq) (hh : 0 ≤ tailSq)
    (heps : 0 < eps)
    (htotal : total ≥ a * trialSq + d * tailSq - 2 * b * Real.sqrt trialSq * Real.sqrt tailSq)
    (ha : 0 ≤ a - eps)
    (hd : 0 ≤ d - b^2 / eps) :
    0 ≤ total := by
  have hsqt : 0 ≤ Real.sqrt trialSq := Real.sqrt_nonneg _
  have hsqh : 0 ≤ Real.sqrt tailSq := Real.sqrt_nonneg _
  have ht_sq : (Real.sqrt trialSq)^2 = trialSq := by
    simpa [pow_two] using Real.sq_sqrt ht
  have hh_sq : (Real.sqrt tailSq)^2 = tailSq := by
    simpa [pow_two] using Real.sq_sqrt hh
  have hy : 2 * b * Real.sqrt trialSq * Real.sqrt tailSq ≤
      eps * trialSq + (b^2 / eps) * tailSq := by
    have hsqrteps : 0 < Real.sqrt eps := Real.sqrt_pos.2 heps
    have hsqrteps_ne : Real.sqrt eps ≠ 0 := ne_of_gt hsqrteps
    have heps_sq : (Real.sqrt eps)^2 = eps := by
      simpa [pow_two] using Real.sq_sqrt heps.le
    let X := Real.sqrt eps * Real.sqrt trialSq
    let Y := (b / Real.sqrt eps) * Real.sqrt tailSq
    have hyoung : 2 * X * Y ≤ X^2 + Y^2 := two_mul_le_add_sq X Y
    have hX : X^2 = eps * trialSq := by
      dsimp [X]
      nlinarith
    have hY : Y^2 = (b^2 / eps) * tailSq := by
      dsimp [Y]
      rw [mul_pow, div_pow, heps_sq, hh_sq]
    rw [hX, hY] at hyoung
    dsimp [X, Y] at hyoung
    field_simp [hsqrteps_ne] at hyoung ⊢
    nlinarith
  have hmain : total ≥ (a - eps) * trialSq + (d - b^2 / eps) * tailSq := by
    calc
      total ≥ a * trialSq + d * tailSq - 2 * b * Real.sqrt trialSq * Real.sqrt tailSq := htotal
      _ ≥ (a - eps) * trialSq + (d - b^2 / eps) * tailSq := by linarith
  have h1 : 0 ≤ (a - eps) * trialSq := mul_nonneg ha ht
  have h2 : 0 ≤ (d - b^2 / eps) * tailSq := mul_nonneg hd hh
  linarith

end PaidThetaCompensation
