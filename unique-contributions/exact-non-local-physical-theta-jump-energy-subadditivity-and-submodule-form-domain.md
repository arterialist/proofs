# Unique Contribution 208: Exact Non-Local Physical Theta Jump Energy Subadditivity and Submodule Form Domain

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PhysicalThetaJumpAddition.lean`](../../formalization/BuildingBlocks/PhysicalThetaJumpAddition.lean), [`building-blocks/theta/physical-theta-jump-addition.md`](../../building-blocks/theta/physical-theta-jump-addition.md)  
**Classification:** Dirichlet Forms / Non-Local Jump Processes / Functional Analysis / Energy Functionals / Submodule Domains / Operator Quadratic Forms

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of non-local Markov jump generators and arithmetic scattering forms, proving that the maximal domain $\mathcal{D}(\mathcal{E})$ of a non-local Dirichlet form is a true linear subspace (submodule) requires establishing sharp quadratic subadditivity for both the continuous integral jumps and the discrete prime nodes. When the energy functional involves two-point product weights $\phi(u+a)\phi(u) (h(u+a) - h(u))^2$, linearity of the domain cannot be asserted without uniform energy bounds under vector addition.

This contribution proves:

1. **Exact Two-Point Jump Integrand Quadratic Bound:**  
   For all measurable functions $h, g : \mathbb{R} \to \mathbb{R}$ and shift parameters $a, u \in \mathbb{R}$:
   \[
   \phi(u+a) \phi(u) (h(u+a) + g(u+a) - (h(u) + g(u)))^2 \le 2 \phi(u+a) \phi(u) \left( (h(u+a) - h(u))^2 + (g(u+a) - g(u))^2 \right).
   \]
2. **Subadditivity of Continuous and Prime Jump Energies:**  
   Integrating against the continuous kernel $K(a)$ and summing across the discrete von Mangoldt prime nodes $\Lambda(n)/\sqrt{n}$ preserves the factor of 2:
   \[
   \mathcal{E}_{\text{cont}}(h + g) \le 2 (\mathcal{E}_{\text{cont}}(h) + \mathcal{E}_{\text{cont}}(g)),
   \]
   \[
   \mathcal{E}_{\text{prime}}(h + g) \le 2 (\mathcal{E}_{\text{prime}}(h) + \mathcal{E}_{\text{prime}}(g)).
   \]
3. **Total and Killed Exterior Energy Subadditivity:**  
   For any truncation radius $R \in \mathbb{R}$, the total jump energy $\mathcal{E}_{\text{jump}} = \mathcal{E}_{\text{cont}} + \mathcal{E}_{\text{prime}}$ and the exterior killed energy $\mathcal{E}_R(h)$ satisfy:
   \[
   \mathcal{E}_R(h + g) \le 2 (\mathcal{E}_R(h) + \mathcal{E}_R(g)).
   \]
4. **Submodule Architecture for the Maximal Exterior Domain:**  
   The maximal exterior domain $\mathcal{D}(\mathcal{E}_R) = \{h \in L^2(\nu|_{\{|v|>R\}}) : \mathcal{E}_R(h) < \infty\}$ is closed under vector addition:
   \[
   h, g \in \mathcal{D}(\mathcal{E}_R) \implies h + g \in \mathcal{D}(\mathcal{E}_R),
   \]
   and forms an authentic $\mathbb{R}$-submodule (`Submodule ℝ (ExteriorGroundSpace R)`).

---

## 2. Mathematical Proof

### 2.1. Elementary Quadratic Inequality
For any real numbers $A, B$:
\[
(A + B)^2 = 2(A^2 + B^2) - (A - B)^2 \le 2(A^2 + B^2).
\]
Setting $A = h(u+a) - h(u)$ and $B = g(u+a) - g(u)$, we have $A + B = (h+g)(u+a) - (h+g)(u)$.
Since $\phi(v) > 0$ for all $v$, multiplying by $\phi(u+a)\phi(u) \ge 0$ yields:
\[
\text{integrand}(h+g, a, u) \le 2 (\text{integrand}(h, a, u) + \text{integrand}(g, a, u)).
\]

### 2.2. Linearity of Integrals and Prime Series
Integrating with respect to $u \in \mathbb{R}$ gives $\text{edgeMass}(h+g, a) \le 2(\text{edgeMass}(h, a) + \text{edgeMass}(g, a))$.
Multiplying by non-negative kernel coefficients and integrating over $a \in (0, \infty)$ yields the continuous energy bound.
Similarly, summing over all $n \ge 2$ with non-negative weights $\frac{\Lambda(n)}{\sqrt{n}}$ yields the prime energy bound.
Adding the two inequalities gives $\mathcal{E}_{\text{jump}}(h+g) \le 2(\mathcal{E}_{\text{jump}}(h) + \mathcal{E}_{\text{jump}}(g))$.

### 2.3. Submodule Construction
For $h, g \in \text{ExteriorGroundSpace}(R)$, their representatives $H, G$ satisfy $\mathcal{E}_R(H) < \infty$ and $\mathcal{E}_R(G) < \infty$.
Then $\mathcal{E}_R(H+G) \le 2(\mathcal{E}_R(H) + \mathcal{E}_R(G)) < \infty$.
Together with homogeneity under scalar multiplication $\mathcal{E}_R(c h) = c^2 \mathcal{E}_R(h) < \infty$, this establishes that $\mathcal{D}(\mathcal{E}_R)$ is a linear submodule of $L^2(\nu|_{\{|v|>R\}})$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PhysicalThetaJumpAddition` in `formalization/BuildingBlocks/PhysicalThetaJumpAddition.lean`):
```lean
theorem integrand_add_bound (h g : ℝ → ℝ) (a u : ℝ) :
    integrand (fun v => h v + g v) a u ≤ 2 * (integrand h a u + integrand g a u)

theorem edge_mass_add_bound {h g : ℝ → ℝ} (hh : Measurable h) (a : ℝ) :
    edgeMass (fun u => h u + g u) a ≤ 2 * (edgeMass h a + edgeMass g a)

theorem continuous_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    continuousEnergy (fun u => h u + g u) ≤ 2 * (continuousEnergy h + continuousEnergy g)

theorem prime_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    primeEnergy (fun u => h u + g u) ≤ 2 * (primeEnergy h + primeEnergy g)

theorem jump_energy_add_bound {h g : ℝ → ℝ} (hh : Measurable h) :
    jumpEnergy (fun u => h u + g u) ≤ 2 * (jumpEnergy h + jumpEnergy g)

theorem exterior_hilbert_energy_add_bound (R : ℝ) (h g : ExteriorGroundSpace R) :
    exteriorHilbertEnergy R (h + g) ≤
      2 * (exteriorHilbertEnergy R h + exteriorHilbertEnergy R g)

theorem maximal_exterior_domain_add (R : ℝ) (h g : ExteriorGroundSpace R)
    (hh : h ∈ maximalExteriorDomain R) (hg : g ∈ maximalExteriorDomain R) :
    h + g ∈ maximalExteriorDomain R

def exteriorFormDomain (R : ℝ) : Submodule ℝ (ExteriorGroundSpace R)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet forms and jump processes on metric measure spaces (Fukushima-Oshima-Takeda 2011, Chen-Fukushima 2012). Machine formalization of non-local arithmetic Dirichlet forms combining continuous and prime jump energies in Lean 4 is new.
- **Advancement:** Proves the universal subadditivity $\mathcal{E}(h+g) \le 2(\mathcal{E}(h) + \mathcal{E}(g))$ for the hybrid continuous-prime theta jump energy and formally constructs the form domain submodule in Lean 4.
- **Target Venues:** *Potential Analysis* or *Journal of Functional Analysis*.
