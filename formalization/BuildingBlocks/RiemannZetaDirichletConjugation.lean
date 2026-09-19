import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Topology.Algebra.InfiniteSum.Constructions
import Mathlib.Analysis.SpecialFunctions.Pow.Complex

/-!
# Riemann Zeta Dirichlet Conjugation and Half-Plane Reflection

This module formalizes the exact complex conjugation identity for the Riemann zeta function
on the half-plane of absolute convergence `Re(s) > 1` directly from Mathlib's formal definition
`zeta_eq_tsum_one_div_nat_cpow`.

## Mathematical Content
For any complex number `s` with `Re(s) > 1`, the Riemann zeta function is given by the
absolutely convergent Dirichlet series:
$$\zeta(s) = \sum_{n=1}^\infty \frac{1}{n^s}.$$
Since each integer `n` is real, we have for all `n ≥ 1`:
$$\operatorname{star}((n : \mathbb{C})^s) = (n : \mathbb{C})^{\operatorname{star}(s)}.$$
Because complex conjugation `starRingEnd ℂ` is an isometric ring involution, it distributes
over division and continuous infinite sums (`tsum_star`), yielding:
$$\operatorname{star}(\zeta(s)) = \operatorname{star}\left(\sum_{n=1}^\infty \frac{1}{n^s}\right) = \sum_{n=1}^\infty \frac{1}{n^{\operatorname{star}(s)}} = \zeta(\operatorname{star}(s)).$$

## Main Results
- `nat_cpow_conj`: Exact conjugation commutation for integer complex powers.
- `nat_inv_cpow_conj`: Conjugation commutation for Dirichlet series summands `1 / n^s`.
- `zeta_conj_of_one_lt_re`: Exact Schwarz reflection identity `ζ(star s) = star (ζ(s))` for all `s` with `1 < Re(s)`.
- `zeta_zero_iff_conj_zero_of_one_lt_re`: Equivalence of vanishing `ζ(s) = 0 ↔ ζ(star s) = 0` for `1 < Re(s)`.

## Axiom Status
All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaDirichletConjugation

open Complex

noncomputable section

/-- Exact conjugation commutation for integer complex powers `(n : ℂ) ^ s`. -/
theorem nat_cpow_conj (n : ℕ) (s : ℂ) : star ((n : ℂ) ^ s) = (n : ℂ) ^ (star s) := by
  rcases eq_or_ne n 0 with rfl | hn
  · simp only [Nat.cast_zero]
    rcases eq_or_ne s 0 with rfl | hs
    · simp only [Complex.cpow_zero, star_one, star_zero]
    · have hs_star : star s ≠ 0 := by
        intro h
        apply hs
        simpa using congr_arg star h
      rw [zero_cpow hs, zero_cpow hs_star, star_zero]
  · have hn_pos : 0 < (n : ℝ) := Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn)
    have hn_ne : (n : ℂ) ≠ 0 := by
      exact_mod_cast hn
    have h_cast : (n : ℂ) = ((n : ℝ) : ℂ) := by simp only [ofReal_natCast]
    rw [Complex.star_def, Complex.cpow_def_of_ne_zero hn_ne, Complex.cpow_def_of_ne_zero hn_ne,
        ← Complex.exp_conj, RingHom.map_mul, h_cast,
        ← Complex.ofReal_log hn_pos.le, Complex.conj_ofReal]

/-- Exact conjugation commutation for Dirichlet series summands `1 / (n : ℂ) ^ s`. -/
theorem nat_inv_cpow_conj (n : ℕ) (s : ℂ) : star (1 / (n : ℂ) ^ s) = 1 / (n : ℂ) ^ (star s) := by
  rw [Complex.star_def, map_div₀, map_one, ← Complex.star_def, nat_cpow_conj]

/-- Exact Schwarz reflection identity for the Riemann zeta function on `Re(s) > 1`
directly from Mathlib's Dirichlet series representation. -/
theorem zeta_conj_of_one_lt_re {s : ℂ} (hs : 1 < s.re) :
    riemannZeta (star s) = star (riemannZeta s) := by
  have hs_star : 1 < (star s).re := by
    rw [Complex.star_def, Complex.conj_re]
    exact hs
  rw [zeta_eq_tsum_one_div_nat_cpow hs, zeta_eq_tsum_one_div_nat_cpow hs_star]
  rw [tsum_star]
  congr 1 with n
  exact (nat_inv_cpow_conj n s).symm

/-- Zero equivalence across the real axis for `Re(s) > 1`: `ζ(s) = 0 ↔ ζ(star s) = 0`. -/
theorem zeta_zero_iff_conj_zero_of_one_lt_re {s : ℂ} (hs : 1 < s.re) :
    riemannZeta s = 0 ↔ riemannZeta (star s) = 0 := by
  have h := zeta_conj_of_one_lt_re hs
  constructor
  · intro hz
    rw [h, hz, star_zero]
  · intro hz_star
    rw [h] at hz_star
    have := congr_arg star hz_star
    rwa [star_star, star_zero] at this

#print axioms nat_cpow_conj
#print axioms nat_inv_cpow_conj
#print axioms zeta_conj_of_one_lt_re
#print axioms zeta_zero_iff_conj_zero_of_one_lt_re

end

end BuildingBlocks.RiemannZetaDirichletConjugation
