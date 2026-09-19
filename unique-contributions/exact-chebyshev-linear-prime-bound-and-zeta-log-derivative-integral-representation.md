# Unique Contribution 241: Exact Chebyshev Linear Prime Bound and Zeta Log-Derivative Integral Representation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarsePrimeBounds.lean`](../../formalization/BuildingBlocks/CoarsePrimeBounds.lean), [`building-blocks/coarse/coarse-prime-bounds.md`](../../building-blocks/coarse/coarse-prime-bounds.md)  
**Classification:** Analytic Number Theory / Chebyshev Prime Bounds / Riemann Zeta Function / Logarithmic Derivative / Central Binomial Coefficients / Legendre Formula / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The foundational estimates of prime distribution require establishing Chebyshev's classical linear bound on the von Mangoldt summatory function $\psi(N) = \sum_{n \le N} \Lambda(n)$ and the unconditional integral representation of $-\zeta'(s)/\zeta(s)$ on $\text{Re}(s) > 1$. In machine-checked mathematics, proofs typically rely on asymptotic big-$O$ machinery or external libraries.

This contribution proves:

1. **Legendre Factorial Identity for Prime Powers:**  
   For every positive integer $N \in \mathbb{N}$, the log-factorial has an exact representation as a weighted sum over von Mangoldt coefficients:
   \[
   \log(N!) = \sum_{d=1}^N \left\lfloor \frac{N}{d} \right\rfloor \Lambda(d).
   \]
2. **Central Binomial Difference Inequality:**  
   The doubled prime sum satisfies the exact binomial difference bound:
   \[
   \psi(2N) \le \psi(N) + \log((2N)!) - 2\log(N!) = \psi(N) + \log \binom{2N}{N} \le \psi(N) + (2\log 2) N.
   \]
3. **Grand Unconditional Linear Chebyshev Bound:**  
   For every natural number $N \in \mathbb{N}$:
   \[
   \psi(N) \le (4 \log 2) \cdot N.
   \]
   The proof proceeds by complete induction on $N$ via the dyadic midpoint $m = \lfloor(N+1)/2\rfloor$ using the linear relation $6m \le 4N$.
4. **Unconditional Zeta Log-Derivative Integral Representation:**  
   For every complex frequency $s \in \mathbb{C}$ with $\text{Re}(s) > 1$:
   \[
   -\frac{\zeta'(s)}{\zeta(s)} = s \int_1^\infty \psi(\lfloor x \rfloor) x^{-(s+1)} \, dx.
   \]
   This directly establishes the link between discrete prime sums and the analytic Mellin kernel of Mathlib's native `riemannZeta` without unverified Tauberian hypotheses.

---

## 2. Mathematical Proof

### 2.1. Legendre Summation via Hyperbola Product
Using $\log(n) = \sum_{d|n} \Lambda(d)$:
\[
\log(N!) = \sum_{n=1}^N \log n = \sum_{n=1}^N \sum_{d|n} \Lambda(d) = \sum_{d=1}^N \left\lfloor \frac{N}{d} \right\rfloor \Lambda(d).
\]

### 2.2. Binomial Difference Bound
Expanding the difference:
\[
\log((2N)!) - 2\log(N!) = \sum_{n=1}^{2N} \left( \left\lfloor \frac{2N}{n} \right\rfloor - 2\left\lfloor \frac{N}{n} \right\rfloor \right) \Lambda(n).
\]
For $n \le N$, $\lfloor 2N/n \rfloor - 2\lfloor N/n \rfloor \in \{0, 1\}$.
For $N < n \le 2N$, $\lfloor N/n \rfloor = 0$ and $\lfloor 2N/n \rfloor = 1$, so the coefficient is 1.
Hence:
\[
\psi(2N) - \psi(N) = \sum_{n=N+1}^{2N} \Lambda(n) \le \log((2N)!) - 2\log(N!) = \log \binom{2N}{N}.
\]
Since $\binom{2N}{N} \le 2^{2N}$, taking logarithms yields:
\[
\psi(2N) \le \psi(N) + (2 \log 2) N.
\]

### 2.3. Strong Induction for Linear Bound
Base cases $N \le 2$ verified by exact computation ($\psi(0)=0$, $\psi(1)=0$, $\psi(2)=\log 2 \le 8\log 2$).
For $N \ge 3$, set $m = \lfloor(N+1)/2\rfloor$.
Then $m < N$ and $N \le 2m$. By monotonicity and the doubling inequality:
\[
\psi(N) \le \psi(2m) \le \psi(m) + (2\log 2)m.
\]
By inductive hypothesis $\psi(m) \le (4\log 2)m$, so:
\[
\psi(N) \le (6\log 2)m.
\]
Since $m = \lfloor(N+1)/2\rfloor$, $6m \le 3(N+1) \le 4N$ for all $N \ge 3$.
Thus $\psi(N) \le (4\log 2)N$.

### 2.4. Zeta Log-Derivative Representation
For $\text{Re}(s) > 1$:
\[
L(\Lambda, s) = \sum_{n=1}^\infty \frac{\Lambda(n)}{n^s} = -\frac{\zeta'(s)}{\zeta(s)}.
\]
Applying partial summation in integral form (`LSeries_eq_mul_integral_of_nonneg`) with the bound $\psi(N) = O(N^r)$ for $r = (\text{Re}(s)+1)/2 > 1$ yields:
\[
-\frac{\zeta'(s)}{\zeta(s)} = s \int_1^\infty \psi(\lfloor x \rfloor) x^{-(s+1)} \, dx.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarsePrimeBounds.lean`):
```lean
theorem logFactorial_eq_weighted_prime_sum (N : ℕ) :
    logFactorial N = ∑ d ∈ Finset.Icc 1 N,
      ((N / d : ℕ) : ℝ) * ArithmeticFunction.vonMangoldt d

theorem psi_double_le (N : ℕ) : psi (2 * N) ≤ psi N + (2 * N : ℕ) * Real.log 2

theorem psi_le_linear (N : ℕ) : psi N ≤ (4 * Real.log 2) * (N : ℝ)

theorem zeta_logDerivative_eq_prime_integral_unconditional {s : ℂ} (hs : 1 < s.re) :
    -deriv riemannZeta s / riemannZeta s =
      s * ∫ x : ℝ in Set.Ioi 1, (psi ⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Chebyshev's 1852 prime bounds, central binomial coefficients, and Dirichlet series representations (Chebyshev 1852, Ingham 1932, Apostol 1976). A machine-checked constructive proof of $\psi(N) \le (4\log 2)N$ via complete induction and the exact connection to Mathlib's native `riemannZeta` in Lean 4 is new.
- **Advancement:** Establishes non-asymptotic prime bounds from arithmetic first principles, removing external asymptotic approximations from the foundation of the proof.
- **Target Venues:** *American Mathematical Monthly* or *Journal of Automated Reasoning*.
