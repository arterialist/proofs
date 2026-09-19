# First Formalization: Exact Pointwise Goldbach Cofactor Abel Decomposition and Packet Variation Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean`](../../formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact finite Abel difference identity with endpoints, the total variation error bound, the exact pointwise packet decomposition of the centered Goldbach remainder, and the finite packet error bound in Lean 4:

1. **Definitions of Residual and Sums:**
   Formal definition of `residual` ($R(m) = \text{primeError}(m) - F(m)$).
2. **Abel Summation and Variation Bounds:**
   Formal proofs of `finite_difference_abel` and `finite_difference_abs_le_variation`.
3. **Reversal and Difference Identification:**
   Formal proofs of `centeredPairRemainder_reverse` and `centeredPairRemainder_as_difference`.
4. **Packet Splitting and Pointwise Abel Formula:**
   Formal proofs of `centeredPairRemainder_packet_split` and `centeredPairRemainder_packet_abel`.
5. **Finite Packet Error Estimate:**
   Formal proof of `centeredPairRemainder_packet_error_bound`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact finite difference Abel summation with endpoints
theorem finite_difference_abel (R w : ℕ → ℝ) (k : ℕ) :
    (∑ m ∈ Icc 2 (k + 2), (R m - R (m - 1)) * w m) =
      R (k + 2) * w (k + 2) - R 1 * w 2 +
        ∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1))

-- Total variation bound on Abel difference sum
theorem finite_difference_abs_le_variation (R w : ℕ → ℝ) (k : ℕ) (M : ℝ)
    (hR : ∀ m ∈ Icc 1 (k + 2), |R m| ≤ M) :
    |∑ m ∈ Icc 2 (k + 2), (R m - R (m - 1)) * w m| ≤
      M * (|w (k + 2)| + |w 2| +
        ∑ m ∈ Ico 2 (k + 2), |w m - w (m + 1)|)

-- Reversal of centered pair remainder sum
theorem centeredPairRemainder_reverse (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      ∑ m ∈ Icc 2 (s - 2), (Λ m - 1) * ratioError (s - m)

-- Identification of centered remainder as discrete derivative convolution
theorem centeredPairRemainder_as_difference (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      ∑ m ∈ Icc 2 (s - 2),
        (primeError m - primeError (m - 1)) * ratioError (s - m)

-- Exact pointwise packet Abel decomposition
theorem centeredPairRemainder_packet_abel (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      (∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)) +
      residual F (s - 2) * ratioError 2 -
      residual F 1 * ratioError (s - 2) +
      (∑ m ∈ Ico 2 (s - 2),
        residual F m *
          (ratioError (s - m) - ratioError (s - (m + 1))))

-- Finite packet error estimate bounded by total variation
theorem centeredPairRemainder_packet_error_bound
    (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) (M : ℝ)
    (hR : ∀ m ∈ Icc 1 (s - 2), |residual F m| ≤ M) :
    |centeredPairRemainder s -
      ∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)| ≤
      M * (|ratioError 2| + |ratioError (s - 2)| +
        ∑ m ∈ Ico 2 (s - 2),
          |ratioError (s - m) - ratioError (s - (m + 1))|)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the exact pointwise Abel decomposition of Goldbach cofactors under arbitrary zero packets, bounding residual errors solely by total variation and boundary terms.
