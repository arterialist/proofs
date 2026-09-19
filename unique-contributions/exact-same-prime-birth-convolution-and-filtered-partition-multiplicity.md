# Contribution 176: Exact Same-Prime Birth Convolution and Filtered Partition Multiplicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeBirthConvolution.lean`](../../formalization/BuildingBlocks/SamePrimeBirthConvolution.lean), [`building-blocks/primes/same-prime-birth-convolution.md`](../../building-blocks/primes/same-prime-birth-convolution.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Causal Renewal Theory / Integral Transforms / Partition Multiplicities / Causal Filters

---

## 1. Executive Summary and Mathematical Statement

In the continuous renewal model of prime arrivals, individual prime powers $p^j$ act as birth events at logarithmic age $j \ell$ with exponential weight $e^{-v/2}\mathbf{1}_{v \ge j\ell}$. The convolution of two such birth histories models the bilinear interaction of prime-power pairs.

This contribution proves:

1. **Exact Birth Convolution Identity:**  
   For any birth delays $b, c \ge 0$ and evaluation age $s \ge 0$:
   $$
   \int_0^s \text{birth}_b(u) \text{birth}_c(s - u) \, du = \text{ramp}_{b+c}(s) = e^{-s/2} \max(s - (b+c), 0).
   $$
   The literal continuous convolution of two delayed exponential step functions produces an exact piecewise-linear ramp with combined delay $b+c$.
2. **Action of Causal Filter on Ramp Signals:**  
   Applying the canonical renewal filter $\mathcal{L}_0(g)(s) = g(s) - \int_0^s e^{-3(s-v)/2} g(v) \, dv$ to the delayed ramp yields:
   $$
   \mathcal{L}_0(\text{ramp}_d)(s) = e^{-d/2} \theta(s - d),
   $$
   where $\theta(v) = \mathbf{1}_{v \ge 0} (e^{-v/2} - e^{-3v/2})$.
3. **Exact Filtered Birth Convolution:**  
   Combining the convolution and filtering operations:
   $$
   \mathcal{L}_0\left( \int_0^\cdot \text{birth}_b(u) \text{birth}_c(\cdot - u) \, du \right)(s) = e^{-(b+c)/2} \theta(s - (b+c)).
   $$
4. **Exact Exponent Partition Regrouping:**  
   For any prime scale $\ell \ge 0$ and any integer total exponent $m \ge 2$:
   $$
   \sum_{j=1}^{m-1} \mathcal{L}_0(\text{birth}_{j\ell} * \text{birth}_{(m-j)\ell})(s) = (m - 1) e^{-m\ell/2} \theta(s - m\ell).
   $$
   The aggregate filtered response of all same-prime pairs with total power $p^m = p^j \cdot p^{m-j}$ matches the exact integer partition multiplicity $m - 1$.

---

## 2. Mathematical Proof

### 2.1. Product Support and Convolution
The integrand is $\text{birth}_b(u) \text{birth}_c(s - u) = \mathbf{1}_{u \ge b} e^{-u/2} \cdot \mathbf{1}_{s - u \ge c} e^{-(s-u)/2}$.
The product is non-zero if and only if $u \ge b$ and $u \le s - c$.
On this interval $u \in [b, s-c]$, the exponential factors multiply to $e^{-u/2} e^{-(s-u)/2} = e^{-s/2}$.
The measure of $[b, s-c]$ is $\max((s-c) - b, 0) = \max(s - (b+c), 0)$.
Therefore:
$$
\int_0^s \text{birth}_b(u) \text{birth}_c(s - u) \, du = e^{-s/2} \max(s - (b+c), 0) = \text{ramp}_{b+c}(s).
$$

### 2.2. Filter Integration
For $s \ge d$, the integral term in $\mathcal{L}_0(\text{ramp}_d)(s)$ is:
$$
\int_0^s e^{-3(s-v)/2} \text{ramp}_d(v) \, dv = \int_d^s e^{-3(s-v)/2} e^{-v/2} (v - d) \, dv = \int_d^s e^{-3s/2 + v} (v - d) \, dv.
$$
Using the antiderivative $\frac{d}{dv}[e^{-3s/2 + v}(v - d - 1)] = e^{-3s/2 + v}(v - d)$:
$$
\int_d^s e^{-3s/2 + v} (v - d) \, dv = e^{-3s/2 + s}(s - d - 1) - e^{-3s/2 + d}(-1) = e^{-s/2}(s - d - 1) + e^{-3s/2 + d}.
$$
Subtracting this from $\text{ramp}_d(s) = e^{-s/2}(s - d)$:
$$
\mathcal{L}_0(\text{ramp}_d)(s) = e^{-s/2}(s - d) - [e^{-s/2}(s - d - 1) + e^{-3s/2 + d}] = e^{-s/2} - e^{-3s/2 + d}.
$$
Factoring $e^{-d/2}$:
$$
e^{-d/2} (e^{-(s-d)/2} - e^{-3(s-d)/2}) = e^{-d/2} \theta(s - d).
$$
For $s < d$, both sides are $0$.

### 2.3. Regrouping by Exponent Sum
Setting $b = j\ell$ and $c = (m-j)\ell$, the sum $b + c = m\ell$ is invariant under $j$.
Each term in the sum over $1 \le j \le m-1$ evaluates to $e^{-m\ell/2}\theta(s - m\ell)$.
Since there are $(m-1) - 1 + 1 = m-1$ identical terms, the sum equals $(m-1)e^{-m\ell/2}\theta(s - m\ell)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeBirthConvolution` in `formalization/BuildingBlocks/SamePrimeBirthConvolution.lean`):
```lean
theorem birth_convolution {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    (∫ u in 0..s, birth b u * birth c (s - u)) = ramp (b + c) s

theorem filtered_ramp {d s : ℝ} (hd : 0 ≤ d) (hs : 0 ≤ s) :
    L0 (ramp d) s = Real.exp (-d / 2) * theta (s - d)

theorem filtered_birth_convolution {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, birth b u * birth c (v - u)) s =
      Real.exp (-(b + c) / 2) * theta (s - b - c)

theorem filtered_pairs_by_total {ell s : ℝ} (hell : 0 ≤ ell) (hs : 0 ≤ s)
    {m : ℕ} (hm : 2 ≤ m) :
    (∑ j ∈ Finset.Icc 1 (m - 1),
      L0 (fun v => ∫ u in 0..v, birth ((j : ℝ) * ell) u *
        birth (((m - j : ℕ) : ℝ) * ell) (v - u)) s) =
      ((m - 1 : ℕ) : ℝ) * (Real.exp (-((m : ℝ) * ell) / 2) * theta (s - (m : ℝ) * ell))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Renewal convolutions and Volterra integral operators (Bellman-Cooke 1963, Gripenberg-Londen-Staffans 1990). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact identity $\sum_{j=1}^{m-1} \mathcal{L}_0(\text{birth}_{j\ell} * \text{birth}_{(m-j)\ell}) = (m-1)e^{-m\ell/2}\theta(s - m\ell)$ in Lean 4.
- **Target Venues:** *Journal of Integral Equations and Applications* or *Mathematical Proceedings of the Cambridge Philosophical Society*.
