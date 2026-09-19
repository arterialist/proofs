# First Formalization: Exact Compact Physical Mellin Holomorphy and Pole-Null Cauchy Residue Vanishing

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean`](../../formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the entire holomorphy of compact physical Mellin transforms, Cauchy integral representations, and exact vanishing of pole circle corrections at $s = 0, 1$ in Lean 4:

1. **Entire Holomorphy via Dominated Differentiation:**
   Formal proof of `physical_mellin_hasDerivAt`, `physical_mellin_entire`, and `physical_mellin_analytic`: entire holomorphy on all of $\mathbb{C}$.
2. **Conjugate Dictionary and Product Weights:**
   Formal proof of `conjugate_mellin_dictionary`, `paired_weight_entire`, `paired_weight_analytic`, `centered_weight_entire`, and `centered_weight_analytic`.
3. **Block Conditioner Regularity:**
   Formal proof of `finite_block_centered_weight_entire` and `finite_block_centered_weight_analytic`.
4. **Cauchy Integral Evaluation:**
   Formal proof of `entire_weight_circle_coefficient`: $\oint_{C(c, R)} \frac{F(w)}{w-s} dw = 2\pi i F(s)$.
5. **Exact Pole Residue Circle Vanishing:**
   Formal proof of `pole_null_circle_corrections` and `finite_block_pole_null_circle_corrections`:
   \[
   \oint_{C(c, R)} \frac{\mathcal{W}(w)}{w} dw = 0 \quad \text{and} \quad \oint_{C(c, R)} \frac{\mathcal{W}(w)}{w-1} dw = 0
   \]
   under physical null conditions $\mathcal{M}[f](\pm 1/2) = 0$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Entire holomorphy of compact physical Mellin transform
theorem physical_mellin_entire {f : ℝ → ℂ} (hf : Continuous f)
    (hfc : HasCompactSupport f) :
    Differentiable ℂ (BuildingBlocks.FullComplexHistoryMellin.mellin f)

-- Cauchy integral formula for entire functions
theorem entire_weight_circle_coefficient (F : ℂ → ℂ) (hF : Differentiable ℂ F)
    (c s : ℂ) (R : ℝ) (hs : s ∈ Metric.ball c R) :
    (∮ w in C(c, R), F w / (w - s)) = (2 * Real.pi * Complex.I) * F s

-- Vanishing of Cauchy residue circle integrals at s = 0 and s = 1
theorem pole_null_circle_corrections {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (h0 : (0 : ℂ) ∈ Metric.ball c R) (h1 : (1 : ℂ) ∈ Metric.ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w / w) = 0 ∧
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w / (w - 1)) = 0

-- Invariance under finite prime block conditioning
theorem finite_block_pole_null_circle_corrections {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (h0 : (0 : ℂ) ∈ Metric.ball c R) (h1 : (1 : ℂ) ∈ Metric.ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w / w) = 0 ∧
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w / (w - 1)) = 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the entire holomorphy of compact physical Mellin transforms and the exact vanishing of Cauchy residue circle corrections around spectral poles $s = 0, 1$ for both bare and block-conditioned physical states.
