import BuildingBlocks.ZetaPole
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.NormNum

open Filter Set
open scoped Topology

namespace BuildingBlocks

def Target : Prop := RiemannHypothesis

def RightHalfZeroFree : Prop :=
  ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0

theorem zeta_zero_ne_origin {s : ℂ} (hz : riemannZeta s = 0) : s ≠ 0 := by
  intro hs
  subst s
  rw [riemannZeta_zero] at hz
  norm_num at hz

theorem gamma_ne_zero_at_nontrivial_zero {s : ℂ} (hz : riemannZeta s = 0)
    (ht : ¬ ∃ n : ℕ, s = -2 * (n + 1)) : Complex.Gammaℝ s ≠ 0 := by
  intro hg
  obtain ⟨n, hn⟩ := Complex.Gammaℝ_eq_zero_iff.mp hg
  cases n with
  | zero =>
      apply zeta_zero_ne_origin hz
      simpa using hn
  | succ n =>
      apply ht
      refine ⟨n, ?_⟩
      simpa [Nat.cast_add, Nat.cast_one, neg_mul] using hn

theorem reflect_nontrivial_zero {s : ℂ} (hz : riemannZeta s = 0)
    (ht : ¬ ∃ n : ℕ, s = -2 * (n + 1)) (hs : s ≠ 1) :
    riemannZeta (1 - s) = 0 := by
  have hg := gamma_ne_zero_at_nontrivial_zero hz ht
  have hc : completedRiemannZeta s = 0 := by
    have hq := hz
    rw [riemannZeta_def_of_ne_zero (zeta_zero_ne_origin hz)] at hq
    exact (div_eq_zero_iff.mp hq).resolve_right hg
  rw [riemannZeta_def_of_ne_zero (sub_ne_zero.mpr hs.symm),
    completedRiemannZeta_one_sub, hc, zero_div]

theorem target_iff_rightHalfZeroFree : Target ↔ RightHalfZeroFree := by
  constructor
  · intro h s hsr hs hz
    have ht : ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
      rintro ⟨n, rfl⟩
      norm_num at hsr
      have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
      linarith
    have := h s hz ht hs
    linarith
  · intro h s hz ht hs
    by_contra he
    rcases lt_or_gt_of_ne he with hlt | hgt
    · have hzero := reflect_nontrivial_zero hz ht hs
      apply h (1 - s) _ _ hzero
      · simp only [Complex.sub_re, Complex.one_re]
        linarith
      · intro hsub
        apply zeta_zero_ne_origin hz
        linear_combination -hsub
    · exact h s hgt hs hz

theorem analytic_nonzero_of_deriv_eq_mul {f a : ℂ → ℂ} {z₀ : ℂ}
    (hf : AnalyticAt ℂ f z₀) (ha : AnalyticAt ℂ a z₀)
    (hn : ¬ ∀ᶠ z in 𝓝 z₀, f z = 0)
    (hode : ∀ᶠ z in 𝓝 z₀, deriv f z = a z * f z) :
    f z₀ ≠ 0 := by
  intro hz
  obtain ⟨m, g, hg, hg0, hfac⟩ := hf.exists_eventuallyEq_pow_smul_nonzero_iff.mpr hn
  have hm : m ≠ 0 := by
    intro hm
    have hh := hfac.self_of_nhds
    rw [hm, pow_zero, one_smul, hz] at hh
    exact hg0 hh.symm
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hm
  have heq : f =ᶠ[𝓝 z₀] (fun z => (z - z₀) ^ (n + 1) * g z) := by
    simpa only [smul_eq_mul] using hfac
  let q : ℂ → ℂ := fun z =>
    (n + 1 : ℂ) * g z + (z - z₀) * deriv g z - a z * (z - z₀) * g z
  have hqa : AnalyticAt ℂ q z₀ :=
    ((analyticAt_const.mul hg).add
      ((analyticAt_id.sub analyticAt_const).mul hg.deriv)).sub
        ((ha.mul (analyticAt_id.sub analyticAt_const)).mul hg)
  have hq : ∀ᶠ z in 𝓝[≠] z₀, q z = 0 := by
    filter_upwards [heq.filter_mono nhdsWithin_le_nhds,
      heq.deriv.filter_mono nhdsWithin_le_nhds,
      hode.filter_mono nhdsWithin_le_nhds,
      hg.eventually_analyticAt.filter_mono nhdsWithin_le_nhds,
      self_mem_nhdsWithin] with z he he' ho hgz hzne
    have hd := (((hasDerivAt_id z).sub_const z₀).pow (n + 1)).mul
      hgz.differentiableAt.hasDerivAt
    have hmain : (n + 1 : ℂ) * (z - z₀) ^ n * g z +
        (z - z₀) ^ (n + 1) * deriv g z =
        a z * ((z - z₀) ^ (n + 1) * g z) := by
      calc
        _ = deriv (fun w => (w - z₀) ^ (n + 1) * g w) z := by
          simpa using hd.deriv.symm
        _ = deriv f z := he'.symm
        _ = a z * ((z - z₀) ^ (n + 1) * g z) := by rw [ho, he]
    have hprod : (z - z₀) ^ n * q z = 0 := by
      dsimp [q]
      rw [pow_succ] at hmain
      linear_combination hmain
    exact (mul_eq_zero.mp hprod).resolve_left
      (pow_ne_zero n (sub_ne_zero.mpr hzne))
  have hq0 := (hqa.frequently_zero_iff_eventually_zero.mp hq.frequently).self_of_nhds
  have hng : (n + 1 : ℂ) * g z₀ = 0 := by simpa [q] using hq0
  exact (mul_ne_zero (by exact_mod_cast Nat.succ_ne_zero n) hg0) hng

def rightDomain : Set ℂ := {s | (1 : ℝ) / 2 < s.re ∧ s ≠ 1}

theorem rightDomain_isOpen : IsOpen rightDomain :=
  (isOpen_lt continuous_const Complex.continuous_re).inter isOpen_compl_singleton

def HolomorphicZetaODE : Prop :=
  ∃ a : ℂ → ℂ, AnalyticOnNhd ℂ a rightDomain ∧
    ∀ s ∈ rightDomain, deriv riemannZeta s = a s * riemannZeta s

theorem target_of_holomorphicZetaODE (h : HolomorphicZetaODE) : Target := by
  apply target_iff_rightHalfZeroFree.mpr
  obtain ⟨a, ha, ho⟩ := h
  intro s hsr hs
  apply analytic_nonzero_of_deriv_eq_mul (zeta_analytic_off_pole s hs) (ha s ⟨hsr, hs⟩)
    (zeta_not_locally_zero hs)
  filter_upwards [rightDomain_isOpen.mem_nhds (show s ∈ rightDomain from ⟨hsr, hs⟩)] with z hz
  exact ho z hz

def tiltedDomain (t : ℝ) : Set ℂ :=
  {s | (1 : ℝ) / 2 < s.re ∧ s.re - t * s.im < 1}

theorem tiltedDomain_convex (t : ℝ) : Convex ℝ (tiltedDomain t) := by
  apply (convex_halfSpace_gt (IsLinearMap.mk Complex.add_re Complex.smul_re)
    ((1 : ℝ) / 2)).inter
  apply convex_halfSpace_lt (𝕜 := ℝ) (f := fun s : ℂ => s.re - t * s.im) (r := 1)
  exact IsLinearMap.mk
    (by intro x y; simp only [Complex.add_re, Complex.add_im]; ring)
    (by intro r x; simp only [Complex.smul_re, Complex.smul_im, smul_eq_mul]; ring)

theorem tiltedDomain_subset (t : ℝ) : tiltedDomain t ⊆ rightDomain := by
  intro s hs
  refine ⟨hs.1, ?_⟩
  intro heq
  subst s
  simpa [tiltedDomain] using hs.2

theorem eq_zero_on_tiltedDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F rightDomain)
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0)
    {t : ℝ} {w : ℂ} (hw : w ∈ tiltedDomain t) (hwre : 1 < w.re) :
    EqOn F 0 (tiltedDomain t) := by
  apply (show AnalyticOnNhd ℂ F (tiltedDomain t) from
    fun s hs => hF s (tiltedDomain_subset t hs)).eqOn_zero_of_preconnected_of_eventuallyEq_zero
      (tiltedDomain_convex t).isPreconnected hw
  filter_upwards [(isOpen_lt continuous_const Complex.continuous_re).mem_nhds hwre] with s hs
  exact hzero s hs

theorem identity_on_rightDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F rightDomain)
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0) :
    ∀ s ∈ rightDomain, F s = 0 := by
  intro s hs
  by_cases hsr : 1 < s.re
  · exact hzero s hsr
  have hu := eq_zero_on_tiltedDomain hF hzero
    (t := 1) (w := 2 + 2 * Complex.I)
    (by norm_num [tiltedDomain, Complex.mul_re, Complex.mul_im])
    (by norm_num [Complex.mul_re])
  have hl := eq_zero_on_tiltedDomain hF hzero
    (t := -1) (w := 2 - 2 * Complex.I)
    (by norm_num [tiltedDomain, Complex.mul_re, Complex.mul_im])
    (by norm_num [Complex.mul_re])
  by_cases huS : s ∈ tiltedDomain 1
  · exact hu huS
  apply hl
  refine ⟨hs.1, ?_⟩
  have h1 : 1 ≤ s.re - s.im := by
    apply le_of_not_gt
    intro hh
    exact huS ⟨hs.1, by simpa using hh⟩
  by_contra hh
  have h2 : 1 ≤ s.re + s.im := by simpa using le_of_not_gt hh
  have hr : s.re = 1 := by linarith
  have hi : s.im = 0 := by linarith
  exact hs.2 (Complex.ext (by simpa using hr) (by simpa using hi))

def HolomorphicPrimeExtension : Prop :=
  ∃ G : ℂ → ℂ, AnalyticOnNhd ℂ G {s | (1 : ℝ) / 2 < s.re} ∧
    ∀ s : ℂ, 1 < s.re →
      G s = -deriv riemannZeta s / riemannZeta s - s / (s - 1)

theorem target_of_holomorphicPrimeExtension (h : HolomorphicPrimeExtension) : Target := by
  obtain ⟨G, hG, hGeq⟩ := h
  have hcoef : AnalyticOnNhd ℂ (fun s => s / (s - 1) + G s) rightDomain := by
    intro s hs
    exact (analyticAt_id.div (analyticAt_id.sub analyticAt_const)
      (sub_ne_zero.mpr hs.2)).add (hG s hs.1)
  have hres : AnalyticOnNhd ℂ
      (fun s => deriv riemannZeta s + (s / (s - 1) + G s) * riemannZeta s)
      rightDomain := by
    intro s hs
    exact (zeta_analytic_off_pole s hs.2).deriv.add
      ((hcoef s hs).mul (zeta_analytic_off_pole s hs.2))
  have hzero : ∀ s : ℂ, 1 < s.re →
      deriv riemannZeta s + (s / (s - 1) + G s) * riemannZeta s = 0 := by
    intro s hs
    have hz := riemannZeta_ne_zero_of_one_lt_re hs
    rw [hGeq s hs]
    field_simp
    ring
  have hext := identity_on_rightDomain hres hzero
  apply target_of_holomorphicZetaODE
  refine ⟨fun s => -(s / (s - 1) + G s), ?_, ?_⟩
  · intro s hs
    exact (hcoef s hs).neg
  · intro s hs
    have hh := hext s hs
    linear_combination hh

end BuildingBlocks
