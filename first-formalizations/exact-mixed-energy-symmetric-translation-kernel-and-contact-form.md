# First Formalization: Exact Mixed-Energy Symmetric Translation Kernel and Contact Form

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MixedEnergyKernel.lean`](../../formalization/BuildingBlocks/MixedEnergyKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact symmetric translation-kernel representations and diagonal mass cancellation for the mixed energy Dirichlet forms in Lean 4:

1. **Energy Finiteness in $L^2$:**
   Formal proof of `lag_lift_memLp`, `lag_backward_memLp`, `lag_forward_memLp`, `gradient_memLp_of_memLp`, and `energy_lt_top_of_memLp` ($H \in L^2 \implies \mathcal{E}(H) < \infty$).
2. **Translation Invariance and Cross-Orientation:**
   Formal proof of `lag_pair_integral`, `lag_shifted_pair_integral`, and `lag_cross_orientation` ($\int H(x-h)G(x) = \int H(x)G(x+h)$).
3. **Bilinear Form Decomposition:**
   Formal proof of `symmetricKernelPair_integrable` and `bilinear_eq_symmetricKernelPair`:
   \[
   \text{bilinear}(H, G) = 4 \langle H, G \rangle - \text{symmetricKernelPair}(H, G).
   \]
4. **Discrete Unit Pair Decomposition:**
   Formal proof of `translated_memLp` and `unitPair_eq_translations`:
   \[
   \text{unitPair}(H, G) = 2 \langle H, G \rangle - \int H(x) (G(x-1) + G(x+1)) dx.
   \]
5. **Exact Contact Form Formula:**
   Formal proof of `contactForm_eq_kernel`: diagonal cancellation yielding:
   \[
   \text{contactForm}(H, G) = -\text{symmetricKernelPair}(H, G) + 2 \int H(x) (G(x-1) + G(x+1)) dx.
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Energy finiteness for L² functions under gradient measure
theorem energy_lt_top_of_memLp {H : ℝ → ℝ} (hm : Measurable H)
    (hH : MemLp H 2 volume) : energy H < ∞

-- Cross-orientation invariance
theorem lag_cross_orientation {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    (∫ z : ℝ × ℝ, H (z.2 - z.1) * G z.2 ∂gradientMeasure) =
      ∫ z : ℝ × ℝ, H z.2 * G (z.2 + z.1) ∂gradientMeasure

-- Expansion into diagonal inner product and symmetric kernel
theorem bilinear_eq_symmetricKernelPair {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    bilinear H G = 4 * (∫ x, H x * G x) - symmetricKernelPair H G

-- Discrete unit pair expansion
theorem unitPair_eq_translations {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    unitPair H G = 2 * (∫ x, H x * G x) -
      ∫ x, H x * (G (x - 1) + G (x + 1))

-- Exact contact form representation with diagonal cancellation
theorem contactForm_eq_kernel {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    contactForm H G = -symmetricKernelPair H G +
      2 * ∫ x, H x * (G (x - 1) + G (x + 1))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact translation-kernel decomposition and diagonal mass cancellation of mixed continuous-discrete Dirichlet contact forms on $L^2(\mathbb{R})$.
