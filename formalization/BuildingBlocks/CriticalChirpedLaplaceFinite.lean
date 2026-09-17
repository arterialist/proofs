import BuildingBlocks.CriticalChirpedEndpointFinite
import BuildingBlocks.ActualArchimedeanFactor

/-!
# Finite complex Laplace transform of the actual prime cross

The identities in this file preserve a complex spectral parameter and every
von Mangoldt prime-power weight. The finite transforms converge to the actual
zeta logarithmic derivative on its Dirichlet-series half-plane. The theorem
does not assert a separate interchange with a full infinite Laplace integral
or analytic continuation across its boundary.
-/

open MeasureTheory
open scoped Interval BigOperators

namespace BuildingBlocks.CriticalChirpedLaplaceFinite

noncomputable section



def momentIntegrand (C : ℝ → ℂ) (z : ℂ) (y : ℝ) : ℂ :=
  Complex.exp (z * (y : ℂ)) * C y

private theorem mangoldt_laplace_term (n : ℕ) (hn : 2 ≤ n) (z : ℂ) :
    ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
      Complex.exp (-z * (Real.log (n : ℝ) : ℂ)) =
    ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ) /
      ((n : ℂ) ^ (z + (1 / 2 : ℂ))) := by
  have hnpos : (0 : ℝ) < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hnne : (n : ℂ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
  let A : ℂ := ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ)
  let L : ℂ := ((Real.log (n : ℝ)) : ℂ)
  have hsqrt : ((Real.sqrt (n : ℝ) : ℝ) : ℂ) = Complex.exp (L / 2) := by
    rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos hnpos]
    simp only [L, Complex.ofReal_exp, Complex.ofReal_mul, Complex.ofReal_div,
      Complex.ofReal_one, Complex.ofReal_ofNat]
    congr 1
    ring_nf
  have hweight : ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) =
      A * Complex.exp (-L / 2) := by
    calc
      ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) =
          A / ((Real.sqrt (n : ℝ) : ℝ) : ℂ) := by
            simp [A, Complex.ofReal_div]
      _ = A / Complex.exp (L / 2) := by rw [hsqrt]
      _ = A * Complex.exp (-L / 2) := by
        rw [div_eq_mul_inv, ← Complex.exp_neg]
        ring
  have hpow : (n : ℂ) ^ (z + (1 / 2 : ℂ)) =
      Complex.exp (L * (z + (1 / 2 : ℂ))) := by
    have hlog : Complex.log (n : ℂ) = L := by
      simpa [L] using (Complex.ofReal_log hnpos.le).symm
    rw [Complex.cpow_def_of_ne_zero hnne, hlog]
  calc
    ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
        Complex.exp (-z * (Real.log (n : ℝ) : ℂ)) =
      A * Complex.exp (-L / 2) * Complex.exp (-z * L) := by
        rw [hweight]
    _ = A * Complex.exp (-(z + (1 / 2 : ℂ)) * L) := by
      rw [mul_assoc, ← Complex.exp_add]
      congr 1
      ring_nf
    _ = A / ((n : ℂ) ^ (z + (1 / 2 : ℂ))) := by
      rw [hpow]
      simp only [div_eq_mul_inv, ← Complex.exp_neg]
      congr 1
      ring_nf
    _ = ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ) /
        ((n : ℂ) ^ (z + (1 / 2 : ℂ))) := by rfl

/-- A one-location Laplace transform before imposing support endpoints. -/
theorem one_location_laplace_finite (C : ℝ → ℂ) (z : ℂ) (r R : ℝ) :
    (∫ d in (0 : ℝ)..R,
      Complex.exp (-z * (d : ℂ)) * C (r - d)) =
      Complex.exp (-z * (r : ℂ)) *
        (∫ y in (r - R)..r, momentIntegrand C z y) := by
  have hpoint (d : ℝ) :
      Complex.exp (-z * (d : ℂ)) * C (r - d) =
      Complex.exp (-z * (r : ℂ)) * momentIntegrand C z (r - d) := by
    simp only [momentIntegrand, ← mul_assoc, ← Complex.exp_add]
    congr 1
    push_cast
    ring_nf
  calc
    (∫ d in (0 : ℝ)..R, Complex.exp (-z * (d : ℂ)) * C (r - d)) =
        ∫ d in (0 : ℝ)..R,
          Complex.exp (-z * (r : ℂ)) * momentIntegrand C z (r - d) := by
          apply intervalIntegral.integral_congr
          intro d hd
          exact hpoint d
    _ = Complex.exp (-z * (r : ℂ)) *
        (∫ d in (0 : ℝ)..R, momentIntegrand C z (r - d)) := by
          rw [intervalIntegral.integral_const_mul]
    _ = Complex.exp (-z * (r : ℂ)) *
        (∫ y in (r - R)..r, momentIntegrand C z y) := by
          rw [intervalIntegral.integral_comp_sub_left]
          simp

/-- A compactly supported correlation has the same moment on every interval
that contains its full support, including both literal endpoints. -/
theorem moment_interval_eq (C : ℝ → ℂ) (z : ℂ) (w r R : ℝ)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0)
    (ha : r - R ≤ -w) (hb : w ≤ r) :
    (∫ y in (r - R)..r, momentIntegrand C z y) =
      (∫ y in (-w)..w, momentIntegrand C z y) := by
  have hcont : Continuous (momentIntegrand C z) := by
    unfold momentIntegrand
    fun_prop
  have hzeroL : (∫ y in (r - R)..(-w), momentIntegrand C z y) = 0 := by
    calc
      (∫ y in (r - R)..(-w), momentIntegrand C z y) =
          ∫ y in (r - R)..(-w), (0 : ℂ) := by
            apply intervalIntegral.integral_congr
            intro y hy
            have hyw : y ≤ -w := by
              rw [Set.uIcc_of_le ha] at hy
              exact hy.2
            simp [momentIntegrand, hleft y hyw]
      _ = 0 := by simp
  have hzeroR : (∫ y in w..r, momentIntegrand C z y) = 0 := by
    calc
      (∫ y in w..r, momentIntegrand C z y) =
          ∫ y in w..r, (0 : ℂ) := by
            apply intervalIntegral.integral_congr
            intro y hy
            have hyw : w ≤ y := by
              rw [Set.uIcc_of_le hb] at hy
              exact hy.1
            simp [momentIntegrand, hright y hyw]
      _ = 0 := by simp
  have hsplitL :
      (∫ y in (r - R)..(-w), momentIntegrand C z y) +
        (∫ y in (-w)..w, momentIntegrand C z y) =
          (∫ y in (r - R)..w, momentIntegrand C z y) :=
    intervalIntegral.integral_add_adjacent_intervals
      (hcont.intervalIntegrable (r - R) (-w))
      (hcont.intervalIntegrable (-w) w)
  have hsplitR :
      (∫ y in (r - R)..w, momentIntegrand C z y) +
        (∫ y in w..r, momentIntegrand C z y) =
          (∫ y in (r - R)..r, momentIntegrand C z y) :=
    intervalIntegral.integral_add_adjacent_intervals
      (hcont.intervalIntegrable (r - R) w)
      (hcont.intervalIntegrable w r)
  calc
    (∫ y in (r - R)..r, momentIntegrand C z y) =
        (∫ y in (r - R)..w, momentIntegrand C z y) +
          (∫ y in w..r, momentIntegrand C z y) := hsplitR.symm
    _ = (∫ y in (r - R)..(-w), momentIntegrand C z y) +
          (∫ y in (-w)..w, momentIntegrand C z y) +
          (∫ y in w..r, momentIntegrand C z y) := by rw [← hsplitL]
    _ = (∫ y in (-w)..w, momentIntegrand C z y) := by
      rw [hzeroL, hzeroR]
      simp

/-- The common compact correlation moment factors out at one arithmetic
location. -/
theorem one_location_laplace_compact (C : ℝ → ℂ) (z : ℂ) (w r R : ℝ)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0)
    (hr : w ≤ r) (hR : r + w ≤ R) :
    (∫ d in (0 : ℝ)..R,
      Complex.exp (-z * (d : ℂ)) * C (r - d)) =
      Complex.exp (-z * (r : ℂ)) *
        (∫ y in (-w)..w, momentIntegrand C z y) := by
  rw [one_location_laplace_finite]
  rw [moment_interval_eq C z w r R hC hleft hright (by linarith) hr]

/-- The complex Laplace transform of the complete finite actual-prime cross
factors into a finite von Mangoldt Dirichlet polynomial and one correlation
moment. Every higher prime power remains in the sum. -/
theorem actual_cross_laplace_finite (N : ℕ) (C : ℝ → ℂ)
    (z : ℂ) (w R : ℝ) (hw : w < Real.log 2)
    (hR : ∀ n ∈ Finset.Icc 2 N, Real.log (n : ℝ) + w ≤ R)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0) :
    (∫ d in (0 : ℝ)..R,
      Complex.exp (-z * (d : ℂ)) *
        CriticalChirpedEndpointFinite.actualCrossFinite N C d) =
      (∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
          Complex.exp (-z * (Real.log (n : ℝ) : ℂ))) *
      (∫ y in (-w)..w, momentIntegrand C z y) := by
  classical
  have hfun : (fun d : ℝ => Complex.exp (-z * (d : ℂ)) *
      CriticalChirpedEndpointFinite.actualCrossFinite N C d) =
      (fun d : ℝ => ∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
          (Complex.exp (-z * (d : ℂ)) *
            C (Real.log (n : ℝ) - d))) := by
    funext d
    simp only [CriticalChirpedEndpointFinite.actualCrossFinite, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n hn
    ring
  rw [hfun]
  rw [intervalIntegral.integral_finset_sum (s := Finset.Icc 2 N)
    (f := fun n d =>
      ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
        (Complex.exp (-z * (d : ℂ)) * C (Real.log (n : ℝ) - d)))
    (by
      intro n hn
      have hcont : Continuous (fun d : ℝ =>
          Complex.exp (-z * (d : ℂ)) * C (Real.log (n : ℝ) - d)) := by
        fun_prop
      exact (hcont.intervalIntegrable 0 R).const_mul _)]
  simp_rw [intervalIntegral.integral_const_mul]
  calc
    (∑ n ∈ Finset.Icc 2 N,
      ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
        (∫ d in (0 : ℝ)..R,
          Complex.exp (-z * (d : ℂ)) * C (Real.log (n : ℝ) - d))) =
      ∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
          (Complex.exp (-z * (Real.log (n : ℝ) : ℂ)) *
            (∫ y in (-w)..w, momentIntegrand C z y)) := by
      apply Finset.sum_congr rfl
      intro n hn
      have hnreal : (2 : ℝ) ≤ (n : ℝ) := by
        exact_mod_cast (Finset.mem_Icc.mp hn).1
      have hnlog : w ≤ Real.log (n : ℝ) :=
        hw.le.trans (Real.log_le_log (by norm_num) hnreal)
      rw [one_location_laplace_compact C z w (Real.log (n : ℝ)) R
        hC hleft hright hnlog (hR n hn)]
    _ = (∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n / Real.sqrt (n : ℝ) : ℝ) : ℂ) *
          Complex.exp (-z * (Real.log (n : ℝ) : ℂ))) *
        (∫ y in (-w)..w, momentIntegrand C z y) := by
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro n hn
      ring

/-- The same identity in the standard Dirichlet-series normalization
`s = z + 1/2`, with literal von Mangoldt coefficients. -/
theorem actual_cross_laplace_dirichlet_finite (N : ℕ) (C : ℝ → ℂ)
    (z : ℂ) (w R : ℝ) (hw : w < Real.log 2)
    (hR : ∀ n ∈ Finset.Icc 2 N, Real.log (n : ℝ) + w ≤ R)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0) :
    (∫ d in (0 : ℝ)..R,
      Complex.exp (-z * (d : ℂ)) *
        CriticalChirpedEndpointFinite.actualCrossFinite N C d) =
      (∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ) /
          ((n : ℂ) ^ (z + (1 / 2 : ℂ)))) *
      (∫ y in (-w)..w, momentIntegrand C z y) := by
  rw [actual_cross_laplace_finite N C z w R hw hR hC hleft hright]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  exact mangoldt_laplace_term n (Finset.mem_Icc.mp hn).1 z

#print axioms actual_cross_laplace_dirichlet_finite

def primeDirichletTerm (s : ℂ) (n : ℕ) : ℂ :=
  ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ) / ((n : ℂ) ^ s)

/-- The literal finite actual-prime-power Dirichlet polynomial. -/
def primeDirichletPolynomial (N : ℕ) (s : ℂ) : ℂ :=
  ∑ n ∈ Finset.Icc 2 N, primeDirichletTerm s n

private theorem polynomial_eq_range (N : ℕ) (s : ℂ) :
    primeDirichletPolynomial N s =
      ∑ n ∈ Finset.range (N + 1), primeDirichletTerm s n := by
  classical
  have hsubset : Finset.Icc 2 N ⊆ Finset.range (N + 1) := by
    intro n hn
    exact Finset.mem_range.mpr (Nat.lt_succ_of_le (Finset.mem_Icc.mp hn).2)
  exact Finset.sum_subset hsubset (by
    intro n hn hnot
    have hnle : n ≤ N := Nat.lt_succ_iff.mp (Finset.mem_range.mp hn)
    have hnlt : n < 2 := by
      by_contra h
      exact hnot (Finset.mem_Icc.mpr ⟨Nat.le_of_not_gt h, hnle⟩)
    have hsmall : n = 0 ∨ n = 1 := by omega
    rcases hsmall with rfl | rfl <;> simp [primeDirichletTerm])

/-- On `Re s > 1`, these finite actual-prime polynomials converge to
the established logarithmic derivative of the actual Riemann zeta function.
This uses mathlib's unconditional von Mangoldt Dirichlet-series theorem. -/
theorem prime_dirichlet_polynomial_tendsto_zeta (s : ℂ) (hs : 1 < s.re) :
    Filter.Tendsto (fun N : ℕ => primeDirichletPolynomial N s)
      Filter.atTop (nhds (-logDeriv riemannZeta s)) := by
  have hsum : Summable (primeDirichletTerm s) := by
    exact summable_norm_iff.mp
      (by simpa [primeDirichletTerm] using
        ActualArchimedeanFactor.zeta_prime_series_absolute s hs)
  have hlim := hsum.hasSum.tendsto_sum_nat
  have hlim' := hlim.comp (Filter.tendsto_add_atTop_nat 1)
  have hzeta := ActualArchimedeanFactor.zeta_prime_series s hs
  simpa only [polynomial_eq_range, Function.comp_apply, primeDirichletTerm, hzeta]
    using hlim'

#print axioms prime_dirichlet_polynomial_tendsto_zeta

/-- The finite actual-prime Laplace transforms, each integrated past every
prime-power support endpoint, converge to the actual zeta logarithmic
derivative times the compact correlation moment. The statement is a limit of
finite integrals; it does not assert a separate infinite-integral interchange.
-/
theorem finite_cross_laplace_tendsto_logderiv (C : ℝ → ℂ)
    (z : ℂ) (w : ℝ) (hw : w < Real.log 2)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0)
    (hz : 1 < (z + (1 / 2 : ℂ)).re) :
    Filter.Tendsto
      (fun N : ℕ => ∫ d in (0 : ℝ)..(Real.log (N : ℝ) + w),
        Complex.exp (-z * (d : ℂ)) *
          CriticalChirpedEndpointFinite.actualCrossFinite N C d)
      Filter.atTop
      (nhds ((-logDeriv riemannZeta (z + (1 / 2 : ℂ))) *
        (∫ y in (-w)..w, momentIntegrand C z y))) := by
  have hpoint (N : ℕ) :
      (∫ d in (0 : ℝ)..(Real.log (N : ℝ) + w),
        Complex.exp (-z * (d : ℂ)) *
          CriticalChirpedEndpointFinite.actualCrossFinite N C d) =
      primeDirichletPolynomial N (z + (1 / 2 : ℂ)) *
        (∫ y in (-w)..w, momentIntegrand C z y) := by
    have hR : ∀ n ∈ Finset.Icc 2 N,
        Real.log (n : ℝ) + w ≤ Real.log (N : ℝ) + w := by
      intro n hn
      have hnpos : (0 : ℝ) < (n : ℝ) := by
        exact_mod_cast (show 0 < n by
          have hn2 := (Finset.mem_Icc.mp hn).1
          omega)
      have hnle : (n : ℝ) ≤ (N : ℝ) := by
        exact_mod_cast (Finset.mem_Icc.mp hn).2
      exact add_le_add_right (Real.log_le_log hnpos hnle) w
    simpa only [primeDirichletPolynomial, primeDirichletTerm] using
      (actual_cross_laplace_dirichlet_finite N C z w
        (Real.log (N : ℝ) + w) hw hR hC hleft hright)
  have hlim := (prime_dirichlet_polynomial_tendsto_zeta
    (z + (1 / 2 : ℂ)) hz).mul_const
      (∫ y in (-w)..w, momentIntegrand C z y)
  convert hlim using 1
  funext N
  exact hpoint N

#print axioms finite_cross_laplace_tendsto_logderiv

end
end BuildingBlocks.CriticalChirpedLaplaceFinite
