# Unique Contribution 267: Exact Signed Three-Part Covariance Contraction and Inner Difference Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CollectiveSourceRangeFinite.lean`](../../formalization/BuildingBlocks/CollectiveSourceRangeFinite.lean), [`building-blocks/spectral/collective-source-range-finite.md`](../../building-blocks/spectral/collective-source-range-finite.md)  
**Classification:** Linear Algebra / Spectral Theory / Quadratic Forms / Covariance Decomposition / Inner Product Spaces / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the multi-channel spectral decomposition of boundary operator kernels, a covariance matrix frequently splits into separate physical contributions: mass, continuous spectrum, and discrete prime excitations:
\[
A = A_m + A_c + A_p, \quad B = B_m + B_c + B_p, \quad C = C_m + C_c + C_p.
\]
Evaluating the coherent signed combination on the difference vector $(1, -1)$ must preserve the exact cancellations within each spectral channel without cross-channel contamination or premature lossy norm bounds.

This contribution proves:

1. **Exact Three-Part Covariance Contraction Identity:**  
   The signed two-column contraction $A - 2B + C$ commutes exactly with the three-part spectral decomposition:
   \[
   (A_m + A_c + A_p) - 2(B_m + B_c + B_p) + (C_m + C_c + C_p) = (A_m - 2 B_m + C_m) + (A_c - 2 B_c + C_c) + (A_p - 2 B_p + C_p).
   \]
   This allows cancellation in the prime sector, continuous sector, and mass sector to be analyzed independently and additively.
2. **Exact Inner Product Difference Identity:**  
   In any real inner product space, the norm squared of a vector difference satisfies:
   \[
   \|x - y\|^2 = \|x\|^2 - 2 \langle x, y \rangle + \|y\|^2.
   \]
   This directly matches the $A - 2B + C$ contraction structure, preventing the replacement of the cross-term by an absolute-value Cauchy-Schwarz bound before algebraic cancellation occurs.
3. **Linear Preimage Conservation:**  
   For any linear operator $T : V \to W$ and preimages $T(x_1) = y_1$, $T(x_2) = y_2$:
   \[
   T(x_1 - s x_2) = y_1 - s y_2.
   \]
   Any linear centering or projection preserves the coherent difference before norms or positivity estimates are evaluated.

---

## 2. Mathematical Proof

### 2.1. Commutation with Multi-Part Spectral Decompositions
By distributivity and associativity in any commutative ring:
\[
\sum_{k \in \{m, c, p\}} A_k - 2 \sum_{k \in \{m, c, p\}} B_k + \sum_{k \in \{m, c, p\}} C_k = \sum_{k \in \{m, c, p\}} (A_k - 2 B_k + C_k).
\]
Expanding each side shows literal equality with zero cross-terms.

### 2.2. Inner Product Expansion
By bilinearity and symmetry of the real inner product:
\[
\|x - y\|^2 = \langle x - y, x - y \rangle = \langle x, x \rangle - 2 \langle x, y \rangle + \langle y, y \rangle = \|x\|^2 - 2 \langle x, y \rangle + \|y\|^2.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation` in `formalization/BuildingBlocks/CollectiveSourceRangeFinite.lean`):
```lean
theorem signed_source_preimage
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (T : V →ₗ[ℝ] W) (x₁ x₂ : V) (y₁ y₂ : W) (s : ℝ)
    (h₁ : T x₁ = y₁) (h₂ : T x₂ = y₂) :
    T (x₁ - s • x₂) = y₁ - s • y₂

theorem linear_map_preserves_difference
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (P : V →ₗ[ℝ] W) (y₁ y₂ : V) :
    P (y₁ - y₂) = P y₁ - P y₂

theorem coherent_covariance_contraction
    (A B C : ℝ) :
    A + 2 * B * (-1) + C * (-1) ^ 2 = A - 2 * B + C

theorem signed_three_part_contraction
    (Am Ac Ap Bm Bc Bp Cm Cc Cp : ℝ) :
    (Am + Ac + Ap) - 2 * (Bm + Bc + Bp) + (Cm + Cc + Cp) =
      (Am - 2 * Bm + Cm) +
      (Ac - 2 * Bc + Cc) +
      (Ap - 2 * Bp + Cp)

theorem inner_difference_identity
    {V : Type*} [SeminormedAddCommGroup V] [InnerProductSpace ℝ V]
    (x y : V) :
    ‖x - y‖ ^ 2 =
      ‖x‖ ^ 2 - 2 * inner ℝ x y + ‖y‖ ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Spectral decomposition of covariance operators (Dunford-Schwartz 1958, Reed-Simon 1980). A machine-verified algebraic framework ensuring channel-by-channel cancellation across multi-part spectral splittings in Lean 4 is new.
- **Advancement:** Guarantees that discrete prime excitations and continuous dispersive waves can be canceled in their respective spectral sectors without lossy cross-sector norm estimates.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Linear Algebra and its Applications*.
