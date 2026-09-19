# First Formalization: Exact Causal Successor Jacobian and Charge-Conserving Compensation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCharge.lean`](../../formalization/BuildingBlocks/SuccessorCharge.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the measure-theoretic change of variables for the causal successor operator, derives the explicit relative charge defect kernel, and proves total charge conservation for the compensated successor operator in Lean 4:

1. **Successor Diffeomorphism Properties:**
   Formal proof of `sigma_hasDerivAt`, `sigma_injective`, and `sigma_image_positive`: $\sigma((0, \infty)) = (\log 2, \infty)$.
2. **Measure-Theoretic Successor Integral:**
   Formal proof of `integral_successor`: $\int_0^\infty \mathcal{T} f(v) dv = \int_{\log 2}^\infty W(u) f(u) du$.
3. **Uniform Kernel and Weight Bounds:**
   Formal proof of `weight_bounds`: $0 \le W(u) \le 2$ on $[\log 2, \infty)$, and `kernel_abs_le`: $|K(u)| \le 1$ on $(0, \infty)$.
4. **Exact Relative Defect Formula:**
   Formal proof of `integral_successor_sub`: $\int_0^\infty \mathcal{T} f(v) dv - \int_0^\infty f(u) du = \int_0^\infty K(u) f(u) du$.
5. **Causal Reference Probe Normalization:**
   Formal proof of `reference_integral`: $\int_0^\infty e^{-v/2} dv = 2$.
6. **Total Charge Conservation:**
   Formal proof of `integral_compensated` and `charge_compensated`: $\text{charge}(\mathcal{T}_{\text{comp}} f) = \text{charge}(f)$ for all $f \in L^1(0, \infty)$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Change-of-variables integral
theorem integral_successor (f : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), successor f v) =
      ∫ u in Ioi (log 2), weight u * f u

-- Kernel uniform bound
theorem kernel_abs_le (u : ℝ) : |kernel u| ≤ 1

-- Relative defect integral
theorem integral_successor_sub {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor f v) - (∫ u in Ioi (0 : ℝ), f u) =
      ∫ u in Ioi (0 : ℝ), kernel u * f u

-- Reference integral normalization
theorem reference_integral : (∫ v in Ioi (0 : ℝ), exp (-v / 2)) = 2

-- Compensated integral equality
theorem integral_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), compensated f v) = ∫ v in Ioi (0 : ℝ), f v

-- Total charge conservation
theorem charge_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    charge (compensated f) = charge f
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that the geometric boundary defect of the causal dilation operator can be exactly compensated by a normalized exponential probe, achieving rigorous charge conservation on the positive half-line.
