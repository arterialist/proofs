import BuildingBlocks.MeanCorrection

/-!
# Prime-state bounds and renewal-arch geometry

This file is deliberately not imported by `BuildingBlocks.lean`.  It records the
elementary, unconditional content of the prime-state projector argument without
adding an RH-strength hypothesis.
-/

namespace BuildingBlocks.PrimeStateAndRenewalArch

open scoped BigOperators

/-- The sharp normalized composite-state ceiling from the hard-wall argument. -/
noncomputable def cStar : ℝ := (1 + (Real.sqrt (2 : ℝ))⁻¹) / 2

theorem sqrt_two_pos : 0 < Real.sqrt (2 : ℝ) := Real.sqrt_pos.2 (by norm_num)

theorem inv_sqrt_two_lt_one : (Real.sqrt (2 : ℝ))⁻¹ < 1 := by
  have hs0 : 0 ≤ Real.sqrt (2 : ℝ) := Real.sqrt_nonneg _
  have hs2 : (Real.sqrt (2 : ℝ)) ^ 2 = 2 := by norm_num
  have hs : 1 < Real.sqrt (2 : ℝ) := by nlinarith
  exact inv_lt_one_of_one_lt₀ hs

theorem cStar_nonneg : 0 ≤ cStar := by
  unfold cStar
  positivity

theorem cStar_lt_one : cStar < 1 := by
  have h := inv_sqrt_two_lt_one
  unfold cStar
  rw [div_lt_iff₀ (by norm_num : (0 : ℝ) < 2)]
  linarith

/-- A finite weighted collection of composite coordinates below `cStar` stays
below `cStar` after aggregation.  This is the algebraic core of the hard wall. -/
theorem weighted_hard_wall
    {ι : Type*} [Fintype ι] (w r : ι → ℝ)
    (hw : ∀ i, 0 ≤ w i) (hr : ∀ i, r i ≤ cStar) :
    ∑ i, w i * r i ≤ cStar * ∑ i, w i := by
  calc
    ∑ i, w i * r i ≤ ∑ i, w i * cStar :=
      Finset.sum_le_sum fun i _ => mul_le_mul_of_nonneg_left (hr i) (hw i)
    _ = cStar * ∑ i, w i := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun i _ => by ring

/-- Powers of a normalized composite state converge uniformly at the geometric
rate `cStar ^ k`. -/
theorem projector_power_bound {r : ℝ} (hr0 : 0 ≤ r) (hr : r ≤ cStar) (k : ℕ) :
    0 ≤ r ^ k ∧ r ^ k ≤ cStar ^ k := by
  exact ⟨pow_nonneg hr0 k, pow_le_pow_left₀ hr0 hr k⟩

/-- Abstract finite-set form of the prime-projector error estimate. -/
theorem finite_projector_error
    {α : Type*} [DecidableEq α]
    (s primes : Finset α) (r : α → ℝ) (k : ℕ)
    (hsub : primes ⊆ s)
    (hp : ∀ a ∈ primes, r a = 1)
    (hc0 : ∀ a ∈ s \ primes, 0 ≤ r a)
    (hc : ∀ a ∈ s \ primes, r a ≤ cStar) :
    0 ≤ (∑ a ∈ s, r a ^ k) - (primes.card : ℝ) ∧
      (∑ a ∈ s, r a ^ k) - (primes.card : ℝ)
        ≤ ((s \ primes).card : ℝ) * cStar ^ k := by
  have hsplit : ∑ a ∈ s, r a ^ k =
      (∑ a ∈ primes, r a ^ k) + ∑ a ∈ s \ primes, r a ^ k := by
    simpa only [add_comm] using
      (Finset.sum_sdiff (f := fun a => r a ^ k) hsub).symm
  rw [hsplit]
  have hprime : ∑ a ∈ primes, r a ^ k = (primes.card : ℝ) := by
    calc
      ∑ a ∈ primes, r a ^ k = ∑ _a ∈ primes, (1 : ℝ) := by
        apply Finset.sum_congr rfl
        intro a ha
        rw [hp a ha, one_pow]
      _ = (primes.card : ℝ) := by simp
  rw [hprime]
  simp only [add_sub_cancel_left]
  constructor
  · exact Finset.sum_nonneg fun a ha => pow_nonneg (hc0 a ha) k
  · calc
      ∑ a ∈ s \ primes, r a ^ k ≤ ∑ _a ∈ s \ primes, cStar ^ k := by
        apply Finset.sum_le_sum
        intro a ha
        exact (projector_power_bound (hc0 a ha) (hc a ha) k).2
      _ = ((s \ primes).card : ℝ) * cStar ^ k := by simp

/-! ## Exact geometry of one renewal arch -/

/-- Normal form of the within-cell arch after writing
`Aₙ = q y`, with `q = 2 * sqrt n`. -/
noncomputable def renewalArch (q y t : ℝ) : ℝ :=
  q * y * t - 2 * q * (Real.exp (t / 2) - 1)

/-- The unique stationary time of a renewal arch. -/
noncomputable def renewalArchMaxTime (y : ℝ) : ℝ := 2 * Real.log y

theorem renewalArch_at_max (q y : ℝ) (hy : 0 < y) :
    renewalArch q y (renewalArchMaxTime y) =
      2 * q * (y * Real.log y - y + 1) := by
  rw [renewalArch, renewalArchMaxTime]
  have he : Real.exp ((2 * Real.log y) / 2) = y := by
    rw [show (2 * Real.log y) / 2 = Real.log y by ring, Real.exp_log hy]
  rw [he]
  ring

/-- Exact global maximality.  It uses only `log u ≤ u - 1`; no zeta or RH
input occurs here. -/
theorem renewalArch_le_at_max (q y t : ℝ) (hq : 0 ≤ q) (hy : 0 < y) :
    renewalArch q y t ≤ renewalArch q y (renewalArchMaxTime y) := by
  have heu : 0 < Real.exp (t / 2) := Real.exp_pos _
  have hratio : 0 < Real.exp (t / 2) / y := div_pos heu hy
  have hlog := Real.log_le_sub_one_of_pos hratio
  have hscaled : y * (t / 2 - Real.log y) ≤ Real.exp (t / 2) - y := by
    calc
      y * (t / 2 - Real.log y) =
          y * Real.log (Real.exp (t / 2) / y) := by
            rw [Real.log_div (ne_of_gt heu) (ne_of_gt hy), Real.log_exp]
      _ ≤ y * (Real.exp (t / 2) / y - 1) :=
        mul_le_mul_of_nonneg_left hlog (le_of_lt hy)
      _ = Real.exp (t / 2) - y := by field_simp
  rw [renewalArch_at_max q y hy]
  dsimp [renewalArch]
  nlinarith

/-- The exact maximizer lies strictly inside a cell `(0, log(1+x))` as
soon as `1 < y` and `y² < 1+x`. -/
theorem renewalArch_maxTime_mem_cell
    (x y : ℝ) (hy : 1 < y) (hxy : y ^ 2 < 1 + x) :
    0 < renewalArchMaxTime y ∧ renewalArchMaxTime y < Real.log (1 + x) := by
  have hy0 : 0 < y := lt_trans (by norm_num) hy
  have hy2 : 0 < y ^ 2 := sq_pos_of_pos hy0
  have hx0 : 0 < 1 + x := lt_trans hy2 hxy
  constructor
  · dsimp [renewalArchMaxTime]
    exact mul_pos (by norm_num) (Real.log_pos hy)
  · have hlog : Real.log (y ^ 2) < Real.log (1 + x) :=
      Real.strictMonoOn_log hy2 hx0 hxy
    rw [show y ^ 2 = y * y by ring,
      Real.log_mul (ne_of_gt hy0) (ne_of_gt hy0)] at hlog
    dsimp [renewalArchMaxTime]
    linarith

end BuildingBlocks.PrimeStateAndRenewalArch
