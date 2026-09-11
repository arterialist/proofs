import BuildingBlocks.CoarsePrimeBounds

open Finset Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive

theorem rpow_psi_intervalIntegrable {N : ℕ} (hN : 1 ≤ N) (a : ℝ) :
    IntervalIntegrable (fun x : ℝ => x ^ a * psi ⌊x⌋₊) volume 1 (N : ℝ) := by
  rw [intervalIntegrable_iff_integrableOn_Icc_of_le (by exact_mod_cast hN)]
  simp only [psi_eq_sum_Icc]
  apply integrableOn_mul_sum_Icc ArithmeticFunction.vonMangoldt zero_le_one
  apply ContinuousOn.integrableOn_Icc
  exact continuousOn_id.rpow_const (fun x hx => Or.inl (by change x ≠ 0; linarith [hx.1]))

theorem weighted_vonMangoldt_abel {N : ℕ} (hN : 1 ≤ N) (r : ℝ) :
    (∑ n ∈ Finset.Icc 1 N, (n : ℝ) ^ (-r) * ArithmeticFunction.vonMangoldt n) =
      (N : ℝ) ^ (-r) * psi N + r *
        ∫ x : ℝ in (1 : ℝ)..(N : ℝ), x ^ (-r - 1) * psi ⌊x⌋₊ := by
  have hderiv : ∀ x ∈ Set.Icc (1 : ℝ) (N : ℝ),
      deriv (fun x : ℝ => x ^ (-r)) x = -r * x ^ (-r - 1) := by
    intro x hx
    exact Real.deriv_rpow_const (Or.inl (by linarith [hx.1]))
  have hdi : IntegrableOn (deriv (fun x : ℝ => x ^ (-r))) (Set.Icc 1 (N : ℝ)) := by
    apply (integrableOn_congr_fun hderiv measurableSet_Icc).mpr
    apply ContinuousOn.integrableOn_Icc
    exact continuousOn_const.mul (continuousOn_id.rpow_const
      (fun x hx => Or.inl (by change x ≠ 0; linarith [hx.1])))
  have hh := sum_mul_eq_sub_integral_mul₀' ArithmeticFunction.vonMangoldt (by simp) N
    (fun x hx => (Real.hasDerivAt_rpow_const (p := -r) (Or.inl (by linarith [hx.1]))).differentiableAt) hdi
  have hs : ∀ M : ℕ, (∑ n ∈ Finset.Icc 0 M, ArithmeticFunction.vonMangoldt n) = psi M := by
    intro M
    have hi : Finset.Icc 0 M = Finset.range (M + 1) := by ext n; simp; omega
    rw [hi, psi]
  simp only [hs] at hh
  rw [Finset.Icc_eq_cons_Ioc (Nat.zero_le N), Finset.sum_cons] at hh
  simp only [Nat.cast_zero, ArithmeticFunction.map_zero, mul_zero, zero_add,
    ← Finset.Icc_add_one_left_eq_Ioc] at hh
  rw [setIntegral_congr_fun measurableSet_Ioc
    (g := fun x : ℝ => -r * (x ^ (-r - 1) * psi ⌊x⌋₊)) (fun x hx => by
      dsimp only
      rw [hderiv x ⟨hx.1.le, hx.2⟩]
      ring), integral_const_mul] at hh
  rw [intervalIntegral.integral_of_le (by exact_mod_cast hN)]
  convert hh using 1
  ring

theorem weighted_vonMangoldt_le {N : ℕ} (hN : 1 ≤ N) {r : ℝ}
    (hr : 0 ≤ r) (hr1 : r < 1) :
    (∑ n ∈ Finset.Icc 1 N, (n : ℝ) ^ (-r) * ArithmeticFunction.vonMangoldt n) ≤
      (4 * Real.log 2) / (1 - r) * (N : ℝ) ^ (1 - r) := by
  let K : ℝ := 4 * Real.log 2
  have hK : 0 < K := by dsimp only [K]; positivity
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  have hNreal : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hp : ∀ x ∈ Set.Icc (1 : ℝ) (N : ℝ),
      x ^ (-r - 1) * psi ⌊x⌋₊ ≤ K * x ^ (-r) := by
    intro x hx
    have hx0 : 0 < x := by linarith [hx.1]
    have hpsi : psi ⌊x⌋₊ ≤ K * x := (psi_le_linear _).trans
      (mul_le_mul_of_nonneg_left (Nat.floor_le hx0.le) hK.le)
    calc
      _ ≤ x ^ (-r - 1) * (K * x) := mul_le_mul_of_nonneg_left hpsi (Real.rpow_nonneg hx0.le _)
      _ = K * x ^ (-r) := by
        nth_rw 2 [← Real.rpow_one x]
        rw [show x ^ (-r - 1) * (K * x ^ (1 : ℝ)) = K * (x ^ (-r - 1) * x ^ (1 : ℝ)) by ring,
          ← Real.rpow_add hx0]
        congr 1
        congr 1
        ring
  have hi : IntervalIntegrable (fun x : ℝ => K * x ^ (-r)) volume 1 (N : ℝ) := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hNreal]
    exact continuousOn_const.mul (continuousOn_id.rpow_const
      (fun x hx => Or.inl (by change x ≠ 0; linarith [hx.1])))
  have hInt := intervalIntegral.integral_mono_on hNreal (rpow_psi_intervalIntegrable hN (-r-1)) hi hp
  have hval : (∫ x : ℝ in (1 : ℝ)..(N : ℝ), K * x ^ (-r)) =
      K * (((N : ℝ) ^ (1 - r) - 1) / (1 - r)) := by
    rw [intervalIntegral.integral_const_mul, integral_rpow (Or.inl (by linarith : -1 < -r))]
    rw [show -r + 1 = 1 - r by ring, Real.one_rpow]
  rw [hval] at hInt
  have hend : (N : ℝ) ^ (-r) * psi N ≤ K * (N : ℝ) ^ (1 - r) := by
    calc
      _ ≤ (N : ℝ) ^ (-r) * (K * (N : ℝ)) :=
        mul_le_mul_of_nonneg_left (psi_le_linear N) (Real.rpow_nonneg hn.le _)
      _ = _ := by
        nth_rw 2 [← Real.rpow_one (N : ℝ)]
        rw [show (N : ℝ) ^ (-r) * (K * (N : ℝ) ^ (1 : ℝ)) =
          K * ((N : ℝ) ^ (-r) * (N : ℝ) ^ (1 : ℝ)) by ring, ← Real.rpow_add hn]
        congr 1
        congr 1
        ring
  rw [weighted_vonMangoldt_abel hN r]
  calc
    _ ≤ K * (N : ℝ) ^ (1 - r) + r * (K * (((N : ℝ) ^ (1 - r) - 1) / (1 - r))) :=
      add_le_add hend (mul_le_mul_of_nonneg_left hInt hr)
    _ ≤ K / (1 - r) * (N : ℝ) ^ (1 - r) := by
      have hd : 0 < 1 - r := by linarith
      rw [div_mul_eq_mul_div]
      apply (le_div_iff₀ hd).mpr
      have heq : (K * (N : ℝ) ^ (1 - r) +
          r * (K * (((N : ℝ) ^ (1 - r) - 1) / (1 - r)))) * (1 - r) =
            K * (N : ℝ) ^ (1 - r) - r * K := by
        field_simp
        ring
      rw [heq]
      exact sub_le_self _ (mul_nonneg hr hK.le)

end BuildingBlocks
