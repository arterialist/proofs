import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaDisplacementRigidity
import BuildingBlocks.RiemannZetaHyperbolicDisparityKernel

/-!
# Module 319: RiemannZetaDisplacementAsymptotics

This module proves a pointwise $t^{-4}$ upper bound for the algebraic residual and derives
conditional zero tests. It does not prove a global sign for the displacement functional or an
unconditional zero-free region.

## Mathematical Overview

In Module 317 (`RiemannZetaDisplacementRigidity`), we proved that any candidate zero $s = \sigma + it$
in the upper quadrant ($1/2 < \sigma < 1$, $t > 0$) must satisfy the exact displacement identity:
$$(2d)\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s)) = R(d, s)$$
where $d = \sigma - 1/2 \in (0, 1/2)$ and the displacement residual is:
$$R(d, s) = \frac{2d(1/4 - d^2)}{|s(s-1)|^2} > 0.$$

In this module, we prove:
1. **Asymptotic $t^{-4}$ Decay of the Residual**:
   Since $|s(s-1)|^2 \ge t^4$, the residual is strictly bounded from above:
   $$R(d, s) \le \frac{d}{2 t^4}$$
   for all $0 \le d \le 1/2$ and $t > 0$.
2. **Uniform Height-Monotonic Bound**:
   For any threshold $t \ge t_0 > 0$:
   $$R(d, s) \le \frac{d}{2 t_0^4}.$$
3. **Displacement Functional**:
   We define $\mathcal{F}_{\text{disp}}(s) := 2(\sigma - 1/2)\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s))$.
   At any candidate zero $s$, $\mathcal{F}_{\text{disp}}(s) = R(d, s)$.
4. **Conditional zero tests**:
   - Refutation by lower bound: Any candidate with $\mathcal{F}_{\text{disp}}(s) \le 0$ is not a zero.
   - Refutation by upper decay: Any candidate with $\mathcal{F}_{\text{disp}}(s) > \frac{d}{2 t^4}$ is not a zero.
   - Refutation by exact residual mismatch: Any candidate with $\mathcal{F}_{\text{disp}}(s) \ne R(d, s)$ is not a zero.

   Each theorem requires the displayed sign, bound violation, or mismatch as an input. This file
   does not establish any of them for arbitrary points. For fixed $1/2 < \sigma < 1$, eventual
   positivity needs a separate estimate on the zeta contribution and does not imply global
   positivity. Numerical quadrature at $s=0.75+20i$, for example, gives approximately
   $-8.75470256\times 10^{-7}$ for the displacement diagnostic.

## Foundational Integrity

This module contains zero `sorry`s, zero non-standard axioms, and depends solely on Lean's
foundational core: `[propext, Classical.choice, Quot.sound]`.
-/

open Real Complex
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaDisplacementRigidity
open BuildingBlocks.RiemannZetaHyperbolicDisparityKernel

noncomputable section

namespace BuildingBlocks.RiemannZetaDisplacementAsymptotics

/-! ### Section 1: Algebraic Displacement Residual and Positivity -/

/-- The algebraic displacement residual $R(d, s)$:
$$R(d, s) = \frac{2d(1/4 - d^2)}{|s(s-1)|^2}.$$ -/
def displacementResidual (d : ℝ) (s : ℂ) : ℝ :=
  2 * d * (1 / 4 - d ^ 2) / normSq (s * (s - 1))

/-- Definitional equivalence with the displacement residual formulation in Module 317. -/
theorem displacementResidual_eq (s : ℂ) :
    displacementResidual (s.re - 1 / 2) s =
    2 * (s.re - 1 / 2) * (1 / 4 - (s.re - 1 / 2) ^ 2) / normSq (s * (s - 1)) := rfl

/-- For an off-line candidate with $0 < d < 1/2$, the displacement residual is strictly positive. -/
theorem displacementResidual_pos {d : ℝ} {s : ℂ} (hd_pos : 0 < d) (hd_lt : d < 1 / 2)
    (hs_ne : normSq (s * (s - 1)) ≠ 0) :
    0 < displacementResidual d s := by
  unfold displacementResidual
  have h_num : 0 < 2 * d * (1 / 4 - d ^ 2) := by
    have h1 : 0 < 2 * d := by linarith
    have h2 : 0 < 1 / 4 - d ^ 2 := by
      have hd_sq : d ^ 2 < (1 / 2 : ℝ) ^ 2 := sq_lt_sq.mpr (by
        rw [abs_of_pos hd_pos, abs_of_pos (by norm_num : (0 : ℝ) < 1 / 2)]
        exact hd_lt)
      have : (1 / 2 : ℝ) ^ 2 = 1 / 4 := by norm_num
      linarith
    exact mul_pos h1 h2
  have h_den_pos : 0 < normSq (s * (s - 1)) := lt_of_le_of_ne (normSq_nonneg _) hs_ne.symm
  exact div_pos h_num h_den_pos

/-! ### Section 2: Asymptotic $t^{-4}$ Decay of the Denominator -/

/-- High-frequency lower bound on the pole denominator:
Since $\operatorname{normSq}(s) \ge t^2$ and $\operatorname{normSq}(s-1) \ge t^2$, we have
$t^4 \le \operatorname{normSq}(s(s-1))$. -/
theorem normSq_mul_sub_one_ge_im_pow_four (s : ℂ) :
    s.im ^ 4 ≤ normSq (s * (s - 1)) := by
  rw [normSq_mul, normSq_apply, normSq_apply]
  have h1 : s.im ^ 2 ≤ s.re * s.re + s.im * s.im := by
    have : s.im * s.im = s.im ^ 2 := by ring
    rw [this]
    have : 0 ≤ s.re * s.re := mul_self_nonneg _
    linarith
  have h2 : s.im ^ 2 ≤ (s - 1).re * (s - 1).re + (s - 1).im * (s - 1).im := by
    have him : (s - 1).im = s.im := by simp
    rw [him]
    have : s.im * s.im = s.im ^ 2 := by ring
    rw [this]
    have : 0 ≤ (s - 1).re * (s - 1).re := mul_self_nonneg _
    linarith
  calc s.im ^ 4 = s.im ^ 2 * s.im ^ 2 := by ring
       _ ≤ (s.re * s.re + s.im * s.im) * ((s - 1).re * (s - 1).re + (s - 1).im * (s - 1).im) :=
         mul_le_mul h1 h2 (sq_nonneg _) (by
           have : 0 ≤ s.re * s.re := mul_self_nonneg _
           have : 0 ≤ s.im * s.im := mul_self_nonneg _
           linarith)

/-- Explicit upper bound on the displacement residual by $d / (2 t^4)$:
$R(d, s) \le \frac{d}{2 t^4}$ when $0 \le d \le 1/2$ and $t > 0$. -/
theorem displacementResidual_le_div_im_four {d : ℝ} {s : ℂ}
    (hd_nonneg : 0 ≤ d) (hd_le : d ≤ 1 / 2) (ht_pos : 0 < s.im) :
    displacementResidual d s ≤ d / (2 * s.im ^ 4) := by
  unfold displacementResidual
  have ht4_pos : 0 < s.im ^ 4 := by
    have : 0 < s.im ^ 2 := sq_pos_of_ne_zero (ne_of_gt ht_pos)
    have : 0 < (s.im ^ 2) ^ 2 := sq_pos_of_ne_zero (ne_of_gt this)
    have heq : s.im ^ 4 = (s.im ^ 2) ^ 2 := by ring
    rw [heq]
    exact this
  have h_den_ge : s.im ^ 4 ≤ normSq (s * (s - 1)) := normSq_mul_sub_one_ge_im_pow_four s
  have h_num_le : 2 * d * (1 / 4 - d ^ 2) ≤ d / 2 := by
    have h_factor : 1 / 4 - d ^ 2 ≤ 1 / 4 := by
      have : 0 ≤ d ^ 2 := sq_nonneg _
      linarith
    calc 2 * d * (1 / 4 - d ^ 2) ≤ 2 * d * (1 / 4) := mul_le_mul_of_nonneg_left h_factor (by linarith)
         _ = d / 2 := by ring
  have h_num_nonneg : 0 ≤ 2 * d * (1 / 4 - d ^ 2) := by
    have h1 : 0 ≤ 2 * d := by linarith
    have h2 : 0 ≤ 1 / 4 - d ^ 2 := by
      have hd_sq : d ^ 2 ≤ (1 / 2 : ℝ) ^ 2 := sq_le_sq.mpr (by
        rw [abs_of_nonneg hd_nonneg, abs_of_pos (by norm_num : (0 : ℝ) < 1 / 2)]
        exact hd_le)
      have : (1 / 2 : ℝ) ^ 2 = 1 / 4 := by norm_num
      linarith
    exact mul_nonneg h1 h2
  have h_d2_nonneg : 0 ≤ d / 2 := by linarith
  have h_div_le : 2 * d * (1 / 4 - d ^ 2) / normSq (s * (s - 1)) ≤
                  (d / 2) / (s.im ^ 4) := by
    exact div_le_div₀ h_d2_nonneg h_num_le ht4_pos h_den_ge
  calc 2 * d * (1 / 4 - d ^ 2) / normSq (s * (s - 1)) ≤ (d / 2) / (s.im ^ 4) := h_div_le
       _ = d / (2 * s.im ^ 4) := by ring

/-- Monotonic decay bound: for $t \ge t_0 > 0$, $R(d, s) \le \frac{d}{2 t_0^4}$. -/
theorem displacementResidual_le_of_im_ge {d : ℝ} {s : ℂ} {t₀ : ℝ}
    (hd_nonneg : 0 ≤ d) (hd_le : d ≤ 1 / 2) (ht₀_pos : 0 < t₀) (ht_ge : t₀ ≤ s.im) :
    displacementResidual d s ≤ d / (2 * t₀ ^ 4) := by
  have ht_pos : 0 < s.im := lt_of_lt_of_le ht₀_pos ht_ge
  have h1 := displacementResidual_le_div_im_four hd_nonneg hd_le ht_pos
  have ht4_le : t₀ ^ 4 ≤ s.im ^ 4 := by
    have ht2_le : t₀ ^ 2 ≤ s.im ^ 2 := sq_le_sq.mpr (by
      rw [abs_of_pos ht₀_pos, abs_of_pos ht_pos]
      exact ht_ge)
    have ht2_pos : 0 < t₀ ^ 2 := sq_pos_of_ne_zero (ne_of_gt ht₀_pos)
    have ht2_im_pos : 0 < s.im ^ 2 := sq_pos_of_ne_zero (ne_of_gt ht_pos)
    have : (t₀ ^ 2) ^ 2 ≤ (s.im ^ 2) ^ 2 := sq_le_sq.mpr (by
      rw [abs_of_pos ht2_pos, abs_of_pos ht2_im_pos]
      exact ht2_le)
    have heq1 : t₀ ^ 4 = (t₀ ^ 2) ^ 2 := by ring
    have heq2 : s.im ^ 4 = (s.im ^ 2) ^ 2 := by ring
    rw [heq1, heq2]
    exact this
  have h_den_le : 2 * t₀ ^ 4 ≤ 2 * s.im ^ 4 := by linarith
  have h_den_pos : 0 < 2 * t₀ ^ 4 := by
    have : 0 < t₀ ^ 4 := by
      have : 0 < t₀ ^ 2 := sq_pos_of_ne_zero (ne_of_gt ht₀_pos)
      have : 0 < (t₀ ^ 2) ^ 2 := sq_pos_of_ne_zero (ne_of_gt this)
      have heq : t₀ ^ 4 = (t₀ ^ 2) ^ 2 := by ring
      rw [heq]
      exact this
    linarith
  have h2 : d / (2 * s.im ^ 4) ≤ d / (2 * t₀ ^ 4) := by
    exact div_le_div_of_nonneg_left hd_nonneg h_den_pos h_den_le
  exact le_trans h1 h2

/-! ### Section 3: Displacement Functional and Candidate Zero Identities -/

/-- The displacement functional $\mathcal{F}_{\text{disp}}(s)$:
$$\mathcal{F}_{\text{disp}}(s) = 2(s.re - 1/2) \operatorname{Re}(\Lambda_0(s)) - s.im \operatorname{Im}(\Lambda_0(s)).$$ -/
def displacementFunctional (s : ℂ) : ℝ :=
  (2 * (s.re - 1 / 2)) * (completedRiemannZeta₀ s).re - s.im * (completedRiemannZeta₀ s).im

/-- At any candidate zero $s$ in the upper quadrant, the displacement functional equals
the displacement residual. -/
theorem displacementFunctional_eq_residual {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    displacementFunctional s = displacementResidual (s.re - 1 / 2) s := by
  unfold displacementFunctional displacementResidual
  exact completedRiemannZeta₀_displacement_identity hsr hsim hz

/-- At any candidate zero $s$ in the upper quadrant with $s.re < 1$, the displacement functional
is strictly positive. -/
theorem displacementFunctional_pos_of_zero {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_lt : s.re < 1) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    0 < displacementFunctional s := by
  rw [displacementFunctional_eq_residual hsr hsim hz]
  have hd_pos : 0 < s.re - 1 / 2 := by linarith
  have hd_lt : s.re - 1 / 2 < 1 / 2 := by linarith
  have hs_ne : normSq (s * (s - 1)) ≠ 0 := by
    have h1 : s ≠ 0 := by
      intro h
      have : s.im = 0 := by rw [h]; rfl
      linarith
    have h2 : s - 1 ≠ 0 := by
      intro h
      have : s.re = 1 := by
        have : (s - 1).re = 0 := by rw [h]; rfl
        simp at this
        linarith
      linarith
    intro h
    rw [normSq_eq_zero] at h
    have : s = 0 ∨ s - 1 = 0 := mul_eq_zero.mp h
    cases this with
    | inl h => exact h1 h
    | inr h => exact h2 h
  exact displacementResidual_pos hd_pos hd_lt hs_ne

/-- Asymptotic upper bound on the displacement functional at any candidate zero:
$\mathcal{F}_{\text{disp}}(s) \le \frac{s.re - 1/2}{2 t^4}$. -/
theorem displacementFunctional_le_decay {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_le : s.re ≤ 1) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    displacementFunctional s ≤ (s.re - 1 / 2) / (2 * s.im ^ 4) := by
  rw [displacementFunctional_eq_residual hsr hsim hz]
  have hd_nonneg : 0 ≤ s.re - 1 / 2 := by linarith
  have hd_le : s.re - 1 / 2 ≤ 1 / 2 := by linarith
  exact displacementResidual_le_div_im_four hd_nonneg hd_le hsim

/-! ### Section 4: Conditional zero tests -/

/-- Refutation by non-positivity:
If $\mathcal{F}_{\text{disp}}(s) \le 0$, then $s$ cannot be a zero with $1/2 < \sigma < 1$ and $t > 0$. -/
theorem refute_zero_of_displacementFunctional_nonpos {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_lt : s.re < 1) (hsim : 0 < s.im)
    (h_le : displacementFunctional s ≤ 0) :
    riemannZeta s ≠ 0 := by
  intro hz
  have h_pos := displacementFunctional_pos_of_zero hsr hsr_lt hsim hz
  linarith

/-- Refutation by high-frequency upper decay:
If $\mathcal{F}_{\text{disp}}(s) > \frac{s.re - 1/2}{2 t^4}$ with $1/2 < \sigma \le 1$ and $t > 0$,
then $s$ cannot be a zero of $\zeta(s)$. -/
theorem refute_zero_of_displacementFunctional_gt_decay {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_le : s.re ≤ 1) (hsim : 0 < s.im)
    (h_gt : (s.re - 1 / 2) / (2 * s.im ^ 4) < displacementFunctional s) :
    riemannZeta s ≠ 0 := by
  intro hz
  have h_decay := displacementFunctional_le_decay hsr hsr_le hsim hz
  linarith

/-- Refutation by exact residual mismatch:
If $\mathcal{F}_{\text{disp}}(s) \ne R(s.re - 1/2, s)$, then $s$ cannot be a zero of $\zeta(s)$. -/
theorem refute_zero_of_displacementFunctional_ne_residual {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im)
    (h_ne : displacementFunctional s ≠ displacementResidual (s.re - 1 / 2) s) :
    riemannZeta s ≠ 0 := by
  intro hz
  have h_eq := displacementFunctional_eq_residual hsr hsim hz
  exact h_ne h_eq

/-! ### Section 5: Axiom Verification -/

#print axioms displacementResidual_pos
#print axioms normSq_mul_sub_one_ge_im_pow_four
#print axioms displacementResidual_le_div_im_four
#print axioms displacementResidual_le_of_im_ge
#print axioms displacementFunctional_eq_residual
#print axioms displacementFunctional_pos_of_zero
#print axioms displacementFunctional_le_decay
#print axioms refute_zero_of_displacementFunctional_nonpos
#print axioms refute_zero_of_displacementFunctional_gt_decay
#print axioms refute_zero_of_displacementFunctional_ne_residual

end BuildingBlocks.RiemannZetaDisplacementAsymptotics
