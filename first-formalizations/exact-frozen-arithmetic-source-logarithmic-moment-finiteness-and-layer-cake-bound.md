# First Formalization: Exact Frozen Arithmetic Source Logarithmic-Moment Finiteness and Layer-Cake Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenLogMoment.lean`](../../formalization/BuildingBlocks/ChargeFrozenLogMoment.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the global integrability and explicit layer-cake logarithmic-moment bound for the actual whole-frequency frozen causal source in Lean 4:

1. **Measurability and Majorization:**
   Formal proofs that the Fourier transform $\widehat{\text{causalSource}}(N, \cdot)$ and spectral density $\|\widehat{\text{causalSource}}(N, \cdot)\|^2$ are measurable (`measurable_hat`, `measurable_density`), and that the density is pointwise majorized by $E(N)/(1+\xi^2)$ (`density_le_envelope`).
2. **Global Density Integrability:**
   Formal proof that the arithmetic spectral density is globally integrable: `Integrable (density N)` (`integrable_density`).
3. **Logarithmic-Moment Finiteness and Bound:**
   Formal proof that $\xi \mapsto \text{density}(N, \xi) \log(2 + |\xi|)$ is integrable on $\mathbb{R}$ and bounded by $\text{mass}(N) (\log 2 + \log(1 + E(N)/\text{mass}(N)) + 1)$ without a positive-denominator premise (`actual_log_moment`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Measurability of Fourier transform
theorem measurable_hat (N : ℕ) : Measurable (hat N)

-- Measurability of spectral density
theorem measurable_density (N : ℕ) : Measurable (density N)

-- Pointwise envelope majorization
theorem density_le_envelope {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    density N ξ ≤ envelope N / (1 + ξ ^ 2)

-- Global integrability of spectral density
theorem integrable_density {N : ℕ} (hN : 2 ≤ N) : Integrable (density N)

-- Layer-cake logarithmic-moment theorem for whole-frequency actual source
theorem actual_log_moment {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      mass N * (Real.log 2 + Real.log (1 + envelope N / mass N) + 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving global integrability and an explicit non-asymptotic layer-cake logarithmic moment bound for the whole-frequency arithmetic source without artificial frequency cutoffs or unproven hypotheses.
