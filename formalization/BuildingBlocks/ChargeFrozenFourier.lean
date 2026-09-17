import BuildingBlocks.ChargeFrozenIntegrability

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenFourier

open CoarsePrimitive ChargeFrozenSource ChargeOriginalBirth

noncomputable def centering (N : ℕ) : ℝ → ℝ :=
  (Ici (0 : ℝ)).indicator (fun v => Real.exp (-v / 2) * min (Real.exp v) (N : ℝ))

/-- A convergent finite decomposition of the literal source, without separating
the divergent growth term from its compensating tail. -/
theorem causalSource_eq_atoms_sub_centering {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    causalSource N v =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
        centering N v := by
  by_cases hv : 0 ≤ v
  · rw [causalSource_of_nonnegative N hv]
    have ha : (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) =
        Real.exp (-v / 2) * psi ⌊min (Real.exp v) (N : ℝ)⌋₊ := by
      rw [psi_frozen_eq_atoms hN, Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n _
      unfold beta
      split_ifs <;> ring
    rw [ha]
    simp only [centering, indicator_of_mem (show v ∈ Ici (0 : ℝ) from hv), source]
    ring
  · have hvn : v < 0 := lt_of_not_ge hv
    have he : Real.exp v < 1 := by simpa using Real.exp_lt_exp.mpr hvn
    have ha : (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) = 0 := by
      apply Finset.sum_eq_zero
      intro n hn
      have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
      simp [beta, show ¬(n : ℝ) ≤ Real.exp v by linarith]
    rw [causalSource_of_negative N hvn, ha]
    simp [centering, hv]

theorem beta_eq_indicator {n : ℕ} (hn : 0 < n) :
    beta n = (Ici (Real.log (n : ℝ))).indicator (fun v => Real.exp (-v / 2)) := by
  have hnp : (0 : ℝ) < n := by exact_mod_cast hn
  funext v
  have he : (n : ℝ) ≤ Real.exp v ↔ Real.log (n : ℝ) ≤ v := by
    calc
      (n : ℝ) ≤ Real.exp v ↔ Real.exp (Real.log (n : ℝ)) ≤ Real.exp v := by
        rw [Real.exp_log hnp]
      _ ↔ Real.log (n : ℝ) ≤ v := Real.exp_le_exp
  simp [beta, he, Set.indicator]

noncomputable def w (ξ : ℝ) : ℂ := 1 / 2 + Complex.I * (ξ : ℂ)

theorem phase_mul_decay (ξ v : ℝ) :
    Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (Real.exp (-v / 2) : ℂ) =
      Complex.exp (-w ξ * (v : ℂ)) := by
  rw [Complex.ofReal_exp, ← Complex.exp_add]
  congr 1
  simp only [w, Complex.ofReal_div, Complex.ofReal_neg, Complex.ofReal_ofNat]
  ring

/-- Exact angular-frequency coefficient of each actual prime-power birth atom. -/
theorem beta_fourier_integral {n : ℕ} (hn : 0 < n) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (beta n v : ℂ)) =
      Complex.exp (-w ξ * (Real.log (n : ℝ) : ℂ)) / w ξ := by
  have hf : (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (beta n v : ℂ)) = (Ici (Real.log (n : ℝ))).indicator
        (fun v : ℝ => Complex.exp (-w ξ * (v : ℂ))) := by
    funext v
    rw [beta_eq_indicator hn]
    by_cases hv : v ∈ Ici (Real.log (n : ℝ))
    · simp only [indicator_of_mem hv]
      exact phase_mul_decay ξ v
    · simp [indicator_of_notMem hv]
  rw [hf, integral_indicator measurableSet_Ici, integral_Ici_eq_integral_Ioi]
  have hw : (-w ξ).re < 0 := by simp [w]
  rw [integral_exp_mul_complex_Ioi hw]
  simp

theorem phase_mul_growth (ξ v : ℝ) :
    Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (Real.exp (-v / 2) * Real.exp v : ℝ) =
        Complex.exp ((1 - w ξ) * (v : ℂ)) := by
  simp only [Complex.ofReal_mul, Complex.ofReal_exp]
  rw [← Complex.exp_add, ← Complex.exp_add]
  congr 1
  simp only [w, Complex.ofReal_div, Complex.ofReal_neg, Complex.ofReal_ofNat]
  ring

theorem phase_centering_eq {N : ℕ} (hN : 1 ≤ N) (ξ v : ℝ) :
    Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (centering N v : ℂ) =
      (Icc (0 : ℝ) (Real.log (N : ℝ))).indicator
        (fun v : ℝ => Complex.exp ((1 - w ξ) * (v : ℂ))) v +
      (N : ℂ) * (Ioi (Real.log (N : ℝ))).indicator
        (fun v : ℝ => Complex.exp (-w ξ * (v : ℂ))) v := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hNl : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg (by exact_mod_cast hN)
  by_cases hv : 0 ≤ v
  · by_cases ht : v ≤ Real.log (N : ℝ)
    · have he : Real.exp v ≤ N := by
        simpa only [Real.exp_log hNp] using Real.exp_le_exp.mpr ht
      simp only [centering, indicator_of_mem (show v ∈ Ici (0 : ℝ) from hv),
        min_eq_left he, indicator_of_mem (show v ∈ Icc 0 (Real.log (N : ℝ)) from ⟨hv, ht⟩),
        indicator_of_notMem (show v ∉ Ioi (Real.log (N : ℝ)) from not_lt.mpr ht),
        mul_zero, add_zero]
      exact phase_mul_growth ξ v
    · have hlt : Real.log (N : ℝ) < v := lt_of_not_ge ht
      have he : (N : ℝ) ≤ Real.exp v := by
        simpa only [Real.exp_log hNp] using (Real.exp_le_exp.mpr hlt.le)
      simp only [centering, indicator_of_mem (show v ∈ Ici (0 : ℝ) from hv),
        min_eq_right he, indicator_of_notMem (show v ∉ Icc 0 (Real.log (N : ℝ)) from
          fun h => ht h.2), indicator_of_mem (show v ∈ Ioi (Real.log (N : ℝ)) from hlt),
        zero_add, Complex.ofReal_mul]
      rw [← mul_assoc, phase_mul_decay]
      push_cast
      ring
  · have hn2 : v ∉ Ioi (Real.log (N : ℝ)) := by intro h; exact hv (hNl.trans h.le)
    simp [centering, hv, indicator_of_notMem hn2]

theorem centering_fourier_integral {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (centering N v : ℂ)) =
      (Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ) +
        (N : ℂ) * Complex.exp (-w ξ * (Real.log (N : ℝ) : ℂ)) / w ξ := by
  have hNl : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg (by exact_mod_cast hN)
  have hi : IntegrableOn (fun v : ℝ => Complex.exp ((1 - w ξ) * (v : ℂ)))
      (Icc (0 : ℝ) (Real.log (N : ℝ))) :=
    (by fun_prop : Continuous (fun v : ℝ => Complex.exp ((1 - w ξ) * (v : ℂ)))).integrableOn_Icc
  have hw : (-w ξ).re < 0 := by simp [w]
  have hj : IntegrableOn (fun v : ℝ => Complex.exp (-w ξ * (v : ℂ)))
      (Ioi (Real.log (N : ℝ))) := integrableOn_exp_mul_complex_Ioi hw _
  simp_rw [phase_centering_eq hN]
  rw [integral_add (hi.integrable_indicator measurableSet_Icc)
    ((hj.integrable_indicator measurableSet_Ioi).const_mul (N : ℂ)),
    integral_const_mul, integral_indicator measurableSet_Icc,
    integral_indicator measurableSet_Ioi, integral_exp_mul_complex_Ioi hw]
  have hw1 : 1 - w ξ ≠ 0 := by
    intro h
    have hh := congrArg Complex.re h
    norm_num [w] at hh
  rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hNl,
    integral_exp_mul_complex hw1]
  simp
  ring

theorem integrable_beta_fourier {n : ℕ} (hn : 0 < n) (ξ : ℝ) :
    Integrable (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (beta n v : ℂ)) := by
  have he : IntegrableOn (fun v : ℝ => Real.exp (-v / 2)) (Ici (Real.log (n : ℝ))) := by
    apply Iff.mpr integrableOn_Ici_iff_integrableOn_Ioi
    convert integrableOn_exp_mul_Ioi (by norm_num : (- (1 / 2) : ℝ) < 0)
      (Real.log (n : ℝ)) using 1
    funext v
    congr 1
    ring
  have hb : Integrable (beta n) := by
    rw [beta_eq_indicator hn]
    exact he.integrable_indicator measurableSet_Ici
  apply hb.ofReal.bdd_mul
  · exact (by fun_prop : Continuous (fun v : ℝ =>
      Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)))).aestronglyMeasurable
  · exact ⟨1, fun v => by simp [Complex.norm_exp, Complex.mul_re, Complex.mul_im]⟩

theorem integrable_centering_fourier {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    Integrable (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (centering N v : ℂ)) := by
  have hi : IntegrableOn (fun v : ℝ => Complex.exp ((1 - w ξ) * (v : ℂ)))
      (Icc (0 : ℝ) (Real.log (N : ℝ))) :=
    (by fun_prop : Continuous (fun v : ℝ => Complex.exp ((1 - w ξ) * (v : ℂ)))).integrableOn_Icc
  have hj : IntegrableOn (fun v : ℝ => Complex.exp (-w ξ * (v : ℂ)))
      (Ioi (Real.log (N : ℝ))) :=
    integrableOn_exp_mul_complex_Ioi (by simp [w]) _
  simp_rw [phase_centering_eq hN]
  exact (hi.integrable_indicator measurableSet_Icc).add
    ((hj.integrable_indicator measurableSet_Ioi).const_mul (N : ℂ))

/-- Explicit Fourier formula of the original frozen arithmetic source. The
clipped density includes the origin contribution; every Mangoldt power remains. -/
theorem causalSource_fourier_integral {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (causalSource N v : ℂ)) =
      (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        Complex.exp (-w ξ * (Real.log (n : ℝ) : ℂ)) / w ξ) -
      ((Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ) +
        (N : ℂ) * Complex.exp (-w ξ * (Real.log (N : ℝ) : ℂ)) / w ξ) := by
  have hf : (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ)) = (fun v : ℝ =>
      (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (beta n v : ℂ))) -
      Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (centering N v : ℂ)) := by
    funext v
    rw [causalSource_eq_atoms_sub_centering hN]
    push_cast
    rw [mul_sub, Finset.mul_sum]
    congr 1
    apply Finset.sum_congr rfl
    intro n _
    ring
  have ha : ∀ n ∈ Finset.Icc 2 N, Integrable (fun v : ℝ =>
      (ArithmeticFunction.vonMangoldt n : ℂ) *
        (Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (beta n v : ℂ))) := by
    intro n hn
    exact (integrable_beta_fourier (by have := (Finset.mem_Icc.mp hn).1; omega) ξ).const_mul _
  rw [hf, integral_sub (integrable_finset_sum _ ha)
    (integrable_centering_fourier (by omega) ξ), integral_finset_sum _ ha,
    centering_fourier_integral (by omega)]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  rw [integral_const_mul, beta_fourier_integral
    (by have := (Finset.mem_Icc.mp hn).1; omega)]
  ring

theorem real_cpow_eq_exp_log {x : ℝ} (hx : 0 < x) (z : ℂ) :
    (x : ℂ) ^ z = Complex.exp (z * (Real.log x : ℂ)) := by
  rw [Complex.cpow_def_of_ne_zero (by exact_mod_cast hx.ne'), ← Complex.ofReal_log hx.le]
  congr 1
  ring

theorem density_mellin_integral {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)) =
      (Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ) := by
  rw [integral_cpow (Or.inl (show -1 < (-w ξ).re by norm_num [w]))]
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  rw [real_cpow_eq_exp_log hNp]
  simp only [Complex.ofReal_one, Complex.one_cpow]
  have he : -w ξ + 1 = 1 - w ξ := by ring
  rw [he]

theorem terminal_centering_exp {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (N : ℂ) * Complex.exp (-w ξ * (Real.log (N : ℝ) : ℂ)) =
      Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have he : (N : ℂ) = Complex.exp (Real.log (N : ℝ) : ℂ) := by
    rw [← Complex.ofReal_exp, Real.exp_log hNp]
    norm_cast
  rw [he, ← Complex.exp_add]
  congr 1
  ring

/-- The exact finite Mellin numerator contains the original seed -1 and the
actual continuous density integral, rather than an assumed source bridge. -/
theorem causalSource_fourier_mellin {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (causalSource N v : ℂ)) =
      (-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)) -
        (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))) / w ξ := by
  rw [causalSource_fourier_integral hN, density_mellin_integral (by omega),
    terminal_centering_exp (by omega)]
  have hs : (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      Complex.exp (-w ξ * (Real.log (n : ℝ) : ℂ)) / w ξ) =
      (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)) / w ξ := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro n hn
    have hnp : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by
      have := (Finset.mem_Icc.mp hn).1; omega)
    rw [← real_cpow_eq_exp_log hnp]
    norm_cast
  rw [hs]
  have hw : w ξ ≠ 0 := by
    intro h
    have hh := congrArg Complex.re h
    norm_num [w] at hh
  have hw1 : 1 - w ξ ≠ 0 := by
    intro h
    have hh := congrArg Complex.re h
    norm_num [w] at hh
  field_simp
  ring

#print axioms causalSource_eq_atoms_sub_centering
#print axioms beta_eq_indicator
#print axioms beta_fourier_integral
#print axioms centering_fourier_integral
#print axioms integrable_beta_fourier
#print axioms integrable_centering_fourier
#print axioms causalSource_fourier_integral
#print axioms density_mellin_integral
#print axioms terminal_centering_exp
#print axioms causalSource_fourier_mellin

end BuildingBlocks.ChargeFrozenFourier
