# Contribution 170: Exact Mertens-to-Chebyshev Prime Error Transfer and Quadratic Harmonic Majorants

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MertensPrimeTransfer.lean`](../../formalization/BuildingBlocks/MertensPrimeTransfer.lean), [`building-blocks/primes/mertens-prime-transfer.md`](../../building-blocks/primes/mertens-prime-transfer.md)  
**Classification:** Analytic Number Theory / Multiplicative Number Theory / Mertens Function / Chebyshev Function / Hyperbola Method / Effective Error Bounds

---

## 1. Executive Summary and Mathematical Statement

Connecting bounds on the Mertens function $M(x) = \sum_{n \le x} \mu(n)$ to bounds on the prime Chebyshev error $\psi(x) - x$ is a classic problem in analytic number theory. Traditional proofs rely on complex contour integrals of $1/\zeta(s)$. Here, an entirely real, non-contour, discrete hyperbola transfer is established with explicit non-asymptotic constants.

This contribution proves:

1. **Divisor Harmonic Majorant via Factor Pairing:**  
   For any integer $K \ge 1$:
   $$
   \sum_{n=1}^K \frac{d(n)}{n} \le H_K^2,
   $$
   where $H_K = \sum_{k=1}^K \frac{1}{k}$ is the $K$-th harmonic number.
2. **Centered Divisor Harmonic Bound:**  
   For the centered Dirichlet divisor coefficients $c_k = \log k - d(k) + 2\gamma$:
   $$
   \sum_{k=1}^K \frac{|c_k|}{k} \le 4 (1 + \log K)^2.
   $$
3. **Explicit Effective Mertens-to-Chebyshev Prime Error Transfer:**  
   Let $1 \le K \le N$. If the Mertens function satisfies the quotient bound $|M(N/k)| \le \eta \frac{N}{k}$ for all $1 \le k \le K$ with $\eta \ge 0$, then the centered Chebyshev prime error $\psi(N) - N + 2\gamma$ is explicitly bounded by:
   $$
   |\psi(N) - N + 2\gamma| \le 4 \eta N (1 + \log K)^2 + \frac{39 N}{\sqrt{K+1}}.
   $$
   This bound holds unconditionally for all positive integers $N$ and $K$ with $K \le N$, with zero asymptotic Landau $O$-constants and zero dependence on complex analysis or zero-free regions.

---

## 2. Mathematical Proof

### 2.1. Divisor Harmonic Majorant
Expressing $d(n) = \sum_{d \mid n} 1$ and pairing factors $n = a \cdot b$:
$$
\sum_{n=1}^K \frac{d(n)}{n} = \sum_{n=1}^K \sum_{d \mid n} \frac{1}{d (n/d)} = \sum_{a \le K} \sum_{b \le K/a} \frac{1}{ab} \le \sum_{a=1}^K \frac{1}{a} \sum_{b=1}^K \frac{1}{b} = H_K^2.
$$

### 2.2. Centered Divisor Sum
Since $c_k = \log k - d(k) + 2\gamma$, by triangle inequality:
$$
|c_k| \le \log k + 2\gamma + d(k) \le \log K + 2\gamma + d(k).
$$
Dividing by $k$ and summing over $k \in [1, K]$:
$$
\sum_{k=1}^K \frac{|c_k|}{k} \le (\log K + 2\gamma) H_K + \sum_{k=1}^K \frac{d(k)}{k} \le (\log K + 2\gamma) H_K + H_K^2.
$$
Using $H_K \le 1 + \log K$ and $2\gamma < 4/3 < 2$:
$$
(\log K + 2\gamma)(1 + \log K) + (1 + \log K)^2 \le 4 (1 + \log K)^2.
$$

### 2.3. Prime Error Hyperbola Remainder Combination
By Dirichlet hyperbola decomposition of the centered divisor identity:
$$
\psi(N) - N + 2\gamma = \sum_{k=1}^K c_k M(\lfloor N/k \rfloor) + R(N, K).
$$
By `primeError_Mertens_prefix_remainder`, the remainder is bounded by:
$$
|R(N, K)| \le \frac{39 N}{\sqrt{K+1}}.
$$
For the prefix sum, inserting the hypothesis $|M(N/k)| \le \eta \frac{N}{k}$:
$$
\left| \sum_{k=1}^K c_k M(N/k) \right| \le \sum_{k=1}^K |c_k| \eta \frac{N}{k} = \eta N \sum_{k=1}^K \frac{|c_k|}{k} \le 4 \eta N (1 + \log K)^2.
$$
Combining the prefix and remainder terms via the triangle inequality yields:
$$
|\psi(N) - N + 2\gamma| \le 4 \eta N (1 + \log K)^2 + \frac{39 N}{\sqrt{K+1}}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MertensTransfer` in `formalization/BuildingBlocks/MertensPrimeTransfer.lean`):
```lean
theorem divisorCard_harmonic_bound (K : ℕ) :
    (∑ n ∈ Finset.Icc 1 K, (n.divisors.card : ℝ) / n) ≤ (harmonic K : ℝ) ^ 2

theorem centeredDivisorCoefficient_harmonic_bound {K : ℕ} (hK : 1 ≤ K) :
    (∑ k ∈ Finset.Icc 1 K, |centeredDivisorCoefficient k| / k) ≤
      4 * (1 + Real.log K) ^ 2

theorem primeError_bound_of_Mertens_quotients {N K : ℕ} (hN : 1 ≤ N)
    (hK : 1 ≤ K) (hKN : K ≤ N) {η : ℝ} (hη : 0 ≤ η)
    (hM : ∀ k ∈ Finset.Icc 1 K,
      |(mertens (N / k) : ℝ)| ≤ η * ((N : ℝ) / k)) :
    |integerError N + 2 * Real.eulerMascheroniConstant| ≤
      4 * η * N * (1 + Real.log K) ^ 2 + 39 * N / Real.sqrt ((K + 1 : ℕ) : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Elementary bounds connecting the Möbius and von Mangoldt functions (Landau 1909, Diamond 1982, Tenenbaum 2015). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the explicit effective transfer $|\psi(N) - N + 2\gamma| \le 4 \eta N (1 + \log K)^2 + \frac{39 N}{\sqrt{K+1}}$ from quotient Mertens bounds in Lean 4.
- **Target Venues:** *Acta Arithmetica* or *Journal of Number Theory*.
