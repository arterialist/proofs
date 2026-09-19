# First Formalization: Exact Dyadic Chebyshev Shell Inverse-Square Bound and PNT-Free Prime Summability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedActivityBound.lean`](../../formalization/BuildingBlocks/PrimeSeedActivityBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the inverse-square logarithmic shell bound and Basel majorization of the prime reciprocal series without assuming the Prime Number Theorem in Lean 4:

1. **Chebyshev Majorization and Weight Bounds:**
   Formal proof that $\sum_{p \in S} \log p \le \psi(M)$ (`sum_log_primes_le_psi`) and logarithmic weight comparison.
2. **Inverse-Square Logarithmic Shell Bound:**
   Formal proof that for any dyadic shell $S \subseteq [N, 2N]$, $\sum_{p \in S} \frac{1}{p \log p} \le \frac{8 \log 2}{\log^2 N}$ (`prime_shell_activity_le`).
3. **Logarithmic Fiber Discretization:**
   Formal proof that dyadic fibers $\text{logFiber}(k)$ are finite (`finite_logFiber`) and satisfy $\sum_{p \in \text{logFiber}(k)} \frac{1}{p \log p} \le \frac{8}{\log 2} \frac{1}{k^2}$ (`logFiber_weight_le`).
4. **PNT-Free Unconditional Summability:**
   Formal proof that $\sum_{p \in \mathcal{P}} \frac{1}{p \log p} < \infty$ by majorization against the Basel series (`summable_prime_reciprocal_mul_log`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Majorization of prime log sums by Chebyshev psi
theorem sum_log_primes_le_psi (S : Finset ℕ) (M : ℕ)
    (hprime : ∀ p ∈ S, p.Prime) (hM : ∀ p ∈ S, p ≤ M) :
    (∑ p ∈ S, log (p : ℝ)) ≤ BuildingBlocks.CoarsePrimitive.psi M

-- Inverse-square logarithmic shell bound
theorem prime_shell_activity_le (S : Finset ℕ) (N : ℕ) (hN : 2 ≤ N)
    (hprime : ∀ p ∈ S, p.Prime)
    (hlo : ∀ p ∈ S, N ≤ p) (hhi : ∀ p ∈ S, p ≤ 2 * N) :
    (∑ p ∈ S, 1 / ((p : ℝ) * log p)) ≤ 8 * log 2 / log (N : ℝ) ^ 2

-- Dyadic logarithmic fiber bound
theorem logFiber_weight_le {k : ℕ} (hk : 1 ≤ k) :
    (∑' p : logFiber k, 1 / ((p.val : ℝ) * log p.val)) ≤
      (8 / log 2) * (1 / (k : ℝ) ^ 2)

-- Unconditional summability over all primes
theorem summable_prime_reciprocal_mul_log :
    Summable (fun p : Nat.Primes => 1 / ((p : ℝ) * log p))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that Chebyshev's linear bound $\psi(M) \le C M$ implies the inverse-square bound $\frac{8 \log 2}{\log^2 N}$ on prime shells, establishing the finite total activity of prime renewal measures without PNT.
