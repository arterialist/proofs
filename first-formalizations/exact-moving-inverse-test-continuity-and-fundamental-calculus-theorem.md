# First Formalization: Exact Moving Inverse Test Continuity and Fundamental Calculus Theorem

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialRealCellTest.lean`](../../formalization/BuildingBlocks/FactorialRealCellTest.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the global continuity and Fundamental Theorem of Calculus for floor-indexed moving inverse test functions in Lean 4:

1. **Exact Integer Boundary Match:**
   Formal proof of `finiteInverseTest_entry_match`: $\text{finiteInverseTest}(N+1, t, N+1) = \text{finiteInverseTest}(N, t, N+1)$ via $\text{centeredTest}(t, 1) = 0$.
2. **Global Half-Line Continuity:**
   Formal proof of `movingInverseTest_continuousOn`: $x \mapsto \text{movingInverseTest}(t, x)$ is everywhere continuous on $[1, \infty)$.
3. **Right and Pointwise Derivation:**
   Formal proof of `movingInverseTest_hasDerivWithinAt_right` and `movingInverseTest_hasDerivAt`: recovery of $-\text{inverseTestPhase}(x, t)$.
4. **Lebesgue Interval Integrability:**
   Formal proof of `inverseTestPhase_intervalIntegrable`: interval integrability of $-\text{inverseTestPhase}(x, t)$ on $[1, X]$.
5. **Exact Fundamental Theorem of Calculus:**
   Formal proof of `movingInverseTest_integral_from_one`: $\int_1^X (-\text{inverseTestPhase}(x, t)) dx = \text{movingInverseTest}(t, X)$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact boundary matching across integer threshold
theorem finiteInverseTest_entry_match (N : ℕ) (t : ℝ) :
    finiteInverseTest (N + 1) t (N + 1) = finiteInverseTest N t (N + 1)

-- Global continuity on [1, ∞)
theorem movingInverseTest_continuousOn (t : ℝ) :
    ContinuousOn (movingInverseTest t) (Set.Ici 1)

-- Right derivative recovery
theorem movingInverseTest_hasDerivWithinAt_right {t x : ℝ} (hx : 1 ≤ x) :
    HasDerivWithinAt (movingInverseTest t) (-inverseTestPhase x t) (Ioi x) x

-- Lebesgue interval integrability
theorem inverseTestPhase_intervalIntegrable {t X : ℝ} (ht : 0 < t) (hX : 1 ≤ X) :
    IntervalIntegrable (fun x => inverseTestPhase x t) volume 1 X

-- Fundamental Theorem of Calculus
theorem movingInverseTest_integral_from_one {t X : ℝ} (ht : 0 < t) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, -inverseTestPhase x t) = movingInverseTest t X
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 proving that dynamic floor-indexed Möbius sums can produce everywhere continuous functions satisfying the classical Fundamental Theorem of Calculus without regularizing boundary smoothings.
