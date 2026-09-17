import BuildingBlocks.MertensPrimeTransfer
import Lean.Util.CollectAxioms

example {N K : ℕ} (hN : 1 ≤ N) (hK : 1 ≤ K) (hKN : K ≤ N)
    {η : ℝ} (hη : 0 ≤ η)
    (hM : ∀ k ∈ Finset.Icc 1 K,
      |(BuildingBlocks.MertensTransfer.mertens (N / k) : ℝ)| ≤ η * ((N : ℝ) / k)) :
    |BuildingBlocks.CoarsePrimitive.psi N - (N : ℝ) + 2 * Real.eulerMascheroniConstant| ≤
      4 * η * N * (1 + Real.log K) ^ 2 + 39 * N / Real.sqrt ((K + 1 : ℕ) : ℝ) :=
  BuildingBlocks.MertensTransfer.primeError_bound_of_Mertens_quotients hN hK hKN hη hM

#print BuildingBlocks.MertensTransfer.mertens
#print BuildingBlocks.MertensTransfer.integerError
#print BuildingBlocks.MertensTransfer.centeredDivisorCoefficient
#print BuildingBlocks.MertensTransfer.centeredMertensPrefix
#check BuildingBlocks.MertensTransfer.smallQuotientSigned_partial_summation
#check BuildingBlocks.MertensTransfer.primeError_Mertens_prefix_remainder
#check BuildingBlocks.MertensTransfer.primeError_bound_of_Mertens_quotients
#print axioms BuildingBlocks.MertensTransfer.primeError_bound_of_Mertens_quotients

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => (`BuildingBlocks).isPrefixOf env.header.moduleNames[idx.toNat]!
  unless !selected.isEmpty do throwError "Empty local audit scope"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do
      Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun a => allowed.contains a) do
    throwError m!"Unexpected transitive axiom: {state.axioms}"
  logInfo m!"FULL_TRANSITIVE_AXIOM_UNION {state.axioms}"
  logInfo m!"AUDITED_LOCAL_CONSTANT_COUNT {selected.length}"
  for (name, _) in selected do logInfo m!"AUDITED {name}"
  for mod in env.header.moduleNames do
    if (`BuildingBlocks).isPrefixOf mod then logInfo m!"LOCAL_MODULE {mod}"
    if (`ArithmeticDynamics).isPrefixOf mod || (`PrimeNumberTheoremAnd).isPrefixOf mod then
      throwError m!"Unexpected research import: {mod}"
