# First Formalization: Exact Centered Riesz-Mellin Identity for Distinct Prime Pairs

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact decomposition of the centered prime-pair tent into full minus same-prime proper powers, the explicit finite real cutoff formula, and the closed algebraic Mellin transform identity on $\operatorname{Re}(s) > 1$ in Lean 4:

1. **Distinct-Prime Tent Decomposition:**
   Formal proof of $V(x) = N(x) - T(x)$ (`V_eq_N_sub_T`).
2. **Explicit Real Cutoff Identity:**
   Formal derivation of $V(x) = \sum_{n \le x} ((x-n)\Lambda_{\text{distinct}}(n) - \Lambda(n)(x^2-n^2)/n) + B(x)$ (`V_eq_real_cutoff`).
3. **Centered Riesz-Mellin Identity:**
   Formal derivation of $\mathcal{M}(V)(-s-1) = \frac{(\mathcal{L}_c(s))^2 - H(s)}{s(s+1)}$ (`hasMellin_V`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact decomposition into full square minus same-prime diagonal powers
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

-- Explicit atom-plus-Lebesgue cross sum
theorem etaSum_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    etaSum x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((ArithmeticFunction.vonMangoldt n *
          ((x^2 - (n : ℝ)^2) / (2 * n)) : ℝ) : ℂ)

-- Explicit finite real cutoff formula
theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x

-- Centered Riesz-Mellin identity on Re(s) > 1
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

This entry documents a machine-verified implementation in Lean 4 proving the exact Riesz-Mellin transform formula $\mathcal{M}(V)(-s-1) = \frac{(\mathcal{L}_c(s))^2 - H(s)}{s(s+1)}$ for centered distinct prime-pair correlations.
