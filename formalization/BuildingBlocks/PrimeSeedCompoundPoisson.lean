import BuildingBlocks.PrimeSeedLevy
import Mathlib.Probability.Distributions.Poisson
import Mathlib.MeasureTheory.Group.Convolution

/-! A compound Poisson probability law for the actual finite-prime jump measure.
The jump-count probabilities use mathlib's classical Poisson distribution.
Every convolution power is retained. The time-semigroup identity and uniform
all-prime limit are separate dependencies, not assumptions of this construction.
-/

open MeasureTheory ProbabilityTheory
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedProcess

/-- The complete `n`-jump history, including the literal zero-jump state. -/
noncomputable def jumpPower (μ : Measure ℝ) : ℕ → Measure ℝ
  | 0 => Measure.dirac 0
  | n + 1 => μ ∗ jumpPower μ n

instance jumpPower_isProbability (μ : Measure ℝ) [IsProbabilityMeasure μ] (n : ℕ) :
    IsProbabilityMeasure (jumpPower μ n) := by
  induction n with
  | zero => change IsProbabilityMeasure (Measure.dirac (0 : ℝ)); infer_instance
  | succ n ih =>
    letI := ih
    change IsProbabilityMeasure (μ ∗ jumpPower μ n)
    infer_instance

/-- The Poisson mixture retains every possible jump count. -/
noncomputable def poissonLaw (μ : Measure ℝ) (r : ℝ≥0) : Measure ℝ :=
  Measure.sum (fun n : ℕ => (poissonPMF r n) • jumpPower μ n)

instance poissonLaw_isProbability (μ : Measure ℝ) [IsProbabilityMeasure μ] (r : ℝ≥0) :
    IsProbabilityMeasure (poissonLaw μ r) := by
  constructor
  rw [poissonLaw, Measure.sum_apply _ MeasurableSet.univ]
  simpa only [Measure.smul_apply, measure_univ, smul_eq_mul, mul_one] using
    (poissonPMF r).tsum_coe

/-- Normalize a finite jump measure. The zero-intensity case uses a fixed
probability measure; the Poisson law then has only its zero-jump term. -/
noncomputable def normalizedJump (μ : Measure ℝ) : Measure ℝ := by
  classical
  exact if μ = 0 then Measure.dirac 0 else (μ Set.univ)⁻¹ • μ

instance normalizedJump_isProbability (μ : Measure ℝ) [IsFiniteMeasure μ] :
    IsProbabilityMeasure (normalizedJump μ) := by
  classical
  unfold normalizedJump
  split_ifs with hμ
  · infer_instance
  · constructor
    rw [Measure.smul_apply, smul_eq_mul]
    exact ENNReal.inv_mul_cancel
      (fun h => hμ (Measure.measure_univ_eq_zero.mp h)) (measure_ne_top μ Set.univ)

/-- Normalization retains the exact original jump measure and its intensity. -/
theorem normalizedJump_reconstruct (μ : Measure ℝ) [IsFiniteMeasure μ] :
    (μ Set.univ) • normalizedJump μ = μ := by
  classical
  unfold normalizedJump
  split_ifs with hμ
  · subst μ
    simp
  · rw [smul_smul, ENNReal.mul_inv_cancel
      (fun h => hμ (Measure.measure_univ_eq_zero.mp h)) (measure_ne_top μ Set.univ),
      one_smul]

theorem jumpPower_smul (μ : Measure ℝ) [IsProbabilityMeasure μ] (c : ℝ≥0∞) (n : ℕ) :
    jumpPower (c • μ) n = c ^ n • jumpPower μ n := by
  induction n with
  | zero => simp [jumpPower]
  | succ n ih =>
    simp only [jumpPower, ih]
    rw [Measure.conv_smul_right, Measure.conv_smul_left, smul_smul, pow_succ]

theorem jumpPower_normalized_reconstruct (μ : Measure ℝ) [IsFiniteMeasure μ] (n : ℕ) :
    jumpPower μ n = (μ Set.univ) ^ n • jumpPower (normalizedJump μ) n := by
  calc
    jumpPower μ n = jumpPower ((μ Set.univ) • normalizedJump μ) n := by
      rw [normalizedJump_reconstruct]
    _ = _ := jumpPower_smul _ _ _

private theorem poisson_weight_factor (u rate : ℝ≥0) (n : ℕ) :
    poissonPMF (u * rate) n =
      ENNReal.ofReal (Real.exp (-(u : ℝ) * (rate : ℝ)) * (u : ℝ) ^ n / n.factorial) *
        (rate : ℝ≥0∞) ^ n := by
  change ENNReal.ofReal (poissonPMFReal (u * rate) n) = _
  have heq : poissonPMFReal (u * rate) n =
      (Real.exp (-(u : ℝ) * (rate : ℝ)) * (u : ℝ) ^ n / n.factorial) * (rate : ℝ) ^ n := by
    simp only [poissonPMFReal, NNReal.coe_mul, neg_mul, mul_pow]
    ring
  rw [heq, ENNReal.ofReal_mul (by positivity), ENNReal.ofReal_pow rate.coe_nonneg]
  simp

/-- The normalized Poisson mixture equals the original unnormalized convolution
series, including the zero measure and zero process-time cases. -/
theorem poissonLaw_original_series (μ : Measure ℝ) [IsFiniteMeasure μ] (u : ℝ≥0) :
    poissonLaw (normalizedJump μ) (u * measureUnivNNReal μ) =
      Measure.sum (fun n : ℕ =>
        ENNReal.ofReal (Real.exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ)) *
          (u : ℝ) ^ n / n.factorial) • jumpPower μ n) := by
  unfold poissonLaw
  congr 1
  funext n
  rw [poisson_weight_factor, coe_measureUnivNNReal, ← smul_smul,
    ← jumpPower_normalized_reconstruct]

/-- The actual finite-prime law at nonnegative process time. -/
noncomputable def seedProcess (S : Finset Nat.Primes) (u : ℝ≥0) : Measure ℝ :=
  poissonLaw (normalizedJump (PrimeSeedMass.levyMeasure S))
    (u * measureUnivNNReal (PrimeSeedMass.levyMeasure S))

instance seedProcess_isProbability (S : Finset Nat.Primes) (u : ℝ≥0) :
    IsProbabilityMeasure (seedProcess S u) := by
  unfold seedProcess
  infer_instance

theorem seedProcess_original_series (S : Finset Nat.Primes) (u : ℝ≥0) :
    seedProcess S u = Measure.sum (fun n : ℕ =>
      ENNReal.ofReal (Real.exp (-(u : ℝ) *
        (measureUnivNNReal (PrimeSeedMass.levyMeasure S) : ℝ)) *
          (u : ℝ) ^ n / n.factorial) • jumpPower (PrimeSeedMass.levyMeasure S) n) :=
  poissonLaw_original_series _ _

theorem poissonLaw_zero (μ : Measure ℝ) : poissonLaw μ 0 = Measure.dirac 0 := by
  ext s hs
  rw [poissonLaw, Measure.sum_apply _ hs]
  have hw (n : ℕ) : poissonPMF 0 n = if n = 0 then 1 else 0 := by
    change ENNReal.ofReal (poissonPMFReal 0 n) = _
    by_cases hn : n = 0
    · subst n
      simp [poissonPMFReal]
    · simp [poissonPMFReal, hn]
  simp only [Measure.smul_apply, smul_eq_mul, hw]
  simp only [ite_mul, one_mul, zero_mul]
  rw [tsum_eq_single 0 (fun i hi => by simp [hi])]
  simp [jumpPower]

theorem seedProcess_zero (S : Finset Nat.Primes) : seedProcess S 0 = Measure.dirac 0 := by
  simp [seedProcess, poissonLaw_zero]

end BuildingBlocks.PrimeSeedProcess
