# First Formalization: Exact Physical Continuous Arrival Kernel Near-Origin Hyperbolic Bound and Logarithmic Integral

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PhysicalContinuousArrival.lean`](../../formalization/BuildingBlocks/PhysicalContinuousArrival.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-asymptotic bounds and logarithmic cutoff estimates for the physical continuous arrival kernel $K(s) = \frac{e^{-s/2}}{1 - e^{-2s}}$ in Lean 4:

1. **Denominator Lower Bound:**
   Formal proof that $1 - e^{-2s} \ge \frac{2s}{1+2s}$ for all $s > 0$ (`denominator_lower`).
2. **Rational and Near-Origin Hyperbolic Bounds:**
   Formal proof of $K(s) \le e^{-s/2}\frac{1+2s}{2s}$ (`kernel_rational_bound`) and $K(s) \le \frac{3/2}{s}$ on $(0, 1]$ (`kernel_near_bound`).
3. **Exact Truncated Logarithmic Integral:**
   Formal proof that $\int_d^1 \frac{3/2}{s} ds = -\frac{3}{2}\log d$ (`truncated_boundary_majorant_integral`) and $\int_d^1 K(s) ds \le -\frac{3}{2}\log d$ (`truncated_kernel_integral_bound`).
4. **Far-Field Exponential Decay and Integrability:**
   Formal proofs of $K(s) \le \frac{e^{-s/2}}{1-e^{-2}}$ on $[1, \infty)$ (`kernel_far_bound`) and global integrability on $(1, \infty)$ (`kernel_far_integrable`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Rational lower bound for exponential denominator
theorem denominator_lower {s : ℝ} (hs : 0 < s) :
    2 * s / (1 + 2 * s) ≤ 1 - exp (-2 * s)

-- Near-origin rational bound
theorem kernel_rational_bound {s : ℝ} (hs : 0 < s) :
    kernel s ≤ exp (-s / 2) * ((1 + 2 * s) / (2 * s))

-- Near-origin hyperbolic bound
theorem kernel_near_bound {s : ℝ} (hs : 0 < s) (hsmall : s ≤ 1) :
    kernel s ≤ (3 / 2 : ℝ) / s

-- Exact integral of hyperbolic majorant
theorem truncated_boundary_majorant_integral {d : ℝ} (hd : 0 < d) :
    (∫ s : ℝ in d..1, (3 / 2 : ℝ) / s) = -(3 / 2 : ℝ) * log d

-- Exact non-asymptotic bound on truncated kernel integral
theorem truncated_kernel_integral_bound {d : ℝ} (hd : 0 < d) (hd1 : d ≤ 1) :
    (∫ s : ℝ in d..1, kernel s) ≤ -(3 / 2 : ℝ) * log d

-- Far-field exponential decay bound
theorem kernel_far_bound {s : ℝ} (hs : 1 ≤ s) :
    kernel s ≤ exp (-s / 2) / (1 - exp (-2))

-- Far-field global integrability
theorem kernel_far_integrable : IntegrableOn kernel (Set.Ioi 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving explicit non-asymptotic hyperbolic bounds and logarithmic cutoff estimates $\int_d^1 K(s) ds \le -\frac{3}{2}\log d$ for the physical continuous arrival kernel without uncertified asymptotic limits.
