import BuildingBlocks.ConnectedLowModeFinite

open Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks.ConnectedDyadicLowMode

open BuildingBlocks.ConnectedLowModeFinite
open CoarsePrimitive

noncomputable def freq (X : ℕ) (j : ℤ) : ℂ :=
  ((-j : ℤ) : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) / (X : ℂ)

noncomputable def modeDenom (j : ℤ) : ℂ :=
  2 * (Real.pi : ℂ) * Complex.I * (j : ℂ)

theorem modeDenom_ne_zero {j : ℤ} (hj : j ≠ 0) :
    modeDenom j ≠ 0 := by
  have hjc : (j : ℂ) ≠ 0 := by exact_mod_cast hj
  have hpic : (Real.pi : ℂ) ≠ 0 := by
    exact_mod_cast Real.pi_ne_zero
  unfold modeDenom
  exact mul_ne_zero
    (mul_ne_zero (mul_ne_zero (by norm_num) hpic) Complex.I_ne_zero) hjc

theorem freq_ne_zero {X : ℕ} {j : ℤ} (hX : 0 < X) (hj : j ≠ 0) :
    freq X j ≠ 0 := by
  have hXc : (X : ℂ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hX)
  have hjc : ((-j : ℤ) : ℂ) ≠ 0 := by
    exact_mod_cast (neg_ne_zero.mpr hj)
  have hpic : (Real.pi : ℂ) ≠ 0 := by
    exact_mod_cast Real.pi_ne_zero
  unfold freq
  exact div_ne_zero
    (mul_ne_zero hjc
      (mul_ne_zero (mul_ne_zero (by norm_num) hpic)
        Complex.I_ne_zero)) hXc

theorem inv_freq_eq (X : ℕ) (j : ℤ)
    (hX : 0 < X) (hj : j ≠ 0) :
    (freq X j)⁻¹ = -(X : ℂ) / modeDenom j := by
  have hXc : (X : ℂ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hX)
  have hdc := modeDenom_ne_zero hj
  unfold freq modeDenom at *
  have hjc : (j : ℂ) ≠ 0 := by exact_mod_cast hj
  have hpic : (Real.pi : ℂ) ≠ 0 := by
    exact_mod_cast Real.pi_ne_zero
  field_simp
  push_cast
  simp [hjc]

theorem freq_mul_X (X : ℕ) (j : ℤ) (hX : 0 < X) :
    freq X j * (X : ℂ) =
      ((-j : ℤ) : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
  have hX0 : (X : ℂ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hX)
  unfold freq
  field_simp

theorem freq_mul_twoX (X : ℕ) (j : ℤ) (hX : 0 < X) :
    freq X j * ((2 * X : ℕ) : ℂ) =
      ((-2 * j : ℤ) : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
  calc
    freq X j * ((2 * X : ℕ) : ℂ) =
        (freq X j * (X : ℂ)) * 2 := by push_cast; ring
    _ = ((-2 * j : ℤ) : ℂ) *
        (2 * (Real.pi : ℂ) * Complex.I) := by
          rw [freq_mul_X X j hX]
          push_cast
          ring

theorem exp_freq_X (X : ℕ) (j : ℤ) (hX : 0 < X) :
    Complex.exp (freq X j * (X : ℂ)) = 1 := by
  rw [freq_mul_X X j hX]
  exact Complex.exp_int_mul_two_pi_mul_I (-j)

theorem exp_freq_twoX (X : ℕ) (j : ℤ) (hX : 0 < X) :
    Complex.exp (freq X j * ((2 * X : ℕ) : ℂ)) = 1 := by
  rw [freq_mul_twoX X j hX]
  exact Complex.exp_int_mul_two_pi_mul_I (-2 * j)

theorem phasePrimitive_X (X : ℕ) (j : ℤ) (hX : 0 < X) :
    phasePrimitive (freq X j) (X : ℝ) =
      (freq X j)⁻¹ - (X : ℂ) := by
  unfold phasePrimitive
  rw [show ((X : ℝ) : ℂ) = (X : ℂ) by norm_cast, exp_freq_X X j hX]
  ring

theorem phasePrimitive_twoX (X : ℕ) (j : ℤ) (hX : 0 < X) :
    phasePrimitive (freq X j) ((2 * X : ℕ) : ℝ) =
      (freq X j)⁻¹ - ((2 * X : ℕ) : ℂ) := by
  unfold phasePrimitive
  rw [show ((((2 * X : ℕ) : ℝ)) : ℂ) = ((2 * X : ℕ) : ℂ) by norm_cast,
    exp_freq_twoX X j hX]
  ring

theorem psi_block (X : ℕ) :
    (psi (2 * X) : ℂ) =
      (psi X : ℂ) +
      ∑ n ∈ Finset.Ioc X (2 * X),
        (ArithmeticFunction.vonMangoldt n : ℂ) := by
  have hunion :
      Finset.range (2 * X + 1) =
        Finset.range (X + 1) ∪ Finset.Ioc X (2 * X) := by
    ext n
    simp only [Finset.mem_range, Finset.mem_union, Finset.mem_Ioc]
    omega
  have hdisj :
      Disjoint (Finset.range (X + 1)) (Finset.Ioc X (2 * X)) := by
    apply Finset.disjoint_left.mpr
    intro n hn hm
    simp only [Finset.mem_range] at hn
    simp only [Finset.mem_Ioc] at hm
    omega
  have hreal : psi (2 * X) =
      psi X + ∑ n ∈ Finset.Ioc X (2 * X),
        ArithmeticFunction.vonMangoldt n := by
    unfold psi
    rw [hunion, Finset.sum_union hdisj]
  exact_mod_cast hreal

noncomputable def densityPrimitive (k : ℂ) (t : ℝ) : ℂ :=
  (t : ℂ) * Complex.exp (k * (t : ℂ)) / k -
    Complex.exp (k * (t : ℂ)) / k ^ 2 - (t : ℂ) ^ 2 / 2

theorem densityPrimitive_hasDerivAt (k : ℂ) (hk : k ≠ 0) (t : ℝ) :
    HasDerivAt (densityPrimitive k)
      ((Complex.exp (k * (t : ℂ)) - 1) * (t : ℂ)) t := by
  have he : HasDerivAt
      (fun u : ℝ => Complex.exp (k * (u : ℂ)))
      (Complex.exp (k * (t : ℂ)) * k) t := by
    have hec : HasDerivAt
        (fun z : ℂ => Complex.exp (k * z))
        (Complex.exp (k * (t : ℂ)) * k) (t : ℂ) := by
      simpa only [id_eq, mul_one] using
        (((hasDerivAt_id (t : ℂ)).const_mul k).cexp)
    exact hec.comp_ofReal
  have ht : HasDerivAt (fun u : ℝ => (u : ℂ)) 1 t :=
    (hasDerivAt_id (t : ℂ)).comp_ofReal
  have hder :=
    ((ht.mul he).div_const k).sub (he.div_const (k ^ 2)) |>.sub
      ((ht.pow 2).div_const 2)
  convert hder using 1
  · field_simp [hk]
    ring

theorem densityIntegral (X : ℕ) (j : ℤ)
    (hX : 0 < X) (hj : j ≠ 0) :
    (∫ t in Set.Ioc (X : ℝ) ((2 * X : ℕ) : ℝ),
      (Complex.exp (freq X j * (t : ℂ)) - 1) * (t : ℂ)) =
      (X : ℂ) / freq X j - (3 / 2 : ℂ) * (X : ℂ) ^ 2 := by
  let k := freq X j
  have hk : k ≠ 0 := freq_ne_zero hX hj
  have hab : (X : ℝ) ≤ ((2 * X : ℕ) : ℝ) := by
    exact_mod_cast (show X ≤ 2 * X by omega)
  have hcont : Continuous
      (fun t : ℝ => (Complex.exp (k * (t : ℂ)) - 1) * (t : ℂ)) := by
    fun_prop
  have hi : IntervalIntegrable
      (fun t : ℝ => (Complex.exp (k * (t : ℂ)) - 1) * (t : ℂ))
      volume (X : ℝ) ((2 * X : ℕ) : ℝ) :=
    hcont.intervalIntegrable _ _
  have hftc := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun t _ => densityPrimitive_hasDerivAt k hk t) hi
  rw [intervalIntegral.integral_of_le hab] at hftc
  change
    (∫ t in Set.Ioc (X : ℝ) ((2 * X : ℕ) : ℝ),
      (Complex.exp (k * (t : ℂ)) - 1) * (t : ℂ)) =
      (X : ℂ) / k - (3 / 2 : ℂ) * (X : ℂ) ^ 2
  rw [hftc]
  simp only [densityPrimitive]
  rw [show (((X : ℝ) : ℂ)) = (X : ℂ) by norm_cast,
    show (((((2 * X : ℕ) : ℝ)) : ℂ)) = ((2 * X : ℕ) : ℂ) by norm_cast,
    exp_freq_X X j hX, exp_freq_twoX X j hX]
  have h2X : ((2 * X : ℕ) : ℂ) = 2 * (X : ℂ) := by norm_cast
  rw [h2X]
  field_simp [hk]
  ring

/-- The complete additive prime-power twist, including all proper powers. -/
noncomputable def actualB (X : ℕ) (j : ℤ) : ℂ :=
  (X : ℂ) +
    ∑ n ∈ Finset.Ioc X (2 * X),
      (ArithmeticFunction.vonMangoldt n : ℂ) *
        (Complex.exp (freq X j * (n : ℂ)) - 1)

/-- Equivalent finite terminal mass, arranged for the Abel algebra. -/
noncomputable def terminalSimple (X : ℕ) : ℂ :=
  2 * (X : ℂ) * (psi (2 * X) : ℂ) -
    (X : ℂ) * (psi X : ℂ) -
    (∑ n ∈ Finset.Ioc X (2 * X),
      (n : ℂ) * (ArithmeticFunction.vonMangoldt n : ℂ)) -
    (3 / 2 : ℂ) * (X : ℂ) ^ 2

/-- The complete prime-power weighted sum under the phase primitive. -/
theorem phasePrimeSum (X : ℕ) (j : ℤ) :
    (∑ n ∈ Finset.Ioc X (2 * X),
      phasePrimitive (freq X j) n *
        (ArithmeticFunction.vonMangoldt n : ℂ)) =
    (freq X j)⁻¹ *
      (∑ n ∈ Finset.Ioc X (2 * X),
        Complex.exp (freq X j * (n : ℂ)) *
          (ArithmeticFunction.vonMangoldt n : ℂ)) -
      (∑ n ∈ Finset.Ioc X (2 * X),
        (n : ℂ) * (ArithmeticFunction.vonMangoldt n : ℂ)) := by
  calc
    _ = ∑ n ∈ Finset.Ioc X (2 * X),
        ((freq X j)⁻¹ *
          (Complex.exp (freq X j * (n : ℂ)) *
            (ArithmeticFunction.vonMangoldt n : ℂ)) -
        (n : ℂ) * (ArithmeticFunction.vonMangoldt n : ℂ)) := by
          apply Finset.sum_congr rfl
          intro n hn
          unfold phasePrimitive
          push_cast
          ring
    _ = _ := by
      rw [Finset.sum_sub_distrib, ← Finset.mul_sum]

theorem actualB_expanded (X : ℕ) (j : ℤ) :
    actualB X j =
      (X : ℂ) +
      (∑ n ∈ Finset.Ioc X (2 * X),
        Complex.exp (freq X j * (n : ℂ)) *
          (ArithmeticFunction.vonMangoldt n : ℂ)) -
      (∑ n ∈ Finset.Ioc X (2 * X),
        (ArithmeticFunction.vonMangoldt n : ℂ)) := by
  unfold actualB
  simp_rw [mul_sub, mul_one, Finset.sum_sub_distrib]
  have hs :
      (∑ n ∈ Finset.Ioc X (2 * X),
        (ArithmeticFunction.vonMangoldt n : ℂ) *
          Complex.exp (freq X j * (n : ℂ))) =
      (∑ n ∈ Finset.Ioc X (2 * X),
        Complex.exp (freq X j * (n : ℂ)) *
          (ArithmeticFunction.vonMangoldt n : ℂ)) := by
    apply Finset.sum_congr rfl
    intro n hn
    ring
  rw [hs]
  ring

/-- The exact connected dyadic mode, with the complete von Mangoldt score. -/
theorem connected_mode_finite (X : ℕ) (j : ℤ)
    (hX : 1 ≤ X) (hj : j ≠ 0) :
    weightedActualError X (phasePrimitive (freq X j)) =
      (X : ℂ) / modeDenom j * actualB X j - terminalSimple X := by
  have hXp : 0 < X := by omega
  have hk : freq X j ≠ 0 := freq_ne_zero hXp hj
  have hXi : (X : ℂ) / freq X j = -((X : ℂ) ^ 2) / modeDenom j := by
    rw [div_eq_mul_inv, inv_freq_eq X j hXp hj]
    ring
  unfold terminalSimple
  rw [weightedPhaseActualError_finite hX hk,
    phasePrimitive_twoX X j hXp, phasePrimitive_X X j hXp,
    phasePrimeSum X j, densityIntegral X j hXp hj, hXi,
    actualB_expanded, inv_freq_eq X j hXp hj, psi_block X]
  have h2X : ((2 * X : ℕ) : ℂ) = 2 * (X : ℂ) := by norm_cast
  rw [h2X]
  have hd : modeDenom j ≠ 0 := modeDenom_ne_zero hj
  field_simp
  ring

theorem terminalSimple_eq_actual (X : ℕ) :
    terminalSimple X = (coarseTerminalMassFinite X : ℂ) := by
  unfold terminalSimple coarseTerminalMassFinite dyadicTerminalPrimeMass
  rw [psi_block X]
  push_cast
  simp_rw [sub_mul, Finset.sum_sub_distrib, ← Finset.mul_sum]
  ring

/-- The identity with the repository's established actual terminal mass. -/
theorem connected_mode_actual (X : ℕ) (j : ℤ)
    (hX : 1 ≤ X) (hj : j ≠ 0) :
    weightedActualError X (phasePrimitive (freq X j)) =
      (X : ℂ) / modeDenom j * actualB X j -
        (coarseTerminalMassFinite X : ℂ) := by
  rw [← terminalSimple_eq_actual X]
  exact connected_mode_finite X j hX hj

#print axioms exp_freq_X
#print axioms exp_freq_twoX
#print axioms connected_mode_finite
#print axioms connected_mode_actual

end BuildingBlocks.ConnectedDyadicLowMode
