# Contribution 332: Exact Integer Birth Density Difference L1 Decay and Mangoldt Series Integration

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/IntegerBirthDifferenceL1.lean`](../../formalization/BuildingBlocks/IntegerBirthDifferenceL1.lean), [`building-blocks/integer-birth/difference-l1.md`](../../building-blocks/integer-birth/difference-l1.md)  
**Classification:** Analytic Number Theory / Measure Theory / Integer Birth Densities / L1 Convergence / Fubini-Tonelli / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The continuous integer birth process models prime-power arrivals as density waves $\rho_n(j, x)$ supported on $x \ge 1$. A crucial mathematical obstacle in passing from continuous density evolutions to discrete arithmetic weights is controlling the $L^1(1, \infty)$ norm of successive step differences $\Delta \rho_n(j, x) = \rho_n(j+1, x) - \rho_n(j, x)$ when weighted by the full von Mangoldt function $\Lambda(n)$.

This contribution proves:

1. **Exact Half-Density Common Tail Identity:**  
   For all $x > 0$ and index $j$:
   $$
   \rho_j(x) - \rho_{j+1}(x) = \frac{1}{2\sqrt{x}(x+j)(x+j+1)}.
   $$
2. **Exact Strip-Plus-Tail Majorant:**  
   For $n \ge 2$, $x > 1$, the density difference is pointwise dominated by a bounded strip indicator plus an inverse algebraic tail:
   $$
   \|\rho_n(j+1, x) - \rho_n(j, x)\| \le \text{stripMajorant}_n(j, x) + \text{tailMajorant}_n(j, x).
   $$
3. **Exact $L^1$ Polynomial Clock Decay:**  
   Integrating the majorants yields the sharp $n^{-3/2}$ decay:
   $$
   \int_1^\infty \|\rho_n(j+1, x) - \rho_n(j, x)\| \, dx \le \frac{2(j+2)^2}{n^{3/2}}.
   $$
4. **Countable Von Mangoldt-Weighted $L^1$ Summability:**  
   Because $\Lambda(n) \le \log n$ and $\sum_{n} n^{-3/2} \log n < \infty$:
   $$
   \sum_{n=0}^\infty \int_1^\infty \|\Lambda(n+2) (\rho_{n+2}(j+1, x) - \rho_{n+2}(j, x))\| \, dx < \infty.
   $$
5. **Exact Termwise Interchanged Integral Formula:**  
   The countable series of signed continuous birth differences is $L^1$-integrable, and its integral equals the series of discrete birth differences:
   $$
   \int_1^\infty \sum_{n=0}^\infty \Lambda(n+2) (\rho_{n+2}(j+1, x) - \rho_{n+2}(j, x)) \, dx = \sum_{n=0}^\infty \Lambda(n+2) (b(n+2, j+1) - b(n+2, j)).
   $$

---

## 2. Mathematical Proof

### 2.1. Strip and Tail Decomposition
For $x < n - j - 1$, both densities vanish.
For $x \in [n - j - 1, n - j]$, only $\rho_n(j+1, x)$ is active, contributing a strip of width 1 bounded by $\frac{1}{2n\sqrt{\ell(n, j)}}$.
For $x \ge n - j$, both densities are active, and their difference is given by the common tail $\frac{1}{2\sqrt{x}(x+j)(x+j+1)} \le \frac{1}{2\ell(n, j) x^{3/2}}$.

### 2.2. Integration and Polynomial Decay
Integrating the strip gives $\frac{1}{2n\sqrt{\ell(n, j)}}$.
Integrating the tail over $[\ell(n, j), \infty)$ gives $\frac{1}{\ell(n, j)^{3/2}}$.
Since $\ell(n, j) \ge n / (j+2)$, $\ell(n, j)^{-3/2} \le (j+2)^2 n^{-3/2}$, giving the uniform bound $\frac{2(j+2)^2}{n^{3/2}}$.

### 2.3. Dominated Convergence
Since the $L^1$ norms are summable against $\Lambda(n+2)$, Fubini-Tonelli allows interchanging the integral and the countable sum, establishing the result.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.IntegerBirthDifferenceL1` in `formalization/BuildingBlocks/IntegerBirthDifferenceL1.lean`):
```lean
theorem difference_integral_norm_birth_bound {n j : ℕ} (hn : 2 ≤ n) :
    (∫ x in Ioi (1:ℝ), ‖birthDensity n (j+1) x-birthDensity n j x‖) ≤
      2*((j:ℝ)+2)^2/((n:ℝ)*Real.sqrt n)

theorem mangoldt_difference_integral_norm_summable (j : ℕ) :
    Summable (fun n : ℕ => ∫ x in Ioi (1:ℝ),
      ‖ArithmeticFunction.vonMangoldt (n+2) *
        (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)‖)

theorem all_birth_difference_integrable (j : ℕ) :
    IntegrableOn (fun x => ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) (Ioi 1)

theorem all_birth_difference_integral (j : ℕ) :
    (∫ x in Ioi (1:ℝ), ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) =
    ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (IntegerBirthDiscreteCorrection.discreteBirth (n+2) (j+1)-
        IntegerBirthDiscreteCorrection.discreteBirth (n+2) j)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Rudin (1987) *Real and Complex Analysis*; Montgomery & Vaughan (2007) *Multiplicative Number Theory*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Bridges continuous density models of prime arrivals with discrete arithmetic corrections via machine-verified $L^1$ dominated convergence.
- **Target Venues:** *Journal of Functional Analysis* or *Ramanujan Journal*.
