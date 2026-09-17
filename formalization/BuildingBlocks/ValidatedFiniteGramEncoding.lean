import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Exact algebra consumed by the rational finite-Gram replay.  The analytic
theta entries and spectral floors remain explicit certificate inputs. -/

structure RatInterval where
  lo : ℚ
  hi : ℚ
  valid : lo ≤ hi

def RatInterval.Contains (i : RatInterval) (x : ℝ) : Prop :=
  (i.lo : ℝ) ≤ x ∧ x ≤ (i.hi : ℝ)

theorem RatInterval.add_contains {i j : RatInterval} {x y : ℝ}
    (hx : i.Contains x) (hy : j.Contains y) :
    ((⟨i.lo + j.lo, i.hi + j.hi, add_le_add i.valid j.valid⟩ : RatInterval).Contains
      (x + y)) := by
  constructor <;> norm_num [RatInterval.Contains] at hx hy ⊢ <;> linarith

/-- Exact rational upper bounds validate the coarse low-plus-tail test after
casting to reals. -/
theorem rational_coarse_accept
    {r beta : ℝ} {rHi betaHi : ℚ}
    (hr : r ≤ (rHi : ℝ)) (hb : beta ≤ (betaHi : ℝ))
    (haccept : rHi + betaHi ≤ 1) :
    r + beta ≤ 1 := by
  exact le_trans (add_le_add hr hb) (by exact_mod_cast haccept)

/-- Robust Schur test: rational upper endpoints may be used on all three
normalized blocks. -/
theorem rational_schur_accept
    {r beta delta : ℝ} {rHi betaHi deltaHi : ℚ}
    (hd0 : 0 ≤ delta)
    (hr : r ≤ (rHi : ℝ)) (hb : beta ≤ (betaHi : ℝ))
    (hd : delta ≤ (deltaHi : ℝ))
    (hrHi : rHi ≤ 1) (hbHi : betaHi ≤ 1)
    (hdet : deltaHi ^ 2 ≤ (1 - rHi) * (1 - betaHi)) :
    delta ^ 2 ≤ (1 - r) * (1 - beta) := by
  have hrHiR : (rHi : ℝ) ≤ 1 := by exact_mod_cast hrHi
  have hbHiR : (betaHi : ℝ) ≤ 1 := by exact_mod_cast hbHi
  have hdetR : (deltaHi : ℝ) ^ 2 ≤
      (1 - (rHi : ℝ)) * (1 - (betaHi : ℝ)) := by
    exact_mod_cast hdet
  have hdSq : delta ^ 2 ≤ (deltaHi : ℝ) ^ 2 := by nlinarith
  have hmargin :
      (1 - (rHi : ℝ)) * (1 - (betaHi : ℝ)) ≤
        (1 - r) * (1 - beta) := by nlinarith
  linarith

/-- The exact common constraint subtraction used before forming Gram
entries.  Apply this theorem once for each of the four real rows. -/
theorem exact_constraint_subtraction
    {V : Type*} [AddCommGroup V] [Module ℝ V]
    (L : V →ₗ[ℝ] ℝ) (h z : V)
    (hz : L z = 1) :
    L (h - (L h) • z) = 0 := by
  simp [map_sub, map_smul, hz]

end PaidThetaCompensation
