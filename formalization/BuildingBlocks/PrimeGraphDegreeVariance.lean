import Mathlib

/-!
# Finite prime graph with the actual tent probability law

All vertices are positive integers strictly below a real cutoff. Conductances may
vanish, but are nonnegative, symmetric, and supported on ordinary prime edges.
The finite cut inequality is an identity about this graph, without asymptotic
counting assumptions. It does not assert a Liouville or RH estimate.
-/

noncomputable section
open scoped BigOperators
namespace BuildingBlocks.PrimeGraphDegreeVariance

/-- Positive integers strictly below the real cutoff, including noninteger endpoints. -/
def Vertex (X : ℝ) := {n : Fin (Nat.ceil X) // 0 < n.val}

instance (X : ℝ) : Fintype (Vertex X) := inferInstanceAs (Fintype {n : Fin (Nat.ceil X) // 0 < n.val})
instance (X : ℝ) : DecidableEq (Vertex X) := Classical.decEq _

def integer {X : ℝ} (n : Vertex X) : ℕ := n.val.val

theorem integer_pos {X : ℝ} (n : Vertex X) : 0 < integer n := n.property

theorem integer_lt_cutoff {X : ℝ} (n : Vertex X) : (integer n : ℝ) < X :=
  Nat.lt_ceil.mp n.val.isLt

/-- Every positive integer below the cutoff occurs as a vertex. -/
def vertexOfNat {X : ℝ} (n : ℕ) (hn : 0 < n) (hnX : (n : ℝ) < X) : Vertex X :=
  ⟨⟨n, Nat.lt_ceil.mpr hnX⟩, hn⟩

@[simp] theorem integer_vertexOfNat {X : ℝ} (n : ℕ) (hn : 0 < n)
    (hnX : (n : ℝ) < X) : integer (vertexOfNat n hn hnX) = n := rfl

/-- The literal tent weight, before probability normalization. -/
def tentWeight {X : ℝ} (n : Vertex X) : ℝ :=
  (X - (integer n : ℝ)) / Real.sqrt (integer n : ℝ)

def normalizer (X : ℝ) : ℝ := ∑ n : Vertex X, tentWeight n

def pi {X : ℝ} (n : Vertex X) : ℝ := tentWeight n / normalizer X

theorem tentWeight_pos {X : ℝ} (n : Vertex X) : 0 < tentWeight n := by
  exact div_pos (sub_pos.mpr (integer_lt_cutoff n))
    (Real.sqrt_pos.mpr (by exact_mod_cast integer_pos n))

theorem normalizer_pos {X : ℝ} (hX : 2 < X) : 0 < normalizer X := by
  let one : Vertex X := vertexOfNat 1 (by omega) (by norm_num; linarith)
  exact Finset.sum_pos' (fun n _ => (tentWeight_pos n).le)
    ⟨one, Finset.mem_univ _, tentWeight_pos one⟩

theorem pi_pos {X : ℝ} (hX : 2 < X) (n : Vertex X) : 0 < pi n :=
  div_pos (tentWeight_pos n) (normalizer_pos hX)

theorem pi_sum {X : ℝ} (hX : 2 < X) : ∑ n : Vertex X, pi n = 1 := by
  simp only [pi, ← Finset.sum_div]
  exact div_self (ne_of_gt (normalizer_pos hX))

/-- Ordinary prime multiplication in either direction, including repeated prime factors. -/
def PrimeEdge {X : ℝ} (n m : Vertex X) : Prop :=
  ∃ p : ℕ, p.Prime ∧ (integer m = p * integer n ∨ integer n = p * integer m)

theorem primeEdge_symm {X : ℝ} {n m : Vertex X} (h : PrimeEdge n m) :
    PrimeEdge m n := by
  obtain ⟨p, hp, h⟩ := h
  exact ⟨p, hp, h.symm⟩

/-- The fixed rough band, stated through its literal prime divisibility condition. -/
def roughSet (X Y : ℝ) : Finset (Vertex X) := by
  classical
  exact Finset.univ.filter fun n =>
    X / 2 < (integer n : ℝ) ∧ (integer n : ℝ) < 3 * X / 4 ∧
      ∀ p : ℕ, p.Prime → (p : ℝ) ≤ Y → ¬ p ∣ integer n

/-- The initial block that contains every neighbor of the rough band. -/
def smallSet (X Y : ℝ) : Finset (Vertex X) := by
  classical
  exact Finset.univ.filter fun n => (integer n : ℝ) ≤ 3 * X / (4 * Y)

@[simp] theorem mem_roughSet {X Y : ℝ} {n : Vertex X} : n ∈ roughSet X Y ↔
    X / 2 < (integer n : ℝ) ∧ (integer n : ℝ) < 3 * X / 4 ∧
      ∀ p : ℕ, p.Prime → (p : ℝ) ≤ Y → ¬ p ∣ integer n := by
  classical
  simp [roughSet]

@[simp] theorem mem_smallSet {X Y : ℝ} {n : Vertex X} : n ∈ smallSet X Y ↔
    (integer n : ℝ) ≤ 3 * X / (4 * Y) := by
  classical
  simp [smallSet]

/-- Upward moves leave the cutoff; downward moves divide by a prime greater than `Y`. -/
theorem rough_prime_neighbors_small {X Y : ℝ} (hY : 2 ≤ Y)
    {n m : Vertex X} (hn : n ∈ roughSet X Y) (hedge : PrimeEdge n m) :
    m ∈ smallSet X Y := by
  obtain ⟨hnlo, hnhi, hnrough⟩ := mem_roughSet.mp hn
  obtain ⟨p, hp, hedge | hedge⟩ := hedge
  · have hp2 : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp.two_le
    have hnpos : 0 ≤ (integer n : ℝ) := by positivity
    have hmul := mul_le_mul_of_nonneg_right hp2 hnpos
    have he : (integer m : ℝ) = (p : ℝ) * (integer n : ℝ) := by
      exact_mod_cast hedge
    have hmX := integer_lt_cutoff m
    exfalso
    nlinarith
  · have hpY : Y < (p : ℝ) := by
      by_contra h
      have hpLe : (p : ℝ) ≤ Y := le_of_not_gt h
      exact hnrough p hp hpLe ⟨integer m, hedge⟩
    have hmpos : 0 < (integer m : ℝ) := by exact_mod_cast integer_pos m
    have he : (integer n : ℝ) = (p : ℝ) * (integer m : ℝ) := by
      exact_mod_cast hedge
    have hmul := mul_lt_mul_of_pos_right hpY hmpos
    apply mem_smallSet.mpr
    apply (le_div_iff₀ (by linarith : 0 < 4 * Y)).mpr
    nlinarith

theorem rough_small_disjoint {X Y : ℝ} (hX : 2 < X) (hY : 2 ≤ Y) :
    Disjoint (roughSet X Y) (smallSet X Y) := by
  classical
  apply Finset.disjoint_left.mpr
  intro n hn hs
  have hnlo := (mem_roughSet.mp hn).1
  have hs' := (le_div_iff₀ (by linarith : 0 < 4 * Y)).mp (mem_smallSet.mp hs)
  have hnpos : 0 ≤ (integer n : ℝ) := by positivity
  have hmul := mul_le_mul_of_nonneg_right hY hnpos
  nlinarith

/-- The only constraints imposed on the finite conductance matrix. -/
structure Conductance (X : ℝ) where
  c : Vertex X → Vertex X → ℝ
  nonneg : ∀ n m, 0 ≤ c n m
  symm : ∀ n m, c n m = c m n
  support : ∀ n m, ¬ PrimeEdge n m → c n m = 0

namespace Conductance

variable {X : ℝ} (C : Conductance X)

def rowMass (n : Vertex X) : ℝ := ∑ m : Vertex X, C.c n m

def degree (n : Vertex X) : ℝ := C.rowMass n / pi n

def mass (S : Finset (Vertex X)) : ℝ := ∑ n ∈ S, pi n

def degreeMass (S : Finset (Vertex X)) : ℝ := ∑ n ∈ S, pi n * C.degree n

/-- Mean degree one is a separate condition, not a property of every conductance system. -/
def Normalized : Prop := (∑ n : Vertex X, pi n * C.degree n) = 1

def variance : ℝ := ∑ n : Vertex X, pi n * (C.degree n - 1) ^ 2

theorem rowMass_nonneg (n : Vertex X) : 0 ≤ C.rowMass n :=
  Finset.sum_nonneg (fun m _ => C.nonneg n m)

theorem degree_nonneg (hX : 2 < X) (n : Vertex X) : 0 ≤ C.degree n :=
  div_nonneg (C.rowMass_nonneg n) (pi_pos hX n).le

theorem pi_mul_degree (hX : 2 < X) (n : Vertex X) : pi n * C.degree n = C.rowMass n := by
  unfold degree
  exact mul_div_cancel₀ _ (ne_of_gt (pi_pos hX n))

theorem degreeMass_eq_rows (hX : 2 < X) (S : Finset (Vertex X)) :
    C.degreeMass S = ∑ n ∈ S, C.rowMass n := by
  simp only [degreeMass, C.pi_mul_degree hX]

theorem normalized_iff_total_conductance (hX : 2 < X) :
    C.Normalized ↔ (∑ n : Vertex X, ∑ m : Vertex X, C.c n m) = 1 := by
  simp only [Normalized, C.pi_mul_degree hX, rowMass]

/-- All prime neighbors of `S` lie in `T`. Zero-conductance isolates are permitted. -/
def NeighborsIn (S T : Finset (Vertex X)) : Prop :=
  ∀ n ∈ S, ∀ m, PrimeEdge n m → m ∈ T

/-- Symmetry counts the same crossing mass from either side; extra mass at `T` is nonnegative. -/
theorem degreeMass_cut_le (hX : 2 < X) (S T : Finset (Vertex X))
    (hST : NeighborsIn S T) : C.degreeMass S ≤ C.degreeMass T := by
  classical
  rw [C.degreeMass_eq_rows hX, C.degreeMass_eq_rows hX]
  calc
    (∑ n ∈ S, C.rowMass n) = ∑ n ∈ S, ∑ m ∈ T, C.c n m := by
      apply Finset.sum_congr rfl
      intro n hn
      unfold rowMass
      exact (Finset.sum_subset (Finset.subset_univ T) (by
        intro m _ hm
        exact C.support n m (fun hed => hm (hST n hn m hed)))).symm
    _ = ∑ m ∈ T, ∑ n ∈ S, C.c m n := by
      rw [Finset.sum_comm]
      simp_rw [C.symm]
    _ ≤ ∑ m ∈ T, C.rowMass m := by
      apply Finset.sum_le_sum
      intro m hm
      exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S)
        (fun n _ _ => C.nonneg m n)

/-- The exact cut constraint for the actual rough band and initial block. -/
theorem rough_degreeMass_le_small (hX : 2 < X) {Y : ℝ} (hY : 2 ≤ Y) :
    C.degreeMass (roughSet X Y) ≤ C.degreeMass (smallSet X Y) := by
  apply C.degreeMass_cut_le hX
  intro n hn m hedge
  exact rough_prime_neighbors_small hY hn hedge

/-- Actual Liouville values, with prime factors counted with multiplicity. -/
def liouville (n : ℕ) : ℝ := (-1 : ℝ) ^ ArithmeticFunction.cardFactors n

theorem liouville_mul_prime {p n : ℕ} (hp : p.Prime) (hn : n ≠ 0) :
    liouville (p * n) = -liouville n := by
  rw [liouville, ArithmeticFunction.cardFactors_mul hp.ne_zero hn,
    ArithmeticFunction.cardFactors_apply_prime hp, pow_add, pow_one]
  simp [liouville]

theorem liouville_edge_flip {n m : Vertex X} (h : PrimeEdge n m) :
    liouville (integer m) = -liouville (integer n) := by
  obtain ⟨p, hp, h | h⟩ := h
  · rw [h, liouville_mul_prime hp (ne_of_gt (integer_pos n))]
  · have hh := liouville_mul_prime hp (ne_of_gt (integer_pos m))
    rw [← h] at hh
    linarith

theorem liouville_sq (n : ℕ) : liouville n ^ 2 = 1 := by
  rw [liouville, ← pow_mul, Nat.mul_comm, pow_mul]
  norm_num

/-- Any edge-flipping sign has zero degree-weighted mean by finite symmetric pairing. -/
theorem edge_flip_degree_pairing_zero (hX : 2 < X) (sign : Vertex X → ℝ)
    (hflip : ∀ n m, PrimeEdge n m → sign m = -sign n) :
    (∑ n : Vertex X, pi n * C.degree n * sign n) = 0 := by
  classical
  simp only [C.pi_mul_degree hX, rowMass, Finset.sum_mul]
  let A := ∑ n : Vertex X, ∑ m : Vertex X, C.c n m * sign n
  have hswap : (∑ n : Vertex X, ∑ m : Vertex X, C.c n m * sign m) = A := by
    rw [Finset.sum_comm]
    simp only [A]
    congr 1
    ext n
    congr 1
    ext m
    rw [C.symm]
  have hzero : A + (∑ n : Vertex X, ∑ m : Vertex X, C.c n m * sign m) = 0 := by
    simp only [A, ← Finset.sum_add_distrib]
    apply Finset.sum_eq_zero
    intro n hn
    apply Finset.sum_eq_zero
    intro m hm
    by_cases he : PrimeEdge n m
    · rw [hflip n m he]
      ring
    · rw [C.support n m he]
      ring
  rw [hswap] at hzero
  change A = 0
  linarith

theorem liouville_degree_pairing_zero (hX : 2 < X) :
    (∑ n : Vertex X, pi n * C.degree n * liouville (integer n)) = 0 :=
  C.edge_flip_degree_pairing_zero hX (fun n => liouville (integer n))
    (fun _ _ => liouville_edge_flip)

end Conductance

/-! Finite weighted projection and exact rational comparison. -/

lemma weighted_cauchy {ι : Type*} (I : Finset ι) (p x y : ι → ℝ)
    (hp : ∀ i ∈ I, 0 ≤ p i) :
    (∑ i ∈ I, p i * x i * y i)^2 ≤
      (∑ i ∈ I, p i * (x i)^2) * ∑ i ∈ I, p i * (y i)^2 := by
  apply Finset.sum_sq_le_sum_mul_sum_of_sq_eq_mul
  · intro i hi; exact mul_nonneg (hp i hi) (sq_nonneg _)
  · intro i hi; exact mul_nonneg (hp i hi) (sq_nonneg _)
  · intro i hi; ring

lemma weighted_centering {ι : Type*} (I : Finset ι) (p u : ι → ℝ)
    (hp : ∑ i ∈ I, p i = 1) :
    ∑ i ∈ I, p i * (u i - ∑ j ∈ I, p j * u j)^2 =
      (∑ i ∈ I, p i * (u i)^2) - (∑ i ∈ I, p i * u i)^2 := by
  have h : ∀ i, p i * (u i - ∑ j ∈ I, p j * u j)^2 =
      p i * (u i)^2 - 2 * (∑ j ∈ I, p j * u j) * (p i * u i) +
        (∑ j ∈ I, p j * u j)^2 * p i := by intro i; ring
  simp_rw [h, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    ← Finset.mul_sum]
  rw [hp]
  ring

noncomputable def cutSign {ι : Type*} [DecidableEq ι] (S T : Finset ι) (i : ι) : ℝ :=
  (if i ∈ S then 1 else 0) - (if i ∈ T then 1 else 0)

lemma sum_cutSign {ι : Type*} [DecidableEq ι] (I S T : Finset ι)
    (p : ι → ℝ) (hS : S ⊆ I) (hT : T ⊆ I) :
    (∑ i ∈ I, p i * cutSign S T i) = (∑ i ∈ S, p i) - ∑ i ∈ T, p i := by
  simp only [cutSign, mul_sub, Finset.sum_sub_distrib]
  congr 1 <;> simp_rw [mul_ite, mul_one, mul_zero]
  · rw [← Finset.sum_filter]
    congr 1
    ext i
    simp only [Finset.mem_filter]
    exact ⟨fun h => h.2, fun h => ⟨hS h, h⟩⟩
  · rw [← Finset.sum_filter]
    congr 1
    ext i
    simp only [Finset.mem_filter]
    exact ⟨fun h => h.2, fun h => ⟨hT h, h⟩⟩

lemma sum_cutSign_sq {ι : Type*} [DecidableEq ι] (I S T : Finset ι)
    (p : ι → ℝ) (hS : S ⊆ I) (hT : T ⊆ I) (hST : Disjoint S T) :
    (∑ i ∈ I, p i * (cutSign S T i)^2) = (∑ i ∈ S, p i) + ∑ i ∈ T, p i := by
  have hi : ∀ i, (cutSign S T i)^2 =
      (if i ∈ S then 1 else 0) + (if i ∈ T then 1 else 0) := by
    intro i
    have hd : ¬ (i ∈ S ∧ i ∈ T) := by
      exact fun h => Finset.disjoint_left.mp hST h.1 h.2
    unfold cutSign
    split_ifs <;> simp_all
  simp_rw [hi, mul_add, Finset.sum_add_distrib]
  congr 1 <;> simp_rw [mul_ite, mul_one, mul_zero]
  · rw [← Finset.sum_filter]
    congr 1
    ext i
    simp only [Finset.mem_filter]
    exact ⟨fun h => h.2, fun h => ⟨hS h, h⟩⟩
  · rw [← Finset.sum_filter]
    congr 1
    ext i
    simp only [Finset.mem_filter]
    exact ⟨fun h => h.2, fun h => ⟨hT h, h⟩⟩

lemma weighted_covariance {ι : Type*} (I : Finset ι) (p u d : ι → ℝ)
    (hp : ∑ i ∈ I, p i = 1) (hd : ∑ i ∈ I, p i * d i = 1) :
    (∑ i ∈ I, p i * (u i - ∑ j ∈ I, p j * u j) * (d i - 1)) =
      (∑ i ∈ I, p i * u i * d i) - ∑ i ∈ I, p i * u i := by
  have h : ∀ i, p i * (u i - ∑ j ∈ I, p j * u j) * (d i - 1) =
      p i * u i * d i - p i * u i -
        (∑ j ∈ I, p j * u j) * (p i * d i) +
          (∑ j ∈ I, p j * u j) * p i := by intro i; ring
  simp_rw [h, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [hp, hd]
  ring

lemma weighted_projection {ι : Type*} (I : Finset ι) (p u d : ι → ℝ)
    (hp0 : ∀ i ∈ I, 0 ≤ p i) (hp : ∑ i ∈ I, p i = 1)
    (hd : ∑ i ∈ I, p i * d i = 1)
    (hu : 0 ≤ ∑ i ∈ I, p i * u i)
    (hcut : ∑ i ∈ I, p i * u i * d i ≤ 0) :
    (∑ i ∈ I, p i * u i)^2 ≤
      ((∑ i ∈ I, p i * (u i)^2) - (∑ i ∈ I, p i * u i)^2) *
        ∑ i ∈ I, p i * (d i - 1)^2 := by
  have hc := weighted_cauchy I p (fun i => u i - ∑ j ∈ I, p j * u j)
    (fun i => d i - 1) hp0
  rw [weighted_centering I p u hp, weighted_covariance I p u d hp hd] at hc
  have hneg : 0 ≤ -(∑ i ∈ I, p i * u i * d i) := neg_nonneg.mpr hcut
  have hsq := mul_nonneg hneg (by linarith :
    0 ≤ 2 * (∑ i ∈ I, p i * u i) - ∑ i ∈ I, p i * u i * d i)
  nlinarith

lemma weighted_cut_projection {ι : Type*} [DecidableEq ι]
    (I S T : Finset ι) (p d : ι → ℝ)
    (hp0 : ∀ i ∈ I, 0 ≤ p i) (hp : ∑ i ∈ I, p i = 1)
    (hd : ∑ i ∈ I, p i * d i = 1)
    (hS : S ⊆ I) (hT : T ⊆ I) (hST : Disjoint S T)
    (hm : (∑ i ∈ T, p i) ≤ ∑ i ∈ S, p i)
    (hcut : (∑ i ∈ S, p i * d i) ≤ ∑ i ∈ T, p i * d i) :
    ((∑ i ∈ S, p i) - ∑ i ∈ T, p i)^2 ≤
      ((∑ i ∈ S, p i) + (∑ i ∈ T, p i) -
        ((∑ i ∈ S, p i) - ∑ i ∈ T, p i)^2) *
          ∑ i ∈ I, p i * (d i - 1)^2 := by
  have hu : 0 ≤ ∑ i ∈ I, p i * cutSign S T i := by
    rw [sum_cutSign I S T p hS hT]; linarith
  have hc : ∑ i ∈ I, p i * cutSign S T i * d i ≤ 0 := by
    have he : (∑ i ∈ I, p i * cutSign S T i * d i) =
        ∑ i ∈ I, (p i * d i) * cutSign S T i := by
      apply Finset.sum_congr rfl; intro i hi; ring
    rw [he, sum_cutSign I S T (fun i => p i * d i) hS hT]
    linarith
  have h := weighted_projection I p (cutSign S T) d hp0 hp hd hu hc
  simpa only [sum_cutSign I S T p hS hT, sum_cutSign_sq I S T p hS hT hST] using h

lemma projection_denominator_pos {m q V : ℝ} (hmq : q < m) (hV : 0 ≤ V)
    (hproj : (m-q)^2 ≤ (m+q-(m-q)^2)*V) :
    0 < m+q-(m-q)^2 := by
  by_contra h
  have hh := mul_nonpos_of_nonpos_of_nonneg (le_of_not_gt h) hV
  nlinarith [sq_pos_of_pos (sub_pos.mpr hmq)]

/-- Strict monotonicity across a lower mass and an upper mass corner, without calculus. -/
lemma projection_corner_cross {m q a b : ℝ} (hb : 0 ≤ b) (hab : b < a)
    (hma : a < m) (hqb : q ≤ b) :
    (a-b)^2 * (m+q) < (m-q)^2 * (a+b) := by
  have ha : 0 < a := lt_of_le_of_lt hb hab
  have hfirst : 0 < (m-a)*(a-b)*(a+3*b) :=
    mul_pos (mul_pos (sub_pos.mpr hma) (sub_pos.mpr hab)) (by linarith)
  have hsecond : 0 ≤ (b-q)*(a-b)*(3*a+b) :=
    mul_nonneg (mul_nonneg (sub_nonneg.mpr hqb) (le_of_lt (sub_pos.mpr hab)))
      (by linarith)
  have hthird : 0 ≤ (a+b)*((m-a)+(b-q))^2 :=
    mul_nonneg (by linarith) (sq_nonneg _)
  have he : (m-q)^2*(a+b) - (a-b)^2*(m+q) =
      (m-a)*(a-b)*(a+3*b) + (b-q)*(a-b)*(3*a+b) +
        (a+b)*((m-a)+(b-q))^2 := by ring
  linarith

lemma projection_corner_strict {m q a b : ℝ} (hb : 0 ≤ b) (hab : b < a)
    (hma : a < m) (hqb : q ≤ b)
    (hD0 : 0 < a+b-(a-b)^2) (hD : 0 < m+q-(m-q)^2) :
    (a-b)^2 / (a+b-(a-b)^2) < (m-q)^2 / (m+q-(m-q)^2) := by
  apply (div_lt_div_iff₀ hD0 hD).2
  have hc := projection_corner_cross hb hab hma hqb
  nlinarith

lemma exact_projection_corner :
    ((1 / (6*(2:ℝ)^20)) - (3/(2:ℝ)^25))^2 /
      ((1 / (6*(2:ℝ)^20)) + (3/(2:ℝ)^25) -
        ((1 / (6*(2:ℝ)^20)) - (3/(2:ℝ)^25))^2) =
      49 / (75*(2:ℝ)^25 - 49) := by norm_num

lemma exact_projection_floor_pos : 0 < 49 / (75*(2:ℝ)^25 - 49) := by norm_num

lemma strict_projection_floor {m q : ℝ}
    (hm : 1 / (6*(2:ℝ)^20) < m) (hq : q < 3/(2:ℝ)^25)
    (hD : 0 < m+q-(m-q)^2) :
    49 / (75*(2:ℝ)^25 - 49) < (m-q)^2 / (m+q-(m-q)^2) := by
  rw [← exact_projection_corner]
  apply projection_corner_strict (by norm_num) (by norm_num) hm (le_of_lt hq)
    (by norm_num) hD

lemma strict_variance_floor {m q V : ℝ}
    (hm : 1 / (6*(2:ℝ)^20) < m) (hq : q < 3/(2:ℝ)^25)
    (hV : 0 ≤ V) (hproj : (m-q)^2 ≤ (m+q-(m-q)^2)*V) :
    49 / (75*(2:ℝ)^25 - 49) < V := by
  have hmq : q < m := by
    have h : (3/(2:ℝ)^25) < 1/(6*(2:ℝ)^20) := by norm_num
    linarith
  have hD := projection_denominator_pos hmq hV hproj
  have hf := strict_projection_floor hm hq hD
  have hv : (m-q)^2/(m+q-(m-q)^2) ≤ V := by
    exact (div_le_iff₀ hD).2 (by nlinarith [hproj])
  exact lt_of_lt_of_le hf hv

namespace Conductance

variable {X : ℝ} (C : Conductance X)

theorem variance_nonneg (hX : 2 < X) : 0 ≤ C.variance :=
  Finset.sum_nonneg (fun n _ => mul_nonneg (pi_pos hX n).le (sq_nonneg _))

/-- The centered projection applied to the actual rough band and its actual
prime-neighbor block, retaining the complete finite tent law. -/
theorem rough_variance_projection (hX : 2 < X) {Y : ℝ} (hY : 2 ≤ Y)
    (hnorm : C.Normalized)
    (hmq : mass (smallSet X Y) ≤ mass (roughSet X Y)) :
    (mass (roughSet X Y) - mass (smallSet X Y)) ^ 2 ≤
      (mass (roughSet X Y) + mass (smallSet X Y) -
        (mass (roughSet X Y) - mass (smallSet X Y)) ^ 2) * C.variance := by
  classical
  have hp : ∑ n ∈ (Finset.univ : Finset (Vertex X)), pi n = 1 := pi_sum hX
  have hd : ∑ n ∈ (Finset.univ : Finset (Vertex X)), pi n * C.degree n = 1 := hnorm
  have hc := C.rough_degreeMass_le_small hX hY
  simpa only [mass, variance] using
    weighted_cut_projection Finset.univ (roughSet X Y) (smallSet X Y)
      (fun n => pi n) C.degree (fun n _ => (pi_pos hX n).le) hp hd
      (Finset.subset_univ _) (Finset.subset_univ _)
      (rough_small_disjoint hX hY) hmq hc

/-- The finite graph has the claimed strict rational floor whenever its two
literal masses cross the displayed corner. The eventual mass estimates are
written CRT/asymptotic analysis, not supplied by this theorem. -/
theorem rough_variance_gt_corner (hX : 2 < X) {Y : ℝ} (hY : 2 ≤ Y)
    (hnorm : C.Normalized)
    (hm : 1 / (6 * (2 : ℝ) ^ 20) < mass (roughSet X Y))
    (hq : mass (smallSet X Y) < 3 / (2 : ℝ) ^ 25) :
    49 / (75 * (2 : ℝ) ^ 25 - 49) < C.variance := by
  have hab : (3 / (2 : ℝ) ^ 25) < 1 / (6 * (2 : ℝ) ^ 20) := by norm_num
  have hmq : mass (smallSet X Y) ≤ mass (roughSet X Y) := by linarith
  exact strict_variance_floor hm hq (C.variance_nonneg hX)
    (C.rough_variance_projection hX hY hnorm hmq)

/-- The elementary graph cancellation-to-variance bound. It does not assert
that the actual Liouville mean is large or that the variance can be small. -/
theorem liouville_mean_sq_le_variance (hX : 2 < X) :
    (∑ n : Vertex X, pi n * liouville (integer n)) ^ 2 ≤ C.variance := by
  classical
  have hz := C.liouville_degree_pairing_zero hX
  have he : (∑ n : Vertex X, pi n * liouville (integer n) * (1 - C.degree n)) =
      ∑ n : Vertex X, pi n * liouville (integer n) := by
    have hi : ∀ n : Vertex X,
        pi n * liouville (integer n) * (1 - C.degree n) =
          pi n * liouville (integer n) - pi n * C.degree n * liouville (integer n) := by
      intro n
      ring
    simp_rw [hi, Finset.sum_sub_distrib]
    rw [hz, sub_zero]
  have hc := weighted_cauchy Finset.univ (fun n : Vertex X => pi n)
    (fun n => liouville (integer n)) (fun n => 1 - C.degree n)
    (fun n _ => (pi_pos hX n).le)
  have hs : (∑ n : Vertex X, pi n * liouville (integer n) ^ 2) = 1 := by
    simp only [liouville_sq, mul_one]
    exact pi_sum hX
  have hv : (∑ n : Vertex X, pi n * (1 - C.degree n) ^ 2) = C.variance := by
    apply Finset.sum_congr rfl
    intro n hn
    congr 1
    ring
  rw [he, hs, hv, one_mul] at hc
  exact hc

end Conductance

#print axioms pi_sum
#print axioms rough_prime_neighbors_small
#print axioms Conductance.degreeMass_cut_le
#print axioms Conductance.rough_variance_projection
#print axioms Conductance.rough_variance_gt_corner
#print axioms Conductance.liouville_degree_pairing_zero
#print axioms Conductance.liouville_mean_sq_le_variance
#print axioms exact_projection_corner
#print axioms exact_projection_floor_pos

end BuildingBlocks.PrimeGraphDegreeVariance
