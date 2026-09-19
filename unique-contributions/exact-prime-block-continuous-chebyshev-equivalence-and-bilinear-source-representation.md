# Unique Contribution 191: Exact Prime Block Continuous Chebyshev Equivalence and Bilinear Source Representation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeBlockSource.lean`](../../formalization/BuildingBlocks/PrimeBlockSource.lean), [`building-blocks/primes/prime-block-source.md`](../../building-blocks/primes/prime-block-source.md)  
**Classification:** Analytic Number Theory / Chebyshev Functions / Renewal Blocks / Bilinear Kernels / Continuous Prime Semigroups

---

## 1. Executive Summary and Mathematical Statement

Connecting continuous delay-differential renewal dynamics to classical arithmetic sums requires an exact, non-asymptotic bridge between continuous prime blocks and the classical von Mangoldt / Chebyshev function $\psi(x)$. Establishing this exact correspondence without remainder terms or truncation errors is essential for spectral reformulations of the Riemann Hypothesis.

This contribution proves:

1. **Finite Prime-Power Parametrization of the von Mangoldt Sum:**  
   For every positive integer $N \in \mathbb{N}$, the Chebyshev $\psi(N)$ function decomposes bijectively into the double sum:
   \[
   \psi(N) = \sum_{p \in [2, N], p \text{ prime}} \sum_{j \in [1, N], p^j \le N} \log p.
   \]
2. **Exact Age-Floor Prime-Power Activation Equivalence:**  
   For any prime $p$ and integer exponent $j \ge 1$, the continuous age activation threshold matches the discrete floor inequality exactly:
   \[
   j \log p \le v \iff p^j \le \lfloor e^v \rfloor.
   \]
3. **Exact Continuous Prime Block Representation:**  
   For every prime $p$ and continuous age $v \in \mathbb{R}$:
   \[
   \text{primeBlock}_p(v) = e^{-v/2} \sum_{j=1}^{\lfloor e^v \rfloor} \mathbf{1}_{p^j \le \lfloor e^v \rfloor} \log p.
   \]
   In particular, primes beyond the floor cutoff ($p > \lfloor e^v \rfloor$) satisfy $\text{primeBlock}_p(v) = 0$ identically.
4. **The Fundamental Bridge Identity:**  
   The finite sum of all continuous prime blocks equals the normalized Chebyshev function identically:
   \[
   \text{primeBlockSum}(v) = \sum_{p=2}^{\lfloor e^v \rfloor} \mathbf{1}_{p \text{ prime}} \text{primeBlock}_p(v) = e^{-v/2} \psi(\lfloor e^v \rfloor).
   \]
5. **Exact Bilinear Arithmetic Source Representation:**  
   The centered arithmetic source function $\text{source}(v) = e^{-v/2}(\psi(\lfloor e^v \rfloor) - e^v) \mathbf{1}_{v \ge 0}$ satisfies:
   \[
   \text{source}(v) = \text{primeBlockSum}(v) - e^{v/2}, \quad \text{source}(0) = -1.
   \]
   For any two observation ages $u, v \ge 0$, the bilinear product expands with all cross-prime interference terms and continuous background terms:
   \[
   \text{source}(u)\text{source}(v) = \text{primeBlockSum}(u)\text{primeBlockSum}(v) - e^{v/2}\text{primeBlockSum}(u) - e^{u/2}\text{primeBlockSum}(v) + e^{(u+v)/2}.
   \]
   No primes are omitted, no higher prime powers are discarded, and the equivalence is exact on the entire non-negative real line $[0, \infty)$.

---

## 2. Mathematical Proof

### 2.1. Bijection and Chebyshev Parametrization
Let $P = \{ (p, j) \in [2, N] \times [1, N] : p \text{ prime}, p^j \le N \}$ and $Q = \{ n \in [1, N] : n \text{ is a prime power} \}$.
The map $\phi(p, j) = p^j$ is a bijection from $P$ to $Q$ by the fundamental theorem of arithmetic.
Furthermore, $\Lambda(p^j) = \log p$.
Thus:
\[
\sum_{(p, j) \in P} \log p = \sum_{n \in Q} \Lambda(n).
\]
Since $\Lambda(n) = 0$ when $n$ is not a prime power, $\sum_{n \in Q} \Lambda(n) = \sum_{n=1}^N \Lambda(n) = \psi(N)$.

### 2.2. Continuous Age-Floor Activation
$j \log p \le v \iff \log(p^j) \le v \iff p^j \le e^v$.
Since $p^j$ is an integer, $p^j \le e^v \iff p^j \le \lfloor e^v \rfloor$.
Hence the indicator of $v \ge j \log p$ is identically equal to the indicator of $p^j \le \lfloor e^v \rfloor$.
Substituting into $\text{primeBlock}_p(v) = e^{-v/2} \sum_j \mathbf{1}_{v \ge j \log p} \log p$ gives the power sum representation.

### 2.3. Bridge Identity and Bilinear Product
Summing $\text{primeBlock}_p(v)$ over all primes $p \le \lfloor e^v \rfloor$:
\[
\sum_{p \le \lfloor e^v \rfloor} \text{primeBlock}_p(v) = e^{-v/2} \sum_{p \le \lfloor e^v \rfloor} \sum_{p^j \le \lfloor e^v \rfloor} \log p = e^{-v/2} \psi(\lfloor e^v \rfloor).
\]
Subtracting $e^{v/2}$ gives $\text{source}(v) = e^{-v/2}(\psi(\lfloor e^v \rfloor) - e^v)$.
Multiplying $\text{source}(u)$ and $\text{source}(v)$ yields the 4-term bilinear expansion in `source_product`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeBlockSource` in `formalization/BuildingBlocks/PrimeBlockSource.lean`):
```lean
theorem psi_eq_prime_power_sum (N : ℕ) :
    psi N = ∑ p ∈ Finset.Icc 2 N, if p.Prime then
      ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then Real.log p else 0 else 0

theorem birth_activation_iff {p : ℕ} (hp : p.Prime) (j : ℕ) (v : ℝ) :
    (j : ℝ) * Real.log p ≤ v ↔ p ^ j ≤ ⌊Real.exp v⌋₊

theorem primeBlock_eq_power_sum {p : ℕ} (hp : p.Prime) (v : ℝ) :
    primeBlock p v = Real.exp (-v / 2) *
      ∑ j ∈ Finset.Icc 1 ⌊Real.exp v⌋₊, if p ^ j ≤ ⌊Real.exp v⌋₊ then Real.log p else 0

theorem primeBlock_eq_zero_above_cutoff {p : ℕ} (hp : p.Prime) {v : ℝ}
    (hpN : ⌊Real.exp v⌋₊ < p) : primeBlock p v = 0

theorem primeBlockSum_eq_psi (v : ℝ) :
    primeBlockSum v = Real.exp (-v / 2) * psi ⌊Real.exp v⌋₊

theorem source_eq_primeBlocks {v : ℝ} (hv : 0 ≤ v) :
    source v = primeBlockSum v - Real.exp (v / 2)

theorem source_product {u v : ℝ} (hu : 0 ≤ u) (hv : 0 ≤ v) :
    source u * source v = primeBlockSum u * primeBlockSum v -
      primeBlockSum u * Real.exp (v / 2) - Real.exp (u / 2) * primeBlockSum v +
      Real.exp ((u + v) / 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical von Mangoldt sums and Chebyshev function equivalences (Landau 1909, Ingham 1932, Montgomery-Vaughan 2007). Machine-verified continuous age-floor equivalences connecting prime renewal blocks and Chebyshev sums in Lean 4 are new.
- **Advancement:** Establishes the exact identity $\text{primeBlockSum}(v) = e^{-v/2}\psi(\lfloor e^v \rfloor)$ and proves the bilinear source product formula in Lean 4.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
