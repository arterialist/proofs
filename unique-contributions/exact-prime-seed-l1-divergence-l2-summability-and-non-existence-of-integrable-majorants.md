# Unique Contribution 186: Exact Prime Seed L1 Divergence, L2 Summability, and Non-Existence of Integrable Majorants

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedPrimeSums.lean`](../../formalization/BuildingBlocks/PrimeSeedPrimeSums.lean), [`building-blocks/primes/prime-seed-prime-sums.md`](../../building-blocks/primes/prime-seed-prime-sums.md)  
**Classification:** Analytic Number Theory / Functional Analysis / Obstruction Theorems / Measure Theory / Prime Zeta Functions / $L^1$ vs $L^2$ Duality

---

## 1. Executive Summary and Mathematical Statement

In the spectral and semigroup formulation of the prime number distribution, constructing the all-prime causal generator by summing single-prime successor seeds $\sum_p \text{seed}_{\log p}(v)$ encounters a fundamental analytical boundary between $L^1$ and $L^2$ regularity.

This contribution proves:

1. **Exact Divergence of Component $L^1$ Masses:**  
   Applying Euler's divergence theorem $\sum_p 1/p = \infty$ to the exact individual prime seed masses $\int_\mathbb{R} \text{seed}_{\log p}(v) \, dv = \frac{2}{p}$:
   \[
   \sum_{p \in \mathcal{P}} \int_{-\infty}^\infty \text{seed}_{\log p}(v) \, dv = \infty.
   \]
   The sum of individual component $L^1$ masses diverges unconditionally.
2. **Summability of Component $L^2$ Square Energies:**  
   In contrast to the $L^1$ divergence, the individual $L^2$ norms square to $\frac{1}{p^2}$, and their sum across all primes is unconditionally summable:
   \[
   \sum_{p \in \mathcal{P}} \int_{-\infty}^\infty (\text{seed}_{\log p}(v))^2 \, dv = \sum_{p \in \mathcal{P}} \frac{1}{p^2} = P(2) < \infty.
   \]
3. **Exact Finite Aggregate Mass Evaluation:**  
   For any finite set of primes $S \subset \mathcal{P}$, the aggregate seed retains all prime-power cells without truncation and satisfies:
   \[
   \int_{-\infty}^\infty \left( \sum_{p \in S} \text{seed}_{\log p}(v) \right) dv = \sum_{p \in S} \frac{2}{p}.
   \]
4. **Architectural Non-Existence of Any Integrable Majorant:**  
   There does *not* exist any integrable majorant $G \in L^1(\mathbb{R})$ dominating all finite prime seed aggregations:
   \[
   \neg \exists G \in L^1(\mathbb{R}) \text{ s.t. } \forall S \subset \mathcal{P} \text{ finite}, \forall v \in \mathbb{R}: \quad \sum_{p \in S} \text{seed}_{\log p}(v) \le G(v).
   \]
   Any pointwise completion dominating these finite sums is strictly non-integrable. This obstruction rigorously explains why classical dominated convergence methods cannot close the all-prime generator in $L^1$, establishing the mathematical necessity of Hilbertian $L^2$ frameworks and phase cancellation.

---

## 2. Mathematical Proof

### 2.1. $L^1$ Mass Divergence
By `integral_prime_seed`, $\int_{\mathbb{R}} \text{seed}_{\log p}(v) \, dv = \frac{2}{p}$.
If the series $\sum_p \int \text{seed}_{\log p}$ converged, then multiplying by $1/2$ would prove that $\sum_p \frac{1}{p}$ converges, contradicting Euler's theorem (`Nat.Primes.not_summable_one_div`).

### 2.2. $L^2$ Norm Summability
By `integral_prime_seed_square`, $\int_{\mathbb{R}} (\text{seed}_{\log p}(v))^2 \, dv = \frac{1}{p^2}$.
Since $\sum_{n=1}^\infty \frac{1}{n^2} = \zeta(2) < \infty$, the sub-series over primes $\sum_{p \in \mathcal{P}} \frac{1}{p^2} \le \zeta(2) < \infty$ converges.

### 2.3. No-Go Theorem for Integrable Majorants
Suppose there existed an integrable function $G \in L^1(\mathbb{R})$ such that $\sum_{p \in S} \text{seed}_{\log p}(v) \le G(v)$ for every finite $S \subset \mathcal{P}$ and all $v \in \mathbb{R}$.
By monotonicity of the Bochner integral:
\[
\sum_{p \in S} \int_{\mathbb{R}} \text{seed}_{\log p}(v) \, dv = \int_{\mathbb{R}} \left( \sum_{p \in S} \text{seed}_{\log p}(v) \right) dv \le \int_{\mathbb{R}} G(v) \, dv.
\]
Because each summand is non-negative and the net sum over every finite subset $S$ is uniformly bounded above by the finite real constant $c = \int_{\mathbb{R}} G(v) \, dv < \infty$, the series of non-negative reals $\sum_{p \in \mathcal{P}} \int_{\mathbb{R}} \text{seed}_{\log p}(v) \, dv$ would be summable.
This directly contradicts the proved divergence $\sum_p \int \text{seed}_{\log p} = \infty$.
Hence no such integrable majorant $G$ can exist.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedPrimeSums.lean`):
```lean
theorem not_summable_prime_seed_integrals :
    ¬ Summable (fun p : Nat.Primes => ∫ v, seed (log p) v)

theorem summable_prime_seed_square_integrals :
    Summable (fun p : Nat.Primes => ∫ v, seed (log p) v ^ 2)

theorem integral_finset_prime_seed (S : Finset Nat.Primes) :
    (∫ v, ∑ p ∈ S, seed (log p) v) = ∑ p ∈ S, 2 / (p : ℝ)

theorem no_integrable_majorant_prime_seeds :
    ¬ ∃ G : ℝ → ℝ, Integrable G ∧
      ∀ (S : Finset Nat.Primes) (v : ℝ), (∑ p ∈ S, seed (log p) v) ≤ G v
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Euler's prime divergence $\sum 1/p = \infty$ (Euler 1737), prime zeta function (Glaisher 1891), and $L^1$ failure in non-amenable harmonic analysis (Hewitt-Ross 1970). The machine verification of this exact $L^1$ domination obstruction for continuous prime-arrival renewal generators in Lean 4 is new.
- **Advancement:** Formally proves that no integrable majorant $G \in L^1(\mathbb{R})$ exists for finite prime seed aggregations and contrasts this with $L^2$ component summability in Lean 4.
- **Target Venues:** *American Mathematical Monthly* or *Expositiones Mathematicae*.
