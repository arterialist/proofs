# Contribution 151: Exact Prime Error Primitive Area and First-Order Riesz Representation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimePrimitiveFormula.lean`](../../formalization/BuildingBlocks/PrimePrimitiveFormula.lean), [`building-blocks/prime/prime-primitive-formula.md`](../../building-blocks/prime/prime-primitive-formula.md)  
**Classification:** Analytic Number Theory / Chebyshev Error Primitives / Abel Summation / First Riesz Means / Step-Function Integrals

---

## 1. Executive Summary and Mathematical Statement

In analytic number theory, the continuous integral of the discontinuous prime-counting error $E(t) = \psi(t) - t$ represents the first-order Riesz smoothing of prime distributions. Standard treatments rely on contour integration or asymptotic estimates with unspecified $O(1)$ terms.

This contribution proves:

1. **Exact Step-Function Abel Integration:**  
   For any real number $x \ge 1$:
   $$
   \int_1^x \psi(\lfloor t \rfloor) dt = x \psi(\lfloor x \rfloor) - \sum_{n=1}^{\lfloor x \rfloor} n \Lambda(n).
   $$
2. **First-Order Riesz Mean Representation:**  
   The prime primitive area function $\psi_1(x)$ defined by $x \psi(\lfloor x \rfloor) - \sum_{n \le \lfloor x \rfloor} n \Lambda(n) - \frac{x^2 - 1}{2}$ is identically equal to the classical first-order Riesz sum:
   $$
   \psi_1(x) = \sum_{n=1}^{\lfloor x \rfloor} (x - n)\Lambda(n) - \frac{x^2 - 1}{2}.
   $$
3. **Exact Primitive Integral of the Prime Error:**  
   For all real $x \ge 1$, without any prime-error hypotheses or asymptotic remainders:
   $$
   \int_1^x (\psi(t) - t) dt = \psi_1(x) = \sum_{n=1}^{\lfloor x \rfloor} (x - n)\Lambda(n) - \frac{x^2 - 1}{2}.
   $$
4. **Finite Coarse Prefix Decomposition:**  
   For any $1 \le X \le t$:
   $$
   \int_X^t E(u) du = \psi_1(t) - \psi_1(X).
   $$

---

## 2. Mathematical Proof

### 2.1. Exact Abel Summation on the Step Function
By the Abel summation formula on $[1, x]$ for the arithmetic function $\Lambda(n)$ and the smooth weight function $g(t) = t$:
$$
\sum_{n \le \lfloor x \rfloor} n \Lambda(n) = x \psi(\lfloor x \rfloor) - \int_1^x \psi(\lfloor t \rfloor) g'(t) dt = x \psi(\lfloor x \rfloor) - \int_1^x \psi(\lfloor t \rfloor) dt.
$$
Rearranging terms yields:
$$
\int_1^x \psi(\lfloor t \rfloor) dt = x \psi(\lfloor x \rfloor) - \sum_{n=1}^{\lfloor x \rfloor} n \Lambda(n).
$$

### 2.2. Equivalence to the Riesz Mean
Using the expansion $\psi(\lfloor x \rfloor) = \sum_{n \le \lfloor x \rfloor} \Lambda(n)$:
$$
x \psi(\lfloor x \rfloor) - \sum_{n=1}^{\lfloor x \rfloor} n \Lambda(n) = \sum_{n=1}^{\lfloor x \rfloor} x \Lambda(n) - \sum_{n=1}^{\lfloor x \rfloor} n \Lambda(n) = \sum_{n=1}^{\lfloor x \rfloor} (x - n)\Lambda(n).
$$
Subtracting the smooth baseline $\int_1^x t dt = \frac{x^2 - 1}{2}$:
$$
\psi_1(x) = \sum_{n=1}^{\lfloor x \rfloor} (x - n)\Lambda(n) - \frac{x^2 - 1}{2}.
$$

### 2.3. Exact Primitive Integration
Since $E(t) = \psi(\lfloor t \rfloor) - t$:
$$
\int_1^x E(t) dt = \int_1^x \psi(\lfloor t \rfloor) dt - \int_1^x t dt = \left( x \psi(\lfloor x \rfloor) - \sum_{n=1}^{\lfloor x \rfloor} n \Lambda(n) \right) - \frac{x^2 - 1}{2} = \psi_1(x).
$$
This holds unconditionally for all $x \ge 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimePrimitiveFormula.lean`):
```lean
theorem primePrimitiveArea_eq_weighted_sum (x : ℝ) :
    primePrimitiveArea x =
      (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - n) * ArithmeticFunction.vonMangoldt n) -
        (x ^ 2 - 1) / 2

theorem integral_psi_floor_eq_finite {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, psi ⌊t⌋₊) =
      x * psi ⌊x⌋₊ -
        ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n

theorem integral_primeErrorReal_eq_area {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, primeErrorReal t) = primePrimitiveArea x

theorem coarsePrefix_eq_area_sub {X t : ℝ} (hX : 1 ≤ X) (ht : 1 ≤ t) :
    coarsePrefix X t = primePrimitiveArea t - primePrimitiveArea X
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Ingham's Prime Number Theory (1932), Montgomery-Vaughan's Multiplicative Number Theory (2007). Continuous primitives of the Chebyshev step error are standard, but establishing exact closed-form algebraic representations in Lean 4 without error terms is novel.
- **Advancement:** Complete machine verification of the exact finite arithmetic Riesz mean identity for prime error primitives in Lean 4.
- **Target Venues:** *American Mathematical Monthly* or *Expositiones Mathematicae*.
