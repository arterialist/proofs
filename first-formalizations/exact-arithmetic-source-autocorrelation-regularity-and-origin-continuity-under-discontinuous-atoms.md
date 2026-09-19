# First Formalization: Exact Arithmetic Source Autocorrelation Regularity and Origin Continuity Under Discontinuous Atoms

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean`](../../formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the almost-everywhere continuity of the discontinuous causal arithmetic source, dominated convergence of translate products, origin continuity of the autocorrelation function, and global $L^1$ convolution integrability in Lean 4:

1. **$L^2$ Space Membership:**
   Formal proof that $\text{complexSource}(N) \in L^2(\mathbb{R})$ (`memLp_complexSource`).
2. **Harmonic Angular-to-Mathlib Fourier Identification:**
   Formal proof of `hat_eq_mathlib_fourier`: $\widehat{f}(\xi) = \mathcal{F}(f)(\xi / (2\pi))$.
3. **Almost-Everywhere Continuity of Jump Signals:**
   Formal proof that `causalSource` is continuous almost everywhere with respect to Lebesgue measure (`ae_continuous_causalSource`).
4. **Origin Continuity via Dominated Convergence:**
   Formal proof that `ContinuousAt (autocorrelation N) 0` using almost-everywhere continuity and an integrable constant-times-source majorant (`continuousAt_autocorrelation_zero`).
5. **Autocorrelation Convolution Regularity:**
   Formal proof of Young's convolution integrability for the autocorrelation function (`integrable_autocorrelation`) and origin identity (`autocorrelation_zero`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Membership of the complex arithmetic source in L²(ℝ)
theorem memLp_complexSource {N : ℕ} (hN : 2 ≤ N) :
    MemLp (complexSource N) 2 volume

-- Exact connection between angular and unitary Mathlib Fourier transforms
theorem hat_eq_mathlib_fourier (N : ℕ) (ξ : ℝ) :
    hat N ξ = 𝓕 (complexSource N) (ξ / (2 * Real.pi))

-- Almost-everywhere continuity of the step-discontinuous source
theorem ae_continuous_causalSource {N : ℕ} (hN : 2 ≤ N) :
    ∀ᵐ v : ℝ, ContinuousAt (causalSource N) v

-- Continuity of autocorrelation at the Fourier inversion origin
theorem continuousAt_autocorrelation_zero {N : ℕ} (hN : 2 ≤ N) :
    ContinuousAt (autocorrelation N) 0

-- Global L¹ integrability of autocorrelation via Young's theorem
theorem integrable_autocorrelation (N : ℕ) :
    Integrable (autocorrelation N)

-- Value at the origin equals physical L² energy
theorem autocorrelation_zero (N : ℕ) :
    autocorrelation N 0 = ∫ v : ℝ, (causalSource N v) ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving origin continuity of the prime counting autocorrelation function across the dense lattice of jump discontinuities $\{\log n\}_{n=2}^N$ using almost-everywhere dominated convergence, enabling rigorous Fourier inversion.
