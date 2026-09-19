# Unique Contribution 274: Exact Compact-Strip Theta Payment and Explicit Rational Core Margin

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean`](../../formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean), [`building-blocks/spectral/compact-strip-rational-core.md`](../../building-blocks/spectral/compact-strip-rational-core.md)  
**Classification:** Operator Theory / Resolvent Bounds / Order Theory / Theta Regularization / Compact Strip Coercivity / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the boundary control of the Hamiltonian generator along the critical strip, non-conservative losses arising from continuous backgrounds, prime-power generators, and spectral projections must be dominated by a positive theta arrival payment. This file isolates and proves the rational and order-theoretic core that turns analytic operator bounds into explicit numerical coercivity margins.

This contribution proves:

1. **Order-Theoretic Compact-Strip Payment Principle:**  
   For any parameters satisfying $-L \le \text{strip}$, $w \le M$, and arrival rate $L + \delta M < \text{arrival}$ (or $\le$), the net quadratic form $\text{total} = \text{strip} + \text{arrival}$ strictly bounds the weighted state energy:
   \[
   \delta \cdot w < \text{total}.
   \]
2. **Explicit Numerical Deficit Margin Overcoming Strip Loss:**  
   With the explicit parameters:
   - $\text{stripL} = 10^{503}$,
   - $\text{barrierM} = 10^{500}$,
   - $\delta_* = \frac{1}{8 \cdot 10^{546}}$,
   - $B_* = 5 \cdot 10^{503} \cdot 3^{\text{stripExponent}}$,
   - $c_* = 3^{-\text{stripExponent}}$,
   the explicit payment margin strictly satisfies:
   \[
   \text{stripL} + \delta_* M < \frac{c_* B_*}{4}.
   \]
3. **Full Logarithmic Arrival Payment Settlement:**  
   Under the rational cutoff $\epsilon_* = \frac{1}{2 \cdot 3^{B_*}}$, and given the elementary transcendental bound $1 < \log 3$:
   \[
   \text{stripL} + \delta_* M < \frac{c_*}{4} \log\left(\frac{1/2}{\epsilon_*}\right).
   \]
   Hence any continuous arrival rate $q \ge \frac{c_*}{4} \log\left(\frac{1/2}{\epsilon_*}\right)$ unconditionally pays the entire compact-strip deficit.
4. **Coarse Resolvent Operator Bound:**  
   Combining the analytic resolvent bound $P \le M C / \delta$ with the Schur kernel bound $C \le 3^B / 2$ yields the exact uniform operator bound:
   \[
   P \le 4 \cdot 10^{1046} \cdot 3^B.
   \]
5. **Spectral-Continuous-Prime Aggregated Strip Lower Bound:**  
   Aggregating continuous loss $D_c \ge -M/2$, prime-power loss $D_p > -576 M$, and spectral projection loss $-(1/2 - d_0) w \ge -M/2$ (for $0 \le d_0 < 1/2$ and $w \le M$):
   \[
   \text{total} = D_c + D_p - (1/2 - d_0) w > -577 M > -\text{stripL} = -10^{503}.
   \]

---

## 2. Mathematical Proof

### 2.1. Compact Payment Principle
\[
\text{total} = \text{strip} + \text{arrival} \ge -L + \text{arrival}.
\]
Since $\text{arrival} > L + \delta M$:
\[
\text{total} > -L + (L + \delta M) = \delta M \ge \delta w.
\]

### 2.2. Explicit Margin
Evaluating the product $c_* B_*$:
\[
c_* B_* = 3^{-\text{stripExponent}} \cdot \left( 5 \cdot 10^{503} \cdot 3^{\text{stripExponent}} \right) = 5 \cdot 10^{503}.
\]
Then:
\[
\frac{c_* B_*}{4} = \frac{5}{4} \cdot 10^{503} = 10^{503} + \frac{1}{4} \cdot 10^{503}.
\]
On the left side:
\[
\text{stripL} + \delta_* M = 10^{503} + \frac{10^{500}}{8 \cdot 10^{546}} = 10^{503} + \frac{1}{8 \cdot 10^{46}} < 10^{503} + \frac{1}{4} \cdot 10^{503} = \frac{c_* B_*}{4}.
\]

### 2.3. Resolvent Constant
\[
\frac{M \cdot (3^B / 2)}{\delta_*} = \frac{10^{500} \cdot 3^B / 2}{1 / (8 \cdot 10^{546})} = 10^{500} \cdot 4 \cdot 10^{546} \cdot 3^B = 4 \cdot 10^{1046} \cdot 3^B.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ThetaCompactStripRationalCore` in `formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean`):
```lean
theorem compact_payment
    {L δ M strip arrival total w : ℝ}
    (hδ : 0 ≤ δ) (hwM : w ≤ M)
    (hstrip : -L ≤ strip)
    (hrate : L + δ * M < arrival)
    (hdecomp : total = strip + arrival) :
    δ * w < total

theorem schur_at_epsilonOf
    {C r : ℝ} {B : ℕ}
    (hschur : C ≤ r / 4) (hr : r ≤ 1 / epsilonOf B) :
    C ≤ (3 : ℝ) ^ B / 2

lemma explicit_payment_margin :
    stripL + deltaStar * barrierM <
      cStar * (explicitB : ℝ) / 4

theorem explicit_arrival_payment
    {q : ℝ}
    (hlog3 : (1 : ℝ) < Real.log 3)
    (hthetaRate :
      cStar / 4 * Real.log ((1 / 2 : ℝ) / epsilonStar) ≤ q) :
    stripL + deltaStar * barrierM < q

theorem explicit_resolvent_bound
    {P C : ℝ} {B : ℕ}
    (hresolvent : P ≤ barrierM * C / deltaStar)
    (hC : C ≤ (3 : ℝ) ^ B / 2) :
    P ≤ 4 * (10 : ℝ) ^ 1046 * (3 : ℝ) ^ B

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

## 4. Literature Context and Target Venues

- **Prior Literature:** Resolvent estimates and coercive operator inequalities in non-self-adjoint boundary value problems (Davies 2007, Trefethen-Embree 2005). Establishing verified explicit rational bounds overcoming continuous-prime-spectral losses in Lean 4 is new.
- **Advancement:** Formalizes the complete arithmetic core connecting operator-theoretic resolvents with explicit numeric constants ($10^{503}, 10^{1046}$).
- **Target Venues:** *SIAM Journal on Mathematical Analysis* or *Journal of Functional Analysis*.
