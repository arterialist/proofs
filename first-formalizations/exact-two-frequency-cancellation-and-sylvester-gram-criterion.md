# First Formalization: Exact Two-Frequency Cancellation and Sylvester Gram Criterion

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CollectiveLambertGramFinite.lean`](../../formalization/BuildingBlocks/CollectiveLambertGramFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact two-frequency cancellation identity, cancellation upper bound, and completing-the-square Sylvester non-negativity criterion for $2 \times 2$ symmetric matrices in Lean 4:

1. **Exact Cancellation Identity:**
   Formal proof of `two_frequency_cancellation_identity`: $k_0(1+s^2) - 2k_1 s = k_0(1-s)^2 + 2s(k_0 - k_1)$.
2. **Cancellation Upper Bound:**
   Formal proof of `two_frequency_cancellation_upper`: Under near-identity and small difference bounds, $k_0(1+s^2) - 2k_1 s \le k_0 \epsilon^2 + 2\delta k_0$.
3. **Sylvester Non-Negativity Criterion:**
   Formal proof of `two_by_two_nonneg_of_det`: For $a > 0$ and $b^2 \le ac$, $ax^2 + 2bxy + cy^2 \ge 0$ via the exact completion of squares.
4. **Comparison Residual Decomposition:**
   Formal proof of `two_by_two_comparison_residual`: Exact affine difference of scaled bilinear forms.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact two-frequency cancellation identity
theorem two_frequency_cancellation_identity
    (k0 k1 s : ℝ) :
    k0 * (1 + s ^ 2) - 2 * k1 * s =
      k0 * (1 - s) ^ 2 + 2 * s * (k0 - k1)

-- Cancellation upper bound
theorem two_frequency_cancellation_upper
    {k0 k1 s eps delta : ℝ}
    (hidentity :
      k0 * (1 + s ^ 2) - 2 * k1 * s =
        k0 * (1 - s) ^ 2 + 2 * s * (k0 - k1))
    (hk0 : 0 ≤ k0)
    (hnear : (1 - s) ^ 2 ≤ eps ^ 2)
    (htail : 2 * s * (k0 - k1) ≤ 2 * delta * k0) :
    k0 * (1 + s ^ 2) - 2 * k1 * s
      ≤ k0 * eps ^ 2 + 2 * delta * k0

-- Sylvester's criterion for real 2x2 symmetric forms
theorem two_by_two_nonneg_of_det
    {a b c x y : ℝ} (ha : 0 < a) (hdet : b ^ 2 ≤ a * c) :
    0 ≤ a * x ^ 2 + 2 * b * x * y + c * y ^ 2

-- Comparison residual matrix decomposition
theorem two_by_two_comparison_residual
    (scale A B C k0 k1 x y : ℝ) :
    scale * (A * x ^ 2 + 2 * B * x * y + C * y ^ 2) -
        (k0 * x ^ 2 + 2 * k1 * x * y + k0 * y ^ 2) =
      (scale * A - k0) * x ^ 2 +
        2 * (scale * B - k1) * x * y +
        (scale * C - k0) * y ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the two-frequency cancellation identity and completing-the-square Sylvester non-negativity for symmetric $2 \times 2$ matrices.
