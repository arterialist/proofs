import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite divisor-layer algebra for an endpoint quadratic

These identities retain every ordered cross term.  Analytic bounds for the
resulting weighted two-point Möbius sum are deliberately left as hypotheses.
-/

namespace BuildingBlocks.EndpointQuadraticLayerFinite

open scoped BigOperators

noncomputable section

/-- A finite upper-tail packet with arbitrary locations and coefficients. -/
def tailPacket (S : Finset ℕ) (loc : ℕ → ℕ) (a : ℕ → ℝ) (k : ℕ) : ℝ :=
  ∑ d ∈ S, if k ≤ loc d then a d else 0

/-- The incidence kernel obtained after reversing the finite tail sums. -/
def incidenceKernel (K : Finset ℕ) (w : ℕ → ℝ) (x y : ℕ) : ℝ :=
  ∑ k ∈ K, if k ≤ x ∧ k ≤ y then w k else 0

/-- Reversing two finite tail sums retains all ordered pairs. -/
theorem weighted_tail_pair_expand
    (K S T : Finset ℕ) (w a b : ℕ → ℝ) (u v : ℕ → ℕ) :
    (∑ k ∈ K, w k * tailPacket S u a k * tailPacket T v b k) =
      ∑ d ∈ S, ∑ e ∈ T,
        a d * b e * incidenceKernel K w (u d) (v e) := by
  classical
  induction K using Finset.induction_on with
  | empty => simp [incidenceKernel]
  | @insert k K hk ih =>
      rw [Finset.sum_insert hk, ih]
      simp_rw [incidenceKernel, Finset.sum_insert hk]
      have hnew :
          w k * tailPacket S u a k * tailPacket T v b k =
            ∑ d ∈ S, ∑ e ∈ T,
              a d * b e * (if k ≤ u d ∧ k ≤ v e then w k else 0) := by
        simp only [tailPacket]
        calc
          (w k * (∑ d ∈ S, if k ≤ u d then a d else 0)) *
              (∑ e ∈ T, if k ≤ v e then b e else 0) =
              ((∑ d ∈ S, if k ≤ u d then a d else 0) *
                (∑ e ∈ T, if k ≤ v e then b e else 0)) * w k := by ring
          _ = (∑ d ∈ S, ∑ e ∈ T,
                (if k ≤ u d then a d else 0) *
                  (if k ≤ v e then b e else 0)) * w k := by
                rw [Finset.sum_mul_sum]
          _ = ∑ d ∈ S, ∑ e ∈ T,
                a d * b e * (if k ≤ u d ∧ k ≤ v e then w k else 0) := by
                rw [Finset.sum_mul]
                apply Finset.sum_congr rfl
                intro d hd
                rw [Finset.sum_mul]
                apply Finset.sum_congr rfl
                intro e he
                by_cases hkd : k ≤ u d <;> by_cases hke : k ≤ v e <;>
                  simp [hkd, hke]
      rw [hnew]
      simp_rw [mul_add, Finset.sum_add_distrib]

/-- Exact pointwise square increment for an oriented newly admitted layer. -/
theorem square_sub_layer (old new : ℝ) :
    (old - new) ^ 2 - old ^ 2 = new ^ 2 - 2 * old * new := by
  ring

/-- Exact weighted endpoint admission before any sign estimate. -/
theorem weighted_endpoint_layer_increment
    (K : Finset ℕ) (w old new : ℕ → ℝ) :
    (∑ k ∈ K, w k * ((old k - new k) ^ 2 - (old k) ^ 2)) =
      (∑ k ∈ K, w k * (new k) ^ 2) -
        2 * ∑ k ∈ K, w k * old k * new k := by
  rw [Finset.mul_sum]
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  rw [square_sub_layer]
  ring

/-- Ordered divisor-layer expansion of the exact endpoint admission. -/
theorem endpoint_divisor_layer_expand
    (K D : Finset ℕ) (w mu : ℕ → ℝ) (p : ℕ) :
    (∑ k ∈ K, w k *
      ((tailPacket D id mu k - tailPacket D (fun e => p * e) mu k) ^ 2 -
        (tailPacket D id mu k) ^ 2)) =
      (∑ e ∈ D, ∑ f ∈ D,
        mu e * mu f * incidenceKernel K w (p * e) (p * f)) -
      2 * ∑ d ∈ D, ∑ e ∈ D,
        mu d * mu e * incidenceKernel K w d (p * e) := by
  rw [weighted_endpoint_layer_increment]
  have hself := weighted_tail_pair_expand K D D w mu mu
    (fun e => p * e) (fun e => p * e)
  have hcross := weighted_tail_pair_expand K D D w mu mu id (fun e => p * e)
  calc
    (∑ k ∈ K, w k * (tailPacket D (fun e => p * e) mu k) ^ 2) -
          2 * ∑ k ∈ K, w k * tailPacket D id mu k *
            tailPacket D (fun e => p * e) mu k =
        (∑ k ∈ K, w k * tailPacket D (fun e => p * e) mu k *
            tailPacket D (fun e => p * e) mu k) -
          2 * ∑ k ∈ K, w k * tailPacket D id mu k *
            tailPacket D (fun e => p * e) mu k := by
              apply congrArg₂ (· - ·)
              · apply Finset.sum_congr rfl
                intro k hk
                ring
              · rfl
    _ = _ := by rw [hself, hcross]; simp

/-- Centering a finite tail by its total coefficient turns it into the
negative strict prefix, with the integer endpoint retained. -/
theorem tail_sub_total_eq_neg_prefix
    (S : Finset ℕ) (a : ℕ → ℝ) (k : ℕ) :
    tailPacket S id a k - (∑ n ∈ S, a n) =
      -(∑ n ∈ S, if n < k then a n else 0) := by
  simp only [tailPacket, id_eq]
  rw [← Finset.sum_sub_distrib]
  rw [← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  by_cases hnk : k ≤ n
  · have hnot : ¬n < k := by omega
    simp [hnk, hnot]
  · have hlt : n < k := by omega
    simp [hnk, hlt]

/-- The centered square increment still contains the old/new ordered
two-point prefix correlation. -/
theorem centered_prefix_square_increment (old new : ℝ) :
    (old + new) ^ 2 - old ^ 2 = 2 * old * new + new ^ 2 := by
  ring

/-- Exact common-mode/centered-prefix decomposition at one clock index. -/
theorem tail_square_centered_decomposition (total pref : ℝ) :
    (total - pref) ^ 2 =
      total ^ 2 - 2 * total * pref + pref ^ 2 := by
  ring

/-- Exact admission increment after separating the Abel total from the
strict prefix.  The final two terms are the centered two-point increment. -/
theorem centered_admission_decomposition
    (oldTotal newTotal oldPrefix newPrefix : ℝ) :
    ((oldTotal + newTotal) - (oldPrefix + newPrefix)) ^ 2 -
        (oldTotal - oldPrefix) ^ 2 =
      (2 * oldTotal * newTotal + newTotal ^ 2) -
      2 * (newTotal * oldPrefix + oldTotal * newPrefix +
        newTotal * newPrefix) +
      (2 * oldPrefix * newPrefix + newPrefix ^ 2) := by
  ring

end
end BuildingBlocks.EndpointQuadraticLayerFinite

#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.weighted_tail_pair_expand
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.square_sub_layer
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.weighted_endpoint_layer_increment
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.endpoint_divisor_layer_expand
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.tail_sub_total_eq_neg_prefix
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.centered_prefix_square_increment
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.tail_square_centered_decomposition
#print axioms BuildingBlocks.EndpointQuadraticLayerFinite.centered_admission_decomposition
