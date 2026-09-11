import BuildingBlocks.WindowVariance
import BuildingBlocks.ContractionRecovery

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

noncomputable def arrayFraction (c : ℕ → ℕ → ℝ) (N : ℕ) (x : ℝ) : ℝ :=
  kernelSum fractionKernel (Finset.Icc 1 N) (c N) (fun q => (q : ℝ) / (N : ℝ)) x

noncomputable def arrayImage (c : ℕ → ℕ → ℝ) (N : ℕ) (x : ℝ) : ℝ :=
  kernelSum reciprocalKernel (Finset.Icc 1 N) (c N) (fun q => (q : ℝ) / (N : ℝ)) x

noncomputable def windowMoment (c : ℕ → ℕ → ℝ) (N j : ℕ) : ℝ :=
  ∑ q ∈ Finset.Icc 1 N, (q : ℝ) * c N q * ((j / q : ℕ) : ℝ)

/-- The ordinary squared L² Cauchy condition, expressed directly with integrals. -/
def ArrayCauchy (c : ℕ → ℕ → ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ K : ℕ, ∀ N M : ℕ, K ≤ N → K ≤ M →
    (∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - arrayFraction c M x) ^ 2) < ε

theorem array_distance_identity (c : ℕ → ℕ → ℝ) {N M : ℕ} (hN : 0 < N) (hM : 0 < M) :
    (∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - arrayFraction c M x) ^ 2) =
      ∫ x in Set.Ioi (0 : ℝ), (arrayImage c N x - arrayImage c M x) ^ 2 :=
  kernelSum_distance_eq _ _ _ _ _ _
    (fun _ hq => quotient_parameter_pos hN hq)
    (fun _ hq => quotient_parameter_pos hM hq)

theorem arrayImage_product_integrable (c : ℕ → ℕ → ℝ) {N M : ℕ} (hN : 0 < N) (hM : 0 < M) :
    IntegrableOn (fun x => arrayImage c N x * arrayImage c M x) (Set.Ioi (0 : ℝ)) :=
  kernelSum_product_integrable _ _ _ _ _ _ _ _ (fun _ hi _ hj =>
    reciprocalKernel_product_integrable (quotient_parameter_pos hN hi) (quotient_parameter_pos hM hj))

theorem arrayImage_distance_integrable (c : ℕ → ℕ → ℝ) {N M : ℕ} (hN : 0 < N) (hM : 0 < M) :
    IntegrableOn (fun x => (arrayImage c N x - arrayImage c M x) ^ 2) (Set.Ioi (0 : ℝ)) := by
  have he : (fun x => (arrayImage c N x - arrayImage c M x) ^ 2) =
      (fun x => arrayImage c N x * arrayImage c N x -
        2 * (arrayImage c N x * arrayImage c M x) + arrayImage c M x * arrayImage c M x) := by
    funext x
    ring
  rw [he]
  exact ((arrayImage_product_integrable c hN hN).sub
    ((arrayImage_product_integrable c hN hM).const_mul 2)).add
      (arrayImage_product_integrable c hM hM)

theorem arrayImage_first_window (c : ℕ → ℕ → ℝ) {N : ℕ} (hN : 0 < N) {x : ℝ}
    (hx0 : 0 < x) (hx1 : x < 1 / (N : ℝ)) :
    arrayImage c N x = ∑ q ∈ Finset.Icc 1 N, c N q := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  unfold arrayImage kernelSum
  apply Finset.sum_congr rfl
  intro q hq
  have hq1 : (1 : ℝ) ≤ (q : ℝ) := by exact_mod_cast (Finset.mem_Icc.mp hq).1
  rw [reciprocalKernel_eq_one (by positivity) hx0
    (hx1.trans_le ((div_le_div_iff_of_pos_right hn).mpr hq1)), mul_one]

theorem reciprocalKernel_integer_window {N q j : ℕ} (hN : 0 < N) (hq : 0 < q) (hj : 0 < j)
    {x : ℝ} (hx1 : (j : ℝ) / (N : ℝ) < x) (hx2 : x < ((j : ℝ) + 1) / (N : ℝ)) :
    reciprocalKernel ((q : ℝ) / (N : ℝ)) x =
      1 - (q : ℝ) * ((j / q : ℕ) : ℝ) / ((N : ℝ) * x) := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hqR : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq
  have hjR : (0 : ℝ) < (j : ℝ) := by exact_mod_cast hj
  have hx0 : 0 < x := lt_trans (by positivity) hx1
  have h1 : (j : ℝ) < (N : ℝ) * x := by nlinarith [(div_lt_iff₀ hn).mp hx1]
  have h2 : (N : ℝ) * x < (j : ℝ) + 1 := by nlinarith [(lt_div_iff₀ hn).mp hx2]
  have hf : ⌊(N : ℝ) * x⌋ = (j : ℤ) := Int.floor_eq_iff.mpr (by
    simpa only [Int.cast_natCast] using And.intro h1.le h2)
  have he : x / ((q : ℝ) / (N : ℝ)) = ((N : ℝ) * x) / (q : ℝ) := by field_simp
  have hfloor : ⌊x / ((q : ℝ) / (N : ℝ))⌋ = ((j / q : ℕ) : ℤ) := by
    rw [he, Int.floor_div_natCast, hf]
    norm_cast
  unfold reciprocalKernel
  change (q : ℝ) / (N : ℝ) / x *
    (x / ((q : ℝ) / (N : ℝ)) - (⌊x / ((q : ℝ) / (N : ℝ))⌋ : ℝ)) = _
  rw [hfloor, Int.cast_natCast]
  field_simp

theorem arrayImage_integer_window (c : ℕ → ℕ → ℝ) {N j : ℕ} (hN : 0 < N) (hj : 0 < j)
    {x : ℝ} (hx1 : (j : ℝ) / (N : ℝ) < x) (hx2 : x < ((j : ℝ) + 1) / (N : ℝ)) :
    arrayImage c N x = (∑ q ∈ Finset.Icc 1 N, c N q) -
      windowMoment c N j / ((N : ℝ) * x) := by
  unfold arrayImage kernelSum windowMoment
  rw [Finset.sum_div, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro q hq
  rw [reciprocalKernel_integer_window hN (Finset.mem_Icc.mp hq).1 hj hx1 hx2]
  ring

theorem windowMoment_eq_prefix (c : ℕ → ℕ → ℝ) {N j : ℕ} (hjN : j ≤ N) :
    windowMoment c N j = ∑ q ∈ Finset.Icc 1 j, (q : ℝ) * c N q * ((j / q : ℕ) : ℝ) := by
  unfold windowMoment
  symm
  apply Finset.sum_subset
  · intro q hq
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hq).1, (Finset.mem_Icc.mp hq).2.trans hjN⟩
  · intro q hq hq'
    have hjq : j < q := by
      have hq1 := (Finset.mem_Icc.mp hq).1
      simp only [Finset.mem_Icc, not_and] at hq'
      exact lt_of_not_ge (hq' hq1)
    simp only [Nat.div_eq_of_lt hjq, Nat.cast_zero, mul_zero]

theorem array_window_distance_lower (c : ℕ → ℕ → ℝ) {N M j : ℕ}
    (hM : 0 < M) (hj : 0 < j) (hNM : (j + 1) * M ≤ N) :
    windowMoment c N j ^ 2 / (N : ℝ) ≤ 24 * ((j : ℝ) + 1) ^ 4 *
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - arrayFraction c M x) ^ 2 := by
  have hN : 0 < N := by nlinarith
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hm : (0 : ℝ) < (M : ℝ) := by exact_mod_cast hM
  have hjR : (0 : ℝ) < (j : ℝ) := by exact_mod_cast hj
  have hnm : ((j : ℝ) + 1) * (M : ℝ) ≤ (N : ℝ) := by exact_mod_cast hNM
  let B : ℝ := (∑ q ∈ Finset.Icc 1 N, c N q) - ∑ q ∈ Finset.Icc 1 M, c M q
  let A := windowMoment c N j
  have hends : (j : ℝ) / (N : ℝ) ≤ ((j : ℝ) + 1) / (N : ℝ) := by gcongr; linarith
  have hw : (∫ x in ((j : ℝ) / (N : ℝ))..(((j : ℝ) + 1) / (N : ℝ)),
      (arrayImage c N x - arrayImage c M x) ^ 2) =
      (N : ℝ)⁻¹ * ∫ u in (j : ℝ)..((j : ℝ) + 1), (B - A / u) ^ 2 := by
    have he : (∫ x in ((j : ℝ) / (N : ℝ))..(((j : ℝ) + 1) / (N : ℝ)),
        (arrayImage c N x - arrayImage c M x) ^ 2) =
        ∫ x in ((j : ℝ) / (N : ℝ))..(((j : ℝ) + 1) / (N : ℝ)),
          (B - A / ((N : ℝ) * x)) ^ 2 := by
      apply intervalIntegral.integral_congr_ae
      filter_upwards [(Set.countable_singleton (((j : ℝ) + 1) / (N : ℝ))).ae_notMem volume]
        with x hx hmem
      rw [uIoc_of_le hends] at hmem
      have hx' : x ≠ ((j : ℝ) + 1) / (N : ℝ) := hx
      have hx2 := lt_of_le_of_ne hmem.2 hx'
      have hx0 : 0 < x := lt_trans (by positivity) hmem.1
      have hsmall : x < 1 / (M : ℝ) := by
        apply hx2.trans_le
        exact (div_le_div_iff₀ hn hm).mpr (by simpa only [one_mul] using hnm)
      rw [arrayImage_integer_window c hN hj hmem.1 hx2, arrayImage_first_window c hM hx0 hsmall]
      dsimp [A, B]
      ring
    rw [he]
    have hh := intervalIntegral.integral_comp_mul_left
      (a := (j : ℝ) / (N : ℝ)) (b := ((j : ℝ) + 1) / (N : ℝ))
      (fun u : ℝ => (B - A / u) ^ 2) hn.ne'
    simpa only [mul_div_cancel₀ _ hn.ne', smul_eq_mul] using hh
  have hsub : (∫ x in ((j : ℝ) / (N : ℝ))..(((j : ℝ) + 1) / (N : ℝ)),
      (arrayImage c N x - arrayImage c M x) ^ 2) ≤
      ∫ x in Set.Ioi (0 : ℝ), (arrayImage c N x - arrayImage c M x) ^ 2 := by
    rw [intervalIntegral.integral_of_le hends]
    apply setIntegral_mono_set (arrayImage_distance_integrable c hN hM)
      (Eventually.of_forall fun x => sq_nonneg _) ?_
    exact Eventually.of_forall (fun x hx => lt_trans (by positivity) hx.1)
  have hv := reciprocal_window_variance (by exact_mod_cast hj : (1 : ℝ) ≤ (j : ℝ)) A B
  have hd := div_le_div_of_nonneg_right hv hn.le
  rw [hw] at hsub
  rw [array_distance_identity c hN hM]
  have hs := mul_le_mul_of_nonneg_left hsub
    (show 0 ≤ 24 * ((j : ℝ) + 1) ^ 4 by positivity)
  dsimp [A] at hd
  calc
    _ ≤ (24 * ((j : ℝ) + 1) ^ 4 *
        ∫ u in (j : ℝ)..((j : ℝ) + 1), (B - A / u) ^ 2) / (N : ℝ) := hd
    _ = 24 * ((j : ℝ) + 1) ^ 4 *
        ((N : ℝ)⁻¹ * ∫ u in (j : ℝ)..((j : ℝ) + 1), (B - A / u) ^ 2) := by ring
    _ ≤ _ := hs

theorem windowMoment_sq_tendsto_of_cauchy (c : ℕ → ℕ → ℝ) (h : ArrayCauchy c)
    {j : ℕ} (hj : 0 < j) :
    Tendsto (fun N : ℕ => windowMoment c N j ^ 2 / (N : ℝ)) atTop (𝓝 0) := by
  apply Metric.tendsto_atTop.mpr
  intro ε hε
  let C : ℝ := 24 * ((j : ℝ) + 1) ^ 4
  have hC : 0 < C := by dsimp [C]; positivity
  obtain ⟨K, hK⟩ := h (ε / C) (by positivity)
  let M := max K 1
  refine ⟨(j + 1) * M, fun N hN => ?_⟩
  have hM : 0 < M := by dsimp [M]; omega
  have hKM : K ≤ M := le_max_left _ _
  have hKN : K ≤ N := by nlinarith
  have hd := hK N M hKN hKM
  have hl := array_window_distance_lower c hM hj hN
  have hnonneg : 0 ≤ windowMoment c N j ^ 2 / (N : ℝ) := by positivity
  simp only [Real.dist_eq, sub_zero, abs_of_nonneg hnonneg]
  apply hl.trans_lt
  simpa only [C, mul_comm] using (lt_div_iff₀ hC).mp hd

theorem windowMoment_normalized_split (c : ℕ → ℕ → ℝ) {N j : ℕ} (hj : 0 < j) (hjN : j ≤ N) :
    windowMoment c N j / Real.sqrt (N : ℝ) =
      (∑ q ∈ (Finset.Icc 1 j).erase j,
        (q : ℝ) * c N q * ((j / q : ℕ) : ℝ) / Real.sqrt (N : ℝ)) +
      (j : ℝ) * (c N j / Real.sqrt (N : ℝ)) := by
  have hjmem : j ∈ Finset.Icc 1 j := Finset.mem_Icc.mpr ⟨hj, le_rfl⟩
  rw [windowMoment_eq_prefix c hjN,
    ← Finset.sum_erase_add _ _ hjmem, add_div, Finset.sum_div,
    Nat.div_self hj, Nat.cast_one, mul_one]
  ring

/-- Every fixed coefficient must be little-o of sqrt N if these finite
fractional-part sums are Cauchy in squared L² distance. -/
theorem fixed_coefficient_tendsto_of_cauchy (c : ℕ → ℕ → ℝ) (h : ArrayCauchy c)
    {j : ℕ} (hj : 0 < j) :
    Tendsto (fun N : ℕ => c N j / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  induction j using Nat.strong_induction_on with
  | h j ih =>
    have ha := normalized_ratio_tendsto_of_square (fun N => windowMoment c N j)
      (windowMoment_sq_tendsto_of_cauchy c h hj)
    have hl : Tendsto (fun N : ℕ => ∑ q ∈ (Finset.Icc 1 j).erase j,
        (q : ℝ) * c N q * ((j / q : ℕ) : ℝ) / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
      have hh : ∀ q ∈ (Finset.Icc 1 j).erase j,
          Tendsto (fun N : ℕ => (q : ℝ) * c N q * ((j / q : ℕ) : ℝ) /
            Real.sqrt (N : ℝ)) atTop (𝓝 (0 : ℝ)) := by
        intro q hq
        obtain ⟨hqj, hq⟩ := Finset.mem_erase.mp hq
        have hq1 := (Finset.mem_Icc.mp hq).1
        have hqle := (Finset.mem_Icc.mp hq).2
        have ht := (ih q (lt_of_le_of_ne hqle hqj) hq1).const_mul
          ((q : ℝ) * ((j / q : ℕ) : ℝ))
        convert ht using 1
        · funext N
          ring
        · simp
      simpa only [Finset.sum_const_zero] using tendsto_finset_sum _ hh
    have ht := (ha.sub hl).div_const (j : ℝ)
    have hnorm : (0 : ℝ) < (j : ℝ) := by exact_mod_cast hj
    have he : (fun N : ℕ => c N j / Real.sqrt (N : ℝ)) =ᶠ[atTop]
        (fun N : ℕ => (windowMoment c N j / Real.sqrt (N : ℝ) -
          ∑ q ∈ (Finset.Icc 1 j).erase j,
            (q : ℝ) * c N q * ((j / q : ℕ) : ℝ) / Real.sqrt (N : ℝ)) / (j : ℝ)) := by
      filter_upwards [eventually_ge_atTop j] with N hN
      rw [windowMoment_normalized_split c hj hN]
      field_simp
      ring
    apply Tendsto.congr' he.symm
    simpa only [sub_self, zero_div] using ht

theorem arrayCauchy_false_of_fixed_quotient (c : ℕ → ℕ → ℝ) {q : ℕ} (hq : 0 < q)
    (heq : ∀ᶠ N : ℕ in atTop, c N q = (quotientCoefficient N q : ℝ))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ ArrayCauchy c := by
  intro h
  apply fixed_quotient_not_small_of_mertens_oscillation hq hM
  have ht := fixed_coefficient_tendsto_of_cauchy c h hq
  apply ht.congr'
  filter_upwards [heq] with N hN
  rw [hN]

/-- Arbitrary N-dependent changes to any fixed initial set of quotient
coefficients cannot repair the L² Cauchy property, under the explicit
established Mertens oscillation premise. -/
theorem finite_quotient_repair_not_cauchy (c : ℕ → ℕ → ℝ) (K : ℕ)
    (heq : ∀ᶠ N : ℕ in atTop, ∀ q, K < q → q ≤ N → c N q = (quotientCoefficient N q : ℝ))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ ArrayCauchy c := by
  apply arrayCauchy_false_of_fixed_quotient c (q := K + 1) (by omega) ?_ hM
  filter_upwards [heq, eventually_ge_atTop (K + 1)] with N hN hKN
  exact hN (K + 1) (by omega) hKN

theorem arrayFraction_distance_integrable (c : ℕ → ℕ → ℝ) {N M : ℕ}
    (hN : 0 < N) (hM : 0 < M) :
    IntegrableOn (fun x => (arrayFraction c N x - arrayFraction c M x) ^ 2) (Set.Ioi (0 : ℝ)) := by
  have hp : ∀ i j : ℕ, 0 < i → 0 < j →
      IntegrableOn (fun x => arrayFraction c i x * arrayFraction c j x) (Set.Ioi (0 : ℝ)) := by
    intro i j hi hj
    exact kernelSum_product_integrable _ _ _ _ _ _ _ _ (fun _ hq _ hr =>
      fractionKernel_product_integrable (quotient_parameter_pos hi hq) (quotient_parameter_pos hj hr))
  have he : (fun x => (arrayFraction c N x - arrayFraction c M x) ^ 2) =
      (fun x => arrayFraction c N x * arrayFraction c N x -
        2 * (arrayFraction c N x * arrayFraction c M x) + arrayFraction c M x * arrayFraction c M x) := by
    funext x
    ring
  rw [he]
  exact ((hp N N hN hN).sub ((hp N M hN hM).const_mul 2)).add (hp M M hM hM)

theorem arrayCauchy_of_squared_convergence (c : ℕ → ℕ → ℝ) (g : ℝ → ℝ)
    (hI : ∀ N : ℕ, 0 < N →
      IntegrableOn (fun x => (arrayFraction c N x - g x) ^ 2) (Set.Ioi (0 : ℝ)))
    (h : Tendsto (fun N : ℕ =>
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - g x) ^ 2) atTop (𝓝 0)) :
    ArrayCauchy c := by
  intro ε hε
  obtain ⟨K, hK⟩ := Metric.tendsto_atTop.mp h (ε / 4) (by positivity)
  refine ⟨max K 1, fun N M hN hM => ?_⟩
  have hn : 0 < N := by have := (le_max_right K 1).trans hN; omega
  have hm : 0 < M := by have := (le_max_right K 1).trans hM; omega
  have hEN := hK N ((le_max_left K 1).trans hN)
  have hEM := hK M ((le_max_left K 1).trans hM)
  simp only [Real.dist_eq, sub_zero] at hEN hEM
  have heN := (le_abs_self _).trans_lt hEN
  have heM := (le_abs_self _).trans_lt hEM
  have hb : (∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - arrayFraction c M x) ^ 2) ≤
      ∫ x in Set.Ioi (0 : ℝ), 2 * (arrayFraction c N x - g x) ^ 2 +
        2 * (arrayFraction c M x - g x) ^ 2 := by
    apply integral_mono_ae (arrayFraction_distance_integrable c hn hm)
      (((hI N hn).const_mul 2).add ((hI M hm).const_mul 2))
    exact Eventually.of_forall (fun x => by
      dsimp only [Pi.add_apply]
      nlinarith [sq_nonneg (arrayFraction c N x + arrayFraction c M x - 2 * g x)])
  rw [integral_add ((hI N hn).const_mul 2) ((hI M hm).const_mul 2),
    integral_const_mul, integral_const_mul] at hb
  linarith

theorem finite_quotient_repair_not_convergent (c : ℕ → ℕ → ℝ) (K : ℕ) (g : ℝ → ℝ)
    (heq : ∀ᶠ N : ℕ in atTop, ∀ q, K < q → q ≤ N → c N q = (quotientCoefficient N q : ℝ))
    (hI : ∀ N : ℕ, 0 < N →
      IntegrableOn (fun x => (arrayFraction c N x - g x) ^ 2) (Set.Ioi (0 : ℝ)))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto (fun N : ℕ =>
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - g x) ^ 2) atTop (𝓝 0) := by
  intro h
  exact finite_quotient_repair_not_cauchy c K heq hM (arrayCauchy_of_squared_convergence c g hI h)

end BuildingBlocks
