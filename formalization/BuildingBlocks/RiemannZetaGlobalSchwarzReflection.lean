import Mathlib.NumberTheory.LSeries.HurwitzZetaEven
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaSchwarzReflection

/-!
# Global Schwarz Reflection of Completed and Riemann Zeta Functions

This module establishes the machine-verified proof in Lean 4 that both the completed
Riemann zeta function `completedRiemannZeta` (globally on `ℂ`) and the Riemann zeta
function `riemannZeta` (on the open right half-plane `Re(s) > 0`, including the entire
critical strip and the critical half-plane `Re(s) > 1/2`) satisfy the exact Schwarz reflection
symmetry across the real axis:
$$\Lambda(\overline{s}) = \overline{\Lambda(s)}, \qquad \zeta(\overline{s}) = \overline{\zeta(s)}.$$

## Mathematical Architecture
1. **Real Kernel Representation:**
   The completed even Hurwitz zeta function at parameter $a = 0$ is constructed via
   `hurwitzEvenFEPair 0`, whose modifying kernel `WeakFEPair.f_modif` is shown to be
   identically real-valued:
   $$f_{\text{modif}}(x) = \mathbf{1}_{(1, \infty)}(x)(f(x) - 1) + \mathbf{1}_{(0, 1)}(x)(f(x) - x^{-1/2}).$$
2. **Mellin Conjugation Commutation:**
   Applying `mellin_conj_of_real` proves that the entire function `completedRiemannZeta₀`
   satisfies $\Lambda_0(\overline{s}) = \overline{\Lambda_0(s)}$.
3. **Pole Symmetries:**
   The pole subtractions $1/s$ and $1/(1-s)$ commute with conjugation, yielding global
   Schwarz reflection for `completedRiemannZeta`:
   $$\Lambda(\overline{s}) = \overline{\Lambda(s)} \quad \text{for all } s \in \mathbb{C}.$$
4. **Zeta Reflection on $\operatorname{Re}(s) > 0$:**
   Since $\Lambda(s) = \Gamma_{\mathbb{R}}(s)\zeta(s)$ with $\Gamma_{\mathbb{R}}(\overline{s}) = \overline{\Gamma_{\mathbb{R}}(s)}$,
   and $\Gamma_{\mathbb{R}}(s) \ne 0$ for $\operatorname{Re}(s) > 0$, dividing by $\Gamma_{\mathbb{R}}$ yields:
   $$\zeta(\overline{s}) = \overline{\zeta(s)} \quad \text{for all } s \text{ with } \operatorname{Re}(s) > 0.$$
5. **Zero Equivalence:**
   For any off-line zero candidate with $\operatorname{Re}(s) > 1/2$, $\zeta(s) = 0 \iff \zeta(\overline{s}) = 0$.

## Axiom Status
All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaGlobalSchwarzReflection

open Complex
open BuildingBlocks.RiemannZetaSchwarzReflection
open HurwitzZeta

noncomputable section

/-- The canonical even functional equation pair for the Riemann zeta function. -/
def P₀ := hurwitzEvenFEPair 0

/-- The explicit real-valued modifying kernel for the completed zeta function. -/
def real_f_modif (x : ℝ) : ℝ :=
  (Set.Ioi 1).indicator (fun x ↦ evenKernel 0 x - 1) x +
  (Set.Ioo 0 1).indicator (fun x ↦ evenKernel 0 x - x ^ (- (1 / 2 : ℝ))) x

/-- Pointwise identity showing that `P₀.f_modif` is identically real-valued. -/
lemma f_modif_eq_ofReal (x : ℝ) :
    P₀.f_modif x = (real_f_modif x : ℂ) := by
  dsimp [P₀, WeakFEPair.f_modif, real_f_modif, hurwitzEvenFEPair]
  by_cases h1 : x ∈ Set.Ioi (1 : ℝ)
  · rw [Set.indicator_of_mem h1, Set.indicator_of_mem h1]
    have h_not_ioo : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt h1 (Set.mem_Ioo.mp h).2.le
    rw [Set.indicator_of_notMem h_not_ioo, Set.indicator_of_notMem h_not_ioo]
    simp only [add_zero, ofReal_sub, ofReal_one]
    rfl
  · rw [Set.indicator_of_notMem h1, Set.indicator_of_notMem h1]
    by_cases h2 : x ∈ Set.Ioo (0 : ℝ) 1
    · rw [Set.indicator_of_mem h2, Set.indicator_of_mem h2]
      simp only [zero_add, ofReal_sub, mul_one, one_mul]
    · rw [Set.indicator_of_notMem h2, Set.indicator_of_notMem h2]
      simp

/-- Functional extensional equality between `(hurwitzEvenFEPair 0).f_modif` and `real_f_modif`. -/
lemma f_modif_eq_fun : (hurwitzEvenFEPair 0).f_modif = fun x ↦ (real_f_modif x : ℂ) := by
  ext x
  exact f_modif_eq_ofReal x

/-- The Mellin transform of the zeta kernel commutes with complex conjugation. -/
theorem strong_lambda_conj (s : ℂ) :
    mellin (hurwitzEvenFEPair 0).f_modif (star s) = star (mellin (hurwitzEvenFEPair 0).f_modif s) := by
  rw [f_modif_eq_fun]
  exact mellin_conj_of_real real_f_modif s

/-- Halving commutes with complex conjugation. -/
lemma star_div_two (z : ℂ) : star (z / 2) = star z / 2 := by
  rw [Complex.star_def, map_div₀]
  have h2 : (starRingEnd ℂ) 2 = 2 := by simp only [map_ofNat]
  rw [h2, ← Complex.star_def]

/-- The entire function `completedRiemannZeta₀` satisfies exact Schwarz reflection. -/
theorem completedRiemannZeta₀_conj (s : ℂ) :
    completedRiemannZeta₀ (star s) = star (completedRiemannZeta₀ s) := by
  dsimp only [completedRiemannZeta₀, completedHurwitzZetaEven₀, WeakFEPair.Λ₀, P₀]
  rw [← star_div_two, strong_lambda_conj (s / 2), star_div_two]

/-- Complex reciprocal commutes with complex conjugation. -/
lemma star_one_div (z : ℂ) : star (1 / z) = 1 / star z := by
  rw [Complex.star_def, map_div₀, map_one, ← Complex.star_def]

/-- Global Schwarz reflection for the completed Riemann zeta function on `ℂ`. -/
theorem completedRiemannZeta_conj (s : ℂ) :
    completedRiemannZeta (star s) = star (completedRiemannZeta s) := by
  rw [completedRiemannZeta, completedHurwitzZetaEven_eq,
      completedRiemannZeta, completedHurwitzZetaEven_eq]
  simp only [if_true]
  change completedRiemannZeta₀ (star s) - 1 / star s - 1 / (1 - star s) =
    star (completedRiemannZeta₀ s - 1 / s - 1 / (1 - s))
  rw [completedRiemannZeta₀_conj]
  simp only [star_sub]
  rw [star_one_div s, star_one_div (1 - s)]
  simp only [star_sub, star_one]

/-- Global zero reflection equivalence for `completedRiemannZeta`. -/
theorem completedRiemannZeta_zero_iff (s : ℂ) :
    completedRiemannZeta s = 0 ↔ completedRiemannZeta (star s) = 0 := by
  have h := completedRiemannZeta_conj s
  constructor
  · intro hz
    rw [h, hz, star_zero]
  · intro hz_star
    rw [h] at hz_star
    have := congr_arg star hz_star
    rwa [star_star, star_zero] at this

/-- Complex division commutes with complex conjugation. -/
lemma complex_star_div (a b : ℂ) : star (a / b) = star a / star b := by
  rw [Complex.star_def, map_div₀]

/-- Exact Schwarz reflection symmetry for `riemannZeta` on `Re(s) > 0`. -/
theorem riemannZeta_conj_of_re_pos {s : ℂ} (hs : 0 < s.re) :
    riemannZeta (star s) = star (riemannZeta s) := by
  have hs_ne : s ≠ 0 := by
    intro h
    rw [h] at hs
    simp at hs
  have hs_star_ne : star s ≠ 0 := by
    intro h
    apply hs_ne
    have := congr_arg star h
    rwa [star_star, star_zero] at this
  rw [riemannZeta_def_of_ne_zero hs_ne, riemannZeta_def_of_ne_zero hs_star_ne]
  rw [completedRiemannZeta_conj s, Gammaℝ_star s]
  exact (complex_star_div (completedRiemannZeta s) (Gammaℝ s)).symm

/-- Zero vanishing equivalence across the real axis for `riemannZeta` on `Re(s) > 0`. -/
theorem riemannZeta_zero_iff_conj_zero_of_re_pos {s : ℂ} (hs : 0 < s.re) :
    riemannZeta s = 0 ↔ riemannZeta (star s) = 0 := by
  have h := riemannZeta_conj_of_re_pos hs
  constructor
  · intro hz
    rw [h, hz, star_zero]
  · intro hz_star
    rw [h] at hz_star
    have := congr_arg star hz_star
    rwa [star_star, star_zero] at this

/-- Zero reflection equivalence for any off-line zero candidate with `Re(s) > 1/2`. -/
theorem riemannZeta_zero_iff_conj_zero_of_half_lt_re {s : ℂ} (hs : 1 / 2 < s.re) :
    riemannZeta s = 0 ↔ riemannZeta (star s) = 0 :=
  riemannZeta_zero_iff_conj_zero_of_re_pos (by linarith)

#print axioms f_modif_eq_ofReal
#print axioms strong_lambda_conj
#print axioms completedRiemannZeta₀_conj
#print axioms completedRiemannZeta_conj
#print axioms completedRiemannZeta_zero_iff
#print axioms riemannZeta_conj_of_re_pos
#print axioms riemannZeta_zero_iff_conj_zero_of_re_pos
#print axioms riemannZeta_zero_iff_conj_zero_of_half_lt_re

end

end BuildingBlocks.RiemannZetaGlobalSchwarzReflection
