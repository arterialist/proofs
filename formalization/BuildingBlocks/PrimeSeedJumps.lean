import BuildingBlocks.PrimeSeedDelay
import Mathlib.Topology.Order.OrderClosed

/-! Actual one-sided limits and signed prime-power jumps of the floor-defined
seed. These are prerequisites for its variation measure. -/

open Real Set Filter
open scoped Topology

namespace BuildingBlocks.PrimeSeedMass

theorem seed_clock_value {L : ℝ} (hL : 0 < L) (j : ℕ) :
    seed L ((j + 1 : ℝ) * L) = exp (-((j + 3 : ℝ) * L) / 2) := by
  rw [seed_eq_cellDensity hL j (by constructor <;> nlinarith)]
  unfold cellDensity
  congr 1
  ring

theorem seed_clock_right_limit {L : ℝ} (hL : 0 < L) (j : ℕ) :
    Tendsto (seed L) (𝓝[≥] ((j + 1 : ℝ) * L)) (𝓝 (exp (-((j + 3 : ℝ) * L) / 2))) := by
  have hc : Continuous (cellDensity L j) := by unfold cellDensity; fun_prop
  have he : ∀ᶠ v in 𝓝[≥] ((j + 1 : ℝ) * L), seed L v = cellDensity L j v := by
    filter_upwards [Ico_mem_nhdsGE (show (j + 1 : ℝ) * L < (j + 2 : ℝ) * L by nlinarith)] with v hv
    exact seed_eq_cellDensity hL j hv
  have ht := (hc.tendsto ((j + 1 : ℝ) * L)).mono_left (nhdsWithin_le_nhds (s := Ici ((j + 1 : ℝ) * L)))
  have hv : cellDensity L j ((j + 1 : ℝ) * L) = exp (-((j + 3 : ℝ) * L) / 2) := by
    unfold cellDensity
    congr 1
    ring
  rw [hv] at ht
  exact ht.congr' (Filter.Eventually.mono he (fun _ h => h.symm))

theorem seed_birth_left_limit (L : ℝ) :
    Tendsto (seed L) (𝓝[<] L) (𝓝 0) := by
  apply tendsto_const_nhds.congr'
  filter_upwards [self_mem_nhdsWithin] with v hv
  exact (seed_eq_zero hv).symm

theorem seed_power_left_limit {L : ℝ} (hL : 0 < L) (j : ℕ) :
    Tendsto (seed L) (𝓝[<] ((j + 2 : ℝ) * L)) (𝓝 (exp (-((j + 2 : ℝ) * L) / 2))) := by
  have hc : Continuous (cellDensity L j) := by unfold cellDensity; fun_prop
  have he : ∀ᶠ v in 𝓝[<] ((j + 2 : ℝ) * L), seed L v = cellDensity L j v := by
    filter_upwards [Ico_mem_nhdsLT (show (j + 1 : ℝ) * L < (j + 2 : ℝ) * L by nlinarith)] with v hv
    exact seed_eq_cellDensity hL j hv
  have ht := (hc.tendsto ((j + 2 : ℝ) * L)).mono_left (nhdsWithin_le_nhds (s := Iio ((j + 2 : ℝ) * L)))
  have hv : cellDensity L j ((j + 2 : ℝ) * L) = exp (-((j + 2 : ℝ) * L) / 2) := by
    unfold cellDensity
    congr 1
    ring
  rw [hv] at ht
  exact ht.congr' (Filter.Eventually.mono he (fun _ h => h.symm))

/-- Every proper-power jump is negative, with its full literal amplitude. -/
theorem seed_power_jump {L : ℝ} (hL : 0 < L) (j : ℕ) :
    seed L ((j + 2 : ℝ) * L) - exp (-((j + 2 : ℝ) * L) / 2) =
      -(1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) := by
  have hv : seed L ((j + 2 : ℝ) * L) = exp (-((j + 4 : ℝ) * L) / 2) := by
    convert seed_clock_value hL (j + 1) using 1 <;> push_cast <;> congr 1 <;> ring
  rw [hv, show -((j + 4 : ℝ) * L) / 2 = -L + -((j + 2 : ℝ) * L) / 2 by ring, exp_add]
  ring

theorem seed_power_jump_neg {L : ℝ} (hL : 0 < L) (j : ℕ) :
    seed L ((j + 2 : ℝ) * L) - exp (-((j + 2 : ℝ) * L) / 2) < 0 := by
  rw [seed_power_jump hL j]
  have he : exp (-L) < 1 := exp_lt_one_iff.2 (neg_neg_of_pos hL)
  exact mul_neg_of_neg_of_pos (neg_neg_of_pos (sub_pos.2 he)) (exp_pos _)

theorem seed_hasDerivAt_in_cell {L v : ℝ} (hL : 0 < L) (j : ℕ)
    (hv : v ∈ Ioo ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) :
    HasDerivAt (seed L) (seed L v / 2) v := by
  have hd : HasDerivAt (cellDensity L j) (cellDensity L j v / 2) v := by
    unfold cellDensity
    convert (((hasDerivAt_id v).div_const 2).sub_const ((j + 2 : ℝ) * L)).exp using 1 <;> simp <;> ring
  have he : seed L =ᶠ[𝓝 v] cellDensity L j := by
    filter_upwards [Ioo_mem_nhds hv.1 hv.2] with w hw
    exact seed_eq_cellDensity hL j ⟨hw.1.le, hw.2⟩
  rw [seed_eq_cellDensity hL j ⟨hv.1.le, hv.2⟩]
  exact hd.congr_of_eventuallyEq he

/-- The sum of every downward jump amplitude, with no power cutoff. -/
theorem hasSum_seed_negative_jumps {L : ℝ} (hL : 0 < L) :
    HasSum (fun j : ℕ => (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2))
      (exp (-L) + exp (-3 * L / 2)) := by
  let r := exp (-L / 2)
  have hr0 : 0 < r := exp_pos _
  have hr1 : r < 1 := by dsimp [r]; exact exp_lt_one_iff.mpr (by linarith)
  have he (j : ℕ) : exp (-((j + 2 : ℝ) * L) / 2) = r ^ (j + 2) := by
    dsimp [r]
    rw [← exp_nat_mul]
    congr 1
    push_cast
    ring
  have hsq : r ^ 2 = exp (-L) := by
    dsimp [r]
    rw [← exp_nat_mul]
    congr 1
    push_cast
    ring
  have hcube : r ^ 3 = exp (-3 * L / 2) := by
    dsimp [r]
    rw [← exp_nat_mul]
    congr 1
    push_cast
    ring
  have hs := (hasSum_geometric_of_lt_one hr0.le hr1).mul_left ((1 - r ^ 2) * r ^ 2)
  convert hs using 1
  · funext j
    rw [he, pow_add, ← hsq]
    ring
  · rw [← hsq, ← hcube]
    field_simp [ne_of_gt (sub_pos.mpr hr1)]
    ring

/-- The absolutely summed continuous and jump contributions cancel exactly.
This statement records their masses, before identifying a distributional derivative. -/
theorem seed_derivative_mass_balance {L : ℝ} (hL : 0 < L) :
    (1 / 2) * (∫ v, seed L v) + exp (-3 * L / 2) -
      (∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) = 0 := by
  rw [(integrable_seed_and_integral hL).2, (hasSum_seed_negative_jumps hL).tsum_eq]
  ring

theorem seed_derivative_variation_budget {L : ℝ} (hL : 0 < L) :
    (1 / 2) * (∫ v, seed L v) + exp (-3 * L / 2) +
      (∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) =
        2 * exp (-L) + 2 * exp (-3 * L / 2) := by
  rw [(integrable_seed_and_integral hL).2, (hasSum_seed_negative_jumps hL).tsum_eq]
  ring

end BuildingBlocks.PrimeSeedMass
