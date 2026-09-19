# All-Prime Seed Three-Region Decomposition and L² Square Integrability

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean)
**Classification:** Analytic Number Theory / Harmonic Analysis / Prime Lévy Measures / Square Integrability of Prime Seeds
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

In the stochastic and causal operator framework for primes, the collective all-prime seed function is defined by:
$$
\operatorname{allPrimeSeed}(v) = \sum_{p} \operatorname{seed}(\log p, v) = \sum_{p \le e^v} e^{(v - \log p)/2} e^{-(v - \log p)}.
$$
While the collective seed has an infinite first moment due to the divergence of $\sum 1/p$, its higher energy and $L^2$ norms are controlled by the sub-diffusive spacing of primes.

This note records:

1. **Three-Region Prime Decomposition:**
   For any $v \ge 3 \log 2$ and any finite set of primes $S$, decomposing the prime support into:
   - Small primes: $p \le e^{v/3}$, with aggregate contribution $\le e^{-v/6}$.
   - Middle primes: $e^{v/3} < p \le e^{v/2}$, with aggregate contribution $\le 4 e^{-v/6}$.
   - Large primes: $p > e^{v/2}$, with aggregate contribution $\le \frac{64 \log 2}{v}$.
   Yields the uniform three-region bound:
   $$
   \operatorname{finitePrimeSeed}(S, v) \le \frac{64 \log 2}{v} + 5 e^{-v/6}.
   $$
2. **Universal Age Bound:**
   For all $v \ge 3 \log 2$:
   $$
   v \cdot \operatorname{allPrimeSeed}(v) \le 64 \log 2 + 30.
   $$
3. **Square Tail Dominance:**
   The square of the all-prime seed is pointwise majorized by its weighted Lévy density:
   $$
   (\operatorname{allPrimeSeed}(v))^2 \le (64 \log 2 + 30) \frac{\operatorname{allPrimeSeed}(v)}{v}.
   $$
4. **Unconditional $L^2(\mathbb{R})$ Square Integrability:**
   Using only Chebyshev's elementary upper bound and the finite activity of the prime Lévy measure, without assuming the Prime Number Theorem or the Riemann Hypothesis:
   $$
   \int_{-\infty}^\infty (\operatorname{allPrimeSeed}(v))^2 \, dv < \infty, \quad \operatorname{allPrimeSeed} \in L^2(\mathbb{R}, \operatorname{volume}).
   $$

---

## 2. Mathematical Proof

### 2.1. Small and Middle Regions
For $p \le e^{v/3}$, each seed is bounded by $e^{-v/2}$. The number of such primes is bounded by $e^{v/3}$. Thus the sum is $\le e^{v/3} e^{-v/2} = e^{-v/6}$.
For $e^{v/3} < p \le e^{v/2}$, the reciprocal cube tail sum $\sum 1/p^3 \le 4/Z^2$ bounds the seed by $4 e^{-v/6}$.

### 2.2. Large Region
For $p > e^{v/2}$, the prime seed satisfies the envelope $\le \frac{32 \log 2}{p \log p}$. The tail sum $\sum_{p > e^{v/2}} 1/p^2$ is bounded by $1/\lfloor e^{v/2} \rfloor$, yielding the tail bound $\frac{64 \log 2}{v}$.

### 2.3. $L^2$ Majorization via Finite Activity
The measure $\mu(dv) = \frac{\operatorname{allPrimeSeed}(v)}{v} dv$ is the all-prime Lévy measure, which has finite total mass $\mu(\mathbb{R}) < \infty$.
Since $(\operatorname{allPrimeSeed}(v))^2 \le C \frac{\operatorname{allPrimeSeed}(v)}{v}$ on $[3\log 2, \infty)$, and is square-integrable on compact initial segments by finite prime support, the sum of these two integrable majorants proves that $(\operatorname{allPrimeSeed})^2 \in L^1(\mathbb{R})$, hence $\operatorname{allPrimeSeed} \in L^2(\mathbb{R})$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedAllPrimeSquare`):
```lean
theorem finite_seed_three_region_bound (S : Finset Nat.Primes) {v : ℝ} (hv : 3 * log 2 ≤ v) :
    finitePrimeSeed S v ≤ (64 * log 2) / v + 5 * exp (-v / 6)

theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30

theorem allPrimeSeed_square_tail_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    allPrimeSeed v ^ 2 ≤ (64 * log 2 + 30) * (allPrimeSeed v / v)

theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2)

theorem allPrimeSeed_memLp_two : MemLp allPrimeSeed 2 volume
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
