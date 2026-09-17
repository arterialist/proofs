import BuildingBlocks.HyperbolaMertens

open Finset Filter Set MeasureTheory
open BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct BuildingBlocks.CoarsePrimitive
open scoped BigOperators Topology Interval

namespace BuildingBlocks.MertensTransfer

theorem divisorCard_harmonic_bound (K : ℕ) :
    (∑ n ∈ Finset.Icc 1 K, (n.divisors.card : ℝ) / n) ≤ (harmonic K : ℝ) ^ 2 := by
  have he : (∑ n ∈ Finset.Icc 1 K, (n.divisors.card : ℝ) / n) =
      ∑ n ∈ Finset.Icc 1 K, ∑ d ∈ n.divisors, 1 / ((d : ℝ) * (n / d : ℕ)) := by
    apply Finset.sum_congr rfl
    intro n hn
    have hi : (∑ d ∈ n.divisors, 1 / ((d : ℝ) * (n / d : ℕ))) =
        ∑ _d ∈ n.divisors, (1 : ℝ) / n := by
      apply Finset.sum_congr rfl
      intro d hd
      have hm : (d : ℝ) * (n / d : ℕ) = n := by
        exact_mod_cast Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1
      rw [hm]
    rw [hi]
    simp [div_eq_mul_inv]
  rw [he, sum_divisors_eq_sum_factor_pairs K (fun a b => (1 : ℝ) / ((a : ℝ) * b))]
  calc
    _ ≤ ∑ a ∈ Finset.Icc 1 K, ∑ b ∈ Finset.Icc 1 K, 1 / ((a : ℝ) * b) := by
      apply Finset.sum_le_sum
      intro a ha
      exact Finset.sum_le_sum_of_subset_of_nonneg
        (Finset.Icc_subset_Icc le_rfl (Nat.div_le_self K a)) (fun _ _ _ => by positivity)
    _ = _ := by
      simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast,
        pow_two, Finset.sum_mul_sum, one_div, mul_inv]

theorem centeredDivisorCoefficient_harmonic_bound {K : ℕ} (hK : 1 ≤ K) :
    (∑ k ∈ Finset.Icc 1 K, |centeredDivisorCoefficient k| / k) ≤
      4 * (1 + Real.log K) ^ 2 := by
  have hg0 : 0 ≤ Real.eulerMascheroniConstant :=
    le_trans (by norm_num) Real.one_half_lt_eulerMascheroniConstant.le
  have hg1 := Real.eulerMascheroniConstant_lt_two_thirds
  have hlog : 0 ≤ Real.log (K : ℝ) := Real.log_nonneg (by exact_mod_cast hK)
  have hs : (∑ k ∈ Finset.Icc 1 K, |centeredDivisorCoefficient k| / k) ≤
      (Real.log K + 2 * Real.eulerMascheroniConstant) * (harmonic K : ℝ) +
        (harmonic K : ℝ) ^ 2 := by
    calc
      _ ≤ ∑ k ∈ Finset.Icc 1 K,
          ((Real.log K + 2 * Real.eulerMascheroniConstant) / k +
            (k.divisors.card : ℝ) / k) := by
        apply Finset.sum_le_sum
        intro k hk
        have hk1 : (1 : ℝ) ≤ k := by exact_mod_cast (Finset.mem_Icc.mp hk).1
        have hkl : Real.log (k : ℝ) ≤ Real.log K :=
          Real.log_le_log (by linarith) (by exact_mod_cast (Finset.mem_Icc.mp hk).2)
        have hab : |centeredDivisorCoefficient k| ≤
            Real.log K + 2 * Real.eulerMascheroniConstant + k.divisors.card := by
          unfold centeredDivisorCoefficient
          have hh := (abs_add_le (Real.log k - k.divisors.card)
            (2 * Real.eulerMascheroniConstant)).trans
              (add_le_add_right (abs_sub (Real.log (k : ℝ)) (k.divisors.card : ℝ)) _)
          rw [abs_of_nonneg (Real.log_nonneg hk1), abs_of_nonneg (show (0 : ℝ) ≤ (k.divisors.card : ℝ) by positivity),
            abs_of_nonneg (by positivity : 0 ≤ 2 * Real.eulerMascheroniConstant)] at hh
          linarith
        simpa only [add_div] using div_le_div_of_nonneg_right hab (Nat.cast_nonneg k)
      _ = (Real.log K + 2 * Real.eulerMascheroniConstant) * (harmonic K : ℝ) +
          ∑ k ∈ Finset.Icc 1 K, (k.divisors.card : ℝ) / k := by
        simp only [Finset.sum_add_distrib, harmonic_eq_sum_Icc, Rat.cast_sum,
          Rat.cast_inv, Rat.cast_natCast, Finset.mul_sum, div_eq_mul_inv]
      _ ≤ _ := add_le_add_left (divisorCard_harmonic_bound K) _
  have hH0 : (0 : ℝ) ≤ harmonic K := by
    simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
    exact Finset.sum_nonneg (fun _ _ => by positivity)
  have hH := harmonic_le_one_add_log K
  have hprod := mul_le_mul_of_nonneg_left hH
    (by positivity : 0 ≤ Real.log K + 2 * Real.eulerMascheroniConstant)
  have hsq : (harmonic K : ℝ) ^ 2 ≤ (1 + Real.log K) ^ 2 :=
    pow_le_pow_left₀ hH0 hH 2
  have hgprod := mul_le_mul_of_nonneg_right hg1.le
    (by positivity : 0 ≤ 1 + Real.log K)
  nlinarith [sq_nonneg (Real.log (K : ℝ))]

theorem primeError_bound_of_Mertens_quotients {N K : ℕ} (hN : 1 ≤ N)
    (hK : 1 ≤ K) (hKN : K ≤ N) {η : ℝ} (hη : 0 ≤ η)
    (hM : ∀ k ∈ Finset.Icc 1 K,
      |(mertens (N / k) : ℝ)| ≤ η * ((N : ℝ) / k)) :
    |integerError N + 2 * Real.eulerMascheroniConstant| ≤
      4 * η * N * (1 + Real.log K) ^ 2 + 39 * N / Real.sqrt ((K + 1 : ℕ) : ℝ) := by
  have hp : |centeredMertensPrefix N K| ≤ 4 * η * N * (1 + Real.log K) ^ 2 := by
    calc
      _ ≤ ∑ k ∈ Finset.Icc 1 K,
          |centeredDivisorCoefficient k * (mertens (N / k) : ℝ)| :=
        Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ k ∈ Finset.Icc 1 K,
          |centeredDivisorCoefficient k| * (η * ((N : ℝ) / k)) := by
        apply Finset.sum_le_sum
        intro k hk
        rw [abs_mul]
        exact mul_le_mul_of_nonneg_left (hM k hk) (abs_nonneg _)
      _ = (η * N) * ∑ k ∈ Finset.Icc 1 K, |centeredDivisorCoefficient k| / k := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro k hk
        ring
      _ ≤ (η * N) * (4 * (1 + Real.log K) ^ 2) :=
        mul_le_mul_of_nonneg_left (centeredDivisorCoefficient_harmonic_bound hK) (by positivity)
      _ = _ := by ring
  have hr := primeError_Mertens_prefix_remainder hN hKN
  have ht := abs_add_le (integerError N + 2 * Real.eulerMascheroniConstant -
    centeredMertensPrefix N K) (centeredMertensPrefix N K)
  rw [sub_add_cancel] at ht
  linarith

end BuildingBlocks.MertensTransfer
