# Unique Contribution 46: The Arithmetic Birth Gram Kernel and Universal Positive Semidefiniteness

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenBirthGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthGram.lean), [`formalization/BuildingBlocks/ChargeFrozenBirthFiniteGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthFiniteGram.lean)  
**Classification:** Analytic Number Theory / Integral Operators / Reproducing Kernels / Matrix Inequalities

---

## 1. Executive Summary and Mathematical Statement

The prime birth increments $\delta_n(v) = a_{n+1}(v) - a_n(v)$ define a sequence of localized states in the Hilbert space $L^2(0, \infty)$ indexed by integers $n \ge 2$.  
This contribution establishes:

1. **Closed Arithmetic Form of the Gram Matrix:**
   For any integers $m, n \ge 2$, the $L^2$ inner product $K(m, n) = \langle \delta_m, \delta_n \rangle = \int_0^\infty \delta_m(v) \delta_n(v) dv$ evaluates to the exact arithmetic kernel:
   \[
   K(m, n) = \begin{cases}
   (\Lambda(m+1) - 1) \left( \frac{\Lambda(n+1)}{n+1} - \log\left(1 + \frac{1}{n}\right) \right), & m < n, \\
   (\Lambda(n+1) - 1) \left( \frac{\Lambda(m+1)}{m+1} - \log\left(1 + \frac{1}{m}\right) \right), & n < m, \\
   1 + \frac{m}{m+1} - 2m \log\left(1 + \frac{1}{m}\right) + \frac{(\Lambda(m+1) - 1)^2}{m+1}, & m = n.
   \end{cases}
   \]
2. **Rank-One Structural Factorization:**
   For all off-diagonal entries $m < n$, the dependence on the earlier index $m$ factors completely as a single scalar multiplier $(\Lambda(m+1) - 1)$, while the dependence on the later index $n$ is precisely the prime discrepancy step $\frac{\Lambda(n+1)}{n+1} - \log\left(1 + \frac{1}{n}\right)$.
3. **Universal Finite Positive Semidefiniteness:**
   For **any** finite subset $s \subset \{n \in \mathbb{N} \mid n \ge 2\}$ and **any** real coefficients $(c_n)_{n \in s} \in \mathbb{R}^{|s|}$, the arithmetic matrix $K$ is unconditionally positive semidefinite:
   \[
   \sum_{m \in s} \sum_{n \in s} c_m c_n K(m, n) \ge 0.
   \]

---

## 2. Derivation and Operator-Theoretic Meaning

### 2.1. Off-Diagonal Factorization
When $m < n$, the support of $\delta_m(v)$ transitions into its frozen terminal plateau $(\Lambda(m+1) - 1)e^{-v/2}$ at $v = \log(m+1)$.  
Because $m < n \implies m+1 \le n$, at the point where $\delta_n(v)$ begins to activate ($v = \log n$), $\delta_m(v)$ is already strictly in its terminal state:
\[
\delta_m(v) = (\Lambda(m+1) - 1) e^{-v/2}, \quad \text{for all } v \ge \log n.
\]
Consequently, the inner product over $(0, \infty)$ vanishes on $(0, \log n)$ and factors as:
\[
\int_0^\infty \delta_m(v) \delta_n(v) dv = (\Lambda(m+1) - 1) \int_{\log n}^\infty e^{-v/2} \delta_n(v) dv.
\]
Evaluating the remaining integral over the ramp $(\log n, \log(n+1))$ and the tail $(\log(n+1), \infty)$ yields:
\[
\int_{\log n}^\infty e^{-v/2} \delta_n(v) dv = \frac{\Lambda(n+1)}{n+1} - \log\left(1 + \frac{1}{n}\right),
\]
which proves the rank-1 factorization.

### 2.2. Universal Positive Semidefiniteness
For any finite set $s$ and sequence $c$:
\[
\sum_{m, n \in s} c_m c_n K(m, n) = \int_0^\infty \left( \sum_{n \in s} c_n \delta_n(v) \right)^2 dv \ge 0.
\]
Because the integrand is an explicit square of a real-valued measurable function on $(0, \infty)$, the quadratic form is unconditionally non-negative without any conditions on the distribution of primes or zeros of $\zeta(s)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0:
```lean
theorem birth_gram_integral {m N : ℕ} (hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment N v) =
      (ArithmeticFunction.vonMangoldt (m + 1) - 1) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))

theorem birth_gram_eq_kernel {m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment n v) = gramKernel m n

theorem finite_kernel_quadratic_nonnegative (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) : 0 ≤ ∑ m ∈ s, ∑ n ∈ s, c m * c n * gramKernel m n
```
Axioms audit confirms dependence strictly on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Gram matrices of arithmetic functions (such as the Redheffer matrix for the Möbius function, or Hilbert matrices $\frac{1}{i+j}$) are well-studied. However, this exact arithmetic Gram kernel $K(m, n)$—intertwining prime discrepancy steps with von Mangoldt shifts—has never previously appeared in the literature.
- **Advancement:** Establishes the exact reproducing kernel of the causal prime source step process and proves its universal positive semidefiniteness.
- **Target Venues:** *Linear Algebra and its Applications* or *Journal of Functional Analysis*.
