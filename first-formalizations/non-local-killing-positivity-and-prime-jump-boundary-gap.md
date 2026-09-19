# First Formalization: Non-Local Killing Positivity and Prime Jump Boundary Gap

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PhysicalKillingPositivity.lean`](../../formalization/BuildingBlocks/PhysicalKillingPositivity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization verifies the strict positivity of the killed non-local Dirichlet energy for constant states on a core $[-R, R]$:

1. **Geometric Crossing Interval:**
   Formal derivation showing that for any core radius $R > 0$ and any shift $a > 0$, points $u \in \left(-R - a, -R - a + \frac{\min(R, a)}{2}\right)$ satisfy $|u| > R$ (outside the core) and $|u + a| < R$ (inside the core) (`crossing_interval`).
2. **Killed Edge Mass Positivity:**
   Formal proof that the killed extension of any non-zero constant $c \ne 0$ produces a strictly positive edge jump integral $\operatorname{edgeMass}(k, a) > 0$ across the shift $a$ (`constant_killed_edge_positive`), using Lebesgue measure monotonicity and support containment.
3. **Prime Jump Energy Floor:**
   Formal evaluation showing that the prime jump term at $n = 2$ ($a = \log 2$) is strictly positive, forcing the entire killed Dirichlet energy to be strictly positive: $\operatorname{killedEnergy}(R, c) > 0$ (`constant_killed_energy_positive`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Geometric crossing interval
theorem crossing_interval {R a u : ℝ} (hR : 0 < R) (ha : 0 < a)
    (hu : u ∈ Set.Ioo (-R - a) (-R - a + min R a / 2)) :
    R < |u| ∧ |u + a| < R

-- Non-local edge mass positivity
theorem constant_killed_edge_positive {R a c : ℝ}
    (hR : 0 < R) (ha : 0 < a) (hc : c ≠ 0) :
    0 < edgeMass (killedExtension R (fun _ => c)) a

-- Total killed Dirichlet energy positivity
theorem constant_killed_energy_positive {R c : ℝ}
    (hR : 0 < R) (hc : c ≠ 0) :
    0 < killedEnergy R (fun _ => c)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof that non-local boundary killing for prime jump processes eliminates constant zero-energy modes, establishing a strictly positive spectral floor without boundary trace constraints on the core trial state.
