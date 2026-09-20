# Contribution 209: Exact Physical Continuous Arrival Kernel Near-Origin Hyperbolic Bound and Logarithmic Integral

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PhysicalContinuousArrival.lean`](../../formalization/BuildingBlocks/PhysicalContinuousArrival.lean), [`building-blocks/theta/physical-continuous-arrival.md`](../../building-blocks/theta/physical-continuous-arrival.md)  
**Classification:** Singular Integrals / Renewal Kernels / Analytic Number Theory / Continuous Arrival Generators / Logarithmic Singularity Control

---

## 1. Executive Summary and Mathematical Statement

The non-local continuous arrival operator in the physical theta scattering model is governed by the singular renewal kernel:
$$
K(s) = \frac{e^{-s/2}}{1 - e^{-2s}} \quad (s > 0).
$$
Because $1 - e^{-2s} \sim 2s$ as $s \to 0^+$, the kernel develops a non-integrable $1/s$ singularity at the origin. In non-asymptotic analysis, controlling truncated integrals $\int_d^1 K(s) ds$ requires proving an explicit rational lower bound on the denominator without asymptotic error terms, deducing an explicit hyperbolic majorant, and bounding the truncated mass by $-\frac{3}{2} \log d$.

This contribution proves:

1. **Exact Denominator Lower Bound:**  
   For all $s > 0$:
   $$
   1 - e^{-2s} \ge \frac{2s}{1 + 2s}.
   $$
2. **Sharp Near-Origin Rational and Hyperbolic Bounds:**  
   For all $s > 0$:
   $$
   K(s) \le e^{-s/2} \frac{1 + 2s}{2s},
   $$
   and for all $s \in (0, 1]$:
   $$
   K(s) \le \frac{3/2}{s}.
   $$
3. **Explicit Truncated Boundary Logarithmic Integral:**  
   For any cutoff $0 < d \le 1$:
   $$
   \int_d^1 \frac{3/2}{s} \, ds = -\frac{3}{2} \log d,
   $$
   yielding the explicit non-asymptotic mass bound:
   $$
   \int_d^1 K(s) \, ds \le -\frac{3}{2} \log d.
   $$
4. **Far-Field Exponential Decay and Integrability:**  
   For all $s \ge 1$:
   $$
   K(s) \le \frac{e^{-s/2}}{1 - e^{-2}},
   $$
   proving that $K$ is globally integrable on the exterior half-line $(1, \infty)$ (`kernel_far_integrable`).

---

## 2. Mathematical Proof

### 2.1. Denominator Inequality
By convexity of the exponential, $e^{2s} \ge 1 + 2s$ for all $s \in \mathbb{R}$.
Multiplying by $e^{-2s} > 0$:
$$
1 \ge (1 + 2s) e^{-2s} \implies e^{-2s} \le \frac{1}{1 + 2s}.
$$
Subtracting from 1:
$$
1 - e^{-2s} \ge 1 - \frac{1}{1 + 2s} = \frac{2s}{1 + 2s}.
$$

### 2.2. Hyperbolic Bound on $(0, 1]$
Dividing $e^{-s/2} \le 1$ by the lower bound on $1 - e^{-2s}$:
$$
K(s) \le \frac{1 + 2s}{2s} = \frac{1}{2s} + 1.
$$
For $s \in (0, 1]$, $1 \le \frac{1}{s}$, so:
$$
\frac{1}{2s} + 1 \le \frac{1}{2s} + \frac{1}{s} = \frac{3/2}{s}.
$$

### 2.3. Truncated Logarithmic Integral
For $0 < d \le 1$:
$$
\int_d^1 \frac{3/2}{s} \, ds = \frac{3}{2} [\log s]_d^1 = \frac{3}{2} (0 - \log d) = -\frac{3}{2} \log d.
$$
By monotonicity of the interval integral on $d \le 1$:
$$
\int_d^1 K(s) \, ds \le \int_d^1 \frac{3/2}{s} \, ds = -\frac{3}{2} \log d.
$$

### 2.4. Far-Field Bound
For $s \ge 1$, $-2s \le -2$, so $e^{-2s} \le e^{-2}$, giving $1 - e^{-2s} \ge 1 - e^{-2} > 0$.
Thus $K(s) \le \frac{e^{-s/2}}{1 - e^{-2}}$.
Since $\int_1^\infty e^{-s/2} ds = 2 e^{-1/2} < \infty$, $K$ is integrable on $(1, \infty)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PhysicalContinuousArrival` in `formalization/BuildingBlocks/PhysicalContinuousArrival.lean`):
```lean
theorem denominator_lower {s : ℝ} (hs : 0 < s) :
    2 * s / (1 + 2 * s) ≤ 1 - exp (-2 * s)

theorem kernel_rational_bound {s : ℝ} (hs : 0 < s) :
    kernel s ≤ exp (-s / 2) * ((1 + 2 * s) / (2 * s))

theorem kernel_near_bound {s : ℝ} (hs : 0 < s) (hsmall : s ≤ 1) :
    kernel s ≤ (3 / 2 : ℝ) / s

theorem truncated_boundary_majorant_integral {d : ℝ} (hd : 0 < d) :
    (∫ s : ℝ in d..1, (3 / 2 : ℝ) / s) = -(3 / 2 : ℝ) * log d

theorem truncated_kernel_integral_bound {d : ℝ} (hd : 0 < d) (hd1 : d ≤ 1) :
    (∫ s : ℝ in d..1, kernel s) ≤ -(3 / 2 : ℝ) * log d

theorem kernel_far_bound {s : ℝ} (hs : 1 ≤ s) :
    kernel s ≤ exp (-s / 2) / (1 - exp (-2))

theorem kernel_far_integrable : IntegrableOn kernel (Set.Ioi 1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Asymptotic analysis of singular renewal kernels with $1/s$ singularities (Feller 1971, Asmussen 2003). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the sharp explicit inequality $1 - e^{-2s} \ge \frac{2s}{1+2s}$, the uniform majorant $K(s) \le \frac{3/2}{s}$, and the exact logarithmic cutoff integral in Lean 4.
- **Target Venues:** *Integral Transforms and Special Functions* or *Journal of Mathematical Analysis and Applications*.
