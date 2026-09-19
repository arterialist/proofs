# Unique Contribution 193: Exact Prime Seed Derivative Jordan Decomposition, Mutual Singularity, and Total Variation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedDerivativeVariation.lean`](../../formalization/BuildingBlocks/PrimeSeedDerivativeVariation.lean), [`building-blocks/primes/prime-seed-derivative-variation.md`](../../building-blocks/primes/prime-seed-derivative-variation.md)  
**Classification:** Real Analysis / Measure Theory / Jordan Decomposition / Mutual Singularity / Total Variation Measure / Bounded Variation Spaces

---

## 1. Executive Summary and Mathematical Statement

By the classical Jordan decomposition theorem (Hahn-Jordan 1921), any signed Borel measure $\nu$ decomposes uniquely into mutually singular positive measures $\nu = \nu^+ - \nu^-$ with $\nu^+ \perp \nu^-$. For the distributional derivative of the prime successor seed $D(\text{seed}_L)$, establishing mutual singularity requires proving that the continuous density and birth Dirac mass live on a set disjoint from the countable proper-power jump atoms.

This contribution proves:

1. **Exact Mutual Singularity:**  
   The constructed positive and negative derivative measures are mutually singular:
   \[
   D^+(\text{seed}_L) \perp D^-(\text{seed}_L).
   \]
   Explicit certificate: Let $A = \{ (j+2)L : j \in \mathbb{N} \}$. Then $A$ is countable and measurable.
   The negative measure is supported entirely on $A$ ($D^-(\text{seed}_L)(A^c) = 0$).
   The positive measure satisfies $D^+(\text{seed}_L)(A) = 0$ because the continuous part is absolutely continuous with respect to Lebesgue volume ($\text{vol}(A) = 0$) and the birth atom $L \notin A$ (since $L < 2L \le (j+2)L$).
2. **Canonical Jordan Decomposition of the Prime Seed Derivative:**  
   The pair $(D^+, D^-)$ constitutes the exact, canonical Jordan decomposition (`JordanDecomposition ℝ`):
   \[
   \text{seedDerivativeJordan}(L, hL) = (D^+(\text{seed}_L), D^-(\text{seed}_L)).
   \]
3. **Exact Total Variation Measure Formula:**  
   The total variation measure $|D(\text{seed}_L)| = D^+(\text{seed}_L) + D^-(\text{seed}_L)$ is a bona fide positive finite Borel measure:
   \[
   |D(\text{seed}_L)|(dv) = \frac{1}{2}\text{seed}_L(v) \, dv + e^{-3L/2}\delta_L(dv) + \sum_{j=0}^\infty (1 - e^{-L})e^{-(j+2)L/2}\delta_{(j+2)L}(dv).
   \]
4. **Exact Total Variation Mass Identity:**  
   The total variation norm (total mass of $|D(\text{seed}_L)|$) evaluates to the exact closed-form expression:
   \[
   \|D(\text{seed}_L)\|_{\text{TV}} = |D(\text{seed}_L)|(\mathbb{R}) = 2 e^{-L} + 2 e^{-3L/2}.
   \]
   For prime seeds with $L = \log p$, the total variation is:
   \[
   \|D(\text{seed}_{\log p})\|_{\text{TV}} = \frac{2}{p} + \frac{2}{p^{3/2}}.
   \]

---

## 2. Mathematical Proof

### 2.1. Mutual Singularity
Define the separating set $A = \{ (j+2)L : j \in \mathbb{N} \}$.
$A$ is a countable union of singletons, so $\text{MeasurableSet } A$ holds and $\text{vol}(A) = 0$.
The negative measure is:
\[
D^-(A^c) = \sum_{j=0}^\infty c_j \delta_{(j+2)L}(A^c) = \sum_{j=0}^\infty c_j \cdot 0 = 0.
\]
The positive measure is:
\[
D^+(A) = \int_A \frac{1}{2}\text{seed}_L(v) \, dv + e^{-3L/2}\delta_L(A).
\]
Since $\text{vol}(A) = 0$ and the density is locally integrable, the integral vanishes.
For the birth atom: $(j+2)L = L \iff j+2 = 1 \iff j = -1 \notin \mathbb{N}$.
Thus $L \notin A$, and $\delta_L(A) = 0$.
Hence $D^+(A) = 0 + 0 = 0$.
This establishes $D^+ \perp D^-$.

### 2.2. Jordan Decomposition and Total Variation Mass
Because $D^+$ and $D^-$ are mutually singular finite measures, they form the canonical Jordan decomposition of the signed measure $D = D^+ - D^-$.
By standard measure theory, $|D| = D^+ + D^-$.
Evaluating on $\mathbb{R}$:
\[
|D|(\mathbb{R}) = D^+(\mathbb{R}) + D^-(\mathbb{R}) = (e^{-L} + e^{-3L/2}) + (e^{-L} + e^{-3L/2}) = 2e^{-L} + 2e^{-3L/2}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedDerivativeVariation.lean`):
```lean
theorem seedDerivative_mutuallySingular {L : ℝ} (hL : 0 < L) :
    seedDerivativePositive L ⟂ₘ seedDerivativeNegative L

noncomputable def seedDerivativeJordan (L : ℝ) (hL : 0 < L) : JordanDecomposition ℝ

theorem seedDerivativeJordan_toSigned {L : ℝ} (hL : 0 < L) :
    (seedDerivativeJordan L hL).toSignedMeasure = seedDerivative L hL

theorem seedDerivative_totalVariation {L : ℝ} (hL : 0 < L) :
    (seedDerivative L hL).totalVariation = seedDerivativePositive L + seedDerivativeNegative L

theorem seedDerivative_totalVariation_mass {L : ℝ} (hL : 0 < L) :
    (seedDerivative L hL).totalVariation univ =
      ENNReal.ofReal (2 * exp (-L) + 2 * exp (-3 * L / 2))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Jordan decomposition of signed measures and total variation of BV functions (Jordan 1881, Hahn 1921, Halmos 1950, Bogachev 2007). Machine verification of the Jordan decomposition and mutual singularity certificate for prime renewal seeds in Lean 4 is new.
- **Advancement:** Proves mutual singularity $D^+ \perp D^-$ via explicit countable set separation, formalizes `JordanDecomposition ℝ`, and proves $|D(\text{seed}_L)|(\mathbb{R}) = 2e^{-L} + 2e^{-3L/2}$ in Lean 4.
- **Target Venues:** *Real Analysis Exchange* or *Journal of Mathematical Analysis and Applications*.
