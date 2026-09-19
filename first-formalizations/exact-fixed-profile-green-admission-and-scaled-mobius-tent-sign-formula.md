# First Formalization: Exact Fixed-Profile Green Admission and Scaled Möbius Tent Sign Formula

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FixedProfileGreenAdmissionFinite.lean`](../../formalization/BuildingBlocks/FixedProfileGreenAdmissionFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact scaled sign extraction formula for fixed-profile Green packet admissions and establishes the equivalence between Gram kernels and doubled Hilbert packet increments in Lean 4:

1. **Packet Definitions and Base/Tail Splitting:**
   Formal definitions of `oldPacket`, `delayedPacket`, `delayedTail`, and proof of `delayedPacket_eq_base_add_tail`.
2. **Doubled Increment and Perturbations:**
   Formal proof of `doubledIncrement_decomposition`, `doubledIncrement_perturbation`, and sign stability lemmas `negative_increment_of_error_lt_margin` and `positive_increment_of_error_lt_margin`.
3. **Gram Kernel Equivalence:**
   Formal definition of `kernelIncrement` and proof of `kernelIncrement_eq_doubledIncrement`.
4. **Lower and Upper Cross Decomposition:**
   Formal definitions of `lowerOldCross` and `upperOldCross`, proof of `new_row_absent` and `oldCross_eq_lower_add_upper`.
5. **Möbius Tent and Scaled Sign Formula:**
   Formal definitions of `truncatedTClosed`, `truncatedT`, `reciprocalPrefixBelow`, and `mertensBelow`, with proofs of `truncatedTClosed_eq_truncatedT`, `truncatedT_eq_main_term`, `truncatedTClosed_eq_main_term`, and `scaled_increment_main_sign`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact scaled Green admission sign formula isolating the truncated Möbius tent
theorem scaled_increment_main_sign
    {p : ℕ} (hp : 0 < p) (Δ diag J D A B : ℝ)
    (hΔ : Δ / 2 = diag -
      2 * (exp (-2 * (p : ℝ)) / (4 * p) *
        (truncatedTClosed p + A - B / 2) + J) + D) :
    (p : ℝ) * exp (2 * p) * Δ = -truncatedTClosed p +
      (2 * p * exp (2 * p) * diag - A + B / 2 -
        4 * p * exp (2 * p) * J + 2 * p * exp (2 * p) * D)

-- Truncated Möbius tent main term decomposition
theorem truncatedTClosed_eq_main_term (p : ℕ) :
    truncatedTClosed p = (p : ℝ) * reciprocalPrefixBelow p - mertensBelow p

-- Exact Gram dictionary between kernel and Hilbert packet vectors
theorem kernelIncrement_eq_doubledIncrement
    (G : ℕ → H) (K : ℕ → ℕ → ℝ) (N p : ℕ)
    (hK : ∀ d e, inner ℝ (G d) (G e) = K d e) :
    kernelIncrement K N p =
      doubledIncrement (oldPacket G N) (delayedPacket G N p)

-- Exact lower and upper cross row decomposition
theorem oldCross_eq_lower_add_upper
    (K : ℕ → ℕ → ℝ) {N p : ℕ} (hp : ¬p ∣ N) :
    (∑ d ∈ N.divisors, μR d * K d p) =
      lowerOldCross K N p + upperOldCross K N p
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact scaled sign formula for Green packet admissions, demonstrating that the leading sign is rigorously governed by the negative truncated Möbius tent $-T_{\text{closed}}(p)$ while accounting for all finite cofactor and delayed faces.
