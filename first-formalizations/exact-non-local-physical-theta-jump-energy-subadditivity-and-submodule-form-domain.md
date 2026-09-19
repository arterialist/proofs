# First Formalization: Exact Non-Local Physical Theta Jump Energy Subadditivity and Submodule Form Domain

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PhysicalThetaJumpAddition.lean`](../../formalization/BuildingBlocks/PhysicalThetaJumpAddition.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes quadratic subadditivity for continuous and arithmetic prime jump energies and constructs the maximal exterior form domain as an authentic linear submodule in Lean 4:

1. **Integrand Subadditivity:**
   Formal proof that $\text{integrand}(h+g, a, u) \le 2 (\text{integrand}(h, a, u) + \text{integrand}(g, a, u))$ (`integrand_add_bound`).
2. **Continuous and Prime Energy Preservation:**
   Formal proofs that $\mathcal{E}_{\text{cont}}(h+g) \le 2(\mathcal{E}_{\text{cont}}(h) + \mathcal{E}_{\text{cont}}(g))$ (`continuous_energy_add_bound`) and $\mathcal{E}_{\text{prime}}(h+g) \le 2(\mathcal{E}_{\text{prime}}(h) + \mathcal{E}_{\text{prime}}(g))$ (`prime_energy_add_bound`).
3. **Killed Exterior Energy Bound:**
   Formal proof of the subadditive bound $\mathcal{E}_R(h+g) \le 2(\mathcal{E}_R(h) + \mathcal{E}_R(g))$ for $L^2$ equivalence classes (`exterior_hilbert_energy_add_bound`).
4. **Submodule Form Domain Construction:**
   Formal proof that the maximal domain is closed under vector addition (`maximal_exterior_domain_add`) and construction of `exteriorFormDomain` as a `Submodule ℝ (ExteriorGroundSpace R)`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Elementary two-point quadratic integrand inequality
theorem integrand_add_bound (h g : ℝ → ℝ) (a u : ℝ) :
    integrand (fun v => h v + g v) a u ≤ 2 * (integrand h a u + integrand g a u)

-- Subadditivity of continuous jump energy
theorem continuous_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    continuousEnergy (fun u => h u + g u) ≤ 2 * (continuousEnergy h + continuousEnergy g)

-- Subadditivity of prime jump energy
theorem prime_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    primeEnergy (fun u => h u + g u) ≤ 2 * (primeEnergy h + primeEnergy g)

-- Subadditivity of total jump energy
theorem jump_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    jumpEnergy (fun u => h u + g u) ≤ 2 * (jumpEnergy h + jumpEnergy g)

-- Subadditivity on Hilbert space equivalence classes
theorem exterior_hilbert_energy_add_bound (R : ℝ) (h g : ExteriorGroundSpace R) :
    exteriorHilbertEnergy R (h + g) ≤
      2 * (exteriorHilbertEnergy R h + exteriorHilbertEnergy R g)

-- Additive closure of the maximal domain
theorem maximal_exterior_domain_add (R : ℝ) (h g : ExteriorGroundSpace R)
    (hh : h ∈ maximalExteriorDomain R) (hg : g ∈ maximalExteriorDomain R) :
    h + g ∈ maximalExteriorDomain R

-- Construction of the form domain submodule
def exteriorFormDomain (R : ℝ) : Submodule ℝ (ExteriorGroundSpace R)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving quadratic subadditivity for hybrid continuous-prime non-local Dirichlet jump energies and establishing that the maximal exterior form domain forms a bona fide linear submodule.
