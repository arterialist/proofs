import Mathlib.Algebra.BigOperators.Group.Finset.Powerset
import Mathlib.Tactic

/-!
Finite signed divisor cubes and their prefix energy.  A subset `T` of the
prime set represents the squarefree divisor `∏ q ∈ T, q`; its coefficient is
`(-1) ^ T.card`.  This representation keeps the prime admission pairing
visible without an intermediate squarefree-divisor equivalence.
-/

namespace BuildingBlocks.FinitePrimeFutureConeEnergy

open Finset

noncomputable section

/-- Complete signed prefix of the finite prime cube. -/
def cubePrefix (S : Finset ℕ) (m : ℕ) : ℝ :=
  ∑ T ∈ S.powerset,
    (-1 : ℝ) ^ T.card * if (∏ q ∈ T, q) ≤ m then 1 else 0

/-- Admitting a fresh positive prime pairs each old divisor with its
negative `p`-multiple. -/
theorem cubePrefix_insert (S : Finset ℕ) (p m : ℕ)
    (hp : 0 < p) (hps : p ∉ S) :
    cubePrefix (insert p S) m = cubePrefix S m - cubePrefix S (m / p) := by
  classical
  unfold cubePrefix
  rw [Finset.sum_powerset_insert hps]
  have hnew :
      (∑ T ∈ S.powerset,
        (-1 : ℝ) ^ (insert p T).card *
          if (∏ q ∈ insert p T, q) ≤ m then 1 else 0) =
        -(∑ T ∈ S.powerset,
          (-1 : ℝ) ^ T.card *
            if (∏ q ∈ T, q) ≤ m / p then 1 else 0) := by
    rw [← Finset.sum_neg_distrib]
    apply Finset.sum_congr rfl
    intro T hT
    have hpt : p ∉ T := Finset.notMem_mono (Finset.mem_powerset.mp hT) hps
    rw [Finset.card_insert_of_notMem hpt, Finset.prod_insert hpt]
    have hdiv : (p * ∏ q ∈ T, q) ≤ m ↔ (∏ q ∈ T, q) ≤ m / p := by
      rw [Nat.le_div_iff_mul_le hp]
      simp only [mul_comm]
    simp only [pow_succ, hdiv]
    ring
  rw [hnew]
  ring

/-- The finite reverse triangle inequality, in the exact squared-energy form
used for adjoining a prime. -/
theorem finite_energy_reverse_triangle {ι : Type*} (s : Finset ι)
    (f g : ι → ℝ) (p : ℕ)
    (hg : (∑ i ∈ s, g i ^ 2) = (p : ℝ) * ∑ i ∈ s, f i ^ 2) :
    (Real.sqrt (p : ℝ) - 1) ^ 2 * (∑ i ∈ s, f i ^ 2) ≤
      ∑ i ∈ s, (f i - g i) ^ 2 := by
  let A : ℝ := ∑ i ∈ s, f i ^ 2
  have hA : 0 ≤ A := Finset.sum_nonneg (fun _ _ => sq_nonneg _)
  have hp : 0 ≤ (p : ℝ) := Nat.cast_nonneg _
  have hcross := Real.sum_mul_le_sqrt_mul_sqrt s f g
  have hroot : Real.sqrt ((p : ℝ) * A) = Real.sqrt (p : ℝ) * Real.sqrt A :=
    Real.sqrt_mul hp _
  have hsqrt : (Real.sqrt A) ^ 2 = A := Real.sq_sqrt hA
  have hexpand : (∑ i ∈ s, (f i - g i) ^ 2) =
      A + (∑ i ∈ s, g i ^ 2) - 2 * (∑ i ∈ s, f i * g i) := by
    dsimp [A]
    calc
      ∑ i ∈ s, (f i - g i) ^ 2 =
          ∑ i ∈ s, (f i ^ 2 + g i ^ 2 - 2 * (f i * g i)) := by
            apply Finset.sum_congr rfl
            intro i hi
            ring
      _ = _ := by rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum]
  have hc : (∑ i ∈ s, f i * g i) ≤ Real.sqrt (p : ℝ) * A := by
    rw [hg] at hcross
    change (∑ i ∈ s, f i * g i) ≤ Real.sqrt A * Real.sqrt ((p : ℝ) * A) at hcross
    rw [hroot] at hcross
    calc
      _ ≤ Real.sqrt A * (Real.sqrt (p : ℝ) * Real.sqrt A) := hcross
      _ = Real.sqrt (p : ℝ) * A := by rw [mul_left_comm, ← pow_two, hsqrt]
  rw [hexpand, hg]
  change (Real.sqrt (p : ℝ) - 1) ^ 2 * A ≤
    A + (p : ℝ) * A - 2 * (∑ i ∈ s, f i * g i)
  nlinarith [Real.sq_sqrt hp]

/-- Every value in a length-`N` history appears in exactly `p` consecutive
slots of the dilated history. -/
theorem sum_div_blocks (p N : ℕ) (hp : 0 < p) (g : ℕ → ℝ) :
    (∑ m ∈ Finset.range (p * N), g (m / p)) =
      (p : ℝ) * ∑ n ∈ Finset.range N, g n := by
  induction N with
  | zero => simp
  | succ N ih =>
      rw [show p * (N + 1) = p * N + p by ring, Finset.sum_range_add, ih,
        Finset.sum_range_succ]
      have hblock : (∑ j ∈ Finset.range p, g ((p * N + j) / p)) =
          (p : ℝ) * g N := by
        calc
          _ = ∑ j ∈ Finset.range p, g N := by
                apply Finset.sum_congr rfl
                intro j hj
                have hjp : j < p := Finset.mem_range.mp hj
                rw [Nat.mul_comm p N, Nat.add_comm (N * p) j,
                  Nat.add_mul_div_right j N hp]
                simp [Nat.div_eq_of_lt hjp]
          _ = (p : ℝ) * g N := by simp
      rw [hblock]
      ring

/-- Exact finite norm expansion under integer division. -/
theorem dilated_energy (p N : ℕ) (hp : 0 < p) (F : ℕ → ℝ) :
    (∑ m ∈ Finset.range (p * N), (F (m / p)) ^ 2) =
      (p : ℝ) * ∑ m ∈ Finset.range N, (F m) ^ 2 :=
  sum_div_blocks p N hp (fun m => (F m) ^ 2)

/-- The completed finite energy of a history supported below `N` grows by
at least the reverse-triangle factor after prime-style admission. -/
theorem finite_admission_energy (p N : ℕ) (hp : 0 < p)
    (F : ℕ → ℝ) (hF : ∀ m, N ≤ m → F m = 0) :
    (Real.sqrt (p : ℝ) - 1) ^ 2 *
        (∑ m ∈ Finset.range N, (F m) ^ 2) ≤
      ∑ m ∈ Finset.range (p * N), (F m - F (m / p)) ^ 2 := by
  have hNp : N ≤ p * N := by
    have hp1 : 1 ≤ p := hp
    nlinarith
  have hold : (∑ m ∈ Finset.range (p * N), (F m) ^ 2) =
      ∑ m ∈ Finset.range N, (F m) ^ 2 := by
    have hsplit := Finset.sum_range_add_sum_Ico (fun m => (F m) ^ 2) hNp
    have htail : (∑ m ∈ Finset.Ico N (p * N), (F m) ^ 2) = 0 := by
      apply Finset.sum_eq_zero
      intro m hm
      rw [hF m (Finset.mem_Ico.mp hm).1]
      ring
    rw [htail, add_zero] at hsplit
    exact hsplit.symm
  have hreverse := finite_energy_reverse_triangle (Finset.range (p * N))
    F (fun m => F (m / p)) p
  have hd := dilated_energy p N hp F
  calc
    _ = (Real.sqrt (p : ℝ) - 1) ^ 2 *
        (∑ m ∈ Finset.range (p * N), (F m) ^ 2) := by rw [hold]
    _ ≤ _ := hreverse (by rw [hold]; exact hd)

/-- For a nonempty finite prime cube, the signed prefix vanishes at and
beyond its product horizon. -/
theorem cubePrefix_vanishes (S : Finset ℕ) (hS : S.Nonempty)
    (hprime : ∀ q ∈ S, Nat.Prime q) (m : ℕ)
    (hm : (∏ q ∈ S, q) ≤ m) : cubePrefix S m = 0 := by
  classical
  calc
    cubePrefix S m = ∑ T ∈ S.powerset, (-1 : ℝ) ^ T.card := by
      unfold cubePrefix
      apply Finset.sum_congr rfl
      intro T hT
      have hTS : T ⊆ S := Finset.mem_powerset.mp hT
      have hprod : (∏ q ∈ T, q) ≤ ∏ q ∈ S, q :=
        Finset.prod_le_prod_of_subset_of_one_le' hTS
          (fun q hq _ => Nat.one_le_iff_ne_zero.mpr (hprime q hq).ne_zero)
      simp [hprod.trans hm]
    _ = 0 := by exact_mod_cast Finset.sum_powerset_neg_one_pow_card_of_nonempty hS

/-- Completed finite energy, with the zero prefix included harmlessly in
the range. -/
def cubeEnergy (S : Finset ℕ) : ℝ :=
  ∑ m ∈ Finset.range (∏ q ∈ S, q), (cubePrefix S m) ^ 2

/-- The zero-time prefix vanishes for a finite prime cube. -/
theorem cubePrefix_zero (S : Finset ℕ)
    (hprime : ∀ q ∈ S, Nat.Prime q) : cubePrefix S 0 = 0 := by
  classical
  by_cases hS : S = ∅
  · subst S
    simp [cubePrefix]
  · obtain ⟨p, hpS⟩ := Finset.nonempty_iff_ne_empty.mpr hS
    calc
      cubePrefix S 0 = cubePrefix (insert p (S.erase p)) 0 := by
        rw [Finset.insert_erase hpS]
      _ = cubePrefix (S.erase p) 0 - cubePrefix (S.erase p) (0 / p) :=
        cubePrefix_insert (S.erase p) p 0 (hprime p hpS).pos
          (Finset.notMem_erase p S)
      _ = 0 := by simp

/-- The only divisor visible at time one is the empty-subset divisor. -/
theorem cubePrefix_one (S : Finset ℕ)
    (hprime : ∀ q ∈ S, Nat.Prime q) : cubePrefix S 1 = 1 := by
  classical
  induction S using Finset.induction_on with
  | empty => simp [cubePrefix]
  | @insert p S hps ih =>
      have hp : Nat.Prime p := hprime p (Finset.mem_insert_self p S)
      have hSp : ∀ q ∈ S, Nat.Prime q := by
        intro q hq
        exact hprime q (Finset.mem_insert_of_mem hq)
      rw [cubePrefix_insert S p 1 hp.pos hps,
        Nat.div_eq_of_lt hp.one_lt, cubePrefix_zero S hSp, ih hSp]
      ring

/-- A nonempty finite prime cube has positive completed energy. -/
theorem cubeEnergy_pos (S : Finset ℕ) (hS : S.Nonempty)
    (hprime : ∀ q ∈ S, Nat.Prime q) : 0 < cubeEnergy S := by
  classical
  obtain ⟨q, hq⟩ := hS
  have hqQ : q ≤ ∏ r ∈ S, r := by
    simpa using
      (Finset.prod_le_prod_of_subset_of_one_le'
        (Finset.singleton_subset_iff.mpr hq)
        (fun r hr _ => Nat.one_le_iff_ne_zero.mpr (hprime r hr).ne_zero))
  have hQ : 1 < ∏ r ∈ S, r := lt_of_lt_of_le (hprime q hq).one_lt hqQ
  have hmem : 1 ∈ Finset.range (∏ r ∈ S, r) := Finset.mem_range.mpr hQ
  unfold cubeEnergy
  have hterm : 0 < (cubePrefix S 1) ^ 2 := by
    rw [cubePrefix_one S hprime]
    norm_num
  exact Finset.sum_pos' (fun m hm => sq_nonneg (cubePrefix S m))
    ⟨1, hmem, hterm⟩

/-- The exact prime admission identity and finite dilation count imply the
energy theorem for the actual signed prime cube. -/
theorem cubeEnergy_insert (S : Finset ℕ) (hS : S.Nonempty)
    (hprime : ∀ q ∈ S, Nat.Prime q) (p : ℕ)
    (hp : Nat.Prime p) (hps : p ∉ S) :
    (Real.sqrt (p : ℝ) - 1) ^ 2 * cubeEnergy S ≤
      cubeEnergy (insert p S) := by
  have hp0 : 0 < p := hp.pos
  let Q := ∏ q ∈ S, q
  have hbase := finite_admission_energy p Q hp0 (cubePrefix S)
    (fun m hm => cubePrefix_vanishes S hS hprime m hm)
  unfold cubeEnergy at hbase ⊢
  change (Real.sqrt (p : ℝ) - 1) ^ 2 *
      (∑ m ∈ Finset.range Q, (cubePrefix S m) ^ 2) ≤
        ∑ m ∈ Finset.range (∏ q ∈ insert p S, q),
          (cubePrefix (insert p S) m) ^ 2
  rw [Finset.prod_insert hps]
  change _ ≤ ∑ m ∈ Finset.range (p * Q), (cubePrefix (insert p S) m) ^ 2
  calc
    _ ≤ ∑ m ∈ Finset.range (p * Q),
        (cubePrefix S m - cubePrefix S (m / p)) ^ 2 := hbase
    _ = _ := by
      apply Finset.sum_congr rfl
      intro m hm
      rw [cubePrefix_insert S p m hp0 hps]

/-- Adding a fresh prime at least five strictly increases completed energy. -/
theorem cubeEnergy_insert_strict (S : Finset ℕ) (hS : S.Nonempty)
    (hprime : ∀ q ∈ S, Nat.Prime q) (p : ℕ)
    (hp : Nat.Prime p) (hps : p ∉ S) (hp5 : 5 ≤ p) :
    cubeEnergy S < cubeEnergy (insert p S) := by
  have hE : 0 < cubeEnergy S := cubeEnergy_pos S hS hprime
  have hp4 : (4 : ℝ) < p := by exact_mod_cast (show 4 < p by omega)
  have hroot : 2 < Real.sqrt (p : ℝ) := by
    have hnonneg : 0 ≤ Real.sqrt (p : ℝ) := Real.sqrt_nonneg _
    have hsq : (Real.sqrt (p : ℝ)) ^ 2 = (p : ℝ) :=
      Real.sq_sqrt (Nat.cast_nonneg _)
    nlinarith
  have hfactor : 1 < (Real.sqrt (p : ℝ) - 1) ^ 2 := by nlinarith
  have hstrict : cubeEnergy S <
      (Real.sqrt (p : ℝ) - 1) ^ 2 * cubeEnergy S := by
    nlinarith [mul_pos (sub_pos.mpr hfactor) hE]
  exact lt_of_lt_of_le hstrict (cubeEnergy_insert S hS hprime p hp hps)

end

end BuildingBlocks.FinitePrimeFutureConeEnergy
