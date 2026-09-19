# First Formalization in Lean 4: Centered Complete-Admission Consumer and Finite Goldbach Mass Positivity

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/CenteredConsumerStructuralFinite.lean`](../../formalization/BuildingBlocks/CenteredConsumerStructuralFinite.lean)  
**Dependencies:** `Mathlib.NumberTheory.VonMangoldt`, `Mathlib.Tactic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the harmonic and additive analysis of prime histories, the centered complete-admission consumer evaluates the weighted Möbius prefix:
\[
P_n(q) := \sum_{k=1}^n \mu(k) q^k.
\]
Under clock scaling by powers $q^{n+1}$, the centered row obeys the recursive dynamics:
\[
q^{n+1} P_{n+1}(q) = q \left(q^n P_n(q)\right) + \mu(n+1) q^{2(n+1)}.
\]
The quadratic energy of this prefix expands under finite bilinear coupling as:
\[
P_N(q)^2 = \sum_{a=1}^N \sum_{b=1}^N \mu(a) \mu(b) q^{a+b}.
\]
Connecting multiplicative Möbius history directly to additive prime distribution, the Dirichlet convolution satisfies the identity:
\[
(\mu * \log)(n) = \sum_{d \mid n} \mu(d) \log(n/d) = \Lambda(n).
\]
Consequently, the complete dual Goldbach mass on an arbitrary finite box $[1, N]^2$:
\[
G(N) := \sum_{a=1}^N \sum_{b=1}^N \Lambda(a) \Lambda(b)
\]
identifies unconditionally with the square of the Chebyshev prime sum:
\[
G(N) = \left( \sum_{n=1}^N \Lambda(n) \right)^2 \ge 0,
\]
establishing unconditional non-negativity without asymptotic approximations.

This Lean 4 formalization machine-checks:
1. The exact successor recursion for $P_n(q)$ and its clock-scaled row.
2. The horizon and dyadic splitting theorems for finite prefix energies $\sum_{n < N} w_n P_n(q)^2$.
3. The arithmetic identity equating multiplicative history $\mu * \log$ to Mathlib's $\Lambda(n)$.
4. The exact double-Möbius sum representation of $P_N(q)^2$.
5. The complete finite Goldbach box mass formula and its unconditional positivity.
6. The abstract history observability consumer bounding prefix energy by history bounds.

---

## 2. Machine-Verified Theorems

### 2.1 Centered Prefix Recursion and Energy Splitting

```lean
def centeredPrefix (q : ℝ) (n : ℕ) : ℝ :=
  ∑ k ∈ Finset.Icc 1 n, (ArithmeticFunction.moebius k : ℝ) * q ^ k

theorem centeredPrefix_succ (q : ℝ) (n : ℕ) :
    centeredPrefix q (n + 1) = centeredPrefix q n +
      (ArithmeticFunction.moebius (n + 1) : ℝ) * q ^ (n + 1)

theorem scaled_centered_successor (q : ℝ) (n : ℕ) :
    q ^ (n + 1) * centeredPrefix q (n + 1) =
      q * (q ^ n * centeredPrefix q n) +
        (ArithmeticFunction.moebius (n + 1) : ℝ) * q ^ (2 * (n + 1))

theorem prefix_energy_split
    (q : ℝ) (w : ℕ → ℝ) {J N : ℕ} (hJN : J ≤ N) :
    (∑ n ∈ Finset.range N, w n * (centeredPrefix q n) ^ 2) =
      (∑ n ∈ Finset.range J, w n * (centeredPrefix q n) ^ 2) +
        ∑ n ∈ Finset.Ico J N, w n * (centeredPrefix q n) ^ 2
```

### 2.2 Complete Multiplicative History and Goldbach Mass

```lean
def completeHistory (n : ℕ) : ℝ :=
  ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
    ArithmeticFunction.log) n

theorem completeHistory_eq_vonMangoldt (n : ℕ) :
    completeHistory n = ArithmeticFunction.vonMangoldt n

theorem prefix_square_additive_coupling (q : ℝ) (N : ℕ) :
    (centeredPrefix q N) ^ 2 =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
        (ArithmeticFunction.moebius a : ℝ) *
          (ArithmeticFunction.moebius b : ℝ) * q ^ (a + b)

def goldbachMass (N : ℕ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
    ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b

theorem goldbachMass_eq_square (N : ℕ) :
    goldbachMass N =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n) ^ 2

theorem goldbachMass_nonneg (N : ℕ) : 0 ≤ goldbachMass N
```

### 2.3 Observability Consumer

```lean
theorem history_observability_consumer
    (prefixEnergy historyEnergy scale bound : ℝ)
    (hscale : 0 ≤ scale)
    (hobs : prefixEnergy ≤ scale * historyEnergy)
    (hhist : historyEnergy ≤ bound) :
    prefixEnergy ≤ scale * bound
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/CenteredConsumerStructuralFinite.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.CenteredConsumerStructuralFinite.centeredPrefix_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.scaled_centered_successor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.prefix_energy_horizon_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.prefix_energy_split' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.completeHistory_eq_vonMangoldt' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.prefix_square_additive_coupling' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.goldbachMass_eq_square' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.goldbachMass_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CenteredConsumerStructuralFinite.history_observability_consumer' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on the standard foundational axioms.
