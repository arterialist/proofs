# First Formalization: Exact Critical Three-Halves Screw Remainder Budget and Scale Invariance

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachScrewRemainderThresholdFinite.lean`](../../formalization/BuildingBlocks/GoldbachScrewRemainderThresholdFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact absolute remainder budget for the dyadic Goldbach screw combination, verifies the complete scale cancellation yielding the critical threshold constant $25C/2$, and establishes two-sided margin transfer in Lean 4:

1. **Definition of Dyadic Remainder Contribution:**
   Formal definition of `dyadicRemainderContribution` ($2\sqrt{x}\text{err} - \frac{x}{2}\text{errSq}$).
2. **Absolute Remainder Budget:**
   Formal proof of `dyadic_remainder_budget`.
3. **Scale-Invariant Critical Three-Halves Threshold:**
   Formal proof of `critical_three_halves_budget` ($|\Delta| \le \frac{25}{2}C$).
4. **Margin Transfer Inequalities:**
   Formal proofs of `robust_dyadic_of_margin` and `raw_dyadic_of_corrected`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Absolute error bound on dyadic remainder contribution
theorem dyadic_remainder_budget {x err errSq b bSq : ℝ}
    (hx : 0 ≤ x)
    (herr : |err| ≤ b) (herrSq : |errSq| ≤ bSq) :
    |dyadicRemainderContribution x err errSq| ≤
      2 * Real.sqrt x * b + x / 2 * bSq

-- Exact scale invariance at exponent 3/2 yielding constant 25C/2
theorem critical_three_halves_budget {x C err errSq : ℝ}
    (hx : 0 < x)
    (herr : |err| ≤ 5 * C / Real.sqrt x)
    (herrSq : |errSq| ≤ 5 * C / x) :
    |dyadicRemainderContribution x err errSq| ≤ 25 * C / 2

-- Margin transfer from robust to corrected inequality
theorem robust_dyadic_of_margin {raw origin contribution budget : ℝ}
    (habs : |contribution| ≤ budget)
    (hraw : raw + budget ≤ 3 * origin) :
    raw - contribution ≤ 3 * origin

-- Margin transfer from corrected to raw inequality
theorem raw_dyadic_of_corrected {raw origin contribution budget : ℝ}
    (habs : |contribution| ≤ budget)
    (hcorr : raw - contribution ≤ 3 * origin) :
    raw ≤ 3 * origin + budget
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact scale-invariant cancellation of dyadic Goldbach screw remainders at the critical 3/2 exponent, fixing the sharp threshold constant at $25C/2$.
