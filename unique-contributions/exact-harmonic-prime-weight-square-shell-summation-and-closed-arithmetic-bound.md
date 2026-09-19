# Unique Contribution 326: Exact Harmonic Prime Weight Square-Shell Summation and Closed Arithmetic Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/HarmonicPrimeWeightBound.lean`](../../formalization/BuildingBlocks/HarmonicPrimeWeightBound.lean), [`building-blocks/harmonic-weights/bound.md`](../../building-blocks/harmonic-weights/bound.md)  
**Classification:** Analytic Number Theory / Arithmetic Dynamics / Phase Harmonic Mass / LCM Lattices / Geometric Series / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the study of arithmetic dynamics and phase harmonic projections across prime-power lattices, the total weight $w_N(p)$ assigned to a prime $p$ involves double sums over exponents $i, j < N$ weighted by reciprocal least common multiples $1/\text{lcm}(p^i, q^j)$. The self-interaction terms $q = p$ feature $\text{lcm}(p^i, p^j) = p^{\max(i, j)}$, while cross terms $q \ne p$ decouple via coprimality $\text{lcm}(p^i, q^j) = p^i q^j$.

This contribution proves:

1. **Exact 2D Square-Shell Count Identity:**  
   For any ratio $r \in \mathbb{R}$ and integer horizon $N$:
   \[
   \sum_{i=1}^{N-1} \sum_{j=1}^{N-1} r^{\max(i, j)} = \sum_{j=1}^{N-1} (2j - 1) r^j.
   \]
2. **Exact Same-Prime Reciprocal Bound:**  
   Summing the weighted square-shells via derivative geometric series proves that for any prime $p$:
   \[
   \text{samePrimeReciprocalSum}(N, p) = \sum_{i=1}^{N-1} \sum_{j=1}^{N-1} \frac{1}{p^{\max(i, j)}} \le \frac{p+1}{(p-1)^2}.
   \]
3. **Exact Coprime Decoupling of Cross-Prime Powers:**  
   For distinct primes $p \ne q$, coprimality $\gcd(p^i, q^j) = 1$ factorizes the double sum:
   \[
   \sum_{i=1}^{N-1} \sum_{j=1}^{N-1} \frac{1}{\text{lcm}(p^i, q^j)} = \left( \sum_{i=1}^{N-1} \frac{1}{p^i} \right) \left( \sum_{j=1}^{N-1} \frac{1}{q^j} \right) \le \frac{1}{p-1} \frac{1}{q-1}.
   \]
4. **Exact Closed Arithmetic Bound on Harmonic Prime Weights:**  
   For any horizon $N \ge 1$ and prime $p$, the harmonic prime weight is bounded by the explicit closed rational expression:
   \[
   w_N(p) \le \frac{p+1}{(p-1)^2} + \frac{1}{p-1} \sum_{q \in \text{admittedPrimes}(N), q \ne p} \frac{1}{q-1}.
   \]

---

## 2. Mathematical Proof

### 2.1. Square-Shell Summation
In the grid $\{1, \dots, N-1\}^2$, the points $(i, j)$ with $\max(i, j) = k$ form an $L$-shaped shell of size $(2k - 1)$ (namely, $(k, k)$, $(k, j)$ for $j < k$, and $(i, k)$ for $i < k$). Summing over $k \in [1, N-1]$ yields $\sum_{k=1}^{N-1} (2k-1) r^k$.

### 2.2. Infinite Geometric Series Bounds
For $r = 1/p < 1$:
$\sum_{k=1}^\infty (2k-1) r^k = 2 r \sum_{k=1}^\infty k r^{k-1} - \sum_{k=1}^\infty r^k = 2 r \frac{1}{(1-r)^2} - \frac{r}{1-r} = \frac{r(1+r)}{(1-r)^2}$.
Substituting $r = 1/p$ gives $\frac{(1/p)(1 + 1/p)}{(1 - 1/p)^2} = \frac{p+1}{(p-1)^2}$.

### 2.3. Phase Mass Monotonicity and Decoupling
Since phase harmonic mass is monotone, $\frac{M(N/ \text{lcm})}{M(N)} \le \frac{1}{\text{lcm}}$.
Decomposing the admitted primes into $\{p\}$ and $\{q \ne p\}$ yields the result.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`ArithmeticDynamics` in `formalization/BuildingBlocks/HarmonicPrimeWeightBound.lean`):
```lean
lemma sum_pow_max_Ico (N : ℕ) (r : ℝ) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, r ^ max i j) =
      ∑ j ∈ Finset.Ico 1 N, (2 * (j : ℝ) - 1) * r ^ j

lemma same_geometric_sum_le (N : ℕ) {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, r ^ max i j) ≤
      r * (1+r) / (1-r)^2

lemma samePrimeReciprocalSum_le (N p : ℕ) (hp : p.Prime) :
    samePrimeReciprocalSum N p ≤ ((p : ℝ) + 1) / ((p : ℝ) - 1)^2

lemma reciprocal_lcm_sum_eq (N p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
      1 / (Nat.lcm (p ^ i) (q ^ j) : ℝ)) =
    if q = p then samePrimeReciprocalSum N p
    else primePowerReciprocalSum N p * primePowerReciprocalSum N q

theorem harmonicPrimeWeight_le_closed (N p : ℕ) (hN : 1 ≤ N) (hp : p.Prime) :
    harmonicPrimeWeight N p ≤ ((p : ℝ) + 1) / ((p : ℝ) - 1)^2 +
      (1 / ((p : ℝ) - 1)) *
        ∑ q ∈ (admittedPrimes N).filter (fun q => q ≠ p), 1 / ((q : ℝ) - 1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Apostol (1976) *Introduction to Analytic Number Theory*; Tenenbaum (2015) *Introduction to Analytic and Probabilistic Number Theory*. Machine verification of exact square-shell maximum reductions and closed LCM-lattice prime weight bounds in Lean 4 is new.
- **Advancement:** Provides an exact closed arithmetic bound on harmonic prime weights in terms of the prime $p$ and the harmonic series of coprime admitted primes, eliminating all two-dimensional exponent lattices.
- **Target Venues:** *Ramanujan Journal* or *Integers*.
