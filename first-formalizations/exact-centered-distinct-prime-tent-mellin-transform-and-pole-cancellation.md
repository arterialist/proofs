# First Formalization: Exact Centered Distinct-Prime Tent Mellin Transform and Pole Cancellation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact decomposition of the centered distinct-prime cutoff sum $V(x) = N(x) - T(x)$, its finite real arithmetic representation, and its regularized Mellin transform $\frac{(-\zeta'/\zeta - 1/(s-1))^2 - H(s)}{s(s+1)}$ on $\text{Re}(s) > 1$ in Lean 4:

1. **Cutoff Sum Decomposition:**
   Formal proof that $V(x) = N(x) - T(x)$ (`V_eq_N_sub_T`).
2. **Eta Cross-Sum Representation:**
   Formal proof of the finite arithmetic summation for $\text{etaSum}(x)$ (`etaSum_eq_Icc`).
3. **Real Arithmetic Cutoff Formula:**
   Formal proof that $V(x)$ evaluates to an explicit finite sum of distinct-prime weights and eta corrections (`V_eq_real_cutoff`).
4. **Exact Mellin Transform with Pole Cancellation:**
   Formal proof that $\mathcal{M}(V)(-s-1) = \frac{(-\zeta'(s)/\zeta(s) - 1/(s-1))^2 - H(s)}{s(s+1)}$ on $\text{Re}(s) > 1$ (`hasMellin_V`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Decomposition into full centered square minus same-prime diagonal
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

-- Finite summation formula for the eta cross term
theorem etaSum_eq_Icc {x : ℝ} (hx : 0 ≤ x) :
    etaSum x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((ArithmeticFunction.vonMangoldt n *
          ((x^2 - (n : ℝ)^2) / (2 * n)) : ℝ) : ℂ)

-- Real arithmetic cutoff representation
theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x

-- Exact regularized Mellin transform with complete pole cancellation
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

This entry documents a machine-verified implementation in Lean 4 proving that the Mellin transform of the discrete centered distinct-prime cutoff sum equals the centered logarithmic derivative squared minus the same-prime Dirichlet series $H(s)$, rigorously cancelling the second- and first-order poles at $s=1$.
