import BuildingBlocks.CoarseDyadicBase

open Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators Interval

namespace BuildingBlocks.CoarsePrimitive

lemma coarse_cpow_norm_le {X x a : ℝ} (hX : 1 ≤ X) (hx : X ≤ x)
    (ha : 0 ≤ a) {s : ℂ} (hs : a ≤ s.re) :
    ‖(x : ℂ) ^ (-s)‖ ≤ X ^ (-a) := by
  rw [Complex.norm_cpow_eq_rpow_re_of_pos (by linarith), Complex.neg_re]
  exact (Real.rpow_le_rpow_of_nonpos (by linarith) hx (by linarith)).trans
    (Real.rpow_le_rpow_of_exponent_le hX (by linarith))

lemma coarsePrime_mellin_norm_le {X a : ℝ} (hX : 1 ≤ X) (ha : 0 ≤ a)
    {s : ℂ} (hs : a ≤ s.re) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * X ^ (-(a + 1)) +
      ‖s + 1‖ * (X ^ (-(a + 2)) * Real.sqrt (X * coarsePrimitiveSquare X)) := by
  have hpos : 0 < X := by linarith
  have hi : ‖∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2))‖ ≤
      X ^ (-(a + 2)) * Real.sqrt (X * coarsePrimitiveSquare X) := by
    have h := intervalIntegral.norm_integral_le_of_norm_le
      (f := fun x => (coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2)))
      (g := fun x => X ^ (-(a + 2)) * |coarsePrefix X x|)
      (μ := volume) (a := X) (b := 2 * X) (by linarith)
      (Filter.Eventually.of_forall (fun x hx => show
        ‖(coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2))‖ ≤
          X ^ (-(a + 2)) * |coarsePrefix X x| by
        rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, mul_comm (X ^ _)]
        apply mul_le_mul_of_nonneg_left _ (abs_nonneg _)
        apply coarse_cpow_norm_le hX hx.1.le (by linarith)
        simpa using add_le_add_right hs 2))
      ((continuous_const.mul (coarsePrefix_continuous X).abs).intervalIntegrable _ _)
    rw [intervalIntegral.integral_const_mul] at h
    exact h.trans (mul_le_mul_of_nonneg_left (coarsePrefix_abs_integral_le_sqrt hpos.le)
      (Real.rpow_nonneg hpos.le _))
  rw [coarsePrime_mellin_block hpos]
  refine (norm_add_le _ _).trans (add_le_add ?_ ?_)
  · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
    apply mul_le_mul (coarse_terminal_mass_le_sqrt hpos) _ (norm_nonneg _) (Real.sqrt_nonneg _)
    norm_cast
    exact coarse_cpow_norm_le hX (by linarith) (by linarith) (by simpa using add_le_add_right hs 1)
  · rw [norm_mul]
    exact mul_le_mul_of_nonneg_left hi (norm_nonneg _)

lemma coarse_sqrt_rpow {X : ℝ} (hX : 0 ≤ X) (q : ℝ) :
    Real.sqrt (X ^ q) = X ^ (q / 2) := by
  rw [Real.sqrt_eq_rpow, ← Real.rpow_mul hX]
  congr 1
  ring

lemma coarse_energy_sqrt_bounds {X C ε : ℝ} (hX : 0 < X) (hC : 0 < C)
    (hE : coarsePrimitiveSquare X ≤ C * X ^ (4 + ε)) :
    Real.sqrt (2 * coarsePrimitiveSquare X / X) ≤
        Real.sqrt (2 * C) * X ^ ((3 + ε) / 2) ∧
    Real.sqrt (X * coarsePrimitiveSquare X) ≤
        Real.sqrt C * X ^ ((5 + ε) / 2) := by
  constructor
  · calc
      _ ≤ Real.sqrt (2 * (C * X ^ (4 + ε)) / X) :=
        Real.sqrt_le_sqrt (div_le_div_of_nonneg_right (by linarith) hX.le)
      _ = Real.sqrt ((2 * C) * X ^ (3 + ε)) := by
        congr 1
        rw [show 4 + ε = (3 + ε) + 1 by ring, Real.rpow_add hX, Real.rpow_one]
        field_simp
      _ = _ := by rw [Real.sqrt_mul (by positivity), coarse_sqrt_rpow hX.le]
  · calc
      _ ≤ Real.sqrt (X * (C * X ^ (4 + ε))) :=
        Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left hE hX.le)
      _ = Real.sqrt (C * X ^ (5 + ε)) := by
        congr 1
        rw [show 5 + ε = 1 + (4 + ε) by ring, Real.rpow_add hX 1 (4 + ε), Real.rpow_one]
        ring
      _ = _ := by rw [Real.sqrt_mul hC.le, coarse_sqrt_rpow hX.le]

lemma coarseMellinBlock_power_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M b : ℝ, 0 < M ∧ b < 0 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R →
      ‖coarseMellinBlock k s‖ ≤ M * ((2 : ℝ) ^ k) ^ b := by
  obtain ⟨C, hC, hE⟩ := hb (a - 1 / 2) (by linarith)
  refine ⟨Real.sqrt (2 * C) + R * Real.sqrt C, (1 / 2 - a) / 2, ?_, by linarith, ?_⟩
  · exact add_pos_of_pos_of_nonneg (Real.sqrt_pos.2 (by positivity)) (by positivity)
  intro k s hs hnorm
  let X : ℝ := 2 ^ k
  have hX : 1 ≤ X := one_le_pow₀ (by norm_num : (1 : ℝ) ≤ 2)
  have hXp : 0 < X := by linarith
  obtain ⟨ht, hp⟩ := coarse_energy_sqrt_bounds hXp hC (hE k)
  have hh := coarsePrime_mellin_norm_le hX (by linarith : 0 ≤ a) hs
  change ‖coarseMellinBlock k s‖ ≤ _ at hh
  calc
    _ ≤ Real.sqrt (2 * coarsePrimitiveSquare X / X) * X ^ (-(a + 1)) +
        ‖s + 1‖ * (X ^ (-(a + 2)) * Real.sqrt (X * coarsePrimitiveSquare X)) := hh
    _ ≤ (Real.sqrt (2 * C) * X ^ ((3 + (a - 1 / 2)) / 2)) * X ^ (-(a + 1)) +
        R * (X ^ (-(a + 2)) * (Real.sqrt C * X ^ ((5 + (a - 1 / 2)) / 2))) := by
      apply add_le_add
      · exact mul_le_mul_of_nonneg_right ht (Real.rpow_nonneg hXp.le _)
      · exact mul_le_mul hnorm (mul_le_mul_of_nonneg_left hp (Real.rpow_nonneg hXp.le _))
          (by positivity) hR
    _ = _ := by
      change _ = (Real.sqrt (2 * C) + R * Real.sqrt C) * X ^ ((1 / 2 - a) / 2)
      rw [mul_assoc (Real.sqrt (2 * C)), ← Real.rpow_add hXp]
      rw [show (3 + (a - 1 / 2)) / 2 + -(a + 1) = (1 / 2 - a) / 2 by ring]
      rw [mul_left_comm (X ^ (-(a + 2))) (Real.sqrt C), ← Real.rpow_add hXp]
      rw [show -(a + 2) + (5 + (a - 1 / 2)) / 2 = (1 / 2 - a) / 2 by ring]
      ring

lemma coarseMellinBlock_geometric_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k := by
  obtain ⟨M, b, hM, hbneg, hbound⟩ := coarseMellinBlock_power_bound hb ha hR
  refine ⟨M, (2 : ℝ) ^ b, hM, by positivity,
    Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) hbneg, ?_⟩
  intro k s hs hnorm
  have h := hbound k s hs hnorm
  rw [← Real.rpow_natCast_mul (by norm_num : (0 : ℝ) ≤ 2), mul_comm (k : ℝ),
    Real.rpow_mul_natCast (by norm_num : (0 : ℝ) ≤ 2)] at h
  exact h

end BuildingBlocks.CoarsePrimitive

#print axioms BuildingBlocks.CoarsePrimitive.coarsePrime_mellin_norm_le
#print axioms BuildingBlocks.CoarsePrimitive.coarseMellinBlock_geometric_bound
