import BuildingBlocks.PrimeBlockSource

open MeasureTheory Set Finset
open scoped BigOperators Interval ENNReal

namespace BuildingBlocks.PrimeSourceDistinctFilter

open SamePrimeBirthConvolution SamePrimeBlockCalibration PrimeBlockSource ReflectionFilter ReflectionEnergy

noncomputable def density (v : ℝ) : ℝ := Real.exp (v / 2)
noncomputable def primesAt (s : ℝ) : Finset ℕ := (Finset.Icc 2 ⌊Real.exp s⌋₊).filter Nat.Prime
noncomputable def frozenSum (s v : ℝ) : ℝ := ∑ p ∈ primesAt s, primeBlock p v
noncomputable def conv (f g : ℝ → ℝ) (v : ℝ) : ℝ := ∫ u in 0..v, f u * g (v - u)

/-- Actual outer-prime cutoff freezing at every earlier age. -/
theorem frozenSum_eq {s v : ℝ} (hv : v ≤ s) : frozenSum s v = primeBlockSum v := by
  have hN := Nat.floor_mono (Real.exp_le_exp.mpr hv)
  unfold frozenSum primeBlockSum primesAt
  rw [← Finset.sum_filter]
  symm
  apply Finset.sum_subset
  · intro p hp
    rcases Finset.mem_filter.mp hp with ⟨hpN, hp⟩
    exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hpN).1, (Finset.mem_Icc.mp hpN).2.trans hN⟩, hp⟩
  · intro p hp hpnot
    rcases Finset.mem_filter.mp hp with ⟨hpN, hp⟩
    apply primeBlock_eq_zero_above_cutoff hp
    by_contra h
    exact hpnot (Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hpN).1, le_of_not_gt h⟩, hp⟩)

theorem source_eq_frozen {s v : ℝ} (hv : v ∈ Set.Icc 0 s) :
    source v = frozenSum s v - density v := by
  rw [source_eq_primeBlocks hv.1, frozenSum_eq hv.2]
  rfl

/-- Each literal birth has local L2 norm; its discontinuity at birth is retained. -/
theorem birth_memLp (b s : ℝ) : MemLp (birth b) 2 (volume.restrict (Set.Icc 0 s)) := by
  have hm : Measurable (birth b) :=
    (by fun_prop : Continuous (fun v : ℝ => Real.exp (-v / 2))).measurable.indicator measurableSet_Ici
  apply MemLp.of_bound hm.aestronglyMeasurable 1
  filter_upwards [ae_restrict_mem measurableSet_Icc] with v hv
  by_cases hb : b ≤ v
  · have he : Real.exp (-v / 2) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith [hv.1])
    simpa [birth, hb, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)] using he
  · simp [birth, hb]

theorem block_memLp (N p : ℕ) (s : ℝ) : MemLp (block N p) 2 (volume.restrict (Set.Icc 0 s)) :=
  (memLp_finset_sum (Finset.Icc 1 N) (fun j _ => birth_memLp ((j : ℝ) * Real.log p) s)).const_mul (Real.log p)

theorem primeBlock_memLp {p : ℕ} (hp : p.Prime) (s : ℝ) :
    MemLp (primeBlock p) 2 (volume.restrict (Set.Icc 0 s)) := by
  apply (block_memLp ⌊Real.exp s⌋₊ p s).ae_eq
  filter_upwards [ae_restrict_mem measurableSet_Icc] with v hv
  exact block_eq_primeBlock_on hp hv.2

theorem frozenSum_memLp (s : ℝ) : MemLp (frozenSum s) 2 (volume.restrict (Set.Icc 0 s)) :=
  memLp_finset_sum (primesAt s) (fun p hp => primeBlock_memLp (Finset.mem_filter.mp hp).2 s)

theorem density_memLp (s : ℝ) : MemLp density 2 (volume.restrict (Set.Icc 0 s)) := by
  apply MemLp.of_bound (by unfold density; fun_prop : Continuous density).measurable.aestronglyMeasurable (Real.exp (s / 2))
  filter_upwards [ae_restrict_mem measurableSet_Icc] with v hv
  simpa [density, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)] using
    Real.exp_le_exp.mpr (div_le_div_of_nonneg_right hv.2 (by norm_num))

/-- Local L2 of the actual causal source follows from complete prime histories and density. -/
theorem source_memLp (s : ℝ) : MemLp source 2 (volume.restrict (Set.Icc 0 s)) := by
  apply ((frozenSum_memLp s).sub (density_memLp s)).ae_eq
  filter_upwards [ae_restrict_mem measurableSet_Icc] with v hv
  exact (source_eq_frozen hv).symm

private theorem memLp_earlier {f : ℝ → ℝ} {s v : ℝ}
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) (hv : v ≤ s) :
    MemLp f 2 (volume.restrict (Set.Icc 0 v)) :=
  hf.mono_measure (Measure.restrict_mono (Icc_subset_Icc_right hv) le_rfl)

theorem conv_integrand {f g : ℝ → ℝ} {s v : ℝ} (hv : v ∈ Set.Icc 0 s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun u => f u * g (v - u)) volume 0 v :=
  cross_intervalIntegrable hv.1 (memLp_earlier hf hv.2)
    (reflected_memLp hv.1 (memLp_earlier hg hv.2))

private theorem interval_eq_Icc (g : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) :
    (∫ u in a..b, g u) = ∫ u in Set.Icc a b, g u := by
  rw [intervalIntegral.integral_of_le hab, integral_Icc_eq_integral_Ioc]

/-- Local age-integrability for two possibly different actual L2 inputs. -/
theorem conv_integrableOn {f g : ℝ → ℝ} {s : ℝ}
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    IntegrableOn (conv f g) (Set.Icc 0 s) := by
  let fc := (Set.Icc 0 s).indicator f
  let gc := (Set.Icc 0 s).indicator g
  have hfc : Integrable fc := (integrable_indicator_iff measurableSet_Icc).mpr (hf.integrable (by norm_num))
  have hgc : Integrable gc := (integrable_indicator_iff measurableSet_Icc).mpr (hg.integrable (by norm_num))
  have hc := hfc.integrable_convolution (L := ContinuousLinearMap.mul ℝ ℝ) hgc
  apply hc.integrableOn.congr_fun _ measurableSet_Icc
  intro v hv
  unfold conv
  rw [MeasureTheory.convolution_def, interval_eq_Icc _ hv.1, ← integral_indicator measurableSet_Icc]
  apply integral_congr_ae
  filter_upwards [] with u
  change fc u * gc (v - u) = (Set.Icc 0 v).indicator (fun u => f u * g (v - u)) u
  by_cases hu : u ∈ Set.Icc 0 v
  · have huS : u ∈ Set.Icc 0 s := ⟨hu.1, hu.2.trans hv.2⟩
    have hsub : v - u ∈ Set.Icc 0 s := ⟨sub_nonneg.mpr hu.2, by linarith [hv.2, hu.1]⟩
    simp [fc, gc, Set.indicator_of_mem huS, Set.indicator_of_mem hsub, Set.indicator_of_mem hu]
  · rw [Set.indicator_of_notMem hu]
    by_cases hu0 : 0 ≤ u
    · have huv : v < u := lt_of_not_ge (fun hh => hu ⟨hu0, hh⟩)
      have hsub : v - u ∉ Set.Icc 0 s := fun hh => (not_le_of_gt huv) (sub_nonneg.mp hh.1)
      simp [gc, Set.indicator_of_notMem hsub]
    · have huS : u ∉ Set.Icc 0 s := fun hh => hu0 hh.1
      simp [fc, Set.indicator_of_notMem huS]

theorem filtered_conv_integrable {f g : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * conv f g v) volume 0 s := by
  have hi : IntervalIntegrable (conv f g) volume 0 s :=
    (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr (conv_integrableOn hf hg)
  exact hi.continuousOn_mul (by fun_prop)

private theorem conv_sub_left {f g q : ℝ → ℝ} {s v : ℝ} (hv : v ∈ Set.Icc 0 s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s)))
    (hq : MemLp q 2 (volume.restrict (Set.Icc 0 s))) :
    conv (fun u => f u - g u) q v = conv f q v - conv g q v := by
  unfold conv
  simp only [sub_mul]
  exact intervalIntegral.integral_sub (conv_integrand hv hf hq) (conv_integrand hv hg hq)

private theorem conv_sub_right {f g q : ℝ → ℝ} {s v : ℝ} (hv : v ∈ Set.Icc 0 s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s)))
    (hq : MemLp q 2 (volume.restrict (Set.Icc 0 s))) :
    conv f (fun u => g u - q u) v = conv f g v - conv f q v := by
  unfold conv
  simp only [mul_sub]
  exact intervalIntegral.integral_sub (conv_integrand hv hf hg) (conv_integrand hv hf hq)

private theorem conv_sum_left {J : Finset ℕ} {F : ℕ → ℝ → ℝ} {g : ℝ → ℝ} {s v : ℝ}
    (hv : v ∈ Set.Icc 0 s) (hF : ∀ p ∈ J, MemLp (F p) 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    conv (fun u => ∑ p ∈ J, F p u) g v = ∑ p ∈ J, conv (F p) g v := by
  unfold conv
  simp only [Finset.sum_mul]
  exact intervalIntegral.integral_finset_sum (fun p hp => conv_integrand hv (hF p hp) hg)

private theorem conv_sum_right {J : Finset ℕ} {F : ℕ → ℝ → ℝ} {g : ℝ → ℝ} {s v : ℝ}
    (hv : v ∈ Set.Icc 0 s) (hF : ∀ p ∈ J, MemLp (F p) 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    conv g (fun u => ∑ p ∈ J, F p u) v = ∑ p ∈ J, conv g (F p) v := by
  unfold conv
  simp only [Finset.mul_sum]
  exact intervalIntegral.integral_finset_sum (fun p hp => conv_integrand hv hg (hF p hp))

noncomputable def diagonal (s v : ℝ) : ℝ := ∑ p ∈ primesAt s, conv (primeBlock p) (primeBlock p) v
noncomputable def distinct (s v : ℝ) : ℝ :=
  ∑ p ∈ primesAt s, ∑ q ∈ (primesAt s).erase p, conv (primeBlock p) (primeBlock q) v
noncomputable def mixedLeft (s v : ℝ) : ℝ := ∑ p ∈ primesAt s, conv (primeBlock p) density v
noncomputable def mixedRight (s v : ℝ) : ℝ := ∑ p ∈ primesAt s, conv density (primeBlock p) v

/-- Exact actual-source expansion with all ordered distinct-prime histories and both density orders. -/
theorem source_convolution_expansion {s v : ℝ} (hv : v ∈ Set.Icc 0 s) :
    conv source source v - diagonal s v =
      distinct s v - mixedLeft s v - mixedRight s v + conv density density v := by
  have hP : ∀ p ∈ primesAt s, MemLp (primeBlock p) 2 (volume.restrict (Set.Icc 0 s)) :=
    fun p hp => primeBlock_memLp (Finset.mem_filter.mp hp).2 s
  have hQ := frozenSum_memLp s
  have hD := density_memLp s
  have heq : conv source source v = conv (fun u => frozenSum s u - density u)
      (fun u => frozenSum s u - density u) v := by
    unfold conv
    apply intervalIntegral.integral_congr
    intro u hu
    have hu' : u ∈ Set.Icc 0 v := by simpa [uIcc_of_le hv.1] using hu
    dsimp only
    rw [source_eq_frozen ⟨hu'.1, hu'.2.trans hv.2⟩,
      source_eq_frozen (s := s) ⟨sub_nonneg.mpr hu'.2, by linarith [hu'.1, hv.2]⟩]
  have hQDmem : MemLp (fun u => frozenSum s u - density u) 2 (volume.restrict (Set.Icc 0 s)) := hQ.sub hD
  rw [heq, conv_sub_left hv hQ hD hQDmem, conv_sub_right hv hQ hQ hD,
    conv_sub_right hv hD hQ hD]
  have hQQ : conv (frozenSum s) (frozenSum s) v = diagonal s v + distinct s v := by
    change conv (fun u => ∑ p ∈ primesAt s, primeBlock p u) (frozenSum s) v = _
    rw [conv_sum_left hv hP hQ]
    unfold frozenSum diagonal distinct
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro p hp
    rw [conv_sum_right hv hP (hP p hp)]
    have he := Finset.sum_erase_add (s := primesAt s)
      (f := fun q => conv (primeBlock p) (primeBlock q) v) hp
    linarith
  rw [hQQ]
  have hQD : conv (frozenSum s) density v = mixedLeft s v := conv_sum_left hv hP hD
  have hDQ : conv density (frozenSum s) v = mixedRight s v := conv_sum_right hv hP hD
  rw [hQD, hDQ]
  ring

private abbrev WI (s : ℝ) (F : ℝ → ℝ) :=
  IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * F v) volume 0 s

private theorem wi_sub {s : ℝ} {F G : ℝ → ℝ} (hF : WI s F) (hG : WI s G) :
    WI s (fun v => F v - G v) := by
  unfold WI
  have heq : (fun v => Real.exp (-3 * (s - v) / 2) * (F v - G v)) =
      (fun v => Real.exp (-3 * (s - v) / 2) * F v - Real.exp (-3 * (s - v) / 2) * G v) := by
    funext v
    exact mul_sub _ _ _
  rw [heq]
  exact hF.sub hG

private theorem wi_sum (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (s : ℝ)
    (hi : ∀ p ∈ J, WI s (F p)) : WI s (fun v => ∑ p ∈ J, F p v) := by
  unfold WI
  simp only [Finset.mul_sum]
  convert (IntervalIntegrable.sum J
    (f := fun p v => Real.exp (-3 * (s - v) / 2) * F p v) hi) using 1
  funext v
  simp

private theorem L0_sum (J : Finset ℕ) (F : ℕ → ℝ → ℝ) (s : ℝ)
    (hi : ∀ p ∈ J, WI s (F p)) :
    L0 (fun v => ∑ p ∈ J, F p v) s = ∑ p ∈ J, L0 (F p) s := by
  unfold L0
  simp_rw [Finset.mul_sum]
  rw [intervalIntegral.integral_finset_sum hi, Finset.sum_sub_distrib]

private theorem L0_sub (F G : ℝ → ℝ) {s : ℝ} (hF : WI s F) (hG : WI s G) :
    L0 (fun v => F v - G v) s = L0 F s - L0 G s := by
  unfold L0
  have heq : (fun v => Real.exp (-3 * (s - v) / 2) * (F v - G v)) =
      (fun v => Real.exp (-3 * (s - v) / 2) * F v - Real.exp (-3 * (s - v) / 2) * G v) := by
    funext v
    exact mul_sub _ _ _
  rw [heq, intervalIntegral.integral_sub hF hG]
  ring

private theorem L0_add (F G : ℝ → ℝ) {s : ℝ} (hF : WI s F) (hG : WI s G) :
    L0 (fun v => F v + G v) s = L0 F s + L0 G s := by
  unfold L0
  simp only [mul_add]
  rw [intervalIntegral.integral_add hF hG]
  ring

private theorem L0_congr {F G : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (heq : Set.EqOn F G (Set.Icc 0 s)) : L0 F s = L0 G s := by
  unfold L0
  rw [heq ⟨hs, le_rfl⟩]
  congr 1
  apply intervalIntegral.integral_congr
  intro v hv
  have hv' : v ∈ Set.Icc 0 s := by simpa [uIcc_of_le hs] using hv
  dsimp only
  rw [heq hv']

/-- The aggregate diagonal is exactly the already calibrated literal tau, after filtering. -/
theorem filtered_diagonal_eq_tau {s : ℝ} (hs : 0 ≤ s) : L0 (diagonal s) s = tau s := by
  have hi : ∀ p ∈ primesAt s, WI s (conv (primeBlock p) (primeBlock p)) := fun p hp =>
    filtered_conv_integrable hs (primeBlock_memLp (Finset.mem_filter.mp hp).2 s)
      (primeBlock_memLp (Finset.mem_filter.mp hp).2 s)
  unfold diagonal
  rw [L0_sum _ _ _ hi]
  simpa only [primesAt, Finset.sum_filter, conv] using actual_tau_calibration hs

/-- The full filtered actual-source expansion, with ordered distinct primes and both mixed orders. -/
theorem filtered_source_distinct {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv source source) s - tau s =
      L0 (distinct s) s - L0 (mixedLeft s) s - L0 (mixedRight s) s +
        L0 (conv density density) s := by
  have hP : ∀ p ∈ primesAt s, MemLp (primeBlock p) 2 (volume.restrict (Set.Icc 0 s)) :=
    fun p hp => primeBlock_memLp (Finset.mem_filter.mp hp).2 s
  have hpp : ∀ p ∈ primesAt s, ∀ q ∈ primesAt s, WI s (conv (primeBlock p) (primeBlock q)) :=
    fun p hp q hq => filtered_conv_integrable hs (hP p hp) (hP q hq)
  have hdiag : WI s (diagonal s) := wi_sum _ _ _ (fun p hp => hpp p hp p hp)
  have hdist : WI s (distinct s) := wi_sum _ _ _ (fun p hp =>
    wi_sum _ _ _ (fun q hq => hpp p hp q (Finset.mem_of_mem_erase hq)))
  have hml : WI s (mixedLeft s) := wi_sum _ _ _ (fun p hp =>
    filtered_conv_integrable hs (hP p hp) (density_memLp s))
  have hmr : WI s (mixedRight s) := wi_sum _ _ _ (fun p hp =>
    filtered_conv_integrable hs (density_memLp s) (hP p hp))
  have hdd : WI s (conv density density) := filtered_conv_integrable hs (density_memLp s) (density_memLp s)
  have haa : WI s (conv source source) := filtered_conv_integrable hs (source_memLp s) (source_memLp s)
  rw [← filtered_diagonal_eq_tau hs, ← L0_sub _ _ haa hdiag]
  have heq := L0_congr hs (F := fun v => conv source source v - diagonal s v)
    (G := fun v => distinct s v - mixedLeft s v - mixedRight s v + conv density density v)
    (fun v hv => source_convolution_expansion hv)
  rw [heq, L0_add _ _ (wi_sub (wi_sub hdist hml) hmr) hdd,
    L0_sub _ _ (wi_sub hdist hml) hmr, L0_sub _ _ hdist hml]

/-- The density square is literal, including the zero-length endpoint. -/
theorem density_convolution {s : ℝ} (hs : 0 ≤ s) : conv density density s = s * Real.exp (s / 2) := by
  unfold conv density
  have heq : (fun u => Real.exp (u / 2) * Real.exp ((s - u) / 2)) = (fun _ : ℝ => Real.exp (s / 2)) := by
    funext u
    rw [← Real.exp_add]
    congr 1
    ring
  rw [heq, intervalIntegral.integral_const]
  simp

#print axioms source_memLp
#print axioms filtered_conv_integrable
#print axioms source_convolution_expansion
#print axioms filtered_diagonal_eq_tau
#print axioms filtered_source_distinct

end BuildingBlocks.PrimeSourceDistinctFilter
