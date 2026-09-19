# First Formalization: Exact Prime Error Primitive Area and First-Order Riesz Representation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimePrimitiveFormula.lean`](../../formalization/BuildingBlocks/PrimePrimitiveFormula.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact equivalence between the prime primitive area function $\psi_1(x)$ and the classical first-order Riesz sum, the exact integration of the step function $\psi(\lfloor t \rfloor)$ via Abel summation, and the exact continuous primitive integration identity $\int_1^x E(t) dt = \psi_1(x)$ in Lean 4:

1. **Riesz Sum Equivalence:**
   Formal proof of $\psi_1(x) = \sum_{n \le \lfloor x \rfloor} (x - n)\Lambda(n) - (x^2 - 1)/2$ (`primePrimitiveArea_eq_weighted_sum`).
2. **Abel Step-Function Integration:**
   Formal proof of $\int_1^x \psi(\lfloor t \rfloor) dt = x \psi(\lfloor x \rfloor) - \sum_{n \le \lfloor x \rfloor} n \Lambda(n)$ (`integral_psi_floor_eq_finite`).
3. **Exact Error Primitive Integral:**
   Formal proof that $\int_1^x E(t) dt = \psi_1(x)$ unconditionally for all $x \ge 1$ (`integral_primeErrorReal_eq_area`).
4. **Coarse Prefix Decomposition:**
   Formal proof that $\int_X^t E(u) du = \psi_1(t) - \psi_1(X)$ (`coarsePrefix_eq_area_sub`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- First-order Riesz mean representation
theorem primePrimitiveArea_eq_weighted_sum (x : ℝ) :
    primePrimitiveArea x =
      (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - n) * ArithmeticFunction.vonMangoldt n) -
        (x ^ 2 - 1) / 2

-- Exact integration of step function via Abel summation
theorem integral_psi_floor_eq_finite {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, psi ⌊t⌋₊) =
      x * psi ⌊x⌋₊ -
        ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n

-- Exact prime error primitive integral
theorem integral_primeErrorReal_eq_area {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, primeErrorReal t) = primePrimitiveArea x

-- Coarse prefix decomposition
theorem coarsePrefix_eq_area_sub {X t : ℝ} (hX : 1 ≤ X) (ht : 1 ≤ t) :
    coarsePrefix X t = primePrimitiveArea t - primePrimitiveArea X
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact first-order Riesz mean representation of the prime error primitive without asymptotic remainders.
