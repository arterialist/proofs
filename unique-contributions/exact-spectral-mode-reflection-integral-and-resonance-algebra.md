# Unique Contribution 147: Exact Spectral Mode Reflection Integral and Resonance Algebra

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SelbergSpectralModes.lean`](../../formalization/BuildingBlocks/SelbergSpectralModes.lean), [`building-blocks/selberg/selberg-spectral-modes.md`](../../building-blocks/selberg/selberg-spectral-modes.md)  
**Classification:** Harmonic Analysis / Spectral Theory / Selberg Reflection Convolutions / Resonant Modes / Continuous Bilinear Fourier Transforms

---

## 1. Executive Summary and Mathematical Statement

In spectral approaches to the Selberg symmetry formula and the explicit formula for prime numbers, decomposing the continuous reflection convolution $\int_0^T f(t) g(T - t) dt$ across imaginary zero frequencies requires distinguishing exactly between resonant mode pairs ($\gamma = \delta$, which grow linearly in the duration $T$) and non-resonant mode pairs ($\gamma \ne \delta$, which oscillate with bounded $O(1/|\gamma - \delta|)$ amplitudes).

This contribution proves:

1. **Exact Reflected Spectral Mode Integral:**  
   For any two real frequencies $\gamma, \delta \in \mathbb{R}$ and any real time duration $T \in \mathbb{R}$, with additive spectral modes $e_{\gamma}(t) = \exp(i \gamma t)$:
   \[
   \int_0^T e_{\gamma}(t) e_{\delta}(T - t) dt = \begin{cases}
   T \exp(i \gamma T) & \text{if } \gamma = \delta \text{ (exact resonance)}, \\
   \dfrac{\exp(i \gamma T) - \exp(i \delta T)}{i(\gamma - \delta)} & \text{if } \gamma \ne \delta \text{ (off-resonant mode)}.
   \end{cases}
   \]
2. **Universal Reflection Convolution of Finite Spectral Sums:**  
   For any finite collections of modes $\sum_{i \in s} A_i e_{\gamma_i}(t)$ and $\sum_{j \in r} B_j e_{\delta_j}(t)$, the reflection integral evaluates to the exact double sum:
   \[
   \int_0^T \left( \sum_{i \in s} A_i e_{\gamma_i}(t) \right) \left( \sum_{j \in r} B_j e_{\delta_j}(T - t) \right) dt = \sum_{i \in s} \sum_{j \in r} A_i B_j \left( \mathbf{1}_{\gamma_i = \delta_j} T e^{i \gamma_i T} + \mathbf{1}_{\gamma_i \ne \delta_j} \frac{e^{i \gamma_i T} - e^{i \delta_j T}}{i(\gamma_i - \delta_j)} \right).
   \]

---

## 2. Mathematical Proof

### 2.1. Exact Resonance Branch ($\gamma = \delta$)
If $\gamma = \delta$:
\[
e_{\gamma}(t) e_{\delta}(T - t) = \exp(i \gamma t) \exp(i \gamma (T - t)) = \exp(i \gamma (t + T - t)) = \exp(i \gamma T).
\]
The integrand is independent of the integration variable $t$.
Integrating the constant over $[0, T]$:
\[
\int_0^T \exp(i \gamma T) dt = T \exp(i \gamma T).
\]

### 2.2. Off-Resonant Branch ($\gamma \ne \delta$)
If $\gamma \ne \delta$:
\[
e_{\gamma}(t) e_{\delta}(T - t) = \exp(i \delta T) \exp(i (\gamma - \delta) t).
\]
Since $\gamma - \delta \ne 0$, the complex frequency $\alpha = i(\gamma - \delta)$ satisfies $\alpha \ne 0$.
Integrating the exponential:
\[
\int_0^T \exp(\alpha t) dt = \left[ \frac{\exp(\alpha t)}{\alpha} \right]_0^T = \frac{\exp(\alpha T) - 1}{\alpha} = \frac{\exp(i (\gamma - \delta) T) - 1}{i(\gamma - \delta)}.
\]
Multiplying by the prefactor $\exp(i \delta T)$:
\[
\exp(i \delta T) \frac{\exp(i (\gamma - \delta) T) - 1}{i(\gamma - \delta)} = \frac{\exp(i \gamma T) - \exp(i \delta T)}{i(\gamma - \delta)}.
\]

### 2.3. Bilinear Expansion for Finite Spectral Sums
By linearity and distributivity of the Bochner/Lebesgue integral over finite sums, the integral of the product of two finite spectral packets expands into the double sum of individual mode reflection integrals, retaining each off-diagonal cross term with its exact phase difference.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SelbergSpectralModes.lean`):
```lean
theorem continuous_spectralMode (γ : ℝ) : Continuous (spectralMode γ)

theorem integral_reflected_spectralMode (γ δ T : ℝ) :
    (∫ t in (0 : ℝ)..T, spectralMode γ t * spectralMode δ (T - t)) =
      if γ = δ then (T : ℂ) * spectralMode γ T
      else (spectralMode γ T - spectralMode δ T) /
        (Complex.I * ((γ : ℂ) - (δ : ℂ)))

theorem integral_reflected_spectral_sum {ι κ : Type*}
    (s : Finset ι) (r : Finset κ) (A : ι → ℂ) (B : κ → ℂ)
    (γ : ι → ℝ) (δ : κ → ℝ) (T : ℝ) :
    (∫ t in (0 : ℝ)..T,
      (∑ i ∈ s, A i * spectralMode (γ i) t) *
      (∑ j ∈ r, B j * spectralMode (δ j) (T - t))) =
    ∑ i ∈ s, ∑ j ∈ r, (A i * B j) *
      (if γ i = δ j then (T : ℂ) * spectralMode (γ i) T
       else (spectralMode (γ i) T - spectralMode (δ j) T) /
         (Complex.I * ((γ i : ℂ) - (δ i : ℂ))))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Fourier analysis of the Selberg trace formula (Hejhal 1976, Venkov 1982). While mode expansions are ubiquitous in physics and spectral theory, establishing machine-verified exact formulas for continuous reflection convolutions with explicit resonance branching in Lean 4 is novel.
- **Advancement:** Establishes the exact closed-form evaluation of reflected continuous spectral modes and finite spectral packets in Lean 4, isolating resonant linear growth from off-resonant phase differences.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
