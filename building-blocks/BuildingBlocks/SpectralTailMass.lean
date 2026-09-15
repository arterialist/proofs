import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Measure.Lebesgue.Integral

/-! Both actual spectral tails. No logarithmic integrability is assumed. -/
noncomputable section
open Set MeasureTheory
namespace BuildingBlocks.SpectralTailMass

lemma reciprocal_square_integrable {t : ℝ} (ht : 0 < t) :
    IntegrableOn (fun x : ℝ => 1 / x ^ 2) (Ioi t) := by
  have hi := integrableOn_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1) ht
  refine hi.congr_fun (fun x hx => ?_) measurableSet_Ioi
  rw [Real.rpow_neg (le_of_lt (ht.trans hx)), Real.rpow_two]
  simp

lemma reciprocal_square_integral {t : ℝ} (ht : 0 < t) :
    (∫ x : ℝ in Ioi t, 1 / x ^ 2) = 1 / t := by
  have hi := integral_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1) ht
  have he : (∫ x : ℝ in Ioi t, x ^ (-2 : ℝ)) =
      ∫ x : ℝ in Ioi t, 1 / x ^ 2 := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x hx
    dsimp only
    rw [Real.rpow_neg (le_of_lt (ht.trans hx)), Real.rpow_two]
    simp
  rw [he] at hi
  norm_num [Real.rpow_neg_one, one_div] at hi ⊢
  exact hi

lemma positive_tail_le {r : ℝ → ℝ} {A t : ℝ} (hA : 0 ≤ A) (ht : 0 < t)
    (hr : Integrable r) (hb : ∀ x, r x ≤ A / (1 + x ^ 2)) :
    (∫ x in Ioi t, r x) ≤ A / t := by
  have hi := (reciprocal_square_integrable ht).const_mul A
  have hm : ∀ x ∈ Ioi t, r x ≤ A * (1 / x ^ 2) := by
    intro x hx
    have hx0 : 0 < x := ht.trans hx
    calc
      r x ≤ A / (1 + x ^ 2) := hb x
      _ ≤ A / x ^ 2 := div_le_div_of_nonneg_left hA (sq_pos_of_pos hx0) (by linarith)
      _ = A * (1 / x ^ 2) := by ring
  calc
    (∫ x in Ioi t, r x) ≤ ∫ x in Ioi t, A * (1 / x ^ 2) :=
      setIntegral_mono_on (hr.integrableOn) hi measurableSet_Ioi hm
    _ = A / t := by rw [integral_const_mul, reciprocal_square_integral ht]; ring

lemma two_sided_tail_le {r : ℝ → ℝ} {A t : ℝ} (hA : 0 ≤ A) (ht : 0 < t)
    (hr : Integrable r) (hb : ∀ x, r x ≤ A / (1 + x ^ 2)) :
    (∫ x in {x : ℝ | t < |x|}, r x) ≤ 2 * A / t := by
  have hn : Integrable (fun x : ℝ => r (-x)) :=
    (Measure.measurePreserving_neg (volume : Measure ℝ)).integrable_comp_of_integrable hr
  have hb' : ∀ x : ℝ, r (-x) ≤ A / (1 + x ^ 2) := by
    intro x
    simpa using hb (-x)
  have hl := positive_tail_le hA ht hn hb'
  rw [integral_comp_neg_Ioi, integral_Iic_eq_integral_Iio] at hl
  have hu := positive_tail_le hA ht hr hb
  have hs : {x : ℝ | t < |x|} = Iio (-t) ∪ Ioi t := by
    ext x
    simp only [mem_setOf_eq, mem_union, mem_Iio, mem_Ioi, lt_abs]
    constructor <;> intro h <;> rcases h with h | h
    · exact Or.inr h
    · exact Or.inl (by linarith)
    · exact Or.inr (by linarith)
    · exact Or.inl h
  have hd : Disjoint (Iio (-t)) (Ioi t) := by
    apply disjoint_left.mpr
    intro x hx hy
    have hx' : x < -t := hx
    have hy' : t < x := hy
    linarith
  rw [hs, setIntegral_union hd measurableSet_Ioi hr.integrableOn hr.integrableOn]
  calc
    _ ≤ A / t + A / t := add_le_add hl hu
    _ = 2 * A / t := by ring

lemma tail_le_mass {r : ℝ → ℝ} (hr : Integrable r) (hn : ∀ x, 0 ≤ r x) (t : ℝ) :
    (∫ x in {x : ℝ | t < |x|}, r x) ≤ ∫ x, r x :=
  setIntegral_le_integral hr (Filter.Eventually.of_forall hn)

lemma tail_le_min {r : ℝ → ℝ} {A t : ℝ} (hA : 0 ≤ A) (ht : 0 < t)
    (hr : Integrable r) (hn : ∀ x, 0 ≤ r x)
    (hb : ∀ x, r x ≤ A / (1 + x ^ 2)) :
    (∫ x in {x : ℝ | t < |x|}, r x) ≤ min (∫ x, r x) (2 * A / t) :=
  le_min (tail_le_mass hr hn t) (two_sided_tail_le hA ht hr hb)

#print axioms tail_le_min
#print axioms reciprocal_square_integrable
#print axioms reciprocal_square_integral
#print axioms positive_tail_le
#print axioms two_sided_tail_le
#print axioms tail_le_mass
end BuildingBlocks.SpectralTailMass
