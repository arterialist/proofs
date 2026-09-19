# Exact All-Prime Jump Process Finite-Activity Infinite-First-Moment Dichotomy

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedInfiniteMean.lean`](../../formalization/BuildingBlocks/PrimeSeedInfiniteMean.lean),
**Classification:** Probability Theory / Lévy Processes / Pure Jump Semigroups / Moment Duality / Euler Prime Divergence / Infinite Expectations
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

A classical phenomenon in heavy-tailed probability is that a jump measure can have finite total mass (finite total jump rate, ensuring non-explosion of jumps) while simultaneously possessing an infinite first moment (meaning the expected jump size is infinite). In prime arrival dynamics, this dichotomy reflects Euler's harmonic prime divergence $\sum_p 1/p = \infty$ embedded inside the square-integrable renewal architecture.

This note records:

1. **Exact Singleton Prime First-Moment Identity:**
   For any single prime $p$, the first moment of its Lévy jump measure reconstructs the unweighted seed mass:
   $$
   \int_0^\infty v \, \nu_{\{p\}}(dv) = \int_{\mathbb{R}} \text{seed}_{\log p}(v) \, dv = \frac{2}{p}.
   $$
2. **Infinite First Moment of the All-Prime Lévy Measure:**
   Although the aggregated all-prime Lévy measure $\nu_{\mathcal{P}}$ has finite total jump activity ($\|\nu_{\mathcal{P}}\| < \infty$, proven in `PrimeSeedAllPrimeLevy.lean`), its first moment diverges to infinity:
   $$
   \int_0^\infty v \, \nu_{\mathcal{P}}(dv) = \sum_{p \in \mathcal{P}} \frac{2}{p} = \infty.
   $$
3. **Infinite Process First Moment at All Positive Times:**
   For the compound Poisson transition probability measure $X_u \sim \mathcal{P}_u$ of the all-prime process, the expected age / jump location is infinite at EVERY strictly positive operational time $u > 0$:
   $$
   \int_0^\infty v \, \mathcal{P}_u(dv) = \infty \quad \text{for every } u > 0.
   $$
4. **Strict Non-Integrability of the Age Coordinate:**
   For every $u > 0$, the identity function $v \mapsto v$ is strictly non-integrable against the transition law $\mathcal{P}_u$:
   $$
   v \notin L^1(\mathbb{R}, \mathcal{P}_u) \quad \text{for all } u > 0.
   $$
   No first-moment continuity or mean drift can be inferred from event-wise convergence. The process is a non-explosive pure jump process with infinite expected position at every moment of continuous time.

---

## 2. Mathematical Proof

### 2.1. Singleton Prime First Moment
Recall that $\nu_{\{p\}}(dv) = \frac{\text{seed}_{\log p}(v)}{v} \, dv$.
Multiplying by the coordinate $v$:
$$
\int_0^\infty v \, \nu_{\{p\}}(dv) = \int_0^\infty v \frac{\text{seed}_{\log p}(v)}{v} \, dv = \int_0^\infty \text{seed}_{\log p}(v) \, dv.
$$
By causality, $\text{seed}_{\log p}(v) = 0$ for $v < \log p \le 0$, so $\int_0^\infty \text{seed} = \int_{\mathbb{R}} \text{seed} = \frac{2}{p}$.

### 2.2. All-Prime Lévy First Moment Divergence
By monotone convergence for sum measures:
$$
\int_0^\infty v \, \nu_{\mathcal{P}}(dv) = \sum_{p \in \mathcal{P}} \int_0^\infty v \, \nu_{\{p\}}(dv) = \sum_{p \in \mathcal{P}} \frac{2}{p}.
$$
Since $\sum_p 1/p$ diverges, the sum of non-negative reals is infinite in $\overline{\mathbb{R}}_{\ge 0}$, yielding $\infty$.

### 2.3. Process First Moment at Time $u > 0$
The Poisson law series is $\mathcal{P}_u = e^{-u\|\nu\|} \sum_{n=0}^\infty \frac{u^n}{n!} \nu^{*n}$.
The $n = 1$ term provides the sub-measure:
$$
u e^{-u \|\nu\|} \nu_{\mathcal{P}} \le \mathcal{P}_u.
$$
Since $u > 0$ and $\|\nu\| < \infty$, the prefactor $c = u e^{-u \|\nu\|} > 0$ is strictly positive.
Therefore:
$$
\int_0^\infty v \, \mathcal{P}_u(dv) \ge c \int_0^\infty v \, \nu_{\mathcal{P}}(dv) = c \cdot \infty = \infty.
$$
Hence $\int_0^\infty v \, \mathcal{P}_u(dv) = \infty$, and $v \mapsto v$ is not integrable against $\mathcal{P}_u$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` and `BuildingBlocks.PrimeSeedProcess` in `formalization/BuildingBlocks/PrimeSeedInfiniteMean.lean`):
```lean
theorem singleton_levyMeasure_firstMoment (p : Nat.Primes) :
    (∫⁻ v, ENNReal.ofReal v ∂levyMeasure {p}) =
      ENNReal.ofReal (∫ v, seed (log p) v)

theorem allPrimeLevyMeasure_firstMoment :
    (∫⁻ v, ENNReal.ofReal v ∂allPrimeLevyMeasure) = ∞

theorem allPrimeProcess_firstMoment (u : ℝ≥0) (hu : 0 < u) :
    (∫⁻ v, ENNReal.ofReal v ∂allPrimeProcess u) = ∞

theorem not_integrable_allPrimeProcess_age (u : ℝ≥0) (hu : 0 < u) :
    ¬ Integrable (fun v : ℝ => v) (allPrimeProcess u)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
