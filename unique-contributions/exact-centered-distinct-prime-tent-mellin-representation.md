# Unique Contribution 104: Exact Centered Distinct-Prime Tent Mellin Representation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean), [`formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean`](../../formalization/BuildingBlocks/DistinctPrimeRieszMellin.lean), [`formalization/BuildingBlocks/EtaRieszDirichlet.lean`](../../formalization/BuildingBlocks/EtaRieszDirichlet.lean)  
**Classification:** Analytic Number Theory / Mellin Transforms / Prime Pairs / Riesz Regularization / Centered Zeta Logarithmic Derivatives

---

## 1. Executive Summary and Mathematical Statement

In the analytical study of distinct prime pairs $(p_1, p_2)$ with $p_1 \ne p_2$, the correlation sum is centered by subtracting the continuous background and cross-terms against the single-prime Chebyshev density. The centered distinct-prime tent function $V(x)$ is defined by:
\[
V(x) = \sum_{\substack{p_1 \ne p_2 \\ p_1 p_2 \le x}} \Lambda(p_1) \Lambda(p_2) (x - p_1 p_2) - 2 \, \eta(x) + B(x),
\]
where $\eta(x) = \sum_{n \le x} \Lambda(n) \frac{x^2 - n^2}{2n}$ is the atom-plus-Lebesgue cross-sum, and $B(x)$ is the explicit continuous baseline.

This contribution proves:

1. **Exact Diagonal Subtraction:**  
   $V(x) = N(x) - T(x)$, where $N(x)$ is the full centered square and $T(x)$ is the exact sum over all same-prime diagonal powers $p^k \cdot p^m$.
2. **Explicit Arithmetic Cutoff Formula:**  
   For all $x \ge 0$:
   \[
   V(x) = \sum_{n \le x} \left( (x - n) d(n) - \Lambda(n) \frac{x^2 - n^2}{n} \right) + B(x),
   \]
   where $d(n) = \sum_{\substack{d | n, d \ne n/d}} \Lambda(d) \Lambda(n/d)$ is the distinct-prime pair weight.
3. **Exact Mellin Transform of the Centered Distinct-Prime Tent:**  
   For all $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1$:
   \[
   \mathcal{M}(V)(-s-1) = \frac{\left( -\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s-1} \right)^2 - H(s)}{s(s+1)},
   \]
   where:
   - $-\frac{\zeta'}{\zeta}(s) - \frac{1}{s-1}$ is the centered logarithmic derivative of the Riemann zeta function, having its pole at $s=1$ exactly removed;
   - $H(s) = \sum_p \frac{\log^2 p}{(p^s - 1)^2}$ is the absolutely convergent Dirichlet series generating all same-prime diagonal proper powers;
   - The factor $s(s+1)$ in the denominator is the standard second-order Riesz smoothing factor arising from double integration of the tent kernel.

---

## 2. Mathematical Proof

### 2.1. Decomposition of Generating Dirichlet Series
On $\operatorname{Re}(s) > 1$, the Dirichlet series of all prime powers factors as:
\[
\left( -\frac{\zeta'(s)}{\zeta(s)} \right)^2 = \sum_{n=1}^\infty \frac{\Lambda \star \Lambda(n)}{n^s}.
\]
Splitting into distinct-prime and same-prime contributions:
\[
\sum_{n=1}^\infty \frac{\Lambda \star \Lambda(n)}{n^s} = \mathcal{D}_{\text{distinct}}(s) + H(s),
\]
where $H(s) = \sum_p \sum_{j, k \ge 1} \frac{\log^2 p}{p^{(j+k)s}} = \sum_p \frac{\log^2 p}{(p^s - 1)^2}$.

### 2.2. Mellin Convolution of the Riesz Cutoff
The smoothed Riesz cutoff $\sum_{n \le x} a_n (x - n)$ has Mellin transform $\frac{\mathcal{D}(s)}{s(s+1)}$ at argument $-s-1$.
The cross-term $\eta(x)$ has Mellin transform $\frac{-\zeta'(s)/\zeta(s)}{(s-1)(s+1)}$, and the baseline $B(x)$ has Mellin transform $\frac{1}{(s-1)^2 s (s+1)}$.
Assembling the linear combination:
\[
\mathcal{M}(V)(-s-1) = \frac{\mathcal{D}_{\text{distinct}}(s)}{s(s+1)} - 2 \frac{-\zeta'(s)/\zeta(s)}{(s-1)(s+1)} + \frac{1}{(s-1)^2 s(s+1)}.
\]
Substituting $\mathcal{D}_{\text{distinct}}(s) = (-\zeta'/\zeta)^2 - H(s)$:
\[
\frac{(-\zeta'/\zeta)^2 - H(s)}{s(s+1)} - \frac{2s (-\zeta'/\zeta)}{s(s-1)(s+1)} + \frac{1}{(s-1)^2 s (s+1)}
\]
\[
= \frac{(-\zeta'/\zeta)^2 - \frac{2}{s-1}(-\zeta'/\zeta) + \frac{1}{(s-1)^2} - H(s)}{s(s+1)}
= \frac{\left( -\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s-1} \right)^2 - H(s)}{s(s+1)}.
\]
The algebra closes with exact cancellation of all off-diagonal cross terms.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCenteredMellin`):
```lean
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x

theorem hasMellin_V {s : ℂ} (hs : 1 < s.re) :
    HasMellin V (-s-1)
      ((LogDerivativePole.centeredZetaLogDerivative s ^ 2 -
        SamePrimeDirichlet.H s) / (s * (s+1)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Pair correlation of zeros and primes (Montgomery 1973, Goldston-Pintz-Yıldırım 2009). The explicit analytic Mellin transform of the centered distinct-prime tent removing both the $s=1$ pole and same-prime diagonal powers as an exact quotient $\frac{(-\zeta'/\zeta - 1/(s-1))^2 - H(s)}{s(s+1)}$ is novel.
- **Advancement:** Machine-verifies the complete Mellin identity for centered distinct-prime correlation functions.
- **Target Venues:** *Mathematische Annalen* or *Advances in Mathematics*.
