# Unique Contribution 126: Exact Centered Riesz-Mellin Identity for Distinct Prime Pairs

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean), [`building-blocks/mellin-transforms/actual-centered-mellin.md`](../../building-blocks/mellin-transforms/actual-centered-mellin.md)  
**Classification:** Analytic Number Theory / Mellin Transforms / Riesz Means / Centered Prime Pairs / Dirichlet Series Factorization

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of prime-pair correlations, the centered distinct-prime tent $V(x)$ combines the Riesz cutoff of distinct prime pairs, the atom-plus-Lebesgue cross-term $\eta(x)$, and the explicit Euler-Mascheroni baseline $B(x)$:
\[
V(x) = \sum_{n \le x} (x - n) \Lambda_{\text{distinct}}(n) - 2 \eta_{\text{sum}}(x) + B(x),
\]
where all diagonal same-prime proper powers $T(x)$ are subtracted from the full square $N(x)$.

This contribution proves:

1. **Exact Decomposition of the Centered Tent:**  
   \[
   V(x) = N(x) - T(x),
   \]
   decoupling the distinct prime pair dynamics from same-prime diagonal powers.
2. **Explicit Finite Real Cutoff Formula:**  
   For all $x \ge 0$:
   \[
   V(x) = \sum_{n=1}^{\lfloor x \rfloor} \left( (x - n) \Lambda_{\text{distinct}}(n) - \Lambda(n) \frac{x^2 - n^2}{n} \right) + B(x).
   \]
3. **Exact Centered Riesz-Mellin Formula on $\operatorname{Re}(s) > 1$:**  
   For any $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1$, the Mellin transform of the centered cutoff sum satisfies the closed algebraic identity:
   \[
   \mathcal{M}(V)(-s-1) = \frac{(\mathcal{L}_c(s))^2 - H(s)}{s(s+1)},
   \]
   where $\mathcal{L}_c(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s-1}$ is the centered logarithmic derivative of the Riemann zeta function, and $H(s)$ is the Dirichlet series of proper same-prime powers.

---

## 2. Mathematical Proof

### 2.1. Decomposition
From the definition of distinct-prime pairs:
\[
\Lambda_{\text{distinct}}(n) = \Lambda_{\text{full}}(n) - \Lambda_{\text{same}}(n).
\]
By linearity of Riesz cutoff sums:
\[
V(x) = \sum_{n \le x} (x-n)\Lambda_{\text{distinct}}(n) - 2\eta_{\text{sum}}(x) + B(x) = N(x) - T(x).
\]

### 2.2. Real Cutoff Representation
The atom-plus-Lebesgue cross term evaluates to:
\[
\eta_{\text{sum}}(x) = \sum_{n=1}^{\lfloor x \rfloor} \Lambda(n) \frac{x^2 - n^2}{2n}.
\]
Multiplying by $-2$ and combining with the distinct-prime Riesz mean yields the exact representation:
\[
V(x) = \sum_{n=1}^{\lfloor x \rfloor} \left( (x - n) \Lambda_{\text{distinct}}(n) - \Lambda(n) \frac{x^2 - n^2}{n} \right) + B(x).
\]

### 2.3. Mellin Transform Factorization
By the Mellin inversion theorem for Riesz means of Dirichlet series:
- The distinct-prime Riesz sum has Mellin transform $\frac{D_{\text{distinct}}(s)}{s(s+1)} = \frac{(\zeta'/\zeta(s))^2 - H(s)}{s(s+1)}$.
- The cross term $\eta_{\text{sum}}$ has Mellin transform $\frac{-\zeta'/\zeta(s)}{(s-1)(s+1)}$.
- The baseline $B(x)$ has Mellin transform $\frac{1}{(s-1)^2 s(s+1)}$.

Summing with weights $(1, -2, 1)$:
\[
\mathcal{M}(V)(-s-1) = \frac{(\zeta'/\zeta(s))^2 - H(s)}{s(s+1)} - \frac{2(-\zeta'/\zeta(s))}{(s-1)(s+1)} + \frac{1}{(s-1)^2 s(s+1)}.
\]
Factoring over the common denominator $s(s+1)$:
\[
(\zeta'/\zeta(s))^2 + 2\frac{s}{s-1}\zeta'/\zeta(s) + \frac{1}{(s-1)^2} - H(s) = \left(-\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s-1}\right)^2 - H(s) = (\mathcal{L}_c(s))^2 - H(s).
\]
Dividing by $s(s+1)$ yields the exact identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCenteredMellin`):
```lean
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

theorem etaSum_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    etaSum x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((ArithmeticFunction.vonMangoldt n *
          ((x^2 - (n : ℝ)^2) / (2 * n)) : ℝ) : ℂ)

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

- **Prior Literature:** Riesz typical means and Mellin transforms of Dirichlet series (Hardy-Riesz 1915, Chandrasekharan-Minakshisundaram 1952). The exact machine formalization of the centered Riesz-Mellin identity removing diagonal proper prime powers in Lean 4 is novel.
- **Advancement:** Establishes machine-verified algebraic collapse of centered distinct-prime pair Riesz cutoffs to the squared centered logarithmic derivative.
- **Target Venues:** *Ramanujan Journal* or *Journal of the London Mathematical Society*.
