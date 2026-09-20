# Contribution 321: Exact Goldbach Successor Logarithmic Escape and Chebyshev Symmetric Reduction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/GoldbachSuccessorLogFinite.lean`](../../formalization/BuildingBlocks/GoldbachSuccessorLogFinite.lean), [`building-blocks/goldbach-heat/successor-log.md`](../../building-blocks/goldbach-heat/successor-log.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Goldbach Convolutions / Chebyshev Functions / Logarithmic Transport Loss / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the discrete transport dynamics of Goldbach additive pairs across successive scales $s$, the logarithmic factor measuring the relative expansion probability of pairs $(m, n)$ with $m + n \le s$ is:
$$
\text{logPair}(s, m, n) = \log\left(\frac{s-m}{m}\right) + \log\left(\frac{s-n}{n}\right) = \log\left( \frac{(s-m)(s-n)}{mn} \right).
$$
The total logarithmic escape loss over the additive triangle is given by the double sum:
$$
\mathcal{L}(s) = \sum_{m=2}^s \sum_{n=2}^s \mathbf{1}_{m+n \le s} \Lambda(m) \Lambda(n) \left[ \log\left(\frac{s-m}{m}\right) + \log\left(\frac{s-n}{n}\right) \right].
$$

This contribution proves:

1. **Exact Pointwise Non-Negativity of Pair Transport Loss:**  
   Every pair $(m, n)$ in the admitted additive triangle $m \ge 2, n \ge 2, m + n \le s$ satisfies:
   $$
   \text{logPair}(s, m, n) \ge 0,
   $$
   because $n \le s - m \implies \log n \le \log(s-m)$ and $m \le s - n \implies \log m \le \log(s-n)$.
   Consequently, the total logarithmic escape loss is unconditionally non-negative at every finite horizon:
   $$
   \frac{\mathcal{L}(s)}{s^2} \ge 0 \qquad (\forall s \in \mathbb{N}).
   $$
2. **Exact Symmetric Reduction to a Single Chebyshev Convolution:**  
   By exchanging summation variables $m \leftrightarrow n$, the double sum over the triangle collapses identically to twice a single Chebyshev-weighted convolution:
   $$
   \mathcal{L}(s) = 2 \sum_{m=2}^s \Lambda(m) \psi(s-m) \log\left(\frac{s-m}{m}\right).
   $$
3. **Exact Finite Horizon Trimming to $s-2$:**  
   Because the Chebyshev function vanishes at inputs $0$ and $1$ ($\psi(0) = \psi(1) = 0$), the cofactor sum terminates strictly at the interior boundary $s - 2$:
   $$
   \frac{\mathcal{L}(s)}{s^2} = \frac{2}{s^2} \sum_{m=2}^{s-2} \Lambda(m) \psi(s-m) \log\left(\frac{s-m}{m}\right) \qquad (\forall s \ge 4).
   $$
4. **Exact Rational Cofactor Decomposition:**  
   The rational Chebyshev cofactor sum splits into the baseline prime counting mass $\psi(s-2)$ and the complete signed Chebyshev remainder:
   $$
   \sum_{m=2}^{s-2} \frac{\Lambda(m) \psi(s-m)}{s-m} = \psi(s-2) + \sum_{m=2}^{s-2} \Lambda(m) \frac{\psi(s-m) - (s-m)}{s-m}.
   $$

---

## 2. Mathematical Proof

### 2.1. Pointwise Positivity
For $m \ge 2, n \ge 2$ with $m + n \le s$:
$n \le s - m \implies \log n \le \log(s-m) \implies \log(s-m) - \log n \ge 0$.
Similarly, $m \le s - n \implies \log(s-n) - \log m \ge 0$.
Adding the two inequalities gives:
$$
(\log(s-m) - \log m) + (\log(s-n) - \log n) \ge 0.
$$

### 2.2. Symmetric Reduction
Split $\text{logPair}(s, m, n) = \text{logLeg}(s, m) + \text{logLeg}(s, n)$:
$$
\mathcal{L}(s) = \sum_{m, n} \mathbf{1}_{m+n \le s} \Lambda(m) \Lambda(n) \text{logLeg}(s, m) + \sum_{m, n} \mathbf{1}_{m+n \le s} \Lambda(m) \Lambda(n) \text{logLeg}(s, n).
$$
By Fubini / Finset summation swap, the second term equals the first.
In the first term, sum over $n$:
$$
\sum_{n=2, n \le s-m}^s \Lambda(n) = \psi(s-m).
$$
Hence the sum simplifies directly to $2 \sum_{m=2}^s \Lambda(m) \psi(s-m) \text{logLeg}(s, m)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GoldbachSuccessorLogFinite` in `formalization/BuildingBlocks/GoldbachSuccessorLogFinite.lean`):
```lean
theorem logPair_nonneg {s m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n)
    (had : m + n ≤ s) : 0 ≤ logPair s m n

theorem logEscape_nonneg (s : ℕ) : 0 ≤ logEscape s

theorem logPair_eq_log_ratio {s m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n)
    (had : m + n ≤ s) :
    logPair s m n =
      Real.log
        ((((s - m : ℕ) : ℝ) * ((s - n : ℕ) : ℝ)) /
          ((m : ℝ) * (n : ℝ)))

theorem logEscapeNumerator_eq_psi (s : ℕ) :
    logEscapeNumerator s =
      2 * ∑ m ∈ Icc 2 s,
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m

theorem logEscape_eq_psi_trim (s : ℕ) (hs : 4 ≤ s) :
    logEscape s =
      (2 * ∑ m ∈ Icc 2 (s - 2),
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m) /
        (s : ℝ) ^ 2

theorem rationalCofactor_eq_baseline_add_error (s : ℕ) (hs : 4 ≤ s) :
    (∑ m ∈ Icc 2 (s - 2),
      Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) /
        ((s - m : ℕ) : ℝ)) =
      BuildingBlocks.CoarsePrimitive.psi (s - 2) + signedCofactorError s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hardy & Littlewood (1923) *Some problems of 'Partitio Numerorum'*; Chebyshev (1852) *Mémoire sur les nombres premiers*; Vinogradov (1937) *Representation of an odd number as a sum of three prime numbers*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact algebraic reduction of the 2D Goldbach logarithmic transport loss to a single 1D Chebyshev convolution, proving unconditional non-negativity without asymptotic approximations.
- **Target Venues:** *Integers* or *Acta Arithmetica*.
