# Unique Contribution 261: Exact Compact Scattering Packet Energy Identity and Orthogonal Translate Isometry

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactScatteringPackets.lean`](../../formalization/BuildingBlocks/CompactScatteringPackets.lean), [`building-blocks/scattering/compact-scattering-packets.md`](../../building-blocks/scattering/compact-scattering-packets.md)  
**Classification:** Functional Analysis / Scattering Theory / Wave Packets / Geometric Energy Identity / Orthogonal Translates / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In unitary scattering models for prime renewal processes, incoming wave packets encounter reflection barriers and cascade through multiple internal reflections. Proving asymptotic energy conservation and constructible bulk gain requires both exact geometric summation for reflected/transmitted energy and exact $L^2$ orthogonality for spatially separated translate trains.

This contribution proves:

1. **Exact Finite-Depth Packet Energy Identity:**  
   For any reflection coefficient $r \in \mathbb{R}$ and cascade depth $M \in \mathbb{N}$:
   \[
   r^2 + (1 - r^2)^2 \sum_{j=0}^{M-1} (r^2)^j = 1 - (1 - r^2)(r^2)^M.
   \]
   When $|r| < 1$, the defect $(1 - r^2)(r^2)^M \to 0$ exponentially as $M \to \infty$, recovering complete unitary energy conservation $1$.
2. **Existence of Finite Bulk Gain:**  
   For any integer depth $M$ and bulk gain factor $G > 1$, there exists an integer packet length $J > M$ such that:
   \[
   (J - M) G > J.
   \]
   This ensures that bulk amplification overcomes boundary loss for sufficiently long packet trains.
3. **Disjoint Lattice Support Separation:**  
   If $\eta : \mathbb{R} \to \mathbb{C}$ is supported in an open interval $(a, b)$ of width $b - a \le L$ with $L > 0$, then for any distinct integers $i \ne j \in \mathbb{Z}$:
   \[
   \eta(v - i L) \cdot \eta(v - j L) = 0 \quad \text{for all } v \in \mathbb{R}.
   \]
4. **Pointwise Disjoint Norm Identity:**  
   For any finite family of functions $f_i$ having pairwise disjoint supports:
   \[
   \left| \sum_{i \in s} f_i \right|^2 = \sum_{i \in s} |f_i|^2.
   \]
5. **Exact $L^2$ Translate Isometry:**  
   For any lattice spacing $L \ge b - a$, coefficients $c : \mathbb{Z} \to \mathbb{C}$, and finite index set $s \subset \mathbb{Z}$:
   \[
   \int_{\mathbb{R}} \left| \sum_{i \in s} c_i \eta(v - i L) \right|^2 dv = \left( \sum_{i \in s} |c_i|^2 \right) \int_{\mathbb{R}} |\eta(v)|^2 dv.
   \]
   No cross-terms exist, yielding exact diagonal energy summation.

---

## 2. Mathematical Proof

### 2.1. Geometric Resummation Identity
Recall the finite geometric sum identity $\sum_{j=0}^{M-1} q^j = \frac{1 - q^M}{1 - q}$ for $q = r^2$.
Multiplying by $(1 - r^2)^2$:
\[
(1 - r^2)^2 \sum_{j=0}^{M-1} (r^2)^j = (1 - r^2) \left( (1 - r^2) \sum_{j=0}^{M-1} (r^2)^j \right) = (1 - r^2)(1 - (r^2)^M).
\]
Adding $r^2$:
\[
r^2 + (1 - r^2)(1 - (r^2)^M) = r^2 + 1 - r^2 - (1 - r^2)(r^2)^M = 1 - (1 - r^2)(r^2)^M.
\]

### 2.2. Bulk Gain Threshold
To satisfy $(J - M) G > J$, rewrite as $J(G - 1) > M G$, or $J > \frac{M G}{G - 1}$.
Since $G > 1$, $G - 1 > 0$ and $\frac{M G}{G - 1} \in \mathbb{R}$.
Choosing $J = \lfloor \frac{M G}{G - 1} \rfloor + 1$ gives $J > \frac{M G}{G - 1} \ge 0$, and since $G > 1$, $\frac{M G}{G - 1} = M \frac{G}{G - 1} > M$, so $J > M$.

### 2.3. Translate Support Separation and $L^2$ Isometry
Assume $v - i L \in (a, b)$ and $v - j L \in (a, b)$ with $i < j$.
Then $a < v - j L$ and $v - i L < b$, which implies $(j - i) L < b - a$.
Since $i < j$ are integers, $j - i \ge 1$, so $L \le (j - i) L < b - a$, contradicting $b - a \le L$.
Thus the supports are disjoint.
Disjointness implies cross terms vanish pointwise: $\overline{c_i \eta(v - i L)} c_j \eta(v - j L) = 0$ for $i \ne j$.
Integrating term-by-term and using translation invariance of Lebesgue measure $\int |\eta(v - i L)|^2 dv = \int |\eta(v)|^2 dv$ yields the result.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactScatteringPackets` in `formalization/BuildingBlocks/CompactScatteringPackets.lean`):
```lean
theorem isolated_packet_energy (r : ℝ) (M : ℕ) :
    r ^ 2 + (1 - r ^ 2) ^ 2 * ∑ j ∈ Finset.range M, (r ^ 2) ^ j =
      1 - (1 - r ^ 2) * (r ^ 2) ^ M

theorem exists_finite_bulk_gain (M : ℕ) {G : ℝ} (hG : 1 < G) :
    ∃ J : ℕ, M < J ∧ (J - M : ℝ) * G > J

theorem separated_translate_values {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (i j : ℤ) (hij : i ≠ j) (v : ℝ) :
    eta (v - (i : ℝ) * L) = 0 ∨ eta (v - (j : ℝ) * L) = 0

theorem physical_translate_sum_square {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (s : Finset ℤ) (c : ℤ → ℂ) :
    physicalSquare (fun v => ∑ i ∈ s, c i * eta (v - (i : ℝ) * L)) =
      (∑ i ∈ s, Complex.normSq (c i)) * physicalSquare eta
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Wave packets, Gabor frames, and transmission line scattering (Daubechies 1992, Lax-Phillips 1989). A machine-verified algebraic and measure-theoretic proof of the finite-depth energy identity and the translate $L^2$ isometry in Lean 4 is new.
- **Advancement:** Establishes the foundational wave packet orthogonality and energy conservation identities for unitary scattering networks.
- **Target Venues:** *Journal of Functional Analysis* or *IEEE Transactions on Information Theory*.
