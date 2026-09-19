# First Formalization: Exact Paired Scattering Defect and Uniform Critical-Strip Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PairedScatteringDefect.lean`](../../formalization/BuildingBlocks/PairedScatteringDefect.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact uniform boundedness of paired arithmetic scattering multipliers throughout the critical strip in Lean 4:

1. **Paired Invariant Identity:**
   Formal proof of `paired_identity`: $\mathcal{M}(r, x, y, M) \mathcal{M}(r, y, x, M) = 1 - (1-r^2)r^{2M} - (1-r^2) \sum_{j=0}^{M-1} r^{2M-(j+1)} (x^{j+1} + y^{j+1})$ for all $xy = 1$.
2. **Exponential Specialization:**
   Formal proof of `paired_exp`: algebraic reduction for $x = e^z, y = e^{-z}$.
3. **Exact Half-Strip Moment Evaluation:**
   Formal proof of `halfStripMoment_eq`: $H(q, M) = 1 + ((M+1)(1-q) - 1) q^M$.
4. **Universal Moment Bound:**
   Formal proof of `halfStripMoment_le_two`: $0 \le H(q, M) \le 2$ for all $q \in [0, 1]$ and $M \in \mathbb{N}$.
5. **Uniform Strip Bound $\le 3$:**
   Formal proof of `norm_paired_exp_le_three` and `norm_paired_actual_prime_le_three`: $\|\mathcal{M}_{p, M}(z) \mathcal{M}_{p, M}(-z)\| \le 3$ for all $p \ge 2$, $M \in \mathbb{N}$, and $|\text{Re}(z)| \le 1/2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact paired identity
theorem paired_identity (r x y : ℂ) (h : x*y=1) (M : ℕ) :
    multiplier r x y M * multiplier r y x M =
      1-(1-r^2)*r^(2*M) - (1-r^2)*
        ∑ j ∈ Finset.range M, r^(2*M-(j+1))*(x^(j+1)+y^(j+1))

-- Closed-form moment formula
theorem halfStripMoment_eq (q : ℝ) (M : ℕ) :
    halfStripMoment q M = 1+(((M+1 : ℕ) : ℝ)*(1-q)-1)*q^M

-- Universal upper bound ≤ 2
theorem halfStripMoment_le_two (q : ℝ) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) (M : ℕ) :
    halfStripMoment q M ≤ 2

-- Uniform norm bound ≤ 3 on critical strip
theorem norm_paired_actual_prime_le_three (p : ℕ) (hp : 2 ≤ p) (z : ℂ)
    (hz : |z.re| ≤ 1/2) (M : ℕ) :
    ‖multiplier ((1/Real.sqrt (p : ℝ) : ℝ) : ℂ)
        (Complex.exp (z*Real.log (p : ℝ))) (Complex.exp (-(z*Real.log (p : ℝ)))) M *
      multiplier ((1/Real.sqrt (p : ℝ) : ℝ) : ℂ)
        (Complex.exp (-(z*Real.log (p : ℝ)))) (Complex.exp (z*Real.log (p : ℝ))) M‖ ≤ 3
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 proving uniform $O(1)$ upper bounds on paired arithmetic scattering multipliers throughout the critical strip, independent of both prime size and history depth.
