# Contribution 307: Exact Cyclotomic-Farey Tri-Partition and Conductor Interaction Control

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CyclotomicInteraction.lean`](../../formalization/BuildingBlocks/CyclotomicInteraction.lean), [`building-blocks/cyclotomic-boundary/interaction.md`](../../building-blocks/cyclotomic-boundary/interaction.md)  
**Classification:** Arithmetic Geometry / Cyclotomic Polynomials / Farey Dissections / Conductor Partitions / Boundary Derivative Deficits / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral and geometric analysis of cyclotomic boundary dynamics, the total interaction between successive cutoff levels is mediated by Farey-weighted updates at primitive roots of unity. To establish stability as the cutoff $X \to \infty$, the set of old conductors $[1, N-1]$ must be decomposed according to their geometric proximity to the boundaries $0$ and $N$.

This contribution proves:

1. **Exact Disjoint Conductor Tri-Partition:**  
   For any cutoff $N$ and parameter $Y$, the set of old conductors $\mathcal{O}_N = \{1, \dots, N-1\}$ admits an exact disjoint partition into three sets:
   $$
   \mathcal{O}_N = \mathcal{C}_{\text{small}}(N, Y) \sqcup \mathcal{C}_{\text{recent}}(N, Y) \sqcup \mathcal{C}_{\text{interior}}(N, Y),
   $$
   where small conductors satisfy $n \le Y$, controlled recent conductors satisfy $Y < n$ and $N - n \le \sqrt{N}$, and interior conductors satisfy $Y < n$ and $N - n > \sqrt{N}$.
2. **Exact Interaction Sum Decomposition:**  
   The cumulative signed old Farey interaction decomposes into controlled and interior components:
   $$
   \mathcal{I}_{\text{old}}(X) = \mathcal{I}_{\text{controlled}}(X, Y) + \mathcal{I}_{\text{interior}}(X, Y).
   $$
3. **Controlled Boundary Cost Majorization:**  
   The peripheral interaction is strictly bounded by the sum of small-conductor and recent-conductor absolute costs:
   $$
   |\mathcal{I}_{\text{controlled}}(X, Y)| \le \mathcal{C}_{\text{small}}(X, Y) + \mathcal{C}_{\text{recent}}(X).
   $$
4. **Logarithmic-Divisor Conductor Majorization:**  
   For any subset of conductors $s \subseteq \mathcal{O}_N$, the absolute root update is majorized by:
   $$
   \text{selectedAbsolute}(N, s) \le d(N) \log N \cdot \text{selectedMass}(N, s),
   $$
   where $d(N) = |\{d : d \mid N\}|$ is the number of divisors of $N$.
5. **Discrete-to-Continuous Geometric Equivalence:**  
   For $Y = \lfloor \sqrt{X} \rfloor$, an integer conductor $n$ belongs to the interior filter if and only if:
   $$
   \sqrt{X} < n < N - \sqrt{N}.
   $$

---

## 2. Mathematical Proof

### 2.1. Conductor Tri-Partition
For any $n \in \{1, \dots, N-1\}$, either $n \le Y$ (small), or $n > Y$.
If $n > Y$, either $N - n \le \sqrt{N}$ (recent), or $N - n > \sqrt{N}$ (interior).
These three conditions are mutually exclusive and collectively exhaustive, giving an exact disjoint partition of the finite set $\mathcal{O}_N$.

### 2.2. Linearity of Signed Sector Sums
Since $\mathcal{O}_N$ is a disjoint union, summing the sector signed weights:
$$
\sum_{n \in \mathcal{O}_N} \text{sectorSigned}(N, n) = \sum_{n \in \text{small}} + \sum_{n \in \text{recent}} + \sum_{n \in \text{interior}}.
$$
Summing over $N \in [3, X]$ preserves this exact partition into $\mathcal{I}_{\text{controlled}}(X, Y) + \mathcal{I}_{\text{interior}}(X, Y)$.

### 2.3. Absolute Value Bounding
By the triangle inequality on finite sums:
$$
|\text{sectorSigned}(N, n)| = \left| \sum_a w(N, n, a) \Delta(N, \zeta_n^a) \right| \le \sum_a w(N, n, a) |\Delta(N, \zeta_n^a)| = \text{sectorAbsolute}(N, n).
$$
Applying this across the controlled sets yields:
$$
|\mathcal{I}_{\text{controlled}}(X, Y)| \le \sum_{N=3}^X \left( \text{selectedAbsolute}(N, \text{small}) + \text{selectedAbsolute}(N, \text{recent}) \right) = \mathcal{C}_{\text{small}}(X, Y) + \mathcal{C}_{\text{recent}}(X).
$$

### 2.4. Logarithmic Bound from Root Updates
Each individual old root update satisfies $|\Delta(N, \zeta_n^a)| \le d(N) \log N$ under the regularized radial identity.
Since $w(N, n, a) \ge 0$, factoring $d(N) \log N$ out of the sum over $a$ and $n \in s$ gives $\le d(N) \log N \sum_{n \in s} \sum_a w(N, n, a) = d(N) \log N \cdot \text{selectedMass}(N, s)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CyclotomicBoundary` in `formalization/BuildingBlocks/CyclotomicInteraction.lean`):
```lean
theorem oldConductors_partition (N Y : ℕ) :
    oldConductors N = smallConductors N Y ∪
      controlledRecentConductors N Y ∪ interiorConductors N Y

theorem selectedAbsolute_le {X N : ℕ} (hidentity : ActualOldFactorIdentities X)
    (hN : N ∈ Icc 3 X) (s : Finset ℕ) (hs : s ⊆ oldConductors N) :
    selectedAbsolute N s ≤ (N.divisors.card : ℝ) * Real.log N * selectedMass N s

theorem oldInteraction_partition (X Y : ℕ) :
    oldInteraction X = controlledInteraction X Y + interiorInteraction X Y

theorem controlledInteraction_abs_le (X Y : ℕ) :
    |controlledInteraction X Y| ≤ smallBoundaryCost X Y + recentBoundaryCost X

theorem mem_interiorConductors_iff {N X n : ℕ} (hn : 1 ≤ n) (hOld : n < N) :
    n ∈ interiorConductors N (Nat.sqrt X) ↔
      Real.sqrt X < (n : ℝ) ∧ (n : ℝ) < (N : ℝ) - Real.sqrt N
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Farey fractions and Ford circles (Ford 1938); Rademacher (1973) *Topics in Analytic Number Theory*; Vaughan (1997) *The Hardy-Littlewood Method*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes an exact combinatorial framework isolating interior cyclotomic interactions from boundary and recent conductor errors with explicit divisor-logarithmic bounds.
- **Target Venues:** *Journal of Number Theory* or *Ramanujan Journal*.
