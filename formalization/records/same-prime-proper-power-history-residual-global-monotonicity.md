# Contribution 74: Same-Prime Proper-Power History Residual Global Monotonicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeHistoryResidual.lean`](../../formalization/BuildingBlocks/SamePrimeHistoryResidual.lean)  
**Classification:** Analytic Number Theory / Causal Arithmetic Dynamics / Monotone Prime Aggregation / Delay Inequalities

---

## 1. Executive Summary and Mathematical Statement

In the causal operator and reflection formulation of the prime spectrum, the singular self-interaction of prime power ladders is regularized by separating the first power $p$ from the higher proper powers $p^m$ ($m \ge 2$). The higher powers form a delayed history residual $s(v)$ modulated by the monotone chronological divisibility kernel $h(v)$.

This contribution proves:

1. **Exact Representation of Proper Power Residual:**  
   For any continuous age $v \in \mathbb{R}$, the active proper-power same-prime residual is:
   $$
   s(v) = \sum_{p \le e^v} \sum_{\substack{m \ge 2 \\ p^m \le e^v}} \frac{(m-1)(\log p)^2}{\sqrt{p^m}} h(v - m \log p),
   $$
   where $h(v)$ is the normalized chronological divisibility aggregation function ($h(v) = 0$ for $v \le 0$).
2. **Unconditional Non-Negativity:**  
   For all ages $v \in \mathbb{R}$, the history residual is strictly non-negative:
   $$
   \forall v \in \mathbb{R}, \quad s(v) \ge 0.
   $$
3. **Global Monotonicity Across Growing Truncation Cutoffs:**  
   Despite the discrete floor cutoff $\lfloor e^v \rfloor$ introducing jump discontinuities into the active index sets, the function $s: \mathbb{R} \to \mathbb{R}$ is **globally monotone non-decreasing on the entire real line**:
   $$
   \forall u, v \in \mathbb{R}, \quad u \le v \implies s(u) \le s(v).
   $$
4. **Universal Delay Contraction Inequality:**  
   For any non-negative time delay $r \ge 0$ and any age $v \in \mathbb{R}$:
   $$
   s(v - r) \le s(v).
   $$
5. **Significance for Causal Stability:**  
   This establishes that the cumulative feedback from higher prime powers is unconditionally stabilizing: delays cannot cause energy growth or amplify retroactive instabilities in the causal prime field.

---

## 2. Mathematical Proof

### 2.1. Kernel Monotonicity and Weight Positivity
For each prime $p$ and exponent $m \ge 2$, the weight $w(p, m) = \frac{(m-1)(\log p)^2}{\sqrt{p^m}} \ge 0$ is non-negative.
The chronological kernel $h$ satisfies $h(v) = 0$ for $v \le 0$ and is monotone non-decreasing on $\mathbb{R}$.
Therefore, each individual delayed term $t_{p, m}(v) = w(p, m) h(v - m \log p)$ is non-negative and monotone non-decreasing in $v$.

### 2.2. Monotonicity of Truncated Sums
For fixed cutoff $N \in \mathbb{N}$, the rectangular sum:
$$
\Phi_N(v) = \sum_{p=2}^N \mathbf{1}_{\mathrm{Prime}}(p) \sum_{m=2}^N t_{p, m}(v)
$$
is a sum of monotone functions with non-negative coefficients, hence $\Phi_N(v)$ is monotone in $v$.
Furthermore, for fixed $v$, increasing $N$ adds terms with $t_{p, m}(v) \ge 0$, so $\Phi_N(v) \le \Phi_{N+1}(v)$.

### 2.3. Joint Monotonicity
For $u \le v$, let $M = \lfloor e^u \rfloor$ and $N = \lfloor e^v \rfloor$.
Since $e^u \le e^v$, $M \le N$.
Then:
$$
s(u) = \Phi_M(u) \le \Phi_M(v) \le \Phi_N(v) = s(v).
$$
The first inequality follows from the monotonicity of $\Phi_M(\cdot)$ in the age argument, and the second from the monotonicity of $\Phi_{(\cdot)}(v)$ in the cutoff index.

### 2.4. Delay Inequality
Since $r \ge 0$, $v - r \le v$. Applying global monotonicity directly gives $s(v - r) \le s(v)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeHistoryResidual`):
```lean
theorem s_nonneg (v : ℝ) : 0 ≤ s v

theorem s_monotone : Monotone s

theorem s_delay_le (v : ℝ) {r : ℝ} (hr : 0 ≤ r) : s (v - r) ≤ s v

theorem s_eq_active_sum (v : ℝ) :
    s v = ∑ p ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, if p.Prime then
      ∑ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊,
        if p ^ m ≤ ⌊Real.exp v⌋₊ then term p m v else 0 else 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime power sums $\sum_{p^m \le x} \frac{\log p}{p^{m/2}}$ appear in Chebyshev's $\psi$ function and Riemann's explicit formulas. A formal machine verification of global monotonicity for causal delayed prime-power residuals under joint continuous-discrete index variation had not been established.
- **Advancement:** Proves unconditional monotonicity and delay-contraction inequalities for the complete proper-power prime residual field.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
