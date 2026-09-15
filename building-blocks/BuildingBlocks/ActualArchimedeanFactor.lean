import Mathlib.Analysis.SpecialFunctions.Gamma.Deligne
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.Analysis.Analytic.Order
import Mathlib.Analysis.Complex.CauchyIntegral
import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.NumberTheory.LSeries.Nonvanishing
import BuildingBlocks.ChargeFrozenFourier
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace BuildingBlocks.ActualArchimedeanFactor

theorem gamma_half_regular (s : ℂ) (hs : 0 < s.re) :
    Complex.Gamma (s / 2) ≠ 0 ∧ DifferentiableAt ℂ Complex.Gamma (s / 2) := by
  have hp : 0 < (s / 2).re := by simp only [Complex.div_ofNat_re]; positivity
  refine ⟨Complex.Gamma_ne_zero_of_re_pos hp, Complex.differentiableAt_Gamma _ ?_⟩
  intro n he
  have hre := congrArg Complex.re he
  simp only [Complex.neg_re, Complex.natCast_re] at hre
  have hn : (0 : ℝ) ≤ n := Nat.cast_nonneg n
  linarith

theorem gamma_factor_exponential :
    Complex.Gammaℝ = fun s : ℂ =>
      Complex.exp ((-s / 2) * (Real.log Real.pi : ℂ)) * Complex.Gamma (s / 2) := by
  funext s
  rw [Complex.Gammaℝ_def,
    BuildingBlocks.ChargeFrozenFourier.real_cpow_eq_exp_log Real.pi_pos]

theorem gamma_factor_log_derivative (s : ℂ) (hs : 0 < s.re) :
    logDeriv Complex.Gammaℝ s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 := by
  obtain ⟨hgn, hgd⟩ := gamma_half_regular s hs
  have hd : HasDerivAt (fun w : ℂ => w / 2) (1 / 2) s := by
    simpa using (hasDerivAt_id s).div_const (2 : ℂ)
  have hl : HasDerivAt (fun w : ℂ => (-w / 2) * (Real.log Real.pi : ℂ))
      (-(1 / 2) * (Real.log Real.pi : ℂ)) s := by
    simpa only [neg_div, Pi.neg_apply, id_eq] using
      ((hasDerivAt_id s).neg.div_const (2 : ℂ)).mul_const (Real.log Real.pi : ℂ)
  have he := hl.cexp
  rw [gamma_factor_exponential, logDeriv_mul
    (f := fun w : ℂ => Complex.exp ((-w / 2) * (Real.log Real.pi : ℂ)))
    (g := fun w : ℂ => Complex.Gamma (w / 2)) s
    (Complex.exp_ne_zero ((-s / 2) * (Real.log Real.pi : ℂ))) hgn
    he.differentiableAt (hgd.comp s hd.differentiableAt)]
  have hex : logDeriv (fun w : ℂ => Complex.exp ((-w / 2) * (Real.log Real.pi : ℂ))) s =
      -(Real.log Real.pi : ℂ) / 2 := by
    rw [logDeriv_apply, he.deriv]
    field_simp
  have hgg : logDeriv (fun w : ℂ => Complex.Gamma (w / 2)) s =
      logDeriv Complex.Gamma (s / 2) / 2 := by
    change logDeriv (Complex.Gamma ∘ (fun w : ℂ => w / 2)) s = _
    rw [logDeriv_comp (f := Complex.Gamma) (g := fun w : ℂ => w / 2)
      (x := s) hgd hd.differentiableAt, hd.deriv]
    ring
  rw [hex, hgg]

noncomputable def archMultiplier (t : ℝ) : ℝ :=
  2 * (logDeriv Complex.Gammaℝ ((1 / 2 : ℂ) + Complex.I * (t : ℂ))).re

theorem actual_arch_multiplier (t : ℝ) :
    archMultiplier t = -Real.log Real.pi +
      (logDeriv Complex.Gamma ((1 / 4 : ℂ) + Complex.I * (t : ℂ) / 2)).re := by
  have hs : 0 < ((1 / 2 : ℂ) + Complex.I * (t : ℂ)).re := by simp
  have harg : ((1 / 2 : ℂ) + Complex.I * (t : ℂ)) / 2 =
      (1 / 4 : ℂ) + Complex.I * (t : ℂ) / 2 := by ring
  unfold archMultiplier
  rw [gamma_factor_log_derivative _ hs, harg]
  simp only [Complex.add_re, Complex.div_ofNat_re, Complex.neg_re, Complex.ofReal_re]
  ring

theorem gamma_factor_regular (s : ℂ) (hs : 0 < s.re) :
    Complex.Gammaℝ s ≠ 0 ∧ DifferentiableAt ℂ Complex.Gammaℝ s := by
  obtain ⟨_, hg⟩ := gamma_half_regular s hs
  refine ⟨Complex.Gammaℝ_ne_zero_of_re_pos hs, ?_⟩
  rw [gamma_factor_exponential]
  have he : Differentiable ℂ (fun w : ℂ => Complex.exp ((-w / 2) * (Real.log Real.pi : ℂ))) := by fun_prop
  have hh : Differentiable ℂ (fun w : ℂ => w / 2) := by fun_prop
  exact (he s).mul (hg.comp s (hh s))

theorem completed_zeta_gamma_relation (s : ℂ) (hs : 0 < s.re) :
    completedRiemannZeta s = Complex.Gammaℝ s * riemannZeta s := by
  have hs0 : s ≠ 0 := by intro he; subst s; simp at hs
  have hn := Complex.Gammaℝ_ne_zero_of_re_pos hs
  have he := (eq_div_iff hn).mp (riemannZeta_def_of_ne_zero hs0)
  simpa only [mul_comm] using he.symm

theorem zeta_prime_series (s : ℂ) (hs : 1 < s.re) :
    -logDeriv riemannZeta s =
      ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s := by
  have he := ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs
  have ht (n : ℕ) : LSeries.term (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s n =
      (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s := by
    unfold LSeries.term
    split_ifs with hn
    · subst n
      simp
    · rfl
  change (∑' n, LSeries.term (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s n) = _ at he
  simp_rw [ht] at he
  rw [logDeriv_apply]
  simpa only [neg_div] using he.symm

theorem zeta_prime_series_absolute (s : ℂ) (hs : 1 < s.re) :
    Summable (fun n : ℕ => ‖(ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s‖) := by
  have he := ArithmeticFunction.LSeriesSummable_vonMangoldt hs
  change Summable (LSeries.term (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s) at he
  have hn := summable_norm_iff.mpr he
  convert hn using 1
  funext n
  unfold LSeries.term
  split_ifs with h0
  · subst n
    simp
  · rfl

theorem completed_zeta_prime_boundary (s : ℂ) (hs : 1 < s.re) :
    logDeriv completedRiemannZeta s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 -
        ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s := by
  have hs0 : 0 < s.re := lt_trans zero_lt_one hs
  obtain ⟨hgn, hgd⟩ := gamma_factor_regular s hs0
  have hzn : riemannZeta s ≠ 0 := riemannZeta_ne_zero_of_one_le_re (le_of_lt hs)
  have hs1 : s ≠ 1 := by intro he; subst s; simp at hs
  have hzd := differentiableAt_riemannZeta hs1
  have he : completedRiemannZeta =ᶠ[nhds s] (fun w => Complex.Gammaℝ w * riemannZeta w) := by
    have hp : ∀ᶠ w : ℂ in nhds s, 0 < w.re :=
      (isOpen_lt continuous_const Complex.continuous_re).mem_nhds hs0
    filter_upwards [hp] with w hw
    exact completed_zeta_gamma_relation w hw
  have hlog : logDeriv completedRiemannZeta s =
      logDeriv (fun w => Complex.Gammaℝ w * riemannZeta w) s := by
    rw [logDeriv_apply, logDeriv_apply, he.deriv_eq, he.eq_of_nhds]
  rw [hlog, logDeriv_mul (f := Complex.Gammaℝ) (g := riemannZeta) s hgn hzn hgd hzd,
    gamma_factor_log_derivative s hs0]
  have hp := zeta_prime_series s hs
  rw [← hp]
  ring

noncomputable def xi (s : ℂ) : ℂ :=
  (1 + s * (s - 1) * completedRiemannZeta₀ s) / 2

theorem xi_entire : Differentiable ℂ xi := by
  have hz := differentiable_completedZeta₀
  unfold xi
  fun_prop

theorem xi_pole_values : xi 0 = 1 / 2 ∧ xi 1 = 1 / 2 := by
  simp [xi]

theorem xi_functional_equation (s : ℂ) : xi (1 - s) = xi s := by
  unfold xi
  rw [completedRiemannZeta₀_one_sub]
  ring

theorem xi_completed_relation (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1) :
    xi s = s * (s - 1) * completedRiemannZeta s / 2 := by
  rw [completedRiemannZeta_eq]
  unfold xi
  have h1 : 1 - s ≠ 0 := sub_ne_zero.mpr hs1.symm
  field_simp
  ring

theorem xi_zero_iff_zeta (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    xi s = 0 ↔ riemannZeta s = 0 := by
  have hs0 : s ≠ 0 := by intro he; subst s; simp at hs
  have hgn := Complex.Gammaℝ_ne_zero_of_re_pos hs
  rw [xi_completed_relation s hs0 hs1, completed_zeta_gamma_relation s hs]
  simp only [div_eq_zero_iff, mul_eq_zero, hs0, sub_ne_zero.mpr hs1, hgn,
    false_or, OfNat.ofNat_ne_zero, or_false]

#print axioms xi_entire
#print axioms xi_pole_values
#print axioms xi_functional_equation
#print axioms xi_completed_relation
#print axioms xi_zero_iff_zeta
#print axioms gamma_factor_regular
#print axioms completed_zeta_gamma_relation
#print axioms zeta_prime_series
#print axioms zeta_prime_series_absolute
#print axioms completed_zeta_prime_boundary
#print axioms gamma_half_regular
#print axioms gamma_factor_exponential
#print axioms gamma_factor_log_derivative
#print axioms actual_arch_multiplier
end BuildingBlocks.ActualArchimedeanFactor
