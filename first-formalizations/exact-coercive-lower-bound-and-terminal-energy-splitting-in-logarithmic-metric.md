# First Formalization: Exact Coercive Lower Bound and Terminal Energy Splitting in Logarithmic Metric

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenMetric.lean`](../../formalization/BuildingBlocks/ChargeFrozenMetric.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact tail formula, tail square integral evaluation, prefix/terminal domain splitting, and the coercive lower bound for arithmetic causal sources in Lean 4:

1. **Terminal Tail Formula and Integrability:**
   Formal proofs that $\text{causalSource}(N, v) = (\psi(N) - N) e^{-v/2}$ for $v > \log N$ (`causalSource_terminal`) and its square is integrable on $(\log N, \infty)$ (`terminal_square_integrable`).
2. **Exact Terminal Square Integral:**
   Formal proof that $\int_{\log N}^\infty (\text{causalSource}(N, v))^2 dv = \frac{(\psi(N) - N)^2}{N}$ (`terminal_square_integral`).
3. **Exact Domain Splitting:**
   Formal proof that $\int_0^\infty (\text{causalSource})^2 = \int_0^{\log N} (\text{causalSource})^2 + \frac{(\psi(N)-N)^2}{N}$ (`full_square_integral_split`).
4. **Coercive Lower Bound:**
   Formal proof that $\frac{(\psi(N) - N)^2}{N} \le \int_0^\infty (\text{causalSource}(N, v))^2 dv$ (`full_square_integral_lower_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Terminal formula for the frozen causal source
theorem causalSource_terminal {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) :
    causalSource N v = (psi N - (N : ℝ)) * Real.exp (-v / 2)

-- Exact evaluation of the tail square integral
theorem terminal_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (Real.log (N : ℝ)), (causalSource N v)^2) =
      (psi N - (N : ℝ))^2 / (N : ℝ)

-- Domain decomposition into prefix and terminal parts
theorem full_square_integral_split {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
      (∫ v in Ioc 0 (Real.log (N : ℝ)), (causalSource N v)^2) +
        (psi N - (N : ℝ))^2 / (N : ℝ)

-- Coercive lower bound on the Chebyshev prime counting error
theorem full_square_integral_lower_bound {N : ℕ} (hN : 2 ≤ N) :
    (psi N - (N : ℝ))^2 / (N : ℝ) ≤ ∫ v in Ioi (0 : ℝ), (causalSource N v)^2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that the $L^2$ dispersion of the causal arithmetic source coercively controls the normalized Chebyshev error $\frac{(\psi(N) - N)^2}{N}$ from below via exact domain integration in the logarithmic coordinate $v$.
