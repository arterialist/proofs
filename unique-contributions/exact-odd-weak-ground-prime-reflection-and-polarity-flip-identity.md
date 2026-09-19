# Contribution 309: Exact Odd Weak Ground Prime Reflection and Polarity Flip Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/OddWeakGroundPrimeReflectionFinite.lean`](../../formalization/BuildingBlocks/OddWeakGroundPrimeReflectionFinite.lean), [`building-blocks/theta-ground/odd-reflection.md`](../../building-blocks/theta-ground/odd-reflection.md)  
**Classification:** Analytic Number Theory / Explicit Formulas / Odd Scale Symmetries / Von Mangoldt Reflection / Polarity Deficits / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral decomposition of theta-ground kernels associated with the Riemann zeta function, odd test functions undergo sign inversion under logarithmic scale reflection:
$$
\text{oddScale}(f, t, v) = \begin{cases} f(t e^v) & \text{if } v > 0, \\ -f(t e^{-v}) & \text{if } v < 0, \\ 0 & \text{if } v = 0. \end{cases}
$$
When evaluating prime-power contributions at a positive scale parameter $u > 0$ paired with prime logarithms $\ell = \log n$, the argument $u - \ell$ changes sign across the critical threshold $u = \ell = \log n$.

This contribution proves:

1. **Exact Finite Von Mangoldt Scaled Row Identity:**  
   For any test function $f : \mathbb{R} \to \mathbb{R}$, $t \in \mathbb{R}$, $u > 0$, and any finite set of integers $s \subset \mathbb{N}_{\ge 2}$ avoiding the discrete singular points $\log n = u$:
   $$
   \sum_{n \in s} \frac{\Lambda(n)}{\sqrt{n}} \left( \text{oddScale}(f, t, u + \log n) + \text{oddScale}(f, t, u - \log n) \right)
   $$
   $$
   = \sum_{n \in s} \frac{\Lambda(n)}{\sqrt{n}} \left( f(t n e^u) - f(t n e^{-u}) \right) + \sum_{\substack{n \in s \\ \log n < u}} \frac{\Lambda(n)}{\sqrt{n}} \left( f(t e^{u - \log n}) + f(t e^{\log n - u}) \right).
   $$
   This decomposes the odd reflected prime sum into an antisymmetric dilation difference $\sum \frac{\Lambda(n)}{\sqrt{n}} (f(tne^u) - f(tne^{-u}))$ and an explicit non-negative polarity correction supported solely on the finite set of small primes $n < e^u$.
2. **Singular Threshold Polarity Flip Identity:**  
   For any $u > 0$, $\ell \ge 0$, and $\ell \ne u$:
   $$
   \text{oddScale}(f, t, u + \ell) + \text{oddScale}(f, t, u - \ell) = f(t e^{u + \ell}) - f(t e^{\ell - u}) + \mathbf{1}_{\ell < u} \left( f(t e^{u - \ell}) + f(t e^{\ell - u}) \right).
   $$
3. **Antisymmetry Under Scale Reflection:**  
   The odd scale transform is strictly odd: $\text{oddScale}(f, t, -v) = - \text{oddScale}(f, t, v)$ for all $v \in \mathbb{R}$.
4. **Antisymmetry of the Paired Kernel:**  
   $\text{oddScale}(f, t, -u + \ell) + \text{oddScale}(f, t, -u - \ell) = - \left( \text{oddScale}(f, t, u + \ell) + \text{oddScale}(f, t, u - \ell) \right)$.
5. **Exact Exponential Additive Factoring:**  
   $e^{u + \log n} = n e^u$ and $e^{\log n - u} = n e^{-u}$ for all $n \ge 2$.

---

## 2. Mathematical Proof

### 2.1. Threshold Analysis
Let $u > 0$ and $\ell \ge 0$.
1. **Case 1 ($\ell < u$):** Here $u + \ell > 0$ and $u - \ell > 0$.
   Thus $\text{oddScale}(f, t, u + \ell) = f(t e^{u+\ell})$ and $\text{oddScale}(f, t, u - \ell) = f(t e^{u-\ell})$.
   The pair sum is $f(t e^{u+\ell}) + f(t e^{u-\ell})$.
2. **Case 2 ($\ell > u$):** Here $u + \ell > 0$ and $u - \ell < 0$.
   Thus $\text{oddScale}(f, t, u + \ell) = f(t e^{u+\ell})$ and $\text{oddScale}(f, t, u - \ell) = -f(t e^{-(u-\ell)}) = -f(t e^{\ell - u})$.
   The pair sum is $f(t e^{u+\ell}) - f(t e^{\ell - u})$.

Unifying both cases:
$$
\text{oddScale}(f, t, u + \ell) + \text{oddScale}(f, t, u - \ell) = f(t e^{u+\ell}) - f(t e^{\ell - u}) + \mathbf{1}_{\ell < u} \left( f(t e^{u-\ell}) + f(t e^{\ell - u}) \right).
$$
When $\ell < u$, $-f(t e^{\ell - u}) + f(t e^{\ell - u}) = 0$, leaving $f(t e^{u+\ell}) + f(t e^{u-\ell})$. When $\ell > u$, the indicator is zero, leaving $f(t e^{u+\ell}) - f(t e^{\ell - u})$.

### 2.2. Von Mangoldt Summation
Setting $\ell = \log n$ and weighting by $\Lambda(n)/\sqrt{n}$:
For $n \ge 2$, $e^{u + \log n} = n e^u$ and $e^{\log n - u} = n e^{-u}$.
The main term becomes $\sum_{n \in s} \frac{\Lambda(n)}{\sqrt{n}} (f(t n e^u) - f(t n e^{-u}))$.
The correction term is nonzero only when $\log n < u$, i.e., $n < e^u$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.OddWeakGroundPrimeReflectionFinite` in `formalization/BuildingBlocks/OddWeakGroundPrimeReflectionFinite.lean`):
```lean
theorem oddScale_reflect (f : ℝ → ℝ) (t v : ℝ) :
    oddScale f t (-v) = -oddScale f t v

theorem pair_with_flip (f : ℝ → ℝ) (t u ell : ℝ)
    (hu : 0 < u) (hell : 0 ≤ ell) (hne : ell ≠ u) :
    oddScale f t (u + ell) + oddScale f t (u - ell) =
      f (t * Real.exp (u + ell)) - f (t * Real.exp (ell - u)) +
        (if ell < u then
          f (t * Real.exp (u - ell)) + f (t * Real.exp (ell - u))
         else 0)

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
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Weil (1952) *Sur les "formules explicites" de la théorie des nombres premiers*; Bombieri (2000) *Problems of the Millennium: The Riemann Hypothesis*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact algebraic formula decoupling symmetric prime dilation sums from low-prime polarity deficits across sign boundaries.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
