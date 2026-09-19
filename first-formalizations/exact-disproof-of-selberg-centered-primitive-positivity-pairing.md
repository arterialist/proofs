# First Formalization: Exact Disproof of Selberg Centered Primitive Positivity Pairing

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergCenteredPairing.lean`](../../formalization/BuildingBlocks/SelbergCenteredPairing.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the certified machine-verified counterexample refuting non-negative discrete increment pairings between the prime-error primitive $A(x)$ and the centered Selberg convolution primitive $S(x)$ in Lean 4:

1. **Closed-Form Evaluations:**
   Formal evaluation of $S(2), S(3), S(4)$ and $A(2), A(3), A(4)$ (`selbergCenteredArea_two`, `selbergCenteredArea_three`, `selbergCenteredArea_four`, `primePrimitiveArea_two`, `primePrimitiveArea_three`, `primePrimitiveArea_four`).
2. **Exact Strict Negative Pairing Bound:**
   Formal proof that the discrete increment inner product satisfies $\langle \Delta A, \Delta S \rangle < -13/6 < 0$ (`selbergCenteredPairing_two_lt`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Evaluations of centered Selberg area
theorem selbergCenteredArea_two : selbergCenteredArea 2 = 2 * Real.log 2 + 3 / 4

theorem selbergCenteredArea_three :
    selbergCenteredArea 3 = -(5 / 2 : ℝ) * Real.log 2 +
      (9 / 2 : ℝ) * Real.log 3 + 2

theorem selbergCenteredArea_four :
    selbergCenteredArea 4 = 10 * Real.log 2 - (7 / 3 : ℝ) * Real.log 3 + 15 / 4

-- Strict negative bound refuting non-negative pairing
theorem selbergCenteredPairing_two_lt :
    (primePrimitiveArea 3 - primePrimitiveArea 2) *
        (selbergCenteredArea 3 - selbergCenteredArea 2) +
      (primePrimitiveArea 4 - primePrimitiveArea 3) *
        (selbergCenteredArea 4 - selbergCenteredArea 3) < -(13 / 6 : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified counterexample in Lean 4 proving that naive dissipative inner products between prime-error primitives and Selberg auto-convolutions fail strictly.
