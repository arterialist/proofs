import BuildingBlocks.AllPrimeMemoryKernel
import BuildingBlocks.PrimeSeedCutoffConvergence
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! Square convergence of the literal prime cutoffs, including every power
of each admitted prime. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.PrimeSeedMass

theorem finitePrimeSeed_nonneg (S : Finset Nat.Primes) (v : ℝ) :
    0 ≤ finitePrimeSeed S v :=
  Finset.sum_nonneg (fun p _ => seed_nonneg (log p) v)

theorem finitePrimeSeed_le_allPrimeSeed (S : Finset Nat.Primes) (v : ℝ) :
    finitePrimeSeed S v ≤ allPrimeSeed v :=
  (summable_of_finite_support (seed_prime_finite_support v)).sum_le_tsum S
    (fun p _ => seed_nonneg (log p) v)

theorem cutoff_seed_eventually_eq (v : ℝ) :
    ∀ᶠ P : ℕ in atTop, finitePrimeSeed (primesBelow P) v = allPrimeSeed v := by
  filter_upwards [eventually_ge_atTop (⌊exp v⌋₊ + 1)] with P hP
  symm
  unfold allPrimeSeed finitePrimeSeed
  apply tsum_eq_sum
  intro p hp
  have hpP : P ≤ (p : ℕ) := Nat.le_of_not_gt (by simpa using hp)
  have hexp : exp v < (p : ℝ) := by
    have hn := Nat.lt_floor_add_one (exp v)
    have hle : (⌊exp v⌋₊ + 1 : ℕ) ≤ (p : ℕ) := hP.trans hpP
    exact hn.trans_le (by exact_mod_cast hle)
  exact seed_eq_zero ((lt_log_iff_exp_lt (by exact_mod_cast p.property.pos)).2 hexp)

theorem cutoff_seed_square_error_bound (P : ℕ) (v : ℝ) :
    (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2 ≤ allPrimeSeed v ^ 2 := by
  exact (sq_le_sq₀ (sub_nonneg.mpr (finitePrimeSeed_le_allPrimeSeed _ _))
    (allPrimeSeed_nonneg v)).2 (sub_le_self _ (finitePrimeSeed_nonneg _ _))

theorem cutoff_seed_square_error_tendsto :
    Tendsto (fun P : ℕ => ∫ v, (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)
      atTop (𝓝 0) := by
  have h := tendsto_integral_of_dominated_convergence
    (μ := (volume : Measure ℝ)) (f := fun _ => (0 : ℝ))
    (F := fun P v => (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)
    (fun v => allPrimeSeed v ^ 2)
    (fun P => ((measurable_allPrimeSeed.sub (measurable_finitePrimeSeed _)).pow_const 2).aestronglyMeasurable)
    integrable_allPrimeSeed_square
    (fun P => Eventually.of_forall (fun v => by
      rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
      exact cutoff_seed_square_error_bound P v))
    (Eventually.of_forall (fun v => by
      apply tendsto_const_nhds.congr'
      filter_upwards [cutoff_seed_eventually_eq v] with P hP
      simp [hP]))
  simpa only [integral_zero] using h

theorem cutoff_seed_sqrt_error_tendsto :
    Tendsto (fun P : ℕ => sqrt (∫ v,
      (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)) atTop (𝓝 0) := by
  simpa using (Real.continuous_sqrt.tendsto 0).comp cutoff_seed_square_error_tendsto

theorem cutoff_memory_error_bound (P : ℕ) {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    |SuccessorCharge.causalMemory allPrimeSeed f v -
      SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| ≤
      sqrt (∫ w, (allPrimeSeed w - finitePrimeSeed (primesBelow P) w) ^ 2) *
        sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2) := by
  have he : SuccessorCharge.causalMemory allPrimeSeed f v -
      SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v =
      SuccessorCharge.causalMemory
        (fun w => allPrimeSeed w - finitePrimeSeed (primesBelow P) w) f v := by
    unfold SuccessorCharge.causalMemory
    have hA := (SuccessorCharge.reflected_halfline_memLp allPrimeSeed_memLp_two v).integrable_mul hf
    have hB := (SuccessorCharge.reflected_halfline_memLp (finitePrimeSeed_memLp_two (primesBelow P)) v).integrable_mul hf
    simp only [Pi.mul_def] at hA hB
    rw [← integral_sub hA hB]
    congr 1
    funext u
    ring
  rw [he]
  exact SuccessorCharge.causalMemory_bound
    (allPrimeSeed_memLp_two.sub (finitePrimeSeed_memLp_two _)) hf v

/-- The convergence is uniform in the output age. The source has its actual
half-line L² domain; no absolute output charge is assumed. -/
theorem cutoff_memory_uniform {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ v : ℝ,
      |SuccessorCharge.causalMemory allPrimeSeed f v -
        SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| < ε := by
  have ht := cutoff_seed_sqrt_error_tendsto.mul_const
    (sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2))
  simp only [zero_mul] at ht
  have he := ht.eventually (gt_mem_nhds hε)
  obtain ⟨P₀, hP₀⟩ := eventually_atTop.1 he
  exact ⟨P₀, fun P hP v => (cutoff_memory_error_bound P hf v).trans_lt (hP₀ P hP)⟩

/-- Uniform convergence on the half-line L² unit ball, with no restriction on
the output age. -/
theorem cutoff_memory_uniform_unit_ball {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ f : ℝ → ℝ,
      MemLp f 2 (volume.restrict (Ioi (0 : ℝ))) →
      (∫ u in Ioi (0 : ℝ), f u ^ 2) ≤ 1 → ∀ v : ℝ,
      |SuccessorCharge.causalMemory allPrimeSeed f v -
        SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| < ε := by
  obtain ⟨P₀, hP₀⟩ := eventually_atTop.1
    (cutoff_seed_sqrt_error_tendsto.eventually (gt_mem_nhds hε))
  refine ⟨P₀, fun P hP f hf hnorm v => ?_⟩
  apply (cutoff_memory_error_bound P hf v).trans_lt
  have hs : sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2) ≤ 1 := by
    simpa using sqrt_le_sqrt hnorm
  exact (mul_le_of_le_one_right (sqrt_nonneg _) hs).trans_lt (hP₀ P hP)

end BuildingBlocks.PrimeSeedMass
