import Mathlib.Data.Nat.Init
import Mathlib.Data.Nat.Log
import Mathlib.Analysis.SpecialFunctions.Log.Basic
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

/-- For opposite log-2 collars, a right child `r` of left parent
    `1` lies in the intersection of the two integer intervals. -/
theorem collar_child_iff (m d r : ℕ) (hd : 0 < d) :
    (m ≤ r ∧ r < 2 * m ∧ r / d = 1) ↔
      max m d ≤ r ∧ r < min (2 * m) (2 * d) := by
  constructor
  · rintro ⟨hm, h2m, hdiv⟩
    have hchild := (div_eq_iff_child (d := d) (n := 1) (r := r) hd).mp hdiv
    constructor <;> omega
  · rintro ⟨hlo, hhi⟩
    have hdiv : r / d = 1 :=
      (div_eq_iff_child (d := d) (n := 1) (r := r) hd).mpr (by
        constructor <;> omega)
    exact ⟨by omega, by omega, hdiv⟩

/-- The triangular collar overlap is nonempty exactly for
    `m/2 < d < 2*m`, written without division. -/
theorem collar_child_exists_iff (m d : ℕ) (hm : 0 < m) (hd : 0 < d) :
    (∃ r, m ≤ r ∧ r < 2 * m ∧ r / d = 1) ↔
      m < 2 * d ∧ d < 2 * m := by
  constructor
  · rintro ⟨r, hmle, h2m, hdiv⟩
    have hchild := (div_eq_iff_child (d := d) (n := 1) (r := r) hd).mp hdiv
    omega
  · rintro ⟨hmd, hdm⟩
    rcases le_total m d with hle | hle
    · refine ⟨d, hle, hdm, ?_⟩
      apply (div_eq_iff_child (d := d) (n := 1) (r := d) hd).mpr
      constructor <;> omega
    · refine ⟨m, le_refl m, by omega, ?_⟩
      apply (div_eq_iff_child (d := d) (n := 1) (r := m) hd).mpr
      constructor <;> omega

/-- Logarithmic successor-cell lengths telescope on every finite
    integer interval, including the exact lower and upper endpoints. -/
theorem sum_log_cell_length (a b : ℕ) (ha : 0 < a) (hab : a ≤ b) :
    (∑ r ∈ Finset.Ico a b,
      Real.log (((r + 1 : ℕ) : ℝ) / (r : ℝ))) =
      Real.log ((b : ℝ) / (a : ℝ)) := by
  have htel : ∀ b : ℕ, a ≤ b →
      (∑ r ∈ Finset.Ico a b,
        (Real.log ((r + 1 : ℕ) : ℝ) - Real.log (r : ℝ))) =
        Real.log (b : ℝ) - Real.log (a : ℝ) := by
    intro b hb
    induction b, hb using Nat.le_induction with
    | base => simp
    | succ b hb ih =>
      rw [Finset.sum_Ico_succ_top hb, ih]
      push_cast
      ring
  calc
    (∑ r ∈ Finset.Ico a b,
        Real.log (((r + 1 : ℕ) : ℝ) / (r : ℝ))) =
      ∑ r ∈ Finset.Ico a b,
        (Real.log ((r + 1 : ℕ) : ℝ) - Real.log (r : ℝ)) := by
        apply Finset.sum_congr rfl
        intro r hr
        have hrpos : 0 < r := lt_of_lt_of_le ha (Finset.mem_Ico.mp hr).1
        rw [Real.log_div (by positivity) (by exact_mod_cast (Nat.ne_of_gt hrpos))]
    _ = Real.log (b : ℝ) - Real.log (a : ℝ) := htel b hab
    _ = Real.log ((b : ℝ) / (a : ℝ)) := by
      rw [Real.log_div (by exact_mod_cast (Nat.ne_of_gt (lt_of_lt_of_le ha hab)))
        (by exact_mod_cast (Nat.ne_of_gt ha))]

/-- The exact cell-length weight in the two opposite log-2 collars. -/
noncomputable def collarWeight (m d : ℕ) : ℝ :=
  ∑ r ∈ Finset.Ico (max m d) (min (2 * m) (2 * d)),
    Real.log (((r + 1 : ℕ) : ℝ) / (r : ℝ))

/-- The geometric overlap weight is exactly the sum over successor
    children of the first opposite collar cell. -/
theorem collarWeight_eq_child_filter (m d : ℕ) (hd : 0 < d) :
    collarWeight m d =
      ∑ r ∈ (Finset.Ico m (2 * m)).filter (fun r => r / d = 1),
        Real.log (((r + 1 : ℕ) : ℝ) / (r : ℝ)) := by
  have hset : (Finset.Ico m (2 * m)).filter (fun r => r / d = 1) =
      Finset.Ico (max m d) (min (2 * m) (2 * d)) := by
    ext r
    simpa only [Finset.mem_filter, Finset.mem_Ico, and_assoc] using
      (collar_child_iff m d r hd)
  simp only [collarWeight, hset]

theorem collarWeight_lower_band (m d : ℕ) (hm : 0 < m)
    (hdm : d < m) (hmd : m < 2 * d) :
    collarWeight m d = Real.log (((2 * d : ℕ) : ℝ) / (m : ℝ)) := by
  have hmax : max m d = m := max_eq_left (by omega)
  have hmin : min (2 * m) (2 * d) = 2 * d := min_eq_right (by omega)
  simp only [collarWeight, hmax, hmin]
  exact sum_log_cell_length m (2 * d) hm (by omega)

theorem collarWeight_upper_band (m d : ℕ) (hd : 0 < d)
    (hmd : m ≤ d) (hdm : d < 2 * m) :
    collarWeight m d = Real.log (((2 * m : ℕ) : ℝ) / (d : ℝ)) := by
  have hmax : max m d = d := max_eq_right hmd
  have hmin : min (2 * m) (2 * d) = 2 * m := min_eq_left (by omega)
  simp only [collarWeight, hmax, hmin]
  exact sum_log_cell_length d (2 * m) hd (by omega)

theorem collarWeight_zero_outside (m d : ℕ)
    (h : 2 * d ≤ m ∨ 2 * m ≤ d) : collarWeight m d = 0 := by
  have hle : min (2 * m) (2 * d) ≤ max m d := by
    rcases h with h | h <;> omega
  unfold collarWeight
  rw [Finset.Ico_eq_empty_of_le hle]
  simp

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

/-- The additive carry relation for doubling forces a multiplicative
    unit sign to be trivial once the ninth cell is present. -/
theorem multiplicative_sign_rigidity (N : ℕ) (χ : ℕ → ℝ)
    (hN : 9 ≤ N) (hone : χ 1 = 1)
    (hsquare : ∀ n, 0 < n → χ n * χ n = 1)
    (hmul : ∀ a b, 0 < a → 0 < b → χ (a * b) = χ a * χ b)
    (hcarry : ∀ r, 2 ≤ r → r ≤ N → χ r * χ (r / 2) = χ 2) :
    ∀ n, 0 < n → n ≤ N → χ n = 1 := by
  have h9 : χ 9 * χ 4 = χ 2 := by
    simpa using hcarry 9 (by omega) hN
  have hχ9 : χ 9 = 1 := by
    simpa [hmul 3 3 (by omega) (by omega)] using hsquare 3 (by omega)
  have hχ4 : χ 4 = 1 := by
    simpa [hmul 2 2 (by omega) (by omega)] using hsquare 2 (by omega)
  have hχ2 : χ 2 = 1 := by simpa [hχ9, hχ4] using h9.symm
  intro n
  induction n using Nat.strong_induction_on with
  | h n ih =>
    intro hnpos hnN
    by_cases hn1 : n = 1
    · simpa [hn1] using hone
    have hn2 : 2 ≤ n := by omega
    have hkpos : 0 < n / 2 := by omega
    have hklt : n / 2 < n := by omega
    have hkN : n / 2 ≤ N := by omega
    have hk : χ (n / 2) = 1 := ih (n / 2) hklt hkpos hkN
    by_cases heven : n % 2 = 0
    · have hrep : n = 2 * (n / 2) := by omega
      rw [hrep, hmul 2 (n / 2) (by omega) hkpos, hχ2, hk]
      ring
    · have hc := hcarry n hn2 hnN
      simpa [hk, hχ2] using hc

/-- Any nontrivial multiplicative sign in the finite window must
    have a nonzero successor carry coefficient. -/
theorem multiplicative_sign_defect_exists (N : ℕ) (χ : ℕ → ℝ)
    (hN : 9 ≤ N) (hone : χ 1 = 1)
    (hsquare : ∀ n, 0 < n → χ n * χ n = 1)
    (hmul : ∀ a b, 0 < a → 0 < b → χ (a * b) = χ a * χ b)
    (hnontrivial : ∃ n, 0 < n ∧ n ≤ N ∧ χ n ≠ 1) :
    ∃ r, 2 ≤ r ∧ r ≤ N ∧ χ r * χ (r / 2) ≠ χ 2 := by
  by_contra hnot
  have hcarry : ∀ r, 2 ≤ r → r ≤ N → χ r * χ (r / 2) = χ 2 := by
    intro r hr2 hrN
    by_contra hne
    exact hnot ⟨r, hr2, hrN, hne⟩
  obtain ⟨n, hnpos, hnN, hne⟩ := hnontrivial
  exact hne (multiplicative_sign_rigidity N χ hN hone hsquare hmul hcarry
    n hnpos hnN)

/-- Hence an exact phase conjugacy of the dense doubling transfer,
    tested on every physical vector, admits only the trivial sign. -/
theorem signGauge_transfer_conjugacy_rigid (N : ℕ) (χ : ℕ → ℝ)
    (hN : 9 ≤ N) (hone : χ 1 = 1)
    (hsquare : ∀ n, 0 < n → χ n * χ n = 1)
    (hmul : ∀ a b, 0 < a → 0 < b → χ (a * b) = χ a * χ b)
    (hconj : ∀ z : ℕ → ℝ, z 0 = 0 → ∀ r, r ≤ N →
      signGauge χ (transfer N 2 (signGauge χ z)) r =
        χ 2 * transfer N 2 z r) :
    ∀ n, 0 < n → n ≤ N → χ n = 1 := by
  apply multiplicative_sign_rigidity N χ hN hone hsquare hmul
  intro r hr2 hrN
  let z : ℕ → ℝ := fun k => if k = 0 then 0 else 1
  have hz : z 0 = 0 := by simp [z]
  have hc := hconj z hz r hrN
  have hd := signGauge_transfer_defect N 2 r χ z hrN
  rw [hc, sub_self] at hd
  have hdiv : r / 2 ≠ 0 := by omega
  simp [z, hdiv] at hd
  linarith

/-- A global multiplicative sign showing that the ninth-cell cutoff
    in the rigidity theorem cannot be lowered to eight. -/
def twoThreeGauge (n : ℕ) : ℝ :=
  (-1) ^ (padicValNat 2 n + padicValNat 3 n)

theorem twoThreeGauge_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) :
    twoThreeGauge (a * b) = twoThreeGauge a * twoThreeGauge b := by
  haveI : Fact (Nat.Prime 2) := ⟨by norm_num⟩
  haveI : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  simp [twoThreeGauge, padicValNat.mul ha hb, pow_add]
  ring

private theorem twoThreeGauge_one : twoThreeGauge 1 = 1 := by
  simp [twoThreeGauge]

private theorem twoThreeGauge_two : twoThreeGauge 2 = -1 := by
  have h : padicValNat 3 2 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  simp [twoThreeGauge, h]

private theorem twoThreeGauge_three : twoThreeGauge 3 = -1 := by
  have h : padicValNat 2 3 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  simp [twoThreeGauge, h]

private theorem twoThreeGauge_five : twoThreeGauge 5 = 1 := by
  have h2 : padicValNat 2 5 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  have h3 : padicValNat 3 5 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  simp [twoThreeGauge, h2, h3]

private theorem twoThreeGauge_seven : twoThreeGauge 7 = 1 := by
  have h2 : padicValNat 2 7 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  have h3 : padicValNat 3 7 = 0 :=
    padicValNat.eq_zero_of_not_dvd (by norm_num)
  simp [twoThreeGauge, h2, h3]

private theorem twoThreeGauge_four : twoThreeGauge 4 = 1 := by
  simpa [twoThreeGauge_two] using
    twoThreeGauge_mul (a := 2) (b := 2) (by norm_num) (by norm_num)

private theorem twoThreeGauge_six : twoThreeGauge 6 = 1 := by
  simpa [twoThreeGauge_two, twoThreeGauge_three] using
    twoThreeGauge_mul (a := 2) (b := 3) (by norm_num) (by norm_num)

private theorem twoThreeGauge_eight : twoThreeGauge 8 = -1 := by
  simpa [twoThreeGauge_two, twoThreeGauge_four] using
    twoThreeGauge_mul (a := 2) (b := 4) (by norm_num) (by norm_num)

private theorem twoThreeGauge_nine : twoThreeGauge 9 = 1 := by
  simpa [twoThreeGauge_three] using
    twoThreeGauge_mul (a := 3) (b := 3) (by norm_num) (by norm_num)

theorem twoThreeGauge_carry_through_eight (r : ℕ)
    (hr2 : 2 ≤ r) (hr8 : r ≤ 8) :
    twoThreeGauge r * twoThreeGauge (r / 2) = twoThreeGauge 2 := by
  interval_cases r <;> norm_num [twoThreeGauge_one, twoThreeGauge_two,
    twoThreeGauge_three, twoThreeGauge_four, twoThreeGauge_five,
    twoThreeGauge_six, twoThreeGauge_seven, twoThreeGauge_eight]

/-- The nontrivial sign really does conjugate the *whole* doubling
    transfer through eight cells on vectors zero at index zero. -/
theorem twoThreeGauge_transfer_conjugacy_eight (z : ℕ → ℝ)
    (hz : z 0 = 0) :
    signGauge twoThreeGauge (transfer 8 2 (signGauge twoThreeGauge z)) =
      fun r => twoThreeGauge 2 * transfer 8 2 z r := by
  funext r
  by_cases hr : r ≤ 8
  · have hd := signGauge_transfer_defect 8 2 r twoThreeGauge z hr
    by_cases hr2 : 2 ≤ r
    · rw [twoThreeGauge_carry_through_eight r hr2 hr,
        sub_self, zero_mul] at hd
      exact sub_eq_zero.mp hd
    · have hdiv : r / 2 = 0 := by omega
      rw [hdiv, hz, mul_zero] at hd
      exact sub_eq_zero.mp hd
  · simp [signGauge, transfer, hr]

theorem twoThreeGauge_fails_at_nine :
    twoThreeGauge 9 * twoThreeGauge (9 / 2) ≠ twoThreeGauge 2 := by
  norm_num [twoThreeGauge_nine, twoThreeGauge_four, twoThreeGauge_two]

/-- Binary-tree depth gives a phase adapted to successor children,
    rather than to exact multiplicative divisor states. -/
def treeTwoGauge (n : ℕ) : ℝ := (-1) ^ Nat.log 2 n

theorem treeTwoGauge_child (r : ℕ) (hr : 2 ≤ r) :
    treeTwoGauge r * treeTwoGauge (r / 2) = -1 := by
  have hlogpos : 0 < Nat.log 2 r :=
    Nat.log_pos Nat.one_lt_two hr
  have hdepth : Nat.log 2 r = Nat.log 2 (r / 2) + 1 := by
    rw [Nat.log_div_base]
    exact (Nat.sub_add_cancel hlogpos).symm
  rw [treeTwoGauge, treeTwoGauge, hdepth, pow_succ]
  have hsquare : (-1 : ℝ) ^ Nat.log 2 (r / 2) *
      (-1 : ℝ) ^ Nat.log 2 (r / 2) = 1 := by
    calc
      (-1 : ℝ) ^ Nat.log 2 (r / 2) * (-1 : ℝ) ^ Nat.log 2 (r / 2) =
          ((-1 : ℝ) * (-1)) ^ Nat.log 2 (r / 2) :=
            (mul_pow _ _ _).symm
      _ = 1 := by norm_num
  nlinarith [hsquare]

/-- The depth phase assigns the expected sign to every power of
    the doubling shift, retaining all proper powers of the prime 2. -/
theorem treeTwoGauge_pow_child (k r : ℕ) (hr : 2 ^ k ≤ r) :
    treeTwoGauge r * treeTwoGauge (r / 2 ^ k) = (-1 : ℝ) ^ k := by
  have hklog : k ≤ Nat.log 2 r :=
    Nat.le_log_of_pow_le Nat.one_lt_two hr
  have hdepth : Nat.log 2 r = Nat.log 2 (r / 2 ^ k) + k := by
    rw [Nat.log_div_base_pow]
    omega
  rw [treeTwoGauge, treeTwoGauge, hdepth, pow_add]
  have hsquare : (-1 : ℝ) ^ Nat.log 2 (r / 2 ^ k) *
      (-1 : ℝ) ^ Nat.log 2 (r / 2 ^ k) = 1 := by
    calc
      (-1 : ℝ) ^ Nat.log 2 (r / 2 ^ k) * (-1 : ℝ) ^ Nat.log 2 (r / 2 ^ k) =
          ((-1 : ℝ) * (-1)) ^ Nat.log 2 (r / 2 ^ k) :=
            (mul_pow _ _ _).symm
      _ = 1 := by norm_num
  calc
    (-1 : ℝ) ^ Nat.log 2 (r / 2 ^ k) * (-1) ^ k *
        (-1) ^ Nat.log 2 (r / 2 ^ k) =
      (-1 : ℝ) ^ k *
        ((-1) ^ Nat.log 2 (r / 2 ^ k) *
          (-1) ^ Nat.log 2 (r / 2 ^ k)) := by ring
    _ = (-1 : ℝ) ^ k := by rw [hsquare]; ring

theorem treeTwoGauge_transfer_two_pow (N k : ℕ) (z : ℕ → ℝ)
    (hz : z 0 = 0) :
    signGauge treeTwoGauge
        (transfer N (2 ^ k) (signGauge treeTwoGauge z)) =
      fun r => (-1 : ℝ) ^ k * transfer N (2 ^ k) z r := by
  funext r
  by_cases hrN : r ≤ N
  · by_cases hrk : 2 ^ k ≤ r
    · have hphase := treeTwoGauge_pow_child k r hrk
      simp only [signGauge, transfer, if_pos hrN]
      calc
        treeTwoGauge r * (treeTwoGauge (r / 2 ^ k) * z (r / 2 ^ k)) =
            (treeTwoGauge r * treeTwoGauge (r / 2 ^ k)) * z (r / 2 ^ k) := by ring
        _ = (-1 : ℝ) ^ k * z (r / 2 ^ k) := by rw [hphase]
    · have hdiv : r / 2 ^ k = 0 := Nat.div_eq_of_lt (by omega)
      simp [signGauge, transfer, hrN, hdiv, hz]
  · simp [signGauge, transfer, hrN]

/-- A nonmultiplicative depth phase exactly reverses the dense
    doubling transfer on every finite successor-cell window. -/
theorem treeTwoGauge_transfer_two (N : ℕ) (z : ℕ → ℝ) (hz : z 0 = 0) :
    signGauge treeTwoGauge (transfer N 2 (signGauge treeTwoGauge z)) =
      fun r => -transfer N 2 z r := by
  funext r
  by_cases hr : r ≤ N
  · by_cases hr2 : 2 ≤ r
    · have hdiv := signGauge_transfer_defect N 2 r treeTwoGauge z hr
      have hsign : treeTwoGauge 2 = -1 := by norm_num [treeTwoGauge]
      rw [hsign, treeTwoGauge_child r hr2, sub_self, zero_mul] at hdiv
      linarith
    · have hq : r / 2 = 0 := by omega
      simp [signGauge, transfer, hr, hq, hz]
  · simp [signGauge, transfer, hr]

/-- Simultaneous scalar sign phases for the dense 2- and 3-shifts
    are already forced to be trivial by the fourth successor cell.
    No multiplicativity assumption on the phase is used. -/
theorem two_three_sign_phase_rigidity (N : ℕ) (χ : ℕ → ℝ)
    (s₂ s₃ : ℝ) (hN : 4 ≤ N) (hone : χ 1 = 1)
    (hsquare_two : χ 2 * χ 2 = 1)
    (h₂ : ∀ r, 2 ≤ r → r ≤ N → χ r * χ (r / 2) = s₂)
    (h₃ : ∀ r, 3 ≤ r → r ≤ N → χ r * χ (r / 3) = s₃) :
    s₂ = 1 ∧ s₃ = 1 ∧ ∀ n, 0 < n → n ≤ N → χ n = 1 := by
  have hχ2 : χ 2 = s₂ := by
    simpa [hone] using h₂ 2 (by omega) (by omega)
  have hχ3 : χ 3 = s₂ := by
    simpa [hone] using h₂ 3 (by omega) (by omega)
  have hs32 : s₃ = s₂ := by
    simpa [hχ3, hone] using (h₃ 3 (by omega) (by omega)).symm
  have hsquare : s₂ * s₂ = 1 := by simpa [hχ2] using hsquare_two
  have hχ4_mul : χ 4 * s₂ = s₂ := by
    simpa [hχ2] using h₂ 4 (by omega) hN
  have hχ4 : χ 4 = 1 := by
    calc
      χ 4 = χ 4 * (s₂ * s₂) := by rw [hsquare]; ring
      _ = (χ 4 * s₂) * s₂ := by ring
      _ = s₂ * s₂ := by rw [hχ4_mul]
      _ = 1 := hsquare
  have hs3one : s₃ = 1 := by
    simpa [hχ4, hone] using (h₃ 4 (by omega) hN).symm
  have hs2one : s₂ = 1 := hs32.symm.trans hs3one
  refine ⟨hs2one, hs3one, ?_⟩
  intro n
  induction n using Nat.strong_induction_on with
  | h n ih =>
    intro hnpos hnN
    by_cases hn1 : n = 1
    · simpa [hn1] using hone
    have hn2 : 2 ≤ n := by omega
    have hkpos : 0 < n / 2 := by omega
    have hklt : n / 2 < n := by omega
    have hkN : n / 2 ≤ N := by omega
    have hk : χ (n / 2) = 1 := ih (n / 2) hklt hkpos hkN
    simpa [hk, hs2one] using h₂ n hn2 hnN

/-- Testing an exact scalar conjugacy on a physical vector equal to
    one at all positive labels extracts its entrywise phase law. -/
theorem phase_relation_of_transfer_conjugacy (N d r : ℕ)
    (χ : ℕ → ℝ) (s : ℝ) (hd : 0 < d) (hrd : d ≤ r) (hrN : r ≤ N)
    (hconj : ∀ z : ℕ → ℝ, z 0 = 0 → ∀ q, q ≤ N →
      signGauge χ (transfer N d (signGauge χ z)) q =
        s * transfer N d z q) :
    χ r * χ (r / d) = s := by
  let z : ℕ → ℝ := fun k => if k = 0 then 0 else 1
  have hz : z 0 = 0 := by simp [z]
  have hdiv : r / d ≠ 0 := by
    exact Nat.ne_of_gt (Nat.div_pos hrd hd)
  have h := hconj z hz r hrN
  simpa [signGauge, transfer, hrN, z, hdiv, mul_assoc] using h

/-- Therefore the two complete prime shifts already exclude every
    nontrivial scalar diagonal sign gauge from the fourth cell. -/
theorem two_three_operator_phase_rigidity (N : ℕ) (χ : ℕ → ℝ)
    (s₂ s₃ : ℝ) (hN : 4 ≤ N) (hone : χ 1 = 1)
    (hsquare_two : χ 2 * χ 2 = 1)
    (hconj₂ : ∀ z : ℕ → ℝ, z 0 = 0 → ∀ r, r ≤ N →
      signGauge χ (transfer N 2 (signGauge χ z)) r =
        s₂ * transfer N 2 z r)
    (hconj₃ : ∀ z : ℕ → ℝ, z 0 = 0 → ∀ r, r ≤ N →
      signGauge χ (transfer N 3 (signGauge χ z)) r =
        s₃ * transfer N 3 z r) :
    s₂ = 1 ∧ s₃ = 1 ∧ ∀ n, 0 < n → n ≤ N → χ n = 1 := by
  apply two_three_sign_phase_rigidity N χ s₂ s₃ hN hone hsquare_two
  · intro r hr2 hrN
    exact phase_relation_of_transfer_conjugacy N 2 r χ s₂
      (by omega) hr2 hrN hconj₂
  · intro r hr3 hrN
    exact phase_relation_of_transfer_conjugacy N 3 r χ s₃
      (by omega) hr3 hrN hconj₃

/-- The same fourth-cell obstruction holds for arbitrary nonzero
    complex phase gauges when conjugacy uses the inverse phase. -/
theorem two_three_complex_phase_rigidity (N : ℕ) (χ : ℕ → ℂ)
    (s₂ s₃ : ℂ) (hN : 4 ≤ N) (hone : χ 1 = 1)
    (hχ2 : χ 2 ≠ 0)
    (h₂ : ∀ r, 2 ≤ r → r ≤ N → χ r = s₂ * χ (r / 2))
    (h₃ : ∀ r, 3 ≤ r → r ≤ N → χ r = s₃ * χ (r / 3)) :
    s₂ = 1 ∧ s₃ = 1 ∧ ∀ n, 0 < n → n ≤ N → χ n = 1 := by
  have h2val : χ 2 = s₂ := by
    simpa [hone] using h₂ 2 (by omega) (by omega)
  have h3val : χ 3 = s₂ := by
    simpa [hone] using h₂ 3 (by omega) (by omega)
  have hs32 : s₃ = s₂ := by
    simpa [h3val, hone] using (h₃ 3 (by omega) (by omega)).symm
  have h4two : χ 4 = s₂ * s₂ := by
    simpa [h2val] using h₂ 4 (by omega) hN
  have h4three : χ 4 = s₃ := by
    simpa [hone] using h₃ 4 (by omega) hN
  have hss : s₂ * s₂ = s₂ := by
    calc
      s₂ * s₂ = χ 4 := h4two.symm
      _ = s₃ := h4three
      _ = s₂ := hs32
  have hs2ne : s₂ ≠ 0 := by simpa [h2val] using hχ2
  have hs2one : s₂ = 1 := by
    have hzero : s₂ * (s₂ - 1) = 0 := by
      calc
        s₂ * (s₂ - 1) = s₂ * s₂ - s₂ := by ring
        _ = 0 := sub_eq_zero.mpr hss
    exact sub_eq_zero.mp ((mul_eq_zero.mp hzero).resolve_left hs2ne)
  have hs3one : s₃ = 1 := hs32.trans hs2one
  refine ⟨hs2one, hs3one, ?_⟩
  intro n
  induction n using Nat.strong_induction_on with
  | h n ih =>
    intro hnpos hnN
    by_cases hn1 : n = 1
    · simpa [hn1] using hone
    have hn2 : 2 ≤ n := by omega
    have hkpos : 0 < n / 2 := by omega
    have hklt : n / 2 < n := by omega
    have hkN : n / 2 ≤ N := by omega
    have hk : χ (n / 2) = 1 := ih (n / 2) hklt hkpos hkN
    simpa [hs2one, hk] using h₂ n hn2 hnN

#print axioms div_eq_iff_child
#print axioms collar_child_iff
#print axioms collar_child_exists_iff
#print axioms sum_log_cell_length
#print axioms collarWeight_eq_child_filter
#print axioms collarWeight_lower_band
#print axioms collarWeight_upper_band
#print axioms collarWeight_zero_outside
#print axioms transfer_child
#print axioms transfer_mul
#print axioms transfer_comm
#print axioms transfer_zero_of_large
#print axioms signGauge_transfer_defect
#print axioms signGauge_transfer_exact_multiple
#print axioms primeTwoGauge_mul
#print axioms primeTwoGauge_carry
#print axioms multiplicative_sign_rigidity
#print axioms multiplicative_sign_defect_exists
#print axioms signGauge_transfer_conjugacy_rigid
#print axioms twoThreeGauge_mul
#print axioms twoThreeGauge_carry_through_eight
#print axioms twoThreeGauge_transfer_conjugacy_eight
#print axioms twoThreeGauge_fails_at_nine
#print axioms treeTwoGauge_child
#print axioms treeTwoGauge_pow_child
#print axioms treeTwoGauge_transfer_two
#print axioms treeTwoGauge_transfer_two_pow
#print axioms two_three_sign_phase_rigidity
#print axioms phase_relation_of_transfer_conjugacy
#print axioms two_three_operator_phase_rigidity
#print axioms two_three_complex_phase_rigidity

end BuildingBlocks.SuccessorCellTransferFinite
