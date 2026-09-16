import BuildingBlocks.GoldbachHeatDerivative
import BuildingBlocks.GoldbachHeatInitialTrace

open Real Set

namespace BuildingBlocks.GoldbachHeat

noncomputable def criticalHeatProfileDerivative (v : ℝ) : ℝ :=
  -(exp (-v / 2) * mixedCenteredHeat (exp (-v))) / 2 -
    exp (-v / 2) * exp (-v) * mixedCenteredHeatDerivative (exp (-v))

theorem criticalHeatProfile_hasDerivAt (v : ℝ) :
    HasDerivAt criticalHeatProfile (criticalHeatProfileDerivative v) v := by
  have hi := (hasDerivAt_id v).neg.exp
  have ho := ((hasDerivAt_id v).neg.div_const 2).exp
  have hh := (mixedCenteredHeat_hasDerivAt (exp_pos (-v))).comp v hi
  convert ho.mul hh using 1
  unfold criticalHeatProfileDerivative
  simp only [id_eq, Pi.neg_apply, Function.comp_apply]
  ring

theorem criticalHeatProfile_continuous (v : ℝ) : ContinuousAt criticalHeatProfile v :=
  (criticalHeatProfile_hasDerivAt v).continuousAt

theorem criticalHeatProfileDerivative_continuous : Continuous criticalHeatProfileDerivative := by
  apply continuous_iff_continuousAt.mpr
  intro v
  have ht : 0 < exp (-v) / 2 := by positivity
  have hc : ContinuousAt mixedCenteredHeatDerivative (exp (-v)) :=
    (mixedCenteredHeatDerivative_continuousOn_Ici ht).continuousAt
      (Ici_mem_nhds (by linarith [exp_pos (-v)] : exp (-v) / 2 < exp (-v)))
  have hi : ContinuousAt (fun v : ℝ => exp (-v)) v := continuousAt_id.neg.rexp
  have hh : ContinuousAt (fun v : ℝ => mixedCenteredHeatDerivative (exp (-v))) v :=
    ContinuousAt.comp (f := fun v : ℝ => exp (-v)) (g := mixedCenteredHeatDerivative) hc hi
  have ho : ContinuousAt (fun v : ℝ => exp (-v / 2)) v :=
    (continuousAt_id.neg.div_const 2).rexp
  change ContinuousAt (fun v : ℝ =>
    -(exp (-v / 2) * mixedCenteredHeat (exp (-v))) / 2 -
      exp (-v / 2) * exp (-v) * mixedCenteredHeatDerivative (exp (-v))) v
  exact ((criticalHeatProfile_continuous v).neg.div_const 2).sub ((ho.mul hi).mul hh)

#print axioms criticalHeatProfile_hasDerivAt
#print axioms criticalHeatProfile_continuous
#print axioms criticalHeatProfileDerivative_continuous

end BuildingBlocks.GoldbachHeat
