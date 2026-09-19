# First Formalization: Exact Logarithmic Layercake Representation and Cauchy Moment Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/LogarithmicLayercake.lean`](../../formalization/BuildingBlocks/LogarithmicLayercake.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact layer-cake identity for logarithmic spectral moments and establishes optimal explicit bounds under Cauchy tail domination in Lean 4:

1. **Reciprocal Integrability and Primitives:**
   Formal proof of `reciprocal_intervalIntegrable` and `reciprocal_primitive` ($\int_0^t \frac{1}{2+x} dx = \log(2+t) - \log 2$).
2. **Logarithmic Layer-Cake Identity:**
   Formal proof of `logarithmic_layercake`:
   \[
   \int_{\mathbb{R}} (\log(2+|x|) - \log 2) d\mu = \int_0^\infty \mu(\{|x| > t\}) \frac{1}{2+t} dt.
   \]
3. **Two-Regime Truncation Bounds:**
   Formal proof of `logarithmic_layercake_le` and `log_increment_integral_le`:
   \[
   \int_{\mathbb{R}} (\log(2+|x|) - \log 2) d\mu \le H (\log(2+R) - \log 2) + \frac{2A}{R}.
   \]
4. **Optimal Threshold Minimization:**
   Formal proof of `optimized_increment_bound`: sharp upper bound $H (\log(1 + A/H) + 1)$ attained at $R = 2A/H$.
5. **Universal Density Log-Moment Bounds:**
   Formal proof of `log_moment_integrable`, `log_moment_le`, `density_log_moment`, `density_log_moment_zero`, and `density_log_moment_nonnegative_mass`:
   \[
   \int_{\mathbb{R}} r(x) \log(2+|x|) dx \le H \left( \log 2 + \log(1 + A/H) + 1 \right).
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact layer-cake formula for logarithmic increments
lemma logarithmic_layercake (μ : Measure ℝ) :
    (∫⁻ x : ℝ, ENNReal.ofReal (Real.log (2+|x|)-Real.log 2) ∂μ) =
      ∫⁻ t in Ioi (0 : ℝ), μ {x : ℝ | t < |x|} * ENNReal.ofReal (1/(2+t))

-- Two-regime truncation bound for any radius R > 0
lemma logarithmic_layercake_le {μ : Measure ℝ} {H A R : ℝ}
    (hH : 0 ≤ H) (hA : 0 ≤ A) (hR : 0 < R)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫⁻ x : ℝ, ENNReal.ofReal (Real.log (2+|x|)-Real.log 2) ∂μ) ≤
      ENNReal.ofReal (H*(Real.log (2+R)-Real.log 2)+2*A/R)

-- Optimized balance at R = 2A/H
lemma optimized_increment_bound {μ : Measure ℝ} {H A : ℝ}
    (hH : 0 < H) (hA : 0 < A)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫ x : ℝ, Real.log (2+|x|)-Real.log 2 ∂μ) ≤
      H*(Real.log (1+A/H)+1)

-- Full moment bound for Cauchy-dominated densities
lemma density_log_moment_nonnegative_mass {r : ℝ → ℝ} {A H : ℝ}
    (hm : Measurable r) (hr : Integrable r) (hn : ∀ x, 0 ≤ r x)
    (hA : 0 < A) (hH : 0 ≤ H) (hMass : (∫ x, r x)=H)
    (hb : ∀ x, r x ≤ A/(1+x^2)) :
    Integrable (fun x : ℝ => r x * Real.log (2+|x|)) ∧
    (∫ x : ℝ, r x * Real.log (2+|x|)) ≤
      H*(Real.log 2+Real.log (1+A/H)+1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact logarithmic layer-cake representation and sharp non-circular logarithmic moment bounds under Cauchy tail domination.
