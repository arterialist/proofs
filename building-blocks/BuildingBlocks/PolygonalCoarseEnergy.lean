import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

open scoped BigOperators

namespace BuildingBlocks.PolygonalCoarse

noncomputable def cellEnergy (A p q : ℝ) : ℝ :=
  (p^2 + p*q + q^2 + (A-p)^2 + (A-p)*(A-q) + (A-q)^2) / 3

theorem cellEnergy_integral (A p q : ℝ) :
    (∫ u in (0 : ℝ)..1,
      ((1-u)*p+u*q)^2 + (A-((1-u)*p+u*q))^2) = cellEnergy A p q := by
  have heq : (fun u : ℝ => ((1-u)*p+u*q)^2 + (A-((1-u)*p+u*q))^2) =
      (fun u : ℝ => (p^2+(A-p)^2) +
        (2*p*(q-p)-2*(A-p)*(q-p))*u + 2*(q-p)^2*u^2) := by
    funext u
    ring
  rw [heq]
  rw [intervalIntegral.integral_add, intervalIntegral.integral_add]
  · rw [intervalIntegral.integral_const, intervalIntegral.integral_const_mul,
      intervalIntegral.integral_const_mul]
    rw [integral_id, integral_pow]
    simp only [sub_zero, one_pow, zero_pow (by decide : (3 : ℕ) ≠ 0),
      one_smul, Nat.cast_ofNat]
    unfold cellEnergy
    ring
  all_goals apply Continuous.intervalIntegrable; fun_prop

theorem cellEnergy_lower (A p q : ℝ) :
    (p^2 + (A-p)^2 + q^2 + (A-q)^2) / 6 ≤ cellEnergy A p q := by
  unfold cellEnergy
  nlinarith [sq_nonneg (p+q), sq_nonneg ((A-p)+(A-q))]

theorem cellEnergy_upper (A p q : ℝ) :
    cellEnergy A p q ≤ (p^2 + (A-p)^2 + q^2 + (A-q)^2) / 2 := by
  unfold cellEnergy
  nlinarith [sq_nonneg (p-q), sq_nonneg ((A-p)-(A-q))]

theorem polygonal_energy_identity (m : ℕ) (h f : ℕ → ℝ) (A : ℝ) :
    (∑ i ∈ Finset.range m, h i *
      (∫ u in (0 : ℝ)..1,
        ((1-u)*f i+u*f (i+1))^2 + (A-((1-u)*f i+u*f (i+1)))^2)) =
    ∑ i ∈ Finset.range m, h i *
      ((f i)^2 + f i*f (i+1) + (f (i+1))^2 +
        (A-f i)^2 + (A-f i)*(A-f (i+1)) + (A-f (i+1))^2) / 3 := by
  simp_rw [cellEnergy_integral, cellEnergy]
  apply Finset.sum_congr rfl
  intro i hi
  ring

theorem polygonal_energy_bounds (m : ℕ) (h f : ℕ → ℝ) (A : ℝ)
    (hh : ∀ i ∈ Finset.range m, 0 ≤ h i) :
    (∑ i ∈ Finset.range m, h i *
      ((f i)^2 + (A-f i)^2 + (f (i+1))^2 + (A-f (i+1))^2) / 6) ≤
      (∑ i ∈ Finset.range m, h i * cellEnergy A (f i) (f (i+1))) ∧
    (∑ i ∈ Finset.range m, h i * cellEnergy A (f i) (f (i+1))) ≤
      (∑ i ∈ Finset.range m, h i *
        ((f i)^2 + (A-f i)^2 + (f (i+1))^2 + (A-f (i+1))^2) / 2) := by
  constructor
  · apply Finset.sum_le_sum
    intro i hi
    have hs := mul_le_mul_of_nonneg_left (cellEnergy_lower A (f i) (f (i+1))) (hh i hi)
    nlinarith [hs]
  · apply Finset.sum_le_sum
    intro i hi
    have hs := mul_le_mul_of_nonneg_left (cellEnergy_upper A (f i) (f (i+1))) (hh i hi)
    nlinarith [hs]

end BuildingBlocks.PolygonalCoarse
