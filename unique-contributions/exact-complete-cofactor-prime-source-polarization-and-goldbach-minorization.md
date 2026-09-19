# Unique Contribution 320: Exact Complete Cofactor Prime Source Polarization and Goldbach Minorization

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialBinetGoldbachFinite.lean`](../../formalization/BuildingBlocks/FactorialBinetGoldbachFinite.lean), [`building-blocks/factorial-energy/binet-goldbach.md`](../../building-blocks/factorial-energy/binet-goldbach.md)  
**Classification:** Analytic Number Theory / Multiplicative Arithmetic / Prime Power Decomposition / Factorial Energy / Goldbach Minorization / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the factorial-clock and Binet-residual approach to arithmetic convolutions, the complete multiplicative-history prime source attached to a weight sequence $v : \mathbb{N} \to \mathbb{R}_{\ge 0}$ is defined by:
\[
S_v(n) = \sum_{m \mid n} v(m) \Lambda(n/m).
\]
When $v$ arises from the positive Binet residual of factorial clocks, it satisfies $v(m) \le v(2) \le v(1)$ for $m \ge 2$.

This contribution proves:

1. **Exact Prime-Composite Polarization:**  
   Under any positive, non-increasing proper cofactor sequence ($v(m) \le v(2) \le v(1)$ for $m \ge 2$):
   - At every prime $p$:
     \[
     S_v(p) = v(1) \log p.
     \]
   - At every composite $n \ge 2$:
     \[
     S_v(n) \le \frac{v(1) + v(2)}{2} \log n.
     \]
2. **Rational Hard Wall via Binet Ratio:**  
   When the cofactor weights satisfy the Binet ratio $40 v(2) \le 7 v(1)$:
   \[
   S_v(n) \le \frac{47}{80} v(1) \log n \qquad (\forall n \ge 2 \text{ composite}).
   \]
3. **Sharpness and Exact Attainment at $n = 4$:**  
   At the lowest composite prime power $n = 4 = 2^2$:
   \[
   S_v(4) = (v(1) + v(2)) \log 2 = \frac{v(1) + v(2)}{2} \log 4,
   \]
   proving that the bound $\frac{v(1)+v(2)}{2} \log n$ is optimal and attained.
4. **Exact Composite von Mangoldt Half-Log Bound:**  
   For every composite integer $n \ge 2$:
   \[
   \Lambda(n) \le \frac{1}{2} \log n.
   \]
5. **Exact Ordered Goldbach Minorization:**  
   For any additive total $k$:
   \[
   v(1)^2 \sum_{a+b=k} \Lambda(a) \Lambda(b) \le \sum_{a+b=k} S_v(a) S_v(b) = \text{goldbachPair}(v, k),
   \]
   establishing that the bare Goldbach convolution is an exact nonnegative subrow of the complete cofactor-pair convolution.

---

## 2. Mathematical Proof

### 2.1. Prime Value
For a prime $p$, the divisors are only $\{1, p\}$. Since $\Lambda(1) = 0$:
\[
S_v(p) = v(1) \Lambda(p) + v(p) \Lambda(1) = v(1) \log p.
\]

### 2.2. Composite Upper Bound
Isolate the $m = 1$ term from the divisor sum:
\[
S_v(n) = v(1) \Lambda(n) + \sum_{m \mid n, m > 1} v(m) \Lambda(n/m) \le v(1) \Lambda(n) + v(2) \sum_{m \mid n, m > 1} \Lambda(n/m).
\]
By the identity $\sum_{d \mid n} \Lambda(d) = \log n$, the tail sum is $\log n - \Lambda(n)$.
Thus:
\[
S_v(n) \le v(1) \Lambda(n) + v(2)(\log n - \Lambda(n)) = v(2) \log n + (v(1) - v(2)) \Lambda(n).
\]
For composite $n$, $\Lambda(n) \le \frac{1}{2} \log n$.
Since $v(1) \ge v(2)$, substituting this inequality yields:
\[
S_v(n) \le v(2) \log n + (v(1) - v(2)) \frac{\log n}{2} = \frac{v(1) + v(2)}{2} \log n.
\]

### 2.3. Rational Ratio
If $40 v(2) \le 7 v(1)$, then:
\[
\frac{v(1) + v(2)}{2} \le \frac{v(1) + \frac{7}{40} v(1)}{2} = \frac{47}{80} v(1).
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialBinetGoldbachFinite` in `formalization/BuildingBlocks/FactorialBinetGoldbachFinite.lean`):
```lean
theorem primeSource_prime_eq_direct (v : ℕ → ℝ)
    (hv : ∀ m, 0 ≤ v m) (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2)
    {p : ℕ} (hp : p.Prime) :
    primeSource v p = v 1 * Real.log (p : ℝ)

theorem primeSource_composite_le (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    primeSource v n ≤ (v 1 + v 2) / 2 * Real.log (n : ℝ)

theorem primeSource_composite_le_rational (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    primeSource v n ≤ (47 / 80 : ℝ) * v 1 * Real.log (n : ℝ)

theorem primeSource_four (v : ℕ → ℝ) :
    primeSource v 4 = (v 1 + v 2) * Real.log (2 : ℝ)

theorem direct_goldbach_le_pair (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m) (k : ℕ) :
    (v 1) ^ 2 *
        (∑ p ∈ Finset.antidiagonal k,
          ArithmeticFunction.vonMangoldt p.1 * ArithmeticFunction.vonMangoldt p.2) ≤
      goldbachPair v k
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Binet (1839) *Mémoire sur les intégrales définies eulériennes*; Hardy & Littlewood (1923) *Partitio Numerorum*; Montgomery & Vaughan (1973) *The large sieve*. Machine verification of complete cofactor prime source polarization, the 47/80 rational hard wall, and Goldbach minorization in Lean 4 is new.
- **Advancement:** Establishes an exact separation between prime and composite inputs in complete multiplicative-history sources, showing that composite contributions are strictly dampened by a factor of 47/80 under Binet ratios.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
