import BuildingBlocks.ActualPrimeCutoffCovarianceFinite

/-!
Exact finite cofactor change of variables for the actual cutoff density score.
The strict increase of the density mean is a separate analytic input in the
conditional sign theorem below. This module does not prove RH or an RH bound.
-/

namespace BuildingBlocks.DensityPrimeCovarianceFinite

open ActualPrimeCutoffCovarianceFinite

noncomputable section

def densityScore (x : ℝ) (n : ℕ) : ℝ := x / n - 1

def densityMass (N : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, cutoffWeight x n * densityScore x n

def densityMean (N : ℕ) (x : ℝ) : ℝ :=
  densityMass N x / cutoffMass N x

theorem densityScore_dilate {a d : ℕ} {x : ℝ}
    (ha : 0 < a) (hd : 0 < d) :
    densityScore x (a * d) = densityScore (x / a) d := by
  have haR : (a : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt ha)
  have hdR : (d : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hd)
  unfold densityScore
  push_cast
  field_simp

theorem densityMass_stable {M N : ℕ} {x : ℝ}
    (hMN : M ≤ N) (hx : x ≤ (M : ℝ) + 1) :
    densityMass N x = densityMass M x := by
  unfold densityMass
  symm
  apply Finset.sum_subset
  · intro n hn
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hMN⟩
  · intro n hnN hnM
    have hnlarge : M < n := by
      have hnlo := (Finset.mem_Icc.mp hnN).1
      have hnot : ¬ n ≤ M := by
        intro hnle
        exact hnM (Finset.mem_Icc.mpr ⟨hnlo, hnle⟩)
      omega
    have hxn : ¬ (n : ℝ) < x := by
      have : (M : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hnlarge
      exact not_lt.mpr (hx.trans this)
    simp [cutoffWeight, hxn]

theorem densityMass_dilated_stable {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    densityMass (N / a) (x / a) = densityMass N (x / a) := by
  exact (densityMass_stable (Nat.div_le_self N a)
    (cutoff_dilated_endpoint ha hx)).symm

theorem cutoff_prime_power_density_mass {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * densityScore x n *
        (if a ∣ n then Real.sqrt (a : ℝ) else 0)) =
      (a : ℝ) * densityMass N (x / a) := by
  have haR : 0 ≤ (a : ℝ) := by exact_mod_cast (Nat.zero_le a)
  calc
    _ = Real.sqrt (a : ℝ) *
        (∑ n ∈ Finset.Icc 1 N,
          if a ∣ n then cutoffWeight x n * densityScore x n else 0) := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro n hn
          split_ifs <;> ring
    _ = Real.sqrt (a : ℝ) *
        (Real.sqrt (a : ℝ) *
          ∑ d ∈ Finset.Icc 1 (N / a),
            cutoffWeight (x / a) d * densityScore x (a * d)) := by
          rw [cutoff_multiples_sum_weighted N a x (densityScore x) ha]
    _ = (a : ℝ) * densityMass (N / a) (x / a) := by
          have he :
              (∑ d ∈ Finset.Icc 1 (N / a),
                  cutoffWeight (x / a) d * densityScore x (a * d)) =
              densityMass (N / a) (x / a) := by
            unfold densityMass
            apply Finset.sum_congr rfl
            intro d hd
            rw [densityScore_dilate ha (Finset.mem_Icc.mp hd).1]
          rw [he, ← mul_assoc, ← pow_two, Real.sq_sqrt haR]
    _ = (a : ℝ) * densityMass N (x / a) := by
          rw [densityMass_dilated_stable ha hx]

def originalDensityPrimeMass (N J p : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N,
    cutoffWeight x n * densityScore x n * primeScore J p n

theorem originalDensityPrimeMass_eq_cofactor
    {N J p : ℕ} {x : ℝ} (hp : 0 < p)
    (hx : x ≤ (N : ℝ) + 1) :
    originalDensityPrimeMass N J p x =
      Real.log p *
        ∑ j ∈ Finset.Icc 1 J,
          (p : ℝ) ^ j * densityMass N (x / (p : ℝ) ^ j) := by
  unfold originalDensityPrimeMass
  calc
    (∑ n ∈ Finset.Icc 1 N,
        cutoffWeight x n * densityScore x n * primeScore J p n) =
      Real.log p *
        ∑ n ∈ Finset.Icc 1 N,
          ∑ j ∈ Finset.Icc 1 J,
            cutoffWeight x n * densityScore x n *
              (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro n hn
        unfold primeScore
        rw [Finset.mul_sum]
        rw [Finset.mul_sum]
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro j hj
        ring
    _ = Real.log p *
        ∑ j ∈ Finset.Icc 1 J,
          ∑ n ∈ Finset.Icc 1 N,
            cutoffWeight x n * densityScore x n *
              (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
        rw [Finset.sum_comm]
    _ = _ := by
        congr 1
        apply Finset.sum_congr rfl
        intro j hj
        simpa only [Nat.cast_pow] using
          (cutoff_prime_power_density_mass (N := N) (a := p ^ j)
            (pow_pos hp j) hx)

def originalDensityPrimeMoment (N J p : ℕ) (x : ℝ) : ℝ :=
  originalDensityPrimeMass N J p x / cutoffMass N x

def cofactorDensityPrimeMoment (N J p : ℕ) (x : ℝ) : ℝ :=
  Real.log p / cutoffMass N x *
    ∑ j ∈ Finset.Icc 1 J,
      (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
        densityMean N (x / (p : ℝ) ^ j)

theorem densityMass_eq_mass_mul_densityMean (N : ℕ) (x : ℝ) :
    densityMass N x = cutoffMass N x * densityMean N x := by
  by_cases hZ : cutoffMass N x = 0
  · have hmass : densityMass N x = 0 := by
      have hzero : ∀ n ∈ Finset.Icc 1 N, cutoffWeight x n = 0 := by
        intro n hn
        have hnnon : 0 ≤ cutoffWeight x n := by
          unfold cutoffWeight
          split_ifs with h
          · exact div_nonneg (sub_nonneg.mpr h.le) (Real.sqrt_nonneg _)
          · exact le_refl _
        have hle : cutoffWeight x n ≤ cutoffMass N x := by
          unfold cutoffMass
          exact Finset.single_le_sum (fun m hm => by
            unfold cutoffWeight
            split_ifs with h
            · exact div_nonneg (sub_nonneg.mpr h.le) (Real.sqrt_nonneg _)
            · exact le_refl _) hn
        linarith
      unfold densityMass
      apply Finset.sum_eq_zero
      intro n hn
      simp [hzero n hn]
    simp [densityMean, hZ, hmass]
  · unfold densityMean
    field_simp

theorem originalDensityPrimeMoment_eq_cofactor
    {N J p : ℕ} {x : ℝ} (hp : 0 < p)
    (hx : x ≤ (N : ℝ) + 1) :
    originalDensityPrimeMoment N J p x =
      cofactorDensityPrimeMoment N J p x := by
  unfold originalDensityPrimeMoment cofactorDensityPrimeMoment
  rw [originalDensityPrimeMass_eq_cofactor hp hx]
  simp_rw [densityMass_eq_mass_mul_densityMean]
  ring_nf

def densityPrimeCovariance (N J p : ℕ) (x : ℝ) : ℝ :=
  cofactorDensityPrimeMoment N J p x -
    densityMean N x * primeMean N J p x

/-- The exact signed density-prime covariance formula before any
monotonicity input. The full actual score is recovered by taking `J=N`. -/
theorem negative_densityPrimeCovariance_eq (N J p : ℕ) (x : ℝ) :
    -densityPrimeCovariance N J p x =
      Real.log p / cutoffMass N x *
        ∑ j ∈ Finset.Icc 1 J,
          (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
            (densityMean N x -
              densityMean N (x / (p : ℝ) ^ j)) := by
  unfold densityPrimeCovariance cofactorDensityPrimeMoment primeMean
  simp_rw [mul_sub]
  rw [Finset.sum_sub_distrib]
  simp only [← Finset.sum_mul]
  ring

/-- The original full prime-power mixed moment, with the density score
evaluated on the actual integer sample. -/
def fullDensityPrimeMoment (N p : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * densityScore x n * fullPrimeScore p n) /
    cutoffMass N x

theorem fullDensityPrimeMoment_eq_cofactor
    {N p : ℕ} {x : ℝ} (hp : p.Prime)
    (hx : x ≤ (N : ℝ) + 1) :
    fullDensityPrimeMoment N p x =
      cofactorDensityPrimeMoment N N p x := by
  have hs : fullDensityPrimeMoment N p x =
      originalDensityPrimeMoment N N p x := by
    unfold fullDensityPrimeMoment originalDensityPrimeMoment
      originalDensityPrimeMass
    congr 1
    apply Finset.sum_congr rfl
    intro n hn
    rw [primeScore_eq_fullPrimeScore hp (Finset.mem_Icc.mp hn).1
      (Finset.mem_Icc.mp hn).2]
  rw [hs]
  exact originalDensityPrimeMoment_eq_cofactor hp.pos hx

/-- The exact gap formula for the original full actual score. The
monotonicity of the density mean, needed to give this formula a strict
sign, is not assumed here. -/
theorem negative_full_densityPrimeCovariance_eq
    {N p : ℕ} {x : ℝ} (hp : p.Prime)
    (hx : x ≤ (N : ℝ) + 1) :
    -(fullDensityPrimeMoment N p x -
        densityMean N x * fullScoreMean N p x) =
      Real.log p / cutoffMass N x *
        ∑ j ∈ Finset.Icc 1 N,
          (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
            (densityMean N x -
              densityMean N (x / (p : ℝ) ^ j)) := by
  rw [fullDensityPrimeMoment_eq_cofactor hp hx]
  rw [fullScoreMean_eq_primeMean hp hx]
  exact negative_densityPrimeCovariance_eq N N p x

/-- The strict sign reduces to two explicit properties of the actual
density mean. Both are quantified over the full cutoff family; the finite
identity above does not itself supply them. -/
theorem densityPrimeCovariance_neg_of_densityMean_monotone
    {N J p : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hJ : 1 ≤ J) (hp : 1 < p) (hxp : (p : ℝ) < x)
    (hmono : ∀ j ∈ Finset.Icc 1 J,
      densityMean N (x / (p : ℝ) ^ j) ≤ densityMean N x)
    (hstrict : densityMean N (x / p) < densityMean N x) :
    densityPrimeCovariance N J p x < 0 := by
  have hx : 1 < x := lt_trans (by exact_mod_cast hp) hxp
  have hZ : 0 < cutoffMass N x := cutoffMass_pos hN hx
  have hlog : 0 < Real.log (p : ℝ) := Real.log_pos (by exact_mod_cast hp)
  have hsum : 0 < ∑ j ∈ Finset.Icc 1 J,
      (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
        (densityMean N x - densityMean N (x / (p : ℝ) ^ j)) := by
    apply Finset.sum_pos'
    · intro j hj
      apply mul_nonneg
      · apply mul_nonneg
        · positivity
        · exact cutoffMass_nonneg N _
      · exact sub_nonneg.mpr (hmono j hj)
    · refine ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hJ⟩, ?_⟩
      have hp0 : (0 : ℝ) < p := by exact_mod_cast (lt_trans Nat.zero_lt_one hp)
      have hpx : 1 < x / (p : ℝ) := (one_lt_div hp0).mpr hxp
      have hzp : 0 < cutoffMass N (x / (p : ℝ)) := cutoffMass_pos hN hpx
      have hd : 0 < densityMean N x - densityMean N (x / p) := sub_pos.mpr hstrict
      simpa using mul_pos (mul_pos (by positivity) hzp) hd
  have hneg : 0 < -densityPrimeCovariance N J p x := by
    rw [negative_densityPrimeCovariance_eq]
    exact mul_pos (div_pos hlog hZ) hsum
  linarith

#print axioms densityScore_dilate
#print axioms cutoff_prime_power_density_mass
#print axioms originalDensityPrimeMass_eq_cofactor
#print axioms negative_full_densityPrimeCovariance_eq
#print axioms densityPrimeCovariance_neg_of_densityMean_monotone

end

end BuildingBlocks.DensityPrimeCovarianceFinite
