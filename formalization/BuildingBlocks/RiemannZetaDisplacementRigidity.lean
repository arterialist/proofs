/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
import BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
import BuildingBlocks.RiemannZetaRealImaginaryDisparity

/-!
# Module 317: Riemann Zeta Displacement Rigidity and Slope-Invariant Exactness

This module formalizes the exact algebraic rigidity and slope-invariance of the completed
Riemann zeta function $\Lambda_0(s)$ at any putative off-line zero in the upper half-plane.

## Mathematical Architecture

1. **The Exact Slope-Invariant Identity**:
   - `completedRiemannZeta₀_exact_slope_invariant`: Proves that for any zero of $\zeta(s)$
     with $\sigma > 1/2$ and $t > 0$,
     $$\operatorname{Re}(\Lambda_0(s)) - \frac{t}{2\sigma - 1}\operatorname{Im}(\Lambda_0(s)) =
       \frac{\sigma(1 - \sigma)}{|s(s-1)|^2}.$$
     Notice that the leading $t^2$ terms cancel identically, leaving only the coordinate
     weight $\sigma(1 - \sigma) \le 1/4$.

2. **The Disparity Numerator Factorization**:
   - `disparity_numerator_identity`: Proves the algebraic identity
     $$t^2 - \sigma(\sigma-1) - t(2\sigma-1)t = (1-\sigma)(2t^2 + \sigma).$$
   - `completedRiemannZeta₀_re_sub_mul_im_eq`: Proves the exact completed zeta disparity
     $$\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s)) =
       \frac{(1-\sigma)(2t^2 + \sigma)}{|s(s-1)|^2}.$$

3. **Master Displacement Identity**:
   - `completedRiemannZeta₀_displacement_identity`: Expresses the disparity in terms of the
     critical displacement $d = \sigma - 1/2 > 0$:
     $$(2d)\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s)) =
       \frac{2d(1/4 - d^2)}{|s(s-1)|^2}.$$

4. **Strict Positivity of Displacement Residual**:
   - `displacement_residual_pos`: For any $d \in (0, 1/2)$ and $t > 0$,
     $$\frac{2d(1/4 - d^2)}{|s(s-1)|^2} > 0.$$
   - `displacement_lhs_pos_of_zero`: Consequently, at every interior off-line zero,
     $$t \operatorname{Im}(\Lambda_0(s)) < (2d)\operatorname{Re}(\Lambda_0(s)).$$

5. **Displacement Rigidity Refutation**:
   - `refute_zero_of_displacement_le`: Any candidate zero with displacement $d \in (0, 1/2)$
     satisfying $(2d)\operatorname{Re}(\Lambda_0(s)) \le t \operatorname{Im}(\Lambda_0(s))$
     is refuted constructively, yielding $\zeta(s) \ne 0$.

All declarations depend strictly on standard Lean 4 foundational axioms:
`[propext, Classical.choice, Quot.sound]`. Zero `sorry` placeholders.
-/

open Complex Real
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
open BuildingBlocks.RiemannZetaRealImaginaryDisparity

namespace BuildingBlocks.RiemannZetaDisplacementRigidity

noncomputable section

/-! ### Section 1: Exact Slope-Invariant Identity -/

/-- The exact completed zeta slope-invariant identity:
For any zero of $\zeta(s)$ with $1/2 < \sigma$ and $t > 0$,
$$\operatorname{Re}(\Lambda_0(s)) - \frac{t}{2\sigma - 1} \operatorname{Im}(\Lambda_0(s)) =
  \frac{\sigma(1 - \sigma)}{|s(s-1)|^2}.$$ -/
theorem completedRiemannZeta₀_exact_slope_invariant {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).re - (s.im / (2 * s.re - 1)) * (completedRiemannZeta₀ s).im =
      (s.re * (1 - s.re)) / normSq (s * (s - 1)) := by
  rw [completedRiemannZeta₀_re_of_zero hsr hsim hz]
  rw [completedRiemannZeta₀_im_of_zero hsr hsim hz]
  have h_sub : (s.im / (2 * s.re - 1)) * (((2 * s.re - 1) * s.im) / normSq (s * (s - 1))) =
      (s.im ^ 2) / normSq (s * (s - 1)) := by
    have h_ne : 2 * s.re - 1 ≠ 0 := by linarith
    have : (s.im / (2 * s.re - 1)) * (((2 * s.re - 1) * s.im) / normSq (s * (s - 1))) =
        ((s.im * ((2 * s.re - 1) * s.im)) / (2 * s.re - 1)) / normSq (s * (s - 1)) := by ring
    rw [this]
    have h_cancel : (s.im * ((2 * s.re - 1) * s.im)) / (2 * s.re - 1) = s.im ^ 2 := by
      calc (s.im * ((2 * s.re - 1) * s.im)) / (2 * s.re - 1)
        _ = (s.im ^ 2 * (2 * s.re - 1)) / (2 * s.re - 1) := by ring_nf
        _ = s.im ^ 2 := mul_div_cancel_right₀ (s.im ^ 2) h_ne
    rw [h_cancel]
  rw [h_sub]
  have h_diff : (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1)) -
      (s.im ^ 2) / normSq (s * (s - 1)) =
      (s.re * (1 - s.re)) / normSq (s * (s - 1)) := by ring
  exact h_diff

/-! ### Section 2: Disparity Numerator Factorization -/

/-- Algebraic identity for the disparity numerator:
$t^2 - \sigma(\sigma-1) - t(2\sigma-1)t = (1-\sigma)(2t^2 + \sigma)$. -/
lemma disparity_numerator_identity (σ t : ℝ) :
    t ^ 2 - σ * (σ - 1) - t * ((2 * σ - 1) * t) = (1 - σ) * (2 * t ^ 2 + σ) := by
  ring

/-- The exact completed zeta disparity identity:
$\operatorname{Re}(\Lambda_0(s)) - t \cdot \operatorname{Im}(\Lambda_0(s)) =
  \frac{(1 - \sigma)(2t^2 + \sigma)}{|s(s-1)|^2}$. -/
theorem completedRiemannZeta₀_re_sub_mul_im_eq {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).re - s.im * (completedRiemannZeta₀ s).im =
      (1 - s.re) * (2 * s.im ^ 2 + s.re) / normSq (s * (s - 1)) := by
  rw [completedRiemannZeta₀_re_of_zero hsr hsim hz]
  rw [completedRiemannZeta₀_im_of_zero hsr hsim hz]
  have h_sub : (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1)) -
      s.im * (((2 * s.re - 1) * s.im) / normSq (s * (s - 1))) =
      (s.im ^ 2 - s.re * (s.re - 1) - s.im * ((2 * s.re - 1) * s.im)) / normSq (s * (s - 1)) := by
    ring
  rw [h_sub]
  rw [disparity_numerator_identity s.re s.im]

/-! ### Section 3: Master Displacement Identity -/

/-- Master Displacement Identity:
For any zero with displacement $d = \sigma - 1/2 > 0$ and $t > 0$,
$$(2d) \operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s)) =
  \frac{2d(1/4 - d^2)}{|s(s-1)|^2}.$$ -/
theorem completedRiemannZeta₀_displacement_identity {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    let d := s.re - 1 / 2
    (2 * d) * (completedRiemannZeta₀ s).re - s.im * (completedRiemannZeta₀ s).im =
      (2 * d * (1 / 4 - d ^ 2)) / normSq (s * (s - 1)) := by
  intro d
  rw [completedRiemannZeta₀_re_of_zero hsr hsim hz]
  rw [completedRiemannZeta₀_im_of_zero hsr hsim hz]
  have hd_eq : 2 * s.re - 1 = 2 * d := by
    dsimp [d]
    ring
  have h_lhs : (2 * d) * ((s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1))) -
      s.im * (((2 * s.re - 1) * s.im) / normSq (s * (s - 1))) =
      ((2 * d) * (s.im ^ 2 - s.re * (s.re - 1)) - s.im * ((2 * s.re - 1) * s.im)) / normSq (s * (s - 1)) := by
    ring
  rw [h_lhs]
  have h_num : (2 * d) * (s.im ^ 2 - s.re * (s.re - 1)) - s.im * ((2 * s.re - 1) * s.im) =
      2 * d * (1 / 4 - d ^ 2) := by
    rw [hd_eq]
    ring_nf
    have : s.re = d + 1 / 2 := by
      dsimp [d]
      ring
    rw [this]
    ring
  rw [h_num]

/-! ### Section 4: Strict Positivity and Rigidity Refutation -/

/-- The displacement residual is strictly positive for any interior displacement $d \in (0, 1/2)$. -/
theorem displacement_residual_pos {s : ℂ}
    (hd_pos : 0 < s.re - 1 / 2) (hd_lt : s.re - 1 / 2 < 1 / 2) (hsim : 0 < s.im) :
    let d := s.re - 1 / 2
    0 < (2 * d * (1 / 4 - d ^ 2)) / normSq (s * (s - 1)) := by
  have hsr : 1 / 2 < s.re := by linarith
  have hd_sq : (s.re - 1 / 2) ^ 2 < (1 / 2 : ℝ) ^ 2 := by
    have h1 : 0 ≤ s.re - 1 / 2 := le_of_lt hd_pos
    nlinarith
  have h_diff : 0 < 1 / 4 - (s.re - 1 / 2) ^ 2 := by
    have : (1 / 2 : ℝ) ^ 2 = (1 / 4 : ℝ) := by norm_num
    linarith
  have h2d : 0 < 2 * (s.re - 1 / 2) := by linarith
  have h_num : 0 < 2 * (s.re - 1 / 2) * (1 / 4 - (s.re - 1 / 2) ^ 2) := mul_pos h2d h_diff
  have hmul : s * (s - 1) ≠ 0 := mul_sub_one_ne_zero hsr hsim
  have hden : 0 < normSq (s * (s - 1)) := normSq_pos.mpr hmul
  exact div_pos h_num hden

/-- Strict inequality between the imaginary and real terms at any interior off-line zero:
$$t \operatorname{Im}(\Lambda_0(s)) < (2d)\operatorname{Re}(\Lambda_0(s)).$$ -/
theorem displacement_lhs_pos_of_zero {s : ℂ}
    (hd_pos : 0 < s.re - 1 / 2) (hd_lt : s.re - 1 / 2 < 1 / 2) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    let d := s.re - 1 / 2
    s.im * (completedRiemannZeta₀ s).im < (2 * d) * (completedRiemannZeta₀ s).re := by
  have hsr : 1 / 2 < s.re := by linarith
  have h_id := completedRiemannZeta₀_displacement_identity hsr hsim hz
  have h_pos := displacement_residual_pos hd_pos hd_lt hsim
  change (2 * (s.re - 1 / 2)) * (completedRiemannZeta₀ s).re - s.im * (completedRiemannZeta₀ s).im = _ at h_id
  change 0 < _ at h_pos
  linarith

/-- Displacement Rigidity Refutation:
Any candidate zero in the critical strip interior with $d \in (0, 1/2)$ that satisfies
$(2d)\operatorname{Re}(\Lambda_0(s)) \le t \operatorname{Im}(\Lambda_0(s))$ cannot be a zero of $\zeta(s)$. -/
theorem refute_zero_of_displacement_le {s : ℂ}
    (hd_pos : 0 < s.re - 1 / 2) (hd_lt : s.re - 1 / 2 < 1 / 2) (hsim : 0 < s.im)
    (h_le : (2 * (s.re - 1 / 2)) * (completedRiemannZeta₀ s).re ≤ s.im * (completedRiemannZeta₀ s).im) :
    riemannZeta s ≠ 0 := by
  intro hz
  have h_gt := displacement_lhs_pos_of_zero hd_pos hd_lt hsim hz
  change s.im * (completedRiemannZeta₀ s).im < (2 * (s.re - 1 / 2)) * (completedRiemannZeta₀ s).re at h_gt
  linarith

end

end BuildingBlocks.RiemannZetaDisplacementRigidity

#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.completedRiemannZeta₀_exact_slope_invariant
#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.disparity_numerator_identity
#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.completedRiemannZeta₀_re_sub_mul_im_eq
#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.completedRiemannZeta₀_displacement_identity
#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.displacement_residual_pos
#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.displacement_lhs_pos_of_zero
#print axioms BuildingBlocks.RiemannZetaDisplacementRigidity.refute_zero_of_displacement_le
