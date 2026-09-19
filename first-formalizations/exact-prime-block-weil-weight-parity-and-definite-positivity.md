# First Formalization: Exact Prime-Block Weil Weight Parity and Definite Positivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Mellin reflection invariance for even seeds, paired weight reduction to squared norm, exact prime-block Weil weight reflection parity $(-1)^k$, and guaranteed parity-compensated positivity in Lean 4:

1. **Even Reflection Invariance:**
   Formal proof that $\mathcal{M}(f)(-z) = \mathcal{M}(f)(z)$ for even $f$ (`mellin_reflection_even`).
2. **Paired Weight Reduction:**
   Formal proof of $\mathcal{W}_{f, f}(b) = |\mathcal{M}(f)(b)|^2$ (`even_seed_paired_weight`).
3. **Block Weil Weight Parity Law:**
   Formal induction establishing $\mathcal{W}_{U_{ps} f, U_{ps} f}(h+1/2) = (-1)^{|ps|} A(ps, d, h) \mathcal{W}_{f, f}(h+1/2)$ (`actual_block_paired_weight_parity`).
4. **Even Seed Block Weight Identity:**
   Formal derivation of real-valued representation $(-1)^{|ps|} A |\mathcal{M}(f)|^2$ (`actual_even_seed_block_weight`).
5. **Parity-Compensated Positivity:**
   Formal proof that $(-1)^{|ps|} \operatorname{Re}(\mathcal{W}) \ge 0$ (`actual_even_seed_parity_signed_weight_nonnegative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Mellin reflection invariance for even functions
theorem mellin_reflection_even {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin f (-z) =
      BuildingBlocks.FullComplexHistoryMellin.mellin f z

-- Even seed paired weight is norm squared
theorem even_seed_paired_weight {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (b : ℝ) :
    pairedWeight f f (b : ℂ) =
      (Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f (b : ℂ)) : ℂ)

-- Exact block paired weight parity law
theorem actual_block_paired_weight_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) * pairedWeight f f ((h : ℂ) + 1 / 2)

-- Real representation for even seeds
theorem actual_even_seed_block_weight {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (((-1 : ℝ) ^ ps.length * amplitude ps depth h *
        Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f
          ((h : ℂ) + 1 / 2)) : ℝ) : ℂ)

-- Parity-compensated non-negativity
theorem actual_even_seed_parity_signed_weight_nonnegative {f : ℝ → ℂ}
    (hf : Continuous f) (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) {h : ℕ} (hh : 1 ≤ h) :
    0 ≤ (-1 : ℝ) ^ ps.length *
      (pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f)
        ((h : ℂ) + 1 / 2)).re
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact parity law $\mathcal{W}_{U_{ps}} = (-1)^k A \mathcal{W}$ and guaranteed parity-compensated positivity $(-1)^k \operatorname{Re}(\mathcal{W}) \ge 0$ for prime-scattering blocks in the Weil explicit formula.
