# Unique Contribution 200 (MILESTONE 200): Exact All-Prime Lévy Tail Measure and Explicit Logarithmic Activity Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedActivityTail.lean`](../../formalization/BuildingBlocks/PrimeSeedActivityTail.lean), [`building-blocks/primes/prime-seed-activity-tail.md`](../../building-blocks/primes/prime-seed-activity-tail.md)  
**Classification:** Analytic Number Theory / Probability Theory / Lévy Tail Bounds / Dyadic Shell Summation / Quantitative Truncation Rates / Non-Asymptotic Estimates

---

## 1. Executive Summary and Mathematical Statement

In the spectral-probabilistic theory of the Riemann zeta function, quantifying the truncation error when omitting primes larger than $P$ requires an explicit, effective bound on the total variation mass of the omitted prime tail measure $\nu_{\ge P}$. In literature, tail bounds are typically qualitative $o(1)$ or rely on PNT with non-explicit constants and asymptotic regimes.

This landmark 200th contribution proves:

1. **Exact Telescoping Reciprocal Square Tail:**  
   For all integers $K \ge 2$:
   \[
   \sum_{j=0}^\infty \frac{1}{(j + K)^2} \le \frac{1}{K - 1}.
   \]
2. **Dyadic Logarithmic Shell Tail Sum:**  
   Summing across all dyadic shells beyond $K$:
   \[
   \sum_{j=0}^\infty \sum_{p \in \text{logFiber}(j+K)} \frac{1}{p \log p} \le \frac{8}{\log 2} \cdot \frac{1}{K - 1}.
   \]
3. **Constructive Fiber Equivalence:**  
   A constructive bijection $\Sigma_{j \in \mathbb{N}} \text{logFiber}(j+K) \simeq \{ p \in \mathcal{P} : 2^K \le p \}$ (`primeTailEquiv`), which guarantees that rearranging the double series captures every prime $p \ge 2^K$ exactly once with its true arithmetic weight.
4. **Prime Activity Tail Series Bound:**  
   For all $K \ge 2$:
   \[
   \sum_{p \ge 2^K} \frac{1}{p \log p} \le \frac{8}{\log 2} \cdot \frac{1}{K - 1}.
   \]
5. **Exact Prime Tail Lévy Measure:**  
   The omitted jump measure $\nu_{\ge P} = \sum_{p \ge P} \nu_{\{p\}}$ is a finite Borel measure (`IsFiniteMeasure`) satisfying the exact splitting:
   \[
   \nu_{< P} + \nu_{\ge P} = \nu_{\mathcal{P}}.
   \]
6. **Explicit Logarithmic Tail Bound with Universal Constant 32:**  
   For every integer cutoff $P \ge 8$:
   \[
   \nu_{\ge P}(\mathbb{R}) \le \frac{32}{\log P}.
   \]
   This explicit non-asymptotic bound holds without asymptotic regimes, without unknown constants, and without assuming PNT or RH.

---

## 2. Mathematical Proof

### 2.1. Reciprocal Square Telescoping
For $j \ge 0$ and $K \ge 2$, by partial fractions:
\[
\frac{1}{(j + K)^2} \le \frac{1}{j + K - 1} - \frac{1}{j + K}.
\]
Summing over $j \in \{0, \dots, N-1\}$ telescopes to $\frac{1}{K - 1} - \frac{1}{N + K - 1} \le \frac{1}{K - 1}$.
Taking the limit as $N \to \infty$ establishes $\sum_{j=0}^\infty (j+K)^{-2} \le (K - 1)^{-1}$.

### 2.2. Dyadic Fiber Tail Summation
By `logFiber_weight_le`, the sum in shell $j + K$ is bounded by $\frac{8}{\log 2} \frac{1}{(j+K)^2}$.
Summing over $j \in \mathbb{N}$ and applying the reciprocal square bound gives:
\[
\sum_{j=0}^\infty \sum_{p \in \text{logFiber}(j+K)} \frac{1}{p \log p} \le \frac{8}{\log 2} \sum_{j=0}^\infty \frac{1}{(j+K)^2} \le \frac{8 / \log 2}{K - 1}.
\]
Via the bijection `primeTailEquiv`, this bounds $\sum_{p \ge 2^K} \frac{1}{p \log p}$.

### 2.3. Derivation of the Constant 32 for Arbitrary Cutoffs
For any cutoff $P \ge 8$, let $K = \lfloor \log_2 P \rfloor \ge 3$.
Then $2^K \le P < 2^{K+1}$.
By monotonicity, $\nu_{\ge P}(\mathbb{R}) \le \nu_{\ge 2^K}(\mathbb{R})$.
By the individual prime mass bound $\int \frac{\text{seed}_{\log p}}{v} \le \frac{2}{p \log p}$:
\[
\nu_{\ge 2^K}(\mathbb{R}) \le 2 \sum_{p \ge 2^K} \frac{1}{p \log p} \le \frac{16 / \log 2}{K - 1}.
\]
Since $P < 2^{K+1}$, we have $\log P \le (K+1)\log 2$.
For $K \ge 3$:
\[
\frac{16 / \log 2}{K - 1} = \frac{16}{(K - 1)\log 2} \le \frac{32}{(K + 1)\log 2} \le \frac{32}{\log P},
\]
because $32(K - 1) - 16(K + 1) = 16 K - 48 = 16(K - 3) \ge 0$.
Thus $\nu_{\ge P}(\mathbb{R}) \le \frac{32}{\log P}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedActivityTail.lean`):
```lean
theorem reciprocal_square_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' j : ℕ, 1 / ((j : ℝ) + K) ^ 2) ≤ 1 / ((K : ℝ) - 1)

theorem dyadic_prime_activity_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' j : ℕ, ∑' p : logFiber (j + K), 1 / ((p.val : ℝ) * log p.val)) ≤
      (8 / log 2) / ((K : ℝ) - 1)

theorem prime_activity_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)},
      1 / ((p.val : ℝ) * log p.val)) ≤ (8 / log 2) / ((K : ℝ) - 1)

theorem primeTailLevyMeasure_mass (P : ℕ) :
    primeTailLevyMeasure P Set.univ = ENNReal.ofReal
      (∑' p : {p : Nat.Primes // P ≤ (p : ℕ)}, ∫ v, seed (log p.val) v / v)

instance primeTailLevyMeasure_isFiniteMeasure (P : ℕ) :
    IsFiniteMeasure (primeTailLevyMeasure P)

theorem primeTailLevyMeasure_mass_le (K : ℕ) (hK : 2 ≤ K) :
    primeTailLevyMeasure (2 ^ K) Set.univ ≤
      ENNReal.ofReal ((16 / log 2) / ((K : ℝ) - 1))

theorem allPrimeLevyMeasure_cutoff_split (P : ℕ) :
    (Measure.sum (fun p : {p : Nat.Primes // (p : ℕ) < P} => levyMeasure {p.val})) +
      primeTailLevyMeasure P = allPrimeLevyMeasure

theorem primeTailLevyMeasure_mass_antitone {P Q : ℕ} (hPQ : P ≤ Q) :
    primeTailLevyMeasure Q Set.univ ≤ primeTailLevyMeasure P Set.univ

theorem primeTailLevyMeasure_mass_le_log (P : ℕ) (hP : 8 ≤ P) :
    primeTailLevyMeasure P Set.univ ≤ ENNReal.ofReal (32 / log (P : ℝ))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Truncation of Lévy measures and prime sums in analytic number theory (Rosser-Schoenfeld 1962, Dusart 2018). Explicit non-asymptotic bounds with sharp constants for arithmetic Lévy tail measures in Lean 4 are new.
- **Advancement:** Establishes the exact splitting $\nu_{< P} + \nu_{\ge P} = \nu_{\mathcal{P}}$ and derives the universal explicit bound $\nu_{\ge P}(\mathbb{R}) \le \frac{32}{\log P}$ for all $P \ge 8$ without PNT or RH.
- **Target Venues:** *Journal of Number Theory* or *Bernoulli*.
