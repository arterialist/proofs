# Unique Contribution 203: Exact Charge-Compensated Successor Operator and Rank-One Hilbert Adjoint

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorCompensatedL2.lean`](../../formalization/BuildingBlocks/SuccessorCompensatedL2.lean), [`building-blocks/successor/successor-compensated-l2.md`](../../building-blocks/successor/successor-compensated-l2.md)  
**Classification:** Functional Analysis / Hilbert Space Operators / Adjoint Operators / Rank-One Perturbations / Successor Dynamics / $L^2$ Duality

---

## 1. Executive Summary and Mathematical Statement

In spectral approaches to the Riemann Hypothesis and non-self-adjoint operator algebras, the fundamental successor operator $\mathcal{S}$ is non-unitary and has a non-trivial defect. To restore charge conservation, the operator is modified by a rank-one projection along the reference ground state $e^{-v/2}$, yielding the charge-compensated successor operator $\mathcal{T}_{\text{comp}}$. To analyze the spectrum, Fredholm determinant, and spectral radius of $\mathcal{T}_{\text{comp}}$, its exact Hilbert space adjoint $\mathcal{T}_{\text{comp}}^*$ on $L^2((0, \infty))$ must be identified explicitly.

This contribution proves:

1. **$L^2$ Regularity of the Reference and Memory Kernel:**  
   Both the reference function $v \mapsto e^{-v/2}$ and the memory kernel $u \mapsto K(u)$ belong strictly to $L^2((0, \infty))$:
   \[
   \|e^{-v/2}\|_{L^2((0, \infty))} < \infty, \quad \|K\|_{L^2((0, \infty))} < \infty.
   \]
2. **$L^2$-Boundedness of Compensated Successor:**  
   The charge-compensated operator $\mathcal{T}_{\text{comp}}[f] = \mathcal{S}[f] - \text{defect}(f) e^{-v/2}$ maps $L^2((0, \infty))$ boundedly into $L^2((0, \infty))$.
3. **Explicit Rank-One Perturbation Adjoint:**  
   The formal adjoint $\mathcal{T}_{\text{comp}}^*$ on $L^2((0, \infty))$ is given by the predecessor operator $\mathcal{P}$ perturbed by an explicit rank-one projection along the memory kernel $K$:
   \[
   \mathcal{T}_{\text{comp}}^*[f](u) = \mathcal{P}[f](u) - \left( \frac{1}{2} \int_0^\infty e^{-v/2} f(v) dv \right) K(u).
   \]
4. **Exact $L^2$ Duality Identity:**  
   For all functions $f, g \in L^2((0, \infty))$:
   \[
   \int_0^\infty f(v) \, \mathcal{T}_{\text{comp}}[g](v) \, dv = \int_0^\infty \mathcal{T}_{\text{comp}}^*[f](u) \, g(u) \, du.
   \]
   The pairing holds without boundary residuals, cutoff truncations, or modifications of the underlying measure.

---

## 2. Mathematical Proof

### 2.1. $L^2$ Membership
For the reference state:
\[
\int_0^\infty (e^{-v/2})^2 dv = \int_0^\infty e^{-v} dv = 1 < \infty.
\]
For the memory kernel, $|K(u)| \le |K_{\text{weighted}}(u)| e^{-u/2} \le |K_{\text{weighted}}(u)|$ on $(0, \infty)$, and since $K_{\text{weighted}} \in L^2((0, \infty))$, $K \in L^2((0, \infty))$.

### 2.2. Adjoint Derivation
By definition of the compensated successor:
\[
\langle f, \mathcal{T}_{\text{comp}}[g] \rangle = \langle f, \mathcal{S}[g] \rangle - \text{defect}(g) \langle f, e^{-v/2} \rangle.
\]
By the uncompensated adjoint identity `successor_predecessor_adjoint`, $\langle f, \mathcal{S}[g] \rangle = \langle \mathcal{P}[f], g \rangle$.
The defect is defined as:
\[
\text{defect}(g) = \frac{1}{2} \int_0^\infty K(u) g(u) du = \frac{1}{2} \langle K, g \rangle.
\]
Substituting this gives:
\[
\langle f, \mathcal{T}_{\text{comp}}[g] \rangle = \langle \mathcal{P}[f], g \rangle - \left( \frac{1}{2} \langle f, e^{-v/2} \rangle \right) \langle K, g \rangle = \left\langle \mathcal{P}[f] - \left( \frac{1}{2} \langle e^{-v/2}, f \rangle \right) K, g \right\rangle = \langle \mathcal{T}_{\text{comp}}^*[f], g \rangle.
\]
This completes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCharge` in `formalization/BuildingBlocks/SuccessorCompensatedL2.lean`):
```lean
theorem reference_memLp :
    MemLp (fun v : ℝ => exp (-v / 2)) 2 (volume.restrict (Ioi (0 : ℝ)))

theorem kernel_memLp : MemLp kernel 2 (volume.restrict (Ioi (0 : ℝ)))

theorem compensated_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (compensated f) 2 (volume.restrict (Ioi (0 : ℝ)))

noncomputable def compensatedAdjoint (f : ℝ → ℝ) (u : ℝ) : ℝ :=
  predecessor f u - ((1 / 2) * ∫ v in Ioi (0 : ℝ), exp (-v / 2) * f v) * kernel u

theorem compensatedAdjoint_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (compensatedAdjoint f) 2 (volume.restrict (Ioi (0 : ℝ)))

theorem compensated_adjoint {f g : ℝ → ℝ} (hmf : Measurable f) (hmg : Measurable g)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ))))
    (hg : MemLp g 2 (volume.restrict (Ioi (0 : ℝ)))) :
    (∫ v in Ioi (0 : ℝ), f v * compensated g v) =
      ∫ u in Ioi (0 : ℝ), compensatedAdjoint f u * g u
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Rank-one perturbations of shift operators and semi-Fredholm systems (Kato 1995, Gohberg-Goldberg-Kaashoek 1990). Machine verification of the exact $L^2$ adjoint for the charge-compensated arithmetic successor in Lean 4 is new.
- **Advancement:** Identifies the exact rank-one perturbation formula $\mathcal{T}_{\text{comp}}^* = \mathcal{P} - \frac{1}{2}\langle e^{-v/2}, \cdot \rangle K$ and machine-verifies $L^2((0, \infty))$ duality in Lean 4.
- **Target Venues:** *Journal of Functional Analysis* or *Linear Algebra and its Applications*.
