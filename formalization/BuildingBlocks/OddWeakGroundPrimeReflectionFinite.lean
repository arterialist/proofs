import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic

/-! The finite prime reflection algebra for the odd weak theta-ground row.
The equality case `u = log n` has measure zero in the later physical
integral; the finite theorem states the exact pointwise formula off it. -/

namespace BuildingBlocks.OddWeakGroundPrimeReflectionFinite

open scoped ArithmeticFunction.vonMangoldt

noncomputable def oddScale (f : ℝ → ℝ) (t v : ℝ) : ℝ :=
  if 0 < v then f (t * Real.exp v)
  else if v < 0 then -f (t * Real.exp (-v))
  else 0

theorem oddScale_pos (f : ℝ → ℝ) (t v : ℝ) (hv : 0 < v) :
    oddScale f t v = f (t * Real.exp v) := by
  simp [oddScale, hv]

theorem oddScale_neg (f : ℝ → ℝ) (t v : ℝ) (hv : v < 0) :
    oddScale f t v = -f (t * Real.exp (-v)) := by
  have hn : ¬ 0 < v := by linarith
  simp [oddScale, hn, hv]

theorem oddScale_zero (f : ℝ → ℝ) (t : ℝ) : oddScale f t 0 = 0 := by
  simp [oddScale]

theorem oddScale_reflect (f : ℝ → ℝ) (t v : ℝ) :
    oddScale f t (-v) = -oddScale f t v := by
  rcases lt_trichotomy v 0 with hv | hv | hv
  · have hp : 0 < -v := by linarith
    simp [oddScale_pos f t (-v) hp, oddScale_neg f t v hv]
  · subst v
    simp [oddScale_zero]
  · have hn : -v < 0 := by linarith
    simp [oddScale_neg f t (-v) hn, oddScale_pos f t v hv]

theorem pair_below (f : ℝ → ℝ) (t u ell : ℝ)
    (hu : 0 < u) (hell : 0 ≤ ell) (h : ell < u) :
    oddScale f t (u + ell) + oddScale f t (u - ell) =
      f (t * Real.exp (u + ell)) + f (t * Real.exp (u - ell)) := by
  have h₁ : 0 < u + ell := by linarith
  have h₂ : 0 < u - ell := by linarith
  rw [oddScale_pos f t (u + ell) h₁, oddScale_pos f t (u - ell) h₂]

theorem pair_above (f : ℝ → ℝ) (t u ell : ℝ)
    (hu : 0 < u) (h : u < ell) :
    oddScale f t (u + ell) + oddScale f t (u - ell) =
      f (t * Real.exp (u + ell)) - f (t * Real.exp (ell - u)) := by
  have h₁ : 0 < u + ell := by linarith
  have h₂ : u - ell < 0 := by linarith
  rw [oddScale_pos f t (u + ell) h₁, oddScale_neg f t (u - ell) h₂]
  simp [sub_eq_add_neg]

theorem pair_with_flip (f : ℝ → ℝ) (t u ell : ℝ)
    (hu : 0 < u) (hell : 0 ≤ ell) (hne : ell ≠ u) :
    oddScale f t (u + ell) + oddScale f t (u - ell) =
      f (t * Real.exp (u + ell)) - f (t * Real.exp (ell - u)) +
        (if ell < u then
          f (t * Real.exp (u - ell)) + f (t * Real.exp (ell - u))
         else 0) := by
  by_cases h : ell < u
  · rw [pair_below f t u ell hu hell h, if_pos h]
    ring
  · have h' : u < ell := by
      have hle : u ≤ ell := le_of_not_gt h
      exact lt_of_le_of_ne hle (Ne.symm hne)
    rw [pair_above f t u ell hu h', if_neg h]
    ring

theorem pair_reflect (f : ℝ → ℝ) (t u ell : ℝ) :
    oddScale f t (-u + ell) + oddScale f t (-u - ell) =
      -(oddScale f t (u + ell) + oddScale f t (u - ell)) := by
  have h₁ : -u + ell = -(u - ell) := by ring
  have h₂ : -u - ell = -(u + ell) := by ring
  rw [h₁, h₂, oddScale_reflect, oddScale_reflect]
  ring

theorem finite_reflected_row (f : ℝ → ℝ) (t u : ℝ) (s : Finset ℕ)
    (weight : ℕ → ℝ) (ell : ℕ → ℝ)
    (hu : 0 < u) (hell : ∀ n ∈ s, 0 ≤ ell n)
    (hne : ∀ n ∈ s, ell n ≠ u) :
    (∑ n ∈ s, weight n *
      (oddScale f t (u + ell n) + oddScale f t (u - ell n))) =
    (∑ n ∈ s, weight n *
      (f (t * Real.exp (u + ell n)) -
       f (t * Real.exp (ell n - u)))) +
    (∑ n ∈ s, weight n *
      (if ell n < u then
        f (t * Real.exp (u - ell n)) +
        f (t * Real.exp (ell n - u)) else 0)) := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  rw [pair_with_flip f t u (ell n) hu (hell n hn) (hne n hn)]
  ring

theorem finite_vonMangoldt_reflected_row (f : ℝ → ℝ) (t u : ℝ)
    (s : Finset ℕ) (hu : 0 < u)
    (hs : ∀ n ∈ s, 2 ≤ n)
    (hne : ∀ n ∈ s, Real.log n ≠ u) :
    (∑ n ∈ s, (Λ n / Real.sqrt n) *
      (oddScale f t (u + Real.log n) +
       oddScale f t (u - Real.log n))) =
    (∑ n ∈ s, (Λ n / Real.sqrt n) *
      (f (t * Real.exp (u + Real.log n)) -
       f (t * Real.exp (Real.log n - u)))) +
    (∑ n ∈ s, (Λ n / Real.sqrt n) *
      (if Real.log n < u then
        f (t * Real.exp (u - Real.log n)) +
        f (t * Real.exp (Real.log n - u)) else 0)) := by
  apply finite_reflected_row f t u s
    (fun n => Λ n / Real.sqrt n) (fun n => Real.log n) hu
  · intro n hn
    apply Real.log_nonneg
    exact_mod_cast (le_trans (by norm_num : 1 ≤ 2) (hs n hn))
  · exact hne

theorem exp_plus_log (u : ℝ) (n : ℕ) (hn : 2 ≤ n) :
    Real.exp (u + Real.log n) = (n : ℝ) * Real.exp u := by
  have hp : (0 : ℝ) < n := by
    exact_mod_cast (lt_of_lt_of_le (by norm_num : 0 < 2) hn)
  rw [Real.exp_add, Real.exp_log hp]
  ring

theorem exp_log_sub (u : ℝ) (n : ℕ) (hn : 2 ≤ n) :
    Real.exp (Real.log n - u) = (n : ℝ) * Real.exp (-u) := by
  have hp : (0 : ℝ) < n := by
    exact_mod_cast (lt_of_lt_of_le (by norm_num : 0 < 2) hn)
  rw [sub_eq_add_neg, Real.exp_add, Real.exp_log hp]

theorem finite_vonMangoldt_scaled_row (f : ℝ → ℝ) (t u : ℝ)
    (s : Finset ℕ) (hu : 0 < u)
    (hs : ∀ n ∈ s, 2 ≤ n)
    (hne : ∀ n ∈ s, Real.log n ≠ u) :
    (∑ n ∈ s, (Λ n / Real.sqrt n) *
      (oddScale f t (u + Real.log n) +
       oddScale f t (u - Real.log n))) =
    (∑ n ∈ s, (Λ n / Real.sqrt n) *
      (f (t * (n : ℝ) * Real.exp u) -
       f (t * (n : ℝ) * Real.exp (-u)))) +
    (∑ n ∈ s, (Λ n / Real.sqrt n) *
      (if Real.log n < u then
        f (t * Real.exp (u - Real.log n)) +
        f (t * Real.exp (Real.log n - u)) else 0)) := by
  rw [finite_vonMangoldt_reflected_row f t u s hu hs hne]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  rw [exp_plus_log u n (hs n hn), exp_log_sub u n (hs n hn)]
  ring

#print axioms oddScale_reflect
#print axioms pair_with_flip
#print axioms finite_vonMangoldt_reflected_row
#print axioms finite_vonMangoldt_scaled_row

end BuildingBlocks.OddWeakGroundPrimeReflectionFinite
