# Contribution 183: Exact Prime Seed Unweighted and Half-Weighted Mass Identities

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedMass.lean`](../../formalization/BuildingBlocks/PrimeSeedMass.lean), [`building-blocks/primes/prime-seed-mass.md`](../../building-blocks/primes/prime-seed-mass.md)  
**Classification:** Analytic Number Theory / Causal Semigroups / Bochner Integration / Dirichlet Series / Geometric Series / Prime Successor Seeds

---

## 1. Executive Summary and Mathematical Statement

The continuous causal prime successor seed $\text{seed}_L(v) = e^{v/2 - (\lfloor v/L \rfloor + 1)L} \mathbf{1}_{[L, \infty)}(v)$ models the injection of prime arrivals into renewal memory equations along the logarithmic clock $L = \log p$. Analyzing its continuous integrals over $\mathbb{R}$ connects the piecewise continuous semigroup dynamics directly to classical arithmetic Dirichlet series.

This contribution proves:

1. **Exact Identification with the Power-Floor Formula:**  
   For any prime $p > 0$ and all $v \in \mathbb{R}$:
   $$
   \text{seed}_{\log p}(v) = \begin{cases} \dfrac{e^{v/2}}{p^{\lfloor v/\log p \rfloor + 1}}, & v \ge \log p \\ 0, & v < \log p. \end{cases}
   $$
2. **Clock-Cell Partition Decomposition Principle:**  
   For any clock $L > 0$, the disjoint half-open intervals $\bigcup_{j=0}^\infty [(j+1)L, (j+2)L) = [L, \infty)$ partition the causal support. Any non-negative causal function with summable cell integrals is globally integrable, with whole-line integral equal to the series sum.
3. **Exact Total Unweighted Mass Identity:**  
   The unweighted cell integrals evaluate to $\int_{(j+1)L}^{(j+2)L} \text{cellDensity}(L, j, v) \, dv = 2(1 - e^{-L/2})(e^{-L/2})^{j+2}$.
   Summing over all $j \in \mathbb{N}$ cancels the prefactor and yields:
   $$
   \int_{-\infty}^\infty \text{seed}_L(v) \, dv = 2 e^{-L}.
   $$
   Specializing to the prime clock $L = \log p$ ($p > 1$):
   $$
   \int_{-\infty}^\infty \text{seed}_{\log p}(v) \, dv = \frac{2}{p}.
   $$
4. **Exact Half-Weighted Mass and Classical Dirichlet Series Identification:**  
   Weighting the seed by $e^{-v/2}$ removes the exponential growth within each cell, giving constant integrand $e^{-(j+2)L}$ and cell integral $L e^{-(j+2)L}$.
   Summing the geometric series yields:
   $$
   \int_{-\infty}^\infty e^{-v/2} \text{seed}_L(v) \, dv = \frac{L e^{-2L}}{1 - e^{-L}}.
   $$
   Specializing to $L = \log p$:
   $$
   \int_{-\infty}^\infty e^{-v/2} \text{seed}_{\log p}(v) \, dv = \frac{\log p}{p(p - 1)}.
   $$
   The continuous half-weighted mass of the prime seed matches the exact classical coefficient $\frac{\log p}{p(p-1)}$ of the prime-power sum $\sum_{m=2}^\infty \frac{\Lambda(n)}{n} = \sum_p \frac{\log p}{p(p-1)}$!

---

## 2. Mathematical Proof

### 2.1. Unweighted Cell Integration and Geometric Cancellation
On $[(j+1)L, (j+2)L]$, the density is $e^{v/2 - (j+2)L}$.
Using $\int_a^b e^{v/2 - c} \, dv = 2 e^{b/2 - c} - 2 e^{a/2 - c}$:
$$
\int_{(j+1)L}^{(j+2)L} e^{v/2 - (j+2)L} \, dv = 2 e^{(j+2)L/2 - (j+2)L} - 2 e^{(j+1)L/2 - (j+2)L}
$$
$$
= 2 e^{-(j+2)L/2} - 2 e^{-(j+3)L/2} = 2 (1 - e^{-L/2}) (e^{-L/2})^{j+2}.
$$
Let $r = e^{-L/2} < 1$.
The sum is $\sum_{j=0}^\infty 2(1 - r) r^{j+2} = 2(1 - r) r^2 \frac{1}{1 - r} = 2 r^2 = 2 e^{-L}$.
For $L = \log p$, $2 e^{-\log p} = \frac{2}{p}$.

### 2.2. Half-Weighted Integration and Dirichlet Matching
Multiplying by $e^{-v/2}$ gives:
$$
e^{-v/2} \text{cellDensity}(L, j, v) = e^{-v/2} e^{v/2 - (j+2)L} = e^{-(j+2)L}.
$$
This is constant on the interval of length $(j+2)L - (j+1)L = L$.
The cell integral is $L e^{-(j+2)L} = L (e^{-L})^{j+2}$.
Let $q = e^{-L} < 1$.
Summing over $j \ge 0$:
$$
\sum_{j=0}^\infty L q^{j+2} = L q^2 \sum_{j=0}^\infty q^j = \frac{L q^2}{1 - q} = \frac{L e^{-2L}}{1 - e^{-L}}.
$$
Substituting $L = \log p$ where $q = 1/p$:
$$
\frac{(\log p) (1/p^2)}{1 - 1/p} = \frac{\log p}{p^2 (p - 1)/p} = \frac{\log p}{p(p - 1)}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedMass.lean`):
```lean
theorem seed_log_eq {p : ℝ} (hp : 0 < p) (v : ℝ) :
    seed (log p) v = if log p ≤ v then
      exp (v / 2) / p ^ (⌊v / log p⌋₊ + 1) else 0

theorem integral_of_clock_cells {L M : ℝ} {f : ℝ → ℝ} (hL : 0 < L)
    (hnonneg : ∀ v, 0 ≤ f v) (hzero : ∀ v < L, f v = 0)
    (hi : ∀ j : ℕ, IntegrableOn f
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)))
    (hs : HasSum (fun j : ℕ => ∫ v in
      Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L), f v) M) :
    Integrable f ∧ (∫ v, f v) = M

theorem integrable_seed_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (seed L) ∧ (∫ v, seed L v) = 2 * exp (-L)

theorem integral_prime_seed {p : ℝ} (hp : 1 < p) :
    (∫ v, seed (log p) v) = 2 / p

theorem integrable_weighted_seed_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => exp (-v / 2) * seed L v) ∧
      (∫ v, exp (-v / 2) * seed L v) =
        L * exp (-L) ^ 2 / (1 - exp (-L))

theorem integral_prime_weighted_seed {p : ℝ} (hp : 1 < p) :
    (∫ v, exp (-v / 2) * seed (log p) v) = log p / (p * (p - 1))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet series evaluations of prime-power sums $\sum_p \frac{\log p}{p(p-1)}$ (Landau 1909, Montgomery-Vaughan 2007). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves the exact identities $\int_{\mathbb{R}} \text{seed}_{\log p} = \frac{2}{p}$ and $\int_{\mathbb{R}} e^{-v/2}\text{seed}_{\log p} = \frac{\log p}{p(p-1)}$ in Lean 4.
- **Target Venues:** *Ramanujan Journal* or *Journal of Mathematical Analysis and Applications*.
