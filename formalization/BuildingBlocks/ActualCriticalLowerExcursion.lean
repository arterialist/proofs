import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.RiemannZetaRealAxisUnconditional
import BuildingBlocks.RiemannZetaPoleCancellation
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.NumberTheory.SumPrimeReciprocals

/-!
# Unconditional lower excursions of the actual critical sum

The lower growth criterion (`ActualCriticalGrowthCriterion.RiemannHypothesis_of_lower_growth_after`)
shows that an eventual bound `-C x^{3/2} ≤ Re W(x)` would imply RH. Here we show that such a
bound can never hold, for any real `C` and any cutoff `A`. Hence

  `∀ C B, ∃ x > B, Re W(x) < -C x^{3/2}`

unconditionally: the actual critical sum has negative excursions larger than every multiple
of `x^{3/2}`.

The argument is the Landau argument once more, now followed to its singularity. Under the
lower bound, the positive Landau measure `(C x^{3/2} + W x) x^{-2} dx` has a Laplace transform
that converges and is nonnegative on the whole real ray `σ > 1/2`, and on `(1/2, 1)` it equals
`filledTransform σ + C A^{1/2-σ}/(σ-1/2) - initial(σ)` (the real-axis identity uses the
unconditional non-vanishing `ζ(σ) ≠ 0` on `(1/2, 1)`). Multiplying by `σ - 1/2` and letting
`σ → 1/2⁺`:

* `(σ - 1/2) M(σ) → 4/3` by the residue of `ζ` at `1` (`riemannZeta_residue_one`);
* `G(σ) = -ζ'/ζ(σ) - σ/(σ-1)` stays bounded, because `ζ(1/2) ≠ 0` (proved here from the
  repository's unconditional bound `Re Λ₀(σ) < 2` on `(1/2, 1)` and continuity);
* `H(σ) = ∑_p (log p)² p^{-2σ}/(1-p^{-σ})² → +∞`, because `∑_p (log p)²/p` diverges
  (from `Nat.Primes.not_summable_one_div`);
* the majorant term stays bounded by `|C|` and the initial part is entire.

So the transform's real part tends to `-∞`, contradicting nonnegativity.

All results are unconditional and use only the standard axioms.
-/

open MeasureTheory Set Filter Topology
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalLowerExcursion

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion

/-! ### `ζ(1/2) ≠ 0` from the unconditional real-axis bound -/

theorem completedRiemannZeta₀_re_half_le_two :
    (completedRiemannZeta₀ ((((1 : ℝ) / 2 : ℝ)) : ℂ)).re ≤ 2 := by
  have hcont : ContinuousAt (fun σ : ℝ => (completedRiemannZeta₀ (σ : ℂ)).re) ((1 : ℝ) / 2) := by
    have h1 : ContinuousAt completedRiemannZeta₀ ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
      differentiable_completedZeta₀.continuous.continuousAt
    exact Complex.continuous_re.continuousAt.comp (h1.comp Complex.continuous_ofReal.continuousAt)
  have ht : Tendsto (fun σ : ℝ => (completedRiemannZeta₀ (σ : ℂ)).re) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 ((completedRiemannZeta₀ ((((1 : ℝ) / 2 : ℝ)) : ℂ)).re)) :=
    hcont.tendsto.mono_left nhdsWithin_le_nhds
  have hev : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), (completedRiemannZeta₀ (σ : ℂ)).re ≤ 2 := by
    filter_upwards [Ioo_mem_nhdsGT (by norm_num : (1 : ℝ) / 2 < 1)] with σ hσ
    exact (RiemannZetaRealAxisUnconditional.completedRiemannZeta₀_re_lt_two_unconditional
      σ hσ.1 hσ.2).le
  exact le_of_tendsto ht hev

theorem riemannZeta_half_ne_zero : riemannZeta ((((1 : ℝ) / 2 : ℝ)) : ℂ) ≠ 0 := by
  apply RiemannZetaPoleCancellation.riemannZeta_ofReal_ne_zero_of_completed_bound
    (by norm_num) (by norm_num)
  linarith [completedRiemannZeta₀_re_half_le_two]

/-! ### The same-prime Dirichlet series on the real axis -/

theorem primeRatio_ofReal (p : Nat.Primes) (σ : ℝ) :
    SamePrimeDirichlet.primeRatio p (σ : ℂ) = (((((p : ℕ) : ℝ)) ^ (-σ) : ℝ) : ℂ) := by
  unfold SamePrimeDirichlet.primeRatio
  have hp : (0 : ℝ) ≤ ((p : ℕ) : ℝ) := by positivity
  rw [Complex.ofReal_cpow hp (-σ)]
  push_cast
  rfl

theorem samePrimeTerm_ofReal (p : Nat.Primes) (σ : ℝ) :
    SamePrimeDirichlet.samePrimeTerm p (σ : ℂ) =
      (((Real.log ((p : ℕ) : ℝ)) ^ 2 * (((p : ℕ) : ℝ) ^ (-σ)) ^ 2 /
        (1 - ((p : ℕ) : ℝ) ^ (-σ)) ^ 2 : ℝ) : ℂ) := by
  unfold SamePrimeDirichlet.samePrimeTerm
  rw [primeRatio_ofReal]
  push_cast
  ring

theorem samePrimeTerm_im (p : Nat.Primes) (σ : ℝ) :
    (SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)).im = 0 := by
  rw [samePrimeTerm_ofReal]
  exact Complex.ofReal_im _

theorem samePrimeTerm_re_ge (p : Nat.Primes) {σ : ℝ} (hσ : 0 < σ) :
    (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * σ) ≤
      (SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)).re := by
  rw [samePrimeTerm_ofReal, Complex.ofReal_re]
  have hp1 : (1 : ℝ) < ((p : ℕ) : ℝ) := by exact_mod_cast p.2.one_lt
  have hp0 : (0 : ℝ) < ((p : ℕ) : ℝ) := by linarith
  set r : ℝ := ((p : ℕ) : ℝ) ^ (-σ) with hr
  have hr0 : 0 < r := Real.rpow_pos_of_pos hp0 _
  have hr1 : r < 1 := Real.rpow_lt_one_of_one_lt_of_neg hp1 (by linarith)
  have hsq : ((p : ℕ) : ℝ) ^ (-2 * σ) = r ^ 2 := by
    rw [hr, ← Real.rpow_natCast, ← Real.rpow_mul hp0.le]
    congr 1
    push_cast
    ring
  rw [hsq]
  apply le_div_self (by positivity) (by nlinarith) (by nlinarith)

theorem samePrimeTerm_re_nonneg (p : Nat.Primes) {σ : ℝ} (hσ : 0 < σ) :
    0 ≤ (SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)).re :=
  le_trans (by positivity) (samePrimeTerm_re_ge p hσ)

theorem samePrimeTerm_summable_ofReal {σ : ℝ} (hσ : 1 / 2 < σ) :
    Summable (fun p : Nat.Primes => SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)) :=
  (SamePrimeDirichlet.samePrimeTerm_norm_summable (by simpa using hσ)).of_norm

theorem H_im (σ : ℝ) (hσ : 1 / 2 < σ) : (SamePrimeDirichlet.H (σ : ℂ)).im = 0 := by
  unfold SamePrimeDirichlet.H
  rw [Complex.im_tsum (samePrimeTerm_summable_ofReal hσ)]
  simp [samePrimeTerm_im]

theorem H_re_ge_finset (σ : ℝ) (hσ : 1 / 2 < σ) (S : Finset Nat.Primes) :
    (∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * σ)) ≤
      (SamePrimeDirichlet.H (σ : ℂ)).re := by
  have hs := samePrimeTerm_summable_ofReal hσ
  have hre : Summable (fun p : Nat.Primes => (SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)).re) :=
    (Complex.hasSum_re hs.hasSum).summable
  have hσ0 : 0 < σ := by linarith
  unfold SamePrimeDirichlet.H
  rw [Complex.re_tsum hs]
  calc (∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * σ))
      ≤ ∑ p ∈ S, (SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)).re :=
        Finset.sum_le_sum (fun p _ => samePrimeTerm_re_ge p hσ0)
    _ ≤ ∑' p, (SamePrimeDirichlet.samePrimeTerm p (σ : ℂ)).re :=
        hre.sum_le_tsum S (fun p _ => samePrimeTerm_re_nonneg p hσ0)

/-! ### Divergence of `∑_p (log p)^2 / p` -/

theorem not_summable_log_sq_div_prime :
    ¬ Summable (fun p : Nat.Primes => (Real.log ((p : ℕ) : ℝ)) ^ 2 / ((p : ℕ) : ℝ)) := by
  intro h
  apply Nat.Primes.not_summable_one_div
  refine Summable.of_nonneg_of_le (fun p => by positivity) (fun p => ?_) (h.mul_left 3)
  have hp2 : (2 : ℝ) ≤ ((p : ℕ) : ℝ) := by exact_mod_cast p.2.two_le
  have hp0 : (0 : ℝ) < ((p : ℕ) : ℝ) := by linarith
  have hlog : Real.log 2 ≤ Real.log ((p : ℕ) : ℝ) := Real.log_le_log (by norm_num) hp2
  have h2 : (0.6931471803 : ℝ) < Real.log 2 := Real.log_two_gt_d9
  have hsq : 1 ≤ 3 * (Real.log ((p : ℕ) : ℝ)) ^ 2 := by nlinarith
  calc (1 : ℝ) / ((p : ℕ) : ℝ) = 1 * (1 / ((p : ℕ) : ℝ)) := by ring
    _ ≤ (3 * (Real.log ((p : ℕ) : ℝ)) ^ 2) * (1 / ((p : ℕ) : ℝ)) := by
        apply mul_le_mul_of_nonneg_right hsq (by positivity)
    _ = 3 * ((Real.log ((p : ℕ) : ℝ)) ^ 2 / ((p : ℕ) : ℝ)) := by ring

theorem exists_finset_log_sq_div_prime_gt (K : ℝ) :
    ∃ S : Finset Nat.Primes, K < ∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 / ((p : ℕ) : ℝ) := by
  by_contra h
  push_neg at h
  exact not_summable_log_sq_div_prime (summable_of_sum_le (fun p => by positivity) h)

theorem eventually_H_re_ge (K : ℝ) :
    ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), K ≤ (SamePrimeDirichlet.H (σ : ℂ)).re := by
  obtain ⟨S, hS⟩ := exists_finset_log_sq_div_prime_gt K
  have hcont : ∀ p : Nat.Primes, ContinuousAt
      (fun σ : ℝ => (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * σ)) ((1 : ℝ) / 2) := by
    intro p
    have hp0 : ((p : ℕ) : ℝ) ≠ 0 := by
      have : (2 : ℝ) ≤ ((p : ℕ) : ℝ) := by exact_mod_cast p.2.two_le
      linarith
    have h1 : ContinuousAt (fun b : ℝ => ((p : ℕ) : ℝ) ^ b) (-2 * ((1 : ℝ) / 2)) :=
      Real.continuousAt_const_rpow hp0
    have h2 : ContinuousAt (fun σ : ℝ => -2 * σ) ((1 : ℝ) / 2) := by fun_prop
    exact continuousAt_const.mul (h1.comp h2)
  have hT : Tendsto (fun σ : ℝ => ∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * σ))
      (𝓝 ((1 : ℝ) / 2))
      (𝓝 (∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * ((1 : ℝ) / 2)))) :=
    tendsto_finset_sum S (fun p _ => (hcont p).tendsto)
  have h0 : (∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * ((1 : ℝ) / 2))) =
      ∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 / ((p : ℕ) : ℝ) := by
    apply Finset.sum_congr rfl
    intro p _
    rw [show (-2 * ((1 : ℝ) / 2)) = (-1 : ℝ) by ring, Real.rpow_neg_one]
    ring
  rw [h0] at hT
  have hev : ∀ᶠ σ : ℝ in 𝓝 ((1 : ℝ) / 2),
      K < ∑ p ∈ S, (Real.log ((p : ℕ) : ℝ)) ^ 2 * ((p : ℕ) : ℝ) ^ (-2 * σ) :=
    hT.eventually (lt_mem_nhds hS)
  filter_upwards [hev.filter_mono nhdsWithin_le_nhds, self_mem_nhdsWithin] with σ hσK hσ
  exact le_trans hσK.le (H_re_ge_finset σ hσ S)

/-! ### The residue factor `(σ - 1/2) M(σ) → 4/3` -/

theorem tendsto_half_shift :
    Tendsto (fun σ : ℝ => ((σ : ℂ) + 1 / 2)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝[≠] (1 : ℂ)) := by
  apply tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within
  · have h : Tendsto (fun σ : ℝ => ((σ : ℂ) + 1 / 2)) (𝓝 ((1 : ℝ) / 2))
        (𝓝 (((((1 : ℝ) / 2 : ℝ)) : ℂ) + 1 / 2)) :=
      (Complex.continuous_ofReal.continuousAt.add continuousAt_const).tendsto
    have h2 : (((((1 : ℝ) / 2 : ℝ)) : ℂ) + 1 / 2) = 1 := by push_cast; ring
    rw [h2] at h
    exact h.mono_left nhdsWithin_le_nhds
  · filter_upwards [self_mem_nhdsWithin] with σ hσ
    rw [Set.mem_compl_singleton_iff]
    intro h
    have := congrArg Complex.re h
    simp at this
    have hσ' : (1 : ℝ) / 2 < σ := hσ
    linarith

theorem tendsto_residue_factor :
    Tendsto (fun σ : ℝ => (((σ : ℂ) + 1 / 2) - 1) * riemannZeta ((σ : ℂ) + 1 / 2))
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 1) :=
  riemannZeta_residue_one.comp tendsto_half_shift

/-- `m(σ) = (σ - 1/2) M(σ)`, with the real prefactor written as a cast. -/
noncomputable def m (σ : ℝ) : ℂ := ((σ - 1 / 2 : ℝ) : ℂ) * ShiftedZetaMultiplier.M (σ : ℂ)

theorem tendsto_m : Tendsto m (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (4 / 3 : ℂ)) := by
  have h1 := tendsto_residue_factor
  have h2 : Tendsto (fun σ : ℝ => (1 : ℂ) / ((σ : ℂ) * ((σ : ℂ) + 1))) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 ((1 : ℂ) / (((((1 : ℝ) / 2 : ℝ)) : ℂ) * ((((((1 : ℝ) / 2 : ℝ)) : ℂ)) + 1)))) := by
    apply Tendsto.mono_left _ nhdsWithin_le_nhds
    apply ContinuousAt.tendsto
    apply ContinuousAt.div continuousAt_const
    · exact Complex.continuous_ofReal.continuousAt.mul
        (Complex.continuous_ofReal.continuousAt.add continuousAt_const)
    · push_cast
      norm_num
  have h3 : ((1 : ℂ) / (((((1 : ℝ) / 2 : ℝ)) : ℂ) * ((((((1 : ℝ) / 2 : ℝ)) : ℂ)) + 1))) = 4 / 3 := by
    push_cast
    norm_num
  rw [h3] at h2
  have h := h1.mul h2
  rw [one_mul] at h
  refine h.congr (fun σ => ?_)
  unfold m ShiftedZetaMultiplier.M
  push_cast
  ring

/-! ### The unconditional excursion theorem -/

theorem moment_re_nonneg (C A : ℝ) (σ : ℝ) :
    0 ≤ (LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 (σ : ℂ)).re := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand
  simp only [pow_zero, one_mul]
  have hfun : (fun x : ℝ => Complex.exp (-(σ : ℂ) * (time x : ℂ))) =
      fun x : ℝ => ((Real.exp (-σ * time x) : ℝ) : ℂ) := by
    funext x
    push_cast
    rfl
  have key : (∫ x, ((Real.exp (-σ * time x) : ℝ) : ℂ) ∂(lowerMeasure C A)) =
      ((∫ x, Real.exp (-σ * time x) ∂(lowerMeasure C A) : ℝ) : ℂ) := integral_ofReal
  rw [hfun, key, Complex.ofReal_re]
  exact integral_nonneg (fun x => (Real.exp_pos _).le)

theorem majorant_prefactor {C A : ℝ} (hA : 1 ≤ A) {σ : ℝ} (hσ : 1 / 2 < σ) :
    ((σ - 1 / 2 : ℝ) : ℂ) * majorantTransform C A (σ : ℂ) =
      (C : ℂ) * (((A ^ (1 / 2 - σ) : ℝ)) : ℂ) := by
  unfold majorantTransform
  have hA0 : (0 : ℝ) ≤ A := by linarith
  have hexp : (-(σ : ℂ) - 1 / 2 + 1) = (((1 / 2 - σ : ℝ)) : ℂ) := by push_cast; ring
  have hne : (-(σ : ℂ) - 1 / 2 + 1) ≠ 0 := by
    rw [hexp]
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hd : (((σ - 1 / 2 : ℝ)) : ℂ) ≠ 0 := by
    have : (0 : ℝ) < σ - 1 / 2 := by linarith
    exact_mod_cast this.ne'
  have he : (-(σ : ℂ) - 1 / 2 + 1) = -(((σ - 1 / 2 : ℝ)) : ℂ) := by push_cast; ring
  rw [Complex.ofReal_cpow hA0, ← hexp, he, neg_div_neg_eq, mul_comm, mul_assoc,
    div_mul_cancel₀ _ hd]

theorem majorant_prefactor_re_le {C A : ℝ} (hA : 1 ≤ A) {σ : ℝ} (hσ : 1 / 2 < σ) :
    (((σ - 1 / 2 : ℝ) : ℂ) * majorantTransform C A (σ : ℂ)).re ≤ |C| := by
  rw [majorant_prefactor hA hσ, ← Complex.ofReal_mul, Complex.ofReal_re]
  have h1 : A ^ (1 / 2 - σ) ≤ 1 := Real.rpow_le_one_of_one_le_of_nonpos hA (by linarith)
  have h0 : 0 ≤ A ^ (1 / 2 - σ) := Real.rpow_nonneg (by linarith) _
  calc C * A ^ (1 / 2 - σ) ≤ |C| * A ^ (1 / 2 - σ) :=
        mul_le_mul_of_nonneg_right (le_abs_self C) h0
    _ ≤ |C| * 1 := mul_le_mul_of_nonneg_left h1 (abs_nonneg C)
    _ = |C| := mul_one _

/-- **Unconditional lower excursions.** For every real `C` and every cutoff `A ≥ 1`, the bound
`-C x^{3/2} ≤ Re W(x)` fails for some `x > A`. -/
theorem not_eventually_lower_growth (C A : ℝ) (hA : 1 ≤ A) :
    ¬ (∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) := by
  intro hlow
  -- the continuation and the real-axis identity
  have hJ := lowerContinuation_analyticOnNhd hA hlow
  have heq : ∀ s : ℂ, 1 < s.re →
      lowerContinuation C A s = CriticalTransformPoles.filledTransform s :=
    fun s hs => lowerContinuation_eq_filledTransform hA hlow hs
  have hcl := CriticalTransformContinuationRH.cleared_zero_on_rightDomain hJ heq
  have hreal : ∀ σ : ℝ, 1 / 2 < σ → σ < 1 →
      lowerContinuation C A (σ : ℂ) = CriticalTransformPoles.filledTransform (σ : ℂ) := by
    intro σ h1 h2
    have hσ1 : (σ : ℂ) ≠ 1 := by
      intro h
      have := congrArg Complex.re h
      simp at this
      linarith
    have hz : riemannZeta (σ : ℂ) ≠ 0 :=
      RiemannZetaRealAxisUnconditional.riemannZeta_ofReal_ne_zero_unconditional h1 h2
    have hdom : (σ : ℂ) ∈ rightDomain := ⟨by simpa using h1, hσ1⟩
    have h0 := hcl (σ : ℂ) hdom
    rw [CriticalTransformContinuationRH.cleared_eq hσ1 hz] at h0
    exact sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_left (pow_ne_zero 2 hz))
  -- bounded quantities near 1/2
  set G := LogDerivativePole.centeredZetaLogDerivative with hG
  set I : ℂ → ℂ := fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1) with hI
  have hhalf : ((((1 : ℝ) / 2 : ℝ)) : ℂ) = (1 / 2 : ℂ) := by push_cast; ring
  have hζ : AnalyticAt ℂ riemannZeta ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
    zeta_analytic_off_pole _ (by rw [Set.mem_compl_singleton_iff, hhalf]; norm_num)
  have hGcont : ContinuousAt G ((((1 : ℝ) / 2 : ℝ)) : ℂ) := by
    have hd : ContinuousAt (deriv riemannZeta) ((((1 : ℝ) / 2 : ℝ)) : ℂ) := hζ.deriv.continuousAt
    have hq : ContinuousAt (fun s => deriv riemannZeta s / riemannZeta s) ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
      hd.div hζ.continuousAt riemannZeta_half_ne_zero
    have hr : ContinuousAt (fun s : ℂ => s / (s - 1)) ((((1 : ℝ) / 2 : ℝ)) : ℂ) := by
      apply continuousAt_id.div (continuousAt_id.sub continuousAt_const)
      rw [hhalf]; norm_num
    have hGe : G = fun s => -(deriv riemannZeta s / riemannZeta s) - s / (s - 1) := by
      funext s
      simp [hG, LogDerivativePole.centeredZetaLogDerivative, logDeriv_apply]
    rw [hGe]
    exact hq.neg.sub hr
  have hIcont : ContinuousAt I ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
    (MellinCompactCorrection.differentiable_W_initialPart A).continuous.continuousAt
  have hcast : Tendsto (fun σ : ℝ => (σ : ℂ)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((((1 : ℝ) / 2 : ℝ)) : ℂ)) :=
    Complex.continuous_ofReal.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  set B : ℝ := ‖G ((((1 : ℝ) / 2 : ℝ)) : ℂ)‖ + 1 with hB
  set D : ℝ := ‖I ((((1 : ℝ) / 2 : ℝ)) : ℂ)‖ + 1 with hD
  have hGb : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖G (σ : ℂ)‖ ≤ B := by
    have ht := (hGcont.tendsto.comp hcast).norm
    exact (ht.eventually (gt_mem_nhds (lt_add_one _))).mono (fun σ h => h.le)
  have hIb : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖I (σ : ℂ)‖ ≤ D := by
    have ht := (hIcont.tendsto.comp hcast).norm
    exact (ht.eventually (gt_mem_nhds (lt_add_one _))).mono (fun σ h => h.le)
  have hmre : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), 1 ≤ (m σ).re := by
    have ht : Tendsto (fun σ => (m σ).re) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((4 / 3 : ℂ).re)) :=
      (Complex.continuous_re.tendsto _).comp tendsto_m
    have h43 : (4 / 3 : ℂ).re = 4 / 3 := by norm_num
    rw [h43] at ht
    exact (ht.eventually (lt_mem_nhds (by norm_num : (1 : ℝ) < 4 / 3))).mono (fun σ h => h.le)
  have hmnorm : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖m σ‖ ≤ 2 := by
    have ht := tendsto_m.norm
    have h43 : ‖(4 / 3 : ℂ)‖ = 4 / 3 := by
      rw [show (4 / 3 : ℂ) = (((4 / 3 : ℝ)) : ℂ) by push_cast; ring, Complex.norm_real]
      norm_num
    rw [h43] at ht
    exact (ht.eventually (gt_mem_nhds (by norm_num : (4 / 3 : ℝ) < 2))).mono (fun σ h => h.le)
  set K : ℝ := 2 * B ^ 2 + |C| + D + 1 with hK
  have hH := eventually_H_re_ge K
  have hIoo : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), σ ∈ Ioo ((1 : ℝ) / 2) 1 :=
    Ioo_mem_nhdsGT (by norm_num)
  obtain ⟨σ, ⟨⟨⟨⟨⟨hσI, hGσ⟩, hIσ⟩, hmσ⟩, hmnσ⟩, hHσ⟩⟩ :=
    (((((hIoo.and hGb).and hIb).and hmre).and hmnorm).and hH).exists
  have h1 : 1 / 2 < σ := hσI.1
  have h2 : σ < 1 := hσI.2
  have hσ1 : (σ : ℂ) ≠ 1 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hd0 : 0 < σ - 1 / 2 := by linarith
  have hd1 : σ - 1 / 2 ≤ 1 := by linarith
  -- the Laplace transform at σ, through the continuation
  have hmom : LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 (σ : ℂ) =
      CriticalTransformPoles.filledTransform (σ : ℂ) + majorantTransform C A (σ : ℂ) - I (σ : ℂ) := by
    have := hreal σ h1 h2
    unfold lowerContinuation at this
    simp only [hI]
    linear_combination this
  have hfill : CriticalTransformPoles.filledTransform (σ : ℂ) =
      ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - SamePrimeDirichlet.H (σ : ℂ)) := by
    rw [CriticalTransformPoles.filledTransform_eq_of_ne hσ1]
    rfl
  -- multiply by the positive real σ - 1/2 and take real parts
  have hnn : 0 ≤ (((σ - 1 / 2 : ℝ) : ℂ) * LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 (σ : ℂ)).re := by
    rw [Complex.re_ofReal_mul]
    exact mul_nonneg hd0.le (moment_re_nonneg C A σ)
  rw [hmom, hfill] at hnn
  have hexpand : ((σ - 1 / 2 : ℝ) : ℂ) *
      (ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - SamePrimeDirichlet.H (σ : ℂ)) +
        majorantTransform C A (σ : ℂ) - I (σ : ℂ)) =
      m σ * G (σ : ℂ) ^ 2 - m σ * SamePrimeDirichlet.H (σ : ℂ) +
        ((σ - 1 / 2 : ℝ) : ℂ) * majorantTransform C A (σ : ℂ) -
        ((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ) := by
    unfold m
    ring
  rw [hexpand] at hnn
  simp only [Complex.sub_re, Complex.add_re] at hnn
  -- bound each piece
  have hA1 : (m σ * G (σ : ℂ) ^ 2).re ≤ 2 * B ^ 2 := by
    calc (m σ * G (σ : ℂ) ^ 2).re ≤ ‖m σ * G (σ : ℂ) ^ 2‖ := Complex.re_le_norm _
      _ = ‖m σ‖ * ‖G (σ : ℂ)‖ ^ 2 := by rw [norm_mul, norm_pow]
      _ ≤ 2 * B ^ 2 := by
          apply mul_le_mul hmnσ (pow_le_pow_left₀ (norm_nonneg _) hGσ 2) (by positivity) (by norm_num)
  have hA2 : K ≤ (m σ * SamePrimeDirichlet.H (σ : ℂ)).re := by
    rw [Complex.mul_re, H_im σ h1, mul_zero, sub_zero]
    have hK0 : 0 ≤ K := by positivity
    have hHnn : 0 ≤ (SamePrimeDirichlet.H (σ : ℂ)).re := le_trans hK0 hHσ
    calc K ≤ (SamePrimeDirichlet.H (σ : ℂ)).re := hHσ
      _ = 1 * (SamePrimeDirichlet.H (σ : ℂ)).re := (one_mul _).symm
      _ ≤ (m σ).re * (SamePrimeDirichlet.H (σ : ℂ)).re :=
          mul_le_mul_of_nonneg_right hmσ hHnn
  have hA3 : (((σ - 1 / 2 : ℝ) : ℂ) * majorantTransform C A (σ : ℂ)).re ≤ |C| :=
    majorant_prefactor_re_le hA h1
  have hA4 : -D ≤ (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re := by
    rw [Complex.re_ofReal_mul]
    have h := Complex.abs_re_le_norm (I (σ : ℂ))
    have h' : -‖I (σ : ℂ)‖ ≤ (I (σ : ℂ)).re := (abs_le.mp h).1
    have hD0 : 0 ≤ D := by rw [hD]; positivity
    have hn0 : 0 ≤ ‖I (σ : ℂ)‖ := norm_nonneg _
    calc -D ≤ -((σ - 1 / 2) * D) := by nlinarith [hd0, hd1, hD0]
      _ ≤ -((σ - 1 / 2) * ‖I (σ : ℂ)‖) := by nlinarith [hd0, hIσ, hn0]
      _ = (σ - 1 / 2) * (-‖I (σ : ℂ)‖) := by ring
      _ ≤ (σ - 1 / 2) * (I (σ : ℂ)).re := mul_le_mul_of_nonneg_left h' hd0.le
  linarith

/-- For every real `C` and every `B`, some `x > B` has `Re W(x) < -C x^{3/2}`. -/
theorem exists_lower_excursion (C B : ℝ) :
    ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2)) := by
  by_contra h
  push_neg at h
  apply not_eventually_lower_growth C (max 1 B) (le_max_left _ _)
  intro x hx
  exact h x (lt_of_le_of_lt (le_max_right 1 B) hx)

/-- Filter form: `Re W(x) < -C x^{3/2}` happens frequently as `x → ∞`, for every `C`. -/
theorem frequently_lower_excursion (C : ℝ) :
    ∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2)) := by
  rw [Filter.frequently_atTop]
  intro B
  obtain ⟨x, hx, hW⟩ := exists_lower_excursion C B
  exact ⟨x, hx.le, hW⟩

/-- In particular `W` is not eventually nonnegative: it takes negative values beyond every `B`. -/
theorem exists_negative_value (B : ℝ) : ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re < 0 := by
  obtain ⟨x, hx, hW⟩ := exists_lower_excursion 0 B
  exact ⟨x, hx, by simpa using hW⟩

end BuildingBlocks.ActualCriticalLowerExcursion

#print axioms BuildingBlocks.ActualCriticalLowerExcursion.riemannZeta_half_ne_zero
#print axioms BuildingBlocks.ActualCriticalLowerExcursion.not_eventually_lower_growth
#print axioms BuildingBlocks.ActualCriticalLowerExcursion.exists_lower_excursion
#print axioms BuildingBlocks.ActualCriticalLowerExcursion.frequently_lower_excursion
