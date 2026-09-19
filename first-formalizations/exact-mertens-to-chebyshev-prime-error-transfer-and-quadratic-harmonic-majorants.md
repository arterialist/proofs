# First Formalization: Exact Mertens-to-Chebyshev Prime Error Transfer and Quadratic Harmonic Majorants

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MertensPrimeTransfer.lean`](../../formalization/BuildingBlocks/MertensPrimeTransfer.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the divisor harmonic bound $\sum_{n \le K} \frac{d(n)}{n} \le H_K^2$, the centered divisor coefficient harmonic bound $\sum_{k \le K} \frac{|c_k|}{k} \le 4(1 + \log K)^2$, and the explicit effective Mertens-to-Chebyshev prime error transfer theorem in Lean 4:

1. **Divisor Harmonic Majorant:**
   Formal proof that $\sum_{n \le K} \frac{d(n)}{n} \le H_K^2$ via factor pairing (`divisorCard_harmonic_bound`).
2. **Centered Divisor Coefficient Bound:**
   Formal proof that $\sum_{k \le K} \frac{|c_k|}{k} \le 4(1 + \log K)^2$ (`centeredDivisorCoefficient_harmonic_bound`).
3. **Effective Prime Error Transfer Theorem:**
   Formal proof that $|M(N/k)| \le \eta \frac{N}{k}$ implies $|\psi(N) - N + 2\gamma| \le 4 \eta N (1 + \log K)^2 + \frac{39 N}{\sqrt{K+1}}$ (`primeError_bound_of_Mertens_quotients`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Divisor harmonic bound
theorem divisorCard_harmonic_bound (K : ℕ) :
    (∑ n ∈ Finset.Icc 1 K, (n.divisors.card : ℝ) / n) ≤ (harmonic K : ℝ) ^ 2

-- Centered divisor harmonic bound
theorem centeredDivisorCoefficient_harmonic_bound {K : ℕ} (hK : 1 ≤ K) :
    (∑ k ∈ Finset.Icc 1 K, |centeredDivisorCoefficient k| / k) ≤
      4 * (1 + Real.log K) ^ 2

-- Explicit Mertens-to-Chebyshev transfer
theorem primeError_bound_of_Mertens_quotients {N K : ℕ} (hN : 1 ≤ N)
    (hK : 1 ≤ K) (hKN : K ≤ N) {η : ℝ} (hη : 0 ≤ η)
    (hM : ∀ k ∈ Finset.Icc 1 K,
      |(mertens (N / k) : ℝ)| ≤ η * ((N : ℝ) / k)) :
    |integerError N + 2 * Real.eulerMascheroniConstant| ≤
      4 * η * N * (1 + Real.log K) ^ 2 + 39 * N / Real.sqrt ((K + 1 : ℕ) : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving an explicit, non-asymptotic transfer bound from the Mertens function to the Chebyshev prime error $\psi(N) - N + 2\gamma$ using the Dirichlet hyperbola method.
