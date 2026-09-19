# Unique Contribution 270: Exact Finite Successor-Cell Dilation Semigroup and Collar Weight Densities

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorCellTransferFinite.lean`](../../formalization/BuildingBlocks/SuccessorCellTransferFinite.lean), [`building-blocks/spectral/successor-cell-transfer-finite.md`](../../building-blocks/spectral/successor-cell-transfer-finite.md)  
**Classification:** Arithmetic Dynamics / Dilation Semigroups / Cell Partitions / Logarithmic Weights / Multiplicative Operators / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

On physical discretized states indexed by logarithmic successor cells $[r, r+1)$ with cell lengths $\log((r+1)/r)$, an arithmetic left translation by $\log d$ evaluates the parent value at index $\lfloor r/d \rfloor$. A critical challenge in finite-cutoff arithmetic transport is verifying that truncation to a finite window $r \le N$ preserves the exact multiplicative semigroup property and controls carry errors.

This contribution proves:

1. **Finite Cutoff Semigroup Composition Law:**  
   Defining the finite-cutoff dilation transfer operator by:
   \[
   \text{transfer}(N, d, z)(r) = \begin{cases} z(\lfloor r / d \rfloor) & \text{if } r \le N, \\ 0 & \text{if } r > N, \end{cases}
   \]
   the operator satisfies the exact multiplicative semigroup law under iteration:
   \[
   \text{transfer}(N, a, \text{transfer}(N, b, z)) = \text{transfer}(N, ab, z).
   \]
   Because $\lfloor \lfloor r/a \rfloor / b \rfloor = \lfloor r / (ab) \rfloor$ and $\lfloor r/a \rfloor \le r \le N$, no state discarded beyond the finite ceiling $N$ can ever re-enter under subsequent dilations.
2. **Integer Dilation Interval Partition:**  
   For any dilation $d > 0$ and parent index $n$:
   \[
   \lfloor r / d \rfloor = n \iff d \cdot n \le r < d \cdot (n + 1).
   \]
3. **Logarithmic Cell Telescoping Identity:**  
   For any positive integers $a \le b$:
   \[
   \sum_{r=a}^{b-1} \log\left(\frac{r+1}{r}\right) = \log\left(\frac{b}{a}\right).
   \]
   In particular, the complete set of $d$ children of parent $n$ has total logarithmic measure:
   \[
   \sum_{r=d \cdot n}^{d(n+1)-1} \log\left(\frac{r+1}{r}\right) = \log\left(\frac{n+1}{n}\right),
   \]
   which is identically independent of $d$.
4. **Uniform Logarithmic Carry Bound:**  
   For child index $d \cdot n + j$ with remainder $0 \le j < d$:
   \[
   0 \le \log\left(\frac{d \cdot n + j}{d \cdot n}\right) < \frac{1}{n}.
   \]
   Consequently, the complex phase perturbation along the imaginary axis is uniformly bounded:
   \[
   \|e^{i t \log((dn+j)/(dn))} - 1\| \le \frac{|t|}{n},
   \]
   completely independent of the dilation factor $d$.
5. **Exact Triangular Collar Overlap Densities:**  
   For opposite dyadic collars $m \le r < 2m$ under left translation by $d$:
   \[
   \text{collarWeight}(m, d) = \sum_{r=\max(m,d)}^{\min(2m,2d)-1} \log\left(\frac{r+1}{r}\right) = \begin{cases}
   \log(2d / m) & \text{if } d < m < 2d, \\
   \log(2m / d) & \text{if } m \le d < 2m, \\
   0 & \text{if } 2d \le m \text{ or } 2m \le d.
   \end{cases}
   \]

---

## 2. Mathematical Proof

### 2.1. Finite Semigroup Law
For $r \le N$, the inner application evaluates at $r' = \lfloor r/a \rfloor$.
Since $a \ge 1$, $r' \le r \le N$, so the outer cutoff at $N$ is identically satisfied:
\[
\text{transfer}(N, a, \text{transfer}(N, b, z))(r) = \text{transfer}(N, b, z)(\lfloor r/a \rfloor) = z(\lfloor \lfloor r/a \rfloor / b \rfloor) = z(\lfloor r / (ab) \rfloor).
\]
For $r > N$, both sides evaluate to $0$.

### 2.2. Logarithmic Telescoping
\[
\sum_{r=a}^{b-1} \log\left(\frac{r+1}{r}\right) = \sum_{r=a}^{b-1} (\log(r+1) - \log r) = \log b - \log a = \log(b/a).
\]

### 2.3. Uniform Carry Bound
Using the elementary inequality $\log(1 + x) < x$ for $x > 0$:
\[
\log\left(\frac{dn+j}{dn}\right) = \log\left(1 + \frac{j}{dn}\right) < \frac{j}{dn} < \frac{d}{dn} = \frac{1}{n}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCellTransferFinite` in `formalization/BuildingBlocks/SuccessorCellTransferFinite.lean`):
```lean
theorem transfer_mul {R : Type*} [Zero R]
    (N a b : ℕ) (z : ℕ → R) :
    transfer N a (transfer N b z) = transfer N (a * b) z

theorem div_eq_iff_child {d n r : ℕ} (hd : 0 < d) :
    r / d = n ↔ d * n ≤ r ∧ r < d * (n + 1)

theorem sum_log_cell_length (a b : ℕ) (ha : 0 < a) (hab : a ≤ b) :
    (∑ r ∈ Finset.Ico a b,
      Real.log (((r + 1 : ℕ) : ℝ) / (r : ℝ))) =
      Real.log ((b : ℝ) / (a : ℝ))

theorem log_successor_carry_bound (d n j : ℕ) (hd : 0 < d)
    (hn : 0 < n) (hj : j < d) :
    0 ≤ Real.log (((d * n + j : ℕ) : ℝ) / ((d * n : ℕ) : ℝ)) ∧
      Real.log (((d * n + j : ℕ) : ℝ) / ((d * n : ℕ) : ℝ)) <
        (1 : ℝ) / (n : ℝ)

theorem norm_exp_successor_carry_le (t : ℝ) (d n j : ℕ)
    (hd : 0 < d) (hn : 0 < n) (hj : j < d) :
    ‖Complex.exp
        (((t * Real.log (((d * n + j : ℕ) : ℝ) /
            ((d * n : ℕ) : ℝ)) : ℝ) : ℂ) * Complex.I) - 1‖ ≤
      |t| / (n : ℝ)

theorem collarWeight_lower_band (m d : ℕ) (hm : 0 < m)
    (hdm : d < m) (hmd : m < 2 * d) :
    collarWeight m d = Real.log (((2 * d : ℕ) : ℝ) / (m : ℝ))

theorem collarWeight_upper_band (m d : ℕ) (hd : 0 < d)
    (hmd : m ≤ d) (hdm : d < 2 * m) :
    collarWeight m d = Real.log (((2 * m : ℕ) : ℝ) / (d : ℝ))

theorem collarWeight_zero_outside (m d : ℕ)
    (h : 2 * d ≤ m ∨ 2 * m ≤ d) : collarWeight m d = 0
```
Axioms audit confirms:
- `transfer_mul` and `div_eq_iff_child` depend strictly on constructive axioms `[propext, Quot.sound]` (zero `Classical.choice`!).
- Analytic theorems depend strictly on foundational axioms `[propext, Classical.choice, Quot.sound]`.
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Discretized dilation operators, Perron-Frobenius transfer operators of logarithmic intervals, and dyadic collar decompositions (Baladi 2000, Mayer 1991). A machine-verified proof of finite-cutoff semigroup preservation and exact triangular collar weights in Lean 4 is new.
- **Advancement:** Proves that arithmetic transport on discrete logarithmic grids is an exact semigroup despite finite ceiling truncation, with uniform $1/n$ carry bounds.
- **Target Venues:** *Ergodic Theory and Dynamical Systems* or *Journal of Number Theory*.
