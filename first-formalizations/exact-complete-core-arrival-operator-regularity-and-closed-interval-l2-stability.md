# First Formalization: Exact Complete Core Arrival Operator Regularity and Closed-Interval L² Stability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PhysicalContinuousArrivalMass.lean`](../../formalization/BuildingBlocks/PhysicalContinuousArrivalMass.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the $L^2$ regularity of the continuous and complete arrival operators on the closed core $[-R, R]$ in Lean 4:

1. **Kernel Tail Mass Upper Bound:**
   Formal proof of $\int_d^\infty K(s) ds \le \frac{3}{2}\text{boundaryLog}(d) + \frac{2}{1-e^{-2}}$ (`tail_mass_bound`).
2. **Boundary Log Distance Splitting:**
   Formal proof that $\text{boundaryLog}((R-|v|)/2) \le \text{boundaryLog}(R-v) + \text{boundaryLog}(R+v) + \log 2$ (`core_half_distance_log_bound`).
3. **Core Majorant Bound:**
   Formal proof bounding the continuous arrival operator by the explicit square-integrable two-sided logarithmic majorant (`continuous_arrival_core_bound`).
4. **$L^2$ Regularity on Open and Closed Intervals:**
   Formal proofs that $\mathcal{A}_{\text{cont}}[R, \psi] \in L^2((-R, R))$ (`continuous_arrival_core_memLp_two`) and $\mathcal{A}_{\text{cont}}[R, \psi] \in L^2([-R, R])$ (`continuous_arrival_closed_core_memLp_two`).
5. **Unified Complete Arrival $L^2$ Stability:**
   Formal proof that the complete arrival operator $\mathcal{A}_{\text{complete}}[R, \psi] = \mathcal{A}_{\text{cont}} + \mathcal{A}_{\text{prime}}$ satisfies $\mathcal{A}_{\text{complete}} \in L^2([-R, R])$ (`complete_core_arrival_memLp_two`) and $\int_{-R}^R |\mathcal{A}_{\text{complete}}|^2 < \infty$ (`complete_core_arrival_square_integrable`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Universal tail mass bound
theorem tail_mass_bound {d : ℝ} (hd : 0 < d) :
    (∫ s : ℝ in Set.Ioi d, kernel s) ≤
      (3 / 2 : ℝ) * boundaryLog d + 2 / (1 - exp (-2))

-- Pointwise continuous arrival mass bound
theorem continuous_arrival_mass_bound {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    ‖continuousArrival R ψ v‖ ≤
      2 * (P * tailConstant) * ((3 / 2 : ℝ) * boundaryLog ((R - |v|) / 2) +
        2 / (1 - exp (-2)))

-- Two-sided logarithmic core majorant bound
theorem continuous_arrival_core_bound {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    ‖continuousArrival R ψ v‖ ≤ coreMajorant R (2 * (P * tailConstant))
      ((3 / 2 : ℝ) * log 2 + 2 / (1 - exp (-2))) v

-- L² membership on open core (-R, R)
theorem continuous_arrival_core_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (continuousArrival R ψ) 2 (volume.restrict (Set.Ioo (-R) R))

-- L² membership on closed core [-R, R]
theorem continuous_arrival_closed_core_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (continuousArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R))

-- Definition of complete core arrival
noncomputable def completeCoreArrival (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) : ℝ :=
  continuousArrival R ψ v + primeArrival R ψ v

-- Complete arrival L² stability on closed core [-R, R]
theorem complete_core_arrival_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (completeCoreArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R))

-- Square integrability of complete arrival
theorem complete_core_arrival_square_integrable {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    IntegrableOn (fun v => completeCoreArrival R ψ v ^ 2) (Set.Icc (-R) R)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the $L^2$ regularity of the non-local continuous arrival operator across boundary logarithmic singularities and proving full $L^2$ closed-interval stability for the complete hybrid arrival operator $\mathcal{A}_{\text{complete}}[R, \psi]$ on $[-R, R]$.
