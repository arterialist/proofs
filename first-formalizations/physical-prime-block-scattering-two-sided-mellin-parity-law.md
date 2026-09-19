# First Formalization: Physical Prime-Block Scattering Two-Sided Mellin Parity Law

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact sign parity law of composite prime scattering blocks on two-sided real Mellin moments in Lean 4:

1. **Strict Multiplier Signs:**
   Formal proof that $M_+(p) < 0$ and $M_-(p) > 0$, hence $M_+(p) M_-(p) < 0$ (`actual_prime_multiplier_product_negative`).
2. **Strictly Positive Block Amplitude:**
   Formal proof that $\mathcal{A}(ps, \text{depth}, h) > 0$ for any prime block $ps$ (`actual_block_amplitude_positive`).
3. **Block Mellin Multiplicativity & Regularity:**
   Formal verification that physical prime blocks preserve continuity and compact support (`physical_block_regular`) and act multiplicatively on the Mellin transform (`actual_block_mellin`).
4. **Exact Block Mellin Parity Theorem:**
   Formal verification of the exact sign parity identity:
   \[
   \mathcal{M}(\mathcal{B} f)\left(h + \frac{1}{2}\right) \mathcal{M}(\mathcal{B} f)\left(-\left(h + \frac{1}{2}\right)\right) = (-1)^{|ps|} \mathcal{A} \left[ \mathcal{M}(f)\left(h + \frac{1}{2}\right) \mathcal{M}(f)\left(-\left(h + \frac{1}{2}\right)\right) \right]
   \]
   (`actual_block_two_sided_mellin_parity`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Regularity preservation
theorem physical_block_regular {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ) :
    Continuous (physicalBlock ps depth f) ∧ HasCompactSupport (physicalBlock ps depth f)

-- Multiplicative factorization on Mellin transform
theorem actual_block_mellin {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z =
      (ps.map (fun (p : ℕ) => BuildingBlocks.GrowingPrimeScatteringBounds.originalHistory
        (p : ℝ) z (depth p))).prod * BuildingBlocks.FullComplexHistoryMellin.mellin f z

-- Strictly positive amplitude
theorem actual_block_amplitude_positive (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) : 0 < amplitude ps depth h

-- Exact sign parity law
theorem actual_block_two_sided_mellin_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) (-((h : ℂ) + 1 / 2)) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) *
        (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) *
          BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 that each prime in a physical scattering block induces an exact sign flip $(-1)$ on two-sided real Mellin moments at half-integers $\pm(h + 1/2)$, establishing a parity barrier against classical positive-definite bounds.
