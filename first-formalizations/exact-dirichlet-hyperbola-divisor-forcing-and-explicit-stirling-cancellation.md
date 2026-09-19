# First Formalization: Exact Dirichlet Hyperbola Divisor Forcing and Explicit Stirling Cancellation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/DivisorForcingBound.lean`](../../formalization/BuildingBlocks/DivisorForcingBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact Dirichlet hyperbola dissection, explicit divisor error bounds, log factorial integral estimates, and non-asymptotic divisor forcing bound in Lean 4:

1. **Exact Combinatorial Hyperbola Decomposition:**
   Formal proof of `floor_sum_hyperbola`: $\sum_{a=1}^N \lfloor N/a \rfloor + m^2 = 2 \sum_{a=1}^m \lfloor N/a \rfloor$.
2. **Harmonic Discrepancy Bounds:**
   Formal proof of `harmonic_euler_error_bounds`: $0 \le H_m - \log m - \gamma \le 1/m$.
3. **Explicit Divisor Problem Remainder:**
   Formal proof of `divisorSum_error_le`: $|\sum_{n \le N} d(n) - (N \log N + (2\gamma - 1)N)| \le 10 \lfloor \sqrt{N} \rfloor$.
4. **Log Factorial Stirling Integral Envelopes:**
   Formal proof of `logFactorial_integral_bounds` and `logFactorial_error_le`: $|\log(N!) - (N \log N - N)| \le 1 + \log N$.
5. **Non-Asymptotic Centered Divisor Forcing Bound:**
   Formal proof of `centeredDivisorForcing_sqrt_bound`: $|\text{centeredDivisorForcing}(N)| \le 13 \sqrt{N}$ for all $N \ge 1$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact Dirichlet hyperbola dissection
theorem floor_sum_hyperbola (N m : ℕ) (hm : m ≤ N)
    (hm2 : m * m ≤ N) (hN : N < (m + 1) * (m + 1)) :
    (∑ a ∈ Finset.Icc 1 N, N / a) + m * m =
      2 * (∑ a ∈ Finset.Icc 1 m, N / a)

-- Explicit divisor sum remainder
theorem divisorSum_error_le {N : ℕ} (hN : 1 ≤ N) :
    |divisorSum N - ((N : ℝ) * Real.log N +
      (2 * Real.eulerMascheroniConstant - 1) * N)| ≤ 10 * (N.sqrt : ℝ)

-- Explicit log factorial bounds
theorem logFactorial_integral_bounds {N : ℕ} (hN : 1 ≤ N) :
    (N : ℝ) * Real.log N - N + 1 ≤ logFactorial N ∧
    logFactorial N ≤ (N : ℝ) * Real.log N - N + 1 + Real.log N

-- Non-asymptotic square-root divisor forcing bound
theorem centeredDivisorForcing_sqrt_bound {N : ℕ} (hN : 1 ≤ N) :
    |centeredDivisorForcing N| ≤ 13 * Real.sqrt N
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the non-asymptotic $13\sqrt{N}$ bound for centered divisor forcing via the exact combinatorial Dirichlet hyperbola method and monotonic integral comparisons for factorials.
