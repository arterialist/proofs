import BuildingBlocks.FinitePrimeSourceIntegration
import BuildingBlocks.ActualFiniteHeatSource
import BuildingBlocks.GoldbachHeatQuadratic
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic

/-! The compact actual prime-error heat source, including the initial density
atom and the frozen terminal charge. -/

open MeasureTheory Real

namespace BuildingBlocks.ActualCompactHeatEndpoint

noncomputable def compactHeat (N : ℕ) (t : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 2 N,
      ArithmeticFunction.vonMangoldt n * exp (-(n : ℝ) * t)) -
    (∫ x in (1 : ℝ)..(N : ℝ), exp (-x * t)) - exp (-t) -
      BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t)

/-- The discrete-minus-continuous density-cell correction between the
centered Goldbach packet and the compact cumulative-error source. -/
noncomputable def densityCellCorrection (N : ℕ) (t : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 2 N, exp (-(n : ℝ) * t)) -
    (∫ x in (1 : ℝ)..(N : ℝ), exp (-x * t))

/-- Exact finite comparison with the actual discrete Goldbach heat packet.
The density cells and the frozen terminal error remain separate. -/
theorem compactHeat_eq_goldbach_packet (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      GoldbachHeat.finiteHeat GoldbachHeat.centeredCoefficient N t +
        densityCellCorrection N t -
          BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t) := by
  have hIcc : Finset.Icc 1 N = insert 1 (Finset.Icc 2 N) := by
    ext n
    simp only [Finset.mem_Icc, Finset.mem_insert]
    omega
  have hone : (1 : ℕ) ∉ Finset.Icc 2 N := by simp
  have hpacket :
      GoldbachHeat.finiteHeat GoldbachHeat.centeredCoefficient N t =
        -exp (-t) +
          (∑ n ∈ Finset.Icc 2 N,
            ArithmeticFunction.vonMangoldt n * exp (-(n : ℝ) * t)) -
          (∑ n ∈ Finset.Icc 2 N, exp (-(n : ℝ) * t)) := by
    unfold GoldbachHeat.finiteHeat GoldbachHeat.centeredCoefficient
    rw [hIcc, Finset.sum_insert hone]
    simp only [ArithmeticFunction.vonMangoldt_apply_one, zero_sub, Nat.cast_one, one_mul]
    simp_rw [sub_mul]
    rw [Finset.sum_sub_distrib]
    simp only [one_mul]
    ring
  rw [hpacket]
  unfold compactHeat densityCellCorrection
  ring

/-- The compact source is exactly the already-formalized finite source with
its frozen terminal charge, not a replacement arithmetic sequence. -/
theorem compactHeat_eq_source_sub_terminal (N : ℕ) (t : ℝ) :
    compactHeat N t =
      ActualFiniteHeatSource.source N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t) := by
  let f : ℕ → ℝ := fun n => ArithmeticFunction.vonMangoldt n * exp (-(n : ℝ) * t)
  have hsub : Finset.Icc 2 N ⊆ Finset.range (N + 1) := by
    intro n hn
    exact Finset.mem_range.mpr (by have := (Finset.mem_Icc.mp hn).2; omega)
  have hsum : (∑ n ∈ Finset.Icc 2 N, f n) = ∑ n ∈ Finset.range (N + 1), f n := by
    apply Finset.sum_subset hsub
    intro n hn hnnot
    have hnsmall : n = 0 ∨ n = 1 := by
      have h : ¬ (2 ≤ n ∧ n ≤ N) := by simpa only [Finset.mem_Icc] using hnnot
      have hnN : n ≤ N := by have := Finset.mem_range.mp hn; omega
      omega
    rcases hnsmall with rfl | rfl <;> simp [f]
  have he : (fun x : ℝ => exp (-x * t)) = (fun x : ℝ => exp (-t * x)) := by
    funext x
    congr 1
    ring
  unfold compactHeat ActualFiniteHeatSource.source ActualFiniteHeatSource.density
  change (∑ n ∈ Finset.Icc 2 N, f n) -
      (∫ x in (1 : ℝ)..(N : ℝ), exp (-x * t)) - exp (-t) -
        BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t) = _
  rw [hsum, he]

/-- The complete prime-power cutoff, density, initial atom, and terminal
compensation equal the Laplace transform of the original cumulative error. -/
theorem compactHeat_eq_error_integral (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      t * (∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * exp (-x * t)) := by
  have hD : Continuous (fun x : ℝ => -t * exp (-x * t)) := by fun_prop
  have hderiv (x : ℝ) :
      HasDerivAt (fun y : ℝ => exp (-y * t)) (-t * exp (-x * t)) x := by
    have hlin : HasDerivAt (fun y : ℝ => -y * t) (-t) x := by
      convert (hasDerivAt_id x).mul_const (-t) using 1
      · funext y
        simp only [id_eq]
        ring
      · simp
    convert hlin.exp using 1
    ring_nf
  have h := FinitePrimeSourceIntegration.original_prime_error_integration_endpoints
    hN hD hderiv
  have hi :
      (∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * (-t * exp (-x * t))) =
      -t * (∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * exp (-x * t)) := by
    have heq :
        (fun x : ℝ => BuildingBlocks.CoarsePrimitive.primeErrorReal x *
          (-t * exp (-x * t))) =
        (fun x : ℝ => -t *
          (BuildingBlocks.CoarsePrimitive.primeErrorReal x * exp (-x * t))) := by
      funext x
      ring
    rw [heq, intervalIntegral.integral_const_mul]
  rw [hi] at h
  unfold compactHeat
  rw [h]
  ring_nf

/-- The complete compact source has zero total charge at every integer
cutoff, including a prime-power arrival at the terminal integer. -/
theorem compactHeat_at_zero (N : ℕ) (hN : 1 ≤ N) : compactHeat N 0 = 0 := by
  rw [compactHeat_eq_error_integral N hN 0]
  simp

#print axioms compactHeat_eq_source_sub_terminal
#print axioms compactHeat_eq_error_integral
#print axioms compactHeat_at_zero
#print axioms compactHeat_eq_goldbach_packet

end BuildingBlocks.ActualCompactHeatEndpoint
