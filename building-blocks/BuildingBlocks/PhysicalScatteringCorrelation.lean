import BuildingBlocks.FullComplexHistoryMellin
import Mathlib.Analysis.Convolution

open MeasureTheory
namespace BuildingBlocks.PhysicalScatteringCorrelation
open BuildingBlocks.FullComplexHistoryMellin

noncomputable def finiteTranslate {ι : Type*} (s : Finset ι) (c : ι → ℂ)
    (d : ι → ℝ) (f : ℝ → ℂ) (v : ℝ) : ℂ :=
  ∑ i ∈ s, c i * f (v - d i)

noncomputable def correlation (f g : ℝ → ℂ) (x : ℝ) : ℂ :=
  ∫ v : ℝ, g (v + x) * (starRingEnd ℂ) (f v)

theorem correlation_translate (f g : ℝ → ℂ) (a b x : ℝ) :
    correlation (fun v => f (v - a)) (fun v => g (v - b)) x =
      correlation f g (x + a - b) := by
  unfold correlation
  calc
    _ = ∫ v : ℝ, g ((v - a) + (x + a - b)) * (starRingEnd ℂ) (f (v - a)) := by
      apply integral_congr_ae
      filter_upwards [] with v
      congr 2
      ring
    _ = _ := integral_sub_right_eq_self
      (fun v : ℝ => g (v + (x + a - b)) * (starRingEnd ℂ) (f v)) a

theorem correlation_kernel_integrable {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f) (a b x : ℝ) :
    Integrable (fun v => g ((v + x) - b) * (starRingEnd ℂ) (f (v - a))) := by
  have hh : Continuous (fun v => g ((v + x) - b) * (starRingEnd ℂ) (f (v - a))) := by fun_prop
  have hc : HasCompactSupport (fun v => g ((v + x) - b) * (starRingEnd ℂ) (f (v - a))) := by
    apply (BuildingBlocks.CompactScatteringRegularity.shifted_compact hfc a).mono
    intro v hv
    change f (v - a) ≠ 0
    intro he
    exact hv (by simp [he])
  exact hh.integrable_of_hasCompactSupport hc

theorem finite_translate_correlation {ι κ : Type*} (s : Finset ι) (t : Finset κ)
    (c : ι → ℂ) (e : κ → ℂ) (a : ι → ℝ) (b : κ → ℝ) {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f) (x : ℝ) :
    correlation (finiteTranslate s c a f) (finiteTranslate t e b g) x =
      ∑ j ∈ t, ∑ i ∈ s, (e j * (starRingEnd ℂ) (c i)) * correlation f g (x + a i - b j) := by
  have hi (i : ι) (j : κ) : Integrable (fun v =>
      (e j * g ((v + x) - b j)) * ((starRingEnd ℂ) (c i) * (starRingEnd ℂ) (f (v - a i)))) := by
    have ht := (correlation_kernel_integrable hf hg hfc (a i) (b j) x).const_mul
      (e j * (starRingEnd ℂ) (c i))
    convert ht using 1
    funext v
    ring
  unfold correlation finiteTranslate
  simp_rw [map_sum, map_mul, Finset.sum_mul, Finset.mul_sum]
  rw [integral_finset_sum]
  · apply Finset.sum_congr rfl
    intro j _
    rw [integral_finset_sum s (fun i _ => hi i j)]
    apply Finset.sum_congr rfl
    intro i _
    calc
      _ = ∫ v : ℝ, (e j * (starRingEnd ℂ) (c i)) *
          (g ((v + x) - b j) * (starRingEnd ℂ) (f (v - a i))) := by
        apply integral_congr_ae
        filter_upwards [] with v
        ring
      _ = (e j * (starRingEnd ℂ) (c i)) * correlation f g (x + a i - b j) := by
        rw [integral_const_mul]
        change (e j * (starRingEnd ℂ) (c i)) *
          correlation (fun v => f (v - a i)) (fun v => g (v - b j)) x = _
        rw [correlation_translate]
      _ = _ := rfl
  · intro j _
    exact integrable_finset_sum s (fun i _ => hi i j)

noncomputable def arithmeticCutoff (N : ℕ) (f g : ℝ → ℂ) : ℂ :=
  ∑ n ∈ Finset.Icc 2 N,
    ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
      (correlation f g (Real.log (n : ℝ)) +
        (starRingEnd ℂ) (correlation g f (Real.log (n : ℝ))))

theorem finite_translate_arithmetic_cutoff {ι κ : Type*} (s : Finset ι) (t : Finset κ)
    (c : ι → ℂ) (e : κ → ℂ) (a : ι → ℝ) (b : κ → ℝ) {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (N : ℕ) :
    arithmeticCutoff N (finiteTranslate s c a f) (finiteTranslate t e b g) =
      ∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
          ((∑ j ∈ t, ∑ i ∈ s, (e j * (starRingEnd ℂ) (c i)) *
            correlation f g (Real.log (n : ℝ) + a i - b j)) +
            (starRingEnd ℂ) (∑ i ∈ s, ∑ j ∈ t, (c i * (starRingEnd ℂ) (e j)) *
              correlation g f (Real.log (n : ℝ) + b j - a i))) := by
  unfold arithmeticCutoff
  apply Finset.sum_congr rfl
  intro n _
  rw [finite_translate_correlation s t c e a b hf hg hfc,
    finite_translate_correlation t s e c b a hg hf hgc]

theorem observing_prime_power_weight (p m : ℕ) (hp : p.Prime) (hm : 1 ≤ m) :
    ArithmeticFunction.vonMangoldt (p ^ m) = Real.log (p : ℝ) := by
  rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega),
    ArithmeticFunction.vonMangoldt_apply_prime hp]


theorem correlation_reflected_conjugate (f g : ℝ → ℂ) (x : ℝ) :
    (starRingEnd ℂ) (correlation g f x) = correlation f g (-x) := by
  unfold correlation
  rw [← integral_conj]
  calc
    _ = ∫ v : ℝ, g ((v + x) + -x) * (starRingEnd ℂ) (f (v + x)) := by
      apply integral_congr_ae
      filter_upwards [] with v
      simp only [map_mul, Complex.conj_conj]
      rw [show (v + x) + -x = v by ring]
      ring
    _ = _ := by
      simpa only [sub_neg_eq_add] using
        integral_sub_right_eq_self (fun v : ℝ => g (v + -x) * (starRingEnd ℂ) (f v)) (-x)

theorem weighted_correlation_convolution (f g : ℝ → ℂ) (z : ℂ) (x : ℝ) :
    correlation f g x * Complex.exp (z * (x : ℂ)) =
      convolution (fun v : ℝ => (starRingEnd ℂ) (f (-v)) * Complex.exp (z * (v : ℂ)))
        (fun v : ℝ => g v * Complex.exp (z * (v : ℂ)))
        (ContinuousLinearMap.mul ℂ ℂ) volume x := by
  unfold correlation
  rw [← integral_mul_const]
  rw [convolution_def]
  simp only [ContinuousLinearMap.mul_apply']
  calc
    _ = ∫ v : ℝ, (g (-v + x) * (starRingEnd ℂ) (f (-v))) * Complex.exp (z * (x : ℂ)) := by
      exact (integral_neg_eq_self _ volume).symm
    _ = _ := by
      apply integral_congr_ae
      filter_upwards [] with v
      have he : Complex.exp (z * (v : ℂ)) * Complex.exp (z * ((x - v : ℝ) : ℂ)) =
          Complex.exp (z * (x : ℂ)) := by
        rw [← Complex.exp_add]
        congr 1
        push_cast
        ring
      rw [show -v + x = x - v by ring]
      calc
        _ = ((starRingEnd ℂ) (f (-v)) * g (x - v)) *
            (Complex.exp (z * (v : ℂ)) * Complex.exp (z * ((x - v : ℝ) : ℂ))) := by rw [he]; ring
        _ = _ := by ring

theorem weighted_correlation_integrable {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (z : ℂ) :
    Integrable (fun x => correlation f g x * Complex.exp (z * (x : ℂ))) := by
  have hfc' : HasCompactSupport (fun v : ℝ => (starRingEnd ℂ) (f (-v))) := by
    have hr : HasCompactSupport (fun v : ℝ => f (-v)) := by
      simpa [Function.comp_def] using hfc.comp_homeomorph (Homeomorph.neg ℝ)
    exact hr.mono (fun v hv he => hv (by simp [he]))
  have hF := weighted_integrable (by fun_prop : Continuous (fun v : ℝ => (starRingEnd ℂ) (f (-v)))) hfc' z
  have hG := weighted_integrable hg hgc z
  simpa only [weighted_correlation_convolution] using
    hF.integrable_convolution (ContinuousLinearMap.mul ℂ ℂ) hG

theorem correlation_mellin {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (z : ℂ) :
    FullComplexHistoryMellin.mellin (correlation f g) z = pairedWeight g f z := by
  let F : ℝ → ℂ := fun v => (starRingEnd ℂ) (f (-v)) * Complex.exp (z * (v : ℂ))
  let G : ℝ → ℂ := fun v => g v * Complex.exp (z * (v : ℂ))
  have hfc' : HasCompactSupport (fun v : ℝ => (starRingEnd ℂ) (f (-v))) := by
    have hr : HasCompactSupport (fun v : ℝ => f (-v)) := by
      simpa [Function.comp_def] using hfc.comp_homeomorph (Homeomorph.neg ℝ)
    exact hr.mono (fun v hv he => hv (by simp [he]))
  have hF : Integrable F := weighted_integrable (by fun_prop) hfc' z
  have hG : Integrable G := weighted_integrable hg hgc z
  have hIF : (∫ v, F v) = (starRingEnd ℂ) (FullComplexHistoryMellin.mellin f (-((starRingEnd ℂ) z))) := by
    dsimp [F]
    rw [← integral_neg_eq_self _ volume]
    unfold FullComplexHistoryMellin.mellin
    rw [← integral_conj]
    apply integral_congr_ae
    filter_upwards [] with v
    simp only [neg_neg, map_mul, ← Complex.exp_conj]
    congr 1
    congr 1
    simp only [map_neg, Complex.conj_conj, Complex.conj_ofReal, Complex.ofReal_neg]
    ring
  unfold FullComplexHistoryMellin.mellin
  simp_rw [weighted_correlation_convolution]
  rw [integral_convolution (ContinuousLinearMap.mul ℂ ℂ) hF hG]
  change (∫ v, F v) * (∫ v, G v) = _
  rw [hIF]
  exact mul_comm _ _

theorem finite_history_correlation_mellin {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p)
    (M : ℕ) (z : ℂ) :
    FullComplexHistoryMellin.mellin
      (correlation (blockPhysical s.toList M f) (blockPhysical s.toList M g)) z =
      (∏ p ∈ s, GrowingPrimeScatteringBounds.paired p z M) * pairedWeight g f z := by
  have hfr := block_regular hf hfc s.toList M
  have hgr := block_regular hg hgc s.toList M
  rw [correlation_mellin hfr.1 hgr.1 hfr.2 hgr.2]
  exact finite_prime_block_paired_weight hg hf hgc hfc s hs M z

#print axioms finite_history_correlation_mellin
#print axioms correlation_reflected_conjugate
#print axioms correlation_translate
#print axioms correlation_kernel_integrable
#print axioms finite_translate_correlation
#print axioms finite_translate_arithmetic_cutoff
#print axioms observing_prime_power_weight
#print axioms weighted_correlation_convolution
#print axioms weighted_correlation_integrable
#print axioms correlation_mellin
end BuildingBlocks.PhysicalScatteringCorrelation
