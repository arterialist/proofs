import BuildingBlocks.Scope
import Mathlib.Analysis.Analytic.IsolatedZeros

open Filter
open scoped Topology

namespace BuildingBlocks

/-- A nontrivial analytic solution of f' = a f cannot vanish where the
coefficient a is analytic. No assumption about simple zeros is made. -/
theorem analytic_nonzero_of_deriv_eq_mul {f a : ℂ → ℂ} {z₀ : ℂ}
    (hf : AnalyticAt ℂ f z₀) (ha : AnalyticAt ℂ a z₀)
    (hn : ¬ ∀ᶠ z in 𝓝 z₀, f z = 0)
    (hode : ∀ᶠ z in 𝓝 z₀, deriv f z = a z * f z) :
    f z₀ ≠ 0 := by
  intro hz
  obtain ⟨m, g, hg, hg0, hfac⟩ := hf.exists_eventuallyEq_pow_smul_nonzero_iff.mpr hn
  have hm : m ≠ 0 := by
    intro hm
    have hh := hfac.self_of_nhds
    rw [hm, pow_zero, one_smul, hz] at hh
    exact hg0 hh.symm
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hm
  have heq : f =ᶠ[𝓝 z₀] (fun z => (z - z₀) ^ (n + 1) * g z) := by
    simpa only [smul_eq_mul] using hfac
  let q : ℂ → ℂ := fun z =>
    (n + 1 : ℂ) * g z + (z - z₀) * deriv g z - a z * (z - z₀) * g z
  have hqa : AnalyticAt ℂ q z₀ :=
    ((analyticAt_const.mul hg).add
      ((analyticAt_id.sub analyticAt_const).mul hg.deriv)).sub
        ((ha.mul (analyticAt_id.sub analyticAt_const)).mul hg)
  have hq : ∀ᶠ z in 𝓝[≠] z₀, q z = 0 := by
    filter_upwards [heq.filter_mono nhdsWithin_le_nhds,
      heq.deriv.filter_mono nhdsWithin_le_nhds,
      hode.filter_mono nhdsWithin_le_nhds,
      hg.eventually_analyticAt.filter_mono nhdsWithin_le_nhds,
      self_mem_nhdsWithin] with z he he' ho hgz hzne
    have hd := (((hasDerivAt_id z).sub_const z₀).pow (n + 1)).mul
      hgz.differentiableAt.hasDerivAt
    have hmain : (n + 1 : ℂ) * (z - z₀) ^ n * g z +
        (z - z₀) ^ (n + 1) * deriv g z =
        a z * ((z - z₀) ^ (n + 1) * g z) := by
      calc
        _ = deriv (fun w => (w - z₀) ^ (n + 1) * g w) z := by
          simpa using hd.deriv.symm
        _ = deriv f z := he'.symm
        _ = a z * ((z - z₀) ^ (n + 1) * g z) := by rw [ho, he]
    have hprod : (z - z₀) ^ n * q z = 0 := by
      dsimp [q]
      rw [pow_succ] at hmain
      linear_combination hmain
    exact (mul_eq_zero.mp hprod).resolve_left
      (pow_ne_zero n (sub_ne_zero.mpr hzne))
  have hq0 := (hqa.frequently_zero_iff_eventually_zero.mp hq.frequently).self_of_nhds
  have hng : (n + 1 : ℂ) * g z₀ = 0 := by simpa [q] using hq0
  exact (mul_ne_zero (by exact_mod_cast Nat.succ_ne_zero n) hg0) hng

end BuildingBlocks
