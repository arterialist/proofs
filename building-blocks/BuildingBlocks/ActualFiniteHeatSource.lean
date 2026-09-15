import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Tactic

open scoped ArithmeticFunction.vonMangoldt
open MeasureTheory Set

namespace BuildingBlocks.ActualFiniteHeatSource

theorem continuum_heat_integral (a b t : ℝ) (ht : t ≠ 0) :
    (∫ x : ℝ in a..b, Real.exp (-t * x)) =
      (Real.exp (-t * a) - Real.exp (-t * b)) / t := by
  have h := intervalIntegral.mul_integral_comp_mul_left
    (a := a) (b := b) (f := Real.exp) (-t)
  rw [integral_exp] at h
  apply (eq_div_iff ht).mpr
  nlinarith

noncomputable def density (N : ℕ) (t : ℝ) : ℝ :=
  ∫ x : ℝ in (1 : ℝ)..(N : ℝ), Real.exp (-t * x)

noncomputable def source (N : ℕ) (t : ℝ) : ℝ :=
  (∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)) -
    density N t - Real.exp (-t)

theorem density_formula (N : ℕ) (t : ℝ) (ht : t ≠ 0) :
    density N t = (Real.exp (-t) - Real.exp (-(N : ℝ) * t)) / t := by
  unfold density
  rw [continuum_heat_integral _ _ _ ht]
  simp [mul_comm]

theorem source_formula (N : ℕ) (t : ℝ) (ht : t ≠ 0) :
    source N t =
      (∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)) -
        (Real.exp (-t) - Real.exp (-(N : ℝ) * t)) / t - Real.exp (-t) := by
  rw [source, density_formula N t ht]

theorem source_at_one (t : ℝ) : source 1 t = -Real.exp (-t) := by
  norm_num [source, density, Finset.sum_range_succ]

theorem density_set_integral (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    density N t = ∫ x : ℝ in Set.Icc (1 : ℝ) (N : ℝ), Real.exp (-t * x) := by
  unfold density
  rw [intervalIntegral.integral_of_le (by exact_mod_cast hN),
    MeasureTheory.integral_Icc_eq_integral_Ioc]

theorem source_at_zero (N : ℕ) :
    source N 0 = (∑ n ∈ Finset.range (N + 1), Λ n) - (N : ℝ) := by
  simp [source, density]
  ring

theorem density_successor (N : ℕ) (t : ℝ) :
    density (N + 1) t = density N t +
      ∫ x : ℝ in (N : ℝ)..(N + 1 : ℕ), Real.exp (-t * x) := by
  unfold density
  have hi : Continuous (fun x : ℝ => Real.exp (-t * x)) := by fun_prop
  exact (intervalIntegral.integral_add_adjacent_intervals
    (hi.intervalIntegrable _ _) (hi.intervalIntegrable _ _)).symm

theorem source_successor (N : ℕ) (t : ℝ) :
    source (N + 1) t - source N t =
      Λ (N + 1) * Real.exp (-((N + 1 : ℕ) : ℝ) * t) -
        ∫ x : ℝ in (N : ℝ)..(N + 1 : ℕ), Real.exp (-t * x) := by
  unfold source
  rw [Finset.sum_range_succ, density_successor]
  ring

theorem density_norm_bound (N : ℕ) (hN : 1 ≤ N) (t : ℝ) (ht : 0 ≤ t) :
    ‖density N t‖ ≤ ((N : ℝ) - 1) * Real.exp (-t) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have h := intervalIntegral.norm_integral_le_of_norm_le_const
    (a := (1 : ℝ)) (b := (N : ℝ)) (C := Real.exp (-t))
    (f := fun x => Real.exp (-t * x)) (by
      intro x hx
      rw [uIoc_of_le hNr] at hx
      rw [Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
      apply Real.exp_le_exp.mpr
      nlinarith [hx.1])
  simpa [density, abs_of_nonneg (sub_nonneg.mpr hNr), mul_comm] using h

noncomputable def variationBound (N : ℕ) : ℝ :=
  (∑ n ∈ Finset.range (N + 1), Λ n) + N

theorem variationBound_nonnegative (N : ℕ) : 0 ≤ variationBound N := by
  unfold variationBound
  exact add_nonneg (Finset.sum_nonneg (fun _ _ => ArithmeticFunction.vonMangoldt_nonneg))
    (Nat.cast_nonneg _)

theorem source_norm_bound (N : ℕ) (hN : 1 ≤ N) (t : ℝ) (ht : 0 ≤ t) :
    ‖source N t‖ ≤ variationBound N * Real.exp (-t) := by
  have ha : ∀ n : ℕ, ‖Λ n * Real.exp (-(n : ℝ) * t)‖ ≤ Λ n * Real.exp (-t) := by
    intro n
    by_cases hn : n = 0
    · simp [hn]
    have hn1 : (1 : ℝ) ≤ n := by exact_mod_cast Nat.one_le_iff_ne_zero.mpr hn
    simp only [Real.norm_eq_abs, abs_mul, abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg,
      abs_of_pos (Real.exp_pos _)]
    apply mul_le_mul_of_nonneg_left _ ArithmeticFunction.vonMangoldt_nonneg
    apply Real.exp_le_exp.mpr
    nlinarith
  have hs : ‖∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)‖ ≤
      (∑ n ∈ Finset.range (N + 1), Λ n) * Real.exp (-t) := by
    calc
      _ ≤ ∑ n ∈ Finset.range (N + 1), ‖Λ n * Real.exp (-(n : ℝ) * t)‖ := norm_sum_le _ _
      _ ≤ ∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-t) :=
        Finset.sum_le_sum (fun n _ => ha n)
      _ = _ := (Finset.sum_mul _ _ _).symm
  have hd := density_norm_bound N hN t ht
  have he : ‖Real.exp (-t)‖ = Real.exp (-t) := by
    rw [Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
  unfold source
  have h1 := norm_sub_le
    ((∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)) - density N t)
    (Real.exp (-t))
  have h2 := norm_sub_le (∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t))
    (density N t)
  unfold variationBound
  rw [he] at h1
  nlinarith

theorem source_square_integrable (N : ℕ) (hN : 1 ≤ N) :
    IntegrableOn (fun t : ℝ => source N t ^ 2) (Ioi 0) := by
  let f : ℝ → ℝ := fun t =>
    ((∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)) -
      (Real.exp (-t) - Real.exp (-(N : ℝ) * t)) / t - Real.exp (-t)) ^ 2
  have hf : Measurable f := by unfold f; fun_prop
  have heq : (fun t : ℝ => source N t ^ 2) =ᵐ[volume.restrict (Ioi 0)] f := by
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    simp only [f, source_formula N t (ne_of_gt ht)]
  have hm : AEStronglyMeasurable (fun t : ℝ => source N t ^ 2)
      (volume.restrict (Ioi 0)) := hf.aestronglyMeasurable.restrict.congr heq.symm
  have hg := (integrableOn_exp_mul_Ioi (a := (-2 : ℝ)) (by norm_num) 0).const_mul
    (variationBound N ^ 2)
  apply hg.mono' hm
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  calc
    ‖source N t ^ 2‖ = ‖source N t‖ ^ 2 := norm_pow _ _
    _ ≤ (variationBound N * Real.exp (-t)) ^ 2 :=
      pow_le_pow_left₀ (norm_nonneg _) (source_norm_bound N hN t ht.le) 2
    _ = variationBound N ^ 2 * Real.exp (-2 * t) := by
      rw [mul_pow, pow_two (Real.exp (-t)), ← Real.exp_add]
      congr 2
      ring

#print axioms continuum_heat_integral
#print axioms source_formula
#print axioms source_at_one
#print axioms density_set_integral
#print axioms source_at_zero
#print axioms density_successor
#print axioms source_successor
#print axioms density_norm_bound
#print axioms source_norm_bound
#print axioms source_square_integrable

end BuildingBlocks.ActualFiniteHeatSource
