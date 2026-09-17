import BuildingBlocks.ActualArchimedeanFactor
import BuildingBlocks.CompactPhysicalMellinAnalytic

open MeasureTheory Metric Filter Set
open BuildingBlocks.ActualArchimedeanFactor
open BuildingBlocks.FullComplexHistoryMellin
open BuildingBlocks.CompactPhysicalMellinAnalytic

namespace BuildingBlocks.ActualZeroCircleResidues

theorem analytic_log_derivative_regular_part (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ H : ℂ → ℂ, AnalyticAt ℂ H s ∧
      ∀ᶠ w in nhds s, w ≠ s →
        logDeriv f w = (analyticOrderNatAt f s : ℂ) / (w - s) + H w := by
  obtain ⟨g, hg, hgn, he⟩ := hf.analyticOrderAt_ne_top.mp hfinite
  have he' : f =ᶠ[nhds s] (fun w => (w - s) ^ analyticOrderNatAt f s * g w) := by
    simpa only [smul_eq_mul] using he
  have hl : logDeriv f =ᶠ[nhds s]
      logDeriv (fun w => (w - s) ^ analyticOrderNatAt f s * g w) := by
    filter_upwards [he', he'.deriv] with w hw hdw
    simp only [logDeriv_apply]
    rw [hw, hdw]
  refine ⟨logDeriv g, hg.deriv.div hg hgn, ?_⟩
  have hng : ∀ᶠ w in nhds s, g w ≠ 0 := hg.continuousAt.eventually_ne hgn
  have hdg : ∀ᶠ w in nhds s, DifferentiableAt ℂ g w :=
    hg.eventually_analyticAt.mono (fun _ h => h.differentiableAt)
  filter_upwards [hl, hng, hdg] with w hlw hgw hdgw
  intro hsw
  have hb : HasDerivAt (fun v : ℂ => v - s) 1 w := (hasDerivAt_id w).sub_const s
  have hbl : logDeriv (fun v : ℂ => v - s) w = 1 / (w - s) := by
    rw [logDeriv_apply, hb.deriv]
  rw [hlw, logDeriv_mul (f := fun v => (v - s) ^ analyticOrderNatAt f s)
    (g := g) w (pow_ne_zero _ (sub_ne_zero.mpr hsw)) hgw
    (hb.differentiableAt.pow _) hdgw, logDeriv_fun_pow hb.differentiableAt, hbl]
  simp only [mul_one_div]

theorem analytic_zero_circle_coefficient (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv f w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt f s : ℂ) * F s := by
  obtain ⟨H, hH, he⟩ := analytic_log_derivative_regular_part f s hf hfinite
  obtain ⟨r, hr, hHa⟩ := hH.exists_ball_analyticOnNhd
  obtain ⟨δ, hδ, hmodel⟩ := Metric.eventually_nhds_iff_ball.mp he
  refine ⟨min r δ, lt_min hr hδ, ?_⟩
  intro F hF R hR hRe
  have hRr : R < r := lt_of_lt_of_le hRe (min_le_left _ _)
  have hRd : R < δ := lt_of_lt_of_le hRe (min_le_right _ _)
  have hG : AnalyticOnNhd ℂ (fun w => F w * H w) (closedBall s R) := by
    intro w hw
    exact (hF.analyticAt w).mul (hHa w (closedBall_subset_ball hRr hw))
  have hzero : (∮ w in C(s, R), F w * H w) = 0 :=
    Complex.circleIntegral_eq_zero_of_differentiable_on_off_countable hR.le
      Set.countable_empty hG.continuousOn
      (fun w hw => (hG w (ball_subset_closedBall hw.1)).differentiableAt)
  have hn : ∀ w ∈ sphere s R, w ≠ s := by
    intro w hw heq
    have hdist := Metric.mem_sphere.mp hw
    rw [heq, dist_self] at hdist
    exact (ne_of_gt hR) hdist.symm
  have heq : EqOn (fun w => F w * logDeriv f w)
      (fun w => (analyticOrderNatAt f s : ℂ) * (F w / (w - s)) + F w * H w)
      (sphere s R) := by
    intro w hw
    dsimp only
    rw [hmodel w (closedBall_subset_ball hRd (sphere_subset_closedBall hw)) (hn w hw)]
    ring
  have hrat : CircleIntegrable (fun w => F w / (w - s)) s R :=
    (hF.continuous.continuousOn.div (continuousOn_id.sub continuousOn_const)
      (fun w hw => sub_ne_zero.mpr (hn w hw))).circleIntegrable hR.le
  have hratm : CircleIntegrable
      (fun w => (analyticOrderNatAt f s : ℂ) * (F w / (w - s))) s R :=
    hrat.const_fun_smul
  have hgc : CircleIntegrable (fun w => F w * H w) s R :=
    (hG.continuousOn.mono sphere_subset_closedBall).circleIntegrable hR.le
  rw [circleIntegral.integral_congr hR.le heq, circleIntegral.integral_add hratm hgc,
    circleIntegral.integral_const_mul, hzero,
    entire_weight_circle_coefficient F hF s s R (mem_ball_self hR)]
  ring

theorem xi_zero_circle_coefficient (s : ℂ) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv xi w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) * F s :=
  analytic_zero_circle_coefficient xi s (xi_entire.analyticAt s) (xi_zero_order_finite s)

theorem finite_prime_block_xi_circle_coefficient {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w * logDeriv xi w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) *
            (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
              BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s := by
  obtain ⟨ε, hε, hc⟩ := xi_zero_circle_coefficient s
  refine ⟨ε, hε, ?_⟩
  intro primes hp M R hR hRe
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g)) :=
    finite_block_centered_weight_entire hf hg hfc hgc primes.toList M
  have hi := hc _ hF R hR hRe
  have hv : BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) s =
      (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
        BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s :=
    finite_prime_block_paired_weight hf hg hfc hgc primes hp M (s - 1 / 2)
  rw [hi, hv]
  ring

theorem zeta_zero_circle_coefficient (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) * F s := by
  have ho : analyticOrderNatAt riemannZeta s = analyticOrderNatAt xi s := by
    unfold analyticOrderNatAt
    rw [xi_zeta_zero_order s hs hs1]
  simpa only [ho] using analytic_zero_circle_coefficient riemannZeta s
    (zeta_analytic s hs1) (zeta_zero_order_finite s hs hs1)

theorem finite_prime_block_zeta_circle_coefficient {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) *
            (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
              BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s := by
  obtain ⟨ε, hε, hc⟩ := zeta_zero_circle_coefficient s hs hs1
  refine ⟨ε, hε, ?_⟩
  intro primes hp M R hR hRe
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g)) :=
    finite_block_centered_weight_entire hf hg hfc hgc primes.toList M
  have hi := hc _ hF R hR hRe
  have hv : BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) s =
      (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
        BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s :=
    finite_prime_block_paired_weight hf hg hfc hgc primes hp M (s - 1 / 2)
  rw [hi, hv]
  ring

theorem finite_prime_block_signed_circle_difference {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) -
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
          logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) *
            ((∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) - 1) *
              BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s := by
  obtain ⟨ε, hε, hc⟩ := zeta_zero_circle_coefficient s hs hs1
  refine ⟨ε, hε, ?_⟩
  intro primes hp M R hR hRe
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g)) :=
    finite_block_centered_weight_entire hf hg hfc hgc primes.toList M
  have hF0 : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight f g) :=
    centered_weight_entire hf hg hfc hgc
  have hi := hc _ hF R hR hRe
  have hi0 := hc _ hF0 R hR hRe
  have hv : BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) s =
      (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
        BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s :=
    finite_prime_block_paired_weight hf hg hfc hgc primes hp M (s - 1 / 2)
  rw [hi, hi0, hv]
  ring

theorem finite_prime_block_circle_comparison {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1)
    (delta : ℝ) (hd : 0 < delta) (hz : |(s - 1 / 2).re| ≤ 1 / 2 - delta) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        ‖(∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) -
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
          logDeriv riemannZeta w)‖ ≤
          ‖(2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ)‖ *
            ‖BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s‖ *
              (Real.exp (∑ p ∈ primes,
                let B := Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
                  (1 - Real.exp (-delta * Real.log (p : ℝ)))
                2 * B + B ^ 2) - 1) := by
  obtain ⟨ε, hε, hc⟩ := finite_prime_block_signed_circle_difference hf hg hfc hgc s hs hs1
  refine ⟨ε, hε, ?_⟩
  intro primes hp M R hR hRe
  rw [hc primes hp M R hR hRe]
  have he : ‖(2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) *
      ((∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) - 1) *
        BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s‖ =
      ‖(2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ)‖ *
        ‖BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s‖ *
          ‖(∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) - 1‖ := by
    simp only [norm_mul]
    ring
  rw [he]
  exact mul_le_mul_of_nonneg_left
    (BuildingBlocks.GrowingPrimeScatteringBounds.actual_block_interior_comparison
      primes hp (s - 1 / 2) M delta hd hz)
    (mul_nonneg (norm_nonneg _) (norm_nonneg _))

#print axioms analytic_log_derivative_regular_part
#print axioms analytic_zero_circle_coefficient
#print axioms xi_zero_circle_coefficient
#print axioms finite_prime_block_xi_circle_coefficient
#print axioms zeta_zero_circle_coefficient
#print axioms finite_prime_block_zeta_circle_coefficient
#print axioms finite_prime_block_signed_circle_difference
#print axioms finite_prime_block_circle_comparison
end BuildingBlocks.ActualZeroCircleResidues
