# First Formalization: Exact Two-Sided Scattering Moment Signs and Single-Prime Magnitude Bounds

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ActualScatteringMomentSigns.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentSigns.lean), [`formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the strict sign alternation of positive and negative Mellin scattering multipliers, product negativity, finite prime-block parity factorization $(-1)^{|B|}$, and two-sided single-prime magnitude bounds in Lean 4:

1. **Sign Alternation:**
   Formal proof that $\mu^+ < 0$ and $\mu^- > 0$ (`literal_multiplier_signs`).
2. **Product Negativity:**
   Formal derivation of $\mu^+ \mu^- < 0$ for every prime $p$ (`actual_prime_multiplier_product_negative`).
3. **Block Parity Factorization:**
   Formal proof of $\prod (\mu^+ \mu^-) = (-1)^{|B|} \prod (-\mu^+ \mu^-)$ with positive magnitude product (`actual_prime_block_product_parity`).
4. **Single-Prime Magnitude Bounds:**
   Formal proof that $\frac{1}{8} p^{hM} \le -(\mu^+ \mu^-) \le 2 p^{hM}$ (`literal_multiplier_magnitude`, `actual_prime_multiplier_magnitude`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Sign opposition of two-sided scattering multipliers
theorem literal_multiplier_signs {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier p h M < 0 ∧ 0 < negativeMultiplier p h M

-- Product negativity
theorem actual_prime_multiplier_product_negative {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M < 0

-- Finite block parity factorization
theorem actual_prime_block_product_parity (B : Finset ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ B, p.Prime)
    (hdepth : ∀ p ∈ B, 1 ≤ depth p) :
    let A := fun (p : ℕ) => positiveMultiplier (p : ℝ) h (depth p) *
      negativeMultiplier (p : ℝ) h (depth p)
    (0 < ∏ p ∈ B, -A p) ∧
      (∏ p ∈ B, A p) = (-1 : ℝ) ^ B.card * ∏ p ∈ B, -A p

-- Single-prime two-sided magnitude bounds
theorem actual_prime_multiplier_magnitude {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    ((p : ℝ) ^ (h * M)) / 8 ≤
        -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ∧
      -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ≤
        2 * (p : ℝ) ^ (h * M)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving exact sign opposition $\mu^+ < 0 < \mu^-$ and two-sided power bounds $\frac{1}{8} p^{hM} \le -\mu^+ \mu^- \le 2 p^{hM}$ for prime-scattering Mellin multipliers.
