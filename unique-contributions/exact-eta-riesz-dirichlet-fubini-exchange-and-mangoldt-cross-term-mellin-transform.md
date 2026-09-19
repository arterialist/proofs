# Unique Contribution 165: Exact Eta-Riesz-Dirichlet Fubini Exchange and Mangoldt Cross-Term Mellin Transform

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/EtaRieszDirichlet.lean`](../../formalization/BuildingBlocks/EtaRieszDirichlet.lean), [`building-blocks/mellin/eta-riesz-dirichlet.md`](../../building-blocks/mellin/eta-riesz-dirichlet.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Mellin Transforms / Dominated Convergence / Fubini Interchanges / Von Mangoldt Arithmetic Series

---

## 1. Executive Summary and Mathematical Statement

In the spectral formulation of the prime-pair autocorrelation, the cross term between the discrete prime-power birth measures and the continuous background density creates the quadratic kernel $\frac{x^2 - n^2}{2n}$ truncated at the birth endpoint $x \ge n$. To connect this finite arithmetic cutoff sum directly to the Riemann zeta function, one must rigorously justify the interchange of summation and infinite improper Mellin integration without circular analytic continuation assumptions.

This contribution proves:

1. **Exact Finite Cutoff Identity for Infinite Series of Eta Kernels:**  
   For any Dirichlet sequence $c: \mathbb{N} \to \mathbb{C}$ and any $x \in \mathbb{R}$:
   \[
   \sum_{n=0}^\infty c(n+1) K_\eta(n+1, x) = \sum_{n \in [0, \lfloor x \rfloor)} c(n+1) K_\eta(n+1, x) = \text{cutoffSum}(c, x),
   \]
   since $K_\eta(n+1, x) = \frac{x^2 - (n+1)^2}{2(n+1)} \mathbf{1}_{x > n+1}$ vanishes identically for all $n \ge \lfloor x \rfloor$.
2. **General Eta-Riesz-Dirichlet Fubini Exchange Theorem:**  
   If the coefficient sequence $c$ satisfies the absolute Dirichlet convergence condition:
   \[
   \sum_{n=0}^\infty \|c(n+1)\| (n+1)^{-\text{Re}(s)} < \infty \quad \text{for } \text{Re}(s) > 1,
   \]
   then the Mellin transform of the finite cutoff sum converges on $\text{Re}(s) > 1$ and evaluates identically to:
   \[
   \mathcal{M}\left( \sum_{n \le x} c(n) \frac{x^2 - n^2}{2n} \right)(-s-1) = \frac{\sum_{n=1}^\infty c(n) n^{-s}}{(s-1)(s+1)}.
   \]
3. **Exact Von Mangoldt Cross-Term Mellin Transform:**  
   Specializing to $c(n) = \Lambda(n)$, the actual prime cross term $\text{crossTerm}(x) = \sum_{n \le x} \Lambda(n) \frac{x^2 - n^2}{2n}$ has the exact Mellin transform:
   \[
   \mathcal{M}(\text{crossTerm})(-s-1) = \frac{-\frac{\zeta'(s)}{\zeta(s)}}{(s-1)(s+1)} \quad (\text{Re}(s) > 1).
   \]

---

## 2. Mathematical Proof

### 2.1. Finite Cutoff Sum Support
The eta kernel is defined by $K_\eta(a, x) = \frac{x^2 - a^2}{2a}$ if $x > a$ and $0$ otherwise.
For $a = n + 1$, if $n \ge \lfloor x \rfloor$, then $n + 1 > \lfloor x \rfloor + 1 > x$.
Hence $x - (n+1) \le 0$, which implies $K_\eta(n+1, x) = 0$.
Thus the infinite series $\sum_{n=0}^\infty c(n+1) K_\eta(n+1, x)$ terminates at $n = \lfloor x \rfloor - 1$, coinciding with the finite cutoff sum.

### 2.2. Dominated Convergence and Fubini Interchange
Consider the bivariate kernel on $(0, \infty) \times \mathbb{N}$:
\[
g(x, n) = x^{-s-2} c(n+1) K_\eta(n+1, x).
\]
For each fixed $n$, the Mellin transform integral evaluates to:
\[
\int_0^\infty x^{-s-2} K_\eta(n+1, x) dx = \frac{(n+1)^{-s}}{(s-1)(s+1)}.
\]
The $L^1$ norm of the integrand on $(0, \infty)$ satisfies:
\[
\int_0^\infty \|g(x, n)\| dx = \frac{\|c(n+1)\| (n+1)^{-\text{Re}(s)}}{(\text{Re}(s)-1)(\text{Re}(s)+1)}.
\]
Summing over $n \in \mathbb{N}$, the series of $L^1$ norms is bounded by:
\[
\frac{1}{(\text{Re}(s)-1)(\text{Re}(s)+1)} \sum_{n=0}^\infty \|c(n+1)\| (n+1)^{-\text{Re}(s)} < \infty.
\]
By the Lebesgue-Fubini theorem for series of integrable functions (`SummableIntegrals.integrable_tsum_of_summable_integral_norm`), the sum and the integral commute:
\[
\int_0^\infty x^{-s-2} \left( \sum_{n=0}^\infty c(n+1) K_\eta(n+1, x) \right) dx = \sum_{n=0}^\infty \int_0^\infty g(x, n) dx = \frac{\sum_{n=1}^\infty c(n) n^{-s}}{(s-1)(s+1)}.
\]

### 2.3. Specialization to Von Mangoldt
For $c(n) = \Lambda(n)$, the Dirichlet series is the logarithmic derivative of $\zeta(s)$:
\[
\sum_{n=1}^\infty \frac{\Lambda(n)}{n^s} = -\frac{\zeta'(s)}{\zeta(s)} \quad (\text{Re}(s) > 1).
\]
Applying the general Fubini exchange theorem yields the closed form $\frac{-\zeta'(s)/\zeta(s)}{(s-1)(s+1)}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.EtaRieszDirichlet` in `formalization/BuildingBlocks/EtaRieszDirichlet.lean`):
```lean
theorem kernel_eq_zero_outside_cutoff (x : ℝ) {n : ℕ}
    (hn : n ∉ Finset.range ⌊x⌋₊) : EtaRieszKernel.kernel (n + 1) x = 0

theorem tsum_tents_eq_cutoff (c : ℕ → ℂ) (x : ℝ) :
    (∑' n : ℕ, c (n + 1) * EtaRieszKernel.kernel (n + 1) x) = cutoffSum c x

theorem hasMellin_cutoffSum (c : ℕ → ℂ) {s : ℂ} (hs : 1 < s.re)
    (hc : Summable (fun n : ℕ => ‖c (n + 1)‖ * (n + 1 : ℝ) ^ (-s.re))) :
    HasMellin (cutoffSum c) (-s - 1)
      ((∑' n : ℕ, c (n + 1) * ((n + 1 : ℝ) : ℂ) ^ (-s)) / ((s - 1) * (s + 1)))

theorem hasMellin_crossTerm {s : ℂ} (hs : 1 < s.re) :
    HasMellin crossTerm (-s-1)
      ((-deriv riemannZeta s / riemannZeta s) / ((s-1)*(s+1)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Quadratic Mellin kernels in prime number theory (Ingham 1932, Montgomery-Vaughan 2007). Machine formalization of exact Fubini interchanges for truncated quadratic eta kernels has not been previously achieved in Lean 4.
- **Advancement:** Establishes the exact continuous Mellin transform of discrete quadratic arithmetic cutoff sums with machine-verified Fubini dominated convergence in Lean 4.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Rocky Mountain Journal of Mathematics*.
