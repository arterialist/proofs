# Continuous-to-Discrete Renewal Transfer via the Exact Exponential B-Spline Factor $4\sinh^2(t/2)/t^2$

**Date:** 19 September 2026
**Primary Source Documents:**
**Lean 4 Formalizations:** [`formalization/BuildingBlocks/IntegerBirthExponentialHats.lean`](../../formalization/BuildingBlocks/IntegerBirthExponentialHats.lean)
**Classification:** Renewal Theory / Integral Transforms / Sinc and Spline Theory
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

In the analytical study of integer renewal processes (such as the prime birth renewal equation and Poisson clock counters), one must pass between the continuous-time Laplace transform on $\mathbb{R}_+$ and the discrete generating function on $\mathbb{N}_0$. Standard approximations introduce error terms that destroy non-asymptotic bounds.

This note records that for any discrete sequence $c(j)$ on $\mathbb{N}_0$ satisfying the zero initial condition $c(0) = 0$, the continuous Laplace transform of its piecewise-linear continuous interpolant $\widetilde{c}(u)$ on $[0, \infty)$ is **identically equal** to the discrete Laplace transform multiplied by the exact hyperbolic sinc squared factor:
$$
\int_0^\infty e^{-tu} \widetilde{c}(u) \, du = \frac{4\sinh^2(t/2)}{t^2} \sum_{j=0}^\infty e^{-tj} c(j).
$$
Consequently, the continuous and discrete renewal operators are algebraically intertwined without any truncation error. We formalize this exact identity in Lean 4 and prove the complete-source defect formula connecting the continuous and discrete sources.

---

## 2. Affine Cell Integration and Left/Right Hat Functions

On the unit cell $[0, 1]$, define the left and right exponential hat integrals:
$$
\operatorname{leftHat}(t) = \frac{t - 1 + e^{-t}}{t^2} = \int_0^1 e^{-tv}(1 - v) \, dv,
$$
$$
\operatorname{rightHat}(t) = \frac{1 - (1 + t)e^{-t}}{t^2} = \int_0^1 e^{-tv} v \, dv.
$$
By linearity of integration:
$$
\int_0^1 e^{-tv} ((1 - v)c + v d) \, dv = \operatorname{leftHat}(t) c + \operatorname{rightHat}(t) d.
$$
On any integer cell $[j, j+1)$, the shifted coordinate $u = j + v$ factors the exponential kernel:
$$
e^{-tu} = e^{-tj} e^{-tv},
$$
giving the exact cell integral:
$$
\int_j^{j+1} e^{-tu} \widetilde{c}(u) \, du = e^{-tj} \left[ \operatorname{leftHat}(t) c(j) + \operatorname{rightHat}(t) c(j+1) \right].
$$

---

## 3. Geometric Summation and the B-Spline Factor

Summing over all integer cells $j \ge 0$:
$$
\int_0^\infty e^{-tu} \widetilde{c}(u) \, du = \sum_{j=0}^\infty e^{-tj} \operatorname{leftHat}(t) c(j) + \sum_{j=0}^\infty e^{-tj} \operatorname{rightHat}(t) c(j+1).
$$
Shifting the second sum via $j \to j+1$ and using $c(0) = 0$:
$$
\sum_{j=0}^\infty e^{-tj} c(j+1) = e^t \sum_{k=1}^\infty e^{-tk} c(k) = e^t \sum_{j=0}^\infty e^{-tj} c(j).
$$
Factoring out the discrete transform gives the exact scalar multiplier:
$$
\operatorname{leftHat}(t) + e^t \operatorname{rightHat}(t) = \frac{t - 1 + e^{-t}}{t^2} + \frac{e^t - 1 - t}{t^2} = \frac{e^t - 2 + e^{-t}}{t^2} = \frac{(e^{t/2} - e^{-t/2})^2}{t^2} = \frac{4\sinh^2(t/2)}{t^2}.
$$

---

## 4. Machine Verification and Axiom Audit

All identities in `IntegerBirthExponentialHats.lean` are compiled with Lean 4.24.0:
```lean
theorem integral_exp_affine {t : ℝ} (ht : 0 < t) (c d : ℝ) :
    (∫ v in (0 : ℝ)..1, Real.exp (-t*v)*((1-v)*c+v*d)) = leftHat t*c+rightHat t*d

theorem hat_factor {t : ℝ} (ht : 0 < t) :
    leftHat t+rightHat t/Real.exp (-t)=interpolationFactor t

theorem actual_birth_hat_identity {t : ℝ} (ht : 0 < t) (n : ℕ) :
    (∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      interpolationFactor t * ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j

theorem actual_all_birth_hat_identity {t : ℝ} (ht : 0 < t) :
    (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      interpolationFactor t * ∑' n : ℕ, ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j

theorem actual_all_birth_defect_identity {t : ℝ} (ht : 0 < t) :
    interpolationFactor t * (∑' n : ℕ, ∑' j : ℕ, Real.exp (-t*(j : ℝ))*sourceTerm n j) -
      (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceSource t n u) =
    ∑' n : ℕ, ∫ u in Ioi (0 : ℝ), Real.exp (-t*u)*ArithmeticFunction.vonMangoldt (n+2)*
      (interpolant (n+2) u-U (n+2) u)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 5. Scope and status

- **Repository role:** This is a reusable building block and formalization record; no priority claim is made.
