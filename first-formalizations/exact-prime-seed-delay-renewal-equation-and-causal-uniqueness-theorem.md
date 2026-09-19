# First Formalization: Exact Prime Seed Delay Renewal Equation and Causal Uniqueness Theorem

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedDelay.lean`](../../formalization/BuildingBlocks/PrimeSeedDelay.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact clock shift scaling identity, the global delay renewal equation on $\mathbb{R}$, the finite unrolled complete-history identity, and the unconditional causal uniqueness theorem for the prime successor seed in Lean 4:

1. **Clock Shift Scaling:**
   Formal proof that $\text{seed}_L(v + L) = e^{-L/2} \text{seed}_L(v)$ (`seed_add_clock`).
2. **Delay Renewal Equation:**
   Formal proof that $\text{seed}_L(v) = \text{initialCell}_L(v) + e^{-L/2} \text{seed}_L(v - L)$ on all of $\mathbb{R}$ (`seed_delay_equation`).
3. **Finite Unrolling and History Expansion:**
   Formal proofs of the $N$-step unrolling identity and the finite history expansion (`iterate_delay`, `seed_finite_history`).
4. **Unconditional Causal Uniqueness:**
   Formal proof that causality and the delay equation uniquely determine the seed without auxiliary growth hypotheses (`seed_unique`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Clock shift scaling
theorem seed_add_clock {L v : ℝ} (hL : 0 < L) (hv : L ≤ v) :
    seed L (v + L) = exp (-L / 2) * seed L v

-- Inhomogeneous delay renewal equation
theorem seed_delay_equation {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v = initialCell L v + exp (-L / 2) * seed L (v - L)

-- N-step unrolling identity
theorem iterate_delay {f g : ℝ → ℝ} {L r : ℝ}
    (h : ∀ v, f v = g v + r * f (v - L)) (N : ℕ) (v : ℝ) :
    f v = (∑ j ∈ Finset.range N, r ^ j * g (v - j * L)) +
      r ^ N * f (v - N * L)

-- Finite history expansion
theorem seed_finite_history {L v : ℝ} (hL : 0 < L) (N : ℕ)
    (hv : v < (N + 1 : ℝ) * L) :
    seed L v = ∑ j ∈ Finset.range N,
      exp (-L / 2) ^ j * initialCell L (v - j * L)

-- Unconditional causal uniqueness
theorem seed_unique {L : ℝ} (hL : 0 < L) {f : ℝ → ℝ}
    (hzero : ∀ v < L, f v = 0)
    (hdelay : ∀ v, f v = initialCell L v + exp (-L / 2) * f (v - L)) :
    f = seed L
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing that the prime successor seed is the unique causal solution of its delay renewal equation without needing any a priori integrability or growth bounds.
