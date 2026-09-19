# First Formalization: Exact Centered Distinct-Prime Tent Mellin Representation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact real cutoff formula and Mellin transform representation of the centered distinct-prime tent function in Lean 4:

1. **Tent Diagonal Subtraction:**
   Formal proof of $V(x) = N(x) - T(x)$ decomposing the tent into full centered square minus same-prime diagonal powers (`V_eq_N_sub_T`).
2. **Explicit Real Cutoff Identity:**
   Formal evaluation of $V(x)$ as a finite integer sum $\sum_{n \le x} ((x-n)d(n) - \Lambda(n)\frac{x^2-n^2}{n}) + B(x)$ (`V_eq_real_cutoff`).
3. **Mellin Transform Representation:**
   Formal proof that $\mathcal{M}(V)(-s-1) = \frac{(-\zeta'/\zeta(s) - 1/(s-1))^2 - H(s)}{s(s+1)}$ on the half-plane $\operatorname{Re}(s) > 1$ (`hasMellin_V`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Decomposition of centered distinct-prime tent
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

-- Real cutoff evaluation
theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x

-- Exact Mellin transform representation
theorem hasMellin_V {s : ℂ} (hs : 1 < s.re) :
    HasMellin V (-s-1)
      ((LogDerivativePole.centeredZetaLogDerivative s ^ 2 -
        SamePrimeDirichlet.H s) / (s * (s+1)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 computing the exact Mellin transform of centered distinct prime pair correlation functions, with pole cancellation and proper power extraction certified by foundational axioms.
