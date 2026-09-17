import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Tactic

/-!
# The complete logarithmic pair correction in literal Goldbach succession

The finite double sum is the logarithmic term in the exact transport
loss. Symmetry reduces it to one complete von Mangoldt cofactor row,
with both ordered orientations and all prime powers retained.
-/

namespace BuildingBlocks.GoldbachSuccessorLogFinite

open Finset Real Classical
open scoped BigOperators

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def cofactor (s m : ℕ) : ℝ :=
  ∑ n ∈ Icc 2 s, if m + n ≤ s then Λ n else 0

def logLeg (s m : ℕ) : ℝ :=
  Real.log ((s - m : ℕ) : ℝ) - Real.log (m : ℝ)

def logPair (s m n : ℕ) : ℝ := logLeg s m + logLeg s n

def logEscapeNumerator (s : ℕ) : ℝ :=
  ∑ m ∈ Icc 2 s, ∑ n ∈ Icc 2 s,
    if m + n ≤ s then Λ m * Λ n * logPair s m n else 0

def logEscape (s : ℕ) : ℝ :=
  logEscapeNumerator s / (s : ℝ) ^ 2

def signedCofactorError (s : ℕ) : ℝ :=
  ∑ m ∈ Icc 2 (s - 2),
    Λ m * (BuildingBlocks.CoarsePrimitive.psi (s - m) - ((s - m : ℕ) : ℝ)) /
      ((s - m : ℕ) : ℝ)

/-- The split logarithm is nonnegative on the admitted additive
triangle, including its contact boundary. -/
theorem logPair_nonneg {s m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n)
    (had : m + n ≤ s) : 0 ≤ logPair s m n := by
  have hnm : n ≤ s - m := by omega
  have hmn : m ≤ s - n := by omega
  have hlog1 : Real.log (n : ℝ) ≤ Real.log ((s - m : ℕ) : ℝ) :=
    Real.log_le_log (by exact_mod_cast (show 0 < n by omega))
      (by exact_mod_cast hnm)
  have hlog2 : Real.log (m : ℝ) ≤ Real.log ((s - n : ℕ) : ℝ) :=
    Real.log_le_log (by exact_mod_cast (show 0 < m by omega))
      (by exact_mod_cast hmn)
  unfold logPair logLeg
  linarith

/-- On the admitted triangle, the split logarithm is the literal
logarithmic factor of the transported pair-escape probability. -/
theorem logPair_eq_log_ratio {s m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n)
    (had : m + n ≤ s) :
    logPair s m n =
      Real.log
        ((((s - m : ℕ) : ℝ) * ((s - n : ℕ) : ℝ)) /
          ((m : ℝ) * (n : ℝ))) := by
  have hsm : 0 < ((s - m : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < s - m by omega)
  have hsn : 0 < ((s - n : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < s - n by omega)
  have hmp : 0 < (m : ℝ) := by exact_mod_cast (show 0 < m by omega)
  have hnp : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  rw [Real.log_div (mul_ne_zero (ne_of_gt hsm) (ne_of_gt hsn))
    (mul_ne_zero (ne_of_gt hmp) (ne_of_gt hnp)),
    Real.log_mul (ne_of_gt hsm) (ne_of_gt hsn),
    Real.log_mul (ne_of_gt hmp) (ne_of_gt hnp)]
  unfold logPair logLeg
  ring

/-- The actual complete-prime-power logarithmic loss is nonnegative
at every finite additive horizon. -/
theorem logEscape_nonneg (s : ℕ) : 0 ≤ logEscape s := by
  unfold logEscape logEscapeNumerator
  apply div_nonneg
  · apply Finset.sum_nonneg
    intro m hm
    apply Finset.sum_nonneg
    intro n hn
    split_ifs with had
    · have hΛm : 0 ≤ Λ m := ArithmeticFunction.vonMangoldt_nonneg
      have hΛn : 0 ≤ Λ n := ArithmeticFunction.vonMangoldt_nonneg
      exact mul_nonneg (mul_nonneg hΛm hΛn)
        (logPair_nonneg (mem_Icc.mp hm).1 (mem_Icc.mp hn).1 had)
    · exact le_refl _
  · positivity

/-- The complete von Mangoldt cofactor row through the additive
endpoint is the Chebyshev sum at the complementary horizon. -/
theorem cofactor_eq_psi (s m : ℕ) (hm : m ≤ s) :
    cofactor s m = BuildingBlocks.CoarsePrimitive.psi (s - m) := by
  have hset : (Icc 2 s).filter (fun n => m + n ≤ s) = Icc 2 (s - m) := by
    ext n
    simp only [mem_filter, mem_Icc]
    omega
  have hsum : cofactor s m = ∑ n ∈ Icc 2 (s - m), Λ n := by
    unfold cofactor
    rw [← Finset.sum_filter, hset]
  rw [hsum, BuildingBlocks.CoarsePrimitive.psi_eq_sum_Icc]
  have hsubset : Icc 2 (s - m) ⊆ Icc 1 (s - m) := by
    intro n hn
    obtain ⟨h2, hupper⟩ := mem_Icc.mp hn
    exact mem_Icc.mpr ⟨by omega, hupper⟩
  apply Finset.sum_subset hsubset
  intro n hn hn2
  have hn1 : n = 1 := by
    have h1 := (mem_Icc.mp hn).1
    have hnot : ¬ 2 ≤ n := by
      intro h
      exact hn2 (mem_Icc.mpr ⟨h, (mem_Icc.mp hn).2⟩)
    omega
  subst n
  simp [Λ]

/-- The two ordered logarithmic legs contribute the same cofactor
row. No sign or asymptotic estimate is used. -/
theorem logEscapeNumerator_eq_cofactor (s : ℕ) :
    logEscapeNumerator s =
      2 * ∑ m ∈ Icc 2 s, Λ m * cofactor s m * logLeg s m := by
  let A : ℕ → ℕ → ℝ := fun m n =>
    if m + n ≤ s then Λ m * Λ n * logLeg s m else 0
  let B : ℕ → ℕ → ℝ := fun m n =>
    if m + n ≤ s then Λ m * Λ n * logLeg s n else 0
  have hsplit :
      logEscapeNumerator s =
        (∑ m ∈ Icc 2 s, ∑ n ∈ Icc 2 s, A m n) +
          ∑ m ∈ Icc 2 s, ∑ n ∈ Icc 2 s, B m n := by
    unfold logEscapeNumerator A B logPair
    simp only [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    split_ifs <;> ring
  have hswap :
      (∑ m ∈ Icc 2 s, ∑ n ∈ Icc 2 s, B m n) =
        ∑ m ∈ Icc 2 s, ∑ n ∈ Icc 2 s, A m n := by
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    unfold A B
    rw [Nat.add_comm n m]
    split_ifs <;> ring
  have hfactor :
      (∑ m ∈ Icc 2 s, ∑ n ∈ Icc 2 s, A m n) =
        ∑ m ∈ Icc 2 s, Λ m * cofactor s m * logLeg s m := by
    apply Finset.sum_congr rfl
    intro m hm
    unfold cofactor
    rw [Finset.mul_sum]
    simp only [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro n hn
    unfold A
    split_ifs <;> ring
  rw [hsplit, hswap, hfactor]
  ring

/-- The finite logarithmic transport correction is exactly one
Chebyshev-weighted additive convolution. -/
theorem logEscapeNumerator_eq_psi (s : ℕ) :
    logEscapeNumerator s =
      2 * ∑ m ∈ Icc 2 s,
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m := by
  rw [logEscapeNumerator_eq_cofactor]
  congr 1
  apply Finset.sum_congr rfl
  intro m hm
  rw [cofactor_eq_psi s m (mem_Icc.mp hm).2]

theorem logEscape_eq_psi (s : ℕ) :
    logEscape s =
      (2 * ∑ m ∈ Icc 2 s,
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m) /
        (s : ℝ) ^ 2 := by
  rw [logEscape, logEscapeNumerator_eq_psi]

/-- The final two cofactor horizons have zero von Mangoldt mass, so
the exact row ends at the literal additive endpoint `s-2`. -/
theorem logEscape_eq_psi_trim (s : ℕ) (hs : 4 ≤ s) :
    logEscape s =
      (2 * ∑ m ∈ Icc 2 (s - 2),
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m) /
        (s : ℝ) ^ 2 := by
  have hpsi1 : BuildingBlocks.CoarsePrimitive.psi 1 = 0 := by
    rw [BuildingBlocks.CoarsePrimitive.psi_eq_sum_Icc]
    simp
  have hsubset : Icc 2 (s - 2) ⊆ Icc 2 s := by
    intro m hm
    obtain ⟨hm2, hms⟩ := mem_Icc.mp hm
    exact mem_Icc.mpr ⟨hm2, by omega⟩
  have hsum :
      (∑ m ∈ Icc 2 (s - 2),
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m) =
        ∑ m ∈ Icc 2 s,
          Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m := by
    apply Finset.sum_subset hsubset
    intro m hm hm2
    have hsmall : s - m = 0 ∨ s - m = 1 := by
      have hle := (mem_Icc.mp hm).2
      have hn : ¬ m ≤ s - 2 := by
        intro h
        exact hm2 (mem_Icc.mpr ⟨(mem_Icc.mp hm).1, h⟩)
      omega
    rcases hsmall with h | h
    · simp [h, BuildingBlocks.CoarsePrimitive.psi]
    · simp [h, hpsi1]
  rw [logEscape_eq_psi, hsum]

/-- The rational cofactor in the literal pair loss separates into
its ordinary counting mass and the complete signed Chebyshev error. -/
theorem rationalCofactor_eq_baseline_add_error (s : ℕ) (hs : 4 ≤ s) :
    (∑ m ∈ Icc 2 (s - 2),
      Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) /
        ((s - m : ℕ) : ℝ)) =
      BuildingBlocks.CoarsePrimitive.psi (s - 2) + signedCofactorError s := by
  have hsumpsi :
      (∑ m ∈ Icc 2 (s - 2), Λ m) =
        BuildingBlocks.CoarsePrimitive.psi (s - 2) := by
    have hcof : cofactor (s - 2) 0 = ∑ m ∈ Icc 2 (s - 2), Λ m := by
      unfold cofactor
      apply Finset.sum_congr rfl
      intro m hm
      simp [(mem_Icc.mp hm).2]
    rw [← hcof, cofactor_eq_psi (s - 2) 0 (Nat.zero_le _)]
    simp
  rw [← hsumpsi]
  unfold signedCofactorError
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  have hpos : 0 < ((s - m : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < s - m by
      have := (mem_Icc.mp hm).2
      omega)
  field_simp
  ring

#print axioms cofactor_eq_psi
#print axioms logEscape_nonneg
#print axioms logPair_eq_log_ratio
#print axioms logEscapeNumerator_eq_cofactor
#print axioms logEscapeNumerator_eq_psi
#print axioms logEscape_eq_psi
#print axioms logEscape_eq_psi_trim
#print axioms rationalCofactor_eq_baseline_add_error

end
end BuildingBlocks.GoldbachSuccessorLogFinite
