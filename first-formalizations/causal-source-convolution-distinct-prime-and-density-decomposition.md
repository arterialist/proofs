# First Formalization: Causal Source Convolution Distinct-Prime and Density Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSourceDistinctFilter.lean`](../../formalization/BuildingBlocks/PrimeSourceDistinctFilter.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact filtered convolution decomposition for the arithmetic prime source in Lean 4:

1. **Local $L^2$ Integrability of Sources:**
   Formal proof that each prime block, frozen sum, density, and source function belongs to $L^2([0, s])$ for all $s \ge 0$ (`source_memLp`, `density_memLp`, `primeBlock_memLp`).
2. **Filter Integrability of Convolutions:**
   Formal proof that convolutions of local $L^2$ functions are integrable against the reflection kernel $e^{-3(s-v)/2}$ (`filtered_conv_integrable`).
3. **Exact Diagonal Identification:**
   Formal proof that the filtered diagonal sum equals the calibrated singular prime energy $\tau(s)$ (`filtered_diagonal_eq_tau`).
4. **Source-Tau Residual Decomposition:**
   Formal derivation of $\mathcal{L}_0(S * S)(s) - \tau(s) = \mathcal{L}_0(\mathrm{distinct})(s) - \mathcal{L}_0(\mathrm{mixedLeft})(s) - \mathcal{L}_0(\mathrm{mixedRight})(s) + \mathcal{L}_0(D * D)(s)$ (`filtered_source_distinct`).
5. **Continuous Density Self-Convolution Closed Form:**
   Formal evaluation of $(D * D)(s) = s e^{s/2}$ (`density_convolution`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Local L2 integrability of causal source
theorem source_memLp (s : ℝ) :
    MemLp source 2 (volume.restrict (Set.Icc 0 s))

-- Filtered convolution integrability
theorem filtered_conv_integrable {f g : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * conv f g v) volume 0 s

-- Exact identification of filtered diagonal
theorem filtered_diagonal_eq_tau {s : ℝ} (hs : 0 ≤ s) :
    L0 (diagonal s) s = tau s

-- Source-tau residual expansion
theorem filtered_source_distinct {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s =
      L0 (distinct s) s - L0 (mixedLeft s) s - L0 (mixedRight s) s +
        L0 (conv density density) s

-- Closed-form density convolution
theorem density_convolution {s : ℝ} (hs : 0 ≤ s) :
    conv density density s = s * Real.exp (s / 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified algebraic decomposition isolating the singular prime diagonal energy $\tau(s)$ from distinct prime interactions and continuous density in the quadratic energy balance of the prime source.
