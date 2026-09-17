import BuildingBlocks.RiemannZetaCenteredLogDeriv
import BuildingBlocks.SuzukiGoldbachVariation
import Mathlib.Analysis.Complex.RealDeriv
import Mathlib.NumberTheory.LSeries.Dirichlet

/-!
# First variation of Suzuki's pole normalizer

The residue `1 / ζ(1+2ω)` extends through `ω=0` with derivative `2`.
The analytic filling uses the repository's normalized zeta function
`U(s)=(s-1)ζ(s)`, whose value at one is the actual residue one.
-/

namespace BuildingBlocks.SuzukiPoleNormalizer

open Filter
open scoped Topology
open BuildingBlocks.RiemannZetaCenteredLogDeriv
open BuildingBlocks.SuzukiCoefficientVariation
open BuildingBlocks.SuzukiGoldbachVariation

noncomputable def complexNormalizer (w : ℂ) : ℂ :=
  2 * w / U (1 + 2 * w)

@[simp] theorem complexNormalizer_zero : complexNormalizer 0 = 0 := by
  simp [complexNormalizer]

theorem complexNormalizer_hasDerivAt_zero :
    HasDerivAt complexNormalizer 2 0 := by
  have harg : HasDerivAt (fun w : ℂ => 1 + 2 * w) 2 0 := by
    simpa only [Pi.add_apply, id_eq, zero_add, mul_one] using
      (hasDerivAt_const (0 : ℂ) (1 : ℂ)).add
      ((hasDerivAt_id (0 : ℂ)).const_mul 2)
  have hU : HasDerivAt (fun w : ℂ => U (1 + 2 * w))
      (deriv U 1 * 2) 0 := by
    have houter : HasDerivAt U (deriv U 1) (1 : ℂ) :=
      (differentiable_U 1).hasDerivAt
    have hcomp := HasDerivAt.comp_of_eq (0 : ℂ) houter harg (by simp)
    simpa only [Function.comp_def] using hcomp
  have hinv : HasDerivAt (fun w : ℂ => (U (1 + 2 * w))⁻¹)
      (-(deriv U 1 * 2) / (U 1)^2) 0 := by
    simpa using hU.inv (by simp : U (1 + 2 * (0 : ℂ)) ≠ 0)
  have hnum : HasDerivAt (fun w : ℂ => 2 * w) 2 0 := by
    simpa using (hasDerivAt_id (0 : ℂ)).const_mul 2
  have h := hnum.mul hinv
  simpa [complexNormalizer, div_eq_mul_inv] using h

/-- Real restriction of the actual analytic pole-residue filling. -/
noncomputable def normalizer (w : ℝ) : ℝ :=
  (complexNormalizer (w : ℂ)).re

@[simp] theorem normalizer_zero : normalizer 0 = 0 := by
  simp [normalizer]

theorem normalizer_hasDerivAt_zero : HasDerivAt normalizer 2 0 := by
  exact complexNormalizer_hasDerivAt_zero.real_of_complex

/-- Away from the pole on the real right half-line, the analytic
filling is the literal reciprocal of the actual Riemann zeta. -/
theorem complexNormalizer_eq_inv_zeta_of_pos {w : ℝ} (hw : 0 < w) :
    complexNormalizer (w : ℂ) =
      (riemannZeta (1 + 2 * (w : ℂ)))⁻¹ := by
  have hwc : (w : ℂ) ≠ 0 := by exact_mod_cast hw.ne'
  have htw : (2 : ℂ) * w ≠ 0 := mul_ne_zero (by norm_num) hwc
  have hs : 1 + 2 * (w : ℂ) ≠ 1 := by
    intro h
    apply htw
    calc
      (2 : ℂ) * w = (1 + 2 * (w : ℂ)) - 1 := by ring
      _ = 0 := by rw [h]; ring
  have hζ : riemannZeta (1 + 2 * (w : ℂ)) ≠ 0 := by
    apply riemannZeta_ne_zero_of_one_lt_re
    have hreal : (1 + 2 * (w : ℂ)).re = 1 + 2 * w := by simp
    rw [hreal]
    linarith
  rw [complexNormalizer, U_eq_of_ne hs]
  have hden : 1 + 2 * (w : ℂ) - 1 = 2 * (w : ℂ) := by ring
  rw [hden]
  field_simp [htw, hζ]

/-- Smooth pole-density coefficient, with no artificial state zero. -/
noncomputable def poleDensity (n : ℕ) (w : ℝ) : ℝ :=
  if n = 0 then 0 else normalizer w * Real.exp (w * Real.log n)

@[simp] theorem poleDensity_zero (n : ℕ) : poleDensity n 0 = 0 := by
  simp [poleDensity]

theorem poleDensity_hasDerivAt_zero (n : ℕ) :
    HasDerivAt (poleDensity n) (if n = 0 then 0 else 2) 0 := by
  by_cases hn : n = 0
  · subst n
    change HasDerivAt (fun _ : ℝ => (0 : ℝ)) 0 0
    exact hasDerivAt_const 0 0
  · have hexp : HasDerivAt
        (fun w : ℝ => Real.exp (w * Real.log n)) (Real.log n) 0 := by
      simpa using (((hasDerivAt_id (0 : ℝ)).mul_const (Real.log n)).exp)
    have h := normalizer_hasDerivAt_zero.mul hexp
    have htarget : HasDerivAt
        (fun w : ℝ => normalizer w * Real.exp (w * Real.log n)) 2 0 := by
      simpa only [Pi.mul_apply, normalizer_zero, Real.exp_zero, mul_one,
        zero_mul, add_zero] using h
    have heq : poleDensity n =
        fun w : ℝ => normalizer w * Real.exp (w * Real.log n) := by
      funext w
      simp [poleDensity, hn]
    rw [heq]
    simpa only [if_neg hn] using htarget

/-- Suzuki's arithmetical coefficient, its fixed state-one seed, and
its *actual zeta-pole residue* are all retained in one source. -/
noncomputable def normalizedIncrement (n : ℕ) (w : ℝ) : ℝ :=
  increment n w - poleDensity n w

@[simp] theorem normalizedIncrement_zero (n : ℕ) :
    normalizedIncrement n 0 = 0 := by
  simp [normalizedIncrement]

noncomputable def centeredWeight (n : ℕ) : ℝ :=
  if n = 0 then 0 else ArithmeticFunction.vonMangoldt n - 1

/-- The pole-normalized source varies as twice the complete
von Mangoldt-minus-density coefficient. In particular the state-one
derivative is `-2`. -/
theorem normalizedIncrement_hasDerivAt_zero (n : ℕ) :
    HasDerivAt (normalizedIncrement n) (2 * centeredWeight n) 0 := by
  have h := (increment_hasDerivAt n 0).sub (poleDensity_hasDerivAt_zero n)
  by_cases hn : n = 0
  · subst n
    simpa [normalizedIncrement, centeredWeight, increment_slope_zero] using h
  · simpa [normalizedIncrement, centeredWeight, hn,
      increment_slope_zero, mul_sub] using h

theorem normalizedIncrement_div_tendsto (n : ℕ) :
    Tendsto (fun w : ℝ => normalizedIncrement n w / w)
      (𝓝[≠] 0) (𝓝 (2 * centeredWeight n)) := by
  have h := (normalizedIncrement_hasDerivAt_zero n).tendsto_slope_zero
  simpa [normalizedIncrement_zero, div_eq_mul_inv, mul_comm] using h

/-- Ordered additive pairs of the pole-normalized source. -/
noncomputable def normalizedAdditiveSquare (N : ℕ) (w : ℝ) : ℝ :=
  ∑ p ∈ Finset.antidiagonal N,
    normalizedIncrement p.1 w * normalizedIncrement p.2 w

/-- The exact centered coefficient, including the `n=1` density
endpoint and every von Mangoldt prime power. -/
noncomputable def centeredGoldbachAt (N : ℕ) : ℝ :=
  ∑ p ∈ Finset.antidiagonal N, centeredWeight p.1 * centeredWeight p.2

/-- The antidiagonal convention agrees with the repository's existing
centered Goldbach coefficient after its positive-index shift. -/
theorem centeredGoldbachAt_shift (k : ℕ) :
    centeredGoldbachAt (k + 2) = BuildingBlocks.GoldbachHeat.shiftedGoldbach k := by
  unfold centeredGoldbachAt BuildingBlocks.GoldbachHeat.shiftedGoldbach
  rw [Finset.Nat.antidiagonal_succ_succ']
  simp [Finset.sum_map, centeredWeight,
    BuildingBlocks.GoldbachHeat.centeredCoefficient]

/-- A second-order variation stated as its quadratic coefficient.
This needs only the first derivative of the actual pole residue, and
so avoids an unnecessary second-derivative assumption. -/
theorem normalizedAdditiveSquare_quadratic_tendsto (N : ℕ) :
    Tendsto (fun w : ℝ => normalizedAdditiveSquare N w / w ^ 2)
      (𝓝[≠] 0) (𝓝 (4 * centeredGoldbachAt N)) := by
  have hsum : Tendsto
      (fun w : ℝ => ∑ p ∈ Finset.antidiagonal N,
        (normalizedIncrement p.1 w / w) *
          (normalizedIncrement p.2 w / w))
      (𝓝[≠] 0)
      (𝓝 (∑ p ∈ Finset.antidiagonal N,
        4 * (centeredWeight p.1 * centeredWeight p.2))) := by
    apply tendsto_finset_sum
    intro p hp
    convert (normalizedIncrement_div_tendsto p.1).mul
      (normalizedIncrement_div_tendsto p.2) using 1
    ring_nf
  have hevent : (fun w : ℝ => normalizedAdditiveSquare N w / w ^ 2) =ᶠ[𝓝[≠] 0]
      (fun w : ℝ => ∑ p ∈ Finset.antidiagonal N,
        (normalizedIncrement p.1 w / w) *
          (normalizedIncrement p.2 w / w)) := by
    filter_upwards [self_mem_nhdsWithin] with w hw
    unfold normalizedAdditiveSquare
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro p hp
    field_simp [hw]
  have htarget :
      (∑ p ∈ Finset.antidiagonal N,
        4 * (centeredWeight p.1 * centeredWeight p.2)) =
        4 * centeredGoldbachAt N := by
    simp only [centeredGoldbachAt, Finset.mul_sum]
  rw [← htarget]
  exact hsum.congr' hevent.symm

/-- The quadratic limit is the literal existing centered Goldbach
coefficient at total `k+2`. -/
theorem normalizedAdditiveSquare_quadratic_tendsto_shift (k : ℕ) :
    Tendsto (fun w : ℝ => normalizedAdditiveSquare (k + 2) w / w ^ 2)
      (𝓝[≠] 0) (𝓝 (4 * BuildingBlocks.GoldbachHeat.shiftedGoldbach k)) := by
  simpa only [centeredGoldbachAt_shift] using
    normalizedAdditiveSquare_quadratic_tendsto (k + 2)

#print axioms normalizer_hasDerivAt_zero
#print axioms complexNormalizer_eq_inv_zeta_of_pos
#print axioms normalizedIncrement_hasDerivAt_zero
#print axioms normalizedAdditiveSquare_quadratic_tendsto
#print axioms normalizedAdditiveSquare_quadratic_tendsto_shift

end BuildingBlocks.SuzukiPoleNormalizer
