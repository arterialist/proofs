import BuildingBlocks.ReflectionFilter
import Mathlib.Analysis.SpecialFunctions.Trigonometric.InverseDeriv
import Mathlib.Analysis.Convex.SpecificFunctions.Deriv
import Mathlib.Analysis.Convex.SpecificFunctions.Pow

open MeasureTheory Set
open scoped Interval

namespace BuildingBlocks.IntegerBirthKernel

/-- The literal integer-birth arcsine kernel, with its assigned continuous value at zero. -/
noncomputable def q (n : ℝ) (u : ℝ) : ℝ :=
  if u = 0 then 1/Real.sqrt n else
  if u ≤ n then Real.arcsin (Real.sqrt (u/n))/Real.sqrt u else
    Real.pi/(2*Real.sqrt u)

noncomputable def integrand (n u y : ℝ) : ℝ := 1/Real.sqrt (n-u*y^2)

private theorem arcsine_primitive_deriv {n u y : ℝ} (hn : 0 < n)
    (hu : 0 < u) (hun : u ≤ n) (hy : y ∈ Ioo (0 : ℝ) 1) :
    HasDerivAt (fun y => Real.arcsin (Real.sqrt (u/n)*y)/Real.sqrt u)
      (integrand n u y) y := by
  let c := Real.sqrt (u/n)
  have hc0 : 0 < c := Real.sqrt_pos.mpr (div_pos hu hn)
  have hc1 : c ≤ 1 := by
    dsimp [c]
    exact (Real.sqrt_le_one).mpr ((div_le_one hn).mpr hun)
  have hcy0 : 0 < c*y := mul_pos hc0 hy.1
  have hcy1 : c*y < 1 := (mul_le_mul_of_nonneg_right hc1 hy.1.le).trans_lt (by simpa using hy.2)
  have hd0 : 0 < 1-(c*y)^2 := by nlinarith
  have hc2 : c^2 = u/n := Real.sq_sqrt (div_pos hu hn).le
  have hsqrt : Real.sqrt (n-u*y^2) = Real.sqrt n*Real.sqrt (1-(c*y)^2) := by
    rw [← Real.sqrt_mul hn.le]
    congr 1
    have hcu : n*c^2=u := by rw [hc2]; field_simp
    nlinarith [hcu]
  have hcu : c*Real.sqrt n = Real.sqrt u := by
    dsimp [c]
    rw [Real.sqrt_div hu.le]
    exact div_mul_cancel₀ _ (ne_of_gt (Real.sqrt_pos.mpr hn))
  have hh := ((Real.hasDerivAt_arcsin (by linarith : c*y ≠ -1)
      (by linarith : c*y ≠ 1)).comp y ((hasDerivAt_id y).const_mul c)).div_const (Real.sqrt u)
  change HasDerivAt (fun y => Real.arcsin (c*y)/Real.sqrt u)
    ((1/Real.sqrt (1-(c*y)^2)*(c*1))/Real.sqrt u) y at hh
  convert hh using 1
  unfold integrand
  rw [hsqrt, ← hcu]
  field_simp

/-- Integrability includes u=n: the endpoint cusp is handled by the nonnegative derivative FTC. -/
theorem integrand_intervalIntegrable {n u : ℝ} (hn : 0 < n) (hu : 0 ≤ u) (hun : u ≤ n) :
    IntervalIntegrable (integrand n u) volume 0 1 := by
  rcases hu.eq_or_lt with rfl | hu
  · change IntervalIntegrable (fun y : ℝ => 1/Real.sqrt (n-0*y^2)) volume 0 1
    simp only [zero_mul, sub_zero]
    exact intervalIntegrable_const
  · apply intervalIntegral.intervalIntegrable_deriv_of_nonneg
      (g := fun y => Real.arcsin (Real.sqrt (u/n)*y)/Real.sqrt u)
    · exact (by fun_prop : Continuous (fun y : ℝ => Real.arcsin (Real.sqrt (u/n)*y)/Real.sqrt u)).continuousOn
    · intro y hy
      simp only [min_eq_left (by norm_num : (0 : ℝ) ≤ 1), max_eq_right (by norm_num : (0 : ℝ) ≤ 1)] at hy
      exact arcsine_primitive_deriv hn hu hun hy
    · intro y hy
      exact div_nonneg zero_le_one (Real.sqrt_nonneg _)

/-- Exact positive-integral representation of the actual pre-birth kernel, including both endpoints. -/
theorem q_eq_integral {n u : ℝ} (hn : 0 < n) (hu : 0 ≤ u) (hun : u ≤ n) :
    q n u = ∫ y in (0 : ℝ)..1, integrand n u y := by
  rcases hu.eq_or_lt with rfl | hu
  · simp [q, integrand]
  · have hh := intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le
      (by norm_num : (0 : ℝ) ≤ 1)
      (f := fun y => Real.arcsin (Real.sqrt (u/n)*y)/Real.sqrt u)
      (f' := integrand n u)
      (by fun_prop : ContinuousOn (fun y : ℝ => Real.arcsin (Real.sqrt (u/n)*y)/Real.sqrt u) (Icc 0 1))
      (fun y hy => arcsine_primitive_deriv hn hu hun hy)
      (integrand_intervalIntegrable hn hu.le hun)
    simpa [q, ne_of_gt hu, hun] using hh.symm

/-- Positive reciprocal square root is convex; this combines sqrt concavity with inverse convexity. -/
theorem convexOn_inv_sqrt : ConvexOn ℝ (Ioi (0 : ℝ)) (fun x => 1/Real.sqrt x) := by
  have hi : ConvexOn ℝ (Ioi (0 : ℝ)) (fun x => 1/x) := by
    simpa using (strictConvexOn_zpow (m := (-1 : ℤ)) (by norm_num) (by norm_num)).convexOn
  refine ⟨convex_Ioi 0, ?_⟩
  intro x hx y hy a b ha hb hab
  change 0 < x at hx
  change 0 < y at hy
  have hx0 : 0 < Real.sqrt x := Real.sqrt_pos.mpr hx
  have hy0 : 0 < Real.sqrt y := Real.sqrt_pos.mpr hy
  have hc := Real.strictConcaveOn_sqrt.concaveOn.2 (show x ∈ Ici 0 from hx.le)
    (show y ∈ Ici 0 from hy.le) ha hb hab
  simp only [smul_eq_mul] at hc ⊢
  have hp : 0 < a*Real.sqrt x+b*Real.sqrt y := by
    rcases ha.eq_or_lt with rfl | ha
    · have hb1 : b = 1 := by linarith
      simp [hb1, hy0]
    · exact add_pos_of_pos_of_nonneg (mul_pos ha hx0) (mul_nonneg hb hy0.le)
  exact (one_div_le_one_div_of_le hp hc).trans (hi.2 hx0 hy0 ha hb hab)

private theorem radicand_pos {n u y : ℝ} (hn : 0 < n) (hu : u ∈ Icc (0 : ℝ) n)
    (hy : y ∈ Ioo (0 : ℝ) 1) : 0 < n-u*y^2 := by
  have hy2 : y^2 < 1 := by nlinarith [hy.1, hy.2]
  have hmul := mul_le_mul_of_nonneg_right hu.2 (sq_nonneg y)
  have hp := mul_pos hn (sub_pos.mpr hy2)
  nlinarith

/-- Convexity survives integration on the full closed pre-birth interval, including its cusp. -/
theorem q_convexOn_prebirth {n : ℝ} (hn : 0 < n) : ConvexOn ℝ (Icc (0 : ℝ) n) (q n) := by
  refine ⟨convex_Icc 0 n, ?_⟩
  intro x hx y hy a b ha hb hab
  have hz := (convex_Icc (0 : ℝ) n) hx hy ha hb hab
  simp only [smul_eq_mul] at hz ⊢
  rw [q_eq_integral hn hz.1 hz.2, q_eq_integral hn hx.1 hx.2,
    q_eq_integral hn hy.1 hy.2]
  have hix := integrand_intervalIntegrable hn hx.1 hx.2
  have hiy := integrand_intervalIntegrable hn hy.1 hy.2
  have hiz := integrand_intervalIntegrable hn hz.1 hz.2
  rw [← intervalIntegral.integral_const_mul, ← intervalIntegral.integral_const_mul,
    ← intervalIntegral.integral_add (hix.const_mul a) (hiy.const_mul b)]
  apply intervalIntegral.integral_mono_ae_restrict (by norm_num : (0 : ℝ) ≤ 1)
    hiz ((hix.const_mul a).add (hiy.const_mul b))
  have hn0 : ∀ᵐ z : ℝ ∂volume, z ≠ 0 := by
    simpa using (Set.countable_singleton (0 : ℝ)).ae_notMem volume
  have hn1 : ∀ᵐ z : ℝ ∂volume, z ≠ 1 := by
    simpa using (Set.countable_singleton (1 : ℝ)).ae_notMem volume
  filter_upwards [ae_restrict_mem measurableSet_Icc, ae_restrict_of_ae hn0,
    ae_restrict_of_ae hn1] with z hz hz0 hz1
  have hz' : z ∈ Ioo (0 : ℝ) 1 := ⟨lt_of_le_of_ne hz.1 (Ne.symm hz0), lt_of_le_of_ne hz.2 hz1⟩
  have hc := convexOn_inv_sqrt.2 (radicand_pos hn hx hz') (radicand_pos hn hy hz') ha hb hab
  simp only [smul_eq_mul] at hc
  have he : a*(n-x*z^2)+b*(n-y*z^2)=n-(a*x+b*y)*z^2 := by
    nlinarith [hab]
  rw [he] at hc
  exact hc

@[simp] theorem q_zero (n : ℝ) : q n 0 = 1/Real.sqrt n := by simp [q]

/-- The two literal branches agree at the integer birth, although their slopes need not agree. -/
theorem q_at_birth {n : ℝ} (hn : 0 < n) : q n n = Real.pi/(2*Real.sqrt n) := by
  simp only [q, if_neg (ne_of_gt hn), if_pos le_rfl, div_self (ne_of_gt hn),
    Real.sqrt_one, Real.arcsin_one]
  ring

theorem q_eq_postbirth {n u : ℝ} (hn : 0 < n) (hu : n ≤ u) :
    q n u = Real.pi/(2*Real.sqrt u) := by
  rcases hu.eq_or_lt with rfl | hu
  · exact q_at_birth hn
  · have hu0 : u ≠ 0 := ne_of_gt (hn.trans hu)
    simp [q, hu0, not_le.mpr hu]

theorem q_convexOn_postbirth {n : ℝ} (hn : 0 < n) : ConvexOn ℝ (Ici n) (q n) := by
  have hc : ConvexOn ℝ (Ici n) (fun x => 1/Real.sqrt x) :=
    convexOn_inv_sqrt.subset (fun x hx => hn.trans_le hx) (convex_Ici n)
  have hd := ConvexOn.smul (c := Real.pi/2) (by positivity) hc
  apply hd.congr
  intro u hu
  rw [q_eq_postbirth hn hu]
  simp only [smul_eq_mul]
  ring

/-- Integer births lie on cell boundaries: every actual unit clock cell is convex. -/
theorem q_convexOn_integer_cell {n j : ℕ} (hn : 2 ≤ n) :
    ConvexOn ℝ (Icc (j : ℝ) ((j : ℝ)+1)) (q n) := by
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  by_cases hjn : j < n
  · apply (q_convexOn_prebirth hn0).subset _ (convex_Icc _ _)
    intro u hu
    have hj0 : (0 : ℝ) ≤ j := Nat.cast_nonneg j
    have hje : (j : ℝ)+1 ≤ n := by exact_mod_cast (show j+1 ≤ n by omega)
    exact ⟨hj0.trans hu.1, hu.2.trans hje⟩
  · apply (q_convexOn_postbirth hn0).subset _ (convex_Icc _ _)
    intro u hu
    have hnj : (n : ℝ) ≤ j := by exact_mod_cast (Nat.le_of_not_gt hjn)
    exact hnj.trans hu.1

noncomputable def U (n : ℕ) (u : ℝ) : ℝ := q n u - 1/Real.sqrt n

/-- The ordinary integer-node interpolant of the actual centered birth kernel. -/
noncomputable def interpolant (n : ℕ) (u : ℝ) : ℝ :=
  ((⌊u⌋₊ : ℝ)+1-u)*U n ⌊u⌋₊ + (u-⌊u⌋₊)*U n ((⌊u⌋₊ : ℝ)+1)

@[simp] theorem U_zero (n : ℕ) : U n 0 = 0 := by simp [U]

/-- Actual pointwise positive interpolation defect; no global convexity across a birth is assumed. -/
theorem interpolation_nonnegative {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ interpolant n u - U n u := by
  let j := ⌊u⌋₊
  have hju : (j : ℝ) ≤ u := Nat.floor_le hu
  have huj : u ≤ (j : ℝ)+1 := (Nat.lt_floor_add_one u).le
  have ha : 0 ≤ (j : ℝ)+1-u := by linarith
  have hb : 0 ≤ u-(j : ℝ) := by linarith
  have hab : ((j : ℝ)+1-u)+(u-(j : ℝ))=1 := by ring
  have hc := (q_convexOn_integer_cell (n := n) (j := j) hn).2
    (show (j : ℝ) ∈ Icc (j : ℝ) ((j : ℝ)+1) by constructor <;> linarith)
    (show (j : ℝ)+1 ∈ Icc (j : ℝ) ((j : ℝ)+1) by constructor <;> linarith) ha hb hab
  simp only [smul_eq_mul] at hc
  have he : ((j : ℝ)+1-u)*(j : ℝ)+(u-(j : ℝ))*((j : ℝ)+1)=u := by ring
  rw [he] at hc
  change 0 ≤ ((j : ℝ)+1-u)*(q n j-1/Real.sqrt n) +
    (u-(j : ℝ))*(q n ((j : ℝ)+1)-1/Real.sqrt n) - (q n u-1/Real.sqrt n)
  nlinarith

#print axioms q_convexOn_integer_cell
#print axioms interpolation_nonnegative
#print axioms q_convexOn_prebirth
#print axioms q_eq_integral

end BuildingBlocks.IntegerBirthKernel
