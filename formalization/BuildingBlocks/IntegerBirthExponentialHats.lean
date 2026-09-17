import BuildingBlocks.IntegerBirthLaplaceOrder

open MeasureTheory Set
open scoped BigOperators Interval

namespace BuildingBlocks.IntegerBirthExponentialHats

open IntegerBirthKernel IntegerBirthSourceBound IntegerBirthLaplaceOrder

noncomputable def leftHat (t : ℝ) : ℝ := (t-1+Real.exp (-t))/t^2
noncomputable def rightHat (t : ℝ) : ℝ := (1-(1+t)*Real.exp (-t))/t^2
noncomputable def interpolationFactor (t : ℝ) : ℝ :=
  (1-Real.exp (-t))^2/(Real.exp (-t)*t^2)

private theorem integral_exp (t : ℝ) (ht : t ≠ 0) :
    (∫ v in (0 : ℝ)..1, Real.exp (-t*v)) = (1-Real.exp (-t))/t := by
  have hd (v : ℝ) : HasDerivAt (fun v => -Real.exp (-t*v)/t) (Real.exp (-t*v)) v := by
    have hh := (((hasDerivAt_id v).const_mul (-t)).exp.neg).div_const t
    convert hh using 1 <;> simp [ht]
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v)
    ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-t*v))).intervalIntegrable _ _)]
  simp
  ring

private theorem integral_exp_first (t : ℝ) (ht : t ≠ 0) :
    (∫ v in (0 : ℝ)..1, Real.exp (-t*v)*v) = rightHat t := by
  have hd (v : ℝ) : HasDerivAt
      (fun v => -Real.exp (-t*v)*(v/t+1/t^2)) (Real.exp (-t*v)*v) v := by
    have ha := ((hasDerivAt_id v).const_mul (-t)).exp.neg
    have hb := ((hasDerivAt_id v).div_const t).add_const (1/t^2)
    have hh := ha.mul hb
    change HasDerivAt (fun v => -Real.exp (-t*v)*(v/t+1/t^2))
      (-(Real.exp (-t*v)*(-t*1))*(v/t+1/t^2)+(-Real.exp (-t*v))*(1/t)) v at hh
    convert hh using 1 <;> field_simp <;> ring
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v)
    ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-t*v)*v)).intervalIntegrable _ _)]
  simp only [mul_one, mul_zero, Real.exp_zero, neg_mul, one_mul, zero_div, zero_add]
  unfold rightHat
  field_simp
  ring

theorem integral_exp_affine {t : ℝ} (ht : 0 < t) (c d : ℝ) :
    (∫ v in (0 : ℝ)..1, Real.exp (-t*v)*((1-v)*c+v*d)) = leftHat t*c+rightHat t*d := by
  have h0 : IntervalIntegrable (fun v : ℝ => Real.exp (-t*v)) volume 0 1 := (by fun_prop : Continuous _).intervalIntegrable _ _
  have h1 : IntervalIntegrable (fun v : ℝ => Real.exp (-t*v)*v) volume 0 1 := (by fun_prop : Continuous _).intervalIntegrable _ _
  have he : (fun v : ℝ => Real.exp (-t*v)*((1-v)*c+v*d)) =
      (fun v => Real.exp (-t*v)*c+(Real.exp (-t*v)*v)*(d-c)) := by funext v; ring
  rw [he, intervalIntegral.integral_add (h0.mul_const c) (h1.mul_const (d-c)),
    intervalIntegral.integral_mul_const, intervalIntegral.integral_mul_const,
    integral_exp t ht.ne', integral_exp_first t ht.ne']
  unfold leftHat rightHat
  field_simp
  ring

theorem hat_factor {t : ℝ} (ht : 0 < t) :
    leftHat t+rightHat t/Real.exp (-t)=interpolationFactor t := by
  unfold leftHat rightHat interpolationFactor
  field_simp
  ring

private theorem nat_cells_union : (⋃ j : ℕ, Ico (j : ℝ) ((j : ℝ)+1)) = Ici (0 : ℝ) := by
  ext u
  constructor
  · intro hu
    rcases mem_iUnion.mp hu with ⟨j, hj⟩
    exact (Nat.cast_nonneg j).trans hj.1
  · intro hu
    exact mem_iUnion.mpr ⟨⌊u⌋₊, Nat.floor_le hu, Nat.lt_floor_add_one u⟩

private theorem nat_cells_disjoint : Pairwise (fun i j : ℕ => Disjoint (Ico (i : ℝ) ((i : ℝ)+1)) (Ico (j : ℝ) ((j : ℝ)+1))) := by
  intro i j hij
  apply Set.disjoint_left.mpr
  intro u hi hj
  rcases lt_or_gt_of_ne hij with hij | hji
  · have hh : (i : ℝ)+1 ≤ j := by exact_mod_cast (show i+1 ≤ j by omega)
    linarith [hi.2, hj.1]
  · have hh : (j : ℝ)+1 ≤ i := by exact_mod_cast (show j+1 ≤ i by omega)
    linarith [hj.2, hi.1]

private theorem cell_integral {t : ℝ} (ht : 0 < t) (n j : ℕ) :
    (∫ u in Ico (j : ℝ) ((j : ℝ)+1), laplaceInterpolated t n u) =
      Real.exp (-t*(j : ℝ))*(leftHat t*sourceTerm n j+rightHat t*sourceTerm n (j+1)) := by
  have he : EqOn (laplaceInterpolated t n)
      (fun u => Real.exp (-t*u)*(((j : ℝ)+1-u)*sourceTerm n j+(u-j)*sourceTerm n (j+1)))
      (Ico (j : ℝ) ((j : ℝ)+1)) := by
    intro u hu
    have hf := Nat.floor_eq_on_Ico j u hu
    simp only [laplaceInterpolated, interpolatedTerm, interpolant, hf, sourceTerm, Nat.cast_add, Nat.cast_one]
    ring
  rw [setIntegral_congr_fun measurableSet_Ico he, ← integral_Icc_eq_integral_Ico, integral_Icc_eq_integral_Ioc,
    ← intervalIntegral.integral_of_le (by linarith : (j : ℝ) ≤ (j : ℝ)+1)]
  have hh := intervalIntegral.integral_comp_add_right
    (f := fun u => Real.exp (-t*u)*(((j : ℝ)+1-u)*sourceTerm n j+(u-j)*sourceTerm n (j+1)))
    (a := 0) (b := 1) (j : ℝ)
  simp only [zero_add] at hh
  rw [add_comm (1 : ℝ) (j : ℝ)] at hh
  rw [← hh]
  have hk : (fun v : ℝ => Real.exp (-t*(v+j))*(((j : ℝ)+1-(v+j))*sourceTerm n j+((v+j)-j)*sourceTerm n (j+1))) =
      (fun v => Real.exp (-t*(j : ℝ))*(Real.exp (-t*v)*((1-v)*sourceTerm n j+v*sourceTerm n (j+1)))) := by
    funext v
    rw [show -t*(v+j)= -t*(j : ℝ)+(-t*v) by ring, Real.exp_add]
    ring
  rw [hk, intervalIntegral.integral_const_mul, integral_exp_affine ht]

private theorem interpolated_cell_sum {t : ℝ} (ht : 0 < t) (n : ℕ) :
    (∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      ∑' j : ℕ, Real.exp (-t*(j : ℝ))*(leftHat t*sourceTerm n j+rightHat t*sourceTerm n (j+1)) := by
  have hi : IntegrableOn (laplaceInterpolated t n) (Ici (0 : ℝ)) :=
    Iff.mpr integrableOn_Ici_iff_integrableOn_Ioi (laplaceInterpolated_integrable ht n)
  have hh := hasSum_integral_iUnion (s := fun j : ℕ => Ico (j : ℝ) ((j : ℝ)+1))
    (fun _ => measurableSet_Ico) nat_cells_disjoint
    (by rw [nat_cells_union]; exact hi)
  rw [nat_cells_union, integral_Ici_eq_integral_Ioi] at hh
  simp_rw [cell_integral ht n] at hh
  exact hh.tsum_eq.symm

private theorem geometric_shift {r : ℝ} (hr : r ≠ 0) (c : ℕ → ℝ) (hc0 : c 0 = 0)
    (hc : Summable (fun j => r^j*c j)) :
    Summable (fun j => r^j*c (j+1)) ∧
      (∑' j, r^j*c (j+1)) = (∑' j, r^j*c j)/r := by
  have hh := (summable_nat_add_iff 1).mpr hc
  have hg : Summable (fun j => r^j*c (j+1)) := by
    convert hh.div_const r using 1
    funext j
    rw [pow_succ]
    field_simp
  refine ⟨hg, ?_⟩
  have he := hc.tsum_eq_zero_add
  simp only [pow_zero, hc0, mul_zero, zero_add] at he
  have hp : (fun j : ℕ => r^(j+1)*c (j+1)) = (fun j => r*(r^j*c (j+1))) := by
    funext j
    rw [pow_succ]
    ring
  rw [hp, tsum_mul_left] at he
  rw [he]
  field_simp

/-- Exact fixed-birth exponential interpolation identity; the only initial term vanishes by U_n(0)=0. -/
theorem actual_birth_hat_identity {t : ℝ} (ht : 0 < t) (n : ℕ) :
    (∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      interpolationFactor t * ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j := by
  let r := Real.exp (-t)
  have hr0 : 0 ≤ r := (Real.exp_pos _).le
  have hr1 : r < 1 := Real.exp_lt_one_iff.mpr (by linarith)
  have hrne : r ≠ 0 := Real.exp_ne_zero _
  have he (j : ℕ) : Real.exp (-t*(j : ℝ)) = r^j := by
    rw [mul_comm, Real.exp_nat_mul]
  have hc : Summable (fun j : ℕ => r^j*sourceTerm n j) := by
    have hh := (geometric_source_absolute hr0 hr1).comp_injective
      (i := fun j : ℕ => (n,j)) (fun i j h => congrArg Prod.snd h)
    exact hh.of_norm
  have hc0 : sourceTerm n 0 = 0 := by simp [sourceTerm]
  have hg := geometric_shift hrne (fun j : ℕ => sourceTerm n j) (by simpa using hc0) hc
  simp only [Nat.cast_add, Nat.cast_one] at hg
  rw [interpolated_cell_sum ht n]
  simp_rw [he]
  have hk : (fun j : ℕ => r^j*(leftHat t*sourceTerm n j+rightHat t*sourceTerm n (j+1))) =
      (fun j : ℕ => leftHat t*(r^j*sourceTerm n j)+rightHat t*(r^j*sourceTerm n (j+1))) := by
    funext j
    ring
  rw [hk, (hc.mul_left (leftHat t)).tsum_add (hg.1.mul_left (rightHat t)),
    tsum_mul_left, tsum_mul_left, hg.2]
  have hf := hat_factor ht
  change leftHat t+rightHat t/r=interpolationFactor t at hf
  rw [← hf]
  ring

/-- The complete actual Lambda-weighted exponential interpolation identity. -/
theorem actual_all_birth_hat_identity {t : ℝ} (ht : 0 < t) :
    (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      interpolationFactor t * ∑' n : ℕ, ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j := by
  simp_rw [actual_birth_hat_identity ht]
  exact tsum_mul_left

/-- A positive-order inequality for the actual complete discrete source, before any E+C identification. -/
theorem actual_discrete_laplace_order {t : ℝ} (ht : 0 < t) :
    (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceSource t n u) ≤
      interpolationFactor t * ∑' n : ℕ, ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j := by
  rw [← actual_all_birth_hat_identity ht]
  exact actual_laplace_interpolation_le ht

/-- Exact complete-source defect after exponential interpolation, with no discrete-source premise. -/
theorem actual_all_birth_defect_identity {t : ℝ} (ht : 0 < t) :
    interpolationFactor t * (∑' n : ℕ, ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j) -
      (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceSource t n u) =
    ∑' n : ℕ, ∫ u in Ioi (0 : ℝ), Real.exp (-t*u)*ArithmeticFunction.vonMangoldt (n+2)*
      (interpolant (n+2) u-U (n+2) u) := by
  rw [← actual_all_birth_hat_identity ht]
  exact actual_laplace_defect ht

#print axioms actual_birth_hat_identity
#print axioms actual_all_birth_hat_identity
#print axioms actual_discrete_laplace_order
#print axioms actual_all_birth_defect_identity
#print axioms integral_exp_affine
#print axioms cell_integral

end BuildingBlocks.IntegerBirthExponentialHats
