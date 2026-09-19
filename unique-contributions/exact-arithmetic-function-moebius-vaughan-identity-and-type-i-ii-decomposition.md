# Contribution 156: Exact Arithmetic Function Möbius-Vaughan Identity and Type I/II Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MobiusVaughan.lean`](../../formalization/BuildingBlocks/MobiusVaughan.lean), [`building-blocks/mertens/mobius-vaughan.md`](../../building-blocks/mertens/mobius-vaughan.md)  
**Classification:** Analytic Number Theory / Sieve Theory / Vaughan's Identity / Möbius Function / Dirichlet Convolution Rings / Bilinear Forms

---

## 1. Executive Summary and Mathematical Statement

Vaughan's identity (Vaughan 1977) is typically stated in textbooks for the von Mangoldt function $\Lambda(n)$ as a partition of sums into Type I (smooth convolution) and Type II (bilinear) components. For the Möbius function $\mu(n)$, the identity is often described heuristically via formal Dirichlet series manipulations $1/\zeta(s) = 2 M_{\le U}(s) - M_{\le U}(s)^2 \zeta(s) + \dots$.

This contribution proves:

1. **Exact Equality in the Commutative Ring of Arithmetic Functions:**  
   In the ring of real-valued arithmetic functions under Dirichlet convolution, with $\mu_{\le U} = \mu \cdot \mathbf{1}_{n \le U}$, $\mu_{> U} = \mu - \mu_{\le U}$, $c_1 = \mu_{\le U} * \mu_{\le U}$, and $c_2 = \mu_{> U} * \zeta$:
   $$
   \mu = 2 \mu_{\le U} - c_1 * \zeta + \mu_{> U} * c_2.
   $$
   This is an exact, non-asymptotic equality holding identically at every natural number $n$, without any small-$n$ exception or error term.
2. **Compact Support of Truncated Convolutions:**  
   - The Type I convolution kernel $c_1(n) = (\mu_{\le U} * \mu_{\le U})(n)$ vanishes identically for all $n > U^2$.
   - The Type II convolution kernel $c_2(n) = (\mu_{> U} * \zeta)(n)$ vanishes identically for all $n \le U$.
3. **Exact Weighted Bilinear Type I / Type II Decomposition:**  
   For any integer cutoff $U \ge 1$, truncation $N$, and weight function $w: \mathbb{N} \to \mathbb{R}$ supported on $n > U$ (i.e. $w(n) = 0$ for $n \le U$):
   $$
   \sum_{n=1}^N \mu(n) w(n) = -\sum_{a=1}^N c_1(a) \sum_{b=1}^{\lfloor N/a \rfloor} w(ab) + \sum_{a=1}^N \mu_{>U}(a) \sum_{b=1}^{\lfloor N/a \rfloor} c_2(b) w(ab).
   $$

---

## 2. Mathematical Proof

### 2.1. Exact Ring Algebraic Identity
Let $\mathcal{A}$ be the commutative ring of arithmetic functions with Dirichlet convolution $*$ and unit $\delta_1 = \mu * \zeta$.
Let $M_1 = \mu_{\le U}$ and $M_2 = \mu - M_1 = \mu_{> U}$.
Then:
$$
\mu = M_1 + M_2.
$$
Convolving both sides with the unit $\delta_1 = \mu * \zeta$:
$$
\mu = (M_1 + M_2) * (M_1 + M_2) * \zeta.
$$
Expanding the product:
$$
\mu = (M_1 * M_1 + 2 M_1 * M_2 + M_2 * M_2) * \zeta
$$
$$
= M_1 * M_1 * \zeta + 2 M_1 * M_2 * \zeta + M_2 * (M_2 * \zeta).
$$
Now substitute $M_2 * \zeta = (\mu - M_1) * \zeta = \mu * \zeta - M_1 * \zeta = \delta_1 - M_1 * \zeta$:
$$
2 M_1 * M_2 * \zeta = 2 M_1 * (\delta_1 - M_1 * \zeta) = 2 M_1 - 2 M_1 * M_1 * \zeta.
$$
Combining terms:
$$
\mu = M_1 * M_1 * \zeta + (2 M_1 - 2 M_1 * M_1 * \zeta) + M_2 * (M_2 * \zeta)
$$
$$
= 2 M_1 - M_1 * M_1 * \zeta + M_2 * (M_2 * \zeta).
$$
This completes the exact algebraic proof.

### 2.2. Support Bounds
- If $n > U^2$, any factorization $n = d \cdot (n/d)$ requires that either $d > U$ or $n/d > U$. Therefore, $\mu_{\le U}(d) \mu_{\le U}(n/d) = 0$ for all divisors $d \mid n$, yielding $c_1(n) = 0$.
- If $n \le U$, every divisor $d \mid n$ satisfies $d \le n \le U$. Thus $\mu_{> U}(d) = 0$ for all $d \mid n$, yielding $c_2(n) = 0$.

### 2.3. Weighted Decomposition
Applying the general weighted Dirichlet convolution formula:
$$
\sum_{n=1}^N (f * g)(n) w(n) = \sum_{a=1}^N f(a) \sum_{b=1}^{\lfloor N/a \rfloor} g(b) w(ab)
$$
to the arithmetic function identity $\mu = 2 \mu_{\le U} - c_1 * \zeta + \mu_{>U} * c_2$.
Since $w(n) = 0$ for $n \le U$ and $\mu_{\le U}(n) = 0$ for $n > U$, the term $2 \sum \mu_{\le U}(n) w(n)$ vanishes identically, leaving the exact Type I and Type II terms.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/MobiusVaughan.lean`):
```lean
theorem moebius_vaughan_identity (U : ℕ) :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) =
      2 • moebiusSmall U -
        vaughanSmallCoefficient U * (ArithmeticFunction.zeta : ArithmeticFunction ℝ) +
        moebiusLarge U * vaughanLargeCoefficient U

theorem vaughanSmallCoefficient_eq_zero_of_lt {U n : ℕ} (hn : U * U < n) :
    vaughanSmallCoefficient U n = 0

theorem vaughanLargeCoefficient_eq_zero_of_le {U n : ℕ} (hn : n ≤ U) :
    vaughanLargeCoefficient U n = 0

theorem weighted_convolution_sum (f g : ArithmeticFunction ℝ) (w : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, (f * g) n * w n) =
      ∑ a ∈ Finset.Icc 1 N, f a *
        ∑ b ∈ Finset.Icc 1 (N / a), g b * w (a * b)

theorem moebius_vaughan_weighted_sum (U N : ℕ) (w : ℕ → ℝ)
    (hw : ∀ n, n ≤ U → w n = 0) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * w n) =
      -(∑ a ∈ Finset.Icc 1 N, vaughanSmallCoefficient U a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          (ArithmeticFunction.zeta : ArithmeticFunction ℝ) b * w (a * b)) +
      ∑ a ∈ Finset.Icc 1 N, moebiusLarge U a *
        ∑ b ∈ Finset.Icc 1 (N / a), vaughanLargeCoefficient U b * w (a * b)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Vaughan (1977), Montgomery-Vaughan (2007). In standard textbooks, Vaughan's identity for $\mu$ is derived through complex generating functions or stated with asymptotic ranges.
- **Advancement:** Machine-checks the stated ring-theoretic identity for $\mu$ under Dirichlet convolution and its weighted Type I and Type II decomposition. Priority among formalizations is not established by this audit.
- **Target Venues:** *Journal of Number Theory* or *Integers*.
