import BuildingBlocks.PairedScatteringDefect
import BuildingBlocks.CompactLocalScatteringSigns
import Mathlib.Tactic.FieldSimp
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Normed.Group.InfiniteSum
import Mathlib.Topology.Algebra.InfiniteSum.Ring

namespace BuildingBlocks.GrowingPrimeScatteringBounds

noncomputable def originalHistory (p : ℝ) (z : ℂ) (M : ℕ) : ℂ :=
  -(p : ℂ) ^ (z - 1 / 2) +
    (1 - (p : ℂ)⁻¹) * ∑ j ∈ Finset.range M,
      (p : ℂ) ^ (-(j : ℂ) * (z + 1 / 2))

noncomputable def originalDefect (p : ℝ) (z : ℂ) (M : ℕ) : ℂ :=
  (1 - (p : ℂ)⁻¹) * (p : ℂ) ^ (-(M : ℂ) * (z + 1 / 2)) /
    (1 - (p : ℂ) ^ (z - 1 / 2))

theorem full_power_dictionary {p : ℝ} (hp : 0 < p) (z : ℂ) :
    (p : ℂ) ^ (z - 1 / 2) =
      ((1 / Real.sqrt p : ℝ) : ℂ) * Complex.exp (z * Real.log p) := by
  rw [BuildingBlocks.ChargeFrozenFourier.real_cpow_eq_exp_log hp]
  rw [show (z - 1 / 2) * (Real.log p : ℂ) =
    -(1 / 2 : ℂ) * (Real.log p : ℂ) + z * Real.log p by ring,
    Complex.exp_add, BuildingBlocks.CompactLocalScatteringSigns.half_decay_exp hp]

theorem full_history_power_dictionary {p : ℝ} (hp : 0 < p) (z : ℂ) (j : ℕ) :
    (p : ℂ) ^ (-(j : ℂ) * (z + 1 / 2)) =
      (((1 / Real.sqrt p : ℝ) : ℂ) * Complex.exp (-(z * Real.log p))) ^ j := by
  rw [show -(j : ℂ) * (z + 1 / 2) = (j : ℂ) * (-z - 1 / 2) by ring,
    Complex.cpow_nat_mul, full_power_dictionary hp (-z), neg_mul]

theorem inverse_parameter_dictionary {p : ℝ} (hp : 0 < p) :
    (((1 / Real.sqrt p : ℝ) : ℂ)) ^ 2 = (p : ℂ)⁻¹ := by
  have he : (1 / Real.sqrt p : ℝ) ^ 2 = p⁻¹ := by
    rw [div_pow, one_pow, Real.sq_sqrt hp.le]
    simp
  exact_mod_cast he

theorem full_history_dictionary {p : ℝ} (hp : 0 < p) (z : ℂ) (M : ℕ) :
    originalHistory p z M = BuildingBlocks.PairedScatteringDefect.multiplier
      (((1 / Real.sqrt p : ℝ) : ℂ))
      (Complex.exp (z * Real.log p)) (Complex.exp (-(z * Real.log p))) M := by
  unfold originalHistory BuildingBlocks.PairedScatteringDefect.multiplier
  rw [full_power_dictionary hp, inverse_parameter_dictionary hp, neg_mul]
  congr 2
  apply Finset.sum_congr rfl
  intro j _
  exact full_history_power_dictionary hp z j

noncomputable def tail (r x y : ℂ) (M : ℕ) : ℂ :=
  (1 - r ^ 2) * (r * y) ^ M / (1 - r * x)

theorem multiplier_tail_factorization (r x y : ℂ) (hxy : x * y = 1)
    (hx : 1 - r * x ≠ 0) (hy : 1 - r * y ≠ 0) (M : ℕ) :
    BuildingBlocks.PairedScatteringDefect.multiplier r x y M =
      ((1 - r * x) / (1 - r * y)) * (1 - tail r x y M) := by
  have hp : (r * y) * (r * x) = r ^ 2 := by
    calc
      _ = r ^ 2 * (x * y) := by ring
      _ = _ := by rw [hxy, mul_one]
  simpa only [BuildingBlocks.PairedScatteringDefect.multiplier, hp, tail, neg_mul]
    using BuildingBlocks.CompactLocalScatteringSigns.finite_history_factorization hy hx M

theorem paired_tail_factorization (r x y : ℂ) (hxy : x * y = 1)
    (hx : 1 - r * x ≠ 0) (hy : 1 - r * y ≠ 0) (M : ℕ) :
    BuildingBlocks.PairedScatteringDefect.multiplier r x y M *
      BuildingBlocks.PairedScatteringDefect.multiplier r y x M =
      (1 - tail r x y M) * (1 - tail r y x M) := by
  rw [multiplier_tail_factorization r x y hxy hx hy,
    multiplier_tail_factorization r y x (by simpa [mul_comm] using hxy) hy hx]
  field_simp

theorem tail_norm_bound (r : ℝ) (x y : ℂ) (M : ℕ) (hr : 0 ≤ r)
    (hr1 : r ≤ 1) (q : ℝ) (hq0 : 0 ≤ q) (hq1 : q < 1)
    (hx : ‖(r : ℂ) * x‖ ≤ q) (hy : ‖(r : ℂ) * y‖ ≤ q) :
    ‖tail (r : ℂ) x y M‖ ≤ q ^ M / (1 - q) := by
  have hc : 0 ≤ 1 - r ^ 2 := by nlinarith
  have hc1 : 1 - r ^ 2 ≤ 1 := by nlinarith [sq_nonneg r]
  have hd : 1 - q ≤ ‖1 - (r : ℂ) * x‖ := by
    have hh := norm_sub_norm_le (1 : ℂ) ((r : ℂ) * x)
    simp only [norm_one] at hh
    linarith
  have hd0 : 0 < ‖1 - (r : ℂ) * x‖ := lt_of_lt_of_le (sub_pos.mpr hq1) hd
  have hcn : ‖(1 : ℂ) - (r : ℂ) ^ 2‖ = 1 - r ^ 2 := by
    norm_cast
    rw [Real.norm_eq_abs, abs_of_nonneg hc]
  unfold tail
  rw [norm_div, norm_mul, norm_pow, hcn]
  have hn : (1 - r ^ 2) * ‖(r : ℂ) * y‖ ^ M ≤ q ^ M := by
    calc
      _ ≤ 1 * ‖(r : ℂ) * y‖ ^ M :=
        mul_le_mul_of_nonneg_right hc1 (pow_nonneg (norm_nonneg _) _)
      _ ≤ q ^ M := by simpa using pow_le_pow_left₀ (norm_nonneg _) hy M
  exact div_le_div₀ (pow_nonneg hq0 M) hn (sub_pos.mpr hq1) hd

theorem product_defect_bound {ι : Type*} (s : Finset ι) (d : ι → ℂ) :
    ‖(∏ i ∈ s, (1 - d i)) - 1‖ ≤ (∏ i ∈ s, (1 + ‖d i‖)) - 1 := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert a s ha ih =>
    rw [Finset.prod_insert ha, Finset.prod_insert ha]
    have hn : ‖∏ i ∈ s, (1 - d i)‖ ≤ ∏ i ∈ s, (1 + ‖d i‖) := by
      have hh := norm_add_le ((∏ i ∈ s, (1 - d i)) - 1) (1 : ℂ)
      simp only [sub_add_cancel, norm_one] at hh
      linarith
    have he : (1 - d a) * (∏ i ∈ s, (1 - d i)) - 1 =
        ((∏ i ∈ s, (1 - d i)) - 1) - d a * (∏ i ∈ s, (1 - d i)) := by ring
    rw [he]
    have ht := norm_sub_le ((∏ i ∈ s, (1 - d i)) - 1)
      (d a * (∏ i ∈ s, (1 - d i)))
    rw [norm_mul] at ht
    have hm := mul_le_mul_of_nonneg_left hn (norm_nonneg (d a))
    nlinarith

theorem product_defect_exp_bound {ι : Type*} (s : Finset ι) (d : ι → ℂ) :
    ‖(∏ i ∈ s, (1 - d i)) - 1‖ ≤ Real.exp (∑ i ∈ s, ‖d i‖) - 1 := by
  have hp : (∏ i ∈ s, (1 + ‖d i‖)) ≤ ∏ i ∈ s, Real.exp ‖d i‖ := by
    apply Finset.prod_le_prod
    · intro i _
      positivity
    · intro i _
      simpa [add_comm] using Real.add_one_le_exp ‖d i‖
  rw [← Real.exp_sum] at hp
  exact le_trans (product_defect_bound s d) (sub_le_sub_right hp 1)

noncomputable def paired (p : ℕ) (z : ℂ) (M : ℕ) : ℂ :=
  BuildingBlocks.PairedScatteringDefect.multiplier
      ((1 / Real.sqrt (p : ℝ) : ℝ) : ℂ)
      (Complex.exp (z * Real.log (p : ℝ)))
      (Complex.exp (-(z * Real.log (p : ℝ)))) M *
    BuildingBlocks.PairedScatteringDefect.multiplier
      ((1 / Real.sqrt (p : ℝ) : ℝ) : ℂ)
      (Complex.exp (-(z * Real.log (p : ℝ))))
      (Complex.exp (z * Real.log (p : ℝ))) M

noncomputable def actualTail (p : ℕ) (z : ℂ) (M : ℕ) : ℂ :=
  tail ((1 / Real.sqrt (p : ℝ) : ℝ) : ℂ)
    (Complex.exp (z * Real.log (p : ℝ)))
    (Complex.exp (-(z * Real.log (p : ℝ)))) M

theorem actual_tail_original_dictionary (p : ℕ) (hp : 2 ≤ p) (z : ℂ) (M : ℕ) :
    actualTail p z M = originalDefect (p : ℝ) z M := by
  have hp0 : (0 : ℝ) < p := by exact_mod_cast (show 0 < p by omega)
  unfold actualTail tail originalDefect
  rw [full_history_power_dictionary hp0, full_power_dictionary hp0,
    inverse_parameter_dictionary hp0]

theorem actual_paired_original_dictionary (p : ℕ) (hp : 2 ≤ p) (z : ℂ) (M : ℕ) :
    paired p z M = originalHistory (p : ℝ) z M * originalHistory (p : ℝ) (-z) M := by
  have hp0 : (0 : ℝ) < p := by exact_mod_cast (show 0 < p by omega)
  rw [full_history_dictionary hp0, full_history_dictionary hp0]
  simp only [paired, neg_mul, neg_neg]

theorem actual_scaled_norm (p : ℕ) (hp : 2 ≤ p) (z : ℂ) :
    ‖((1 / Real.sqrt (p : ℝ) : ℝ) : ℂ) *
      Complex.exp (z * Real.log (p : ℝ))‖ =
        Real.exp ((z.re - 1 / 2) * Real.log (p : ℝ)) := by
  obtain ⟨hr, _, _, hL⟩ := BuildingBlocks.PairedScatteringDefect.actual_parameters p hp
  have hre : (1 / Real.sqrt (p : ℝ)) = Real.exp (-(Real.log (p : ℝ) / 2)) := by
    rw [Real.exp_neg, hL, inv_inv]
  rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr, Complex.norm_exp]
  simp only [Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, mul_zero, sub_zero]
  rw [hre, ← Real.exp_add]
  congr 1
  ring

theorem actual_interior_decay (p : ℕ) (hp : 2 ≤ p) (z : ℂ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖((1 / Real.sqrt (p : ℝ) : ℝ) : ℂ) *
      Complex.exp (z * Real.log (p : ℝ))‖ ≤ Real.exp (-delta * Real.log (p : ℝ)) ∧
    ‖((1 / Real.sqrt (p : ℝ) : ℝ) : ℂ) *
      Complex.exp (-(z * Real.log (p : ℝ)))‖ ≤ Real.exp (-delta * Real.log (p : ℝ)) ∧
    Real.exp (-delta * Real.log (p : ℝ)) < 1 := by
  have hp1 : (1 : ℝ) < p := by exact_mod_cast (show 1 < p by omega)
  have hL : 0 < Real.log (p : ℝ) := Real.log_pos hp1
  have hu := (abs_le.mp hz).2
  have hl := (abs_le.mp hz).1
  refine ⟨?_, ?_, Real.exp_lt_one_iff.mpr (by nlinarith)⟩
  · rw [actual_scaled_norm p hp z]
    apply Real.exp_le_exp.mpr
    nlinarith
  · have he : -(z * (Real.log (p : ℝ) : ℂ)) = (-z) * Real.log (p : ℝ) := by ring
    rw [he, actual_scaled_norm p hp (-z)]
    simp only [Complex.neg_re]
    apply Real.exp_le_exp.mpr
    nlinarith

theorem actual_tail_decay (p : ℕ) (hp : 2 ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖actualTail p z M‖ ≤
      Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
        (1 - Real.exp (-delta * Real.log (p : ℝ))) := by
  obtain ⟨hr, hr1, _, _⟩ := BuildingBlocks.PairedScatteringDefect.actual_parameters p hp
  obtain ⟨hx, hy, hq⟩ := actual_interior_decay p hp z delta hd hz
  have hb := tail_norm_bound (1 / Real.sqrt (p : ℝ))
    (Complex.exp (z * Real.log (p : ℝ)))
    (Complex.exp (-(z * Real.log (p : ℝ)))) M (le_of_lt hr) hr1
    (Real.exp (-delta * Real.log (p : ℝ))) (le_of_lt (Real.exp_pos _)) hq hx hy
  have he : Real.exp (-delta * Real.log (p : ℝ)) ^ M =
      Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) := by
    rw [← Real.exp_nat_mul]
    congr 1
    ring
  simpa only [actualTail, he] using hb

theorem actual_paired_tail_factorization (p : ℕ) (hp : 2 ≤ p) (z : ℂ)
    (M : ℕ) (delta : ℝ) (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    paired p z M = (1 - actualTail p z M) * (1 - actualTail p (-z) M) := by
  obtain ⟨hx, hy, hq⟩ := actual_interior_decay p hp z delta hd hz
  have hn {w : ℂ} (hw : ‖w‖ ≤ Real.exp (-delta * Real.log (p : ℝ))) :
      1 - w ≠ 0 := by
    intro he
    have hew : w = 1 := (sub_eq_zero.mp he).symm
    rw [hew, norm_one] at hw
    linarith
  have hexy : Complex.exp (z * Real.log (p : ℝ)) *
      Complex.exp (-(z * Real.log (p : ℝ))) = 1 := by
    rw [← Complex.exp_add]
    simp
  have hf := paired_tail_factorization
    (((1 / Real.sqrt (p : ℝ)) : ℝ) : ℂ)
    (Complex.exp (z * Real.log (p : ℝ)))
    (Complex.exp (-(z * Real.log (p : ℝ)))) hexy (hn hx) (hn hy) M
  simpa only [paired, actualTail, neg_mul, neg_neg] using hf

theorem paired_defect_norm (d e : ℂ) :
    ‖(1 - d) * (1 - e) - 1‖ ≤ ‖d‖ + ‖e‖ + ‖d‖ * ‖e‖ := by
  have he : (1 - d) * (1 - e) - 1 = (-d - e) + d * e := by ring
  rw [he]
  have ha := norm_add_le (-d - e) (d * e)
  have hs := norm_sub_le (-d) e
  simp only [norm_mul, norm_neg] at *
  linarith

/-- Fully explicit interior tail budget; a zero-free gap is still required
to specialize delta to actual low-height zeta zeros. -/
theorem actual_block_interior_comparison (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖(∏ p ∈ s, paired p z M) - 1‖ ≤
      Real.exp (∑ p ∈ s,
        let B := Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
          (1 - Real.exp (-delta * Real.log (p : ℝ)))
        2 * B + B ^ 2) - 1 := by
  have hb := product_defect_exp_bound s (fun p => 1 - paired p z M)
  simp only [sub_sub_cancel] at hb
  apply le_trans hb
  apply sub_le_sub_right
  apply Real.exp_le_exp.mpr
  apply Finset.sum_le_sum
  intro p hp
  let B := Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
    (1 - Real.exp (-delta * Real.log (p : ℝ)))
  have ht := actual_tail_decay p (hs p hp) z M delta hd hz
  have hu := actual_tail_decay p (hs p hp) (-z) M delta hd
    (by simpa only [Complex.neg_re, abs_neg] using hz)
  have hB : 0 ≤ B := le_trans (norm_nonneg _) ht
  have hn := paired_defect_norm (actualTail p z M) (actualTail p (-z) M)
  have hm := mul_le_mul ht hu (norm_nonneg _) hB
  have he : ‖1 - paired p z M‖ = ‖paired p z M - 1‖ := norm_sub_rev _ _
  rw [he, actual_paired_tail_factorization p (hs p hp) z M delta hd hz]
  change ‖(1 - actualTail p z M) * (1 - actualTail p (-z) M) - 1‖ ≤ 2 * B + B ^ 2
  change ‖actualTail p z M‖ ≤ B at ht
  change ‖actualTail p (-z) M‖ ≤ B at hu
  change ‖actualTail p z M‖ * ‖actualTail p (-z) M‖ ≤ B * B at hm
  nlinarith

theorem original_tail_decay (p : ℕ) (hp : 2 ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖originalDefect (p : ℝ) z M‖ ≤
      Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
        (1 - Real.exp (-delta * Real.log (p : ℝ))) := by
  rw [← actual_tail_original_dictionary p hp z M]
  exact actual_tail_decay p hp z M delta hd hz

theorem original_block_interior_comparison (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖(∏ p ∈ s, originalHistory (p : ℝ) z M * originalHistory (p : ℝ) (-z) M) - 1‖ ≤
      Real.exp (∑ p ∈ s,
        let B := Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
          (1 - Real.exp (-delta * Real.log (p : ℝ)))
        2 * B + B ^ 2) - 1 := by
  have he : (∏ p ∈ s, paired p z M) =
      ∏ p ∈ s, originalHistory (p : ℝ) z M * originalHistory (p : ℝ) (-z) M := by
    apply Finset.prod_congr rfl
    intro p hp
    exact actual_paired_original_dictionary p (hs p hp) z M
  rw [← he]
  exact actual_block_interior_comparison s hs z M delta hd hz

theorem actual_block_bound (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p)
    (z : ℂ) (hz : |z.re| ≤ 1 / 2) (M : ℕ) :
    ‖∏ p ∈ s, paired p z M‖ ≤ (3 : ℝ) ^ s.card := by
  classical
  calc
    _ = ∏ p ∈ s, ‖paired p z M‖ := norm_prod _ _
    _ ≤ ∏ _p ∈ s, (3 : ℝ) := by
      apply Finset.prod_le_prod
      · intro p _
        exact norm_nonneg _
      · intro p hp
        exact BuildingBlocks.PairedScatteringDefect.norm_paired_actual_prime_le_three
          p (hs p hp) z hz M
    _ = _ := by simp

theorem actual_block_exp_bound (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p)
    (z : ℂ) (hz : |z.re| ≤ 1 / 2) (M : ℕ) :
    ‖∏ p ∈ s, paired p z M‖ ≤ Real.exp ((s.card : ℝ) * Real.log 3) := by
  have he : Real.exp ((s.card : ℝ) * Real.log 3) = (3 : ℝ) ^ s.card := by
    rw [Real.exp_nat_mul, Real.exp_log (by norm_num : (0 : ℝ) < 3)]
  rw [he]
  exact actual_block_bound s hs z hz M

/-- Complex weights retain their signs and both paired orientations. -/
theorem actual_block_weighted_comparison {ι : Type*} (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (t : Finset ι) (z weight : ι → ℂ)
    (hz : ∀ i ∈ t, |(z i).re| ≤ 1 / 2) (M : ℕ) :
    ‖∑ i ∈ t, ((∏ p ∈ s, paired p (z i) M) - 1) * weight i‖ ≤
      ((3 : ℝ) ^ s.card + 1) * ∑ i ∈ t, ‖weight i‖ := by
  calc
    _ ≤ ∑ i ∈ t, ‖((∏ p ∈ s, paired p (z i) M) - 1) * weight i‖ :=
      norm_sum_le _ _
    _ ≤ ∑ i ∈ t, ((3 : ℝ) ^ s.card + 1) * ‖weight i‖ := by
      apply Finset.sum_le_sum
      intro i hi
      rw [norm_mul]
      apply mul_le_mul_of_nonneg_right _ (norm_nonneg _)
      have hb := actual_block_bound s hs (z i) (hz i hi) M
      have ht := norm_sub_le (∏ p ∈ s, paired p (z i) M) (1 : ℂ)
      simp only [norm_one] at ht
      linarith
    _ = _ := by rw [Finset.mul_sum]

theorem actual_block_weighted_summable {ι : Type*} (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (z weight : ι → ℂ)
    (hz : ∀ i, |(z i).re| ≤ 1 / 2) (M : ℕ)
    (hw : Summable (fun i => ‖weight i‖)) :
    Summable (fun i => (∏ p ∈ s, paired p (z i) M) * weight i) := by
  apply (hw.mul_left ((3 : ℝ) ^ s.card)).of_norm_bounded
  intro i
  rw [norm_mul]
  exact mul_le_mul_of_nonneg_right
    (actual_block_bound s hs (z i) (hz i) M) (norm_nonneg _)

theorem actual_block_weighted_tsum_identity {ι : Type*} (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (z weight : ι → ℂ)
    (hz : ∀ i, |(z i).re| ≤ 1 / 2) (M : ℕ)
    (hw : Summable (fun i => ‖weight i‖)) :
    (∑' i, (∏ p ∈ s, paired p (z i) M) * weight i) - (∑' i, weight i) =
      ∑' i, ((∏ p ∈ s, paired p (z i) M) - 1) * weight i := by
  have hf := actual_block_weighted_summable s hs z weight hz M hw
  rw [← hf.tsum_sub hw.of_norm]
  apply tsum_congr
  intro i
  ring

theorem actual_block_weighted_tsum_comparison {ι : Type*} (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (z weight : ι → ℂ)
    (hz : ∀ i, |(z i).re| ≤ 1 / 2) (M : ℕ)
    (hw : Summable (fun i => ‖weight i‖)) :
    ‖(∑' i, (∏ p ∈ s, paired p (z i) M) * weight i) - (∑' i, weight i)‖ ≤
      ((3 : ℝ) ^ s.card + 1) * ∑' i, ‖weight i‖ := by
  rw [actual_block_weighted_tsum_identity s hs z weight hz M hw]
  apply tsum_of_norm_bounded (hw.hasSum.mul_left ((3 : ℝ) ^ s.card + 1))
  intro i
  rw [norm_mul]
  apply mul_le_mul_of_nonneg_right _ (norm_nonneg _)
  have hb := actual_block_bound s hs (z i) (hz i) M
  have ht := norm_sub_le (∏ p ∈ s, paired p (z i) M) (1 : ℂ)
  simp only [norm_one] at ht
  linarith

/-- The low-height multiplier estimate remains an explicit hypothesis.
No sign or critical-line location is assumed for the weights or points. -/
theorem actual_block_low_high_comparison {ι : Type*} (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (z weight : ι → ℂ)
    (hz : ∀ i, |(z i).re| ≤ 1 / 2) (M : ℕ)
    (hw : Summable (fun i => ‖weight i‖)) (low : Set ι) (E : ℝ)
    (hlow : ∀ i ∈ low, ‖(∏ p ∈ s, paired p (z i) M) - 1‖ ≤ E) :
    ‖(∑' i, (∏ p ∈ s, paired p (z i) M) * weight i) - (∑' i, weight i)‖ ≤
      E * (∑' i : low, ‖weight i‖) +
        ((3 : ℝ) ^ s.card + 1) * (∑' i : ↑(lowᶜ), ‖weight i‖) := by
  have hf := actual_block_weighted_summable s hs z weight hz M hw
  have hd : Summable (fun i => ((∏ p ∈ s, paired p (z i) M) - 1) * weight i) := by
    simpa only [sub_mul, one_mul] using hf.sub hw.of_norm
  have hl : ‖∑' i : low, ((∏ p ∈ s, paired p (z i) M) - 1) * weight i‖ ≤
      E * ∑' i : low, ‖weight i‖ := by
    apply tsum_of_norm_bounded ((hw.subtype low).hasSum.mul_left E)
    intro i
    rw [norm_mul]
    exact mul_le_mul_of_nonneg_right (hlow i i.property) (norm_nonneg _)
  have hh := actual_block_weighted_tsum_comparison s hs
    (fun i : ↑(lowᶜ) => z i) (fun i : ↑(lowᶜ) => weight i)
    (fun i => hz i) M (hw.subtype lowᶜ)
  rw [actual_block_weighted_tsum_identity s hs
    (fun i : ↑(lowᶜ) => z i) (fun i : ↑(lowᶜ) => weight i)
    (fun i => hz i) M (hw.subtype lowᶜ)] at hh
  rw [actual_block_weighted_tsum_identity s hs z weight hz M hw,
    ← hd.tsum_subtype_add_tsum_subtype_compl low]
  exact le_trans (norm_add_le _ _) (add_le_add hl hh)

theorem exponential_denominator_bound {x : ℝ} (hx : 0 < x) :
    x / (1 + x) ≤ 1 - Real.exp (-x) := by
  have hm := mul_le_mul_of_nonneg_right (Real.add_one_le_exp x)
    (le_of_lt (Real.exp_pos (-x)))
  rw [← Real.exp_add, add_neg_cancel, Real.exp_zero] at hm
  apply (div_le_iff₀ (by positivity : 0 < 1 + x)).mpr
  nlinarith

theorem decay_budget_mono {x y : ℝ} (hx : 0 < x) (hxy : x ≤ y) (M : ℕ) :
    Real.exp (-(M : ℝ) * y) / (1 - Real.exp (-y)) ≤
      Real.exp (-(M : ℝ) * x) / (1 - Real.exp (-x)) := by
  have hd : 0 < 1 - Real.exp (-x) :=
    sub_pos.mpr (Real.exp_lt_one_iff.mpr (by linarith))
  have hn : Real.exp (-(M : ℝ) * y) ≤ Real.exp (-(M : ℝ) * x) := by
    apply Real.exp_le_exp.mpr
    exact mul_le_mul_of_nonpos_left hxy (neg_nonpos.mpr (Nat.cast_nonneg M))
  have he : 1 - Real.exp (-x) ≤ 1 - Real.exp (-y) := by
    apply sub_le_sub_left
    exact Real.exp_le_exp.mpr (neg_le_neg hxy)
  exact div_le_div₀ (le_of_lt (Real.exp_pos _)) hn hd he

theorem decay_budget_gap_bound {x : ℝ} (hx : 0 < x) (M : ℕ) :
    Real.exp (-(M : ℝ) * x) / (1 - Real.exp (-x)) ≤
      Real.exp (-(M : ℝ) * x) * ((1 + x) / x) := by
  have hd : 0 < x / (1 + x) := div_pos hx (by positivity)
  calc
    _ ≤ Real.exp (-(M : ℝ) * x) / (x / (1 + x)) :=
      div_le_div₀ (le_of_lt (Real.exp_pos _)) le_rfl hd (exponential_denominator_bound hx)
    _ = _ := by field_simp

theorem actual_uniform_tail_bound (p : ℕ) (hp : 2 ≤ p) (P : ℝ)
    (hP : 1 < P) (hPp : P ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖originalDefect (p : ℝ) z M‖ ≤
      Real.exp (-(M : ℝ) * (delta * Real.log P)) *
        ((1 + delta * Real.log P) / (delta * Real.log P)) := by
  have hL : 0 < Real.log P := Real.log_pos hP
  have hx : 0 < delta * Real.log P := mul_pos hd hL
  have hlog : Real.log P ≤ Real.log (p : ℝ) := Real.log_le_log (by linarith) hPp
  have hxy := mul_le_mul_of_nonneg_left hlog (le_of_lt hd)
  have ht := original_tail_decay p hp z M delta hd hz
  have he : -(M : ℝ) * delta * Real.log (p : ℝ) =
      -(M : ℝ) * (delta * Real.log (p : ℝ)) := by ring
  have hen : -delta * Real.log (p : ℝ) = -(delta * Real.log (p : ℝ)) := by ring
  rw [he, hen] at ht
  exact le_trans ht (le_trans (decay_budget_mono hx hxy M) (decay_budget_gap_bound hx M))

theorem actual_uniform_block_comparison (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (P : ℝ) (hP : 1 < P)
    (hPs : ∀ p ∈ s, P ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    let B := Real.exp (-(M : ℝ) * (delta * Real.log P)) *
      ((1 + delta * Real.log P) / (delta * Real.log P))
    ‖(∏ p ∈ s, paired p z M) - 1‖ ≤
      Real.exp ((s.card : ℝ) * (2 * B + B ^ 2)) - 1 := by
  dsimp only
  let B := Real.exp (-(M : ℝ) * (delta * Real.log P)) *
    ((1 + delta * Real.log P) / (delta * Real.log P))
  have hb := product_defect_exp_bound s (fun p => 1 - paired p z M)
  simp only [sub_sub_cancel] at hb
  have ht (p : ℕ) (hp : p ∈ s) (w : ℂ) (hw : |w.re| ≤ 1 / 2 - delta) :
      ‖actualTail p w M‖ ≤ B := by
    rw [actual_tail_original_dictionary p (hs p hp) w M]
    exact actual_uniform_tail_bound p (hs p hp) P hP (hPs p hp) w M delta hd hw
  have hlocal (p : ℕ) (hp : p ∈ s) : ‖1 - paired p z M‖ ≤ 2 * B + B ^ 2 := by
    have h1 := ht p hp z hz
    have h2 := ht p hp (-z) (by simpa only [Complex.neg_re, abs_neg] using hz)
    have hB : 0 ≤ B := le_trans (norm_nonneg _) h1
    have hm := mul_le_mul h1 h2 (norm_nonneg _) hB
    have hn := paired_defect_norm (actualTail p z M) (actualTail p (-z) M)
    rw [norm_sub_rev, actual_paired_tail_factorization p (hs p hp) z M delta hd hz]
    nlinarith
  apply le_trans hb
  apply sub_le_sub_right
  apply Real.exp_le_exp.mpr
  calc
    _ ≤ ∑ _p ∈ s, (2 * B + B ^ 2) := Finset.sum_le_sum hlocal
    _ = _ := by simp [B, mul_add]

#print axioms actual_uniform_block_comparison
#print axioms exponential_denominator_bound
#print axioms decay_budget_mono
#print axioms decay_budget_gap_bound
#print axioms actual_uniform_tail_bound
#print axioms actual_block_low_high_comparison
#print axioms full_power_dictionary
#print axioms full_history_power_dictionary
#print axioms inverse_parameter_dictionary
#print axioms full_history_dictionary
#print axioms actual_tail_original_dictionary
#print axioms actual_paired_original_dictionary
#print axioms original_tail_decay
#print axioms original_block_interior_comparison
#print axioms multiplier_tail_factorization
#print axioms paired_tail_factorization
#print axioms tail_norm_bound
#print axioms actual_scaled_norm
#print axioms actual_interior_decay
#print axioms actual_tail_decay
#print axioms actual_paired_tail_factorization
#print axioms paired_defect_norm
#print axioms actual_block_interior_comparison
#print axioms actual_block_weighted_summable
#print axioms actual_block_weighted_tsum_identity
#print axioms actual_block_weighted_tsum_comparison
#print axioms product_defect_bound
#print axioms product_defect_exp_bound
#print axioms actual_block_bound
#print axioms actual_block_exp_bound
#print axioms actual_block_weighted_comparison
end BuildingBlocks.GrowingPrimeScatteringBounds
