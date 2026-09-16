import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic

set_option maxHeartbeats 2000000

namespace PaidThetaCompensation.RadiusTwoEdgeCellGeometry

inductive PrimePowerLabel
  | two | three | four
  deriving DecidableEq, Repr

inductive Orientation
  | minus | plus
  deriving DecidableEq, Repr

structure Label where
  q : PrimePowerLabel
  orientation : Orientation
  startCell : Fin 8
  deriving DecidableEq, Repr

structure LabelledInterval where
  label : Label
  lo : ℝ
  hi : ℝ

noncomputable def displacement : PrimePowerLabel → ℝ
  | .two => Real.log 2
  | .three => Real.log 3
  | .four => Real.log 4

noncomputable def signedDisplacement :
    Orientation → PrimePowerLabel → ℝ
  | .minus, q => -displacement q
  | .plus, q => displacement q

noncomputable def edgeWeight : PrimePowerLabel → ℝ
  | .two => Real.log 2 / Real.sqrt 2
  | .three => Real.log 3 / Real.sqrt 3
  | .four => Real.log 2 / 2

def mkLabel (q : PrimePowerLabel) (o : Orientation) (k : Fin 8) :
    Label := ⟨q, o, k⟩

noncomputable def cells : List LabelledInterval :=
  let d2 := Real.log 2
  let d3 := Real.log 3
  let d4 := Real.log 4
  [
    ⟨mkLabel .two .plus 0, -4, -3⟩,
    ⟨mkLabel .two .plus 1, -3, -9 / 4 - d2⟩,
    ⟨mkLabel .two .plus 6, 9 / 4, 3⟩,
    ⟨mkLabel .two .plus 7, 3, 4 - d2⟩,
    ⟨mkLabel .two .minus 0, -4 + d2, -3⟩,
    ⟨mkLabel .two .minus 1, -3, -9 / 4⟩,
    ⟨mkLabel .two .minus 6, 9 / 4 + d2, 3⟩,
    ⟨mkLabel .two .minus 7, 3, 4⟩,
    ⟨mkLabel .three .plus 0, -4, -9 / 4 - d3⟩,
    ⟨mkLabel .three .plus 6, 9 / 4, 4 - d3⟩,
    ⟨mkLabel .three .minus 1, -4 + d3, -9 / 4⟩,
    ⟨mkLabel .three .minus 7, 9 / 4 + d3, 4⟩,
    ⟨mkLabel .four .plus 0, -4, -9 / 4 - d4⟩,
    ⟨mkLabel .four .plus 6, 9 / 4, 4 - d4⟩,
    ⟨mkLabel .four .minus 1, -4 + d4, -9 / 4⟩,
    ⟨mkLabel .four .minus 7, 9 / 4 + d4, 4⟩
  ]

theorem cells_length : cells.length = 16 := by
  rfl

theorem cell_labels_nodup : (cells.map LabelledInterval.label).Nodup := by
  simp [cells, mkLabel]

theorem log_two_bounds :
    (2 / 3 : ℝ) < Real.log 2 ∧ Real.log 2 < 3 / 4 := by
  constructor
  · linarith [Real.log_two_gt_d9]
  · linarith [Real.log_two_lt_d9]

theorem log_four_eq : Real.log 4 = 2 * Real.log 2 := by
  have hfour : (4 : ℝ) = 2 ^ (2 : ℕ) := by norm_num
  rw [hfour, Real.log_pow]
  norm_num

theorem log_three_bounds :
    (1 : ℝ) < Real.log 3 ∧ Real.log 3 < 3 / 2 := by
  constructor
  · rw [Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)]
    exact Real.exp_one_lt_d9.trans (by norm_num)
  · have h34 : Real.log 3 < Real.log 4 := by
      exact Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
    rw [log_four_eq] at h34
    linarith [log_two_bounds.2]

theorem log_four_bounds :
    (4 / 3 : ℝ) < Real.log 4 ∧ Real.log 4 < 3 / 2 := by
  rw [log_four_eq]
  constructor <;> linarith [log_two_bounds.1, log_two_bounds.2]

theorem every_listed_interval_nonempty
    (I : LabelledInterval) (hI : I ∈ cells) : I.lo < I.hi := by
  simp [cells] at hI
  rcases hI with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals
    dsimp
    linarith [log_two_bounds.1, log_two_bounds.2,
      log_three_bounds.1, log_three_bounds.2,
      log_four_bounds.1, log_four_bounds.2]

def inWindow (M u : ℝ) : Prop :=
  (-M ≤ u ∧ u ≤ -(2 + M⁻¹)) ∨
    (2 + M⁻¹ ≤ u ∧ u ≤ M)

theorem window_two_empty (u : ℝ) : ¬ inWindow 2 u := by
  intro h
  rcases h with h | h
  · norm_num at h
    linarith
  · norm_num at h
    linarith

theorem window_three_no_plus_pair
    {d u : ℝ} (hlo : 2 / 3 < d) (hhi : d < 3 / 2) :
    ¬(inWindow 3 u ∧ inWindow 3 (u + d)) := by
  rintro ⟨hu, hv⟩
  rcases hu with hu | hu <;> rcases hv with hv | hv <;>
    norm_num [inWindow] at hu hv <;> linarith

theorem window_three_no_minus_pair
    {d u : ℝ} (hlo : 2 / 3 < d) (hhi : d < 3 / 2) :
    ¬(inWindow 3 u ∧ inWindow 3 (u - d)) := by
  intro h
  have hp := window_three_no_plus_pair (u := u - d) hlo hhi
  apply hp
  constructor
  · exact h.2
  · simpa [sub_add_cancel] using h.1

theorem stages_two_three_empty_for_actual_shifts
    (q : PrimePowerLabel) (u : ℝ) :
    (¬ inWindow 2 u) ∧
    (¬(inWindow 3 u ∧
      inWindow 3 (u + displacement q))) ∧
    (¬(inWindow 3 u ∧
      inWindow 3 (u - displacement q))) := by
  refine ⟨window_two_empty u, ?_, ?_⟩
  · cases q
    · exact window_three_no_plus_pair log_two_bounds.1
        (lt_trans log_two_bounds.2 (by norm_num))
    · exact window_three_no_plus_pair
        (lt_trans (by norm_num) log_three_bounds.1)
        log_three_bounds.2
    · exact window_three_no_plus_pair
        (lt_trans (by norm_num) log_four_bounds.1)
        log_four_bounds.2
  · cases q
    · exact window_three_no_minus_pair log_two_bounds.1
        (lt_trans log_two_bounds.2 (by norm_num))
    · exact window_three_no_minus_pair
        (lt_trans (by norm_num) log_three_bounds.1)
        log_three_bounds.2
    · exact window_three_no_minus_pair
        (lt_trans (by norm_num) log_four_bounds.1)
        log_four_bounds.2

def inStartCell (label : Label) (u : ℝ) : Prop :=
  (label.startCell.val : ℝ) - 4 ≤ u ∧
    u < (label.startCell.val : ℝ) - 3

def inActualCell (I : LabelledInterval) (u : ℝ) : Prop :=
  inStartCell I.label u ∧ inWindow 4 u ∧
    inWindow 4
      (u + signedDisplacement I.label.orientation I.label.q)

theorem window_four_iff (u : ℝ) :
    inWindow 4 u ↔
      (-4 ≤ u ∧ u ≤ -9 / 4) ∨ (9 / 4 ≤ u ∧ u ≤ 4) := by
  norm_num [inWindow]

theorem window_four_plus_bands
    {d u : ℝ} (hd0 : 0 < d) (hd : d < 3 / 2) :
    inWindow 4 u ∧ inWindow 4 (u + d) ↔
      (-4 ≤ u ∧ u ≤ -9 / 4 - d) ∨
      (9 / 4 ≤ u ∧ u ≤ 4 - d) := by
  rw [window_four_iff, window_four_iff]
  constructor
  · rintro ⟨hu, hv⟩
    rcases hu with hu | hu <;> rcases hv with hv | hv
    · left; constructor <;> linarith
    · exfalso; linarith
    · exfalso; linarith
    · right; constructor <;> linarith
  · rintro (h | h)
    · constructor
      · left; constructor <;> linarith
      · left; constructor <;> linarith
    · constructor
      · right; constructor <;> linarith
      · right; constructor <;> linarith

theorem window_four_minus_bands
    {d u : ℝ} (hd0 : 0 < d) (hd : d < 3 / 2) :
    inWindow 4 u ∧ inWindow 4 (u - d) ↔
      (-4 + d ≤ u ∧ u ≤ -9 / 4) ∨
      (9 / 4 + d ≤ u ∧ u ≤ 4) := by
  rw [window_four_iff, window_four_iff]
  constructor
  · rintro ⟨hu, hv⟩
    rcases hu with hu | hu <;> rcases hv with hv | hv
    · left; constructor <;> linarith
    · exfalso; linarith
    · exfalso; linarith
    · right; constructor <;> linarith
  · rintro (h | h)
    · constructor
      · left; constructor <;> linarith
      · left; constructor <;> linarith
    · constructor
      · right; constructor <;> linarith
      · right; constructor <;> linarith

theorem listed_interval_interior_mem_actual_cell
    (I : LabelledInterval) (hI : I ∈ cells)
    {u : ℝ} (hlo : I.lo < u) (hhi : u < I.hi) :
    inActualCell I u := by
  simp [cells] at hI
  rcases hI with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals
    dsimp [inActualCell, inStartCell, inWindow, signedDisplacement,
      displacement, mkLabel] at *
  all_goals
    norm_num at *
  all_goals
    constructor
    · constructor <;>
        linarith [log_two_bounds.1, log_two_bounds.2,
          log_three_bounds.1, log_three_bounds.2,
          log_four_bounds.1, log_four_bounds.2]
    constructor
    · first
      | left; constructor <;>
          linarith [log_two_bounds.1, log_two_bounds.2,
            log_three_bounds.1, log_three_bounds.2,
            log_four_bounds.1, log_four_bounds.2]
      | right; constructor <;>
          linarith [log_two_bounds.1, log_two_bounds.2,
            log_three_bounds.1, log_three_bounds.2,
            log_four_bounds.1, log_four_bounds.2]
    · first
      | left; constructor <;>
          linarith [log_two_bounds.1, log_two_bounds.2,
            log_three_bounds.1, log_three_bounds.2,
            log_four_bounds.1, log_four_bounds.2]
      | right; constructor <;>
          linarith [log_two_bounds.1, log_two_bounds.2,
            log_three_bounds.1, log_three_bounds.2,
            log_four_bounds.1, log_four_bounds.2]

theorem every_actual_label_is_listed
    (label : Label) (u : ℝ)
    (hstart : inStartCell label u)
    (hwin : inWindow 4 u)
    (hshift : inWindow 4
      (u + signedDisplacement label.orientation label.q)) :
    label ∈ cells.map LabelledInterval.label := by
  rcases label with ⟨q, o, k⟩
  cases q <;> cases o <;> fin_cases k
  all_goals
    first
    | solve | simp [cells, mkLabel]
    | have hfalse : False := by
        dsimp [inStartCell, inWindow, signedDisplacement,
          displacement] at hstart hwin hshift
        norm_num at hstart hwin hshift
        rcases hwin with hwin | hwin <;>
          rcases hshift with hshift | hshift <;>
          linarith [log_two_bounds.1, log_two_bounds.2,
            log_three_bounds.1, log_three_bounds.2,
            log_four_bounds.1, log_four_bounds.2]
      exact False.elim hfalse

theorem actual_cell_inside_listed_closed_interval
    (I : LabelledInterval) (hI : I ∈ cells)
    {u : ℝ} (hactual : inActualCell I u) :
    I.lo ≤ u ∧ u ≤ I.hi := by
  simp [cells] at hI
  rcases hI with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals
    dsimp [inActualCell, inStartCell, inWindow, signedDisplacement,
      displacement, mkLabel] at hactual ⊢
    norm_num at hactual ⊢
    rcases hactual with ⟨hstart, hwin, hshift⟩
    rcases hwin with hwin | hwin <;>
      rcases hshift with hshift | hshift <;>
      constructor <;>
      linarith [log_two_bounds.1, log_two_bounds.2,
        log_three_bounds.1, log_three_bounds.2,
        log_four_bounds.1, log_four_bounds.2]

theorem actual_label_iff_listed (label : Label) :
    (∃ u : ℝ,
      inStartCell label u ∧ inWindow 4 u ∧
      inWindow 4
        (u + signedDisplacement label.orientation label.q)) ↔
      label ∈ cells.map LabelledInterval.label := by
  constructor
  · rintro ⟨u, hstart, hwin, hshift⟩
    exact every_actual_label_is_listed label u hstart hwin hshift
  · intro hmem
    obtain ⟨I, hI, hlabel⟩ := List.mem_map.mp hmem
    let u := (I.lo + I.hi) / 2
    have hlen := every_listed_interval_nonempty I hI
    have hlo : I.lo < u := by dsimp [u]; linarith
    have hhi : u < I.hi := by dsimp [u]; linarith
    have hactual := listed_interval_interior_mem_actual_cell I hI hlo hhi
    rcases hactual with ⟨hstart, hwin, hshift⟩
    refine ⟨u, ?_, hwin, ?_⟩
    · simpa [hlabel] using hstart
    · simpa [hlabel] using hshift

noncomputable def edgeDensity
    (psi Phi ell : ℝ → ℝ) (a : ℝ)
    (I : LabelledInterval) (u : ℝ) : ℝ :=
  let v := u + signedDisplacement I.label.orientation I.label.q
  edgeWeight I.label.q * psi u * psi v * Phi u * Phi v /
    ((a + ell u) * (a + ell v))

noncomputable def cellMass
    (psi Phi ell : ℝ → ℝ) (a : ℝ)
    (I : LabelledInterval) : ℝ :=
  ∫ u in Set.Icc I.lo I.hi, edgeDensity psi Phi ell a I u

noncomputable def observedEntry
    (psi Phi ell : ℝ → ℝ) (a : ℝ)
    (I : LabelledInterval) (F : ℝ → ℂ) : ℂ :=
  let m := cellMass psi Phi ell a I
  ((Real.sqrt (2 * m))⁻¹ : ℝ) •
    ∫ u in Set.Icc I.lo I.hi,
      (F (u + signedDisplacement I.label.orientation I.label.q) - F u) *
        (edgeDensity psi Phi ell a I u : ℂ)

theorem observedEntry_is_explicit_interval_integral
    (psi Phi ell : ℝ → ℝ) (a : ℝ)
    (I : LabelledInterval) (F : ℝ → ℂ) :
    observedEntry psi Phi ell a I F =
      ((Real.sqrt (2 * cellMass psi Phi ell a I))⁻¹ : ℝ) •
        ∫ u in Set.Icc I.lo I.hi,
          (F (u + signedDisplacement I.label.orientation I.label.q) - F u) *
            (edgeDensity psi Phi ell a I u : ℂ) := by
  rfl

end PaidThetaCompensation.RadiusTwoEdgeCellGeometry

#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.cells_length
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.cell_labels_nodup
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.every_listed_interval_nonempty
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.stages_two_three_empty_for_actual_shifts
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.window_four_plus_bands
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.window_four_minus_bands
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.listed_interval_interior_mem_actual_cell
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.every_actual_label_is_listed
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.actual_cell_inside_listed_closed_interval
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.actual_label_iff_listed
#print axioms PaidThetaCompensation.RadiusTwoEdgeCellGeometry.observedEntry_is_explicit_interval_integral
