import BuildingBlocks.FactorialRealCellRenewal

open Real Finset Set MeasureTheory
open scoped BigOperators
namespace BuildingBlocks.FactorialRealCellPhase

/-- Literal real quotient floors count all rational step endpoints, including equality. -/
theorem real_floor_step_sum (q : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    (⌊(q : ℝ) / x⌋₊ : ℝ) =
      ∑ k ∈ Finset.Icc 1 q, if x ≤ (q : ℝ) / k then (1 : ℝ) else 0 := by
  have hxp : 0 < x := by linarith
  have hnon : 0 ≤ (q : ℝ) / x := div_nonneg (Nat.cast_nonneg q) hxp.le
  have hf : ⌊(q : ℝ) / x⌋₊ ≤ q := by
    have hle : (q : ℝ) / x ≤ q := (div_le_iff₀ hxp).mpr (by nlinarith [Nat.cast_nonneg (α := ℝ) q])
    simpa only [Nat.floor_natCast] using Nat.floor_mono hle
  have he : ∀ k ∈ Finset.Icc 1 q,
      x ≤ (q : ℝ) / k ↔ k ≤ ⌊(q : ℝ) / x⌋₊ := by
    intro k hk
    have hkp : (0 : ℝ) < k := by exact_mod_cast (Finset.mem_Icc.mp hk).1
    rw [Nat.le_floor_iff hnon, le_div_iff₀ hxp, le_div_iff₀ hkp]
    rw [mul_comm x (k : ℝ)]
  have hs : (∑ k ∈ Finset.Icc 1 ⌊(q : ℝ) / x⌋₊,
      if x ≤ (q : ℝ) / k then (1 : ℝ) else 0) =
      ∑ k ∈ Finset.Icc 1 q, if x ≤ (q : ℝ) / k then (1 : ℝ) else 0 := by
    apply Finset.sum_subset
    · intro k hk
      exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hk).1, (Finset.mem_Icc.mp hk).2.trans hf⟩
    · intro k hk hnot
      rw [if_neg]
      intro hh
      exact hnot (Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hk).1, (he k hk).mp hh⟩)
  have hv : (∑ k ∈ Finset.Icc 1 ⌊(q : ℝ) / x⌋₊,
      if x ≤ (q : ℝ) / k then (1 : ℝ) else 0) =
      ∑ k ∈ Finset.Icc 1 ⌊(q : ℝ) / x⌋₊, (1 : ℝ) := by
    apply Finset.sum_congr rfl
    intro k hk
    have hkq : k ∈ Finset.Icc 1 q := Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hk).1, (Finset.mem_Icc.mp hk).2.trans hf⟩
    exact if_pos ((he k hkq).mpr (Finset.mem_Icc.mp hk).2)
  rw [← hs, hv]
  simp

theorem inversePhase_indicator_intervalIntegrable {t X : ℝ} (ht : 0 < t) (hX : 1 ≤ X)
    (a : ℝ) : IntervalIntegrable ((Set.Iic a).indicator (fun x => -inverseTestPhase x t)) volume 1 X := by
  apply (inverseTestPhase_intervalIntegrable ht hX).neg.mono_fun
    ((inverseTestPhase_measurable t).neg.indicator measurableSet_Iic).aestronglyMeasurable
  exact Filter.Eventually.of_forall (fun x => norm_indicator_le_norm_self _ x)

theorem real_floor_inversePhase_step_eq (q : ℕ) (t : ℝ) {X : ℝ} (hX : 1 ≤ X) : Set.EqOn
      (fun x => (⌊(q : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t))
      (fun x => ∑ k ∈ Finset.Icc 1 q,
        (Set.Iic ((q : ℝ) / k)).indicator (fun y => -inverseTestPhase y t) x) (Set.uIcc 1 X) := by
    intro x hx
    dsimp only
    have hx1 : 1 ≤ x := (by simpa only [Set.uIcc_of_le hX] using hx : x ∈ Set.Icc 1 X).1
    rw [real_floor_step_sum q hx1, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro k hk
    by_cases hh : x ≤ (q : ℝ) / k <;> simp [Set.indicator, hh]

/-- Full rational-step integration with the origin and terminal values retained. -/
theorem real_floor_inversePhase_intervalIntegrable (q : ℕ) {t X : ℝ}
    (ht : 0 < t) (hX : 1 ≤ X) :
    IntervalIntegrable (fun x => (⌊(q : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t)) volume 1 X := by
  have hs := IntervalIntegrable.sum (Finset.Icc 1 q)
    (fun (k : ℕ) _ => inversePhase_indicator_intervalIntegrable ht hX ((q : ℝ) / k))
  apply hs.congr
  intro x hx
  simpa only [Finset.sum_apply] using
    (real_floor_inversePhase_step_eq q t hX (Set.uIoc_subset_uIcc hx)).symm

theorem real_floor_inversePhase_integral (q : ℕ) {t X : ℝ} (ht : 0 < t)
    (hq : 0 < q) (hqX : (q : ℝ) ≤ X) :
    (∫ x in (1 : ℝ)..X, (⌊(q : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t)) = centeredTest t q := by
  have hq1 : (1 : ℝ) ≤ q := by exact_mod_cast hq
  have hX : 1 ≤ X := hq1.trans hqX
  have he := real_floor_inversePhase_step_eq q t hX
  rw [intervalIntegral.integral_congr he]
  rw [intervalIntegral.integral_finset_sum (s := Finset.Icc 1 q)
    (fun (k : ℕ) _ => inversePhase_indicator_intervalIntegrable ht hX ((q : ℝ) / k))]
  have hj : ∀ k ∈ Finset.Icc 1 q,
      (∫ x in (1 : ℝ)..X, (Set.Iic ((q : ℝ) / k)).indicator (fun y => -inverseTestPhase y t) x) =
      movingInverseTest t ((q : ℝ) / k) := by
    intro k hk
    have hh := Finset.mem_Icc.mp hk
    have hkp : (0 : ℝ) < k := by exact_mod_cast hh.1
    have hkq : (k : ℝ) ≤ q := by exact_mod_cast hh.2
    have hl : 1 ≤ (q : ℝ) / k := (le_div_iff₀ hkp).mpr (by simpa using hkq)
    have hu : (q : ℝ) / k ≤ X :=
      (div_le_self (Nat.cast_nonneg q) (by exact_mod_cast hh.1)).trans hqX
    change (∫ x in (1 : ℝ)..X, ({x : ℝ | x ≤ (q : ℝ) / k}).indicator
      (fun y => -inverseTestPhase y t) x) = movingInverseTest t ((q : ℝ) / k)
    rw [intervalIntegral.integral_indicator (f := fun y => -inverseTestPhase y t)
      (μ := volume) (Set.mem_Icc.mpr ⟨hl, hu⟩)]
    exact movingInverseTest_integral_from_one ht hl
  rw [Finset.sum_congr rfl hj]
  exact movingInverseTest_rational_renewal q t hq

/-- The original factorial response reconstructed from every literal real quotient floor. -/
theorem actual_real_floor_response_integral (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    (∫ x in (1 : ℝ)..N,
      (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ)) * (-inverseTestPhase x t)) =
      BuildingBlocks.FactorialBinaryCarry.response N t - (1 - exp (-t)) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  simp_rw [Finset.sum_mul, mul_assoc]
  rw [intervalIntegral.integral_finset_sum (s := Finset.Icc 1 N)
    (fun (n : ℕ) _ => (real_floor_inversePhase_intervalIntegrable (N / n) ht hNr).const_mul
      (ArithmeticFunction.moebius n : ℝ))]
  simp_rw [intervalIntegral.integral_const_mul]
  have he : ∀ n ∈ Finset.Icc 1 N,
      (∫ x in (1 : ℝ)..N, (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t)) =
      ∑ k ∈ Finset.Icc 1 (N / n), movingInverseTest t (((N / n : ℕ) : ℝ) / k) := by
    intro n hn
    have hq := Nat.div_pos (Finset.mem_Icc.mp hn).2 (Finset.mem_Icc.mp hn).1
    rw [real_floor_inversePhase_integral (N / n) ht hq
      (by exact_mod_cast Nat.div_le_self N n)]
    exact (movingInverseTest_rational_renewal (N / n) t hq).symm
  have hs : (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
      (∫ x in (1 : ℝ)..N, (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ) * (-inverseTestPhase x t))) =
      ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        ∑ k ∈ Finset.Icc 1 (N / n), movingInverseTest t (((N / n : ℕ) : ℝ) / k) := by
    apply Finset.sum_congr rfl
    intro n hn
    rw [he n hn]
  rw [hs]
  exact actual_rational_jump_pairing N t hN

#print axioms actual_real_floor_response_integral
#print axioms real_floor_inversePhase_intervalIntegrable
#print axioms real_floor_inversePhase_step_eq
#print axioms real_floor_inversePhase_integral
#print axioms inversePhase_indicator_intervalIntegrable
#print axioms real_floor_step_sum
end BuildingBlocks.FactorialRealCellPhase
