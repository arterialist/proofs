# Contribution 179: Exact Causal Probability Delay Dissipation and Same-Prime Residual Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeHistoryProbability.lean`](../../formalization/BuildingBlocks/SamePrimeHistoryProbability.lean), [`building-blocks/primes/same-prime-history-probability.md`](../../building-blocks/primes/same-prime-history-probability.md)  
**Classification:** Measure Theory / Probability Theory / Renewal Dynamics / Causal Delay / Monotone Operators / Energy Dissipation

---

## 1. Executive Summary and Mathematical Statement

In the analysis of causal memory kernels for prime distributions, delay differential and renewal equations introduce delayed convolution operators against arbitrary probability distributions $\mu$ supported on causal delays $[0, \infty)$. Establishing that such averaging operators strictly dissipate energy without increasing the underlying state variable is essential for stability.

This contribution proves:

1. **Measurability of the Same-Prime History Function:**  
   Because $s : \mathbb{R} \to \mathbb{R}$ is monotone non-decreasing, it is automatically Borel measurable:
   $$
   s \in \mathcal{M}(\mathbb{R}, \mathcal{B}(\mathbb{R})).
   $$
2. **Integrability Under Arbitrary Causal Probability Measures:**  
   For any finite Borel measure $\mu$ supported on causal delays ($\mu((-\infty, 0)) = 0$) and any $v \in \mathbb{R}$:
   $$
   r \mapsto s(v - r) \in L^1(\mu).
   $$
3. **Exact Probability Averaging Upper Bound:**  
   For any Borel probability measure $\mu$ on $[0, \infty)$ and every evaluation age $v \in \mathbb{R}$:
   $$
   0 \le \int_0^\infty s(v - r) \, d\mu(r) \le s(v).
   $$
   Causal probability averaging cannot increase the magnitude of the same-prime history function at any age.
4. **Universal Non-Positivity of the Delay Dissipation Residual:**  
   The delay residual $\Delta_\mu(v) = \int_0^\infty s(v - r) \, d\mu(r) - s(v)$ satisfies the universal sign-definite bound:
   $$
   -s(v) \le \int_0^\infty s(v - r) \, d\mu(r) - s(v) \le 0.
   $$
   The causal delay dissipation residual is strictly non-positive across all ages $v \in \mathbb{R}$ and for all causal probability measures $\mu$.

---

## 2. Mathematical Proof

### 2.1. Measurability
A monotone function on $\mathbb{R}$ has at most countably many discontinuities.
In any topological space, any monotone function $f: \mathbb{R} \to \mathbb{R}$ generates lower level sets $\{x : f(x) < c\}$ or $\{x : f(x) \le c\}$ that are connected intervals (rays).
Every ray is an open or closed interval, hence a Borel set. Thus $s$ is Borel measurable.

### 2.2. Dominated Integrability
For almost every $r$ with respect to $\mu$, $r \ge 0$.
Since $s$ is monotone non-decreasing, $r \ge 0 \implies v - r \le v \implies s(v - r) \le s(v)$.
Since $s$ is non-negative everywhere, $0 \le s(v - r) \le s(v)$.
The constant function $g(r) = s(v)$ is integrable under the finite measure $\mu$, with $\int s(v) \, d\mu = s(v) \mu(\mathbb{R}) < \infty$.
By the dominated convergence theorem / comparison test in Bochner integration, $r \mapsto s(v - r)$ is $\mu$-integrable.

### 2.3. Probability Averaging Bounds
Using monotonicity of the Bochner integral under almost-everywhere pointwise inequality:
$$
\int_{\mathbb{R}} s(v - r) \, d\mu(r) \le \int_{\mathbb{R}} s(v) \, d\mu(r) = s(v) \mu(\mathbb{R}).
$$
When $\mu$ is a probability measure, $\mu(\mathbb{R}) = 1$, giving $\int s(v - r) \, d\mu(r) \le s(v)$.
Non-negativity follows from $s \ge 0$.

### 2.4. Residual Bound
Subtracting $s(v)$ from both sides of $0 \le \int s(v - r) \, d\mu(r) \le s(v)$ yields:
$$
-s(v) \le \int_0^\infty s(v - r) \, d\mu(r) - s(v) \le 0.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeHistoryProbability` in `formalization/BuildingBlocks/SamePrimeHistoryProbability.lean`):
```lean
theorem s_measurable : Measurable s

theorem delayed_s_integrable {μ : Measure ℝ} [IsFiniteMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    Integrable (fun r : ℝ => s (v - r)) μ

theorem delayed_s_integral_bounds {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    0 ≤ (∫ r, s (v - r) ∂μ) ∧ (∫ r, s (v - r) ∂μ) ≤ s v

theorem samePrime_residual_bounds {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    -s v ≤ (∫ r, s (v - r) ∂μ) - s v ∧
      (∫ r, s (v - r) ∂μ) - s v ≤ 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Contractive Markov semigroups, monotone operators, and Choquet-Deny integral equations (Feller 1971, Revuz 1984). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes $-s(v) \le \int_0^\infty s(v-r)d\mu(r) - s(v) \le 0$ for arbitrary causal probability measures $\mu$ in Lean 4.
- **Target Venues:** *Probability Theory and Related Fields* or *Journal of Theoretical Probability*.
