# First Formalization: Truncated Prime Scattering Amplification and Non-Contractivity Obstruction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactLocalScatteringSigns.lean`](../../formalization/BuildingBlocks/CompactLocalScatteringSigns.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This entry documents a machine-verified proof that finite history truncations of prime scattering multipliers fail to be contractions on $L^2$:

1. **Geometric History Sum Factorization:**
   Formal identity factorizing the finite geometric memory sum into a unitary phase and a complex tail term (`finite_history_numerator`, `finite_history_factorization`, `compact_phase_factorization`).
2. **Zero-Frequency Attenuation:**
   Formal proof that at $t = 0$, the multiplier norm square is strictly strictly less than 1 (`compact_attenuation_zero`).
3. **Resonant Frequency Amplification:**
   Formal proof that at the resonant frequency $t = \frac{\pi}{M \log p}$, the negative tail real part forces the norm square strictly above 1 (`compact_amplification_special`, `amplification_phase`).
4. **General Prime Non-Contractivity Theorem:**
   Formal proof of `original_prime_compact_signs` verifying attenuation at DC and amplification at the resonant frequency for every prime $p$ and every history truncation depth $M \ge 1$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Attenuation at frequency zero
theorem compact_attenuation_zero {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (hr2 : r ^ 2 ≤ 1 / 2) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (compactPhase r 0 M) < 1

-- Amplification at resonant frequency
theorem compact_amplification_special {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    {M : ℕ} (hM : 1 ≤ M) :
    1 < Complex.normSq (compactPhase r (Real.pi / (M : ℝ)) M)

-- Original power form across all primes and history depths
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

This formalization establishes an unconditional obstruction to naive causal truncations in operator-theoretic Riemann Hypothesis programs, rigorously identifying the resonant frequency where norm amplification occurs.
