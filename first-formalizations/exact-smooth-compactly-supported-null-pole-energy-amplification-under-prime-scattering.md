# First Formalization: Exact Smooth Compactly Supported Null-Pole Energy Amplification Under Prime Scattering

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactScatteringRegularity.lean`](../../formalization/BuildingBlocks/CompactScatteringRegularity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes regularity inheritance, compact support inheritance, complex moment translation and vanishing inheritance, and constructive energy amplification on smooth null-pole functions in Lean 4:

1. **Regularity and Support Inheritance:**
   Formal proofs that $\text{packet}(L, \eta, c)$ is $C^\infty$ (`packet_contDiff`) and compactly supported (`packet_compact`) whenever $\eta$ is $C_c^\infty$.
2. **Moment Vanishing Inheritance:**
   Formal proof of `complexMoment_translate` and proof that wave packets inherit vanishing complex moments at $s$ (`packet_moment_zero`).
3. **Smooth Null-Pole Prime Energy Amplification Theorem:**
   Formal proof that for any prime $p$ and depth $M \ge 1$, there exists $f \in C_c^\infty(\mathbb{R})$ with vanishing moments at $\pm 1/2$ such that $\|f\|_{L^2}^2 < \|\mathcal{H}_{p^{-1/2}, M, \log p}(f)\|_{L^2}^2$ (`exists_prime_smooth_pole_null_amplification`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Smoothness of synthesized wave packets
theorem packet_contDiff {eta : ℝ → ℂ} (hd : ContDiff ℝ ∞ eta)
    (L : ℝ) (c : ℤ →₀ ℂ) : ContDiff ℝ ∞ (packet L eta c)

-- Compact support of synthesized wave packets
theorem packet_compact {eta : ℝ → ℂ} (hc : HasCompactSupport eta)
    (L : ℝ) (c : ℤ →₀ ℂ) : HasCompactSupport (packet L eta c)

-- Wave packets inherit vanishing complex moments
theorem packet_moment_zero {eta : ℝ → ℂ} (hh : Continuous eta)
    (hc : HasCompactSupport eta) (s : ℝ) (hm : complexMoment eta s = 0)
    (L : ℝ) (c : ℤ →₀ ℂ) : complexMoment (packet L eta c) s = 0

-- Prime energy amplification on smooth null-pole wavelets
theorem exists_prime_smooth_pole_null_amplification (p : ℕ) (hp : p.Prime)
    (M : ℕ) (hM : 1 ≤ M) :
    ∃ f : ℝ → ℂ, HasCompactSupport f ∧ ContDiff ℝ ∞ f ∧
      complexMoment f (1 / 2) = 0 ∧ complexMoment f (-(1 / 2)) = 0 ∧
      BuildingBlocks.CompactScatteringPackets.physicalSquare f <
        BuildingBlocks.CompactScatteringPackets.physicalSquare
          (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that unconstrained prime history scattering amplifies energy even on smooth, compactly supported functions with zero residues at the Riemann zeta poles $s = 0, 1$, demonstrating that proper-cofactor subspace constraints are structurally necessary.
