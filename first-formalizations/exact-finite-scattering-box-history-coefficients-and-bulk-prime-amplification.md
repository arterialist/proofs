# First Formalization: Exact Finite Scattering Box History Coefficients and Bulk Prime Amplification

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactScatteringCoefficients.lean`](../../formalization/BuildingBlocks/CompactScatteringCoefficients.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic factorization of scattering history coefficients on interior lattice sites and proves unconditional bulk prime amplification in Lean 4:

1. **Exact Interior History Formula:**
   Formal proof of `history_box_interior`: $\text{historyCoefficient}(r, M, \text{box}(q, J))(k) = q^{-k} [-rq + (1-r^2)\sum_{m=0}^{M-1}(rq^{-1})^m]$.
2. **Phase Factorization on the Circle:**
   Formal proof of `history_phase_box_interior`: $\text{historyCoefficient}(r, M, \text{box}(e^{i\theta}, J))(k) = e^{-ik\theta} \text{compactPhase}(r, \theta, M)$.
3. **Pointwise Bulk Energy Invariance:**
   Formal proof of `history_phase_box_normSq`: Modulus squared equals $|\text{compactPhase}(r, \theta, M)|^2$ uniformly across all $1 \le k \le J - M$.
4. **Unconditional Bulk Prime Amplification:**
   Formal proof of `prime_interior_amplification`: Strictly super-unitary intensity $> 1$ for all primes $p$ at reflection $r = 1/\sqrt{p}$ and resonance $\theta = \pi/M$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact interior history coefficient formula
theorem history_box_interior (r : ℝ) (q : ℂ) (hq : q ≠ 0) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    historyCoefficient r M (box q J) k = q ^ (-k) *
      (-(r : ℂ) * q + (1 - (r : ℂ) ^ 2) *
        ∑ m ∈ Finset.range M, ((r : ℂ) * q⁻¹) ^ m)

-- Phase circle factorization
theorem history_phase_box_interior (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    historyCoefficient r M (box (phase theta) J) k =
      (phase theta) ^ (-k) * compactPhase r theta M

-- Bulk intensity invariance
theorem history_phase_box_normSq (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    Complex.normSq (historyCoefficient r M (box (phase theta) J) k) =
      Complex.normSq (compactPhase r theta M)

-- Strict super-unitary bulk prime amplification
theorem prime_interior_amplification (p : ℕ) (hp : p.Prime)
    (J M : ℕ) (hM : 1 ≤ M) (k : ℤ) (hk : 1 ≤ k)
    (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    1 < Complex.normSq (historyCoefficient (1 / Real.sqrt (p : ℝ)) M
      (box (phase (Real.pi / (M : ℝ))) J) k)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the exact bulk factorization of scattering history operators on finite phase boxes and proving that every prime $p$ generates strictly super-unitary amplification across the interior of the scattering lattice.
