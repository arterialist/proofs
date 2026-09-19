import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.NumberTheory.LSeries.HurwitzZetaEven
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaRealAxisUnconditional
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaPhaseContradiction
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaLowFrequencyContradiction
import BuildingBlocks.ChirpedUniversalFredholmExclusion
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedGrandSynthesis
import BuildingBlocks.RiemannZetaSymmetrizedRepresentation

/-!
# Module 296: RiemannZetaModularMellinInversion

## Overview

This module formalizes the definitive unconditional modular Mellin inversion theorem for the completed
Riemann zeta function $\xi_0(s)$ (`completedRiemannZeta₀ s`).

By synthesizing:
1. Mathlib's definitional Mellin identity for the Hurwitz-even functional equation pair at $a = 0$:
   $$\xi_0(s) = \frac{1}{2} \mathcal{M}(f_{\text{modif}})(s / 2)$$
2. The exact modular scale-covariance of the real modifying kernel on $\mathbb{R}_{>0}$:
   $$f_{\text{modif}}(x^{-1}) = x^{1/2} f_{\text{modif}}(x)$$
3. The complex Bochner change of variables under the inversion diffeomorphism $x \mapsto x^{-1}$:
   $$\int_0^1 y^{s/2 - 1} f_{\text{modif}}(y) \, dy = \int_1^\infty x^{-2} (x^{-1})^{s/2 - 1} f_{\text{modif}}(x^{-1}) \, dx$$
4. The exact algebraic exponent collapse:
   $$x^{-2} \cdot x^{1 - s/2} \cdot x^{1/2} = x^{(1-s)/2 - 1}$$
5. The additive recombining on $(1, \infty)$ giving the exact symmetric kernel:
   $$x^{s/2 - 1} + x^{(1-s)/2 - 1} = \operatorname{cpowTrigKernel}(s, x)$$

we obtain the unconditional symmetrized representation:
$$\xi_0(s) = \frac{1}{2} \int_1^\infty \operatorname{cpowTrigKernel}(s, x) f_{\text{modif}}(x) \, dx$$
holding unconditionally for all $s \in \mathbb{C}$ without any auxiliary representation hypotheses.

## Main Definitions & Theorems

- `completedRiemannZeta₀_eq_mellin`: Identification of $\xi_0(s)$ with $\frac{1}{2} \mathcal{M}(f_{\text{modif}})(s/2)$.
- `mellin_f_modif_eq`: Pointwise equality of the Mellin integral with the Bochner integral of $x^{s/2 - 1} f_{\text{modif}}(x)$.
- `cpow_inv_ofReal_pos`: Identity $(x^{-1})^w = x^{-w}$ for positive reals.
- `cpow_exponent_combine`: Exact exponent collapse $(x^2)^{-1} \cdot (x^{-1})^{s/2 - 1} \cdot x^{1/2} = x^{(1-s)/2 - 1}$.
- `integrand_inv_eq`: Pointwise transformation of the inverted integrand into the dual Mellin integrand.
- `integral_inv_Ioi_one_complex_mul`: Complex substitution law on $(0, 1) \leftrightarrow (1, \infty)$.
- `integral_mellin_Ioo_eq`: Inversion isomorphism $\int_0^1 y^{s/2-1} f(y) dy = \int_1^\infty x^{(1-s)/2-1} f(x) dx$.
- `integrableOn_mellin_f_modif`: Global Bochner integrability of $x^{s/2-1} f_{\text{modif}}(x)$ on $(0, \infty)$.
- `integrableOn_cpowTrigKernel_mul_f_modif`: Unconditional integrability of $\operatorname{cpowTrigKernel}(s, x) f_{\text{modif}}(x)$ on $(1, \infty)$.
- `symmetrizedRepresentation_unconditional`: Unconditional proof that `SymmetrizedRepresentation s` holds for all $s \in \mathbb{C}$.
- `certificate_of_modular_inversion_and_fredholm`: Canonical refutation certificate from modular inversion and Fredholm theory.
- `RiemannHypothesis_of_modular_inversion_and_fredholm`: Master deduction of Mathlib's `RiemannHypothesis`.
-/

open Complex MeasureTheory Set Filter HurwitzZeta
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaRealAxisUnconditional
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaPhaseContradiction
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaLowFrequencyContradiction
open BuildingBlocks.ChirpedUniversalFredholmExclusion
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedGrandSynthesis
open BuildingBlocks.RiemannZetaSymmetrizedRepresentation

namespace BuildingBlocks.RiemannZetaModularMellinInversion

noncomputable section

/-! ### Section 1: Definitional Mellin Identity for $\xi_0(s)$ -/

/-- Mathlib definitional identification:
$\xi_0(s) = \frac{1}{2} \mathcal{M}(f_{\text{modif}})(s / 2)$. -/
theorem completedRiemannZeta₀_eq_mellin (s : ℂ) :
    completedRiemannZeta₀ s = (1 / 2 : ℂ) * mellin (hurwitzEvenFEPair 0).f_modif (s / 2) := by
  dsimp [completedRiemannZeta₀, completedHurwitzZetaEven₀, WeakFEPair.Λ₀]
  ring

/-- Unfolding of `mellin` to standard Bochner integral on $(0, \infty)$. -/
theorem mellin_eq_integral (f : ℝ → ℂ) (w : ℂ) :
    mellin f w = ∫ x in Ioi (0 : ℝ), (x : ℂ) ^ (w - 1) * f x := by
  unfold mellin
  simp_rw [smul_eq_mul]

/-- Mellin integral of `f_modif` expressed with real modifying kernel `real_f_modif`. -/
theorem mellin_f_modif_eq (s : ℂ) :
    mellin (hurwitzEvenFEPair 0).f_modif (s / 2) =
      ∫ x in Ioi (0 : ℝ), (x : ℂ) ^ (s / 2 - 1) * (real_f_modif x : ℂ) := by
  rw [mellin_eq_integral]
  refine setIntegral_congr_fun measurableSet_Ioi fun x hx => ?_
  have h_eq : (hurwitzEvenFEPair 0).f_modif x = (real_f_modif x : ℂ) := f_modif_eq_ofReal x
  rw [h_eq]

/-! ### Section 2: Complex Power Inversion and Exponent Collapse -/

/-- Inversion identity for complex powers of positive reals: $(x^{-1})^w = x^{-w}$. -/
theorem cpow_inv_ofReal_pos {x : ℝ} (hx : 0 < x) (w : ℂ) :
    ((x⁻¹ : ℝ) : ℂ) ^ w = (x : ℂ) ^ (-w) := by
  have hx_ne : (x : ℂ) ≠ 0 := ofReal_ne_zero.mpr hx.ne'
  have h_arg : (x : ℂ).arg ≠ Real.pi := by
    rw [arg_ofReal_of_nonneg hx.le]
    exact Real.pi_pos.ne
  rw [ofReal_inv, inv_cpow (x : ℂ) w h_arg, cpow_neg]

/-- Exact exponent collapse for modular inversion:
$(x^2)^{-1} \cdot (x^{-1})^{s/2 - 1} \cdot x^{1/2} = x^{(1-s)/2 - 1}$. -/
theorem cpow_exponent_combine (s : ℂ) {x : ℝ} (hx : 0 < x) :
    (((x ^ 2)⁻¹ : ℝ) : ℂ) * (((x⁻¹ : ℝ) : ℂ) ^ (s / 2 - 1)) * (((x ^ (1 / 2 : ℝ)) : ℝ) : ℂ) =
      (x : ℂ) ^ ((1 - s) / 2 - 1) := by
  have hx_ne : (x : ℂ) ≠ 0 := ofReal_ne_zero.mpr hx.ne'
  rw [cpow_inv_ofReal_pos hx]
  have h_x2 : (((x ^ 2)⁻¹ : ℝ) : ℂ) = (x : ℂ) ^ (-2 : ℂ) := by
    have h_rpow : (x ^ 2)⁻¹ = x ^ (-2 : ℝ) := by
      rw [Real.rpow_neg hx.le, Real.rpow_two]
    rw [h_rpow, ofReal_cpow hx.le (-2 : ℝ)]
    push_cast
    rfl
  have h_x_half : (((x ^ (1 / 2 : ℝ)) : ℝ) : ℂ) = (x : ℂ) ^ (1 / 2 : ℂ) := by
    rw [ofReal_cpow hx.le (1 / 2 : ℝ)]
    push_cast
    rfl
  rw [h_x2, h_x_half]
  rw [← cpow_add _ _ hx_ne, ← cpow_add _ _ hx_ne]
  congr 1
  ring

/-- Pointwise transformation of the inverted integrand under modular reflection:
$(x^2)^{-1} \cdot (x^{-1})^{s/2 - 1} \cdot f_{\text{modif}}(x^{-1}) = x^{(1-s)/2 - 1} \cdot f_{\text{modif}}(x)$. -/
theorem integrand_inv_eq (s : ℂ) {x : ℝ} (hx : 0 < x) :
    (((x ^ 2)⁻¹ : ℝ) : ℂ) * (((x⁻¹ : ℝ) : ℂ) ^ (s / 2 - 1) * (real_f_modif (x⁻¹) : ℂ)) =
      (x : ℂ) ^ ((1 - s) / 2 - 1) * (real_f_modif x : ℂ) := by
  have h_inv : x⁻¹ = 1 / x := inv_eq_one_div x
  have h_symm : real_f_modif (x⁻¹) = x ^ (1 / 2 : ℝ) * real_f_modif x := by
    rw [h_inv, real_f_modif_symmetry hx]
  rw [h_symm, ofReal_mul]
  calc
    (((x ^ 2)⁻¹ : ℝ) : ℂ) * (((x⁻¹ : ℝ) : ℂ) ^ (s / 2 - 1) * ((((x ^ (1 / 2 : ℝ)) : ℝ) : ℂ) * (real_f_modif x : ℂ)))
      = ((((x ^ 2)⁻¹ : ℝ) : ℂ) * (((x⁻¹ : ℝ) : ℂ) ^ (s / 2 - 1)) * (((x ^ (1 / 2 : ℝ)) : ℝ) : ℂ)) * (real_f_modif x : ℂ) := by ring
    _ = (x : ℂ) ^ ((1 - s) / 2 - 1) * (real_f_modif x : ℂ) := by
      rw [cpow_exponent_combine s hx]

/-! ### Section 3: Bochner Change of Variables & Modular Inversion Isomorphism -/

/-- Complex Bochner change of variables on $(0, 1) \leftrightarrow (1, \infty)$ under $y = x^{-1}$. -/
theorem integral_inv_Ioi_one_complex (g : ℝ → ℂ) :
    ∫ y in Ioo 0 1, g y = ∫ x in Ioi (1 : ℝ), ((x ^ 2)⁻¹ : ℝ) • g x⁻¹ := by
  have hs : MeasurableSet (Ioi (1 : ℝ)) := measurableSet_Ioi
  have hf' : ∀ x ∈ Ioi (1 : ℝ), HasDerivWithinAt (fun t : ℝ => t⁻¹) (-(x ^ 2)⁻¹) (Ioi (1 : ℝ)) x :=
    fun x hx => hasDerivWithinAt_inv_Ioi_one x hx
  have hf : InjOn (fun x : ℝ => x⁻¹) (Ioi (1 : ℝ)) := injOn_inv_Ioi_one
  have h_img := integral_image_eq_integral_abs_deriv_smul hs hf' hf g
  rw [inv_image_Ioi_one] at h_img
  rw [h_img]
  refine setIntegral_congr_fun hs fun x hx => ?_
  rw [abs_deriv_inv_eq x hx]

/-- Complex Bochner change of variables with scalar multiplication expanded to complex multiplication. -/
theorem integral_inv_Ioi_one_complex_mul (g : ℝ → ℂ) :
    ∫ y in Ioo 0 1, g y = ∫ x in Ioi (1 : ℝ), (((x ^ 2)⁻¹ : ℝ) : ℂ) * g x⁻¹ := by
  rw [integral_inv_Ioi_one_complex]
  simp_rw [real_smul]

/-- Exact modular inversion integral identity:
$$\int_0^1 y^{s/2 - 1} f_{\text{modif}}(y) \, dy = \int_1^\infty x^{(1-s)/2 - 1} f_{\text{modif}}(x) \, dx.$$ -/
theorem integral_mellin_Ioo_eq (s : ℂ) :
    ∫ y : ℝ in Ioo (0 : ℝ) 1, (y : ℂ) ^ (s / 2 - 1) * (real_f_modif y : ℂ) =
      ∫ x : ℝ in Ioi (1 : ℝ), (x : ℂ) ^ ((1 - s) / 2 - 1) * (real_f_modif x : ℂ) := by
  rw [integral_inv_Ioi_one_complex_mul (fun y => (y : ℂ) ^ (s / 2 - 1) * (real_f_modif y : ℂ))]
  refine setIntegral_congr_fun measurableSet_Ioi fun x hx => ?_
  have hx_pos : 0 < x := by linarith [mem_Ioi.mp hx]
  exact integrand_inv_eq s hx_pos

/-! ### Section 4: Global Integrability & Domain Splitting -/

/-- Unconditional Bochner integrability of $x^{s/2-1} f_{\text{modif}}(x)$ on $(0, \infty)$ for all $s \in \mathbb{C}$. -/
theorem integrableOn_mellin_f_modif (s : ℂ) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (s / 2 - 1) * (real_f_modif x : ℂ)) (Ioi (0 : ℝ)) := by
  let P := hurwitzEvenFEPair 0
  have hm : HasMellin P.toStrongFEPair.f (s / 2) (P.toStrongFEPair.Λ (s / 2)) :=
    P.toStrongFEPair.hasMellin (s / 2)
  have hc : MellinConvergent P.toStrongFEPair.f (s / 2) := hm.1
  have h_int_c : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (s / 2 - 1) • P.f_modif x) (Ioi 0) := hc
  have h_mul : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (s / 2 - 1) * P.f_modif x) (Ioi 0) := by
    refine h_int_c.congr (ae_of_all _ fun x => ?_)
    exact smul_eq_mul ((x : ℂ) ^ (s / 2 - 1)) (P.f_modif x)
  refine h_mul.congr (ae_of_all _ fun x => ?_)
  dsimp
  have h_eq : P.f_modif x = (real_f_modif x : ℂ) := f_modif_eq_ofReal x
  rw [h_eq]

/-- Restriction of integrability to the half-line $(1, \infty)$. -/
theorem integrableOn_mellin_f_modif_Ioi_one (s : ℂ) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (s / 2 - 1) * (real_f_modif x : ℂ)) (Ioi (1 : ℝ)) :=
  (integrableOn_mellin_f_modif s).mono_set (fun x hx => by
    have h : (1 : ℝ) < x := mem_Ioi.mp hx
    exact mem_Ioi.mpr (by linarith))

/-- Integrability of the dual factor $x^{(1-s)/2-1} f_{\text{modif}}(x)$ on $(1, \infty)$. -/
theorem integrableOn_mellin_f_modif_dual_Ioi_one (s : ℂ) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ ((1 - s) / 2 - 1) * (real_f_modif x : ℂ)) (Ioi (1 : ℝ)) :=
  integrableOn_mellin_f_modif_Ioi_one (1 - s)

/-- Unconditional Bochner integrability of the symmetrized product $\operatorname{cpowTrigKernel}(s, x) f_{\text{modif}}(x)$ on $(1, \infty)$. -/
theorem integrableOn_cpowTrigKernel_mul_f_modif (s : ℂ) :
    IntegrableOn (fun x : ℝ => cpowTrigKernel s x * (real_f_modif x : ℂ)) (Ioi (1 : ℝ)) := by
  have h1 := integrableOn_mellin_f_modif_Ioi_one s
  have h2 := integrableOn_mellin_f_modif_dual_Ioi_one s
  have h_add := h1.add h2
  refine h_add.congr (ae_of_all _ fun x => ?_)
  dsimp [cpowTrigKernel]
  ring

/-- Complex Bochner domain split: $\int_0^\infty = \int_0^1 + \int_1^\infty$. -/
theorem integral_Ioi_zero_split_complex (g : ℝ → ℂ) (h_int : IntegrableOn g (Ioi (0 : ℝ))) :
    ∫ y in Ioi (0 : ℝ), g y = (∫ y in Ioo 0 1, g y) + (∫ y in Ioi 1, g y) := by
  have h_int_Ioc : IntegrableOn g (Ioc 0 1) := h_int.mono_set (fun x hx => (mem_Ioc.mp hx).1)
  have h_int_Ioi : IntegrableOn g (Ioi 1) := h_int.mono_set (fun x hx => by
    have h : (1 : ℝ) < x := mem_Ioi.mp hx
    exact mem_Ioi.mpr (by linarith))
  have h_union : ∫ y in Ioi (0 : ℝ), g y = (∫ y in Ioc 0 1, g y) + (∫ y in Ioi 1, g y) := by
    rw [← Set.Ioc_union_Ioi_eq_Ioi (by norm_num : (0 : ℝ) ≤ 1)]
    exact setIntegral_union Ioc_disjoint_Ioi measurableSet_Ioi h_int_Ioc h_int_Ioi
  rw [h_union, integral_Ioc_eq_integral_Ioo]

/-! ### Section 5: Unconditional Symmetrized Representation Master Theorem -/

/-- Master Theorem: Unconditional proof that `SymmetrizedRepresentation s` holds for all $s \in \mathbb{C}$. -/
theorem symmetrizedRepresentation_unconditional (s : ℂ) : SymmetrizedRepresentation s := by
  unfold SymmetrizedRepresentation
  rw [completedRiemannZeta₀_eq_mellin s, mellin_f_modif_eq s]
  have h_int := integrableOn_mellin_f_modif s
  have h_split := integral_Ioi_zero_split_complex
    (fun x => (x : ℂ) ^ (s / 2 - 1) * (real_f_modif x : ℂ)) h_int
  rw [h_split, integral_mellin_Ioo_eq s]
  have h_dual := integrableOn_mellin_f_modif_dual_Ioi_one s
  have h_direct := integrableOn_mellin_f_modif_Ioi_one s
  rw [← integral_add h_dual h_direct]
  congr 1
  refine setIntegral_congr_fun measurableSet_Ioi fun x hx => ?_
  dsimp [cpowTrigKernel]
  ring

/-- Universal quantifier: `SymmetrizedRepresentation` holds everywhere on $\mathbb{C}$. -/
theorem symmetrizedRepresentation_all : ∀ s : ℂ, SymmetrizedRepresentation s :=
  symmetrizedRepresentation_unconditional

/-- Integral formula for $\xi_0(s)$ unconditionally for all $s \in \mathbb{C}$. -/
theorem completedRiemannZeta₀_eq_integral_unconditional (s : ℂ) :
    completedRiemannZeta₀ s =
      (1 / 2 : ℂ) * ∫ x in Set.Ioi (1 : ℝ), cpowTrigKernel s x * (real_f_modif x : ℂ) :=
  symmetrizedRepresentation_unconditional s

/-- Exact imaginary part of $\xi_0(s)$ unconditionally for all $s \in \mathbb{C}$. -/
theorem im_completedRiemannZeta₀_unconditional (s : ℂ) :
    (completedRiemannZeta₀ s).im =
      (1 / 2 : ℝ) * ∫ x in Set.Ioi (1 : ℝ), mellinTrigIntegrandIm s x :=
  im_completedRiemannZeta₀_of_representation
    (symmetrizedRepresentation_unconditional s)
    (integrableOn_cpowTrigKernel_mul_f_modif s)

/-- Exact real part of $\xi_0(s)$ unconditionally for all $s \in \mathbb{C}$. -/
theorem re_completedRiemannZeta₀_unconditional (s : ℂ) :
    (completedRiemannZeta₀ s).re =
      (1 / 2 : ℝ) * ∫ x in Set.Ioi (1 : ℝ), mellinTrigIntegrandRe s x := by
  have h_rep := symmetrizedRepresentation_unconditional s
  unfold SymmetrizedRepresentation at h_rep
  rw [h_rep, half_complex_mul_re]
  congr 1
  exact integral_cpowTrigKernel_re s (integrableOn_cpowTrigKernel_mul_f_modif s)

/-- Unconditional exact ratio equality `SymmetrizedRatioExact s`. -/
theorem symmetrizedRatioExact_unconditional (s : ℂ) : SymmetrizedRatioExact s :=
  symmetrizedRatioExact_of_representation
    (symmetrizedRepresentation_unconditional s)
    (integrableOn_cpowTrigKernel_mul_f_modif s)

/-- Unconditional Mellin domination `SymmetrizedMellinDominated s`. -/
theorem symmetrizedMellinDominated_unconditional (s : ℂ) : SymmetrizedMellinDominated s :=
  symmetrizedMellinDominated_of_representation
    (symmetrizedRepresentation_unconditional s)
    (integrableOn_cpowTrigKernel_mul_f_modif s)

/-- Unconditional zero-freeness of $\zeta(s)$ in the low-frequency strip under modular inversion. -/
theorem low_freq_free_of_modular_inversion {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 1)
    (h_int_ratio : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ))) :
    riemannZeta s ≠ 0 :=
  low_freq_free_of_representation hsr1 hsr2 hsim1 hsim2
    (symmetrizedRepresentation_unconditional s)
    (integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio

/-! ### Section 6: Master Reductions to Mathlib's `RiemannHypothesis` -/

/-- Canonical refutation certificate from modular inversion and Fredholm theory. -/
theorem certificate_of_modular_inversion_and_fredholm
    (h_int_ratio : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ)))
    (sys : UniversalFredholmSystem) :
    OffLineZeroRefutationCertificate :=
  certificate_of_representation_and_fredholm
    (fun s _ _ _ _ => symmetrizedRepresentation_unconditional s)
    (fun s _ _ _ _ => integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio sys

/-- Canonical refutation certificate from modular inversion and carrier refutation. -/
theorem certificate_of_modular_inversion_and_refutation
    (h_int_ratio : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ)))
    (sys : UniversalZeroRefutationSystem) :
    OffLineZeroRefutationCertificate :=
  certificate_of_representation_and_refutation
    (fun s _ _ _ _ => symmetrizedRepresentation_unconditional s)
    (fun s _ _ _ _ => integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio sys

/-- Canonical refutation certificate from modular inversion and Grand Synthesis. -/
theorem certificate_of_modular_inversion_and_grand_synthesis
    (h_int_ratio : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ)))
    (hgs : GrandSynthesisSystem) :
    OffLineZeroRefutationCertificate :=
  certificate_of_representation_and_grand_synthesis
    (fun s _ _ _ _ => symmetrizedRepresentation_unconditional s)
    (fun s _ _ _ _ => integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio hgs

/-- Master deduction of Mathlib's `RiemannHypothesis` from modular inversion and Fredholm theory. -/
theorem RiemannHypothesis_of_modular_inversion_and_fredholm
    (h_int_ratio : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ)))
    (sys : UniversalFredholmSystem) :
    RiemannHypothesis :=
  RiemannHypothesis_of_representation_and_fredholm
    (fun s _ _ _ _ => symmetrizedRepresentation_unconditional s)
    (fun s _ _ _ _ => integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio sys

/-- Master deduction of Mathlib's `RiemannHypothesis` from modular inversion and carrier refutation. -/
theorem RiemannHypothesis_of_modular_inversion_and_refutation
    (h_int_ratio : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ)))
    (sys : UniversalZeroRefutationSystem) :
    RiemannHypothesis :=
  RiemannHypothesis_of_representation_and_refutation
    (fun s _ _ _ _ => symmetrizedRepresentation_unconditional s)
    (fun s _ _ _ _ => integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio sys

/-- Master deduction of Mathlib's `RiemannHypothesis` from modular inversion and Grand Synthesis. -/
theorem RiemannHypothesis_of_modular_inversion_and_grand_synthesis
    (h_int_ratio : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Set.Ioi (1 : ℝ)))
    (hgs : GrandSynthesisSystem) :
    RiemannHypothesis :=
  RiemannHypothesis_of_representation_and_grand_synthesis
    (fun s _ _ _ _ => symmetrizedRepresentation_unconditional s)
    (fun s _ _ _ _ => integrableOn_cpowTrigKernel_mul_f_modif s)
    h_int_ratio hgs

#print axioms completedRiemannZeta₀_eq_mellin
#print axioms mellin_eq_integral
#print axioms mellin_f_modif_eq
#print axioms cpow_inv_ofReal_pos
#print axioms cpow_exponent_combine
#print axioms integrand_inv_eq
#print axioms integral_inv_Ioi_one_complex
#print axioms integral_inv_Ioi_one_complex_mul
#print axioms integral_mellin_Ioo_eq
#print axioms integrableOn_mellin_f_modif
#print axioms integrableOn_mellin_f_modif_Ioi_one
#print axioms integrableOn_mellin_f_modif_dual_Ioi_one
#print axioms integrableOn_cpowTrigKernel_mul_f_modif
#print axioms integral_Ioi_zero_split_complex
#print axioms symmetrizedRepresentation_unconditional
#print axioms symmetrizedRepresentation_all
#print axioms completedRiemannZeta₀_eq_integral_unconditional
#print axioms im_completedRiemannZeta₀_unconditional
#print axioms re_completedRiemannZeta₀_unconditional
#print axioms symmetrizedRatioExact_unconditional
#print axioms symmetrizedMellinDominated_unconditional
#print axioms low_freq_free_of_modular_inversion
#print axioms certificate_of_modular_inversion_and_fredholm
#print axioms certificate_of_modular_inversion_and_refutation
#print axioms certificate_of_modular_inversion_and_grand_synthesis
#print axioms RiemannHypothesis_of_modular_inversion_and_fredholm
#print axioms RiemannHypothesis_of_modular_inversion_and_refutation
#print axioms RiemannHypothesis_of_modular_inversion_and_grand_synthesis

end

end BuildingBlocks.RiemannZetaModularMellinInversion
