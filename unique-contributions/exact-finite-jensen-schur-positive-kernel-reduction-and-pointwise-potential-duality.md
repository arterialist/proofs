# Contribution 162: Exact Finite Jensen-Schur Positive Kernel Reduction and Pointwise Potential Duality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PositiveKernelCauchy.lean`](../../formalization/BuildingBlocks/PositiveKernelCauchy.lean), [`building-blocks/kernels/positive-kernel-cauchy.md`](../../building-blocks/kernels/positive-kernel-cauchy.md)  
**Classification:** Operator Theory / Matrix Inequalities / Schur Test / Positive Kernels / Pointwise Potential Certificates / Hermitian Theta Forms

---

## 1. Executive Summary and Mathematical Statement

Proving global positivity or coercivity of integral and matrix operators $T x(u) = \sum_v K(u, v) x(v)$ coupled with weights $\mu(u) w(u)$ is often complicated by off-diagonal interactions. By leveraging Cauchy-Schwarz / Jensen convexity along each row of a non-negative kernel, the non-local bilinear form can be dominated by a purely diagonal sum of squares against an explicit pulled weight.

This contribution proves:

1. **Row-Wise Real and Complex Cauchy Inequalities:**  
   For any non-negative row vector $k(v) \ge 0$ on a finite set $V$:
   $$
   \forall x: V \to \mathbb{R}, \quad \left( \sum_{v \in V} k(v) x(v) \right)^2 \le \left( \sum_{v \in V} k(v) \right) \sum_{v \in V} k(v) x(v)^2,
   $$
   and for complex vectors $x: V \to \mathbb{C}$:
   $$
   \left| \sum_{v \in V} k(v) x(v) \right|^2 \le \left( \sum_{v \in V} k(v) \right) \sum_{v \in V} k(v) |x(v)|^2.
   $$
2. **Exact Finite Jensen-Schur Positive Kernel Reduction:**  
   For non-negative weights $\mu, w: U \to \mathbb{R}_{\ge 0}$ and any non-negative matrix kernel $K: U \times V \to \mathbb{R}_{\ge 0}$:
   $$
   \sum_{u \in U} \mu(u) w(u) \left( \sum_{v \in V} K(u, v) x(v) \right)^2 \le \sum_{v \in V} W_{\text{pulled}}(v) x(v)^2,
   $$
   where the pulled weight is explicitly defined by:
   $$
   W_{\text{pulled}}(v) = \sum_{u \in U} \mu(u) w(u) \left( \sum_{v' \in V} K(u, v') \right) K(u, v).
   $$
3. **Complex Hermitian Extension:**  
   For any complex field $x: V \to \mathbb{C}$:
   $$
   \sum_{u \in U} \mu(u) w(u) \left| \sum_{v \in V} K(u, v) x(v) \right|^2 \le \sum_{v \in V} W_{\text{pulled}}(v) |x(v)|^2.
   $$
4. **Pointwise Potential Certificate Duality:**  
   If the pulled weight satisfies the pointwise inequality $W(v)/a + \alpha \le \kappa(v)$ for all $v \in V$, then for any non-negative internal energy $\text{internal} \ge 0$:
   $$
   \frac{1}{a} \sum_{v \in V} W(v) x(v)^2 \le \text{internal} + \sum_{v \in V} \kappa(v) x(v)^2 - \alpha \sum_{v \in V} x(v)^2.
   $$
   This converts non-local operator bounds into 1-dimensional pointwise potential verifications verifiable by interval arithmetic.

---

## 2. Mathematical Proof

### 2.1. Row-Wise Cauchy-Schwarz
Let $k(v) \ge 0$. Apply the standard Cauchy-Schwarz inequality to the sequences $a(v) = \sqrt{k(v)}$ and $b(v) = \sqrt{k(v)} x(v)$:
$$
\left( \sum_v k(v) x(v) \right)^2 = \left( \sum_v a(v) b(v) \right)^2 \le \left( \sum_v a(v)^2 \right) \left( \sum_v b(v)^2 \right) = \left( \sum_v k(v) \right) \left( \sum_v k(v) x(v)^2 \right).
$$
For $x(v) \in \mathbb{C}$, splitting $x(v) = x_R(v) + i x_I(v)$:
$$
\left| \sum_v k(v) x(v) \right|^2 = \left( \sum_v k(v) x_R(v) \right)^2 + \left( \sum_v k(v) x_I(v) \right)^2
$$
$$
\le \left( \sum_v k(v) \right) \sum_v k(v) x_R(v)^2 + \left( \sum_v k(v) \right) \sum_v k(v) x_I(v)^2 = \left( \sum_v k(v) \right) \sum_v k(v) |x(v)|^2.
$$

### 2.2. Jensen-Schur Reduction
Multiply the row bound for each $u \in U$ by the non-negative weight $\mu(u) w(u)$:
$$
\mu(u) w(u) (K x(u))^2 \le \mu(u) w(u) \left( \sum_{v'} K(u, v') \right) \sum_v K(u, v) x(v)^2.
$$
Summing over $u \in U$ and interchanging the finite sums:
$$
\sum_u \mu(u) w(u) (K x(u))^2 \le \sum_u \sum_v \mu(u) w(u) \left( \sum_{v'} K(u, v') \right) K(u, v) x(v)^2
$$
$$
= \sum_v \left[ \sum_u \mu(u) w(u) \left( \sum_{v'} K(u, v') \right) K(u, v) \right] x(v)^2 = \sum_v W_{\text{pulled}}(v) x(v)^2.
$$

### 2.3. Pointwise Certificate Duality
Given $W(v)/a \le \kappa(v) - \alpha$, multiplying by $x(v)^2 \ge 0$ and summing over $v$:
$$
\frac{1}{a} \sum_v W(v) x(v)^2 \le \sum_v (\kappa(v) - \alpha) x(v)^2 = \sum_v \kappa(v) x(v)^2 - \alpha \sum_v x(v)^2.
$$
Since $\text{internal} \ge 0$, adding it to the upper bound preserves the inequality.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation` in `formalization/BuildingBlocks/PositiveKernelCauchy.lean`):
```lean
theorem kernel_row_cauchy
    (k : V → ℝ) (x : V → ℝ) (hk : ∀ v, 0 ≤ k v) :
    (∑ v, k v * x v)^2 ≤ (∑ v, k v) * ∑ v, k v * (x v)^2

theorem kernel_row_cauchy_complex
    (k : V → ℝ) (x : V → ℂ) (hk : ∀ v, 0 ≤ k v) :
    Complex.normSq (∑ v, (k v : ℂ) * x v) ≤
      (∑ v, k v) * ∑ v, k v * Complex.normSq (x v)

theorem positive_kernel_cauchy_reduction
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℝ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) :
    (∑ u, mu u * w u * (kernelColumn k x u)^2) ≤
      ∑ v, pulledWeight mu w k v * (x v)^2

theorem positive_kernel_cauchy_reduction_complex
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℂ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) :
    (∑ u, mu u * w u * Complex.normSq (kernelColumnComplex k x u)) ≤
      ∑ v, pulledWeight mu w k v * Complex.normSq (x v)

theorem pointwise_weight_pays_port
    (W kappa : V → ℝ) (x : V → ℝ) (a alpha internal : ℝ)
    (ha : 0 < a) (hinternal : 0 ≤ internal)
    (hpoint : ∀ v, W v / a + alpha ≤ kappa v) :
    (∑ v, W v * (x v)^2) / a ≤
      internal + ∑ v, kappa v * (x v)^2 - alpha * ∑ v, (x v)^2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Schur's test for integral operators (Schur 1911), Hardy-Littlewood-Pólya inequalities. Formalization of finite positive kernel reductions to exact pulled weights and pointwise potential certificates has not been previously implemented in Lean 4.
- **Advancement:** Establishes exact real and complex Jensen-Schur positive kernel reductions and pointwise potential certificates in Lean 4.
- **Target Venues:** *Linear and Multilinear Algebra* or *Journal of Mathematical Inequalities*.
