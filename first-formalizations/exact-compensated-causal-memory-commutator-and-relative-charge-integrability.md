# First Formalization: Exact Compensated Causal Memory Commutator and Relative Charge Integrability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompensatedMemoryKernel.lean`](../../formalization/BuildingBlocks/CompensatedMemoryKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the Cauchy-Schwarz bound, unconditional integrability of the defect charge, and the exact compensated memory commutator identity in Lean 4:

1. **Causal Memory Bound:**
   Formal proof of `causalMemory_bound`: $|\text{causalMemory}(F, f)(v)| \le \|F\|_2 \|f\|_2$.
2. **Defect Charge Integrability:**
   Formal proof of `integrable_memory_defect`: $\text{kernel} \cdot \text{causalMemory}(F, f) \in L^1(\mathbb{R}_+)$.
3. **Exact Compensated Commutator Identity:**
   Formal proofs of `compensated_memory_commutator` and `finitePrimeSeed_compensated_memory_commutator`: Exact evaluation of the difference $\text{compensated}(\text{causalMemory}(F, f)) - \text{causalMemory}(F, \text{compensated}(f))$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Uniform Cauchy-Schwarz bound for causal memory convolution
theorem causalMemory_bound {F f : ℝ → ℝ} (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    |causalMemory F f v| ≤ sqrt (∫ x, F x ^ 2) * sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2)

-- Absolute integrability of output relative charge
theorem integrable_memory_defect {F f : ℝ → ℝ} (hmF : Measurable F) (hmf : Measurable f)
    (hF : MemLp F 2 volume) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun v => kernel v * causalMemory F f v) (Ioi (0 : ℝ))

-- Exact compensated commutator identity
theorem compensated_memory_commutator {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    compensated (causalMemory F f) v - causalMemory F (compensated f) v =
      (∫ u in Ioi (0 : ℝ), memoryKernel F v u * f u) +
      causalMemory F (fun u => exp (-u / 2)) v * defect f -
      exp (-v / 2) * defect (causalMemory F f)

-- Finite prime seed specialization
theorem finitePrimeSeed_compensated_memory_commutator (S : Finset Nat.Primes)
    {f : ℝ → ℝ} (hmf : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.compensated f) v =
      (∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryKernel (finitePrimeSeed S) v u * f u) +
      SuccessorCharge.causalMemory (finitePrimeSeed S) (fun u => exp (-u / 2)) v *
        SuccessorCharge.defect f - exp (-v / 2) *
        SuccessorCharge.defect (SuccessorCharge.causalMemory (finitePrimeSeed S) f)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the exact compensated commutator identity and output defect charge integrability for causal half-line memory operators.
