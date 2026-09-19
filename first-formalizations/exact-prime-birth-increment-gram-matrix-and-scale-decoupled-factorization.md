# First Formalization: Exact Prime Birth Increment Gram Matrix and Scale-Decoupled Factorization

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenBirthGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthGram.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Hilbert-space $L^2((0, \infty))$ Gram inner product between prime birth increments in Lean 4:

1. **Integrability of Gram Cross-Products:**
   Formal proof that `increment m v * increment N v` is integrable on $(0, \infty)$ (`birth_gram_integrable`).
2. **Transition Ramp and Terminal Regimes:**
   Formal proofs of the ramp product formula (`birth_gram_ramp`) and terminal product formula (`birth_gram_terminal`).
3. **Exact Closed-Form Decoupled Gram Formula:**
   Formal proof of `birth_gram_integral`:
   $$
   \langle \text{increment}(m), \text{increment}(N) \rangle_{L^2} = (\Lambda(m+1) - 1) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
   $$

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- L² integrability of the Gram product
theorem birth_gram_integrable {m N : ℕ} (hm : 2 ≤ m) (hN : 2 ≤ N) :
    IntegrableOn (fun v => increment m v * increment N v) (Ioi (0 : ℝ))

-- Intermediate transition ramp product formula
theorem birth_gram_ramp {m N : ℕ} (_hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) (hv1 : v < Real.log ((N + 1 : ℕ) : ℝ)) :
    increment m v * increment N v =
      -(ArithmeticFunction.vonMangoldt (m + 1) - 1) * (1 - (N : ℝ) * Real.exp (-v))

-- Terminal product formula on (log(N+1), ∞)
theorem birth_gram_terminal {m N : ℕ} (_hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log ((N + 1 : ℕ) : ℝ) < v) :
    increment m v * increment N v =
      (ArithmeticFunction.vonMangoldt (m + 1) - 1) * (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v)

-- Exact closed-form Gram inner product evaluation
theorem birth_gram_integral {m N : ℕ} (hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment N v) =
      (ArithmeticFunction.vonMangoldt (m + 1) - 1) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact closed-form evaluation of the $L^2$ Gram matrix of the prime birth process $\langle \Delta \text{source}_m, \Delta \text{source}_N \rangle = (\Lambda(m+1) - 1)(\frac{\Lambda(N+1)}{N+1} - \log(1+1/N))$, demonstrating algebraic scale-decoupling and intermediate boundary cancellation.
