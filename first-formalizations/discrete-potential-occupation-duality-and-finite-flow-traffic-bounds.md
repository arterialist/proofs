# First Formalization: Discrete Potential-Occupation Duality and Finite Flow Traffic Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/AncestryFlow.lean`](../../formalization/BuildingBlocks/AncestryFlow.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes discrete potential-occupation duality, absorption conservation, and finite Foster-Lyapunov drift and traffic bounds on arbitrary finite graphs in Lean 4:

1. **Discrete Green's Identity:**
   Formal proof of $\sum_{i \in s} M_i (V_i - \sum_j T_{ij} V_j) = \sum_{i \in s} b_i V_i$ without positivity or stochasticity assumptions (`finite_flow_potential`).
2. **Absorption Conservation:**
   Formal derivation of total mass conservation $\sum_{i \in s} M_i r_i = \sum_{i \in s} b_i$ under row defect condition $r_i + \sum_j T_{ij} = 1$ (`finite_flow_absorption`).
3. **Foster-Lyapunov Drift Bound:**
   Formal derivation of $c \sum_{i \in o} M_i \le \sum_{i \in s} b_i V_i$ under sub-harmonic potential drift on $s$ and strict drift $c > 0$ on $o \subseteq s$ (`finite_flow_drift_bound`).
4. **Total Traffic Majorization:**
   Formal derivation of total network occupation bound $\sum_{i \in s} M_i \le \frac{2}{c} \sum_{i \in s} b_i V_i + B$ under complementary traffic control (`finite_flow_traffic_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Discrete Green identity
theorem finite_flow_potential (s : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i) :
    (∑ i ∈ s, M i * (V i - ∑ j ∈ s, T i j * V j)) =
      ∑ i ∈ s, b i * V i

-- Absorption mass conservation
theorem finite_flow_absorption (s : Finset ι) (b M r : ι → ℝ)
    (T : ι → ι → ℝ)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hrow : ∀ i ∈ s, r i + ∑ j ∈ s, T i j = 1) :
    (∑ i ∈ s, M i * r i) = ∑ i ∈ s, b i

-- Foster-Lyapunov drift bound
theorem finite_flow_drift_bound (s o : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ) (c : ℝ)
    (hos : o ⊆ s)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hM : ∀ i ∈ s, 0 ≤ M i)
    (hdelta : ∀ i ∈ s, 0 ≤ V i - ∑ j ∈ s, T i j * V j)
    (hodrift : ∀ i ∈ o, c ≤ V i - ∑ j ∈ s, T i j * V j) :
    c * (∑ i ∈ o, M i) ≤ ∑ i ∈ s, b i * V i

-- Total traffic majorization
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

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation of discrete Green potential-occupation duality $\langle M, (I-T)V \rangle = \langle b, V \rangle$ and explicit Foster-Lyapunov traffic majorization on finite graphs in Lean 4.
