# First Formalization: Exact Arithmetic Source Birth Work and Energy Increment Formula

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenBirthWork.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthWork.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Hilbert-space cross-work and energy increment recurrence for the arithmetic causal source in Lean 4:

1. **Source-Increment Cross Integrability:**
   Formal proof that `causalSource N v * increment N v` is integrable on $(0, \infty)$ (`source_increment_integrable`).
2. **Ramp and Terminal Work Profiles:**
   Formal proofs of the ramp product formula (`source_increment_ramp`) and terminal product formula (`source_increment_terminal`).
3. **Exact Closed-Form Cross-Work Theorem:**
   Formal proof of `source_increment_integral`:
   \[
   \int_0^\infty \text{causalSource}(N, v) \text{increment}(N, v) dv = (\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right).
   \]
4. **Exact Total Energy Increment Formula:**
   Formal proof of `full_square_integral_increment`:
   \[
   \begin{aligned}
   \|\text{causalSource}(N+1)\|_{L^2}^2 - \|\text{causalSource}(N)\|_{L^2}^2 &= 2 (\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right) \\
   &\quad + 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right) + \frac{(\Lambda(N+1) - 1)^2}{N+1}.
   \end{aligned}
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- L² cross-product integrability
theorem source_increment_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => causalSource N v * increment N v) (Ioi (0 : ℝ))

-- Exact closed-form cross-work integral
theorem source_increment_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), causalSource N v * increment N v) =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))

-- Exact global energy increment formula
theorem full_square_integral_increment {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource (N + 1) v)^2) -
      (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
        2 * (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
          ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ))) +
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) +
          (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact closed-form evaluation of arithmetic prime birth cross-work $\langle \text{causalSource}(N), \Delta \text{source}_N \rangle = (\psi(N)-N)(\frac{\Lambda(N+1)}{N+1} - \log(1+1/N))$ and the exact step-by-step energy increment formula for the Chebyshev prime-counting field.
