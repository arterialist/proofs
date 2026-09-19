# Unique Contribution 323: Exact Cumulative Odd Goldbach Lacunary Chebyshev Convolution and Step Dynamics

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/GoldbachOddCumulativeFinite.lean`](../../formalization/BuildingBlocks/GoldbachOddCumulativeFinite.lean), [`building-blocks/goldbach-heat/odd-cumulative.md`](../../building-blocks/goldbach-heat/odd-cumulative.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Goldbach Convolutions / Chebyshev Error / Lacunary Dyadic Shifts / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

Odd additive totals $N = p_1 + p_2$ in the Goldbach problem require one of the summands to be even, hence a pure prime power $2^k$. In the cumulative sum over all odd totals up to a horizon $X$:
\[
\mathcal{C}_{\text{odd}}(X) = \sum_{N \le X, N \text{ odd}} \sum_{p_1 + p_2 = N} \Lambda(p_1) \Lambda(p_2),
\]
understanding the exact coupling between the discrete arithmetic error and the underlying prime counting function is critical.

This contribution proves:

1. **Exact Cumulative Dyadic Reindexing:**  
   Every ordered pair contributing to an odd total decomposes uniquely into a dyadic shift $2^k$ ($1 \le k \le \lfloor \log_2 X \rfloor$) and an odd partner $X - 2^k$:
   \[
   \mathcal{C}_{\text{odd}}(X) = 2 \log 2 \sum_{k=1}^{\lfloor \log_2 X \rfloor} \text{oddPartner}(X - 2^k),
   \]
   where $\text{oddPartner}(Y) = \psi(Y) - \lfloor \log_2 Y \rfloor \log 2$ retains every odd prime power and strips all even prime powers from the Chebyshev sum.
2. **Exact Lacunary Chebyshev Error Representation:**  
   Subtracting the standard counting baseline:
   \[
   \text{oddBaseline}(X) = 2 \log 2 \sum_{k=1}^{\lfloor \log_2 X \rfloor} \left( (X - 2^k) - \lfloor \log_2(X - 2^k) \rfloor \log 2 \right),
   \]
   the centered residual $\mathcal{R}_{\text{odd}}(X) = \mathcal{C}_{\text{odd}}(X) - \text{oddBaseline}(X)$ is an exact lacunary dyadic convolution of the Chebyshev error $E(Y) = \psi(Y) - Y$:
   \[
   \mathcal{R}_{\text{odd}}(X) = 2 \log 2 \sum_{k=1}^{\lfloor \log_2 X \rfloor} (\psi(X - 2^k) - (X - 2^k)).
   \]
3. **Exact Discrete Clock Derivative:**  
   One integer step $X \mapsto X + 1$ alters the cumulative residual by:
   \[
   \mathcal{R}_{\text{odd}}(X+1) - \mathcal{R}_{\text{odd}}(X) = 2 \log 2 \sum_{k=1}^{\lfloor \log_2 X \rfloor} (\Lambda(X + 1 - 2^k) - 1).
   \]
4. **Unconditional Lower Bound on Downward Drift:**  
   Because $\Lambda \ge 0$, the downward step change is strictly controlled by the number of active binary scales:
   \[
   \mathcal{R}_{\text{odd}}(X+1) - \mathcal{R}_{\text{odd}}(X) \ge -2 \log 2 \lfloor \log_2 X \rfloor.
   \]
5. **Odd-to-Even Binary Pair Collapse:**  
   When $X$ is odd, the shifted argument $X + 1 - 2^k$ is even. Its von Mangoldt value is non-zero if and only if it is a pure power of two $2^j$. Consequently, the prime contribution collapses completely to the explicit count of binary power pairs:
   \[
   \mathcal{R}_{\text{odd}}(X+1) - \mathcal{R}_{\text{odd}}(X) = 2 \log 2 \left( \log 2 \cdot \text{binaryPairCount}(X) - \lfloor \log_2 X \rfloor \right).
   \]

---

## 2. Mathematical Proof

### 2.1. Dyadic Reindexing
For odd $N = p_1 + p_2$, parity forces one summand to be even. An even prime power is of the form $2^k$. By symmetry of the ordered convolution, the factor is $2 \Lambda(2^k) = 2 \log 2$. The other summand must be odd, so $p_2 \in [1, X - 2^k]$ with $p_2$ odd. Summing over all odd $N \le X$ and swapping the order of summation gives the dyadic sum over $k \in [1, \lfloor \log_2 X \rfloor]$.

### 2.2. Error Convolution
Using $\text{oddPartner}(Y) = \psi(Y) - \lfloor \log_2 Y \rfloor \log 2$, subtracting the baseline removes the linear term $X - 2^k$ and the power-of-two count $\lfloor \log_2(X - 2^k) \rfloor \log 2$, leaving exactly $\psi(X - 2^k) - (X - 2^k) = E(X - 2^k)$.

### 2.3. Step Derivative and Parity Collapse
Taking differences at $X+1$ and $X$:
The top power $k = \lfloor \log_2(X+1) \rfloor$ (if new) has $X + 1 - 2^k = 0$, where $E(0) = 0$, so the index range restricts to $k \le \lfloor \log_2 X \rfloor$.
The difference $E((X - 2^k) + 1) - E(X - 2^k) = \Lambda(X + 1 - 2^k) - 1$.
When $X$ is odd, $X+1 - 2^k$ is even; the only nonzero values of $\Lambda$ on even numbers are $\log 2$ at powers of 2.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GoldbachOddCumulativeFinite` in `formalization/BuildingBlocks/GoldbachOddCumulativeFinite.lean`):
```lean
theorem cumulativeOdd_eq_power_sum (X : ℕ) :
    cumulativeOdd X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), oddPartner (X - 2 ^ k)

theorem oddResidual_eq_error_convolution (X : ℕ) :
    oddResidual X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), integerPrimeError (X - 2 ^ k)

theorem oddResidual_succ (X : ℕ) :
    oddResidual (X + 1) - oddResidual X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), (Λ (X + 1 - 2 ^ k) - 1)

theorem oddResidual_succ_lower (X : ℕ) :
    -(2 * Real.log 2) * (Nat.log 2 X : ℝ) ≤
      oddResidual (X + 1) - oddResidual X

theorem oddResidual_succ_odd (X : ℕ) (hodd : Odd X) :
    oddResidual (X + 1) - oddResidual X =
      2 * Real.log 2 *
        (Real.log 2 * binaryPairCount X - (Nat.log 2 X : ℝ))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hardy & Littlewood (1923) *Partitio Numerorum*; Vinogradov (1937) *Representation of an odd number as a sum of three prime numbers*; Vaughan (1997) *The Hardy-Littlewood Method*. Machine verification of exact cumulative odd Goldbach lacunary Chebyshev error convolutions and binary-power step collapse in Lean 4 is new.
- **Advancement:** Establishes that the cumulative odd Goldbach error is precisely governed by lacunary dyadic samples of the Chebyshev error $E(X - 2^k)$, with exact step dynamics on odd-to-even transitions controlled by binary power representations.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
