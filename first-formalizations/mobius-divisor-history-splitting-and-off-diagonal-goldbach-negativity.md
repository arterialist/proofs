# First Formalization: Möbius Divisor History Splitting and Off-Diagonal Goldbach Negativity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CenteredGoldbachHistoryShellFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachHistoryShellFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Möbius divisor history expansion of binary Goldbach prime correlations, proving sign definiteness of diagonal and off-diagonal blocks in Lean 4:

1. **History Expansion:**
   Formal proof that $\Lambda(m)\Lambda(n) = \sum_{de | m, fg | n} \mu(d)\mu(f) \log e \log g$ (`pairHistory_eq_prime_pair`).
2. **Diagonal/Off-Diagonal Decomposition:**
   Formal splitting into matching ($d = f$) and distinct ($d \ne f$) divisor channels (`primeCoefficient_history_split`).
3. **Diagonal Positivity and Dominance:**
   Formal proof that $\text{diagonalCoefficient}(Y, N) \ge 0$ (`diagonalCoefficient_nonneg`) and $\log m \log n \le \text{diagonalHistory}(m, n)$ (`log_pair_le_diagonalHistory`).
4. **Universal Off-Diagonal Negativity:**
   Formal derivation of $\text{offDiagonalCoefficient}(Y, N) \le 0$ (`offDiagonalCoefficient_nonpos`).
5. **Concrete Negative Witness:**
   Formal evaluation of $\text{offDiagonalHistory}(2, 4) = -(\log 2)^2$ and $\text{offDiagonalCoefficient}(4, 6) = -2(\log 2)^2 < 0$ (`offDiagonalCoefficient_four_six_neg`).
6. **Parity Obstruction:**
   Formal proof that matching divisor labels $d$ must be odd whenever the Goldbach sum $N$ is odd (`diagonal_label_odd_of_odd_total`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Equivalence with prime-pair von Mangoldt product
theorem pairHistory_eq_prime_pair (m n : ℕ) :
    pairHistory m n =
      ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n

-- Splitting into diagonal and off-diagonal history blocks
theorem primeCoefficient_history_split (Y N : ℕ) :
    truncatedPrimeCoefficient Y N =
      diagonalCoefficient Y N + offDiagonalCoefficient Y N

-- Diagonal common label divides sum; odd total forces odd label
theorem diagonal_label_odd_of_odd_total {m n N d e f : ℕ}
    (hm : m = d * e) (hn : n = d * f) (hN : m + n = N)
    (hodd : Odd N) : Odd d

-- Nonnegativity of diagonal block
theorem diagonalCoefficient_nonneg (Y N : ℕ) :
    0 ≤ diagonalCoefficient Y N

-- Logarithmic pair is bounded by diagonal history
theorem log_pair_le_diagonalHistory {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    log m * log n ≤ diagonalHistory m n

-- Off-diagonal block is universally nonpositive
theorem offDiagonalCoefficient_nonpos (Y N : ℕ) :
    offDiagonalCoefficient Y N ≤ 0

-- Explicit negative witness at N = 6
theorem offDiagonalCoefficient_four_six :
    offDiagonalCoefficient 4 6 = -2 * (log 2) ^ 2

theorem offDiagonalCoefficient_four_six_neg :
    offDiagonalCoefficient 4 6 < 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 decomposing binary Goldbach sums through Möbius divisor histories into an unconditionally non-negative diagonal block and an unconditionally non-positive off-diagonal block with explicit negative witnesses.
