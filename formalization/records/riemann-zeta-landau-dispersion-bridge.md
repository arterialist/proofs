# Riemann Zeta Landau Prime-Allocation Dispersion Bridge

**Module Path**: `formalization/BuildingBlocks/RiemannZetaLandauDispersionBridge.lean`  
**Root Module**: `formalization/BuildingBlocks.lean`  
**Dependencies**:
- `BuildingBlocks.Target`
- `BuildingBlocks.ActualCriticalMellin`
- `BuildingBlocks.ActualFullCenteredMellin`
- `BuildingBlocks.ActualCriticalSignCriterion`
- `BuildingBlocks.CriticalTransformPoles`
- `BuildingBlocks.CriticalTransformRH`
- `BuildingBlocks.RiemannZetaGrandEquivalence`
- `Mathlib.Analysis.Complex.Basic`
- `Mathlib.NumberTheory.LSeries.RiemannZeta`

---

## 1. Mathematical and Formal Context

This module establishes the explicit structural bridge between the Landau sign criterion on the centered prime Mellin kernel $\mathcal{W}(x)$ and the 10-fold grand master equivalence chain for the Riemann Hypothesis:

$$\mathcal{W}(x) = \operatorname{fullNumerator}(x) - \operatorname{allocation}(x)$$

Because the imaginary parts of both arithmetic sums vanish identically:
$$\operatorname{Re}(\mathcal{W}(x)) \le 0 \iff \operatorname{Re}(\operatorname{fullNumerator}(x)) \le \operatorname{Re}(\operatorname{allocation}(x))$$

Here:
- $\operatorname{allocation}(x) = \sum_{d \le x} \sqrt{d} \, T(x/d) \ge 0$ represents the diagonal proper/ordinary prime-power allocation with growth $\sim \frac{1}{2} x^2 \log x$.
- $\operatorname{fullNumerator}(x) = \sum_{d \le x} \sqrt{d} \, N(x/d)$ represents the complete centered prime fluctuations.

When eventual domination $\forallᶠ x \text{ in } \operatorname{atTop}, (\operatorname{fullNumerator}(x))_{\text{re}} \le (\operatorname{allocation}(x))_{\text{re}}$ is satisfied, the sign criterion unconditionally forces:
1. `RiemannHypothesis` (Mathlib canonical)
2. `Target`
3. `RightHalfZeroFree`
4. `RightOfflineSupport = ∅`
5. Upper half-plane zero-freeness
6. High-frequency zero-freeness
7. `HolomorphicZetaODE`
8. `AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | 1/2 < s.re}`
9. `Nonempty HighFrequencyContradictionSystem`
10. `Nonempty DisplacementIntegralRefutationSystem`
11. `Nonempty DisplacementIntegralMismatchSystem`

---

## 2. Machine-Verified Theorems

All declarations have been machine-checked in Lean 4.34.1 with **0 `sorry`**, **0 `sorryAx`**, and **strictly foundational axioms** `[propext, Classical.choice, Quot.sound]`:

1. `W_re_nonpos_iff_fullNumerator_le_allocation`:
   $$(\mathcal{W}(x))_{\text{re}} \le 0 \iff (\operatorname{fullNumerator}(x))_{\text{re}} \le (\operatorname{allocation}(x))_{\text{re}}$$
2. `eventually_W_re_nonpos_iff_eventually_fullNumerator_le_allocation`:
   $$(\forallᶠ x \text{ in } \operatorname{atTop}, (\mathcal{W}(x))_{\text{re}} \le 0) \iff (\forallᶠ x \text{ in } \operatorname{atTop}, (\operatorname{fullNumerator}(x))_{\text{re}} \le (\operatorname{allocation}(x))_{\text{re}})$$
3. `RiemannHypothesis_of_fullNumerator_le_allocation_after`:
   Cutoff criterion proving `RiemannHypothesis` given domination after threshold $A \ge 1$.
4. `RiemannHypothesis_of_eventually_fullNumerator_le_allocation`:
   Filter criterion proving `RiemannHypothesis` given eventual domination at infinity.
5. `analyticOnNhd_filledTransform_of_eventually_fullNumerator_le_allocation`:
   Analytic continuation bridge establishing $\operatorname{AnalyticOnNhd} \mathbb{C} \, \text{filledTransform} \, \{s \mid 1/2 < \sigma\}$.
6. `target_of_eventually_fullNumerator_le_allocation`:
   Direct verification of Mathlib `Target`.
7. `rightHalfZeroFree_of_eventually_fullNumerator_le_allocation`:
   Right half-plane zero-freeness from eventual allocation domination.
8. `rightOfflineSupport_empty_of_eventually_fullNumerator_le_allocation`:
   Unilateral off-line support emptiness.
9. `upper_half_plane_zero_free_of_eventually_fullNumerator_le_allocation`:
   Upper half-plane zero-freeness.
10. `high_frequency_zero_free_of_eventually_fullNumerator_le_allocation`:
    High-frequency zero-freeness.
11. `holomorphicZetaODE_of_eventually_fullNumerator_le_allocation`:
    Holomorphic zeta ODE system.
12. `grand_rh_bundle_of_eventually_fullNumerator_le_allocation`:
    Comprehensive grand theorem bundling all 10 equivalences into a single machine-verified compound conclusion.

---

## 3. Kernel Axiom Audit

Machine confirmation from `#print axioms`:
```
info: 'BuildingBlocks.RiemannZetaLandauDispersionBridge.W_re_nonpos_iff_fullNumerator_le_allocation' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaLandauDispersionBridge.eventually_W_re_nonpos_iff_eventually_fullNumerator_le_allocation' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaLandauDispersionBridge.RiemannHypothesis_of_fullNumerator_le_allocation_after' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaLandauDispersionBridge.RiemannHypothesis_of_eventually_fullNumerator_le_allocation' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaLandauDispersionBridge.analyticOnNhd_filledTransform_of_eventually_fullNumerator_le_allocation' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaLandauDispersionBridge.grand_rh_bundle_of_eventually_fullNumerator_le_allocation' depends on axioms: [propext, Classical.choice, Quot.sound]
```
No `sorry`, no `sorryAx`, no custom axioms.
