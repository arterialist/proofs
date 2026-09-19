# First Formalization: Exact Prime-Block Scattering Mellin Parity and Amplitude Bounds

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean), [`formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact preservation of regularity and compact support for multi-prime physical blocks, product factorization of Mellin transforms, vanishing moment preservation, the two-sided reflection parity law $(-1)^k$, and universal geometric amplitude bounds in Lean 4:

1. **Regularity and Support:**
   Formal proof that $U_{ps} f \in C_c(\mathbb{R})$ for $f \in C_c(\mathbb{R})$ (`physical_block_regular`).
2. **Multi-Prime Mellin Factorization:**
   Formal proof of $\mathcal{M}(U_{ps} f)(z) = (\prod \Theta_p(z)) \mathcal{M}(f)(z)$ (`actual_block_mellin`).
3. **Zero Moment Preservation:**
   Formal derivation of $\mathcal{M}(f)(z) = 0 \implies \mathcal{M}(U_{ps} f)(z) = 0$ (`actual_block_preserves_zero_moment`).
4. **Reflection Parity Law:**
   Formal proof that the two-sided Mellin product at $\pm(h+1/2)$ acquires exact parity $(-1)^k$ (`actual_block_two_sided_mellin_parity`).
5. **Geometric Amplitude Bounds:**
   Formal induction proving $(1/8)^k \prod p^{h \cdot d(p)} \le A(ps, d, h) \le 2^k \prod p^{h \cdot d(p)}$ (`actual_block_amplitude_bounds`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Regularity and compact support preservation
theorem physical_block_regular {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ) :
    Continuous (physicalBlock ps depth f) ∧ HasCompactSupport (physicalBlock ps depth f)

-- Mellin product factorization
theorem actual_block_mellin {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z =
      (ps.map (fun (p : ℕ) => BuildingBlocks.GrowingPrimeScatteringBounds.originalHistory
        (p : ℝ) z (depth p))).prod * BuildingBlocks.FullComplexHistoryMellin.mellin f z

-- Zero-moment preservation
theorem actual_block_preserves_zero_moment {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ)
    (hz : BuildingBlocks.FullComplexHistoryMellin.mellin f z = 0) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z = 0

-- Strict positivity of block amplitude
theorem actual_block_amplitude_positive (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) : 0 < amplitude ps depth h

-- Exact reflection parity identity
theorem actual_block_two_sided_mellin_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) (-((h : ℂ) + 1 / 2)) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) *
        (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) *
          BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))

-- Two-sided geometric amplitude bounds
theorem actual_block_amplitude_bounds (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) :
    (1 / 8 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod ≤
      amplitude ps depth h ∧
    amplitude ps depth h ≤
      (2 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact reflection parity law $(-1)^k$ and geometric amplitude bounds for arbitrary prime scattering sequences acting on physical waveforms.
