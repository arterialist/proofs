# First Formalization: Exact Distinct-Prime Cell Dynamics and Arithmetic Velocity Jump Dichotomy

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/DistinctPrimeDynamics.lean`](../../formalization/BuildingBlocks/DistinctPrimeDynamics.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the continuous trajectory cell dynamics of arithmetic coprime prime pairs in Lean 4:

1. **Discrete Arithmetic Identification:**
   Formal proof of `cell_at_integer`: $\text{cell}(N, N) = \text{distinctPrimeArea}(N)$.
2. **Continuous Cell Interface Splicing:**
   Formal proof of `cell_join`: $\text{cell}(N+1, N+1) = \text{cell}(N, N+1)$.
3. **Exact Arithmetic Velocity Jumps:**
   Formal proof of `slope_jump`: $\Delta \text{slope}(N+1) = w_{\text{distinct}}(N+1) - 2 \Lambda(N+1)$.
4. **Prime Power Deceleration Shock:**
   Formal proof of `slope_jump_prime_pow` and `slope_jump_prime_pow_neg`: $\Delta \text{slope}(p^k) = -2 \log p < 0$.
5. **Composite Acceleration Impulse:**
   Formal proof of `slope_jump_nonneg_of_not_prime_pow`: $\Delta \text{slope}(N+1) \ge 0$ whenever $N+1$ is not a prime power.
6. **Curvature Defect:**
   Formal proof of `curvature_jump`: $\Delta \text{curvature}(N+1) = -2\Lambda(N+1)/(N+1)$.
7. **Compensating Initial Conditions:**
   Formal proof of `initial_cell_and_slope`: $\text{cell}(1, 1) = 0$ and $\text{slope}(1, 1) = 1$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Integer boundary identification
theorem cell_at_integer (N : ℕ) : cell N N = distinctPrimeArea N

-- Continuous cell interface gluing
theorem cell_join (N : ℕ) :
    cell (N + 1) (N + 1 : ℕ) = cell N (N + 1 : ℕ)

-- General velocity jump
theorem slope_jump (N : ℕ) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) =
      distinctPrimePairWeight (N + 1) -
        2 * ArithmeticFunction.vonMangoldt (N + 1)

-- Deceleration shock at prime powers
theorem slope_jump_prime_pow {N p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k)
    (hN : N + 1 = p ^ k) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) = -2 * Real.log p

-- Strict negativity at prime powers
theorem slope_jump_prime_pow_neg {N p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k)
    (hN : N + 1 = p ^ k) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) < 0

-- Non-negative impulse at composite integers
theorem slope_jump_nonneg_of_not_prime_pow (N : ℕ)
    (hN : ¬IsPrimePow (N + 1)) :
    0 ≤ slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ)

-- Initial conditions
theorem initial_cell_and_slope : cell 1 1 = 0 ∧ slope 1 1 = 1
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 constructing a continuous geometric cell embedding that identifies arithmetic coprime pair areas and proves that prime powers act as negative deceleration shocks while composite numbers act as positive acceleration impulses.
