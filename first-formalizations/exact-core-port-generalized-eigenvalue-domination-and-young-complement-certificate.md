# First Formalization: Exact Core-Port Generalized Eigenvalue Domination and Young Complement Certificate

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CorePortGeneralizedEigen.lean`](../../formalization/BuildingBlocks/CorePortGeneralizedEigen.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the generalized eigenvalue domination certificate, obstruction failure witness, and 2x2 trial-complement Young certificate in Lean 4:

1. **Generalized Rayleigh Quotient Equivalence:**
   Formal proof of `generalizedRayleigh_le_one_iff`: $\text{port}/\text{supply} \le 1 \iff \text{port} \le \text{supply}$ for $\text{supply} > 0$.
2. **Generalized Eigenvalue Domination Certificate:**
   Formal proof of `generalizedEigenvalue_certificate`: $\lambda \le 1$ and $\text{port} \le \lambda \cdot \text{supply} \implies \text{port} \le \text{supply}$.
3. **Certified Coordinate Failure Witness:**
   Formal proof of `compressed_failure_witness`: A single coordinate with $\text{supply}(Zc) < \text{port}(Zc)$ refutes non-negativity.
4. **Interval-Enclosure Certificate:**
   Formal proof of `interval_coordinate_certificate`: $\text{supplyLo} \le \text{supply}$ and $\text{port} \le \text{portHi} \le \text{supplyLo} \implies \text{port} \le \text{supply}$.
5. **Trial-Complement Young Certificate:**
   Formal proof of `trial_complement_young_certificate`: $\text{total} \ge a \|\text{trial}\|^2 + d \|\text{tail}\|^2 - 2b \|\text{trial}\|\|\text{tail}\| \ge 0$ whenever $a \ge \epsilon$ and $d \ge b^2/\epsilon$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Equivalence of Rayleigh quotient bound and form domination
theorem generalizedRayleigh_le_one_iff
    {supply port : ℝ} (hs : 0 < supply) :
    port / supply ≤ 1 ↔ port ≤ supply

-- Certified spectral radius domination theorem
theorem generalizedEigenvalue_certificate
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) (lambda : ℝ)
    (hs : ∀ c, 0 ≤ supply (Z c))
    (hp : ∀ c, port (Z c) ≤ lambda * supply (Z c))
    (hlambda : lambda ≤ 1) :
    ∀ c, port (Z c) ≤ supply (Z c)

-- Certified failure witness refutation
theorem compressed_failure_witness
    {V W : Type*} (supply port : V → ℝ) (Z : W → V) (c : W)
    (h : supply (Z c) < port (Z c)) :
    ¬ (∀ d, 0 ≤ compressedForm supply Z d - compressedForm port Z d)

-- Certified interval enclosure bridge
theorem interval_coordinate_certificate
    {supply port supplyLo portHi : ℝ}
    (hs : supplyLo ≤ supply) (hp : port ≤ portHi) (hbox : portHi ≤ supplyLo) :
    port ≤ supply

-- Trial-complement Young margin certificate
theorem trial_complement_young_certificate
    {trialSq tailSq total : ℝ} {a b d eps : ℝ}
    (ht : 0 ≤ trialSq) (hh : 0 ≤ tailSq)
    (heps : 0 < eps)
    (htotal : total ≥ a * trialSq + d * tailSq - 2 * b * Real.sqrt trialSq * Real.sqrt tailSq)
    (ha : 0 ≤ a - eps)
    (hd : 0 ≤ d - b^2 / eps) :
    0 ≤ total
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 connecting coordinate interval enclosures, failure witnesses, and 2x2 trial-complement Young margin certificates to verify operator domination in formal theorem proving.
