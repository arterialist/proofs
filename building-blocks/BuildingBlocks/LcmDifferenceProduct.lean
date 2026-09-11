import Mathlib.Algebra.GCDMonoid.Finset
import Mathlib.Algebra.GCDMonoid.Nat
import Mathlib.Algebra.BigOperators.Group.List.Lemmas
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.List
import Mathlib.Data.Nat.Dist
import Mathlib.Tactic.Ring

/-!
# The common-prime correction for a finite family

For the entries of a list, `differenceProduct` contains `|n_j - n_i|` once
for every pair of positions `i < j`. The main divisibility theorem permits
zeros and repeated entries. Distinct positive entries make all factors nonzero.
-/

namespace BuildingBlocks.LcmDifferenceProduct

/-- The absolute Vandermonde product, with one factor for each pair of positions. -/
def differenceProduct : List ℕ → ℕ
  | [] => 1
  | a :: l => (l.map (Nat.dist a)).prod * differenceProduct l

theorem gcd_prod_dvd_prod_gcd (a : ℕ) (l : List ℕ) :
    Nat.gcd a l.prod ∣ (l.map (Nat.gcd a)).prod := by
  induction l with
  | nil => simp
  | cons b l ih =>
    simpa only [List.prod_cons, List.map_cons, gcd_eq_nat_gcd] using
      (gcd_mul_dvd_mul_gcd a b l.prod).trans (mul_dvd_mul (dvd_refl _) ih)

theorem gcd_dvd_distance (a b : ℕ) : Nat.gcd a b ∣ Nat.dist a b := by
  unfold Nat.dist
  exact Nat.dvd_add
    (Nat.dvd_sub (Nat.gcd_dvd_left a b) (Nat.gcd_dvd_right a b))
    (Nat.dvd_sub (Nat.gcd_dvd_right a b) (Nat.gcd_dvd_left a b))

theorem prod_gcd_dvd_prod_distance (a : ℕ) (l : List ℕ) :
    (l.map (Nat.gcd a)).prod ∣ (l.map (Nat.dist a)).prod := by
  induction l with
  | nil => simp
  | cons b l ih =>
    simpa only [List.map_cons, List.prod_cons] using
      mul_dvd_mul (gcd_dvd_distance a b) ih

/-- The overlap with the old lcm is absorbed by the new pair differences. -/
theorem gcd_lcm_dvd_prod_distance (a : ℕ) (l : List ℕ) :
    Nat.gcd a (l.toFinset.lcm id) ∣ (l.map (Nat.dist a)).prod := by
  have hl : l.toFinset.lcm id ∣ l.prod := by
    apply Finset.lcm_dvd
    intro b hb
    exact List.dvd_prod (List.mem_toFinset.mp hb)
  have hg : Nat.gcd a (l.toFinset.lcm id) ∣ Nat.gcd a l.prod :=
    gcd_dvd_gcd (dvd_refl a) hl
  exact hg.trans ((gcd_prod_dvd_prod_gcd a l).trans (prod_gcd_dvd_prod_distance a l))

/-- Product divides lcm times the absolute Vandermonde product.
No nonzero or distinctness hypotheses are required for divisibility itself. -/
theorem prod_dvd_lcm_mul_differenceProduct (l : List ℕ) :
    l.prod ∣ l.toFinset.lcm id * differenceProduct l := by
  induction l with
  | nil => simp [differenceProduct]
  | cons a l ih =>
    have hfirst := mul_dvd_mul (dvd_refl a) ih
    have hsecond := mul_dvd_mul
      (mul_dvd_mul (dvd_refl (Nat.lcm a (l.toFinset.lcm id)))
        (gcd_lcm_dvd_prod_distance a l))
      (dvd_refl (differenceProduct l))
    have heq : a * (l.toFinset.lcm id * differenceProduct l) =
        (Nat.lcm a (l.toFinset.lcm id) * Nat.gcd a (l.toFinset.lcm id)) *
          differenceProduct l := by
      rw [mul_comm (Nat.lcm a _) (Nat.gcd a _), Nat.gcd_mul_lcm]
      ring
    rw [heq] at hfirst
    simpa only [List.prod_cons, List.toFinset_cons, Finset.lcm_insert,
      lcm_eq_nat_lcm, id_eq, differenceProduct, mul_assoc] using hfirst.trans hsecond

theorem differenceProduct_pos {l : List ℕ} (hl : l.Nodup) :
    0 < differenceProduct l := by
  induction l with
  | nil => simp [differenceProduct]
  | cons a l ih =>
    obtain ⟨ha, ht⟩ := List.nodup_cons.mp hl
    apply mul_pos _ (ih ht)
    apply List.prod_pos
    intro b hb
    obtain ⟨c, hc, rfl⟩ := List.mem_map.mp hb
    exact Nat.dist_pos_of_ne (fun heq => ha (heq ▸ hc))

theorem lcm_ne_zero_of_positive {l : List ℕ} (hl : ∀ a ∈ l, 0 < a) :
    l.toFinset.lcm id ≠ 0 := by
  apply Finset.lcm_ne_zero_iff.mpr
  intro a ha
  exact (hl a (List.mem_toFinset.mp ha)).ne'

end BuildingBlocks.LcmDifferenceProduct
