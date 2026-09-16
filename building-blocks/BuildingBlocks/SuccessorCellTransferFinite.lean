import Mathlib.Data.Nat.Init
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Tactic

/-!
# Finite successor-cell dilation transfer

On physical values of logarithmic successor cells, a left translation
by log d reads the parent value at r / d. The cutoff is the
rightmost cell label N. This file proves the exact finite
multiplicative semigroup and child-interval laws. It makes no claim
about the signed gamma, pole, or full Weil forms.
-/

namespace BuildingBlocks.SuccessorCellTransferFinite

/-- Physical cell values after a left translation by log d,
    with zero extension beyond the finite window. A physical
    cell vector has value zero at index 0. -/
def transfer {R : Type*} [Zero R] (N d : ℕ) (z : ℕ → R) (r : ℕ) : R :=
  if r ≤ N then z (r / d) else 0

theorem transfer_apply_of_le {R : Type*} [Zero R]
    {N d r : ℕ} (z : ℕ → R) (hr : r ≤ N) :
    transfer N d z r = z (r / d) := by
  simp [transfer, hr]

theorem transfer_apply_of_gt {R : Type*} [Zero R]
    {N d r : ℕ} (z : ℕ → R) (hr : N < r) :
    transfer N d z r = 0 := by
  simp [transfer, Nat.not_le.mpr hr]

/-- Integer dilation refines one successor cell into precisely the
    consecutive indices d*n, ..., d*(n+1)-1. -/
theorem div_eq_iff_child {d n r : ℕ} (hd : 0 < d) :
    r / d = n ↔ d * n ≤ r ∧ r < d * (n + 1) := by
  constructor
  · intro h
    constructor
    · have hle : n ≤ r / d := by omega
      have := (Nat.le_div_iff_mul_le hd).mp hle
      simpa [mul_comm] using this
    · have hlt : r / d < n + 1 := by omega
      have := (Nat.div_lt_iff_lt_mul hd).mp hlt
      simpa [mul_comm] using this
  · rintro ⟨hlo, hhi⟩
    have hle : n ≤ r / d :=
      (Nat.le_div_iff_mul_le hd).mpr (by simpa [mul_comm] using hlo)
    have hlt : r / d < n + 1 :=
      (Nat.div_lt_iff_lt_mul hd).mpr (by simpa [mul_comm] using hhi)
    omega

theorem transfer_child {R : Type*} [Zero R]
    {N d n r : ℕ} (z : ℕ → R) (hd : 0 < d) (hr : r ≤ N)
    (hlo : d * n ≤ r) (hhi : r < d * (n + 1)) :
    transfer N d z r = z n := by
  rw [transfer_apply_of_le z hr, (div_eq_iff_child hd).mpr ⟨hlo, hhi⟩]

/-- Cutoff does not disrupt composition of left dilations: no
    state discarded beyond N can return under another dilation. -/
theorem transfer_mul {R : Type*} [Zero R]
    (N a b : ℕ) (z : ℕ → R) :
    transfer N a (transfer N b z) = transfer N (a * b) z := by
  funext r
  by_cases hr : r ≤ N
  · have hdiv : r / a ≤ N := (Nat.div_le_self r a).trans hr
    simp [transfer, hr, hdiv, Nat.div_div_eq_div_mul]
  · simp [transfer, hr]

theorem transfer_comm {R : Type*} [Zero R]
    (N a b : ℕ) (z : ℕ → R) :
    transfer N a (transfer N b z) =
      transfer N b (transfer N a z) := by
  rw [transfer_mul, transfer_mul, mul_comm]

theorem transfer_one {R : Type*} [Zero R]
    (N : ℕ) (z : ℕ → R) (r : ℕ) :
    transfer N 1 z r = if r ≤ N then z r else 0 := by
  simp [transfer]

theorem transfer_zero_of_large {R : Type*} [Zero R]
    (N d : ℕ) (z : ℕ → R) (hz : z 0 = 0) (hd : N < d) :
    transfer N d z = 0 := by
  funext r
  by_cases hr : r ≤ N
  · have hrd : r < d := hr.trans_lt hd
    simp [transfer, hr, Nat.div_eq_of_lt hrd, hz]
  · simp [transfer, hr]

/-- A real sign gauge on physical successor-cell values. -/
def signGauge (χ z : ℕ → ℝ) (r : ℕ) : ℝ := χ r * z r

/-- The exact carry defect of a sign gauge and one finite dilation. -/
theorem signGauge_transfer_defect (N d r : ℕ) (χ z : ℕ → ℝ)
    (hr : r ≤ N) :
    signGauge χ (transfer N d (signGauge χ z)) r -
      χ d * transfer N d z r =
      (χ r * χ (r / d) - χ d) * z (r / d) := by
  simp [signGauge, transfer, hr]
  ring

/-- Complete multiplicativity and a unit sign erase the carry defect
    at an exact multiple. The nonmultiple children remain separate. -/
theorem signGauge_transfer_exact_multiple (N d n : ℕ) (χ z : ℕ → ℝ)
    (hd : 0 < d) (hn : d * n ≤ N)
    (hmul : χ (d * n) = χ d * χ n)
    (hsquare : χ n * χ n = 1) :
    signGauge χ (transfer N d (signGauge χ z)) (d * n) -
      χ d * transfer N d z (d * n) = 0 := by
  rw [signGauge_transfer_defect N d (d * n) χ z hn,
    Nat.mul_div_cancel_left n hd, hmul]
  calc
    ((χ d * χ n) * χ n - χ d) * z n =
        (χ d * (χ n * χ n - 1)) * z n := by ring
    _ = 0 := by rw [hsquare]; ring

/-- The sign that flips the prime 2, on positive integer labels. -/
def primeTwoGauge (n : ℕ) : ℝ := (-1) ^ padicValNat 2 n

theorem primeTwoGauge_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) :
    primeTwoGauge (a * b) = primeTwoGauge a * primeTwoGauge b := by
  haveI : Fact (Nat.Prime 2) := ⟨by norm_num⟩
  simp [primeTwoGauge, padicValNat.mul ha hb, pow_add]

theorem primeTwoGauge_odd {n : ℕ} (hn : n % 2 = 1) :
    primeTwoGauge n = 1 := by
  have hnot : ¬ 2 ∣ n := by
    intro h
    omega
  simp [primeTwoGauge, padicValNat.eq_zero_of_not_dvd hnot]

theorem primeTwoGauge_two_mul {n : ℕ} (hn : n % 2 = 1) :
    primeTwoGauge (2 * n) = -1 := by
  haveI : Fact (Nat.Prime 2) := ⟨by norm_num⟩
  have hnot : ¬ 2 ∣ n := by
    intro h
    omega
  have hn0 : n ≠ 0 := by omega
  rw [primeTwoGauge, padicValNat.mul (by omega : (2 : ℕ) ≠ 0) hn0,
    padicValNat.self (by omega : 1 < (2 : ℕ)),
    padicValNat.eq_zero_of_not_dvd hnot]
  norm_num

/-- At an odd parent, the nondivisor successor child `2*n+1`
    retains a defect of exactly twice the physical parent value. -/
theorem primeTwoGauge_carry (N n : ℕ) (z : ℕ → ℝ)
    (hn : n % 2 = 1) (hN : 2 * n + 1 ≤ N) :
    signGauge primeTwoGauge
        (transfer N 2 (signGauge primeTwoGauge z)) (2 * n + 1) -
      primeTwoGauge 2 * transfer N 2 z (2 * n + 1) = 2 * z n := by
  have hdiv : (2 * n + 1) / 2 = n := by omega
  rw [signGauge_transfer_defect N 2 (2 * n + 1) primeTwoGauge z hN,
    hdiv, primeTwoGauge_odd hn,
    primeTwoGauge_odd (show (2 * n + 1) % 2 = 1 by omega)]
  have htwo : primeTwoGauge 2 = -1 := by
    simpa using primeTwoGauge_two_mul (n := 1) (by norm_num)
  rw [htwo]
  ring

#print axioms div_eq_iff_child
#print axioms transfer_child
#print axioms transfer_mul
#print axioms transfer_comm
#print axioms transfer_zero_of_large
#print axioms signGauge_transfer_defect
#print axioms signGauge_transfer_exact_multiple
#print axioms primeTwoGauge_mul
#print axioms primeTwoGauge_carry

end BuildingBlocks.SuccessorCellTransferFinite
