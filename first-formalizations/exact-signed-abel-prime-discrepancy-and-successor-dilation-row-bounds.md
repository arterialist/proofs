# First Formalization: Exact Signed Abel Prime Discrepancy and Successor Dilation Row Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCoarseParentSignedAbel.lean`](../../formalization/BuildingBlocks/SuccessorCoarseParentSignedAbel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact closed-interval Abel identity for prime discrepancy, the sharp $2B \cdot w(\text{lo})$ envelope bound for monotone weights, and the quotient dilation row estimate in Lean 4:

1. **Exact Discrete Abel Identity:**
   Formal proof of `actual_prime_discrepancy_abel`: Equating the weighted prime discrepancy $\sum_{d=\text{lo}}^{\text{hi}} (\Lambda(d)-1)w(d)$ to the discrete partial summation error.
2. **Universal Monotone Envelope Bound:**
   Formal proof of `actual_prime_discrepancy_uniform_bound`: Proving the non-asymptotic bound $\le 2 B \cdot w(\text{lo})$ under $|\psi(n)-n| \le B$.
3. **Singular Weight Evaluation:**
   Formal proofs of `actual_prime_discrepancy_inv_sqrt_bound` and `actual_prime_discrepancy_Ioc_inv_sqrt_bound`: Establishing explicit $2B/\sqrt{\text{lo}}$ and $2B/\sqrt{a+1}$ estimates for $w(d) = 1/\sqrt{d}$.
4. **Successor Dilation Quotient Identification & Row Bound:**
   Formal proofs of `child_dilations_eq_quotient_Ioc` and `child_dilation_signed_inv_sqrt_bound`: Connecting the infinite-dimensional matrix rows directly to discrete Chebyshev bounds.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact closed-interval Abel identity for the von Mangoldt discrepancy
theorem actual_prime_discrepancy_abel (w : ℕ → ℝ)
    {lo hi : ℕ} (hlo : 1 ≤ lo) (hhi : lo ≤ hi) :
    (∑ d ∈ Icc lo hi,
      (ArithmeticFunction.vonMangoldt d - 1) * w d) =
      partialSummationError integerError w lo hi

-- Universal non-asymptotic bound for monotone weights
theorem actual_prime_discrepancy_uniform_bound (w : ℕ → ℝ)
    {lo hi : ℕ} (hlo : 1 ≤ lo) (hhi : lo ≤ hi)
    {B : ℝ} (hB : 0 ≤ B)
    (hE : ∀ n ∈ Icc (lo - 1) hi, |integerError n| ≤ B)
    (hw_nonneg : ∀ n ∈ Icc lo hi, 0 ≤ w n)
    (hw_anti : ∀ n ∈ Ico lo hi, w (n + 1) ≤ w n) :
    |∑ d ∈ Icc lo hi,
      (ArithmeticFunction.vonMangoldt d - 1) * w d| ≤
      2 * B * w lo

-- Set identity between successor children and quotient intervals
theorem child_dilations_eq_quotient_Ioc
    {r n D : ℕ} (hn : 0 < n) (hD : D ≤ r / (n + 1)) :
    highParentChildren r n D = Ioc (r / (n + 1)) (r / n)

-- Grand signed row residual bound for the successor matrix
theorem child_dilation_signed_inv_sqrt_bound
    {r n D : ℕ} (hn : 0 < n) (hD : D ≤ r / (n + 1))
    (hinterval : r / (n + 1) < r / n)
    {B : ℝ} (hB : 0 ≤ B)
    (hE : ∀ k ∈ Icc (r / (n + 1)) (r / n), |integerError k| ≤ B) :
    |∑ d ∈ highParentChildren r n D,
      (ArithmeticFunction.vonMangoldt d - 1) / Real.sqrt d| ≤
      2 * B / Real.sqrt (r / (n + 1) + 1 : ℕ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the sharp $2 B \cdot w(\text{lo})$ envelope bound for signed prime discrepancies and applying it to bound dilation rows of the successor transfer operator.
