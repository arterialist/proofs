# Unique Contribution 305: Exact Mixed-Energy Symmetric Translation Kernel and Contact Form

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MixedEnergyKernel.lean`](../../formalization/BuildingBlocks/MixedEnergyKernel.lean), [`building-blocks/mixed-energy/kernel.md`](../../building-blocks/mixed-energy/kernel.md)  
**Classification:** Functional Analysis / Dirichlet Forms / Translation Semigroups / Convolution Kernels / Symmetrized Bilinear Forms / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the variational theory of energy dissipation on real line geometries, the mixed gradient quadratic form measures the $L^2$ discrepancy across both infinitesimal spatial scales and discrete lag shifts:
\[
\text{gradient}(H)(h, x) = H(x) - H(x - h).
\]
Pairing two functions $H, G \in L^2(\mathbb{R})$ across the product measure $d\mu_{\text{gradient}}(h, x) = d\mu_{\text{lag}}(h) dx$ produces the bilinear energy form $\text{bilinear}(H, G)$. Simultaneously, the discrete unit step forms the unit pair $\text{unitPair}(H, G)$, and their difference yields the physical contact form $\text{contactForm}(H, G) = \text{bilinear}(H, G) - 2 \cdot \text{unitPair}(H, G)$.

This contribution proves:

1. **Exact Representation of the Physical Contact Form:**  
   For any $H, G \in L^2(\mathbb{R})$:
   \[
   \text{contactForm}(H, G) = - \text{symmetricKernelPair}(H, G) + 2 \int_{-\infty}^\infty H(x) \left( G(x - 1) + G(x + 1) \right) dx,
   \]
   where the diagonal mass terms identically cancel.
2. **Expansion of the Continuous Bilinear Form:**  
   The bilinear gradient form expands into diagonal and symmetric lag-kernel components:
   \[
   \text{bilinear}(H, G) = 4 \int_{-\infty}^\infty H(x) G(x) dx - \int_{\mathbb{R} \times \mathbb{R}} H(x) \left( G(x - h) + G(x + h) \right) d\mu_{\text{lag}}(h) dx.
   \]
3. **Discrete Unit Pair Decomposition:**  
   The discrete unit step form decomposes into:
   \[
   \text{unitPair}(H, G) = 2 \int_{-\infty}^\infty H(x) G(x) dx - \int_{-\infty}^\infty H(x) \left( G(x - 1) + G(x + 1) \right) dx.
   \]
4. **Cross-Orientation Invariance:**  
   Under the gradient measure, backward and forward shifts are exact adjoints:
   \[
   \int H(x - h) G(x) d\mu_{\text{lag}}(h) dx = \int H(x) G(x + h) d\mu_{\text{lag}}(h) dx.
   \]
5. **Universal Energy Finiteness:**  
   Any function $H \in L^2(\mathbb{R}, dx)$ automatically has finite mixed gradient energy: $\text{energy}(H) < \infty$.

---

## 2. Mathematical Proof

### 2.1. Bilinear Expansion
Expanding the pointwise gradient product:
\[
(H(x) - H(x-h))(G(x) - G(x-h)) = H(x)G(x) + H(x-h)G(x-h) - H(x)G(x-h) - H(x-h)G(x).
\]
Integrating with respect to $dx$:
- $\int H(x) G(x) dx$ is the standard inner product.
- By translation invariance of Lebesgue measure, $\int H(x-h) G(x-h) dx = \int H(x) G(x) dx$.
- Integrating against $d\mu_{\text{lag}}(h)$ with total mass $\mu_{\text{lag}}(\mathbb{R}) = 2$ produces $2 + 2 = 4$ for the diagonal terms.
- By translation change of variables $y = x - h$, $\int H(x-h) G(x) dx = \int H(y) G(y+h) dy$.
Thus the off-diagonal terms combine into $\int H(x)(G(x-h) + G(x+h)) d\mu_{\text{lag}}(h) dx = \text{symmetricKernelPair}(H, G)$.
Hence $\text{bilinear}(H, G) = 4 \langle H, G \rangle - \text{symmetricKernelPair}(H, G)$.

### 2.2. Unit Pair Expansion
Similarly, for the discrete unit shift $h = 1$:
\[
\text{unitPair}(H, G) = \int (H(x) - H(x-1))(G(x) - G(x-1)) dx = 2 \langle H, G \rangle - \int H(x)(G(x-1) + G(x+1)) dx.
\]

### 2.3. Cancellation in Contact Form
Subtracting $2 \times \text{unitPair}$:
\[
\text{contactForm}(H, G) = \text{bilinear}(H, G) - 2 \cdot \text{unitPair}(H, G)
\]
\[
= \left( 4 \langle H, G \rangle - \text{symmetricKernelPair}(H, G) \right) - 2 \left( 2 \langle H, G \rangle - \int H(x)(G(x-1) + G(x+1)) dx \right)
\]
\[
= - \text{symmetricKernelPair}(H, G) + 2 \int H(x) (G(x-1) + G(x+1)) dx.
\]
The diagonal term $4\langle H, G \rangle - 4\langle H, G \rangle = 0$ cancels identically.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MixedEnergy` in `formalization/BuildingBlocks/MixedEnergyKernel.lean`):
```lean
theorem energy_lt_top_of_memLp {H : ℝ → ℝ} (hm : Measurable H)
    (hH : MemLp H 2 volume) : energy H < ∞

theorem lag_cross_orientation {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    (∫ z : ℝ × ℝ, H (z.2 - z.1) * G z.2 ∂gradientMeasure) =
      ∫ z : ℝ × ℝ, H z.2 * G (z.2 + z.1) ∂gradientMeasure

theorem bilinear_eq_symmetricKernelPair {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    bilinear H G = 4 * (∫ x, H x * G x) - symmetricKernelPair H G

theorem unitPair_eq_translations {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    unitPair H G = 2 * (∫ x, H x * G x) -
      ∫ x, H x * (G (x - 1) + G (x + 1))

theorem contactForm_eq_kernel {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    contactForm H G = -symmetricKernelPair H G +
      2 * ∫ x, H x * (G (x - 1) + G (x + 1))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Beurling and Deny (1959) *Dirichlet Spaces*; Fukushima (1980) *Dirichlet Forms and Markov Processes*. Machine verification of symmetric translation-kernel decompositions and diagonal mass cancellation in mixed continuous-discrete contact forms in Lean 4 is new.
- **Advancement:** Establishes the exact algebraic structure and translation representations for mixed continuous-discrete Dirichlet contact forms on $L^2(\mathbb{R})$.
- **Target Venues:** *Journal of Functional Analysis* or *Potential Analysis*.
