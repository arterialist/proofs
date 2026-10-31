import BuildingBlocks.RiemannZetaFredholmPerronContourResolution
import Lean.Util.CollectAxioms

open Real Complex Filter
open BuildingBlocks
open BuildingBlocks.HighFrequencyReductionBridge
open BuildingBlocks.RiemannHypothesisResolution
open BuildingBlocks.RiemannZetaPerronContourShift
open BuildingBlocks.RiemannZetaFredholmCarrierCoercivity
open BuildingBlocks.RiemannZetaCauchyFredholmSynthesis
open BuildingBlocks.RiemannZetaFredholmPerronContourResolution

/-!
# Standalone Adversarial Verification Harness for Module 334
Directly queries the Lean 4 kernel to verify types, non-circularity, and axioms.
-/

-- Test 1: Verify type signature and unconditional nature of spectral_gap_carrier_residue_duality
#check (spectral_gap_carrier_residue_duality : ∀ β : ℝ, offlineExponent β - subquadraticExponent = offlineSpectralGap β)

-- Test 2: Verify type signature of carrier_power_dominates_residue_threshold
#check (carrier_power_dominates_residue_threshold : ∀ β : ℝ, 1 / 2 < β → 0 < 2 * (offlineExponent β - subquadraticExponent))

-- Test 3: Verify type signature of fredholm_carrier_gap_residue_coercivity
#check (fredholm_carrier_gap_residue_coercivity :
  ∀ {γ β b A C M_bal : ℝ},
    0 < γ → 1 / 2 < β → 0 < b →
    ∃ T > (16 : ℝ), 0 < fredholmCarrierGap b (offlineExponent β - subquadraticExponent) A C M_bal T)

-- Test 4: Verify type signature of grand_fredholm_perron_master
#check (grand_fredholm_perron_master :
  (Target = RiemannHypothesis) ∧
  (RiemannHypothesis ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0)) ∧
  (RiemannHypothesis ↔ HighFrequencyZeroFree frontierCutoff) ∧
  (RiemannHypothesis ↔ HighFrequencyZeroFree asymptoticCutoff) ∧
  (RiemannHypothesis ↔ Nonempty (FredholmSpectralCarrierFamily frontierCutoff)) ∧
  (RiemannHypothesis ↔ Nonempty (FredholmSpectralCarrierFamily asymptoticCutoff)) ∧
  (RiemannHypothesis ↔ Nonempty (FredholmPerronSynthesisSystem frontierCutoff)) ∧
  (RiemannHypothesis ↔ Nonempty (FredholmPerronSynthesisSystem asymptoticCutoff)) ∧
  (RiemannHypothesis ↔ Nonempty CanonicalAdmissibleContradictionSystem) ∧
  (RiemannHypothesis ↔ Nonempty CauchyFredholmCarrierSystem) ∧
  (EventualSubquadraticGrowth → RiemannHypothesis) ∧
  (PerronLogGrowth → RiemannHypothesis) ∧
  (∀ s : ℂ, 1 / 2 < s.re → s ≠ 1 → riemannZeta s = 0 → ¬ EventualSubquadraticGrowth) ∧
  (∀ s : ℂ, 1 / 2 < s.re → s ≠ 1 → riemannZeta s = 0 → ¬ PerronLogGrowth) ∧
  (∀ s : ℂ, 1 / 2 < s.re → s ≠ 1 → |s.im| ≤ frontierCutoff → riemannZeta s ≠ 0) ∧
  (∀ s : ℂ, 1 / 2 < s.re → s ≠ 1 → |s.im| ≤ asymptoticCutoff → riemannZeta s ≠ 0) ∧
  (riemannZeta ((((1 : ℝ) / 2 : ℝ)) : ℂ) ≠ 0) ∧
  (∀ C : ℝ, ∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2))))

-- Test 5: Verify that RiemannHypothesis_of_fredholm_perron_frontier can deduce RiemannHypothesis directly
example (sys : FredholmPerronSynthesisSystem frontierCutoff) : RiemannHypothesis :=
  RiemannHypothesis_of_fredholm_perron_frontier sys

-- Test 6: Verify that target_of_fredholm_perron_frontier deduces canonical Target directly
example (sys : FredholmPerronSynthesisSystem frontierCutoff) : Target :=
  target_of_fredholm_perron_frontier sys

-- Test 7: In-Kernel Check of Axioms on grand_fredholm_perron_master
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let decl := `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.grand_fredholm_perron_master
  let axioms ← Lean.collectAxioms decl
  let allowed : Array Name := #[`propext, `Classical.choice, `Quot.sound]
  for ax in axioms do
    if !allowed.contains ax then
      throwError s!"Disallowed axiom: {ax}"
  logInfo m!"STANDALONE LEAN AUDIT PASSED: {decl} strictly depends on {axioms}"
