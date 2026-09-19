# Unique Contribution 257: Exact Arithmetic Correlation Support Cutoff and Prime-Power Bijection

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompleteArithmeticCorrelation.lean`](../../formalization/BuildingBlocks/CompleteArithmeticCorrelation.lean), [`building-blocks/correlation/complete-arithmetic-correlation.md`](../../building-blocks/correlation/complete-arithmetic-correlation.md)  
**Classification:** Analytic Number Theory / Arithmetic Functions / Von Mangoldt Function / Compact Support Correlation / Prime Powers Bijection / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The prime correlation matrix row evaluates the pairing between compactly supported test functions $f, g$ and the primes via:
\[
\text{arithmeticRow}(f, g) = \sum_{n=2}^\infty \frac{\Lambda(n)}{\sqrt{n}} \left( \text{correlation}(f, g)(\log n) + \overline{\text{correlation}(g, f)(\log n)} \right).
\]
Although defined as an infinite series, the compact support of $f$ and $g$ causes the cross-correlation $\text{correlation}(f, g)(x) = \int_{-\infty}^\infty g(v + x)\overline{f(v)} dv$ to vanish identically for sufficiently large displacement $x$.

This contribution proves:

1. **Exact Von Mangoldt Prime-Power Bijection:**  
   For any weight sequence $w : \mathbb{N} \to \mathbb{C}$ and cutoff $N \in \mathbb{N}$:
   \[
   \sum_{n=1}^N \Lambda(n) w(n) = \sum_{\substack{p \le N \\ p \text{ prime}}} \sum_{\substack{j \ge 1 \\ p^j \le N}} (\log p) w(p^j).
   \]
   This theorem provides a constructive machine-verified bijection between the arithmetic domain of prime powers $p^j \le N$ and the filter $\text{IsPrimePow}$ on $\{1, \dots, N\}$.
2. **Correlation Vanishing Outside Support Width:**  
   If $f, g$ have supports contained in $(a, b)$, then:
   \[
   \text{correlation}(f, g)(x) = 0 \quad \text{for all } x \ge b - a.
   \]
3. **Finite Truncation Equivalence:**  
   Whenever the integer truncation satisfies $N + 1 \ge e^{b - a}$:
   \[
   \text{arithmeticRow}(f, g) = \text{arithmeticCutoff}(N, f, g).
   \]
   The infinite series collapses unconditionally to a finite sum of length at most $\lfloor e^{b - a} \rfloor$.
4. **Exact Prime-Power Representation:**  
   For any cutoff $N$:
   \[
   \text{arithmeticCutoff}(N, f, g) = \sum_{\substack{p \le N \\ p \text{ prime}}} \sum_{\substack{j \ge 1 \\ p^j \le N}} \frac{\log p}{\sqrt{p^j}} \left( \text{correlation}(f, g)(j \log p) + \overline{\text{correlation}(g, f)(j \log p)} \right).
   \]

---

## 2. Mathematical Proof

### 2.1. Constructive Index Bijection
The von Mangoldt function is defined by $\Lambda(n) = \log p$ if $n = p^j$ for a prime $p$ and $j \ge 1$, and $\Lambda(n) = 0$ otherwise.
Define the index set $P = \{(p, j) \in [2, N] \times [1, N] \mid p \text{ is prime}, p^j \le N\}$ and $Q = \{n \in [1, N] \mid \text{IsPrimePow}(n)\}$.
- The mapping $\phi(p, j) = p^j$ is injective by the uniqueness of prime factorization ($p_1^{j_1} = p_2^{j_2} \implies p_1 = p_2$ and $j_1 = j_2$).
- The mapping $\phi$ is surjective onto $Q$ by definition of prime power.
- Summing over $Q$ and applying $\Lambda(p^j) = \log p$:
\[
\sum_{n \in Q} \Lambda(n) w(n) = \sum_{(p, j) \in P} (\log p) w(p^j) = \sum_{\substack{p \le N \\ p \text{ prime}}} \sum_{\substack{j \ge 1 \\ p^j \le N}} (\log p) w(p^j).
\]
Since $\Lambda(n) = 0$ for $n \notin Q$, the sum over $Q$ equals the sum over $\{1, \dots, N\}$.

### 2.2. Correlation Support Width
The cross-correlation is:
\[
\text{correlation}(f, g)(x) = \int_{\mathbb{R}} g(v + x) \overline{f(v)} \, dv.
\]
For the integrand to be non-zero at $v$, we must have $v \in (a, b)$ and $v + x \in (a, b)$.
This implies $a < v < b$ and $a < v + x < b$.
Thus $x < b - v < b - a$.
Therefore, if $x \ge b - a$, there is no $v$ where both factors are non-zero, and the integral vanishes identically.

### 2.3. Series Collapse
For $n \ge N + 1 \ge e^{b - a}$:
\[
\log n \ge \log(e^{b - a}) = b - a.
\]
By the width vanishing theorem, $\text{correlation}(f, g)(\log n) = 0$ and $\text{correlation}(g, f)(\log n) = 0$ for all $n > N$.
Thus $\text{arithmeticTerm}(f, g, n) = 0$ for all $n > N$, and the infinite sum $\sum_{n=2}^\infty$ equals the finite sum $\sum_{n=2}^N$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompleteArithmeticCorrelation` in `formalization/BuildingBlocks/CompleteArithmeticCorrelation.lean`):
```lean
theorem weighted_von_mangoldt_prime_powers (N : ℕ) (w : ℕ → ℂ) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n) =
      ∑ p ∈ Finset.Icc 2 N, if p.Prime then
        ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then (Real.log (p : ℝ) : ℂ) * w (p ^ j) else 0 else 0

theorem correlation_zero_of_width {f g : ℝ → ℂ} {a b x : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (hx : b - a ≤ x) :
    correlation f g x = 0

theorem arithmetic_row_eq_cutoff {f g : ℝ → ℂ} {a b : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (N : ℕ)
    (hN : Real.exp (b - a) ≤ (N : ℝ) + 1) :
    arithmeticRow f g = arithmeticCutoff N f g

theorem arithmetic_cutoff_eq_prime_powers (N : ℕ) (f g : ℝ → ℂ) :
    arithmeticCutoff N f g = primePowerCutoff N f g
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Explicit formulas and prime sums in spectral theory (Guinand 1948, Weil 1952, Burnol 2002). A machine-verified constructive bijection for $\sum \Lambda(n) w(n) = \sum (\log p) w(p^j)$ and the exact finitary collapse of correlation series for compactly supported test functions in Lean 4 is new.
- **Advancement:** Guarantees that arithmetic test matrices are finite and computable without truncation error whenever the test functions are compactly supported.
- **Target Venues:** *Journal of Number Theory* or *Journal of Functional Analysis*.
