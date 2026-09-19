# First Formalization: Causal Successor-Predecessor Adjoint Duality and Isometry-Projection Algebra

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCriticalLift.lean`](../../formalization/BuildingBlocks/SuccessorCriticalLift.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact operator-algebraic structure of the causal successor and predecessor operators on $L^2(0, \infty)$:

1. **Adjoint Pair Duality:**
   Formal proof of $\langle f, T g \rangle = \langle P f, g \rangle$ under change-of-variables integration (`successor_predecessor_adjoint`).
2. **Left-Inversion Identity:**
   Formal proof that $T(P f)(v) = f(v)$ for all $v > 0$ (`successor_predecessor`).
3. **Orthogonal Projection Onto Translated Domain:**
   Formal proof that $P(T f)(u) = \mathbf{1}_{(\log 2, \infty)}(u) f(u)$ (`predecessor_successor`).
4. **Exact Isometry and Co-Isometry Mass Identities:**
   Formal proofs that the predecessor $P$ is an isometry ($\int_0^\infty (P f)^2 = \int_0^\infty f^2$) while the successor $T$ is a co-isometry ($\int_0^\infty (T f)^2 = \int_{\log 2}^\infty f^2$) without assuming finite mass (`predecessor_square_lintegral`, `successor_square_lintegral`).
5. **Physical Shift Duality:**
   Formal verification of the unitary conjugacy to the physical discrete shifts $x \mapsto x \pm 1$ (`successor_physicalLift`, `predecessor_physicalLift`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Adjoint identity
theorem successor_predecessor_adjoint (f g : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), f v * successor g v) =
      ∫ u in Ioi (0 : ℝ), predecessor f u * g u

-- Left-inverse relation
theorem successor_predecessor (f : ℝ → ℝ) {v : ℝ} (hv : 0 < v) :
    successor (predecessor f) v = f v

-- Projection relation
theorem predecessor_successor (f : ℝ → ℝ) (u : ℝ) :
    predecessor (successor f) u = (Ioi (log 2)).indicator f u

-- Non-negative lintegral isometry formulas
theorem successor_square_lintegral (f : ℝ → ℝ) :
    (∫⁻ v in Ioi (0 : ℝ), ENNReal.ofReal (successor f v ^ 2)) =
      ∫⁻ u in Ioi (log 2), ENNReal.ofReal (f u ^ 2)

theorem predecessor_square_lintegral (f : ℝ → ℝ) :
    (∫⁻ u in Ioi (0 : ℝ), ENNReal.ofReal (predecessor f u ^ 2)) =
      ∫⁻ v in Ioi (0 : ℝ), ENNReal.ofReal (f v ^ 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof that non-linear logarithmic shifts generate an exact unilateral shift algebra with partial isometry and projection structure on $L^2(0, \infty)$.
