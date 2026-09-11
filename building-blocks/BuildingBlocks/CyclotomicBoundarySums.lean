import BuildingBlocks.CyclotomicDivisorPairs

open Finset
open scoped BigOperators

namespace BuildingBlocks.CyclotomicBoundary

/-- The elementary average divisor bound, including the empty prefix. -/
theorem divisorCard_sum_le_mul_harmonic (X : ℕ) :
    (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ)) ≤
      (X : ℝ) * (harmonic X : ℝ) := by
  exact divisorCard_sum_harmonic_bound X

/-- A telescoping square-root comparison; no improper integral is needed. -/
theorem inv_sqrt_sum_le_two_sqrt (X : ℕ) :
    (∑ n ∈ Finset.Icc 1 X, (1 : ℝ) / Real.sqrt n) ≤ 2 * Real.sqrt X := by
  induction X with
  | zero => simp
  | succ X ih =>
    rw [Finset.sum_Icc_succ_top (by omega)]
    have hs : (0 : ℝ) < Real.sqrt (X + 1 : ℕ) := by positivity
    have hx := Real.sq_sqrt (Nat.cast_nonneg X)
    have hx1 := Real.sq_sqrt (Nat.cast_nonneg (X + 1))
    have hd : (1 : ℝ) / Real.sqrt (X + 1 : ℕ) ≤
        2 * (Real.sqrt (X + 1 : ℕ) - Real.sqrt X) := by
      apply (div_le_iff₀ hs).mpr
      norm_num only [Nat.cast_add, Nat.cast_one] at hx1 ⊢
      nlinarith [sq_nonneg (Real.sqrt ((X : ℝ) + 1) - Real.sqrt X)]
    simpa only [Nat.succ_eq_add_one] using add_le_add ih hd |>.trans (by ring_nf; rfl)

/-- Finite divisor-pair summation with the square-root denominator. -/
theorem divisorCard_inv_sqrt_sum_le (X : ℕ) :
    (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ) / Real.sqrt n) ≤
      2 * Real.sqrt X * (harmonic X : ℝ) := by
  have he : (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ) / Real.sqrt n) =
      ∑ n ∈ Finset.Icc 1 X, ∑ d ∈ n.divisors,
        1 / Real.sqrt ((d : ℝ) * (n / d : ℕ)) := by
    apply Finset.sum_congr rfl
    intro n hn
    have hi : (∑ d ∈ n.divisors, 1 / Real.sqrt ((d : ℝ) * (n / d : ℕ))) =
        ∑ _d ∈ n.divisors, (1 : ℝ) / Real.sqrt n := by
      apply Finset.sum_congr rfl
      intro d hd
      have hm : (d : ℝ) * (n / d : ℕ) = n := by
        exact_mod_cast Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1
      rw [hm]
    rw [hi]
    simp [div_eq_mul_inv]
  rw [he, sum_divisors_eq_sum_factor_pairs X
    (fun a b => (1 : ℝ) / Real.sqrt ((a : ℝ) * b))]
  calc
    _ ≤ ∑ a ∈ Finset.Icc 1 X, (2 * Real.sqrt X) / a := by
      apply Finset.sum_le_sum
      intro a ha
      calc
        _ = (1 / Real.sqrt (a : ℝ)) *
            ∑ b ∈ Finset.Icc 1 (X / a), (1 : ℝ) / Real.sqrt b := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro b hb
          rw [Real.sqrt_mul (Nat.cast_nonneg a)]
          ring
        _ ≤ (1 / Real.sqrt (a : ℝ)) * (2 * Real.sqrt (X / a : ℕ)) :=
          mul_le_mul_of_nonneg_left (inv_sqrt_sum_le_two_sqrt (X / a)) (by positivity)
        _ ≤ (1 / Real.sqrt (a : ℝ)) * (2 * Real.sqrt ((X : ℝ) / a)) := by
          exact mul_le_mul_of_nonneg_left
            (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt Nat.cast_div_le) (by norm_num))
            (by positivity)
        _ = (2 * Real.sqrt X) / a := by
          rw [Real.sqrt_div (Nat.cast_nonneg X)]
          calc
            _ = (2 * Real.sqrt X) / (Real.sqrt (a : ℝ) * Real.sqrt a) := by ring
            _ = _ := by rw [Real.mul_self_sqrt (Nat.cast_nonneg a)]
    _ = _ := by
      simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast,
        Finset.mul_sum, div_eq_mul_inv]

private theorem harmonic_nonneg_real (X : ℕ) : (0 : ℝ) ≤ harmonic X := by
  simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
  exact Finset.sum_nonneg (fun _ _ => by positivity)

private theorem harmonic_mono_real {X Y : ℕ} (h : X ≤ Y) :
    (harmonic X : ℝ) ≤ harmonic Y := by
  simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
  exact Finset.sum_le_sum_of_subset_of_nonneg
    (Finset.Icc_subset_Icc le_rfl h) (fun _ _ _ => by positivity)

/-- An enabling scalar estimate from the pointwise mass dichotomy. The
application must separately supply its actual mass and rootwise cost bounds. -/
theorem small_mass_cost_bound (X Y : ℕ) {L : ℝ} (hL : 0 ≤ L)
    (mass cost : ℕ → ℝ)
    (hcost : ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (n.divisors.card : ℝ) * L * mass n)
    (hearly : ∀ n ∈ Finset.Icc 1 X, n ≤ 2 * Y → mass n ≤ 1)
    (hlate : ∀ n ∈ Finset.Icc 1 X, 2 * Y < n → mass n ≤ 2 * (Y : ℝ) / n) :
    (∑ n ∈ Finset.Icc 1 X, cost n) ≤
      2 * (Y : ℝ) * L * (harmonic X : ℝ) * (1 + (harmonic X : ℝ)) := by
  have hs : (∑ n ∈ Finset.Icc 1 X,
      if n ≤ 2 * Y then (n.divisors.card : ℝ) else 0) ≤
        2 * (Y : ℝ) * (harmonic X : ℝ) := by
    rw [← Finset.sum_filter]
    have hf : (Finset.Icc 1 X).filter (fun n => n ≤ 2 * Y) =
        Finset.Icc 1 (min X (2 * Y)) := by
      ext n
      simp only [Finset.mem_filter, Finset.mem_Icc, le_min_iff]
      omega
    rw [hf]
    calc
      _ ≤ (min X (2 * Y) : ℕ) * (harmonic (min X (2 * Y)) : ℝ) :=
        divisorCard_sum_le_mul_harmonic _
      _ ≤ (2 * Y : ℕ) * (harmonic X : ℝ) :=
        mul_le_mul (by exact_mod_cast min_le_right X (2 * Y))
          (harmonic_mono_real (min_le_left _ _)) (harmonic_nonneg_real _)
          (by positivity)
      _ = _ := by push_cast; ring
  have hp : ∀ n ∈ Finset.Icc 1 X, cost n ≤
      L * (if n ≤ 2 * Y then (n.divisors.card : ℝ) else 0) +
        (2 * (Y : ℝ) * L) * ((n.divisors.card : ℝ) / n) := by
    intro n hn
    by_cases h : n ≤ 2 * Y
    · rw [if_pos h]
      have hu := mul_le_mul_of_nonneg_left (hearly n hn h)
        (by positivity : 0 ≤ (n.divisors.card : ℝ) * L)
      have hh := (hcost n hn).trans hu
      have hz : 0 ≤ (2 * (Y : ℝ) * L) * ((n.divisors.card : ℝ) / n) := by positivity
      nlinarith
    · rw [if_neg h, mul_zero, zero_add]
      calc
        _ ≤ (n.divisors.card : ℝ) * L * (2 * (Y : ℝ) / n) :=
          (hcost n hn).trans (mul_le_mul_of_nonneg_left (hlate n hn (by omega))
            (by positivity))
        _ = _ := by ring
  calc
    _ ≤ ∑ n ∈ Finset.Icc 1 X,
        (L * (if n ≤ 2 * Y then (n.divisors.card : ℝ) else 0) +
          (2 * (Y : ℝ) * L) * ((n.divisors.card : ℝ) / n)) :=
      Finset.sum_le_sum hp
    _ = L * (∑ n ∈ Finset.Icc 1 X,
          if n ≤ 2 * Y then (n.divisors.card : ℝ) else 0) +
        (2 * (Y : ℝ) * L) *
          (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ) / n) := by
      rw [Finset.sum_add_distrib, Finset.mul_sum, Finset.mul_sum]
    _ ≤ L * (2 * (Y : ℝ) * (harmonic X : ℝ)) +
        (2 * (Y : ℝ) * L) * (harmonic X : ℝ) ^ 2 :=
      add_le_add (mul_le_mul_of_nonneg_left hs hL)
        (mul_le_mul_of_nonneg_left (divisorCard_harmonic_bound X) (by positivity))
    _ = _ := by ring

/-- An enabling scalar estimate from the moving-band mass bound. -/
theorem recent_mass_cost_bound (X : ℕ) {L : ℝ} (hL : 0 ≤ L)
    (mass cost : ℕ → ℝ)
    (hcost : ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (n.divisors.card : ℝ) * L * mass n)
    (hmass : ∀ n ∈ Finset.Icc 1 X,
      mass n ≤ 2 * (harmonic n : ℝ) / Real.sqrt n) :
    (∑ n ∈ Finset.Icc 1 X, cost n) ≤
      4 * Real.sqrt X * (harmonic X : ℝ) ^ 2 * L := by
  have hp : ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (2 * (harmonic X : ℝ) * L) *
        ((n.divisors.card : ℝ) / Real.sqrt n) := by
    intro n hn
    have hm : mass n ≤ 2 * (harmonic X : ℝ) / Real.sqrt n :=
      (hmass n hn).trans (div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_left (harmonic_mono_real (Finset.mem_Icc.mp hn).2)
          (by norm_num)) (Real.sqrt_nonneg _))
    calc
      _ ≤ (n.divisors.card : ℝ) * L *
          (2 * (harmonic X : ℝ) / Real.sqrt n) :=
        (hcost n hn).trans (mul_le_mul_of_nonneg_left hm (by positivity))
      _ = _ := by ring
  calc
    _ ≤ ∑ n ∈ Finset.Icc 1 X,
        (2 * (harmonic X : ℝ) * L) * ((n.divisors.card : ℝ) / Real.sqrt n) :=
      Finset.sum_le_sum hp
    _ = (2 * (harmonic X : ℝ) * L) *
        (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ) / Real.sqrt n) := by
      rw [Finset.mul_sum]
    _ ≤ (2 * (harmonic X : ℝ) * L) *
        (2 * Real.sqrt X * (harmonic X : ℝ)) :=
      mul_le_mul_of_nonneg_left (divisorCard_inv_sqrt_sum_le X)
        (mul_nonneg (mul_nonneg (by norm_num) (harmonic_nonneg_real X)) hL)
    _ = _ := by ring

private theorem log_cost_le_fixed_cost (X : ℕ) (mass cost : ℕ → ℝ)
    (hzero : ∀ n ∈ Finset.Icc 1 X, 0 ≤ mass n)
    (hcost : ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (n.divisors.card : ℝ) * Real.log n * mass n) :
    ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (n.divisors.card : ℝ) * Real.log X * mass n := by
  intro n hn
  have hn0 : (0 : ℝ) < n := by
    exact_mod_cast (Finset.mem_Icc.mp hn).1
  have hlog : Real.log (n : ℝ) ≤ Real.log X :=
    Real.log_le_log hn0 (by exact_mod_cast (Finset.mem_Icc.mp hn).2)
  exact (hcost n hn).trans (mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_left hlog (by positivity)) (hzero n hn))

/-- Small-range aggregation with the actual pointwise logarithmic cost. -/
theorem small_mass_log_cost_bound {X Y : ℕ} (hX : 1 ≤ X)
    (mass cost : ℕ → ℝ)
    (hzero : ∀ n ∈ Finset.Icc 1 X, 0 ≤ mass n)
    (hcost : ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (n.divisors.card : ℝ) * Real.log n * mass n)
    (hearly : ∀ n ∈ Finset.Icc 1 X, n ≤ 2 * Y → mass n ≤ 1)
    (hlate : ∀ n ∈ Finset.Icc 1 X, 2 * Y < n → mass n ≤ 2 * (Y : ℝ) / n) :
    (∑ n ∈ Finset.Icc 1 X, cost n) ≤
      2 * (Y : ℝ) * Real.log X * (harmonic X : ℝ) * (1 + (harmonic X : ℝ)) :=
  small_mass_cost_bound X Y (Real.log_nonneg (by exact_mod_cast hX)) mass cost
    (log_cost_le_fixed_cost X mass cost hzero hcost) hearly hlate

/-- Recent-range aggregation with the actual pointwise logarithmic cost. -/
theorem recent_mass_log_cost_bound {X : ℕ} (hX : 1 ≤ X)
    (mass cost : ℕ → ℝ)
    (hzero : ∀ n ∈ Finset.Icc 1 X, 0 ≤ mass n)
    (hcost : ∀ n ∈ Finset.Icc 1 X,
      cost n ≤ (n.divisors.card : ℝ) * Real.log n * mass n)
    (hmass : ∀ n ∈ Finset.Icc 1 X,
      mass n ≤ 2 * (harmonic n : ℝ) / Real.sqrt n) :
    (∑ n ∈ Finset.Icc 1 X, cost n) ≤
      4 * Real.sqrt X * (harmonic X : ℝ) ^ 2 * Real.log X :=
  recent_mass_cost_bound X (Real.log_nonneg (by exact_mod_cast hX)) mass cost
    (log_cost_le_fixed_cost X mass cost hzero hcost) hmass

end BuildingBlocks.CyclotomicBoundary
