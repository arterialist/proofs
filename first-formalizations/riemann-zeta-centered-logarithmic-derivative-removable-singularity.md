# First Formalization: Riemann Zeta Centered Logarithmic Derivative Removable Singularity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/RiemannZetaCenteredLogDeriv.lean`](../../formalization/BuildingBlocks/RiemannZetaCenteredLogDeriv.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the removable singularity of the centered logarithmic derivative of the Riemann zeta function at $s = 1$ in Lean 4:

1. **Entire Normalized Zeta Function:**
   Formal construction of $U(s) = (s-1)\zeta(s)$ with $U(1) = 1$ and proof that $U$ is differentiable everywhere on $\mathbb{C}$ (`differentiable_U`, `analyticAt_U`).
2. **Euler–Mascheroni Derivative Value:**
   Formal evaluation of $U'(1) = \gamma$ (`hasDerivAt_U_one`) using Mathlib's `tendsto_riemannZeta_sub_one_div`.
3. **Equivalence on Punctured Neighborhood:**
   Formal proof that the centered expression $G(s) = -\zeta'(s)/\zeta(s) - s/(s-1)$ matches $G_{\mathrm{ext}}(s) = -U'(s)/U(s) - 1$ on a punctured neighborhood of $1$ (`G_eventuallyEq_Gext`).
4. **Analyticity at $s = 1$:**
   Formal proof that the filled function $G_{\mathrm{filled}}$ is analytic at $s = 1$ (`analyticAt_Gfilled_one`) and takes the exact value $G_{\mathrm{filled}}(1) = -\gamma - 1$ (`Gfilled_one`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Entireness of U(s)
theorem differentiable_U : Differentiable ℂ U

-- Complex derivative at 1 equals Euler-Mascheroni constant
theorem hasDerivAt_U_one :
    HasDerivAt U (Real.eulerMascheroniConstant : ℂ) 1

-- Analyticity of filled centered logarithmic derivative at 1
theorem analyticAt_Gfilled_one : AnalyticAt ℂ Gfilled 1

-- Exact value at pole
theorem Gfilled_one : Gfilled 1 = -(Real.eulerMascheroniConstant : ℂ) - 1
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 that the centered logarithmic derivative $-\zeta'(s)/\zeta(s) - s/(s-1)$ is analytic at $s = 1$ with exact value $-\gamma - 1$.
