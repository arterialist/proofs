# First Formalization: Exact Prime Seed Pointwise Envelopes and Explicit Finite-Prime Square Tail Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedPointwise.lean`](../../formalization/BuildingBlocks/PrimeSeedPointwise.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes uniform pointwise envelopes for continuous prime successor seeds, explicit dyadic prime shell estimates, and effective finite tail bounds $\sum_{p \in S} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y}$ in Lean 4:

1. **Global Uniform Pointwise Envelope:**
   Formal proof that $\text{seed}_L(v) \le e^{-v/2}$ globally (`seed_le_exp_neg_half`).
2. **Piecewise Clock Envelopes:**
   Formal proofs of upper and exact envelopes on initial clock intervals (`prime_seed_first_envelope`, `prime_seed_second_envelope`).
3. **Finite Prime Log-Square Tail:**
   Formal proof that $\sum_{p \in S} \frac{\log p}{p^2} \le \frac{32 \log 2}{Y}$ for any finite set $S$ with $p > Y \ge 2$ (`finite_prime_log_square_tail`).
4. **Explicit Prime Zeta Square Tail Bound:**
   Formal proof that $\sum_{p \in S} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y}$ (`finite_prime_square_tail`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Uniform pointwise exponential envelope
theorem seed_le_exp_neg_half {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v ≤ exp (-v / 2)

-- First-cell upper envelope
theorem prime_seed_first_envelope {p v : ℝ} (hp : 1 < p) (hv : v < 2 * log p) :
    seed (log p) v ≤ exp (v / 2) / p ^ 2

-- Second-cell exact envelope
theorem prime_seed_second_envelope {p v : ℝ} (hp : 1 < p)
    (hlo : 2 * log p ≤ v) (hhi : v < 3 * log p) :
    seed (log p) v = exp (v / 2) / p ^ 3

-- Explicit log-square tail bound
theorem finite_prime_log_square_tail (S : Finset Nat.Primes) {Y : ℝ} (hY : 2 ≤ Y)
    (hlo : ∀ p ∈ S, Y < (p : ℝ)) :
    (∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2) ≤ (32 * log 2) / Y

-- Explicit unweighted square tail bound
theorem finite_prime_square_tail (S : Finset Nat.Primes) {Y : ℝ} (hY : 2 ≤ Y)
    (hlo : ∀ p ∈ S, Y < (p : ℝ)) :
    (∑ p ∈ S, 1 / (p : ℝ) ^ 2) ≤ (32 * log 2) / (Y * log Y)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving uniform global decay $\text{seed}_L(v) \le e^{-v/2}$ and establishing completely explicit, non-asymptotic prime square tail bounds $\sum_{p \in S} \frac{1}{p^2} \le \frac{32 \log 2}{Y \log Y}$ without using $\mathcal{O}$-notation.
