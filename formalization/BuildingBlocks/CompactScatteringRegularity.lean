import BuildingBlocks.CompactScatteringOperator

open scoped ContDiff
open MeasureTheory
namespace BuildingBlocks.CompactScatteringRegularity
open BuildingBlocks.CompactScatteringOperator BuildingBlocks.NarrowPoleNullPacket

theorem shifted_compact {eta : ℝ → ℂ} (hc : HasCompactSupport eta) (d : ℝ) :
    HasCompactSupport (fun v => eta (v - d)) := by
  simpa [Function.comp_def, sub_eq_add_neg] using
    hc.comp_homeomorph (Homeomorph.addRight (-d))

theorem packet_contDiff {eta : ℝ → ℂ} (hd : ContDiff ℝ ∞ eta)
    (L : ℝ) (c : ℤ →₀ ℂ) : ContDiff ℝ ∞ (packet L eta c) := by
  have he : packet L eta c = fun v => ∑ j ∈ c.support, c j * eta (v - (j : ℝ) * L) :=
    funext (packet_apply L eta c)
  rw [he]
  exact ContDiff.sum (fun j _ => contDiff_const.mul
    (hd.comp (contDiff_id.sub contDiff_const)))

theorem packet_compact {eta : ℝ → ℂ} (hc : HasCompactSupport eta)
    (L : ℝ) (c : ℤ →₀ ℂ) : HasCompactSupport (packet L eta c) := by
  have he : packet L eta c = ∑ j ∈ c.support, (fun v => c j * eta (v - (j : ℝ) * L)) := by
    funext v
    simp only [Finset.sum_apply, packet_apply]
  rw [he]
  have hf : ∀ t : Finset ℤ, HasCompactSupport
      (∑ j ∈ t, (fun v => c j * eta (v - (j : ℝ) * L))) := by
    intro t
    induction t using Finset.induction_on with
    | empty => simpa using (HasCompactSupport.zero : HasCompactSupport (0 : ℝ → ℂ))
    | @insert j t hj ht =>
      rw [Finset.sum_insert hj]
      exact ((shifted_compact hc _).mul_left).add ht
  exact hf _

theorem weighted_integrable {eta : ℝ → ℂ} (hh : Continuous eta)
    (hc : HasCompactSupport eta) (s : ℝ) :
    Integrable (fun v => eta v * Complex.exp ((s : ℂ) * (v : ℂ))) := by
  have hw : Continuous (fun v : ℝ => Complex.exp ((s : ℂ) * (v : ℂ))) := by fun_prop
  exact (hh.mul hw).integrable_of_hasCompactSupport hc.mul_right

theorem complexMoment_translate (eta : ℝ → ℂ) (s d : ℝ) :
    complexMoment (fun v => eta (v - d)) s =
      complexMoment eta s * Complex.exp ((s : ℂ) * (d : ℂ)) := by
  unfold complexMoment
  calc
    _ = ∫ v : ℝ, (eta (v - d) * Complex.exp ((s : ℂ) * ((v - d : ℝ) : ℂ))) *
        Complex.exp ((s : ℂ) * (d : ℂ)) := by
      apply integral_congr_ae
      filter_upwards [] with v
      rw [mul_assoc, ← Complex.exp_add]
      congr 2
      push_cast
      ring
    _ = (∫ v : ℝ, eta (v - d) * Complex.exp ((s : ℂ) * ((v - d : ℝ) : ℂ))) *
        Complex.exp ((s : ℂ) * (d : ℂ)) := integral_mul_const _ _
    _ = _ := by
      congr 1
      exact integral_sub_right_eq_self
        (fun v : ℝ => eta v * Complex.exp ((s : ℂ) * (v : ℂ))) d

theorem packet_moment_zero {eta : ℝ → ℂ} (hh : Continuous eta)
    (hc : HasCompactSupport eta) (s : ℝ) (hm : complexMoment eta s = 0)
    (L : ℝ) (c : ℤ →₀ ℂ) : complexMoment (packet L eta c) s = 0 := by
  unfold complexMoment
  simp_rw [packet_apply, Finset.sum_mul]
  rw [integral_finset_sum]
  · have hz : ∀ j : ℤ, (∫ v : ℝ, c j * eta (v - (j : ℝ) * L) *
        Complex.exp ((s : ℂ) * (v : ℂ))) = 0 := by
      intro j
      simp_rw [mul_assoc]
      rw [integral_const_mul]
      change c j * complexMoment (fun v => eta (v - (j : ℝ) * L)) s = 0
      rw [complexMoment_translate, hm, zero_mul, mul_zero]
    simp only [hz, Finset.sum_const_zero]
  · intro j _
    simpa only [mul_assoc] using
      (weighted_integrable (hh.comp (continuous_id.sub continuous_const))
        (shifted_compact hc _) s).const_mul (c j)

theorem exists_prime_smooth_pole_null_amplification (p : ℕ) (hp : p.Prime)
    (M : ℕ) (hM : 1 ≤ M) :
    ∃ f : ℝ → ℂ, HasCompactSupport f ∧ ContDiff ℝ ∞ f ∧
      complexMoment f (1 / 2) = 0 ∧ complexMoment f (-(1 / 2)) = 0 ∧
      BuildingBlocks.CompactScatteringPackets.physicalSquare f <
        BuildingBlocks.CompactScatteringPackets.physicalSquare
          (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) := by
  obtain ⟨eta, hc, hd, h0, hplus, hminus, J, hMJ, hgain⟩ :=
    exists_prime_amplifying_narrow_carrier p hp M hM
  let c := boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase
    (Real.pi / (M : ℝ))) J
  refine ⟨packet (Real.log (p : ℝ)) eta c, packet_compact hc _ _,
    packet_contDiff hd _ _, packet_moment_zero hd.continuous hc _ hplus _ _,
    packet_moment_zero hd.continuous hc _ hminus _ _, hgain⟩

#print axioms exists_prime_smooth_pole_null_amplification
#print axioms shifted_compact
#print axioms packet_contDiff
#print axioms packet_compact
#print axioms weighted_integrable
#print axioms complexMoment_translate
#print axioms packet_moment_zero
end BuildingBlocks.CompactScatteringRegularity
