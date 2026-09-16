import BuildingBlocks.IntegerCarryPrimitiveIntegral

namespace BuildingBlocks.IntegerCarryPhase

/-- Linear interpolation of the two nonnegative endpoint products. -/
theorem subcell_product_bound (m j s : ℝ) (hj : 0 ≤ j) (hjm : j + 1 ≤ m)
    (hs0 : 0 ≤ s) (hs1 : s ≤ 1) :
    s * (1 - s) ≤ (j + s) * (m - j - s) := by
  have h0 : 0 ≤ j * (m - j) * (1 - s) :=
    mul_nonneg (mul_nonneg hj (by linarith)) (by linarith)
  have h1 : 0 ≤ (j + 1) * (m - j - 1) * s :=
    mul_nonneg (mul_nonneg (by linarith) (by linarith)) hs0
  nlinarith

theorem primitiveFormula_lower (r x : ℝ) (hr : 0 < r) :
    -r / 8 ≤ primitiveFormula r x := by
  have hu := unitPrimitive_bounds x
  have hv := unitPrimitive_bounds (r * x)
  have hl := mul_le_mul_of_nonneg_left hu.1 hr.le
  have hd := div_nonpos_of_nonpos_of_nonneg hv.2 hr.le
  unfold primitiveFormula
  linarith

/-- Nonpositivity uses the actual integer subcell and fails for general real scales. -/
theorem primitiveFormula_nat_nonpos (m : ℕ) (x : ℝ) (hm : 0 < m) :
    primitiveFormula (m : ℝ) x ≤ 0 := by
  have hm' : 0 < (m : ℝ) := by exact_mod_cast hm
  let j : ℝ := (⌊(m : ℝ) * Int.fract x⌋ : ℝ)
  let s : ℝ := Int.fract ((m : ℝ) * x)
  have hj : 0 ≤ j := by
    dsimp [j]
    exact_mod_cast (Int.floor_nonneg.mpr (mul_nonneg hm'.le (Int.fract_nonneg x)))
  have hjm : j + 1 ≤ (m : ℝ) := by
    have hh : (m : ℝ) * Int.fract x < (m : ℝ) := by
      nlinarith [Int.fract_lt_one x]
    have hi := (Int.floor_le_sub_one_iff (z := (m : ℤ))).mpr hh
    dsimp [j]
    exact_mod_cast (by omega : ⌊(m : ℝ) * Int.fract x⌋ + 1 ≤ (m : ℤ))
  have hdec : j + s = (m : ℝ) * Int.fract x := by
    have hh := Int.fract_add_floor ((m : ℝ) * Int.fract x)
    rw [fract_nat_mul_fract] at hh
    dsimp [j, s]
    linarith
  have hrest : (m : ℝ) - j - s = (m : ℝ) * (1 - Int.fract x) := by linarith
  have hp := subcell_product_bound (m : ℝ) j s hj hjm
    (Int.fract_nonneg ((m : ℝ) * x)) (Int.fract_lt_one ((m : ℝ) * x)).le
  have hb : s * (1 - s) ≤ (m : ℝ) ^ 2 * Int.fract x * (1 - Int.fract x) := by
    calc
      _ ≤ (j + s) * ((m : ℝ) - j - s) := hp
      _ = _ := by rw [hdec, hrest]; ring
  have he : 2 * (m : ℝ) * primitiveFormula (m : ℝ) x =
      s * (1 - s) - (m : ℝ) ^ 2 * Int.fract x * (1 - Int.fract x) := by
    unfold primitiveFormula unitPrimitive
    dsimp [s]
    field_simp
    ring
  have hn : 2 * (m : ℝ) * primitiveFormula (m : ℝ) x ≤ 0 := by rw [he]; linarith
  by_contra hp
  have hprod := mul_pos (show 0 < 2 * (m : ℝ) by positivity) (lt_of_not_ge hp)
  linarith

theorem primitiveFormula_nat_bounds (m : ℕ) (x : ℝ) (hm : 0 < m) :
    -(m : ℝ) / 8 ≤ primitiveFormula (m : ℝ) x ∧ primitiveFormula (m : ℝ) x ≤ 0 :=
  ⟨primitiveFormula_lower (m : ℝ) x (by exact_mod_cast hm), primitiveFormula_nat_nonpos m x hm⟩

/-- The bound for the proved actual phase integral, including fractional terminal cells. -/
theorem phase_nat_integral_bounds (m : ℕ) (x : ℝ) (hm : 0 < m) :
    -(m : ℝ) / 8 ≤ (∫ y in (1 : ℝ)..x, phase (m : ℝ) y) ∧
    (∫ y in (1 : ℝ)..x, phase (m : ℝ) y) ≤ 0 := by
  rw [phase_nat_integral m x hm]
  exact primitiveFormula_nat_bounds m x hm

/-- Real-scale extension does not inherit the integer primitive sign or zero initial trace. -/
theorem primitiveFormula_three_halves_one : primitiveFormula (3 / 2) 1 = 1 / 12 := by
  norm_num [primitiveFormula, unitPrimitive, Int.fract]

#print axioms primitiveFormula_three_halves_one

#print axioms subcell_product_bound
#print axioms primitiveFormula_lower
#print axioms primitiveFormula_nat_nonpos
#print axioms primitiveFormula_nat_bounds
#print axioms phase_nat_integral_bounds

end BuildingBlocks.IntegerCarryPhase
