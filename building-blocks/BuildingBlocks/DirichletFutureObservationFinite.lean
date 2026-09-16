import Mathlib.Tactic
import Mathlib.NumberTheory.VonMangoldt

/-!
# Finite Dirichlet future-observation identities

This file records finite algebra behind the sparse-preimage obstruction for
future Mangoldt observations.  It contains no analytic coercivity estimate.
-/

namespace BuildingBlocks.DirichletFutureObservationFinite

open scoped BigOperators ArithmeticFunction

noncomputable section

/-- The full divisor-log history, written with its literal divisor pairs. -/
def divisorLogHistory (n : ℕ) : ℝ :=
  ∑ de ∈ n.divisorsAntidiagonal,
    (ArithmeticFunction.moebius de.1 : ℝ) * Real.log de.2

/-- Möbius inversion turns the complete divisor-log history into von Mangoldt,
with every prime power retained. -/
theorem divisorLogHistory_eq_vonMangoldt (n : ℕ) :
    divisorLogHistory n = ArithmeticFunction.vonMangoldt n := by
  rw [← ArithmeticFunction.moebius_mul_log_eq_vonMangoldt]
  rfl

/-- A sparse preimage supported on multiples of `q`. -/
def sparsePreimage (q e : ℕ) : ℤ :=
  if q ∣ e then ArithmeticFunction.moebius (e / q) else 0

/-- Its entries on the supported dilation are the actual Möbius values. -/
theorem sparsePreimage_dilate {q m : ℕ} (hq : 0 < q) :
    sparsePreimage q (q * m) = ArithmeticFunction.moebius m := by
  simp [sparsePreimage, hq.ne']

/-- The literal finite matrix row from the future-cone operator. -/
def literalSparseFutureObservation (q d : ℕ) : ℝ :=
  ∑ e ∈ (2 * d).divisors,
    if e ≤ d then (sparsePreimage q e : ℝ) * Real.log ((2 * d / e : ℕ) : ℝ)
    else 0

private lemma divisor_two_mul_le_or_eq {d e : ℕ} (hd : 0 < d)
    (he : e ∣ 2 * d) : e ≤ d ∨ e = 2 * d := by
  rcases he with ⟨k, hk⟩
  by_cases hk1 : k = 1
  · right
    simpa [hk1] using hk.symm
  · left
    have hkpos : 0 < k := by
      by_contra hk0
      have : k = 0 := Nat.eq_zero_of_not_pos hk0
      simp [this] at hk
      omega
    have hk2 : 2 ≤ k := by omega
    have hmul := Nat.mul_le_mul_left e hk2
    rw [← hk] at hmul
    omega

private theorem literalSparseFutureObservation_eq_full
    {q d : ℕ} (hd : 0 < d) :
    literalSparseFutureObservation q d =
      ∑ e ∈ (2 * d).divisors,
        (sparsePreimage q e : ℝ) * Real.log ((2 * d / e : ℕ) : ℝ) := by
  apply Finset.sum_congr rfl
  intro e he
  rw [Nat.mem_divisors] at he
  split_ifs with hed
  · rfl
  · rcases divisor_two_mul_le_or_eq hd he.1 with hle | rfl
    · exact (hed hle).elim
    · simp [hd.ne']

private theorem full_sparse_observation_of_dvd
    {q d : ℕ} (hq : 0 < q) (hd : 0 < d) (hqd : q ∣ d) :
    (∑ e ∈ (2 * d).divisors,
      (sparsePreimage q e : ℝ) * Real.log ((2 * d / e : ℕ) : ℝ)) =
      divisorLogHistory (2 * (d / q)) := by
  rcases hqd with ⟨r, rfl⟩
  have hr : 0 < r := Nat.pos_of_mul_pos_left hd
  simp only [sparsePreimage, Int.cast_ite, Int.cast_zero, ite_mul, zero_mul]
  rw [← Finset.sum_filter]
  rw [show q * r / q = r by exact Nat.mul_div_cancel_left r hq]
  unfold divisorLogHistory
  rw [Nat.sum_divisorsAntidiagonal
    (fun m n => (ArithmeticFunction.moebius m : ℝ) * Real.log n)]
  apply Finset.sum_bij (fun e he => e / q)
  · intro e he
    rw [Finset.mem_filter] at he
    rw [Nat.mem_divisors]
    constructor
    · have hediv : e ∣ 2 * (q * r) := (Nat.mem_divisors.mp he.1).1
      rcases hediv with ⟨k, hk⟩
      refine ⟨k, ?_⟩
      exact Nat.mul_left_cancel hq (by
        calc
          q * (2 * r) = 2 * (q * r) := by ring
          _ = e * k := hk
          _ = q * ((e / q) * k) := by
            conv_lhs => rw [← Nat.mul_div_cancel' he.2]
            ring)
    · positivity
  · intro e₁ he₁ e₂ he₂ hdiv
    rw [Finset.mem_filter] at he₁ he₂
    calc
      e₁ = q * (e₁ / q) := (Nat.mul_div_cancel' he₁.2).symm
      _ = q * (e₂ / q) := by rw [hdiv]
      _ = e₂ := Nat.mul_div_cancel' he₂.2
  · intro m hm
    rw [Nat.mem_divisors] at hm
    refine ⟨q * m, ?_, ?_⟩
    · rw [Finset.mem_filter, Nat.mem_divisors]
      constructor
      · constructor
        · rcases hm.1 with ⟨k, hk⟩
          refine ⟨k, ?_⟩
          calc
            2 * (q * r) = q * (2 * r) := by ring
            _ = q * (m * k) := by rw [hk]
            _ = (q * m) * k := by ring
        · positivity
      · exact dvd_mul_right q m
    · exact Nat.mul_div_cancel_left m hq
  · intro e he
    rw [Finset.mem_filter] at he
    have hquot : 2 * (q * r) / e = 2 * r / (e / q) := by
      calc
        2 * (q * r) / e = q * (2 * r) / (q * (e / q)) := by
          rw [show 2 * (q * r) = q * (2 * r) by ring]
          conv_lhs => rw [← Nat.mul_div_cancel' he.2]
        _ = 2 * r / (e / q) := Nat.mul_div_mul_left (2 * r) (e / q) hq
    rw [hquot]

private theorem full_sparse_observation_of_not_dvd
    {q d : ℕ} (hodd : Odd q) (hnqd : ¬q ∣ d) :
    (∑ e ∈ (2 * d).divisors,
      (sparsePreimage q e : ℝ) * Real.log ((2 * d / e : ℕ) : ℝ)) = 0 := by
  apply Finset.sum_eq_zero
  intro e he
  have hediv : e ∣ 2 * d := (Nat.mem_divisors.mp he).1
  have hnqe : ¬q ∣ e := by
    intro hqe
    have hq2d : q ∣ 2 * d := dvd_trans hqe hediv
    exact hnqd ((Nat.coprime_two_right.mpr hodd).dvd_of_dvd_mul_left hq2d)
  simp [sparsePreimage, hnqe]

/-- The literal bounded matrix row is exactly the conditional Mangoldt row.
The positivity assumption makes the divisor finsets nondegenerate; oddness
is exactly what permits cancellation of the factor `2` when `q ∤ d`. -/
theorem literalSparseFutureObservation_eq
    {q d : ℕ} (hq : 0 < q) (hd : 0 < d) (hodd : Odd q) :
    literalSparseFutureObservation q d =
      if q ∣ d then ArithmeticFunction.vonMangoldt (2 * (d / q)) else 0 := by
  rw [literalSparseFutureObservation_eq_full hd]
  by_cases hqd : q ∣ d
  · rw [if_pos hqd, full_sparse_observation_of_dvd hq hd hqd,
      divisorLogHistory_eq_vonMangoldt]
  · rw [if_neg hqd, full_sparse_observation_of_not_dvd hodd hqd]

/-- The exact future observation after the dilation has been pulled back to
the quotient. -/
def sparseFutureObservation (q d : ℕ) : ℝ :=
  if q ∣ d then divisorLogHistory (2 * (d / q)) else 0

/-- The pulled-back future observation is a Mangoldt coefficient. -/
theorem sparseFutureObservation_eq (q d : ℕ) :
    sparseFutureObservation q d =
      if q ∣ d then ArithmeticFunction.vonMangoldt (2 * (d / q)) else 0 := by
  simp [sparseFutureObservation, divisorLogHistory_eq_vonMangoldt]

/-- Generic finite centering identity for a linear future observation. -/
theorem centered_future_observation
    (S : Finset ℕ) (mu : ℕ → ℝ) (c : ℝ) (kernel : ℕ → ℝ) :
    (∑ d ∈ S, (mu d - c) * kernel d) =
      (∑ d ∈ S, mu d * kernel d) - c * ∑ d ∈ S, kernel d := by
  simp only [sub_mul, Finset.sum_sub_distrib, Finset.mul_sum]

/-- Pullback of an additive quadratic form through an arbitrary finite
observation matrix.  The resulting kernel is `T* H T`, not a scalar
multiplier on the source indices. -/
theorem additive_quadratic_pullback
    (D N : Finset ℕ) (x : ℕ → ℝ) (T : ℕ → ℕ → ℝ)
    (H : ℕ → ℕ → ℝ) :
    (∑ m ∈ N, ∑ n ∈ N,
      (∑ d ∈ D, T m d * x d) * H m n * (∑ e ∈ D, T n e * x e)) =
      ∑ d ∈ D, ∑ e ∈ D, x d *
        (∑ m ∈ N, ∑ n ∈ N, T m d * H m n * T n e) * x e := by
  let f : (ℕ × ℕ) → (ℕ × ℕ) → ℝ := fun mn de =>
    (T mn.1 de.2 * x de.2) * H mn.1 mn.2 * (T mn.2 de.1 * x de.1)
  calc
    _ = ∑ mn ∈ N ×ˢ N, ∑ de ∈ D ×ˢ D, f mn de := by
      rw [Finset.sum_product]
      simp_rw [Finset.sum_product]
      simp [f, Finset.sum_mul, Finset.mul_sum]
    _ = ∑ de ∈ D ×ˢ D, ∑ mn ∈ N ×ˢ N, f mn de := Finset.sum_comm
    _ = _ := by
      rw [Finset.sum_product]
      simp_rw [Finset.sum_product]
      simp [f, Finset.sum_mul, Finset.mul_sum]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro d hd
      apply Finset.sum_congr rfl
      intro e he
      apply Finset.sum_congr rfl
      intro m hm
      apply Finset.sum_congr rfl
      intro n hn
      ring

/-- Exact norm-ratio lower bound for any left inverse on one finite vector. -/
theorem inverse_norm_lower_bound
    {normA normY inverseNorm : ℝ}
    (hnormY : 0 < normY) (hrecover : normA ≤ inverseNorm * normY) :
    normA / normY ≤ inverseNorm := by
  exact (div_le_iff₀ hnormY).2 (by simpa [mul_comm] using hrecover)

end
end BuildingBlocks.DirichletFutureObservationFinite

#print axioms BuildingBlocks.DirichletFutureObservationFinite.divisorLogHistory_eq_vonMangoldt
#print axioms BuildingBlocks.DirichletFutureObservationFinite.sparsePreimage_dilate
#print axioms BuildingBlocks.DirichletFutureObservationFinite.literalSparseFutureObservation_eq
#print axioms BuildingBlocks.DirichletFutureObservationFinite.sparseFutureObservation_eq
#print axioms BuildingBlocks.DirichletFutureObservationFinite.centered_future_observation
#print axioms BuildingBlocks.DirichletFutureObservationFinite.additive_quadratic_pullback
#print axioms BuildingBlocks.DirichletFutureObservationFinite.inverse_norm_lower_bound
