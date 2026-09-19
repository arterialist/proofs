# Contribution 196: Exact All-Prime Lévy Measure Finiteness and Pure-Jump Probability Semigroup

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeLevy.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeLevy.lean), [`building-blocks/primes/prime-seed-all-prime-levy.md`](../../building-blocks/primes/prime-seed-all-prime-levy.md)  
**Classification:** Stochastic Processes / Lévy Processes / Pure Jump Semigroups / Prime Renewal / Density Inversion / Convolution Semigroups

---

## 1. Executive Summary and Mathematical Statement

In the spectral-probabilistic theory of the Riemann zeta function, the collective arrival dynamics across all prime numbers are governed by an aggregate Lévy jump measure. A central foundational challenge is proving that the sum over all infinitely many primes produces a strictly finite Borel jump measure without presupposing the Prime Number Theorem (PNT) or the Riemann Hypothesis (RH).

This contribution proves:

1. **Explicit Prime Lévy Mass Bound:**  
   For every prime $p \ge 2$, the total mass of the singleton jump measure $\nu_{\{p\}}(dv) = \frac{\text{seed}_{\log p}(v)}{v} dv$ satisfies:
   $$
   \int_{\mathbb{R}} \frac{\text{seed}_{\log p}(v)}{v} \, dv \le \frac{2}{p \log p}.
   $$
2. **Summability via Chebyshev Shell Estimates:**  
   Without assuming PNT, RH, or asymptotic prime densities, the sum over all primes is summable:
   $$
   \sum_{p \in \mathcal{P}} \int_{\mathbb{R}} \frac{\text{seed}_{\log p}(v)}{v} \, dv < \infty.
   $$
3. **Finite All-Prime Lévy Measure:**  
   The aggregate all-prime measure $\nu_{\mathcal{P}} = \sum_{p \in \mathcal{P}} \nu_{\{p\}}$ is a finite Borel measure (`IsFiniteMeasure`):
   $$
   \nu_{\mathcal{P}}(\mathbb{R}) = \sum_{p \in \mathcal{P}} \int_{\mathbb{R}} \frac{\text{seed}_{\log p}(v)}{v} \, dv < \infty.
   $$
4. **Finite Local Prime Support and Density Identification:**  
   At any finite age $v \in \mathbb{R}$, only primes $p \le \lfloor e^v \rfloor$ have non-zero seed evaluations. The collective seed $B(v) = \sum_{p \in \mathcal{P}} \text{seed}_{\log p}(v)$ is a well-defined pointwise finite sum, and the Lévy measure satisfies:
   $$
   \nu_{\mathcal{P}} = \text{volume.withDensity}\left(v \mapsto \frac{B(v)}{v}\right).
   $$
5. **Non-Integrability of the Unweighted Seed:**  
   The unweighted collective seed $B(v)$ is strictly non-integrable: $B \notin L^1(\mathbb{R})$. Finiteness of activity relies essentially on the age denominator $v$.
6. **Pure-Jump Transition Probability Semigroup:**  
   For operational time $u \ge 0$, the compound Poisson law $\mathcal{P}_u = \text{poissonLaw}(\text{normalizedJump } \nu_{\mathcal{P}}, u \|\nu_{\mathcal{P}}\|)$ defines a rigorous Markov transition probability semigroup:
   $$
   \mathcal{P}_0 = \delta_0, \quad \mathcal{P}_u * \mathcal{P}_w = \mathcal{P}_{u+w},
   $$
   with exact series expansion $\mathcal{P}_u = \sum_{n=0}^\infty e^{-u \|\nu_{\mathcal{P}}\|} \frac{u^n}{n!} \nu_{\mathcal{P}}^{*n}$.

---

## 2. Mathematical Proof

### 2.1. Individual Prime Jump Bound
By `integral_seed_div_age_le`, for $L = \log p > 0$:
$$
\int_{\mathbb{R}} \frac{\text{seed}_{\log p}(v)}{v} \, dv \le \frac{2 e^{-\log p}}{\log p} = \frac{2}{p \log p}.
$$

### 2.2. Summability Across Primes
By `summable_prime_reciprocal_mul_log` (proved via dyadic Chebyshev shells without PNT), $\sum_p \frac{1}{p \log p} < \infty$.
By comparison test, $\sum_p \int \frac{\text{seed}_{\log p}(v)}{v} dv < \infty$.
Thus $\nu_{\mathcal{P}}(\mathbb{R}) < \infty$, establishing `IsFiniteMeasure`.

### 2.3. Pointwise Density Identification
For $v \in \mathbb{R}$, if $\text{seed}_{\log p}(v) \ne 0$, then $\log p \le v$, meaning $p \le e^v$, which restricts $p \in \{2, \dots, \lfloor e^v \rfloor\}$.
Thus the sum $B(v) = \sum_p \text{seed}_{\log p}(v)$ is finite at every $v$.
Applying monotone convergence for series of measures (`withDensity_tsum`) gives $\nu_{\mathcal{P}} = \text{withDensity}(B(v)/v)$.

### 2.4. Probability Semigroup
The Poisson convolution law $\mathcal{P}_u$ is normalized to total mass 1 because $\sum_{n=0}^\infty \frac{\lambda^n}{n!} e^{-\lambda} = 1$.
The convolution semigroup property $\mathcal{P}_u * \mathcal{P}_w = \mathcal{P}_{u+w}$ follows from Cauchy convolution product of exponential power series.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` and `BuildingBlocks.PrimeSeedProcess` in `formalization/BuildingBlocks/PrimeSeedAllPrimeLevy.lean`):
```lean
theorem prime_levy_mass_le (p : Nat.Primes) :
    (∫ v, seed (log p) v / v) ≤ 2 * (1 / ((p : ℝ) * log p))

theorem summable_prime_levy_masses :
    Summable (fun p : Nat.Primes => ∫ v, seed (log p) v / v)

theorem allPrimeLevyMeasure_mass :
    allPrimeLevyMeasure Set.univ =
      ENNReal.ofReal (∑' p : Nat.Primes, ∫ v, seed (log p) v / v)

instance allPrimeLevyMeasure_isFiniteMeasure : IsFiniteMeasure allPrimeLevyMeasure

theorem seed_prime_finite_support (v : ℝ) :
    (Function.support (fun p : Nat.Primes => seed (log p) v)).Finite

theorem allPrimeLevyMeasure_eq_withDensity :
    allPrimeLevyMeasure = volume.withDensity
      (fun v => ENNReal.ofReal (allPrimeSeed v / v))

theorem not_integrable_allPrimeSeed : ¬ Integrable allPrimeSeed

instance allPrimeProcess_isProbability (u : ℝ≥0) : IsProbabilityMeasure (allPrimeProcess u)

theorem allPrimeProcess_zero : allPrimeProcess 0 = Measure.dirac 0

theorem allPrimeProcess_add (u v : ℝ≥0) :
    allPrimeProcess u ∗ allPrimeProcess v = allPrimeProcess (u + v)

theorem allPrimeProcess_original_series (u : ℝ≥0) :
    allPrimeProcess u = Measure.sum (fun n : ℕ =>
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure : ℝ)) *
          (u : ℝ) ^ n / n.factorial) • jumpPower PrimeSeedMass.allPrimeLevyMeasure n)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Construction of compound Poisson and pure-jump Lévy processes (Lévy 1937, Sato 1999, Applebaum 2009). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes $\sum_p \int \frac{\text{seed}_{\log p}}{v} < \infty$, proves $\nu_{\mathcal{P}} = \text{withDensity}(B(v)/v)$, and constructs the convolution probability semigroup $\mathcal{P}_{u+v} = \mathcal{P}_u * \mathcal{P}_v$ in Lean 4.
- **Target Venues:** *Stochastic Processes and their Applications* or *Probability Theory and Related Fields*.
