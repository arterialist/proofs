# First Formalization: Filtered Prime-Density Convolution and Three-Component Potential Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeDensityFilter.lean`](../../formalization/BuildingBlocks/PrimeDensityFilter.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact evaluations of the three filtered convolution components that assemble the arithmetic potential $V(x)$ in Lean 4:

1. **Discrete Prime Power Pairs:**
   Formal evaluation of the filtered convolution of two prime-power impulses yielding the tent potential $(e^s - p^j q^k) \log p \log q$ (`prime_power_pair_evaluation`).
2. **Symmetrized Mixed Discrete-Continuous Convolution:**
   Formal evaluation of the symmetrized mixed order filtered convolution yielding the subtraction term $\log p \frac{e^{2s} - (p^j)^2}{p^j}$ (`prime_power_mixed_evaluation`).
3. **Continuous Density Self-Convolution:**
   Formal evaluation of the continuous density self-convolution yielding $e^{-3s/2}(\frac{e^{2s} s}{2} + \frac{e^{2s}}{4} - \frac{1}{4})$ (`density_square_normalized`).
4. **Commutativity of Filtered Convolutions:**
   Formal proof that $\operatorname{conv}(f, g) = \operatorname{conv}(g, f)$ (`conv_comm`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Prime power pair filtered convolution
theorem prime_power_pair_evaluation {p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    (j k : ℕ) {s : ℝ} (hs : 0 ≤ s) :
    (Real.log p * Real.log q) *
      L0 (conv (birth ((j : ℝ)*Real.log p)) (birth ((k : ℝ)*Real.log q))) s =
    if (p : ℝ)^j * (q : ℝ)^k ≤ Real.exp s then
      Real.exp (-3*s/2) * (Real.exp s - (p : ℝ)^j*(q : ℝ)^k) *
        Real.log p * Real.log q else 0

-- Mixed discrete-continuous filtered convolution
theorem prime_power_mixed_evaluation {p : ℕ} (hp : p.Prime) (j : ℕ)
    {s : ℝ} (hs : 0 ≤ s) :
    Real.log p * (L0 (conv (birth ((j : ℝ)*Real.log p)) density) s +
      L0 (conv density (birth ((j : ℝ)*Real.log p))) s) =
    if (p : ℝ)^j ≤ Real.exp s then
      Real.exp (-3*s/2) * Real.log p *
        (Real.exp (2*s) - ((p : ℝ)^j)^2) / (p : ℝ)^j else 0

-- Continuous density-density self-convolution
theorem density_square_normalized {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv density density) s = Real.exp (-3*s/2) *
      (Real.exp (2*s) * s/2 + Real.exp (2*s)/4 - 1/4)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proofs in Lean 4 of the exact closed formulas for the three constituent components of the arithmetic potential $V(x)$, forming the mathematical foundation for the master identity $\mathcal{L}_0(S * S)(s) - \tau(s) = x^{-3/2} V(x)$.
