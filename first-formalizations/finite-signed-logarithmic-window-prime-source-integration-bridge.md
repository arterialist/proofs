# First Formalization: Finite Signed Logarithmic Window Prime-Source Integration Bridge

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`](../../formalization/BuildingBlocks/LogarithmicPrimeWindow.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact non-asymptotic integration bridge connecting physical prime sums against critical windows to continuous integrals against the causal frozen source in Lean 4:

1. **Window Derivative Identity:**
   Formal proof of the differentiation rule for $W_s(x) = x^{-1/2} R(\log x - s)$ giving $W_s'(x) = x^{-3/2} (R' - R/2)(\log x - s)$ (`window_hasDerivAt`).
2. **Support Boundary Vanishing:**
   Formal proof that boundary terms vanish at $x = 1$ and at large cutoffs $x \ge e^{s+d}$ (`window_one_eq_zero`, `window_endpoint_eq_zero`).
3. **Single Window Residual Identity:**
   Formal proof of the identity $\sum_{n=2}^N \Lambda(n) W_s(n) - e^{s/2} \int e^{y/2} R(y) \, dy = - \int_{-\infty}^\infty S_C(v) \mathcal{K}_{R, D}(v - s) \, dv$ (`window_residual_frozen_source`).
4. **Finite Signed Window Superposition:**
   Formal proof that for any finite linear combination $\sum_{i \in T} c_i W_{s_i}$, the discrete sum minus density equals the continuous source integral against the linear combination of shifted kernels (`signed_windows_frozen_source`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Differentiation rule for critical window
theorem window_hasDerivAt {R D : ℝ → ℝ} {s x : ℝ} (hx : 0 < x)
    (hR : HasDerivAt R (D (Real.log x - s)) (Real.log x - s)) :
    HasDerivAt (window R s) (windowDerivative R D s x) x

-- Single window residual formula
theorem window_residual_frozen_source {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
      Real.exp (s / 2) * densityMoment R) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        sourceKernel R D (v - s))

-- Finite signed window superposition theorem
theorem signed_windows_frozen_source {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {R D : ℝ → ℝ} {d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y)
    (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window R (s i) n) - Real.exp (s i / 2) * densityMoment R)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * sourceKernel R D (v - s i)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified bridge establishing exact algebraic equivalence between finite signed discrete prime sums and continuous causal source integrals without contour integration or complex analytic continuation.
