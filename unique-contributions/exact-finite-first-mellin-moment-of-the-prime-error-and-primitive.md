# Contribution 150: Exact Finite First Mellin Moment of the Prime Error and Primitive

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeFirstMoment.lean`](../../formalization/BuildingBlocks/PrimeFirstMoment.lean), [`building-blocks/prime/prime-first-moment.md`](../../building-blocks/prime/prime-first-moment.md)  
**Classification:** Analytic Number Theory / Mellin Transforms / Prime Counting Errors / Mertens Sums / Abel Summation / Right-Differentiable Integration by Parts

---

## 1. Executive Summary and Mathematical Statement

In the quantitative analysis of the Chebyshev prime-counting error $E(t) = \psi(t) - t$, evaluating its first Mellin moment $\int_1^N \frac{E(t)}{t^2} dt$ at finite integer truncations $N$ is traditionally performed asymptotically with an unspecified $O(1/N)$ error term. In exact formal arithmetic, capturing all boundary terms explicitly is necessary to close discrete Riesz convolution formulas.

This contribution proves:

1. **Exact Finite First Mellin Moment Identity:**  
   For any integer truncation $N \ge 1$:
   $$
   \int_1^N \frac{E(t)}{t^2} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N} - \log N.
   $$
2. **Right-Differentiable Integration by Parts Formula:**  
   For any real cutoff $T \ge 1$, connecting the Mellin moment of $E(t)$ to its integrated primitive $\psi_1(t) = \int_1^t E(u) du$:
   $$
   \int_1^T \frac{E(t)}{t^2} dt = \frac{\psi_1(T)}{T^2} + 2 \int_1^T \frac{\psi_1(t)}{t^3} dt.
   $$
3. **Exact Arithmetic Primitive Moment Representation:**  
   Combining both identities yields the exact finite arithmetic formula for the weighted primitive integral:
   $$
   2 \int_1^N \frac{\psi_1(t)}{t^3} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N} - \log N - \frac{\psi_1(N)}{N^2}.
   $$

---

## 2. Mathematical Proof

### 2.1. First Mellin Moment via Weighted Abel Summation
By definition of $E(t) = \psi(\lfloor t \rfloor) - t$:
$$
\int_1^N \frac{E(t)}{t^2} dt = \int_1^N \frac{\psi(\lfloor t \rfloor)}{t^2} dt - \int_1^N \frac{1}{t} dt.
$$
The second integral evaluates directly to $\log N$:
$$
\int_1^N \frac{1}{t} dt = \log N.
$$
For the first integral, we use Abel summation with exponent $s = -1$:
$$
\int_1^N \frac{\psi(\lfloor t \rfloor)}{t^2} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N}.
$$
Subtracting $\log N$ yields the exact finite moment identity:
$$
\int_1^N \frac{E(t)}{t^2} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N} - \log N.
$$

### 2.2. Integration by Parts with Primitive $\psi_1$
The primitive $\psi_1(t) = \int_1^t E(u) du$ is continuous on $[1, T]$ with right derivative $(\psi_1)_+'(t) = E(t)$.
The weight $v(t) = t^{-2}$ is $C^\infty$ with $v'(t) = -2 t^{-3}$.
Applying right-differentiable integration by parts:
$$
\int_1^T \frac{E(t)}{t^2} dt = \left[ \frac{\psi_1(t)}{t^2} \right]_1^T - \int_1^T \psi_1(t) \left(-\frac{2}{t^3}\right) dt.
$$
Since $\psi_1(1) = 0$, the lower evaluation vanishes:
$$
\int_1^T \frac{E(t)}{t^2} dt = \frac{\psi_1(T)}{T^2} + 2 \int_1^T \frac{\psi_1(t)}{t^3} dt.
$$

### 2.3. Combining into the Primitive Moment Formula
Equating the two expressions at $T = N$ and rearranging yields:
$$
2 \int_1^N \frac{\psi_1(t)}{t^3} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N} - \log N - \frac{\psi_1(N)}{N^2}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimeFirstMoment.lean`):
```lean
theorem primeError_first_moment {N : ℕ} (hN : 1 ≤ N) :
    (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t / t ^ 2) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) - Real.log (N : ℝ)

theorem coarsePrefix_first_moment {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, primeErrorReal t / t ^ 2) =
      coarsePrefix 1 T / T ^ 2 +
        2 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t / t ^ 3

theorem primePrimitive_first_moment {N : ℕ} (hN : 1 ≤ N) :
    2 * (∫ t in (1 : ℝ)..(N : ℝ), coarsePrefix 1 t / t ^ 3) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) - Real.log (N : ℝ) - coarsePrefix 1 N / (N : ℝ) ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Mertens' second theorem and Abel summation formulas (Mertens 1874, Ingham 1932, Montgomery-Vaughan 2007). In standard textbooks, finite identities are rarely stated with all boundary terms intact without passing to asymptotic limits.
- **Advancement:** Machine-checked exact finite arithmetic identity for the first Mellin moment of the prime error and its primitive in Lean 4 without asymptotic approximations.
- **Target Venues:** *American Mathematical Monthly* or *Journal of Number Theory*.
