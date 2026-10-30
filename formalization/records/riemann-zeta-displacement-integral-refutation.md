# Displacement Mellin Integral Representation and Candidate Zero Refutation

**Module Path**: `formalization/BuildingBlocks/RiemannZetaDisplacementIntegralRefutation.lean`  
**Root Module**: `formalization/BuildingBlocks.lean`  
**Dependencies**:
- `BuildingBlocks.RiemannZetaGlobalSchwarzReflection`
- `BuildingBlocks.RiemannZetaTrigonometricDecomposition`
- `BuildingBlocks.RiemannZetaModularMellinInversion`
- `BuildingBlocks.RiemannZetaHyperbolicDisparityKernel`
- `BuildingBlocks.RiemannZetaDisplacementRigidity`
- `BuildingBlocks.RiemannZetaDisplacementAsymptotics`
- `BuildingBlocks.RiemannZetaSymmetrizedRepresentation`
- `BuildingBlocks.RightOfflineContradiction`
- `Mathlib.Analysis.Complex.Basic`
- `Mathlib.NumberTheory.LSeries.RiemannZeta`
- `Mathlib.NumberTheory.LSeries.Nonvanishing`

---

## 1. Mathematical and Formal Context

This module establishes the exact integral representation of the algebraic displacement functional $\mathcal{F}_{\text{disp}}(s)$ via the modular Mellin transform of the coupled hyperbolic disparity kernel $\mathcal{D}(s, x) f_{\text{modif}}(x)$, and proves the exact candidate zero refutation criteria and system equivalences.

### Key Architecture:

1. **Exact Bochner Integrability**:
   - `integrable_mellinTrigRe`: Integrability of the real Mellin integrand on $(1, \infty)$.
   - `integrable_mellinTrigIm`: Integrability of the imaginary Mellin integrand on $(1, \infty)$.
   - `integrable_disparityPointKernel_mul_f_modif`: Global Bochner integrability of the coupled disparity kernel $\mathcal{D}(s, x) f_{\text{modif}}(x)$ on $(1, \infty)$.

2. **Master Displacement Mellin Representation**:
   - `displacementFunctional_eq_half_integral`: Unconditionally proves that for all $s \in \mathbb{C}$,
     $$\mathcal{F}_{\text{disp}}(s) = \frac{1}{2} \int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) \, dx.$$

3. **Candidate Zero Displacement Identities**:
   - `displacement_integral_eq_residual_of_zero`: At any candidate zero $s$ with $\operatorname{Re}(s) > 1/2$ and $\operatorname{Im}(s) > 0$,
     $$\frac{1}{2} \int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) \, dx = \frac{2d(1/4 - d^2)}{|s(s-1)|^2} > 0.$$
   - `displacement_integral_pos_of_zero`: At any interior candidate zero ($1/2 < \operatorname{Re}(s) < 1$), the displacement integral is strictly positive.
   - `displacement_integral_le_decay_of_zero`: Proves the quartic decay bound $\le \frac{d}{2t^4}$ at candidate zeros.

4. **Constructive Zero Refutation Criteria & Obstruction Theorems**:
   - `refute_zero_of_integral_nonpos`: If $\frac{1}{2}\int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) \, dx \le 0$, then $\zeta(s) \ne 0$.
   - `refute_zero_of_integral_ne_residual`: If the integral differs from the algebraic residual $R(d, s)$, then $\zeta(s) \ne 0$.
   - `refute_zero_of_integral_gt_decay`: If the integral exceeds $\frac{d}{2t^4}$, then $\zeta(s) \ne 0$.
   - `not_displacement_integral_nonpos_of_zero`: Proves $\neg (\text{Integral} \le 0)$ at every candidate zero in the critical strip interior, ruling out non-positivity as an actual zero refuter.
   - `not_displacement_integral_ne_residual_of_zero`: Proves $\neg (\text{Integral} \ne R(d, s))$ at every candidate zero in the critical strip, demonstrating the algebraic exactness of the residual identity.

5. **Displacement Refutation Systems and Master RH Equivalence**:
   - `DisplacementIntegralRefutationSystem.toContradictionSystem`: Converts an integral nonpositivity certificate into a `HighFrequencyContradictionSystem`.
   - `DisplacementIntegralMismatchSystem.toContradictionSystem`: Converts an integral mismatch certificate into a `HighFrequencyContradictionSystem`.
   - `RiemannHypothesis_of_displacement_integral_system`: Proves `RiemannHypothesis` from a displacement integral system.
   - `RiemannHypothesis_of_displacement_mismatch_system`: Proves `RiemannHypothesis` from a displacement mismatch system.
   - `displacement_refutation_system_equivalence`: Proves that the existence of a high-frequency contradiction system is logically equivalent to `RiemannHypothesis`:
     $$\operatorname{Nonempty}(\text{HighFrequencyContradictionSystem}) \iff \text{RiemannHypothesis}.$$

---

## 2. Machine-Verified Theorems

All declarations have been machine-checked in Lean 4.34.1 with 0 `sorry`, 0 `sorryAx`, and strictly standard foundational axioms:

| Lean Theorem Name | Type / Statement | Axioms |
| :--- | :--- | :--- |
| `integrable_mellinTrigRe` | $\operatorname{IntegrableOn} (\text{mellinTrigIntegrandRe } s) (1, \infty)$ | `[propext, Classical.choice, Quot.sound]` |
| `integrable_mellinTrigIm` | $\operatorname{IntegrableOn} (\text{mellinTrigIntegrandIm } s) (1, \infty)$ | `[propext, Classical.choice, Quot.sound]` |
| `integrable_disparityPointKernel_mul_f_modif` | $\operatorname{IntegrableOn} (\mathcal{D}(s, \cdot) f_{\text{modif}}) (1, \infty)$ | `[propext, Classical.choice, Quot.sound]` |
| `displacementFunctional_eq_half_integral` | $\mathcal{F}_{\text{disp}}(s) = \frac{1}{2}\int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) dx$ | `[propext, Classical.choice, Quot.sound]` |
| `displacement_integral_eq_residual_of_zero` | $\zeta(s) = 0 \implies \frac{1}{2}\int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) dx = R(d, s)$ | `[propext, Classical.choice, Quot.sound]` |
| `displacement_integral_pos_of_zero` | $\zeta(s) = 0 \implies 0 < \frac{1}{2}\int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) dx$ | `[propext, Classical.choice, Quot.sound]` |
| `displacement_integral_le_decay_of_zero` | $\zeta(s) = 0 \implies \frac{1}{2}\int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) dx \le \frac{d}{2t^4}$ | `[propext, Classical.choice, Quot.sound]` |
| `refute_zero_of_integral_nonpos` | $\text{Integral} \le 0 \implies \zeta(s) \ne 0$ | `[propext, Classical.choice, Quot.sound]` |
| `refute_zero_of_integral_ne_residual` | $\text{Integral} \ne R(d, s) \implies \zeta(s) \ne 0$ | `[propext, Classical.choice, Quot.sound]` |
| `refute_zero_of_integral_gt_decay` | $\text{Integral} > \frac{d}{2t^4} \implies \zeta(s) \ne 0$ | `[propext, Classical.choice, Quot.sound]` |
| `not_displacement_integral_nonpos_of_zero` | $\zeta(s) = 0 \implies \neg (\text{Integral} \le 0)$ | `[propext, Classical.choice, Quot.sound]` |
| `not_displacement_integral_ne_residual_of_zero` | $\zeta(s) = 0 \implies \neg (\text{Integral} \ne R(d, s))$ | `[propext, Classical.choice, Quot.sound]` |
| `DisplacementIntegralRefutationSystem.toContradictionSystem` | $\text{DisplacementIntegralRefutationSystem} \implies \text{HighFrequencyContradictionSystem}$ | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_displacement_integral_system` | $\text{DisplacementIntegralRefutationSystem} \implies \text{RiemannHypothesis}$ | `[propext, Classical.choice, Quot.sound]` |
| `DisplacementIntegralMismatchSystem.toContradictionSystem` | $\text{DisplacementIntegralMismatchSystem} \implies \text{HighFrequencyContradictionSystem}$ | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_displacement_mismatch_system` | $\text{DisplacementIntegralMismatchSystem} \implies \text{RiemannHypothesis}$ | `[propext, Classical.choice, Quot.sound]` |
| `displacement_refutation_system_equivalence` | $\operatorname{Nonempty}(\text{System}) \iff \text{RH} \iff \text{HighFreqFree}$ | `[propext, Classical.choice, Quot.sound]` |

---

## 3. Axiom Verification Summary

```lean
#print axioms BuildingBlocks.RiemannZetaDisplacementIntegralRefutation.integrable_mellinTrigRe
-- [propext, Classical.choice, Quot.sound]

#print axioms BuildingBlocks.RiemannZetaDisplacementIntegralRefutation.displacementFunctional_eq_half_integral
-- [propext, Classical.choice, Quot.sound]

#print axioms BuildingBlocks.RiemannZetaDisplacementIntegralRefutation.displacement_integral_eq_residual_of_zero
-- [propext, Classical.choice, Quot.sound]

#print axioms BuildingBlocks.RiemannZetaDisplacementIntegralRefutation.refute_zero_of_integral_nonpos
-- [propext, Classical.choice, Quot.sound]

#print axioms BuildingBlocks.RiemannZetaDisplacementIntegralRefutation.refute_zero_of_integral_ne_residual
-- [propext, Classical.choice, Quot.sound]

#print axioms BuildingBlocks.RiemannZetaDisplacementIntegralRefutation.displacement_refutation_system_equivalence
-- [propext, Classical.choice, Quot.sound]
```
