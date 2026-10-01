import Zeta23.WeilEF.Main
import Zeta23.ExplicitFormula.Bridge
import Zeta23.GammaFacts.Complete

/-!
Actual-zeta explicit-formula convention adapter. The external source is
Anthropic's Apache-2.0 zeta23 project at commit fbdc36bbf17d20af3fd0447c6d1a8a02773c9844.
SPDX-License-Identifier: Apache-2.0. See LICENSE and NOTICE for attribution.
This file adds a transform adapter; it asserts no positivity or RH.
The external package's copyright and upstream NOTICE remain in that checkout.

Changing exp(+i z u) to exp(-i z u) changes the zero frequency from gammaOf rho
to -gammaOf rho. The zero rho itself and its actual analytic multiplicity stay
unchanged. Every prime power, both poles and the full digamma term are retained.
-/

open MeasureTheory Complex Set
open scoped ComplexConjugate

noncomputable section

namespace ActualWeil

def minusTransform (f : ℝ → ℂ) (z : ℂ) : ℂ :=
  ∫ u : ℝ, f u * Complex.exp (-Complex.I * z * (u : ℂ))

theorem minusTransform_eq_source (f : ℝ → ℂ) (z : ℂ) :
    minusTransform f z = Zeta23.paperFT f (-z) := by
  unfold minusTransform Zeta23.paperFT
  congr 1
  funext u
  congr 1
  congr 1
  ring

def zeroFrequency (ρ : ℂ) : ℂ := -Zeta23.gammaOf ρ

theorem zeroFrequency_mellin (ρ : ℂ) :
    -Complex.I * zeroFrequency ρ = ρ - 1 / 2 := by
  unfold zeroFrequency Zeta23.gammaOf
  field_simp

/-- The canonical source carrier consists of the actual Mathlib zeta zeros. -/
theorem actual_carrier : Zeta23.zetaZeroConfig.carrier =
    {ρ : ℂ | riemannZeta ρ = 0 ∧ 0 < ρ.re ∧ ρ.re < 1} := by
  rw [Zeta23.zetaZeroConfig_carrier]
  rfl

theorem actual_multiplicity (ρ : ℂ) : Zeta23.zetaZeroConfig.mult ρ =
    (analyticOrderAt riemannZeta ρ).toNat := rfl

def spectralSummand (k : ℝ → ℂ) (ρ : Zeta23.zetaZeroConfig.carrier) : ℂ :=
  (Zeta23.zetaZeroConfig.mult ρ : ℂ) * minusTransform k (zeroFrequency ρ)

def spectralSum (k : ℝ → ℂ) : ℂ := ∑' ρ, spectralSummand k ρ

def gammaWeight (r : ℝ) : ℝ :=
  (Complex.digamma (1 / 4 + Complex.I * r / 2)).re - Real.log Real.pi

theorem gammaWeight_eq_sourceMu (r : ℝ) : gammaWeight r = 2 * Real.pi * Zeta23.mu r := by
  unfold gammaWeight Zeta23.mu
  field_simp

theorem gammaWeight_even (r : ℝ) : gammaWeight (-r) = gammaWeight r := by
  rw [gammaWeight_eq_sourceMu, gammaWeight_eq_sourceMu, Zeta23.mu_even]

/-- Absolute convergence of the complete gamma integral, using the proved
upstream gamma facts rather than a supplied analytic premise. -/
theorem integrable_gamma_source (k : ℝ → ℂ) (hk : ContDiff ℝ 2 k)
    (hkc : HasCompactSupport k) :
    Integrable (fun r : ℝ => Zeta23.paperFT k r * (gammaWeight r : ℂ)) := by
  have h := Zeta23.EF.integrable_paperFT_mul_mu hk hkc Zeta23.gammaFacts
  convert h.const_mul ((2 * Real.pi : ℝ) : ℂ) using 1
  funext r
  rw [gammaWeight_eq_sourceMu]
  push_cast
  ring

theorem integrable_gamma_minus (k : ℝ → ℂ) (hk : ContDiff ℝ 2 k)
    (hkc : HasCompactSupport k) :
    Integrable (fun r : ℝ => minusTransform k r * (gammaWeight r : ℂ)) := by
  convert (integrable_gamma_source k hk hkc).comp_neg using 1
  funext r
  simp only [minusTransform_eq_source, gammaWeight_even, Complex.ofReal_neg]

/-- The complete prime row is finite for a compactly supported test. -/
theorem summable_prime_row (k : ℝ → ℂ) (hkc : HasCompactSupport k) :
    Summable (fun n : ℕ => ((ArithmeticFunction.vonMangoldt n / Real.sqrt n : ℝ) : ℂ) *
      (k (Real.log n) + k (-Real.log n))) := by
  obtain ⟨B, hB⟩ := Zeta23.EF.exists_abs_le_of_hasCompactSupport hkc
  apply summable_of_hasFiniteSupport
  refine (Set.finite_Iic ⌈Real.exp B⌉₊).subset ?_
  intro n hn
  rw [Function.mem_support] at hn
  have hn0 : n ≠ 0 := by rintro rfl; simp at hn
  have hlog : |Real.log n| ≤ B := by
    by_cases hkp : k (Real.log n) = 0
    · have hkn : k (-Real.log n) ≠ 0 := by
        intro hkn
        simp [hkp, hkn] at hn
      simpa only [abs_neg] using hB (-Real.log n) hkn
    · exact hB (Real.log n) hkp
  have hnpos : (0 : ℝ) < n := by exact_mod_cast Nat.pos_of_ne_zero hn0
  have hbound : (n : ℝ) ≤ Real.exp B := by
    calc
      (n : ℝ) = Real.exp (Real.log n) := (Real.exp_log hnpos).symm
      _ ≤ Real.exp B := Real.exp_le_exp.mpr ((le_abs_self _).trans hlog)
  exact_mod_cast hbound.trans (Nat.le_ceil _)

def arithmeticSide (k : ℝ → ℂ) : ℂ :=
  minusTransform k (Complex.I / 2) + minusTransform k (-Complex.I / 2) -
    ∑' n : ℕ, ((ArithmeticFunction.vonMangoldt n / Real.sqrt n : ℝ) : ℂ) *
      (k (Real.log n) + k (-Real.log n)) +
    (1 / (2 * Real.pi) : ℂ) * ∫ r : ℝ, minusTransform k r * (gammaWeight r : ℂ)

theorem arithmeticSide_eq_source (k : ℝ → ℂ) :
    arithmeticSide k = Zeta23.EF.literatureRHS k := by
  have hg : (∫ r : ℝ, minusTransform k r * (gammaWeight r : ℂ)) =
      ∫ r : ℝ, Zeta23.paperFT k r * (Zeta23.EF.gammaBracket r : ℂ) := by
    calc
      _ = ∫ r : ℝ, minusTransform k ((-r : ℝ) : ℂ) * (gammaWeight (-r) : ℂ) :=
        (integral_neg_eq_self (fun r : ℝ => minusTransform k r * (gammaWeight r : ℂ))
          volume).symm
      _ = _ := by
        apply integral_congr_ae
        filter_upwards [] with r
        rw [minusTransform_eq_source, gammaWeight_even]
        simp only [Complex.ofReal_neg, neg_neg]
        rfl
  unfold arithmeticSide Zeta23.EF.literatureRHS
  rw [hg]
  simp only [minusTransform_eq_source, neg_div, neg_neg]
  rw [add_comm (Zeta23.paperFT k (-(Complex.I / 2))) (Zeta23.paperFT k (Complex.I / 2))]

/-- Actual-zeta explicit formula, with absolute convergence, for every
complex C2 compactly supported test; no analytic package is supplied as a premise. -/
theorem actual_explicit_formula (k : ℝ → ℂ) (hk : ContDiff ℝ 2 k)
    (hkc : HasCompactSupport k) :
    Summable (spectralSummand k) ∧ spectralSum k = arithmeticSide k := by
  have h := Zeta23.WeilEF.EF_lit_zetaZeroConfig k hk hkc
  unfold spectralSum spectralSummand
  simpa only [zeroFrequency, minusTransform_eq_source, neg_neg, arithmeticSide_eq_source] using h

/-- The minus-sign transform retains the full complex Hermitian factorization. -/
theorem minusTransform_weilTest {f g : ℝ → ℂ} (hf : Continuous f) (hg : Continuous g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) (z : ℂ) :
    minusTransform (Zeta23.EF.weilTest f g) z =
      minusTransform f z * conj (minusTransform g (conj z)) := by
  rw [minusTransform_eq_source, Zeta23.EF.paperFT_weilTest hf hg hfc hgc]
  simp only [minusTransform_eq_source, map_neg]

def hermitianSummand (f g : ℝ → ℂ) (ρ : Zeta23.zetaZeroConfig.carrier) : ℂ :=
  (Zeta23.zetaZeroConfig.mult ρ : ℂ) * minusTransform f (zeroFrequency ρ) *
    conj (minusTransform g (conj (zeroFrequency ρ)))

def hermitianSpectralSum (f g : ℝ → ℂ) : ℂ := ∑' ρ, hermitianSummand f g ρ

theorem hermitianSummand_eq_test {f g : ℝ → ℂ} (hf : Continuous f) (hg : Continuous g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g)
    (ρ : Zeta23.zetaZeroConfig.carrier) :
    hermitianSummand f g ρ = spectralSummand (Zeta23.EF.weilTest f g) ρ := by
  unfold hermitianSummand spectralSummand
  rw [minusTransform_weilTest hf hg hfc hgc]
  ring

theorem actual_hermitian_explicit_formula (f g : ℝ → ℂ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) :
    Summable (hermitianSummand f g) ∧
      hermitianSpectralSum f g = arithmeticSide (Zeta23.EF.weilTest f g) := by
  have heq : hermitianSummand f g = spectralSummand (Zeta23.EF.weilTest f g) :=
    funext (hermitianSummand_eq_test hf.continuous hg.continuous hfc hgc)
  rw [heq]
  simpa only [hermitianSpectralSum, heq, spectralSum] using
    actual_explicit_formula (Zeta23.EF.weilTest f g)
      (Zeta23.EF.weilTest_contDiff hf hg.continuous hfc)
      (Zeta23.EF.weilTest_hasCompactSupport hfc hgc)

/-- Bilateral Laplace convention used by the local research notes. -/
def bilateralLaplace (f : ℝ → ℂ) (w : ℂ) : ℂ :=
  ∫ u : ℝ, f u * Complex.exp (w * (u : ℂ))

theorem bilateralLaplace_eq_source (f : ℝ → ℂ) (w : ℂ) :
    bilateralLaplace f w = Zeta23.paperFT f (w / Complex.I) := by
  unfold bilateralLaplace Zeta23.paperFT
  congr 1
  funext u
  congr 1
  congr 1
  field_simp [Complex.I_ne_zero]

theorem bilateralLaplace_imaginary (f : ℝ → ℂ) (r : ℝ) :
    bilateralLaplace f (Complex.I * (r : ℂ)) = Zeta23.paperFT f r := by
  rw [bilateralLaplace_eq_source]
  congr 1
  field_simp [Complex.I_ne_zero]

theorem integrable_gamma_laplace (k : ℝ → ℂ) (hk : ContDiff ℝ 2 k)
    (hkc : HasCompactSupport k) :
    Integrable (fun r : ℝ =>
      bilateralLaplace k (Complex.I * (r : ℂ)) * (gammaWeight r : ℂ)) := by
  simpa only [bilateralLaplace_imaginary] using integrable_gamma_source k hk hkc

theorem minusTransform_eq_laplace (f : ℝ → ℂ) (z : ℂ) :
    minusTransform f z = bilateralLaplace f (-Complex.I * z) := rfl

theorem source_gamma_conjugate (ρ : ℂ) :
    Complex.I * conj (Zeta23.gammaOf ρ) = 1 / 2 - conj ρ := by
  unfold Zeta23.gammaOf
  have hs : conj (1 / 2 : ℂ) = 1 / 2 := by
    have h := Complex.conj_ofReal (1 / 2 : ℝ)
    push_cast at h
    exact h
  rw [map_div₀, map_sub, hs, Complex.conj_I]
  field_simp [Complex.I_ne_zero]
  ring

theorem minusTransform_conjugate_frequency (f : ℝ → ℂ) (ρ : ℂ) :
    minusTransform f (conj (zeroFrequency ρ)) = bilateralLaplace f (1 / 2 - conj ρ) := by
  rw [minusTransform_eq_laplace]
  congr 1
  unfold zeroFrequency
  rw [map_neg]
  calc
    -Complex.I * -conj (Zeta23.gammaOf ρ) = Complex.I * conj (Zeta23.gammaOf ρ) := by ring
    _ = _ := source_gamma_conjugate ρ

def laplaceSummand (k : ℝ → ℂ) (ρ : Zeta23.zetaZeroConfig.carrier) : ℂ :=
  (Zeta23.zetaZeroConfig.mult ρ : ℂ) * bilateralLaplace k ((ρ : ℂ) - 1 / 2)

def laplaceSpectralSum (k : ℝ → ℂ) : ℂ := ∑' ρ, laplaceSummand k ρ

theorem spectralSummand_eq_laplace (k : ℝ → ℂ) (ρ : Zeta23.zetaZeroConfig.carrier) :
    spectralSummand k ρ = laplaceSummand k ρ := by
  unfold spectralSummand laplaceSummand
  rw [minusTransform_eq_laplace, zeroFrequency_mellin]

def laplaceArithmeticSide (k : ℝ → ℂ) : ℂ :=
  bilateralLaplace k (1 / 2) + bilateralLaplace k (-(1 / 2 : ℂ)) -
    ∑' n : ℕ, ((ArithmeticFunction.vonMangoldt n / Real.sqrt n : ℝ) : ℂ) *
      (k (Real.log n) + k (-Real.log n)) +
    (1 / (2 * Real.pi) : ℂ) * ∫ r : ℝ,
      bilateralLaplace k (Complex.I * (r : ℂ)) * (gammaWeight r : ℂ)

theorem laplaceArithmeticSide_eq_source (k : ℝ → ℂ) :
    laplaceArithmeticSide k = Zeta23.EF.literatureRHS k := by
  have hp : (1 / 2 : ℂ) / Complex.I = -Complex.I / 2 := by
    field_simp [Complex.I_ne_zero]
    norm_num
  have hm : (-(1 / 2 : ℂ)) / Complex.I = Complex.I / 2 := by
    field_simp [Complex.I_ne_zero]
    norm_num
  have hg (r : ℝ) : bilateralLaplace k (Complex.I * (r : ℂ)) = Zeta23.paperFT k r := by
    rw [bilateralLaplace_eq_source]
    congr 1
    field_simp [Complex.I_ne_zero]
  unfold laplaceArithmeticSide Zeta23.EF.literatureRHS
  rw [bilateralLaplace_eq_source, hp, bilateralLaplace_eq_source, hm]
  simp_rw [hg]
  unfold gammaWeight Zeta23.EF.gammaBracket
  ring

theorem actual_laplace_explicit_formula (k : ℝ → ℂ) (hk : ContDiff ℝ 2 k)
    (hkc : HasCompactSupport k) :
    Summable (laplaceSummand k) ∧ laplaceSpectralSum k = laplaceArithmeticSide k := by
  have heq : spectralSummand k = laplaceSummand k := funext (spectralSummand_eq_laplace k)
  have h := actual_explicit_formula k hk hkc
  rw [heq] at h
  simpa only [spectralSum, heq, laplaceSpectralSum,
    arithmeticSide_eq_source, laplaceArithmeticSide_eq_source] using h

/-- Off-line zeros require the reflected conjugate Laplace argument; the
second factor is not an absolute square at the first argument. -/
def laplaceHermitianSummand (f g : ℝ → ℂ) (ρ : Zeta23.zetaZeroConfig.carrier) : ℂ :=
  (Zeta23.zetaZeroConfig.mult ρ : ℂ) * bilateralLaplace f ((ρ : ℂ) - 1 / 2) *
    conj (bilateralLaplace g (1 / 2 - conj (ρ : ℂ)))

def laplaceHermitianSpectralSum (f g : ℝ → ℂ) : ℂ := ∑' ρ, laplaceHermitianSummand f g ρ

theorem hermitianSummand_eq_laplace (f g : ℝ → ℂ) (ρ : Zeta23.zetaZeroConfig.carrier) :
    hermitianSummand f g ρ = laplaceHermitianSummand f g ρ := by
  unfold hermitianSummand laplaceHermitianSummand
  rw [minusTransform_eq_laplace, zeroFrequency_mellin, minusTransform_conjugate_frequency]

theorem actual_laplace_hermitian_formula (f g : ℝ → ℂ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) :
    Summable (laplaceHermitianSummand f g) ∧
      laplaceHermitianSpectralSum f g = laplaceArithmeticSide (Zeta23.EF.weilTest f g) := by
  have heq : hermitianSummand f g = laplaceHermitianSummand f g :=
    funext (hermitianSummand_eq_laplace f g)
  have h := actual_hermitian_explicit_formula f g hf hg hfc hgc
  rw [heq] at h
  simpa only [hermitianSpectralSum, heq, laplaceHermitianSpectralSum,
    arithmeticSide_eq_source, laplaceArithmeticSide_eq_source] using h

/-- The complete localized density form, including absolute convergence.
 The support length and both complex test functions are explicit. -/
theorem actual_laplace_pair_density {L : ℝ} (hL : 0 < L) (f g : ℝ → ℂ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfs : tsupport f ⊆ Icc (-(L / 2)) (L / 2))
    (hgs : tsupport g ⊆ Icc (-(L / 2)) (L / 2)) :
    Summable (laplaceHermitianSummand f g) ∧
    Integrable (fun r : ℝ => bilateralLaplace f (Complex.I * (r : ℂ)) *
      conj (bilateralLaplace g (Complex.I * (r : ℂ))) * (Zeta23.nuX (Real.exp L) r : ℂ)) ∧
    laplaceHermitianSpectralSum f g = ∫ r : ℝ,
      bilateralLaplace f (Complex.I * (r : ℂ)) *
        conj (bilateralLaplace g (Complex.I * (r : ℂ))) * (Zeta23.nuX (Real.exp L) r : ℂ) := by
  have h := Zeta23.EF.explicitFormulaPaper_of_lit Zeta23.zetaZeroConfig
    Zeta23.WeilEF.EF_lit_zetaZeroConfig Zeta23.gammaFacts L hL f g hf hg hfs hgs
  have heq : laplaceHermitianSummand f g =
      (fun ρ : Zeta23.zetaZeroConfig.carrier => Zeta23.zetaZeroConfig.Wsummand f g ρ) := by
    funext ρ
    rw [← hermitianSummand_eq_laplace]
    unfold hermitianSummand Zeta23.ZeroConfig.Wsummand zeroFrequency
    simp only [minusTransform_eq_source, map_neg, neg_neg]
  simpa only [Zeta23.ZeroConfig.W, ← heq, laplaceHermitianSpectralSum,
    bilateralLaplace_imaginary] using h

#print axioms minusTransform_eq_source
#print axioms zeroFrequency_mellin
#print axioms actual_carrier
#print axioms actual_multiplicity
#print axioms gammaWeight_even
#print axioms integrable_gamma_source
#print axioms integrable_gamma_minus
#print axioms integrable_gamma_laplace
#print axioms summable_prime_row
#print axioms arithmeticSide_eq_source
#print axioms actual_explicit_formula
#print axioms minusTransform_weilTest
#print axioms actual_hermitian_explicit_formula
#print axioms bilateralLaplace_eq_source
#print axioms source_gamma_conjugate
#print axioms laplaceArithmeticSide_eq_source
#print axioms actual_laplace_explicit_formula
#print axioms actual_laplace_hermitian_formula
#print axioms actual_laplace_pair_density

end ActualWeil
