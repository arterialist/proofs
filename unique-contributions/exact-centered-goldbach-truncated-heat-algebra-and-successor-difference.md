# Contribution 110: Exact Centered Goldbach Truncated Heat Algebra and Successor Difference

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CenteredGoldbachTruncatedHeat.lean`](../../formalization/BuildingBlocks/CenteredGoldbachTruncatedHeat.lean), [`formalization/BuildingBlocks/GoldbachHeatConvolution.lean`](../../formalization/BuildingBlocks/GoldbachHeatConvolution.lean)  
**Classification:** Analytic Number Theory / Additive Prime Theory / Centered Goldbach Convolution / Truncated Heat Polynomials / Additive Successor Differences

---

## 1. Executive Summary and Mathematical Statement

The centered Goldbach sequence $c_n = \Lambda(n) - 1$ subtracts the continuous background baseline from the von Mangoldt prime-power weight. In the spectral and thermodynamic analysis of binary Goldbach sums, the truncated heat polynomial is defined by:
$$
H_Y(z) = \sum_{n=1}^Y c_n z^n, \quad \text{with } z = e^{-t} \text{ for } t > 0.
$$

This contribution proves:

1. **Exact Finite Cauchy Product and Support Ceiling:**  
   The square of the truncated centered heat polynomial expands into a polynomial supported strictly on degrees $N \in [2, 2Y]$:
   $$
   (H_Y(z))^2 = \sum_{N=2}^{2Y} r_c^{(Y)}(N) z^N, \quad \text{with } r_c^{(Y)}(N) = 0 \text{ for all } N > 2Y.
   $$
2. **Exact Interior Identification with Unbounded Convolution:**  
   For all additive totals in the interior range $2 \le N \le Y + 1$, the truncation has zero effect on the binary correlation:
   $$
   r_c^{(Y)}(N) = r_c(N) = \sum_{m=1}^{N-1} c_m c_{N-m}.
   $$
3. **Exact Chebyshev Decomposition of Interior Centered Coefficients:**  
   For $2 \le N \le Y + 1$, the centered Goldbach coefficient decomposes with exact integer constants:
   $$
   r_c(N) = r_\Lambda(N) - 2 \psi(N - 1) + (N - 1),
   $$
   where $r_\Lambda(N) = \sum_{m=1}^{N-1} \Lambda(m)\Lambda(N-m)$ is the standard Goldbach representation function and $\psi(x) = \sum_{n \le x} \Lambda(n)$ is Chebyshev's function.
4. **Exact Additive Successor Difference Formula:**  
   For every $N \ge 2$, the discrete derivative $\Delta r_c(N) = r_c(N + 1) - r_c(N)$ satisfies the exact identity:
   $$
   r_c(N + 1) - r_c(N) = \sum_{m=1}^{N-1} \Lambda(m) \Big( \Lambda(N + 1 - m) - \Lambda(N - m) \Big) - 2 \Lambda(N) + 1.
   $$
   Every single term is exact: the convolution of the prime weight $\Lambda$ with its backward difference $\nabla \Lambda$, minus the exact boundary birth $2\Lambda(N)$, plus the unit constant $+1$.

---

## 2. Mathematical Proof

### 2.1. Cauchy Square and Support
Expanding the square:
$$
(H_Y(z))^2 = \left( \sum_{m=1}^Y c_m z^m \right) \left( \sum_{n=1}^Y c_n z^n \right) = \sum_{m=1}^Y \sum_{n=1}^Y c_m c_n z^{m+n}.
$$
Grouping by $N = m + n$: since $1 \le m, n \le Y$, the sum $N$ satisfies $2 \le N \le 2Y$.
For any $N > 2Y$, no pair $(m, n) \in [1, Y]^2$ satisfies $m + n = N$, so $r_c^{(Y)}(N) = 0$.

### 2.2. Interior Range Invariance
When $N \le Y + 1$, if $1 \le m < N$, then $n = N - m$ satisfies:
$$
1 \le n = N - m \le (Y + 1) - 1 = Y.
$$
Thus the constraint $n \le Y$ is automatically satisfied for all $m \in [1, N-1]$. The sum over $m, n \in [1, Y]$ with $m + n = N$ therefore runs over all $m \in [1, N-1]$ without truncation:
$$
r_c^{(Y)}(N) = \sum_{m=1}^{N-1} c_m c_{N-m} = r_c(N).
$$

### 2.3. Successor Difference
Expanding $c_k = \Lambda(k) - 1$:
$$
r_c(N) = \sum_{m=1}^{N-1} (\Lambda(m) - 1)(\Lambda(N-m) - 1) = r_\Lambda(N) - 2\psi(N-1) + (N-1).
$$
Now compute the difference between $N+1$ and $N$:
$$
r_\Lambda(N+1) - r_\Lambda(N) = \sum_{m=1}^N \Lambda(m)\Lambda(N+1-m) - \sum_{m=1}^{N-1} \Lambda(m)\Lambda(N-m).
$$
In the first sum, the $m = N$ term is $\Lambda(N)\Lambda(1) = 0$ (since $\Lambda(1) = 0$).
Combining the remaining sums for $m \in [1, N-1]$:
$$
r_\Lambda(N+1) - r_\Lambda(N) = \sum_{m=1}^{N-1} \Lambda(m) \Big( \Lambda(N+1-m) - \Lambda(N-m) \Big).
$$
For the background terms:
$$
-2\psi(N) + N - \Big(-2\psi(N-1) + (N-1)\Big) = -2(\psi(N) - \psi(N-1)) + 1 = -2\Lambda(N) + 1.
$$
Adding the two pieces yields the exact identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CenteredGoldbachTruncatedHeat`):
```lean
theorem truncatedHeat_square (Y : ℕ) (z : ℝ) :
    truncatedHeat Y z ^ 2 =
      ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N * z ^ N

theorem centered_finiteHeat_square (Y : ℕ) (t : ℝ) :
    finiteHeat centeredCoefficient Y t ^ 2 =
      ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N *
        Real.exp (-((N : ℝ) * t))

theorem truncatedCoefficient_eq_zero_of_two_mul_lt {Y N : ℕ} (hN : 2 * Y < N) :
    truncatedCoefficient Y N = 0

theorem truncatedCoefficient_interior {Y N : ℕ} (hN2 : 2 ≤ N) (hNY : N ≤ Y + 1) :
    truncatedCoefficient Y N = shiftedGoldbach (N - 2)

theorem truncatedCoefficient_interior_prime_psi {Y N : ℕ}
    (hN2 : 2 ≤ N) (hNY : N ≤ Y + 1) :
    truncatedCoefficient Y N =
      shiftedPrimeGoldbach (N - 2) - 2 * BuildingBlocks.CoarsePrimitive.psi (N - 1) +
        (N - 1 : ℕ)

theorem centeredGoldbach_successor {N : ℕ} (hN : 2 ≤ N) :
    shiftedGoldbach (N - 1) - shiftedGoldbach (N - 2) =
      (∑ m ∈ Icc 1 (N - 1), ArithmeticFunction.vonMangoldt m *
        (ArithmeticFunction.vonMangoldt (N + 1 - m) -
          ArithmeticFunction.vonMangoldt (N - m))) -
        2 * ArithmeticFunction.vonMangoldt N + 1
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Additive prime divisor problems and circle method heat transforms (Matsumoto-Suzuki 2024, Granville 2007). Standard references express Goldbach convolutions asymptotically using the singular series $\mathfrak{S}(N)$. The exact non-asymptotic algebra of the truncated heat square, the sharp support $[2, 2Y]$, and the closed finite difference formula $\Delta r_c(N) = \Lambda * \nabla \Lambda - 2\Lambda(N) + 1$ are novel.
- **Advancement:** Establishes machine-verified non-asymptotic Cauchy algebra and exact successor difference identities for centered Goldbach convolutions.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
