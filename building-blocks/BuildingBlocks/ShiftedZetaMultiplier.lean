import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.Analysis.Complex.CauchyIntegral
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

open Filter
open scoped Topology

namespace BuildingBlocks.ShiftedZetaMultiplier

/-- The full open half-plane needed by the critical all-multiples transform. -/
def domain : Set ℂ := {s | (1 : ℝ) / 2 < s.re}

/-- The actual shifted zeta multiplier, with both Mellin denominator factors retained. -/
noncomputable def M (s : ℂ) : ℂ := riemannZeta (s + 1 / 2) / (s * (s + 1))

theorem domain_isOpen : IsOpen domain :=
  isOpen_lt continuous_const Complex.continuous_re

theorem shifted_re_gt_one {s : ℂ} (hs : s ∈ domain) :
    1 < (s + 1 / 2).re := by
  change (1 : ℝ) / 2 < s.re at hs
  norm_num [Complex.add_re]
  linarith

theorem shifted_ne_one {s : ℂ} (hs : s ∈ domain) : s + 1 / 2 ≠ 1 := by
  intro heq
  have h := shifted_re_gt_one hs
  rw [heq] at h
  norm_num at h

theorem argument_ne_zero {s : ℂ} (hs : s ∈ domain) : s ≠ 0 := by
  intro heq
  subst s
  norm_num [domain] at hs

theorem argument_add_one_ne_zero {s : ℂ} (hs : s ∈ domain) : s + 1 ≠ 0 := by
  intro heq
  have h := congrArg Complex.re heq
  simp only [Complex.add_re, Complex.one_re, Complex.zero_re] at h
  change (1 : ℝ) / 2 < s.re at hs
  linarith

theorem denominator_ne_zero {s : ℂ} (hs : s ∈ domain) : s * (s + 1) ≠ 0 :=
  mul_ne_zero (argument_ne_zero hs) (argument_add_one_ne_zero hs)

/-- This uses mathlib's actual zeta nonvanishing theorem on `re z > 1`. -/
theorem M_ne_zero {s : ℂ} (hs : s ∈ domain) : M s ≠ 0 := by
  exact div_ne_zero (riemannZeta_ne_zero_of_one_lt_re (shifted_re_gt_one hs))
    (denominator_ne_zero hs)

theorem differentiableAt_M {s : ℂ} (hs : s ∈ domain) : DifferentiableAt ℂ M s := by
  unfold M
  apply DifferentiableAt.div
  · exact (differentiableAt_riemannZeta (shifted_ne_one hs)).comp s
      (differentiableAt_id.add_const (1 / 2 : ℂ))
  · exact differentiableAt_id.mul (differentiableAt_id.add_const (1 : ℂ))
  · exact denominator_ne_zero hs

theorem differentiableOn_M : DifferentiableOn ℂ M domain :=
  fun _ hs => (differentiableAt_M hs).differentiableWithinAt

theorem analyticOnNhd_M : AnalyticOnNhd ℂ M domain :=
  differentiableOn_M.analyticOnNhd domain_isOpen

theorem analyticAt_M {s : ℂ} (hs : s ∈ domain) : AnalyticAt ℂ M s :=
  analyticOnNhd_M s hs

/-- Exact local interface for multiplication of a logarithmic-derivative pole. -/
theorem local_nonzero_factor {ρ : ℂ} (hρ : ρ ∈ domain) :
    AnalyticAt ℂ M ρ ∧ M ρ ≠ 0 :=
  ⟨analyticAt_M hρ, M_ne_zero hρ⟩

theorem eventually_M_ne_zero {ρ : ℂ} (hρ : ρ ∈ domain) :
    ∀ᶠ s in 𝓝 ρ, M s ≠ 0 := by
  filter_upwards [domain_isOpen.mem_nhds hρ] with s hs
  exact M_ne_zero hs

/-- Every positive zero multiplicity produces a nonzero scaled double-pole coefficient. -/
theorem multiplicity_coefficient_ne_zero {ρ : ℂ} (hρ : ρ ∈ domain)
    {m : ℕ} (hm : 1 ≤ m) : M ρ * (m : ℂ) ^ 2 ≠ 0 := by
  have hm0 : m ≠ 0 := by omega
  exact mul_ne_zero (M_ne_zero hρ) (pow_ne_zero _ (by exact_mod_cast hm0))

end BuildingBlocks.ShiftedZetaMultiplier
