# Contribution 328: Exact Harmonic Phase Defect Domination and LCM Valuation Overlap Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/HarmonicPrimePhase.lean`](../../formalization/BuildingBlocks/HarmonicPrimePhase.lean), [`building-blocks/harmonic-weights/phase.md`](../../building-blocks/harmonic-weights/phase.md)  
**Classification:** Analytic Number Theory / Arithmetic Dynamics / Phase Synchronization / Valuation Theory / LCM Divisibility / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

Understanding the phase alignment of arithmetic sequences $n^{it}$ across composite integers without relying on asymptotic prime number theorems requires exact finite averaging bounds.

This contribution proves:

1. **Exact Finite Harmonic Phase Defect Domination:**  
   For any truncation horizon $N \ge 1$ and real parameter $t \in \mathbb{R}$, the harmonic average of composite phase deficits $\|1 - n^{it}\|^2$ is unconditionally dominated by the weighted sum of prime phase defects:
   $$
   \mathcal{D}_N(t) = \frac{1}{H_N} \sum_{n=1}^N \frac{\|1 - \chi_t(n)\|^2}{n} \le \sum_{p \in \text{admittedPrimes}(N)} w_N(p) \|1 - \chi_t(p)\|^2,
   $$
   where $w_N(p) = \frac{1}{H_N} \sum_{n=1}^N \frac{\Omega(n) v_p(n)}{n}$.
2. **Exact Representation of $p$-Adic Valuations as Divisor Indicators:**  
   For any prime $p$ and integer $n$:
   $$
   v_p(n) = \sum_{i=1}^{n-1} \mathbf{1}_{p^i \mid n}.
   $$
3. **Exact LCM Representation of Valuation Overlaps:**  
   For any primes $p, q$ (distinct or identical), the cross-product of $p$-adic and $q$-adic valuations is an exact 2D sum over LCM divisibility conditions:
   $$
   v_p(n) v_q(n) = \sum_{i=1}^{n-1} \sum_{j=1}^{n-1} \mathbf{1}_{\text{lcm}(p^i, q^j) \mid n}.
   $$
4. **Exact Maximum-Power Overlap on the Diagonal:**  
   When $p = q$, the least common multiple collapses to $\text{lcm}(p^i, p^j) = p^{\max(i, j)}$, yielding:
   $$
   v_p(n)^2 = \sum_{i=1}^{n-1} \sum_{j=1}^{n-1} \mathbf{1}_{p^{\max(i, j)} \mid n}.
   $$

---

## 2. Mathematical Proof

### 2.1. Harmonic Phase Defect Domination
From prime phase factorization, for every integer $n$, $\|1 - n^{it}\|^2 \le \Omega(n) \sum_{p \mid n} v_p(n) \|1 - p^{it}\|^2$.
Dividing by $n$, summing over $n \in [1, N]$, dividing by $H_N = \sum_{n=1}^N 1/n$, and swapping the order of summation establishes the bound with harmonic weights $w_N(p)$.

### 2.2. Valuation LCM Overlap
$p^i \mid n$ and $q^j \mid n \iff \text{lcm}(p^i, q^j) \mid n$.
Multiplying the indicator representations $\sum_i \mathbf{1}_{p^i \mid n}$ and $\sum_j \mathbf{1}_{q^j \mid n}$ yields $\sum_{i, j} \mathbf{1}_{\text{lcm}(p^i, q^j) \mid n}$.
When $p = q$, the exponent of $p$ dividing $n$ must be at least $\max(i, j)$, so $\text{lcm}(p^i, p^j) = p^{\max(i, j)}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`ArithmeticDynamics` in `formalization/BuildingBlocks/HarmonicPrimePhase.lean`):
```lean
theorem harmonicPhaseDefect_le_prime_sum (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    harmonicPhaseDefect N t ≤
      ∑ p ∈ admittedPrimes N, harmonicPrimeWeight N p *
        ‖1 - logarithmicPrimePhase t p‖ ^ 2

theorem valuation_overlap_eq_lcm_sum (n p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (n.factorization p : ℝ) * (n.factorization q : ℝ) =
      ∑ i ∈ Finset.Ico 1 n, ∑ j ∈ Finset.Ico 1 n,
        if Nat.lcm (p ^ i) (q ^ j) ∣ n then (1 : ℝ) else 0

theorem same_prime_valuation_sq_eq_max_sum (n p : ℕ) (hn : n ≠ 0) (hp : p.Prime) :
    (n.factorization p : ℝ) ^ 2 =
      ∑ i ∈ Finset.Ico 1 n, ∑ j ∈ Finset.Ico 1 n,
        if p ^ max i j ∣ n then (1 : ℝ) else 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Halász (1968) *Über die Mittelwerte multiplikativer zahlentheoretischer Funktionen*; Elliott (1979) *Probabilistic Number Theory*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects composite phase fluctuations directly to prime phase deficits without spectral gap assumptions, expressing all valuation moments via exact LCM divisibility lattices.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
