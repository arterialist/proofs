import Mathlib.Analysis.Meromorphic.TrailingCoefficient
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.Analysis.Calculus.FDeriv.Analytic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import BuildingBlocks.LogDerivative
import BuildingBlocks.ShiftedZetaMultiplier

open Filter
open scoped Topology

namespace BuildingBlocks.LogDerivativePole

theorem analyticAt_logDeriv {u : ℂ → ℂ} {ρ : ℂ}
    (hu : AnalyticAt ℂ u ρ) (hu0 : u ρ ≠ 0) : AnalyticAt ℂ (logDeriv u) ρ := by
  exact hu.deriv.div hu hu0

/-- A local analytic unit factorization identifies the logarithmic residue,
including arbitrary positive multiplicities. -/
theorem logDeriv_of_factorization {f u : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hu : AnalyticAt ℂ u ρ) (hu0 : u ρ ≠ 0)
    (hfactor : f =ᶠ[𝓝 ρ] fun z => (z - ρ) ^ m * u z) :
    logDeriv f =ᶠ[𝓝[≠] ρ] fun z => (m : ℂ) / (z - ρ) + logDeriv u z := by
  filter_upwards [nhdsWithin_le_nhds hfactor, nhdsWithin_le_nhds hfactor.deriv,
    nhdsWithin_le_nhds hu.eventually_analyticAt,
    nhdsWithin_le_nhds (hu.continuousAt.eventually_ne hu0), self_mem_nhdsWithin]
    with z hfz hdfz huz huz0 hz
  have hz0 : z - ρ ≠ 0 := sub_ne_zero.mpr hz
  have heq : logDeriv f z = logDeriv (fun w => (w - ρ) ^ m * u w) z := by
    simp only [logDeriv_apply]
    rw [hfz, hdfz]
  rw [heq, logDeriv_mul (f := fun w : ℂ => (w - ρ) ^ m) (g := u) z
    (pow_ne_zero m hz0) huz0 (by fun_prop) huz.differentiableAt]
  have hp : logDeriv (fun w : ℂ => (w - ρ) ^ m) z = (m : ℂ) / (z - ρ) := by
    rw [logDeriv_fun_pow (by fun_prop)]
    simp [logDeriv_apply, div_eq_mul_inv]
  rw [hp]

/-- Squaring a nonzero simple principal part and subtracting an analytic
function leaves a double pole. The analytic multiplier preserves its order. -/
theorem double_pole_persistence {G R H Q : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hm : 1 ≤ m) (hR : AnalyticAt ℂ R ρ) (hH : AnalyticAt ℂ H ρ)
    (hQ : AnalyticAt ℂ Q ρ) (hQ0 : Q ρ ≠ 0)
    (hG : G =ᶠ[𝓝[≠] ρ] fun z => -(m : ℂ) / (z - ρ) + R z) :
    meromorphicOrderAt (fun z => Q z * (G z ^ 2 - H z)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun z => Q z * (G z ^ 2 - H z)) ρ = Q ρ * (m : ℂ) ^ 2 := by
  let K : ℂ → ℂ := fun z => Q z *
    ((-(m : ℂ) + (z - ρ) * R z) ^ 2 - (z - ρ) ^ 2 * H z)
  have hK : AnalyticAt ℂ K ρ := by
    dsimp [K]
    fun_prop
  have hKval : K ρ = Q ρ * (m : ℂ) ^ 2 := by simp [K]
  have hm0 : (m : ℂ) ≠ 0 := by exact_mod_cast (show m ≠ 0 by omega)
  have hK0 : K ρ ≠ 0 := by rw [hKval]; exact mul_ne_zero hQ0 (pow_ne_zero 2 hm0)
  have heq : (fun z => Q z * (G z ^ 2 - H z)) =ᶠ[𝓝[≠] ρ]
      fun z => (z - ρ) ^ (-2 : ℤ) • K z := by
    filter_upwards [hG, self_mem_nhdsWithin] with z hgz hz
    have hz0 : z - ρ ≠ 0 := sub_ne_zero.mpr hz
    rw [hgz]
    simp only [K, smul_eq_mul, zpow_neg, zpow_ofNat]
    field_simp
  have hmer : MeromorphicAt (fun z => Q z * (G z ^ 2 - H z)) ρ := by
    apply (MeromorphicAt.meromorphicAt_congr heq).2
    exact ((analyticAt_id.sub analyticAt_const).meromorphicAt.fun_zpow (-2)).fun_smul
      hK.meromorphicAt
  constructor
  · exact (meromorphicOrderAt_eq_int_iff hmer).2 ⟨K, hK, hK0, heq⟩
  · rw [hK.meromorphicTrailingCoeffAt_of_ne_zero_of_eq_nhdsNE hK0 heq, hKval]

/-- The exact analytic-order hypothesis supplies the local unit automatically.
No conclusion about the order of any particular zeta zero is assumed here. -/
theorem logDeriv_square_sub_pole {f J H Q : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hf : AnalyticAt ℂ f ρ) (horder : analyticOrderAt f ρ = m) (hm : 1 ≤ m)
    (hJ : AnalyticAt ℂ J ρ) (hH : AnalyticAt ℂ H ρ)
    (hQ : AnalyticAt ℂ Q ρ) (hQ0 : Q ρ ≠ 0) :
    meromorphicOrderAt (fun z => Q z * ((-logDeriv f z - J z) ^ 2 - H z)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun z => Q z * ((-logDeriv f z - J z) ^ 2 - H z)) ρ =
        Q ρ * (m : ℂ) ^ 2 := by
  obtain ⟨u, hu, hu0, heq⟩ := hf.analyticOrderAt_eq_natCast.mp horder
  simp only [smul_eq_mul] at heq
  have hlog := logDeriv_of_factorization hu hu0 heq
  apply double_pole_persistence (R := fun z => -logDeriv u z - J z) hm
    ((analyticAt_logDeriv hu hu0).neg.sub hJ) hH hQ hQ0
  filter_upwards [hlog] with z hz
  rw [hz]
  ring

/-- Every actual zeta zero away from its pole has a finite positive analytic
order. Non-local vanishing is supplied by the existing zeta identity theorem. -/
theorem zeta_zero_finite_order {ρ : ℂ} (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m := by
  have hf := zeta_analytic_off_pole ρ hρ
  have hfinite : analyticOrderAt riemannZeta ρ ≠ ⊤ := by
    intro htop
    exact zeta_not_locally_zero hρ (analyticOrderAt_eq_top.mp htop)
  obtain ⟨m, hm⟩ := ENat.ne_top_iff_exists.mp hfinite
  have hm0 : m ≠ 0 := by
    intro hzero
    apply hf.analyticOrderAt_ne_zero.mpr hz
    simpa [hzero] using hm.symm
  exact ⟨m, by omega, hm.symm⟩

noncomputable def centeredZetaLogDerivative (s : ℂ) : ℂ :=
  -logDeriv riemannZeta s - s / (s - 1)

/-- At every actual zeta zero to the right of the critical line, the shifted
zeta multiplier preserves a nonzero double pole after any analytic subtraction.
The theorem does not assert that such a zero exists or assume RH. -/
theorem actual_zeta_zero_double_pole {ρ : ℂ} {H : ℂ → ℂ}
    (hρre : (1 : ℝ) / 2 < ρ.re) (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0)
    (hH : AnalyticAt ℂ H ρ) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      meromorphicOrderAt (fun s => ShiftedZetaMultiplier.M s *
        (centeredZetaLogDerivative s ^ 2 - H s)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun s => ShiftedZetaMultiplier.M s *
        (centeredZetaLogDerivative s ^ 2 - H s)) ρ =
          ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ∧
      ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ≠ 0 := by
  obtain ⟨m, hm, horder⟩ := zeta_zero_finite_order hρ hz
  have hJ : AnalyticAt ℂ (fun s : ℂ => s / (s - 1)) ρ :=
    analyticAt_id.div (analyticAt_id.sub analyticAt_const) (sub_ne_zero.mpr hρ)
  have hpole := logDeriv_square_sub_pole (zeta_analytic_off_pole ρ hρ) horder hm hJ hH
    (ShiftedZetaMultiplier.analyticAt_M hρre) (ShiftedZetaMultiplier.M_ne_zero hρre)
  exact ⟨m, hm, horder, hpole.1, hpole.2,
    ShiftedZetaMultiplier.multiplicity_coefficient_ne_zero hρre hm⟩

end BuildingBlocks.LogDerivativePole
