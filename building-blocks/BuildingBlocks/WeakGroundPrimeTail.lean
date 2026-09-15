import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.Normed.Group.InfiniteSum
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic

/-! The actual all-prime-power majorant for exponential weak ground tests.
No prime-density replacement, PNT premise, or zero-free assumption is used. -/
namespace BuildingBlocks.WeakGroundPrimeTail
open Complex LSeries
open MeasureTheory
open scoped ArithmeticFunction.vonMangoldt

theorem shifted_exponential_bound (v x β : ℝ) (hx : 1 ≤ x) (hβ : 0 ≤ β) :
    Real.exp (-β * |v + Real.log x|) ≤ Real.exp (β * |v|) / x ^ β := by
  have hl : Real.log x ≤ |v + Real.log x| + |v| := by
    calc
      Real.log x = |(v + Real.log x) - v| := by
        simp [abs_of_nonneg (Real.log_nonneg hx)]
      _ ≤ _ := by simpa using abs_sub_le (v + Real.log x) 0 v
  have hm := mul_le_mul_of_nonneg_left hl hβ
  rw [Real.rpow_def_of_pos (lt_of_lt_of_le zero_lt_one hx), ← Real.exp_sub]
  apply Real.exp_le_exp.mpr
  nlinarith

theorem shifted_exponential_bound_minus (v x β : ℝ) (hx : 1 ≤ x) (hβ : 0 ≤ β) :
    Real.exp (-β * |v - Real.log x|) ≤ Real.exp (β * |v|) / x ^ β := by
  have h := shifted_exponential_bound (-v) x β hx hβ
  have he : -v + Real.log x = -(v - Real.log x) := by ring
  simpa only [he, abs_neg] using h

noncomputable def shift (side : Bool) (x v : ℝ) : ℝ :=
  if side then v + Real.log x else v - Real.log x

theorem shifted_exponential_bound_both (side : Bool) (v x β : ℝ)
    (hx : 1 ≤ x) (hβ : 0 ≤ β) :
    Real.exp (-β * |shift side x v|) ≤ Real.exp (β * |v|) / x ^ β := by
  cases side
  · exact shifted_exponential_bound_minus v x β hx hβ
  · exact shifted_exponential_bound v x β hx hβ

theorem exponential_overlap_integrable_bound (μ : Measure ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) (side : Bool) (x β C : ℝ)
    (hx : 1 ≤ x) (hβ : 0 ≤ β) (hC : 0 ≤ C)
    (hG : ∀ v, 0 ≤ G v)
    (hz : ∀ v, ‖z v‖ ≤ C * Real.exp (-β * |v|))
    (hm : Integrable (fun v => Real.exp (β * |v|) * G v) μ)
    (hmeas : AEStronglyMeasurable (fun v => G v • z (shift side x v)) μ) :
    Integrable (fun v => G v • z (shift side x v)) μ ∧
      (∫ v, ‖G v • z (shift side x v)‖ ∂μ) ≤
        C * (∫ v, Real.exp (β * |v|) * G v ∂μ) / x ^ β ∧
      ‖∫ v, G v • z (shift side x v) ∂μ‖ ≤
        C * (∫ v, Real.exp (β * |v|) * G v ∂μ) / x ^ β := by
  have hg := hm.const_mul (C / x ^ β)
  have hb : ∀ v, ‖G v • z (shift side x v)‖ ≤
      (C / x ^ β) * (Real.exp (β * |v|) * G v) := by
    intro v
    rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg (hG v)]
    calc
      _ ≤ G v * (C * Real.exp (-β * |shift side x v|)) :=
        mul_le_mul_of_nonneg_left (hz _) (hG v)
      _ ≤ G v * (C * (Real.exp (β * |v|) / x ^ β)) :=
        mul_le_mul_of_nonneg_left
          (mul_le_mul_of_nonneg_left (shifted_exponential_bound_both side v x β hx hβ) hC)
          (hG v)
      _ = _ := by ring
  have hf := hg.mono' hmeas (Filter.Eventually.of_forall hb)
  have hi := integral_mono_ae hf.norm hg (Filter.Eventually.of_forall hb)
  rw [integral_const_mul] at hi
  have hn : (∫ v, ‖G v • z (shift side x v)‖ ∂μ) ≤
      C * (∫ v, Real.exp (β * |v|) * G v ∂μ) / x ^ β := by
    convert hi using 1
    ring
  exact ⟨hf, hn, (norm_integral_le_integral_norm _).trans hn⟩

theorem summable_log_div_rpow {s : ℝ} (hs : 1 < s) :
    Summable (fun n : ℕ => Real.log n / (n : ℝ) ^ s) := by
  have h : LSeriesSummable (logMul (1 : ℕ → ℂ)) (s : ℂ) :=
    LSeriesSummable_logMul_of_lt_re (by
      simp only [abscissaOfAbsConv_one, ofReal_re]
      exact_mod_cast hs)
  apply h.norm.congr
  intro n
  rw [norm_term_eq]
  by_cases hn : n = 0
  · simp [hn]
  · have hl : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by
      exact_mod_cast (Nat.one_le_iff_ne_zero.mpr hn))
    simp [hn, logMul, ← natCast_log, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg hl]

theorem summable_vonMangoldt_div_rpow {s : ℝ} (hs : 1 < s) :
    Summable (fun n : ℕ => Λ n / (n : ℝ) ^ s) := by
  apply (summable_log_div_rpow hs).of_nonneg_of_le
  · intro n
    exact div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Real.rpow_nonneg n.cast_nonneg s)
  · intro n
    exact div_le_div_of_nonneg_right ArithmeticFunction.vonMangoldt_le_log
      (Real.rpow_nonneg n.cast_nonneg s)

theorem exponential_majorant_summable {β : ℝ} (hβ : 1 / 2 < β) :
    Summable (fun n : ℕ => Λ n / (n : ℝ) ^ (β + 1 / 2)) := by
  apply summable_vonMangoldt_div_rpow
  linarith

theorem summable_weighted_overlaps {β C : ℝ} (hβ : 1 / 2 < β)
    (a : {n : ℕ // 2 ≤ n} → ℂ)
    (ha : ∀ n, ‖a n‖ ≤ C / (n.val : ℝ) ^ β) :
    Summable (fun n => (Λ n.val / Real.sqrt n.val) • a n) := by
  apply Summable.of_norm_bounded
    (((exponential_majorant_summable hβ).mul_left C).subtype (fun n => 2 ≤ n))
  intro n
  have hn : 0 < (n.val : ℝ) := by exact_mod_cast (lt_of_lt_of_le (by norm_num : 0 < 2) n.property)
  have hc : 0 ≤ Λ n.val / Real.sqrt n.val :=
    div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Real.sqrt_nonneg _)
  rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg hc]
  calc
    _ ≤ (Λ n.val / Real.sqrt n.val) * (C / (n.val : ℝ) ^ β) :=
      mul_le_mul_of_nonneg_left (ha n) hc
    _ = C * (Λ n.val / (n.val : ℝ) ^ (β + 1 / 2)) := by
      rw [Real.rpow_add hn, Real.sqrt_eq_rpow]
      simp only [div_eq_mul_inv, mul_inv_rev]
      ring

theorem summable_absolute_weighted_overlaps {β C : ℝ} (hβ : 1 / 2 < β)
    (a : {n : ℕ // 2 ≤ n} → ℂ)
    (ha : ∀ n, ‖a n‖ ≤ C / (n.val : ℝ) ^ β) :
    Summable (fun n => ‖(Λ n.val / Real.sqrt n.val) • a n‖) :=
  (summable_weighted_overlaps hβ a ha).norm

theorem summable_absolute_ground_prime_integrals (μ : Measure ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) (side : Bool) (β C : ℝ)
    (hβ : 1 / 2 < β) (hC : 0 ≤ C)
    (hG : ∀ v, 0 ≤ G v)
    (hz : ∀ v, ‖z v‖ ≤ C * Real.exp (-β * |v|))
    (hm : Integrable (fun v => Real.exp (β * |v|) * G v) μ)
    (hmeas : ∀ n : {n : ℕ // 2 ≤ n},
      AEStronglyMeasurable (fun v => G v • z (shift side n.val v)) μ) :
    Summable (fun n : {n : ℕ // 2 ≤ n} =>
      (Λ n.val / Real.sqrt n.val) * (∫ v, ‖G v • z (shift side n.val v)‖ ∂μ)) := by
  let M := C * (∫ v, Real.exp (β * |v|) * G v ∂μ)
  apply Summable.of_norm_bounded
    (((exponential_majorant_summable hβ).mul_left M).subtype (fun n => 2 ≤ n))
  intro n
  have hx : 1 ≤ (n.val : ℝ) := by exact_mod_cast (le_trans (by norm_num : 1 ≤ 2) n.property)
  have hp : 0 < (n.val : ℝ) := lt_of_lt_of_le zero_lt_one hx
  have hc : 0 ≤ Λ n.val / Real.sqrt n.val :=
    div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Real.sqrt_nonneg _)
  have hn : 0 ≤ ∫ v, ‖G v • z (shift side n.val v)‖ ∂μ :=
    integral_nonneg (fun _ => norm_nonneg _)
  rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg hc hn)]
  have hb := (exponential_overlap_integrable_bound μ G z side n.val β C hx
    (by linarith) hC hG hz hm (hmeas n)).2.1
  calc
    _ ≤ (Λ n.val / Real.sqrt n.val) * (M / (n.val : ℝ) ^ β) :=
      mul_le_mul_of_nonneg_left hb hc
    _ = M * (Λ n.val / (n.val : ℝ) ^ (β + 1 / 2)) := by
      rw [Real.rpow_add hp, Real.sqrt_eq_rpow]
      simp only [div_eq_mul_inv, mul_inv_rev]
      ring

theorem summable_complete_ground_prime_integrals (μ : Measure ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) (β C : ℝ)
    (hβ : 1 / 2 < β) (hC : 0 ≤ C)
    (hG : ∀ v, 0 ≤ G v)
    (hz : ∀ v, ‖z v‖ ≤ C * Real.exp (-β * |v|))
    (hm : Integrable (fun v => Real.exp (β * |v|) * G v) μ)
    (hmeas : ∀ side : Bool, ∀ n : {n : ℕ // 2 ≤ n},
      AEStronglyMeasurable (fun v => G v • z (shift side n.val v)) μ) :
    Summable (fun n : {n : ℕ // 2 ≤ n} =>
      (Λ n.val / Real.sqrt n.val) *
        ((∫ v, ‖G v • z (shift true n.val v)‖ ∂μ) +
         (∫ v, ‖G v • z (shift false n.val v)‖ ∂μ))) := by
  have hp := summable_absolute_ground_prime_integrals μ G z true β C
    hβ hC hG hz hm (hmeas true)
  have hn := summable_absolute_ground_prime_integrals μ G z false β C
    hβ hC hG hz hm (hmeas false)
  apply (hp.add hn).congr
  intro n
  ring

#print axioms summable_log_div_rpow
#print axioms shifted_exponential_bound
#print axioms shifted_exponential_bound_minus
#print axioms summable_vonMangoldt_div_rpow
#print axioms exponential_majorant_summable
#print axioms summable_weighted_overlaps
#print axioms summable_absolute_weighted_overlaps
#print axioms shifted_exponential_bound_both
#print axioms exponential_overlap_integrable_bound
#print axioms summable_absolute_ground_prime_integrals
#print axioms summable_complete_ground_prime_integrals
end BuildingBlocks.WeakGroundPrimeTail
