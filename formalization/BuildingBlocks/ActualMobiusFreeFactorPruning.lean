import Mathlib.Tactic

namespace BuildingBlocks.ActualMobiusFreeFactorPruning

/-- Current hybrid Type-II endpoint. -/
noncomputable def endpoint (lambda : ℝ) : ℝ :=
  2 * (lambda + 1) / 5

/-- Vaughan truncation exponent retained by the hybrid argument. -/
noncomputable def truncationExponent (lambda : ℝ) : ℝ :=
  (42 * lambda - 55) / 126

/-- Robert--Sargos/Bordellès switch for the large factor. -/
noncomputable def hybridSwitch (lambda d : ℝ) : ℝ :=
  (3 * d - lambda) / 2

noncomputable def robertSargosFirst (lambda d a : ℝ) : ℝ :=
  (d + a - lambda) / 4

noncomputable def robertSargosSecond (lambda d a : ℝ) : ℝ :=
  (3 * d - lambda - 1 - a) / 4

noncomputable def robertSargosThird (lambda d a : ℝ) : ℝ :=
  (d + a - lambda) / 2

noncomputable def bordellesFirst (lambda d a : ℝ) : ℝ :=
  -lambda / 3 + 2 * d / 3 - a / 6

noncomputable def bordellesSecond (_lambda _d a : ℝ) : ℝ :=
  (a - 1) / 2

noncomputable def bordellesThird (lambda d a : ℝ) : ℝ :=
  d - a / 2 - lambda / 2

noncomputable def commonFourth (lambda d : ℝ) : ℝ :=
  d - (lambda + 1) / 2

/-- If `x+y+z=d`, `z≥v`, and both original Möbius factors have exponent at
least `u`, grouping the smaller one separately produces a large-factor
exponent between `(d+v)/2` and `d-u`. -/
theorem freeFactor_grouping
    {d u v x y z : ℝ}
    (hsum : x + y + z = d) (hx : u ≤ x) (hy : u ≤ y) (hz : v ≤ z) :
    ∃ a, (d + v) / 2 ≤ a ∧ a ≤ d - u ∧ (a = d - x ∨ a = d - y) := by
  by_cases hsmall : x ≤ (d - v) / 2
  · refine ⟨d - x, ?_, ?_, Or.inl rfl⟩ <;> linarith
  · have hySmall : y ≤ (d - v) / 2 := by linarith
    refine ⟨d - y, ?_, ?_, Or.inr rfl⟩ <;> linarith

/-- Choosing the smaller original Möbius factor separately gives an exact
distance from balance: `2a-d = z+|x-y|`. Thus either a large free factor or
an imbalance between the Möbius factors moves the rectangle away from the
critical balanced line. -/
theorem exact_grouping_separation
    {d u x y z : ℝ}
    (hsum : x + y + z = d) (hx : u ≤ x) (hy : u ≤ y) :
    ∃ a, a ≤ d - u ∧ 2 * a - d = z + |x - y| ∧
      (a = d - x ∨ a = d - y) := by
  by_cases hxy : x ≤ y
  · refine ⟨d - x, ?_, ?_, Or.inl rfl⟩
    · linarith
    · rw [abs_of_nonpos (sub_nonpos.mpr hxy)]
      linarith
  · have hyx : y ≤ x := le_of_not_ge hxy
    refine ⟨d - y, ?_, ?_, Or.inr rfl⟩
    · linarith
    · rw [abs_of_nonneg (sub_nonneg.mpr hyx)]
      linarith

/-- The formerly critical Robert--Sargos exponent gains `(v-5δ)/8` after
large-free-factor grouping. -/
theorem robertSargosSecond_le
    {lambda d a v delta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : (d + v) / 2 ≤ a) :
    robertSargosSecond lambda d a ≤ (5 * delta - v) / 8 := by
  unfold endpoint at hd
  unfold robertSargosSecond
  rw [hd] at ha
  linarith

/-- Exact form of the active exponent in terms of the joint free-factor and
aspect-ratio separation `xi = 2a-d`. -/
theorem robertSargosSecond_eq_separation
    {lambda d a xi delta : ℝ}
    (hd : d = endpoint lambda + delta) (hxi : 2 * a - d = xi) :
    robertSargosSecond lambda d a = (5 * delta - xi) / 8 := by
  unfold endpoint at hd
  unfold robertSargosSecond
  rw [hd] at hxi ⊢
  linarith

theorem robertSargosSecond_separation_lt_margin
    {lambda d a xi delta eta : ℝ}
    (hd : d = endpoint lambda + delta) (hxi : 2 * a - d = xi)
    (hmargin : 5 * delta + 8 * eta < xi) :
    robertSargosSecond lambda d a < -eta := by
  rw [robertSargosSecond_eq_separation hd hxi]
  linarith

theorem robertSargosFirst_le
    {lambda d a delta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : a ≤ hybridSwitch lambda d) :
    robertSargosFirst lambda d a ≤ (2 - lambda + 5 * delta) / 8 := by
  unfold endpoint at hd
  unfold hybridSwitch at ha
  unfold robertSargosFirst
  rw [hd] at ha ⊢
  linarith

theorem robertSargosThird_le
    {lambda d a delta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : a ≤ hybridSwitch lambda d) :
    robertSargosThird lambda d a ≤ (2 - lambda + 5 * delta) / 4 := by
  unfold endpoint at hd
  unfold hybridSwitch at ha
  unfold robertSargosThird
  rw [hd] at ha ⊢
  linarith

theorem bordellesFirst_le
    {lambda d a delta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : hybridSwitch lambda d ≤ a) :
    bordellesFirst lambda d a ≤ (2 - lambda + 5 * delta) / 12 := by
  unfold endpoint at hd
  unfold hybridSwitch at ha
  unfold bordellesFirst
  rw [hd] at ha ⊢
  linarith

theorem bordellesSecond_le
    {lambda d a delta : ℝ}
    (hd : d = endpoint lambda + delta)
    (ha : a ≤ d - truncationExponent lambda) :
    bordellesSecond lambda d a ≤
      -(103 - 42 * lambda) / 1260 + delta / 2 := by
  unfold endpoint at hd
  unfold truncationExponent at ha
  unfold bordellesSecond
  rw [hd] at ha
  linarith

theorem bordellesThird_le
    {lambda d a delta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : hybridSwitch lambda d ≤ a) :
    bordellesThird lambda d a ≤ -(3 * lambda - 2) / 20 + delta / 4 := by
  unfold endpoint at hd
  unfold hybridSwitch at ha
  unfold bordellesThird
  rw [hd] at ha ⊢
  linarith

theorem commonFourth_eq
    {lambda d delta : ℝ} (hd : d = endpoint lambda + delta) :
    commonFourth lambda d = -(lambda + 1) / 10 + delta := by
  unfold endpoint at hd
  unfold commonFourth
  rw [hd]
  ring

/-- A final margin `η` in the critical Robert--Sargos term follows from the
strict free-factor inequality `5δ+8η<v`. -/
theorem robertSargosSecond_lt_margin
    {lambda d a v delta eta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : (d + v) / 2 ≤ a)
    (hmargin : 5 * delta + 8 * eta < v) :
    robertSargosSecond lambda d a < -eta := by
  have h := robertSargosSecond_le hd ha
  linarith

theorem bordellesFirst_lt_margin
    {lambda d a delta eta : ℝ}
    (hd : d = endpoint lambda + delta) (ha : hybridSwitch lambda d ≤ a)
    (hmargin : 5 * delta + 12 * eta < lambda - 2) :
    bordellesFirst lambda d a < -eta := by
  have h := bordellesFirst_le hd ha
  linarith

theorem bordellesSecond_lt_margin
    {lambda d a delta eta : ℝ}
    (hd : d = endpoint lambda + delta)
    (ha : a ≤ d - truncationExponent lambda)
    (hmargin : delta + 2 * eta < (103 - 42 * lambda) / 630) :
    bordellesSecond lambda d a < -eta := by
  have h := bordellesSecond_le hd ha
  linarith

end BuildingBlocks.ActualMobiusFreeFactorPruning
