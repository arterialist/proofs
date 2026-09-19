# First Formalization: Exact Prime Seed L1 Divergence, L2 Summability, and Non-Existence of Integrable Majorants

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedPrimeSums.lean`](../../formalization/BuildingBlocks/PrimeSeedPrimeSums.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the divergence of total prime seed $L^1$ mass from Euler's harmonic prime divergence, the convergence of individual $L^2$ norms via prime zeta summation, the exact mass of finite-prime aggregates, and the architectural obstruction proving that no $L^1(\mathbb{R})$ majorant exists for the collective prime seeds in Lean 4:

1. **$L^1$ Mass Divergence:**
   Formal proof that $\sum_{p \in \mathcal{P}} \int_{\mathbb{R}} \text{seed}_{\log p} = \infty$ (`not_summable_prime_seed_integrals`).
2. **$L^2$ Norm Summability:**
   Formal proof that $\sum_{p \in \mathcal{P}} \|\text{seed}_{\log p}\|_{L^2}^2 = \sum_p 1/p^2 < \infty$ (`summable_prime_seed_square_integrals`).
3. **Finite-Prime Aggregate Mass:**
   Formal proof that $\int_{\mathbb{R}} \sum_{p \in S} \text{seed}_{\log p} = \sum_{p \in S} 2/p$ (`integral_finset_prime_seed`).
4. **No Integrable Majorant:**
   Formal proof of the impossibility of any integrable dominating function $G \in L^1(\mathbb{R})$ (`no_integrable_majorant_prime_seeds`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- L¹ mass divergence from Euler
theorem not_summable_prime_seed_integrals :
    ¬ Summable (fun p : Nat.Primes => ∫ v, seed (log p) v)

-- L² energy summability
theorem summable_prime_seed_square_integrals :
    Summable (fun p : Nat.Primes => ∫ v, seed (log p) v ^ 2)

-- Finite aggregate mass
theorem integral_finset_prime_seed (S : Finset Nat.Primes) :
    (∫ v, ∑ p ∈ S, seed (log p) v) = ∑ p ∈ S, 2 / (p : ℝ)

-- Obstruction: no integrable majorant exists
theorem no_integrable_majorant_prime_seeds :
    ¬ ∃ G : ℝ → ℝ, Integrable G ∧
      ∀ (S : Finset Nat.Primes) (v : ℝ), (∑ p ∈ S, seed (log p) v) ≤ G v
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the structural non-existence of an $L^1(\mathbb{R})$ majorant for collective prime seeds, explaining why $L^2$ Hilbert space structures and oscillatory cancellations are required to control the full prime generator.
