# Unique Contribution 138: Exact Critical Square-Root Mellin Aggregation and Zeta Multiplier

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCriticalMellin.lean`](../../formalization/BuildingBlocks/ActualCriticalMellin.lean), [`building-blocks/mellin/actual-critical-mellin.md`](../../building-blocks/mellin/actual-critical-mellin.md)  
**Classification:** Analytic Number Theory / Mellin Transforms / Arithmetic Convolutions / Critical Square-Root Scaling / Shifted Zeta Multiplier

---

## 1. Executive Summary and Mathematical Statement

In the spectral decomposition of prime-pair and centered Riesz correlations, the base correlation profile $V(x)$ has Mellin transform $\frac{\mathcal{L}_c(s)^2 - H(s)}{s(s+1)}$. To generate the full critical transform with the non-trivial zeros of $\zeta(s)$ as poles, one must scale and aggregate $V(x)$ across all integer dilations $d \ge 1$ with the critical square-root weight $\sqrt{d}$.

This contribution proves:

1. **Exact Finite Multiple Sum Representation:**  
   The critical aggregation kernel $W: \mathbb{R} \to \mathbb{R}$ is defined for $x > 0$ by the finite sum:
   \[
   W(x) = \sum_{d=1}^{\lfloor x \rfloor} \sqrt{d} \, V\left(\frac{x}{d}\right).
   \]
2. **Support and Reality Properties:**  
   - **Support:** $W(x) = 0$ identically for all $x \le 1$.
   - **Reality:** $W(x) \in \mathbb{R}$ is strictly real-valued for all $x \in \mathbb{R}$.
3. **Exact Shifted Zeta Multiplier Mellin Identity:**  
   For all $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1$:
   \[
   \mathcal{M}(W)(-s - 1) = \zeta\left(s + \frac{1}{2}\right) \frac{\mathcal{L}_c(s)^2 - H(s)}{s(s+1)} = \Phi(s),
   \]
   where $\Phi(s)$ is the critical transform.
4. **Explicit Semi-Infinite Integral Formula:**  
   On the domain of absolute convergence $\operatorname{Re}(s) > 1$:
   \[
   \int_1^\infty x^{-s-2} W(x) dx = \Phi(s).
   \]

---

## 2. Mathematical Proof

### 2.1. Support and Reality
Since $V(y) = 0$ for $y \le 1$, if $x \le 1$, then for any integer $d \ge 1$ we have $x/d \le 1$, so $V(x/d) = 0$. Hence $W(x) = 0$ for $x \le 1$.
Since $V(y)$ is formed from real tent combinations, real kernel convolutions, and real baseline corrections, $\operatorname{Im}(V(y)) = 0$. Since $\sqrt{d} \in \mathbb{R}$, $\operatorname{Im}(W(x)) = 0$.

### 2.2. Mellin Transform of Arithmetic Dilation Sums
Let $f(x)$ be a function with support in $[1, \infty)$ and Mellin transform $\mathcal{M}(f)(z) = \int_1^\infty x^{z-1} f(x) dx$.
For the dilated and weighted sum:
\[
W(x) = \sum_{d=1}^\infty \sqrt{d} \, f\left(\frac{x}{d}\right) \mathbf{1}_{x/d \ge 1},
\]
taking the Mellin transform at $z = -s - 1$:
\[
\mathcal{M}(W)(-s - 1) = \int_0^\infty x^{-s-2} \sum_{d=1}^{\lfloor x \rfloor} \sqrt{d} f(x/d) dx.
\]
Substituting $u = x/d$, so $x = d u$ and $dx = d \, du$:
\[
\mathcal{M}(W)(-s - 1) = \sum_{d=1}^\infty \sqrt{d} \int_1^\infty (d u)^{-s-2} f(u) d(d u) = \sum_{d=1}^\infty d^{1/2 - s - 2 + 1} \int_1^\infty u^{-s-2} f(u) du.
\]
The exponent of $d$ is $\frac{1}{2} - s - 1 = -(s + 1/2)$.
Thus:
\[
\sum_{d=1}^\infty d^{-(s + 1/2)} = \zeta\left(s + \frac{1}{2}\right),
\]
which converges absolutely for $\operatorname{Re}(s + 1/2) > 1 \iff \operatorname{Re}(s) > 1/2$.
Since $\mathcal{M}(V)(-s - 1) = \frac{\mathcal{L}_c(s)^2 - H(s)}{s(s+1)}$ for $\operatorname{Re}(s) > 1$, the product equals $\zeta(s + 1/2) \frac{\mathcal{L}_c(s)^2 - H(s)}{s(s+1)} = \Phi(s)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCriticalMellin`):
```lean
theorem W_eq_Icc (x : ℝ) :
    W x = ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * V (x/d)

theorem W_real (x : ℝ) : (W x).im = 0

theorem W_zero {x : ℝ} (hx : x ≤ 1) : W x = 0

theorem hasMellin_W {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.transform s)

theorem hasMellin_W_filled {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.filledTransform s)

theorem integral_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ)^(-s-2) * W x) =
      CriticalTransformPoles.transform s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Mellin transforms of arithmetically scaled sums and Dirichlet series multipliers (Titchmarsh 1986, Montgomery-Vaughan 2007). The formal verification of exact arithmetic dilation aggregation $W(x) = \sum \sqrt{d} V(x/d)$ and shifted zeta multiplication in Lean 4 is novel.
- **Advancement:** Establishes machine-verified arithmetic dilation algebra and shifted zeta multiplication $\zeta(s+1/2)$ for centered Riesz-Mellin kernels.
- **Target Venues:** *Ramanujan Journal* or *Journal of Mathematical Analysis and Applications*.
