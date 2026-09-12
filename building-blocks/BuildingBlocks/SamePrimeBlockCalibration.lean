import BuildingBlocks.SamePrimeBirthConvolution
import BuildingBlocks.SamePrimeHistoryResidual

open MeasureTheory Set Finset
open scoped Interval ENNReal BigOperators

namespace BuildingBlocks.SamePrimeBlockCalibration

open ReflectionFilter SamePrimeBirthConvolution

noncomputable def block (N p : ℕ) (v : ℝ) : ℝ :=
  Real.log p * ∑ j ∈ Finset.Icc 1 N, birth ((j : ℝ) * Real.log p) v

noncomputable def primeBlock (p : ℕ) (v : ℝ) : ℝ := block ⌊Real.exp v⌋₊ p v

noncomputable def pair (p j k : ℕ) (v : ℝ) : ℝ :=
  ∫ u in 0..v, birth ((j : ℝ) * Real.log p) u * birth ((k : ℝ) * Real.log p) (v - u)

/-- Every omitted exponent is strictly before its own birth. -/
theorem birth_eq_zero_above_cutoff {p j : ℕ} (hp : p.Prime) {v : ℝ}
    (hj : ⌊Real.exp v⌋₊ < j) : birth ((j : ℝ) * Real.log p) v = 0 := by
  have hej : Real.exp v < (j : ℝ) := (Nat.floor_lt (Real.exp_pos v).le).mp hj
  have hjp : (j : ℝ) < ((p ^ j : ℕ) : ℝ) := by exact_mod_cast j.lt_pow_self hp.one_lt
  have hpos : (0 : ℝ) < ((p ^ j : ℕ) : ℝ) := by exact_mod_cast pow_pos hp.pos j
  have hv : v < (j : ℝ) * Real.log p := by
    have hh := (Real.lt_log_iff_exp_lt hpos).mpr (hej.trans hjp)
    rwa [Nat.cast_pow, Real.log_pow] at hh
  exact Set.indicator_of_notMem (show v ∉ Ici ((j : ℝ) * Real.log p) from not_le.mpr hv) _

/-- Freezing the oversized cutoff at any later age retains every actual active exponent. -/
theorem block_eq_primeBlock {p N : ℕ} (hp : p.Prime) {v : ℝ}
    (hN : ⌊Real.exp v⌋₊ ≤ N) : block N p v = primeBlock p v := by
  unfold block primeBlock
  congr 1
  symm
  apply Finset.sum_subset
  · intro j hj
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hj).1, (Finset.mem_Icc.mp hj).2.trans hN⟩
  · intro j hj hjnot
    apply birth_eq_zero_above_cutoff hp
    have hj1 := (Finset.mem_Icc.mp hj).1
    by_contra hn
    exact hjnot (Finset.mem_Icc.mpr ⟨hj1, le_of_not_gt hn⟩)

theorem block_eq_primeBlock_on {p : ℕ} (hp : p.Prime) {s v : ℝ} (hv : v ≤ s) :
    block ⌊Real.exp s⌋₊ p v = primeBlock p v :=
  block_eq_primeBlock hp (Nat.floor_mono (Real.exp_le_exp.mpr hv))

/-- Exact square expansion before filtering, retaining every ordered pair. -/
theorem block_convolution (N p : ℕ) (v : ℝ) :
    (∫ u in 0..v, block N p u * block N p (v - u)) =
      (Real.log p) ^ 2 * ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N, pair p j k v := by
  have heq : (fun u => block N p u * block N p (v - u)) =
      (fun u => (Real.log p) ^ 2 * ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N,
        birth ((j : ℝ) * Real.log p) u * birth ((k : ℝ) * Real.log p) (v - u)) := by
    funext u
    simp only [block, ← Finset.mul_sum, ← Finset.sum_mul]
    ring
  rw [heq, intervalIntegral.integral_const_mul]
  congr 1
  rw [intervalIntegral.integral_finset_sum]
  · apply Finset.sum_congr rfl
    intro j _
    rw [intervalIntegral.integral_finset_sum]
    · rfl
    · intro k _
      exact (birth_product_integrable _ _ _).intervalIntegrable
  · intro j _
    convert (IntervalIntegrable.sum (Finset.Icc 1 N) (a := 0) (b := v)
        (f := fun k u => birth ((j : ℝ) * Real.log p) u * birth ((k : ℝ) * Real.log p) (v - u))
        (fun k _ => (birth_product_integrable _ _ _).intervalIntegrable)) using 1
    funext u
    simp

private theorem L0_const_mul (c : ℝ) (F : ℝ → ℝ) (s : ℝ) :
    L0 (fun v => c * F v) s = c * L0 F s := by
  unfold L0
  have heq : (fun v => Real.exp (-3 * (s - v) / 2) * (c * F v)) =
      (fun v => c * (Real.exp (-3 * (s - v) / 2) * F v)) := by funext v; ring
  rw [heq, intervalIntegral.integral_const_mul]
  ring

private theorem L0_sum {ι : Type*} (J : Finset ι) (F : ι → ℝ → ℝ) (s : ℝ)
    (hi : ∀ j ∈ J, IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * F j v) volume 0 s) :
    L0 (fun v => ∑ j ∈ J, F j v) s = ∑ j ∈ J, L0 (F j) s := by
  unfold L0
  simp_rw [Finset.mul_sum]
  rw [intervalIntegral.integral_finset_sum hi, Finset.sum_sub_distrib]

/-- Fixed-cutoff block calibration with all exponent pairs and the literal L0. -/
theorem filtered_block (N : ℕ) {p : ℕ} (hp : p.Prime) {s : ℝ} (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, block N p u * block N p (v - u)) s =
      (Real.log p) ^ 2 * ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N,
        Real.exp (-(((j : ℝ) + k) * Real.log p) / 2) *
          theta (s - ((j : ℝ) + k) * Real.log p) := by
  have hlog : 0 ≤ Real.log p := Real.log_nonneg (by exact_mod_cast hp.one_lt.le)
  have hi (j k : ℕ) : IntervalIntegrable
      (fun v => Real.exp (-3 * (s - v) / 2) * pair p j k v) volume 0 s :=
    filtered_pair_integrable (mul_nonneg (Nat.cast_nonneg _) hlog)
      (mul_nonneg (Nat.cast_nonneg _) hlog) hs
  simp_rw [block_convolution]
  rw [L0_const_mul, L0_sum]
  · congr 1
    apply Finset.sum_congr rfl
    intro j _
    rw [L0_sum _ _ _ (fun k _ => hi j k)]
    apply Finset.sum_congr rfl
    intro k _
    unfold pair
    rw [filtered_birth_convolution (mul_nonneg (Nat.cast_nonneg _) hlog)
      (mul_nonneg (Nat.cast_nonneg _) hlog) hs]
    congr 2 <;> ring
  · intro j _
    simp_rw [Finset.mul_sum]
    convert (IntervalIntegrable.sum (Finset.Icc 1 N)
        (f := fun k v => Real.exp (-3 * (s - v) / 2) * pair p j k v) (fun k _ => hi j k)) using 1
    funext v
    simp

/-- The frozen block square is the actual moving-cutoff prime-history square on [0,s]. -/
theorem actual_convolution_eq_block {p : ℕ} (hp : p.Prime) {s v : ℝ}
    (hv : v ∈ Icc 0 s) :
    (∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) =
      ∫ u in 0..v, block ⌊Real.exp s⌋₊ p u * block ⌊Real.exp s⌋₊ p (v - u) := by
  apply intervalIntegral.integral_congr
  intro u hu
  have hu' : u ∈ Icc 0 v := by simpa [uIcc_of_le hv.1] using hu
  dsimp only
  rw [block_eq_primeBlock_on hp (hu'.2.trans hv.2),
    block_eq_primeBlock_on hp (show v - u ≤ s by linarith [hu'.1, hv.2])]

/-- The complete actual prime block, not an arbitrarily truncated square, has this pair sum. -/
theorem filtered_actual_primeBlock {p : ℕ} (hp : p.Prime) {s : ℝ} (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s =
      (Real.log p) ^ 2 * ∑ j ∈ Finset.Icc 1 ⌊Real.exp s⌋₊, ∑ k ∈ Finset.Icc 1 ⌊Real.exp s⌋₊,
        Real.exp (-(((j : ℝ) + k) * Real.log p) / 2) *
          theta (s - ((j : ℝ) + k) * Real.log p) := by
  rw [← filtered_block ⌊Real.exp s⌋₊ hp hs]
  unfold L0
  dsimp only
  rw [actual_convolution_eq_block hp ⟨hs, le_rfl⟩]
  congr 1
  apply intervalIntegral.integral_congr
  intro v hv
  have hv' : v ∈ Icc 0 s := by simpa [uIcc_of_le hs] using hv
  dsimp only
  rw [actual_convolution_eq_block hp hv']

/-- Finite positive exponent pairs regroup by their total; larger totals are zero. -/
theorem sum_pairs_by_total (N : ℕ) (F : ℕ → ℝ)
    (hzero : ∀ m, N < m → F m = 0) :
    (∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N, F (j + k)) =
      ∑ m ∈ Finset.Icc 2 N, ((m - 1 : ℕ) : ℝ) * F m := by
  let P := (Finset.Icc 1 N ×ˢ Finset.Icc 1 N)
  let T := P.filter (fun a => a.1 + a.2 ≤ N)
  let Q := (Finset.Icc 2 N).sigma (fun m => Finset.Icc 1 (m - 1))
  have hfilter : (∑ a ∈ T, F (a.1 + a.2)) = ∑ a ∈ P, F (a.1 + a.2) := by
    apply Finset.sum_subset (Finset.filter_subset _ _)
    intro a ha hat
    apply hzero
    by_contra h
    exact hat (Finset.mem_filter.mpr ⟨ha, le_of_not_gt h⟩)
  have hbij : (∑ a ∈ T, F (a.1 + a.2)) = ∑ a ∈ Q, F a.1 := by
    apply Finset.sum_bij (fun a _ => (⟨a.1 + a.2, a.1⟩ : Sigma (fun _ : ℕ => ℕ)))
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨haP, haN⟩
      rcases Finset.mem_product.mp haP with ⟨ha1, ha2⟩
      rcases Finset.mem_Icc.mp ha1 with ⟨h1, h1N⟩
      rcases Finset.mem_Icc.mp ha2 with ⟨h2, h2N⟩
      have hm : a.1 + a.2 ∈ Finset.Icc 2 N := Finset.mem_Icc.mpr ⟨by omega, haN⟩
      have hj : a.1 ∈ Finset.Icc 1 (a.1 + a.2 - 1) := Finset.mem_Icc.mpr ⟨h1, by omega⟩
      exact Finset.mem_sigma.mpr ⟨hm, hj⟩
    · intro a ha b hb hab
      have hsum := congrArg Sigma.fst hab
      have hfst := congrArg (fun z : Sigma (fun _ : ℕ => ℕ) => z.2) hab
      dsimp only at hsum hfst
      apply Prod.ext hfst
      omega
    · intro b hb
      rcases Finset.mem_sigma.mp hb with ⟨hm, hj⟩
      rcases Finset.mem_Icc.mp hm with ⟨hm2, hmN⟩
      rcases Finset.mem_Icc.mp hj with ⟨hj1, hjm⟩
      refine ⟨(b.2, b.1 - b.2), ?_, ?_⟩
      · exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
          ⟨Finset.mem_Icc.mpr ⟨hj1, by omega⟩,
            Finset.mem_Icc.mpr ⟨by omega, by omega⟩⟩, by omega⟩
      · have hsum : b.2 + (b.1 - b.2) = b.1 := by omega
        cases b with
        | mk m j => simp only at hsum ⊢; rw [hsum]
    · intro a ha
      rfl
  calc
    _ = ∑ a ∈ P, F (a.1 + a.2) := (Finset.sum_product _ _ _).symm
    _ = ∑ a ∈ T, F (a.1 + a.2) := hfilter.symm
    _ = ∑ a ∈ Q, F a.1 := hbij
    _ = _ := by
      dsimp only [Q]
      rw [Finset.sum_sigma]
      simp

noncomputable def powerTerm (p : ℕ) (s : ℝ) (m : ℕ) : ℝ :=
  Real.exp (-((m : ℝ) * Real.log p) / 2) * theta (s - (m : ℝ) * Real.log p)

theorem powerTerm_eq_zero_above_cutoff {p m : ℕ} (hp : p.Prime) {s : ℝ}
    (hm : ⌊Real.exp s⌋₊ < m) : powerTerm p s m = 0 := by
  have hem : Real.exp s < (m : ℝ) := (Nat.floor_lt (Real.exp_pos s).le).mp hm
  have hmp : (m : ℝ) < ((p ^ m : ℕ) : ℝ) := by exact_mod_cast m.lt_pow_self hp.one_lt
  have hpos : (0 : ℝ) < ((p ^ m : ℕ) : ℝ) := by exact_mod_cast pow_pos hp.pos m
  have hage : s < (m : ℝ) * Real.log p := by
    have hh := (Real.lt_log_iff_exp_lt hpos).mpr (hem.trans hmp)
    rwa [Nat.cast_pow, Real.log_pow] at hh
  unfold powerTerm theta
  rw [Set.indicator_of_notMem (show s - (m : ℝ) * Real.log p ∉ Set.Ici 0 from
    not_le.mpr (sub_neg.mpr hage)), mul_zero]

theorem exp_weight {p : ℕ} (hp : p.Prime) (m : ℕ) :
    Real.exp (-((m : ℝ) * Real.log p) / 2) = 1 / Real.sqrt ((p ^ m : ℕ) : ℝ) := by
  rw [neg_div, Real.exp_neg, Real.exp_half, Real.exp_nat_mul,
    Real.exp_log (by exact_mod_cast hp.pos), Nat.cast_pow]
  simp

/-- Every active exponent total is retained; totals beyond the actual cutoff vanish. -/
theorem filtered_primeBlock_by_total {p : ℕ} (hp : p.Prime) {s : ℝ} (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s =
      ∑ m ∈ Finset.Icc 2 ⌊Real.exp s⌋₊,
        SamePrimeHistoryResidual.weight p m * theta (s - (m : ℝ) * Real.log p) := by
  rw [filtered_actual_primeBlock hp hs]
  have hsum := sum_pairs_by_total ⌊Real.exp s⌋₊ (powerTerm p s)
    (fun m hm => powerTerm_eq_zero_above_cutoff hp hm)
  simp only [powerTerm, Nat.cast_add] at hsum
  rw [hsum, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro m _
  rw [exp_weight hp]
  unfold SamePrimeHistoryResidual.weight
  ring

/-- A frozen block's actual convolution is continuous through every birth endpoint. -/
theorem block_convolution_continuousOn (N : ℕ) {p : ℕ} (hp : p.Prime) :
    ContinuousOn (fun v => ∫ u in 0..v, block N p u * block N p (v - u)) (Set.Ici 0) := by
  have hlog : 0 ≤ Real.log p := Real.log_nonneg (by exact_mod_cast hp.one_lt.le)
  have hpairs (j k : ℕ) : ContinuousOn (pair p j k) (Set.Ici 0) := by
    apply (ramp_continuous (((j : ℝ) * Real.log p) + ((k : ℝ) * Real.log p))).continuousOn.congr
    intro v hv
    exact birth_convolution (mul_nonneg (Nat.cast_nonneg _) hlog)
      (mul_nonneg (Nat.cast_nonneg _) hlog) hv
  have hsum : ContinuousOn (fun v => ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N, pair p j k v) (Set.Ici 0) :=
    continuousOn_finset_sum _ (fun j _ => continuousOn_finset_sum _ (fun k _ => hpairs j k))
  apply (continuousOn_const.mul hsum).congr
  intro v hv
  exact block_convolution N p v

/-- The all-active moving-cutoff square is locally continuous by exact cutoff freezing. -/
theorem actual_convolution_continuousOn {p : ℕ} (hp : p.Prime) {s : ℝ} :
    ContinuousOn (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) (Set.Icc 0 s) := by
  apply ((block_convolution_continuousOn ⌊Real.exp s⌋₊ hp).mono (fun v hv => hv.1)).congr
  intro v hv
  exact actual_convolution_eq_block hp hv

theorem actual_filtered_integrable {p : ℕ} (hp : p.Prime) {s : ℝ} (hs : 0 ≤ s) :
    IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) *
      (∫ u in 0..v, primeBlock p u * primeBlock p (v - u))) volume 0 s := by
  apply (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr
  exact ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * (s - v) / 2))).continuousOn.mul
    (actual_convolution_continuousOn hp)).integrableOn_Icc

/-- The literal all-prime same-prime subtraction with its full proper-power multiplicity. -/
noncomputable def tau (s : ℝ) : ℝ :=
  ∑ p ∈ Finset.Icc 2 ⌊Real.exp s⌋₊, if p.Prime then
    ∑ m ∈ Finset.Icc 2 ⌊Real.exp s⌋₊,
      SamePrimeHistoryResidual.weight p m * theta (s - (m : ℝ) * Real.log p) else 0

/-- Full actual same-prime block calibration at each nonnegative cutoff. -/
theorem actual_tau_calibration {s : ℝ} (hs : 0 ≤ s) :
    (∑ p ∈ Finset.Icc 2 ⌊Real.exp s⌋₊, if p.Prime then
      L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s else 0) = tau s := by
  unfold tau
  apply Finset.sum_congr rfl
  intro p _
  split_ifs with hp
  · exact filtered_primeBlock_by_total hp hs
  · rfl

#print axioms actual_filtered_integrable
#print axioms filtered_primeBlock_by_total
#print axioms actual_tau_calibration
#print axioms sum_pairs_by_total
#print axioms block_eq_primeBlock
#print axioms filtered_block
#print axioms filtered_actual_primeBlock

end BuildingBlocks.SamePrimeBlockCalibration
