# Unique Contribution 105: Exact Critical-Multiple Mellin Integral Identity and Half-Plane Convergence

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCriticalMellin.lean`](../../formalization/BuildingBlocks/ActualCriticalMellin.lean), [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean), [`formalization/BuildingBlocks/CriticalMultipleMellin.lean`](../../formalization/BuildingBlocks/CriticalMultipleMellin.lean)  
**Classification:** Analytic Number Theory / Mellin Transforms / Shifted Zeta Factors / Critical Wave Packets / Explicit Integral Representations

---

## 1. Executive Summary and Mathematical Statement

The critical multiple aggregation $W(x)$ scales the centered distinct-prime tent $V(x)$ by square-root factors across all positive integers:
\[
W(x) = \sum_{d=1}^{\lfloor x \rfloor} \sqrt{d} \, V\left(\frac{x}{d}\right).
\]
Because $V(t) = 0$ for $t \le 1$, the function $W(x)$ vanishes identically on the interval $(-\infty, 1]$, making $x=1$ the exact physical birth endpoint of distinct prime correlation.

This contribution proves:

1. **Exact Support and Reality:**  
   $V(x) = 0$ and $W(x) = 0$ for all $x \le 1$. Furthermore, both $V(x)$ and $W(x)$ are purely real-valued functions.
2. **Shifted Zeta Mellin Convolution Identity:**  
   On the absolute convergence half-plane $\operatorname{Re}(s) > 1$, the Mellin transform of $W$ at argument $-s-1$ factors as the product of the shifted Riemann zeta function $\zeta(s + 1/2)$ and the centered distinct-prime tent Mellin transform:
   \[
   \mathcal{M}(W)(-s-1) = \zeta\left( s + \frac{1}{2} \right) \mathcal{M}(V)(-s-1) = \zeta\left( s + \frac{1}{2} \right) \frac{\left( -\frac{\zeta'}{\zeta}(s) - \frac{1}{s-1} \right)^2 - H(s)}{s(s+1)}.
   \]
3. **Certified Integral Representation with Exact Lower Endpoint:**  
   The written integral on $(1, \infty)$ converges absolutely:
   \[
   \int_1^\infty x^{-s-2} W(x) \, dx = \zeta\left( s + \frac{1}{2} \right) \frac{\left( -\frac{\zeta'}{\zeta}(s) - \frac{1}{s-1} \right)^2 - H(s)}{s(s+1)},
   \]
   rigorously justifying replacing the open ray $(0, \infty)$ by $[1, \infty)$ due to the vanishing of $W(x)$ on $(0, 1]$.

---

## 2. Mathematical Proof

### 2.1. Support Vanishing
For $x \le 1$, every term in the sum defining $V(x)$ vanishes because:
- Prime pairs $p_1 p_2 \ge 2 \cdot 3 = 6 > 1$, so the Riesz tent kernel is zero;
- The cross-sum $\eta(x) = \sum_{n \le x} \Lambda(n) \frac{x^2 - n^2}{2n} = 0$ since $n \ge 2 > 1$;
- The baseline $B(x) = 0$ for $x \le 1$.
Consequently, for $x \le 1$ and $d \ge 1$, $x/d \le 1$, giving $V(x/d) = 0$ for all $d$, whence $W(x) = 0$.

### 2.2. Multiple Convolution Mellin Transform
By Dirichlet convolution duality for Mellin transforms:
\[
\mathcal{M}\left( \sum_{d \le x} \sqrt{d} f(x/d) \right)(w) = \left( \sum_{d=1}^\infty \sqrt{d} \, d^w \right) \mathcal{M}(f)(w) = \zeta\left( -w - \frac{1}{2} \right) \mathcal{M}(f)(w).
\]
Setting $w = -s - 1$:
\[
-w - \frac{1}{2} = (s + 1) - \frac{1}{2} = s + \frac{1}{2}.
\]
Thus the multiplier is precisely $\zeta(s + 1/2)$.
Because $\operatorname{Re}(s) > 1$, $\operatorname{Re}(s + 1/2) > 3/2 > 1$, ensuring absolute convergence of $\zeta(s + 1/2) = \sum_{d=1}^\infty d^{-(s+1/2)}$.

### 2.3. Endpoint Restriction
Since $W(x) = 0$ for $x \le 1$:
\[
\int_0^\infty x^{-s-2} W(x) \, dx = \int_0^1 x^{-s-2} \cdot 0 \, dx + \int_1^\infty x^{-s-2} W(x) \, dx = \int_1^\infty x^{-s-2} W(x) \, dx.
\]
This proves the identity on the half-line $[1, \infty)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCriticalMellin`):
```lean
theorem W_zero {x : ℝ} (hx : x ≤ 1) : W x = 0

theorem hasMellin_W {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.transform s)

theorem integrableOn_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ)^(-s-2) * W x) (Ioi 1)

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

- **Prior Literature:** Mellin transforms of Dirichlet convolutions $\sum d^{-\alpha} f(x/d)$ are classical in analytic number theory. However, the machine-verified derivation of the exact shifted critical zeta multiplier $\zeta(s + 1/2)$ acting on centered distinct-prime correlation functions with certified $[1, \infty)$ support cutoff is novel.
- **Advancement:** Establishes machine-verified explicit integral formulas for the critical multiple correlation transform.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
