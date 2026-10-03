import BuildingBlocks.ActualMobiusConvolution
import Mathlib.Analysis.MeanInequalities
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Data.Nat.Totient
import Mathlib.Tactic

/-!
Finite identities for Mathlib's actual Möbius harmonic coefficients, and
the finite composition of three explicitly supplied analytic estimates.
The coprime reindexing is unconditional, including nonsquarefree labels.
The final numerical norm theorem does not prove its source estimates.
It asserts no asymptotic, full signed F bound, or RH implication.
-/

namespace BuildingBlocks.ActualMobiusCoprimeHarmonic

open Finset
open scoped BigOperators

noncomputable section

def multipleHarmonic (N q : ℕ) : ℝ :=
  ∑ d ∈ (Icc 1 N).filter (fun d => q ∣ d),
    (ArithmeticFunction.moebius d : ℝ) / d

def coprimeHarmonic (q M : ℕ) : ℝ :=
  ∑ m ∈ (Icc 1 M).filter (fun m => q.Coprime m),
    (ArithmeticFunction.moebius m : ℝ) / m

def multipleHarmonicReal (X : ℝ) (q : ℕ) : ℝ :=
  multipleHarmonic ⌊X⌋₊ q

def coprimeHarmonicReal (q : ℕ) (Y : ℝ) : ℝ :=
  coprimeHarmonic q ⌊Y⌋₊

def lowCofactorEnergy (X D : ℝ) : ℝ :=
  ∑ q ∈ Icc 1 ⌊D⌋₊, (q.totient : ℝ) * multipleHarmonicReal X q ^ 2

/-- Noncoprime factors give zero actual Möbius coefficient. -/
theorem moebius_mul_eq_zero_of_not_coprime {q m : ℕ}
    (h : ¬q.Coprime m) : ArithmeticFunction.moebius (q * m) = 0 := by
  apply ArithmeticFunction.moebius_eq_zero_of_not_squarefree
  exact fun hs => h (Nat.coprime_of_squarefree_mul hs)

/-- Reindex all positive multiples, with no squarefree restriction. -/
theorem multipleHarmonic_reindex (N q : ℕ) (hq : 0 < q) :
    multipleHarmonic N q =
      ∑ m ∈ Icc 1 (N / q), (ArithmeticFunction.moebius (q * m) : ℝ) / (q * m) := by
  unfold multipleHarmonic
  apply Finset.sum_bij (fun d _ => d / q)
  · intro d hd
    rcases Finset.mem_filter.mp hd with ⟨hd, hdiv⟩
    rcases Finset.mem_Icc.mp hd with ⟨hdpos, hdN⟩
    have hprod : q * (d / q) = d := Nat.mul_div_cancel' hdiv
    apply Finset.mem_Icc.mpr
    constructor
    · apply Nat.succ_le_iff.mpr
      apply Nat.pos_of_ne_zero
      intro hz
      rw [hz, mul_zero] at hprod
      omega
    · exact Nat.div_le_div_right hdN
  · intro d₁ hd₁ d₂ hd₂ heq
    have hdiv₁ := (Finset.mem_filter.mp hd₁).2
    have hdiv₂ := (Finset.mem_filter.mp hd₂).2
    calc
      d₁ = q * (d₁ / q) := (Nat.mul_div_cancel' hdiv₁).symm
      _ = q * (d₂ / q) := by rw [heq]
      _ = d₂ := Nat.mul_div_cancel' hdiv₂
  · intro m hm
    rcases Finset.mem_Icc.mp hm with ⟨hmpos, hmN⟩
    refine ⟨q * m, ?_, ?_⟩
    · apply Finset.mem_filter.mpr
      constructor
      · apply Finset.mem_Icc.mpr
        exact ⟨by nlinarith, by simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hq).mp hmN⟩
      · exact dvd_mul_right q m
    · exact Nat.mul_div_right m hq
  · intro d hd
    have hdiv := (Finset.mem_filter.mp hd).2
    rw [← Nat.cast_mul, Nat.mul_div_cancel' hdiv]

/-- Exact actual coprime harmonic identity for every natural cutoff,
including zero and nonsquarefree q. -/
theorem multipleHarmonic_eq_coprime (N q : ℕ) (hq : 0 < q) :
    multipleHarmonic N q =
      (ArithmeticFunction.moebius q : ℝ) * coprimeHarmonic q (N / q) / q := by
  rw [multipleHarmonic_reindex N q hq]
  unfold coprimeHarmonic
  rw [Finset.sum_filter]
  rw [Finset.mul_sum, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro m hm
  by_cases hcop : q.Coprime m
  · simp only [if_pos hcop]
    have hmu := BuildingBlocks.ActualMobiusConvolution.moebius_mul_of_coprime hcop
    have hc := congrArg (fun z : ℤ => (z : ℝ)) hmu
    push_cast at hc
    rw [← hc]
    ring
  · rw [moebius_mul_eq_zero_of_not_coprime hcop]
    simp [hcop]

/-- The floor dictionary preserves every real cutoff and quotient seam. -/
theorem multipleHarmonicReal_eq_coprime (X : ℝ) (q : ℕ) (hq : 0 < q) :
    multipleHarmonicReal X q =
      (ArithmeticFunction.moebius q : ℝ) * coprimeHarmonicReal q (X / q) / q := by
  unfold multipleHarmonicReal coprimeHarmonicReal
  rw [Nat.floor_div_natCast]
  exact multipleHarmonic_eq_coprime ⌊X⌋₊ q hq

@[simp] theorem multipleHarmonic_zero (q : ℕ) : multipleHarmonic 0 q = 0 := by
  simp [multipleHarmonic]

@[simp] theorem coprimeHarmonic_zero (q : ℕ) : coprimeHarmonic q 0 = 0 := by
  simp [coprimeHarmonic]

theorem multipleHarmonic_eq_zero_of_not_squarefree (N q : ℕ)
    (hq : 0 < q) (hs : ¬Squarefree q) : multipleHarmonic N q = 0 := by
  rw [multipleHarmonic_eq_coprime N q hq,
    ArithmeticFunction.moebius_eq_zero_of_not_squarefree hs]
  simp

def sourceXi : ℝ := 1 - 1 / Real.log (10 ^ 12 : ℝ)

def jordanReal (s : ℝ) (q : ℕ) : ℝ :=
  (q : ℝ) ^ s * ∏ p ∈ q.primeFactors, (1 - (p : ℝ) ^ (-s))

def sourceG0 (q : ℕ) : ℝ :=
  if 2 ∣ q then Real.sqrt 3 * (Real.sqrt 2 - 1) / 2 else 1

def sourceG2 (q : ℕ) : ℝ :=
  if 2 ∣ q then 2.9506 * (1 - (2 : ℝ) ^ (-sourceXi)) else 1

def sourceRootCoefficient (q : ℕ) : ℝ := sourceG0 q / jordanReal (1 / 2) q

def sourceLogEnvelope (q : ℕ) : ℝ :=
  sourceG2 q * (q : ℝ) ^ sourceXi / jordanReal sourceXi q

/-- Literal Lemma2.6 input. This proposition is an analytic hypothesis,
not a theorem supplied by this module. -/
def SourcePointwiseEstimate : Prop :=
  ∀ (q : ℕ), 0 < q → ∀ (Y : ℝ), 0 < Y →
    |coprimeHarmonicReal q Y| ≤
      sourceRootCoefficient q * Real.sqrt q * Real.sqrt (2 / Y) +
        if (10 ^ 12 : ℝ) ≤ Y then 0.010032 * sourceLogEnvelope q / Real.log Y else 0

/-- Literal positive root-mean input, with the actual Möbius square. -/
def SourceRootMeanEstimate (D : ℝ) : Prop :=
  (∑ q ∈ Icc 1 ⌊D⌋₊,
    (ArithmeticFunction.moebius q : ℝ) ^ 2 * (q.totient : ℝ) *
      sourceG0 q ^ 2 / jordanReal (1 / 2) q ^ 2) ≤ 2.1206 * D

/-- Literal K2 mean upper, with the printed upper enclosure for c2. -/
def SourceLogMeanEstimate (D : ℝ) : Prop :=
  (∑ q ∈ Icc 1 ⌊D⌋₊,
    (ArithmeticFunction.moebius q : ℝ) ^ 2 * (q.totient : ℝ) /
      (q : ℝ) ^ 2 * sourceLogEnvelope q ^ 2) ≤ 1.6385 * Real.log D + 1.2943

private theorem finite_weighted_two_envelope
    {ι : Type*} (s : Finset ι) (w a u v : ι → ℝ) (A B : ℝ)
    (hw : ∀ i ∈ s, 0 ≤ w i) (hu : ∀ i ∈ s, 0 ≤ u i)
    (hv : ∀ i ∈ s, 0 ≤ v i) (ha : ∀ i ∈ s, |a i| ≤ u i + v i)
    (hA : ∑ i ∈ s, w i * u i ^ 2 ≤ A)
    (hB : ∑ i ∈ s, w i * v i ^ 2 ≤ B) :
    (∑ i ∈ s, w i * a i ^ 2) ≤ (Real.sqrt A + Real.sqrt B) ^ 2 := by
  let U := ∑ i ∈ s, w i * u i ^ 2
  let V := ∑ i ∈ s, w i * v i ^ 2
  have hU : 0 ≤ U := Finset.sum_nonneg fun i hi => mul_nonneg (hw i hi) (sq_nonneg _)
  have hV : 0 ≤ V := Finset.sum_nonneg fun i hi => mul_nonneg (hw i hi) (sq_nonneg _)
  have hAnon : 0 ≤ A := hU.trans hA
  have hBnon : 0 ≤ B := hV.trans hB
  have hcross := Real.sum_mul_le_sqrt_mul_sqrt s
    (fun i => Real.sqrt (w i) * u i) (fun i => Real.sqrt (w i) * v i)
  have hf : (∑ i ∈ s, (Real.sqrt (w i) * u i) ^ 2) = U := by
    apply Finset.sum_congr rfl
    intro i hi
    rw [mul_pow, Real.sq_sqrt (hw i hi)]
  have hg : (∑ i ∈ s, (Real.sqrt (w i) * v i) ^ 2) = V := by
    apply Finset.sum_congr rfl
    intro i hi
    rw [mul_pow, Real.sq_sqrt (hw i hi)]
  have hfg : (∑ i ∈ s, (Real.sqrt (w i) * u i) * (Real.sqrt (w i) * v i)) =
      ∑ i ∈ s, w i * u i * v i := by
    apply Finset.sum_congr rfl
    intro i hi
    calc
      _ = Real.sqrt (w i) ^ 2 * u i * v i := by ring
      _ = _ := by rw [Real.sq_sqrt (hw i hi)]
  rw [hf, hg, hfg] at hcross
  have hroots : Real.sqrt U * Real.sqrt V ≤ Real.sqrt A * Real.sqrt B :=
    mul_le_mul (Real.sqrt_le_sqrt hA) (Real.sqrt_le_sqrt hB)
      (Real.sqrt_nonneg V) (Real.sqrt_nonneg A)
  have henv : (∑ i ∈ s, w i * a i ^ 2) ≤ ∑ i ∈ s, w i * (u i + v i) ^ 2 := by
    apply Finset.sum_le_sum
    intro i hi
    apply mul_le_mul_of_nonneg_left _ (hw i hi)
    nlinarith [ha i hi, hu i hi, hv i hi, abs_nonneg (a i), sq_abs (a i)]
  have hex : (∑ i ∈ s, w i * (u i + v i) ^ 2) =
      U + V + 2 * ∑ i ∈ s, w i * u i * v i := by
    simp only [U, V]
    calc
      _ = ∑ i ∈ s, (w i * u i ^ 2 + w i * v i ^ 2 + 2 * (w i * u i * v i)) := by
        apply Finset.sum_congr rfl
        intro i hi
        ring
      _ = _ := by rw [Finset.sum_add_distrib, Finset.sum_add_distrib, ← Finset.mul_sum]
  rw [hex] at henv
  nlinarith [Real.sq_sqrt hAnon, Real.sq_sqrt hBnon]

/-- Finite composition of the three explicit source hypotheses. Every
analytic estimate remains visible in the theorem's arguments. -/
theorem lowCofactorEnergy_le_of_source_estimates
    (X D : ℝ) (hD : 1 ≤ D) (hcut : D ≤ X / (10 ^ 12 : ℝ))
    (hpoint : SourcePointwiseEstimate)
    (hroot : SourceRootMeanEstimate D) (hlogmean : SourceLogMeanEstimate D) :
    lowCofactorEnergy X D ≤
      (Real.sqrt (4.2412 * D / X) +
        0.010032 * Real.sqrt (1.6385 * Real.log D + 1.2943) / Real.log (X / D)) ^ 2 := by
  have hDp : 0 < D := by linarith
  have hbig : D * (10 ^ 12 : ℝ) ≤ X :=
    (le_div_iff₀ (by norm_num : (0 : ℝ) < 10 ^ 12)).mp hcut
  have hX : 0 < X := by nlinarith
  have hDX : D < X := by nlinarith
  have hlogXD : 0 < Real.log (X / D) :=
    Real.log_pos ((lt_div_iff₀ hDp).mpr (by simpa using hDX))
  have hK : 0 ≤ 1.6385 * Real.log D + 1.2943 := by
    have := Real.log_nonneg hD
    nlinarith
  let s := Icc 1 ⌊D⌋₊
  let u : ℕ → ℝ := fun q =>
    |(ArithmeticFunction.moebius q : ℝ)| * |sourceRootCoefficient q| * Real.sqrt (2 / X)
  let v : ℕ → ℝ := fun q =>
    0.010032 * |(ArithmeticFunction.moebius q : ℝ)| * |sourceLogEnvelope q| /
      ((q : ℝ) * Real.log (X / D))
  have hqpos : ∀ q ∈ s, 0 < q := fun q hq => by
    have := (Finset.mem_Icc.mp hq).1
    omega
  have hqD : ∀ q ∈ s, (q : ℝ) ≤ D := fun q hq => by
    exact (Nat.cast_le.mpr (Finset.mem_Icc.mp hq).2).trans (Nat.floor_le hDp.le)
  have henv : ∀ q ∈ s, |multipleHarmonicReal X q| ≤ u q + v q := by
    intro q hq
    have hqr : 0 < (q : ℝ) := Nat.cast_pos.mpr (hqpos q hq)
    have hY : 0 < X / q := div_pos hX hqr
    have hYlarge : (10 ^ 12 : ℝ) ≤ X / q := by
      apply (le_div_iff₀ hqr).mpr
      nlinarith [hqD q hq]
    have hlogY : 0 < Real.log (X / q) := Real.log_pos (by nlinarith [hYlarge])
    have hlogs : Real.log (X / D) ≤ Real.log (X / q) := by
      apply Real.log_le_log (div_pos hX hDp)
      exact div_le_div_of_nonneg_left hX.le hqr (hqD q hq)
    have hsqrt : Real.sqrt (q : ℝ) * Real.sqrt (2 / (X / q)) =
        (q : ℝ) * Real.sqrt (2 / X) := by
      have heq : 2 / (X / q) = (2 / X) * (q : ℝ) := by field_simp
      rw [heq, Real.sqrt_mul (by positivity : 0 ≤ 2 / X)]
      calc
        _ = Real.sqrt (q : ℝ) ^ 2 * Real.sqrt (2 / X) := by ring
        _ = _ := by rw [Real.sq_sqrt hqr.le]
    have hp := hpoint q (hqpos q hq) (X / q) hY
    rw [if_pos hYlarge] at hp
    have hp' : |coprimeHarmonicReal q (X / q)| ≤
        sourceRootCoefficient q * (q : ℝ) * Real.sqrt (2 / X) +
          0.010032 * sourceLogEnvelope q / Real.log (X / q) := by
      simpa only [mul_assoc, hsqrt] using hp
    rw [multipleHarmonicReal_eq_coprime X q (hqpos q hq), abs_div, abs_mul,
      abs_of_pos hqr]
    calc
      _ ≤ |(ArithmeticFunction.moebius q : ℝ)| *
          (sourceRootCoefficient q * (q : ℝ) * Real.sqrt (2 / X) +
            0.010032 * sourceLogEnvelope q / Real.log (X / q)) / q := by gcongr
      _ = |(ArithmeticFunction.moebius q : ℝ)| * sourceRootCoefficient q * Real.sqrt (2 / X) +
          0.010032 * |(ArithmeticFunction.moebius q : ℝ)| * sourceLogEnvelope q /
            ((q : ℝ) * Real.log (X / q)) := by field_simp
      _ ≤ |(ArithmeticFunction.moebius q : ℝ)| * |sourceRootCoefficient q| * Real.sqrt (2 / X) +
          0.010032 * |(ArithmeticFunction.moebius q : ℝ)| * |sourceLogEnvelope q| /
            ((q : ℝ) * Real.log (X / q)) := by
        gcongr
        · exact le_abs_self _
        · exact le_abs_self _
      _ ≤ u q + v q := by
        dsimp [u, v]
        gcongr
  have hu : ∀ q ∈ s, 0 ≤ u q := fun _ _ => by dsimp [u]; positivity
  have hv : ∀ q ∈ s, 0 ≤ v q := fun q hq => by
    dsimp [v]
    positivity
  have hU : (∑ q ∈ s, (q.totient : ℝ) * u q ^ 2) ≤ 4.2412 * D / X := by
    have heq : (∑ q ∈ s, (q.totient : ℝ) * u q ^ 2) =
        (2 / X) * ∑ q ∈ s,
          (ArithmeticFunction.moebius q : ℝ) ^ 2 * (q.totient : ℝ) *
            sourceG0 q ^ 2 / jordanReal (1 / 2) q ^ 2 := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro q hq
      dsimp [u, sourceRootCoefficient]
      simp only [mul_pow, sq_abs, div_pow, Real.sq_sqrt (by positivity : 0 ≤ 2 / X)]
      ring
    rw [heq]
    calc
      _ ≤ (2 / X) * (2.1206 * D) :=
        mul_le_mul_of_nonneg_left hroot (by positivity)
      _ = _ := by ring
  let B : ℝ := 0.010032 * Real.sqrt (1.6385 * Real.log D + 1.2943) / Real.log (X / D)
  have hB : 0 ≤ B := by dsimp [B]; positivity
  have hV : (∑ q ∈ s, (q.totient : ℝ) * v q ^ 2) ≤ B ^ 2 := by
    have heq : (∑ q ∈ s, (q.totient : ℝ) * v q ^ 2) =
        0.010032 ^ 2 / Real.log (X / D) ^ 2 *
          ∑ q ∈ s, (ArithmeticFunction.moebius q : ℝ) ^ 2 * (q.totient : ℝ) /
            (q : ℝ) ^ 2 * sourceLogEnvelope q ^ 2 := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro q hq
      dsimp [v]
      simp only [div_pow, mul_pow, sq_abs]
      ring
    rw [heq]
    calc
      _ ≤ 0.010032 ^ 2 / Real.log (X / D) ^ 2 * (1.6385 * Real.log D + 1.2943) :=
        mul_le_mul_of_nonneg_left hlogmean (by positivity)
      _ = B ^ 2 := by
        dsimp [B]
        rw [div_pow, mul_pow, Real.sq_sqrt hK]
        ring
  have hmain := finite_weighted_two_envelope s (fun q => (q.totient : ℝ))
    (multipleHarmonicReal X) u v (4.2412 * D / X) (B ^ 2)
    (fun _ _ => Nat.cast_nonneg _) hu hv henv hU hV
  rw [Real.sqrt_sq hB] at hmain
  exact hmain

end

end BuildingBlocks.ActualMobiusCoprimeHarmonic
