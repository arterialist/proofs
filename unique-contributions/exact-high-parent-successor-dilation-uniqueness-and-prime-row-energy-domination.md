# Contribution 324: Exact High-Parent Successor Dilation Uniqueness and Prime Row Energy Domination

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean`](../../formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean), [`building-blocks/successor-cell/high-parent-row.md`](../../building-blocks/successor-cell/high-parent-row.md)  
**Classification:** Analytic Number Theory / Operator Theory / Beurling-Nyman Systems / Successor-Cell Dilations / Fourth-Logarithm Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the discrete spectral analysis of successor-cell operators $T$ acting on arithmetic functions, one must control the interaction between a parent scale $n$ and a child cell $r$. When the parent index exceeds the square-root scale of the child ($r < n^2$), the arithmetic geometry of integer intervals changes fundamentally.

This contribution proves:

1. **Exact Dilation Uniqueness Above Square-Root Threshold:**  
   If $r < n^2$, and $d, e \in \mathbb{N}$ are integer dilations mapping parent cell $n$ into child cell $r$, meaning:
   $$
   d n \le r < d(n + 1) \quad \text{and} \quad e n \le r < e(n + 1),
   $$
   then $d = e$ unconditionally.
   Consequently, the cardinality of the active dilation set is bounded by 1:
   $$
   |\text{highParentChildren}(r, n, D)| \le 1.
   $$
2. **Complete Elimination of Prime-Power Cross-Terms:**  
   Because the active dilation set contains at most one element, the square of the complete von Mangoldt row sum contains zero cross-terms:
   $$
   \left( \sum_{d \in \text{highParentChildren}(r, n, D)} \frac{\Lambda(d)}{\sqrt{d}} \right)^2 = \sum_{d \in \text{highParentChildren}(r, n, D)} \left( \frac{\Lambda(d)}{\sqrt{d}} \right)^2.
   $$
3. **Exact Two-Reciprocal-Dilation Cell Length Ratio:**  
   For physical logarithmic cell lengths $\text{cellLength}(n) = \log\left(\frac{n+1}{n}\right)$, whenever $dn \le r$:
   $$
   \frac{\text{cellLength}(r)}{\text{cellLength}(n)} \le \frac{n+1}{r} \le \frac{2}{d}.
   $$
4. **Exact Normalized Row Energy Domination:**  
   The total physically normalized row energy across all high parents $n > \sqrt{r}$ is bounded by twice the reciprocal-square tail of active von Mangoldt weights:
   $$
   \sum_{n \le r, r < n^2} \left( \sqrt{\frac{\text{cellLength}(r)}{\text{cellLength}(n)}} \sum_{d \in \text{children}} \frac{\Lambda(d)}{\sqrt{d}} \right)^2 \le 2 \sum_{d = D+1}^r \left( \frac{\Lambda(d)}{d} \right)^2.
   $$
5. **Unnormalized Energy Domination:**  
   Without normalization, the energy is bounded by the exact tail:
   $$
   \sum_{n \le r, r < n^2} \left( \sum_{d \in \text{children}} \frac{\Lambda(d)}{\sqrt{d}} \right)^2 \le \sum_{d = D+1}^r \frac{\Lambda(d)^2}{d}.
   $$

---

## 2. Mathematical Proof

### 2.1. Dilation Uniqueness
If $d \ge n$, then $d n \ge n^2 > r$, contradicting $d n \le r$. Thus $d < n$ and similarly $e < n$.
Suppose $d < e$. Then $d + 1 \le e$, which implies:
$$
d(n + 1) = d n + d < d n + n = (d + 1) n \le e n \le r.
$$
This contradicts $r < d(n + 1)$. Symmetrically, $e < d$ is impossible. Hence $d = e$.

### 2.2. Cross-Term Cancellation
For any finite sum over a set $S$ with $|S| \le 1$, $(\sum_{x \in S} f(x))^2 = \sum_{x \in S} f(x)^2$, because $S$ is either empty or a singleton.

### 2.3. Row Energy Tail
Summing over $n > \sqrt{r}$ and exchanging order of summation:
Each dilation $d$ has at most one parent $n = \lfloor r/d \rfloor$.
Thus each dilation $d$ appears at most once in the entire row sum. Applying the pointwise bound $\frac{\text{cellLength}(r)}{\text{cellLength}(n)} \frac{\Lambda(d)^2}{d} \le \frac{2}{d} \frac{\Lambda(d)^2}{d} = 2 \left(\frac{\Lambda(d)}{d}\right)^2$ finishes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorHighParentPrimeRow` in `formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean`):
```lean
theorem high_parent_child_dilation_unique
    {r n d e : ℕ} (hrn : r < n * n)
    (hdlo : d * n ≤ r) (hdhi : r < d * (n + 1))
    (helo : e * n ≤ r) (hehi : r < e * (n + 1)) :
    d = e

theorem highParentChildren_card_le_one
    {r n D : ℕ} (hrn : r < n * n) :
    (highParentChildren r n D).card ≤ 1

theorem highParent_vonMangoldt_sum_sq
    {r n D : ℕ} (hrn : r < n * n) :
    (∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 =
      ∑ d ∈ highParentChildren r n D,
        (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2

theorem highParent_vonMangoldt_normalized_row_energy_le (r D : ℕ) :
    (∑ n ∈ (Finset.Icc 1 r).filter (fun n => r < n * n),
      (Real.sqrt (cellLength r / cellLength n) *
        ∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2) ≤
      2 * ∑ d ∈ Finset.Ioc D r,
        (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Nyman (1950) *On the one-dimensional translation group and semi-group in certain function spaces*; Beurling (1955) *A closure problem related to the Riemann Zeta-function*; Báez-Duarte (2003) *A strengthening of the Nyman-Beurling criterion for the Riemann hypothesis*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Resolves the high-parent regime of the successor-cell operator by showing that dilation uniqueness eliminates all off-diagonal interference, yielding an exact reciprocal-square tail bound on prime energy.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Zeitschrift*.
