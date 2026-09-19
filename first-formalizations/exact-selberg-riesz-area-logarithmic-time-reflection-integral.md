# First Formalization: Exact Selberg-Riesz Area Logarithmic-Time Reflection Integral

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergLogReflection.lean`](../../formalization/BuildingBlocks/SelbergLogReflection.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the measurable exponential change-of-variables theorem on intervals, the exact algebraic rescaling of prime reflection integrands, and the continuous logarithmic-time representation of the discrete Selberg centered area primitive in Lean 4:

1. **Measurable Exponential Change-of-Variables:**
   Formal proof of $\int_1^{e^T} f(a) da = \int_0^T e^t f(e^t) dt$ without continuity assumptions (`integral_exp_substitution`).
2. **Exact Logarithmic Time Representation:**
   Formal proof that the discrete Selberg centered area primitive equals the continuous logarithmic reflection integral $S(N) = e^{\frac{3}{2}\log N} \int_0^{\log N} \mathcal{E}(t)(\mathcal{E}(\log N - t) - \mathcal{R}(\log N - t)) dt$ (`selbergCenteredArea_log_reflection`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Measurable exponential change of variables
theorem integral_exp_substitution (T : ℝ) (hT : 0 ≤ T) (f : ℝ → ℝ) :
    (∫ a in (1 : ℝ)..Real.exp T, f a) =
      ∫ t in (0 : ℝ)..T, Real.exp t * f (Real.exp t)

-- Logarithmic reflection integral formula for Selberg centered area
theorem selbergCenteredArea_log_reflection {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N = Real.exp ((3 / 2 : ℝ) * Real.log (N : ℝ)) *
      ∫ t in (0 : ℝ)..Real.log (N : ℝ),
        primeLogError t *
          (primeLogError (Real.log (N : ℝ) - t) -
            primeLogResponse (Real.log (N : ℝ) - t))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the continuous logarithmic-time reflection integral representation of the discrete Selberg Riesz area primitive without continuity assumptions.
