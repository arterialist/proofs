# First Formalization: Exact Möbius–Stokes Two-Face Boundary Algebra and Prime Dilation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean`](../../formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact finite Möbius–Stokes boundary identities, prime dilation splitting, and observation prefix algebra in Lean 4:

1. **Abel–Stokes Observation Identity:**
   Formal proof of `finite_abel_identity` and `finite_stokes_observed`: exact expansion of future observation prefixes.
2. **Divisor Renewal Mass:**
   Formal proof of `complete_moebius_divisor_renewal`: $\sum_{d \le N} \mu(d) \lfloor N/d \rfloor = 1$.
3. **Prime Dilation Reindexing:**
   Formal proof of `moebius_prime_mul_of_not_dvd`, `moebius_eq_zero_of_prime_sq_dvd`, and `primitive_multiples_reindex`.
4. **Unconditional Prime Dilation Splitting:**
   Formal proof of `bulkMass_eq_notDvd_add_primitive` and `bulkMass_prime_split`.
5. **Exact Two-Face Boundary Cancellation:**
   Formal proof of `notDvd_interval_two_face`, `prime_dilation_two_face`, and `prime_dilation_two_face_expanded`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact primitive multiples bijection and sign flip
theorem primitive_multiples_reindex {p D N : ℕ} (hp : p.Prime) :
    (∑ d ∈ primitiveMultiples p D N, ArithmeticFunction.moebius d) =
      -(∑ m ∈ primitiveCofactors p D N, ArithmeticFunction.moebius m)

-- Unconditional prime dilation split into nondivisible faces
theorem bulkMass_prime_split {p D N : ℕ} (hp : p.Prime) :
    bulkMass D N = notDvdFace p D N - notDvdFace p (D / p) (N / p)

-- Exact two-face discrete boundary Stokes identity
theorem prime_dilation_two_face {p D N : ℕ} (hp : p.Prime) (hDN : D ≤ N) :
    bulkMass D N =
      notDvdFace p (Nat.max D (N / p)) N -
        notDvdFace p (D / p) (Nat.min D (N / p))

-- Exact observed Stokes prefix identity
theorem finite_stokes_observed (F : ℕ → R) (q : R) (n : ℕ) :
    (1 - q) * futurePrefix F (n + 1) q =
      (1 - q) ^ 2 * (∑ i ∈ Finset.range n, charge F (i + 1) * q ^ i) +
        (1 - q) * charge F (n + 1) * q ^ n
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the exact two-face discrete Stokes boundary identity for the Möbius function under prime dilation, eliminating bulk interior terms via primitive cofactor bijections.
