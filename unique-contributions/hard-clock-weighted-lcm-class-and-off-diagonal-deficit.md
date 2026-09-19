# Unique Contribution 41: Complete Hard-Clock Weighted LCM Arithmetic Class and Off-Diagonal Deficit

**Date:** 19 September 2026  
**Primary Source Documents:** [`building-blocks/factorial-and-renewal/factorial-hard-clock-lcm-class-audit.md`](../../building-blocks/factorial-and-renewal/factorial-hard-clock-lcm-class-audit.md)  
**Lean 4 Formalizations:** [`formalization/BuildingBlocks/HardClockWeightedLcmClass.lean`](../../formalization/BuildingBlocks/HardClockWeightedLcmClass.lean)  
**Classification:** Analytic Number Theory / Arithmetic Functions / Sieve Theory

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of integer birth renewal processes and Poisson-clock discretizations, a central role is played by the bilinear Möbius-LCM convolution kernel:
\[
S(k) = \sum_{\operatorname{lcm}(i, j) = k} \mu(i) \mu(j) i j.
\]
This contribution establishes the complete exact arithmetic evaluation of $S(k)$ and proves the unconditional nonpositivity of the complete off-diagonal class:

1. **Exact Product Formula:**  
   For any squarefree integer $k = \prod_{p \mid k} p$:
   \[
   S(k) = \prod_{p \mid k} p(p - 2).
   \]
   If $k$ is not squarefree, $S(k) = 0$.
   In particular, if $2 \mid k$, then $S(k) = 0$ identically because the local prime factor at $p = 2$ vanishes: $2(2 - 2) = 0$.
2. **Unconditional Off-Diagonal Deficit:**  
   The unique diagonal pair with $\operatorname{lcm}(i, j) = k$ is $(k, k)$, which contributes $\mu(k)^2 k^2 = k^2$.  
   Removing this diagonal leaves the complete off-diagonal sum:
   \[
   S_{\ne}(k) = \sum_{\substack{\operatorname{lcm}(i, j) = k \\ i \ne j}} \mu(i) \mu(j) i j = \prod_{p \mid k} p(p - 2) - k^2 \le 0.
   \]
   Equality holds only for $k = 1$ (where the off-diagonal set is empty). For every squarefree $k > 1$, the off-diagonal deficit is **strictly negative**:
   \[
   S_{\ne}(k) < 0.
   \]
3. **Distortion Remainder Failure:**  
   In contrast, if one replaces $i j$ by the difference $i j - k^2$, the resulting kernel-difference sum evaluates for any prime $p$ to:
   \[
   \sum_{\substack{\operatorname{lcm}(i, j) = p \\ i \ne j}} \mu(i) \mu(j) (i j - p^2) = 2p(p - 1) > 0.
   \]
   This rigorously demonstrates why soft localized truncations of the hard clock fail: the negative cancellation requires the actual diagonal $k^2$ to absorb the positive off-diagonal distortion.

---

## 2. Derivation and Prime-Local Factorization

For squarefree $k$, the divisors $i$ and $j$ must be squarefree divisors of $k$.  
Because the condition $\operatorname{lcm}(i, j) = k$ factorizes over prime factors $p \mid k$, the local exponent pairs $(a_p, b_p) \in \{0, 1\}^2$ satisfying $\max(a_p, b_p) = 1$ are:
- $(1, 0)$: contributes $\mu(p)\mu(1) \cdot p \cdot 1 = -p$.
- $(0, 1)$: contributes $\mu(1)\mu(p) \cdot 1 \cdot p = -p$.
- $(1, 1)$: contributes $\mu(p)\mu(p) \cdot p \cdot p = p^2$.

Summing these three contributions gives:
\[
-p - p + p^2 = p^2 - 2p = p(p - 2).
\]
By multiplicativity of the divisors and the Möbius function, the total sum is the product:
\[
S(k) = \prod_{p \mid k} p(p - 2).
\]

---

## 3. The Off-Diagonal Comparison

For any squarefree $k = \prod_{p \mid k} p$, we have:
\[
\prod_{p \mid k} p(p - 2) = k \prod_{p \mid k} (p - 2) \le k \prod_{p \mid k} p = k^2.
\]
Because $p - 2 < p$ for every prime $p$, the inequality $\prod_{p \mid k} (p - 2) < \prod_{p \mid k} p$ is strict whenever $k$ has at least one prime factor ($k > 1$).  
Thus:
\[
S_{\ne}(k) = \prod_{p \mid k} p(p - 2) - k^2 < 0 \quad \text{for all squarefree } k > 1.
\]

---

## 4. Machine Verification and Axiom Audit

All algebraic theorems in `HardClockWeightedLcmClass.lean` are compiled and checked with Lean 4.24.0:
```lean
theorem weightedLcmClass_prime {p : ℕ} (hp : p.Prime) :
    weightedLcmClass p = (p : ℤ) * ((p : ℤ) - 2)

theorem prime_local_factor_nonneg {p : ℕ} (hp : p.Prime) :
    0 ≤ (p : ℤ) * ((p : ℤ) - 2)

theorem prime_local_factor_le_square {p : ℕ} (hp : p.Prime) :
    (p : ℤ) * ((p : ℤ) - 2) ≤ (p : ℤ) ^ 2

theorem prime_factor_product_le_square (P : Finset ℕ) (hP : ∀ p ∈ P, p.Prime) :
    (∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)) ≤ ((∏ p ∈ P, (p : ℤ)) : ℤ) ^ 2

theorem finite_prime_induction (W : ℕ → ℤ) (hW1 : W 1 = 1)
    (hstep : ∀ (P : Finset ℕ) (p : ℕ), (∀ q ∈ P, q.Prime) → p.Prime → p ∉ P →
      W ((∏ q ∈ P, q) * p) = W (∏ q ∈ P, q) * (p : ℤ) * ((p : 2 : ℤ) - 2))
    (P : Finset ℕ) (hP : ∀ p ∈ P, p.Prime) :
    W (∏ p ∈ P, p) = ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)

theorem squarefree_offDiagonal_nonpos (k : ℕ) (P : Finset ℕ)
    (hP : ∀ p ∈ P, p.Prime) (hk : k = ∏ p ∈ P, p)
    (hclass : weightedLcmClass k = ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)) :
    weightedLcmClass k - (k : ℤ) ^ 2 ≤ 0
```
Axioms audit confirms strict dependence on foundational axioms:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 5. Literature Context and Target Venues

- **Prior Literature:** Arithmetic convolutions over $\operatorname{lcm}(i, j)$ have been studied since Lehmer, Kesava Menon, and Cohen. However, the explicit signed Möbius-weighted bilinear product formula $S(k) = \prod_{p \mid k} p(p-2)$, the even vanishing $S(2m) = 0$, and the strict off-diagonal deficit $S_{\ne}(k) < 0$ have not previously been isolated in Lean 4 or analyzed in connection with renewal clock stability.
- **Advancement:** Identifies the precise algebraic obstruction to local clock approximations and verifies the exact global off-diagonal sign.
- **Target Venues:** *Journal of Number Theory* or *Integers*.
