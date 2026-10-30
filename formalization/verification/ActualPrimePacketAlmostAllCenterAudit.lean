import BuildingBlocks.ActualPrimePacketAlmostAllCenter

#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.averagePrefactorExponent
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.averagePrefactorExponent
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.critical_prefactor
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.critical_prefactor
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.prefactor_positive_above_critical
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.prefactor_positive_above_critical
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.selberg_range_of_critical_or_larger
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.selberg_range_of_critical_or_larger
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.zeroModeExponent
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.zeroModeExponent
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.zeroMode_sub_prefactor
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.zeroMode_sub_prefactor
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.offline_zero_below_envelope
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.offline_zero_below_envelope
#check BuildingBlocks.ActualPrimePacketAlmostAllCenter.proper_power_below_prime_scale
#print axioms BuildingBlocks.ActualPrimePacketAlmostAllCenter.proper_power_below_prime_scale

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualPrimePacketAlmostAllCenter
  let mut axs : NameSet := {}
  for (name, _) in selected do
    let a ← Lean.collectAxioms name
    for x in a do
      axs := axs.insert x
  let axList := axs.toList
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  if selected.isEmpty then throwError "No module constants selected"
  unless axList.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {axList}"
  logInfo m!"Module constants audited, including generated declarations: {selected.length}"
  logInfo m!"Full transitive axiom union: {axList}"
  logInfo "ACTUAL PRIME PACKET ALMOST-ALL-CENTER AXIOM AUDIT PASSED"
