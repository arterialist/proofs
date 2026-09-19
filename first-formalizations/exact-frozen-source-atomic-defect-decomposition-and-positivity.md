# First Formalization: Exact Frozen-Source Atomic Defect Decomposition and Positivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenSource.lean`](../../formalization/BuildingBlocks/ChargeFrozenSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the atomic expansion, origin value, growth decoupling, and unconditional defect non-negativity of the frozen Chebyshev prime error source in Lean 4:

1. **Origin Value:**
   Formal evaluation of $S_N(0) = -1$ (`causalSource_at_origin`).
2. **Atomic Source Decomposition:**
   Formal derivation of $S_N(v) = \sum_{n=2}^N \Lambda(n)\beta_n(v) - e^{v/2} + \text{tail}_N(v)$ (`source_decomposition`).
3. **Tail Integrability and Pointwise Non-Negativity:**
   Formal proofs that $\text{kernel}(v) \cdot \text{tail}_N(v)$ is integrable and non-negative (`kernel_tail_integrable`, `kernel_tail_nonnegative`).
4. **Exact Defect Formula:**
   Formal proof that $\text{defect}(S_N) = \sum_{n=2}^N \Lambda(n)\text{correction}(n) + \text{defect}(\text{tail}_N)$ (`original_defect_source`).
5. **Unconditional Defect Non-Negativity:**
   Formal proof of $\text{defect}(S_N) \ge 0$ and $\text{defect}(\text{causalSource}_N) \ge 0$ (`original_defect_source_nonnegative`, `original_defect_causalSource_nonnegative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Initial value at origin
theorem causalSource_at_origin {N : ℕ} (hN : 2 ≤ N) : causalSource N 0 = -1

-- Exact atomic decomposition
theorem source_decomposition {N : ℕ} (hN : 2 ≤ N) {v : ℝ} (_hv : 0 < v) :
    source N v = (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
      Real.exp (v / 2) + tail N v

-- Integrability and nonnegativity of the tail integrand
theorem kernel_tail_integrable (N : ℕ) :
    IntegrableOn (fun v => kernel v * tail N v) (Ioi (0 : ℝ))

theorem kernel_tail_nonnegative {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    0 ≤ kernel v * tail N v

-- Exact defect expansion
theorem original_defect_source {N : ℕ} (hN : 2 ≤ N) :
    defect (source N) =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * ChargeBirthSummability.correction n) +
        defect (tail N)

-- Unconditional defect nonnegativity
theorem original_defect_source_nonnegative {N : ℕ} (hN : 2 ≤ N) :
    0 ≤ defect (source N)

theorem original_defect_causalSource_nonnegative {N : ℕ} (hN : 2 ≤ N) :
    0 ≤ defect (causalSource N)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 decomposing the frozen prime-error source into arithmetic atoms, demonstrating that the background growth mode decouples identically from the defect, and proving unconditional non-negativity $\text{defect}(S_N) \ge 0$.
