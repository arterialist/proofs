import BuildingBlocks.ChargeFrozenBirthGram

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.ChargeFrozenBirthFiniteGram

open ChargeFrozenBirthMetric ChargeFrozenBirthGram

theorem finite_square_expansion (s : Finset ℕ) (c : ℕ → ℝ) (v : ℝ) :
    (∑ n ∈ s, c n * increment n v)^2 =
      ∑ m ∈ s, ∑ n ∈ s, c m * c n * (increment m v * increment n v) := by
  rw [pow_two, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro m _
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n _
  ring

theorem finite_square_integrable (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) :
    IntegrableOn (fun v => (∑ n ∈ s, c n * increment n v)^2) (Ioi (0 : ℝ)) := by
  have hi : IntegrableOn (fun v => ∑ m ∈ s, ∑ n ∈ s,
      c m * c n * (increment m v * increment n v)) (Ioi (0 : ℝ)) := by
    apply integrable_finset_sum
    intro m hm
    apply integrable_finset_sum
    intro n hn
    exact (birth_gram_integrable (hs m hm) (hs n hn)).const_mul (c m * c n)
  apply hi.congr
  filter_upwards [] with v
  exact (finite_square_expansion s c v).symm

theorem finite_energy_eq_double_sum (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), (∑ n ∈ s, c n * increment n v)^2) =
      ∑ m ∈ s, ∑ n ∈ s, c m * c n *
        (∫ v in Ioi (0 : ℝ), increment m v * increment n v) := by
  have hi (m n : ℕ) (hm : m ∈ s) (hn : n ∈ s) :
      IntegrableOn (fun v => c m * c n * (increment m v * increment n v)) (Ioi (0 : ℝ)) :=
    (birth_gram_integrable (hs m hm) (hs n hn)).const_mul (c m * c n)
  have he : (∫ v in Ioi (0 : ℝ), (∑ n ∈ s, c n * increment n v)^2) =
      ∫ v in Ioi (0 : ℝ), ∑ m ∈ s, ∑ n ∈ s, c m * c n * (increment m v * increment n v) := by
    apply integral_congr_ae
    filter_upwards [] with v
    exact finite_square_expansion s c v
  rw [he, integral_finset_sum _ (fun m hm => integrable_finset_sum _ (fun n hn => hi m n hm hn))]
  apply Finset.sum_congr rfl
  intro m hm
  rw [integral_finset_sum _ (fun n hn => hi m n hm hn)]
  apply Finset.sum_congr rfl
  intro n _
  rw [integral_const_mul]

theorem finite_gram_quadratic_nonnegative (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) :
    0 ≤ ∑ m ∈ s, ∑ n ∈ s, c m * c n *
      (∫ v in Ioi (0 : ℝ), increment m v * increment n v) := by
  rw [← finite_energy_eq_double_sum s c hs]
  exact integral_nonneg (fun v => sq_nonneg _)

noncomputable def gramKernel (m n : ℕ) : ℝ :=
  if m < n then (ArithmeticFunction.vonMangoldt (m + 1) - 1) *
    (ArithmeticFunction.vonMangoldt (n + 1) / ((n + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (n : ℝ)))
  else if n < m then (ArithmeticFunction.vonMangoldt (n + 1) - 1) *
    (ArithmeticFunction.vonMangoldt (m + 1) / ((m + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (m : ℝ)))
  else 1 + (m : ℝ) / ((m + 1 : ℕ) : ℝ) - 2 * (m : ℝ) * Real.log (1 + 1 / (m : ℝ)) +
    (ArithmeticFunction.vonMangoldt (m + 1) - 1)^2 / ((m + 1 : ℕ) : ℝ)

theorem birth_gram_eq_kernel {m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment n v) = gramKernel m n := by
  unfold gramKernel
  split_ifs with hmn hnm
  · exact birth_gram_integral hm hmn hn
  · have he : (∫ v in Ioi (0 : ℝ), increment m v * increment n v) =
        ∫ v in Ioi (0 : ℝ), increment n v * increment m v := by
      apply integral_congr_ae
      filter_upwards [] with v
      exact mul_comm _ _
    rw [he]
    exact birth_gram_integral hn hnm hm
  · have he : n = m := by omega
    subst n
    simp_rw [← pow_two]
    exact increment_square_integral_evaluated hm

theorem finite_energy_eq_kernel (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), (∑ n ∈ s, c n * increment n v)^2) =
      ∑ m ∈ s, ∑ n ∈ s, c m * c n * gramKernel m n := by
  rw [finite_energy_eq_double_sum s c hs]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [birth_gram_eq_kernel (hs m hm) (hs n hn)]

theorem finite_kernel_quadratic_nonnegative (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) : 0 ≤ ∑ m ∈ s, ∑ n ∈ s, c m * c n * gramKernel m n := by
  rw [← finite_energy_eq_kernel s c hs]
  exact integral_nonneg (fun v => sq_nonneg _)

#print axioms finite_square_integrable
#print axioms finite_energy_eq_double_sum
#print axioms birth_gram_eq_kernel
#print axioms finite_kernel_quadratic_nonnegative

end BuildingBlocks.ChargeFrozenBirthFiniteGram
