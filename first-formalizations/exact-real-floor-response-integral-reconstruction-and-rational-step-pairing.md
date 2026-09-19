# First Formalization: Exact Real-Floor Response Integral Reconstruction and Rational Step Pairing

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialRealCellSteps.lean`](../../formalization/BuildingBlocks/FactorialRealCellSteps.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact real-floor response integral identity and rational step pairings for factorial cells in Lean 4:

1. **Rational Step Floor Decomposition:**
   Formal proof of `real_floor_step_sum`: $\lfloor q/x \rfloor = \sum_{k=1}^q \mathbf{1}_{x \le q/k}$.
2. **Indicator Interval Integrability:**
   Formal proof of `inversePhase_indicator_intervalIntegrable`: interval integrability of step indicators against the inverse test phase.
3. **Equivalence on Compact Windows:**
   Formal proof of `real_floor_inversePhase_step_eq`: equality between floor products and step indicator sums.
4. **Single Quotient Floor Renewal:**
   Formal proof of `real_floor_inversePhase_integral`: $\int_1^X \lfloor q/x \rfloor (-\text{inverseTestPhase}(x, t)) dx = \text{centeredTest}(t, q)$ for $X \ge q$.
5. **Full Carry Response Integral Reconstruction:**
   Formal proof of `actual_real_floor_response_integral`: exact continuous integral representation of the factorial binary carry response.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Rational step floor counting identity
theorem real_floor_step_sum (q : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    (⌊(q : ℝ) / x⌋₊ : ℝ) =
      ∑ k ∈ Finset.Icc 1 q, if x ≤ (q : ℝ) / k then (1 : ℝ) else 0

-- Single floor harmonic renewal integral
theorem real_floor_inversePhase_integral (q : ℕ) {t X : ℝ} (ht : 0 < t)
    (hq : 0 < q) (hqX : (q : ℝ) ≤ X) :
    (∫ x in (1 : ℝ)..X, (⌊(q : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t)) = centeredTest t q

-- Full real-floor response integral reconstruction
theorem actual_real_floor_response_integral (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    (∫ x in (1 : ℝ)..N,
      (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ)) * (-inverseTestPhase x t)) =
      BuildingBlocks.FactorialBinaryCarry.response N t - (1 - exp (-t))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 reconstructing a discrete arithmetic binary carry response as a continuous Lebesgue integral of literal real quotient floor functions against an inverse test phase.
