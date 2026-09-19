# First Formalization: Exact Centered-Divisor Forcing Inversion and Chebyshev Error Duality

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MertensArithmetic.lean`](../../formalization/BuildingBlocks/MertensArithmetic.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact hyperbola floor convolution, Möbius floor inversion, floor mass contraction, and the $2\gamma$-shifted duality between centered divisor forcing and Chebyshev's prime error in Lean 4:

1. **Log-Factorial Prime Decomposition:**
   Formal derivation of $\log(N!) = \sum_{k=1}^N \psi(N/k)$ (`logFactorial_eq_sum_psi`).
2. **Error Recurrence Forcing:**
   Formal identity $\sum_{k=1}^N (\psi(N/k) - N/k) = \mathcal{R}(N)$ (`sum_integerError_eq_forcing`).
3. **Möbius Floor Mass Invariant:**
   Formal proof of $\sum_{d=1}^N \mu(d)\lfloor N/d \rfloor = 1$ (`moebius_floor_mass`).
4. **General Möbius Floor Inversion:**
   Formal proof of $\sum_{d=1}^N \mu(d) \sum_{k \le N/d} f(\lfloor (N/d)/k \rfloor) = f(N)$ (`moebius_floor_inversion`).
5. **Chebyshev Error Möbius Inversion:**
   Formal derivation of $\psi(N) - N = \sum_{d=1}^N \mu(d) \mathcal{R}(\lfloor N/d \rfloor)$ (`integerError_eq_moebius_recurrenceForcing`).
6. **Centered Divisor Inversion with Euler Shift:**
   Formal derivation of $\sum_{d=1}^N \mu(d) \mathcal{F}_c(\lfloor N/d \rfloor) = (\psi(N) - N) + 2\gamma$ (`centeredDivisorForcing_inverse`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Factorial prime decomposition
theorem logFactorial_eq_sum_psi (N : ℕ) :
    logFactorial N = ∑ k ∈ Finset.Icc 1 N, psi (N / k)

-- Error convolution with recurrence forcing
theorem sum_integerError_eq_forcing (N : ℕ) :
    ∑ k ∈ Finset.Icc 1 N, integerError (N / k) = recurrenceForcing N

-- Total integer floor mass of the Moebius function
theorem moebius_floor_mass {N : ℕ} (hN : 0 < N) :
    ∑ k ∈ Finset.Icc 1 N,
      ArithmeticFunction.moebius k * ((N / k : ℕ) : ℤ) = 1

-- General Moebius floor inversion
theorem moebius_floor_inversion (f : ℕ → ℝ) {N : ℕ} (hN : 1 ≤ N) :
    (∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ k ∈ Finset.Icc 1 (N / d), f (N / d / k)) = f N

-- Exact prime error inversion
theorem integerError_eq_moebius_recurrenceForcing {N : ℕ} (hN : 1 ≤ N) :
    integerError N = ∑ d ∈ Finset.Icc 1 N,
      (ArithmeticFunction.moebius d : ℝ) * recurrenceForcing (N / d)

-- Centered divisor forcing inverse with 2 * gamma shift
theorem centeredDivisorForcing_inverse {N : ℕ} (hN : 1 ≤ N) :
    (∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      centeredDivisorForcing (N / d)) =
        integerError N + 2 * Real.eulerMascheroniConstant
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the exact discrete Möbius hyperbola inversion connecting Dirichlet divisor forcing to Chebyshev's prime error with the exact topological shift $2\gamma$.
