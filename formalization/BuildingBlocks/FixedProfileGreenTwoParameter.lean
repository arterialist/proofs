import BuildingBlocks.FixedProfileGreenAdmissionFinite

namespace BuildingBlocks.FixedProfileGreenTwoParameter

open Finset
open scoped BigOperators ArithmeticFunction.Moebius
open FixedProfileGreenAdmissionFinite

noncomputable section

/-- Complete actual Möbius packet energy for an arbitrary finite kernel.  Taking
`K = K_X` gives the finite-horizon energy; taking `K = fun d e => 2 * greenKernel d e` gives the source normalization `E_P = 2 ‖F_P‖²`. -/
def packetEnergy (K : ℕ → ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ d ∈ N.divisors, ∑ e ∈ N.divisors, μR d * μR e * K d e

/-- Exact simultaneous-limit discrepancy `B(X,P)` once `KX X` and the old
product `stage P` are instantiated by the analytic construction. -/
def packetDiscrepancy (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    (stage : ℕ → ℕ) (X P : ℕ) : ℝ :=
  packetEnergy (KX X) (stage P) - packetEnergy KLim (stage P)

/-- No face is lost: `B(X,P)` is the complete ordered-pair sum of the literal
kernel error. -/
theorem packetDiscrepancy_eq_complete_error_sum
    (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    (stage : ℕ → ℕ) (X P : ℕ) :
    packetDiscrepancy KX KLim stage X P =
      ∑ d ∈ (stage P).divisors, ∑ e ∈ (stage P).divisors,
        μR d * μR e * (KX X d e - KLim d e) := by
  simp only [packetDiscrepancy, packetEnergy]
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro e he
  ring

/-- Complete admission discrepancy: all old-old, old-delayed, and delayed-
delayed rows remain in the same finite sums. -/
def admissionDiscrepancy (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    (X N p : ℕ) : ℝ :=
  kernelIncrement (KX X) N p - kernelIncrement KLim N p

theorem admissionDiscrepancy_eq_kernel_error
    (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    (X N p : ℕ) :
    admissionDiscrepancy KX KLim X N p =
      kernelIncrement (fun d e => KX X d e - KLim d e) N p := by
  simp only [admissionDiscrepancy, kernelIncrement]
  simp_rw [mul_sub, Finset.sum_sub_distrib]
  ring

/-- The old base-face error retains the strict lower and upper rows separately. -/
theorem old_error_cross_lower_upper
    (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    {X N p : ℕ} (hp : ¬p ∣ N) :
    (∑ d ∈ N.divisors, μR d * (KX X d p - KLim d p)) =
      lowerOldCross (fun d e => KX X d e - KLim d e) N p +
      upperOldCross (fun d e => KX X d e - KLim d e) N p :=
  oldCross_eq_lower_add_upper (fun d e => KX X d e - KLim d e) hp

/-- Finite telescope in either horizon or prime-stage parameter. -/
theorem finite_parameter_telescope (E : ℕ → ℝ) (m : ℕ) :
    (∑ j ∈ Finset.range m, (E (j + 1) - E j)) = E m - E 0 := by
  induction m with
  | zero => simp
  | succ m ih =>
      rw [Finset.sum_range_succ, ih]
      ring

/-- Exact two-horizon cocycle for `B`; useful before asking for a rate. -/
theorem packetDiscrepancy_two_horizon
    (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    (stage : ℕ → ℕ) (X₀ X₁ X₂ P : ℕ) :
    packetDiscrepancy KX KLim stage X₂ P - packetDiscrepancy KX KLim stage X₀ P =
      (packetDiscrepancy KX KLim stage X₂ P - packetDiscrepancy KX KLim stage X₁ P) +
      (packetDiscrepancy KX KLim stage X₁ P - packetDiscrepancy KX KLim stage X₀ P) := by
  ring

/-- Exact prime-stage telescope at a fixed horizon, with no uniformity assumed. -/
theorem packetDiscrepancy_stage_telescope
    (KX : ℕ → ℕ → ℕ → ℝ) (KLim : ℕ → ℕ → ℝ)
    (stage : ℕ → ℕ) (X m : ℕ) :
    (∑ j ∈ Finset.range m,
      (packetDiscrepancy KX KLim stage X (j + 1) -
       packetDiscrepancy KX KLim stage X j)) =
      packetDiscrepancy KX KLim stage X m -
      packetDiscrepancy KX KLim stage X 0 :=
  finite_parameter_telescope (fun P => packetDiscrepancy KX KLim stage X P) m

#print axioms packetDiscrepancy_eq_complete_error_sum
#print axioms admissionDiscrepancy_eq_kernel_error
#print axioms old_error_cross_lower_upper
#print axioms finite_parameter_telescope
#print axioms packetDiscrepancy_two_horizon
#print axioms packetDiscrepancy_stage_telescope

end
end BuildingBlocks.FixedProfileGreenTwoParameter
