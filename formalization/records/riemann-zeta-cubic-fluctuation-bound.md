# Cubic Fluctuation Bound and Divisor Sum Convergence

**Module Path**: `formalization/BuildingBlocks/RiemannZetaCubicFluctuationBound.lean`  
**Audit Path**: `formalization/verification/RiemannZetaCubicFluctuationBoundAudit.lean`  
**Root Module**: `formalization/BuildingBlocks.lean`  
**Dependencies**:
- `BuildingBlocks.RiemannZetaChebyshevFluctuationBound`
- `Mathlib.Algebra.BigOperators.Intervals`
- `Mathlib.Tactic`

---

## 1. Mathematical and Formal Context

This module advances the discrete arithmetic bound on the centered prime fluctuation sum $\operatorname{fullNumerator}(x)$ and critical transform kernel $\mathcal{W}(x)$ from the quartic bound $O(x^4)$ of Module 324 down to a sharp cubic bound $O(x^3)$ for all $x \ge 0$.

In `RiemannZetaChebyshevFluctuationBound.lean`, each term in the divisor sum:
$$\operatorname{fullNumerator}(x) = \sum_{d \le x} \sqrt{d} N(x/d)$$
was bounded individually by $C_N x^3$, yielding $C_N x^4$ via the trivial bound $\lfloor x \rfloor \le x$.

In this module, we evaluate the divisor convolution directly against the convergent Dirichlet series $\sum d^{-5/2}$:
$$\sum_{d \le x} \sqrt{d} \left(\frac{x}{d}\right)^3 = x^3 \sum_{d \le x} \frac{\sqrt{d}}{d^3} \le x^3 \sum_{d \le x} \frac{1}{d^2}.$$

Using the induction $\sum_{d=1}^N \frac{1}{d^2} \le 2 - \frac{1}{N} \le 2$ for all $N \ge 1$, we establish:
$$\sum_{d \le x} \sqrt{d} \left(\frac{x}{d}\right)^3 \le 2 x^3 \quad (\forall x \ge 0).$$

Combined with the centered Mellin bound $\operatorname{Re}(N(u)) \le C_N u^3$, this yields:
$$\operatorname{Re}(\operatorname{fullNumerator}(x)) \le C_{\text{cubic}} x^3 \quad (\forall x \ge 0)$$
$$\operatorname{Re}(\mathcal{W}(x)) \le C_{\text{cubic}} x^3 \quad (\forall x \ge 0)$$
where $C_{\text{cubic}} = 2 C_N = 2 ((4 \log 2)^2 + 1) > 0$.

---

## 2. Machine-Verified Theorems (11 Declarations)

All declarations have been machine-checked in Lean 4.34.1 with **0 `sorry`**, **0 `sorryAx`**, and **strictly foundational axioms** `[propext, Classical.choice, Quot.sound]`:

1. `sum_inv_sq_le_two_sub_inv`:
   $$\sum_{d=1}^N \frac{1}{d^2} \le 2 - \frac{1}{N} \quad (\forall N \ge 1)$$
2. `sum_inv_sq_le_two`:
   $$\sum_{d=1}^N \frac{1}{d^2} \le 2 \quad (\forall N \in \mathbb{N})$$
3. `sqrt_div_pow_three_le_one_div_sq`:
   $$\frac{\sqrt{d}}{d^3} \le \frac{1}{d^2} \quad (\forall d \ge 1)$$
4. `sum_sqrt_div_pow_three_le_two`:
   $$\sum_{d=1}^N \frac{\sqrt{d}}{d^3} \le 2 \quad (\forall N \in \mathbb{N})$$
5. `sum_sqrt_mul_div_le`:
   $$\sum_{d=1}^N \sqrt{d} \left(\frac{x}{d}\right)^3 \le 2 x^3 \quad (\forall x \ge 0, N \in \mathbb{N})$$
6. `C_cubic` & `C_cubic_pos`:
   Explicit universal constant $C_{\text{cubic}} = 2 C_N = 2 ((4 \log 2)^2 + 1) > 0$.
7. `fullNumerator_re_le_cubic`:
   $$\forall x \ge 0, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C_{\text{cubic}} x^3$$
8. `W_re_le_cubic`:
   $$\forall x \ge 0, \operatorname{Re}(\mathcal{W}(x)) \le C_{\text{cubic}} x^3$$
9. `eventually_fullNumerator_re_le_cubic`:
   $$\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C_{\text{cubic}} x^3$$
10. `eventually_W_re_le_cubic`:
    $$\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\mathcal{W}(x)) \le C_{\text{cubic}} x^3$$
