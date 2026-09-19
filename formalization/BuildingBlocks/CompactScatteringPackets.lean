import BuildingBlocks.CompactLocalScatteringSigns

/-! Finite-packet prerequisites.
The physical operator assembly and smooth pole-null bump existence remain written. -/
namespace BuildingBlocks.CompactScatteringPackets

theorem isolated_packet_energy (r : ℝ) (M : ℕ) :
    r ^ 2 + (1 - r ^ 2) ^ 2 * ∑ j ∈ Finset.range M, (r ^ 2) ^ j =
      1 - (1 - r ^ 2) * (r ^ 2) ^ M := by
  have hg := geom_sum_mul_neg (r ^ 2) M
  calc
    _ = r ^ 2 + (1 - r ^ 2) *
      ((∑ j ∈ Finset.range M, (r ^ 2) ^ j) * (1 - r ^ 2)) := by ring
    _ = r ^ 2 + (1 - r ^ 2) * (1 - (r ^ 2) ^ M) := by rw [hg]
    _ = _ := by ring

theorem exists_finite_bulk_gain (M : ℕ) {G : ℝ} (hG : 1 < G) :
    ∃ J : ℕ, M < J ∧ (J - M : ℝ) * G > J := by
  obtain ⟨J, hJ⟩ := exists_nat_gt ((M : ℝ) * G / (G - 1))
  have hd : 0 < G - 1 := by linarith
  have hh : (M : ℝ) * G < (J : ℝ) * (G - 1) := (div_lt_iff₀ hd).mp hJ
  have hg : (J - M : ℝ) * G > J := by nlinarith
  have hmj : (M : ℝ) < J := by
    nlinarith [Nat.cast_nonneg (α := ℝ) J]
  exact ⟨J, by exact_mod_cast hmj, hg⟩

theorem separated_translate_values {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (i j : ℤ) (hij : i ≠ j) (v : ℝ) :
    eta (v - (i : ℝ) * L) = 0 ∨ eta (v - (j : ℝ) * L) = 0 := by
  by_contra h
  push_neg at h
  have hi := hs _ h.1
  have hj := hs _ h.2
  rcases lt_or_gt_of_ne hij with hlt | hgt
  · have he : (i : ℝ) + 1 ≤ j := by exact_mod_cast (show i + 1 ≤ j by omega)
    have hm := mul_le_mul_of_nonneg_right he hL.le
    nlinarith
  · have he : (j : ℝ) + 1 ≤ i := by exact_mod_cast (show j + 1 ≤ i by omega)
    have hm := mul_le_mul_of_nonneg_right he hL.le
    nlinarith

theorem disjoint_sum_normSq {ι : Type*} (s : Finset ι) (f : ι → ℂ)
    (hd : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → f i = 0 ∨ f j = 0) :
    Complex.normSq (∑ i ∈ s, f i) = ∑ i ∈ s, Complex.normSq (f i) := by
  classical
  by_cases he : ∃ i ∈ s, f i ≠ 0
  · obtain ⟨i, hi, hfi⟩ := he
    have hz : ∀ j ∈ s, j ≠ i → f j = 0 := by
      intro j hj hji
      exact (hd i hi j hj hji.symm).resolve_left hfi
    have hsum : ∑ j ∈ s, f j = f i :=
      Finset.sum_eq_single i hz (fun hni => (hni hi).elim)
    have hsumN : ∑ j ∈ s, Complex.normSq (f j) = Complex.normSq (f i) :=
      Finset.sum_eq_single i (fun j hj hji => by simp [hz j hj hji])
        (fun hni => (hni hi).elim)
    rw [hsum, hsumN]
  · have hz : ∀ i ∈ s, f i = 0 := by
      intro i hi
      by_contra hfi
      exact he ⟨i, hi, hfi⟩
    rw [Finset.sum_eq_zero hz, Finset.sum_eq_zero (fun i hi => by simp [hz i hi])]
    simp

theorem physical_translate_sum_normSq {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (s : Finset ℤ) (c : ℤ → ℂ) (v : ℝ) :
    Complex.normSq (∑ i ∈ s, c i * eta (v - (i : ℝ) * L)) =
      ∑ i ∈ s, Complex.normSq (c i) * Complex.normSq (eta (v - (i : ℝ) * L)) := by
  rw [disjoint_sum_normSq s _]
  · apply Finset.sum_congr rfl
    intro i hi
    exact map_mul Complex.normSq _ _
  · intro i hi j hj hij
    rcases separated_translate_values hL hw hs i j hij v with h | h
    · exact Or.inl (by rw [h, mul_zero])
    · exact Or.inr (by rw [h, mul_zero])


noncomputable def physicalSquare (f : ℝ → ℂ) : ℝ :=
  ∫ v : ℝ, Complex.normSq (f v)

theorem physical_translate_square (eta : ℝ → ℂ) (d : ℝ) :
    physicalSquare (fun v => eta (v - d)) = physicalSquare eta := by
  exact MeasureTheory.integral_sub_right_eq_self (fun v => Complex.normSq (eta v)) d

theorem physical_translate_sum_square {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (s : Finset ℤ) (c : ℤ → ℂ) :
    physicalSquare (fun v => ∑ i ∈ s, c i * eta (v - (i : ℝ) * L)) =
      (∑ i ∈ s, Complex.normSq (c i)) * physicalSquare eta := by
  unfold physicalSquare
  calc
    _ = ∫ v : ℝ, ∑ i ∈ s,
        Complex.normSq (c i) * Complex.normSq (eta (v - (i : ℝ) * L)) := by
      apply MeasureTheory.integral_congr_ae
      exact Filter.Eventually.of_forall (physical_translate_sum_normSq hL hw hs s c)
    _ = ∑ i ∈ s, ∫ v : ℝ,
        Complex.normSq (c i) * Complex.normSq (eta (v - (i : ℝ) * L)) := by
      apply MeasureTheory.integral_finset_sum
      intro i hi
      exact (heta.comp_sub_right ((i : ℝ) * L)).const_mul _
    _ = ∑ i ∈ s, Complex.normSq (c i) * (∫ v : ℝ, Complex.normSq (eta v)) := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [MeasureTheory.integral_const_mul]
      exact congrArg (fun x => Complex.normSq (c i) * x)
        (physical_translate_square eta ((i : ℝ) * L))
    _ = _ := by rw [Finset.sum_mul]


#print axioms physical_translate_square
#print axioms physical_translate_sum_square
#print axioms isolated_packet_energy
#print axioms exists_finite_bulk_gain
#print axioms separated_translate_values
#print axioms disjoint_sum_normSq
#print axioms physical_translate_sum_normSq
end BuildingBlocks.CompactScatteringPackets
