import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite combinatorial core of the sign-free endpoint frontier

Prime faces are indexed by subsets of a finite prime set.  The analytic
one-face envelope is an explicit hypothesis; the complete Euler-product
and normalized Minkowski bounds are proved here.  There is no asymptotic
or RH assertion.
-/

namespace BuildingBlocks.SignFreeEndpointFrontierFinite

open scoped BigOperators

noncomputable section

/-- Product of the primes in one squarefree face. -/
def faceDivisor (A : Finset ℕ) : ℕ := ∏ p ∈ A, p

/-- Multiplicative majorant attached to one face. -/
def faceWeight (w : ℕ → ℝ) (A : Finset ℕ) : ℝ := ∏ p ∈ A, w p

@[simp] theorem faceWeight_empty (w : ℕ → ℝ) : faceWeight w ∅ = 1 := by
  simp [faceWeight]

/-- Exact powerset-to-Euler-product identity. -/
theorem sum_faceWeight_powerset (Q : Finset ℕ) (w : ℕ → ℝ) :
    (∑ A ∈ Q.powerset, faceWeight w A) = ∏ p ∈ Q, (1 + w p) := by
  simpa [faceWeight] using (Finset.prod_one_add Q).symm

/-- Every actual Möbius coefficient on a squarefree face has modulus at most one. -/
theorem abs_moebius_face_le_one (A : Finset ℕ) :
    |(ArithmeticFunction.moebius (faceDivisor A) : ℝ)| ≤ 1 := by
  exact_mod_cast ArithmeticFunction.abs_moebius_le_one (n := faceDivisor A)

/-- Weighted finite Minkowski bound.  No cancellation of the actual Möbius
signs is used. -/
theorem mobius_powerset_weighted_norm_le
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace ℝ E]
    (Q : Finset ℕ) (w : ℕ → ℝ) (v : Finset ℕ → E) (C : ℝ)
    (hv : ∀ A ∈ Q.powerset, ‖v A‖ ≤ C * faceWeight w A) :
    ‖∑ A ∈ Q.powerset,
        (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ≤
      C * ∏ p ∈ Q, (1 + w p) := by
  calc
    ‖∑ A ∈ Q.powerset,
        (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ≤
        ∑ A ∈ Q.powerset,
          ‖(ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ :=
      norm_sum_le _ _
    _ ≤ ∑ A ∈ Q.powerset, ‖v A‖ := by
      apply Finset.sum_le_sum
      intro A hA
      rw [norm_smul, Real.norm_eq_abs]
      exact mul_le_of_le_one_left (norm_nonneg _) (abs_moebius_face_le_one A)
    _ ≤ ∑ A ∈ Q.powerset, C * faceWeight w A := Finset.sum_le_sum hv
    _ = C * ∑ A ∈ Q.powerset, faceWeight w A := by rw [Finset.mul_sum]
    _ = C * ∏ p ∈ Q, (1 + w p) := by rw [sum_faceWeight_powerset]

/-- Squared and externally normalized version of the exact weighted bound. -/
theorem mobius_powerset_weighted_scaled_sq_le
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace ℝ E]
    (Q : Finset ℕ) (w : ℕ → ℝ) (v : Finset ℕ → E)
    (C scale : ℝ)
    (hC : 0 ≤ C) (hscale : 0 ≤ scale) (hw : ∀ p ∈ Q, 0 ≤ w p)
    (hv : ∀ A ∈ Q.powerset, ‖v A‖ ≤ C * faceWeight w A) :
    (scale * ‖∑ A ∈ Q.powerset,
        (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖) ^ 2 ≤
      (scale * C * ∏ p ∈ Q, (1 + w p)) ^ 2 := by
  have hbound := mobius_powerset_weighted_norm_le Q w v C hv
  have hleft : 0 ≤ scale * ‖∑ A ∈ Q.powerset,
      (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ :=
    mul_nonneg hscale (norm_nonneg _)
  have hprod : 0 ≤ ∏ p ∈ Q, (1 + w p) := by
    apply Finset.prod_nonneg
    intro p hp
    linarith [hw p hp]
  have hright : 0 ≤ scale * C * ∏ p ∈ Q, (1 + w p) :=
    mul_nonneg (mul_nonneg hscale hC) hprod
  have hlin : scale * ‖∑ A ∈ Q.powerset,
      (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ≤
      scale * C * ∏ p ∈ Q, (1 + w p) := by
    calc
      scale * ‖∑ A ∈ Q.powerset,
          (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ≤
          scale * (C * ∏ p ∈ Q, (1 + w p)) :=
        mul_le_mul_of_nonneg_left hbound hscale
      _ = scale * C * ∏ p ∈ Q, (1 + w p) := by ring
  nlinarith

/-- Exact number of squarefree subset faces. -/
theorem card_prime_faces (Q : Finset ℕ) : Q.powerset.card = 2 ^ Q.card := by
  exact Finset.card_powerset Q

/-- Cubical orientation of a squarefree face. -/
def cubeSign (A : Finset ℕ) : ℝ := (-1 : ℝ) ^ A.card

/-- Exact codimension-one pairing in the prime-valuation cube.  It is an
identity of differences, not a norm contraction. -/
theorem oriented_cube_pairing
    {E : Type*} [AddCommGroup E] [Module ℝ E]
    (Q : Finset ℕ) {p : ℕ} (hp : p ∉ Q) (v : Finset ℕ → E) :
    (∑ A ∈ (insert p Q).powerset, cubeSign A • v A) =
      ∑ A ∈ Q.powerset, cubeSign A • (v A - v (insert p A)) := by
  rw [Finset.sum_powerset_insert hp]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro A hA
  have hsub : A ⊆ Q := Finset.mem_powerset.mp hA
  have hpA : p ∉ A := fun h => hp (hsub h)
  have hsign : cubeSign (insert p A) = -cubeSign A := by
    simp only [cubeSign, Finset.card_insert_of_notMem hpA, pow_succ]
    ring
  rw [hsign]
  module

/-- A finite orientation alone gives no cancellation: vectors can align
with the cubical signs and saturate the face-count scale. -/
theorem oriented_cube_aligned
    {E : Type*} [AddCommGroup E] [Module ℝ E]
    (Q : Finset ℕ) (x : E) :
    (∑ A ∈ Q.powerset, cubeSign A • (cubeSign A • x)) =
      ((2 ^ Q.card : ℕ) : ℝ) • x := by
  calc
    (∑ A ∈ Q.powerset, cubeSign A • (cubeSign A • x)) =
        ∑ _A ∈ Q.powerset, x := by
      apply Finset.sum_congr rfl
      intro A hA
      simp only [cubeSign, smul_smul]
      have hs : ((-1 : ℝ) ^ A.card) * ((-1 : ℝ) ^ A.card) = 1 := by
        rw [← pow_add]
        norm_num [show A.card + A.card = 2 * A.card by omega, pow_mul]
      rw [hs, one_smul]
    _ = ((Q.powerset.card : ℕ) : ℝ) • x := by
      rw [Finset.sum_const]
      exact (Nat.cast_smul_eq_nsmul ℝ Q.powerset.card x).symm
    _ = ((2 ^ Q.card : ℕ) : ℝ) • x := by rw [card_prime_faces]

/-- The uniform one-half face estimate recovers the elementary
`4^(#primes)/4` energy bound. -/
theorem mobius_powerset_uniform_quarter_bound
    {E : Type*} [SeminormedAddCommGroup E] [NormedSpace ℝ E]
    (Q : Finset ℕ) (v : Finset ℕ → E)
    (hv : ∀ A ∈ Q.powerset, ‖v A‖ ^ 2 ≤ (1 : ℝ) / 4) :
    ‖∑ A ∈ Q.powerset,
        (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ^ 2 ≤
      (((2 ^ Q.card : ℕ) : ℝ) ^ 2) / 4 := by
  have hvhalf : ∀ A ∈ Q.powerset, ‖v A‖ ≤ (1 : ℝ) / 2 := by
    intro A hA
    have hn := norm_nonneg (v A)
    have hs := hv A hA
    nlinarith
  have hnorm : ‖∑ A ∈ Q.powerset,
      (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ≤
      ((Q.powerset.card : ℝ) / 2) := by
    calc
      ‖∑ A ∈ Q.powerset,
          (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ ≤
          ∑ A ∈ Q.powerset,
            ‖(ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ :=
        norm_sum_le _ _
      _ ≤ ∑ A ∈ Q.powerset, ‖v A‖ := by
        apply Finset.sum_le_sum
        intro A hA
        rw [norm_smul, Real.norm_eq_abs]
        exact mul_le_of_le_one_left (norm_nonneg _) (abs_moebius_face_le_one A)
      _ ≤ ∑ _A ∈ Q.powerset, ((1 : ℝ) / 2) := Finset.sum_le_sum hvhalf
      _ = (Q.powerset.card : ℝ) / 2 := by simp; ring
  rw [card_prime_faces] at hnorm
  have hn : 0 ≤ ‖∑ A ∈ Q.powerset,
      (ArithmeticFunction.moebius (faceDivisor A) : ℝ) • v A‖ := norm_nonneg _
  have hc : 0 ≤ (((2 ^ Q.card : ℕ) : ℝ) / 2) := by positivity
  nlinarith

end
end BuildingBlocks.SignFreeEndpointFrontierFinite

#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.sum_faceWeight_powerset
#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.mobius_powerset_weighted_norm_le
#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.mobius_powerset_weighted_scaled_sq_le
#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.card_prime_faces
#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.oriented_cube_pairing
#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.oriented_cube_aligned
#print axioms BuildingBlocks.SignFreeEndpointFrontierFinite.mobius_powerset_uniform_quarter_bound
