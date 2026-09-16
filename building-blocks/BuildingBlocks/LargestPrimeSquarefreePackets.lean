import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite squarefree packets indexed by a supplied largest-prime map

Mathlib has `ArithmeticFunction.moebius`, rather than a declaration named
`Nat.moebius`.  The Möbius sign change below uses that actual arithmetic
function.  Existence and defining properties of a largest-prime map are kept
as hypotheses; the finite decomposition and packet identities are proved from them.
-/

namespace BuildingBlocks.LargestPrimeSquarefreePackets

open scoped BigOperators

/-- Squarefree positive integers in the closed interval `[A,B]`. -/
def squarefreeInterval (A B : ℕ) : Finset ℕ :=
  (Finset.Icc A B).filter fun d => Squarefree d ∧ d ≠ 1

/-- The part of a finite set assigned the label `q`. -/
def fiber (S : Finset ℕ) (largest : ℕ → ℕ) (q : ℕ) : Finset ℕ :=
  S.filter fun d => largest d = q

/-- Quotients obtained by removing the packet prime. -/
def quotientPacket (S : Finset ℕ) (largest : ℕ → ℕ) (q : ℕ) : Finset ℕ :=
  (fiber S largest q).image fun d => d / q

lemma mem_squarefreeInterval {A B d : ℕ} :
    d ∈ squarefreeInterval A B ↔ A ≤ d ∧ d ≤ B ∧ Squarefree d ∧ d ≠ 1 := by
  simp [squarefreeInterval, and_assoc]

/-- A squarefree integer cannot contain its prime divisor a second time in the quotient. -/
lemma prime_not_dvd_div_of_squarefree
    {q d : ℕ} (hq : q.Prime) (hsf : Squarefree d) (hqd : q ∣ d) :
    ¬ q ∣ d / q := by
  intro hsecond
  have hqq : q * q ∣ d := by
    rw [← Nat.mul_div_cancel' hqd]
    exact Nat.mul_dvd_mul_left q hsecond
  have hu : IsUnit q := hsf q hqq
  have hq1 : q = 1 := Nat.isUnit_iff.mp hu
  exact hq.ne_one hq1

lemma prime_coprime_div_of_squarefree
    {q d : ℕ} (hq : q.Prime) (hsf : Squarefree d) (hqd : q ∣ d) :
    q.Coprime (d / q) :=
  hq.coprime_iff_not_dvd.mpr (prime_not_dvd_div_of_squarefree hq hsf hqd)

/-- Exact removal of one prime from the actual Mathlib Möbius function. -/
theorem moebius_eq_neg_moebius_div
    {q d : ℕ} (hq : q.Prime) (hsf : Squarefree d) (hqd : q ∣ d) :
    ArithmeticFunction.moebius d = -ArithmeticFunction.moebius (d / q) := by
  have hprod : q * (d / q) = d := Nat.mul_div_cancel' hqd
  have hcop : q.Coprime (d / q) :=
    prime_coprime_div_of_squarefree hq hsf hqd
  calc
    ArithmeticFunction.moebius d =
        ArithmeticFunction.moebius (q * (d / q)) := by rw [hprod]
    _ = ArithmeticFunction.moebius q * ArithmeticFunction.moebius (d / q) :=
      ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime hcop
    _ = -ArithmeticFunction.moebius (d / q) := by
      rw [ArithmeticFunction.moebius_apply_prime hq]
      ring

/-- The quotient in a decomposition `d=q*m` is unique. -/
theorem quotient_unique
    {q d m : ℕ} (hq : 0 < q) (hqm : q * m = d) :
    m = d / q := by
  rw [← hqm, Nat.mul_div_cancel_left m hq]

/-- Unique decomposition by a supplied prime divisor. -/
theorem unique_prime_decomposition
    {q d : ℕ} (hq : q.Prime) (hqd : q ∣ d) :
    ∃! m, q * m = d := by
  refine ⟨d / q, Nat.mul_div_cancel' hqd, ?_⟩
  intro m hm
  exact quotient_unique hq.pos hm

/-- The complete decomposition statement for the label supplied as the largest
prime: existence, uniqueness, and the Möbius sign change in one predicate. -/
theorem supplied_largest_prime_decomposition
    {largest : ℕ → ℕ} {d : ℕ}
    (hsf : Squarefree d)
    (hprime : (largest d).Prime)
    (hdiv : largest d ∣ d) :
    ∃! m, largest d * m = d ∧
      ArithmeticFunction.moebius d = -ArithmeticFunction.moebius m := by
  refine ⟨d / largest d, ⟨Nat.mul_div_cancel' hdiv, ?_⟩, ?_⟩
  · exact moebius_eq_neg_moebius_div hprime hsf hdiv
  · intro m hm
    exact quotient_unique hprime.pos hm.1

/-- Reindex one squarefree fiber by its quotient.  The hypothesis `hdiv`
records the only largest-prime property needed here: its label divides every
member of its fiber. -/
theorem fiber_moebius_reconstruction
    {S : Finset ℕ} {largest : ℕ → ℕ} {q : ℕ}
    (hq : q.Prime)
    (hsquarefree : ∀ d ∈ S, Squarefree d)
    (hdiv : ∀ d ∈ S, largest d = q → q ∣ d)
    (a : ℕ → ℤ) :
    (∑ d ∈ fiber S largest q,
        ArithmeticFunction.moebius d * a d) =
      ∑ m ∈ quotientPacket S largest q,
        -(ArithmeticFunction.moebius m * a (q * m)) := by
  apply Finset.sum_bij (fun d _ => d / q)
  · intro d hd
    exact Finset.mem_image.mpr ⟨d, hd, rfl⟩
  · intro d₁ hd₁ d₂ hd₂ heq
    simp only [fiber, Finset.mem_filter] at hd₁ hd₂
    have hq1 : q ∣ d₁ := hdiv d₁ hd₁.1 hd₁.2
    have hq2 : q ∣ d₂ := hdiv d₂ hd₂.1 hd₂.2
    calc
      d₁ = q * (d₁ / q) := (Nat.mul_div_cancel' hq1).symm
      _ = q * (d₂ / q) := by rw [heq]
      _ = d₂ := Nat.mul_div_cancel' hq2
  · intro m hm
    simp only [quotientPacket, Finset.mem_image] at hm
    obtain ⟨d, hd, rfl⟩ := hm
    exact ⟨d, hd, rfl⟩
  · intro d hd
    simp only [fiber, Finset.mem_filter] at hd
    have hqd : q ∣ d := hdiv d hd.1 hd.2
    have hmu := moebius_eq_neg_moebius_div hq (hsquarefree d hd.1) hqd
    rw [hmu, Nat.mul_div_cancel' hqd]
    ring

/-- Every finite sum is the sum of its largest-prime fibers, provided all
labels of members of `S` lie in the finite label set `Q`. -/
theorem sum_eq_sum_fibers
    {R : Type*} [AddCommMonoid R]
    {S Q : Finset ℕ} {largest : ℕ → ℕ}
    (hmaps : ∀ d ∈ S, largest d ∈ Q) (f : ℕ → R) :
    (∑ d ∈ S, f d) =
      ∑ q ∈ Q, ∑ d ∈ fiber S largest q, f d := by
  symm
  exact Finset.sum_fiberwise_of_maps_to hmaps f

/-- Full finite packet reconstruction.  `hprime`, `hdiv`, and `hmaps` are the
explicit interface for the unavailable largest-prime facts.  No existence or
maximality theorem is asserted in this file. -/
theorem finite_packet_sum_reconstruction
    {S Q : Finset ℕ} {largest : ℕ → ℕ}
    (hsquarefree : ∀ d ∈ S, Squarefree d)
    (hmaps : ∀ d ∈ S, largest d ∈ Q)
    (hprime : ∀ q ∈ Q, (fiber S largest q).Nonempty → q.Prime)
    (hdiv : ∀ d ∈ S, largest d ∣ d)
    (a : ℕ → ℤ) :
    (∑ d ∈ S, ArithmeticFunction.moebius d * a d) =
      -∑ q ∈ Q, ∑ m ∈ quotientPacket S largest q,
        ArithmeticFunction.moebius m * a (q * m) := by
  rw [sum_eq_sum_fibers hmaps]
  calc
    (∑ q ∈ Q, ∑ d ∈ fiber S largest q,
        ArithmeticFunction.moebius d * a d) =
        ∑ q ∈ Q, -(∑ m ∈ quotientPacket S largest q,
          ArithmeticFunction.moebius m * a (q * m)) := by
      apply Finset.sum_congr rfl
      intro q hq
      by_cases hempty : fiber S largest q = ∅
      · simp [hempty, quotientPacket]
      · have hne : (fiber S largest q).Nonempty := Finset.nonempty_iff_ne_empty.mpr hempty
        rw [fiber_moebius_reconstruction (hprime q hq hne) hsquarefree
          (fun d hdS hdlabel => by simpa [hdlabel] using hdiv d hdS) a]
        rw [Finset.sum_neg_distrib]
    _ = -∑ q ∈ Q, ∑ m ∈ quotientPacket S largest q,
          ArithmeticFunction.moebius m * a (q * m) := by
      rw [Finset.sum_neg_distrib]

/-- Specialization to the actual finite squarefree interval. -/
theorem squarefree_interval_packet_reconstruction
    {A B : ℕ} {Q : Finset ℕ} {largest : ℕ → ℕ}
    (hmaps : ∀ d ∈ squarefreeInterval A B, largest d ∈ Q)
    (hprime : ∀ q ∈ Q,
      (fiber (squarefreeInterval A B) largest q).Nonempty → q.Prime)
    (hdiv : ∀ d ∈ squarefreeInterval A B, largest d ∣ d)
    (a : ℕ → ℤ) :
    (∑ d ∈ squarefreeInterval A B,
        ArithmeticFunction.moebius d * a d) =
      -∑ q ∈ Q, ∑ m ∈ quotientPacket (squarefreeInterval A B) largest q,
        ArithmeticFunction.moebius m * a (q * m) := by
  apply finite_packet_sum_reconstruction
  · intro d hd
    exact (mem_squarefreeInterval.mp hd).2.2.1
  · exact hmaps
  · exact hprime
  · exact hdiv

/-- Interval version with the concrete finite label range `[2,B]`.  The
largest-prime bounds are explicit hypotheses because this module does not
postulate or manufacture a largest-prime-factor API. -/
theorem squarefree_interval_Icc_packet_reconstruction
    {A B : ℕ} {largest : ℕ → ℕ}
    (hprime : ∀ d ∈ squarefreeInterval A B, (largest d).Prime)
    (hdiv : ∀ d ∈ squarefreeInterval A B, largest d ∣ d)
    (hlower : ∀ d ∈ squarefreeInterval A B, 2 ≤ largest d)
    (hupper : ∀ d ∈ squarefreeInterval A B, largest d ≤ B)
    (a : ℕ → ℤ) :
    (∑ d ∈ squarefreeInterval A B,
        ArithmeticFunction.moebius d * a d) =
      -∑ q ∈ Finset.Icc 2 B,
        ∑ m ∈ quotientPacket (squarefreeInterval A B) largest q,
          ArithmeticFunction.moebius m * a (q * m) := by
  apply squarefree_interval_packet_reconstruction
  · intro d hd
    exact Finset.mem_Icc.mpr ⟨hlower d hd, hupper d hd⟩
  · intro q hq
    intro hne
    obtain ⟨d, hd⟩ := hne
    have hdfiber := (Finset.mem_filter.mp hd)
    simpa [hdfiber.2] using hprime d hdfiber.1
  · exact hdiv

end BuildingBlocks.LargestPrimeSquarefreePackets

#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.moebius_eq_neg_moebius_div
#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.unique_prime_decomposition
#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.supplied_largest_prime_decomposition
#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.fiber_moebius_reconstruction
#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.finite_packet_sum_reconstruction
#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.squarefree_interval_packet_reconstruction
#print axioms BuildingBlocks.LargestPrimeSquarefreePackets.squarefree_interval_Icc_packet_reconstruction
