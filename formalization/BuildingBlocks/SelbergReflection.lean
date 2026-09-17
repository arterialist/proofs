import Mathlib.Algebra.Order.Floor.Semifield
import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.SelbergCenteredPairing
import BuildingBlocks.PrimePrimitiveContraction
import BuildingBlocks.PrimeFirstMoment

open Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- The first moment of all actual prime-power births up to a real cutoff. -/
noncomputable def primeBirthMoment (y : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 ⌊y⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n

theorem primeError_sub_primitive_quotient {y : ℝ} (hy : 1 ≤ y) :
    primeErrorReal y - coarsePrefix 1 y / y =
      primeBirthMoment y / y - y / 2 - 1 / (2*y) := by
  have hz : y ≠ 0 := by linarith
  have hj : coarsePrefix 1 y = primePrimitiveArea y := by
    exact integral_primeErrorReal_eq_area hy
  rw [hj]
  unfold primeErrorReal primePrimitiveArea primeBirthMoment
  field_simp
  ring

theorem primeBirthMoment_reflected {N : ℕ} {a : ℝ} (ha : 1 ≤ a) :
    primeBirthMoment ((N : ℝ) / a) =
      ∑ n ∈ Finset.Icc 1 N,
        if a ≤ (N : ℝ) / n then (n : ℝ) * ArithmeticFunction.vonMangoldt n else 0 := by
  have hap : 0 < a := lt_of_lt_of_le zero_lt_one ha
  have hdiv : (N : ℝ) / a ≤ N := div_le_self (by positivity) ha
  have hf : ⌊(N : ℝ) / a⌋₊ ≤ N := by
    simpa only [Nat.floor_natCast] using Nat.floor_mono hdiv
  have hset : Finset.Icc 1 ⌊(N : ℝ) / a⌋₊ =
      (Finset.Icc 1 N).filter (fun n : ℕ => a ≤ (N : ℝ) / (n : ℝ)) := by
    ext n
    by_cases hn : 1 ≤ n
    · have hnp : (0 : ℝ) < n := by exact_mod_cast hn
      have he : n ≤ ⌊(N : ℝ) / a⌋₊ ↔ a ≤ (N : ℝ) / n := by
        rw [Nat.le_floor_iff (by positivity), le_div_iff₀ hap, le_div_iff₀ hnp]
        exact ⟨fun h => by nlinarith, fun h => by nlinarith⟩
      simp only [Finset.mem_Icc, Finset.mem_filter, hn, true_and]
      exact ⟨fun h => ⟨h.trans hf, he.mp h⟩, fun h => he.mpr h.2⟩
    · simp [Finset.mem_Icc, hn]
  rw [primeBirthMoment, hset, Finset.sum_filter]

private theorem reflected_birth_term_integrable (N n : ℕ) :
    IntervalIntegrable
      (fun a : ℝ => (Iic ((N : ℝ) / n)).indicator primeErrorReal a *
        ((n : ℝ) * ArithmeticFunction.vonMangoldt n)) volume 1 N := by
  have hi := primeErrorReal_intervalIntegrable 1 (N : ℝ)
  have hj : IntervalIntegrable ((Iic ((N : ℝ) / n)).indicator primeErrorReal)
      volume 1 N :=
    ⟨hi.1.indicator measurableSet_Iic, hi.2.indicator measurableSet_Iic⟩
  exact hj.mul_const _

theorem integral_primeError_reflected_birthMoment {N : ℕ} (hN : 1 ≤ N) :
    (∫ a in (1 : ℝ)..(N : ℝ), primeErrorReal a * primeBirthMoment ((N : ℝ) / a)) =
      ∑ n ∈ Finset.Icc 1 N,
        (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  calc
    _ = ∫ a in (1 : ℝ)..(N : ℝ), ∑ n ∈ Finset.Icc 1 N,
        (Iic ((N : ℝ) / n)).indicator primeErrorReal a *
          ((n : ℝ) * ArithmeticFunction.vonMangoldt n) := by
      apply intervalIntegral.integral_congr
      intro a ha
      rw [uIcc_of_le hNr] at ha
      dsimp only
      rw [primeBirthMoment_reflected (N := N) ha.1, Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      by_cases hh : a ≤ (N : ℝ) / n
      · simp [hh, Set.indicator_of_mem]
      · simp [hh, Set.indicator_of_notMem]
    _ = ∑ n ∈ Finset.Icc 1 N,
        ∫ a in (1 : ℝ)..(N : ℝ),
          (Iic ((N : ℝ) / n)).indicator primeErrorReal a *
            ((n : ℝ) * ArithmeticFunction.vonMangoldt n) :=
      intervalIntegral.integral_finset_sum (fun n _ => reflected_birth_term_integrable N n)
    _ = _ := by
      apply Finset.sum_congr rfl
      intro n hn
      obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
      have hn1r : (1 : ℝ) ≤ n := by exact_mod_cast hn1
      have hnNr : (n : ℝ) ≤ N := by exact_mod_cast hnN
      have hnp : (0 : ℝ) < n := by linarith
      have hq : (N : ℝ) / n ∈ Icc (1 : ℝ) N :=
        ⟨(le_div_iff₀ hnp).2 (by simpa using hnNr),
          div_le_self (by positivity) hn1r⟩
      rw [intervalIntegral.integral_mul_const]
      have hh := intervalIntegral.integral_indicator (f := primeErrorReal) (μ := volume) hq
      change (∫ a in (1 : ℝ)..(N : ℝ), (Iic ((N : ℝ) / n)).indicator primeErrorReal a) =
        coarsePrefix 1 ((N : ℝ) / n) at hh
      rw [hh, mul_comm]

theorem reflected_primePrimitive_sum {N : ℕ} :
    (∑ n ∈ Finset.Icc 1 N,
      (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n)) =
    (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
      ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
        ArithmeticFunction.vonMangoldt b) -
    (N : ℝ)^2 / 2 * (∑ n ∈ Finset.Icc 1 N,
      ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
    (∑ n ∈ Finset.Icc 1 N, (n : ℝ) * ArithmeticFunction.vonMangoldt n) / 2 := by
  have hterm : ∀ n ∈ Finset.Icc 1 N,
      (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n) =
        (∑ b ∈ Finset.Icc 1 (N / n),
          ((N : ℝ) - (n * b : ℕ)) * ArithmeticFunction.vonMangoldt n *
            ArithmeticFunction.vonMangoldt b) -
        (N : ℝ)^2 / 2 * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
        (n : ℝ) * ArithmeticFunction.vonMangoldt n / 2 := by
    intro n hn
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
    have hnp : (0 : ℝ) < n := by exact_mod_cast hn1
    have hq : (1 : ℝ) ≤ (N : ℝ) / n :=
      (le_div_iff₀ hnp).2 (by simpa using (show (n : ℝ) ≤ N by exact_mod_cast hnN))
    have hj : coarsePrefix 1 ((N : ℝ) / n) = primePrimitiveArea ((N : ℝ) / n) :=
      integral_primeErrorReal_eq_area hq
    rw [hj, primePrimitiveArea_eq_weighted_sum, Nat.floor_div_eq_div, mul_sub,
      Finset.mul_sum]
    have hs : (∑ b ∈ Finset.Icc 1 (N / n),
        ((n : ℝ) * ArithmeticFunction.vonMangoldt n) *
          (((N : ℝ) / n - b) * ArithmeticFunction.vonMangoldt b)) =
        ∑ b ∈ Finset.Icc 1 (N / n),
          ((N : ℝ) - (n * b : ℕ)) * ArithmeticFunction.vonMangoldt n *
            ArithmeticFunction.vonMangoldt b := by
      apply Finset.sum_congr rfl
      intro b hb
      push_cast
      field_simp
    rw [hs]
    have hc : (n : ℝ) * ArithmeticFunction.vonMangoldt n *
        (((N : ℝ) / n)^2 - 1) / 2 =
        (N : ℝ)^2 / 2 * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
          (n : ℝ) * ArithmeticFunction.vonMangoldt n / 2 := by
      field_simp
    linarith
  rw [Finset.sum_congr rfl hterm, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.sum_div]

theorem primeError_reflected_birthMoment_integrable {N : ℕ} (hN : 1 ≤ N) :
    IntervalIntegrable (fun a => primeErrorReal a * primeBirthMoment ((N : ℝ) / a))
      volume 1 N := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hi := IntervalIntegrable.sum (Finset.Icc 1 N)
    (fun n _ => reflected_birth_term_integrable N n)
  apply IntervalIntegrable.congr _ hi
  intro a ha
  rw [uIoc_of_le hNr] at ha
  simp only [Finset.sum_apply]
  rw [primeBirthMoment_reflected (N := N) ha.1.le, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n hn
  by_cases hh : a ≤ (N : ℝ) / n <;> simp [hh]

/-- Exact reflection of the finite centered convolution. The endpoint atom at
one is included through the `1 / (2*y)` term in the quotient formula. -/
theorem selbergCenteredArea_reflection {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N = (N : ℝ) *
      ∫ a in (1 : ℝ)..(N : ℝ),
        primeErrorReal a *
          (primeErrorReal ((N : ℝ) / a) -
            coarsePrefix 1 ((N : ℝ) / a) / ((N : ℝ) / a)) / a := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hNp : (0 : ℝ) < N := by linarith
  have hz : ∀ t ∈ uIcc (1 : ℝ) (N : ℝ), t ≠ 0 := by
    intro t ht
    rw [uIcc_of_le hNr] at ht
    linarith [ht.1]
  have hiE : IntervalIntegrable (fun a => primeErrorReal a / a^2) volume 1 N := by
    simpa only [div_eq_mul_inv] using
      (primeErrorReal_intervalIntegrable 1 (N : ℝ)).mul_continuousOn
        ((continuousOn_id.pow 2).inv₀ (fun t ht => pow_ne_zero _ (hz t ht)))
  have hiQ := primeError_reflected_birthMoment_integrable hN
  have hi1 := hiE.const_mul ((N : ℝ)^2 / 2)
  have hi2 := (primeErrorReal_intervalIntegrable 1 (N : ℝ)).div_const 2
  rw [← intervalIntegral.integral_const_mul]
  have heq : (∫ a in (1 : ℝ)..(N : ℝ),
      (N : ℝ) * (primeErrorReal a *
        (primeErrorReal ((N : ℝ) / a) -
          coarsePrefix 1 ((N : ℝ) / a) / ((N : ℝ) / a)) / a)) =
      ∫ a in (1 : ℝ)..(N : ℝ),
        primeErrorReal a * primeBirthMoment ((N : ℝ) / a) -
          (N : ℝ)^2 / 2 * (primeErrorReal a / a^2) - primeErrorReal a / 2 := by
    apply intervalIntegral.integral_congr
    intro a ha
    rw [uIcc_of_le hNr] at ha
    have hap : 0 < a := by linarith [ha.1]
    have hq : 1 ≤ (N : ℝ) / a := (le_div_iff₀ hap).2 (by linarith [ha.2])
    dsimp only
    rw [primeError_sub_primitive_quotient hq]
    field_simp
  rw [heq, intervalIntegral.integral_sub (hiQ.sub hi1) hi2,
    intervalIntegral.integral_sub hiQ hi1, intervalIntegral.integral_const_mul,
    intervalIntegral.integral_div, integral_primeError_reflected_birthMoment hN,
    primeError_first_moment hN, integral_primeErrorReal_eq_area hNr,
    reflected_primePrimitive_sum]
  unfold selbergCenteredArea primePrimitiveArea
  simp only [Nat.floor_natCast]
  field_simp
  ring

end BuildingBlocks
