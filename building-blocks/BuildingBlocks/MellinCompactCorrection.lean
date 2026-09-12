import BuildingBlocks.ActualCriticalMellin

open MeasureTheory Set Filter Asymptotics
open scoped Topology

namespace BuildingBlocks.MellinCompactCorrection

/-- One absolutely convergent Mellin integral controls every compact interval
bounded away from zero. Here the exponent is fixed at the available value -3. -/
theorem integrableOn_Icc_of_mellin {f : ℝ → ℂ}
    (hf : MellinConvergent f (-3)) (A : ℝ) : IntegrableOn f (Icc 1 A) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ ((-3 : ℂ) - 1) * f x) (Icc 1 A) :=
    hf.mono_set (fun x hx => lt_of_lt_of_le zero_lt_one hx.1)
  have hp : ContinuousOn (fun x : ℝ => (x : ℂ) ^ (4 : ℕ)) (Icc 1 A) :=
    (Complex.continuous_ofReal.pow 4).continuousOn
  have hm := hi.continuousOn_mul hp isCompact_Icc
  apply hm.congr_fun _ measurableSet_Icc
  intro x hx
  have hx0 : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr (ne_of_gt (lt_of_lt_of_le zero_lt_one hx.1))
  change (x : ℂ) ^ (4 : ℕ) * ((x : ℂ) ^ ((-3 : ℂ) - 1) * f x) = f x
  rw [show (-3 : ℂ) - 1 = -(4 : ℂ) by norm_num, Complex.cpow_neg,
    Complex.cpow_ofNat, ← mul_assoc, mul_inv_cancel₀ (pow_ne_zero _ hx0), one_mul]

/-- Removing the finite initial interval in an eventual-sign argument. -/
noncomputable def initialPart (f : ℝ → ℂ) (A : ℝ) : ℝ → ℂ :=
  (Icc 1 A).indicator f

lemma initialPart_bigO_top (f : ℝ → ℂ) (A a : ℝ) :
    initialPart f A =O[atTop] (fun t : ℝ => t ^ (-a)) := by
  refine isBigO_iff.mpr ⟨1, ?_⟩
  filter_upwards [eventually_gt_atTop A] with t ht
  simp [initialPart, not_le.mpr ht]

lemma initialPart_bigO_zero (f : ℝ → ℂ) (A b : ℝ) :
    initialPart f A =O[𝓝[>] (0 : ℝ)] (fun t : ℝ => t ^ (-b)) := by
  refine isBigO_iff.mpr ⟨1, ?_⟩
  have he : ∀ᶠ t : ℝ in 𝓝[>] (0 : ℝ), t < 1 :=
    (eventually_lt_nhds (by norm_num : (0 : ℝ) < 1)).filter_mono nhdsWithin_le_nhds
  filter_upwards [he] with t ht
  simp [initialPart, not_le.mpr ht]

theorem mellinConvergent_initialPart {f : ℝ → ℂ} {A : ℝ}
    (hf : IntegrableOn f (Icc 1 A)) (s : ℂ) : MellinConvergent (initialPart f A) s := by
  have hi : Integrable (initialPart f A) :=
    (integrable_indicator_iff measurableSet_Icc).2 hf
  exact mellinConvergent_of_isBigO_rpow
    (hi.locallyIntegrable.locallyIntegrableOn (Ioi 0))
    (initialPart_bigO_top f A (s.re + 1)) (by linarith)
    (initialPart_bigO_zero f A (s.re - 1)) (by linarith)

/-- The compact initial contribution is entire. This does not assert that
the full integral converges beyond its proved half-plane. -/
theorem differentiable_mellin_initialPart {f : ℝ → ℂ} {A : ℝ}
    (hf : IntegrableOn f (Icc 1 A)) : Differentiable ℂ (mellin (initialPart f A)) := by
  have hi : Integrable (initialPart f A) :=
    (integrable_indicator_iff measurableSet_Icc).2 hf
  intro s
  exact (mellin_hasDerivAt_of_isBigO_rpow
    (hi.locallyIntegrable.locallyIntegrableOn (Ioi 0))
    (initialPart_bigO_top f A (s.re + 1)) (by linarith)
    (initialPart_bigO_zero f A (s.re - 1)) (by linarith)).2.differentiableAt

theorem W_integrableOn_Icc (A : ℝ) :
    IntegrableOn ActualCriticalMellin.W (Icc 1 A) := by
  apply integrableOn_Icc_of_mellin _ A
  convert (ActualCriticalMellin.hasMellin_W (s := 2) (by norm_num)).1 using 1 <;> norm_num

/-- The precise entire correction available for the actual arithmetic W. -/
theorem differentiable_W_initialPart (A : ℝ) :
    Differentiable ℂ (fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1)) := by
  exact (differentiable_mellin_initialPart (W_integrableOn_Icc A)).comp
    ((differentiable_id.neg).sub_const 1)

noncomputable def tailPart (f : ℝ → ℂ) (A : ℝ) : ℝ → ℂ :=
  (Ioi A).indicator f

theorem initialPart_add_tailPart {f : ℝ → ℂ}
    (hf : ∀ x : ℝ, x ≤ 1 → f x = 0) {A : ℝ} (hA : 1 ≤ A) :
    initialPart f A + tailPart f A = f := by
  funext x
  by_cases hxA : A < x
  · simp [initialPart, tailPart, hxA, not_le.mpr hxA]
  · by_cases hx1 : 1 ≤ x
    · simp [initialPart, tailPart, hxA, hx1, le_of_not_gt hxA]
    · simp [initialPart, tailPart, hxA, hx1, hf x (le_of_not_ge hx1)]

/-- The negative tail is nonnegative precisely when the separately stated
eventual-sign condition holds. Its definition itself imposes no such condition. -/
noncomputable def negativeWTail (A : ℝ) (x : ℝ) : ℂ :=
  -tailPart ActualCriticalMellin.W A x

theorem negativeWTail_eq_initial_sub {A : ℝ} (hA : 1 ≤ A) :
    negativeWTail A = initialPart ActualCriticalMellin.W A - ActualCriticalMellin.W := by
  have he := initialPart_add_tailPart (f := ActualCriticalMellin.W)
    (fun x hx => ActualCriticalMellin.W_zero hx) hA
  funext x
  have hx := congrFun he x
  change initialPart ActualCriticalMellin.W A x + tailPart ActualCriticalMellin.W A x =
    ActualCriticalMellin.W x at hx
  change -tailPart ActualCriticalMellin.W A x =
    initialPart ActualCriticalMellin.W A x - ActualCriticalMellin.W x
  rw [← hx]
  ring

theorem negativeWTail_im (A x : ℝ) : (negativeWTail A x).im = 0 := by
  by_cases hx : A < x <;>
    simp [negativeWTail, tailPart, hx, ActualCriticalMellin.W_real]

theorem negativeWTail_re_nonneg {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (x : ℝ) :
    0 ≤ (negativeWTail A x).re := by
  by_cases hx : A < x
  · simpa [negativeWTail, tailPart, hx] using neg_nonneg.mpr (hsign x hx)
  · simp [negativeWTail, tailPart, hx]

/-- Exact tail transform on the established domain, with the entire initial
correction retained. No eventual sign or continuation of the integral is used. -/
theorem hasMellin_negativeWTail {A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 < s.re) :
    HasMellin (negativeWTail A) (-s - 1)
      (mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
        CriticalTransformPoles.filledTransform s) := by
  have hw := ActualCriticalMellin.hasMellin_W_filled hs
  have hi := mellinConvergent_initialPart (W_integrableOn_Icc A) (-s - 1)
  rw [negativeWTail_eq_initial_sub hA]
  have hh := hasMellin_sub hi hw.1
  rw [hw.2] at hh
  exact hh

end BuildingBlocks.MellinCompactCorrection
