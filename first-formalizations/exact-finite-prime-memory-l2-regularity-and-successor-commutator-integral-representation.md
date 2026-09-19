# First Formalization: Exact Finite-Prime Memory L2 Regularity and Successor Commutator Integral Representation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedMemory.lean`](../../formalization/BuildingBlocks/PrimeSeedMemory.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the $L^2(\mathbb{R})$ membership of individual prime seeds, the $L^2(\mathbb{R})$ stability of finite-prime aggregations without proper-power cutoffs, and the exact Lie-Volterra commutator integral representation for the successor operator in Lean 4:

1. **Individual Prime Seed $L^2$ Regularity:**
   Formal proof that $\text{seed}_L \in L^2(\mathbb{R}, \text{volume})$ (`seed_memLp_two`).
2. **Finite-Prime Sum Measurability and $L^2$ Space:**
   Formal proof that $\text{finitePrimeSeed}_S = \sum_{p \in S} \text{seed}_{\log p}$ is measurable and belongs to $L^2(\mathbb{R})$ (`measurable_finitePrimeSeed`, `finitePrimeSeed_memLp_two`).
3. **Exact Commutator Integral Operator Representation:**
   Formal proof that $[\mathcal{S}, \mathcal{K}_S] f(v) = \int_0^\infty M_S(v, u) f(u) \, du$ for any $f \in L^2((0, \infty))$ (`finitePrimeSeed_memory_commutator`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Individual seed L² membership
theorem seed_memLp_two {L : ℝ} (hL : 0 < L) : MemLp (seed L) 2 volume

-- Measurability of finite-prime seed
theorem measurable_finitePrimeSeed (S : Finset Nat.Primes) :
    Measurable (finitePrimeSeed S)

-- Finite-prime seed L² membership
theorem finitePrimeSeed_memLp_two (S : Finset Nat.Primes) :
    MemLp (finitePrimeSeed S) 2 volume

-- Lie-Volterra memory commutator integral representation
theorem finitePrimeSeed_memory_commutator (S : Finset Nat.Primes) {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.successor (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.successor f) v =
    ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryKernel (finitePrimeSeed S) v u * f u
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that the commutator of the successor operator and the finite-prime causal memory operator is an integral operator with explicit kernel $M_S(v, u)$, retaining all prime-power cells without cutoff.
