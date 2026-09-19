# First Formalization: Exact Physical Block Mellin Scattering and Low-High Frequency Exponential Decoupling

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FullComplexHistoryMellin.lean`](../../formalization/BuildingBlocks/FullComplexHistoryMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact Mellin multiplier action, multiplicative paired weight factorization, and low-high frequency exponential decoupling for physical prime scattering blocks in Lean 4:

1. **Translation and Integrability of Weighted Mellin Forms:**
   Formal proof of `weighted_integrable`, `mellin_translate`, `mellin_const_mul`, and `mellin_add`.
2. **Compact Support and Continuity Preservation:**
   Formal proof of `history_regular` and `block_regular`: preservation of $C_c(\mathbb{R})$ under sequential history operations.
3. **Exact Mellin Multiplier Representation:**
   Formal proof of `history_mellin`, `actual_history_mellin`, and `block_mellin`: identification of the operator action with the complex scattering multiplier $\mathcal{M}_{p, M}(z)$.
4. **Multiplicative Paired Weight Factorization:**
   Formal proof of `actual_history_paired_weight`, `block_paired_weight`, and `finite_prime_block_paired_weight`.
5. **Low-High Frequency Exponential Decoupling:**
   Formal proof of `physical_block_readout_bound` and `physical_block_low_high_bound`: explicit non-asymptotic bound proving exponential quenching of prime perturbations in the interior critical strip $|\text{Re}(z)| \le 1/2 - \delta$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact Mellin multiplier action for single prime channel
theorem actual_history_mellin (p : ℕ) (hp : 2 ≤ p) {f : ℝ → ℂ}
    (hh : Continuous f) (hc : HasCompactSupport f) (M : ℕ) (z : ℂ) :
    mellin (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) z =
      GrowingPrimeScatteringBounds.originalHistory (p : ℝ) z M * mellin f z

-- Exact multiplicative factorization for finite prime blocks
theorem finite_prime_block_paired_weight {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p) (M : ℕ) (z : ℂ) :
    pairedWeight (blockPhysical s.toList M f) (blockPhysical s.toList M g) z =
      (∏ p ∈ s, GrowingPrimeScatteringBounds.paired p z M) * pairedWeight f g z

-- Low-high frequency exponential decoupling in the critical strip
theorem physical_block_low_high_bound {ι : Type*} {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p)
    (P : ℝ) (hP : 1 < P) (hPs : ∀ p ∈ s, P ≤ p) (M : ℕ)
    (z : ι → ℂ) (hz : ∀ i, |(z i).re| ≤ 1 / 2)
    (hw : Summable (fun i => ‖pairedWeight f g (z i)‖)) (low : Set ι)
    (delta : ℝ) (hd : 0 < delta)
    (hlow : ∀ i ∈ low, |(z i).re| ≤ 1 / 2 - delta) :
    let B := Real.exp (-(M : ℝ) * (delta * Real.log P)) *
      ((1 + delta * Real.log P) / (delta * Real.log P))
    ‖(∑' i, pairedWeight (blockPhysical s.toList M f) (blockPhysical s.toList M g) (z i)) -
        (∑' i, pairedWeight f g (z i))‖ ≤
      (Real.exp ((s.card : ℝ) * (2 * B + B ^ 2)) - 1) * (∑' i : low, ‖pairedWeight f g (z i)‖) +
        ((3 : ℝ) ^ s.card + 1) * (∑' i : ↑(lowᶜ), ‖pairedWeight f g (z i)‖)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 connecting physical compactly supported wavefunctions to complex spectral readouts in the critical strip, establishing non-asymptotic exponential decoupling of prime scattering channels via memory depth $M$.
