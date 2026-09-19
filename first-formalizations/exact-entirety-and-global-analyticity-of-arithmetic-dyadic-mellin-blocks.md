# First Formalization: Exact Entirety and Global Analyticity of Arithmetic Dyadic Mellin Blocks

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseBlockAnalytic.lean`](../../formalization/BuildingBlocks/CoarseBlockAnalytic.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the entirety (global complex differentiability) of finite arithmetic Mellin integrals and the analyticity of dyadic prime error blocks across the complex plane in Lean 4:

1. **Entirety of Finite Prime Mellin Integrals:**
   Formal proof of `coarsePrime_finiteMellin_differentiable`: For any $X > 0$, $s \mapsto \int_X^{2X} \Delta(x) x^{-(s+1)} dx$ is differentiable on all of $\mathbb{C}$.
2. **Analyticity of Dyadic Mellin Blocks:**
   Formal proof of `coarseMellinBlock_analytic`: For every $k \in \mathbb{N}$, $s \mapsto \text{coarseMellinBlock}(k, s)$ is analytic on $\mathbb{C}$.
3. **Parametric Dominated Differentiation:**
   Machine-verified application of Leibniz's rule under local uniform bounds on compact cylinders $\overline{B}(s, 1) \times [X, 2X]$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite Mellin integral of the prime error function is an entire function on C
theorem coarsePrime_finiteMellin_differentiable {X : ℝ} (hX : 0 < X) :
    Differentiable ℂ (fun s : ℂ => ∫ x in X..(2 * X),
      (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

-- Dyadic Mellin blocks are analytic on the entire complex plane
theorem coarseMellinBlock_analytic (k : ℕ) :
    AnalyticOnNhd ℂ (coarseMellinBlock k) Set.univ
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that localized dyadic Mellin blocks of the prime counting error $\psi(x) - x$ are entire and analytic on the entire complex plane $\mathbb{C}$, confirming that all arithmetic singularities are global phenomena of infinite dyadic summation.
