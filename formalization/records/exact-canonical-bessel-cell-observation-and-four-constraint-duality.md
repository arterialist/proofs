# Contribution 269: Exact Canonical Bessel Cell Observation and Four-Constraint Duality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CanonicalFiniteObservation.lean`](../../formalization/BuildingBlocks/CanonicalFiniteObservation.lean), [`building-blocks/spectral/canonical-finite-observation.md`](../../building-blocks/spectral/canonical-finite-observation.md)  
**Classification:** Functional Analysis / Bessel's Inequality / Inner Product Spaces / Constraint Dimensions / Optimization / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the observer design for energy compensation on partitioned boundary networks, finite normalized cell indicators produce localized observations that extract energy from the state. Tracking the exact real codimension of these observations and completing the square for affine feedback gains are essential steps in proving uniform dissipation.

This contribution proves:

1. **Finite Canonical Bessel Cell Observation Inequality:**  
   For any orthonormal family $\{v_i\}_{i \in \iota}$ in a complex Hilbert space $E$, and any finite index subset $s \subseteq \iota$:
   $$
   \sum_{i \in s} |\langle v_i, h \rangle|^2 \le \|h\|^2.
   $$
   This ensures that observing finite cellular components provides a coefficient-one dissipative observation without overestimating the total available state energy.
2. **Four Real Constraints Duality for Scalar Observations:**  
   Defining the total number of real boundary constraints for a complex observation of dimension $d$ by $\text{actualRealConstraintCount}(d) = 2 + 2d$ (accounting for real and imaginary parts of the $d$ coordinates plus the mean and arrival boundary rows):
   $$
   \text{actualRealConstraintCount}(d) = 4 \iff d = 1.
   $$
   The canonical four-constraint space of the core-to-port boundary theory corresponds uniquely and exactly to a scalar complex observation ($d = 1$).
3. **Exact Affine Completion of Squares Identity:**  
   For quadratic forms $Q_{ff}, Q_{fq}, Q_{qq}$ with optimal affine coefficient $c = \frac{Q_{fq} + m}{Q_{qq}}$:
   $$
   Q_{ff} - \frac{(Q_{fq} + m)(Q_{fq} + m)^*}{Q_{qq}} = Q_{ff} - c (Q_{fq} + m)^*.
   $$

---

## 2. Mathematical Proof

### 2.1. Bessel Step on Finite Partitions
Let $\{v_i\}_{i \in s}$ be an orthonormal family in $E$.
The orthogonal projection onto the subspace $V_s = \text{span}\{v_i : i \in s\}$ is given by $P_s h = \sum_{i \in s} \langle v_i, h \rangle v_i$.
By Pythagorean decomposition:
$$
\|h\|^2 = \|P_s h\|^2 + \|(I - P_s) h\|^2 = \sum_{i \in s} |\langle v_i, h \rangle|^2 + \|(I - P_s) h\|^2 \ge \sum_{i \in s} |\langle v_i, h \rangle|^2.
$$

### 2.2. Constraint Dimensionality Duality
$\text{actualRealConstraintCount}(d) = 2 + 2d = 4 \iff 2d = 2 \iff d = 1$.

### 2.3. Affine Gain Factorization
Substituting $c = (Q_{fq} + m) / Q_{qq}$ into $c(Q_{fq} + m)^*$:
$$
c (Q_{fq} + m)^* = \frac{Q_{fq} + m}{Q_{qq}} (Q_{fq} + m)^* = \frac{(Q_{fq} + m)(Q_{fq} + m)^*}{Q_{qq}}.
$$
Subtracting from $Q_{ff}$ completes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation` in `formalization/BuildingBlocks/CanonicalFiniteObservation.lean`):
```lean
theorem canonical_cell_observation_le
    {E ι : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℂ E]
    {v : ι → E} (h : E) (s : Finset ι) (hv : Orthonormal ℂ v) :
    ∑ i ∈ s, ‖inner ℂ (v i) h‖ ^ 2 ≤ ‖h‖ ^ 2

theorem four_real_constraints_iff_scalar (d : ℕ) :
    actualRealConstraintCount d = 4 ↔ d = 1

theorem affine_optimizer_identity
    {Qff Qfq Qqq m c : ℂ}
    (hc : c = (Qfq + m) / Qqq) :
    (Qff - (Qfq + m) * star (Qfq + m) / Qqq) =
      Qff - c * star (Qfq + m)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Bessel's inequality in Hilbert spaces and dimension counting in boundary control (Curtain-Zwart 1995, Conway 1990). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects discrete cellular boundary observations rigorously to coefficient-one dissipation bounds.
- **Target Venues:** *Systems & Control Letters* or *Journal of Mathematical Analysis and Applications*.
