import BuildingBlocks.LocalAnalytic
import Mathlib.Analysis.Complex.CauchyIntegral
import Mathlib.Analysis.NormedSpace.Connected

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

def rightDomain : Set ℂ := {s | (1 : ℝ) / 2 < s.re ∧ s ≠ 1}

theorem rightDomain_isOpen : IsOpen rightDomain :=
  (isOpen_lt continuous_const Complex.continuous_re).inter isOpen_compl_singleton

/-- Explicitly RH-equivalent. This proposition is not asserted as an axiom. -/
def HolomorphicZetaODE : Prop :=
  ∃ a : ℂ → ℂ, AnalyticOnNhd ℂ a rightDomain ∧
    ∀ s ∈ rightDomain, deriv riemannZeta s = a s * riemannZeta s

theorem target_of_holomorphicZetaODE (h : HolomorphicZetaODE) : Target := by
  apply target_iff_rightHalfZeroFree.mpr
  obtain ⟨a, ha, ho⟩ := h
  intro s hsr hs
  apply analytic_nonzero_of_deriv_eq_mul (zeta_analytic_off_pole s hs) (ha s ⟨hsr, hs⟩)
    (zeta_not_locally_zero hs)
  filter_upwards [rightDomain_isOpen.mem_nhds (show s ∈ rightDomain from ⟨hsr, hs⟩)] with z hz
  exact ho z hz

theorem target_iff_holomorphicZetaODE : Target ↔ HolomorphicZetaODE := by
  refine ⟨?_, target_of_holomorphicZetaODE⟩
  intro ht
  have hf := target_iff_rightHalfZeroFree.mp ht
  refine ⟨fun s => deriv riemannZeta s / riemannZeta s, ?_, ?_⟩
  · intro s hs
    exact (zeta_analytic_off_pole s hs.2).deriv.div
      (zeta_analytic_off_pole s hs.2) (hf s hs.1 hs.2)
  · intro s hs
    exact (div_mul_cancel₀ _ (hf s hs.1 hs.2)).symm

end BuildingBlocks
