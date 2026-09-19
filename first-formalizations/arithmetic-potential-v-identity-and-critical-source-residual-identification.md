# First Formalization: Arithmetic Potential $V(x)$ Identity and Critical Source Residual Identification

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSourceVEvaluation.lean`](../../formalization/BuildingBlocks/PrimeSourceVEvaluation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact identification of the filtered prime source residual with the arithmetic potential $V(x)$ in Lean 4:

1. **Closed Representation of $V(x)$:**
   Formal construction of `rawV` containing distinct prime-power pairs $(x - p^j q^k)\log p \log q$, single prime powers $\Lambda(n)(x^2 - n^2)/n$, and continuous density terms $x^2 \log x / 2 + x^2/4 - 1/4$ (`rawV`, `V`).
2. **Distinct Prime Pair Integration:**
   Formal proof that the filtered convolution of distinct prime blocks evaluates to $e^{-3s/2} \operatorname{distinctArithmetic}(s)$ (`filtered_distinct_arithmetic`).
3. **Mixed Coupling and Density Integration:**
   Formal evaluation of prime-density interactions (`filtered_mixed_arithmetic`) and normalized density convolution.
4. **Master Potential Identification:**
   Formal proof that $\mathcal{L}_0(S * S)(s) - \tau(s) = e^{-3s/2} V(e^s)$ (`actual_source_eq_normalized_V`), and that $V(1) = 0$ (`V_one`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Master filtered source potential identity
theorem actual_source_eq_normalized_V {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s = Real.exp (-3*s/2)*V (Real.exp s)

-- Equivalence to raw arithmetic formula for x ≥ 1
theorem V_eq_rawV {x : ℝ} (hx : 1 ≤ x) : V x = rawV x

-- Vanishing at boundary x = 1
theorem V_one : V 1 = 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof that the non-asymptotic arithmetic potential $V(x)$ exactly governs the energy residual of the continuous prime source field on logarithmic coordinates.
