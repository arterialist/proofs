import BuildingBlocks.PhysicalThetaJumpEnergy
import Mathlib.MeasureTheory.Integral.Lebesgue.Add

namespace BuildingBlocks.PhysicalThetaJumpHomogeneity
open MeasureTheory
open scoped ENNReal
open BuildingBlocks.PhysicalThetaJumpEnergy BuildingBlocks.PhysicalThetaMeasure

theorem edge_mass_homogeneous (c : ℝ) (h : ℝ → ℝ) (a : ℝ) :
    edgeMass (fun u => c * h u) a = ENNReal.ofReal (c ^ 2) * edgeMass h a := by
  unfold edgeMass
  have heq : (fun u : ℝ => ENNReal.ofReal
      (BuildingBlocks.PhysicalThetaSeries.phi (u + a) * BuildingBlocks.PhysicalThetaSeries.phi u *
        (c * h (u + a) - c * h u) ^ 2)) =
      (fun u : ℝ => ENNReal.ofReal (c ^ 2) * ENNReal.ofReal
      (BuildingBlocks.PhysicalThetaSeries.phi (u + a) * BuildingBlocks.PhysicalThetaSeries.phi u *
        (h (u + a) - h u) ^ 2)) := by
    funext u
    rw [← ENNReal.ofReal_mul (sq_nonneg c)]
    congr 1
    ring
  rw [heq, lintegral_const_mul' _ _ ENNReal.ofReal_ne_top]

theorem continuous_energy_homogeneous (c : ℝ) (h : ℝ → ℝ) :
    continuousEnergy (fun u => c * h u) = ENNReal.ofReal (c ^ 2) * continuousEnergy h := by
  unfold continuousEnergy
  simp only [edge_mass_homogeneous]
  rw [← lintegral_const_mul' _ _ ENNReal.ofReal_ne_top]
  apply lintegral_congr
  intro a
  exact mul_left_comm _ _ _

theorem prime_energy_homogeneous (c : ℝ) (h : ℝ → ℝ) :
    primeEnergy (fun u => c * h u) = ENNReal.ofReal (c ^ 2) * primeEnergy h := by
  unfold primeEnergy
  simp only [edge_mass_homogeneous]
  rw [← ENNReal.tsum_mul_left]
  congr 1
  funext n
  exact mul_left_comm _ _ _

theorem jump_energy_homogeneous (c : ℝ) (h : ℝ → ℝ) :
    jumpEnergy (fun u => c * h u) = ENNReal.ofReal (c ^ 2) * jumpEnergy h := by
  rw [jumpEnergy, jumpEnergy, continuous_energy_homogeneous, prime_energy_homogeneous, mul_add]

theorem killed_energy_homogeneous (R c : ℝ) (h : ℝ → ℝ) :
    killedEnergy R (fun u => c * h u) = ENNReal.ofReal (c ^ 2) * killedEnergy R h := by
  have heq : killedExtension R (fun u => c * h u) =
      (fun u => c * killedExtension R h u) := by
    funext u
    unfold killedExtension
    split_ifs <;> simp
  unfold killedEnergy
  rw [heq, jump_energy_homogeneous]

theorem jump_energy_zero : jumpEnergy (fun _ : ℝ => 0) = 0 := by
  simp [jumpEnergy, continuousEnergy, primeEnergy, edgeMass]

theorem killed_energy_zero (R : ℝ) : killedEnergy R (fun _ : ℝ => 0) = 0 := by
  have heq : killedExtension R (fun _ : ℝ => 0) = (fun _ => 0) := by
    funext u
    simp [killedExtension]
  rw [killedEnergy, heq, jump_energy_zero]

theorem exterior_hilbert_energy_smul (R c : ℝ) (h : ExteriorGroundSpace R) :
    exteriorHilbertEnergy R (c • h) = ENNReal.ofReal (c ^ 2) * exteriorHilbertEnergy R h := by
  have hh : (fun u : ℝ => (c • h) u) =ᵐ[exteriorNu R] (fun u => c * h u) := by
    simpa only [Pi.smul_apply, smul_eq_mul] using Lp.coeFn_smul c h
  rw [exteriorHilbertEnergy, killed_energy_exterior_nu_ae_congr hh, killed_energy_homogeneous]
  rfl

theorem exterior_hilbert_energy_zero (R : ℝ) :
    exteriorHilbertEnergy R (0 : ExteriorGroundSpace R) = 0 := by
  have hh : (fun u : ℝ => (0 : ExteriorGroundSpace R) u) =ᵐ[exteriorNu R] (fun _ => 0) :=
    Lp.coeFn_zero _ _ _
  rw [exteriorHilbertEnergy, killed_energy_exterior_nu_ae_congr hh, killed_energy_zero]

theorem maximal_exterior_domain_zero (R : ℝ) :
    (0 : ExteriorGroundSpace R) ∈ maximalExteriorDomain R := by
  change exteriorHilbertEnergy R (0 : ExteriorGroundSpace R) < ∞
  rw [exterior_hilbert_energy_zero]
  exact ENNReal.zero_lt_top

theorem maximal_exterior_domain_smul (R c : ℝ) (h : ExteriorGroundSpace R)
    (hh : h ∈ maximalExteriorDomain R) : c • h ∈ maximalExteriorDomain R := by
  change exteriorHilbertEnergy R (c • h) < ∞
  rw [exterior_hilbert_energy_smul]
  exact ENNReal.mul_lt_top ENNReal.ofReal_lt_top hh

#print axioms edge_mass_homogeneous
#print axioms continuous_energy_homogeneous
#print axioms prime_energy_homogeneous
#print axioms jump_energy_homogeneous
#print axioms killed_energy_homogeneous
#print axioms jump_energy_zero
#print axioms killed_energy_zero
#print axioms exterior_hilbert_energy_smul
#print axioms exterior_hilbert_energy_zero
#print axioms maximal_exterior_domain_zero
#print axioms maximal_exterior_domain_smul
end BuildingBlocks.PhysicalThetaJumpHomogeneity
