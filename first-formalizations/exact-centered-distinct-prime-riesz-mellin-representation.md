# First Formalization: Exact Centered Distinct-Prime Riesz-Mellin Representation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCenteredMellin.lean`](../../formalization/BuildingBlocks/ActualCenteredMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic decomposition of the centered prime pair tent and its explicit Mellin transform evaluation on the absolute convergence half-plane $\text{Re}(s) > 1$ in Lean 4:

1. **Tent Decomposition and Real Cutoff Formulas:**
   Formal proofs of `V_eq_N_sub_T` ($V = N - T$) and `V_eq_real_cutoff`: Explicit representation of $V(x)$ via arithmetic convolution weights and the baseline $B(x)$.
2. **Eta Cross Term Identification:**
   Formal proof of `etaSum_eq_crossTerm`: Proving equivalence between the finite atom sum and the continuous cross term.
3. **Grand Centered Distinct-Prime Mellin Identity:**
   Formal proof of `hasMellin_V`: Evaluates $\mathcal{M}[V](-s-1) = \frac{(\text{centeredZetaLogDerivative}(s))^2 - H(s)}{s(s+1)}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Algebraic decomposition of the centered distinct-prime tent
theorem V_eq_N_sub_T (x : ℝ) : V x = N x - T x

-- Real cutoff formula with baseline
theorem V_eq_real_cutoff {x : ℝ} (hx : 0 ≤ x) :
    V x =
      ((∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        ((x - n) * distinctPrimePairWeight n -
          ArithmeticFunction.vonMangoldt n * ((x^2 - (n : ℝ)^2) / n)) : ℝ) : ℂ) +
        EtaBaselineMellin.B x

-- Grand Mellin transform identity on Re(s) > 1
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

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 evaluating the Mellin transform of off-diagonal prime correlation tents with exact subtraction of the diagonal $H(s)$ and complete cancellation of the principal pole at $s=1$.
