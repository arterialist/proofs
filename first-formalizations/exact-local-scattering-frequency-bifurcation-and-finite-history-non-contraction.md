# First Formalization: Exact Local Scattering Frequency Bifurcation and Finite-History Non-Contraction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactLocalScatteringSigns.lean`](../../formalization/BuildingBlocks/CompactLocalScatteringSigns.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact frequency bifurcation of finite-history local prime scattering filters, proving simultaneous zero-frequency attenuation and resonant amplification in Lean 4:

1. **Finite-History Closed-Form Numerator Identity:**
   Formal proof of `finite_history_numerator`: Exact geometric sum expansion of the finite history filter.
2. **Phase Factorization:**
   Formal proof of `compact_phase_factorization`: Splitting of the scattering filter into a norm-1 phase ratio and an amplification modifier.
3. **Resonant Tail Flipping:**
   Formal proof of `phase_special_power`: $(\text{phase}(\pi/M))^M = -1$.
4. **General Prime Phase Sign Theorem:**
   Formal proof of `actual_prime_compact_signs`: For any prime $p$ and depth $M \ge 1$, attenuation at $\theta = 0$ and amplification at $\theta = \pi/M$.
5. **Main Physical Scattering Non-Contraction Theorem:**
   Formal proof of `original_prime_compact_signs`: Evaluation at the physical frequency $t_M = \frac{\pi}{M \log p}$ proving failure of uniform local scattering contractivity.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite history numerator identity
theorem finite_history_numerator (x y : ℂ) (M : ℕ) :
    (-y + (1 - x * y) * ∑ j ∈ Finset.range M, x ^ j) * (1 - x) =
      (1 - y) - (1 - x * y) * x ^ M

-- Phase factorization
theorem compact_phase_factorization {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (theta : ℝ) (M : ℕ) :
    compactPhase r theta M =
      ((1 - (r : ℂ) * phase theta) /
        (1 - (r : ℂ) * (starRingEnd ℂ) (phase theta))) *
      (1 - (1 - (r : ℂ) ^ 2) *
        ((r : ℂ) * (starRingEnd ℂ) (phase theta)) ^ M /
        (1 - (r : ℂ) * phase theta))

-- Attenuation at zero, amplification at resonant frequency for any prime
theorem actual_prime_compact_signs (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (compactPhase (1 / Real.sqrt (p : ℝ)) 0 M) < 1 ∧
    1 < Complex.normSq
      (compactPhase (1 / Real.sqrt (p : ℝ)) (Real.pi / (M : ℝ)) M)

-- Physical frequency non-contraction theorem
theorem original_prime_compact_signs (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (originalCompact p 0 M) < 1 ∧
      1 < Complex.normSq
        (originalCompact p (Real.pi / ((M : ℝ) * Real.log (p : ℝ))) M)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the simultaneous attenuation and amplification of local prime scattering filters, disproving local uniform contractivity for finite-depth scattering channels.
