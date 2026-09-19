# First Formalization: Exact Finite Haar Energy Decomposition and Coarse-Mode Conservation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CrossHorizonHaarFinite.lean`](../../formalization/BuildingBlocks/CrossHorizonHaarFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact finite Haar energy decomposition for dyadic packets, establishes the gauge invariance of nonconstant Haar details, and proves the conservation of the coarse mode in Lean 4:

1. **Dyadic Packet Inductive Structure:**
   Formal definition of `DyadicPacket`, `total`, `squareEnergy`, `gaugeShift`, `haarCoefficients`, `haarDetailEnergy`, `coarseEnergy`, and `rootDetail`.
2. **Gauge Invariance:**
   Formal proofs of `total_gaugeShift`, `haarCoefficients_gaugeShift`, and `haarDetailEnergy_gaugeShift`.
3. **Exact Haar Energy Identity:**
   Formal proof by structural induction of `squareEnergy_eq_coarse_add_haar`:
   \[
   \|p\|^2 = \mathcal{E}_{\text{coarse}}(p) + \mathcal{E}_{\text{detail}}(p).
   \]
4. **Coarse Merging Recursion and Remainder Conservation:**
   Formal proofs of `child_coarse_recursion` and `coarse_remainder_conserved`.
5. **Sequence Conversion and Möbius Clock Applications:**
   Formal definition of `ofSequence`, proof of `total_ofSequence`, and definitions/proofs for `mobiusClock_haar_gauge_invariant` and `mobiusClock_squareEnergy_decomposition`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact finite Haar energy decomposition for balanced dyadic packets
theorem squareEnergy_eq_coarse_add_haar {k : ℕ} (p : DyadicPacket k) :
    squareEnergy p = coarseEnergy p + haarDetailEnergy p

-- Coarse-detail merging recursion
theorem child_coarse_recursion {k : ℕ} (left right : DyadicPacket k) :
    coarseEnergy left + coarseEnergy right =
      coarseEnergy (.node left right) + rootDetail left right

-- Exact gauge invariance of Haar details
theorem haarCoefficients_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    haarCoefficients (gaugeShift c p) = haarCoefficients p

theorem haarDetailEnergy_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    haarDetailEnergy (gaugeShift c p) = haarDetailEnergy p

-- Coarse mode conservation under multiscale detail removal
theorem coarse_remainder_conserved {k : ℕ} (p : DyadicPacket k) :
    squareEnergy p - haarDetailEnergy p = coarseEnergy p

-- Direct application to finite Möbius clock packets
theorem mobiusClock_squareEnergy_decomposition
    (D T H k : ℕ) (q : ℝ) :
    DyadicPacket.squareEnergy (mobiusClockPacket D T H k q) =
      DyadicPacket.coarseEnergy (mobiusClockPacket D T H k q) +
        DyadicPacket.haarDetailEnergy (mobiusClockPacket D T H k q)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the inductive dyadic Haar wavelet energy identity, gauge invariance of wavelets, and the mathematical conservation of the coarse mode against multiscale cancellation.
