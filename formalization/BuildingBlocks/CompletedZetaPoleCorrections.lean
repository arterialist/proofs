import BuildingBlocks.ActualArchimedeanFactor
import BuildingBlocks.CompactPhysicalMellinAnalytic

open MeasureTheory Metric Filter Set
open BuildingBlocks.ActualArchimedeanFactor
open BuildingBlocks.FullComplexHistoryMellin
open BuildingBlocks.CompactPhysicalMellinAnalytic

namespace BuildingBlocks.CompletedZetaPoleCorrections

theorem completed_log_derivative_corrections (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1)
    (hx : xi s ≠ 0) :
    logDeriv completedRiemannZeta s = logDeriv xi s - 1 / s - 1 / (s - 1) := by
  have hn1 : s - 1 ≠ 0 := sub_ne_zero.mpr hs1
  let q : ℂ → ℂ := fun w => w * (w - 1) / 2
  have hq : HasDerivAt q ((1 * (s - 1) + s * 1) / 2) s :=
    ((hasDerivAt_id s).mul ((hasDerivAt_id s).sub_const 1)).div_const 2
  have hqn : q s ≠ 0 := div_ne_zero (mul_ne_zero hs0 hn1) (by norm_num)
  have hcn : completedRiemannZeta s ≠ 0 := by
    intro he
    apply hx
    rw [xi_completed_relation s hs0 hs1, he, mul_zero, zero_div]
  have he : xi =ᶠ[nhds s] (fun w => q w * completedRiemannZeta w) := by
    have h0 : ∀ᶠ w : ℂ in nhds s, w ≠ 0 := isOpen_ne.mem_nhds hs0
    have h1 : ∀ᶠ w : ℂ in nhds s, w ≠ 1 := isOpen_ne.mem_nhds hs1
    filter_upwards [h0, h1] with w hw0 hw1
    rw [xi_completed_relation w hw0 hw1]
    dsimp [q]
    ring
  have hlq : logDeriv q s = 1 / s + 1 / (s - 1) := by
    rw [logDeriv_apply, hq.deriv]
    dsimp [q]
    field_simp
  have hl : logDeriv xi s = logDeriv (fun w => q w * completedRiemannZeta w) s := by
    rw [logDeriv_apply, logDeriv_apply, he.deriv_eq, he.eq_of_nhds]
  have hsum : logDeriv xi s = 1 / s + 1 / (s - 1) + logDeriv completedRiemannZeta s := by
    rw [hl, logDeriv_mul (f := q) (g := completedRiemannZeta) s hqn hcn
      hq.differentiableAt (differentiableAt_completedZeta hs0 hs1), hlq]
  rw [hsum]
  ring

theorem xi_log_derivative_continuousOn (S : Set ℂ) (hx : ∀ w ∈ S, xi w ≠ 0) :
    ContinuousOn (logDeriv xi) S := by
  have hd : Continuous (deriv xi) := continuous_iff_continuousAt.mpr
    (fun w => (xi_entire.analyticAt w).deriv.continuousAt)
  exact hd.continuousOn.div xi_entire.continuous.continuousOn hx

theorem boundary_excludes_interior (c s : ℂ) (R : ℝ) (hs : s ∈ ball c R) :
    ∀ w ∈ sphere c R, w ≠ s := by
  intro w hw he
  have hd := mem_sphere.mp hw
  rw [he] at hd
  exact (ne_of_lt (mem_ball.mp hs)) hd

theorem completed_log_derivative_continuousOn (S : Set ℂ)
    (hx : ∀ w ∈ S, xi w ≠ 0) (h0 : ∀ w ∈ S, w ≠ 0) (h1 : ∀ w ∈ S, w ≠ 1) :
    ContinuousOn (logDeriv completedRiemannZeta) S := by
  have hc0 : ContinuousOn (fun w : ℂ => 1 / w) S :=
    continuousOn_const.div continuousOn_id h0
  have hc1 : ContinuousOn (fun w : ℂ => 1 / (w - 1)) S :=
    continuousOn_const.div (continuousOn_id.sub continuousOn_const)
      (fun w hw => sub_ne_zero.mpr (h1 w hw))
  exact ((xi_log_derivative_continuousOn S hx).sub hc0 |>.sub hc1).congr
    (fun w hw => completed_log_derivative_corrections w (h0 w hw) (h1 w hw) (hx w hw))

theorem weighted_completed_circle_integrable (F : ℂ → ℂ) (hF : Continuous F)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R)
    (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : ∀ w ∈ sphere c R, w ≠ 0) (h1 : ∀ w ∈ sphere c R, w ≠ 1) :
    CircleIntegrable (fun w => F w * logDeriv completedRiemannZeta w) c R :=
  (hF.continuousOn.mul (completed_log_derivative_continuousOn _ hx h0 h1)).circleIntegrable hR

set_option maxHeartbeats 500000 in
theorem weighted_completed_circle_corrections (F : ℂ → ℂ) (hF : Continuous F)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R)
    (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : ∀ w ∈ sphere c R, w ≠ 0) (h1 : ∀ w ∈ sphere c R, w ≠ 1) :
    (∮ w in C(c, R), F w * logDeriv completedRiemannZeta w) =
      (∮ w in C(c, R), F w * logDeriv xi w) -
        (∮ w in C(c, R), F w / w) - (∮ w in C(c, R), F w / (w - 1)) := by
  have hcx : CircleIntegrable (fun w => F w * logDeriv xi w) c R :=
    (hF.continuousOn.mul (xi_log_derivative_continuousOn _ hx)).circleIntegrable hR
  have hc0 : CircleIntegrable (fun w => F w / w) c R :=
    (hF.continuousOn.div continuousOn_id h0).circleIntegrable hR
  have hc1 : CircleIntegrable (fun w => F w / (w - 1)) c R :=
    (hF.continuousOn.div (continuousOn_id.sub continuousOn_const)
      (fun w hw => sub_ne_zero.mpr (h1 w hw))).circleIntegrable hR
  have he : EqOn (fun w => F w * logDeriv completedRiemannZeta w)
      (fun w => (F w * logDeriv xi w - F w / w) - F w / (w - 1)) (sphere c R) := by
    intro w hw
    dsimp only
    rw [completed_log_derivative_corrections w (h0 w hw) (h1 w hw) (hx w hw)]
    ring
  have hcpartial : CircleIntegrable (fun w => F w * logDeriv xi w - F w / w) c R :=
    hcx.sub hc0
  rw [circleIntegral.integral_congr hR he]
  calc
    (∮ w in C(c, R), (F w * logDeriv xi w - F w / w) - F w / (w - 1)) =
        (∮ w in C(c, R), F w * logDeriv xi w - F w / w) -
          (∮ w in C(c, R), F w / (w - 1)) := circleIntegral.integral_sub hcpartial hc1
    _ = _ := by rw [circleIntegral.integral_sub hcx hc0]

theorem entire_completed_circle_corrections (F : ℂ → ℂ) (hF : Differentiable ℂ F)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), F w * logDeriv completedRiemannZeta w) =
      (∮ w in C(c, R), F w * logDeriv xi w) -
        (2 * Real.pi * Complex.I) * (F 0 + F 1) := by
  rw [weighted_completed_circle_corrections F hF.continuous c R hR hx
    (boundary_excludes_interior c 0 R h0) (boundary_excludes_interior c 1 R h1)]
  have hi0 := entire_weight_circle_coefficient F hF c 0 R h0
  have hi1 := entire_weight_circle_coefficient F hF c 1 R h1
  simp only [sub_zero] at hi0
  rw [hi0, hi1]
  ring

theorem pole_null_completed_circle {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
      logDeriv completedRiemannZeta w) =
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
      logDeriv xi w) := by
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight f g) :=
    centered_weight_entire hf hg hfc hgc
  obtain ⟨hz0, hz1⟩ := BuildingBlocks.ActualPhysicalResidues.centered_weight_pole_null (g := g) hm hp
  simpa only [hz0, hz1, zero_add, mul_zero, sub_zero] using
    entire_completed_circle_corrections _ hF c R hR hx h0 h1

theorem finite_block_pole_null_completed_circle {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (hR : 0 ≤ R) (hx : ∀ w ∈ sphere c R, xi w ≠ 0)
    (h0 : (0 : ℂ) ∈ ball c R) (h1 : (1 : ℂ) ∈ ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
        logDeriv completedRiemannZeta w) =
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w * logDeriv xi w) := by
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g)) :=
    finite_block_centered_weight_entire hf hg hfc hgc primes.toList M
  obtain ⟨hz0, hz1⟩ := BuildingBlocks.ActualPhysicalResidues.finite_block_pole_null
    (g := g) hf hfc primes hp M hm hplus
  simpa only [hz0, hz1, zero_add, mul_zero, sub_zero] using
    entire_completed_circle_corrections _ hF c R hR hx h0 h1

#print axioms completed_log_derivative_corrections
#print axioms completed_log_derivative_continuousOn
#print axioms weighted_completed_circle_integrable
#print axioms xi_log_derivative_continuousOn
#print axioms boundary_excludes_interior
#print axioms weighted_completed_circle_corrections
#print axioms entire_completed_circle_corrections
#print axioms pole_null_completed_circle
#print axioms finite_block_pole_null_completed_circle

end BuildingBlocks.CompletedZetaPoleCorrections
