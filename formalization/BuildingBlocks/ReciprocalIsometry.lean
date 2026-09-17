import BuildingBlocks.MeanCorrection

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

noncomputable def fractionKernel (θ x : ℝ) : ℝ := Int.fract (θ / x)

noncomputable def reciprocalKernel (θ x : ℝ) : ℝ := θ / x * Int.fract (x / θ)

theorem fractionKernel_measurable (θ : ℝ) : Measurable (fractionKernel θ) := by
  unfold fractionKernel
  fun_prop

theorem reciprocalKernel_measurable (θ : ℝ) : Measurable (reciprocalKernel θ) := by
  unfold reciprocalKernel
  fun_prop

theorem fract_le_self_of_nonneg {u : ℝ} (hu : 0 ≤ u) : Int.fract u ≤ u := by
  have hh : (0 : ℝ) ≤ (⌊u⌋ : ℝ) := by exact_mod_cast Int.floor_nonneg.mpr hu
  change u - (⌊u⌋ : ℝ) ≤ u
  exact sub_le_self _ hh

theorem fractionKernel_bounds {θ x : ℝ} (hθ : 0 < θ) (hx : 0 < x) :
    0 ≤ fractionKernel θ x ∧ fractionKernel θ x ≤ 1 ∧ fractionKernel θ x ≤ θ / x :=
  ⟨Int.fract_nonneg _, (Int.fract_lt_one _).le, fract_le_self_of_nonneg (by positivity)⟩

theorem reciprocalKernel_bounds {θ x : ℝ} (hθ : 0 < θ) (hx : 0 < x) :
    0 ≤ reciprocalKernel θ x ∧ reciprocalKernel θ x ≤ 1 ∧ reciprocalKernel θ x ≤ θ / x := by
  have hr : 0 ≤ θ / x := by positivity
  refine ⟨mul_nonneg hr (Int.fract_nonneg _), ?_, ?_⟩
  · have hh := mul_le_mul_of_nonneg_left (fract_le_self_of_nonneg
      (show 0 ≤ x / θ by positivity)) hr
    have he : θ / x * (x / θ) = 1 := by field_simp
    simpa only [reciprocalKernel, he] using hh
  · exact mul_le_of_le_one_right hr (Int.fract_lt_one _).le

theorem integrableOn_Ioi_of_inverse_square_bound {f : ℝ → ℝ} {C : ℝ}
    (hf : Measurable f) (hlo : ∀ x ∈ Set.Ioc (0 : ℝ) 1, |f x| ≤ 1)
    (hhi : ∀ x ∈ Set.Ioi (1 : ℝ), |f x| ≤ C / x ^ 2) :
    IntegrableOn f (Set.Ioi (0 : ℝ)) := by
  have hl : IntegrableOn f (Set.Ioc (0 : ℝ) 1) := by
    apply (intervalIntegrable_const (μ := volume) (a := 0) (b := 1) (c := (1 : ℝ))).1.mono'
      hf.aestronglyMeasurable
    filter_upwards [ae_restrict_mem measurableSet_Ioc] with x hx
    simpa only [Real.norm_eq_abs] using hlo x hx
  have hg : IntegrableOn (fun x : ℝ => C / x ^ 2) (Set.Ioi 1) := by
    have hh := (integrableOn_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1)
      (by norm_num : (0 : ℝ) < 1)).const_mul C
    change Integrable (fun x : ℝ => C / x ^ 2) (volume.restrict (Set.Ioi 1))
    simpa only [Real.rpow_neg_ofNat, zpow_neg, zpow_ofNat, div_eq_mul_inv] using hh
  have hr : IntegrableOn f (Set.Ioi (1 : ℝ)) := by
    apply hg.mono' hf.aestronglyMeasurable
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
    simpa only [Real.norm_eq_abs] using hhi x hx
  have hu : Set.Ioc (0 : ℝ) 1 ∪ Set.Ioi 1 = Set.Ioi 0 := by
    ext x
    simp only [Set.mem_union, Set.mem_Ioc, Set.mem_Ioi]
    constructor
    · rintro (h | h) <;> linarith
    · intro h
      by_cases hx : x ≤ 1
      · exact Or.inl ⟨h, hx⟩
      · exact Or.inr (lt_of_not_ge hx)
  rw [← hu]
  exact hl.union hr

theorem kernel_product_integrable {f g : ℝ → ℝ} {θ η : ℝ}
    (hf : Measurable f) (hg : Measurable g)
    (hfb : ∀ x, 0 < x → 0 ≤ f x ∧ f x ≤ 1 ∧ f x ≤ θ / x)
    (hgb : ∀ x, 0 < x → 0 ≤ g x ∧ g x ≤ 1 ∧ g x ≤ η / x) :
    IntegrableOn (fun x => f x * g x) (Set.Ioi (0 : ℝ)) := by
  apply integrableOn_Ioi_of_inverse_square_bound (C := θ * η) (hf.mul hg)
  · intro x hx
    obtain ⟨hf0, hf1, hft⟩ := hfb x hx.1
    obtain ⟨hg0, hg1, hgt⟩ := hgb x hx.1
    rw [abs_of_nonneg (mul_nonneg hf0 hg0)]
    nlinarith
  · intro x hx
    have hx0 : 0 < x := lt_trans (by norm_num : (0 : ℝ) < 1) hx
    obtain ⟨hf0, hf1, hft⟩ := hfb x hx0
    obtain ⟨hg0, hg1, hgt⟩ := hgb x hx0
    rw [abs_of_nonneg (mul_nonneg hf0 hg0)]
    have hh := mul_le_mul hft hgt hg0 (hf0.trans hft)
    convert hh using 1
    ring

theorem fractionKernel_product_integrable {θ η : ℝ} (hθ : 0 < θ) (hη : 0 < η) :
    IntegrableOn (fun x => fractionKernel θ x * fractionKernel η x) (Set.Ioi (0 : ℝ)) :=
  kernel_product_integrable (fractionKernel_measurable θ) (fractionKernel_measurable η)
    (fun _ hx => fractionKernel_bounds hθ hx) (fun _ hx => fractionKernel_bounds hη hx)

theorem reciprocalKernel_product_integrable {θ η : ℝ} (hθ : 0 < θ) (hη : 0 < η) :
    IntegrableOn (fun x => reciprocalKernel θ x * reciprocalKernel η x) (Set.Ioi (0 : ℝ)) :=
  kernel_product_integrable (reciprocalKernel_measurable θ) (reciprocalKernel_measurable η)
    (fun _ hx => reciprocalKernel_bounds hθ hx) (fun _ hx => reciprocalKernel_bounds hη hx)

/-- The two families have the same Gram kernel, by x = θη/y. -/
theorem fractionKernel_gram_eq {θ η : ℝ} (hθ : 0 < θ) (hη : 0 < η) :
    (∫ x in Set.Ioi (0 : ℝ), fractionKernel θ x * fractionKernel η x) =
      ∫ x in Set.Ioi (0 : ℝ), reciprocalKernel θ x * reciprocalKernel η x := by
  let f : ℝ → ℝ := fun y => θ * η / y
  let f' : ℝ → ℝ := fun y => -(θ * η) / y ^ 2
  have hd : ∀ y ∈ Set.Ioi (0 : ℝ), HasDerivWithinAt f (f' y) (Set.Ioi 0) y := by
    intro y hy
    have hh := ((hasDerivAt_id y).inv (ne_of_gt hy)).const_mul (θ * η)
    convert hh.hasDerivWithinAt using 1
    dsimp [f, f']
    ring
  have himage : f '' Set.Ioi (0 : ℝ) = Set.Ioi 0 := by
    ext x
    constructor
    · rintro ⟨y, hy, rfl⟩
      exact div_pos (mul_pos hθ hη) hy
    · intro hx
      refine ⟨θ * η / x, div_pos (mul_pos hθ hη) hx, ?_⟩
      dsimp [f]
      field_simp
  have hinj : Set.InjOn f (Set.Ioi (0 : ℝ)) := by
    intro x hx y hy hxy
    dsimp [f] at hxy
    have hh : x⁻¹ = y⁻¹ := by
      apply mul_left_cancel₀ (mul_ne_zero hθ.ne' hη.ne')
      simpa only [div_eq_mul_inv] using hxy
    exact inv_injective hh
  have he := integral_image_eq_integral_abs_deriv_smul measurableSet_Ioi hd hinj
    (fun x => fractionKernel θ x * fractionKernel η x)
  rw [himage] at he
  rw [he]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro y hy
  have heθ : θ / (θ * η / y) = y / η := by field_simp
  have heη : η / (θ * η / y) = y / θ := by field_simp
  simp only [fractionKernel, reciprocalKernel, f, f', heθ, heη, smul_eq_mul,
    abs_div, abs_neg, abs_of_pos (mul_pos hθ hη), abs_of_nonneg (sq_nonneg y)]
  ring

noncomputable def kernelSum {ι : Type*} (k : ℝ → ℝ → ℝ)
    (S : Finset ι) (c θ : ι → ℝ) (x : ℝ) : ℝ := ∑ i ∈ S, c i * k (θ i) x

theorem kernelSum_product_integrable {ι κ : Type*} (k l : ℝ → ℝ → ℝ)
    (S : Finset ι) (T : Finset κ) (c θ : ι → ℝ) (d η : κ → ℝ)
    (h : ∀ i ∈ S, ∀ j ∈ T,
      IntegrableOn (fun x => k (θ i) x * l (η j) x) (Set.Ioi (0 : ℝ))) :
    IntegrableOn (fun x => kernelSum k S c θ x * kernelSum l T d η x) (Set.Ioi (0 : ℝ)) := by
  change Integrable _ (volume.restrict (Set.Ioi 0))
  have ht : ∀ i ∈ S, ∀ j ∈ T, Integrable
      (fun x => (c i * k (θ i) x) * (d j * l (η j) x)) (volume.restrict (Set.Ioi 0)) := by
    intro i hi j hj
    convert (h i hi j hj).const_mul (c i * d j) using 1
    funext x
    ring
  have hh := integrable_finset_sum S (fun i hi => integrable_finset_sum T (ht i hi))
  simpa only [kernelSum, Finset.sum_mul_sum] using hh

theorem kernelSum_product_integral {ι κ : Type*} (k l : ℝ → ℝ → ℝ)
    (S : Finset ι) (T : Finset κ) (c θ : ι → ℝ) (d η : κ → ℝ)
    (h : ∀ i ∈ S, ∀ j ∈ T,
      IntegrableOn (fun x => k (θ i) x * l (η j) x) (Set.Ioi (0 : ℝ))) :
    (∫ x in Set.Ioi (0 : ℝ), kernelSum k S c θ x * kernelSum l T d η x) =
      ∑ i ∈ S, ∑ j ∈ T, (c i * d j) *
        ∫ x in Set.Ioi (0 : ℝ), k (θ i) x * l (η j) x := by
  have ht : ∀ i ∈ S, ∀ j ∈ T, Integrable
      (fun x => (c i * k (θ i) x) * (d j * l (η j) x)) (volume.restrict (Set.Ioi 0)) := by
    intro i hi j hj
    convert (h i hi j hj).const_mul (c i * d j) using 1
    funext x
    ring
  simp only [kernelSum, Finset.sum_mul_sum]
  rw [integral_finset_sum S (fun i hi => integrable_finset_sum T (ht i hi))]
  apply Finset.sum_congr rfl
  intro i hi
  rw [integral_finset_sum T (ht i hi)]
  apply Finset.sum_congr rfl
  intro j hj
  rw [← integral_const_mul]
  apply integral_congr_ae
  exact Eventually.of_forall (fun x => by ring)

theorem kernelSum_gram_eq {ι κ : Type*} (S : Finset ι) (T : Finset κ)
    (c θ : ι → ℝ) (d η : κ → ℝ)
    (hθ : ∀ i ∈ S, 0 < θ i) (hη : ∀ j ∈ T, 0 < η j) :
    (∫ x in Set.Ioi (0 : ℝ),
      kernelSum fractionKernel S c θ x * kernelSum fractionKernel T d η x) =
      ∫ x in Set.Ioi (0 : ℝ),
        kernelSum reciprocalKernel S c θ x * kernelSum reciprocalKernel T d η x := by
  rw [kernelSum_product_integral _ _ _ _ _ _ _ _
      (fun i hi j hj => fractionKernel_product_integrable (hθ i hi) (hη j hj)),
    kernelSum_product_integral _ _ _ _ _ _ _ _
      (fun i hi j hj => reciprocalKernel_product_integrable (hθ i hi) (hη j hj))]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  rw [fractionKernel_gram_eq (hθ i hi) (hη j hj)]

theorem integral_sq_sub_expansion {f g : ℝ → ℝ}
    (hf : IntegrableOn (fun x => f x * f x) (Set.Ioi (0 : ℝ)))
    (hfg : IntegrableOn (fun x => f x * g x) (Set.Ioi (0 : ℝ)))
    (hg : IntegrableOn (fun x => g x * g x) (Set.Ioi (0 : ℝ))) :
    (∫ x in Set.Ioi (0 : ℝ), (f x - g x) ^ 2) =
      (∫ x in Set.Ioi (0 : ℝ), f x * f x) -
        2 * (∫ x in Set.Ioi (0 : ℝ), f x * g x) +
        ∫ x in Set.Ioi (0 : ℝ), g x * g x := by
  have he : (fun x => (f x - g x) ^ 2) =
      (fun x => f x * f x - 2 * (f x * g x) + g x * g x) := by
    funext x
    ring
  have hs : IntegrableOn (fun x => f x * f x - 2 * (f x * g x)) (Set.Ioi (0 : ℝ)) :=
    hf.sub (hfg.const_mul 2)
  have he' : (∫ x in Set.Ioi (0 : ℝ), f x * f x - 2 * (f x * g x)) =
      (∫ x in Set.Ioi (0 : ℝ), f x * f x) -
        ∫ x in Set.Ioi (0 : ℝ), 2 * (f x * g x) := by
    simpa only [Pi.sub_apply] using integral_sub hf (hfg.const_mul 2)
  rw [he, integral_add hs hg, he', integral_const_mul]

/-- Squared distances between arbitrary finite sums are preserved. This is
an identity on the finite span, with every required integral justified. -/
theorem kernelSum_distance_eq {ι κ : Type*} (S : Finset ι) (T : Finset κ)
    (c θ : ι → ℝ) (d η : κ → ℝ)
    (hθ : ∀ i ∈ S, 0 < θ i) (hη : ∀ j ∈ T, 0 < η j) :
    (∫ x in Set.Ioi (0 : ℝ),
      (kernelSum fractionKernel S c θ x - kernelSum fractionKernel T d η x) ^ 2) =
      ∫ x in Set.Ioi (0 : ℝ),
        (kernelSum reciprocalKernel S c θ x - kernelSum reciprocalKernel T d η x) ^ 2 := by
  rw [integral_sq_sub_expansion
      (kernelSum_product_integrable _ _ _ _ _ _ _ _
        (fun i hi j hj => fractionKernel_product_integrable (hθ i hi) (hθ j hj)))
      (kernelSum_product_integrable _ _ _ _ _ _ _ _
        (fun i hi j hj => fractionKernel_product_integrable (hθ i hi) (hη j hj)))
      (kernelSum_product_integrable _ _ _ _ _ _ _ _
        (fun i hi j hj => fractionKernel_product_integrable (hη i hi) (hη j hj))),
    integral_sq_sub_expansion
      (kernelSum_product_integrable _ _ _ _ _ _ _ _
        (fun i hi j hj => reciprocalKernel_product_integrable (hθ i hi) (hθ j hj)))
      (kernelSum_product_integrable _ _ _ _ _ _ _ _
        (fun i hi j hj => reciprocalKernel_product_integrable (hθ i hi) (hη j hj)))
      (kernelSum_product_integrable _ _ _ _ _ _ _ _
        (fun i hi j hj => reciprocalKernel_product_integrable (hη i hi) (hη j hj))),
    kernelSum_gram_eq S S c θ c θ hθ hθ,
    kernelSum_gram_eq S T c θ d η hθ hη,
    kernelSum_gram_eq T T d η d η hη hη]

end BuildingBlocks
