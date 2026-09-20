import BuildingBlocks.ActualMobiusCenteredDivisorWindow

open BuildingBlocks.ActualMobiusCenteredDivisorWindow

#check balancedResidueDefect
#check remainderDefectBounds
#check remainderDefect_le_window_mul
#check rationalFrequencySpacing
#check dyadicRationalFrequencySpacing
#check reciprocalNaturalSpacing
#check dyadicReciprocalProductSpacing
#check criticalReciprocalProductSpacing
#check dyadicProductSet_subset_interval
#check sum_dyadicPairs_by_product
#check dyadicProductMultiplicity_le_divisorsCard
#check normalizedWindowRmsExponent
#check normalizedWindowRmsSaves
#check twoWindowExponent
#check averagedResidualExponent
#check averagedResidualSaves
#check almostAllHighScaleExponent_eq
#check almostAllHighScaleSaves
#check localBoundaryGainExponent
#check localAlmostAllSaves

#print axioms balancedResidueDefect
#print axioms remainderDefectBounds
#print axioms remainderDefect_le_window_mul
#print axioms rationalFrequencySpacing
#print axioms dyadicRationalFrequencySpacing
#print axioms reciprocalNaturalSpacing
#print axioms dyadicReciprocalProductSpacing
#print axioms criticalReciprocalProductSpacing
#print axioms dyadicProductSet_subset_interval
#print axioms sum_dyadicPairs_by_product
#print axioms dyadicProductMultiplicity_le_divisorsCard
#print axioms normalizedWindowRmsExponent
#print axioms normalizedWindowRmsSaves
#print axioms twoWindowExponent
#print axioms averagedResidualExponent
#print axioms averagedResidualSaves
#print axioms almostAllHighScaleExponent_eq
#print axioms almostAllHighScaleSaves
#print axioms localBoundaryGainExponent
#print axioms localAlmostAllSaves

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusCenteredDivisorWindow
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the centered divisor-window module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"CENTERED DIVISOR-WINDOW DECLARATION COUNT {selected.length}"
  logInfo m!"CENTERED DIVISOR-WINDOW TRANSITIVE AXIOMS {state.axioms}"
  logInfo "CENTERED DIVISOR-WINDOW AXIOM AUDIT PASSED"
