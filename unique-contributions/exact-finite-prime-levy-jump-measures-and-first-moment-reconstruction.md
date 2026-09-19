# Unique Contribution 188: Exact Finite-Prime Lévy Jump Measures and First-Moment Reconstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedLevy.lean`](../../formalization/BuildingBlocks/PrimeSeedLevy.lean), [`building-blocks/primes/prime-seed-levy.md`](../../building-blocks/primes/prime-seed-levy.md)  
**Classification:** Stochastic Analysis / Lévy Processes / Jump Intensities / Prime Successor Seeds / First-Moment Reconstruction

---

## 1. Executive Summary and Mathematical Statement

In the probabilistic and dynamical interpretation of arithmetic renewal, prime arrivals along logarithmic clocks are modeled via jump processes whose intensity is inversely proportional to age. Constructing finite-prime jump measures directly from continuous causal seeds and proving their finite activity and moment identities without truncating higher prime powers is crucial for pure jump semigroup generators.

This contribution proves:

1. **Age-Division Integrability and Upper Bound:**  
   For any clock $L > 0$, the causal seed vanishes on $(-\infty, L)$, ensuring that $v \ge L > 0$ on its support. Consequently:
   \[
   0 \le \frac{\text{seed}_L(v)}{v} \le \frac{\text{seed}_L(v)}{L} \quad \text{for all } v \in \mathbb{R}.
   \]
   The age-divided seed $v \mapsto \frac{\text{seed}_L(v)}{v}$ is Lebesgue integrable on $\mathbb{R}$, with total mass:
   \[
   \int_{-\infty}^\infty \frac{\text{seed}_L(v)}{v} \, dv \le \frac{2 e^{-L}}{L}.
   \]
2. **Finite-Prime Lévy Density and Finite Measure:**  
   For any finite set of primes $S \subset \mathcal{P}$, the aggregated Lévy density is defined by:
   \[
   \text{levyDensity}_S(v) = \sum_{p \in S} \frac{\text{seed}_{\log p}(v)}{v}.
   \]
   It is non-negative and integrable. The induced jump measure:
   \[
   \nu_S(dv) = \text{levyMeasure}_S(dv) = \text{levyDensity}_S(v) \, dv
   \]
   is a strictly finite measure (`IsFiniteMeasure (levyMeasure S)`): $\nu_S(\mathbb{R}) < \infty$. The system exhibits strictly finite jump activity.
3. **Exact Age-Multiplication Inversion Identity:**  
   Multiplying the Lévy density by the age variable $v$ cancels the age denominator identically and recovers the complete multi-prime causal seed:
   \[
   v \cdot \text{levyDensity}_S(v) = \sum_{p \in S} \text{seed}_{\log p}(v) \quad \text{for all } v \in \mathbb{R}.
   \]
4. **Exact First-Moment Reconstruction Formula:**  
   The first moment of the finite-prime Lévy measure evaluates in closed form to the finite harmonic prime sum:
   \[
   \int_{-\infty}^\infty v \, \nu_S(dv) = \int_{-\infty}^\infty v \cdot \text{levyDensity}_S(v) \, dv = \sum_{p \in S} \frac{2}{p}.
   \]
   All proper prime-power intervals $p^m$ ($m \ge 2$) are retained and accounted for in both the intensity measure and its moment reconstruction.

---

## 2. Mathematical Proof

### 2.1. Pointwise Age Bounds and Integrability
If $v < L$, $\text{seed}_L(v) = 0$, so $\frac{\text{seed}_L(v)}{v} = 0 \le \frac{\text{seed}_L(v)}{L}$.
If $v \ge L > 0$, dividing the non-negative numerator $\text{seed}_L(v) \ge 0$ by $v \ge L$ gives $\frac{\text{seed}_L(v)}{v} \le \frac{\text{seed}_L(v)}{L}$.
Since $\text{seed}_L \in L^1(\mathbb{R})$, the majorant $\frac{\text{seed}_L(v)}{L} \in L^1(\mathbb{R})$ dominates $\frac{\text{seed}_L(v)}{v}$.
By Lebesgue dominated convergence / monotonicity:
\[
\int_{\mathbb{R}} \frac{\text{seed}_L(v)}{v} \, dv \le \frac{1}{L} \int_{\mathbb{R}} \text{seed}_L(v) \, dv = \frac{2 e^{-L}}{L}.
\]

### 2.2. Finite-Prime Lévy Measure
For any finite set $S \subset \mathcal{P}$, $\text{levyDensity}_S$ is a finite sum of integrable functions, hence integrable.
By Radon-Nikodym / density integration with respect to Lebesgue measure:
\[
\nu_S(\mathbb{R}) = \int_{\mathbb{R}} \text{levyDensity}_S(v) \, dv < \infty,
\]
proving that $\nu_S$ is a finite Borel measure on $\mathbb{R}$.

### 2.3. Reconstruction and First Moment
For $v = 0$, $0 \cdot \text{levyDensity}_S(0) = 0$. Since $\log p > 0$, $\text{seed}_{\log p}(0) = 0$, so both sides equal 0.
For $v \ne 0$, $v \cdot \frac{\text{seed}_{\log p}(v)}{v} = \text{seed}_{\log p}(v)$.
Summing over $p \in S$ proves $v \cdot \text{levyDensity}_S(v) = \sum_{p \in S} \text{seed}_{\log p}(v)$.
Integrating over $\mathbb{R}$ and applying `integral_finset_prime_seed`:
\[
\int_{\mathbb{R}} v \, \nu_S(dv) = \int_{\mathbb{R}} \left( \sum_{p \in S} \text{seed}_{\log p}(v) \right) dv = \sum_{p \in S} \frac{2}{p}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedLevy.lean`):
```lean
theorem seed_div_age_le {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v / v ≤ seed L v / L

theorem integrable_seed_div_age {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => seed L v / v)

theorem integral_seed_div_age_le {L : ℝ} (hL : 0 < L) :
    (∫ v, seed L v / v) ≤ 2 * exp (-L) / L

instance levyMeasure_isFiniteMeasure (S : Finset Nat.Primes) :
    IsFiniteMeasure (levyMeasure S)

theorem age_mul_levyDensity (S : Finset Nat.Primes) (v : ℝ) :
    v * levyDensity S v = ∑ p ∈ S, seed (log p) v

theorem integral_age_mul_levyDensity (S : Finset Nat.Primes) :
    (∫ v, v * levyDensity S v) = ∑ p ∈ S, 2 / (p : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Lévy-Khintchine representations and jump measures for renewal processes (Sato 1999, Applebaum 2009). The rigorous construction and formal verification of finite-prime Lévy jump measures retaining all prime powers and their first-moment reconstruction in Lean 4 is new.
- **Advancement:** Establishes the finite-measure property `IsFiniteMeasure (levyMeasure S)` and proves the first-moment identity $\int v \, d\nu_S = \sum_{p \in S} 2/p$ in Lean 4.
- **Target Venues:** *Stochastic Processes and their Applications* or *Probability Theory and Related Fields*.
