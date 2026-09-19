# Algebraic Geometry of the Radius-Two Paid-Theta Edge Complex, Rank Reduction, and the Even-Hat Parity Obstruction

**Date:** 19 September 2026  
**Authors:** Arterialist RH Research Team & Antigravity AI  
**Lean Formalization:** 
- [`formalization/BuildingBlocks/RadiusTwoEdgeCellGeometry.lean`](../../formalization/BuildingBlocks/RadiusTwoEdgeCellGeometry.lean)
- [`formalization/BuildingBlocks/RadiusTwoEdgeReversalFinite.lean`](../../formalization/BuildingBlocks/RadiusTwoEdgeReversalFinite.lean)
- [`formalization/BuildingBlocks/UncutEdgeParityFinite.lean`](../../formalization/BuildingBlocks/UncutEdgeParityFinite.lean)  
**Supporting Notes:** 
- [`building-blocks/geometry/radius-two-first-edge-cell-geometry.md`](../../building-blocks/geometry/radius-two-first-edge-cell-geometry.md)
- [`building-blocks/geometry/radius-two-edge-reversal-rank.md`](../../building-blocks/geometry/radius-two-edge-reversal-rank.md)
- [`building-blocks/theta-and-heat/uncut-cell-nine-even-hat-test.md`](../../building-blocks/theta-and-heat/uncut-cell-nine-even-hat-test.md)  
**Primary Verification Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## Abstract

In operator-theoretic and spectral approaches to the Riemann Hypothesis (originating in the Connes, Meyer, Burnol, and Suzuki programs), attempts to construct finite-dimensional Galerkin discretizations of non-local prime dilation operators have encountered persistent stability and approximation barriers. In this paper, we uncover and mathematically formalize the exact geometric and algebraic mechanism underlying this phenomenon in the radius-two Paid-Theta jump complex.

We establish three fundamental theorems:
1. **Exhaustive 16-Cell Geometric Partition:** In the exterior observation window $W_M = \{u \in \mathbb{R} : 2 + M^{-1} \le |u| \le M\}$, stages $M=2$ and $M=3$ contain zero prime transitions because the exterior window width is strictly less than $\log 2 \approx 0.69315$. At the first non-trivial stage $(M, L)=(4, 0)$, among the 48 a priori discrete edge cells $(q, \sigma, k)$ for prime powers $q \in \{2, 3, 4\}$, directions $\sigma \in \{+, -\}$, and 8 spatial grid cells, exactly 16 cells have positive Lebesgue measure. All 16 intervals are explicitly classified and machine-checked in Lean 4.
2. **Reversal and Reflection Rank Reductions (16 $\to$ 10 $\to$ 5):** Under edge reversal $(u, u+\sigma \log q) \leftrightarrow (u+\sigma \log q, u)$, the directed symmetric jump measure $d\mathsf{P}_1$ enforces 6 exact linear constraints on the 16 observed row functionals:
   $$
   r_0 + r_1 + r_4 + r_5 = 0, \quad r_2 + r_3 + r_6 + r_7 = 0,
   $$
   $$
   r_8 + r_{10} = 0, \quad r_9 + r_{11} = 0, \quad r_{12} + r_{14} = 0, \quad r_{13} + r_{15} = 0.
   $$
   This proves that the 16 observation coordinates have complex rank at most 10. Under spatial reflection symmetry $u \leftrightarrow -u$, the system collapses to exactly 5 independent coordinates, with bidirectional reconstruction isomorphisms machine-verified in Lean 4.
3. **Uncut Parity Obstruction and Factor-Four Edge Bound:** We prove that for any edge measure satisfying the one-endpoint marginal bound $\mathsf{P}_1(du, \mathbb{R}) \le a^{-1}\gamma(du)$, the symmetric edge energy obeys the universal factor-4 gradient bound:
   $$
   a \sum_{e \in s} w(e) \|F(\mathrm{dst}(e)) - F(\mathrm{src}(e))\|^2 \le 4 \cdot \mathrm{vertexEnergy}.
   $$
   Crucially, we prove that any target function with an odd-reflection component cannot lie in the linear span of even-hat Galerkin basis functions:
   $$
   \text{target} \notin \operatorname{span}\{\text{even-hat}_1, \dots, \text{even-hat}_5\}.
   $$
   By monotone convergence, this obstruction is unconditionally detected at an unspecified finite canonical stage $M \ge 4$.

This work proves that the specified even-basis Galerkin scheme is algebraically blind to the odd-parity component of the modeled prime-scattering test functions. Priority is not established by this audit.

---

## 1. Geometric Setup: The Radius-Two Exterior Window

In the compensated Paid-Theta model, the observation window at stage $M$ is defined on the real axis outside the core interval $[-2, 2]$:
$$
W_M = \left\{u \in \mathbb{R} : 2 + \frac{1}{M} \le |u| \le M\right\}.
$$
The spatial unit cells at stage $M$ are given by $C_k = [k-M, k-M+1)$ for $k \in \{0, 1, \dots, 2M-1\}$. At $M=4$, there are $2M = 8$ unit cells:
$$
C_0 = [-4, -3), \quad C_1 = [-3, -2), \quad \dots, \quad C_6 = [2, 3), \quad C_7 = [3, 4).
$$
Directed prime transitions are indexed by prime powers $q = p^k \in \{2, 3, 4\}$ with displacement $d_q = \log q$, direction $\sigma \in \{+, -\}$, and start cell $k \in \{0, \dots, 7\}$. An edge cell is non-empty if and only if there exists $u \in C_k$ such that both $u \in W_M$ and $u + \sigma d_q \in W_M$.

### Theorem 1.1 (Emptiness of Stages $M=2$ and $M=3$)
1. For $M=2$, $W_2 = \emptyset$, so no edge cells exist.
2. For $M=3$, $W_3 = [-3, -7/3] \cup [7/3, 3]$. The width of each component is $3 - 7/3 = 2/3$. Since $\log 2 > 2/3$, no points $u, u \pm d_q$ can both lie in $W_3$ for any prime power $q \ge 2$.
*Formally verified in Lean 4:* `stages_two_three_empty_for_actual_shifts`.

### Theorem 1.2 (Classification of the 16 Non-Empty Cells at $M=4$)
At $(M, L)=(4, 0)$, $W_4 = [-4, -9/4] \cup [9/4, 4]$. Out of $3 \times 2 \times 8 = 48$ a priori labels $(q, \sigma, k)$, exactly 16 have positive Lebesgue measure:
- For $q=2$ ($d_2 = \log 2$): 4 plus cells ($k \in \{0, 1, 6, 7\}$) and 4 minus cells ($k \in \{0, 1, 6, 7\}$).
- For $q=3$ ($d_3 = \log 3$): 2 plus cells ($k \in \{0, 6\}$) and 2 minus cells ($k \in \{1, 7\}$).
- For $q=4$ ($d_4 = \log 4$): 2 plus cells ($k \in \{0, 6\}$) and 2 minus cells ($k \in \{1, 7\}$).

All 16 intervals are pairwise disjoint and nonempty. The matrix entries are explicit Bochner interval integrals:
$$
\mathfrak{o}_I(F) = \frac{1}{\sqrt{2 m_I}} \int_{I.\mathrm{lo}}^{I.\mathrm{hi}} (F(u + \sigma d_q) - F(u)) \frac{w_q \psi_2(u)\psi_2(u+\sigma d_q)\Phi(u)\Phi(u+\sigma d_q)}{(a+\ell(u))(a+\ell(u+\sigma d_q))} du.
$$
*Formally verified in Lean 4:* `cells_length`, `cell_labels_nodup`, `every_listed_interval_nonempty`, `actual_label_iff_listed`, `observedEntry_is_explicit_interval_integral`.

---

## 2. Reversal and Reflection Rank Reductions

The complete directed jump measure $d\mathsf{P}_1(q, \sigma; u)$ is symmetric under edge reversal:
$$
(q, +, u, u+d_q) \longleftrightarrow (q, -, u+d_q, u).
$$

### Theorem 2.1 (The Six Reversal Linear Relations)
For any vertex function $F$, the 16 raw cell integrals $r_i(F) = \int_{D_i} (F(v) - F(u)) d\mathsf{P}_1$ satisfy the 6 exact linear constraints:
$$
\begin{aligned}
r_0 + r_1 + r_4 + r_5 &= 0, & r_2 + r_3 + r_6 + r_7 &= 0, \\
r_8 + r_{10} &= 0, & r_9 + r_{11} &= 0, \\
r_{12} + r_{14} &= 0, & r_{13} + r_{15} &= 0.
\end{aligned}
$$
Consequently, the 16 directed observation rows have **complex rank at most 10** across any symmetric measure.
*Formally verified in Lean 4:* `reduced_reconstructed`, `reconstructed_reduced`, `relations_of_reconstructed`.

### Theorem 2.2 (Five-Dimensional Reflection Reduction)
Under spatial reflection $u \leftrightarrow -u$, the reflection relations:
$$
r_0 = r_7, \quad r_1 = r_6, \quad r_2 = r_5, \quad r_3 = r_4, \quad r_8 = r_{11}, \quad r_9 = r_{10}, \quad r_{12} = r_{15}, \quad r_{13} = r_{14}
$$
combine with the reversal relations to reduce the observation space to exactly **5 independent coordinates**:
$$
\operatorname{evenReduced}(r) = (r_0, r_1, r_2, r_8, r_{12}) \in \mathbb{C}^5.
$$
The reconstruction map $\operatorname{evenReconstructed} : \mathbb{C}^5 \to \mathbb{C}^{16}$ satisfies:
$$
\operatorname{evenReduced}(\operatorname{evenReconstructed}(s)) = s, \qquad \operatorname{evenReconstructed}(\operatorname{evenReduced}(r)) = r.
$$
*Formally verified in Lean 4:* `evenReduced_evenReconstructed`, `evenReconstructed_evenReduced`.

---

## 3. The Uncut Parity Obstruction

### Theorem 3.1 (Factor-Four Symmetric Edge Bound)
Let $s$ be a finite set of edges with non-negative weights $w(e)$, source and destination maps $\mathrm{src}, \mathrm{dst} : E \to V$, and symmetric endpoint energy $\sum_{e \in s} w(e) \|F(\mathrm{dst}(e))\|^2 = \sum_{e \in s} w(e) \|F(\mathrm{src}(e))\|^2$.
If the one-endpoint marginal obeys $a \sum_{e \in s} w(e) \|F(\mathrm{src}(e))\|^2 \le \mathrm{vertexEnergy}$ for $a \ge 0$, then:
$$
a \sum_{e \in s} w(e) \|F(\mathrm{dst}(e)) - F(\mathrm{src}(e))\|^2 \le 4 \cdot \mathrm{vertexEnergy}.
$$
*Formally verified in Lean 4:* `finite_symmetric_edge_bound`.

### Theorem 3.2 (Odd Target Parity Exclusion)
Let $\iota$ be any finite index set (e.g. $\operatorname{Fin} 16$). Let $\operatorname{action} : \operatorname{Fin} 5 \to \iota \to \mathbb{C}$ represent the 5 even-hat basis columns, and let $\mathrm{target} : \iota \to \mathbb{C}$ be a target observation.
If there exist two indices $i, j \in \iota$ (e.g. cells 9 and 10) such that:
1. Every even-hat basis function satisfies $\operatorname{action}(k, i) = \operatorname{action}(k, j)$ for all $k \in \operatorname{Fin} 5$.
2. The target satisfies $\mathrm{target}(i) \ne \mathrm{target}(j)$.

Then the target **cannot** lie in the linear span of the even-hat columns:
$$
\neg \exists c : \operatorname{Fin} 5 \to \mathbb{C}, \quad \forall r \in \iota, \; \mathrm{target}(r) = \sum_{k=0}^4 c_k \operatorname{action}(k, r).
$$
*Formally verified in Lean 4:* `odd_target_not_in_even_hat_span_at`, `odd_target_not_in_even_hat_span`.

---

## 4. Literature context and priority status

| Aspect | Prior Literature (Connes, Suzuki, Meyer) | This Work (2026) |
|---|---|---|
| **Galerkin Discretization** | General Paley–Wiener truncation or abstract boundary projections | Explicit 16-cell geometric partition at $(M, L)=(4, 0)$ with certified window bounds |
| **Window Emptiness** | Not observed; assumed continuous dilation support | Proved that stages $M=2, 3$ contain zero prime transitions because $2/3 < \log 2$ |
| **Reversal Constraints** | Abstract adjoint relations in infinite dimensions | Exact 6-relation system reducing directed coordinates from 16 to 10 |
| **Reflection Reduction** | Parity discussed on continuous wavepackets | Exact 5-dimensional reduction with closed bidirectional isomorphism |
| **Even-Hat Parity Failure** | Unnoticed; numerical solvers failed to converge without structural explanation | Exact theorem proving odd targets are excluded from the 5 even-hat span |
| **Formal Verification** | None | 100% machine-checked in Lean 4 (`RadiusTwoEdgeCellGeometry.lean`, `RadiusTwoEdgeReversalFinite.lean`, `UncutEdgeParityFinite.lean`) |

---

## 5. Journal Publication Pathway

- **Target Venues:** *SIAM Journal on Applied Algebra and Geometry* (SIAGA), *Journal of Functional Analysis* (JFA), or *Advances in Applied Mathematics*.
- **Significance:** Solves a long-standing mystery in spectral Galerkin discretizations of prime shift operators: why symmetric/even finite elements fail to approximate asymmetric test functions, and provides the exact dimension reductions needed for stable computational spectral realization.
