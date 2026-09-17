import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Tactic

/-!
# Finite stabilization of the odd Möbius convolution

The arithmetic theorem assumes precisely that every nonzero Möbius divisor
of the given integer has entered the cutoff packet.  The companion written
audit proves this hypothesis for `n < p` and the primorial below `p`.
-/

namespace BuildingBlocks.StableOddMobiusPrefixFinite

noncomputable section

def oddMoebius (n : ℕ) : ℤ :=
  if Odd n then ArithmeticFunction.moebius n else 0

def cutoffCoefficient (D n : ℕ) : ℤ :=
  ∑ d ∈ n.divisors,
    if d ∣ D then ArithmeticFunction.moebius d * oddMoebius (n / d) else 0

def stableCoefficient (n : ℕ) : ℤ :=
  ∑ d ∈ n.divisors,
    ArithmeticFunction.moebius d * oddMoebius (n / d)

def primorialBelow (p : ℕ) : ℕ :=
  ∏ q ∈ (Finset.range p).filter Nat.Prime, q

/-- Once every nonzero Möbius divisor of `n` lies in the packet, the
cutoff convolution agrees with the full odd Möbius convolution. -/
theorem cutoff_eq_stable (D n : ℕ)
    (h : ∀ d ∈ n.divisors,
      ArithmeticFunction.moebius d ≠ 0 → d ∣ D) :
    cutoffCoefficient D n = stableCoefficient n := by
  unfold cutoffCoefficient stableCoefficient
  apply Finset.sum_congr rfl
  intro d hd
  by_cases hz : ArithmeticFunction.moebius d = 0
  · simp [hz]
  · simp [h d hd hz]

/-- A squarefree divisor of a positive integer below `p` is contained
in the actual product of all primes below `p`. -/
theorem squarefree_divisor_dvd_primorialBelow
    (p n d : ℕ) (hn0 : n ≠ 0) (hnp : n < p)
    (hdn : d ∣ n) (hs : Squarefree d) :
    d ∣ primorialBelow p := by
  rw [← Nat.prod_primeFactors_of_squarefree hs]
  unfold primorialBelow
  apply Finset.prod_dvd_prod_of_subset
  intro q hq
  have hqd : q ∣ d := Nat.dvd_of_mem_primeFactors hq
  have hqn : q ∣ n := hqd.trans hdn
  have hqp : q < p :=
    lt_of_le_of_lt (Nat.le_of_dvd (Nat.pos_of_ne_zero hn0) hqn) hnp
  simp [hqp, Nat.prime_of_mem_primeFactors hq]

/-- Literal primorial stabilization at every positive `n < p`. -/
theorem cutoff_primorialBelow_eq_stable
    (p n : ℕ) (hn0 : n ≠ 0) (hnp : n < p) :
    cutoffCoefficient (primorialBelow p) n = stableCoefficient n := by
  apply cutoff_eq_stable
  intro d hd hμ
  have hdn : d ∣ n := (Nat.mem_divisors.mp hd).1
  have hs : Squarefree d := ArithmeticFunction.moebius_ne_zero_iff_squarefree.mp hμ
  exact squarefree_divisor_dvd_primorialBelow p n d hn0 hnp hdn hs

/-- At a newly admitted odd prime, the old packet has only its unit
divisor available, so the endpoint coefficient is `-1`, not the
stabilized coefficient `-2`. -/
theorem cutoff_prime (D p : ℕ) (hp : Nat.Prime p)
    (hodd : Odd p) (hnew : ¬p ∣ D) :
    cutoffCoefficient D p = -1 := by
  rw [cutoffCoefficient, hp.divisors]
  have h1p : (1 : ℕ) ∉ ({p} : Finset ℕ) := by simp [hp.ne_one.symm]
  rw [Finset.sum_insert h1p, Finset.sum_singleton]
  simp [hnew, oddMoebius, hodd,
    ArithmeticFunction.moebius_apply_prime hp]

theorem stable_prime (p : ℕ) (hp : Nat.Prime p) (hodd : Odd p) :
    stableCoefficient p = -2 := by
  rw [stableCoefficient, hp.divisors]
  have h1p : (1 : ℕ) ∉ ({p} : Finset ℕ) := by simp [hp.ne_one.symm]
  rw [Finset.sum_insert h1p, Finset.sum_singleton]
  simp [oddMoebius, hodd, Nat.div_self hp.pos,
    ArithmeticFunction.moebius_apply_prime hp]

end
end BuildingBlocks.StableOddMobiusPrefixFinite

#print axioms BuildingBlocks.StableOddMobiusPrefixFinite.cutoff_eq_stable
#print axioms BuildingBlocks.StableOddMobiusPrefixFinite.squarefree_divisor_dvd_primorialBelow
#print axioms BuildingBlocks.StableOddMobiusPrefixFinite.cutoff_primorialBelow_eq_stable
#print axioms BuildingBlocks.StableOddMobiusPrefixFinite.cutoff_prime
#print axioms BuildingBlocks.StableOddMobiusPrefixFinite.stable_prime
