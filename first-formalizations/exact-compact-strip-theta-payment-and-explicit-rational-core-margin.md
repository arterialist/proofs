# First Formalization: Exact Compact-Strip Theta Payment and Explicit Rational Core Margin

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean`](../../formalization/BuildingBlocks/ThetaCompactStripRationalCore.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the order-theoretic and rational arithmetic core that turns analytic theta arrival rates, Schur integral estimates, and resolvent bounds into explicit numerical coercivity margins in Lean 4:

1. **Order-Theoretic Payment Principle:**
   Formal proof of `compact_payment`: $\delta \cdot w < \text{total}$ whenever $-L \le \text{strip}$ and $L + \delta M < \text{arrival}$.
2. **Schur Integral Substitution:**
   Formal proof of `schur_at_epsilonOf`: $C \le 3^B / 2$ from $C \le r/4$ and $r \le 1/\epsilon$.
3. **Explicit Payment Deficit Margin:**
   Formal proof of `explicit_payment_margin`: $\text{stripL} + \delta_* M < c_* B_* / 4$.
4. **Logarithmic Arrival Settlement:**
   Formal proof of `explicit_arrival_payment`: Full settlement of the strip deficit from the analytic rate bound and $1 < \log 3$.
5. **Coarse Resolvent Operator Bound:**
   Formal proof of `explicit_resolvent_bound`: $P \le 4 \cdot 10^{1046} \cdot 3^B$.
6. **Aggregated Strip Loss Bounds:**
   Formal proof of `aggregate_strip_lower`: $\text{total} > -577 M$, and `explicit_strip_lower`: $\text{total} > -10^{503}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Compact strip payment principle
theorem compact_payment
    {L δ M strip arrival total w : ℝ}
    (hδ : 0 ≤ δ) (hwM : w ≤ M)
    (hstrip : -L ≤ strip)
    (hrate : L + δ * M < arrival)
    (hdecomp : total = strip + arrival) :
    δ * w < total

-- Schur bound at rational cutoff
theorem schur_at_epsilonOf
    {C r : ℝ} {B : ℕ}
    (hschur : C ≤ r / 4) (hr : r ≤ 1 / epsilonOf B) :
    C ≤ (3 : ℝ) ^ B / 2

-- Explicit payment margin
lemma explicit_payment_margin :
    stripL + deltaStar * barrierM <
      cStar * (explicitB : ℝ) / 4

-- Logarithmic arrival settlement
theorem explicit_arrival_payment
    {q : ℝ}
    (hlog3 : (1 : ℝ) < Real.log 3)
    (hthetaRate :
      cStar / 4 * Real.log ((1 / 2 : ℝ) / epsilonStar) ≤ q) :
    stripL + deltaStar * barrierM < q

-- Coarse resolvent bound
theorem explicit_resolvent_bound
    {P C : ℝ} {B : ℕ}
    (hresolvent : P ≤ barrierM * C / deltaStar)
    (hC : C ≤ (3 : ℝ) ^ B / 2) :
    P ≤ 4 * (10 : ℝ) ^ 1046 * (3 : ℝ) ^ B

-- Explicit strip loss lower bound
theorem explicit_strip_lower
    {d0 w Dc Dp total : ℝ}
    (hd0 : 0 ≤ d0) (hdhalf : d0 < 1 / 2)
    (hw0 : 0 ≤ w) (hwM : w ≤ barrierM)
    (hcontinuous : -barrierM / 2 ≤ Dc)
    (hprime : -576 * barrierM < Dp)
    (hdecomp : total = Dc + Dp - (1 / 2 - d0) * w) :
    -stripL < total
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 verifying the rational and order-theoretic core of the compact-strip theta regularization, combining explicit constants ($10^{503}, 10^{1046}$) with coercive resolvent and arrival estimates.
