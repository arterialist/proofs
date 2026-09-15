import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

open MeasureTheory Set
open scoped BigOperators

set_option autoImplicit false

namespace BuildingBlocks.IntegerBirthGram

/-- The native integer birth, including its exact arrival endpoint. -/
noncomputable def seed (m : ℕ) (v : ℝ) : ℝ :=
  (Ici (Real.log (m : ℝ))).indicator (fun v => Real.exp (-v / 2)) v

theorem seed_product_of_le {m l : ℕ} (hm : 1 ≤ m) (hml : m ≤ l) :
    (fun v => seed m v * seed l v) =
      (Ici (Real.log (l : ℝ))).indicator (fun v => Real.exp (-v)) := by
  have hm0 : (0 : ℝ) < m := by exact_mod_cast (show 0 < m by omega)
  have hlog : Real.log (m : ℝ) ≤ Real.log (l : ℝ) :=
    Real.log_le_log hm0 (by exact_mod_cast hml)
  funext v
  by_cases hv : Real.log (l : ℝ) ≤ v
  · have hvm : Real.log (m : ℝ) ≤ v := hlog.trans hv
    simp only [seed, indicator_of_mem (show v ∈ Ici (Real.log (l : ℝ)) from hv),
      indicator_of_mem (show v ∈ Ici (Real.log (m : ℝ)) from hvm)]
    rw [← Real.exp_add]
    congr 1
    ring
  · simp only [seed, indicator_of_notMem
      (show v ∉ Ici (Real.log (l : ℝ)) from hv), mul_zero]

theorem seed_product_integrable_of_le {m l : ℕ} (hm : 1 ≤ m) (hml : m ≤ l) :
    Integrable (fun v => seed m v * seed l v) := by
  rw [seed_product_of_le hm hml]
  apply (integrable_indicator_iff measurableSet_Ici).mpr
  apply (integrableOn_Ici_iff_integrableOn_Ioi).mpr
  simpa using integrableOn_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0)
    (Real.log (l : ℝ))

theorem seed_product_integrable {m l : ℕ} (hm : 1 ≤ m) (hl : 1 ≤ l) :
    Integrable (fun v => seed m v * seed l v) := by
  rcases le_total m l with h | h
  · exact seed_product_integrable_of_le hm h
  · simpa only [mul_comm] using seed_product_integrable_of_le hl h

theorem seed_gram_of_le {m l : ℕ} (hm : 1 ≤ m) (hml : m ≤ l) :
    (∫ v : ℝ, seed m v * seed l v) = 1 / (l : ℝ) := by
  have hl0 : (0 : ℝ) < l := by exact_mod_cast (show 0 < l by omega)
  rw [seed_product_of_le hm hml, integral_indicator measurableSet_Ici,
    integral_Ici_eq_integral_Ioi]
  have he : (∫ v in Ioi (Real.log (l : ℝ)), Real.exp (-v)) =
      Real.exp (-Real.log (l : ℝ)) := by
    simpa using integral_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0)
      (Real.log (l : ℝ))
  rw [he, Real.exp_neg, Real.exp_log hl0, one_div]

/-- The Gram entry is evaluated in the original age metric dv. -/
theorem seed_gram {m l : ℕ} (hm : 1 ≤ m) (hl : 1 ≤ l) :
    (∫ v : ℝ, seed m v * seed l v) = 1 / ((max m l : ℕ) : ℝ) := by
  rcases le_total m l with h | h
  · rw [max_eq_right h]
    exact seed_gram_of_le hm h
  · rw [max_eq_left h]
    simpa only [mul_comm] using seed_gram_of_le hl h

theorem seed_square_integrable {m : ℕ} (hm : 1 ≤ m) :
    Integrable (fun v => seed m v ^ 2) := by
  simpa only [pow_two] using seed_product_integrable hm hm

theorem seed_square_integral {m : ℕ} (hm : 1 ≤ m) :
    (∫ v : ℝ, seed m v ^ 2) = 1 / (m : ℝ) := by
  simpa only [pow_two, max_self] using seed_gram hm hm

theorem finite_square_expansion (s : Finset ℕ) (c : ℕ → ℝ) (v : ℝ) :
    (∑ n ∈ s, c n * seed n v)^2 =
      ∑ m ∈ s, ∑ n ∈ s, c m * c n * (seed m v * seed n v) := by
  rw [pow_two, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro m _
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n _
  ring

/-- Every finite real combination has an integrable original-metric square. -/
theorem finite_square_integrable (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 1 ≤ n) :
    Integrable (fun v => (∑ n ∈ s, c n * seed n v)^2) := by
  have hi : Integrable (fun v => ∑ m ∈ s, ∑ n ∈ s,
      c m * c n * (seed m v * seed n v)) := by
    apply integrable_finset_sum
    intro m hm
    apply integrable_finset_sum
    intro n hn
    exact (seed_product_integrable (hs m hm) (hs n hn)).const_mul (c m * c n)
  apply hi.congr
  filter_upwards [] with v
  exact (finite_square_expansion s c v).symm

theorem finite_energy_eq_kernel (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 1 ≤ n) :
    (∫ v : ℝ, (∑ n ∈ s, c n * seed n v)^2) =
      ∑ m ∈ s, ∑ n ∈ s, c m * c n / ((max m n : ℕ) : ℝ) := by
  have hi (m n : ℕ) (hm : m ∈ s) (hn : n ∈ s) :
      Integrable (fun v => c m * c n * (seed m v * seed n v)) :=
    (seed_product_integrable (hs m hm) (hs n hn)).const_mul (c m * c n)
  have he : (∫ v : ℝ, (∑ n ∈ s, c n * seed n v)^2) =
      ∫ v : ℝ, ∑ m ∈ s, ∑ n ∈ s, c m * c n * (seed m v * seed n v) := by
    apply integral_congr_ae
    filter_upwards [] with v
    exact finite_square_expansion s c v
  rw [he, integral_finset_sum _ (fun m hm =>
    integrable_finset_sum _ (fun n hn => hi m n hm hn))]
  apply Finset.sum_congr rfl
  intro m hm
  rw [integral_finset_sum _ (fun n hn => hi m n hm hn)]
  apply Finset.sum_congr rfl
  intro n hn
  rw [integral_const_mul, seed_gram (hs m hm) (hs n hn)]
  ring

theorem finite_kernel_nonnegative (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 1 ≤ n) :
    0 ≤ ∑ m ∈ s, ∑ n ∈ s, c m * c n / ((max m n : ℕ) : ℝ) := by
  rw [← finite_energy_eq_kernel s c hs]
  exact integral_nonneg (fun _ => sq_nonneg _)

#print axioms seed_gram
#print axioms seed_product_integrable
#print axioms seed_square_integral
#print axioms finite_square_integrable
#print axioms finite_energy_eq_kernel
#print axioms finite_kernel_nonnegative

end BuildingBlocks.IntegerBirthGram
