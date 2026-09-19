# Unique Contribution 217: Exact Prime Wave Packet Scattering Amplification and Null-Pole Smooth Carrier

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactScatteringOperator.lean`](../../formalization/BuildingBlocks/CompactScatteringOperator.lean), [`building-blocks/scattering/compact-scattering-operator.md`](../../building-blocks/scattering/compact-scattering-operator.md)  
**Classification:** Functional Analysis / Scattering Theory / Wavelet Analysis / Prime Number Distribution / Discrete Translation Operators / Spectral Non-Contractivity

---

## 1. Executive Summary and Mathematical Statement

In the operator-theoretic approach to scattering on the prime lattice $\mathbb{Z} \log p$, a crucial question is whether the unconstrained discrete history-scattering operator:
\[
\mathcal{H}_{r, M, L}(f)(v) = -r f(v - L) + (1 - r^2) \sum_{m=0}^{M-1} r^m f(v + m L)
\]
can act contractively on the full physical space $L^2(\mathbb{R})$, or whether structured localized wave packets can amplify $L^2$ energy. If wave packets with vanishing pole moments can amplify energy, this rigorously disproves naive unconditional contractivity on test spaces and proves that proper-cofactor cancellation conditions are strictly necessary to enforce stability.

This contribution proves:

1. **Exact Translation Commutation:**  
   The wave-packet synthesis operator $\text{packet}(L, \eta, c)(v) = \sum_{j \in \text{supp}(c)} c_j \eta(v - jL)$ commutes exactly with discrete coefficient translations and the history operator:
   \[
   \mathcal{H}_{r, M, L}(\text{packet}(L, \eta, c)) = \text{packet}(L, \eta, \mathcal{H}_{r, M}(c)).
   \]
2. **Exact $L^2$ Isometry for Disjoint Wave Packets:**  
   If the support diameter of the carrier $\eta$ is bounded by the lattice spacing $L$ ($\text{diam}(\text{supp}(\eta)) \le L$), the wave packet satisfies the exact $L^2$ norm identity:
   \[
   \|\text{packet}(L, \eta, c)\|_{L^2}^2 = \left( \sum_{j \in \text{supp}(c)} |c_j|^2 \right) \|\eta\|_{L^2}^2,
   \]
   and similarly for the history-scattered packet.
3. **Phase-Box History Bulk Gain:**  
   For phase coefficients $q = e^{i\theta}$ and box length $J > M$:
   \[
   \sum_{k} |\mathcal{H}_{r, M}(c)_k|^2 \ge (J - M) |\sigma(r, \theta, M)|^2.
   \]
4. **Prime Wave Packet Energy Amplification:**  
   For every prime $p$ with lattice parameter $L = \log p$, transmission parameter $r = p^{-1/2}$, and depth $M \ge 1$:
   There exists a finite packet length $J > M$ such that:
   \[
   \|\text{packet}(\log p, \eta, c_J)\|_{L^2}^2 < \|\mathcal{H}_{p^{-1/2}, M, \log p}(\text{packet}(\log p, \eta, c_J))\|_{L^2}^2.
   \]
5. **Existence of Smooth Carrier with Vanishing Pole Moments:**  
   There exists a smooth, compactly supported carrier wavelet $\eta \in C_c^\infty(\mathbb{R})$ satisfying $\eta(0) = 1$ and vanishing complex pole moments:
   \[
   \int_{-\infty}^\infty \eta(v) e^{\pm v/2} \, dv = 0,
   \]
   which simultaneously produces strict $L^2$ energy amplification under the discrete prime history scattering operator.

---

## 2. Mathematical Proof

### 2.1. Translation and Disjointness
When $\text{supp}(\eta) \subseteq (a, b)$ with $b - a \le L$, the translated copies $\eta(\cdot - jL)$ have pairwise disjoint supports for distinct $j \in \mathbb{Z}$.
Consequently, the cross terms in the $L^2$ norm vanish identically:
\[
\int_{-\infty}^\infty \left| \sum_{j} c_j \eta(v - jL) \right|^2 dv = \sum_{j} |c_j|^2 \int_{-\infty}^\infty |\eta(v - jL)|^2 dv = \left( \sum_j |c_j|^2 \right) \|\eta\|_{L^2}^2.
\]

### 2.2. Bulk Amplification
The history operator acts on the sequence $c_j = e^{ij\theta}$ for $0 \le j < J$.
On the bulk region $1 \le k \le J - M$, all $M$ terms in the backward sum fall within the support of $c$, producing the constant modulus:
\[
|\mathcal{H}_{r, M}(c)_k| = |\sigma(r, \theta, M)|.
\]
Summing over the $J - M$ bulk indices yields $\sum_k |\mathcal{H}_{r, M}(c)_k|^2 \ge (J - M) |\sigma(r, \theta, M)|^2$.
When $|\sigma(r, \theta, M)| > 1$, choosing $J$ sufficiently large ensures that $(J - M) |\sigma|^2 > J = \sum_{j=0}^{J-1} |c_j|^2$.

### 2.3. Vanishing Pole Moments
By construction of the narrow complex pole-null wavelet (`BuildingBlocks.NarrowPoleNullPacket`), one can choose $\eta \in C_c^\infty((-\epsilon, \epsilon))$ with $\epsilon < (\log p)/2$ such that $\int \eta(v) e^{\pm v/2} dv = 0$ while preserving $\eta(0) = 1$ and $\|\eta\|_{L^2} > 0$. The disjointness condition $b - a = 2\epsilon < \log p$ holds, and the energy strictly amplifies.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactScatteringOperator` in `formalization/BuildingBlocks/CompactScatteringOperator.lean`):
```lean
theorem packet_physical_square {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (c : ℤ →₀ ℂ) :
    physicalSquare (packet L eta c) =
      (∑ j ∈ c.support, Complex.normSq (c j)) * physicalSquare eta

theorem exists_prime_amplifying_packet {eta : ℝ → ℂ} {a b : ℝ}
    (p : ℕ) (hp : p.Prime) (hw : b - a ≤ Real.log (p : ℝ))
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (hmass : 0 < physicalSquare eta) (M : ℕ) (hM : 1 ≤ M) :
    ∃ J : ℕ, M < J ∧
      physicalSquare (packet (Real.log (p : ℝ)) eta ...) <
      physicalSquare (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) ...)

theorem exists_prime_amplifying_narrow_carrier (p : ℕ) (hp : p.Prime)
    (M : ℕ) (hM : 1 ≤ M) :
    ∃ eta : ℝ → ℂ, HasCompactSupport eta ∧ ContDiff ℝ ∞ eta ∧ eta 0 = 1 ∧
      BuildingBlocks.NarrowPoleNullPacket.complexMoment eta (1 / 2) = 0 ∧
      BuildingBlocks.NarrowPoleNullPacket.complexMoment eta (-(1 / 2)) = 0 ∧
      ∃ J : ℕ, M < J ∧ ...
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Discrete wavelets, Lax-Phillips scattering, and non-unitary shift operators (Daubechies 1992, Lax-Phillips 1989, Pavlov 1987). Machine formalization of exact prime wave-packet energy amplification with vanishing pole moments in Lean 4 is new.
- **Advancement:** Proves constructively that the unconstrained prime history operator amplifies energy on localized smooth wave packets with vanishing pole moments, establishing the necessity of proper-cofactor subspace constraints.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
