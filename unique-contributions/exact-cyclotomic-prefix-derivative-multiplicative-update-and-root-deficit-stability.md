# Unique Contribution 329: Exact Cyclotomic Prefix Derivative Multiplicative Update and Root Deficit Stability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CyclotomicPrefix.lean`](../../formalization/BuildingBlocks/CyclotomicPrefix.lean), [`building-blocks/cyclotomic-boundary/prefix.md`](../../building-blocks/cyclotomic-boundary/prefix.md)  
**Classification:** Algebraic Number Theory / Cyclotomic Polynomials / Boundary Dynamics / Derivative Deficits / Roots of Unity / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The cumulative cyclotomic prefix polynomial $P_N(z) = \prod_{m=1}^N \Phi_m(z)$ packages all primitive roots of unity of orders up to $N$. The stability of its derivative at an old root of unity $\alpha$ of order $n < N$ determines the spectral confinement of boundary states.

This contribution proves:

1. **Exact Multiplicative Derivative Update at Old Roots:**  
   For any primitive root of unity $\alpha$ of order $n < N$:
   \[
   P_N'(\alpha) = P_{N-1}'(\alpha) \cdot \Phi_N(\alpha).
   \]
   Because $\alpha$ is a root of $P_{N-1}(z)$, the Leibniz term $P_{N-1}(\alpha) \Phi_N'(\alpha)$ vanishes identically, isolating the exact multiplier $\Phi_N(\alpha)$.
2. **Non-Vanishing Derivative and Simplicity of Prefix Roots:**  
   For any $n \le N$ and primitive $n$-th root $\alpha$:
   \[
   P_N'(\alpha) \ne 0.
   \]
   Thus, all roots of $P_N(z)$ are simple roots, and the logarithmic derivative deficit $\mathcal{D}_N(\alpha) = \max(0, -\log \|P_N'(\alpha)\|)$ is well-defined and finite.
3. **Exact Logarithmic Deficit Update Bound:**  
   The discrete update in root deficit $\Delta \mathcal{D}_N(\alpha) = \mathcal{D}_N(\alpha) - \mathcal{D}_{N-1}(\alpha)$ satisfies:
   \[
   |\Delta \mathcal{D}_N(\alpha)| \le |\log \|\Phi_N(\alpha)\||.
   \]
4. **Divisor-Logarithm Growth Bound:**  
   Under regularized cyclotomic identities:
   \[
   |\Delta \mathcal{D}_N(\alpha)| \le d(N) \log N.
   \]

---

## 2. Mathematical Proof

### 2.1. Leibniz Rule at Roots
$P_N(z) = P_{N-1}(z) \Phi_N(z)$.
Differentiating: $P_N'(z) = P_{N-1}'(z) \Phi_N(z) + P_{N-1}(z) \Phi_N'(z)$.
Since $n < N$, $\Phi_n \mid P_{N-1}$, so $P_{N-1}(\alpha) = 0$.
The second term drops out, leaving $P_N'(\alpha) = P_{N-1}'(\alpha) \Phi_N(\alpha)$.

### 2.2. Simplicity of Roots
Since $\Phi_n$ is separable, $\Phi_n'(\alpha) \ne 0$.
For any $m \ne n$, $\Phi_m(\alpha) \ne 0$.
Factoring $P_N(z) = \Phi_n(z) \prod_{m \ne n, m \le N} \Phi_m(z)$ and evaluating the derivative at $\alpha$ gives $P_N'(\alpha) = \Phi_n'(\alpha) \prod_{m \ne n} \Phi_m(\alpha) \ne 0$.

### 2.3. Logarithmic Deficit Lipschitz Stability
The function $f(x) = \max(0, -x)$ is 1-Lipschitz: $|f(x) - f(y)| \le |x - y|$.
With $x = \log \|P_N'(\alpha)\| = \log \|P_{N-1}'(\alpha)\| + \log \|\Phi_N(\alpha)\|$ and $y = \log \|P_{N-1}'(\alpha)\|$, the difference is exactly $\log \|\Phi_N(\alpha)\|$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CyclotomicBoundary` in `formalization/BuildingBlocks/CyclotomicPrefix.lean`):
```lean
theorem prefixPolynomial_step {N : ℕ} (hN : 1 ≤ N) :
    prefixPolynomial N = prefixPolynomial (N - 1) * Polynomial.cyclotomic N ℂ

theorem prefixDerivative_old_step {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).derivative.eval α =
      (prefixPolynomial (N - 1)).derivative.eval α *
        (Polynomial.cyclotomic N ℂ).eval α

theorem prefixDerivative_ne_zero {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hnN : n ≤ N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).derivative.eval α ≠ 0

theorem oldRootUpdate_abs_le_factorLog {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n) :
    |oldRootUpdate N α| ≤ |Real.log ‖(Polynomial.cyclotomic N ℂ).eval α‖|

theorem oldRootUpdate_abs_le {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n)
    (hidentity : OldFactorRegularizedIdentity α n N) :
    |oldRootUpdate N α| ≤ (N.divisors.card : ℝ) * Real.log N
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Lang (2002) *Algebra* (Cyclotomic Polynomials); Montgomery & Vaughan (2007) *Multiplicative Number Theory*. Machine verification of exact cyclotomic prefix derivative step updates and root deficit Lipschitz stability in Lean 4 is new.
- **Advancement:** Establishes the exact multiplicative evolution of polynomial derivatives at roots of unity across cyclotomic tower extensions, bounding local root deficit jumps by incoming cyclotomic evaluations.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
