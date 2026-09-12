import Mathlib.NumberTheory.SmoothNumbers

/-! The state immediately before revealing n contains the positive integers whose
prime factors are smaller than n. These are available products, not only the
integers already visited. Every result here is elementary and unconditional. -/
namespace BuildingBlocks

def before (n : ℕ) : Set ℕ := Nat.smoothNumbers n

theorem mem_before_iff {n m : ℕ} :
    m ∈ before n ↔ ∀ p : ℕ, p.Prime → p ∣ m → p < n :=
  Nat.mem_smoothNumbers'

theorem before_mono {n k : ℕ} (h : n ≤ k) : before n ⊆ before k :=
  Nat.smoothNumbers_mono h

theorem before_one : before 1 = {1} := Nat.smoothNumbers_one

theorem before_mul {n a b : ℕ} (ha : a ∈ before n) (hb : b ∈ before n) :
    a * b ∈ before n := Nat.mul_mem_smoothNumbers ha hb

theorem before_divisor {n a b : ℕ} (ha : a ∈ before n) (h : b ∣ a) :
    b ∈ before n := Nat.mem_smoothNumbers_of_dvd ha h

theorem earlier_available {n m : ℕ} (hm : 0 < m) (h : m < n) :
    m ∈ before n := Nat.mem_smoothNumbers_of_lt hm h

theorem prime_not_before {p : ℕ} (hp : p.Prime) : p ∉ before p := by
  intro h
  exact (lt_irrefl p) ((mem_before_iff.mp h) p hp (dvd_refl p))

theorem prime_available_after {p : ℕ} (hp : p.Prime) : p ∈ before (p + 1) :=
  earlier_available hp.pos (Nat.lt_succ_self p)

theorem nonprime_no_change {n : ℕ} (hn : ¬n.Prime) : before (n + 1) = before n :=
  Nat.smoothNumbers_succ hn

theorem new_generator_iff_prime {n : ℕ} (hn : 0 < n) :
    n ∉ before n ↔ n.Prime := by
  constructor
  · intro h
    by_contra hnp
    have ha : n ∈ before (n + 1) := earlier_available hn (Nat.lt_succ_self n)
    rw [nonprime_no_change hnp] at ha
    exact h ha
  · exact prime_not_before

theorem state_changes_iff_prime (n : ℕ) : before (n + 1) ≠ before n ↔ n.Prime := by
  constructor
  · intro h
    by_contra hn
    exact h (nonprime_no_change hn)
  · intro hp h
    have ha := prime_available_after hp
    rw [h] at ha
    exact prime_not_before hp ha

/-- Retention maps keep the represented integer, so they lose no distinctions. -/
def retain {n k : ℕ} (h : n ≤ k) : before n → before k :=
  fun m => ⟨m.val, before_mono h m.property⟩

theorem retain_injective {n k : ℕ} (h : n ≤ k) : Function.Injective (retain h) := by
  intro a b hab
  exact Subtype.ext (congrArg (fun x : before k => x.val) hab)

/-- At a prime, every new available number has one unique exponent coordinate
and an old available factor. This reuses mathlib's unique factorization result. -/
def prime_step_equiv {p : ℕ} (hp : p.Prime) :
    ℕ × before p ≃ before (p + 1) := Nat.equivProdNatSmoothNumbers hp

theorem prime_step_equiv_apply {p : ℕ} (hp : p.Prime) (x : ℕ × before p) :
    (prime_step_equiv hp x).val = p ^ x.1 * x.2.val := rfl

/-- The additive clock can be reversed on its image; orientation alone is not
information destruction. The model simply permits forward steps. -/
theorem additive_clock_injective : Function.Injective Nat.succ := Nat.succ_injective

theorem prime_div_self {p : ℕ} (hp : p.Prime) : p / p = 1 := Nat.div_self hp.pos

/-- This rank is the number of available prime generators, not an entropy. -/
def generatorRank (n : ℕ) : ℕ := (Nat.primesBelow n).card

theorem generatorRank_succ (n : ℕ) :
    generatorRank (n + 1) = generatorRank n + if n.Prime then 1 else 0 := by
  classical
  unfold generatorRank
  rw [Nat.primesBelow_succ]
  split_ifs with hp
  · exact Finset.card_insert_of_notMem (Nat.notMem_primesBelow n)
  · simp

end BuildingBlocks
