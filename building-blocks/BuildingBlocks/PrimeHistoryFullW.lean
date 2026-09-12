import BuildingBlocks.PrimeHistoryCoefficientIdentification
import BuildingBlocks.CriticalMultipleMellin

open Finset
open scoped BigOperators

namespace BuildingBlocks.PrimeHistoryFullW

open PrimeHistoryCoefficientIdentification PrimeSourceDistinctFilter

/-- The literal every-multiple real arithmetic W, with the causal coefficient V. -/
noncomputable def W (x : ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * coefficientV (x/d)

/-- The full signed core, before harmonic aggregation. -/
noncomputable def core (s : ℝ) : ℝ :=
  ReflectionFilter.L0 (conv PrimeBlockSource.source PrimeBlockSource.source) s -
    SamePrimeBlockCalibration.tau s

/-- Literal finite action of sum_{d>=1} d^(-1) delta_{log d} at the causal cutoff. -/
noncomputable def harmonicAction (f : ℝ → ℝ) (s : ℝ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 ⌊Real.exp s⌋₊, (1/(d : ℝ))*f (s-Real.log d)

/-- This real W is exactly the existing multiple cutoff action, without an infinite-sum change. -/
theorem W_eq_existing_cutoffSum (x : ℝ) :
    (W x : ℂ) = CriticalMultipleMellin.cutoffSum (fun y => (coefficientV y : ℂ)) x := by
  unfold W CriticalMultipleMellin.cutoffSum
  rw [Complex.ofReal_sum]
  symm
  apply Finset.sum_bij (fun j _ => j+1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n-1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    simp [CriticalMultipleMellin.scaled]

/-- Every retained divisor lies in the genuine nonnegative-age source domain. -/
theorem retained_age_nonneg {s : ℝ} {d : ℕ}
    (hd : d ∈ Finset.Icc 1 ⌊Real.exp s⌋₊) : 0 ≤ s-Real.log d := by
  have hd0 : (0 : ℝ) < d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hde : (d : ℝ) ≤ Real.exp s :=
    (Nat.le_floor_iff (Real.exp_pos s).le).mp (Finset.mem_Icc.mp hd).2
  exact sub_nonneg.mpr ((Real.log_le_iff_le_exp hd0).mpr hde)

/-- The square-root weight and logarithmic shift produce exactly the harmonic coefficient. -/
theorem harmonic_normalization {d : ℝ} (hd : 0 < d) (s : ℝ) :
    (1/d)*Real.exp (-3*(s-Real.log d)/2) = Real.exp (-3*s/2)*Real.sqrt d := by
  have hh : Real.exp (Real.log d/2) = Real.sqrt d := by
    rw [Real.exp_half, Real.exp_log hd]
  have he : Real.exp (-3*(s-Real.log d)/2) =
      Real.exp (-3*s/2)*d*Real.sqrt d := by
    rw [show -3*(s-Real.log d)/2 = -3*s/2+Real.log d+Real.log d/2 by ring,
      Real.exp_add, Real.exp_add, Real.exp_log hd, hh]
  rw [he]
  field_simp

/-- Exact single retained multiple, including the zero-age activation endpoint. -/
theorem retained_core_identity {s : ℝ} {d : ℕ}
    (hd : d ∈ Finset.Icc 1 ⌊Real.exp s⌋₊) :
    (1/(d : ℝ))*core (s-Real.log d) =
      Real.exp (-3*s/2)*Real.sqrt d*coefficientV (Real.exp s/d) := by
  have hd0 : (0 : ℝ) < d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  unfold core
  rw [actual_source_eq_coefficientV (retained_age_nonneg hd)]
  rw [Real.exp_sub, Real.exp_log hd0, ← mul_assoc, harmonic_normalization hd0]

/-- The actual every-multiple W is exactly the harmonic action of the complete signed core. -/
theorem normalized_W_eq_harmonicAction {s : ℝ} (hs : 0 ≤ s) :
    Real.exp (-3*s/2)*W (Real.exp s) = harmonicAction core s := by
  unfold W harmonicAction
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  rw [retained_core_identity hd]
  ring

/-- Expanded form of the every-multiple identity, with no sign assumption. -/
theorem normalized_W_eq_source_sum {s : ℝ} (hs : 0 ≤ s) :
    Real.exp (-3*s/2)*W (Real.exp s) =
      ∑ d ∈ Finset.Icc 1 ⌊Real.exp s⌋₊, (1/(d : ℝ))*
        (ReflectionFilter.L0 (conv PrimeBlockSource.source PrimeBlockSource.source) (s-Real.log d) -
          SamePrimeBlockCalibration.tau (s-Real.log d)) :=
  normalized_W_eq_harmonicAction hs

@[simp] theorem core_zero : core 0 = 0 := by
  unfold core
  rw [actual_source_eq_coefficientV (le_refl 0)]
  simp [coefficientV]

@[simp] theorem W_one : W 1 = 0 := by simp [W, coefficientV]

theorem W_zero_of_le_one {x : ℝ} (hx : x ≤ 1) : W x = 0 := by
  unfold W
  apply Finset.sum_eq_zero
  intro d hd
  have hd1 : (1 : ℝ) ≤ d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hd0 : (0 : ℝ) < d := by linarith
  have he : x/d ≤ 1 := (div_le_one hd0).mpr (hx.trans hd1)
  simp [coefficientV, he]

#print axioms W_eq_existing_cutoffSum
#print axioms retained_core_identity
#print axioms normalized_W_eq_source_sum
#print axioms core_zero
#print axioms W_zero_of_le_one

end BuildingBlocks.PrimeHistoryFullW
