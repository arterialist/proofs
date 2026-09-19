import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import BuildingBlocks.ChirpedSpectralRHBridge

/-!
# Chirped Archimedean-Prime Row Margin and Arithmetic Lower Bound Construction

This module formalizes the derivation of the positive logarithmic arithmetic lower bound
`ChirpedArithmeticLowerBound Q_arith a` required by `ChirpedSpectralRHBridge.lean`.

In the chirped wavepacket constellation program (e.g. `chirped-critical-span-constellation.md`),
the arithmetic evaluation of the Weil quadratic form splits as:
  `Q_arith(T) = Q_arch(T) - Q_prime(T)`
where:
1. The archimedean digamma term provides a universal positive diagonal loading:
   `Q_arch(T) ≥ log(T / (2π)) - C_arch = log T - (log(2π) + C_arch)`.
2. The complete prime-power cross-correlation sum is bounded by a geometric row budget:
   `Q_prime(T) ≤ C_geom * exp(-B / 2) * log T + C_row`
   where `B` is the constellation buffer parameter.
3. The net difference satisfies:
   `Q_arith(T) ≥ (1 - C_geom * exp(-B / 2)) * log T - C_tot`.

This module proves:
- For any geometric constant `C_geom > 0` and buffer parameter `B > 2 * log C_geom`,
  the prime-row decay factor satisfies `C_geom * exp(-B / 2) < 1`.
- The net logarithmic margin `c0 := 1 - C_geom * exp(-B / 2)` is strictly positive.
- Setting the target arithmetic margin `a := c0 / 2 > 0`, the residual `(c0 - a) * log T`
  diverges to `+∞`, absorbing the constant remainder `C_tot`.
- Consequently, `a * log T ≤ Q_arith(T)` holds eventually as `T → +∞`, rigorously producing
  the hypothesis `ChirpedArithmeticLowerBound Q_arith a`.

All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.ChirpedArithmeticArchimedeanMargin

open Filter
open Topology
open BuildingBlocks.ChirpedSpectralRHBridge

/-- For any geometric row constant C_geom > 0 and buffer parameter B > 2 * log C_geom,
the prime-power cross term coefficient C_geom * exp(-B / 2) is strictly less than 1. -/
theorem buffer_decay_lt_one {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    C_geom * Real.exp (-B / 2) < 1 := by
  have hB2 : Real.log C_geom < B / 2 := by linarith
  have hneg : -B / 2 < - Real.log C_geom := by linarith
  have hexp : Real.exp (-B / 2) < Real.exp (- Real.log C_geom) := Real.exp_lt_exp.mpr hneg
  rw [Real.exp_neg, Real.exp_log hC] at hexp
  calc
    C_geom * Real.exp (-B / 2) < C_geom * (C_geom⁻¹) := mul_lt_mul_of_pos_left hexp hC
    _ = 1 := mul_inv_cancel₀ (ne_of_gt hC)

/-- Net logarithmic margin coefficient after subtracting the prime row budget from the
archimedean digamma term. -/
noncomputable def netMarginCoeff (C_geom B : ℝ) : ℝ :=
  1 - C_geom * Real.exp (-B / 2)

/-- Strict positivity of the net arithmetic margin coefficient. -/
theorem net_arithmetic_margin_pos {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    0 < netMarginCoeff C_geom B := by
  dsimp [netMarginCoeff]
  have hlt := buffer_decay_lt_one hC hB
  linarith

/-- The net margin coefficient is bounded above by 1. -/
theorem net_arithmetic_margin_le_one {C_geom B : ℝ} (hC : 0 ≤ C_geom) :
    netMarginCoeff C_geom B ≤ 1 := by
  dsimp [netMarginCoeff]
  have hpos : 0 ≤ C_geom * Real.exp (-B / 2) := mul_nonneg hC (le_of_lt (Real.exp_pos _))
  linarith

/-- Canonical target arithmetic margin chosen as half of the net margin coefficient. -/
noncomputable def targetMarginCoeff (C_geom B : ℝ) : ℝ :=
  (netMarginCoeff C_geom B) / 2

/-- Strict positivity of the target arithmetic margin. -/
theorem targetMarginCoeff_pos {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    0 < targetMarginCoeff C_geom B := by
  dsimp [targetMarginCoeff]
  have hpos : 0 < netMarginCoeff C_geom B := net_arithmetic_margin_pos hC hB
  linarith

/-- The target arithmetic margin is strictly less than the full net margin coefficient. -/
theorem targetMarginCoeff_lt_net {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    targetMarginCoeff C_geom B < netMarginCoeff C_geom B := by
  dsimp [targetMarginCoeff]
  have hnet : 0 < netMarginCoeff C_geom B := net_arithmetic_margin_pos hC hB
  linarith

/-- For any target margin a < c0 and constant C_tot, the logarithmic term (c0 - a) * log T
eventually dominates C_tot, ensuring a * log T ≤ c0 * log T - C_tot for large T. -/
theorem log_sub_margin_eventual {c0 a C_tot : ℝ} (ha : a < c0) :
    ∀ᶠ (T : ℝ) in atTop, a * Real.log T ≤ c0 * Real.log T - C_tot := by
  have hdiff : 0 < c0 - a := by linarith
  have htend : Tendsto (fun T : ℝ => (c0 - a) * Real.log T) atTop atTop :=
    Tendsto.const_mul_atTop hdiff Real.tendsto_log_atTop
  have hevt : ∀ᶠ (T : ℝ) in atTop, C_tot ≤ (c0 - a) * Real.log T :=
    (tendsto_atTop.mp htend) C_tot
  filter_upwards [hevt] with T hT
  linarith

/-- Derivation of the arithmetic lower bound hypothesis `ChirpedArithmeticLowerBound Q_arith a`
from the archimedean-prime row budget. -/
theorem chirped_arithmetic_lower_bound_of_budget
    {Q_arith : ℝ → ℝ} {C_geom B C_tot : ℝ}
    (hC : 0 < C_geom) (hB : 2 * Real.log C_geom < B)
    (hbudget : ∀ᶠ (T : ℝ) in atTop,
      (netMarginCoeff C_geom B) * Real.log T - C_tot ≤ Q_arith T) :
    ChirpedArithmeticLowerBound Q_arith (targetMarginCoeff C_geom B) := by
  have hlt := targetMarginCoeff_lt_net hC hB
  have hdom := log_sub_margin_eventual (c0 := netMarginCoeff C_geom B)
    (a := targetMarginCoeff C_geom B) (C_tot := C_tot) hlt
  filter_upwards [hdom, hbudget] with T hTdom hTbud
  exact hTdom.trans hTbud

/-- Structure bundling the arithmetic margin certificate. -/
structure ChirpedArithmeticMarginCertificate (Q_arith : ℝ → ℝ) (C_geom B C_tot : ℝ) where
  hC : 0 < C_geom
  hB : 2 * Real.log C_geom < B
  hbudget : ∀ᶠ (T : ℝ) in atTop,
    (netMarginCoeff C_geom B) * Real.log T - C_tot ≤ Q_arith T
  a : ℝ
  ha_pos : 0 < a
  hlower : ChirpedArithmeticLowerBound Q_arith a

/-- Canonical construction of an arithmetic margin certificate. -/
noncomputable def makeArithmeticMarginCertificate {Q_arith : ℝ → ℝ} {C_geom B C_tot : ℝ}
    (hC : 0 < C_geom) (hB : 2 * Real.log C_geom < B)
    (hbudget : ∀ᶠ (T : ℝ) in atTop,
      (netMarginCoeff C_geom B) * Real.log T - C_tot ≤ Q_arith T) :
    ChirpedArithmeticMarginCertificate Q_arith C_geom B C_tot where
  hC := hC
  hB := hB
  hbudget := hbudget
  a := targetMarginCoeff C_geom B
  ha_pos := targetMarginCoeff_pos hC hB
  hlower := chirped_arithmetic_lower_bound_of_budget hC hB hbudget

end BuildingBlocks.ChirpedArithmeticArchimedeanMargin

#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.buffer_decay_lt_one
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.net_arithmetic_margin_pos
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.net_arithmetic_margin_le_one
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.targetMarginCoeff_pos
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.targetMarginCoeff_lt_net
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.log_sub_margin_eventual
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.chirped_arithmetic_lower_bound_of_budget
#print axioms BuildingBlocks.ChirpedArithmeticArchimedeanMargin.makeArithmeticMarginCertificate
