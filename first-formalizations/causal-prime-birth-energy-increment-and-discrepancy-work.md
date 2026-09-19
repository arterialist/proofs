# First Formalization: Causal Prime Source Birth Step Energy Increment and Discrepancy Work Identity

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ChargeFrozenBirthWork.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthWork.lean), [`formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact step-by-step energy law of the causal prime source under discrete horizon increments $N \to N+1$:

1. **Piecewise Birth Dissection:**
   Formal evaluation showing that the birth increment $\delta_N(v) = a_{N+1}(v) - a_N(v)$ vanishes on $e^v \le N$ (`increment_before`), transitions to $-(e^v - N)e^{-v/2}$ on $N < e^v < N+1$ (`increment_ramp`), and freezes at $(\Lambda(N+1) - 1)e^{-v/2}$ for $e^v \ge N+1$ (`increment_terminal`, `increment_piecewise`).
2. **Deterministic Geometric Ramp Integral:**
   Formal Bochner evaluation of the ramp $L^2$ energy on $[\log N, \log(N+1)]$ yielding $1 + \frac{N}{N+1} - 2N\log\left(1 + \frac{1}{N}\right)$ (`ramp_square_integral`).
3. **Total Birth Increment Norm:**
   Formal derivation of the total $L^2(0, \infty)$ norm of the birth increment as the sum of the ramp energy and the discrete prime atom $(\Lambda(N+1) - 1)^2 / (N+1)$ (`increment_square_integral_evaluated`).
4. **Cross-Work Discrepancy Identity:**
   Formal proof that the cross-pairing between the existing causal source $a_N$ and the birth increment $\delta_N$ evaluates in closed form to $(\psi(N) - N) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right)$ (`source_increment_integral`).
5. **Complete Telescoping Energy Step Law:**
   Formal verification that the change in total source energy under $N \to N+1$ decomposes exactly into twice the discrepancy cross-work, plus the ramp energy, plus the discrete atom energy (`full_square_integral_increment`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Piecewise structure of birth increment
theorem increment_piecewise {N : ℕ} {v : ℝ} (hv : 0 < v) :
    increment N v = if Real.exp v ≤ (N : ℝ) then 0 else
      if Real.exp v < ((N + 1 : ℕ) : ℝ) then -(Real.exp v - (N : ℝ)) * Real.exp (-v / 2)
      else (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v / 2)

-- Closed-form ramp energy integral
theorem ramp_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
      (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) =
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ))

-- Cross-work discrepancy pairing
theorem source_increment_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), causalSource N v * increment N v) =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))

-- Total source energy increment
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

This formalization provides the first machine-verified proof of the exact discrete energy step law for the causal prime source, decomposing the energy increment into microscopic discrepancy cross-work, deterministic ramp dissipation, and prime atom mass.
