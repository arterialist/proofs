# First Formalization: Exact Prime Seed Derivative Jordan Decomposition, Mutual Singularity, and Total Variation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedDerivativeVariation.lean`](../../formalization/BuildingBlocks/PrimeSeedDerivativeVariation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact mutual singularity of the positive and negative derivative measures, formalizes the authentic Mathlib `JordanDecomposition ℝ`, and verifies the total variation measure and closed-form total mass for prime successor seeds in Lean 4:

1. **Mutual Singularity Certificate:**
   Formal proof that $D^+(\text{seed}_L) \perp D^-(\text{seed}_L)$ (`seedDerivative_mutuallySingular`) via explicit separation on the countable set $A = \{ (j+2)L : j \in \mathbb{N} \}$.
2. **Canonical Jordan Decomposition:**
   Formal definition of `seedDerivativeJordan` as a Mathlib `JordanDecomposition ℝ` and identification with the signed measure `seedDerivative` (`seedDerivativeJordan_toSigned`).
3. **Total Variation Measure:**
   Formal identification of the total variation measure as the sum of positive and negative parts (`seedDerivative_totalVariation`).
4. **Exact Total Variation Mass Identity:**
   Formal proof that the total variation evaluated on `univ` equals $2 e^{-L} + 2 e^{-3L/2}$ (`seedDerivative_totalVariation_mass`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Mutual singularity of derivative positive and negative parts
theorem seedDerivative_mutuallySingular {L : ℝ} (hL : 0 < L) :
    seedDerivativePositive L ⟂ₘ seedDerivativeNegative L

-- Jordan decomposition structure
noncomputable def seedDerivativeJordan (L : ℝ) (hL : 0 < L) : JordanDecomposition ℝ where
  posPart := seedDerivativePositive L
  negPart := seedDerivativeNegative L
  posPart_finite := seedDerivativePositive_finite hL
  negPart_finite := seedDerivativeNegative_finite hL
  mutuallySingular := seedDerivative_mutuallySingular hL

-- Identity with signed measure
theorem seedDerivativeJordan_toSigned {L : ℝ} (hL : 0 < L) :
    (seedDerivativeJordan L hL).toSignedMeasure = seedDerivative L hL

-- Total variation measure identity
theorem seedDerivative_totalVariation {L : ℝ} (hL : 0 < L) :
    (seedDerivative L hL).totalVariation = seedDerivativePositive L + seedDerivativeNegative L

-- Closed-form total variation mass
theorem seedDerivative_totalVariation_mass {L : ℝ} (hL : 0 < L) :
    (seedDerivative L hL).totalVariation univ =
      ENNReal.ofReal (2 * exp (-L) + 2 * exp (-3 * L / 2))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 constructing the exact Jordan decomposition of the distributional derivative of an arithmetic renewal function, proving mutual singularity via explicit topological/measure-theoretic separation, and evaluating its total variation norm in closed form.
