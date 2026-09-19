# First Formalization: Successor-Cell Transfer Phase Rigidity and Dyadic Shell Obstruction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCellTransferFinite.lean`](../../formalization/BuildingBlocks/SuccessorCellTransferFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This entry documents a machine-verified proof of phase rigidity and dyadic shell obstructions for finite successor-cell dilation transfer operators:

1. **Exact Multiplicative Semigroup Laws on Successor Cells:**
   Formal proof that integer dilation refines cells via division intervals (`div_eq_iff_child`), satisfies composition $T_{d_1} \circ T_{d_2} = T_{d_1 d_2}$ (`transfer_mul`), and commutes (`transfer_comm`).
2. **Triangular Collar Band Geometry:**
   Formal characterization of collar child overlap $\max(m, d) \le r < \min(2m, 2d)$ (`collar_child_iff`) and existence criterion $m < 2d \land d < 2m$ (`collar_child_exists_iff`).
3. **Algebraic Phase Rigidity at $N = 4$:**
   Formal proof that any scalar sign gauge (`two_three_sign_phase_rigidity`), operator gauge (`two_three_operator_phase_rigidity`), or complex gauge (`two_three_complex_phase_rigidity`) conjugating both 2- and 3-shift transfers is identically trivial $s_2 = s_3 = 1$ and $\chi \equiv 1$ from the fourth cell.
4. **Dyadic Shell Parity Inversion:**
   Formal proof that the binary tree-depth gauge $\chi(n) = (-1)^{\lfloor \log_2 n \rfloor}$ exhibits opposite signs for tripling children of low parents ($-1$) versus high parents ($+1$) within every dyadic shell (`treeTwoGauge_three_low_shell`, `treeTwoGauge_three_high_shell`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Phase rigidity for real scalar signs
theorem two_three_sign_phase_rigidity (N : ℕ) (χ : ℕ → ℝ)
    (s₂ s₃ : ℝ) (hN : 4 ≤ N) (hone : χ 1 = 1)
    (hsquare_two : χ 2 * χ 2 = 1)
    (h₂ : ∀ r, 2 ≤ r → r ≤ N → χ r * χ (r / 2) = s₂)
    (h₃ : ∀ r, 3 ≤ r → r ≤ N → χ r * χ (r / 3) = s₃) :
    s₂ = 1 ∧ s₃ = 1 ∧ ∀ n, 0 < n → n ≤ N → χ n = 1

-- Operator-level phase rigidity
theorem two_three_operator_phase_rigidity (N : ℕ) (χ : ℕ → ℝ)
    (s₂ s₃ : ℝ) (hN : 4 ≤ N) (hone : χ 1 = 1)
    (hsquare_two : χ 2 * χ 2 = 1)
    (hconj₂ : ∀ z : ℕ → ℝ, z 0 = 0 → ∀ r, r ≤ N →
      signGauge χ (transfer N 2 (signGauge χ z)) r =
        s₂ * transfer N 2 z r)
    (hconj₃ : ∀ z : ℕ → ℝ, z 0 = 0 → ∀ r, r ≤ N →
      signGauge χ (transfer N 3 (signGauge χ z)) r =
        s₃ * transfer N 3 z r) :
    s₂ = 1 ∧ s₃ = 1 ∧ ∀ n, 0 < n → n ≤ N → χ n = 1

-- Complex phase rigidity
theorem two_three_complex_phase_rigidity (N : ℕ) (χ : ℕ → ℂ)
    (s₂ s₃ : ℂ) (hN : 4 ≤ N) (hone : χ 1 = 1)
    (hχ2 : χ 2 ≠ 0)
    (h₂ : ∀ r, 2 ≤ r → r ≤ N → χ r = s₂ * χ (r / 2))
    (h₃ : ∀ r, 3 ≤ r → r ≤ N → χ r = s₃ * χ (r / 3)) :
    s₂ = 1 ∧ s₃ = 1 ∧ ∀ n, 0 < n → n ≤ N → χ n = 1

-- Parity inversion within dyadic shells
theorem treeTwoGauge_three_low_shell (k j : ℕ) (hk : 2 ≤ k)
    (hj : j < 3) :
    treeTwoGauge (3 * 2 ^ k + j) * treeTwoGauge (2 ^ k) = -1

theorem treeTwoGauge_three_high_shell (k j : ℕ) (hk : 2 ≤ k)
    (hj : j < 3) :
    treeTwoGauge (3 * (2 ^ (k + 1) - 1) + j) *
      treeTwoGauge (2 ^ (k + 1) - 1) = 1
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof that diagonal phase gauges cannot simultaneously twist the 2- and 3-dilation transfer operators without degenerating to the identity, and demonstrates the exact dyadic boundary mechanism that breaks tree-gauge sign assignments.
