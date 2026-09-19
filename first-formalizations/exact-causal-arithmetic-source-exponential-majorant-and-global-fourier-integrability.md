# First Formalization: Exact Causal Arithmetic Source Exponential Majorant and Global Fourier Integrability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenIntegrability.lean`](../../formalization/BuildingBlocks/ChargeFrozenIntegrability.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-asymptotic exponential majorant and global Fourier Bochner integrability of the causal arithmetic source in Lean 4:

1. **Exponential Decay Majorant:**
   Formal proof that $|\text{causalSource}(N, v)| \le (\psi(N) + N) e^{-v/2}$ for all $v \ge 0$ (`source_abs_le`).
2. **Global $L^1$ Membership:**
   Formal proof of global Bochner integrability: `Integrable (causalSource N)` (`integrable_causalSource`).
3. **Absolute Fourier Integrability:**
   Formal proof that the angular Fourier integrand $v \mapsto e^{-i \xi v} \text{causalSource}(N, v)$ is integrable on $\mathbb{R}$ for every frequency $\xi \in \mathbb{R}$ (`integrable_fourier_integrand`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact exponential decaying majorant
theorem source_abs_le {N : ℕ} (v : ℝ) (hv : 0 ≤ v) :
    |causalSource N v| ≤ (psi N + (N : ℝ)) * Real.exp (-v / 2)

-- Global L¹ membership of the causal source
theorem integrable_causalSource (N : ℕ) : Integrable (causalSource N)

-- Global Bochner integrability of the Fourier transform integrand
theorem integrable_fourier_integrand (N : ℕ) (ξ : ℝ) :
    Integrable (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving explicit non-asymptotic exponential bounds and unconditional Fourier Bochner integrability for the accelerated causal prime source without smoothing windows or unproven conjectures.
