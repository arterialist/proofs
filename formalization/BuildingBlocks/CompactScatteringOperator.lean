import BuildingBlocks.CompactScatteringCoefficients
import BuildingBlocks.NarrowPoleNullPacket
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
open scoped ContDiff

/-! Literal finite translation operator and its finitely supported coefficients.
RH Proof formalization. No source-sign or RH assumption. -/
namespace BuildingBlocks.CompactScatteringOperator
open BuildingBlocks.CompactScatteringPackets
open BuildingBlocks.CompactScatteringCoefficients

noncomputable def packet (L : ℝ) (eta : ℝ → ℂ) : (ℤ →₀ ℂ) →ₗ[ℂ] (ℝ → ℂ) :=
  Finsupp.linearCombination ℂ (fun j v => eta (v - (j : ℝ) * L))

noncomputable def translateCoefficients (d : ℤ) (c : ℤ →₀ ℂ) : ℤ →₀ ℂ :=
  Finsupp.mapDomain (fun j => j + d) c

noncomputable def historyCoefficients (r : ℝ) (M : ℕ) (c : ℤ →₀ ℂ) : ℤ →₀ ℂ :=
  (-(r : ℂ)) • translateCoefficients 1 c + (1 - (r : ℂ) ^ 2) •
    ∑ m ∈ Finset.range M, (r : ℂ) ^ m • translateCoefficients (-(m : ℤ)) c

noncomputable def historyPhysical (r : ℝ) (M : ℕ) (L : ℝ) (f : ℝ → ℂ) (v : ℝ) : ℂ :=
  -(r : ℂ) * f (v - L) + (1 - (r : ℂ) ^ 2) *
    ∑ m ∈ Finset.range M, (r : ℂ) ^ m * f (v + (m : ℝ) * L)

theorem packet_apply (L : ℝ) (eta : ℝ → ℂ) (c : ℤ →₀ ℂ) (v : ℝ) :
    packet L eta c v = ∑ j ∈ c.support, c j * eta (v - (j : ℝ) * L) := by
  simp [packet, Finsupp.linearCombination_apply, Finsupp.sum, smul_eq_mul]

theorem translateCoefficients_apply (d k : ℤ) (c : ℤ →₀ ℂ) :
    translateCoefficients d c k = c (k - d) := by
  have h := Finsupp.mapDomain_apply (show Function.Injective (fun j : ℤ => j + d) by
    intro i j hij; exact add_right_cancel hij) c (k - d)
  simpa [translateCoefficients] using h

theorem historyCoefficients_apply (r : ℝ) (M : ℕ) (c : ℤ →₀ ℂ) (k : ℤ) :
    historyCoefficients r M c k = historyCoefficient r M c k := by
  simp [historyCoefficients, historyCoefficient, translateCoefficients_apply,
    smul_eq_mul]

theorem packet_translate (L : ℝ) (eta : ℝ → ℂ) (d : ℤ) (c : ℤ →₀ ℂ) (v : ℝ) :
    packet L eta (translateCoefficients d c) v = packet L eta c (v - (d : ℝ) * L) := by
  simp only [packet_apply]
  change (Finsupp.mapDomain (fun j => j + d) c).sum
      (fun j a => a * eta (v - (j : ℝ) * L)) =
    c.sum (fun j a => a * eta ((v - (d : ℝ) * L) - (j : ℝ) * L))
  rw [Finsupp.sum_mapDomain_index (fun j => by simp) (fun j a b => by ring)]
  apply Finsupp.sum_congr
  intro j hj
  congr 2
  push_cast
  ring

theorem history_packet (r : ℝ) (M : ℕ) (L : ℝ) (eta : ℝ → ℂ)
    (c : ℤ →₀ ℂ) (v : ℝ) :
    historyPhysical r M L (packet L eta c) v =
      packet L eta (historyCoefficients r M c) v := by
  unfold historyCoefficients
  simp only [map_add, map_smul, map_sum, Pi.add_apply, Pi.smul_apply,
    Finset.sum_apply, smul_eq_mul]
  simp_rw [packet_translate]
  simp [historyPhysical, Int.cast_neg, Int.cast_natCast]

theorem packet_physical_square {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (c : ℤ →₀ ℂ) :
    physicalSquare (packet L eta c) =
      (∑ j ∈ c.support, Complex.normSq (c j)) * physicalSquare eta := by
  have he : packet L eta c = fun v => ∑ j ∈ c.support, c j * eta (v - (j : ℝ) * L) := by
    funext v
    exact packet_apply L eta c v
  rw [he]
  exact physical_translate_sum_square hL hw hs heta c.support c

theorem history_packet_physical_square {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (r : ℝ) (M : ℕ) (c : ℤ →₀ ℂ) :
    physicalSquare (historyPhysical r M L (packet L eta c)) =
      (∑ j ∈ (historyCoefficients r M c).support,
        Complex.normSq (historyCoefficients r M c j)) * physicalSquare eta := by
  have he : historyPhysical r M L (packet L eta c) =
      packet L eta (historyCoefficients r M c) := by
    funext v
    exact history_packet r M L eta c v
  rw [he]
  exact packet_physical_square hL hw hs heta _

noncomputable def boxCoefficients (q : ℂ) (J : ℕ) : ℤ →₀ ℂ := by
  classical
  exact Finsupp.onFinset (Finset.Ico (0 : ℤ) (J : ℤ)) (box q J) (by
    intro k hk
    by_contra h
    have hz : box q J k = 0 := by
      simp only [Finset.mem_Ico] at h
      simp [box, h]
    exact hk hz)

theorem boxCoefficients_apply (q : ℂ) (J : ℕ) (k : ℤ) :
    boxCoefficients q J k = box q J k := by
  classical
  exact Finsupp.onFinset_apply

theorem boxCoefficients_support (q : ℂ) (hq : q ≠ 0) (J : ℕ) :
    (boxCoefficients q J).support = Finset.Ico (0 : ℤ) (J : ℤ) := by
  classical
  ext k
  simp only [Finsupp.mem_support_iff, boxCoefficients_apply, Finset.mem_Ico]
  by_cases hk : 0 ≤ k ∧ k < (J : ℤ)
  · simp [box, hk, zpow_ne_zero _ hq]
  · simp [box, hk]

theorem phase_box_square (theta : ℝ) (J : ℕ) :
    (∑ k ∈ (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J).support,
      Complex.normSq (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J k)) =
        (J : ℝ) := by
  classical
  have hq : BuildingBlocks.CompactLocalScatteringSigns.phase theta ≠ 0 := by
    intro h
    have hn := BuildingBlocks.CompactLocalScatteringSigns.phase_normSq theta
    simp [h] at hn
  rw [boxCoefficients_support _ hq]
  have he : (∑ k ∈ Finset.Ico (0 : ℤ) (J : ℤ),
      Complex.normSq (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J k)) =
        ∑ k ∈ Finset.Ico (0 : ℤ) (J : ℤ), (1 : ℝ) := by
    apply Finset.sum_congr rfl
    intro k hk
    rw [boxCoefficients_apply, box_inside _ J k (Finset.mem_Ico.mp hk).1
      (Finset.mem_Ico.mp hk).2, phase_zpow_normSq]
  rw [he]
  simp

theorem phase_box_history_normSq (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    Complex.normSq (historyCoefficients r M
      (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J) k) =
        Complex.normSq (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M) := by
  rw [historyCoefficients_apply]
  have hc : (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J : ℤ → ℂ) =
      box (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J := by
    funext j
    exact boxCoefficients_apply _ J j
  rw [hc]
  exact history_phase_box_normSq r theta J M k hk hbulk

theorem phase_box_history_bulk_bound (r theta : ℝ) (J M : ℕ) (hMJ : M < J)
    (hG : 0 < Complex.normSq (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M)) :
    (J - M : ℝ) * Complex.normSq (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M) ≤
      ∑ k ∈ (historyCoefficients r M
        (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J)).support,
          Complex.normSq (historyCoefficients r M
            (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J) k) := by
  classical
  let c := historyCoefficients r M
    (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J)
  let t := Finset.Icc (1 : ℤ) ((J : ℤ) - (M : ℤ))
  have hb : ∀ k ∈ t, Complex.normSq (c k) =
      Complex.normSq (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M) := by
    intro k hk
    exact phase_box_history_normSq r theta J M k (Finset.mem_Icc.mp hk).1
      (Finset.mem_Icc.mp hk).2
  have hsub : t ⊆ c.support := by
    intro k hk
    apply Finsupp.mem_support_iff.mpr
    intro hz
    have he := hb k hk
    simp [hz] at he
    linarith
  have hcard : t.card = J - M := by
    dsimp [t]
    simp only [Int.card_Icc]
    omega
  have he : (∑ k ∈ t, Complex.normSq (c k)) =
      (J - M : ℝ) * Complex.normSq
        (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M) := by
    calc
      _ = ∑ k ∈ t, Complex.normSq
          (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M) :=
        Finset.sum_congr rfl hb
      _ = _ := by simp [hcard, Nat.cast_sub hMJ.le]
  rw [← he]
  exact Finset.sum_le_sum_of_subset_of_nonneg hsub (fun k hk hkt => Complex.normSq_nonneg (c k))

theorem exists_amplifying_phase_packet {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (hmass : 0 < physicalSquare eta) (r theta : ℝ) (M : ℕ)
    (hG : 1 < Complex.normSq (BuildingBlocks.CompactLocalScatteringSigns.compactPhase r theta M)) :
    ∃ J : ℕ, M < J ∧
      physicalSquare (packet L eta
        (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J)) <
      physicalSquare (historyPhysical r M L (packet L eta
        (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase theta) J))) := by
  obtain ⟨J, hMJ, hgain⟩ := exists_finite_bulk_gain M hG
  refine ⟨J, hMJ, ?_⟩
  rw [packet_physical_square hL hw hs heta, phase_box_square,
    history_packet_physical_square hL hw hs heta]
  have hb := phase_box_history_bulk_bound r theta J M hMJ (by linarith)
  exact mul_lt_mul_of_pos_right (hgain.trans_le hb) hmass

theorem exists_prime_amplifying_packet {eta : ℝ → ℂ} {a b : ℝ}
    (p : ℕ) (hp : p.Prime) (hw : b - a ≤ Real.log (p : ℝ))
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (hmass : 0 < physicalSquare eta) (M : ℕ) (hM : 1 ≤ M) :
    ∃ J : ℕ, M < J ∧
      physicalSquare (packet (Real.log (p : ℝ)) eta
        (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase (Real.pi / (M : ℝ))) J)) <
      physicalSquare (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ))
        (packet (Real.log (p : ℝ)) eta
          (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase (Real.pi / (M : ℝ))) J))) := by
  apply exists_amplifying_phase_packet (Real.log_pos (by exact_mod_cast hp.one_lt)) hw hs heta hmass
  exact (BuildingBlocks.CompactLocalScatteringSigns.actual_prime_compact_signs p hp hM).2

theorem exists_prime_amplifying_narrow_carrier (p : ℕ) (hp : p.Prime)
    (M : ℕ) (hM : 1 ≤ M) :
    ∃ eta : ℝ → ℂ, HasCompactSupport eta ∧ ContDiff ℝ ∞ eta ∧ eta 0 = 1 ∧
      BuildingBlocks.NarrowPoleNullPacket.complexMoment eta (1 / 2) = 0 ∧
      BuildingBlocks.NarrowPoleNullPacket.complexMoment eta (-(1 / 2)) = 0 ∧
      ∃ J : ℕ, M < J ∧
        physicalSquare (packet (Real.log (p : ℝ)) eta
          (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase (Real.pi / (M : ℝ))) J)) <
        physicalSquare (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ))
          (packet (Real.log (p : ℝ)) eta
            (boxCoefficients (BuildingBlocks.CompactLocalScatteringSigns.phase (Real.pi / (M : ℝ))) J))) := by
  have hL : 0 < Real.log (p : ℝ) := Real.log_pos (by exact_mod_cast hp.one_lt)
  obtain ⟨eta, hc, hd, h0, hs, hi, hm, hplus, hminus⟩ :=
    BuildingBlocks.NarrowPoleNullPacket.exists_narrow_complex_pole_null hL
  refine ⟨eta, hc, hd, h0, hplus, hminus, ?_⟩
  exact exists_prime_amplifying_packet p hp (by linarith) hs hi hm M hM

#print axioms exists_prime_amplifying_narrow_carrier
#print axioms exists_prime_amplifying_packet
#print axioms phase_box_history_normSq
#print axioms phase_box_history_bulk_bound
#print axioms exists_amplifying_phase_packet
#print axioms boxCoefficients_apply
#print axioms boxCoefficients_support
#print axioms phase_box_square
#print axioms packet_apply
#print axioms translateCoefficients_apply
#print axioms historyCoefficients_apply
#print axioms packet_translate
#print axioms history_packet
#print axioms packet_physical_square
#print axioms history_packet_physical_square
end BuildingBlocks.CompactScatteringOperator
