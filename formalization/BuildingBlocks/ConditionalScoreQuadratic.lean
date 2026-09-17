import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.BilinearForm.Basic
import Mathlib.Tactic

/-! Scalar and bilinear-form algebra for the conditional-edge residual estimator.
The continuous and prime components share one score coefficient. These
theorems do not identify the edge integrals or bound their arithmetic size. -/
namespace BuildingBlocks.ConditionalScoreQuadratic
open LinearMap (BilinForm)

def energy (e b d s : ℝ) : ℝ := e - 2 * s * b + s ^ 2 * d

theorem completion (e b d s : ℝ) (hd : d ≠ 0) :
    energy e b d s = e - b ^ 2 / d + d * (s - b / d) ^ 2 := by
  unfold energy
  field_simp
  ring

theorem minimum (e b d s : ℝ) (hd : 0 < d) :
    e - b ^ 2 / d ≤ energy e b d s := by
  rw [completion e b d s hd.ne']
  have h := mul_nonneg hd.le (sq_nonneg (s - b / d))
  linarith

theorem attained (e b d : ℝ) (hd : d ≠ 0) :
    energy e b d (b / d) = e - b ^ 2 / d := by
  rw [completion e b d (b / d) hd]
  simp

theorem joint_completion (ec ep bc bp dc dp s : ℝ)
    (hd : dc + dp ≠ 0) :
    energy ec bc dc s + energy ep bp dp s =
      ec + ep - (bc + bp) ^ 2 / (dc + dp) +
        (dc + dp) * (s - (bc + bp) / (dc + dp)) ^ 2 := by
  have he : energy ec bc dc s + energy ep bp dp s =
      energy (ec + ep) (bc + bp) (dc + dp) s := by
    unfold energy
    ring
  rw [he, completion _ _ _ _ hd]

theorem joint_minimum (ec ep bc bp dc dp s : ℝ) (hd : 0 < dc + dp) :
    ec + ep - (bc + bp) ^ 2 / (dc + dp) ≤
      energy ec bc dc s + energy ep bp dp s := by
  rw [joint_completion ec ep bc bp dc dp s hd.ne']
  have h := mul_nonneg hd.le (sq_nonneg (s - (bc + bp) / (dc + dp)))
  linarith

theorem joint_attained (ec ep bc bp dc dp : ℝ) (hd : dc + dp ≠ 0) :
    energy ec bc dc ((bc + bp) / (dc + dp)) +
      energy ep bp dp ((bc + bp) / (dc + dp)) =
        ec + ep - (bc + bp) ^ 2 / (dc + dp) := by
  rw [joint_completion ec ep bc bp dc dp ((bc + bp) / (dc + dp)) hd]
  simp

theorem separate_penalty (ec ep bc bp dc dp : ℝ)
    (hc : dc ≠ 0) (hp : dp ≠ 0) (hd : dc + dp ≠ 0) :
    ec + ep - (bc + bp) ^ 2 / (dc + dp) =
      (ec - bc ^ 2 / dc) + (ep - bp ^ 2 / dp) +
        dc * dp / (dc + dp) * (bc / dc - bp / dp) ^ 2 := by
  field_simp
  ring

theorem separate_minimum_le_joint (ec ep bc bp dc dp : ℝ)
    (hc : 0 < dc) (hp : 0 < dp) :
    (ec - bc ^ 2 / dc) + (ep - bp ^ 2 / dp) ≤
      ec + ep - (bc + bp) ^ 2 / (dc + dp) := by
  have hd : 0 < dc + dp := add_pos hc hp
  rw [separate_penalty ec ep bc bp dc dp hc.ne' hp.ne' hd.ne']
  have h := mul_nonneg
    (div_nonneg (mul_nonneg hc.le hp.le) hd.le)
    (sq_nonneg (bc / dc - bp / dp))
  linarith

theorem zero_energy_pairing (e b : ℝ)
    (h : ∀ s : ℝ, 0 ≤ energy e b 0 s) : b = 0 := by
  by_contra hb
  have hs := h ((e + 1) / (2 * b))
  have he : energy e b 0 ((e + 1) / (2 * b)) = -1 := by
    unfold energy
    field_simp
    ring
  rw [he] at hs
  norm_num at hs

theorem zero_component (e s : ℝ) : energy e 0 0 s = e := by
  simp [energy]

section Forms
variable {V : Type*} [AddCommGroup V] [Module ℝ V]

theorem form_displacement (B : BilinForm ℝ V)
    (hs : ∀ x y, B x y = B y x) (v φ : V) (s : ℝ) :
    B (v - s • φ) (v - s • φ) = energy (B v v) (B v φ) (B φ φ) s := by
  simp only [LinearMap.BilinForm.sub_left, LinearMap.BilinForm.sub_right,
    LinearMap.BilinForm.smul_left, LinearMap.BilinForm.smul_right]
  rw [hs φ v]
  unfold energy
  ring

noncomputable def scoreResidual (B : BilinForm ℝ V) (φ : V) : BilinForm ℝ V :=
  LinearMap.mk₂ ℝ (fun x y => B x y - B x φ * B φ y / B φ φ)
    (by intro x z y; simp only [LinearMap.BilinForm.add_left]; ring)
    (by intro a x y; simp only [LinearMap.BilinForm.smul_left, smul_eq_mul]; ring)
    (by intro x y z; simp only [LinearMap.BilinForm.add_right]; ring)
    (by intro a x y; simp only [LinearMap.BilinForm.smul_right, smul_eq_mul]; ring)

theorem scoreResidual_nonnegative (B : BilinForm ℝ V)
    (hs : ∀ x y, B x y = B y x) (hpos : ∀ x, 0 ≤ B x x)
    (φ : V) (hd : 0 < B φ φ) (v : V) : 0 ≤ scoreResidual B φ v v := by
  have h := hpos (v - (B v φ / B φ φ) • φ)
  rw [form_displacement B hs, attained _ _ _ hd.ne'] at h
  change 0 ≤ B v v - B v φ * B φ v / B φ φ
  rw [hs φ v]
  simpa only [pow_two] using h

theorem scoreResidual_annihilates (B : BilinForm ℝ V) (φ v : V)
    (hd : B φ φ ≠ 0) : scoreResidual B φ φ v = 0 := by
  change B φ v - B φ φ * B φ v / B φ φ = 0
  field_simp
  ring

theorem form_zero_energy_pairing (B : BilinForm ℝ V)
    (hs : ∀ x y, B x y = B y x) (hpos : ∀ x, 0 ≤ B x x)
    (φ : V) (hd : B φ φ = 0) (v : V) : B v φ = 0 := by
  apply zero_energy_pairing (B v v) (B v φ)
  intro s
  have h := hpos (v - s • φ)
  rw [form_displacement B hs, hd] at h
  exact h

/-- The separate-score disagreement formula directly on a common real form domain. -/
theorem joint_form_penalty (Bc Bp : BilinForm ℝ V)
    (hsc : ∀ x y, Bc x y = Bc y x) (hsp : ∀ x y, Bp x y = Bp y x)
    (φ v : V) (hc : Bc φ φ ≠ 0) (hp : Bp φ φ ≠ 0)
    (hd : Bc φ φ + Bp φ φ ≠ 0) :
    scoreResidual (Bc + Bp) φ v v =
      scoreResidual Bc φ v v + scoreResidual Bp φ v v +
        Bc φ φ * Bp φ φ / (Bc φ φ + Bp φ φ) *
          (Bc v φ / Bc φ φ - Bp v φ / Bp φ φ) ^ 2 := by
  change (Bc v v + Bp v v) -
      (Bc v φ + Bp v φ) * (Bc φ v + Bp φ v) / (Bc φ φ + Bp φ φ) =
    (Bc v v - Bc v φ * Bc φ v / Bc φ φ) +
      (Bp v v - Bp v φ * Bp φ v / Bp φ φ) + _
  rw [hsc φ v, hsp φ v]
  simpa only [pow_two] using
    separate_penalty (Bc v v) (Bp v v) (Bc v φ) (Bp v φ) (Bc φ φ) (Bp φ φ) hc hp hd

end Forms

#print axioms completion
#print axioms minimum
#print axioms attained
#print axioms joint_completion
#print axioms joint_minimum
#print axioms joint_attained
#print axioms separate_penalty
#print axioms separate_minimum_le_joint
#print axioms zero_energy_pairing
#print axioms zero_component
#print axioms form_displacement
#print axioms scoreResidual
#print axioms scoreResidual_nonnegative
#print axioms scoreResidual_annihilates
#print axioms form_zero_energy_pairing
#print axioms joint_form_penalty

end BuildingBlocks.ConditionalScoreQuadratic
