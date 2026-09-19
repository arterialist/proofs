import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.Analysis.Complex.Trigonometric
import BuildingBlocks.RiemannZetaDirichletConjugation

/-!
# Riemann Zeta Functional Equation Reflection Symmetry

This module establishes the exact Schwarz reflection symmetry of the Riemann zeta function
on the negative half-plane `Re(w) < 0` directly from the functional equation `riemannZeta_one_sub`
and the Dirichlet series conjugation theorem on `Re(s) > 1` (`RiemannZetaDirichletConjugation`).

## Mathematical Formulation
For any $s \in \mathbb{C}$ satisfying $\operatorname{Re}(s) > 1$, $s \ne 1$, and $s \notin -\mathbb{N}$, the Riemann
zeta functional equation in Mathlib asserts:
$$\zeta(1 - s) = 2 (2\pi)^{-s} \Gamma(s) \cos(\pi s / 2) \zeta(s).$$
Under complex conjugation:
- $2 \in \mathbb{R}$, so $\operatorname{star}(2) = 2$.
- $2\pi > 0$, so $\operatorname{star}((2\pi)^{-s}) = (2\pi)^{-\operatorname{star}(s)}$.
- $\Gamma(\operatorname{star}(s)) = \operatorname{star}(\Gamma(s))$ via `Complex.Gamma_conj`.
- $\cos(\pi \operatorname{star}(s) / 2) = \operatorname{star}(\cos(\pi s / 2))$ via `Complex.cos_conj`.
- $\zeta(\operatorname{star}(s)) = \operatorname{star}(\zeta(s))$ via `zeta_conj_of_one_lt_re`.

Multiplying these factors establishes:
$$\zeta(1 - \operatorname{star}(s)) = \operatorname{star}(\zeta(1 - s)).$$
Setting $w = 1 - s$, this gives the exact Schwarz reflection symmetry for all $w$ with $\operatorname{Re}(w) < 0$:
$$\zeta(\operatorname{star}(w)) = \operatorname{star}(\zeta(w)).$$

## Main Theorems
- `ofReal_cpow_conj`: Exact conjugation commutation for positive real powers `(a : ℂ) ^ s`.
- `zeta_one_sub_conj`: Exact functional equation conjugation symmetry `ζ(1 - star s) = star (ζ(1 - s))`.
- `zeta_conj_of_re_lt_zero`: Exact Schwarz reflection `ζ(star w) = star (ζ(w))` for `w.re < 0`.
- `zeta_zero_iff_conj_zero_of_re_lt_zero`: Vanishing equivalence across the real axis on `Re(w) < 0`.

## Axiom Status
All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaFunctionalReflection

open Complex
open BuildingBlocks.RiemannZetaDirichletConjugation

noncomputable section

/-- Exact conjugation commutation for complex powers of positive real numbers. -/
theorem ofReal_cpow_conj {a : ℝ} (ha : 0 < a) (s : ℂ) :
    star ((a : ℂ) ^ s) = (a : ℂ) ^ (star s) := by
  have ha_ne : (a : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr ha.ne'
  rw [Complex.star_def, Complex.cpow_def_of_ne_zero ha_ne, Complex.cpow_def_of_ne_zero ha_ne,
      ← Complex.exp_conj, RingHom.map_mul,
      ← Complex.ofReal_log ha.le, Complex.conj_ofReal]

/-- Exact functional equation conjugation symmetry for `s` in the half-plane `Re(s) > 1`. -/
theorem zeta_one_sub_conj {s : ℂ} (hs : ∀ n : ℕ, s ≠ -n) (hs' : s ≠ 1) (hs_gt : 1 < s.re) :
    riemannZeta (1 - star s) = star (riemannZeta (1 - s)) := by
  have hs_star : ∀ n : ℕ, star s ≠ -n := by
    intro n hn
    have h_conj : star (star s) = star (- (n : ℂ)) := congr_arg star hn
    rw [star_star] at h_conj
    have h_n_real : star (- (n : ℂ)) = - (n : ℂ) := by
      simp only [star_def, map_neg, conj_natCast]
    rw [h_n_real] at h_conj
    exact hs n h_conj
  have hs'_star : star s ≠ 1 := by
    intro hn
    apply hs'
    have : star (star s) = star (1 : ℂ) := congr_arg star hn
    rwa [star_star, star_one] at this
  rw [riemannZeta_one_sub hs hs', riemannZeta_one_sub hs_star hs'_star]
  have h2 : star (2 : ℂ) = 2 := by simp
  have h_base_pos : 0 < 2 * Real.pi := by positivity
  have h_pow : star ((2 * (Real.pi : ℂ)) ^ (-s)) = (2 * (Real.pi : ℂ)) ^ (- star s) := by
    have h_base : (2 * (Real.pi : ℂ)) = ((2 * Real.pi : ℝ) : ℂ) := by simp
    rw [h_base]
    have := ofReal_cpow_conj h_base_pos (-s)
    rw [this, Complex.star_def, map_neg, ← Complex.star_def]
  have h_gamma : star (Gamma s) = Gamma (star s) := by
    rw [Complex.star_def, ← Complex.Gamma_conj]
  have h_cos : star (cos (Real.pi * s / 2)) = cos (Real.pi * star s / 2) := by
    rw [Complex.star_def, ← cos_conj]
    congr 1
    simp only [map_div₀, map_mul, conj_ofReal, ← Complex.star_def, h2]
  have h_zeta : star (riemannZeta s) = riemannZeta (star s) :=
    (zeta_conj_of_one_lt_re hs_gt).symm
  simp only [star_mul]
  rw [h2, h_pow, h_gamma, h_cos, h_zeta]
  ring

/-- Exact Schwarz reflection symmetry for `Re(w) < 0` away from non-positive integers. -/
theorem zeta_conj_of_re_lt_zero {w : ℂ} (hw : w.re < 0)
    (hw_nat : ∀ n : ℕ, 1 - w ≠ -n) (hw1 : w ≠ 0) :
    riemannZeta (star w) = star (riemannZeta w) := by
  have hs_gt : 1 < (1 - w).re := by
    rw [sub_re, one_re]
    linarith
  have hs' : 1 - w ≠ 1 := by
    intro h
    apply hw1
    linear_combination -1 * h
  have h_w_star : star w = 1 - star (1 - w) := by
    rw [Complex.star_def, map_sub, map_one, sub_sub_cancel, ← Complex.star_def]
  have h_w : w = 1 - (1 - w) := by ring
  nth_rw 1 [h_w_star]
  nth_rw 2 [h_w]
  exact zeta_one_sub_conj hw_nat hs' hs_gt

/-- Equivalence of zero vanishing on `Re(w) < 0` away from non-positive integers. -/
theorem zeta_zero_iff_conj_zero_of_re_lt_zero {w : ℂ} (hw : w.re < 0)
    (hw_nat : ∀ n : ℕ, 1 - w ≠ -n) (hw1 : w ≠ 0) :
    riemannZeta w = 0 ↔ riemannZeta (star w) = 0 := by
  have h := zeta_conj_of_re_lt_zero hw hw_nat hw1
  constructor
  · intro hz
    rw [h, hz, star_zero]
  · intro hz_star
    rw [h] at hz_star
    have := congr_arg star hz_star
    rwa [star_star, star_zero] at this

#print axioms ofReal_cpow_conj
#print axioms zeta_one_sub_conj
#print axioms zeta_conj_of_re_lt_zero
#print axioms zeta_zero_iff_conj_zero_of_re_lt_zero

end

end BuildingBlocks.RiemannZetaFunctionalReflection
