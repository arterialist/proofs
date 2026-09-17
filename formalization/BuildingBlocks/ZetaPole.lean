/-
Copyright (c) 2026 Andrew. Released under the MIT license in LICENSE.
Local logarithmic-derivative poles at zeros of the Riemann zeta function.
See ../../building-blocks/catalog.md for mathematical sources and verification.
-/
import Mathlib.Analysis.Analytic.IsolatedZeros
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.Analysis.Complex.CauchyIntegral
import Mathlib.Analysis.NormedSpace.Connected
import Mathlib.NumberTheory.Harmonic.EulerMascheroni
import Mathlib.NumberTheory.LSeries.Dirichlet

open Filter Set
open scoped Topology

namespace BuildingBlocks

theorem zeta_analytic_off_pole :
    AnalyticOnNhd ℂ riemannZeta ({1}ᶜ : Set ℂ) :=
  (show DifferentiableOn ℂ riemannZeta ({1}ᶜ : Set ℂ) from
    fun _ hs => (differentiableAt_riemannZeta hs).differentiableWithinAt).analyticOnNhd
      isOpen_compl_singleton

theorem zeta_not_locally_zero {s : ℂ} (hs : s ≠ 1) :
    ¬ ∀ᶠ z in 𝓝 s, riemannZeta z = 0 := by
  intro hz
  have hc : IsPreconnected ({1}ᶜ : Set ℂ) :=
    (isConnected_compl_singleton_of_one_lt_rank
      (Complex.rank_real_complex ▸ Nat.one_lt_ofNat) (1 : ℂ)).isPreconnected
  have hall := zeta_analytic_off_pole.eqOn_zero_of_preconnected_of_eventuallyEq_zero hc hs hz
  exact riemannZeta_ne_zero_of_one_lt_re (s := 2) (by norm_num)
    (hall (show (2 : ℂ) ∈ ({1}ᶜ : Set ℂ) by norm_num))


/-- The classical local logarithmic derivative formula, with zero multiplicity
obtained from analytic factorization rather than assumed to be one. -/
theorem analytic_logDerivative_principal_part {f : ℂ → ℂ} {ρ : ℂ}
    (hf : AnalyticAt ℂ f ρ) (hn : ¬ ∀ᶠ z in 𝓝 ρ, f z = 0)
    (hzero : f ρ = 0) :
    ∃ m : ℕ, 0 < m ∧ ∃ a : ℂ → ℂ, AnalyticAt ℂ a ρ ∧
      ∀ᶠ z in 𝓝[≠] ρ, deriv f z / f z = (m : ℂ) / (z - ρ) + a z := by
  obtain ⟨m, g, hg, hg0, he⟩ := hf.exists_eventuallyEq_pow_smul_nonzero_iff.mpr hn
  have hm : m ≠ 0 := by
    intro hm
    have hh := he.self_of_nhds
    rw [hm, pow_zero, one_smul, hzero] at hh
    exact hg0 hh.symm
  have he' : f =ᶠ[𝓝 ρ] (fun z => (z - ρ) ^ m * g z) := by
    simpa only [smul_eq_mul] using he
  refine ⟨m, Nat.pos_of_ne_zero hm, fun z => deriv g z / g z, hg.deriv.div hg hg0, ?_⟩
  filter_upwards [he'.filter_mono nhdsWithin_le_nhds,
    he'.deriv.filter_mono nhdsWithin_le_nhds,
    hg.eventually_analyticAt.filter_mono nhdsWithin_le_nhds,
    hg.continuousAt.eventually_ne hg0 |>.filter_mono nhdsWithin_le_nhds,
    self_mem_nhdsWithin] with z hval hderiv hgz hgnz hz
  rw [hval, hderiv]
  change logDeriv (fun w => (w - ρ) ^ m * g w) z = _
  rw [logDeriv_mul (f := fun w : ℂ => (w - ρ) ^ m) (g := g) z
    (pow_ne_zero m (sub_ne_zero.mpr hz)) hgnz
    (by fun_prop) hgz.differentiableAt,
    logDeriv_fun_pow (f := fun w : ℂ => w - ρ) (by fun_prop) m]
  have ht : logDeriv (fun w : ℂ => w - ρ) z = 1 / (z - ρ) := by
    have hd : deriv (fun w : ℂ => w - ρ) z = 1 := by
      simp
    rw [logDeriv_apply, hd]
  rw [ht, mul_one_div, logDeriv_apply]

/-- The continued joint Mellin expression retains a simple pole at every zeta
zero away from 0 and 1, including zeros of arbitrary positive multiplicity.
This statement concerns the displayed expression. It does not assert Mellin
integral convergence near the zero or that such a zero is off the line. -/
theorem zeta_jointMellin_principal_part {ρ : ℂ} (hρ0 : ρ ≠ 0) (hρ1 : ρ ≠ 1)
    (hzero : riemannZeta ρ = 0) :
    ∃ m : ℕ, 0 < m ∧ ∃ a : ℂ → ℂ, AnalyticAt ℂ a ρ ∧
      (∀ᶠ s in 𝓝[≠] ρ,
        -deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
          (2 * (Real.eulerMascheroniConstant : ℂ)) / s =
        (-(m : ℂ) / ρ) / (s - ρ) + a s) ∧
      Tendsto (fun s : ℂ => (s - ρ) *
        (-deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
          (2 * (Real.eulerMascheroniConstant : ℂ)) / s))
        (𝓝[≠] ρ) (𝓝 (-(m : ℂ) / ρ)) ∧ -(m : ℂ) / ρ ≠ 0 := by
  obtain ⟨m, hm, b, hb, he⟩ := analytic_logDerivative_principal_part
    (zeta_analytic_off_pole ρ hρ1) (zeta_not_locally_zero hρ1) hzero
  let a : ℂ → ℂ := fun s => (m : ℂ) / (ρ * s) - b s / s - 1 / (s - 1) +
    (2 * (Real.eulerMascheroniConstant : ℂ)) / s
  have ha : AnalyticAt ℂ a ρ :=
    (((analyticAt_const.div (analyticAt_const.mul analyticAt_id) (mul_ne_zero hρ0 hρ0)).sub
      (hb.div analyticAt_id hρ0)).sub
      (analyticAt_const.div (analyticAt_id.sub analyticAt_const) (sub_ne_zero.mpr hρ1))).add
      (analyticAt_const.div analyticAt_id hρ0)
  have hform : ∀ᶠ s in 𝓝[≠] ρ,
      -deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
        (2 * (Real.eulerMascheroniConstant : ℂ)) / s =
      (-(m : ℂ) / ρ) / (s - ρ) + a s := by
    filter_upwards [he, (continuousAt_id.eventually_ne hρ0).filter_mono nhdsWithin_le_nhds,
      self_mem_nhdsWithin] with s hs hs0 hsρ
    change s ≠ 0 at hs0
    have hz : -deriv riemannZeta s / (s * riemannZeta s) =
        -(deriv riemannZeta s / riemannZeta s) / s := by
      ring
    rw [hz, hs]
    dsimp only [a]
    field_simp [hρ0, hs0, sub_ne_zero.mpr hsρ]
    ring
  refine ⟨m, hm, a, ha, hform, ?_, div_ne_zero (neg_ne_zero.mpr ?_) hρ0⟩
  · have hlim : Tendsto (fun s : ℂ => -(m : ℂ) / ρ + (s - ρ) * a s)
        (𝓝[≠] ρ) (𝓝 (-(m : ℂ) / ρ)) := by
      have hc : ContinuousAt (fun s : ℂ => -(m : ℂ) / ρ + (s - ρ) * a s) ρ :=
        continuousAt_const.add ((continuousAt_id.sub continuousAt_const).mul ha.continuousAt)
      simpa using hc.tendsto.mono_left nhdsWithin_le_nhds
    apply hlim.congr'
    filter_upwards [hform, self_mem_nhdsWithin] with s hs hsρ
    rw [hs]
    field_simp [sub_ne_zero.mpr hsρ]
  · exact_mod_cast Nat.ne_of_gt hm


end BuildingBlocks
