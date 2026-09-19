# First Formalization: Exact Harmonic Prime Weight Square-Shell Summation and Closed Arithmetic Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/HarmonicPrimeWeightBound.lean`](../../formalization/BuildingBlocks/HarmonicPrimeWeightBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact square-shell count identity for maximums of exponents, the closed geometric bound for same-prime reciprocal sums, and the closed arithmetic bound on harmonic prime weights in Lean 4:

1. **Definitions of Prime Power Reciprocal Sums:**
   Formal definitions of `primePowerReciprocalSum` and `samePrimeReciprocalSum`.
2. **Harmonic Mass and Base LCM Lemmas:**
   Formal proofs of `phaseHarmonicMass_mono` and `same_base_lcm_pow`.
3. **Square-Shell 2D Identity:**
   Formal proof of `sum_pow_max_Ico` ($\sum_{i,j < N} r^{\max(i, j)} = \sum_{j < N} (2j-1) r^j$).
4. **Geometric Series Bounds:**
   Formal proofs of `positive_geometric_sum_le` and `same_geometric_sum_le` ($\le r(1+r)/(1-r)^2$).
5. **Decoupled Closed Arithmetic Bound:**
   Formal proofs of `reciprocal_lcm_sum_eq`, `primePowerReciprocalSum_le`, `samePrimeReciprocalSum_le`, `harmonicPrimeWeight_le_finite_geometric`, and `harmonicPrimeWeight_le_closed`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact square shell decomposition of maximum exponent grid
lemma sum_pow_max_Ico (N : ℕ) (r : ℝ) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, r ^ max i j) =
      ∑ j ∈ Finset.Ico 1 N, (2 * (j : ℝ) - 1) * r ^ j

-- Exact infinite geometric bound on square shell sum
lemma same_geometric_sum_le (N : ℕ) {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, r ^ max i j) ≤
      r * (1+r) / (1-r)^2

-- Same-prime reciprocal sum bounded by (p+1)/(p-1)^2
lemma samePrimeReciprocalSum_le (N p : ℕ) (hp : p.Prime) :
    samePrimeReciprocalSum N p ≤ ((p : ℝ) + 1) / ((p : ℝ) - 1)^2

-- Complete orthogonal decoupling of distinct primes in reciprocal LCM sum
lemma reciprocal_lcm_sum_eq (N p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
      1 / (Nat.lcm (p ^ i) (q ^ j) : ℝ)) =
    if q = p then samePrimeReciprocalSum N p
    else primePowerReciprocalSum N p * primePowerReciprocalSum N q

-- Closed arithmetic bound on harmonic prime weights
theorem harmonicPrimeWeight_le_closed (N p : ℕ) (hN : 1 ≤ N) (hp : p.Prime) :
    harmonicPrimeWeight N p ≤ ((p : ℝ) + 1) / ((p : ℝ) - 1)^2 +
      (1 / ((p : ℝ) - 1)) *
        ∑ q ∈ (admittedPrimes N).filter (fun q => q ≠ p), 1 / ((q : ℝ) - 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact 2D square-shell identity for maximums of exponents and deriving the closed rational arithmetic upper bound for harmonic prime weights on LCM lattices.
