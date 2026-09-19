# First Formalization: Composite Prime-Block Scattering Amplitude Magnitude Sandwich

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact two-sided geometric-exponential sandwich controlling the magnitude of composite prime scattering amplitudes in Lean 4:

1. **Two-Sided Geometric Sandwich:**
   Formal derivation that $(1/8)^{|ps|} \prod_{p \in ps} p^{h \cdot \text{depth}(p)} \le \mathcal{A}(ps, \text{depth}, h) \le 2^{|ps|} \prod_{p \in ps} p^{h \cdot \text{depth}(p)}$ (`actual_block_amplitude_bounds`).
2. **List Induction on Prime Chains:**
   Formal inductive propagation of two-sided multiplicative bounds across composite prime blocks.
3. **Non-Asymptotic Universality:**
   Holds for all prime blocks, all depths $\ge 1$, and all moments $h \ge 1$, with no limit processes or approximations.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Two-sided amplitude magnitude bounds
theorem actual_block_amplitude_bounds (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) :
    (1 / 8 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod ≤
      amplitude ps depth h ∧
    amplitude ps depth h ≤
      (2 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 of two-sided geometric-exponential bounds on composite prime scattering amplitudes, trapping $\mathcal{A}$ within a factor of $16^{|ps|}$ around the exact prime power product $\prod p^{h d(p)}$.
