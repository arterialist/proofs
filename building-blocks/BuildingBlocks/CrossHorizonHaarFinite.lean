import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite Haar decomposition and the coarse-mode obstruction

The algebra is first proved for arbitrary real dyadic packets.  The final
definitions instantiate those packets with the exact finite Möbius clock.
There is no asymptotic or RH assertion.
-/

namespace BuildingBlocks.CrossHorizonHaarFinite

open scoped BigOperators

noncomputable section

/-- A balanced packet with exactly `2^k` real leaves. -/
inductive DyadicPacket : ℕ → Type
  | leaf (x : ℝ) : DyadicPacket 0
  | node {k : ℕ} (left right : DyadicPacket k) : DyadicPacket (k + 1)

namespace DyadicPacket

def total : {k : ℕ} → DyadicPacket k → ℝ
  | 0, leaf x => x
  | _ + 1, node left right => total left + total right

def squareEnergy : {k : ℕ} → DyadicPacket k → ℝ
  | 0, leaf x => x ^ 2
  | _ + 1, node left right => squareEnergy left + squareEnergy right

/-- The common cutoff-gauge shift adds `c` to every leaf. -/
def gaugeShift (c : ℝ) : {k : ℕ} → DyadicPacket k → DyadicPacket k
  | 0, leaf x => leaf (x + c)
  | _ + 1, node left right => node (gaugeShift c left) (gaugeShift c right)

/-- All nonconstant, unnormalized Haar coefficients, root first. -/
def haarCoefficients : {k : ℕ} → DyadicPacket k → List ℝ
  | 0, leaf _ => []
  | _ + 1, node left right =>
      (total left - total right) ::
        (haarCoefficients left ++ haarCoefficients right)

/-- Sum of the correctly weighted squares of all nonconstant Haar coefficients. -/
def haarDetailEnergy : {k : ℕ} → DyadicPacket k → ℝ
  | 0, leaf _ => 0
  | k + 1, node left right =>
      (total left - total right) ^ 2 / (2 : ℝ) ^ (k + 1) +
        haarDetailEnergy left + haarDetailEnergy right

/-- Energy of the constant projection. -/
def coarseEnergy {k : ℕ} (p : DyadicPacket k) : ℝ :=
  total p ^ 2 / (2 : ℝ) ^ k

/-- The new Haar energy exposed when two blocks are joined. -/
def rootDetail {k : ℕ} (left right : DyadicPacket k) : ℝ :=
  (total left - total right) ^ 2 / (2 : ℝ) ^ (k + 1)

@[simp] theorem total_node {k : ℕ} (left right : DyadicPacket k) :
    total (.node left right) = total left + total right := rfl

@[simp] theorem squareEnergy_node {k : ℕ} (left right : DyadicPacket k) :
    squareEnergy (.node left right) = squareEnergy left + squareEnergy right := rfl

theorem total_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    total (gaugeShift c p) = total p + (2 : ℝ) ^ k * c := by
  induction p with
  | leaf x => simp [gaugeShift, total]
  | @node k left right ihl ihr =>
      simp only [gaugeShift, total, ihl, ihr, pow_succ]
      ring

/-- Every nonconstant Haar coefficient is exactly gauge invariant. -/
theorem haarCoefficients_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    haarCoefficients (gaugeShift c p) = haarCoefficients p := by
  induction p with
  | leaf x => rfl
  | @node k left right ihl ihr =>
      simp only [gaugeShift, haarCoefficients, total_gaugeShift, ihl, ihr]
      congr 1
      ring

theorem haarDetailEnergy_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    haarDetailEnergy (gaugeShift c p) = haarDetailEnergy p := by
  induction p with
  | leaf x => rfl
  | @node k left right ihl ihr =>
      simp only [gaugeShift, haarDetailEnergy, total_gaugeShift, ihl, ihr]
      congr 1
      ring

/-- Exact unnormalized finite Haar identity. -/
theorem squareEnergy_eq_coarse_add_haar {k : ℕ} (p : DyadicPacket k) :
    squareEnergy p = coarseEnergy p + haarDetailEnergy p := by
  induction p with
  | leaf x => norm_num [squareEnergy, coarseEnergy, haarDetailEnergy, total]
  | @node k left right ihl ihr =>
      rw [squareEnergy_node, ihl, ihr]
      simp only [coarseEnergy, haarDetailEnergy, total_node]
      have hpow : (2 : ℝ) ^ (k + 1) = 2 * (2 : ℝ) ^ k := by ring
      rw [hpow]
      have hn : (2 : ℝ) ^ k ≠ 0 := by positivity
      field_simp
      ring

/-- Joining two blocks transfers only their difference into a new Haar detail;
the parent constant projection remains as the unresolved coarse term. -/
theorem child_coarse_recursion {k : ℕ} (left right : DyadicPacket k) :
    coarseEnergy left + coarseEnergy right =
      coarseEnergy (.node left right) + rootDetail left right := by
  simp only [coarseEnergy, rootDetail, total_node]
  have hpow : (2 : ℝ) ^ (k + 1) = 2 * (2 : ℝ) ^ k := by ring
  rw [hpow]
  have hn : (2 : ℝ) ^ k ≠ 0 := by positivity
  field_simp
  ring

/-- After all nonconstant details are removed, the remainder is exactly the
coarse projection; recursive Haar expansion cannot discard it. -/
theorem coarse_remainder_conserved {k : ℕ} (p : DyadicPacket k) :
    squareEnergy p - haarDetailEnergy p = coarseEnergy p := by
  rw [squareEnergy_eq_coarse_add_haar]
  ring

theorem coarseEnergy_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    coarseEnergy (gaugeShift c p) =
      (total p + (2 : ℝ) ^ k * c) ^ 2 / (2 : ℝ) ^ k := by
  simp [coarseEnergy, total_gaugeShift]

theorem coarseEnergy_nonneg {k : ℕ} (p : DyadicPacket k) :
    0 ≤ coarseEnergy p := by
  unfold coarseEnergy
  positivity

theorem coarseEnergy_eq_zero_iff {k : ℕ} (p : DyadicPacket k) :
    coarseEnergy p = 0 ↔ total p = 0 := by
  unfold coarseEnergy
  have hden : (2 : ℝ) ^ k ≠ 0 := by positivity
  simp [hden]

/-- Construct a dyadic packet from consecutive values of a sequence. -/
def ofSequence : (k : ℕ) → (ℕ → ℝ) → ℕ → DyadicPacket k
  | 0, f, H => .leaf (f H)
  | k + 1, f, H => .node (ofSequence k f H) (ofSequence k f (H + 2 ^ k))

/-- The packet leaves are exactly the literal half-open block
`H ≤ N < H + 2^k`. -/
theorem total_ofSequence (k : ℕ) (f : ℕ → ℝ) (H : ℕ) :
    total (ofSequence k f H) =
      ∑ i ∈ Finset.range (2 ^ k), f (H + i) := by
  induction k generalizing H with
  | zero => simp [ofSequence, total]
  | succ k ih =>
      simp only [ofSequence, total, ih]
      have hp : 2 ^ (k + 1) = 2 ^ k + 2 ^ k := by
        rw [pow_succ]
        omega
      rw [hp, Finset.sum_range_add]
      apply congrArg₂ (· + ·) rfl
      apply Finset.sum_congr rfl
      intro i hi
      congr 1
      omega

end DyadicPacket

/-- Exact finite Möbius clock in its divisor-reversed form. -/
def mobiusClockValue (D T N : ℕ) (q : ℝ) : ℝ :=
  ∑ d ∈ (Finset.Ioo D T).filter (fun d => d ≤ N),
    (ArithmeticFunction.moebius d : ℝ) * (1 - q ^ (N / d))

/-- Consecutive actual Möbius clock values on the literal block
`H ≤ N < H + 2^k`. -/
def mobiusClockPacket (D T H k : ℕ) (q : ℝ) : DyadicPacket k :=
  DyadicPacket.ofSequence k (fun N => mobiusClockValue D T N q) H

/-- A common cutoff gauge cannot alter any nonconstant Haar coefficient of
the actual finite Möbius clock packet. -/
theorem mobiusClock_haar_gauge_invariant
    (D T H k : ℕ) (q c : ℝ) :
    DyadicPacket.haarCoefficients
        (DyadicPacket.gaugeShift c (mobiusClockPacket D T H k q)) =
      DyadicPacket.haarCoefficients (mobiusClockPacket D T H k q) :=
  DyadicPacket.haarCoefficients_gaugeShift _ _

/-- The actual Möbius packet has the same exact finite Haar decomposition. -/
theorem mobiusClock_squareEnergy_decomposition
    (D T H k : ℕ) (q : ℝ) :
    DyadicPacket.squareEnergy (mobiusClockPacket D T H k q) =
      DyadicPacket.coarseEnergy (mobiusClockPacket D T H k q) +
        DyadicPacket.haarDetailEnergy (mobiusClockPacket D T H k q) :=
  DyadicPacket.squareEnergy_eq_coarse_add_haar _

end
end BuildingBlocks.CrossHorizonHaarFinite

#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.haarCoefficients_gaugeShift
#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.haarDetailEnergy_gaugeShift
#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.squareEnergy_eq_coarse_add_haar
#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.child_coarse_recursion
#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.coarse_remainder_conserved
#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.coarseEnergy_eq_zero_iff
#print axioms BuildingBlocks.CrossHorizonHaarFinite.DyadicPacket.total_ofSequence
#print axioms BuildingBlocks.CrossHorizonHaarFinite.mobiusClock_haar_gauge_invariant
#print axioms BuildingBlocks.CrossHorizonHaarFinite.mobiusClock_squareEnergy_decomposition
