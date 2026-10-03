import BuildingBlocks.ActualCriticalMellin

open scoped BigOperators
open MeasureTheory Set

namespace BuildingBlocks.ActualFullCenteredMellin

/-- The same actual centered core before removing the proper-power allocation. -/
theorem N_eq_V_add_T (x : ℝ) :
    ActualCenteredMellin.N x = ActualCenteredMellin.V x + ActualCenteredMellin.T x := by
  rw [ActualCenteredMellin.V_eq_N_sub_T]
  ring

theorem T_zero {x : ℝ} (hx : x ≤ 1) : ActualCenteredMellin.T x = 0 := by
  unfold ActualCenteredMellin.T RieszDirichlet.cutoffSum
  apply Finset.sum_eq_zero
  intro j hj
  have h : x - ((j : ℝ) + 1) ≤ 0 := by linarith [Nat.cast_nonneg (α := ℝ) j]
  simp [RieszTentMellin.tent, max_eq_right h]

theorem N_zero {x : ℝ} (hx : x ≤ 1) : ActualCenteredMellin.N x = 0 := by
  rw [N_eq_V_add_T, ActualCriticalMellin.V_zero hx, T_zero hx, zero_add]

theorem T_real (x : ℝ) : (ActualCenteredMellin.T x).im = 0 := by
  simp [ActualCenteredMellin.T, RieszDirichlet.cutoffSum,
    DistinctPrimeRieszMellin.samePair, RieszTentMellin.tent, Complex.mul_im]

theorem N_real (x : ℝ) : (ActualCenteredMellin.N x).im = 0 := by
  rw [N_eq_V_add_T, Complex.add_im, ActualCriticalMellin.V_real, T_real, zero_add]

/-- Actual ordered Mangoldt pairs, the full eta cross term and baseline give
the centered logarithmic-derivative square, with no allocation subtracted. -/
theorem hasMellin_N {s : ℂ} (hs : 1 < s.re) :
    HasMellin ActualCenteredMellin.N (-s - 1)
      (LogDerivativePole.centeredZetaLogDerivative s ^ 2 / (s * (s + 1))) := by
  have hd := DistinctPrimeRieszMellin.hasMellin_cutoffSum_of_LSeriesHasSum
    (show 0 < s.re by linarith) (DistinctPrimeRieszMellin.fullPair_hasSum hs)
  have he : HasMellin ActualCenteredMellin.etaSum (-s - 1)
      ((-deriv riemannZeta s / riemannZeta s) / ((s - 1) * (s + 1))) := by
    rw [ActualCenteredMellin.etaSum_eq_crossTerm]
    exact EtaRieszDirichlet.hasMellin_crossTerm hs
  have hb := EtaBaselineMellin.hasMellin_B hs
  have he2 := hasMellin_const_smul he.1 (2 : ℂ)
  have hsub := hasMellin_sub hd.1 he2.1
  have hsum := hasMellin_add hsub.1 hb.1
  change HasMellin
    (fun x => RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.fullPair x -
      (2 : ℂ) • ActualCenteredMellin.etaSum x + EtaBaselineMellin.B x) (-s - 1) _
  refine ⟨hsum.1, ?_⟩
  rw [hsum.2, hsub.2, hd.2, he2.2, he.2, hb.2]
  have h0 : s ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have h1 : s - 1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have h2 : s + 1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hz : riemannZeta s ≠ 0 := riemannZeta_ne_zero_of_one_lt_re hs
  simp only [LogDerivativePole.centeredZetaLogDerivative, logDeriv_apply,
    neg_div, smul_eq_mul]
  field_simp [hz]
  ring

/-- The actual proper-power allocation has its own absolutely convergent
Mellin identity on Re(s)>1/2. Every same-prime exponent is retained. -/
theorem hasMellin_T {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    HasMellin ActualCenteredMellin.T (-s - 1)
      (SamePrimeDirichlet.H s / (s * (s + 1))) :=
  DistinctPrimeRieszMellin.hasMellin_cutoffSum_of_LSeriesHasSum
    (by linarith) (DistinctPrimeRieszMellin.samePair_hasSum hs)

private theorem rieszCutoff_eq_Icc (c : ℕ → ℂ) {x : ℝ} (hx : 0 ≤ x) :
    RieszDirichlet.cutoffSum c x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((x - n : ℝ) : ℂ) * c n := by
  unfold RieszDirichlet.cutoffSum
  apply Finset.sum_bij (fun j _ => j + 1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n - 1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    have hjn : j + 1 ≤ ⌊x⌋₊ := by simpa only [Finset.mem_range] using hj
    have hjx : (j : ℝ) + 1 ≤ x := by
      have hcast : (j : ℝ) + 1 ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hjn
      exact hcast.trans (Nat.floor_le hx)
    simp only [RieszTentMellin.tent, Nat.cast_add, Nat.cast_one,
      max_eq_left (sub_nonneg.mpr hjx)]
    ring

/-- The full real-cutoff formula includes all ordered Mangoldt pairs, every
proper power, both eta components and the baseline constant. -/
theorem N_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    ActualCenteredMellin.N x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n -
          ArithmeticFunction.vonMangoldt n * ((x ^ 2 - (n : ℝ) ^ 2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x := by
  unfold ActualCenteredMellin.N
  rw [rieszCutoff_eq_Icc _ hx, ActualCenteredMellin.etaSum_eq_Icc hx]
  simp only [DistinctPrimeRieszMellin.fullPair_eq]
  push_cast
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : (n : ℂ) ≠ 0 := by
    have := (Finset.mem_Icc.mp hn).1
    exact_mod_cast (show n ≠ 0 by omega)
  field_simp

theorem T_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    ActualCenteredMellin.T x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - n) * samePrimePairWeight n : ℝ) : ℂ) := by
  unfold ActualCenteredMellin.T
  rw [rieszCutoff_eq_Icc _ hx]
  simp only [DistinctPrimeRieszMellin.samePair, Complex.ofReal_sum, Complex.ofReal_mul]

/-- Literal square-root aggregation of the complete actual centered core. -/
noncomputable def fullNumerator (x : ℝ) : ℂ :=
  CriticalMultipleMellin.cutoffSum ActualCenteredMellin.N x

/-- Literal complete same-prime allocation, including every proper power
and every square-root cofactor through the actual real cutoff. -/
noncomputable def allocation (x : ℝ) : ℂ :=
  CriticalMultipleMellin.cutoffSum ActualCenteredMellin.T x

private theorem criticalCutoff_eq_Icc (f : ℝ → ℂ) (x : ℝ) :
    CriticalMultipleMellin.cutoffSum f x =
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * f (x / d) := by
  unfold CriticalMultipleMellin.cutoffSum
  apply Finset.sum_bij (fun j _ => j + 1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n - 1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    simp [CriticalMultipleMellin.scaled]

theorem fullNumerator_eq_Icc (x : ℝ) :
    fullNumerator x =
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * ActualCenteredMellin.N (x / d) :=
  criticalCutoff_eq_Icc _ x

theorem allocation_eq_Icc (x : ℝ) :
    allocation x =
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * ActualCenteredMellin.T (x / d) :=
  criticalCutoff_eq_Icc _ x

/-- The already formalized actual W is the complete centered row minus
the complete proper-power allocation, at every real cutoff. -/
theorem W_eq_fullNumerator_sub_allocation (x : ℝ) :
    ActualCriticalMellin.W x = fullNumerator x - allocation x := by
  unfold ActualCriticalMellin.W fullNumerator allocation CriticalMultipleMellin.cutoffSum
    CriticalMultipleMellin.scaled
  simp_rw [ActualCenteredMellin.V_eq_N_sub_T, mul_sub]
  simp only [Finset.sum_sub_distrib]

theorem fullNumerator_real (x : ℝ) : (fullNumerator x).im = 0 := by
  rw [fullNumerator_eq_Icc]
  simp [Complex.mul_im, N_real]

theorem allocation_real (x : ℝ) : (allocation x).im = 0 := by
  rw [allocation_eq_Icc]
  simp [Complex.mul_im, T_real]

theorem fullNumerator_eq_real_sum (x : ℝ) :
    fullNumerator x =
      ((∑ d ∈ Finset.Icc 1 ⌊x⌋₊,
        Real.sqrt d * (ActualCenteredMellin.N (x / d)).re : ℝ) : ℂ) := by
  apply Complex.ext
  · rw [fullNumerator_eq_Icc]
    simp [Complex.mul_re]
  · simp [fullNumerator_real]

theorem allocation_eq_real_sum (x : ℝ) :
    allocation x =
      ((∑ d ∈ Finset.Icc 1 ⌊x⌋₊,
        Real.sqrt d * (ActualCenteredMellin.T (x / d)).re : ℝ) : ℂ) := by
  apply Complex.ext
  · rw [allocation_eq_Icc]
    simp [Complex.mul_re]
  · simp [allocation_real]

theorem fullNumerator_zero {x : ℝ} (hx : x ≤ 1) : fullNumerator x = 0 := by
  rw [fullNumerator_eq_Icc]
  apply Finset.sum_eq_zero
  intro d hd
  have hd1 : (1 : ℝ) ≤ d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hxd : x / d ≤ 1 := (div_le_one (by linarith)).mpr (hx.trans hd1)
  rw [N_zero hxd, mul_zero]

theorem allocation_zero {x : ℝ} (hx : x ≤ 1) : allocation x = 0 := by
  rw [allocation_eq_Icc]
  apply Finset.sum_eq_zero
  intro d hd
  have hd1 : (1 : ℝ) ≤ d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hxd : x / d ≤ 1 := (div_le_one (by linarith)).mpr (hx.trans hd1)
  rw [T_zero hxd, mul_zero]

/-- Complete full-row Mellin identity on its absolute-convergence domain. -/
theorem hasMellin_fullNumerator {s : ℂ} (hs : 1 < s.re) :
    HasMellin fullNumerator (-s - 1)
      (riemannZeta (s + 1 / 2) * LogDerivativePole.centeredZetaLogDerivative s ^ 2 /
        (s * (s + 1))) := by
  have h := CriticalMultipleMellin.hasMellin_cutoffSum
    (show (1 : ℝ) / 2 < s.re by linarith)
    (fun x hx => N_zero hx) (hasMellin_N hs)
  convert h using 1
  ring

theorem hasMellin_allocation {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    HasMellin allocation (-s - 1)
      (riemannZeta (s + 1 / 2) * SamePrimeDirichlet.H s / (s * (s + 1))) := by
  have h := CriticalMultipleMellin.hasMellin_cutoffSum hs
    (fun x hx => T_zero hx) (hasMellin_T hs)
  convert h using 1
  ring

theorem integrableOn_fullNumerator_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * fullNumerator x) (Ioi 1) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * fullNumerator x)
      (Ioi 0) := by
    simpa only [MellinConvergent, smul_eq_mul,
      show (-s - 1) - 1 = -s - 2 by ring] using (hasMellin_fullNumerator hs).1
  exact hi.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))

theorem integral_fullNumerator_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * fullNumerator x) =
      riemannZeta (s + 1 / 2) * LogDerivativePole.centeredZetaLogDerivative s ^ 2 /
        (s * (s + 1)) := by
  have he : (∫ x : ℝ in Ioi 0, (x : ℂ) ^ (-s - 2) * fullNumerator x) =
      ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * fullNumerator x := by
    apply setIntegral_eq_of_subset_of_forall_diff_eq_zero measurableSet_Ioi
      (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
    intro x hx
    rw [fullNumerator_zero (le_of_not_gt hx.2), mul_zero]
  rw [← he]
  simpa only [mellin, smul_eq_mul,
    show (-s - 1) - 1 = -s - 2 by ring] using (hasMellin_fullNumerator hs).2

theorem integrableOn_allocation_Ioi_one {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * allocation x) (Ioi 1) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * allocation x)
      (Ioi 0) := by
    simpa only [MellinConvergent, smul_eq_mul,
      show (-s - 1) - 1 = -s - 2 by ring] using (hasMellin_allocation hs).1
  exact hi.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))

theorem integral_allocation_Ioi_one {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * allocation x) =
      riemannZeta (s + 1 / 2) * SamePrimeDirichlet.H s / (s * (s + 1)) := by
  have he : (∫ x : ℝ in Ioi 0, (x : ℂ) ^ (-s - 2) * allocation x) =
      ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * allocation x := by
    apply setIntegral_eq_of_subset_of_forall_diff_eq_zero measurableSet_Ioi
      (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
    intro x hx
    rw [allocation_zero (le_of_not_gt hx.2), mul_zero]
  rw [← he]
  simpa only [mellin, smul_eq_mul,
    show (-s - 1) - 1 = -s - 2 by ring] using (hasMellin_allocation hs).2

end BuildingBlocks.ActualFullCenteredMellin
