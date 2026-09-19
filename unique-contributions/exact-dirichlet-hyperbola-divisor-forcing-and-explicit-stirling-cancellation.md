# Unique Contribution 293: Exact Dirichlet Hyperbola Divisor Forcing and Explicit Stirling Cancellation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/DivisorForcingBound.lean`](../../formalization/BuildingBlocks/DivisorForcingBound.lean), [`building-blocks/mertens-transfer/divisor-forcing.md`](../../building-blocks/mertens-transfer/divisor-forcing.md)  
**Classification:** Analytic Number Theory / Dirichlet Divisor Problem / Hyperbola Method / Stirling's Approximation / Non-Asymptotic Effective Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the arithmetic transfer theory of Mertens sums and factorial cells, the centered divisor forcing functional is defined by:
\[
\text{centeredDivisorForcing}(N) = \log(N!) - \sum_{n \le N} d(n) + 2\gamma N,
\]
where $d(n) = \sum_{d \mid n} 1$ is the divisor function and $\gamma$ is the Euler–Mascheroni constant.
While the leading terms of $\log(N!)$ and $\sum_{n \le N} d(n)$ both equal $N \log N - N + O(\log N)$ and $N \log N + (2\gamma - 1)N + O(\sqrt{N})$ respectively, proving explicit, effective bounds requires non-asymptotic error control on both sums.

This contribution proves:

1. **Unconditional Non-Asymptotic Divisor Forcing Bound:**  
   For every integer $N \ge 1$:
   \[
   |\text{centeredDivisorForcing}(N)| \le 13 \sqrt{N}.
   \]
2. **Explicit Dirichlet Hyperbola Error Bound:**  
   For all $N \ge 1$, the divisor sum satisfies the explicit $O(\sqrt{N})$ error bound:
   \[
   \left| \sum_{n \le N} d(n) - (N \log N + (2\gamma - 1)N) \right| \le 10 \lfloor \sqrt{N} \rfloor.
   \]
3. **Exact Floor Hyperbola Decomposition:**  
   For any $m \le N$ with $m^2 \le N < (m+1)^2$:
   \[
   \sum_{a=1}^N \left\lfloor \frac{N}{a} \right\rfloor + m^2 = 2 \sum_{a=1}^m \left\lfloor \frac{N}{a} \right\rfloor.
   \]
4. **Explicit Log Factorial Integral Bounds (Stirling Remainder):**  
   For all $N \ge 1$:
   \[
   N \log N - N + 1 \le \log(N!) \le N \log N - N + 1 + \log N,
   \]
   yielding the explicit remainder bound:
   \[
   |\log(N!) - (N \log N - N)| \le 1 + \log N.
   \]
5. **Exact Euler–Mascheroni Harmonic Discrepancy:**  
   For all $m \ge 1$:
   \[
   0 \le H_m - \log m - \gamma \le \frac{1}{m}.
   \]

---

## 2. Mathematical Proof

### 2.1. Dirichlet Hyperbola Dissection
Let $S = \{(a, b) \in \mathbb{N}^2 : a b \le N\}$.
Decompose $S$ into regions $a \le m$, $b \le m$, and their intersection $a \le m, b \le m$:
\[
|S| + m^2 = 2 \sum_{a=1}^m \lfloor N/a \rfloor.
\]
Approximating $\lfloor N/a \rfloor$ by $N/a$ with error in $[0, 1)$:
\[
\sum_{a=1}^m \lfloor N/a \rfloor = N H_m - R_m, \quad 0 \le R_m \le m.
\]
Substituting the harmonic expansion $H_m = \log m + \gamma + O(1/m)$ and $m = \lfloor \sqrt{N} \rfloor$ yields:
\[
\left| \sum_{n \le N} d(n) - (N \log N + (2\gamma - 1)N) \right| \le 10 \lfloor \sqrt{N} \rfloor.
\]

### 2.2. Integral Comparison for Factorials
By monotonicity of $x \mapsto \log x$:
\[
\int_1^N \log x dx \le \sum_{n=1}^N \log n \le \int_1^N \log x dx + \log N.
\]
Evaluating the integral $\int_1^N \log x dx = N \log N - N + 1$ establishes the two-sided bounds.

### 2.3. Cancellation of Leading Terms
Taking the difference:
\[
\text{centeredDivisorForcing}(N) = (\log(N!) - (N \log N - N)) - \left( \sum_{n \le N} d(n) - (N \log N + (2\gamma - 1)N) \right).
\]
Applying the triangle inequality:
\[
|\text{centeredDivisorForcing}(N)| \le (1 + \log N) + 10 \lfloor \sqrt{N} \rfloor.
\]
Using $\log N \le 2\sqrt{N}$ and $1 \le \sqrt{N}$:
\[
|\text{centeredDivisorForcing}(N)| \le \sqrt{N} + 2\sqrt{N} + 10\sqrt{N} = 13\sqrt{N}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MertensTransfer` in `formalization/BuildingBlocks/DivisorForcingBound.lean`):
```lean
theorem floor_sum_hyperbola (N m : ℕ) (hm : m ≤ N)
    (hm2 : m * m ≤ N) (hN : N < (m + 1) * (m + 1)) :
    (∑ a ∈ Finset.Icc 1 N, N / a) + m * m =
      2 * (∑ a ∈ Finset.Icc 1 m, N / a)

theorem divisorSum_error_le {N : ℕ} (hN : 1 ≤ N) :
    |divisorSum N - ((N : ℝ) * Real.log N +
      (2 * Real.eulerMascheroniConstant - 1) * N)| ≤ 10 * (N.sqrt : ℝ)

theorem logFactorial_integral_bounds {N : ℕ} (hN : 1 ≤ N) :
    (N : ℝ) * Real.log N - N + 1 ≤ logFactorial N ∧
    logFactorial N ≤ (N : ℝ) * Real.log N - N + 1 + Real.log N

theorem centeredDivisorForcing_sqrt_bound {N : ℕ} (hN : 1 ≤ N) :
    |centeredDivisorForcing N| ≤ 13 * Real.sqrt N
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet (1849) hyperbola method; Voronoi (1903) and Hardy–Littlewood (1922) bounds on the divisor problem; Bordellès (2012) explicit bounds. Machine verification of the exact combinatorial hyperbola decomposition and non-asymptotic $13\sqrt{N}$ forcing bound in Lean 4 is new.
- **Advancement:** Provides an effective, machine-certified bridge between the discrete divisor sum and continuous factorial logarithms, proving that the error between discrete divisor counting and continuous phase growth is uniformly $O(\sqrt{N})$ with absolute constant 13.
- **Target Venues:** *Journal of Number Theory* or *Ramanujan Journal*.
