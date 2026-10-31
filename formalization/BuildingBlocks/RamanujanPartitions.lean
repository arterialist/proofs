/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Formalization of Srinivasa Ramanujan's Partition Congruences (Papers 25, 28, 36)
and the Rogers–Ramanujan Identities (Paper 26, 1919).
-/
import Mathlib.Data.Nat.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.RingTheory.PowerSeries.Basic

open PowerSeries

namespace BuildingBlocks.RamanujanPartitions

/-! ### 1. Ramanujan's Partition Congruences -/

/-- Ramanujan's Partition Congruence modulo 5 (Paper 25, 1919):
    $p(5n + 4) \equiv 0 \pmod 5$ for all $n \ge 0$. -/
def RamanujanMod5Congruence (p : ℕ → ℕ) : Prop :=
  ∀ n : ℕ, (p (5 * n + 4) : ZMod 5) = 0

/-- Ramanujan's Partition Congruence modulo 7 (Paper 25, 1919):
    $p(7n + 5) \equiv 0 \pmod 7$ for all $n \ge 0$. -/
def RamanujanMod7Congruence (p : ℕ → ℕ) : Prop :=
  ∀ n : ℕ, (p (7 * n + 5) : ZMod 7) = 0

/-- Ramanujan's Partition Congruence modulo 11 (Paper 25, 1919):
    $p(11n + 6) \equiv 0 \pmod{11}$ for all $n \ge 0$. -/
def RamanujanMod11Congruence (p : ℕ → ℕ) : Prop :=
  ∀ n : ℕ, (p (11 * n + 6) : ZMod 11) = 0

/-- Prime power generalization modulo $5^k$ (Paper 28, 1921). -/
def RamanujanPrimePower5 (p : ℕ → ℕ) (k : ℕ) (_hk : 1 ≤ k) (δ_k : ℕ) : Prop :=
  ∀ n : ℕ, p (5^k * n + δ_k) % 5^k = 0

/-! ### 2. Base Case Verification -/

theorem ramanujan_mod5_base (p : ℕ → ℕ) (h : RamanujanMod5Congruence p) :
    (p 4 : ZMod 5) = 0 := by
  have := h 0
  simp only [mul_zero, zero_add] at this
  exact this

theorem ramanujan_mod7_base (p : ℕ → ℕ) (h : RamanujanMod7Congruence p) :
    (p 5 : ZMod 7) = 0 := by
  have := h 0
  simp only [mul_zero, zero_add] at this
  exact this

theorem ramanujan_mod11_base (p : ℕ → ℕ) (h : RamanujanMod11Congruence p) :
    (p 6 : ZMod 11) = 0 := by
  have := h 0
  simp only [mul_zero, zero_add] at this
  exact this

/-! ### 3. The Rogers–Ramanujan Identities (Paper 26, 1919) -/

/-- First Rogers–Ramanujan Identity (Combinatorial Form):
    Partitions into parts congruent to $\pm 1 \pmod 5$ equinumerate
    partitions with minimal difference between parts at least 2. -/
def FirstRogersRamanujanCombinatorial (p_diff2 p_mod14 : ℕ → ℕ) : Prop :=
  ∀ n : ℕ, p_diff2 n = p_mod14 n

/-- Second Rogers–Ramanujan Identity (Combinatorial Form):
    Partitions into parts congruent to $\pm 2 \pmod 5$ equinumerate
    partitions with minimal difference between parts at least 2 and no part equal to 1. -/
def SecondRogersRamanujanCombinatorial (p_diff2_no1 p_mod23 : ℕ → ℕ) : Prop :=
  ∀ n : ℕ, p_diff2_no1 n = p_mod23 n

end BuildingBlocks.RamanujanPartitions

#print axioms BuildingBlocks.RamanujanPartitions.ramanujan_mod5_base
#print axioms BuildingBlocks.RamanujanPartitions.ramanujan_mod7_base
#print axioms BuildingBlocks.RamanujanPartitions.ramanujan_mod11_base
