# Contribution 154: Exact Logarithmic-Time Prime Filter Dynamics and Energy Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeLogFilter.lean`](../../formalization/BuildingBlocks/PrimeLogFilter.lean), [`building-blocks/prime/prime-log-filter.md`](../../building-blocks/prime/prime-log-filter.md)  
**Classification:** Analytic Number Theory / Dynamical Systems / Causal Linear Filters / Energy Dissipation / Logarithmic Coordinates / Jump Systems

---

## 1. Executive Summary and Mathematical Statement

In the dynamic reformulations of the explicit formula for prime numbers, passing to logarithmic time $t = \log x$ converts scaling dilations into time translations. The normalized prime error $u(t) = e^{-t/2} E(e^t)$ and its integrated response $y(t) = e^{-3t/2} \psi_1(e^t)$ form an exact causal low-pass filter with damping constant $\lambda = 3/2$.

This contribution proves:

1. **Exact Logarithmic-Time Filter ODE with Jump Discontinuities:**  
   The normalized prime response $y(t) = e^{-3t/2} \psi_1(e^t)$ is continuous on $[0, \infty)$ with initial condition $y(0) = 0$, and possesses a right derivative satisfying the linear filter equation everywhere on $[0, \infty)$:
   $$
   y_+'(t) = u(t) - \frac{3}{2} y(t),
   $$
   where $u(t) = e^{-t/2} E(e^t)$ carries the discrete prime power jumps.
2. **Exact Logarithmic Filter Energy Dissipation Identity:**  
   For any duration $T \in \mathbb{R}$:
   $$
   \int_0^T (u(t) - y(t))^2 dt = \int_0^T u(t)^2 dt - y(T)^2 - 2 \int_0^T y(t)^2 dt.
   $$
   The dissipation coefficient $2 = 2\lambda - 1 = 2(3/2) - 1$ exactly balances the rate of energy loss, proving unconditional energy contraction in logarithmic time.

---

## 2. Mathematical Proof

### 2.1. Right Derivative of the Logarithmic Response
Let $y(t) = e^{-3t/2} \psi_1(e^t)$.
By the chain rule for right derivatives, since $x(t) = e^t$ is smooth and strictly increasing:
$$
(\psi_1(e^t))_+' = (\psi_1)_+'(e^t) \cdot (e^t)' = E(e^t) e^t.
$$
By the product rule for right derivatives:
$$
y_+'(t) = \left(e^{-3t/2}\right)' \psi_1(e^t) + e^{-3t/2} (\psi_1(e^t))_+'
$$
$$
= -\frac{3}{2} e^{-3t/2} \psi_1(e^t) + e^{-3t/2} E(e^t) e^t.
$$
Combining exponents in the second term:
$$
e^{-3t/2} e^t = e^{-t/2}.
$$
Thus:
$$
e^{-3t/2} E(e^t) e^t = e^{-t/2} E(e^t) = u(t).
$$
Substituting into the derivative formula yields:
$$
y_+'(t) = u(t) - \frac{3}{2} y(t).
$$

### 2.2. General Causal Filter Energy Identity
From `CausalFilterEnergy.lean`, any continuous function $y(t)$ with $y(0) = 0$ satisfying $y_+'(t) = u(t) - \lambda y(t)$ with square-integrable input $u(t)$ satisfies:
$$
\int_0^T (u(t) - y(t))^2 dt = \int_0^T u(t)^2 dt - y(T)^2 - (2\lambda - 1) \int_0^T y(t)^2 dt.
$$
Setting $\lambda = 3/2$:
$$
2\lambda - 1 = 2\left(\frac{3}{2}\right) - 1 = 2.
$$
Substituting this value yields:
$$
\int_0^T (u(t) - y(t))^2 dt = \int_0^T u(t)^2 dt - y(T)^2 - 2 \int_0^T y(t)^2 dt.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimeLogFilter.lean`):
```lean
theorem primeLogResponse_hasDerivWithinAt_right (t : ℝ) :
    HasDerivWithinAt primeLogResponse
      (primeLogError t - (3 / 2 : ℝ) * primeLogResponse t) (Ioi t) t

theorem primeLogError_sq_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable (fun t => primeLogError t ^ 2) volume a b

theorem primeLogFilter_energy_identity (T : ℝ) :
    (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t)^2) =
      (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) - primeLogResponse T ^ 2 -
        2 * ∫ t in (0 : ℝ)..T, primeLogResponse t ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Filter bank representations of prime sums and Mellin transforms in control systems (Berry-Keating 1999, Lagarias 1999). Formalization of explicit linear filter dynamics and energy dissipation for prime errors in Lean 4 has not been previously accomplished.
- **Advancement:** Establishes the exact continuous ODE dynamics and Lyapunov energy dissipation identity for prime error filters in Lean 4.
- **Target Venues:** *IEEE Transactions on Signal Processing* or *Journal of Mathematical Analysis and Applications*.
