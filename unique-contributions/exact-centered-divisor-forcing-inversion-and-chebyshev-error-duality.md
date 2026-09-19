# Unique Contribution 117: Exact Centered-Divisor Forcing Inversion and Chebyshev Error Duality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MertensArithmetic.lean`](../../formalization/BuildingBlocks/MertensArithmetic.lean), [`formalization/BuildingBlocks/DivisorForcingBound.lean`](../../formalization/BuildingBlocks/DivisorForcingBound.lean)  
**Classification:** Analytic Number Theory / Divisor Problems / Möbius Hyperbola Inversion / Chebyshev Prime Errors / Euler-Mascheroni Invariants

---

## 1. Executive Summary and Mathematical Statement

In classical analytic number theory, the connection between Dirichlet's divisor problem and Chebyshev's prime error function is typically established through contour integrals and Perron inversion of $\frac{\zeta'(s)}{\zeta(s)}$ and $\zeta(s)^2$.

This contribution proves:

1. **Exact Divisor Forcing Recurrence:**  
   The discrete Chebyshev prime error $E(N) = \psi(N) - N$ satisfies the exact hyperbola floor convolution:
   \[
   \sum_{k=1}^N E(\lfloor N/k \rfloor) = \mathcal{R}(N) = \log(N!) - \sum_{k=1}^N \lfloor N/k \rfloor.
   \]
2. **Exact Möbius Hyperbola Floor Inversion:**  
   For any arithmetic function $f : \mathbb{N} \to \mathbb{R}$ and all $N \ge 1$:
   \[
   \sum_{d=1}^N \mu(d) \sum_{k \le N/d} f(\lfloor (N/d)/k \rfloor) = f(N).
   \]
   Consequently, the Chebyshev prime error is the exact Möbius convolution of the recurrence forcing:
   \[
   \psi(N) - N = \sum_{d=1}^N \mu(d) \mathcal{R}(\lfloor N/d \rfloor).
   \]
3. **Möbius Floor Mass Invariant:**  
   For all $N \ge 1$, the Möbius sum weighted by integer parts contracts identically to unity:
   \[
   \sum_{d=1}^N \mu(d) \lfloor N/d \rfloor = 1.
   \]
4. **Centered Divisor Inversion with Euler-Mascheroni Shift:**  
   The centered Dirichlet divisor forcing $\mathcal{F}_c(N) = \log(N!) - \sum_{n=1}^N d(n) + 2\gamma N$ inverts under the Möbius function to the integer Chebyshev error shifted by exactly $2\gamma$:
   \[
   \sum_{d=1}^N \mu(d) \mathcal{F}_c(\lfloor N/d \rfloor) = (\psi(N) - N) + 2\gamma.
   \]

---

## 2. Mathematical Proof

### 2.1. Hyperbola Factorization and Forcing Recurrence
Using $\log n = \sum_{d \mid n} \Lambda(d)$:
\[
\log(N!) = \sum_{n=1}^N \log n = \sum_{n=1}^N \sum_{d \mid n} \Lambda(d) = \sum_{k=1}^N \sum_{d \le N/k} \Lambda(d) = \sum_{k=1}^N \psi(\lfloor N/k \rfloor).
\]
Subtracting $\sum_{k=1}^N \lfloor N/k \rfloor$ gives:
\[
\sum_{k=1}^N (\psi(\lfloor N/k \rfloor) - \lfloor N/k \rfloor) = \log(N!) - \sum_{k=1}^N \lfloor N/k \rfloor = \mathcal{R}(N).
\]

### 2.2. Möbius Floor Inversion
Using Dirichlet hyperbola summation and the fundamental Möbius property $\sum_{d \mid n} \mu(d) = \mathbf{1}_{n=1}$:
\[
\sum_{d=1}^N \mu(d) \sum_{k \le N/d} f(\lfloor N/(dk) \rfloor) = \sum_{n=1}^N f(\lfloor N/n \rfloor) \sum_{d \mid n} \mu(d) = f(N) \cdot 1 + 0 = f(N).
\]
Applying this to $f(N) = \psi(N) - N$ and substituting $\sum_{k \le N/d} f(\lfloor (N/d)/k \rfloor) = \mathcal{R}(\lfloor N/d \rfloor)$ yields:
\[
\psi(N) - N = \sum_{d=1}^N \mu(d) \mathcal{R}(\lfloor N/d \rfloor).
\]

### 2.3. Möbius Floor Mass
Similarly, for $f(n) = 1$ when $n=1$ and $0$ otherwise, $\sum_{k \le N} \lfloor N/k \rfloor$ contracts:
\[
\sum_{d=1}^N \mu(d) \lfloor N/d \rfloor = \sum_{n=1}^N \sum_{d \mid n} \mu(d) = \sum_{n=1}^N \mathbf{1}_{n=1} = 1.
\]

### 2.4. Centered Divisor Inversion
By definition, $\mathcal{F}_c(N) = \mathcal{R}(N) + 2\gamma N$.
Convolving with $\mu(d)$:
\[
\sum_{d=1}^N \mu(d) \mathcal{F}_c(\lfloor N/d \rfloor) = \sum_{d=1}^N \mu(d) \mathcal{R}(\lfloor N/d \rfloor) + 2\gamma \sum_{d=1}^N \mu(d) \lfloor N/d \rfloor.
\]
Substituting the previous identities gives:
\[
(\psi(N) - N) + 2\gamma \cdot 1 = (\psi(N) - N) + 2\gamma.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MertensTransfer`):
```lean
theorem logFactorial_eq_sum_psi (N : ℕ) :
    logFactorial N = ∑ k ∈ Finset.Icc 1 N, psi (N / k)

theorem sum_integerError_eq_forcing (N : ℕ) :
    ∑ k ∈ Finset.Icc 1 N, integerError (N / k) = recurrenceForcing N

theorem moebius_floor_mass {N : ℕ} (hN : 0 < N) :
    ∑ k ∈ Finset.Icc 1 N,
      ArithmeticFunction.moebius k * ((N / k : ℕ) : ℤ) = 1

theorem moebius_floor_inversion (f : ℕ → ℝ) {N : ℕ} (hN : 1 ≤ N) :
    (∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ k ∈ Finset.Icc 1 (N / d), f (N / d / k)) = f N

theorem integerError_eq_moebius_recurrenceForcing {N : ℕ} (hN : 1 ≤ N) :
    integerError N = ∑ d ∈ Finset.Icc 1 N,
      (ArithmeticFunction.moebius d : ℝ) * recurrenceForcing (N / d)

theorem centeredDivisorForcing_inverse {N : ℕ} (hN : 1 ≤ N) :
    (∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      centeredDivisorForcing (N / d)) =
        integerError N + 2 * Real.eulerMascheroniConstant
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet's divisor problem and Chebyshev's identities (Dirichlet 1849, Chebyshev 1852, Ingham 1932). The exact finite algebraic duality between centered divisor forcing and the Chebyshev error shifted by $2\gamma$ via the unit-mass identity $\sum_{d \le N} \mu(d)\lfloor N/d \rfloor = 1$ in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact discrete inversion relating the Dirichlet divisor remainder to the Chebyshev prime error with the explicit topological shift $2\gamma$.
- **Target Venues:** *The Ramanujan Journal* or *American Mathematical Monthly*.
