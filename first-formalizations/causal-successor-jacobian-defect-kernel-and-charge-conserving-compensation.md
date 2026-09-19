# First Formalization: Causal Successor Jacobian Defect Kernel and Charge-Conserving Compensation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCharge.lean`](../../formalization/BuildingBlocks/SuccessorCharge.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact change-of-variables integration, defect kernel identity, and charge-conserving compensation for the causal successor operator in Lean 4:

1. **Diffeomorphism and Pull-Back Transformation:**
   Formal proof that $\sigma(v) = \log(1 + e^v)$ is injective and maps $(0, \infty)$ onto $(\log 2, \infty)$ (`sigma_injective`, `sigma_image_positive`), with pull-back Jacobian relation $J(v) w(\sigma(v)) = \sqrt{J(v)}$ (`jacobian_mul_weight_sigma`).
2. **Defect Kernel Integration Formula:**
   Formal proof of the identity $\int_0^\infty T f(v) \, dv - \int_0^\infty f(u) \, du = \int_0^\infty K(u) f(u) \, du$ (`integral_successor_sub`), where $|K(u)| \le 1$ everywhere (`kernel_abs_le`).
3. **Integrability of Successor:**
   Formal proof that $T f \in L^1(0, \infty)$ for all $f \in L^1(0, \infty)$ (`integrable_successor`).
4. **Charge-Conserving Compensation:**
   Formal proof that the compensated operator $\widetilde{T} f(v) = T f(v) - e^{-v/2} \operatorname{defect}(f)$ preserves the total integral and charge identically (`integral_compensated`, `charge_compensated`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Defect kernel integral representation
theorem integral_successor_sub {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor f v) - (∫ u in Ioi (0 : ℝ), f u) =
      ∫ u in Ioi (0 : ℝ), kernel u * f u

-- Kernel uniform bound
theorem kernel_abs_le (u : ℝ) : |kernel u| ≤ 1

-- Integrability of compensated operator
theorem integrable_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    IntegrableOn (compensated f) (Ioi (0 : ℝ))

-- Conservation of integral
theorem integral_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), compensated f v) = ∫ v in Ioi (0 : ℝ), f v

-- Strict conservation of charge
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

## 3. Scope and verification status

This entry documents a machine-verified construction of an exact rank-one boundary compensation that enforces charge conservation in logarithmic shift transfer operators.
