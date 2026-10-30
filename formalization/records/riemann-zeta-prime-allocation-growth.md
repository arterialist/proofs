# Prime-Allocation Positivity and Centered Fluctuation Growth Bridge

**Module Path**: `formalization/BuildingBlocks/RiemannZetaPrimeAllocationGrowth.lean`  
**Root Module**: `formalization/BuildingBlocks.lean`  
**Dependencies**:
- `BuildingBlocks.Target`
- `BuildingBlocks.ActualCriticalMellin`
- `BuildingBlocks.ActualFullCenteredMellin`
- `BuildingBlocks.ActualCriticalGrowthCriterion`
- `BuildingBlocks.SelbergDistinctPrimes`
- `BuildingBlocks.CriticalTransformPoles`
- `BuildingBlocks.CriticalTransformRH`
- `BuildingBlocks.RiemannZetaGrandEquivalence`
- `Mathlib.Analysis.Complex.Basic`
- `Mathlib.NumberTheory.LSeries.RiemannZeta`

---

## 1. Mathematical and Formal Context

This module establishes the exact non-negativity of the diagonal proper-power and ordinary-power prime allocation:

$$\operatorname{Re}(\operatorname{allocation}(x)) \ge 0 \quad (\forall x \in \mathbb{R}),$$

and the resulting unconditional pointwise dominance on the real part of the critical transform kernel $\mathcal{W}(x)$:

$$\operatorname{Re}(\mathcal{W}(x)) \le \operatorname{Re}(\operatorname{fullNumerator}(x)) \quad (\forall x \in \mathbb{R}).$$

Because $\mathcal{W}(x) = \operatorname{fullNumerator}(x) - \operatorname{allocation}(x)$ and $\operatorname{Im}(\mathcal{W}(x)) = 0$, removing the non-negative diagonal allocation unconditionally bounds $\mathcal{W}(x)$ from above by the centered prime fluctuation sum $\operatorname{fullNumerator}(x)$.

Consequently, any one-sided upper bound on the centered fluctuations alone:
$$\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2}$$
immediately transmits to $\operatorname{Re}(\mathcal{W}(x)) \le C x^{3/2}$, which via the Landau growth criterion (`ActualCriticalGrowthCriterion.RiemannHypothesis_of_eventually_growth`) unconditionally forces:
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

1. `T_re_nonneg`:
   $$\forall x \in \mathbb{R}, 0 \le \operatorname{Re}(T(x))$$
2. `allocation_re_nonneg`:
   $$\forall x \in \mathbb{R}, 0 \le \operatorname{Re}(\operatorname{allocation}(x))$$
3. `W_re_le_fullNumerator_re`:
   $$\forall x \in \mathbb{R}, \operatorname{Re}(\mathcal{W}(x)) \le \operatorname{Re}(\operatorname{fullNumerator}(x))$$
4. `RiemannHypothesis_of_fullNumerator_growth_after`:
   Cutoff criterion: $\operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2}$ for $x > A$ implies `RiemannHypothesis`.
5. `RiemannHypothesis_of_eventually_fullNumerator_growth`:
   Filter criterion: $\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2}$ implies `RiemannHypothesis` for any $C \in \mathbb{R}$.
6. `analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth`:
   Analytic continuation bridge: $\operatorname{AnalyticOnNhd} \mathbb{C} \, \text{filledTransform} \, \{s \mid 1/2 < \sigma\}$.
7. `target_of_eventually_fullNumerator_growth`:
   Direct verification of Mathlib `Target`.
8. `rightHalfZeroFree_of_eventually_fullNumerator_growth`:
   Right half-plane zero-freeness.
9. `rightOfflineSupport_empty_of_eventually_fullNumerator_growth`:
   Unilateral off-line support emptiness.
10. `upper_half_plane_zero_free_of_eventually_fullNumerator_growth`:
    Upper half-plane zero-freeness.
11. `high_frequency_zero_free_of_eventually_fullNumerator_growth`:
    High-frequency zero-freeness.
12. `holomorphicZetaODE_of_eventually_fullNumerator_growth`:
    Holomorphic zeta ODE system.
13. `grand_rh_bundle_of_eventually_fullNumerator_growth`:
    Simultaneous constructive deduction of all 10 grand RH representations.

---

## 3. Kernel Axiom Audit

Machine confirmation from `#print axioms` and `Lean.collectAxioms` meta-program in `RiemannZetaPrimeAllocationGrowthAudit.lean`:
```
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.T_re_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.allocation_re_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.RiemannHypothesis_of_fullNumerator_growth_after' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.RiemannHypothesis_of_eventually_fullNumerator_growth' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.RiemannZetaPrimeAllocationGrowth.grand_rh_bundle_of_eventually_fullNumerator_growth' depends on axioms: [propext, Classical.choice, Quot.sound]
```
No `sorry`, no `sorryAx`, no custom axioms.
