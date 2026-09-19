# Unique Contribution 181: Exact Same-Prime Aggregation Cell Derivatives and Global Renewal Monotonicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeAggregationMonotone.lean`](../../formalization/BuildingBlocks/SamePrimeAggregationMonotone.lean), [`building-blocks/primes/same-prime-aggregation-monotone.md`](../../building-blocks/primes/same-prime-aggregation-monotone.md)  
**Classification:** Analytic Number Theory / Continuous Renewal Equations / Classical Analysis / Cell Derivatives / Monotone Embeddings / Chronological Divisibility

---

## 1. Executive Summary and Mathematical Statement

In the continuous-time representation of arithmetic divisor and prime-power renewal processes, the multiplicative floor aggregation $H(x) = \frac{A(\lfloor x \rfloor)}{\sqrt{x}} - \frac{B(\lfloor x \rfloor)}{x \sqrt{x}}$ normalizes the chronological tent sum $S(x)$ by $x^{3/2}$. Establishing differentiability within each integer cell and global monotonicity across all jump boundaries is foundational to prime-power stability.

This contribution proves:

1. **Normalized Chronological Tent Equivalence:**  
   For all $x > 0$:
   \[
   H(x) = \frac{S(x)}{x^{3/2}}.
   \]
2. **Exact Piecewise Cell Identification:**  
   For any integer $k \ge 1$ and every point $x \in [k, k+1]$:
   \[
   H(x) = \text{cell}_k(x) = \frac{x A(k) - B(k)}{x^{3/2}}.
   \]
   The boundary value at $x = k+1$ matches continuously because the newly arriving tent term at $k+1$ vanishes at its birth.
3. **Exact Cell Derivative Formula:**  
   For every $x > 0$, the cell profile has the exact derivative:
   \[
   \frac{d}{dx} \text{cell}_k(x) = \frac{3 B(k) - x A(k)}{2 x^{5/2}}.
   \]
4. **Intra-Cell Monotonicity:**  
   For every integer $k \ge 1$, because $3 B(k) - x A(k) \ge k > 0$ on $[k, k+1]$:
   \[
   \text{cell}_k \text{ is monotone non-decreasing on } [k, k+1].
   \]
5. **Global Monotonicity of the Multiplicative and Logarithmic Profiles:**  
   The renewal profile $H(x)$ is monotone non-decreasing on the entire semi-infinite ray $[1, \infty)$ with $H(1) = 0$. Consequently, the external logarithmic age profile $h(v) = H(e^v)$ is monotone non-decreasing on $[0, \infty)$:
   \[
   0 \le u \le v \implies h(u) \le h(v).
   \]

---

## 2. Mathematical Proof

### 2.1. Quotient Rule on Cell Profile
Let $\text{cell}_k(x) = \frac{u(x)}{w(x)}$ with $u(x) = x A(k) - B(k)$ and $w(x) = x^{3/2} = x \sqrt{x}$.
The derivatives are $u'(x) = A(k)$ and $w'(x) = \sqrt{x} + \frac{x}{2\sqrt{x}} = \frac{3}{2} \sqrt{x}$.
By the quotient rule:
\[
\frac{d}{dx} \text{cell}_k(x) = \frac{A(k) x^{3/2} - (x A(k) - B(k)) \frac{3}{2} x^{1/2}}{x^3}
\]
\[
= \frac{x^{1/2} [ x A(k) - \frac{3}{2} x A(k) + \frac{3}{2} B(k) ]}{x^3} = \frac{\frac{3}{2} B(k) - \frac{1}{2} x A(k)}{x^{5/2}} = \frac{3 B(k) - x A(k)}{2 x^{5/2}}.
\]

### 2.2. Cell Monotonicity via Kernel Positivity
By the aggregation kernel theorem, $3 B(k) - x A(k) \ge k > 0$ for all $x \in [k, k+1]$.
Since $2 x^{5/2} > 0$ for $x > 0$, the derivative is strictly positive on $(k, k+1)$.
By the mean value theorem, $\text{cell}_k$ is monotone non-decreasing on the closed interval $[k, k+1]$.

### 2.3. Boundary Gluing and Global Ray Monotonicity
At each integer boundary $x = k+1$, $\text{cell}_k(k+1) = \text{cell}_{k+1}(k+1)$ because the new term $(k+1)^{-1/2}(x - (k+1))$ evaluates to $0$.
Gluing the monotonic segments across each $[k, k+1]$ yields monotonicity on $(1, \infty)$.
Since $H(1) = \frac{A(1)}{1} - \frac{B(1)}{1} = 1 - 1 = 0$ and $H(x) \ge 0$ for all $x \ge 1$, monotonicity extends to the closed half-line $[1, \infty)$.
Transforming under $x = e^v$ yields monotonicity of $h(v) = H(e^v)$ on $[0, \infty)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeAggregationMonotone` in `formalization/BuildingBlocks/SamePrimeAggregationMonotone.lean`):
```lean
theorem H_eq_normalized_tent {x : ℝ} (hx : 0 < x) :
    H x = ChronologicalDivisibility.S x / (x * Real.sqrt x)

theorem H_eq_cell {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) : H x = cell k x

theorem cell_hasDerivAt (k : ℕ) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (cell k) ((3 * B k - x * A k) / (2 * x ^ 2 * Real.sqrt x)) x

theorem cell_monotoneOn {k : ℕ} (hk : 1 ≤ k) :
    MonotoneOn (cell k) (Set.Icc (k : ℝ) ((k : ℝ) + 1))

theorem H_monotoneOn : MonotoneOn H (Set.Ici 1)

theorem h_monotoneOn : MonotoneOn h (Set.Ici 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Piecewise continuous renewal kernels and Volterra delay operators (Askey 1975, Gripenberg 1990). Exact derivation of the cell derivative $\frac{3 B(k) - x A(k)}{2 x^{5/2}}$ and machine-checked global monotonicity for arithmetic tent normalizations in Lean 4 is new.
- **Advancement:** Proves the exact derivative formula and global monotonicity of $H$ and $h$ in Lean 4.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Results in Mathematics*.
