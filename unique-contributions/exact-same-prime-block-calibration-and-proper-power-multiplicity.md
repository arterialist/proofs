# Contribution 177: Exact Same-Prime Block Calibration and Proper-Power Multiplicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeBlockCalibration.lean`](../../formalization/BuildingBlocks/SamePrimeBlockCalibration.lean), [`building-blocks/primes/same-prime-block-calibration.md`](../../building-blocks/primes/same-prime-block-calibration.md)  
**Classification:** Analytic Number Theory / Causal Renewal Dynamics / Diagonal Spectral Measures / Prime Powers / Discrete Combinatorics / Proper Multiplicities

---

## 1. Executive Summary and Mathematical Statement

The diagonal energy of prime-power interactions in causal spectral analysis requires evaluating the auto-convolution of each prime block $\text{primeBlock}_p(v) = \log p \sum_{j \le \lfloor e^v \rfloor} \mathbf{1}_{v \ge j \log p} e^{-v/2}$ under the canonical Volterra filter $\mathcal{L}_0$. Previous analyses often approximated this via infinite geometric series or heuristic spectral projections.

This contribution proves:

1. **Finite Discrete Exponent Partition Summation Identity:**  
   For any sequence $F$ vanishing beyond index $N$ ($F(m) = 0$ for $m > N$):
   $$
   \sum_{j=1}^N \sum_{k=1}^N F(j+k) = \sum_{m=2}^N (m - 1) F(m).
   $$
   This identity is proven via an explicit constructive bijection between the total-degree fiber sum $\Sigma(m \in [2, N], [1, m-1])$ and the restricted pair product $\{ (j, k) \in [1, N]^2 : j+k \le N \}$.
2. **Moving Cutoff Freezing on Bounded Horizons:**  
   For any age $s \ge 0$ and any $v \in [0, s]$, the moving-cutoff prime block satisfies $\text{primeBlock}_p(v) = \text{block}_{\lfloor e^s \rfloor}(p, v)$. Thus the autoconvolution on $[0, s]$ exactly reduces to a finite sum of bilinear birth convolutions.
3. **Exact Filtered Prime Block Evaluation:**  
   Applying the Volterra filter $\mathcal{L}_0$ to the autoconvolution of $\text{primeBlock}_p$ yields:
   $$
   \mathcal{L}_0\left( \int_0^\cdot \text{primeBlock}_p(u) \text{primeBlock}_p(\cdot - u) \, du \right)(s) = \sum_{m=2}^{\lfloor e^s \rfloor} \frac{(m-1) \log^2 p}{\sqrt{p^m}} \theta(s - m \log p),
   $$
   where $\theta(v) = \mathbf{1}_{v \ge 0}(e^{-v/2} - e^{-3v/2})$. The weight $\frac{(m-1) \log^2 p}{\sqrt{p^m}}$ emerges as the exact multiplicity of ordered pairs $(j, k)$ with $j + k = m$.
4. **Master All-Prime Same-Prime Calibration Identity:**  
   Summing over all primes $p \le \lfloor e^s \rfloor$:
   $$
   \sum_{p=2}^{\lfloor e^s \rfloor} \mathbf{1}_{p \in \mathcal{P}} \, \mathcal{L}_0(\text{primeBlock}_p * \text{primeBlock}_p)(s) = \tau(s),
   $$
   establishing that the formal spectral diagonal $\tau(s)$ matches the filtered sum of prime blocks with zero approximation error.

---

## 2. Mathematical Proof

### 2.1. Combinatorial Partition Duality
Consider the set $T = \{ (j, k) \in \mathbb{N}^2 : 1 \le j, k \le N, j + k \le N \}$.
Map $(j, k) \mapsto (m, j)$ with $m = j + k$. Since $j \ge 1$ and $k \ge 1$, $2 \le m \le N$ and $1 \le j \le m - 1$.
Conversely, given $m \in [2, N]$ and $j \in [1, m-1]$, set $k = m - j$. Since $j \le m - 1$, $k \ge 1$; and $k \le m - 1 \le N - 1 < N$.
Thus $(j, k) \in T$. This map is a bijection, and the size of the fiber for fixed $m$ is $(m-1) - 1 + 1 = m-1$.
Since $F(j+k) = 0$ when $j+k > N$, the unrestricted double sum $\sum_{j=1}^N \sum_{k=1}^N F(j+k)$ equals $\sum_{m=2}^N (m-1) F(m)$.

### 2.2. Filtered Prime Block Autoconvolution
By the birth convolution theorem, $\text{birth}_{j\log p} * \text{birth}_{k\log p} = \text{ramp}_{(j+k)\log p}$.
By the causal filter theorem, $\mathcal{L}_0(\text{ramp}_d)(s) = e^{-d/2}\theta(s-d)$.
Setting $d = (j+k)\log p$:
$$
e^{-d/2} = e^{-(j+k)\log p / 2} = \frac{1}{\sqrt{p^{j+k}}}.
$$
Summing over all pairs $1 \le j, k \le N = \lfloor e^s \rfloor$, with $F(m) = \frac{\log^2 p}{\sqrt{p^m}} \theta(s - m\log p)$:
Whenever $m > \lfloor e^s \rfloor$, $m > e^s / \log p$, so $s < m\log p$ and $\theta(s - m\log p) = 0$.
Thus the condition $F(m) = 0$ for $m > N$ holds strictly, and applying the partition duality theorem:
$$
\sum_{j=1}^N \sum_{k=1}^N F(j+k) = \sum_{m=2}^N (m-1) \frac{\log^2 p}{\sqrt{p^m}} \theta(s - m\log p).
$$

### 2.3. All-Prime Summation
Summing across all prime numbers $p \le \lfloor e^s \rfloor$ reproduces the exact definition of $\tau(s)$ in the causal scattering framework.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeBlockCalibration` in `formalization/BuildingBlocks/SamePrimeBlockCalibration.lean`):
```lean
theorem sum_pairs_by_total (N : ℕ) (F : ℕ → ℝ)
    (hzero : ∀ m, N < m → F m = 0) :
    (∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N, F (j + k)) =
      ∑ m ∈ Finset.Icc 2 N, ((m - 1 : ℕ) : ℝ) * F m

theorem filtered_primeBlock_by_total {p : ℕ} (hp : p.Prime) {s : ℝ} (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s =
      ∑ m ∈ Finset.Icc 2 ⌊Real.exp s⌋₊,
        SamePrimeHistoryResidual.weight p m * theta (s - (m : ℝ) * Real.log p)

theorem actual_tau_calibration {s : ℝ} (hs : 0 ≤ s) :
    (∑ p ∈ Finset.Icc 2 ⌊Real.exp s⌋₊, if p.Prime then
      L0 (fun v => ∫ u in 0..v, primeBlock p u * primeBlock p (v - u)) s else 0) = tau s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime pair correlations and diagonal approximations in trace formulas (Montgomery 1973, Goldston-Montgomery 1987, Berry-Keating 1999). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves the exact identity $\sum_{p \le \lfloor e^s \rfloor} \mathcal{L}_0(\text{primeBlock}_p * \text{primeBlock}_p) = \tau(s)$ with partition bijection in Lean 4.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Number Theory*.
