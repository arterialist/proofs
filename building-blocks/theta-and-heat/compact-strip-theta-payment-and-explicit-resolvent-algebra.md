# Compact-Strip Theta Payment and Explicit Resolvent Coercivity

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean`](../../formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean)
**Classification:** Spectral Theory / Operator Theory / Resolvent Bounds / Explicit Constants
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

In the operator-theoretic and spectral approaches to the Riemann Hypothesis on compact vertical strips, proving that an arrival term strictly dominates the negative energy deficit of the strip generator requires an explicit quantitative coercivity margin:
$$
\delta \cdot w < \text{total} = \text{strip} + \text{arrival}.
$$
This note records the exact rational and order-theoretic algebra that converts the transcendental Schur integral bound and resolvent estimates into closed-form explicit decimal constants:

1. **Order-Theoretic Compact-Strip Coercivity:**
   Given a strip lower bound $\text{strip} \ge -L$, an arrival rate $L + \delta M < \text{arrival}$, and weight bound $w \le M$, the total operator energy strictly satisfies:
   $$
   \delta \cdot w < \text{total}.
   $$
2. **Rational Schur Resolution at Integer Exponent:**
   For any integer exponent $B \in \mathbb{N}$ and rational scale $\varepsilon(B) = \frac{1}{2 \cdot 3^B}$, the Schur integral bound $C \le r/4$ under the kernel bound $r \le 1/\varepsilon(B)$ yields the explicit algebraic bound:
   $$
   C \le \frac{3^B}{2}.
   $$
3. **Explicit Coarse Resolvent Bound:**
   Combining the resolvent substitution $P \le M C / \delta$ with the physical parameters $M = 10^{500}$ and $\delta_* = \frac{1}{8 \cdot 10^{546}}$ yields the explicit uniform resolvent bound:
   $$
   P \le 4 \cdot 10^{1046} \cdot 3^B.
   $$
4. **Deficit Absorption by Logarithmic Arrival:**
   With $B_* = 5 \cdot 10^{503} \cdot 3^{\text{stripExponent}}$ and $c_* = 3^{-\text{stripExponent}}$, the explicit payment margin satisfies:
   $$
   L + \delta_* M < \frac{c_* B_*}{4} = \frac{5}{4} \cdot 10^{503} = 10^{503} + \frac{10^{503}}{4},
   $$
   which strictly absorbs the strip deficit $L = 10^{503}$ and barrier loss $\delta_* M = \frac{1}{8 \cdot 10^{46}}$, proving that the logarithmic arrival rate at $\varepsilon_* = \varepsilon(B_*)$ strictly dominates the compact-strip energy deficit:
   $$
   L + \delta_* M < \frac{c_*}{4} \log\left( \frac{1/2}{\varepsilon_*} \right).
   $$

---

## 2. Mathematical Proof

### 2.1. Compact Payment Inequality
Let $\text{total} = \text{strip} + \text{arrival}$ with $\text{strip} \ge -L$. Since $w \le M$ and $\delta \ge 0$:
$$
\delta w \le \delta M = (\delta M + L) - L < \text{arrival} - L \le \text{arrival} + \text{strip} = \text{total}.
$$

### 2.2. Explicit Margin Calculation
For $M = 10^{500}$ and $\delta_* = \frac{1}{8 \cdot 10^{546}}$:
$$
\delta_* M = \frac{10^{500}}{8 \cdot 10^{546}} = \frac{1}{8 \cdot 10^{46}} < \frac{1}{4}.
$$
Since $L = 10^{503}$, we have:
$$
L + \delta_* M < 10^{503} + \frac{1}{4} < 10^{503} + \frac{10^{503}}{4} = \frac{5}{4} \cdot 10^{503}.
$$
Since $B_* = 5 \cdot 10^{503} \cdot 3^{\text{stripExponent}}$ and $c_* = 3^{-\text{stripExponent}}$, their product is identically:
$$
c_* B_* = 5 \cdot 10^{503}, \quad \text{whence} \quad \frac{c_* B_*}{4} = \frac{5}{4} \cdot 10^{503}.
$$
Thus $L + \delta_* M < c_* B_* / 4$. Using $1 < \log 3$ and $\log((1/2)/\varepsilon(B_*)) = B_* \log 3$, this proves:
$$
L + \delta_* M < \frac{c_*}{4} \log\left( \frac{1/2}{\varepsilon_*} \right).
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ThetaCompactStripRationalCore`):
```lean
theorem compact_payment
    {L δ M strip arrival total w : ℝ}
    (hδ : 0 ≤ δ) (hwM : w ≤ M)
    (hstrip : -L ≤ strip)
    (hrate : L + δ * M < arrival)
    (hdecomp : total = strip + arrival) :
    δ * w < total

theorem explicit_resolvent_bound
    {P C : ℝ} {B : ℕ}
    (hresolvent : P ≤ barrierM * C / deltaStar)
    (hC : C ≤ (3 : ℝ) ^ B / 2) :
    P ≤ 4 * (10 : ℝ) ^ 1046 * (3 : ℝ) ^ B

theorem explicit_arrival_payment
    {q : ℝ}
    (hlog3 : (1 : ℝ) < Real.log 3)
    (hthetaRate :
      cStar / 4 * Real.log ((1 / 2 : ℝ) / epsilonStar) ≤ q) :
    stripL + deltaStar * barrierM < q

theorem explicit_strip_lower
    {d0 w Dc Dp total : ℝ}
    (hd0 : 0 ≤ d0) (hdhalf : d0 < 1 / 2)
    (hw0 : 0 ≤ w) (hwM : w ≤ barrierM)
    (hcontinuous : -barrierM / 2 ≤ Dc)
    (hprime : -576 * barrierM < Dp)
    (hdecomp : total = Dc + Dp - (1 / 2 - d0) * w) :
    -stripL < total
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
