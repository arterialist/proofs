# Contribution 256: Exact Compensated Causal Memory Commutator and Relative Charge Integrability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompensatedMemoryKernel.lean`](../../formalization/BuildingBlocks/CompensatedMemoryKernel.lean), [`building-blocks/operator/compensated-memory-kernel.md`](../../building-blocks/operator/compensated-memory-kernel.md)  
**Classification:** Operator Theory / Causal Memory Kernels / Volterra Operators / Commutator Identities / Defect Charges / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the causal renewal formulation of prime fluctuations, the causal memory operator maps an incoming profile $f \in L^2(\mathbb{R}_+)$ to its convolution against an impulse response filter $F \in L^2(\mathbb{R})$:
$$
\text{causalMemory}(F, f)(v) = \int_0^\infty F(v - u) f(u) \, du.
$$
Because boundary charges accumulate at the origin $u=0$, passing to the compensated profile $\text{compensated}(f) = \text{successor}(f) - \text{defect}(f) e^{-u/2}$ generates non-trivial commutator terms against the causal convolution.

This contribution proves:

1. **Uniform Cauchy-Schwarz Memory Bound:**  
   For any $F \in L^2(\mathbb{R})$, $f \in L^2(\mathbb{R}_+)$, and horizon $v \in \mathbb{R}$:
   $$
   |\text{causalMemory}(F, f)(v)| \le \|F\|_{L^2(\mathbb{R})} \cdot \|f\|_{L^2(\mathbb{R}_+)}.
   $$
2. **Integrability of the Output Relative Charge:**  
   The product of the universal defect kernel and the causal memory output is unconditionally integrable on $\mathbb{R}_+$:
   $$
   \int_0^\infty |\text{kernel}(v) \cdot \text{causalMemory}(F, f)(v)| \, dv < \infty.
   $$
   This guarantees that the relative charge of the output is a genuine absolutely convergent integral without assuming total integrability of $f$.
3. **Exact Compensated Commutator Identity:**  
   For all $F \in L^2(\mathbb{R})$ and $f \in L^2(\mathbb{R}_+)$:
   $$
   \text{compensated}(\text{causalMemory}(F, f))(v) - \text{causalMemory}(F, \text{compensated}(f))(v) = \int_0^\infty \text{memoryKernel}(F, v, u) f(u) \, du + \text{causalMemory}(F, e^{-u/2})(v) \cdot \text{defect}(f) - e^{-v/2} \cdot \text{defect}(\text{causalMemory}(F, f)).
   $$
4. **Finite Prime Seed Invariance:**  
   For every finite set of primes $S$, the identity specializes to the prime-seed memory kernel with certified finite $L^2$ bounds.

---

## 2. Mathematical Proof

### 2.1. Causal Memory Bound
By translation invariance of the Lebesgue measure, $u \mapsto F(v - u)$ has $L^2$ norm equal to $\|F\|_{L^2(\mathbb{R})}$.
Restricting to the half-line $\mathbb{R}_+ = (0, \infty)$ and applying the Cauchy-Schwarz inequality:
$$
|\text{causalMemory}(F, f)(v)| = \left| \int_0^\infty F(v - u) f(u) \, du \right| \le \left( \int_0^\infty F(v - u)^2 \, du \right)^{1/2} \|f\|_{L^2(\mathbb{R}_+)} \le \|F\|_{L^2(\mathbb{R})} \|f\|_{L^2(\mathbb{R}_+)}.
$$

### 2.2. Relative Charge Integrability
Since the defect kernel satisfies $|\text{kernel}(v)| \le 2 e^{-v}$ on $(0, \infty)$, it is integrable on $(0, \infty)$ with $\int_0^\infty |\text{kernel}(v)| dv \le 2$.
Multiplying by the uniform bound $M = \|F\|_2 \|f\|_2$:
$$
\int_0^\infty |\text{kernel}(v) \cdot \text{causalMemory}(F, f)(v)| \, dv \le M \int_0^\infty |\text{kernel}(v)| \, dv < \infty.
$$

### 2.3. Compensated Commutator Expansion
From the definition of the compensated operator $\text{compensated}(g) = \text{successor}(g) - e^{-v/2} \text{defect}(g)$:
1. $\text{compensated}(\text{causalMemory}(F, f)) = \text{successor}(\text{causalMemory}(F, f)) - e^{-v/2} \text{defect}(\text{causalMemory}(F, f))$.
2. $\text{causalMemory}(F, \text{compensated}(f)) = \text{causalMemory}(F, \text{successor}(f)) - \text{causalMemory}(F, e^{-u/2}) \text{defect}(f)$.
Subtracting the two equations:
$$
\text{compensated}(\text{causalMemory}(F, f)) - \text{causalMemory}(F, \text{compensated}(f)) = [\text{successor}, \text{causalMemory}(F, \cdot)](f) + \text{causalMemory}(F, e^{-u/2}) \text{defect}(f) - e^{-v/2} \text{defect}(\text{causalMemory}(F, f)).
$$
Substituting the successor commutator $[\text{successor}, \text{causalMemory}(F, \cdot)](f)(v) = \int_0^\infty \text{memoryKernel}(F, v, u) f(u) du$ establishes the theorem.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCharge` and `BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/CompensatedMemoryKernel.lean`):
```lean
theorem causalMemory_bound {F f : ℝ → ℝ} (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    |causalMemory F f v| ≤ sqrt (∫ x, F x ^ 2) * sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2)

theorem integrable_memory_defect {F f : ℝ → ℝ} (hmF : Measurable F) (hmf : Measurable f)
    (hF : MemLp F 2 volume) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun v => kernel v * causalMemory F f v) (Ioi (0 : ℝ))

theorem compensated_memory_commutator {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    compensated (causalMemory F f) v - causalMemory F (compensated f) v =
      (∫ u in Ioi (0 : ℝ), memoryKernel F v u * f u) +
      causalMemory F (fun u => exp (-u / 2)) v * defect f -
      exp (-v / 2) * defect (causalMemory F f)

theorem finitePrimeSeed_compensated_memory_commutator (S : Finset Nat.Primes)
    {f : ℝ → ℝ} (hmf : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.compensated f) v =
      (∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryKernel (finitePrimeSeed S) v u * f u) +
      SuccessorCharge.causalMemory (finitePrimeSeed S) (fun u => exp (-u / 2)) v *
        SuccessorCharge.defect f - exp (-v / 2) *
        SuccessorCharge.defect (SuccessorCharge.causalMemory (finitePrimeSeed S) f)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Volterra integral equations, causal filtering, and operator commutators (Gohberg-Krein 1970, Cordes 1987). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact algebraic framework for tracking charge conservation across causal convolution layers.
- **Target Venues:** *Integral Equations and Operator Theory* or *Journal of Functional Analysis*.
