import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-! Exact masses of all prime-clock intervals of the positive successor seed.

For `L = log p`, the `j`th interval is `[(j+1)L,(j+2)L]` and its
density is `exp (v/2) p^(-(j+2))`. Endpoints do not affect the integral.
The sums below retain every interval, including all proper-power histories.
-/

open MeasureTheory Real
open scoped Interval

namespace BuildingBlocks.PrimeSeedMass

/-- The causal positive seed, with every prime-power interval retained.
For a prime `p`, substitute `L = log p`. -/
noncomputable def seed (L v : ℝ) : ℝ :=
  if L ≤ v then exp (v / 2 - (⌊v / L⌋₊ + 1 : ℝ) * L) else 0

/-- The density of the actual seed on its `j`th clock interval. -/
noncomputable def cellDensity (L : ℝ) (j : ℕ) (v : ℝ) : ℝ :=
  exp (v / 2 - (j + 2 : ℝ) * L)

theorem cellDensity_pos (L : ℝ) (j : ℕ) (v : ℝ) :
    0 < cellDensity L j v := exp_pos _

theorem seed_nonneg (L v : ℝ) : 0 ≤ seed L v := by
  unfold seed
  split_ifs <;> positivity

theorem seed_eq_zero {L v : ℝ} (hv : v < L) : seed L v = 0 := by
  simp [seed, not_le.mpr hv]

/-- Exact identification with the literal floor-defined seed. -/
theorem seed_eq_cellDensity {L v : ℝ} (hL : 0 < L) (j : ℕ)
    (hv : v ∈ Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) :
    seed L v = cellDensity L j v := by
  have hvL : L ≤ v := by
    have hj : (0 : ℝ) ≤ j := Nat.cast_nonneg j
    nlinarith [hv.1]
  have hfloor : ⌊v / L⌋₊ = j + 1 := by
    apply Nat.floor_eq_on_Ico
    constructor
    · rw [le_div_iff₀ hL]
      simpa only [Nat.cast_add, Nat.cast_one] using hv.1
    · rw [div_lt_iff₀ hL]
      convert hv.2 using 1
      push_cast
      ring
  simp only [seed, if_pos hvL, hfloor, cellDensity]
  congr 1
  push_cast
  ring

private theorem integral_exp_half_sub (a b c : ℝ) :
    (∫ v in a..b, exp (v / 2 - c)) =
      2 * exp (b / 2 - c) - 2 * exp (a / 2 - c) := by
  apply intervalIntegral.integral_eq_sub_of_hasDerivAt
  · intro v _
    convert ((((hasDerivAt_id v).div_const 2).sub_const c).exp.const_mul 2) using 1
    norm_num
    ring
  · exact (continuous_exp.comp ((continuous_id.div_const 2).sub continuous_const)).intervalIntegrable _ _

/-- Exact unweighted mass of one complete prime-clock interval. -/
theorem cell_integral (L : ℝ) (j : ℕ) :
    (∫ v in ((j + 1 : ℝ) * L)..((j + 2 : ℝ) * L), cellDensity L j v) =
      2 * (1 - exp (-L / 2)) * exp (-L / 2) ^ (j + 2) := by
  simp only [cellDensity]
  rw [integral_exp_half_sub]
  have h₁ : (j + 2 : ℝ) * L / 2 - (j + 2 : ℝ) * L =
      (j + 2 : ℕ) * (-L / 2) := by push_cast; ring
  have h₂ : (j + 1 : ℝ) * L / 2 - (j + 2 : ℝ) * L =
      (j + 3 : ℕ) * (-L / 2) := by push_cast; ring
  rw [h₁, h₂, exp_nat_mul, exp_nat_mul]
  rw [show j + 3 = (j + 2) + 1 by omega, pow_succ]
  ring

/-- The half-weight removes the growing exponential on each interval. -/
theorem weighted_cell_integral (L : ℝ) (j : ℕ) :
    (∫ v in ((j + 1 : ℝ) * L)..((j + 2 : ℝ) * L),
      exp (-v / 2) * cellDensity L j v) = L * exp (-L) ^ (j + 2) := by
  have heq : (fun v => exp (-v / 2) * cellDensity L j v) =
      (fun _ : ℝ => exp ((j + 2 : ℕ) * (-L))) := by
    funext v
    rw [cellDensity, ← exp_add]
    congr 1
    push_cast
    ring
  rw [heq, intervalIntegral.integral_const, smul_eq_mul, exp_nat_mul]
  ring

/-- All unweighted interval masses sum to `2 exp(-L)`. -/
theorem hasSum_cell_integrals {L : ℝ} (hL : 0 < L) :
    HasSum (fun j : ℕ =>
      ∫ v in ((j + 1 : ℝ) * L)..((j + 2 : ℝ) * L), cellDensity L j v)
      (2 * exp (-L)) := by
  let r := exp (-L / 2)
  have hr0 : 0 < r := exp_pos _
  have hr1 : r < 1 := by dsimp [r]; exact exp_lt_one_iff.mpr (by linarith)
  have hs := (hasSum_geometric_of_lt_one hr0.le hr1).mul_left (2 * (1 - r) * r ^ 2)
  have hsq : r ^ 2 = exp (-L) := by
    dsimp [r]
    rw [← exp_nat_mul]
    congr 1
    push_cast
    ring
  convert hs using 1
  · funext j
    rw [cell_integral, pow_add]
    dsimp [r]
    ring
  · rw [← hsq]
    field_simp [ne_of_gt (sub_pos.mpr hr1)]

/-- All half-weighted interval masses, with the full geometric tail. -/
theorem hasSum_weighted_cell_integrals {L : ℝ} (hL : 0 < L) :
    HasSum (fun j : ℕ =>
      ∫ v in ((j + 1 : ℝ) * L)..((j + 2 : ℝ) * L),
        exp (-v / 2) * cellDensity L j v)
      (L * exp (-L) ^ 2 / (1 - exp (-L))) := by
  have hr0 : 0 ≤ exp (-L) := (exp_pos _).le
  have hr1 : exp (-L) < 1 := exp_lt_one_iff.mpr (by linarith)
  have hs := (hasSum_geometric_of_lt_one hr0 hr1).mul_left (L * exp (-L) ^ 2)
  convert hs using 1
  · funext j
    rw [weighted_cell_integral, pow_add]
    ring

/-- The unweighted normalization at the actual prime clock is `2/p`.
Primality is unnecessary for this single-clock identity. -/
theorem hasSum_prime_cell_integrals {p : ℝ} (hp : 1 < p) :
    HasSum (fun j : ℕ =>
      ∫ v in ((j + 1 : ℝ) * log p)..((j + 2 : ℝ) * log p),
        cellDensity (log p) j v) (2 / p) := by
  convert hasSum_cell_integrals (log_pos hp) using 1
  rw [exp_neg, exp_log (by linarith : 0 < p)]
  ring

/-- Exact half-weighted normalization of all actual prime-clock intervals. -/
theorem hasSum_prime_weighted_cell_integrals {p : ℝ} (hp : 1 < p) :
    HasSum (fun j : ℕ =>
      ∫ v in ((j + 1 : ℝ) * log p)..((j + 2 : ℝ) * log p),
        exp (-v / 2) * cellDensity (log p) j v)
      (log p / (p * (p - 1))) := by
  convert hasSum_weighted_cell_integrals (log_pos hp) using 1
  rw [exp_neg, exp_log (by linarith : 0 < p)]
  field_simp

/-- The prime-clock cells partition the whole causal support. -/
theorem iUnion_cells {L : ℝ} (hL : 0 < L) :
    (⋃ j : ℕ, Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) = Set.Ici L := by
  ext v
  simp only [Set.mem_iUnion, Set.mem_Ico, Set.mem_Ici]
  constructor
  · rintro ⟨j, hj, _⟩
    have : (0 : ℝ) ≤ j := Nat.cast_nonneg j
    nlinarith
  · intro hv
    have hv' : 0 ≤ v / L - 1 := by
      have : 1 ≤ v / L := (le_div_iff₀ hL).2 (by simpa using hv)
      linarith
    refine ⟨⌊v / L - 1⌋₊, ?_, ?_⟩
    · have h := Nat.floor_le hv'
      have : (⌊v / L - 1⌋₊ : ℝ) + 1 ≤ v / L := by linarith
      exact (le_div_iff₀ hL).1 this
    · have h := Nat.lt_floor_add_one (v / L - 1)
      have : v / L < (⌊v / L - 1⌋₊ : ℝ) + 2 := by linarith
      exact (div_lt_iff₀ hL).1 this

theorem pairwiseDisjoint_cells {L : ℝ} (hL : 0 < L) :
    Pairwise (fun j k : ℕ => Disjoint
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L))
      (Set.Ico ((k + 1 : ℝ) * L) ((k + 2 : ℝ) * L))) := by
  intro j k hjk
  apply Set.disjoint_left.mpr
  intro v hj hk
  rcases lt_or_gt_of_ne hjk with h | h
  · have : (j : ℝ) + 1 ≤ k := by exact_mod_cast h
    nlinarith [hj.2, hk.1]
  · have : (k : ℝ) + 1 ≤ j := by exact_mod_cast h
    nlinarith [hk.2, hj.1]

private theorem integral_Ico_eq_interval (f : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) :
    (∫ v in Set.Ico a b, f v) = ∫ v in a..b, f v := by
  rw [← integral_Icc_eq_integral_Ico, integral_Icc_eq_integral_Ioc,
    intervalIntegral.integral_of_le hab]

/-- A nonnegative causal function is integrable when its complete clock-cell
masses have a finite sum. This also identifies the whole-line integral. -/
theorem integral_of_clock_cells {L M : ℝ} {f : ℝ → ℝ} (hL : 0 < L)
    (hnonneg : ∀ v, 0 ≤ f v) (hzero : ∀ v < L, f v = 0)
    (hi : ∀ j : ℕ, IntegrableOn f
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)))
    (hs : HasSum (fun j : ℕ => ∫ v in
      Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L), f v) M) :
    Integrable f ∧ (∫ v, f v) = M := by
  have hnorm : Summable (fun j : ℕ => ∫ v in
      Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L), ‖f v‖) := by
    simpa only [Real.norm_eq_abs, abs_of_nonneg (hnonneg _)] using hs.summable
  have hu := integrableOn_iUnion_of_summable_integral_norm hi hnorm
  have hu' : IntegrableOn f (Set.Ici L) := by rwa [iUnion_cells hL] at hu
  have hind : (Set.Ici L).indicator f = f := by
    funext v
    by_cases hv : L ≤ v
    · simp [hv]
    · simp [hv, hzero v (lt_of_not_ge hv)]
  have hf : Integrable f := by
    rw [← hind]
    exact (integrable_indicator_iff measurableSet_Ici).2 hu'
  refine ⟨hf, ?_⟩
  have hsum := hasSum_integral_iUnion (fun _ => measurableSet_Ico)
    (pairwiseDisjoint_cells hL) hu
  have hmass := hsum.unique hs
  rw [iUnion_cells hL, ← integral_indicator measurableSet_Ici, hind] at hmass
  exact hmass

/-- The literal floor-defined seed is integrable and has total mass `2 exp(-L)`. -/
theorem integrable_seed_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (seed L) ∧ (∫ v, seed L v) = 2 * exp (-L) := by
  have hab (j : ℕ) : (j + 1 : ℝ) * L ≤ (j + 2 : ℝ) * L := by linarith
  have hi (j : ℕ) : IntegrableOn (seed L)
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) := by
    rw [integrableOn_congr_fun (fun v hv => seed_eq_cellDensity hL j hv) measurableSet_Ico]
    apply (intervalIntegrable_iff_integrableOn_Ico_of_le (hab j)).1
    exact (continuous_exp.comp ((continuous_id.div_const 2).sub continuous_const)).intervalIntegrable _ _
  apply integral_of_clock_cells hL (seed_nonneg L) (fun v hv => seed_eq_zero hv) hi
  convert hasSum_cell_integrals hL using 1
  funext j
  rw [setIntegral_congr_fun measurableSet_Ico (fun v hv => seed_eq_cellDensity hL j hv),
    integral_Ico_eq_interval _ (hab j)]

theorem integral_prime_seed {p : ℝ} (hp : 1 < p) :
    (∫ v, seed (log p) v) = 2 / p := by
  rw [(integrable_seed_and_integral (log_pos hp)).2, exp_neg,
    exp_log (by linarith : 0 < p)]
  ring

/-- The half-weighted literal seed has a finite whole-line integral. -/
theorem integrable_weighted_seed_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => exp (-v / 2) * seed L v) ∧
      (∫ v, exp (-v / 2) * seed L v) =
        L * exp (-L) ^ 2 / (1 - exp (-L)) := by
  have hab (j : ℕ) : (j + 1 : ℝ) * L ≤ (j + 2 : ℝ) * L := by linarith
  have heq (j : ℕ) : Set.EqOn (fun v => exp (-v / 2) * seed L v)
      (fun v => exp (-v / 2) * cellDensity L j v)
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) := by
    intro v hv
    dsimp only
    rw [seed_eq_cellDensity hL j hv]
  have hi (j : ℕ) : IntegrableOn (fun v => exp (-v / 2) * seed L v)
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) := by
    rw [integrableOn_congr_fun (heq j) measurableSet_Ico]
    apply (intervalIntegrable_iff_integrableOn_Ico_of_le (hab j)).1
    exact ((continuous_exp.comp (continuous_id.neg.div_const 2)).mul
      (continuous_exp.comp ((continuous_id.div_const 2).sub continuous_const))).intervalIntegrable _ _
  apply integral_of_clock_cells hL
    (fun v => mul_nonneg (exp_pos _).le (seed_nonneg L v))
    (fun v hv => by rw [seed_eq_zero hv, mul_zero]) hi
  convert hasSum_weighted_cell_integrals hL using 1
  funext j
  rw [setIntegral_congr_fun measurableSet_Ico (heq j),
    integral_Ico_eq_interval _ (hab j)]

theorem integral_prime_weighted_seed {p : ℝ} (hp : 1 < p) :
    (∫ v, exp (-v / 2) * seed (log p) v) = log p / (p * (p - 1)) := by
  rw [(integrable_weighted_seed_and_integral (log_pos hp)).2, exp_neg,
    exp_log (by linarith : 0 < p)]
  field_simp

/-- The exponential definition is exactly the published power/floor formula. -/
theorem seed_log_eq {p : ℝ} (hp : 0 < p) (v : ℝ) :
    seed (log p) v = if log p ≤ v then
      exp (v / 2) / p ^ (⌊v / log p⌋₊ + 1) else 0 := by
  unfold seed
  split_ifs
  · rw [exp_sub]
    congr 1
    rw [show (⌊v / log p⌋₊ + 1 : ℝ) * log p =
        (⌊v / log p⌋₊ + 1 : ℕ) * log p by push_cast; rfl,
      exp_nat_mul, exp_log hp]
  · rfl

end BuildingBlocks.PrimeSeedMass
