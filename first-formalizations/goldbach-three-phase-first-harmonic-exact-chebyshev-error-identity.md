# First Formalization: Goldbach Three-Phase First Harmonic Exact Chebyshev Error Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachThreePhaseEndpoint.lean`](../../formalization/BuildingBlocks/GoldbachThreePhaseEndpoint.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact evaluation of the 3-adic first harmonic of the even Goldbach triangle in terms of the Chebyshev prime error in Lean 4:

1. **One-Leg Reference Row Exact Sum:**
   Formal proof that the one-leg sum equals $(\log 3)(2k+4)$ (`one_leg_reference_exact`).
2. **Two-Power Prefix Closed Form:**
   Formal evaluation of the even prime-power sum as $\operatorname{twoPowerPrefix}(Y) = (\log 2) \lfloor \log_2 Y \rfloor$ (`twoPowerPrefix_eq_power_count`).
3. **Master Harmonic Identity:**
   Formal proof of the exact non-asymptotic identity equating $\operatorname{threeFirstHarmonic}(2k+6)$ to $2\log 3 [\psi(2k+3) - (2k+3) - \operatorname{twoPowerPrefix}(2k+3) - 1 - (\log 3)|\operatorname{ladder}|]$ (`three_first_harmonic_exact`).
4. **Complete Chebyshev Prime Error Representation:**
   Formal substitution of the two-power count into the harmonic identity (`three_first_harmonic_prime_error`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact one-leg reference evaluation
theorem one_leg_reference_exact (k : ℕ) :
    (∑ q ∈ evenPairDomain (2 * k + 6),
      if padicValNat 3 q.1 = 1 then weight q.1 * oddReference q.2 else 0) =
      Real.log 3 * (2 * k + 4 : ℝ)

-- Exact two-power prefix evaluation
theorem twoPowerPrefix_eq_power_count (Y : ℕ) :
    twoPowerPrefix Y = Real.log 2 * (Nat.log 2 Y : ℝ)

-- Master 3-adic first harmonic identity
theorem three_first_harmonic_exact (k : ℕ) :
    threeFirstHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) -
          (2 * k + 3 : ℝ) - twoPowerPrefix (2 * k + 3) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ))

-- Representation via explicit Chebyshev prime error and log_2 count
theorem three_first_harmonic_prime_error (k : ℕ) :
    threeFirstHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof of an exact non-asymptotic identity expressing the first 3-adic harmonic of the binary Goldbach convolution directly in terms of the classical Chebyshev prime counting error $\psi(x) - x$.
