# LCM difference product divisibility for finite families: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean module:
- [formalization/BuildingBlocks/LcmDifferenceProduct.lean](../../formalization/BuildingBlocks/LcmDifferenceProduct.lean)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $l = [n_1, \ldots, n_k]$ be any finite sequence of natural numbers, and let:
\[
 \Delta(l) := \prod_{1 \le i < j \le k} |n_j - n_i|
\]
be the absolute Vandermonde difference product.

**Theorem (LCM Difference Product Divisibility).**
For any finite list of natural numbers $l$:
\[
 \boxed{\quad \prod_{i=1}^k n_i \;\Big|\; \operatorname{lcm}(n_1, \ldots, n_k) \cdot \Delta(l). \quad}
\]
Furthermore:
1. The divisibility holds unconditionally for all lists, including lists with zero entries and repeated elements.
2. If $l$ contains no duplicate entries (`l.Nodup`), then $\Delta(l) > 0$.
3. If all entries are strictly positive, then $\operatorname{lcm}(n_1, \ldots, n_k) > 0$.

## Mathematical Proof

The proof proceeds by induction on the list $l$.
- **Base case:** The empty list has product 1, LCM 1, and difference product 1, satisfying $1 \mid 1$.
- **Inductive step:** For $a :: l$, the induction hypothesis gives $\prod l \mid \operatorname{lcm}(l) \cdot \Delta(l)$.
  Multiplying by $a$ gives:
  \[
   a \prod l \mid a \cdot \operatorname{lcm}(l) \cdot \Delta(l) = \operatorname{lcm}(a, \operatorname{lcm}(l)) \cdot \operatorname{gcd}(a, \operatorname{lcm}(l)) \cdot \Delta(l).
  \]
  Now, since $\operatorname{lcm}(l) \mid \prod l$, we have:
  \[
   \operatorname{gcd}(a, \operatorname{lcm}(l)) \mid \operatorname{gcd}\left(a, \prod_{b \in l} b\right) \mid \prod_{b \in l} \operatorname{gcd}(a, b).
  \]
  Since $\operatorname{gcd}(a, b) \mid |a - b|$ for each $b \in l$:
  \[
   \prod_{b \in l} \operatorname{gcd}(a, b) \;\Big|\; \prod_{b \in l} |a - b|.
  \]
  Therefore, $\operatorname{gcd}(a, \operatorname{lcm}(l)) \mid \prod_{b \in l} |a - b|$.
  Substituting this into the product yields:
  \[
   (a :: l).\operatorname{prod} \;\Big|\; \operatorname{lcm}(a :: l) \cdot \prod_{b \in l} |a - b| \cdot \Delta(l) = \operatorname{lcm}(a :: l) \cdot \Delta(a :: l).
  \]

## Formalization notes

- Module: `BuildingBlocks.LcmDifferenceProduct`.
- Formalized theorems:
  - `gcd_prod_dvd_prod_gcd`: $\operatorname{gcd}(a, \prod l) \mid \prod \operatorname{gcd}(a, b)$.
  - `gcd_dvd_distance`: $\operatorname{gcd}(a, b) \mid |a - b|$.
  - `prod_gcd_dvd_prod_distance`: $\prod \operatorname{gcd}(a, b) \mid \prod |a - b|$.
  - `gcd_lcm_dvd_prod_distance`: $\operatorname{gcd}(a, \operatorname{lcm}(l)) \mid \prod |a - b|$.
  - `prod_dvd_lcm_mul_differenceProduct`: $\prod l \mid \operatorname{lcm}(l) \cdot \Delta(l)$.
  - `differenceProduct_pos`: $\Delta(l) > 0$ when `l.Nodup`.
- Formally compiled in Lean 4.24.0 with standard axioms `[propext, Classical.choice, Quot.sound]` and zero `sorry`.
