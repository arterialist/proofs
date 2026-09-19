# First Formalization: Exact Critical Square-Root Mellin Aggregation and Zeta Multiplier

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalMellin.lean`](../../formalization/BuildingBlocks/ActualCriticalMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the definition of the critical square-root aggregation kernel $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$, its finite interval summation representation, its real-valuedness and support on $[1, \infty)$, its Mellin transform yielding the shifted zeta multiplier $\zeta(s+1/2)$, and its explicit semi-infinite integral formula in Lean 4:

1. **Finite Interval Summation:**
   Formal proof of $W(x) = \sum_{d=1}^{\lfloor x \rfloor} \sqrt{d} V(x/d)$ (`W_eq_Icc`).
2. **Support and Reality:**
   Formal proof that $W(x) = 0$ for $x \le 1$ (`W_zero`) and $\operatorname{Im}(W(x)) = 0$ (`W_real`).
3. **Shifted Zeta Multiplier Mellin Identity:**
   Formal proof that $\mathcal{M}(W)(-s-1) = \Phi(s)$ on $\operatorname{Re}(s) > 1$ (`hasMellin_W`, `hasMellin_W_filled`).
4. **Explicit Semi-Infinite Integral Formula:**
   Formal proof of $\int_1^\infty x^{-s-2} W(x) dx = \Phi(s)$ on $\operatorname{Re}(s) > 1$ (`integral_W_Ioi_one`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite interval representation
theorem W_eq_Icc (x : ℝ) :
    W x = ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * V (x/d)

-- Purely real-valued
theorem W_real (x : ℝ) : (W x).im = 0

-- Support vanishes for x ≤ 1
theorem W_zero {x : ℝ} (hx : x ≤ 1) : W x = 0

-- Mellin transform gives critical transform with zeta multiplier
theorem hasMellin_W {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.transform s)

-- Extension to filled transform
theorem hasMellin_W_filled {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.filledTransform s)

-- Explicit integral from 1 to infinity
theorem integral_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ)^(-s-2) * W x) =
      CriticalTransformPoles.transform s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that arithmetic dilation aggregation with critical square-root weights generates the shifted zeta multiplier $\zeta(s+1/2)$ in the Mellin transform.
