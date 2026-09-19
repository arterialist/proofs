# First Formalization: Collective All-Prime Seed Square-Integrability and Transposed Memory Defect Representation

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean), [`formalization/BuildingBlocks/AllPrimeMemoryKernel.lean`](../../formalization/BuildingBlocks/AllPrimeMemoryKernel.lean), [`formalization/BuildingBlocks/MemoryChargeFubini.lean`](../../formalization/BuildingBlocks/MemoryChargeFubini.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the unconditional $L^2$ theory of the collective prime seed and the exact integral kernel representation of its causal memory defect:

1. **Three-Region Prime Tail Bounds:**
   Formal proof of the finite prime cube tail bound $\sum_{p \in S, p > Z} 1/p^3 \le 4/Z^2$ (`finite_prime_cube_tail`), prime cardinality bound $\operatorname{card}(S) \le Z$ (`finite_prime_card_le`), and the three-region bounds for small (`finite_seed_small_region`), middle (`finite_seed_middle_region`), and large (`finite_seed_large_region`) primes.
2. **Universal Age Bound:**
   Formal derivation of the age-weighted inequality $v \cdot \operatorname{finitePrimeSeed}(S, v) \le 64 \log 2 + 30$ on $v \ge 3 \log 2$ (`finite_seed_age_bound`, `allPrimeSeed_age_bound`).
3. **Square-Integrability via Finite Lévy Activity:**
   Formal domination proof showing that $(\operatorname{allPrimeSeed}(v))^2 \le (64 \log 2 + 30) \operatorname{allPrimeSeed}(v)/v$, and combining this with the finite mass of the collective Lévy measure to prove $\operatorname{allPrimeSeed} \in L^2(\mathbb{R})$ (`integrable_allPrimeSeed_square`, `allPrimeSeed_memLp_two`).
4. **Fubini Exchange for Memory Product:**
   Formal proof that the bivariate kernel $K(v, u) = \operatorname{kernel}(v) F(v-u) f(u)$ is absolutely integrable on $(0, \infty) \times (0, \infty)$ (`memory_charge_product_integrable`).
5. **Transposed Defect and Commutator Identities:**
   Formal derivation of the defect integral identity $\operatorname{defect}(\operatorname{causalMemory}(\operatorname{allPrimeSeed}, f)) = \int_0^\infty \operatorname{memoryDefectKernel}(\operatorname{allPrimeSeed}, u) f(u) du$ (`allPrimeSeed_defect_causalMemory`) and the commutator identity (`allPrimeSeed_corrected_kernel_identity`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Universal age bound
theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30

-- Unconditional L^2 square-integrability
theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2)
theorem allPrimeSeed_memLp_two : MemLp allPrimeSeed 2 volume

-- Transposed defect identity
theorem allPrimeSeed_defect_causalMemory {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    SuccessorCharge.defect (SuccessorCharge.causalMemory allPrimeSeed f) =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel allPrimeSeed u * f u

-- Commutator kernel identity
theorem allPrimeSeed_corrected_kernel_identity {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory allPrimeSeed f) v -
      SuccessorCharge.causalMemory allPrimeSeed (SuccessorCharge.compensated f) v =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.correctedMemoryKernel allPrimeSeed v u * f u
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof that the superposition of all prime jump seeds is unconditionally square-integrable on $\mathbb{R}$ without assuming the Prime Number Theorem or any zero-free region, providing the rigorous foundation for collective prime memory semigroups.
