# First Formalization: Exact Global Cubic Arcsine Sandwich Inequality

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeArcsinBound.lean`](../../formalization/BuildingBlocks/ChargeArcsinBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact, non-asymptotic global cubic sandwich inequality for $\arcsin(z) - z$ on the interval $[0, 1/\sqrt{2}]$ in Lean 4:

1. **Derivative Bound:**
   Formal proof that $0 \le \frac{1}{\sqrt{1 - x^2}} - 1 \le x^2$ for $x \ge 0$ and $x^2 \le 1/2$.
2. **Monotonicity via Mean Value Theorem:**
   Formal verification that both $\arcsin x - x$ and $\frac{x^3}{3} - (\arcsin x - x)$ have nonnegative derivatives on $[0, z]$.
3. **Grand Global Cubic Sandwich Theorem:**
   Formal proof of `arcsin_sub_bounds`:
   $$
   0 \le \arcsin(z) - z \le \frac{z^3}{3} \quad \text{for all } z \ge 0 \text{ with } z^2 \le 1/2.
   $$

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-asymptotic global cubic sandwich inequality for arcsine
theorem arcsin_sub_bounds {z : ℝ} (hz : 0 ≤ z) (hz2 : z ^ 2 ≤ 1 / 2) :
    0 ≤ Real.arcsin z - z ∧ Real.arcsin z - z ≤ z ^ 3 / 3
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the global cubic sandwich inequality $0 \le \arcsin(z) - z \le z^3/3$ across the entire domain $[0, 1/\sqrt{2}]$ using constructive monotonicity, eliminating Taylor expansion remainders in the analysis of arithmetic angle defects.
