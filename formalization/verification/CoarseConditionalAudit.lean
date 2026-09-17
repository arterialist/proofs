import BuildingBlocks.CoarsePrimitiveCriterion
import Lean.Util.CollectAxioms

example : BuildingBlocks.Target = RiemannHypothesis := rfl

example (hb : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ k : ℕ,
    BuildingBlocks.CoarsePrimitive.coarsePrimitiveSquare ((2 : ℝ) ^ k) ≤
      C * ((2 : ℝ) ^ k) ^ (4 + ε)) : RiemannHypothesis :=
  BuildingBlocks.CoarsePrimitive.target_of_coarsePrimitiveBound hb

#print BuildingBlocks.CoarsePrimitive.CoarsePrimitiveBound
#print BuildingBlocks.Target
#print RiemannHypothesis
#print BuildingBlocks.CoarsePrimitive.target_of_coarsePrimitiveBound
#print axioms BuildingBlocks.CoarsePrimitive.target_of_coarsePrimitiveBound

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
  for (name, _) in selected do
    logInfo m!"AUDITED {name}"
  for mod in env.header.moduleNames do
    if (`BuildingBlocks).isPrefixOf mod then logInfo m!"LOCAL_MODULE {mod}"
    if (`ArithmeticDynamics).isPrefixOf mod || (`PrimeNumberTheoremAnd).isPrefixOf mod then
      throwError m!"Unexpected research dependency: {mod}"
