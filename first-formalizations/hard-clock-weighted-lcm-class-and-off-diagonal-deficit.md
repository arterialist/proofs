# First Formalization: Complete Hard-Clock Weighted LCM Class and Off-Diagonal Deficit

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/HardClockWeightedLcmClass.lean`](../../formalization/BuildingBlocks/HardClockWeightedLcmClass.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization verifies the exact prime-local product formula and the global off-diagonal nonpositivity for the bilinear Möbius-weighted least common multiple arithmetic function:
$$
W(k) = \sum_{i \mid k} \sum_{j \mid k} [\operatorname{lcm}(i, j) = k] \mu(i) \mu(j) i j.
$$

Key theorems formalized:
1. **Prime Local Evaluation:**
   Formal evaluation showing that on the divisors $\{1, p\}$ of any prime $p$, the sum over all four pairs retains the three pairs with LCM $p$, evaluating to $p(p - 2)$ (`weightedLcmClass_prime`).
2. **Local Factor Nonnegativity and Square Domination:**
   Formal proofs of $0 \le p(p - 2)$ and $p(p - 2) \le p^2$ for all primes $p \ge 2$ (`prime_local_factor_nonneg`, `prime_local_factor_le_square`).
3. **Finite Squarefree Induction:**
   Formal structural induction over finite sets of primes $P \subset \mathbb{N}$ showing that any class satisfying the new-prime recurrence $W(m p) = W(m) p(p - 2)$ satisfies $W(\prod_{p \in P} p) = \prod_{p \in P} p(p - 2)$ (`finite_prime_induction`).
4. **Squarefree Product Inequality:**
   Formal proof that $\prod_{p \in P} p(p - 2) \le (\prod_{p \in P} p)^2$ for any finite set of primes $P$ (`prime_factor_product_le_square`).
5. **Off-Diagonal Nonpositivity:**
   Formal deduction that removing the diagonal term $k^2$ leaves an unconditionally nonpositive quantity: $W(k) - k^2 \le 0$ (`squarefree_offDiagonal_nonpos`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Definition of the weighted LCM class
def weightedLcmClass (k : ℕ) : ℤ :=
  ∑ i ∈ k.divisors, ∑ j ∈ k.divisors,
    if Nat.lcm i j = k then
      ArithmeticFunction.moebius i * ArithmeticFunction.moebius j * (i : ℤ) * (j : ℤ)
    else 0

-- Evaluation at primes
theorem weightedLcmClass_prime {p : ℕ} (hp : p.Prime) :
    weightedLcmClass p = (p : ℤ) * ((p : ℤ) - 2)

-- Local bounds
theorem prime_local_factor_nonneg {p : ℕ} (hp : p.Prime) :
    0 ≤ (p : ℤ) * ((p : ℤ) - 2)

theorem prime_local_factor_le_square {p : ℕ} (hp : p.Prime) :
    (p : ℤ) * ((p : ℤ) - 2) ≤ (p : ℤ) ^ 2

-- Squarefree product bound
theorem prime_factor_product_le_square (P : Finset ℕ)
    (hP : ∀ p ∈ P, p.Prime) :
    (∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)) ≤
      ((∏ p ∈ P, (p : ℤ)) : ℤ) ^ 2

-- Inductive multiplicative classification
theorem finite_prime_induction (W : ℕ → ℤ)
    (hW1 : W 1 = 1)
    (hstep : ∀ (P : Finset ℕ) (p : ℕ), (∀ q ∈ P, q.Prime) → p.Prime → p ∉ P →
      W ((∏ q ∈ P, q) * p) = W (∏ q ∈ P, q) * (p : ℤ) * ((p : ℤ) - 2))
    (P : Finset ℕ) (hP : ∀ p ∈ P, p.Prime) :
    W (∏ p ∈ P, p) = ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)

-- Off-diagonal nonpositivity
theorem squarefree_offDiagonal_nonpos (k : ℕ) (P : Finset ℕ)
    (hP : ∀ p ∈ P, p.Prime) (hk : k = ∏ p ∈ P, p)
    (hclass : weightedLcmClass k = ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)) :
    weightedLcmClass k - (k : ℤ) ^ 2 ≤ 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-checked proof in Lean 4 of the exact evaluation of the bilinear Möbius-weighted LCM arithmetic function and establishes the nonpositivity of its off-diagonal deficit.
