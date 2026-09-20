# First Formalization in Lean 4: Prime Seed Compound Poisson Process and Convolution Semigroup

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 Files:** [`formalization/BuildingBlocks/PrimeSeedCompoundPoisson.lean`](../../formalization/BuildingBlocks/PrimeSeedCompoundPoisson.lean), [`formalization/BuildingBlocks/PrimeSeedSemigroup.lean`](../../formalization/BuildingBlocks/PrimeSeedSemigroup.lean)  
**Dependencies:** `Mathlib.Probability.Distributions.Poisson`, `Mathlib.MeasureTheory.Group.Convolution`, `Mathlib.Algebra.BigOperators.NatAntidiagonal`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In probability theory and mathematical physics, compound Poisson processes on the real line represent continuous-time jump dynamics. This Lean 4 development formalizes the construction of compound Poisson probability measures directly from the arithmetic prime jump measure $\nu(dv) = \frac{B_S(v)}{v}dv$, where $S$ is a finite set of primes.

Key formalized results:
1. **Jump Power Convolutions:** Formalized $n$-jump convolution powers `jumpPower μ n` on `Measure ℝ`, proving that if $\mu$ is a probability measure, then each `jumpPower μ n` is a probability measure.
2. **Poisson Mixture Law:** Formalized `poissonLaw μ r = ∑_{n=0}^\infty (\text{poissonPMF } r\ n) • \text{jumpPower } \mu\ n$, showing it is unconditionally a probability measure on $\mathbb{R}$.
3. **Normalized Reconstruct:** Established the exact identity $(\mu(\mathbb{R})) • \operatorname{normalizedJump}(\mu) = \mu$ and its corresponding power identity `jumpPower μ n = (μ Set.univ)^n • jumpPower (normalizedJump μ) n`.
4. **Convolution Additivity:** Proved the convolution semigroup property:
   \[
   \operatorname{poissonLaw}(\mu, r) * \operatorname{poissonLaw}(\mu, s) = \operatorname{poissonLaw}(\mu, r+s),
   \]
   via antidiagonal summation and binomial coefficient expansion $\frac{(r+s)^n}{n!} = \sum_{k=0}^n \frac{r^k}{k!} \frac{s^{n-k}}{(n-k)!}$.
5. **Seed Process Semigroup:** Machine-checked that for any finite prime set $S$ and process times $u, v \in \mathbb{R}_{\ge 0}$:
   \[
   \operatorname{seedProcess}(S, u) * \operatorname{seedProcess}(S, v) = \operatorname{seedProcess}(S, u+v).
   \]

---

## 2. Machine-Verified Theorems

### 2.1 Poisson Mixture and Convolution Power Additivity

```lean
noncomputable def jumpPower (μ : Measure ℝ) : ℕ → Measure ℝ
  | 0 => Measure.dirac 0
  | n + 1 => μ ∗ jumpPower μ n

theorem jumpPower_add (μ : Measure ℝ) [IsProbabilityMeasure μ] (m n : ℕ) :
    jumpPower μ m ∗ jumpPower μ n = jumpPower μ (m + n)

theorem poissonPMF_add_antidiagonal (r s : ℝ≥0) (n : ℕ) :
    (∑ k ∈ Finset.antidiagonal n, poissonPMF r k.1 * poissonPMF s k.2) =
      poissonPMF (r + s) n

theorem poissonLaw_add (μ : Measure ℝ) [IsProbabilityMeasure μ] (r s : ℝ≥0) :
    poissonLaw μ r ∗ poissonLaw μ s = poissonLaw μ (r + s)
```

### 2.2 Seed Process Semigroup

```lean
noncomputable def seedProcess (S : Finset Nat.Primes) (u : ℝ≥0) : Measure ℝ :=
  poissonLaw (normalizedJump (PrimeSeedMass.levyMeasure S))
    (u * measureUnivNNReal (PrimeSeedMass.levyMeasure S))

theorem seedProcess_add (S : Finset Nat.Primes) (u v : ℝ≥0) :
    seedProcess S u ∗ seedProcess S v = seedProcess S (u + v)

theorem seedProcess_zero (S : Finset Nat.Primes) :
    seedProcess S 0 = Measure.dirac 0
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/PrimeSeedSemigroup.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.PrimeSeedProcess.seedProcess_add' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
