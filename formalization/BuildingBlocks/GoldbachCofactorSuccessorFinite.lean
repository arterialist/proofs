import BuildingBlocks.GoldbachCofactorVolterraFinite
import Mathlib.NumberTheory.Harmonic.Bounds
import Mathlib.Tactic

/-!
# One-step law for the signed Goldbach cofactor

The new endpoint and every centered prime-power birth remain explicit.
No estimate on the actual signed sum is assumed.
-/

namespace BuildingBlocks.GoldbachCofactorSuccessorFinite

open Finset Real Classical
open scoped BigOperators
open BuildingBlocks.GoldbachCofactorVolterraFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def ratioError (y : ℕ) : ℝ := primeError y / (y : ℝ)

def cofactorConvolution (s : ℕ) : ℝ :=
  ∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s - m)

theorem cofactorConvolution_eq_signed (s : ℕ) :
    cofactorConvolution s =
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s := by
  unfold cofactorConvolution
  rw [BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError]
  apply Finset.sum_congr rfl
  intro m hm
  unfold ratioError primeError
  ring

/-- The complete integer prime error changes by the actual
von Mangoldt birth minus one. -/
theorem primeError_succ (y : ℕ) :
    primeError (y + 1) - primeError y = Λ (y + 1) - 1 := by
  unfold primeError
  rw [BuildingBlocks.CoarsePrimitive.psi_succ]
  push_cast
  ring

/-- Exact rational one-step change, including the derivative of the
cofactor denominator. -/
theorem ratioError_succ (y : ℕ) (hy : 1 ≤ y) :
    ratioError (y + 1) - ratioError y =
      (Λ (y + 1) - 1) / ((y + 1 : ℕ) : ℝ) -
        primeError y / ((y : ℝ) * ((y + 1 : ℕ) : ℝ)) := by
  have hy0 : (y : ℝ) ≠ 0 := by
    exact_mod_cast (show y ≠ 0 by omega)
  have hy10 : (((y + 1 : ℕ) : ℝ)) ≠ 0 := by positivity
  have hstep : primeError (y + 1) =
      primeError y + (Λ (y + 1) - 1) := by
    linarith [primeError_succ y]
  unfold ratioError
  rw [hstep]
  push_cast
  field_simp
  ring

/-- Advancing the additive horizon appends the pair with second leg
two, then advances each old complementary error ratio by one. -/
theorem cofactorConvolution_succ (s : ℕ) (hs : 4 ≤ s) :
    cofactorConvolution (s + 1) - cofactorConvolution s =
      Λ (s - 1) * ratioError 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * (ratioError (s + 1 - m) - ratioError (s - m)) := by
  have hupper : s + 1 - 2 = (s - 2) + 1 := by omega
  have hend : (s - 2) + 1 = s - 1 := by omega
  have hsecond : s + 1 - (s - 1) = 2 := by omega
  unfold cofactorConvolution
  rw [hupper, Finset.sum_Icc_succ_top (by omega : 2 ≤ (s - 2) + 1)]
  rw [hend, hsecond]
  have hrow :
      (∑ m ∈ Icc 2 (s - 2),
        (Λ m * ratioError (s + 1 - m) - Λ m * ratioError (s - m))) =
      ∑ m ∈ Icc 2 (s - 2),
        Λ m * (ratioError (s + 1 - m) - ratioError (s - m)) := by
    apply Finset.sum_congr rfl
    intro m hm
    ring
  calc
    (∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s + 1 - m)) +
          Λ (s - 1) * ratioError 2 -
          ∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s - m) =
        Λ (s - 1) * ratioError 2 +
          ((∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s + 1 - m)) -
            ∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s - m)) := by ring
    _ = Λ (s - 1) * ratioError 2 +
          ∑ m ∈ Icc 2 (s - 2),
            (Λ m * ratioError (s + 1 - m) - Λ m * ratioError (s - m)) := by
          rw [← Finset.sum_sub_distrib]
    _ = _ := by rw [hrow]

/-- The one-step source law for the literal signed correction. -/
theorem signedCofactorError_succ (s : ℕ) (hs : 4 ≤ s) :
    BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError (s + 1) -
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s =
      Λ (s - 1) * ratioError 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * (ratioError (s + 1 - m) - ratioError (s - m)) := by
  rw [← cofactorConvolution_eq_signed (s + 1),
    ← cofactorConvolution_eq_signed s]
  exact cofactorConvolution_succ s hs

/-- The expanded one-step source law keeps the new two-leg endpoint,
each actual new von Mangoldt birth, and the changing denominator. -/
theorem signedCofactorError_succ_expanded (s : ℕ) (hs : 4 ≤ s) :
    BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError (s + 1) -
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s =
      Λ (s - 1) * ratioError 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * ((Λ (s + 1 - m) - 1) / ((s + 1 - m : ℕ) : ℝ) -
            primeError (s - m) /
              (((s - m : ℕ) : ℝ) * ((s + 1 - m : ℕ) : ℝ))) := by
  rw [signedCofactorError_succ s hs]
  congr 1
  apply Finset.sum_congr rfl
  intro m hm
  have hmle : m ≤ s - 2 := (mem_Icc.mp hm).2
  have hy : 1 ≤ s - m := by omega
  have hstep : s + 1 - m = (s - m) + 1 := by omega
  rw [hstep, ratioError_succ (s - m) hy]

/-- Chebyshev's compiled linear bound controls the complete centered
prime error, with no truncation of proper powers. -/
theorem abs_primeError_le_linear (y : ℕ) :
    |primeError y| ≤ (4 * Real.log 2 + 1) * (y : ℝ) := by
  have hψ0 := BuildingBlocks.CoarsePrimitive.psi_nonneg y
  have hψle := BuildingBlocks.CoarsePrimitive.psi_le_linear y
  have hy0 : 0 ≤ (y : ℝ) := Nat.cast_nonneg _
  have hlog : 0 ≤ Real.log 2 := Real.log_nonneg (by norm_num)
  unfold primeError
  apply abs_le.mpr
  constructor <;> nlinarith

/-- A complete centered error ratio changes by at most a harmonic
weight, with the actual von Mangoldt birth retained. -/
theorem ratioError_step_abs_le (y s : ℕ) (hy : 1 ≤ y)
    (hys : y + 1 ≤ s) :
    |ratioError (y + 1) - ratioError y| ≤
      (Real.log (s : ℝ) + 4 * Real.log 2 + 2) /
        (((y + 1 : ℕ) : ℝ)) := by
  have hypos : 0 < (y : ℝ) := by exact_mod_cast (show 0 < y by omega)
  have hdpos : 0 < (((y + 1 : ℕ) : ℝ)) := by positivity
  have hdpos' : 0 < (y : ℝ) + 1 := by positivity
  have hΛ0 : 0 ≤ Λ (y + 1) := ArithmeticFunction.vonMangoldt_nonneg
  have hΛle : Λ (y + 1) ≤ Real.log (s : ℝ) :=
    ArithmeticFunction.vonMangoldt_le_log.trans
      (Real.log_le_log hdpos (by exact_mod_cast hys))
  have habsΛ : |Λ (y + 1) - 1| ≤ Λ (y + 1) + 1 := by
    simpa [abs_of_nonneg hΛ0] using
      (abs_sub_le (Λ (y + 1)) (0 : ℝ) (1 : ℝ))
  have hE := abs_primeError_le_linear y
  have hden : 0 < (y : ℝ) * (((y + 1 : ℕ) : ℝ)) :=
    mul_pos hypos hdpos
  rw [ratioError_succ y hy]
  calc
    |(Λ (y + 1) - 1) / (((y + 1 : ℕ) : ℝ)) -
        primeError y / ((y : ℝ) * (((y + 1 : ℕ) : ℝ)))| ≤
      |Λ (y + 1) - 1| / (((y + 1 : ℕ) : ℝ)) +
        |primeError y| / ((y : ℝ) * (((y + 1 : ℕ) : ℝ))) := by
      simpa [Nat.cast_add, abs_div, abs_mul,
        abs_of_pos hypos, abs_of_pos hdpos'] using
        (abs_sub_le
          ((Λ (y + 1) - 1) / (((y + 1 : ℕ) : ℝ)))
          (0 : ℝ)
          (primeError y / ((y : ℝ) * (((y + 1 : ℕ) : ℝ)))))
    _ ≤ (Λ (y + 1) + 1) / (((y + 1 : ℕ) : ℝ)) +
          ((4 * Real.log 2 + 1) * (y : ℝ)) /
            ((y : ℝ) * (((y + 1 : ℕ) : ℝ))) := by
      exact add_le_add (div_le_div_of_nonneg_right habsΛ hdpos.le)
        (div_le_div_of_nonneg_right hE hden.le)
    _ = (Λ (y + 1) + 4 * Real.log 2 + 2) /
          (((y + 1 : ℕ) : ℝ)) := by
      field_simp
      ring
    _ ≤ _ := div_le_div_of_nonneg_right (by linarith) hdpos.le

/-- Reversing the complementary horizon turns its reciprocal costs
into a subrow of the ordinary harmonic sum. -/
theorem reciprocal_complement_le_harmonic (s : ℕ) (hs : 4 ≤ s) :
    (∑ m ∈ Icc 2 (s - 2),
      ((((s + 1 - m : ℕ) : ℝ))⁻¹)) ≤ (harmonic s : ℝ) := by
  have hreverse :
      (∑ m ∈ Icc 2 (s - 2),
        ((((s + 1 - m : ℕ) : ℝ))⁻¹)) =
      ∑ y ∈ Icc 3 (s - 1), ((y : ℝ)⁻¹) := by
    apply Finset.sum_bij (fun m _ => s + 1 - m)
    · intro m hm
      simp only [mem_Icc] at hm ⊢
      omega
    · intro m hm n hn hmn
      simp only [mem_Icc] at hm hn
      omega
    · intro y hy
      simp only [mem_Icc] at hy
      refine ⟨s + 1 - y, ?_, ?_⟩
      · simp only [mem_Icc]
        omega
      · omega
    · intro m hm
      rfl
  have hsubset : Icc 3 (s - 1) ⊆ Icc 1 s := by
    intro y hy
    simp only [mem_Icc] at hy ⊢
    omega
  have hsum :
      (∑ y ∈ Icc 3 (s - 1), ((y : ℝ)⁻¹)) ≤
        ∑ y ∈ Icc 1 s, ((y : ℝ)⁻¹) := by
    exact Finset.sum_le_sum_of_subset_of_nonneg hsubset
      (by intro y hy hnot; positivity)
  rw [hreverse]
  simpa only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv,
    Rat.cast_natCast] using hsum

/-- The complete actual signed cofactor changes by at most a cubic
logarithmic envelope in one integer step.  This is a local bound, not
a bound for the cofactor itself. -/
theorem signedCofactorError_step_abs_le (s : ℕ) (hs : 4 ≤ s) :
    |BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError (s + 1) -
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s| ≤
      Real.log (s : ℝ) *
        (|ratioError 2| +
          (Real.log (s : ℝ) + 4 * Real.log 2 + 2) *
            (1 + Real.log (s : ℝ))) := by
  let L : ℝ := Real.log (s : ℝ)
  let B : ℝ := L + 4 * Real.log 2 + 2
  have hspos : 0 < (s : ℝ) := by exact_mod_cast (show 0 < s by omega)
  have hsone : 1 ≤ (s : ℝ) := by exact_mod_cast (show 1 ≤ s by omega)
  have hL : 0 ≤ L := Real.log_nonneg hsone
  have hB : 0 ≤ B := by
    dsimp [B]
    have hlog2 : 0 ≤ Real.log 2 := Real.log_nonneg (by norm_num)
    positivity
  have hend : |Λ (s - 1) * ratioError 2| ≤ L * |ratioError 2| := by
    have hΛ0 : 0 ≤ Λ (s - 1) := ArithmeticFunction.vonMangoldt_nonneg
    have hΛle : Λ (s - 1) ≤ L :=
      ArithmeticFunction.vonMangoldt_le_log.trans
        (Real.log_le_log
          (by exact_mod_cast (show 0 < s - 1 by omega))
          (by exact_mod_cast (show s - 1 ≤ s by omega)))
    rw [abs_mul, abs_of_nonneg hΛ0]
    exact mul_le_mul_of_nonneg_right hΛle (abs_nonneg _)
  have hterm : ∀ m ∈ Icc 2 (s - 2),
      |Λ m * (ratioError (s + 1 - m) - ratioError (s - m))| ≤
        L * (B / (((s + 1 - m : ℕ) : ℝ))) := by
    intro m hm
    obtain ⟨hm2, hmle⟩ := mem_Icc.mp hm
    have hΛ0 : 0 ≤ Λ m := ArithmeticFunction.vonMangoldt_nonneg
    have hΛle : Λ m ≤ L :=
      ArithmeticFunction.vonMangoldt_le_log.trans
        (Real.log_le_log
          (by exact_mod_cast (show 0 < m by omega))
          (by exact_mod_cast (show m ≤ s by omega)))
    have hy : 1 ≤ s - m := by omega
    have hys : (s - m) + 1 ≤ s := by omega
    have hstep : s + 1 - m = (s - m) + 1 := by omega
    have hden : 0 < (((s + 1 - m : ℕ) : ℝ)) := by
      exact_mod_cast (show 0 < s + 1 - m by omega)
    have hratio := ratioError_step_abs_le (s - m) s hy hys
    rw [← hstep] at hratio
    have hbound : |ratioError (s + 1 - m) - ratioError (s - m)| ≤
        B / (((s + 1 - m : ℕ) : ℝ)) := by
      simpa [B, L] using hratio
    calc
      |Λ m * (ratioError (s + 1 - m) - ratioError (s - m))| =
          Λ m * |ratioError (s + 1 - m) - ratioError (s - m)| := by
            rw [abs_mul, abs_of_nonneg hΛ0]
      _ ≤ Λ m * (B / (((s + 1 - m : ℕ) : ℝ))) :=
        mul_le_mul_of_nonneg_left hbound hΛ0
      _ ≤ L * (B / (((s + 1 - m : ℕ) : ℝ))) :=
        mul_le_mul_of_nonneg_right hΛle (div_nonneg hB hden.le)
  have hsum :
      |∑ m ∈ Icc 2 (s - 2),
          Λ m * (ratioError (s + 1 - m) - ratioError (s - m))| ≤
        L * B * (harmonic s : ℝ) := by
    calc
      _ ≤ ∑ m ∈ Icc 2 (s - 2),
          |Λ m * (ratioError (s + 1 - m) - ratioError (s - m))| :=
        Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ m ∈ Icc 2 (s - 2),
          L * (B / (((s + 1 - m : ℕ) : ℝ))) :=
        Finset.sum_le_sum hterm
      _ = L * B * (∑ m ∈ Icc 2 (s - 2),
          ((((s + 1 - m : ℕ) : ℝ))⁻¹)) := by
            calc
              (∑ m ∈ Icc 2 (s - 2),
                  L * (B / (((s + 1 - m : ℕ) : ℝ)))) =
                  L * (∑ m ∈ Icc 2 (s - 2),
                    B / (((s + 1 - m : ℕ) : ℝ))) := by rw [Finset.mul_sum]
              _ = L * (B * (∑ m ∈ Icc 2 (s - 2),
                    ((((s + 1 - m : ℕ) : ℝ))⁻¹))) := by
                      congr 1
                      rw [Finset.mul_sum]
                      apply Finset.sum_congr rfl
                      intro m hm
                      rw [div_eq_mul_inv]
              _ = L * B * (∑ m ∈ Icc 2 (s - 2),
                    ((((s + 1 - m : ℕ) : ℝ))⁻¹)) := by ring
      _ ≤ L * B * (harmonic s : ℝ) := by
        exact mul_le_mul_of_nonneg_left
          (reciprocal_complement_le_harmonic s hs)
          (mul_nonneg hL hB)
  rw [signedCofactorError_succ s hs]
  have htri := abs_add_le (Λ (s - 1) * ratioError 2)
    (∑ m ∈ Icc 2 (s - 2),
      Λ m * (ratioError (s + 1 - m) - ratioError (s - m)))
  have hH := harmonic_le_one_add_log s
  have hHmul : L * B * (harmonic s : ℝ) ≤ L * B * (1 + L) :=
    mul_le_mul_of_nonneg_left hH (mul_nonneg hL hB)
  dsimp [L, B] at *
  nlinarith

#print axioms cofactorConvolution_eq_signed
#print axioms primeError_succ
#print axioms ratioError_succ
#print axioms cofactorConvolution_succ
#print axioms signedCofactorError_succ
#print axioms signedCofactorError_succ_expanded
#print axioms abs_primeError_le_linear
#print axioms ratioError_step_abs_le
#print axioms reciprocal_complement_le_harmonic
#print axioms signedCofactorError_step_abs_le

end
end BuildingBlocks.GoldbachCofactorSuccessorFinite
