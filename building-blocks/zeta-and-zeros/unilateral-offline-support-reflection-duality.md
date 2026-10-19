# Unilateral off-line support reflection duality and spectral confinement bridge

### Status, Claims, Assumptions, and Proof Status
- **Claim**: Exact unilateral reflection equivalence $\text{RightOfflineSupport} = \emptyset \iff \text{LeftOfflineSupport} = \emptyset$ and the collapsed equivalence chain connecting unilateral off-line zero support emptiness to Mathlib's formal `RiemannHypothesis`, spectral support confinement, and transverse metric distance vanishing.
- **Assumptions**: None. This is an unconditional mathematical theorem in Lean 4. It does not assume RH, unproved operator bounds, or arithmetic sign conditions.
- **Proof status**: Proved in Lean 4 ([`formalization/BuildingBlocks/UnilateralOfflineSupportBridge.lean`](../../formalization/BuildingBlocks/UnilateralOfflineSupportBridge.lean)). Verified via automated kernel axiom audit ([`formalization/verification/UnilateralOfflineSupportBridgeAudit.lean`](../../formalization/verification/UnilateralOfflineSupportBridgeAudit.lean)) with standard foundational axioms `[propext, Classical.choice, Quot.sound]`, zero custom axioms, and zero `sorry`.
- **Scope & Limitations**: This result proves that ruling out off-critical zeros on either open half-plane ($\operatorname{Re}(s) > 1/2$ or $\operatorname{Re}(s) < 1/2$) is individually sufficient to deduce the full bilateral Riemann Hypothesis. It does not establish the emptiness of either set unconditionally, and therefore does not prove the Riemann Hypothesis.

---

## 1. Mathematical Statement and Definitions

Let $\zeta(s) = \operatorname{riemannZeta}(s)$ denote the Riemann zeta function. In Mathlib 4, the formal proposition `RiemannHypothesis` asserts that all non-trivial zeros lie on the critical line:
```math
\mathrm{RH} \iff \forall s \in \mathbb{C}, \; \zeta(s) = 0 \implies (\neg \exists n \in \mathbb{N}, \; s = -2(n+1)) \implies s \ne 1 \implies \operatorname{Re}(s) = \frac{1}{2}.
```

Define the spectral support sets:
```math
\text{SpectralZeroSupport} = \{s \in \mathbb{C} \mid \zeta(s) = 0 \wedge (\neg \exists n \in \mathbb{N}, \; s = -2(n+1)) \wedge s \ne 1\},
```
```math
\text{CriticalLineSupport} = \{s \in \mathbb{C} \mid \operatorname{Re}(s) = 1/2\},
```
```math
\text{RightOfflineSupport} = \{s \in \text{SpectralZeroSupport} \mid 1/2 < \operatorname{Re}(s)\},
```
```math
\text{LeftOfflineSupport} = \{s \in \text{SpectralZeroSupport} \mid \operatorname{Re}(s) < 1/2\}.
```
The transverse spectral distance to the critical line is given by
```math
\text{spectralDistance}(s) = \left|\operatorname{Re}(s) - \frac{1}{2}\right|,
```
and spectral support confinement is the topological inclusion
```math
\text{SpectralSupportConfinement} \iff \text{SpectralZeroSupport} \subseteq \text{CriticalLineSupport}.
```

---

## 2. Unilateral Reflection Involution

The completed Riemann zeta function $\xi(s) = \frac{1}{2}s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$ satisfies the functional equation $\xi(s) = \xi(1-s)$. In the repository's foundational module `BuildingBlocks.Scope`, this reflection is established at non-trivial zeros via `reflect_nontrivial_zero`:
```math
\zeta(s) = 0 \wedge (\neg \exists n \in \mathbb{N}, \; s = -2(n+1)) \wedge s \ne 1 \implies \zeta(1-s) = 0.
```

### Theorem 1 (Pointwise Reflection Duality)
Let $s \in \mathbb{C}$. Then:
1. $s \in \text{RightOfflineSupport} \implies (1 - s) \in \text{LeftOfflineSupport}$.
2. $s \in \text{LeftOfflineSupport} \implies (1 - s) \in \text{RightOfflineSupport}$.

*Proof.* 
For (1), suppose $s \in \text{RightOfflineSupport}$. Then $\zeta(s) = 0$, $s \ne 1$, $1/2 < \operatorname{Re}(s)$, and $s$ is non-trivial. The real part transforms as $\operatorname{Re}(1-s) = 1 - \operatorname{Re}(s) < 1/2$. By `reflect_nontrivial_zero`, $\zeta(1-s) = 0$. If $1-s = 1$, then $s = 0$, contradicting $\zeta(0) = -1/2 \ne 0$. If $1-s = -2(n+1)$ for some $n \in \mathbb{N}$, then $s = 1 + 2(n+1) \ge 3$, which contradicts the non-vanishing of $\zeta(s)$ on $\operatorname{Re}(s) > 1$. Thus $(1-s)$ is a non-trivial zero with real part $< 1/2$, so $(1-s) \in \text{LeftOfflineSupport}$.

For (2), the argument is symmetric: $\operatorname{Re}(1-s) = 1 - \operatorname{Re}(s) > 1/2$. If $1-s = -2(n+1)$, then $\operatorname{Re}(1-s) = -2(n+1) \le -2 < 0 < 1/2$, contradicting $\operatorname{Re}(1-s) > 1/2$. Hence $(1-s)$ cannot be trivial, yielding $(1-s) \in \text{RightOfflineSupport}$. $\blacksquare$

### Corollary 2 (Unilateral Support Emptiness Equivalence)
```math
\text{RightOfflineSupport} = \emptyset \iff \text{LeftOfflineSupport} = \emptyset.
```
*Proof.* If $\text{RightOfflineSupport} = \emptyset$ and there existed $s \in \text{LeftOfflineSupport}$, then $(1-s) \in \text{RightOfflineSupport} = \emptyset$, a contradiction. The reverse implication is identical. $\blacksquare$

---

## 3. Equivalence Chain

Combining this reflection duality with existing scope and confinement theorems yields the unified chain formalized in `unilateral_rh_equivalence_chain`:

```math
\begin{aligned}
\mathrm{RH} &\iff \text{Target} \\
&\iff \text{RightHalfZeroFree} \\
&\iff \text{RightOfflineSupport} = \emptyset \\
&\iff \text{LeftOfflineSupport} = \emptyset \\
&\iff \text{LeftOfflineSupport} = \emptyset \wedge \text{RightOfflineSupport} = \emptyset \\
&\iff \text{SpectralSupportConfinement} \\
&\iff \forall s \in \text{SpectralZeroSupport}, \; \text{spectralDistance}(s) = 0.
\end{aligned}
```

This collapses earlier formulations that required asserting both left and right off-line support emptiness simultaneously, showing that establishing zero-freeness on either open half-plane is logically sufficient.

---

## 4. Verification and Axioms

The declarations in `formalization/BuildingBlocks/UnilateralOfflineSupportBridge.lean` were verified using Lean 4.34.1. The companion audit module `formalization/verification/UnilateralOfflineSupportBridgeAudit.lean` checks all declarations against Lean's kernel environment:

```
AUDITED DECLARATION BuildingBlocks.not_trivial_zero_of_half_lt_re
AUDITED DECLARATION BuildingBlocks.right_offline_to_left_offline
AUDITED DECLARATION BuildingBlocks.left_offline_to_right_offline
AUDITED DECLARATION BuildingBlocks.rightOfflineSupport_empty_iff_leftOfflineSupport_empty
AUDITED DECLARATION BuildingBlocks.rightHalfZeroFree_iff_rightOfflineSupport_empty
AUDITED DECLARATION BuildingBlocks.RiemannHypothesis_iff_rightOfflineSupport_empty
AUDITED DECLARATION BuildingBlocks.RiemannHypothesis_iff_leftOfflineSupport_empty
AUDITED DECLARATION BuildingBlocks.offline_supports_empty_iff_rightOfflineSupport_empty
AUDITED DECLARATION BuildingBlocks.offline_supports_empty_iff_leftOfflineSupport_empty
AUDITED DECLARATION BuildingBlocks.spectralSupportConfinement_iff_RiemannHypothesis
AUDITED DECLARATION BuildingBlocks.spectralSupportConfinement_iff_spectralDistance_zero
AUDITED DECLARATION BuildingBlocks.rightOfflineSupportAbove_empty_iff_highFrequencyZeroFree
AUDITED DECLARATION BuildingBlocks.highFrequencyZeroFree_mono
AUDITED DECLARATION BuildingBlocks.rightOfflineSupport_empty_iff_highFrequencyZeroFree_of_low
AUDITED DECLARATION BuildingBlocks.unilateral_rh_equivalence_chain
UNILATERAL OFFLINE SUPPORT BRIDGE AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry
```
