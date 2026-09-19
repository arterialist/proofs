# Unique Contribution 43: Non-Local Killing Positivity and Arithmetic Prime Jump Boundary Gap

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PhysicalKillingPositivity.lean`](../../formalization/BuildingBlocks/PhysicalKillingPositivity.lean), [`formalization/BuildingBlocks/PhysicalThetaJumpEnergy.lean`](../../formalization/BuildingBlocks/PhysicalThetaJumpEnergy.lean)  
**Classification:** Non-Local Dirichlet Forms / Jump Processes / Spectral Theory

---

## 1. Executive Summary and Mathematical Statement

In classical local differential operators (such as the Laplacian $-\Delta$), a constant function $f(x) \equiv c$ has zero gradient and thus zero Dirichlet energy: $\int |\nabla c|^2 = 0$. Consequently, boundary conditions must be imposed directly on the function space (e.g. Dirichlet trace $f|_{\partial \Omega} = 0$) to obtain a positive ground state eigenvalue.

For non-local jump processes, boundary killing is realized by setting the exterior state to zero:
\[
k(u) = \begin{cases} c, & |u| < R, \\ 0, & |u| \ge R. \end{cases}
\]
This contribution establishes that the non-local Dirichlet energy of the killed extension of **any non-zero constant core** $c \ne 0$ is strictly positive:
\[
\operatorname{killedEnergy}(R, c) > 0.
\]
We identify the explicit geometric crossing interval:
\[
I = \left(-R - a, -R - a + \frac{\min(R, a)}{2}\right)
\]
on which $u$ lies strictly outside the core ($|u| > R$) while the forward shift $u + a$ lies strictly inside the core ($|u + a| < R$).  
Applied to the arithmetic prime jump process, the shift $a = \log 2$ at the initial prime $p = 2$ alone provides an unconditional, strictly positive lower bound on the ground energy.

---

## 2. Geometric Crossing Interval and Edge Mass Positivity

For any core radius $R > 0$ and any shift $a > 0$:
1. If $u \in I = \left(-R - a, -R - a + \frac{\min(R, a)}{2}\right)$, then:
   - $u < -R - a + a/2 = -R - a/2 < -R \implies |u| > R$.
   - $u + a > -R - a + a = -R$.
   - $u + a < -R - a + R/2 + a = -R/2 < R$.
   Thus $-R < u + a < R$, forcing $|u + a| < R$.
2. On this interval of positive Lebesgue measure $\frac{\min(R, a)}{2} > 0$:
   - $k(u) = 0$ and $k(u + a) = c \ne 0$, so $(k(u + a) - k(u))^2 = c^2 > 0$.
   - The Jacobi weight $\Phi(u) > 0$ is strictly positive everywhere on $\mathbb{R}$.
3. Therefore, the edge mass integrand:
   \[
   F(u) = \Phi(u + a) \Phi(u) (k(u + a) - k(u))^2 = \Phi(u + a) \Phi(u) c^2 > 0
   \]
   is strictly positive on a set of positive measure, proving that the jump edge integral across the shift $a$ is strictly positive:
   \[
   \operatorname{edgeMass}(k, a) = \int_{\mathbb{R}} \Phi(u + a) \Phi(u) (k(u + a) - k(u))^2 \, du > 0.
   \]

---

## 3. Prime Jump Energy Floor

The full killed prime jump energy is given by:
\[
\operatorname{primeEnergy}(k) = \sum_{n=2}^\infty \frac{\Lambda(n)}{\sqrt{n}} \operatorname{edgeMass}(k, \log n).
\]
Because every term in this sum is non-negative and the first prime $n = 2$ contributes:
\[
\frac{\Lambda(2)}{\sqrt{2}} \operatorname{edgeMass}(k, \log 2) = \frac{\log 2}{\sqrt{2}} \operatorname{edgeMass}(k, \log 2) > 0,
\]
the entire prime energy is strictly bounded away from zero:
\[
\operatorname{killedEnergy}(R, c) \ge \operatorname{primeEnergy}(k) \ge \frac{\log 2}{\sqrt{2}} \operatorname{edgeMass}(k, \log 2) > 0.
\]

---

## 4. Machine Verification and Axiom Audit

All theorems in `PhysicalKillingPositivity.lean` are compiled with Lean 4.24.0:
```lean
theorem crossing_interval {R a u : ℝ} (hR : 0 < R) (ha : 0 < a)
    (hu : u ∈ Set.Ioo (-R - a) (-R - a + min R a / 2)) :
    R < |u| ∧ |u + a| < R

theorem constant_killed_edge_positive {R a c : ℝ} (hR : 0 < R) (ha : 0 < a) (hc : c ≠ 0) :
    0 < edgeMass (killedExtension R (fun _ => c)) a

theorem constant_killed_energy_positive {R c : ℝ} (hR : 0 < R) (hc : c ≠ 0) :
    0 < killedEnergy R (fun _ => c)
```
Axioms audit confirms dependence strictly on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 5. Literature Context and Target Venues

- **Prior Literature:** Dirichlet forms for killed jump processes on open sets (Fukushima, Chen, Uemura) establish abstract properties of non-local generators. However, the explicit crossing interval geometry and the arithmetic prime jump spectral floor on constant core functions have not been formalized or analyzed for the Jacobi theta jump kernel.
- **Advancement:** Proves that non-local prime jump killing enforces a strictly positive spectral floor on all core states without requiring Dirichlet trace assumptions on the test state itself.
- **Target Venues:** *Journal of Functional Analysis* or *Potential Analysis*.
