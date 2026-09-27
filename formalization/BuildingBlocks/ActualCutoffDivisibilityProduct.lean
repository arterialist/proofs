import BuildingBlocks.ActualPrimeCutoffCovarianceStrict
import Mathlib.Tactic

/-! Equation (7) for the finite actual cutoff law. This bounds joint
divisibility of arbitrary positive integers under the original cutoff
weight; the factors need not be coprime. -/

namespace BuildingBlocks.ActualCutoffDivisibilityProduct

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.ActualPrimeCutoffCovarianceStrict

noncomputable section

def D (N a : ℕ) (x : ℝ) : ℝ := Ffixed N a x / Real.sqrt a

private theorem mass_zero {N : ℕ} {x : ℝ} (hx : x ≤ 1) : cutoffMass N x = 0 := by
  unfold cutoffMass
  apply Finset.sum_eq_zero
  intro n hn
  exact cutoffWeight_eq_zero_of_le_one hx (Finset.mem_Icc.mp hn).1

private theorem D_zero {N a : ℕ} {x : ℝ} (ha : 0 < a) (hx : x ≤ a) :
    D N a x = 0 := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hxa : x / (a : ℝ) ≤ 1 := (div_le_iff₀ haR).2 (by simpa using hx)
  simp [D, Ffixed, mass_zero hxa]

private theorem D_nonneg (N a : ℕ) (x : ℝ) : 0 ≤ D N a x := by
  unfold D Ffixed
  apply div_nonneg
  · apply div_nonneg
    · exact mul_nonneg (Nat.cast_nonneg _) (cutoffMass_nonneg N (x/a))
    · exact cutoffMass_nonneg N x
  · exact Real.sqrt_nonneg _

private theorem D_one {N : ℕ} {x : ℝ} (hN : 1 ≤ N) (hx : 1 < x) :
    D N 1 x = 1 := by
  have hm : cutoffMass N x ≠ 0 := (cutoffMass_pos hN hx).ne'
  simp [D, Ffixed, hm]

theorem D_eq_actual_probability {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    D N a x =
      (∑ n ∈ Finset.Icc 1 N,
        if a ∣ n then cutoffWeight x n else 0) / cutoffMass N x := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hs : Real.sqrt (a : ℝ) ≠ 0 := (Real.sqrt_pos.2 haR).ne'
  unfold D Ffixed
  rw [cutoff_multiples_sum N a x ha, ← cutoffMass_dilated_stable ha hx]
  have hsq : (Real.sqrt (a : ℝ)) ^ 2 = a := Real.sq_sqrt haR.le
  field_simp
  rw [hsq]
  ring

/-- Probability of the original divisibility event in the finite cutoff
sample, defined as zero when the total mass vanishes. -/
def originalProbability (N a : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
    if a ∣ n then cutoffWeight x n else 0) / cutoffMass N x

theorem originalProbability_eq_D {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    originalProbability N a x = D N a x := by
  exact (D_eq_actual_probability ha hx).symm

private theorem D_mono {N a : ℕ} {x y : ℝ} (hN : 1 ≤ N)
    (ha : 1 ≤ a) (hx : 1 < x) (hxy : x ≤ y)
    (hy : y ≤ (N : ℝ) + 1) : D N a x ≤ D N a y := by
  by_cases ha1 : a = 1
  · subst a
    rw [D_one hN hx, D_one hN (lt_of_lt_of_le hx hxy)]
  · have ha2 : 2 ≤ a := by omega
    rcases eq_or_lt_of_le hxy with heq | hlt
    · simp [heq]
    · have hs : 0 < Real.sqrt (a : ℝ) := by
        apply Real.sqrt_pos.2
        exact_mod_cast (by omega : 0 < a)
      exact (div_le_div_iff_of_pos_right hs).2
        (Ffixed_mono_of_step (fun n hn => finiteGrid_step_increment n hn)
          hN ha2 hlt hy)

private theorem D_mul_eq {N a b : ℕ} {x : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hx : (a : ℝ) < x)
    (hN : 1 ≤ N) :
    D N (a*b) x = D N a x * D N b (x/a) := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hbR : (0 : ℝ) < b := by exact_mod_cast hb
  have hxa : 1 < x / (a : ℝ) := (one_lt_div haR).2 hx
  have hx1 : 1 < x := by
    have : (1 : ℝ) ≤ a := by exact_mod_cast ha
    linarith
  have hm : cutoffMass N x ≠ 0 := (cutoffMass_pos hN hx1).ne'
  have hma : cutoffMass N (x / a) ≠ 0 := (cutoffMass_pos hN hxa).ne'
  have hsa : Real.sqrt (a : ℝ) ≠ 0 := (Real.sqrt_pos.2 haR).ne'
  have hsb : Real.sqrt (b : ℝ) ≠ 0 := (Real.sqrt_pos.2 hbR).ne'
  have hsmul : Real.sqrt ((a*b : ℕ) : ℝ) =
      Real.sqrt (a : ℝ) * Real.sqrt (b : ℝ) := by
    rw [Nat.cast_mul, Real.sqrt_mul haR.le]
  unfold D Ffixed
  rw [hsmul, Nat.cast_mul]
  have hdiv : x / ((a : ℝ) * b) = (x / a) / b := by ring
  rw [hdiv]
  field_simp

private theorem D_mul_le {N a b : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (ha : 1 ≤ a) (hb : 1 ≤ b)
    (hx : 1 < x) (hxN : x ≤ (N : ℝ) + 1) :
    D N (a*b) x ≤ D N a x * D N b x := by
  by_cases hxa : x ≤ a
  · rw [D_zero (Nat.mul_pos (by omega : 0 < a) (by omega : 0 < b))
        (by
          have hab : (a : ℝ) ≤ a*b := by
            have hbR : (1 : ℝ) ≤ b := by exact_mod_cast hb
            have haR : (0 : ℝ) ≤ a := by positivity
            nlinarith
          exact hxa.trans (by simpa [Nat.cast_mul] using hab))]
    exact mul_nonneg (D_nonneg N a x) (D_nonneg N b x)
  · have haR : (a : ℝ) < x := lt_of_not_ge hxa
    rw [D_mul_eq (by omega : 0 < a) (by omega : 0 < b) haR hN]
    have hxa1 : 1 < x / (a : ℝ) :=
      (one_lt_div (by exact_mod_cast (show 0 < a by omega))).2 haR
    have hdivle : x / (a : ℝ) ≤ x := by
      have ha1 : (1 : ℝ) ≤ a := by exact_mod_cast ha
      exact div_le_self (by linarith : 0 ≤ x) ha1
    have hmono : D N b (x/a) ≤ D N b x :=
      D_mono hN hb hxa1 hdivle hxN
    exact mul_le_mul_of_nonneg_left hmono (D_nonneg N a x)

private theorem list_prod_pos (as : List ℕ) (hall : ∀ a ∈ as, 1 ≤ a) :
    1 ≤ as.prod := by
  induction as with
  | nil => simp
  | cons a as ih =>
      simp only [List.prod_cons]
      have ha : 1 ≤ a := hall a (by simp)
      have htail : ∀ b ∈ as, 1 ≤ b := by
        intro b hb
        exact hall b (by simp [hb])
      have htailprod := ih htail
      calc
        1 = 1 * 1 := by omega
        _ ≤ a * as.prod := Nat.mul_le_mul ha htailprod

/-- Actual finite-cutoff divisibility product bound, including empty lists
and inactive product support. `N` includes every active integer because
`x ≤ N+1`. -/
theorem D_list_prod_le {N : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hx : 1 < x) (hxN : x ≤ (N : ℝ) + 1)
    (as : List ℕ) (hall : ∀ a ∈ as, 1 ≤ a) :
    D N as.prod x ≤ (as.map (fun a => D N a x)).prod := by
  induction as with
  | nil => simp [D_one hN hx]
  | cons a as ih =>
      have ha : 1 ≤ a := hall a (by simp)
      have htail : ∀ b ∈ as, 1 ≤ b := by
        intro b hb
        exact hall b (by simp [hb])
      have hprod : 1 ≤ as.prod := list_prod_pos as htail
      simp only [List.prod_cons, List.map_cons, List.prod_cons]
      calc
        D N (a * as.prod) x ≤ D N a x * D N as.prod x :=
          D_mul_le hN ha hprod hx hxN
        _ ≤ D N a x * (as.map (fun b => D N b x)).prod :=
          mul_le_mul_of_nonneg_left (ih htail) (D_nonneg N a x)

/-- Equation (7) stated directly for original cutoff-event probabilities.
The empty list gives `P(1 ∣ n)=1` on the nonempty law. -/
theorem originalProbability_list_prod_le {N : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hx : 1 < x) (hxN : x ≤ (N : ℝ) + 1)
    (as : List ℕ) (hall : ∀ a ∈ as, 1 ≤ a) :
    originalProbability N as.prod x ≤
      (as.map (fun a => originalProbability N a x)).prod := by
  have hpos : 0 < as.prod := by
    have h := list_prod_pos as hall
    omega
  rw [originalProbability_eq_D hpos hxN]
  have hmap :
      (as.map (fun a => originalProbability N a x)).prod =
        (as.map (fun a => D N a x)).prod := by
    congr 1
    apply List.map_congr_left
    intro a ha
    exact originalProbability_eq_D (by have := hall a ha; omega : 0 < a) hxN
  rw [hmap]
  exact D_list_prod_le hN hx hxN as hall

#print axioms D_list_prod_le
#print axioms D_eq_actual_probability
#print axioms originalProbability_list_prod_le

end
end BuildingBlocks.ActualCutoffDivisibilityProduct
