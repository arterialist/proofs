import BuildingBlocks.SuccessorCellTransferFinite
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic

/-!
# High-parent successor-cell prime row

When the parent index exceeds the square-root scale of a child row,
the exact child interval contains at most one dilation. This finite
fact is the arithmetic diagonal step in the fourth-logarithm
negative-index bound. The complete von Mangoldt weight retains all
prime powers.
-/

namespace BuildingBlocks.SuccessorHighParentPrimeRow

/-- The physical logarithmic length of successor cell n. -/
noncomputable def cellLength (n : ℕ) : ℝ :=
  Real.log (((n + 1 : ℕ) : ℝ) / (n : ℝ))

theorem cellLength_upper (n : ℕ) (hn : 0 < n) :
    cellLength n ≤ 1 / (n : ℝ) := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hratio : (((n + 1 : ℕ) : ℝ) / (n : ℝ)) =
      1 + 1 / (n : ℝ) := by
    push_cast
    field_simp
  rw [cellLength, hratio]
  have h := Real.log_le_sub_one_of_pos
    (by positivity : 0 < (1 : ℝ) + 1 / (n : ℝ))
  linarith

theorem cellLength_lower (n : ℕ) (hn : 0 < n) :
    1 / ((n : ℝ) + 1) ≤ cellLength n := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hn1R : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hratio : ((n : ℝ) / ((n : ℝ) + 1)) =
      ((((n + 1 : ℕ) : ℝ) / (n : ℝ))⁻¹) := by
    push_cast
    field_simp
  have hlog := Real.log_le_sub_one_of_pos (div_pos hnR hn1R)
  rw [hratio, Real.log_inv] at hlog
  have hdiff : (n : ℝ) / ((n : ℝ) + 1) - 1 =
      -(1 / ((n : ℝ) + 1)) := by
    field_simp
    ring
  rw [← hratio, hdiff] at hlog
  dsimp [cellLength]
  linarith

/-- The cell normalization ratio used in each actual matrix row. -/
theorem cellLength_ratio_le (r n : ℕ) (hr : 0 < r) (hn : 0 < n) :
    cellLength r / cellLength n ≤ ((n + 1 : ℕ) : ℝ) / (r : ℝ) := by
  have hrR : (0 : ℝ) < r := by exact_mod_cast hr
  have hn1R : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hlow := cellLength_lower n hn
  have hpos : 0 < cellLength n :=
    lt_of_lt_of_le (by positivity : 0 < 1 / ((n : ℝ) + 1)) hlow
  have hleft : cellLength r * (r : ℝ) ≤ 1 :=
    (le_div_iff₀ hrR).mp (cellLength_upper r hr)
  have hright : (1 : ℝ) ≤ cellLength n * ((n : ℝ) + 1) :=
    (div_le_iff₀ hn1R).mp hlow
  apply (div_le_div_iff₀ hpos hrR).mpr
  push_cast
  nlinarith

theorem cellLength_pos (n : ℕ) (hn : 0 < n) :
    0 < cellLength n := by
  have hlow := cellLength_lower n hn
  have hnR : (0 : ℝ) ≤ n := by positivity
  exact lt_of_lt_of_le (by positivity : 0 < 1 / ((n : ℝ) + 1)) hlow

/-- An active dilation pays at most two reciprocal-dilation units
    after exact successor-cell normalization. -/
theorem highParent_cell_ratio_le
    {r n d : ℕ} (hr : 0 < r) (hn : 0 < n) (hd : 0 < d)
    (hlo : d * n ≤ r) :
    cellLength r / cellLength n ≤ 2 / (d : ℝ) := by
  have hrR : (0 : ℝ) < r := by exact_mod_cast hr
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd
  have hnplus : n + 1 ≤ 2 * n := by omega
  have hgeomNat : d * (n + 1) ≤ 2 * r := by
    have hmul := Nat.mul_le_mul_left d hnplus
    nlinarith
  have hgeomNat' : (n + 1) * d ≤ 2 * r := by
    simpa [Nat.mul_comm] using hgeomNat
  have hgeomR : (((n + 1 : ℕ) : ℝ) * (d : ℝ)) ≤
      2 * (r : ℝ) := by exact_mod_cast hgeomNat'
  have hgeom : (((n + 1 : ℕ) : ℝ) / (r : ℝ)) ≤ 2 / (d : ℝ) := by
    exact (div_le_div_iff₀ hrR hdR).mpr hgeomR
  exact (cellLength_ratio_le r n hr hn).trans hgeom

/-- Above the square-root parent threshold, one child row cannot
    arise from two distinct integer dilations of the same parent. -/
theorem high_parent_child_dilation_unique
    {r n d e : ℕ} (hrn : r < n * n)
    (hdlo : d * n ≤ r) (hdhi : r < d * (n + 1))
    (helo : e * n ≤ r) (hehi : r < e * (n + 1)) :
    d = e := by
  have hdlt : d < n := by
    by_contra h
    have hge : n ≤ d := by omega
    have hmul : n * n ≤ d * n := by
      exact Nat.mul_le_mul_right n hge
    omega
  have helt : e < n := by
    by_contra h
    have hge : n ≤ e := by omega
    have hmul : n * n ≤ e * n := by
      exact Nat.mul_le_mul_right n hge
    omega
  rcases lt_trichotomy d e with hde | hde | hed
  · have hstep : d + 1 ≤ e := by omega
    have hmul : (d + 1) * n ≤ e * n :=
      Nat.mul_le_mul_right n hstep
    nlinarith
  · exact hde
  · have hstep : e + 1 ≤ d := by omega
    have hmul : (e + 1) * n ≤ d * n :=
      Nat.mul_le_mul_right n hstep
    nlinarith

/-- Exact integer dilation labels contributing to a fixed child row
    and parent column, above the specified dilation cutoff. -/
def highParentChildren (r n D : ℕ) : Finset ℕ :=
  (Finset.Ioc D r).filter (fun d => d * n ≤ r ∧ r < d * (n + 1))

theorem highParentChildren_card_le_one
    {r n D : ℕ} (hrn : r < n * n) :
    (highParentChildren r n D).card ≤ 1 := by
  apply Finset.card_le_one.mpr
  intro d hd e he
  have hdchild := (Finset.mem_filter.mp hd).2
  have hechild := (Finset.mem_filter.mp he).2
  exact high_parent_child_dilation_unique hrn
    hdchild.1 hdchild.2 hechild.1 hechild.2

/-- No cross term survives in the square of the *actual* complete
    von Mangoldt prime-power row above the square-root parent scale. -/
theorem highParent_vonMangoldt_sum_sq
    {r n D : ℕ} (hrn : r < n * n) :
    (∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 =
      ∑ d ∈ highParentChildren r n D,
        (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 := by
  let s := highParentChildren r n D
  have hs : s.card ≤ 1 := highParentChildren_card_le_one hrn
  rcases s.eq_empty_or_nonempty with h | ⟨d, hd⟩
  · simp [s, h]
  · have hsingle : s = {d} := Finset.eq_singleton_iff_unique_mem.mpr
      ⟨hd, fun e he => (Finset.card_le_one.mp hs) e he d hd⟩
    simp [s, hsingle]

/-- Each active prime-power term in a high-parent row satisfies the
    reciprocal-square energy estimate, including the physical cell lengths. -/
theorem highParent_vonMangoldt_cell_term_le
    {r n d : ℕ} (hr : 0 < r) (hn : 0 < n) (hd : 0 < d)
    (hlo : d * n ≤ r) :
    (cellLength r / cellLength n) *
      (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 ≤
      2 * (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2 := by
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd
  have hratio := highParent_cell_ratio_le hr hn hd hlo
  have hsq :
      (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 =
        (ArithmeticFunction.vonMangoldt d) ^ 2 / (d : ℝ) := by
    rw [div_pow, Real.sq_sqrt (le_of_lt hdR)]
  calc
    (cellLength r / cellLength n) *
        (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 ≤
        (2 / (d : ℝ)) *
          (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 :=
      mul_le_mul_of_nonneg_right hratio (sq_nonneg _)
    _ = 2 * (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2 := by
      rw [hsq, div_pow]
      field_simp

/-- Distinct parent cells use distinct active dilation labels, so any
    nonnegative dilation weight is counted at most once. -/
theorem highParent_child_sum_le
    (r D : ℕ) (w : ℕ → ℝ) (hw : ∀ d, 0 ≤ w d) :
    (∑ n ∈ (Finset.Icc 1 r).filter (fun n => r < n * n),
      ∑ d ∈ highParentChildren r n D, w d) ≤
      ∑ d ∈ Finset.Ioc D r, w d := by
  classical
  let s := (Finset.Icc 1 r).filter (fun n => r < n * n)
  calc
    (∑ n ∈ s, ∑ d ∈ highParentChildren r n D, w d) =
        ∑ d ∈ Finset.Ioc D r, ∑ n ∈ s,
          if d * n ≤ r ∧ r < d * (n + 1) then w d else 0 := by
        simp only [highParentChildren, Finset.sum_filter]
        rw [Finset.sum_comm]
    _ ≤ ∑ d ∈ Finset.Ioc D r, w d := by
        apply Finset.sum_le_sum
        intro d hd
        have hdpos : 0 < d := lt_of_le_of_lt (Nat.zero_le D) (Finset.mem_Ioc.mp hd).1
        have hpred : ∀ n : ℕ,
            (d * n ≤ r ∧ r < d * (n + 1)) ↔ n = r / d := by
          intro n
          simpa [eq_comm] using
            (SuccessorCellTransferFinite.div_eq_iff_child
              (d := d) (n := n) (r := r) hdpos).symm
        simp_rw [hpred]
        rw [Finset.sum_ite_eq']
        split_ifs
        · exact le_rfl
        · exact hw d

/-- Exact high-parent row energy after the physical cell
    normalization. Its right side is the reciprocal-square tail of
    all active von Mangoldt weights, with prime powers intact. -/
theorem highParent_vonMangoldt_normalized_row_energy_le (r D : ℕ) :
    (∑ n ∈ (Finset.Icc 1 r).filter (fun n => r < n * n),
      (Real.sqrt (cellLength r / cellLength n) *
        ∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2) ≤
      2 * ∑ d ∈ Finset.Ioc D r,
        (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2 := by
  classical
  let s := (Finset.Icc 1 r).filter (fun n => r < n * n)
  let w : ℕ → ℝ := fun d =>
    2 * (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2
  have hw : ∀ d, 0 ≤ w d := by
    intro d
    dsimp [w]
    positivity
  calc
    (∑ n ∈ s,
      (Real.sqrt (cellLength r / cellLength n) *
        ∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2) =
        ∑ n ∈ s, ∑ d ∈ highParentChildren r n D,
          (cellLength r / cellLength n) *
            (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 := by
        apply Finset.sum_congr rfl
        intro n hn
        have hsn := Finset.mem_filter.mp hn
        have hnrange := Finset.mem_Icc.mp hsn.1
        have hnpos : 0 < n := by omega
        have hrpos : 0 < r := by omega
        have hratioNonneg : 0 ≤ cellLength r / cellLength n :=
          div_nonneg (le_of_lt (cellLength_pos r hrpos))
            (le_of_lt (cellLength_pos n hnpos))
        rw [mul_pow, Real.sq_sqrt hratioNonneg,
          highParent_vonMangoldt_sum_sq hsn.2, Finset.mul_sum]
    _ ≤ ∑ n ∈ s, ∑ d ∈ highParentChildren r n D, w d := by
        apply Finset.sum_le_sum
        intro n hn
        have hsn := Finset.mem_filter.mp hn
        have hnrange := Finset.mem_Icc.mp hsn.1
        have hnpos : 0 < n := by omega
        have hrpos : 0 < r := by omega
        apply Finset.sum_le_sum
        intro d hd
        have hdmem := (Finset.mem_filter.mp hd).1
        have hlo := (Finset.mem_filter.mp hd).2.1
        have hdpos : 0 < d :=
          lt_of_le_of_lt (Nat.zero_le D) (Finset.mem_Ioc.mp hdmem).1
        exact highParent_vonMangoldt_cell_term_le hrpos hnpos hdpos hlo
    _ ≤ ∑ d ∈ Finset.Ioc D r, w d :=
      highParent_child_sum_le r D w hw
    _ = 2 * ∑ d ∈ Finset.Ioc D r,
          (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2 := by
        simp only [w, Finset.mul_sum]

/-- The total high-parent row energy is bounded by the squared
    weights of the exact active dilation labels. Each dilation has
    one parent, and each high parent has at most one dilation. -/
theorem highParent_vonMangoldt_row_energy_le (r D : ℕ) :
    (∑ n ∈ (Finset.Icc 1 r).filter (fun n => r < n * n),
      (∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2) ≤
      ∑ d ∈ Finset.Ioc D r,
        (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 := by
  classical
  let s := (Finset.Icc 1 r).filter (fun n => r < n * n)
  calc
    (∑ n ∈ s, (∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2) =
        ∑ n ∈ s, ∑ d ∈ highParentChildren r n D,
          (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 := by
        apply Finset.sum_congr rfl
        intro n hn
        exact highParent_vonMangoldt_sum_sq (Finset.mem_filter.mp hn).2
    _ = ∑ d ∈ Finset.Ioc D r, ∑ n ∈ s,
          if d * n ≤ r ∧ r < d * (n + 1) then
            (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 else 0 := by
        simp only [highParentChildren, Finset.sum_filter]
        rw [Finset.sum_comm]
    _ ≤ ∑ d ∈ Finset.Ioc D r,
          (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 := by
        apply Finset.sum_le_sum
        intro d hd
        have hdpos : 0 < d := lt_of_le_of_lt (Nat.zero_le D) (Finset.mem_Ioc.mp hd).1
        have hpred : ∀ n : ℕ,
            (d * n ≤ r ∧ r < d * (n + 1)) ↔ n = r / d := by
          intro n
          simpa [eq_comm] using
            (SuccessorCellTransferFinite.div_eq_iff_child
              (d := d) (n := n) (r := r) hdpos).symm
        simp_rw [hpred]
        rw [Finset.sum_ite_eq']
        split_ifs
        · exact le_rfl
        · exact sq_nonneg _

#print axioms high_parent_child_dilation_unique
#print axioms cellLength_upper
#print axioms cellLength_lower
#print axioms cellLength_ratio_le
#print axioms highParentChildren_card_le_one
#print axioms highParent_vonMangoldt_sum_sq
#print axioms highParent_vonMangoldt_cell_term_le
#print axioms highParent_child_sum_le
#print axioms highParent_vonMangoldt_normalized_row_energy_le
#print axioms highParent_vonMangoldt_row_energy_le

end BuildingBlocks.SuccessorHighParentPrimeRow
