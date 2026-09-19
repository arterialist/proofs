# First Formalization: Exact Harmonic Phase Defect Domination and LCM Valuation Overlap Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/HarmonicPrimePhase.lean`](../../formalization/BuildingBlocks/HarmonicPrimePhase.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact domination of composite harmonic phase defect by prime phase defects, and establishes the LCM representation of valuation overlaps in Lean 4:

1. **Definitions of Phase Weights and Deficit:**
   Formal definitions of `primeMultiplicity` ($\Omega(n)$), `admittedPrimes`, `phaseHarmonicMass`, `harmonicPhaseDefect`, and `harmonicPrimeWeight`.
2. **Positivity and Support Lemmas:**
   Formal proofs of `phaseHarmonicMass_pos`, `primeMultiplicity_nonneg`, `harmonicPrimeWeight_nonneg`, `primeFactors_subset_admitted`, and `phase_prime_sum_admitted`.
3. **Harmonic Defect Inequality:**
   Formal proof of `harmonicPhaseDefect_le_prime_sum`.
4. **Valuation Divisor and LCM Identities:**
   Formal proofs of `valuation_eq_sum_power_divisors`, `valuation_overlap_eq_lcm_sum`, and `same_prime_valuation_sq_eq_max_sum`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact harmonic phase defect upper bound by prime phase defects
theorem harmonicPhaseDefect_le_prime_sum (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    harmonicPhaseDefect N t ≤
      ∑ p ∈ admittedPrimes N, harmonicPrimeWeight N p *
        ‖1 - logarithmicPrimePhase t p‖ ^ 2

-- Exact valuation cross-product as LCM divisibility sum
theorem valuation_overlap_eq_lcm_sum (n p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (n.factorization p : ℝ) * (n.factorization q : ℝ) =
      ∑ i ∈ Finset.Ico 1 n, ∑ j ∈ Finset.Ico 1 n,
        if Nat.lcm (p ^ i) (q ^ j) ∣ n then (1 : ℝ) else 0

-- Diagonal valuation square as maximum power divisibility sum
theorem same_prime_valuation_sq_eq_max_sum (n p : ℕ) (hn : n ≠ 0) (hp : p.Prime) :
    (n.factorization p : ℝ) ^ 2 =
      ∑ i ∈ Finset.Ico 1 n, ∑ j ∈ Finset.Ico 1 n,
        if p ^ max i j ∣ n then (1 : ℝ) else 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the harmonic phase defect domination theorem and expressing $p$-adic valuation cross-moments as exact LCM divisibility sums.
