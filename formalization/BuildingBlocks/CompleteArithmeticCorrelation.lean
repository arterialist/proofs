import BuildingBlocks.PhysicalScatteringCorrelation

open MeasureTheory
namespace BuildingBlocks.CompleteArithmeticCorrelation
open BuildingBlocks.PhysicalScatteringCorrelation
open BuildingBlocks.FullComplexHistoryMellin

theorem correlation_zero_of_width {f g : ℝ → ℂ} {a b x : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (hx : b - a ≤ x) :
    correlation f g x = 0 := by
  unfold correlation
  have he : (fun v : ℝ => g (v + x) * (starRingEnd ℂ) (f v)) = 0 := by
    funext v
    by_cases hv : f v = 0
    · simp [hv]
    · have hs := hf v hv
      have hz : g (v + x) = 0 := by
        by_contra hne
        have ht := hg (v + x) hne
        linarith
      simp [hz]
  rw [he]
  exact integral_zero ℝ ℂ

theorem exists_shared_support_bounds {f g : ℝ → ℂ}
    (hf : HasCompactSupport f) (hg : HasCompactSupport g) :
    ∃ a b : ℝ, (∀ v, f v ≠ 0 → a < v ∧ v < b) ∧
      (∀ v, g v ≠ 0 → a < v ∧ v < b) := by
  have hc := hf.isCompact.union hg.isCompact
  obtain ⟨a, ha⟩ := hc.bddBelow
  obtain ⟨b, hb⟩ := hc.bddAbove
  refine ⟨a - 1, b + 1, ?_, ?_⟩
  · intro v hv
    have hs : v ∈ tsupport f ∪ tsupport g :=
      Or.inl (subset_tsupport f hv)
    have hl := ha hs
    have hu := hb hs
    constructor <;> linarith
  · intro v hv
    have hs : v ∈ tsupport f ∪ tsupport g :=
      Or.inr (subset_tsupport g hv)
    have hl := ha hs
    have hu := hb hs
    constructor <;> linarith

noncomputable def arithmeticTerm (f g : ℝ → ℂ) (n : ℕ) : ℂ :=
  if 2 ≤ n then ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
    (correlation f g (Real.log (n : ℝ)) + (starRingEnd ℂ) (correlation g f (Real.log (n : ℝ))))
  else 0

noncomputable def arithmeticRow (f g : ℝ → ℂ) : ℂ := ∑' n : ℕ, arithmeticTerm f g n

theorem arithmetic_term_zero_outside {f g : ℝ → ℂ} {a b : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (N : ℕ)
    (hN : Real.exp (b - a) ≤ (N : ℝ) + 1) (n : ℕ) (hn : n ∉ Finset.Icc 2 N) :
    arithmeticTerm f g n = 0 := by
  unfold arithmeticTerm
  split_ifs with h2
  · have hnt : N < n := by
      by_contra he
      exact hn (Finset.mem_Icc.mpr ⟨h2, by omega⟩)
    have hcast : (N : ℝ) + 1 ≤ n := by exact_mod_cast (show N + 1 ≤ n by omega)
    have hl := Real.log_le_log (Real.exp_pos (b - a)) (le_trans hN hcast)
    rw [Real.log_exp] at hl
    rw [correlation_zero_of_width hf hg hl, correlation_zero_of_width hg hf hl]
    simp
  · rfl

theorem arithmetic_row_eq_cutoff {f g : ℝ → ℂ} {a b : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (N : ℕ)
    (hN : Real.exp (b - a) ≤ (N : ℝ) + 1) :
    arithmeticRow f g = arithmeticCutoff N f g := by
  unfold arithmeticRow
  rw [tsum_eq_sum (arithmetic_term_zero_outside hf hg N hN)]
  unfold arithmeticCutoff
  apply Finset.sum_congr rfl
  intro n hn
  simp only [arithmeticTerm, if_pos (Finset.mem_Icc.mp hn).1]

theorem exists_arithmetic_cutoff {f g : ℝ → ℂ}
    (hf : HasCompactSupport f) (hg : HasCompactSupport g) :
    ∃ N0 : ℕ, ∀ N : ℕ, N0 ≤ N → arithmeticRow f g = arithmeticCutoff N f g := by
  obtain ⟨a, b, hfa, hga⟩ := exists_shared_support_bounds hf hg
  obtain ⟨N0, hN0⟩ := exists_nat_gt (Real.exp (b - a))
  refine ⟨N0, fun N hN => arithmetic_row_eq_cutoff hfa hga N ?_⟩
  have he : (N0 : ℝ) ≤ N := by exact_mod_cast hN
  linarith

theorem arithmetic_absolute_summable {f g : ℝ → ℂ}
    (hf : HasCompactSupport f) (hg : HasCompactSupport g) :
    Summable (fun n => ‖arithmeticTerm f g n‖) := by
  obtain ⟨a, b, hfa, hga⟩ := exists_shared_support_bounds hf hg
  obtain ⟨N, hN⟩ := exists_nat_gt (Real.exp (b - a))
  have hz := arithmetic_term_zero_outside hfa hga N (by linarith)
  apply summable_of_ne_finset_zero (s := Finset.Icc 2 N)
  intro n hn
  rw [hz n hn, norm_zero]

theorem complete_finite_translate_arithmetic_row {ι κ : Type*} (s : Finset ι) (t : Finset κ)
    (c : ι → ℂ) (e : κ → ℂ) (a : ι → ℝ) (b : κ → ℝ) {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) :
    ∃ N0 : ℕ, ∀ N : ℕ, N0 ≤ N →
      arithmeticRow (finiteTranslate s c a f) (finiteTranslate t e b g) =
        ∑ n ∈ Finset.Icc 2 N,
          ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
            ((∑ j ∈ t, ∑ i ∈ s, (e j * (starRingEnd ℂ) (c i)) *
              correlation f g (Real.log (n : ℝ) + a i - b j)) +
              (starRingEnd ℂ) (∑ i ∈ s, ∑ j ∈ t, (c i * (starRingEnd ℂ) (e j)) *
                correlation g f (Real.log (n : ℝ) + b j - a i))) := by
  obtain ⟨N0, hN0⟩ := exists_arithmetic_cutoff
    (finite_translate_compact s c a hfc) (finite_translate_compact t e b hgc)
  refine ⟨N0, fun N hN => ?_⟩
  have hcut : arithmeticRow (finiteTranslate s c a f) (finiteTranslate t e b g) =
      arithmeticCutoff N (finiteTranslate s c a f) (finiteTranslate t e b g) := hN0 N hN
  rw [hcut, finite_translate_arithmetic_cutoff s t c e a b hf hg hfc hgc]

theorem exists_common_arithmetic_cutoff {f g F G : ℝ → ℂ}
    (hf : HasCompactSupport f) (hg : HasCompactSupport g)
    (hF : HasCompactSupport F) (hG : HasCompactSupport G) :
    ∃ N0 : ℕ, ∀ N : ℕ, N0 ≤ N →
      arithmeticRow f g = arithmeticCutoff N f g ∧ arithmeticRow F G = arithmeticCutoff N F G := by
  obtain ⟨N1, hN1⟩ := exists_arithmetic_cutoff hf hg
  obtain ⟨N2, hN2⟩ := exists_arithmetic_cutoff hF hG
  refine ⟨max N1 N2, fun N hN => ⟨hN1 N ?_, hN2 N ?_⟩⟩
  · exact le_trans (le_max_left _ _) hN
  · exact le_trans (le_max_right _ _) hN

theorem weighted_von_mangoldt_prime_powers (N : ℕ) (w : ℕ → ℂ) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n) =
      ∑ p ∈ Finset.Icc 2 N, if p.Prime then
        ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then (Real.log (p : ℝ) : ℂ) * w (p ^ j) else 0 else 0 := by
  classical
  let P := (Finset.Icc 2 N ×ˢ Finset.Icc 1 N).filter (fun a => a.1.Prime ∧ a.1 ^ a.2 ≤ N)
  let Q := (Finset.Icc 1 N).filter IsPrimePow
  have hbij : (∑ a ∈ P, (Real.log (a.1 : ℝ) : ℂ) * w (a.1 ^ a.2)) =
      ∑ n ∈ Q, (ArithmeticFunction.vonMangoldt n : ℂ) * w n := by
    apply Finset.sum_bij (fun a _ => a.1 ^ a.2)
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨ha, hp, hpow⟩
      have hj := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨pow_pos hp.pos _, hpow⟩,
        ⟨a.1, a.2, hp.prime, hj, rfl⟩⟩
    · intro a ha b hb hab
      rcases Finset.mem_filter.mp ha with ⟨ha, hpa, _⟩
      rcases Finset.mem_filter.mp hb with ⟨hb, hpb, _⟩
      have hja := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      have hjb := (Finset.mem_Icc.mp (Finset.mem_product.mp hb).2).1
      have hpa' : a.1 = b.1 := by
        have hpow : a.1 ^ ((a.2 - 1) + 1) = b.1 ^ ((b.2 - 1) + 1) := by
          simpa [Nat.sub_add_cancel hja, Nat.sub_add_cancel hjb] using hab
        exact (hpa.pow_inj hpb hpow).1
      apply Prod.ext hpa'
      apply Nat.pow_right_injective hpb.two_le
      simpa [hpa'] using hab
    · intro n hn
      rcases Finset.mem_filter.mp hn with ⟨hn, hpw⟩
      rcases hpw with ⟨p, j, hp, hj, hpow⟩
      have hp' : p.Prime := Nat.prime_iff.mpr hp
      have hnN := (Finset.mem_Icc.mp hn).2
      have hpN : p ≤ N := by
        calc
          p = p ^ 1 := by simp
          _ ≤ p ^ j := pow_le_pow_right₀ hp'.one_lt.le hj
          _ ≤ N := by simpa [hpow] using hnN
      have hjN : j ≤ N := (j.lt_pow_self hp'.one_lt).le.trans (by simpa [hpow] using hnN)
      refine ⟨(p, j), ?_, hpow⟩
      exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
        ⟨Finset.mem_Icc.mpr ⟨hp'.two_le, hpN⟩, Finset.mem_Icc.mpr ⟨hj, hjN⟩⟩,
        hp', by simpa [hpow] using hnN⟩
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨ha, hp, _⟩
      have hj := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega), ArithmeticFunction.vonMangoldt_apply_prime hp]
  have hQ : (∑ n ∈ Q, (ArithmeticFunction.vonMangoldt n : ℂ) * w n) =
      ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n := by
    apply Finset.sum_subset (Finset.filter_subset _ _)
    intro n hn hnq
    have hz : ArithmeticFunction.vonMangoldt n = 0 :=
      ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr (fun h => hnq (Finset.mem_filter.mpr ⟨hn, h⟩))
    simp [hz]
  rw [← hQ, ← hbij]
  dsimp only [P]
  rw [Finset.sum_filter, Finset.sum_product]
  apply Finset.sum_congr rfl
  intro p _
  by_cases hp : p.Prime <;> simp [hp]

#print axioms weighted_von_mangoldt_prime_powers

theorem actual_history_arithmetic_absolute_summable {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) :
    Summable (fun n => ‖arithmeticTerm (blockPhysical ps M f) (blockPhysical ps M g) n‖) :=
  arithmetic_absolute_summable (block_regular hf hfc ps M).2 (block_regular hg hgc ps M).2

theorem actual_history_common_arithmetic_cutoff {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) :
    ∃ N0 : ℕ, ∀ N : ℕ, N0 ≤ N →
      arithmeticRow f g = arithmeticCutoff N f g ∧
      arithmeticRow (blockPhysical ps M f) (blockPhysical ps M g) =
        arithmeticCutoff N (blockPhysical ps M f) (blockPhysical ps M g) :=
  exists_common_arithmetic_cutoff hfc hgc
    (block_regular hf hfc ps M).2 (block_regular hg hgc ps M).2

#print axioms actual_history_arithmetic_absolute_summable
#print axioms actual_history_common_arithmetic_cutoff
#print axioms arithmetic_absolute_summable
#print axioms complete_finite_translate_arithmetic_row
#print axioms exists_common_arithmetic_cutoff
#print axioms correlation_zero_of_width
#print axioms exists_shared_support_bounds
#print axioms arithmetic_term_zero_outside
#print axioms arithmetic_row_eq_cutoff
#print axioms exists_arithmetic_cutoff
noncomputable def primePowerCutoff (N : ℕ) (f g : ℝ → ℂ) : ℂ :=
  ∑ p ∈ Finset.Icc 2 N, if p.Prime then
    ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then
      (Real.log (p : ℝ) : ℂ) * ((1 / Real.sqrt ((p ^ j : ℕ) : ℝ) : ℝ) : ℂ) *
        (correlation f g (Real.log ((p ^ j : ℕ) : ℝ)) +
          (starRingEnd ℂ) (correlation g f (Real.log ((p ^ j : ℕ) : ℝ))))
    else 0 else 0

theorem arithmetic_cutoff_eq_prime_powers (N : ℕ) (f g : ℝ → ℂ) :
    arithmeticCutoff N f g = primePowerCutoff N f g := by
  let w : ℕ → ℂ := fun n => ((1 / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
    (correlation f g (Real.log (n : ℝ)) + (starRingEnd ℂ) (correlation g f (Real.log (n : ℝ))))
  have hs : (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n) =
      ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n := by
    apply Finset.sum_subset
    · intro n hn
      rcases Finset.mem_Icc.mp hn with ⟨hl, hu⟩
      exact Finset.mem_Icc.mpr ⟨by omega, hu⟩
    · intro n hn hn2
      have he : n = 1 := by
        simp only [Finset.mem_Icc] at hn hn2
        omega
      simp [he]
  have hw : arithmeticCutoff N f g =
      ∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n := by
    unfold arithmeticCutoff
    apply Finset.sum_congr rfl
    intro n _
    dsimp [w]
    push_cast
    ring
  rw [hw, hs, weighted_von_mangoldt_prime_powers N w]
  unfold primePowerCutoff
  simp only [w, mul_assoc]

theorem complete_arithmetic_row_prime_powers {f g : ℝ → ℂ}
    (hf : HasCompactSupport f) (hg : HasCompactSupport g) :
    ∃ N0 : ℕ, ∀ N : ℕ, N0 ≤ N → arithmeticRow f g = primePowerCutoff N f g := by
  obtain ⟨N0, hN0⟩ := exists_arithmetic_cutoff hf hg
  refine ⟨N0, fun N hN => ?_⟩
  rw [hN0 N hN, arithmetic_cutoff_eq_prime_powers]

theorem actual_history_common_prime_power_cutoff {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) :
    ∃ N0 : ℕ, ∀ N : ℕ, N0 ≤ N →
      arithmeticRow f g = primePowerCutoff N f g ∧
      arithmeticRow (blockPhysical ps M f) (blockPhysical ps M g) =
        primePowerCutoff N (blockPhysical ps M f) (blockPhysical ps M g) := by
  obtain ⟨N0, hN0⟩ := actual_history_common_arithmetic_cutoff hf hg hfc hgc ps M
  refine ⟨N0, fun N hN => ?_⟩
  obtain ⟨ha, hb⟩ := hN0 N hN
  exact ⟨ha.trans (arithmetic_cutoff_eq_prime_powers N f g),
    hb.trans (arithmetic_cutoff_eq_prime_powers N _ _)⟩

#print axioms arithmetic_cutoff_eq_prime_powers
#print axioms complete_arithmetic_row_prime_powers
#print axioms actual_history_common_prime_power_cutoff
end BuildingBlocks.CompleteArithmeticCorrelation
