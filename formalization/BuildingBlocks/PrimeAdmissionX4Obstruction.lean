import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction
import BuildingBlocks.KappaCoefficientPositivity
import BuildingBlocks.LargestPrimeSquarefreePackets
import BuildingBlocks.PrimeAdmissionEnergyFlux

/-!
# The finite `X = 4` prime-admission obstruction

This file certifies only the finite example.  Positivity of the full affine
Gram is consumed through an explicit lower bound by its literal `a=b=1`
term.  No estimate uniform in `X` is asserted.
-/

namespace BuildingBlocks.PrimeAdmissionX4Obstruction

open scoped BigOperators
open BuildingBlocks.KappaCoefficientPositivity
open BuildingBlocks.LargestPrimeSquarefreePackets

/-- The two evaluated hard endpoints in the reviewed `X=4` example. -/
def D4 : ℕ := 2
def T4 : ℕ := 6

/-- The strict bulk interval. -/
def bulk4 : Finset ℕ := Finset.Ioo D4 T4

lemma D4_eq : D4 = 2 := rfl
lemma T4_eq : T4 = 6 := rfl

lemma bulk4_eq : bulk4 = {3, 4, 5} := by decide

lemma moebius_three : ArithmeticFunction.moebius 3 = -1 :=
  ArithmeticFunction.moebius_apply_prime (by norm_num)

lemma moebius_five : ArithmeticFunction.moebius 5 = -1 :=
  ArithmeticFunction.moebius_apply_prime (by norm_num)

lemma moebius_four : ArithmeticFunction.moebius 4 = 0 := by
  apply ArithmeticFunction.moebius_eq_zero_of_not_squarefree
  intro hsf
  have hu := hsf 2 (by norm_num : 2 * 2 ∣ 4)
  norm_num [Nat.isUnit_iff] at hu

/-- The actual nonzero squarefree support in the bulk. -/
def squarefreeBulk4 : Finset ℕ := squarefreeInterval 3 5

lemma squarefreeBulk4_eq : squarefreeBulk4 = {3, 5} := by
  have h4 : ¬ Squarefree 4 := by
    intro hsf
    have hu := hsf 2 (by norm_num : 2 * 2 ∣ 4)
    norm_num [Nat.isUnit_iff] at hu
  ext n
  simp only [squarefreeBulk4, squarefreeInterval, Finset.mem_filter,
    Finset.mem_Icc, Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨⟨h3, h5⟩, hsf, hn1⟩
    interval_cases n <;> simp_all
  · intro h
    rcases h with rfl | rfl
    · exact ⟨⟨by norm_num, by norm_num⟩,
        (by exact (by norm_num : Nat.Prime 3).squarefree), by norm_num⟩
    · exact ⟨⟨by norm_num, by norm_num⟩,
        (by exact (by norm_num : Nat.Prime 5).squarefree), by norm_num⟩

/-- The supplied largest-prime labels on the two-point squarefree support. -/
def largest4 (d : ℕ) : ℕ := if d = 3 then 3 else 5

lemma quotientPacket_three :
    quotientPacket squarefreeBulk4 largest4 3 = {1} := by
  rw [squarefreeBulk4_eq]
  decide

lemma quotientPacket_five :
    quotientPacket squarefreeBulk4 largest4 5 = {1} := by
  rw [squarefreeBulk4_eq]
  decide

/-- No bulk coefficient has yet been admitted. -/
def stage0 (_d : ℕ) : ℤ := 0

/-- The coefficient after admitting the largest-prime layer `3`. -/
def stage1 (d : ℕ) : ℤ :=
  if d = 3 then ArithmeticFunction.moebius d else 0

/-- The coefficient after admitting both nonempty layers `3` and `5`. -/
def stage2 (d : ℕ) : ℤ :=
  if d = 3 ∨ d = 5 then ArithmeticFunction.moebius d else 0

/-- Finite affine Gram energy of a coefficient vector on the literal bulk. -/
def gramEnergy (G : ℕ → ℕ → ℝ) (c : ℕ → ℤ) : ℝ :=
  ∑ d ∈ bulk4, ∑ e ∈ bulk4, (c d : ℝ) * (c e : ℝ) * G d e

/-- First and second prime-admission energy increments. -/
def firstFlux (G : ℕ → ℕ → ℝ) : ℝ :=
  gramEnergy G stage1 - gramEnergy G stage0

def secondFlux (G : ℕ → ℕ → ℝ) : ℝ :=
  gramEnergy G stage2 - gramEnergy G stage1

lemma stage0_energy (G : ℕ → ℕ → ℝ) : gramEnergy G stage0 = 0 := by
  simp [gramEnergy, stage0]

lemma stage1_energy (G : ℕ → ℕ → ℝ) : gramEnergy G stage1 = G 3 3 := by
  unfold gramEnergy
  rw [bulk4_eq]
  simp [stage1, moebius_three]

lemma stage2_energy (G : ℕ → ℕ → ℝ) (hsymm : G 5 3 = G 3 5) :
    gramEnergy G stage2 = G 3 3 + G 5 5 + 2 * G 3 5 := by
  unfold gramEnergy
  rw [bulk4_eq]
  simp [stage2, moebius_three, moebius_five]
  linarith

lemma firstFlux_eq (G : ℕ → ℕ → ℝ) : firstFlux G = G 3 3 := by
  rw [firstFlux, stage1_energy, stage0_energy, sub_zero]

lemma secondFlux_eq (G : ℕ → ℕ → ℝ) (hsymm : G 5 3 = G 3 5) :
    secondFlux G = G 5 5 + 2 * G 3 5 := by
  rw [secondFlux, stage2_energy G hsymm, stage1_energy]
  ring

/-- The literal positive `a=b=1` summand of the exact `X=4` affine kernel. -/
noncomputable def literalKernelTerm (d e : ℕ) : ℝ :=
  kappa 0 * Real.exp (-(Nat.max d e : ℝ) / 2)

lemma literalKernelTerm_pos (d e : ℕ) : 0 < literalKernelTerm d e := by
  unfold literalKernelTerm
  exact mul_pos (kappa_pos 0) (Real.exp_pos _)

/-- Explicit affine-Gram hypothesis used below: symmetry and domination by
its retained positive `a=b=1` kernel term on the finite bulk. -/
structure PositiveAffineGram4 (G : ℕ → ℕ → ℝ) : Prop where
  symmetric : ∀ d e, d ∈ bulk4 → e ∈ bulk4 → G d e = G e d
  literal_le : ∀ d e, d ∈ bulk4 → e ∈ bulk4 → literalKernelTerm d e ≤ G d e

lemma gram_entry_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G)
    {d e : ℕ} (hd : d ∈ bulk4) (he : e ∈ bulk4) :
    0 < G d e :=
  lt_of_lt_of_le (literalKernelTerm_pos d e) (hG.literal_le d e hd he)

/-- The first actual admission has strictly positive energy flux. -/
theorem first_packet_flux_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G) :
    0 < firstFlux G := by
  rw [firstFlux_eq]
  apply gram_entry_pos hG
  · rw [bulk4_eq]
    simp
  · rw [bulk4_eq]
    simp

/-- The second actual admission also has strictly positive energy flux. -/
theorem second_packet_flux_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G) :
    0 < secondFlux G := by
  have hsymm : G 5 3 = G 3 5 := by
    apply hG.symmetric
    all_goals rw [bulk4_eq] <;> simp
  rw [secondFlux_eq G hsymm]
  have h55 : 0 < G 5 5 := by
    apply gram_entry_pos hG <;> rw [bulk4_eq] <;> simp
  have h35 : 0 < G 3 5 := by
    apply gram_entry_pos hG <;> rw [bulk4_eq] <;> simp
  linarith

/-- Even the cross-only part of the second admission is positive. -/
theorem second_packet_cross_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G) :
    0 < 2 * G 3 5 := by
  have h35 : 0 < G 3 5 := by
    apply gram_entry_pos hG <;> rw [bulk4_eq] <;> simp
  positivity

end BuildingBlocks.PrimeAdmissionX4Obstruction

#print axioms BuildingBlocks.PrimeAdmissionX4Obstruction.moebius_four
#print axioms BuildingBlocks.PrimeAdmissionX4Obstruction.quotientPacket_three
#print axioms BuildingBlocks.PrimeAdmissionX4Obstruction.first_packet_flux_pos
#print axioms BuildingBlocks.PrimeAdmissionX4Obstruction.second_packet_flux_pos
#print axioms BuildingBlocks.PrimeAdmissionX4Obstruction.second_packet_cross_pos
