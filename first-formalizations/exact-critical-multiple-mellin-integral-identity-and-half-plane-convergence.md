# First Formalization: Exact Critical-Multiple Mellin Integral Identity and Half-Plane Convergence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalMellin.lean`](../../formalization/BuildingBlocks/ActualCriticalMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact support properties, shifted zeta convolution, and explicit endpoint-justified integral representation of the critical multiple correlation function $W(x)$ in Lean 4:

1. **Exact Support and Real-Valuedness:**
   Formal proofs that $V(x) = 0$ and $W(x) = 0$ for $x \le 1$, and that both functions have identically vanishing imaginary parts (`V_zero`, `W_zero`, `V_real`, `W_real`).
2. **Critical Mellin Transform Identity:**
   Formal proof that $\mathcal{M}(W)(-s-1) = \zeta(s + 1/2) \mathcal{M}(V)(-s-1)$ on the half-plane $\operatorname{Re}(s) > 1$ (`hasMellin_W`, `hasMellin_W_filled`).
3. **Certified Lower-Endpoint Integral Representation:**
   Formal proofs of absolute integrability and the explicit integral formula $\int_1^\infty x^{-s-2} W(x) \, dx = \mathcal{T}(s)$ on the restricted ray $[1, \infty)$ (`integrableOn_W_Ioi_one`, `integral_W_Ioi_one`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Vanishing on the interval [0, 1]
theorem W_zero {x : ℝ} (hx : x ≤ 1) : W x = 0

-- Shifted zeta Mellin convolution identity
theorem hasMellin_W {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.transform s)

-- Absolute integrability on [1, ∞)
theorem integrableOn_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ)^(-s-2) * W x) (Ioi 1)

-- Explicit integral representation
theorem integral_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ)^(-s-2) * W x) =
      CriticalTransformPoles.transform s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 linking the arithmetic critical multiple aggregation $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$ to its explicit half-line Mellin integral $\int_1^\infty x^{-s-2} W(x) dx = \zeta(s + 1/2) \mathcal{M}(V)(-s-1)$ with certified zero support below $x=1$.
