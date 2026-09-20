# Contribution 265: Exact Finite Prime-Cross Laplace Factorization and Zeta Logarithmic Derivative Convergence

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CriticalChirpedLaplaceFinite.lean`](../../formalization/BuildingBlocks/CriticalChirpedLaplaceFinite.lean), [`building-blocks/spectral/critical-chirped-laplace-finite.md`](../../building-blocks/spectral/critical-chirped-laplace-finite.md)  
**Classification:** Analytic Number Theory / Spectral Theory / Laplace Transforms / Dirichlet Series / Zeta Logarithmic Derivative / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of prime-counting wave packets, the finite actual-prime cross product:
$$
\text{actualCrossFinite}(N, C, d) = \sum_{n=2}^N \frac{\Lambda(n)}{\sqrt{n}} C(\log n - d)
$$
encodes prime locations through localized test convolutions. Connecting this spatial cross-correlation to the Riemann zeta function requires computing its complex Laplace transform and taking the infinite-cutoff limit without assuming unverified interchanges.

This contribution proves:

1. **Exact Finite Laplace Factorization Identity:**  
   For any continuous correlation function $C : \mathbb{R} \to \mathbb{C}$ supported in $[-w, w]$ with $w < \log 2$, any complex spectral parameter $z \in \mathbb{C}$, and any integration cutoff $R \ge \log N + w$:
   $$
   \int_0^R e^{-z d} \text{actualCrossFinite}(N, C, d) \, dd = \left( \sum_{n=2}^N \frac{\Lambda(n)}{n^{z + 1/2}} \right) \left( \int_{-w}^w e^{z y} C(y) \, dy \right).
   $$
   The arithmetic Dirichlet polynomial in $s = z + 1/2$ factors completely from the continuous test function moment, with zero boundary truncation loss.
2. **Dirichlet Polynomial Convergence to $-\zeta'/\zeta$:**  
   On the half-plane $\text{Re}(s) > 1$, the finite prime Dirichlet polynomials converge unconditionally to the logarithmic derivative of the actual Riemann zeta function:
   $$
   \lim_{N \to \infty} \sum_{n=2}^N \frac{\Lambda(n)}{n^s} = - \frac{\zeta'}{\zeta}(s).
   $$
3. **Laplace Limit Theorem:**
   When $\text{Re}(z + 1/2) > 1$ (i.e. $\text{Re}(z) > 1/2$), the finite Laplace transforms integrated past all prime support endpoints converge to:
   $$
   \lim_{N \to \infty} \int_0^{\log N + w} e^{-z d} \text{actualCrossFinite}(N, C, d) \, dd = - \frac{\zeta'}{\zeta}\left(z + \frac{1}{2}\right) \left( \int_{-w}^w e^{z y} C(y) \, dy \right).
   $$
   This establishes the exact machine-verified bridge between the physical prime correlation cross and the analytic logarithmic derivative of $\zeta(s)$.

---

## 2. Mathematical Proof

### 2.1. Spatial Convolution and Moment Factorization
For each $n \in [2, N]$, set $r = \log n$.
The term integral is $\int_0^R e^{-z d} C(r - d) dd$.
Substituting $y = r - d$:
$$
\int_0^R e^{-z d} C(r - d) dd = e^{-z r} \int_{r - R}^r e^{z y} C(y) dy.
$$
Since $C$ is supported in $[-w, w]$, $r - R \le -w$ (as $R \ge r + w$), and $w \le r = \log n$ (since $n \ge 2 \implies r \ge \log 2 > w$), the interval $[r - R, r]$ contains the entire support $[-w, w]$.
Since $C(y) = 0$ on $[r - R, -w]$ and $[w, r]$, the integral reduces to:
$$
\int_{r - R}^r e^{z y} C(y) dy = \int_{-w}^w e^{z y} C(y) dy.
$$
Summing over $n \in [2, N]$:
$$
\sum_{n=2}^N \frac{\Lambda(n)}{\sqrt{n}} e^{-z \log n} \left( \int_{-w}^w e^{z y} C(y) dy \right).
$$
Noting that $\frac{1}{\sqrt{n}} e^{-z \log n} = e^{-(z + 1/2)\log n} = n^{-(z + 1/2)}$, the sum becomes $\sum_{n=2}^N \frac{\Lambda(n)}{n^{z + 1/2}}$.

### 2.2. Convergence on $\text{Re}(s) > 1$
By mathlib's absolute convergence theorem for the von Mangoldt Dirichlet series (`ActualArchimedeanFactor.zeta_prime_series`), the series $\sum_{n=1}^\infty \frac{\Lambda(n)}{n^s}$ converges absolutely to $-\zeta'(s)/\zeta(s)$ on $\text{Re}(s) > 1$.
Since $\Lambda(1) = 0$, the sum from $n=2$ to $N$ converges to the full series sum. Multiplying by the constant test-function moment preserves convergence under the filter `atTop`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CriticalChirpedLaplaceFinite` in `formalization/BuildingBlocks/CriticalChirpedLaplaceFinite.lean`):
```lean
theorem actual_cross_laplace_dirichlet_finite (N : ℕ) (C : ℝ → ℂ)
    (z : ℂ) (w R : ℝ) (hw : w < Real.log 2)
    (hR : ∀ n ∈ Finset.Icc 2 N, Real.log (n : ℝ) + w ≤ R)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0) :
    (∫ d in (0 : ℝ)..R,
      Complex.exp (-z * (d : ℂ)) *
        CriticalChirpedEndpointFinite.actualCrossFinite N C d) =
      (∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ) /
          ((n : ℂ) ^ (z + (1 / 2 : ℂ)))) *
      (∫ y in (-w)..w, momentIntegrand C z y)

theorem prime_dirichlet_polynomial_tendsto_zeta (s : ℂ) (hs : 1 < s.re) :
    Filter.Tendsto (fun N : ℕ => primeDirichletPolynomial N s)
      Filter.atTop (nhds (-logDeriv riemannZeta s))

theorem finite_cross_laplace_tendsto_logderiv (C : ℝ → ℂ)
    (z : ℂ) (w : ℝ) (hw : w < Real.log 2)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0)
    (hz : 1 < (z + (1 / 2 : ℂ)).re) :
    Filter.Tendsto
      (fun N : ℕ => ∫ d in (0 : ℝ)..(Real.log (N : ℝ) + w),
        Complex.exp (-z * (d : ℂ)) *
          CriticalChirpedEndpointFinite.actualCrossFinite N C d)
      Filter.atTop
      (nhds ((-logDeriv riemannZeta (z + (1 / 2 : ℂ))) *
        (∫ y in (-w)..w, momentIntegrand C z y)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet series, Laplace transforms, and explicit formulas (Montgomery-Vaughan 2007, Titchmarsh 1986). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact finite-cutoff spectral representation of the prime cross-correlation without assuming infinite-integral interchanges.
- **Target Venues:** *Journal of Number Theory* or *Transactions of the American Mathematical Society*.
