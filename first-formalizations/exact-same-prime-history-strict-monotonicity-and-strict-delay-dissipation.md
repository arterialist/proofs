# First Formalization: Exact Same-Prime History Strict Monotonicity and Strict Delay Dissipation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeStrictDelay.lean`](../../formalization/BuildingBlocks/SamePrimeStrictDelay.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the global strict monotonicity of the renewal profile $H(x)$, the global strict monotonicity of the same-prime history function $s(v)$ on $[\log 4, \infty)$, the strict loss of energy under positive delays, and the strict negativity of the delay dissipation residual in Lean 4:

1. **Global Renewal Strict Monotonicity:**
   Formal proof by boundary gluing that $H$ is strictly monotone increasing on $[1, \infty)$ (`H_strictMonoOn`).
2. **Global History Strict Monotonicity:**
   Formal proof that $s(v)$ is strictly monotone increasing on $[\log 4, \infty)$ (`s_strictMonoOn`).
3. **Strict Delay Energy Loss:**
   Formal proof that $s(v - r) < s(v)$ for all $v > \log 4$ and $r > 0$ (`s_delay_lt`).
4. **Strict Delay Dissipation:**
   Formal proof that $\int_0^\infty s(v - r) \, d\mu(r) - s(v) < 0$ for any causal probability measure with $\mu((0, \infty)) > 0$ (`samePrime_residual_neg`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Renewal profile global strict monotonicity
theorem H_strictMonoOn : StrictMonoOn H (Set.Ici 1)

-- History function global strict monotonicity
theorem s_strictMonoOn : StrictMonoOn s (Set.Ici (Real.log 4))

-- Strict delay energy loss
theorem s_delay_lt {v r : ℝ} (hv : Real.log 4 < v) (hr : 0 < r) :
    s (v - r) < s v

-- Strict delay dissipation under non-degenerate delay measures
theorem samePrime_residual_neg {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (hpositive : 0 < μ (Set.Ioi 0))
    {v : ℝ} (hv : Real.log 4 < v) :
    (∫ r, s (v - r) ∂μ) - s v < 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing strict monotonicity $s(u) < s(v)$ for prime-power history functionals and proving strict energy dissipation $\int s(v-r)d\mu(r) - s(v) < 0$ under non-degenerate causal probability delay measures.
