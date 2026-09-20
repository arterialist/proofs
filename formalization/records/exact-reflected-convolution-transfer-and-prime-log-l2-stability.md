# Contribution 174: Exact Reflected Convolution Transfer and Prime Log L2 Stability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeLogConvolutionTransfer.lean`](../../formalization/BuildingBlocks/PrimeLogConvolutionTransfer.lean), [`building-blocks/primes/prime-log-convolution-transfer.md`](../../building-blocks/primes/prime-log-convolution-transfer.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Convolution Operators / Cauchy-Schwarz Transfer / Prime Error Stability / L2 Bounds

---

## 1. Executive Summary and Mathematical Statement

In the spectral and scattering analysis of the Riemann zeta function, evaluating bilinear forms and reflected convolutions $(f \star g)(T) = \int_0^T f(t) g(T-t) \, dt$ involving discontinuous arithmetic inputs requires establishing local $L^2$ regularity and quadratic transfer stability against smooth approximants.

This contribution proves:

1. **Measurability of Logarithmic Prime Error and Filtered Response:**  
   The normalized logarithmic prime error $t \mapsto e^{-t/2}(\psi(e^t) - e^t)$ and its filtered residual $t \mapsto e^{-t/2}(\psi(e^t) - e^t) - \text{response}(t)$ are Borel measurable both over $\mathbb{R}$ and $\mathbb{C}$.
2. **Local $L^2$ Integrability of Jump Discontinuities:**  
   For any interval $(u, v] \subset \mathbb{R}$, the complexified logarithmic prime error, the continuous response function, and their difference belong unconditionally to $L^2((u, v], dt)$.
3. **Exact Reflected Convolution Transfer Bound:**  
   For any $T \ge 0$ and any measurable test functions $p, q \in L^2((0, T])$:
   $$
   \left\| \int_0^T \text{primeLogError}(t) (\text{primeLogError}(T-t) - \text{primeLogResponse}(T-t)) \, dt - \int_0^T p(t) q(T-t) \, dt \right\|
   $$
   $$
   \le \| \text{primeLogError} - p \|_{L^2(0, T)} \| \text{primeLogError} - \text{primeLogResponse} \|_{L^2(0, T)} + \| p \|_{L^2(0, T)} \| (\text{primeLogError} - \text{primeLogResponse}) - q \|_{L^2(0, T)}.
   $$
   This theorem discharges every measurability and $L^2$ obligation of the jumpy arithmetic prime error, enabling rigorous transfer of spectral identities to numerical and smooth approximants.

---

## 2. Mathematical Proof

### 2.1. Measurability
The function $\psi(x)$ is piecewise constant with jump discontinuities at prime powers $p^k$.
Since piecewise constant functions on $\mathbb{R}^+$ are Borel measurable, composing with the continuous diffeomorphism $t \mapsto e^t$ preserves measurability. Multiplying by the continuous exponential factor $e^{-t/2}$ ensures that $\text{primeLogError}(t) = e^{-t/2}(\psi(e^t) - e^t)$ is Borel measurable.

### 2.2. Local Square Integrability
On any bounded interval $[u, v]$, the step function $\psi(e^t)$ has finitely many jumps.
Its square is bounded by $\sup_{t \in [u, v]} e^{-t}(\psi(e^t) - e^t)^2 \le C(u, v) < \infty$.
Hence the integral $\int_u^v |\text{primeLogError}(t)|^2 \, dt$ is finite.
Similarly, $\text{primeLogResponse}(t)$ is continuous on $\mathbb{R}$, so its square is continuous and integrable on $[u, v]$.
By Minkowski's inequality, the difference belongs to $L^2((u, v])$.

### 2.3. Reflected Convolution Transfer
Let $f(t) = \text{primeLogError}(t)$ and $g(t) = \text{primeLogError}(t) - \text{primeLogResponse}(t)$.
Writing the algebraic difference of convolutions:
$$
\int_0^T f(t) g(T-t) \, dt - \int_0^T p(t) q(T-t) \, dt = \int_0^T (f(t) - p(t)) g(T-t) \, dt + \int_0^T p(t) (g(T-t) - q(T-t)) \, dt.
$$
Applying the Cauchy-Schwarz inequality to each term:
$$
\left\| \int_0^T (f(t) - p(t)) g(T-t) \, dt \right\| \le \left( \int_0^T \|f(t) - p(t)\|^2 \, dt \right)^{1/2} \left( \int_0^T \|g(T-t)\|^2 \, dt \right)^{1/2}.
$$
Using the change of variables $u = T - t$, the reflection preserves the $L^2$ norm:
$$
\int_0^T \|g(T-t)\|^2 \, dt = \int_0^T \|g(u)\|^2 \, du.
$$
Applying Cauchy-Schwarz to the second term and using Minkowski's triangle inequality completes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimeLogConvolutionTransfer.lean`):
```lean
theorem primeLogError_measurable : Measurable primeLogError

theorem primeLogError_complex_memLp_two (u v : ℝ) :
    MemLp (fun t => (primeLogError t : ℂ)) 2 (volume.restrict (Ioc u v))

theorem primeLogResponse_complex_memLp_two (u v : ℝ) :
    MemLp (fun t => (primeLogResponse t : ℂ)) 2 (volume.restrict (Ioc u v))

theorem primeLogFilteredError_complex_memLp_two (u v : ℝ) :
    MemLp (fun t => ((primeLogError t - primeLogResponse t : ℝ) : ℂ)) 2
      (volume.restrict (Ioc u v))

theorem primeLog_reflected_convolution_transfer {T : ℝ} (hT : 0 ≤ T)
    {p q : ℝ → ℂ} (hqmeas : Measurable q)
    (hp : MemLp p 2 (volume.restrict (Ioc 0 T)))
    (hq : MemLp q 2 (volume.restrict (Ioc 0 T))) :
    ‖(∫ t in (0 : ℝ)..T,
        (primeLogError t : ℂ) *
          ((primeLogError (T - t) - primeLogResponse (T - t) : ℝ) : ℂ)) -
        (∫ t in (0 : ℝ)..T, p t * q (T - t))‖ ≤
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖(primeLogError t : ℂ) - p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t) ^ 2) +
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T,
          ‖((primeLogError t - primeLogResponse t : ℝ) : ℂ) - q t‖ ^ 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Bilinear convolution estimates in signal processing and spectral theory (Hörmander 1983, Katznelson 2004). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Completely discharges all measurability and $L^2$ obligations for reflected convolutions of logarithmic Chebyshev prime errors in Lean 4.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Constructive Approximation*.
