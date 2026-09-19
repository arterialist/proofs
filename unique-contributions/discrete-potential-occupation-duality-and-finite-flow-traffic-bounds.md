# Unique Contribution 108: Discrete Potential-Occupation Duality and Finite Flow Traffic Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/AncestryFlow.lean`](../../formalization/BuildingBlocks/AncestryFlow.lean)  
**Classification:** Applied Probability / Markov Chains / Potential Theory / Discrete Green Identities / Foster-Lyapunov Drift Bounds

---

## 1. Executive Summary and Mathematical Statement

In the quantitative analysis of open Markov chains, branching processes, and ancestry flows with external mass injection $b$, the steady-state occupation measure $M$ satisfies the linear balance equation:
\[
M_i = b_i + \sum_{j \in s} M_j T_{ji}, \quad \forall i \in s.
\]
Standard stochastic analysis establishes Foster-Lyapunov stability under asymptotic probabilistic assumptions.

This contribution proves:

1. **Exact Discrete Green Identity (Potential-Occupation Duality):**  
   For ANY finite set $s$, arbitrary vectors $b, M, V: s \to \mathbb{R}$, and transition matrix $T: s \times s \to \mathbb{R}$ satisfying $M_i = b_i + \sum_j M_j T_{ji}$:
   \[
   \sum_{i \in s} M_i \left( V_i - \sum_{j \in s} T_{ij} V_j \right) = \sum_{i \in s} b_i V_i.
   \]
   This identity holds purely algebraically; no positivity, acyclicity, stochasticity, or sub-stochasticity is assumed.
2. **Exact Absorption Mass Conservation:**  
   When $V \equiv 1$ and transitions satisfy row defect absorption $r_i + \sum_j T_{ij} = 1$:
   \[
   \sum_{i \in s} M_i r_i = \sum_{i \in s} b_i.
   \]
   The total absorbed mass across the finite state space exactly equals the total injected mass.
3. **Finite Foster-Lyapunov Drift Bound:**  
   If $M \ge 0$, $(I - T)V \ge 0$ on all of $s$, and $(I - T)V \ge c > 0$ on a subset $o \subseteq s$:
   \[
   c \sum_{i \in o} M_i \le \sum_{i \in s} b_i V_i.
   \]
4. **Finite Flow Total Traffic Majorization:**  
   If the complementary occupation outside $o$ is bounded by $\sum_{i \in s \setminus o} M_i \le \sum_{i \in o} M_i + B$:
   \[
   \sum_{i \in s} M_i \le \frac{2}{c} \sum_{i \in s} b_i V_i + B.
   \]
   The total network traffic is rigorously majorized by the Lyapunov energy of the input injection.

---

## 2. Mathematical Proof

### 2.1. Discrete Green Identity
Multiply the balance equation $M_i = b_i + \sum_j M_j T_{ji}$ by $V_i$ and sum over $i \in s$:
\[
\sum_{i \in s} M_i V_i = \sum_{i \in s} b_i V_i + \sum_{i, j \in s} M_j T_{ji} V_i.
\]
By swapping dummy indices $i \leftrightarrow j$ in the double sum:
\[
\sum_{i, j \in s} M_j T_{ji} V_i = \sum_{i, j \in s} M_i T_{ij} V_j = \sum_{i \in s} M_i \left( \sum_{j \in s} T_{ij} V_j \right).
\]
Subtracting this term from both sides:
\[
\sum_{i \in s} M_i \left( V_i - \sum_{j \in s} T_{ij} V_j \right) = \sum_{i \in s} b_i V_i.
\]

### 2.2. Drift and Traffic Bounds
Let $\Delta V_i = V_i - \sum_j T_{ij} V_j$. By hypothesis, $\Delta V_i \ge 0$ for all $i \in s$, and $\Delta V_i \ge c$ for $i \in o$.
Since $M_i \ge 0$:
\[
c \sum_{i \in o} M_i \le \sum_{i \in o} M_i \Delta V_i \le \sum_{i \in s} M_i \Delta V_i = \sum_{i \in s} b_i V_i.
\]
Dividing by $c > 0$ yields $\sum_{i \in o} M_i \le \frac{1}{c} \sum_{i \in s} b_i V_i$.
Splitting total traffic $\sum_{i \in s} M_i = \sum_{i \in o} M_i + \sum_{i \in s \setminus o} M_i \le 2 \sum_{i \in o} M_i + B \le \frac{2}{c} \sum_{i \in s} b_i V_i + B$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.AncestryFlow`):
```lean
theorem finite_flow_potential (s : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i) :
    (∑ i ∈ s, M i * (V i - ∑ j ∈ s, T i j * V j)) =
      ∑ i ∈ s, b i * V i

theorem finite_flow_absorption (s : Finset ι) (b M r : ι → ℝ)
    (T : ι → ι → ℝ)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hrow : ∀ i ∈ s, r i + ∑ j ∈ s, T i j = 1) :
    (∑ i ∈ s, M i * r i) = ∑ i ∈ s, b i

theorem finite_flow_drift_bound (s o : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ) (c : ℝ)
    (hos : o ⊆ s)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hM : ∀ i ∈ s, 0 ≤ M i)
    (hdelta : ∀ i ∈ s, 0 ≤ V i - ∑ j ∈ s, T i j * V j)
    (hodrift : ∀ i ∈ o, c ≤ V i - ∑ j ∈ s, T i j * V j) :
    c * (∑ i ∈ o, M i) ≤ ∑ i ∈ s, b i * V i

theorem finite_flow_traffic_bound (s o : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ) (c B : ℝ)
    (hos : o ⊆ s) (hc : 0 < c)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hM : ∀ i ∈ s, 0 ≤ M i)
    (hdelta : ∀ i ∈ s, 0 ≤ V i - ∑ j ∈ s, T i j * V j)
    (hodrift : ∀ i ∈ o, c ≤ V i - ∑ j ∈ s, T i j * V j)
    (hcomp : (∑ i ∈ s \ o, M i) ≤ (∑ i ∈ o, M i) + B) :
    (∑ i ∈ s, M i) ≤ 2 * (∑ i ∈ s, b i * V i) / c + B
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Discrete potential theory on networks (Doyle-Snell 1984, Lyons-Peres 2016). Foster-Lyapunov drift criteria for Markov chain ergodicity (Meyn-Tweedie 1993). Prior formalizations usually formalize infinite-state stochastic chains with probability kernels. The exact non-probabilistic algebraic identity $\langle M, (I-T)V \rangle = \langle b, V \rangle$ on arbitrary finite graphs and certified total traffic majorization are novel.
- **Advancement:** Machine-verifies discrete Green duality and explicit Foster-Lyapunov traffic bounds on arbitrary finite graphs.
- **Target Venues:** *Journal of Applied Probability* or *SIAM Journal on Discrete Mathematics*.
