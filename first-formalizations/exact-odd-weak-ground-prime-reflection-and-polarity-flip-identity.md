# First Formalization: Exact Odd Weak Ground Prime Reflection and Polarity Flip Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/OddWeakGroundPrimeReflectionFinite.lean`](../../formalization/BuildingBlocks/OddWeakGroundPrimeReflectionFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact finite prime reflection identity for odd scale theta-ground rows and the polarity flip correction across the singular boundary $\log n = u$ in Lean 4:

1. **Odd Scale Definition and Symmetries:**
   Formal proof of `oddScale_pos`, `oddScale_neg`, `oddScale_zero`, and `oddScale_reflect` ($\text{oddScale}(f, t, -v) = -\text{oddScale}(f, t, v)$).
2. **Threshold Pair Calculations:**
   Formal proof of `pair_below` ($\ell < u$), `pair_above` ($u < \ell$), and `pair_reflect`.
3. **Polarity Flip Identity:**
   Formal proof of `pair_with_flip`:
   \[
   \text{oddScale}(f, t, u + \ell) + \text{oddScale}(f, t, u - \ell) = f(t e^{u+\ell}) - f(t e^{\ell - u}) + \mathbf{1}_{\ell < u}(f(t e^{u-\ell}) + f(t e^{\ell-u})).
   \]
4. **Finite Von Mangoldt Sum Identities:**
   Formal proof of `finite_reflected_row`, `exp_plus_log`, `exp_log_sub`, `finite_vonMangoldt_reflected_row`, and `finite_vonMangoldt_scaled_row`:
   \[
   \sum_{n \in s} \frac{\Lambda(n)}{\sqrt{n}} \text{pair}_n = \sum_{n \in s} \frac{\Lambda(n)}{\sqrt{n}} (f(tn e^u) - f(tn e^{-u})) + \sum_{n < e^u} \frac{\Lambda(n)}{\sqrt{n}} (f(t e^{u-\log n}) + f(t e^{\log n - u})).
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Odd scale antisymmetry
theorem oddScale_reflect (f : ℝ → ℝ) (t v : ℝ) :
    oddScale f t (-v) = -oddScale f t v

-- Exact threshold flip identity
theorem pair_with_flip (f : ℝ → ℝ) (t u ell : ℝ)
    (hu : 0 < u) (hell : 0 ≤ ell) (hne : ell ≠ u) :
    oddScale f t (u + ell) + oddScale f t (u - ell) =
      f (t * Real.exp (u + ell)) - f (t * Real.exp (ell - u)) +
        (if ell < u then
          f (t * Real.exp (u - ell)) + f (t * Real.exp (ell - u))
         else 0)

-- Reflected row identity
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
        f (t * Real.exp (Real.log n - u)) else 0))

-- Scaled von Mangoldt row identity with product factoring
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
        f (t * Real.exp (Real.log n - u)) else 0))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 decomposing finite von Mangoldt-weighted odd scale reflections into symmetric dilation differences and explicit low-prime polarity corrections across the threshold boundary $\log n = u$.
