import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Nat.Basic
import Lean.Elab.Tactic.Omega

open scoped BigOperators

namespace BuildingBlocks.RenewalRod

/-- A genuine proper division rod, with its exact natural quotient. -/
structure DivisionRod where
  left : ℕ
  right : ℕ
  left_pos : 0 < left
  proper : left < right
  divides : left ∣ right

def DivisionRod.ratio (r : DivisionRod) : ℕ := r.right / r.left

/-- The exact quotient recovers the right endpoint on multiplication. -/
theorem DivisionRod.ratio_mul_left (r : DivisionRod) :
    r.ratio * r.left = r.right := by
  exact Nat.div_mul_cancel r.divides

/-- Proper divisibility forces the right endpoint to cover twice the left. -/
theorem DivisionRod.two_mul_left_le (r : DivisionRod) :
    2 * r.left ≤ r.right := by
  obtain ⟨k, hk⟩ := r.divides
  have hk2 : 2 ≤ k := by
    by_contra h
    have hk1 : k ≤ 1 := by omega
    have hm := Nat.mul_le_mul_left r.left hk1
    simp only [Nat.mul_one] at hm
    have hp := r.proper
    omega
  have hm := Nat.mul_le_mul_left r.left hk2
  omega

/-- Useful for degree stabilization: a proper rod's endpoint is at most twice its gap. -/
theorem DivisionRod.right_le_two_mul_gap (r : DivisionRod) :
    r.right ≤ 2 * (r.right - r.left) := by
  have h := r.two_mul_left_le
  omega

/-- A nonempty ordered prefix has quotient product no larger than its last endpoint. -/
theorem ordered_prefix_product_le_last
    (rods : ℕ → DivisionRod) (n : ℕ)
    (hsep : ∀ i < n, (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range (n + 1), (rods i).ratio) ≤ (rods n).right := by
  induction n with
  | zero =>
      simpa [DivisionRod.ratio] using Nat.div_le_self (rods 0).right (rods 0).left
  | succ n ih =>
      have hp : (∏ i ∈ Finset.range (n + 1), (rods i).ratio) ≤ (rods n).right :=
        ih (fun i hi => hsep i (by omega))
      have hleft : (∏ i ∈ Finset.range (n + 1), (rods i).ratio) ≤
          (rods (n + 1)).left := le_trans hp (Nat.le_of_lt (hsep n (by omega)))
      rw [Finset.prod_range_succ]
      calc
        (∏ i ∈ Finset.range (n + 1), (rods i).ratio) * (rods (n + 1)).ratio
            ≤ (rods (n + 1)).left * (rods (n + 1)).ratio :=
          Nat.mul_le_mul_right _ hleft
        _ = (rods (n + 1)).right := by
          simpa [Nat.mul_comm] using (rods (n + 1)).ratio_mul_left

/-- Ordered proper division rods below `N` have exact quotient product at most `N`.
The empty family has product `1`, covered by the explicit assumption `1 ≤ N`. -/
theorem ordered_division_product_le
    (rods : ℕ → DivisionRod) (length N : ℕ) (hN : 1 ≤ N)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left)
    (hbound : ∀ i < length, (rods i).right ≤ N) :
    (∏ i ∈ Finset.range length, (rods i).right / (rods i).left) ≤ N := by
  cases length with
  | zero => simpa using hN
  | succ n =>
      have hp := ordered_prefix_product_le_last rods n
        (fun i hi => hsep i (by omega))
      exact le_trans hp (hbound n (by omega))

/-- Exact quotient multiplication turns its excess over one into the rod gap. -/
theorem DivisionRod.left_mul_ratio_sub_one (r : DivisionRod) :
    r.left * (r.ratio - 1) = r.right - r.left := by
  rw [Nat.mul_sub_left_distrib, Nat.mul_one]
  congr 1
  simpa [Nat.mul_comm] using r.ratio_mul_left

/-- Each exact quotient is at least two. -/
theorem DivisionRod.two_le_ratio (r : DivisionRod) : 2 ≤ r.ratio := by
  by_contra h
  have hq : r.ratio ≤ 1 := by omega
  have hm := Nat.mul_le_mul_right r.left hq
  rw [r.ratio_mul_left, Nat.one_mul] at hm
  have hp := r.proper
  omega

/-- The product before the next rod is bounded by its left endpoint, including
an empty prefix. -/
theorem prefix_product_le_next_left
    (rods : ℕ → DivisionRod) (n : ℕ)
    (hsep : ∀ i < n, (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range n, (rods i).ratio) ≤ (rods n).left := by
  cases n with
  | zero => simpa using (rods 0).left_pos
  | succ n =>
      exact le_trans
        (ordered_prefix_product_le_last rods n (fun i hi => hsep i (by omega)))
        (Nat.le_of_lt (hsep n (by omega)))

/-- The product is at most one plus the sum of exact natural rod gaps. -/
theorem ordered_product_le_one_add_total_gap
    (rods : ℕ → DivisionRod) (length : ℕ)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range length, (rods i).ratio) ≤
      1 + ∑ i ∈ Finset.range length, ((rods i).right - (rods i).left) := by
  induction length with
  | zero => simp
  | succ n ih =>
      have hp := ih (fun i hi => hsep i (by omega))
      have hleft := prefix_product_le_next_left rods n (fun i hi => hsep i (by omega))
      have hq := (rods n).two_le_ratio
      have hsplit : (rods n).ratio = 1 + ((rods n).ratio - 1) := by omega
      rw [Finset.prod_range_succ, Finset.sum_range_succ]
      calc
        (∏ i ∈ Finset.range n, (rods i).ratio) * (rods n).ratio
            = (∏ i ∈ Finset.range n, (rods i).ratio) +
              (∏ i ∈ Finset.range n, (rods i).ratio) * ((rods n).ratio - 1) := by
          conv_lhs => rw [hsplit, Nat.mul_add, Nat.mul_one]
        _ ≤ (1 + ∑ i ∈ Finset.range n, ((rods i).right - (rods i).left)) +
              (rods n).left * ((rods n).ratio - 1) :=
          Nat.add_le_add hp (Nat.mul_le_mul_right _ hleft)
        _ = 1 + ((∑ i ∈ Finset.range n, ((rods i).right - (rods i).left)) +
              ((rods n).right - (rods n).left)) := by
          rw [(rods n).left_mul_ratio_sub_one, Nat.add_assoc]

/-- With at least two rods, strict separation makes the total-gap bound strict. -/
theorem ordered_product_lt_one_add_total_gap
    (rods : ℕ → DivisionRod) (length : ℕ) (hlen : 2 ≤ length)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range length, (rods i).ratio) <
      1 + ∑ i ∈ Finset.range length, ((rods i).right - (rods i).left) := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_add_of_le hlen
  have hprefix := ordered_prefix_product_le_last rods n (fun i hi => hsep i (by omega))
  have hleft : (∏ i ∈ Finset.range (n + 1), (rods i).ratio) <
      (rods (n + 1)).left := lt_of_le_of_lt hprefix (hsep n (by omega))
  have hp := ordered_product_le_one_add_total_gap rods (n + 1)
    (fun i hi => hsep i (by omega))
  have hq := (rods (n + 1)).two_le_ratio
  have hpositive : 0 < (rods (n + 1)).ratio - 1 := by omega
  have hm := Nat.mul_lt_mul_of_pos_right hleft hpositive
  have hsplit : (rods (n + 1)).ratio = 1 + ((rods (n + 1)).ratio - 1) := by omega
  have hlen' : 2 + n = (n + 1) + 1 := by omega
  rw [hlen', Finset.prod_range_succ, Finset.sum_range_succ]
  calc
    (∏ i ∈ Finset.range (n + 1), (rods i).ratio) * (rods (n + 1)).ratio
        = (∏ i ∈ Finset.range (n + 1), (rods i).ratio) +
          (∏ i ∈ Finset.range (n + 1), (rods i).ratio) * ((rods (n + 1)).ratio - 1) := by
      conv_lhs => rw [hsplit, Nat.mul_add, Nat.mul_one]
    _ < (1 + ∑ i ∈ Finset.range (n + 1), ((rods i).right - (rods i).left)) +
          (rods (n + 1)).left * ((rods (n + 1)).ratio - 1) := Nat.add_lt_add_of_le_of_lt hp hm
    _ = 1 + ((∑ i ∈ Finset.range (n + 1), ((rods i).right - (rods i).left)) +
          ((rods (n + 1)).right - (rods (n + 1)).left)) := by
      rw [(rods (n + 1)).left_mul_ratio_sub_one, Nat.add_assoc]

/-- Endpoint-only interface: assumptions apply solely to the finite selected prefix.
No conditions are imposed on the functions outside `Finset.range length`. -/
theorem endpoint_product_bounds
    (left right : ℕ → ℕ) (length N : ℕ) (hN : 1 ≤ N)
    (hpos : ∀ i < length, 0 < left i)
    (hproper : ∀ i < length, left i < right i)
    (hdiv : ∀ i < length, left i ∣ right i)
    (hsep : ∀ i, i + 1 < length → right i < left (i + 1))
    (hbound : ∀ i < length, right i ≤ N) :
    (∏ i ∈ Finset.range length, right i / left i) ≤ N ∧
    (∏ i ∈ Finset.range length, right i / left i) ≤
      1 + ∑ i ∈ Finset.range length, (right i - left i) := by
  let rods : ℕ → DivisionRod := fun i =>
    if hi : i < length then
      ⟨left i, right i, hpos i hi, hproper i hi, hdiv i hi⟩
    else ⟨1, 2, by omega, by omega, by decide⟩
  have hs : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left := by
    intro i hi
    have hi' : i < length := by omega
    simpa [rods, hi, hi'] using hsep i hi
  have hb : ∀ i < length, (rods i).right ≤ N := by
    intro i hi
    simpa [rods, hi] using hbound i hi
  have heq : (∏ i ∈ Finset.range length, (rods i).ratio) =
      (∏ i ∈ Finset.range length, right i / left i) := by
    apply Finset.prod_congr rfl
    intro i hi
    simp [rods, DivisionRod.ratio, Finset.mem_range.mp hi]
  have hgap : (∑ i ∈ Finset.range length, ((rods i).right - (rods i).left)) =
      (∑ i ∈ Finset.range length, (right i - left i)) := by
    apply Finset.sum_congr rfl
    intro i hi
    simp [rods, Finset.mem_range.mp hi]
  constructor
  · have h := ordered_division_product_le rods length N hN hs hb
    change (∏ i ∈ Finset.range length, (rods i).ratio) ≤ N at h
    simpa [heq] using h
  · simpa [heq, hgap] using ordered_product_le_one_add_total_gap rods length hs

/-- The cutoff conclusion with all finite endpoint assumptions exposed. -/
theorem endpoint_product_le
    (left right : ℕ → ℕ) (length N : ℕ) (hN : 1 ≤ N)
    (hpos : ∀ i < length, 0 < left i)
    (hproper : ∀ i < length, left i < right i)
    (hdiv : ∀ i < length, left i ∣ right i)
    (hsep : ∀ i, i + 1 < length → right i < left (i + 1))
    (hbound : ∀ i < length, right i ≤ N) :
    (∏ i ∈ Finset.range length, right i / left i) ≤ N :=
  (endpoint_product_bounds left right length N hN hpos hproper hdiv hsep hbound).1

/-- Endpoint version of the proper-divisibility gap estimate. -/
theorem right_le_two_mul_gap (left right : ℕ)
    (hpos : 0 < left) (hproper : left < right) (hdiv : left ∣ right) :
    right ≤ 2 * (right - left) :=
  DivisionRod.right_le_two_mul_gap ⟨left, right, hpos, hproper, hdiv⟩

/-- A single rod starting at one attains the total-gap bound. -/
theorem DivisionRod.singleton_gap_equality (r : DivisionRod) (hleft : r.left = 1) :
    r.ratio = 1 + (r.right - r.left) := by
  have hp := r.proper
  simp only [DivisionRod.ratio, hleft, Nat.div_one]
  omega

end BuildingBlocks.RenewalRod
