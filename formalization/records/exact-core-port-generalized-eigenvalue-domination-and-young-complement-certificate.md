# Contribution 264: Exact Core-Port Generalized Eigenvalue Domination and Young Complement Certificate

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CorePortGeneralizedEigen.lean`](../../formalization/BuildingBlocks/CorePortGeneralizedEigen.lean), [`building-blocks/spectral/core-port-generalized-eigen.md`](../../building-blocks/spectral/core-port-generalized-eigen.md)  
**Classification:** Functional Analysis / Spectral Theory / Quadratic Forms / Generalized Rayleigh Quotients / Young's Inequality / Certified Inequalities / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In boundary port Hamiltonian and energy compensation architectures, establishing that an internal core supply form dominates an external boundary port form $\text{port}(x) \le \text{supply}(x)$ on a constrained subspace requires passing between finite compression coordinate representations, certified interval enclosures, and block decompositions.

This contribution proves:

1. **Generalized Rayleigh Quotient Equivalence:**  
   When $\text{supply} > 0$, the generalized Rayleigh quotient satisfies:
   $$
   \frac{\text{port}}{\text{supply}} \le 1 \iff \text{port} \le \text{supply}.
   $$
2. **Generalized Eigenvalue Domination Certificate:**  
   If $\text{port}(Z c) \le \lambda \cdot \text{supply}(Z c)$ for all coordinates $c \in W$ with $\text{supply}(Z c) \ge 0$, and the certified generalized spectral radius satisfies $\lambda \le 1$, then:
   $$
   \text{port}(Z c) \le \text{supply}(Z c) \quad \text{for all } c \in W.
   $$
3. **Certified Counterexample Witness:**  
   A single rigorous coordinate $c \in W$ satisfying $\text{supply}(Z c) < \text{port}(Z c)$ constitutes an unconditional refutation of non-negativity for the compressed difference form:
   $$
   \neg (\forall d \in W, \, 0 \le \text{supply}(Z d) - \text{port}(Z d)).
   $$
4. **Interval-Enclosure Coordinate Certificate:**  
   Given certified bounds $\text{supplyLo} \le \text{supply}$ and $\text{port} \le \text{portHi}$, if $\text{portHi} \le \text{supplyLo}$, then $\text{port} \le \text{supply}$.
5. **Exact Trial-Complement Young Margin Certificate:**  
   For any block decomposition into a trial subspace of dimension $k$ and complement tail subspace, with certified trial margin $a$, complement margin $d$, and mixed cross-term coupling bound $b$:
   $$
   \text{total} \ge a \|\text{trial}\|^2 + d \|\text{tail}\|^2 - 2 b \|\text{trial}\| \|\text{tail}\|.
   $$
   For any parameter $\epsilon > 0$, by weighted Young's inequality $2 b \|\text{trial}\| \|\text{tail}\| \le \epsilon \|\text{trial}\|^2 + \frac{b^2}{\epsilon} \|\text{tail}\|^2$. Consequently, if $a \ge \epsilon$ and $d \ge b^2 / \epsilon$, then unconditionally:
   $$
   \text{total} \ge (a - \epsilon) \|\text{trial}\|^2 + \left(d - \frac{b^2}{\epsilon}\right) \|\text{tail}\|^2 \ge 0.
   $$

---

## 2. Mathematical Proof

### 2.1. Rayleigh Quotient and Compression Equivalence
For $\text{supply} > 0$, multiplying the inequality $\frac{\text{port}}{\text{supply}} \le 1$ by $\text{supply}$ preserves orientation and gives $\text{port} \le \text{supply}$.
If $\text{port}(Z c) \le \lambda \cdot \text{supply}(Z c)$ and $\lambda \le 1$, since $\text{supply}(Z c) \ge 0$, we have $\lambda \cdot \text{supply}(Z c) \le 1 \cdot \text{supply}(Z c) = \text{supply}(Z c)$.

### 2.2. Trial-Complement Young Margin
Let $X = \sqrt{\epsilon} \|\text{trial}\|$ and $Y = \frac{b}{\sqrt{\epsilon}} \|\text{tail}\|$.
By the classical algebraic inequality $2 X Y \le X^2 + Y^2$:
$$
2 b \|\text{trial}\| \|\text{tail}\| = 2 (\sqrt{\epsilon} \|\text{trial}\|) \left( \frac{b}{\sqrt{\epsilon}} \|\text{tail}\| \right) \le \epsilon \|\text{trial}\|^2 + \frac{b^2}{\epsilon} \|\text{tail}\|^2.
$$
Subtracting this upper bound from the lower bound on $\text{total}$:
$$
\text{total} \ge a \|\text{trial}\|^2 + d \|\text{tail}\|^2 - \left( \epsilon \|\text{trial}\|^2 + \frac{b^2}{\epsilon} \|\text{tail}\|^2 \right) = (a - \epsilon) \|\text{trial}\|^2 + \left( d - \frac{b^2}{\epsilon} \right) \|\text{tail}\|^2.
$$
Since $a - \epsilon \ge 0$ and $d - b^2/\epsilon \ge 0$, both terms are non-negative, proving $\text{total} \ge 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation` in `formalization/BuildingBlocks/CorePortGeneralizedEigen.lean`):
```lean
theorem generalizedRayleigh_le_one_iff
    {supply port : ℝ} (hs : 0 < supply) :
    port / supply ≤ 1 ↔ port ≤ supply

theorem generalizedEigenvalue_certificate
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) (lambda : ℝ)
    (hs : ∀ c, 0 ≤ supply (Z c))
    (hp : ∀ c, port (Z c) ≤ lambda * supply (Z c))
    (hlambda : lambda ≤ 1) :
    ∀ c, port (Z c) ≤ supply (Z c)

theorem compressed_failure_witness
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) (c : W)
    (h : supply (Z c) < port (Z c)) :
    ¬ (∀ d, 0 ≤ compressedForm supply Z d - compressedForm port Z d)

theorem interval_coordinate_certificate
    {supply port supplyLo portHi : ℝ}
    (hs : supplyLo ≤ supply) (hp : port ≤ portHi) (hbox : portHi ≤ supplyLo) :
    port ≤ supply

theorem trial_complement_young_certificate
    {trialSq tailSq total : ℝ} {a b d eps : ℝ}
    (ht : 0 ≤ trialSq) (hh : 0 ≤ tailSq)
    (heps : 0 < eps)
    (htotal : total ≥ a * trialSq + d * tailSq - 2 * b * Real.sqrt trialSq * Real.sqrt tailSq)
    (ha : 0 ≤ a - eps)
    (hd : 0 ≤ d - b^2 / eps) :
    0 ≤ total
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Rayleigh-Ritz methods, generalized eigenvalues, and Young's inequality for operators (Bhatia 1997, Strang 2006). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Bridges rigorous interval arithmetic calculations directly to verified operator domination in formal proof assistants.
- **Target Venues:** *Numerical Linear Algebra with Applications* or *SIAM Journal on Matrix Analysis and Applications*.
