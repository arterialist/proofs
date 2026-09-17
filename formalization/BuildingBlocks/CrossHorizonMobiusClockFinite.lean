import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite cross-horizon Möbius clock identities

All sums are finite and use literal window endpoints.  There is no asymptotic
or RH assertion.
-/

namespace BuildingBlocks.CrossHorizonMobiusClockFinite

open scoped BigOperators

noncomputable section

/-- Literal windowed integers `D < d < T` which have reached horizon `N`. -/
def horizonWindow (D T N : ℕ) : Finset ℕ :=
  (Finset.Ioo D T).filter fun d => d ≤ N

/-- Future prefix at slope `a`. -/
def futurePrefix (D T N a : ℕ) : ℝ :=
  ∑ d ∈ horizonWindow D T N,
    if a * d ≤ N then (ArithmeticFunction.moebius d : ℝ) else 0

/-- Finite clock field; slopes beyond `N` vanish when `D≥0` and `d>D`. -/
def clockField (D T N : ℕ) (q : ℝ) : ℝ :=
  (1 - q) * ∑ i ∈ Finset.range N, futurePrefix D T N (i + 1) * q ^ i

lemma finite_geometric_cutoff {N d : ℕ} (hd : 0 < d) (q : ℝ) :
    (1 - q) *
        (∑ i ∈ Finset.range N, if (i + 1) * d ≤ N then q ^ i else 0) =
      1 - q ^ (N / d) := by
  have hfilter : (Finset.range N).filter (fun i => (i + 1) * d ≤ N) =
      Finset.range (N / d) := by
    ext i
    simp only [Finset.mem_filter, Finset.mem_range]
    constructor
    · rintro ⟨hiN, hi⟩
      have : i + 1 ≤ N / d := (Nat.le_div_iff_mul_le hd).2 hi
      omega
    · intro hi
      have hle : i + 1 ≤ N / d := by omega
      have himul : (i + 1) * d ≤ N := (Nat.le_div_iff_mul_le hd).1 hle
      have hdivle : N / d ≤ N := Nat.div_le_self N d
      exact ⟨lt_of_lt_of_le hi hdivle, himul⟩
  rw [← Finset.sum_filter, hfilter]
  have hg := mul_geom_sum q (N / d)
  linarith

/-- Exact finite future-prefix reversal, equation (6). -/
theorem future_prefix_reversal
    {D T N : ℕ} (hD : 0 < D) (q : ℝ) :
    clockField D T N q =
      ∑ d ∈ horizonWindow D T N,
        (ArithmeticFunction.moebius d : ℝ) * (1 - q ^ (N / d)) := by
  classical
  unfold clockField futurePrefix
  have hexpand :
      (1 - q) *
          (∑ x ∈ Finset.range N,
            (∑ d ∈ horizonWindow D T N,
              if (x + 1) * d ≤ N then (ArithmeticFunction.moebius d : ℝ) else 0) * q ^ x) =
        ∑ x ∈ Finset.range N, ∑ d ∈ horizonWindow D T N,
          (1 - q) *
            (if (x + 1) * d ≤ N then (ArithmeticFunction.moebius d : ℝ) else 0) * q ^ x := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro x hx
    rw [Finset.sum_mul, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    split <;> ring
  rw [hexpand, Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro d hdw
  have hdD : D < d := (Finset.mem_filter.mp hdw).1 |> Finset.mem_Ioo.mp |>.1
  have hd : 0 < d := lt_trans hD hdD
  calc
    (∑ x ∈ Finset.range N,
      (1 - q) *
        (if (x + 1) * d ≤ N then (ArithmeticFunction.moebius d : ℝ) else 0) * q ^ x) =
      (ArithmeticFunction.moebius d : ℝ) *
        ((1 - q) * ∑ x ∈ Finset.range N,
          if (x + 1) * d ≤ N then q ^ x else 0) := by
            rw [Finset.mul_sum]
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro x hx
            split <;> ring
    _ = ArithmeticFunction.moebius d * (1 - q ^ (N / d)) := by
      rw [finite_geometric_cutoff hd]

/-- Windowed divisor polynomial appearing in the horizon increment. -/
def divisorPolynomial (D T N : ℕ) (q : ℝ) : ℝ :=
  (1 - q) * ∑ d ∈ Finset.Ioo D T,
    if d ∣ N then
      (ArithmeticFunction.moebius d : ℝ) * q ^ (N / d - 1)
    else 0

/-- Exact floor-step hypothesis isolated for the finite increment.  It is the
pointwise statement that `floor(N/d)` changes exactly when `d∣N`. -/
def FloorStep (N d : ℕ) : Prop :=
  N / d = (N - 1) / d + (if d ∣ N then 1 else 0)

lemma floorStep_of_pos {N d : ℕ} (hN : 0 < N) (hd : 0 < d) : FloorStep N d := by
  unfold FloorStep
  by_cases hdiv : d ∣ N
  · obtain ⟨k, hNk⟩ := hdiv
    subst N
    have hk : 0 < k := by
      by_contra h
      simp at h
      subst k
      simp at hN
    obtain ⟨j, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hk)
    rw [if_pos (dvd_mul_right d (j + 1))]
    rw [Nat.mul_div_cancel_left (j + 1) hd]
    have hpred : (d * (j + 1) - 1) / d = j := by
      apply Nat.div_eq_of_lt_le
      · calc
          j * d = d * j := Nat.mul_comm _ _
          _ ≤ d * j + (d - 1) := Nat.le_add_right _ _
          _ = d * (j + 1) - 1 := by
            rw [Nat.mul_add, Nat.mul_one]
            omega
      · calc
          d * (j + 1) - 1 < d * (j + 1) := Nat.sub_lt (by positivity) (by omega)
          _ = (j + 1) * d := Nat.mul_comm _ _
    rw [hpred]
  · rw [if_neg hdiv]
    let k := N / d
    let r := N % d
    have hrpos : 0 < r := by
      dsimp [r]
      exact Nat.pos_of_ne_zero (by simpa [Nat.dvd_iff_mod_eq_zero] using hdiv)
    have hrlt : r < d := Nat.mod_lt N hd
    have hdecomp : d * k + r = N := Nat.div_add_mod N d
    have hpred : (N - 1) / d = k := by
      apply Nat.div_eq_of_lt_le
      · calc
          k * d = d * k := Nat.mul_comm _ _
          _ ≤ d * k + (r - 1) := Nat.le_add_right _ _
          _ = N - 1 := by omega
      · calc
          N - 1 < d * k + d := by omega
          _ = (k + 1) * d := by ring
    exact hpred.symm

/-- Exact divisor-polynomial increment, equation (7). -/
theorem divisor_polynomial_increment
    {D T N : ℕ} (hD : 0 < D) (hN : 0 < N) (q : ℝ) :
    clockField D T N q - clockField D T (N - 1) q =
      divisorPolynomial D T N q := by
  rw [future_prefix_reversal hD, future_prefix_reversal hD]
  unfold divisorPolynomial horizonWindow
  simp only [Finset.sum_filter]
  rw [← Finset.sum_sub_distrib, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hdw
  have hdI := Finset.mem_Ioo.mp hdw
  have hd : 0 < d := lt_trans hD hdI.1
  have hstep := floorStep_of_pos hN hd
  unfold FloorStep at hstep
  by_cases hdiv : d ∣ N
  · have hdN : d ≤ N := Nat.le_of_dvd hN hdiv
    have hquot : 0 < N / d := Nat.div_pos hdN hd
    by_cases hdEq : d = N
    · subst d
      have hnot : ¬N ≤ N - 1 := by omega
      simp [hnot, hN, Nat.div_self]
      ring
    · have hdPred : d ≤ N - 1 := by omega
      rw [if_pos hdiv] at hstep
      simp only [if_pos hdiv, if_pos hdN, if_pos hdPred]
      rw [hstep]
      have hs : (N - 1) / d + 1 - 1 = (N - 1) / d := by omega
      rw [hs, pow_succ]
      ring
  · have hneq : d ≠ N := fun h => hdiv (h ▸ dvd_rfl)
    have hreach : d ≤ N ↔ d ≤ N - 1 := by omega
    rw [if_neg hdiv] at hstep
    by_cases hdN : d ≤ N
    · have hdPred : d ≤ N - 1 := hreach.mp hdN
      simp only [if_neg hdiv, if_pos hdN, if_pos hdPred, hstep]
      ring
    · have hdPred : ¬d ≤ N - 1 := fun h => hdN (le_trans h (Nat.sub_le N 1))
      simp [hdiv, hdN, hdPred]

/-- Scalar version of the exact energy coboundary (8). -/
theorem scalar_energy_coboundary (Gprev Δ : ℝ) :
    (Gprev + Δ) ^ 2 - Gprev ^ 2 = 2 * Gprev * Δ + Δ ^ 2 := by ring

/-- Finite Abel identity for an energy sequence and tail weights. -/
theorem finite_energy_abel (E v : ℕ → ℝ) (M : ℕ) :
    (∑ n ∈ Finset.range (M + 1), (v n - v (n + 1)) * E n) =
      v 0 * E 0 +
        ∑ n ∈ Finset.range M, v (n + 1) * (E (n + 1) - E n) -
          v (M + 1) * E M := by
  induction M with
  | zero => simp; ring
  | succ M ih =>
      rw [Finset.sum_range_succ, ih, Finset.sum_range_succ]
      ring

/-- Finite positive-increment bound.  Negative energy increments telescope
for free, exactly as in the finite form of equation (12). -/
theorem finite_abel_bound_by_positive_increments
    (E v : ℕ → ℝ) (M : ℕ)
    (hE0 : E 0 = 0)
    (hE : ∀ n, 0 ≤ E n)
    (hv : ∀ n, 0 ≤ v n) :
    (∑ n ∈ Finset.range (M + 1), (v n - v (n + 1)) * E n) ≤
      ∑ n ∈ Finset.range M, v (n + 1) * max (E (n + 1) - E n) 0 := by
  rw [finite_energy_abel, hE0, mul_zero, zero_add]
  have hend : -v (M + 1) * E M ≤ 0 := by
    have hp : 0 ≤ v (M + 1) * E M := mul_nonneg (hv _) (hE _)
    nlinarith
  have hsum :
      (∑ n ∈ Finset.range M, v (n + 1) * (E (n + 1) - E n)) ≤
        ∑ n ∈ Finset.range M, v (n + 1) * max (E (n + 1) - E n) 0 := by
    apply Finset.sum_le_sum
    intro n hn
    exact mul_le_mul_of_nonneg_left (le_max_left _ _) (hv _)
  linarith

end
end BuildingBlocks.CrossHorizonMobiusClockFinite

#print axioms BuildingBlocks.CrossHorizonMobiusClockFinite.future_prefix_reversal
#print axioms BuildingBlocks.CrossHorizonMobiusClockFinite.floorStep_of_pos
#print axioms BuildingBlocks.CrossHorizonMobiusClockFinite.divisor_polynomial_increment
#print axioms BuildingBlocks.CrossHorizonMobiusClockFinite.scalar_energy_coboundary
#print axioms BuildingBlocks.CrossHorizonMobiusClockFinite.finite_energy_abel
#print axioms BuildingBlocks.CrossHorizonMobiusClockFinite.finite_abel_bound_by_positive_increments
