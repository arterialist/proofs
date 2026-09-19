# First Formalization: Exact Prime Birth Increment Self-Energy and Transitional Ramp Integral

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact three-regime piecewise structure, transitional ramp integral evaluation, and total self-energy formula for the prime birth increment in Lean 4:

1. **Three-Regime Piecewise Representation:**
   Formal proof that `increment N v` equals $0$ for $e^v \le N$, $-(e^v - N)e^{-v/2}$ for $N < e^v < N+1$, and $(\Lambda(N+1) - 1)e^{-v/2}$ for $e^v \ge N+1$ (`increment_piecewise`).
2. **Domain Splitting:**
   Formal proof of the decomposition into ramp and terminal energy components (`increment_square_integral_split`).
3. **Exact Transitional Ramp Integral:**
   Formal proof of `ramp_square_integral`:
   $$
   \int_{\log N}^{\log(N+1)} (e^v - N)^2 e^{-v} dv = 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right).
   $$
4. **Total Evaluated Self-Energy:**
   Formal proof of `increment_square_integral_evaluated`:
   $$
   \int_0^\infty (\text{increment}(N, v))^2 dv = 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right) + \frac{(\Lambda(N+1) - 1)^2}{N+1}.
   $$

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact piecewise formula for the prime birth increment
theorem increment_piecewise {N : ℕ} {v : ℝ} (hv : 0 < v) :
    increment N v = if Real.exp v ≤ (N : ℝ) then 0 else
      if Real.exp v < ((N + 1 : ℕ) : ℝ) then -(Real.exp v - (N : ℝ)) * Real.exp (-v / 2)
      else (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v / 2)

-- Exact closed-form transitional ramp integral
theorem ramp_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
      (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) =
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ))

-- Total evaluated L² self-energy of the prime birth increment
theorem increment_square_integral_evaluated {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (increment N v)^2) =
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

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact closed-form evaluation of the $L^2((0, \infty))$ self-energy of the prime birth increment $\int_0^\infty (\Delta \text{source}_N)^2 dv = 1 + \frac{N}{N+1} - 2N\log(1+1/N) + \frac{(\Lambda(N+1)-1)^2}{N+1}$, decomposing the continuous geometric boundary cost from the arithmetic prime jump.
