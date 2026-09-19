# Contribution 327: Exact Gradient Realization of Mixed Additive Energy and Contact Form Norm-Nine Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MixedEnergyBilinear.lean`](../../formalization/BuildingBlocks/MixedEnergyBilinear.lean), [`building-blocks/mixed-energy/bilinear.md`](../../building-blocks/mixed-energy/bilinear.md)  
**Classification:** Functional Analysis / Measure Theory / Mixed Additive Energy / Bilinear Forms / Contact Operators / Operator Norms / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral and variational analysis of Beurling-Nyman systems with mixed short/long lag increments, the additive energy $\mathcal{E}(H)$ is defined by integrating squared differences across two scales: short lags $h \in (0, 1)$ with Lebesgue measure and long tails $h > 1$ with inverse-square density $h^{-2} dh$.

This contribution proves:

1. **Exact Total Lag Measure Finite Mass:**  
   The hybrid measure $\mu_{\text{lag}} = \text{Leb}|_{(0, 1)} + h^{-2} \text{Leb}|_{(1, \infty)}$ has total mass exactly 2:
   $$
   \mu_{\text{lag}}(\mathbb{R}) = \int_0^1 1 \, dh + \int_1^\infty \frac{1}{h^2} \, dh = 1 + 1 = 2.
   $$
2. **Exact Gradient Space Realization:**  
   Defining the 2D gradient measure $\mu_{\text{grad}} = \mu_{\text{lag}} \otimes \text{Leb}$ on $\mathbb{R} \times \mathbb{R}$ and the difference gradient $\nabla H(h, x) = H(x) - H(x - h)$, the mixed additive energy is exactly realized as the $L^2(\mu_{\text{grad}})$ norm squared:
   $$
   \mathcal{E}(H) = \iint_{\mathbb{R}^2} (\nabla H(h, x))^2 \, d\mu_{\text{grad}}(h, x).
   $$
   Zero Fourier transform or unweighted $L^2$ assumptions are required.
3. **Exact Bilinear Form and Energy Identification:**  
   The natural bilinear form $\mathcal{B}(H, G) = \int \nabla H \nabla G \, d\mu_{\text{grad}}$ satisfies $\mathcal{B}(H, H) = \mathcal{E}(H)$ and Cauchy-Schwarz:
   $$
   |\mathcal{B}(H, G)| \le \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)}.
   $$
4. **Exact Unit Step Bilinear Bound:**  
   The unit-lag pairing $\text{unitPair}(H, G) = \int (H(x) - H(x-1))(G(x) - G(x-1)) \, dx$ satisfies:
   $$
   |\text{unitPair}(H, G)| \le 4 \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)}.
   $$
5. **Exact Norm-Nine Bound on the Contact Operator Form:**  
   The contact form $\mathcal{C}(H, G) = \mathcal{B}(H, G) - 2 \text{unitPair}(H, G)$ satisfies the unconditional continuity estimate:
   $$
   |\mathcal{C}(H, G)| \le 9 \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)},
   $$
   proving that the contact form defines a bounded operator on the energy Hilbert space with operator norm bounded by 9.

---

## 2. Mathematical Proof

### 2.1. Lag Measure Mass
$\int_0^1 1 \, dh = 1$. By the inverse square tail theorem, $\int_1^\infty h^{-2} \, dh = 1/1 = 1$. Total mass $= 1 + 1 = 2$.

### 2.2. Gradient Isometry
Applying Fubini-Tonelli on the product measure $\mu_{\text{lag}} \otimes \text{volume}$, the 2D integral splits into the integral over $h \in (0, 1)$ of $\int (H(x) - H(x-h))^2 dx$ (short energy) plus $\int_1^\infty h^{-2} \int (H(x) - H(x-h))^2 dx dh$ (long energy), which matches the definition of $\mathcal{E}(H)$.

### 2.3. Unit Step and Contact Bound
By the previously established unit-step inequality, $\int (H(x) - H(x-1))^2 dx \le 4 \mathcal{E}(H)$.
Applying Cauchy-Schwarz to $\text{unitPair}$:
$|\text{unitPair}(H, G)| \le \sqrt{4 \mathcal{E}(H)} \sqrt{4 \mathcal{E}(G)} = 4 \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)}$.
Finally, by the triangle inequality on $\mathcal{C} = \mathcal{B} - 2 \, \text{unitPair}$:
$|\mathcal{C}(H, G)| \le |\mathcal{B}(H, G)| + 2 |\text{unitPair}(H, G)| \le 1 \cdot \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)} + 2 \cdot 4 \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)} = 9 \sqrt{\mathcal{E}(H)} \sqrt{\mathcal{E}(G)}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MixedEnergy` in `formalization/BuildingBlocks/MixedEnergyBilinear.lean`):
```lean
theorem energy_eq_gradient {H : ℝ → ℝ} (hH : Measurable H) :
    energy H = ∫⁻ z, ENNReal.ofReal (gradient H z ^ 2) ∂gradientMeasure

theorem bilinear_self {H : ℝ → ℝ} (hH : Measurable H) (hE : energy H < ∞) :
    bilinear H H = (energy H).toReal

theorem bilinear_bound {H G : ℝ → ℝ} (hH : Measurable H) (hG : Measurable G)
    (hE : energy H < ∞) (hF : energy G < ∞) :
    |bilinear H G| ≤ sqrt ((energy H).toReal) * sqrt ((energy G).toReal)

theorem unitPair_bound {H G : ℝ → ℝ} (hH : Measurable H) (hG : Measurable G)
    (hE : energy H < ∞) (hF : energy G < ∞) :
    |unitPair H G| ≤ 4 * sqrt ((energy H).toReal) * sqrt ((energy G).toReal)

theorem contactForm_bound {H G : ℝ → ℝ} (hH : Measurable H) (hG : Measurable G)
    (hE : energy H < ∞) (hF : energy G < ∞) :
    |contactForm H G| ≤ 9 * sqrt ((energy H).toReal) * sqrt ((energy G).toReal)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Beurling (1955) *A closure problem related to the Riemann Zeta-function*; Báez-Duarte (2003) *A strengthening of the Nyman-Beurling criterion*; Burnol (2001) *On a problem of Nyman concerning the Riemann Hypothesis*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact Hilbert space geometry of mixed additive energies without Fourier transforms, proving the unconditional continuity and norm-9 bound of the contact bilinear form.
- **Target Venues:** *Journal of Functional Analysis* or *Integral Equations and Operator Theory*.
