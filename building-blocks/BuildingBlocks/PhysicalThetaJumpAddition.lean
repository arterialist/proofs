import BuildingBlocks.PhysicalThetaJumpHomogeneity
import Mathlib.MeasureTheory.Measure.Prod

namespace BuildingBlocks.PhysicalThetaJumpAddition
open MeasureTheory
open scoped ENNReal
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaParity
open BuildingBlocks.PhysicalThetaUniform BuildingBlocks.PhysicalContinuousArrival
open BuildingBlocks.PhysicalThetaMeasure BuildingBlocks.PhysicalThetaJumpEnergy
open BuildingBlocks.PhysicalThetaJumpHomogeneity

noncomputable def integrand (h : ℝ → ℝ) (a u : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (phi (u + a) * phi u * (h (u + a) - h u) ^ 2)

theorem integrand_measurable {h : ℝ → ℝ} (hh : Measurable h) (a : ℝ) :
    Measurable (integrand h a) := by
  have hp : Measurable phi := phi_continuous.measurable
  unfold integrand
  fun_prop

theorem edge_mass_measurable {h : ℝ → ℝ} (hh : Measurable h) : Measurable (edgeMass h) := by
  have hp : Measurable phi := phi_continuous.measurable
  have hm : Measurable (fun p : ℝ × ℝ => integrand h p.1 p.2) := by
    unfold integrand
    fun_prop
  exact hm.lintegral_prod_right' (ν := volume)

theorem integrand_add_bound (h g : ℝ → ℝ) (a u : ℝ) :
    integrand (fun v => h v + g v) a u ≤ 2 * (integrand h a u + integrand g a u) := by
  have hw : 0 ≤ phi (u + a) * phi u := mul_nonneg (phi_positive _).le (phi_positive _).le
  have h1 : 0 ≤ phi (u + a) * phi u * (h (u + a) - h u) ^ 2 := mul_nonneg hw (sq_nonneg _)
  have h2 : 0 ≤ phi (u + a) * phi u * (g (u + a) - g u) ^ 2 := mul_nonneg hw (sq_nonneg _)
  unfold integrand
  rw [← ENNReal.ofReal_add h1 h2, ← ENNReal.ofReal_ofNat 2,
    ← ENNReal.ofReal_mul (by norm_num : (0 : ℝ) ≤ 2)]
  apply ENNReal.ofReal_le_ofReal
  have hs : (h (u + a) + g (u + a) - (h u + g u)) ^ 2 ≤
      2 * ((h (u + a) - h u) ^ 2 + (g (u + a) - g u) ^ 2) := by
    nlinarith [sq_nonneg ((h (u + a) - h u) - (g (u + a) - g u))]
  nlinarith [mul_le_mul_of_nonneg_left hs hw]

theorem edge_mass_add_bound {h g : ℝ → ℝ} (hh : Measurable h) (a : ℝ) :
    edgeMass (fun u => h u + g u) a ≤ 2 * (edgeMass h a + edgeMass g a) := by
  change (∫⁻ u : ℝ, integrand (fun v => h v + g v) a u) ≤ _
  calc
    _ ≤ ∫⁻ u : ℝ, 2 * (integrand h a u + integrand g a u) :=
      lintegral_mono (integrand_add_bound h g a)
    _ = _ := by
      rw [lintegral_const_mul' _ _ (by norm_num : (2 : ℝ≥0∞) ≠ ∞),
        lintegral_add_left (integrand_measurable hh a)]
      rfl

theorem continuous_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    continuousEnergy (fun u => h u + g u) ≤ 2 * (continuousEnergy h + continuousEnergy g) := by
  have hk : Measurable kernel := by unfold kernel; fun_prop
  have hm := hk.ennreal_ofReal.mul (edge_mass_measurable hh)
  unfold continuousEnergy
  calc
    _ ≤ ∫⁻ a : ℝ in Set.Ioi 0,
        2 * (ENNReal.ofReal (kernel a) * edgeMass h a +
          ENNReal.ofReal (kernel a) * edgeMass g a) := by
      apply lintegral_mono
      intro a
      have hs := mul_le_mul_left' (edge_mass_add_bound (g := g) hh a) (ENNReal.ofReal (kernel a))
      simpa only [mul_add, mul_assoc, mul_left_comm] using hs
    _ = _ := by
      rw [lintegral_const_mul' _ _ (by norm_num : (2 : ℝ≥0∞) ≠ ∞),
        lintegral_add_left hm]

theorem prime_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    primeEnergy (fun u => h u + g u) ≤ 2 * (primeEnergy h + primeEnergy g) := by
  unfold primeEnergy
  calc
    _ ≤ ∑' n : {n : ℕ // 2 ≤ n}, 2 *
        (ENNReal.ofReal (ArithmeticFunction.vonMangoldt n.val / Real.sqrt n.val) * edgeMass h (Real.log n.val) +
        ENNReal.ofReal (ArithmeticFunction.vonMangoldt n.val / Real.sqrt n.val) * edgeMass g (Real.log n.val)) := by
      apply ENNReal.tsum_le_tsum
      intro n
      have hs := mul_le_mul_left' (edge_mass_add_bound (g := g) hh (Real.log n.val))
        (ENNReal.ofReal (ArithmeticFunction.vonMangoldt n.val / Real.sqrt n.val))
      simpa only [mul_add, mul_assoc, mul_left_comm] using hs
    _ = _ := by rw [ENNReal.tsum_mul_left, ENNReal.summable.tsum_add ENNReal.summable]

theorem jump_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    jumpEnergy (fun u => h u + g u) ≤ 2 * (jumpEnergy h + jumpEnergy g) := by
  have hc := continuous_energy_add_bound (g := g) hh
  have hp := prime_energy_add_bound (g := g) hh
  unfold jumpEnergy
  calc
    _ ≤ _ := add_le_add hc hp
    _ = _ := by ring

theorem killed_extension_measurable {h : ℝ → ℝ} (hh : Measurable h) (R : ℝ) :
    Measurable (killedExtension R h) := by
  have hm : MeasurableSet {u : ℝ | R < |u|} :=
    measurableSet_lt measurable_const continuous_abs.measurable
  simpa only [killedExtension, Set.indicator] using hh.indicator hm

theorem killed_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) (R : ℝ) :
    killedEnergy R (fun u => h u + g u) ≤ 2 * (killedEnergy R h + killedEnergy R g) := by
  have heq : killedExtension R (fun u => h u + g u) =
      (fun u => killedExtension R h u + killedExtension R g u) := by
    funext u
    unfold killedExtension
    split_ifs <;> simp
  unfold killedEnergy
  rw [heq]
  exact jump_energy_add_bound (killed_extension_measurable hh R)

theorem exterior_hilbert_energy_add_bound (R : ℝ) (h g : ExteriorGroundSpace R) :
    exteriorHilbertEnergy R (h + g) ≤
      2 * (exteriorHilbertEnergy R h + exteriorHilbertEnergy R g) := by
  have hm := Lp.aestronglyMeasurable h
  let H := hm.mk (fun u : ℝ => h u)
  have hH : Measurable H := hm.stronglyMeasurable_mk.measurable
  have heq : (fun u : ℝ => h u) =ᵐ[exteriorNu R] H := hm.ae_eq_mk
  have hsum : (fun u : ℝ => (h + g) u) =ᵐ[exteriorNu R] (fun u => H u + g u) := by
    have ha : (fun u : ℝ => (h + g) u) =ᵐ[exteriorNu R] (fun u => h u + g u) := by
      simpa only [Pi.add_apply] using Lp.coeFn_add h g
    exact ha.trans (heq.add Filter.EventuallyEq.rfl)
  have hb := killed_energy_add_bound (g := fun u : ℝ => g u) hH R
  rw [← killed_energy_exterior_nu_ae_congr heq] at hb
  unfold exteriorHilbertEnergy
  rw [killed_energy_exterior_nu_ae_congr hsum]
  exact hb

theorem maximal_exterior_domain_add (R : ℝ) (h g : ExteriorGroundSpace R)
    (hh : h ∈ maximalExteriorDomain R) (hg : g ∈ maximalExteriorDomain R) :
    h + g ∈ maximalExteriorDomain R := by
  change exteriorHilbertEnergy R (h + g) < ∞
  exact (exterior_hilbert_energy_add_bound R h g).trans_lt
    (ENNReal.mul_lt_top (by norm_num : (2 : ℝ≥0∞) < ∞) (ENNReal.add_lt_top.mpr ⟨hh, hg⟩))

def exteriorFormDomain (R : ℝ) : Submodule ℝ (ExteriorGroundSpace R) where
  carrier := maximalExteriorDomain R
  zero_mem' := maximal_exterior_domain_zero R
  add_mem' := fun hh hg => maximal_exterior_domain_add R _ _ hh hg
  smul_mem' := fun c _ hh => maximal_exterior_domain_smul R c _ hh

#print axioms integrand_measurable
#print axioms edge_mass_measurable
#print axioms integrand_add_bound
#print axioms edge_mass_add_bound
#print axioms continuous_energy_add_bound
#print axioms prime_energy_add_bound
#print axioms jump_energy_add_bound
#print axioms killed_extension_measurable
#print axioms killed_energy_add_bound
#print axioms exterior_hilbert_energy_add_bound
#print axioms maximal_exterior_domain_add
end BuildingBlocks.PhysicalThetaJumpAddition
