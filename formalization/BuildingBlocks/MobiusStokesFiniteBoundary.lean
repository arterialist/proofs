import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction
import BuildingBlocks.MertensArithmetic
import BuildingBlocks.LargestPrimeSquarefreePackets

/-!
# Finite Möbius--Stokes future-boundary algebra

Only finite identities are formalized. The prime-dilation theorem proves the
finite prime-split reindexing and all subsequent literal integer endpoint
algebra, including the square-divisible zero terms.
-/

namespace BuildingBlocks.MobiusStokesFiniteBoundary

open scoped BigOperators

section Abel

variable {R : Type*} [CommRing R]

/-- `C_A = F_1 + ... + F_A`, indexed without subtraction. -/
def charge (F : ℕ → R) (A : ℕ) : R :=
  ∑ i ∈ Finset.range A, F (i + 1)

/-- `sum_{a=1}^L F_a q^(a-1)`. -/
def futurePrefix (F : ℕ → R) (L : ℕ) (q : R) : R :=
  ∑ i ∈ Finset.range L, F (i + 1) * q ^ i

lemma charge_succ (F : ℕ → R) (A : ℕ) :
    charge F (A + 1) = charge F A + F (A + 1) := by
  simp [charge, Finset.sum_range_succ]

/-- Exact finite Abel identity (6), stated with `L=n+1` so every exponent is
an ordinary natural number. -/
theorem finite_abel_identity (F : ℕ → R) (q : R) (n : ℕ) :
    futurePrefix F (n + 1) q =
      (1 - q) * (∑ i ∈ Finset.range n, charge F (i + 1) * q ^ i) +
        charge F (n + 1) * q ^ n := by
  induction n with
  | zero => simp [futurePrefix, charge]
  | succ n ih =>
      rw [futurePrefix, Finset.sum_range_succ]
      change futurePrefix F (n + 1) q + F (n + 1 + 1) * q ^ (n + 1) = _
      rw [ih, Finset.sum_range_succ, charge_succ]
      rw [pow_succ]
      rw [charge_succ F (n + 1)]
      rw [charge_succ F n]
      ring

/-- Equation (7): multiply the Abel identity by the observation factor
`1-q`, retaining the terminal charge. -/
theorem finite_stokes_observed (F : ℕ → R) (q : R) (n : ℕ) :
    (1 - q) * futurePrefix F (n + 1) q =
      (1 - q) ^ 2 *
          (∑ i ∈ Finset.range n, charge F (i + 1) * q ^ i) +
        (1 - q) * charge F (n + 1) * q ^ n := by
  rw [finite_abel_identity]
  ring

end Abel

section Renewal

/-- Complete divisor renewal at the moving endpoint, using Mathlib's actual
`ArithmeticFunction.moebius`. -/
theorem complete_moebius_divisor_renewal {N : ℕ} (hN : 0 < N) :
    ∑ d ∈ Finset.Icc 1 N,
      ArithmeticFunction.moebius d * ((N / d : ℕ) : ℤ) = 1 :=
  BuildingBlocks.MertensTransfer.moebius_floor_mass hN

end Renewal

section PrimeDilation

/-- Möbius mass on the literal half-open integer interval `(D,N]`. -/
def bulkMass (D N : ℕ) : ℤ :=
  ∑ d ∈ Finset.Ioc D N, ArithmeticFunction.moebius d

/-- The part of `(lo,hi]` whose indices are not divisible by `p`. -/
def notDvdFace (p lo hi : ℕ) : ℤ :=
  ∑ m ∈ Finset.Ioc lo hi, if p ∣ m then 0 else ArithmeticFunction.moebius m

/-- Actual prime-dilation Möbius sign, with no omitted squarefree premise. -/
theorem moebius_prime_mul_of_not_dvd {p m : ℕ}
    (hp : p.Prime) (hpm : ¬ p ∣ m) :
    ArithmeticFunction.moebius (p * m) = -ArithmeticFunction.moebius m := by
  have hcop : p.Coprime m := hp.coprime_iff_not_dvd.mpr hpm
  rw [ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime hcop,
    ArithmeticFunction.moebius_apply_prime hp]
  ring

lemma moebius_eq_zero_of_prime_sq_dvd {p d : ℕ}
    (hp : p.Prime) (hpd : p ∣ d) (hpquot : p ∣ d / p) :
    ArithmeticFunction.moebius d = 0 := by
  apply ArithmeticFunction.moebius_eq_zero_of_not_squarefree
  intro hsf
  have hpp : p * p ∣ d := by
    rw [← Nat.mul_div_cancel' hpd]
    exact Nat.mul_dvd_mul_left p hpquot
  have hu : IsUnit p := hsf p hpp
  exact hp.ne_one (Nat.isUnit_iff.mp hu)

/-- Multiples containing exactly one visible factor `p`. -/
def primitiveMultiples (p D N : ℕ) : Finset ℕ :=
  (Finset.Ioc D N).filter fun d => p ∣ d ∧ ¬p ∣ d / p

/-- Cofactors in the floor-scaled interval which are not divisible by `p`. -/
def primitiveCofactors (p D N : ℕ) : Finset ℕ :=
  (Finset.Ioc (D / p) (N / p)).filter fun m => ¬p ∣ m

/-- Literal bijection `d ↦ d/p` for the once-divisible terms. -/
theorem primitive_multiples_reindex
    {p D N : ℕ} (hp : p.Prime) :
    (∑ d ∈ primitiveMultiples p D N, ArithmeticFunction.moebius d) =
      -(∑ m ∈ primitiveCofactors p D N, ArithmeticFunction.moebius m) := by
  rw [← Finset.sum_neg_distrib]
  apply Finset.sum_bij (fun d _ => d / p)
  · intro d hd
    simp only [primitiveMultiples, Finset.mem_filter, Finset.mem_Ioc] at hd
    simp only [primitiveCofactors, Finset.mem_filter, Finset.mem_Ioc]
    refine ⟨⟨?_, Nat.div_le_div_right hd.1.2⟩, hd.2.2⟩
    rw [Nat.div_lt_iff_lt_mul hp.pos]
    simpa [Nat.mul_comm] using hd.1.1.trans_eq (Nat.mul_div_cancel' hd.2.1).symm
  · intro d₁ hd₁ d₂ hd₂ heq
    simp only [primitiveMultiples, Finset.mem_filter] at hd₁ hd₂
    calc
      d₁ = p * (d₁ / p) := (Nat.mul_div_cancel' hd₁.2.1).symm
      _ = p * (d₂ / p) := by rw [heq]
      _ = d₂ := Nat.mul_div_cancel' hd₂.2.1
  · intro m hm
    simp only [primitiveCofactors, Finset.mem_filter, Finset.mem_Ioc] at hm
    refine ⟨p * m, ?_, ?_⟩
    · simp only [primitiveMultiples, Finset.mem_filter, Finset.mem_Ioc]
      have hlow : D < p * m := by
        have := (Nat.div_lt_iff_lt_mul hp.pos).mp hm.1.1
        simpa [Nat.mul_comm] using this
      have hupp : p * m ≤ N := by
        have := (Nat.le_div_iff_mul_le hp.pos).mp hm.1.2
        simpa [Nat.mul_comm] using this
      refine ⟨⟨hlow, hupp⟩, dvd_mul_right p m, ?_⟩
      simpa [Nat.mul_div_cancel_left m hp.pos] using hm.2
    · exact Nat.mul_div_cancel_left m hp.pos
  · intro d hd
    simp only [primitiveMultiples, Finset.mem_filter] at hd
    calc
      ArithmeticFunction.moebius d =
          ArithmeticFunction.moebius (p * (d / p)) := by
            rw [Nat.mul_div_cancel' hd.2.1]
      _ = -ArithmeticFunction.moebius (d / p) :=
        moebius_prime_mul_of_not_dvd hp hd.2.2

/-- The actual Möbius bulk splits into its nondivisible face and its
once-divisible part; all `p²` terms vanish. -/
theorem bulkMass_eq_notDvd_add_primitive
    {p D N : ℕ} (hp : p.Prime) :
    bulkMass D N = notDvdFace p D N +
      ∑ d ∈ primitiveMultiples p D N, ArithmeticFunction.moebius d := by
  unfold bulkMass notDvdFace primitiveMultiples
  rw [Finset.sum_filter, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  by_cases hpd : p ∣ d
  · by_cases hpq : p ∣ d / p
    · rw [moebius_eq_zero_of_prime_sq_dvd hp hpd hpq]
      simp [hpd, hpq]
    · simp [hpd, hpq]
  · simp [hpd]

lemma primitiveCofactors_sum_eq_notDvdFace (p D N : ℕ) :
    (∑ m ∈ primitiveCofactors p D N, ArithmeticFunction.moebius m) =
      notDvdFace p (D / p) (N / p) := by
  unfold primitiveCofactors notDvdFace
  simp only [Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro m hm
  by_cases hpm : p ∣ m <;> simp [hpm]

/-- Unconditional finite floor reindexing of the prime-divisible bulk. -/
theorem bulkMass_prime_split {p D N : ℕ} (hp : p.Prime) :
    bulkMass D N = notDvdFace p D N - notDvdFace p (D / p) (N / p) := by
  rw [bulkMass_eq_notDvd_add_primitive hp,
    primitive_multiples_reindex hp,
    primitiveCofactors_sum_eq_notDvdFace]
  ring

/-- Prefix representation of a not-divisible face. -/
def notDvdPrefix (p X : ℕ) : ℤ :=
  ∑ m ∈ Finset.range (X + 1), if p ∣ m then 0 else ArithmeticFunction.moebius m

lemma notDvdFace_eq_prefix_sub {p lo hi : ℕ} (hlohi : lo ≤ hi) :
    notDvdFace p lo hi = notDvdPrefix p hi - notDvdPrefix p lo := by
  unfold notDvdFace notDvdPrefix
  have hI : Finset.Ioc lo hi = Finset.Ico (lo + 1) (hi + 1) := by
    ext m
    simp only [Finset.mem_Ioc, Finset.mem_Ico]
    omega
  rw [hI, Finset.sum_Ico_eq_sub]
  omega

/-- Pure endpoint algebra behind the two faces. -/
theorem notDvd_interval_two_face {p D N : ℕ} (hDN : D ≤ N) :
    notDvdFace p D N - notDvdFace p (D / p) (N / p) =
      notDvdFace p (Nat.max D (N / p)) N -
        notDvdFace p (D / p) (Nat.min D (N / p)) := by
  have hdiv : D / p ≤ N / p := Nat.div_le_div_right hDN
  rcases le_total D (N / p) with hcross | hcross
  · simp only [Nat.max_eq_right hcross, Nat.min_eq_left hcross]
    rw [notDvdFace_eq_prefix_sub hDN,
      notDvdFace_eq_prefix_sub hdiv,
      notDvdFace_eq_prefix_sub (Nat.div_le_self N p),
      notDvdFace_eq_prefix_sub (Nat.div_le_self D p)]
    ring
  · simp only [Nat.max_eq_left hcross, Nat.min_eq_right hcross]

/-- Exact unconditional equation (18). -/
theorem prime_dilation_two_face
    {p D N : ℕ} (hp : p.Prime) (hDN : D ≤ N) :
    bulkMass D N =
      notDvdFace p (Nat.max D (N / p)) N -
        notDvdFace p (D / p) (Nat.min D (N / p)) := by
  rw [bulkMass_prime_split hp]
  exact notDvd_interval_two_face hDN

/-- Expanded literal endpoint form of (18). -/
theorem prime_dilation_two_face_expanded
    {p D N : ℕ} (hp : p.Prime) (hDN : D ≤ N) :
    (∑ d ∈ Finset.Ioc D N, ArithmeticFunction.moebius d) =
      (∑ m ∈ Finset.Ioc (Nat.max D (N / p)) N,
        if p ∣ m then 0 else ArithmeticFunction.moebius m) -
      (∑ m ∈ Finset.Ioc (D / p) (Nat.min D (N / p)),
        if p ∣ m then 0 else ArithmeticFunction.moebius m) := by
  exact prime_dilation_two_face hp hDN

end PrimeDilation

end BuildingBlocks.MobiusStokesFiniteBoundary

#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.finite_abel_identity
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.finite_stokes_observed
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.complete_moebius_divisor_renewal
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.moebius_prime_mul_of_not_dvd
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.moebius_eq_zero_of_prime_sq_dvd
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.primitive_multiples_reindex
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.bulkMass_prime_split
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.notDvd_interval_two_face
#print axioms BuildingBlocks.MobiusStokesFiniteBoundary.prime_dilation_two_face_expanded
