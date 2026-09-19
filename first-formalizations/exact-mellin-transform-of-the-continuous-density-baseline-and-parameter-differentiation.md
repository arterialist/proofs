# First Formalization: Exact Mellin Transform of the Continuous Density Baseline and Parameter Differentiation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/EtaBaselineMellin.lean`](../../formalization/BuildingBlocks/EtaBaselineMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the Mellin transform of the Heaviside step function $H_1$, the logarithmic step function $\log x \cdot H_1(x)$ via parameter differentiation, and the exact closed-form rational Mellin transform $\frac{s}{(s-1)^2(s+1)}$ of the continuous density baseline $B(x)$ in Lean 4:

1. **Step Function Transform:**
   Formal proof that $\mathcal{M}(H_1)(s) = -s^{-1}$ for $\text{Re}(s) < 0$ (`hasMellin_step`).
2. **Logarithmic Step Transform:**
   Formal proof that $\mathcal{M}(\log x \cdot H_1(x))(s) = s^{-2}$ using locally dominated parameter differentiation (`hasMellin_log_step`).
3. **Shifted Power-Log Transforms:**
   Formal proof of $\mathcal{M}(x^a H_1(x))(s) = -(s+a)^{-1}$ (`hasMellin_cpow_step`) and $\mathcal{M}(x^a \log x H_1(x))(s) = (s+a)^{-2}$ (`hasMellin_cpow_log_step`).
4. **Exact Baseline Mellin Rational Formula:**
   Formal proof that $\mathcal{M}(B)(-s-1) = \frac{s}{(s-1)^2(s+1)}$ on $\text{Re}(s) > 1$ (`hasMellin_B`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Heaviside step Mellin transform
lemma hasMellin_step {s : ℂ} (hs : s.re < 0) : HasMellin step s (-s⁻¹)

-- Logarithmic moment Mellin transform via dominated parameter differentiation
lemma hasMellin_log_step {s : ℂ} (hs : s.re < 0) :
    HasMellin (fun t => Real.log t • step t) s (1/s^2)

-- Shifted power transforms
lemma hasMellin_cpow_step {s a : ℂ} (hs : (s+a).re < 0) :
    HasMellin (fun x : ℝ => (x : ℂ)^a • step x) s (-(s+a)⁻¹)

lemma hasMellin_cpow_log_step {s a : ℂ} (hs : (s+a).re < 0) :
    HasMellin (fun x : ℝ => (x : ℂ)^a • (Real.log x • step x)) s
      (1/(s+a)^2)

-- Exact closed-form baseline Mellin transform
theorem hasMellin_B {s : ℂ} (hs : 1 < s.re) :
    HasMellin B (-s-1) (s / ((s-1)^2 * (s+1)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact rational Mellin transform of the logarithmic polynomial prime background baseline via dominated parameter differentiation under the improper integral.
