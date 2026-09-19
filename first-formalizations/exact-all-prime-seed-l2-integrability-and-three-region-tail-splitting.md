# First Formalization: Exact All-Prime Seed $L^2$ Integrability and Three-Region Tail Splitting

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the unconditional square integrability of the complete all-prime seed in Lean 4, overcoming the infinite first moment via three-region prime splitting and Lévy measure majorization:

1. **Prime Power Tail Bounds:**
   Formal proof of `finite_prime_square_integer_tail` and `finite_prime_cube_tail`: $\sum_{p > Z} p^{-3} \le 4/Z^2$.
2. **Three-Region Splitting:**
   Formal proof of `finite_seed_small_region`, `finite_seed_middle_region`, and `finite_seed_large_region`: Small primes ($p \le e^{v/3}$), middle primes ($e^{v/3} < p \le e^{v/2}$), and large primes ($p > e^{v/2}$).
3. **Pointwise Decay of Collective Seed:**
   Formal proof of `allPrimeSeed_age_bound`: $v \cdot \text{allPrimeSeed}(v) \le 64 \log 2 + 30$.
4. **Finite Lévy Activity Integrability:**
   Formal proof of `integrable_allPrimeSeed_div_age`: $\int_\mathbb{R} \frac{\text{allPrimeSeed}(v)}{v} dv < \infty$.
5. **Universal $L^2$ Membership:**
   Formal proof of `integrable_allPrimeSeed_square` and `allPrimeSeed_memLp_two`: $\text{allPrimeSeed} \in L^2(\mathbb{R})$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Three-region bound
theorem finite_seed_three_region_bound (S : Finset Nat.Primes) {v : ℝ} (hv : 3 * log 2 ≤ v) :
    finitePrimeSeed S v ≤ (64 * log 2) / v + 5 * exp (-v / 6)

-- Age-weighted pointwise decay
theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30

-- Integrability of age-normalized profile
theorem integrable_allPrimeSeed_div_age : Integrable (fun v => allPrimeSeed v / v)

-- Quadratic majorization
theorem allPrimeSeed_square_tail_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    allPrimeSeed v ^ 2 ≤ (64 * log 2 + 30) * (allPrimeSeed v / v)

-- L^2 integrability
theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2)

-- MemLp 2 membership
theorem allPrimeSeed_memLp_two : MemLp allPrimeSeed 2 volume
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the $L^2(\mathbb{R})$ integrability of the complete arithmetic all-prime seed without truncation or unproved RH/PNT hypotheses.
