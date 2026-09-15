import BuildingBlocks.CompactScatteringRegularity
import BuildingBlocks.GrowingPrimeScatteringBounds
import BuildingBlocks.PrimeBlockSource

open MeasureTheory
open scoped ContDiff

namespace BuildingBlocks.FullComplexHistoryMellin
open BuildingBlocks
open BuildingBlocks.CompactScatteringOperator

noncomputable def mellin (f : ℝ → ℂ) (z : ℂ) : ℂ :=
  ∫ v : ℝ, f v * Complex.exp (z * (v : ℂ))

theorem weighted_integrable {f : ℝ → ℂ} (hh : Continuous f)
    (hc : HasCompactSupport f) (z : ℂ) :
    Integrable (fun v => f v * Complex.exp (z * (v : ℂ))) := by
  have hw : Continuous (fun v : ℝ => Complex.exp (z * (v : ℂ))) := by fun_prop
  exact (hh.mul hw).integrable_of_hasCompactSupport hc.mul_right

theorem mellin_translate (f : ℝ → ℂ) (z : ℂ) (d : ℝ) :
    mellin (fun v => f (v - d)) z = mellin f z * Complex.exp (z * (d : ℂ)) := by
  unfold mellin
  calc
    _ = ∫ v : ℝ, (f (v - d) * Complex.exp (z * ((v - d : ℝ) : ℂ))) *
        Complex.exp (z * (d : ℂ)) := by
      apply integral_congr_ae
      filter_upwards [] with v
      rw [mul_assoc, ← Complex.exp_add]
      congr 2
      push_cast
      ring
    _ = (∫ v : ℝ, f (v - d) * Complex.exp (z * ((v - d : ℝ) : ℂ))) *
        Complex.exp (z * (d : ℂ)) := integral_mul_const _ _
    _ = _ := by
      congr 1
      exact integral_sub_right_eq_self (fun v : ℝ => f v * Complex.exp (z * (v : ℂ))) d

theorem finite_translate_compact {ι : Type*} (s : Finset ι) (c : ι → ℂ)
    (d : ι → ℝ) {f : ℝ → ℂ} (hc : HasCompactSupport f) :
    HasCompactSupport (fun v => ∑ i ∈ s, c i * f (v - d i)) := by
  classical
  have he : (fun v => ∑ i ∈ s, c i * f (v - d i)) =
      ∑ i ∈ s, (fun v => c i * f (v - d i)) := by
    funext v
    simp only [Finset.sum_apply]
  rw [he]
  clear he
  induction s using Finset.induction_on with
  | empty => simpa using (HasCompactSupport.zero : HasCompactSupport (0 : ℝ → ℂ))
  | @insert i s hi ih =>
    rw [Finset.sum_insert hi]
    exact ((BuildingBlocks.CompactScatteringRegularity.shifted_compact hc _).mul_left).add ih

theorem finite_translate_mellin {ι : Type*} (s : Finset ι) (c : ι → ℂ)
    (d : ι → ℝ) {f : ℝ → ℂ} (hh : Continuous f) (hc : HasCompactSupport f) (z : ℂ) :
    mellin (fun v => ∑ i ∈ s, c i * f (v - d i)) z =
      (∑ i ∈ s, c i * Complex.exp (z * (d i : ℂ))) * mellin f z := by
  unfold mellin
  simp_rw [Finset.sum_mul]
  rw [integral_finset_sum]
  · calc
      _ = ∑ i ∈ s, (c i * Complex.exp (z * (d i : ℂ))) * mellin f z := by
        apply Finset.sum_congr rfl
        intro i _
        simp_rw [mul_assoc]
        rw [integral_const_mul]
        change c i * mellin (fun v => f (v - d i)) z = _
        rw [mellin_translate]
        ring
      _ = _ := by simp only [mellin]
  · intro i _
    simpa only [mul_assoc] using
      (weighted_integrable (hh.comp (continuous_id.sub continuous_const))
        (BuildingBlocks.CompactScatteringRegularity.shifted_compact hc _) z).const_mul (c i)

theorem mellin_const_mul (a : ℂ) (f : ℝ → ℂ) (z : ℂ) :
    mellin (fun v => a * f v) z = a * mellin f z := by
  unfold mellin
  simp_rw [mul_assoc]
  exact integral_const_mul _ _

theorem mellin_add {f g : ℝ → ℂ} (hf : Continuous f) (hg : Continuous g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) (z : ℂ) :
    mellin (fun v => f v + g v) z = mellin f z + mellin g z := by
  unfold mellin
  simp_rw [add_mul]
  exact integral_add (weighted_integrable hf hfc z) (weighted_integrable hg hgc z)

theorem history_regular {f : ℝ → ℂ} (hh : Continuous f) (hc : HasCompactSupport f)
    (r L : ℝ) (M : ℕ) :
    Continuous (historyPhysical r M L f) ∧ HasCompactSupport (historyPhysical r M L f) := by
  have hsum := finite_translate_compact (Finset.range M) (fun m => (r : ℂ) ^ m)
    (fun m => -(m : ℝ) * L) hc
  simp only [neg_mul, sub_neg_eq_add] at hsum
  have ha : HasCompactSupport (fun v => -(r : ℂ) * f (v - L)) :=
    (BuildingBlocks.CompactScatteringRegularity.shifted_compact hc L).mul_left
  have hb : HasCompactSupport (fun v => (1 - (r : ℂ) ^ 2) *
      ∑ m ∈ Finset.range M, (r : ℂ) ^ m * f (v + (m : ℝ) * L)) := hsum.mul_left
  constructor
  · unfold historyPhysical
    fun_prop
  · exact ha.add hb

theorem history_mellin {f : ℝ → ℂ} (hh : Continuous f) (hc : HasCompactSupport f)
    (r L : ℝ) (M : ℕ) (z : ℂ) :
    mellin (historyPhysical r M L f) z =
      BuildingBlocks.PairedScatteringDefect.multiplier (r : ℂ)
        (Complex.exp (z * L)) (Complex.exp (-(z * L))) M * mellin f z := by
  let g : ℝ → ℂ := fun v => ∑ m ∈ Finset.range M, (r : ℂ) ^ m * f (v - (-(m : ℝ) * L))
  have hg : Continuous g := by dsimp [g]; fun_prop
  have hgc : HasCompactSupport g :=
    finite_translate_compact (Finset.range M) (fun m => (r : ℂ) ^ m) (fun m => -(m : ℝ) * L) hc
  have he : historyPhysical r M L f =
      fun v => -(r : ℂ) * f (v - L) + (1 - (r : ℂ) ^ 2) * g v := by
    funext v
    simp only [historyPhysical, g, neg_mul, sub_neg_eq_add]
  have hleft : Continuous (fun v => -(r : ℂ) * f (v - L)) := by fun_prop
  have hright : Continuous (fun v => (1 - (r : ℂ) ^ 2) * g v) := by fun_prop
  have hleftc : HasCompactSupport (fun v => -(r : ℂ) * f (v - L)) :=
    (BuildingBlocks.CompactScatteringRegularity.shifted_compact hc L).mul_left
  have hrightc : HasCompactSupport (fun v => (1 - (r : ℂ) ^ 2) * g v) := hgc.mul_left
  rw [he, mellin_add hleft hright hleftc hrightc z,
    mellin_const_mul, mellin_const_mul, mellin_translate]
  have hgm := finite_translate_mellin (Finset.range M) (fun m => (r : ℂ) ^ m)
    (fun m => -(m : ℝ) * L) hh hc z
  change mellin g z = _ at hgm
  rw [hgm]
  have hex (m : ℕ) : Complex.exp (z * ((-(m : ℝ) * L : ℝ) : ℂ)) =
      Complex.exp (-(z * L)) ^ m := by
    rw [← Complex.exp_nat_mul]
    congr 1
    push_cast
    ring
  simp_rw [hex, ← mul_pow]
  unfold BuildingBlocks.PairedScatteringDefect.multiplier
  ring

theorem actual_history_mellin (p : ℕ) (hp : 2 ≤ p) {f : ℝ → ℂ}
    (hh : Continuous f) (hc : HasCompactSupport f) (M : ℕ) (z : ℂ) :
    mellin (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) z =
      GrowingPrimeScatteringBounds.originalHistory (p : ℝ) z M * mellin f z := by
  have hp0 : (0 : ℝ) < p := by exact_mod_cast (show 0 < p by omega)
  rw [history_mellin hh hc, GrowingPrimeScatteringBounds.full_history_dictionary hp0]

noncomputable def pairedWeight (f g : ℝ → ℂ) (z : ℂ) : ℂ :=
  mellin f z * (starRingEnd ℂ) (mellin g (-((starRingEnd ℂ) z)))

theorem original_history_conjugate {p : ℝ} (hp : 0 < p) (z : ℂ) (M : ℕ) :
    (starRingEnd ℂ) (GrowingPrimeScatteringBounds.originalHistory p z M) =
      GrowingPrimeScatteringBounds.originalHistory p ((starRingEnd ℂ) z) M := by
  rw [GrowingPrimeScatteringBounds.full_history_dictionary hp,
    GrowingPrimeScatteringBounds.full_history_dictionary hp]
  simp [BuildingBlocks.PairedScatteringDefect.multiplier, ← Complex.exp_conj]

theorem actual_history_paired_weight (p : ℕ) (hp : 2 ≤ p) {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (M : ℕ) (z : ℂ) :
    pairedWeight
      (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f)
      (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) g) z =
      GrowingPrimeScatteringBounds.paired p z M * pairedWeight f g z := by
  have hp0 : (0 : ℝ) < p := by exact_mod_cast (show 0 < p by omega)
  have hconj : (starRingEnd ℂ) (GrowingPrimeScatteringBounds.originalHistory
      (p : ℝ) (-((starRingEnd ℂ) z)) M) =
      GrowingPrimeScatteringBounds.originalHistory (p : ℝ) (-z) M := by
    rw [original_history_conjugate hp0]
    simp
  unfold pairedWeight
  rw [actual_history_mellin p hp hf hfc, actual_history_mellin p hp hg hgc,
    map_mul, hconj, GrowingPrimeScatteringBounds.actual_paired_original_dictionary p hp]
  ring

noncomputable def blockPhysical (ps : List ℕ) (M : ℕ) (f : ℝ → ℂ) : ℝ → ℂ :=
  match ps with
  | [] => f
  | p :: qs => historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) (blockPhysical qs M f)

theorem block_regular {f : ℝ → ℂ} (hh : Continuous f) (hc : HasCompactSupport f)
    (ps : List ℕ) (M : ℕ) : Continuous (blockPhysical ps M f) ∧
      HasCompactSupport (blockPhysical ps M f) := by
  induction ps with
  | nil => exact ⟨hh, hc⟩
  | cons p qs ih => exact history_regular ih.1 ih.2 _ _ _

theorem block_mellin {f : ℝ → ℂ} (hh : Continuous f) (hc : HasCompactSupport f)
    (ps : List ℕ) (hs : ∀ p ∈ ps, 2 ≤ p) (M : ℕ) (z : ℂ) :
    mellin (blockPhysical ps M f) z =
      (ps.map (fun p : ℕ => GrowingPrimeScatteringBounds.originalHistory (p : ℝ) z M)).prod * mellin f z := by
  induction ps with
  | nil => simp [blockPhysical]
  | cons p qs ih =>
    have hqs : ∀ q ∈ qs, 2 ≤ q := fun q hq => hs q (by simp [hq])
    have hr := block_regular hh hc qs M
    rw [blockPhysical, actual_history_mellin p (hs p (by simp)) hr.1 hr.2,
      ih hqs]
    simp only [List.map_cons, List.prod_cons]
    ring

theorem block_paired_weight {f g : ℝ → ℂ} (hf : Continuous f) (hg : Continuous g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g)
    (ps : List ℕ) (hs : ∀ p ∈ ps, 2 ≤ p) (M : ℕ) (z : ℂ) :
    pairedWeight (blockPhysical ps M f) (blockPhysical ps M g) z =
      (ps.map (fun p => GrowingPrimeScatteringBounds.paired p z M)).prod * pairedWeight f g z := by
  induction ps with
  | nil => simp [blockPhysical]
  | cons p qs ih =>
    have hqs : ∀ q ∈ qs, 2 ≤ q := fun q hq => hs q (by simp [hq])
    have hfr := block_regular hf hfc qs M
    have hgr := block_regular hg hgc qs M
    rw [blockPhysical, blockPhysical,
      actual_history_paired_weight p (hs p (by simp)) hfr.1 hgr.1 hfr.2 hgr.2,
      ih hqs]
    simp only [List.map_cons, List.prod_cons]
    ring

theorem finite_prime_block_paired_weight {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p) (M : ℕ) (z : ℂ) :
    pairedWeight (blockPhysical s.toList M f) (blockPhysical s.toList M g) z =
      (∏ p ∈ s, GrowingPrimeScatteringBounds.paired p z M) * pairedWeight f g z := by
  rw [block_paired_weight hf hg hfc hgc s.toList (by simpa using hs), Finset.prod_map_toList]

theorem physical_block_readout_bound {ι : Type*} {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p)
    (M : ℕ) (z : ι → ℂ) (hz : ∀ i, |(z i).re| ≤ 1 / 2)
    (hw : Summable (fun i => ‖pairedWeight f g (z i)‖)) :
    ‖(∑' i, pairedWeight (blockPhysical s.toList M f) (blockPhysical s.toList M g) (z i)) -
        (∑' i, pairedWeight f g (z i))‖ ≤
      ((3 : ℝ) ^ s.card + 1) * ∑' i, ‖pairedWeight f g (z i)‖ := by
  simp_rw [finite_prime_block_paired_weight hf hg hfc hgc s hs M]
  exact GrowingPrimeScatteringBounds.actual_block_weighted_tsum_comparison
    s hs z (fun i => pairedWeight f g (z i)) hz M hw

theorem physical_block_low_high_bound {ι : Type*} {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p)
    (P : ℝ) (hP : 1 < P) (hPs : ∀ p ∈ s, P ≤ p) (M : ℕ)
    (z : ι → ℂ) (hz : ∀ i, |(z i).re| ≤ 1 / 2)
    (hw : Summable (fun i => ‖pairedWeight f g (z i)‖)) (low : Set ι)
    (delta : ℝ) (hd : 0 < delta)
    (hlow : ∀ i ∈ low, |(z i).re| ≤ 1 / 2 - delta) :
    let B := Real.exp (-(M : ℝ) * (delta * Real.log P)) *
      ((1 + delta * Real.log P) / (delta * Real.log P))
    ‖(∑' i, pairedWeight (blockPhysical s.toList M f) (blockPhysical s.toList M g) (z i)) -
        (∑' i, pairedWeight f g (z i))‖ ≤
      (Real.exp ((s.card : ℝ) * (2 * B + B ^ 2)) - 1) * (∑' i : low, ‖pairedWeight f g (z i)‖) +
        ((3 : ℝ) ^ s.card + 1) * (∑' i : ↑(lowᶜ), ‖pairedWeight f g (z i)‖) := by
  dsimp only
  simp_rw [finite_prime_block_paired_weight hf hg hfc hgc s hs M]
  apply GrowingPrimeScatteringBounds.actual_block_low_high_comparison
    s hs z (fun i => pairedWeight f g (z i)) hz M hw low
  intro i hi
  exact GrowingPrimeScatteringBounds.actual_uniform_block_comparison
    s hs P hP hPs (z i) M delta hd (hlow i hi)

#print axioms physical_block_readout_bound
#print axioms physical_block_low_high_bound
#print axioms block_regular
#print axioms block_mellin
#print axioms block_paired_weight
#print axioms finite_prime_block_paired_weight
#print axioms original_history_conjugate
#print axioms actual_history_paired_weight
#print axioms mellin_const_mul
#print axioms mellin_add
#print axioms history_regular
#print axioms history_mellin
#print axioms actual_history_mellin
#print axioms weighted_integrable
#print axioms mellin_translate
#print axioms finite_translate_compact
#print axioms finite_translate_mellin
end BuildingBlocks.FullComplexHistoryMellin
