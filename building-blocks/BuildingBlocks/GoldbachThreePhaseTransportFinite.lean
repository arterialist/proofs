import BuildingBlocks.GoldbachThreePhaseFourier

/-!
# Finite weighted three-phase Fourier and successor prefix algebra

A real pair-survival factor can be inserted without changing the exact
Fourier projection. The source coefficients are the complete von Mangoldt
weights and the parity-aware odd-lattice reference. The actual successor
probability law and its logarithmic defect bound are separate analytic
obligations.
-/

namespace BuildingBlocks.GoldbachThreePhaseTransportFinite

open Real Finset intervalIntegral MeasureTheory
open scoped ComplexConjugate
open BuildingBlocks.GoldbachPrimePhaseCutFinite
open BuildingBlocks.GoldbachEvenPhaseCenterFinite
open BuildingBlocks.GoldbachThreePhaseHarmonicFinite
open BuildingBlocks.GoldbachThreePhaseFourier

/-- The parity-centered even triangle after an arbitrary real pair
survival factor has been applied to every ordered source pair. -/
noncomputable def weightedEvenCenteredGoldbach
    (N : ℕ) (p : ℕ → ℕ → ℝ) (θ : ℝ) : ℝ :=
  ∑ q ∈ evenPairDomain N,
    (p q.1 q.2 * weight q.1 * weight q.2 *
        cos ((padicValNat 3 q.1 : ℝ) * θ -
          (padicValNat 3 q.2 : ℝ) * θ) -
      p q.1 q.2 * weight q.1 * oddReference q.2 *
        cos ((padicValNat 3 q.1 : ℝ) * θ) -
      p q.1 q.2 * oddReference q.1 * weight q.2 *
        cos ((padicValNat 3 q.2 : ℝ) * θ) +
      p q.1 q.2 * oddReference q.1 * oddReference q.2)

noncomputable def weightedAngularHarmonic
    (N : ℕ) (p : ℕ → ℕ → ℝ) : ℝ :=
  (∫ θ in (0 : ℝ)..2 * π,
    weightedEvenCenteredGoldbach N p θ * cos θ) / π

/-- The exact algebraic first Fourier coefficient after pair
transport. No sign or bound for the survival factor is assumed. -/
noncomputable def weightedFirstHarmonic
    (N : ℕ) (p : ℕ → ℕ → ℝ) : ℝ :=
  ∑ q ∈ evenPairDomain N,
    (p q.1 q.2 * weight q.1 * weight q.2 *
        ((if padicValNat 3 q.1 = padicValNat 3 q.2 + 1 then 1 else 0) +
         (if padicValNat 3 q.2 = padicValNat 3 q.1 + 1 then 1 else 0)) -
      p q.1 q.2 * weight q.1 * oddReference q.2 *
        (if padicValNat 3 q.1 = 1 then 1 else 0) -
      p q.1 q.2 * oddReference q.1 * weight q.2 *
        (if padicValNat 3 q.2 = 1 then 1 else 0))

theorem weightedAngularHarmonic_eq_first (N : ℕ) (p : ℕ → ℕ → ℝ) :
    weightedAngularHarmonic N p = weightedFirstHarmonic N p := by
  have hint (q : ℕ × ℕ) : IntervalIntegrable
      (fun θ : ℝ =>
        (p q.1 q.2 * weight q.1 * weight q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ -
              (padicValNat 3 q.2 : ℝ) * θ) -
          p q.1 q.2 * weight q.1 * oddReference q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ) -
          p q.1 q.2 * oddReference q.1 * weight q.2 *
            cos ((padicValNat 3 q.2 : ℝ) * θ) +
          p q.1 q.2 * oddReference q.1 * oddReference q.2) * cos θ)
      volume 0 (2 * π) := by
    have hc : Continuous (fun θ : ℝ =>
        (p q.1 q.2 * weight q.1 * weight q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ -
              (padicValNat 3 q.2 : ℝ) * θ) -
          p q.1 q.2 * weight q.1 * oddReference q.2 *
            cos ((padicValNat 3 q.1 : ℝ) * θ) -
          p q.1 q.2 * oddReference q.1 * weight q.2 *
            cos ((padicValNat 3 q.2 : ℝ) * θ) +
          p q.1 q.2 * oddReference q.1 * oddReference q.2) * cos θ) := by
      fun_prop
    exact hc.intervalIntegrable _ _
  unfold weightedAngularHarmonic weightedEvenCenteredGoldbach
  simp_rw [Finset.sum_mul]
  rw [intervalIntegral.integral_finset_sum (fun q _ => hint q)]
  unfold weightedFirstHarmonic
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro q hq
  apply (div_eq_iff (ne_of_gt Real.pi_pos)).2
  have h := pair_projection
    (p q.1 q.2 * weight q.1 * weight q.2)
    (p q.1 q.2 * weight q.1 * oddReference q.2)
    (p q.1 q.2 * oddReference q.1 * weight q.2)
    (p q.1 q.2 * oddReference q.1 * oddReference q.2)
    (padicValNat 3 q.1) (padicValNat 3 q.2)
  rw [h]
  rw [neighbor_indicator_scale,
    indicator_scale (P := padicValNat 3 q.1 = 1),
    indicator_scale (P := padicValNat 3 q.2 = 1)]
  ring

theorem weightedFirstHarmonic_one (N : ℕ) :
    weightedFirstHarmonic N (fun _ _ => 1) = threeFirstHarmonic N := by
  unfold weightedFirstHarmonic threeFirstHarmonic
  apply Finset.sum_congr rfl
  intro q hq
  simp

/-- The original complex phase triangle with a real pair-survival
factor, retaining both mixed reference orientations. -/
noncomputable def weightedComplexCenteredGoldbach
    (N : ℕ) (p : ℕ → ℕ → ℝ) (θ : ℝ) : ℂ :=
  ∑ q ∈ evenPairDomain N,
    (p q.1 q.2 : ℂ) *
      (((weight q.1 : ℂ) * threeComplexPhase q.1 θ -
          (oddReference q.1 : ℂ)) *
        ((weight q.2 : ℂ) * conj (threeComplexPhase q.2 θ) -
          (oddReference q.2 : ℂ)))

private noncomputable def centeredAmplitude (n : ℕ) (θ : ℝ) : ℂ :=
  (weight n : ℂ) * threeComplexPhase n θ - (oddReference n : ℂ)

private theorem weightedComplex_eq_hermitian
    (N : ℕ) (p : ℕ → ℕ → ℝ) (θ : ℝ) :
    weightedComplexCenteredGoldbach N p θ =
      ∑ q ∈ evenPairDomain N,
        (p q.1 q.2 : ℂ) * centeredAmplitude q.1 θ *
          conj (centeredAmplitude q.2 θ) := by
  unfold weightedComplexCenteredGoldbach
  apply Finset.sum_congr rfl
  intro q _
  simp [centeredAmplitude, map_sub, map_mul, mul_assoc]

theorem weightedComplex_im_zero (N : ℕ) (p : ℕ → ℕ → ℝ)
    (hp : ∀ a b, p a b = p b a) (θ : ℝ) :
    (weightedComplexCenteredGoldbach N p θ).im = 0 := by
  rw [weightedComplex_eq_hermitian]
  apply Complex.conj_eq_iff_im.mp
  calc
    conj (∑ q ∈ evenPairDomain N,
        (p q.1 q.2 : ℂ) * centeredAmplitude q.1 θ *
          conj (centeredAmplitude q.2 θ)) =
      ∑ q ∈ evenPairDomain N,
        (p q.1 q.2 : ℂ) * centeredAmplitude q.2 θ *
          conj (centeredAmplitude q.1 θ) := by
        simp [map_sum, map_mul, mul_comm, mul_assoc]
    _ = ∑ q ∈ evenPairDomain N,
        (p q.2 q.1 : ℂ) * centeredAmplitude q.1 θ *
          conj (centeredAmplitude q.2 θ) :=
        sum_evenPair_swap N (fun a b =>
          (p b a : ℂ) * centeredAmplitude a θ *
            conj (centeredAmplitude b θ))
    _ = ∑ q ∈ evenPairDomain N,
        (p q.1 q.2 : ℂ) * centeredAmplitude q.1 θ *
          conj (centeredAmplitude q.2 θ) := by
        apply Finset.sum_congr rfl
        intro q _
        rw [hp]

theorem weightedComplex_re (N : ℕ) (p : ℕ → ℕ → ℝ) (θ : ℝ) :
    (weightedComplexCenteredGoldbach N p θ).re =
      weightedEvenCenteredGoldbach N p θ := by
  unfold weightedComplexCenteredGoldbach weightedEvenCenteredGoldbach
  rw [re_finset_sum]
  apply Finset.sum_congr rfl
  intro q hq
  let z : ℂ :=
    ((weight q.1 : ℂ) * threeComplexPhase q.1 θ -
      (oddReference q.1 : ℂ)) *
      ((weight q.2 : ℂ) * conj (threeComplexPhase q.2 θ) -
        (oddReference q.2 : ℂ))
  change ((p q.1 q.2 : ℂ) * z).re = _
  have hscale : ((p q.1 q.2 : ℂ) * z).re = p q.1 q.2 * z.re := by
    simp [Complex.mul_re]
  rw [hscale]
  have hz : z.re =
      weight q.1 * weight q.2 *
        cos ((padicValNat 3 q.1 : ℝ) * θ -
          (padicValNat 3 q.2 : ℝ) * θ) -
      weight q.1 * oddReference q.2 *
        cos ((padicValNat 3 q.1 : ℝ) * θ) -
      oddReference q.1 * weight q.2 *
        cos ((padicValNat 3 q.2 : ℝ) * θ) +
      oddReference q.1 * oddReference q.2 := by
    dsimp [z]
    convert complex_centered_pair_re (weight q.1) (weight q.2)
        (oddReference q.1) (oddReference q.2)
        ((padicValNat 3 q.1 : ℝ) * θ)
        ((padicValNat 3 q.2 : ℝ) * θ) using 1
  rw [hz]
  ring

theorem weightedComplex_eq_real (N : ℕ) (p : ℕ → ℕ → ℝ)
    (hp : ∀ a b, p a b = p b a) (θ : ℝ) :
    weightedComplexCenteredGoldbach N p θ =
      (weightedEvenCenteredGoldbach N p θ : ℂ) := by
  apply Complex.ext
  · simpa using weightedComplex_re N p θ
  · simp [weightedComplex_im_zero N p hp θ]

noncomputable def weightedComplexAngularHarmonic
    (N : ℕ) (p : ℕ → ℕ → ℝ) : ℝ :=
  (∫ θ in (0 : ℝ)..2 * π,
    (weightedComplexCenteredGoldbach N p θ).re * cos θ) / π

theorem weightedComplexAngularHarmonic_eq_first
    (N : ℕ) (p : ℕ → ℕ → ℝ) :
    weightedComplexAngularHarmonic N p = weightedFirstHarmonic N p := by
  unfold weightedComplexAngularHarmonic
  simp_rw [weightedComplex_re]
  change weightedAngularHarmonic N p = weightedFirstHarmonic N p
  exact weightedAngularHarmonic_eq_first N p

/-- Finite Abel summation with the terminal survival weight kept. -/
theorem prefix_weighted_sum (f p : ℕ → ℝ) (J : ℕ) :
    (∑ j ∈ Finset.range (J + 1), f j * p j) =
      (∑ j ∈ Finset.range (J + 1),
        (∑ i ∈ Finset.range (j + 1), f i) * (p j - p (j + 1))) +
      (∑ i ∈ Finset.range (J + 1), f i) * p (J + 1) := by
  induction J with
  | zero =>
      simp
      ring
  | succ J ih =>
      let F : ℕ → ℝ := fun j => ∑ i ∈ Finset.range (j + 1), f i
      have hF : F (J + 1) = F J + f (J + 1) := by
        change (∑ i ∈ Finset.range ((J + 1) + 1), f i) =
          (∑ i ∈ Finset.range (J + 1), f i) + f (J + 1)
        rw [Finset.sum_range_succ]
      have hL : (∑ j ∈ Finset.range ((J + 1) + 1), f j * p j) =
          (∑ j ∈ Finset.range (J + 1), f j * p j) +
            f (J + 1) * p (J + 1) := by
        rw [Finset.sum_range_succ]
      have hR :
          (∑ j ∈ Finset.range ((J + 1) + 1),
            F j * (p j - p (j + 1))) =
          (∑ j ∈ Finset.range (J + 1),
            F j * (p j - p (j + 1))) +
            F (J + 1) * (p (J + 1) - p ((J + 1) + 1)) := by
        rw [Finset.sum_range_succ]
      change
        (∑ j ∈ Finset.range ((J + 1) + 1), f j * p j) =
          (∑ j ∈ Finset.range ((J + 1) + 1),
            F j * (p j - p (j + 1))) +
          F (J + 1) * p ((J + 1) + 1)
      rw [hL, hR]
      change (∑ j ∈ Finset.range (J + 1), f j * p j) =
        (∑ j ∈ Finset.range (J + 1), F j * (p j - p (j + 1))) +
          F J * p (J + 1) at ih
      rw [ih, hF]
      ring

theorem prefix_weighted_sum_zero_tail (f p : ℕ → ℝ) (J : ℕ)
    (htail : p (J + 1) = 0) :
    (∑ j ∈ Finset.range (J + 1), f j * p j) =
      ∑ j ∈ Finset.range (J + 1),
        (∑ i ∈ Finset.range (j + 1), f i) * (p j - p (j + 1)) := by
  rw [prefix_weighted_sum]
  simp [htail]

theorem prefix_weight_sum_telescope (p : ℕ → ℝ) (J : ℕ) :
    (∑ j ∈ Finset.range (J + 1), (p j - p (j + 1))) =
      p 0 - p (J + 1) := by
  induction J with
  | zero => simp
  | succ J ih =>
      rw [Finset.sum_range_succ, ih]
      ring

theorem prefix_average_weights_nonneg (p : ℕ → ℝ) (J : ℕ)
    (hmono : ∀ j ≤ J, p (j + 1) ≤ p j) :
    ∀ j ∈ Finset.range (J + 1), 0 ≤ p j - p (j + 1) := by
  intro j hj
  exact sub_nonneg.mpr (hmono j (Nat.lt_succ_iff.mp (Finset.mem_range.mp hj)))

theorem prefix_average_total_le_one (p : ℕ → ℝ) (J : ℕ)
    (htail : p (J + 1) = 0) (hhead : p 0 ≤ 1) :
    (∑ j ∈ Finset.range (J + 1), (p j - p (j + 1))) ≤ 1 := by
  rw [prefix_weight_sum_telescope, htail]
  simpa using hhead

/-- The actual odd-lattice source for the unique `3` row. Every odd
prime power other than a power of three remains in the coefficient. -/
noncomputable def oddThreeRowSource (j : ℕ) : ℝ :=
  (if padicValNat 3 (2 * j + 1) = 0 then weight (2 * j + 1) else 0) - 2

noncomputable def oddThreeRowPrefix (j : ℕ) : ℝ :=
  ∑ i ∈ Finset.range (j + 1), oddThreeRowSource i

/-- The transported unique-generator row is a finite average of the
actual complete odd prime-error prefixes when its next survival
weight has vanished. -/
theorem oddThreeRow_prefix_average (J : ℕ) (p : ℕ → ℕ → ℝ)
    (htail : p 3 (2 * (J + 1) + 1) = 0) :
    (∑ j ∈ Finset.range (J + 1),
      oddThreeRowSource j * p 3 (2 * j + 1)) =
      ∑ j ∈ Finset.range (J + 1),
        oddThreeRowPrefix j *
          (p 3 (2 * j + 1) - p 3 (2 * (j + 1) + 1)) := by
  exact prefix_weighted_sum_zero_tail oddThreeRowSource
    (fun j => p 3 (2 * j + 1)) J htail

#print axioms weightedAngularHarmonic_eq_first
#print axioms weightedFirstHarmonic_one
#print axioms weightedComplex_eq_real
#print axioms weightedComplexAngularHarmonic_eq_first
#print axioms prefix_weighted_sum_zero_tail
#print axioms prefix_average_weights_nonneg
#print axioms oddThreeRow_prefix_average

end BuildingBlocks.GoldbachThreePhaseTransportFinite
