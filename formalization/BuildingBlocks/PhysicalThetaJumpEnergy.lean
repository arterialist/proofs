import BuildingBlocks.PhysicalContinuousArrival
import BuildingBlocks.PhysicalThetaParity
import Mathlib.MeasureTheory.Group.Measure
import Mathlib.Topology.Instances.ENNReal.Lemmas
import BuildingBlocks.WeakGroundPrimeTail
import Mathlib.MeasureTheory.Group.LIntegral
import BuildingBlocks.PhysicalThetaMeasure

namespace BuildingBlocks.PhysicalThetaJumpEnergy
open Real MeasureTheory
open scoped ENNReal ArithmeticFunction.vonMangoldt
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaParity
open BuildingBlocks.PhysicalContinuousArrival
open BuildingBlocks.PhysicalThetaMeasure

noncomputable def edgeMass (h : ℝ → ℝ) (a : ℝ) : ℝ≥0∞ :=
  ∫⁻ u : ℝ, ENNReal.ofReal (phi (u + a) * phi u * (h (u + a) - h u) ^ 2)
noncomputable def continuousEnergy (h : ℝ → ℝ) : ℝ≥0∞ :=
  ∫⁻ a : ℝ in Set.Ioi 0, ENNReal.ofReal (kernel a) * edgeMass h a
noncomputable def primeEnergy (h : ℝ → ℝ) : ℝ≥0∞ :=
  ∑' n : {n : ℕ // 2 ≤ n},
    ENNReal.ofReal (Λ n.val / sqrt n.val) * edgeMass h (log n.val)
noncomputable def jumpEnergy (h : ℝ → ℝ) : ℝ≥0∞ :=
  continuousEnergy h + primeEnergy h
noncomputable def killedExtension (R : ℝ) (h : ℝ → ℝ) (u : ℝ) : ℝ :=
  if R < |u| then h u else 0
noncomputable def killedEnergy (R : ℝ) (h : ℝ → ℝ) : ℝ≥0∞ :=
  jumpEnergy (killedExtension R h)

theorem edge_mass_reverse (h : ℝ → ℝ) (a : ℝ) : edgeMass h (-a) = edgeMass h a := by
  let f := fun u : ℝ => ENNReal.ofReal (phi (u + a) * phi u * (h (u + a) - h u) ^ 2)
  calc
    edgeMass h (-a) = ∫⁻ u : ℝ, f (u + -a) := by
      apply lintegral_congr
      intro u
      dsimp [f]
      simp only [neg_add_cancel_right]
      congr 1
      ring
    _ = ∫⁻ u : ℝ, f u := lintegral_add_right_eq_self f (-a)
    _ = edgeMass h a := rfl

theorem edge_mass_ae_congr {h g : ℝ → ℝ} (hh : h =ᵐ[volume] g) (a : ℝ) :
    edgeMass h a = edgeMass g a := by
  have hs := (measurePreserving_add_right (volume : Measure ℝ) a).quasiMeasurePreserving.ae hh
  apply lintegral_congr_ae
  filter_upwards [hh, hs] with u hu hus
  rw [hu, hus]

theorem continuous_energy_ae_congr {h g : ℝ → ℝ} (hh : h =ᵐ[volume] g) :
    continuousEnergy h = continuousEnergy g := by
  unfold continuousEnergy
  congr 1
  funext a
  rw [edge_mass_ae_congr hh]

theorem prime_energy_ae_congr {h g : ℝ → ℝ} (hh : h =ᵐ[volume] g) :
    primeEnergy h = primeEnergy g := by
  unfold primeEnergy
  congr 1
  funext n
  rw [edge_mass_ae_congr hh]

theorem jump_energy_ae_congr {h g : ℝ → ℝ} (hh : h =ᵐ[volume] g) :
    jumpEnergy h = jumpEnergy g := by
  rw [jumpEnergy, jumpEnergy, continuous_energy_ae_congr hh, prime_energy_ae_congr hh]

theorem killed_extension_ae_congr {R : ℝ} {h g : ℝ → ℝ}
    (hh : h =ᵐ[volume.restrict {u : ℝ | R < |u|}] g) :
    killedExtension R h =ᵐ[volume] killedExtension R g := by
  have hm : MeasurableSet {u : ℝ | R < |u|} :=
    measurableSet_lt measurable_const continuous_abs.measurable
  have hs := (ae_restrict_iff' hm).mp hh
  filter_upwards [hs] with u hu
  unfold killedExtension
  split_ifs with hO
  · exact hu hO
  · rfl

theorem killed_energy_ae_congr {R : ℝ} {h g : ℝ → ℝ}
    (hh : h =ᵐ[volume.restrict {u : ℝ | R < |u|}] g) :
    killedEnergy R h = killedEnergy R g :=
  jump_energy_ae_congr (killed_extension_ae_congr hh)

theorem jump_energy_nu_ae_congr {h g : ℝ → ℝ} (hh : h =ᵐ[nu] g) :
    jumpEnergy h = jumpEnergy g :=
  jump_energy_ae_congr ((ae_dictionary (fun u => h u = g u)).mp hh)

theorem killed_energy_exterior_nu_ae_congr {R : ℝ} {h g : ℝ → ℝ}
    (hh : h =ᵐ[exteriorNu R] g) : killedEnergy R h = killedEnergy R g := by
  have hm : MeasurableSet {u : ℝ | R < |u|} :=
    measurableSet_lt measurable_const continuous_abs.measurable
  have hnu := (ae_restrict_iff' hm).mp hh
  have hvol := (ae_dictionary (fun u => R < |u| → h u = g u)).mp hnu
  exact killed_energy_ae_congr ((ae_restrict_iff' hm).mpr hvol)

noncomputable def hilbertEnergy (h : GroundSpace) : ℝ≥0∞ := jumpEnergy (fun u => h u)
noncomputable def exteriorHilbertEnergy (R : ℝ) (h : ExteriorGroundSpace R) : ℝ≥0∞ :=
  killedEnergy R (fun u => h u)
def maximalExteriorDomain (R : ℝ) : Set (ExteriorGroundSpace R) :=
  {h | exteriorHilbertEnergy R h < ∞}

theorem edge_mass_abs_contract (h : ℝ → ℝ) (a : ℝ) :
    edgeMass (fun u => |h u|) a ≤ edgeMass h a := by
  apply lintegral_mono
  intro u
  apply ENNReal.ofReal_le_ofReal
  apply mul_le_mul_of_nonneg_left _ (mul_nonneg (phi_positive _).le (phi_positive _).le)
  exact sq_le_sq.mpr (abs_abs_sub_abs_le_abs_sub _ _)

theorem continuous_energy_abs_contract (h : ℝ → ℝ) :
    continuousEnergy (fun u => |h u|) ≤ continuousEnergy h := by
  apply lintegral_mono
  intro a
  exact mul_le_mul_left' (edge_mass_abs_contract h a) _

theorem prime_energy_abs_contract (h : ℝ → ℝ) :
    primeEnergy (fun u => |h u|) ≤ primeEnergy h := by
  apply ENNReal.tsum_le_tsum
  intro n
  exact mul_le_mul_left' (edge_mass_abs_contract h (log n.val)) _

theorem jump_energy_abs_contract (h : ℝ → ℝ) :
    jumpEnergy (fun u => |h u|) ≤ jumpEnergy h :=
  add_le_add (continuous_energy_abs_contract h) (prime_energy_abs_contract h)

theorem killed_energy_abs_contract (R : ℝ) (h : ℝ → ℝ) :
    killedEnergy R (fun u => |h u|) ≤ killedEnergy R h := by
  have heq : killedExtension R (fun u => |h u|) =
      (fun u => |killedExtension R h u|) := by
    funext u
    unfold killedExtension
    split_ifs <;> simp
  unfold killedEnergy
  rw [heq]
  exact jump_energy_abs_contract _


/-- Zero extension separates internal edges from both directions of killing departure. -/
theorem killed_edge_square_split (R : ℝ) (h : ℝ → ℝ) (u a : ℝ) :
    (killedExtension R h (u + a) - killedExtension R h u) ^ 2 =
      (if R < |u| ∧ R < |u + a| then (h (u + a) - h u) ^ 2 else 0) +
      (if R < |u| ∧ ¬R < |u + a| then h u ^ 2 else 0) +
      (if ¬R < |u| ∧ R < |u + a| then h (u + a) ^ 2 else 0) := by
  by_cases hu : R < |u|
  · by_cases hv : R < |u + a| <;> simp [killedExtension, hu, hv]
  · by_cases hv : R < |u + a| <;> simp [killedExtension, hu, hv]

#print axioms killed_edge_square_split
#print axioms edge_mass_reverse
#print axioms edge_mass_ae_congr
#print axioms continuous_energy_ae_congr
#print axioms prime_energy_ae_congr
#print axioms jump_energy_ae_congr
#print axioms killed_extension_ae_congr
#print axioms killed_energy_ae_congr
#print axioms jump_energy_nu_ae_congr
#print axioms killed_energy_exterior_nu_ae_congr
#print axioms edge_mass_abs_contract
#print axioms continuous_energy_abs_contract
#print axioms prime_energy_abs_contract
#print axioms jump_energy_abs_contract
#print axioms killed_energy_abs_contract
end BuildingBlocks.PhysicalThetaJumpEnergy
