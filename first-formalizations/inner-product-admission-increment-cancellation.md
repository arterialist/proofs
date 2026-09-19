# First Formalization in Lean 4: Inner Product Space Admission Increment Cancellation and Error Localization

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/AdmissionIncrementCancellationFinite.lean`](../../formalization/BuildingBlocks/AdmissionIncrementCancellationFinite.lean)  
**Dependencies:** `Mathlib.Analysis.InnerProductSpace.Basic`, `Mathlib.Tactic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the recursive multi-level admission of prime spectral histories, one faces the danger of accumulating level errors when subtracting consecutive model profiles. At two adjacent scales, let $F$ be the base model state and $R$ be the common unadmitted row remainder. When advancing to the next scale, the model acquires a local face $U$ (forming the updated model $F - U$), while the remainder releases a newly admitted face $V$ (forming the updated remainder $R - V$).

A naive triangle-inequality estimate on the energy difference produces a bare $2\|R\|$ error term, which diverges across infinite dyadic levels. However, by retaining the remainder as a single vector and using exact polarization in an arbitrary real inner product space $(E, \langle \cdot, \cdot \rangle)$, the incremental error satisfies an exact cancellation identity:
\[
\Big(\|(F - U) + (R - V)\|^2 - \|F + R\|^2\Big) - \Big(\|F - U\|^2 - \|F\|^2\Big) = -2\langle U, R\rangle - 2\langle F - U, V\rangle - 2\langle R, V\rangle + \|V\|^2.
\]
Crucially, the old remainder $R$ appears **only** in pairing with the local face $U$ and the admitted piece $V$. The bare remainder norm $\|R\|$ never acts as an unweighted coefficient.

This Lean 4 formalization machine-checks:
1. The fixed-profile model admission identity: $\|F - U\|^2 - \|F\|^2 = \|U\|^2 - 2\langle F, U\rangle$.
2. The exact four-term polarization error identity for row updates.
3. The universal Cauchy–Schwarz norm bound:
   \[
   |\Delta_{\mathrm{err}}| \le 2\|U\|\|R\| + 2\|F - U\|\|V\| + 2\|R\|\|V\| + \|V\|^2.
   \]
4. The bilinear first-correction coefficient localization: $\langle F - U, J - W\rangle - \langle F, J\rangle = -\langle U, J\rangle - \langle F, W\rangle + \langle U, W\rangle$.
5. The abstract Boolean-face reflection pairing: $\sum_{i \in \iota} \mathrm{newFace}_i = -\sum_{i \in \iota} \mathrm{oldFace}_i$.

---

## 2. Machine-Verified Theorems

### 2.1 Model Admission and Increment Error Identities

```lean
/-- The exact fixed-profile admission identity. -/
theorem model_admission
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F U : E) :
    ‖F - U‖ ^ 2 - ‖F‖ ^ 2 = ‖U‖ ^ 2 - 2 * inner ℝ F U

/-- Exact increment error when both the model and its row remainder acquire
a local admitted face. This is the algebra behind direct row differencing. -/
theorem increment_error_identity
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F U R V : E) :
    ((‖(F - U) + (R - V)‖ ^ 2 - ‖F + R‖ ^ 2) -
        (‖F - U‖ ^ 2 - ‖F‖ ^ 2)) =
      -2 * inner ℝ U R - 2 * inner ℝ (F - U) V -
        2 * inner ℝ R V + ‖V‖ ^ 2
```

### 2.2 Strict Error Localization Norm Bound

```lean
/-- Norm bound for the direct increment error. In particular, the old row
remainder is multiplied by the local model face `U`; there is no bare
`2 * ‖R‖` level-error term. -/
theorem increment_error_le
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F U R V : E) :
    |((‖(F - U) + (R - V)‖ ^ 2 - ‖F + R‖ ^ 2) -
        (‖F - U‖ ^ 2 - ‖F‖ ^ 2))| ≤
      2 * ‖U‖ * ‖R‖ + 2 * ‖F - U‖ * ‖V‖ +
        2 * ‖R‖ * ‖V‖ + ‖V‖ ^ 2
```

### 2.3 Bilinear Correction and Boolean-Face Reflection Pairing

```lean
/-- The bilinear first-correction coefficient also localizes to the new
faces, with every mixed orientation retained. -/
theorem bilinear_admission
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F J U W : E) :
    inner ℝ (F - U) (J - W) - inner ℝ F J =
      -inner ℝ U J - inner ℝ F W + inner ℝ U W

/-- Abstract Boolean-face pairing: a packet whose new state is obtained by
subtracting the prime-dilated old faces has the stated exact increment. -/
theorem face_pairing
    {ι E : Type*} [Fintype ι] [AddCommGroup E]
    (oldFace newFace : ι → E)
    (hpair : ∀ i, newFace i = -oldFace i) :
    (∑ i, newFace i) = -(∑ i, oldFace i)
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/AdmissionIncrementCancellationFinite.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.AdmissionIncrementCancellationFinite.model_admission' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.AdmissionIncrementCancellationFinite.increment_error_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.AdmissionIncrementCancellationFinite.increment_error_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.AdmissionIncrementCancellationFinite.bilinear_admission' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.AdmissionIncrementCancellationFinite.face_pairing' depends on axioms: [propext, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
