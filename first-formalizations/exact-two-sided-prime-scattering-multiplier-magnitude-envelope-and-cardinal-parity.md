# First Formalization: Exact Two-Sided Prime Scattering Multiplier Magnitude Envelope and Cardinal Parity

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ActualScatteringMomentSigns.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentSigns.lean), [`formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact sign structure, cardinal parity law, and non-asymptotic power magnitude envelope for two-sided prime scattering multipliers in Lean 4:

1. **Strict Opposite Signs:**
   Formal proof that $\mathcal{P}_p^+ < 0$ and $\mathcal{P}_p^- > 0$, forcing $\mathcal{P}_p^+ \mathcal{P}_p^- < 0$ (`literal_multiplier_signs`, `actual_prime_multiplier_product_negative`).
2. **Cardinal Parity Law:**
   Formal derivation of $\prod_{p \in B} A(p) = (-1)^{|B|} \prod_{p \in B} (-A(p))$ with $\prod (-A(p)) > 0$ (`actual_prime_block_product_parity`).
3. **Universal Power Envelope:**
   Formal proof that $\frac{1}{8} p^{hM} \le -(\mathcal{P}_p^+ \mathcal{P}_p^-) \le 2 p^{hM}$ with universal constants $1/8$ and $2$ (`literal_multiplier_magnitude`, `actual_prime_multiplier_magnitude`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Opposite signs
theorem literal_multiplier_signs {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier p h M < 0 ∧ 0 < negativeMultiplier p h M

-- Cardinal parity law
theorem actual_prime_block_product_parity (B : Finset ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ B, p.Prime)
    (hdepth : ∀ p ∈ B, 1 ≤ depth p) :
    let A := fun (p : ℕ) => positiveMultiplier (p : ℝ) h (depth p) *
      negativeMultiplier (p : ℝ) h (depth p)
    (0 < ∏ p ∈ B, -A p) ∧
      (∏ p ∈ B, A p) = (-1 : ℝ) ^ B.card * ∏ p ∈ B, -A p

-- Non-asymptotic power envelope
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

This entry documents a machine-verified proof in Lean 4 establishing the cardinal parity law $\operatorname{sgn}(\prod A(p)) = (-1)^{|B|}$ and universal non-asymptotic pinching $\frac{1}{8} p^{hM} \le -A(p) \le 2 p^{hM}$ for prime scattering multipliers.
