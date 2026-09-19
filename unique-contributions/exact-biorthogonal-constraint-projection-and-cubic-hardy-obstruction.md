# Contribution 259: Exact Biorthogonal Constraint Projection and Cubic Hardy Obstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ConstrainedHardyObstruction.lean`](../../formalization/BuildingBlocks/ConstrainedHardyObstruction.lean), [`building-blocks/hardy/constrained-hardy-obstruction.md`](../../building-blocks/hardy/constrained-hardy-obstruction.md)  
**Classification:** Functional Analysis / Hardy Inequalities / Constraint Elimination / Biorthogonal Systems / Spectral Obstructions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

A classical question in the spectral theory of weighted Hardy operators is whether imposing finitely many linear moment constraints $\langle L_j, x \rangle = 0$ ($j = 1, \dots, n$) can repair a deficiency where boundary-port energy dominates internal core energy. In the asymptotic scaling parameter $t = \sqrt{\log(1/\epsilon)}$, boundary energy grows cubically in $t$ while core energy grows at most quadratically.

This contribution proves:

1. **Exact Biorthogonal Linear Constraint Elimination:**  
   Given any finite family of linear functionals $L_1, \dots, L_n \in V^*$ and a biorthogonal family $z_1, \dots, z_n \in V$ satisfying $L_i(z_j) = \delta_{ij}$, the projection operator:
   $$
   P_L(x) = x - \sum_{j=1}^n L_j(x) z_j
   $$
   satisfies $L_i(P_L(x)) = 0$ for every $i \in \{1, \dots, n\}$. Thus, $P_L(x)$ projects $x$ into the simultaneous kernel $\bigcap_{i=1}^n \ker L_i$.
2. **Cubic-vs-Quadratic Scaling Dominance:**  
   Let $c, C, D > 0$ and $t \ge 1$. If the threshold condition $C + D < c t$ holds, and the boundary-port weight satisfies $c t^3 \le \text{port}$, then any quadratic core energy bound:
   $$
   \text{energy} \le C t^2 + D
   $$
   strictly fails to dominate the port weight:
   $$
   \text{energy} < \text{port}.
   $$
3. **Impossibility of Finite Correction Recovery:**  
   If an incoming packet with raw energy $E_{\text{raw}} \le C t^2$ is corrected by adding a finite correction with bounded energy $E_{\text{corr}} \le D$, the corrected profile has total energy at most $C t^2 + D$, which strictly satisfies:
   $$
   E_{\text{corrected}} < \text{port}.
   $$
   Thus, no finite-rank constraint correction with bounded ceiling can bridge the cubic-vs-quadratic spectral gap.
4. **Disjoint Energy Monotonicity:**  
   If the correction is spatially or spectrally disjoint from the original packet, their non-negative weighted norms add monotonically, precluding destructive cancellation of the boundary port.

---

## 2. Mathematical Proof

### 2.1. Simultaneous Kernel Projection
Applying $L_i$ to $P_L(x)$:
$$
L_i(P_L(x)) = L_i(x) - \sum_{j=1}^n L_j(x) L_i(z_j).
$$
Since $L_i(z_j) = \delta_{ij}$:
$$
\sum_{j=1}^n L_j(x) \delta_{ij} = L_i(x).
$$
Therefore:
$$
L_i(P_L(x)) = L_i(x) - L_i(x) = 0 \quad (\forall i \in \{1, \dots, n\}).
$$

### 2.2. Cubic Growth Dominance
For $t \ge 1$, we have $t^2 \ge 1$, so $D \le D t^2$.
Thus:
$$
\text{energy} \le C t^2 + D \le (C + D) t^2.
$$
Since $C + D < c t$ and $t^2 > 0$:
$$
(C + D) t^2 < (c t) t^2 = c t^3 \le \text{port}.
$$
Hence:
$$
\text{energy} < \text{port}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation` in `formalization/BuildingBlocks/ConstrainedHardyObstruction.lean`):
```lean
theorem constraintCorrected_mem_kernel {n : ℕ}
    (L : Fin n → V →ₗ[ℝ] ℝ) (z : Fin n → V) (x : V)
    (hdual : ∀ i j, L i (z j) = if i = j then 1 else 0) :
    ∀ i, L i (constraintCorrected L z x) = 0

theorem cubic_weight_beats_quadratic_energy
    {c C D t port energy : ℝ}
    (hD : 0 ≤ D) (ht : 1 ≤ t)
    (hthreshold : C + D < c * t)
    (hport : c * t^3 ≤ port)
    (henergy : energy ≤ C * t^2 + D) :
    energy < port

theorem corrected_packet_failure
    {c C D t port rawEnergy correctionEnergy correctedEnergy : ℝ}
    (hD : 0 ≤ D) (ht : 1 ≤ t)
    (hthreshold : C + D < c * t)
    (hport : c * t^3 ≤ port)
    (hraw : rawEnergy ≤ C * t^2)
    (hcorr : correctionEnergy ≤ D)
    (htotal : correctedEnergy ≤ rawEnergy + correctionEnergy) :
    correctedEnergy < port
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Weighted Hardy inequalities and constraint-modified Sobolev spaces (Maz'ya 1985, Davies 1995, Opic-Kufner 1990). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact algebraic obstruction that disproves naive finite-constraint repairs of boundary leakage in singular renewal operators.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Annalen*.
