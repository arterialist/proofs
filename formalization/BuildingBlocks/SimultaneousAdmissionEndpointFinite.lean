import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# Finite simultaneous-admission endpoint bound

This module proves only a sign-free finite estimate.  It contains no
asymptotic or RH assertion.
-/

namespace BuildingBlocks.SimultaneousAdmissionEndpointFinite

open scoped BigOperators

noncomputable section

/-- The exact squared size of the endpoint face belonging to one divisor. -/
def endpointNormSq (d : ℕ) (q : ℝ) : ℝ :=
  (1 - q) * ∑ i ∈ Finset.range d, q ^ (2 * d - (i + 1))

/-- A concrete one-dimensional real Hilbert-space representative of the face. -/
def endpointFace (d : ℕ) (q : ℝ) : ℝ :=
  Real.sqrt (endpointNormSq d q)

lemma endpoint_geometric_reindex (d : ℕ) (q : ℝ) :
    (∑ i ∈ Finset.range d, q ^ (2 * d - (i + 1))) =
      q ^ d * ∑ i ∈ Finset.range d, q ^ i := by
  calc
    (∑ i ∈ Finset.range d, q ^ (2 * d - (i + 1))) =
        ∑ i ∈ Finset.range d, q ^ (d + (d - 1 - i)) := by
      apply Finset.sum_congr rfl
      intro i hi
      congr 1
      have hid : i < d := Finset.mem_range.mp hi
      omega
    _ = q ^ d * ∑ i ∈ Finset.range d, q ^ (d - 1 - i) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i hi
      rw [pow_add]
    _ = q ^ d * ∑ i ∈ Finset.range d, q ^ i := by
      rw [Finset.sum_range_reflect]

/-- Exact one-divisor endpoint identity. -/
theorem endpointNormSq_eq (d : ℕ) (q : ℝ) :
    endpointNormSq d q = q ^ d - q ^ (2 * d) := by
  unfold endpointNormSq
  rw [endpoint_geometric_reindex]
  have hg := geom_sum_mul_neg q d
  calc
    (1 - q) * (q ^ d * ∑ i ∈ Finset.range d, q ^ i) =
        q ^ d * ((∑ i ∈ Finset.range d, q ^ i) * (1 - q)) := by ring
    _ = q ^ d * (1 - q ^ d) := by rw [hg]
    _ = q ^ d - q ^ (2 * d) := by rw [pow_mul]; ring

lemma endpointNormSq_nonneg {d : ℕ} {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1) :
    0 ≤ endpointNormSq d q := by
  unfold endpointNormSq
  apply mul_nonneg (sub_nonneg.mpr hq1)
  apply Finset.sum_nonneg
  intro i hi
  exact pow_nonneg hq0 _

/-- The concrete face has precisely the claimed squared Hilbert norm. -/
theorem endpointFace_norm_sq {d : ℕ} {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1) :
    ‖endpointFace d q‖ ^ 2 = q ^ d - q ^ (2 * d) := by
  have hnonneg := endpointNormSq_nonneg (d := d) hq0 hq1
  rw [← endpointNormSq_eq]
  simp [endpointFace, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _),
    Real.sq_sqrt hnonneg]

/-- The sharp elementary quarter bound, including `q=0,1` and `d=0`. -/
theorem endpointNormSq_le_quarter {d : ℕ} {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1) :
    endpointNormSq d q ≤ (1 : ℝ) / 4 := by
  rw [endpointNormSq_eq]
  have hx0 : 0 ≤ q ^ d := pow_nonneg hq0 d
  have hx1 : q ^ d ≤ 1 := pow_le_one₀ hq0 hq1
  have hs : 0 ≤ (q ^ d - (1 : ℝ) / 2) ^ 2 := sq_nonneg _
  have hpow : q ^ (2 * d) = (q ^ d) ^ 2 := by
    rw [Nat.mul_comm, pow_mul]
  rw [hpow]
  nlinarith

theorem endpointFace_norm_sq_le_quarter {d : ℕ} {q : ℝ}
    (hq0 : 0 ≤ q) (hq1 : q ≤ 1) :
    ‖endpointFace d q‖ ^ 2 ≤ (1 : ℝ) / 4 := by
  calc
    ‖endpointFace d q‖ ^ 2 = endpointNormSq d q := by
      rw [endpointFace_norm_sq hq0 hq1, endpointNormSq_eq]
    _ ≤ (1 : ℝ) / 4 := endpointNormSq_le_quarter hq0 hq1

/-- Finite Minkowski bound for arbitrary signed faces in a real normed space.
The result uses no cancellation among the signs. -/
theorem signed_packet_norm_sq_le_card_sq_div_four
    {ι E : Type*} [SeminormedAddCommGroup E] [NormedSpace ℝ E]
    (S : Finset ι) (σ : ι → ℝ) (v : ι → E)
    (hσ : ∀ i ∈ S, |σ i| ≤ 1)
    (hv : ∀ i ∈ S, ‖v i‖ ^ 2 ≤ (1 : ℝ) / 4) :
    ‖∑ i ∈ S, σ i • v i‖ ^ 2 ≤ ((S.card : ℝ) ^ 2) / 4 := by
  have hvhalf : ∀ i ∈ S, ‖v i‖ ≤ (1 : ℝ) / 2 := by
    intro i hi
    have hn := norm_nonneg (v i)
    have hs := hv i hi
    nlinarith
  have hterm : ∀ i ∈ S, ‖σ i • v i‖ ≤ (1 : ℝ) / 2 := by
    intro i hi
    rw [norm_smul, Real.norm_eq_abs]
    calc
      |σ i| * ‖v i‖ ≤ 1 * ((1 : ℝ) / 2) :=
        mul_le_mul (hσ i hi) (hvhalf i hi) (norm_nonneg _) zero_le_one
      _ = (1 : ℝ) / 2 := by ring
  have hnorm : ‖∑ i ∈ S, σ i • v i‖ ≤ (S.card : ℝ) / 2 := by
    calc
      ‖∑ i ∈ S, σ i • v i‖ ≤ ∑ i ∈ S, ‖σ i • v i‖ := norm_sum_le _ _
      _ ≤ ∑ _i ∈ S, ((1 : ℝ) / 2) := Finset.sum_le_sum hterm
      _ = (S.card : ℝ) / 2 := by simp; ring
  have hn : 0 ≤ ‖∑ i ∈ S, σ i • v i‖ := norm_nonneg _
  have hc : 0 ≤ (S.card : ℝ) / 2 := by positivity
  nlinarith

/-- Actual Möbius signs satisfy the coefficient hypothesis automatically. -/
theorem mobius_packet_norm_sq_le_card_sq_div_four
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace ℝ E]
    (S : Finset ℕ) (v : ℕ → E)
    (hv : ∀ d ∈ S, ‖v d‖ ^ 2 ≤ (1 : ℝ) / 4) :
    ‖∑ d ∈ S, (ArithmeticFunction.moebius d : ℝ) • v d‖ ^ 2 ≤
      ((S.card : ℝ) ^ 2) / 4 := by
  apply signed_packet_norm_sq_le_card_sq_div_four S
  · intro d hd
    exact_mod_cast ArithmeticFunction.abs_moebius_le_one (n := d)
  · exact hv

/-- A squarefree positive integer has exactly `2^(number of prime factors)`
divisor faces. -/
theorem card_divisors_of_squarefree {P : ℕ} (hP : P ≠ 0) (hsf : Squarefree P) :
    P.divisors.card = 2 ^ P.primeFactors.card := by
  rw [Nat.card_divisors hP]
  calc
    P.primeFactors.prod (fun p => P.factorization p + 1) =
        P.primeFactors.prod (fun _p => 2) := by
      apply Finset.prod_congr rfl
      intro p hp
      have hle := (Nat.squarefree_iff_factorization_le_one hP).mp hsf p
      have hne : P.factorization p ≠ 0 := by
        rw [← Finsupp.mem_support_iff, Nat.support_factorization]
        exact hp
      omega
    _ = 2 ^ P.primeFactors.card := by simp

/-- The divisor-face count of a finite product of distinct primes. -/
theorem card_divisors_primeProduct (Q : Finset ℕ)
    (hprime : ∀ p ∈ Q, p.Prime) :
    (∏ p ∈ Q, p).divisors.card = 2 ^ Q.card := by
  let P := ∏ p ∈ Q, p
  have hP : P ≠ 0 := by
    dsimp [P]
    exact Finset.prod_ne_zero_iff.mpr fun p hp => (hprime p hp).ne_zero
  have hpair : Q.toSet.Pairwise (Function.onFun IsRelPrime id) := by
    intro p hp q hq hpq
    exact Nat.coprime_iff_isRelPrime.mp
      ((Nat.coprime_primes (hprime p hp) (hprime q hq)).2 hpq)
  have hsf : Squarefree P := by
    dsimp [P]
    apply Finset.squarefree_prod_of_pairwise_isCoprime hpair
    intro p hp
    exact (hprime p hp).squarefree
  rw [card_divisors_of_squarefree hP hsf]
  congr 2
  exact Nat.primeFactors_prod hprime

/-- Prime-product specialization of the sign-free face estimate. -/
theorem mobius_primeProduct_packet_norm_sq_le
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace ℝ E]
    (Q : Finset ℕ) (hprime : ∀ p ∈ Q, p.Prime) (v : ℕ → E)
    (hv : ∀ d ∈ (∏ p ∈ Q, p).divisors,
      ‖v d‖ ^ 2 ≤ (1 : ℝ) / 4) :
    ‖∑ d ∈ (∏ p ∈ Q, p).divisors,
        (ArithmeticFunction.moebius d : ℝ) • v d‖ ^ 2 ≤
      (((2 ^ Q.card : ℕ) : ℝ) ^ 2) / 4 := by
  simpa [card_divisors_primeProduct Q hprime] using
    mobius_packet_norm_sq_le_card_sq_div_four
      (S := (∏ p ∈ Q, p).divisors) v hv

end
end BuildingBlocks.SimultaneousAdmissionEndpointFinite

#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.endpointNormSq_eq
#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.endpointFace_norm_sq
#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.endpointNormSq_le_quarter
#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.signed_packet_norm_sq_le_card_sq_div_four
#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.mobius_packet_norm_sq_le_card_sq_div_four
#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.card_divisors_primeProduct
#print axioms BuildingBlocks.SimultaneousAdmissionEndpointFinite.mobius_primeProduct_packet_norm_sq_le
