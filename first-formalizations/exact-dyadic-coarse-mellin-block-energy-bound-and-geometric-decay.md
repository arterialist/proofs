# First Formalization: Exact Dyadic Coarse Mellin Block Energy Bound and Geometric Decay

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseDyadicBound.lean`](../../formalization/BuildingBlocks/CoarseDyadicBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the dyadic block energy bounds and the uniform geometric decay of arithmetic error Mellin blocks in the half-plane $\text{Re}(s) > 1/2$ in Lean 4:

1. **Dyadic Block Energy Bound:**
   Formal proof of `coarsePrime_mellin_norm_le`:
   $$
   \left\| \int_X^{2X} \Delta(x) x^{-(s+1)} dx \right\| \le \sqrt{\frac{2 E(X)}{X}} X^{-(a+1)} + \|s+1\| X^{-(a+2)} \sqrt{X E(X)}.
   $$
2. **Negative Power Exponent:**
   Formal proof of `coarseMellinBlock_power_bound`: $\|\text{coarseMellinBlock}(k, s)\| \le M (2^k)^b$ with $b = (1/2 - a)/2 < 0$.
3. **Grand Geometric Decay Theorem:**
   Formal proof of `coarseMellinBlock_geometric_bound`:
   $$
   \|\text{coarseMellinBlock}(k, s)\| \le M \cdot r^k \quad \text{with } r = 2^{(1/2-a)/2} < 1,
   $$
   holding uniformly on compact subsets of the half-plane $\text{Re}(s) > 1/2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Fundamental norm bound for the localized dyadic Mellin block
lemma coarsePrime_mellin_norm_le {X a : ℝ} (hX : 1 ≤ X) (ha : 0 ≤ a)
    {s : ℂ} (hs : a ≤ s.re) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * X ^ (-(a + 1)) +
      ‖s + 1‖ * (X ^ (-(a + 2)) * Real.sqrt (X * coarsePrimitiveSquare X))

-- Decoupled negative power bound on dyadic blocks
lemma coarseMellinBlock_power_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M b : ℝ, 0 < M ∧ b < 0 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R →
      ‖coarseMellinBlock k s‖ ≤ M * ((2 : ℝ) ^ k) ^ b

-- Grand geometric decay theorem for dyadic Mellin blocks
lemma coarseMellinBlock_geometric_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the geometric decay $\|\text{coarseMellinBlock}(k, s)\| \le M r^k$ of dyadic arithmetic Mellin blocks with explicit ratio $r = 2^{(1/2-a)/2} < 1$, rigorously bridging $L^2$ primitive energy bounds with normal convergence and holomorphy of Mellin transforms in $\text{Re}(s) > 1/2$.
