import BuildingBlocks.ChronologicalPowerRatio
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace BuildingBlocks.ChronologicalDivisibility

open BuildingBlocks.ChronologicalPowerRatio

/-- The actual finite chronological tent. A newly born integer has weight zero. -/
noncomputable def S (x : ℝ) : ℝ :=
  ∑ j ∈ Finset.range ⌊x⌋₊, (x - (j + 1)) / Real.sqrt (j + 1)

/-- The same finite tent with an explicit integer cutoff. -/
noncomputable def tent (n : ℕ) (x : ℝ) : ℝ :=
  ∑ j ∈ Finset.range n, (x - (j + 1)) / Real.sqrt (j + 1)

@[simp] theorem tent_zero (x : ℝ) : tent 0 x = 0 := by simp [tent]

theorem tent_succ (n : ℕ) (x : ℝ) :
    tent (n + 1) x = tent n x + (x - (n + 1)) / Real.sqrt (n + 1) := by
  simp [tent, Finset.sum_range_succ]

theorem tent_birth (n : ℕ) : tent (n + 1) (n + 1) = tent n (n + 1) := by
  rw [tent_succ]
  simp

theorem S_eq_tent (x : ℝ) : S x = tent ⌊x⌋₊ x := rfl

theorem S_nonneg {x : ℝ} (hx : 0 ≤ x) : 0 ≤ S x := by
  apply Finset.sum_nonneg
  intro j hj
  apply div_nonneg _ (Real.sqrt_nonneg _)
  have hjn : j + 1 ≤ ⌊x⌋₊ := Nat.succ_le_of_lt (Finset.mem_range.mp hj)
  have hjr : (j : ℝ) + 1 ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hjn
  linarith [Nat.floor_le hx]

theorem S_eq_zero_of_le_one {x : ℝ} (hx : x ≤ 1) : S x = 0 := by
  have hn : ⌊x⌋₊ ≤ 1 := Nat.floor_le_one_of_le_one hx
  rcases Nat.le_one_iff_eq_zero_or_eq_one.mp hn with h | h
  · simp [S, h]
  · have hx' : (1 : ℝ) ≤ x := by
      have := Nat.floor_le (Nat.pos_of_floor_pos (by omega : 0 < ⌊x⌋₊)).le
      simpa [h] using this
    have : x = 1 := le_antisymm hx hx'
    subst x
    norm_num [S]

theorem S_pos {x : ℝ} (hx : 1 < x) : 0 < S x := by
  have hx0 : 0 ≤ x := by linarith
  have hn : 1 ≤ ⌊x⌋₊ := (Nat.le_floor_iff hx0).2 (by simpa using hx.le)
  unfold S
  apply Finset.sum_pos'
  · intro j hj
    apply div_nonneg _ (Real.sqrt_nonneg _)
    have hjn : j + 1 ≤ ⌊x⌋₊ := Nat.succ_le_of_lt (Finset.mem_range.mp hj)
    have hjr : (j : ℝ) + 1 ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hjn
    linarith [Nat.floor_le hx0]
  · refine ⟨0, Finset.mem_range.mpr (by omega), ?_⟩
    simpa using sub_pos.mpr hx

/-- Closed cells include the next integer, whose newly added summand vanishes. -/
theorem S_eq_tent_of_cell {n : ℕ} {x : ℝ} (hlo : (n : ℝ) ≤ x)
    (hhi : x ≤ (n : ℝ) + 1) : S x = tent n x := by
  by_cases heq : x = (n : ℝ) + 1
  · subst x
    rw [S_eq_tent]
    have hf : ⌊(n : ℝ) + 1⌋₊ = n + 1 := by
      rw [← Nat.cast_one, ← Nat.cast_add, Nat.floor_natCast]
    rw [hf]
    exact tent_birth n
  · have hf : ⌊x⌋₊ = n := Nat.floor_eq_iff ((Nat.cast_nonneg n).trans hlo) |>.2
      ⟨hlo, lt_of_le_of_ne hhi heq⟩
    simp [S_eq_tent, hf]

/-- The actual probability of divisibility by the positive integer `r`. -/
noncomputable def probability (r : ℕ) (x : ℝ) : ℝ :=
  Real.sqrt r * S (x / r) / S x

/-- Exact comparison of the two affine ratios on a common closed cell. -/
theorem affine_ratio_le {r a b c d x y : ℝ} (hr : 0 < r) (hxy : x ≤ y)
    (hx : 0 < x * c - d) (hy : 0 < y * c - d)
    (hcross : a * d ≤ r * c * b) :
    (x / r * a - b) / (x * c - d) ≤
      (y / r * a - b) / (y * c - d) := by
  apply (div_le_div_iff₀ hx hy).2
  have hprod := mul_nonneg (sub_nonneg.mpr hxy)
    (div_nonneg (sub_nonneg.mpr hcross) hr.le)
  have hid : (y / r * a - b) * (x * c - d) -
      (x / r * a - b) * (y * c - d) =
      (y - x) * ((r * c * b - a * d) / r) := by
    field_simp
    ring
  linarith

theorem tent_eq_affine (n : ℕ) (x : ℝ) : tent n x = x * A n - B n := by
  simp only [tent, A, B, Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  have hs : Real.sqrt ((j : ℝ) + 1) ≠ 0 := ne_of_gt (by positivity)
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ j + 1 by positivity)
  field_simp
  nlinarith

theorem S_eq_affine_of_cell {n : ℕ} {x : ℝ} (hlo : (n : ℝ) ≤ x)
    (hhi : x ≤ (n : ℝ) + 1) : S x = x * A n - B n := by
  rw [S_eq_tent_of_cell hlo hhi, tent_eq_affine]

theorem cross_coefficient_nonneg {k n : ℕ} {r : ℝ} (hkn : k ≤ n)
    (hsize : (n : ℝ) + 1 ≤ r * ((k : ℝ) + 1)) :
    A k * B n ≤ r * A n * B k := by
  by_cases hk0 : k = 0
  · simp [hk0]
  have hk : 1 ≤ k := by omega
  have hn : 1 ≤ n := hk.trans hkn
  have hratio : B n / D n ≤ B k / D k := by
    rcases eq_or_lt_of_le hkn with heq | hlt
    · subst n
      exact le_rfl
    · exact (normalizedRatio_lt hk hlt).le
  have hc := (div_le_div_iff₀ (D_pos n hn) (D_pos k hk)).mp hratio
  unfold D at hc
  have hb : 0 ≤ B k := by unfold B; positivity
  have hm := mul_le_mul_of_nonneg_left hsize (mul_nonneg (A_nonneg n) hb)
  apply (mul_le_mul_iff_left₀ (show (0 : ℝ) < k + 1 by positivity)).mp
  nlinarith

/-- Gluing closed unit-cell comparisons uses only finite induction. -/
theorem monotoneOn_Ioi_of_cells {f : ℝ → ℝ}
    (hc : ∀ n : ℕ, 1 ≤ n → ∀ x y : ℝ, 1 < x →
      (n : ℝ) ≤ x → x ≤ y → y ≤ (n : ℝ) + 1 → f x ≤ f y) :
    MonotoneOn f (Set.Ioi 1) := by
  have hfinite : ∀ n : ℕ, MonotoneOn f (Set.Ioc 1 ((n : ℝ) + 1)) := by
    intro n
    induction n with
    | zero =>
        intro x hx y hy hxy
        simp only [Nat.cast_zero, zero_add, Set.mem_Ioc] at hx
        linarith
    | succ n ih =>
        intro x hx y hy hxy
        simp only [Set.mem_Ioc, Nat.cast_add, Nat.cast_one] at hx hy
        by_cases hyl : y ≤ (n : ℝ) + 1
        · exact ih ⟨hx.1, hxy.trans hyl⟩ ⟨hy.1, hyl⟩ hxy
        by_cases hxl : (n : ℝ) + 1 ≤ x
        · exact hc (n + 1) (by omega) x y hx.1 (by simpa using hxl) hxy
            (by simpa using hy.2)
        have hmid : 1 < (n : ℝ) + 1 := lt_of_lt_of_le hx.1 (le_of_not_ge hxl)
        have hleft : f x ≤ f ((n : ℝ) + 1) :=
          ih ⟨hx.1, le_of_not_ge hxl⟩ ⟨hmid, le_rfl⟩ (le_of_not_ge hxl)
        have hright : f ((n : ℝ) + 1) ≤ f y :=
          hc (n + 1) (by omega) _ y hmid (by simp) (le_of_not_ge hyl)
            (by simpa using hy.2)
        exact hleft.trans hright
  intro x hx y hy hxy
  have hbound : y ≤ (⌊y⌋₊ : ℝ) + 1 := (Nat.lt_floor_add_one y).le
  exact hfinite ⌊y⌋₊ ⟨hx, hxy.trans hbound⟩ ⟨hy, hbound⟩ hxy

theorem probability_le_of_cell {r n : ℕ} (hr : 1 ≤ r)
    {x y : ℝ} (hx : 1 < x) (hlo : (n : ℝ) ≤ x)
    (hxy : x ≤ y) (hhi : y ≤ (n : ℝ) + 1) :
    probability r x ≤ probability r y := by
  have hrn : 0 < r := by omega
  have hrr : (0 : ℝ) < r := by exact_mod_cast hrn
  have hk : n / r ≤ n := Nat.div_le_self n r
  have hsizen : n + 1 ≤ r * (n / r + 1) :=
    Nat.succ_le_of_lt (Nat.lt_mul_div_succ n hrn)
  have hsize : (n : ℝ) + 1 ≤ (r : ℝ) * ((n / r : ℕ) + 1) := by
    exact_mod_cast hsizen
  have hbase : ((n / r : ℕ) : ℝ) * r ≤ n := by
    exact_mod_cast Nat.div_mul_le_self n r
  have hxlo : ((n / r : ℕ) : ℝ) ≤ x / r :=
    (le_div_iff₀ hrr).2 (hbase.trans hlo)
  have hyhi : y / r ≤ ((n / r : ℕ) : ℝ) + 1 := by
    apply (div_le_iff₀ hrr).2
    nlinarith [hsize]
  have hquot : x / (r : ℝ) ≤ y / r := div_le_div_of_nonneg_right hxy hrr.le
  have hsx := S_eq_affine_of_cell hlo (hxy.trans hhi)
  have hsy := S_eq_affine_of_cell (hlo.trans hxy) hhi
  have hsxr := S_eq_affine_of_cell hxlo (hquot.trans hyhi)
  have hsyr := S_eq_affine_of_cell (hxlo.trans hquot) hyhi
  have hp := affine_ratio_le hrr hxy
    (hsx ▸ S_pos hx) (hsy ▸ S_pos (hx.trans_le hxy))
    (cross_coefficient_nonneg hk hsize)
  unfold probability
  rw [hsxr, hsyr, hsx, hsy]
  simpa only [mul_div_assoc] using
    mul_le_mul_of_nonneg_left hp (Real.sqrt_nonneg (r : ℝ))

/-- Actual integer-dilation probabilities increase with the full successor clock. -/
theorem probability_monotoneOn {r : ℕ} (hr : 1 ≤ r) :
    MonotoneOn (probability r) (Set.Ioi 1) := by
  apply monotoneOn_Ioi_of_cells
  intro n hn x y hx hlo hxy hhi
  exact probability_le_of_cell hr hx hlo hxy hhi

theorem probability_one {x : ℝ} (hx : 1 < x) : probability 1 x = 1 := by
  simp [probability, ne_of_gt (S_pos hx)]

theorem probability_nonneg {r : ℕ} (hr : 1 ≤ r) {x : ℝ} (hx : 1 < x) :
    0 ≤ probability r x := by
  have hq : 0 ≤ S (x / r) := S_nonneg (div_nonneg (by linarith) (by positivity))
  unfold probability
  exact div_nonneg (mul_nonneg (Real.sqrt_nonneg _) hq) (S_pos hx).le

/-- Multiplicative Turan inequality for every actual integer dilation and cutoff. -/
theorem determinant_nonneg {a b : ℕ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    {x : ℝ} (hx : 1 < x) :
    0 ≤ S (x / a) * S (x / b) - S x * S (x / (a * b : ℕ)) := by
  have ha0 : (0 : ℝ) < a := by exact_mod_cast (show 0 < a by omega)
  have hb0 : (0 : ℝ) < b := by exact_mod_cast (show 0 < b by omega)
  have ha1 : (1 : ℝ) ≤ a := by exact_mod_cast ha
  have hb1 : (1 : ℝ) ≤ b := by exact_mod_cast hb
  have hx0 : 0 ≤ x := by linarith
  have hq0 : 0 ≤ x / (a : ℝ) := div_nonneg hx0 ha0.le
  have hdiv : x / (a : ℝ) / b = x / (a * b : ℕ) := by
    rw [div_div, Nat.cast_mul]
  by_cases hq : 1 < x / (a : ℝ)
  · have hqx : x / (a : ℝ) ≤ x := by
      apply (div_le_iff₀ ha0).2
      nlinarith
    have hm := probability_monotoneOn hb hq hx hqx
    unfold probability at hm
    rw [hdiv] at hm
    have hsqrt : 0 < Real.sqrt (b : ℝ) := Real.sqrt_pos.2 hb0
    have hm' : S (x / (a * b : ℕ)) / S (x / a) ≤ S (x / b) / S x := by
      apply (mul_le_mul_iff_right₀ hsqrt).mp
      simpa only [mul_div_assoc] using hm
    have hc := (div_le_div_iff₀ (S_pos hq) (S_pos hx)).mp hm'
    nlinarith
  · have hqle : x / (a : ℝ) ≤ 1 := le_of_not_gt hq
    have hab : x / (a * b : ℕ) ≤ 1 := by
      rw [← hdiv]
      apply (div_le_iff₀ hb0).2
      linarith
    rw [S_eq_zero_of_le_one hqle, S_eq_zero_of_le_one hab]
    simp

/-- The actual product event is bounded by the product of its marginal probabilities. -/
theorem probability_mul_le {a b : ℕ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    {x : ℝ} (hx : 1 < x) :
    probability (a * b) x ≤ probability a x * probability b x := by
  have hs : 0 < S x := S_pos hx
  have hd := determinant_nonneg ha hb hx
  have hcross : S (x / (a * b : ℕ)) * S x ≤ S (x / a) * S (x / b) := by
    nlinarith
  have hquot : S (x / (a * b : ℕ)) / S x ≤
      (S (x / a) * S (x / b)) / (S x * S x) := by
    apply (div_le_div_iff₀ hs (mul_pos hs hs)).2
    nlinarith [mul_le_mul_of_nonneg_right hcross hs.le]
  have hm := mul_le_mul_of_nonneg_left hquot
    (mul_nonneg (Real.sqrt_nonneg (a : ℝ)) (Real.sqrt_nonneg (b : ℝ)))
  simp only [Nat.cast_mul] at hm
  unfold probability
  rw [Nat.cast_mul, Real.sqrt_mul (Nat.cast_nonneg a)]
  convert hm using 1 <;> field_simp

end BuildingBlocks.ChronologicalDivisibility
