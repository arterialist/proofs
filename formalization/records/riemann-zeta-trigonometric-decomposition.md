# First Formalization 375: Riemann Zeta Trigonometric Decomposition and Mellin Kernel Positivity

## 1. Classification and Attribution
- **Type**: First Formalization (The trigonometric cosine/sine decomposition of the symmetrized complex power kernel $x^{s/2 - 1} + x^{(1-s)/2 - 1}$, the identification of its imaginary part with $\operatorname{powerDiff}(\beta, x) \sin((\gamma/2)\log x)$, the vanishing of the imaginary kernel along the critical line $\beta = 1/2$, and the strict positivity of the imaginary Mellin integrand on the fundamental half-period $(1, \exp(2\pi/\gamma))$ are classical analytic constructions in Riemann-Siegel and Edwards theory, but have never before been formalized in Lean 4 or any interactive theorem prover).
- **Module**: `BuildingBlocks.RiemannZetaTrigonometricDecomposition` (Module 288)
- **Dependencies**: Standard foundational axioms: `[propext, Classical.choice, Quot.sound]`.
- **Zero Sorries**: 0 sorries, completely machine-checked.

---

## 2. Mathematical Content and Key Results

This development provides the machine-checked trigonometric foundation of the symmetrized completed zeta function integrand:
$$\Lambda_0(s) = \int_1^\infty (x^{s/2 - 1} + x^{(1-s)/2 - 1}) f_{\text{modif}}(x) \, dx$$

### Key Formulations:

1. **Trigonometric Exponent Real and Imaginary Parts**:
   ```lean
   lemma cpow_ofReal_re_eq_rpow {x : ℝ} (hx : 0 < x) (z : ℂ) :
       ((x : ℂ) ^ z).re = x ^ z.re * Real.cos (z.im * Real.log x)

   lemma cpow_ofReal_im_eq_rpow {x : ℝ} (hx : 0 < x) (z : ℂ) :
       ((x : ℂ) ^ z).im = x ^ z.re * Real.sin (z.im * Real.log x)
   ```

2. **Symmetrized Trigonometric Kernel Evaluation**:
   ```lean
   noncomputable def cpowTrigKernel (s : ℂ) (x : ℝ) : ℂ :=
     (x : ℂ) ^ (s / 2 - 1) + (x : ℂ) ^ ((1 - s) / 2 - 1)

   theorem cpowTrigKernel_re {s : ℂ} {x : ℝ} (hx : 0 < x) :
       (cpowTrigKernel s x).re =
         (x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1)) * Real.cos ((s.im / 2) * Real.log x)

   theorem cpowTrigKernel_im {s : ℂ} {x : ℝ} (hx : 0 < x) :
       (cpowTrigKernel s x).im =
         (x ^ (s.re / 2 - 1) - x ^ ((1 - s.re) / 2 - 1)) * Real.sin ((s.im / 2) * Real.log x)
   ```

3. **Critical Line Vanishing of the Imaginary Kernel**:
   ```lean
   theorem cpowTrigKernel_im_critical_line {s : ℂ} (hs : s.re = 1 / 2) {x : ℝ} (hx : 0 < x) :
       (cpowTrigKernel s x).im = 0

   theorem mellinTrigIntegrandIm_critical_line {s : ℂ} (hs : s.re = 1 / 2) {x : ℝ} (hx : 0 < x) :
       mellinTrigIntegrandIm s x = 0
   ```
   When $\beta = 1/2$, the hyperbolic exponents match: $(1/2)/2 - 1 = (1 - 1/2)/2 - 1 = -3/4$, causing the difference $x^{-3/4} - x^{-3/4}$ to vanish identically for all $x > 0$.

4. **Factorization via Hyperbolic Power Difference**:
   ```lean
   theorem cpowTrigKernel_im_eq_powerDiff_mul_sin {s : ℂ} {x : ℝ} (hx : 0 < x) :
       (cpowTrigKernel s x).im = powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x)

   theorem powerDiff_nonneg {β x : ℝ} (hβ : (1 : ℝ) / 2 ≤ β) (hx : 1 ≤ x) :
       0 ≤ powerDiff β x
   ```

5. **First Half-Period Strict Positivity**:
   ```lean
   noncomputable def halfPeriodHorizon (γ : ℝ) : ℝ :=
     Real.exp (2 * Real.pi / γ)

   theorem halfPeriodHorizon_gt_one {γ : ℝ} (hγ : 0 < γ) :
       1 < halfPeriodHorizon γ

   theorem mellinTrigIntegrandIm_pos_of_mem_first_half_period {s : ℂ} {x : ℝ}
       (hsr : 1 / 2 < s.re) (hsim : 0 < s.im)
       (hx1 : 1 < x) (hx2 : x < halfPeriodHorizon s.im) :
       0 < mellinTrigIntegrandIm s x
   ```
   For any off-line zero candidate with $\beta > 1/2$ and $\gamma > 0$, the imaginary Mellin integrand is strictly positive on the entire primary interval $(1, \exp(2\pi/\gamma))$.

6. **Infinitesimal Ratio Bounds and Uniform Exponential Majorization**:
   ```lean
   theorem sin_div_gamma_le {γ x : ℝ} (hγ : 0 < γ) (hx : 1 ≤ x) :
       Real.sin ((γ / 2) * Real.log x) / γ ≤ (1 / 2) * Real.log x

   theorem mellinTrigIntegrandIm_div_im_le {s : ℂ} {x : ℝ}
       (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) (hx : 1 ≤ x) :
       mellinTrigIntegrandIm s x / s.im ≤ (1 / 2) * Real.log x * real_f_modif x

   theorem mellinTrigIntegrandIm_div_im_le_two_exp {s : ℂ} {x : ℝ}
       (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) (hx : 1 ≤ x) :
       mellinTrigIntegrandIm s x / s.im ≤ 2 * Real.log x * Real.exp (-π * x)
   ```
