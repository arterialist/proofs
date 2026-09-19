# First Formalization: Even-Seed Prime-Block Paired Weil Weight Parity Law

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact parity law for paired Weil weights under composite prime scattering blocks in Lean 4:

1. **Even Seed Paired Weight Identity:**
   Formal proof that for an even seed $f(-v) = f(v)$, the paired weight at real $b$ equals $|\mathcal{M}(f)(b)|^2$ (`even_seed_paired_weight`).
2. **Exact Prime Block Paired Weight Transformation:**
   Formal derivation of $W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f) = (-1)^{|ps|} \mathcal{A} W(f, f)$ at $h + 1/2$ (`actual_block_paired_weight_parity`).
3. **Even Seed Block Weight Identity:**
   Formal reduction to $W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f) = (-1)^{|ps|} \mathcal{A} |\mathcal{M}(f)(h+1/2)|^2$ (`actual_even_seed_block_weight`).
4. **Parity-Signed Non-Negativity:**
   Formal proof that $(-1)^{|ps|} \operatorname{Re}(W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)(h+1/2)) \ge 0$ unconditionally (`actual_even_seed_parity_signed_weight_nonnegative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Even seed paired weight is norm squared
theorem even_seed_paired_weight {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (b : ℝ) :
    pairedWeight f f (b : ℂ) =
      (Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f (b : ℂ)) : ℂ)

-- Prime block paired weight parity transformation
theorem actual_block_paired_weight_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) * pairedWeight f f ((h : ℂ) + 1 / 2)

-- Even seed block weight formula
theorem actual_even_seed_block_weight {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (((-1 : ℝ) ^ ps.length * amplitude ps depth h *
        Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f
          ((h : ℂ) + 1 / 2)) : ℝ) : ℂ)

-- Universal parity-signed non-negativity
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

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 that local paired Weil weights switch signs depending strictly on the parity of the number of primes in a physical scattering block.
