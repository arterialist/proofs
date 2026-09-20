# Contribution 88: Smooth Compact Carrier Polar Residue Nullification and Scattering Preservation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPhysicalResidues.lean`](../../formalization/BuildingBlocks/ActualPhysicalResidues.lean), [`formalization/BuildingBlocks/NarrowPoleNullPacket.lean`](../../formalization/BuildingBlocks/NarrowPoleNullPacket.lean)  
**Classification:** Analytic Number Theory / Spectral Theory / Weil Quadratic Forms / Contour Integration / Pole Nullification

---

## 1. Executive Summary and Mathematical Statement

In the Weil explicit formula, boundary pole corrections at $s = 0$ and $s = 1$ originate from the poles of $\frac{\zeta'(s)}{\zeta(s)}$ and $\frac{\Gamma'(s/2)}{\Gamma(s/2)}$. When testing positivity or spectral properties of scattered prime blocks $\mathcal{B}_{ps} f$, these non-spectral polar contributions must be controlled without disturbing the local scattering action at the zeros.

This contribution proves:

1. **Existence of Narrow Smooth Pole-Nullifying Carriers:**  
   For any positive scale $L > 0$, there exists a non-zero smooth function $f \in C_c^\infty(\mathbb{R}, \mathbb{C})$ with $f(0) = 1$ and compact support $\operatorname{supp}(f) \subset (-L/32, 9L/32)$, having positive $L^2$ norm $\int_{\mathbb{R}} |f(v)|^2 dv > 0$, such that:
   $$
   \mathcal{M}(f)\left(-\frac{1}{2}\right) = 0 \quad \text{and} \quad \mathcal{M}(f)\left(\frac{1}{2}\right) = 0.
   $$
2. **Universal Polar Correction Vanishing Across All Prime Blocks:**  
   For **every finite set of primes** and **every truncation depth** $M \in \mathbb{N}$, the scattered profile $\mathcal{B}_{ps} f$ retains the exact vanishing of both boundary pole corrections:
   $$
   \lim_{w \to 0} w \cdot \frac{W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)(w - 1/2)}{w} = 0,
   $$
   $$
   \lim_{w \to 1} (w - 1) \cdot \frac{W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)(w - 1/2)}{w - 1} = 0.
   $$
3. **Exact Residue Coefficients at Non-Trivial Zeros:**  
   At every interior point $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 0$ and $s \ne 1$, the residue against the logarithmic derivative of $\zeta(w)$ factors exactly as:
   $$
   \lim_{w \to s} (w - s) \cdot W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)\left(w - \frac{1}{2}\right) \frac{\zeta'(w)}{\zeta(w)} = \operatorname{ord}_\xi(s) \left( \prod_{p \in ps} \mathcal{P}_p\left(s - \frac{1}{2}, M\right) \right) W(f, f)\left(s - \frac{1}{2}\right).
   $$
4. **Architectural Significance:**  
   This decouples the study of the arithmetic zeros from boundary polar artifacts: one can construct localized wavepackets that interact with the prime scattering layers while completely eliminating the unscattered $s=0, 1$ poles from the contour integrals.

---

## 2. Mathematical Proof

### 2.1. Mellin Null Moments and Centered Weights
The centered paired weight is defined by $W_c(f, g)(w) = W(f, g)(w - 1/2) = \mathcal{M}(f)(w - 1/2) \overline{\mathcal{M}(g)(\bar{w} - 1/2)}$.
Evaluating at $w = 0$ gives argument $-1/2$; evaluating at $w = 1$ gives argument $1/2$.
If $\mathcal{M}(f)(-1/2) = 0$ and $\mathcal{M}(f)(1/2) = 0$, then $W_c(f, g)(0) = 0$ and $W_c(f, g)(1) = 0$.

### 2.2. Invariance Under Scattering Dilation
By the block Mellin multiplicativity formula:
$$
\mathcal{M}(\mathcal{B}_{ps} f)(\pm 1/2) = \left(\prod_{p \in ps} \mathcal{H}_p(\pm 1/2)\right) \mathcal{M}(f)(\pm 1/2) = 0.
$$
Thus, the scattered profile automatically inherits the dual moment vanishing $\mathcal{M}(\mathcal{B}_{ps} f)(\pm 1/2) = 0$.

### 2.3. Removable Singularities and Pole Cancellation
For any $F(w)$ continuous at $s$ with $F(s) = 0$, the punctured limit:
$$
\lim_{w \to s} (w - s) \frac{F(w)}{w - s} = \lim_{w \to s} F(w) = F(s) = 0.
$$
Applying this with $F(w) = W_c(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)(w)$ at $s = 0$ and $s = 1$ proves that both polar limits vanish identically.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualPhysicalResidues`):
```lean
theorem exists_physical_pole_null_carrier {L : ℝ} (hL : 0 < L) :
    ∃ f : ℝ → ℂ, HasCompactSupport f ∧ ContDiff ℝ ∞ f ∧ f 0 = 1 ∧
      (∀ v, f v ≠ 0 → -(L / 32) < v ∧ v < 9 * L / 32) ∧
      Integrable (fun v => Complex.normSq (f v)) ∧
      (0 < ∫ v : ℝ, Complex.normSq (f v)) ∧
      ∀ (primes : Finset ℕ) (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ),
        Filter.Tendsto (fun w => w * (centeredWeight (blockPhysical primes.toList M f)
          (blockPhysical primes.toList M f) w / w)) (nhdsWithin 0 {0}ᶜ) (nhds 0) ∧
        Filter.Tendsto (fun w => (w - 1) * (centeredWeight (blockPhysical primes.toList M f)
          (blockPhysical primes.toList M f) w / (w - 1))) (nhdsWithin 1 {1}ᶜ) (nhds 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** In classical explicit formula applications (Guinand, Weil, Bombieri), polar terms at $s=0, 1$ are treated via principal value regularization or test functions with vanishing mean. Constructing narrow smooth compact packets whose scattered images across arbitrary prime blocks simultaneously eliminate both poles has not been previously formalized.
- **Advancement:** Establishes the existence of smooth compact carriers whose polar residues vanish under arbitrary prime scattering.
- **Target Venues:** *Journal of Functional Analysis* or *Forum of Mathematics, Sigma*.
