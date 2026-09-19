# Unique Contribution 136: Exact Critical Convergence Abscissa and Landau Singularity Barrier

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCriticalConvergence.lean`](../../formalization/BuildingBlocks/ActualCriticalConvergence.lean), [`building-blocks/laplace/actual-critical-convergence.md`](../../building-blocks/laplace/actual-critical-convergence.md)  
**Classification:** Analytic Number Theory / Laplace Transforms / Landau Singularity Theorem / Convergence Abscissa / Analytic Continuation / Critical Line Barrier

---

## 1. Executive Summary and Mathematical Statement

In the spectral and transform-theoretic analysis of the Riemann zeta function, establishing the abscissa of convergence for positive/signed Laplace measures is obstructed by potential zeros in the critical strip. Landau's classical singularity theorem states that for a non-negative measure on $[0, \infty)$, the real boundary point of its half-plane of convergence $s = \sigma_c$ must be an essential singularity.

This contribution proves:

1. **Exact Abscissa Barrier at the Critical Line:**  
   Let $A \ge 1$ be a cutoff such that the critical Mellin kernel has negative tail real part: $\operatorname{Re}(W(x)) \le 0$ for all $x > A$.
   If the convergence set of the tail Laplace measure is bounded below, its convergence abscissa $\sigma_c$ satisfies:
   \[
   \sigma_c \le \frac{1}{2}.
   \]
2. **Universal Laplace Integrability Above Half:**  
   Under the negative-tail condition, the Laplace transform of the tail measure converges and is strictly integrable at every real parameter:
   \[
   \int_0^\infty e^{-\sigma t} d\mu_A(t) < \infty \quad \text{for all } \sigma > \frac{1}{2}.
   \]
3. **Holomorphy on the Open Half-Plane $\operatorname{Re}(s) > 1/2$:**  
   The Laplace moment function:
   \[
   s \mapsto \int_0^\infty e^{-s t} d\mu_A(t)
   \]
   is analytic on the entire half-plane $\{s \in \mathbb{C} \mid \operatorname{Re}(s) > 1/2\}$.
4. **Analytic Continuation Matching Filled Transform:**  
   The continuation candidate $F_A(s) = \mathcal{M}(W_{\text{init}, A})(-s-1) - \int_0^\infty e^{-st} d\mu_A(t)$ is analytic on $\operatorname{Re}(s) > 1/2$ and identically equals the pole-filled transform $\Phi(s)$ for $\operatorname{Re}(s) > 1$.

---

## 2. Mathematical Proof

### 2.1. Real-Axis Analyticity of Continuation Candidate
The tail transform is defined by:
\[
F_A(s) = \mathcal{M}(W_{\text{init}, A})(-s-1) - \Phi(s),
\]
where $W_{\text{init}, A}$ is supported on $[1, A]$ and $\Phi(s)$ is the critical transform with trivial poles removed.
Since $W_{\text{init}, A}$ has compact support, its Mellin transform is entire. By previous construction (`CriticalTransformRealAxis`), $\Phi(s)$ has no poles on the open real ray $(1/2, \infty)$. Thus $F_A(\sigma)$ is analytic at every real point $\sigma > 1/2$.

### 2.2. Landau Singularity Barrier
Assume for contradiction that $\sigma_c > 1/2$.
Then $\sigma_c$ is finite and lies in the domain of real-axis analyticity of $F_A$.
By Landau's theorem for positive measures, the abscissa point $\sigma_c \in \mathbb{R}$ is a singular point of the function represented by the Laplace integral $\int_0^\infty e^{-st} d\mu_A(t)$.
However, for $\operatorname{Re}(s) > 1$, the Laplace integral equals $F_A(s)$. Since $F_A(s)$ is analytic in a disk centered at $\sigma_c$, it provides an analytic continuation of the Laplace integral past $\sigma_c$, contradicting Landau's theorem.
Therefore, $\sigma_c \le 1/2$.

### 2.3. Extension to the Entire Half-Plane $\operatorname{Re}(s) > 1/2$
Since $\sigma_c \le 1/2$, every point with $\operatorname{Re}(s) > 1/2$ has $\operatorname{Re}(s) > \sigma_c$, which guarantees absolute convergence and holomorphy of the Laplace transform on $\{s \in \mathbb{C} \mid \operatorname{Re}(s) > 1/2\}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCriticalConvergence`):
```lean
theorem finite_abscissa_le_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time) ≤ (1 : ℝ) / 2

theorem laplace_integrable_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    Integrable (fun x => Real.exp (-σ * ActualCriticalMeasure.time x))
      (ActualCriticalMeasure.tailMeasure A)

theorem laplace_analyticOnNhd_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re}

theorem continuation_analyticOnNhd {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (continuation A) {s : ℂ | (1 : ℝ) / 2 < s.re}

theorem continuation_eq_filledTransform {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    continuation A s = CriticalTransformPoles.filledTransform s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Landau's theorem on Dirichlet series and Laplace transforms with non-negative coefficients (Landau 1905, Widder 1941). The formal verification in Lean 4 connecting Landau's singularity theorem to the critical line abscissa barrier $\sigma_c \le 1/2$ for zeta-derived measures is novel.
- **Advancement:** Establishes machine-verified critical line barrier $\sigma_c \le 1/2$ and open half-plane holomorphy using Landau's singularity theorem in Lean 4.
- **Target Venues:** *Journal of Functional Analysis* or *Journal of Number Theory*.
