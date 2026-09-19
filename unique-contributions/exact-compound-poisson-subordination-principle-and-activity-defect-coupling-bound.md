# Unique Contribution 201: Exact Compound Poisson Subordination Principle and Activity Defect Coupling Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedLawComparison.lean`](../../formalization/BuildingBlocks/PrimeSeedLawComparison.lean), [`building-blocks/primes/prime-seed-law-comparison.md`](../../building-blocks/primes/prime-seed-law-comparison.md)  
**Classification:** Probability Theory / Jump Processes / Coupling Theory / Subordination Principles / Total Variation Bounds / Monotone Convolution

---

## 1. Executive Summary and Mathematical Statement

Comparing the laws of pure jump processes governed by differing jump intensities usually relies on martingale coupling, Girsanov change of measure, or abstract total variation approximations. However, obtaining sharp non-asymptotic bounds on event-wise probability differences without extraneous factors of 2 or unknown constants requires an exact measure-theoretic subordination principle.

This contribution proves:

1. **Monotonicity of Measure Convolution and Jump Powers:**  
   For any positive finite Borel measures $\mu \le \nu$ and $\rho \le \sigma$ on $\mathbb{R}$:
   \[
   \mu * \rho \le \nu * \sigma, \quad \mu^{*n} \le \nu^{*n} \quad (\forall n \in \mathbb{N}).
   \]
2. **Exact Poisson Subordination Principle:**  
   Let $\mathcal{P}_u^{(\mu)}$ and $\mathcal{P}_u^{(\nu)}$ denote the compound Poisson laws with finite jump measures $\mu \le \nu$. Every path history of the smaller process survives in the larger process, precisely scaled by the probability of zero extra jumps:
   \[
   e^{-u(\|\nu\| - \|\mu\|)} \mathcal{P}_u^{(\mu)} \le \mathcal{P}_u^{(\nu)}.
   \]
3. **Sharp Sub-Probability Event Coupling Lemma:**  
   If $\mu$ and $\nu$ are probability measures on a measurable space $(X, \mathcal{M})$ and there exists a scalar $c \in [0, 1]$ such that $c \cdot \mu \le \nu$, then for EVERY measurable event $A \in \mathcal{M}$:
   \[
   |\mu(A) - \nu(A)| \le 1 - c.
   \]
   Notice that this bound achieves equality and contains no extra factor of 2.
4. **Sharp Activity Defect Total Variation Bound:**  
   For any two finite-activity compound Poisson processes whose Lévy measures satisfy $\mu \le \nu$, for all operational times $u \ge 0$ and all measurable sets $A \subseteq \mathbb{R}$:
   \[
   |\mathcal{P}_u^{(\mu)}(A) - \mathcal{P}_u^{(\nu)}(A)| \le 1 - e^{-u(\|\nu\| - \|\mu\|)} \le u (\|\nu\| - \|\mu\|).
   \]
   The total variation distance between the processes is unconditionally controlled by the missing total jump activity multiplied by time.

---

## 2. Mathematical Proof

### 2.1. Monotonicity of Convolution
For $A \in \mathcal{B}(\mathbb{R})$, $(\mu * \rho)(A) = \int \rho(A - x) d\mu(x)$.
Since $\rho \le \sigma$ and $\mu$ is non-negative, $\int \rho(A - x) d\mu(x) \le \int \sigma(A - x) d\mu(x)$.
Since $\mu \le \nu$ and $x \mapsto \sigma(A - x)$ is non-negative, $\int \sigma(A - x) d\mu(x) \le \int \sigma(A - x) d\nu(x) = (\nu * \sigma)(A)$.
By mathematical induction, $\mu^{*n} \le \nu^{*n}$ for all $n \in \mathbb{N}$.

### 2.2. Subordination Series
Expanding both compound Poisson laws into jump series:
\[
\mathcal{P}_u^{(\nu)} = \sum_{n=0}^\infty e^{-u\|\nu\|} \frac{u^n}{n!} \nu^{*n}.
\]
Multiplying $\mathcal{P}_u^{(\mu)}$ by $e^{-u(\|\nu\| - \|\mu\|)}$:
\[
e^{-u(\|\nu\| - \|\mu\|)} \mathcal{P}_u^{(\mu)} = \sum_{n=0}^\infty e^{-u\|\nu\|} \frac{u^n}{n!} \mu^{*n} \le \sum_{n=0}^\infty e^{-u\|\nu\|} \frac{u^n}{n!} \nu^{*n} = \mathcal{P}_u^{(\nu)},
\]
since $\mu^{*n} \le \nu^{*n}$ term-by-term and all coefficients are non-negative.

### 2.3. Event Bound from Sub-Probability Domination
Since $c \cdot \mu \le \nu$, we have $c \cdot \mu(A) \le \nu(A)$ and $c \cdot \mu(A^c) \le \nu(A^c)$.
Using $\mu(A) + \mu(A^c) = 1$ and $\nu(A) + \nu(A^c) = 1$:
\[
\nu(A) - \mu(A) \le 1 - \nu(A^c) - \mu(A) \le 1 - c \mu(A^c) - \mu(A) = 1 - c(1 - \mu(A)) - \mu(A) = (1 - c)(1 - \mu(A)) \le 1 - c.
\]
Similarly, $\mu(A) - \nu(A) \le \mu(A) - c \mu(A) = (1 - c)\mu(A) \le 1 - c$.
Thus $|\mu(A) - \nu(A)| \le 1 - c$.
Applying this to $c = e^{-u(\|\nu\| - \|\mu\|)}$ yields $|\mathcal{P}_u^{(\mu)}(A) - \mathcal{P}_u^{(\nu)}(A)| \le 1 - e^{-u(\|\nu\| - \|\mu\|)} \le u (\|\nu\| - \|\mu\|)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedProcess` in `formalization/BuildingBlocks/PrimeSeedLawComparison.lean`):
```lean
theorem conv_mono_of_finite {μ ν ρ σ : Measure ℝ}
    [IsFiniteMeasure ρ] [IsFiniteMeasure σ] (hμ : μ ≤ ν) (hρ : ρ ≤ σ) :
    μ ∗ ρ ≤ ν ∗ σ

theorem jumpPower_mono {μ ν : Measure ℝ} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    (h : μ ≤ ν) (n : ℕ) : jumpPower μ n ≤ jumpPower ν n

theorem finiteJumpLaw_domination {μ ν : Measure ℝ} [IsFiniteMeasure μ]
    [IsFiniteMeasure ν] (h : μ ≤ ν) (u : ℝ≥0) :
    ENNReal.ofReal (exp (-(u : ℝ) *
      ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ)))) •
        finiteJumpLaw μ u ≤ finiteJumpLaw ν u

theorem probability_event_bound_of_domination {μ ν : Measure ℝ}
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] {c : ℝ}
    (hc : 0 ≤ c) (hc1 : c ≤ 1) (h : ENNReal.ofReal c • μ ≤ ν)
    {A : Set ℝ} (hA : MeasurableSet A) :
    |μ.real A - ν.real A| ≤ 1 - c

theorem finiteJumpLaw_event_bound {μ ν : Measure ℝ} [IsFiniteMeasure μ]
    [IsFiniteMeasure ν] (h : μ ≤ ν) (u : ℝ≥0) {A : Set ℝ}
    (hA : MeasurableSet A) :
    |(finiteJumpLaw μ u).real A - (finiteJumpLaw ν u).real A| ≤
      (u : ℝ) * ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Coupling and total variation bounds for Poisson and compound Poisson distributions (Lindvall 1992, Barbour-Chen 2005, Roos 2003). Machine formalization of exact measure subordination and the sharp event-wise bound $u (\|\nu\| - \|\mu\|)$ in Lean 4 is new.
- **Advancement:** Formalizes the subordination $e^{-u(\|\nu\| - \|\mu\|)} \mathcal{P}_u^{(\mu)} \le \mathcal{P}_u^{(\nu)}$ and derives the exact coupling error bound $u (\|\nu\| - \|\mu\|)$ for arbitrary positive finite jump measures in Lean 4.
- **Target Venues:** *Bernoulli* or *Statistics & Probability Letters*.
