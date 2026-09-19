# First Formalization: All-Prime Seed Three-Region Decomposition and L² Square Integrability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeSquare.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the three-region prime decomposition, universal age bounds, and unconditional $L^2(\mathbb{R})$ square integrability of the collective prime seed in Lean 4:

1. **Three-Region Bound:**
   Formal derivation of $\operatorname{finitePrimeSeed}(S, v) \le \frac{64\log 2}{v} + 5 e^{-v/6}$ (`finite_seed_three_region_bound`).
2. **Universal Age Bound:**
   Formal proof that $v \cdot \operatorname{allPrimeSeed}(v) \le 64\log 2 + 30$ (`allPrimeSeed_age_bound`).
3. **Square Tail Dominance:**
   Formal proof that $(\operatorname{allPrimeSeed}(v))^2 \le (64\log 2 + 30) \frac{\operatorname{allPrimeSeed}(v)}{v}$ (`allPrimeSeed_square_tail_bound`).
4. **Unconditional $L^2$ Membership:**
   Formal proof that $\operatorname{allPrimeSeed} \in L^2(\mathbb{R}, \operatorname{volume})$ (`allPrimeSeed_memLp_two`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Three-region decomposition bound
theorem finite_seed_three_region_bound (S : Finset Nat.Primes) {v : ℝ} (hv : 3 * log 2 ≤ v) :
    finitePrimeSeed S v ≤ (64 * log 2) / v + 5 * exp (-v / 6)

-- Universal age bound
theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30

-- Square tail dominance by Lévy density
theorem allPrimeSeed_square_tail_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    allPrimeSeed v ^ 2 ≤ (64 * log 2 + 30) * (allPrimeSeed v / v)

-- Integrability of the squared seed
theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2)

-- Unconditional L^2 membership
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

This entry documents a machine-verified proof in Lean 4 of the unconditional $L^2(\mathbb{R})$ membership of the all-prime seed function, proved from elementary Chebyshev bounds without assuming PNT or RH.
