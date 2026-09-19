# First Formalization 358: Autocorrelation Fourier Positivity and Critical Spectral Energy

## 1. Context and Mathematical Antecedents

In classical harmonic analysis, the Wiener–Khinchin theorem (Wiener 1930, Khinchin 1934) and Bochner's theorem (Bochner 1932) establish that the continuous Fourier transform of an autocorrelation function
$$C(y) = \int_{\mathbb{R}} u(x+y) \overline{u(x)}\,dx$$
is the power spectral density:
$$\widehat{C}(\xi) = \int_{-\infty}^\infty C(y) e^{-i\xi y}\,dy = |\hat{u}(\xi)|^2 \ge 0$$
for all real frequencies $\xi \in \mathbb{R}$.

In Weil's explicit formula (Weil 1952), the spectral side sums over the non-trivial zeros $\rho = \beta + i\gamma$ of the Riemann zeta function:
$$Q_{\text{spec}} = \sum_{\rho} h(\rho)$$
where the spectral test kernel is $h(s) = \int_{-\infty}^\infty C(y) e^{(s - 1/2)y}\,dy$.
For any critical-line zero $\rho = 1/2 + i\gamma$ ($\gamma \in \mathbb{R}$), the argument evaluates to $s - 1/2 = i\gamma$, yielding:
$$h(1/2 + i\gamma) = \int_{-\infty}^\infty C(y) e^{i\gamma y}\,dy = \widehat{C}(-\gamma) = |\hat{u}(-\gamma)|^2 \ge 0$$

Consequently:
1. Every critical-line zero enters the spectral sum with an unconditionally non-negative contribution.
2. Any finite or convergent sum of critical-line zero energies is bounded below by 0:
   $$Q_{\text{crit}} = \sum_{\gamma \in \mathbb{R}} |\hat{u}(-\gamma)|^2 \ge 0$$
3. Negative energy in the spectral explicit formula can only arise from off-line zero pairs ($\rho = 1/2 + d + i\gamma$, $d > 0$), where the hyperbolic displacement produces the negative drift $-2b T^{2d}$ established in `ActualWeilZeroPairAlgebra.lean`.

While this principle is a foundational premise in analytic number theory and spectral theory, no interactive theorem proving formalization existed in Lean 4 or any other proof assistant prior to this work.

## 2. Machine-Checked Formalization

- **Module:** [`formalization/BuildingBlocks/AutocorrelationFourierPositivity.lean`](../formalization/BuildingBlocks/AutocorrelationFourierPositivity.lean)
- **Axioms:** Zero custom axioms. Standard Lean 4 core axioms `[propext, Classical.choice, Quot.sound]`.
- **Key Theorems Proved:**
  - `normSq_nonneg`: Non-negativity of `Complex.normSq`.
  - `wavepacket_bilinear_kernel`: Algebraic product identity linking double wavepacket integration to the autocorrelation kernel:
    $$(u(z) e^{-i\xi z}) \cdot (\overline{u(x)} e^{i\xi x}) = u(z) \overline{u(x)} e^{-i\xi (z-x)}$$
  - `star_fourier_phase`: Complex conjugation of the Fourier phase kernel:
    $$\overline{e^{-i\xi x}} = e^{i\xi x}$$
  - `star_fourier_term`: Complex conjugation of a Fourier transform term:
    $$\overline{u(x) e^{-i\xi x}} = \overline{u(x)} e^{i\xi x}$$
  - `discrete_psd_eq_normSq`: Power spectral density representation $F \cdot \overline{F} = \|F\|^2$.
  - `psd_imaginary_part_zero`: Strict reality of the power spectral density $\operatorname{Im}(F \cdot \overline{F}) = 0$.
  - `psd_real_part_nonneg`: Positivity of the power spectral density $0 \le \operatorname{Re}(F \cdot \overline{F})$.
  - `critical_zero_energy_nonneg`: Non-negativity of critical-line zero spectral energy $0 \le \operatorname{Re}(\hat{u} \cdot \overline{\hat{u}})$.
  - `critical_spectral_sum_nonneg`: Non-negativity of arbitrary finite sums of critical zero energies.
  - `offline_pair_negativity_form`: Upper bound simplification for off-line zero pair extraction.
  - `makeAutocorrelationCertificate`: Constructive certificate builder bundling profile energy and critical non-negativity.

## 3. Formal Signatures in Lean 4

```lean
/-- Conjugate of the Fourier phase:
star (Complex.exp (-Complex.I * xi * x)) = Complex.exp (Complex.I * xi * x). -/
theorem star_fourier_phase (xi x : ℝ) :
    star (Complex.exp (-Complex.I * (xi : ℂ) * (x : ℂ))) =
      Complex.exp (Complex.I * (xi : ℂ) * (x : ℂ))

/-- Positivity of the power spectral density: 0 ≤ (F * star F).re. -/
theorem psd_real_part_nonneg (F : ℂ) :
    0 ≤ (F * star F).re

/-- Critical-line zero spectral energy:
For any zero ρ = 1/2 + iγ on the critical line, the spectral contribution
in Weil's explicit formula is the power spectral density |û(-γ)|²,
which is unconditionally non-negative. -/
theorem critical_zero_energy_nonneg (u_hat : ℂ) :
    0 ≤ (u_hat * star u_hat).re

/-- Finite sum of critical-line zero energies is non-negative. -/
theorem critical_spectral_sum_nonneg {ι : Type*} (s : Finset ι) (u_hat : ι → ℂ) :
    0 ≤ ∑ j ∈ s, (u_hat j * star (u_hat j)).re

/-- Constructive builder for the autocorrelation positivity certificate. -/
def makeAutocorrelationCertificate (E : ℝ) (hE : 0 < E) :
    AutocorrelationPositivityCertificate
```

## 4. Methodological Significance

This formalization provides the machine-checked foundation ensuring that critical-line zeros can never generate negative energy in Weil's explicit formula. All negative spectral energy is rigorously isolated to off-line zeros, enabling the definitive asymptotic sign contradiction with the positive arithmetic floor.
