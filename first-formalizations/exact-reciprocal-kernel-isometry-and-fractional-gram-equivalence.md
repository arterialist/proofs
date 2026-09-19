# First Formalization: Exact Reciprocal Kernel Isometry and Fractional Gram Equivalence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ReciprocalIsometry.lean`](../../formalization/BuildingBlocks/ReciprocalIsometry.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact $L^2(0, \infty)$ Hilbert space isometry between fractional part kernels $\rho(\theta / x)$ and reciprocal kernels $\frac{\theta}{x}\rho(x / \theta)$ in Lean 4:

1. **Kernel Uniform Bounds & Measurability:**
   Formal proof of `fractionKernel_bounds` and `reciprocalKernel_bounds`: $0 \le K \le 1$ and $K \le \theta / x$.
2. **Product Integrability on $(0, \infty)$:**
   Formal proof of `integrableOn_Ioi_of_inverse_square_bound` and `fractionKernel_product_integrable`: every product of kernels is unconditionally in $L^1(0, \infty)$ via $O(x^{-2})$ decay.
3. **Hyperbolic Involutive Gram Equality:**
   Formal proof of `fractionKernel_gram_eq`: $\int_0^\infty K_{\text{frac}}(\theta, x) K_{\text{frac}}(\eta, x) dx = \int_0^\infty K_{\text{rec}}(\theta, x) K_{\text{rec}}(\eta, x) dx$ via $y = \theta \eta / x$.
4. **Finite Gram Matrix Isometry:**
   Formal proof of `kernelSum_gram_eq`: $\langle F, G \rangle_{L^2} = \langle \widetilde{F}, \widetilde{G} \rangle_{L^2}$ for arbitrary finite linear combinations.
5. **Universal Distance Preservation:**
   Formal proof of `kernelSum_distance_eq`: $\|F - G\|_{L^2} = \|\widetilde{F} - \widetilde{G}\|_{L^2}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Gram kernel equality
theorem fractionKernel_gram_eq {θ η : ℝ} (hθ : 0 < θ) (hη : 0 < η) :
    (∫ x in Set.Ioi (0 : ℝ), fractionKernel θ x * fractionKernel η x) =
      ∫ x in Set.Ioi (0 : ℝ), reciprocalKernel θ x * reciprocalKernel η x

-- Gram matrix isometry
theorem kernelSum_gram_eq {ι κ : Type*} (S : Finset ι) (T : Finset κ)
    (c θ : ι → ℝ) (d η : κ → ℝ)
    (hθ : ∀ i ∈ S, 0 < θ i) (hη : ∀ j ∈ T, 0 < η j) :
    (∫ x in Set.Ioi (0 : ℝ),
      kernelSum fractionKernel S c θ x * kernelSum fractionKernel T d η x) =
      ∫ x in Set.Ioi (0 : ℝ),
        kernelSum reciprocalKernel S c θ x * kernelSum reciprocalKernel T d η x

-- Distance isometry
theorem kernelSum_distance_eq {ι κ : Type*} (S : Finset ι) (T : Finset κ)
    (c θ : ι → ℝ) (d η : κ → ℝ)
    (hθ : ∀ i ∈ S, 0 < θ i) (hη : ∀ j ∈ T, 0 < η j) :
    (∫ x in Set.Ioi (0 : ℝ),
      (kernelSum fractionKernel S c θ x - kernelSum fractionKernel T d η x) ^ 2) =
      ∫ x in Set.Ioi (0 : ℝ),
        (kernelSum reciprocalKernel S c θ x - kernelSum reciprocalKernel T d η x) ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the isometric equivalence of fractional-part and reciprocal kernel Hilbert spaces on the positive real axis.
