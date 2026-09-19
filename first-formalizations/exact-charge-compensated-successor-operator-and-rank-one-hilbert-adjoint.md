# First Formalization: Exact Charge-Compensated Successor Operator and Rank-One Hilbert Adjoint

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCompensatedL2.lean`](../../formalization/BuildingBlocks/SuccessorCompensatedL2.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Hilbert-space adjoint of the charge-compensated successor operator $\mathcal{T}_{\text{comp}}$ on $L^2((0, \infty))$ as a rank-one perturbation of the predecessor operator $\mathcal{P}$ in Lean 4:

1. **$L^2$ Regularity of Basis States:**
   Formal proof that the reference ground state $e^{-v/2}$ (`reference_memLp`) and the memory kernel $K(u)$ (`kernel_memLp`) belong to $L^2((0, \infty))$.
2. **Adjoint Construction:**
   Formal definition of `compensatedAdjoint` as $\mathcal{P}[f](u) - \frac{1}{2}\langle e^{-v/2}, f \rangle K(u)$ and proof that it preserves $L^2((0, \infty))$ (`compensatedAdjoint_memLp`).
3. **Exact $L^2$ Duality Pairing:**
   Formal proof of the Hilbert adjoint pairing $\langle f, \mathcal{T}_{\text{comp}}[g] \rangle = \langle \mathcal{T}_{\text{comp}}^*[f], g \rangle$ (`compensated_adjoint`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- L² regularity of reference state
theorem reference_memLp :
    MemLp (fun v : ℝ => exp (-v / 2)) 2 (volume.restrict (Ioi (0 : ℝ)))

-- L² regularity of memory kernel
theorem kernel_memLp : MemLp kernel 2 (volume.restrict (Ioi (0 : ℝ)))

-- L² stability of compensated successor
theorem compensated_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (compensated f) 2 (volume.restrict (Ioi (0 : ℝ)))

-- Explicit definition of the adjoint
noncomputable def compensatedAdjoint (f : ℝ → ℝ) (u : ℝ) : ℝ :=
  predecessor f u - ((1 / 2) * ∫ v in Ioi (0 : ℝ), exp (-v / 2) * f v) * kernel u

-- L² stability of the adjoint
theorem compensatedAdjoint_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (compensatedAdjoint f) 2 (volume.restrict (Ioi (0 : ℝ)))

-- Exact L² duality pairing
theorem compensated_adjoint {f g : ℝ → ℝ} (hmf : Measurable f) (hmg : Measurable g)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ))))
    (hg : MemLp g 2 (volume.restrict (Ioi (0 : ℝ)))) :
    (∫ v in Ioi (0 : ℝ), f v * compensated g v) =
      ∫ u in Ioi (0 : ℝ), compensatedAdjoint f u * g u
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 constructing the exact Hilbert adjoint $\mathcal{T}_{\text{comp}}^*$ for charge-compensated successor dynamics, proving the rank-one perturbation formula and establishing $L^2$ duality.
