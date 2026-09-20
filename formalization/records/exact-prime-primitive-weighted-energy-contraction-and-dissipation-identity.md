# Contribution 149: Exact Prime Primitive Weighted Energy Contraction and Dissipation Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimePrimitiveContraction.lean`](../../formalization/BuildingBlocks/PrimePrimitiveContraction.lean), [`building-blocks/prime/prime-primitive-contraction.md`](../../building-blocks/prime/prime-primitive-contraction.md)  
**Classification:** Analytic Number Theory / Energy Methods / Prime Error Primitives / Integration by Parts / Strictly Dissipative Operators / Sobolev-Hardy Contractions

---

## 1. Executive Summary and Mathematical Statement

In the analytical study of the Chebyshev prime-counting error $E(t) = \psi(t) - t$ and its integrated first primitive $\psi_1(t) = \int_1^t E(u) du$, establishing that conditioned or mean-subtracted error profiles have strictly smaller $L^2$ energy than the unconditioned prime error is central to bounding bilinear auto-convolutions and sieves.

This contribution proves:

1. **Weighted Primitive Integration by Parts Identity:**  
   For any upper limit $T \ge 1$:
   $$
   \int_1^T \frac{2 \psi_1(t) E(t)}{t^3} dt = \frac{\psi_1(T)^2}{T^3} + 3 \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
   $$
2. **Exact Energy Dissipation Identity:**  
   The $t^{-2}$-weighted $L^2$ energy of the conditioned error $E(t) - \frac{\psi_1(t)}{t}$ equals the unconditioned prime-error energy minus non-negative boundary and interior dissipation terms:
   $$
   \int_1^T \frac{\left(E(t) - \frac{\psi_1(t)}{t}\right)^2}{t^2} dt = \int_1^T \frac{E(t)^2}{t^2} dt - \frac{\psi_1(T)^2}{T^3} - 2 \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
   $$
3. **Strict Prime Primitive Energy Contraction:**  
   For every $T \ge 1$:
   $$
   \int_1^T \frac{\left(E(t) - \frac{\psi_1(t)}{t}\right)^2}{t^2} dt \le \int_1^T \frac{E(t)^2}{t^2} dt,
   $$
   with equality holding if and only if $\psi_1 \equiv 0$.

---

## 2. Mathematical Proof

### 2.1. Right-Differentiable Integration by Parts
The primitive function $\psi_1(t) = \int_1^t E(u) du$ is continuous on $[1, T]$ and possesses a right derivative satisfying $(\psi_1)_+'(t) = E(t)$ everywhere on $[1, T)$.
Consequently, the squared function $\psi_1(t)^2$ is continuous with right derivative $2 \psi_1(t) E(t)$.
The weight function $v(t) = t^{-3}$ is $C^\infty$ on $[1, T]$ with derivative $v'(t) = -3 t^{-4}$.
Applying Lean 4's integration by parts for right-differentiable functions (`integral_smul_deriv_eq_deriv_smul_of_hasDeriv_right`):
$$
\int_1^T 2 \psi_1(t) E(t) t^{-3} dt = \left[ \psi_1(t)^2 t^{-3} \right]_1^T - \int_1^T \psi_1(t)^2 (-3 t^{-4}) dt.
$$
Since $\psi_1(1) = \int_1^1 E(u) du = 0$, the evaluation at $t = 1$ vanishes:
$$
\int_1^T \frac{2 \psi_1(t) E(t)}{t^3} dt = \frac{\psi_1(T)^2}{T^3} + 3 \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
$$

### 2.2. Algebraic Expansion and Dissipation
Expanding the quadratic integrand:
$$
\frac{\left(E(t) - \frac{\psi_1(t)}{t}\right)^2}{t^2} = \frac{E(t)^2}{t^2} - \frac{2 \psi_1(t) E(t)}{t^3} + \frac{\psi_1(t)^2}{t^4}.
$$
Integrating over $[1, T]$:
$$
\int_1^T \frac{\left(E(t) - \frac{\psi_1(t)}{t}\right)^2}{t^2} dt = \int_1^T \frac{E(t)^2}{t^2} dt - \int_1^T \frac{2 \psi_1(t) E(t)}{t^3} dt + \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
$$
Substituting the integration-by-parts identity into the cross term:
$$
-\int_1^T \frac{2 \psi_1(t) E(t)}{t^3} dt = -\frac{\psi_1(T)^2}{T^3} - 3 \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
$$
Combining with the final term $+ \int_1^T \frac{\psi_1(t)^2}{t^4} dt$:
$$
-3 \int_1^T \frac{\psi_1(t)^2}{t^4} dt + \int_1^T \frac{\psi_1(t)^2}{t^4} dt = -2 \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
$$
This proves the exact dissipation identity:
$$
\int_1^T \frac{\left(E(t) - \frac{\psi_1(t)}{t}\right)^2}{t^2} dt = \int_1^T \frac{E(t)^2}{t^2} dt - \frac{\psi_1(T)^2}{T^3} - 2 \int_1^T \frac{\psi_1(t)^2}{t^4} dt.
$$

### 2.3. Contraction Inequality
Since $T \ge 1 > 0$, $\psi_1(T)^2 / T^3 \ge 0$ and $2 \int_1^T \psi_1(t)^2/t^4 dt \ge 0$.
Subtracting two non-negative quantities from $\int_1^T E(t)^2/t^2 dt$ immediately yields:
$$
\int_1^T \frac{\left(E(t) - \frac{\psi_1(t)}{t}\right)^2}{t^2} dt \le \int_1^T \frac{E(t)^2}{t^2} dt.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimePrimitiveContraction.lean`):
```lean
theorem coarsePrefix_square_weighted_parts {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, 2 * coarsePrefix 1 t * primeErrorReal t / t^3) =
      coarsePrefix 1 T ^ 2 / T^3 +
        3 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t ^ 2 / t^4

theorem primePrimitive_weighted_contraction_identity {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, (primeErrorReal t - coarsePrefix 1 t / t)^2 / t^2) =
      (∫ t in (1 : ℝ)..T, primeErrorReal t ^ 2 / t^2) -
        coarsePrefix 1 T ^ 2 / T^3 -
          2 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t ^ 2 / t^4

theorem primePrimitive_weighted_contraction {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, (primeErrorReal t - coarsePrefix 1 t / t)^2 / t^2) ≤
      ∫ t in (1 : ℝ)..T, primeErrorReal t ^ 2 / t^2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hardy-Littlewood weighted integral inequalities, Sobolev contraction principles, and Chebyshev prime error bounds. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves the exact energy dissipation identity and contraction theorem for prime error primitives in Lean 4.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Proceedings of the American Mathematical Society*.
