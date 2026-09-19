# First Formalization in Lean 4: Scattering Multiplier Magnitude and Actual Prime Block Amplitude Bounds

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 Files:** [`formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean), [`formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean)  
**Dependencies:** `BuildingBlocks.ActualScatteringMomentSigns`, `BuildingBlocks.ActualPrimeBlockMellinParity`, `Mathlib.Algebra.Order.BigOperators.GroupWithZero.List`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the scattering theory of prime-scaled dilations and causal multi-prime wavepackets, each prime factor $p$ contributes a pair of opposite-direction scattering multipliers:
\[
W^+(p, h, M) := \text{positive multiplier}, \qquad W^-(p, h, M) := \text{negative multiplier}.
\]
While Formalization 23 established the exact *signs* and *Weil weight parity* ($W^+ < 0, W^- > 0 \implies -W^+ W^- > 0$), a quantitative spectral theory requires **sharp non-asymptotic bounds on the magnitude** of the product multiplier and composite block amplitudes.

Classical literature frequently handles products over prime valuations asymptotically (e.g. Mertens product bounds or Selberg sieve weights) without explicit, finite-length, two-sided geometric bounds valid for arbitrary prime lists and depth functions.

This Lean 4 formalization machine-checks:
1. The exact geometric magnitude bounds for individual prime multipliers:
\[
\frac{(p^h)^M}{8} \le -(W^+(p, h, M) \cdot W^-(p, h, M)) \le 2 (p^h)^M.
\]
2. List induction proving exact exponential-product bounds on composite prime block amplitudes:
\[
\left(\frac{1}{8}\right)^{|ps|} \prod_{p \in ps} p^{h \cdot \mathrm{depth}(p)} \le \operatorname{amplitude}(ps, \mathrm{depth}, h) \le 2^{|ps|} \prod_{p \in ps} p^{h \cdot \mathrm{depth}(p)}.
\]

---

## 2. Machine-Verified Theorems

### 2.1 Single Prime Multiplier Magnitude Bounds

From `BuildingBlocks.ActualScatteringMomentMagnitude`:

```lean
theorem literal_multiplier_magnitude {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    (p ^ h) ^ M / 8 ≤
        -(positiveMultiplier p h M * negativeMultiplier p h M) ∧
      -(positiveMultiplier p h M * negativeMultiplier p h M) ≤
        2 * (p ^ h) ^ M

theorem actual_prime_multiplier_magnitude {p : ℕ} {h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    ((p : ℝ) ^ (h * M)) / 8 ≤
        -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ∧
      -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ≤
        2 * ((p : ℝ) ^ (h * M))
```

### 2.2 Prime Block Amplitude Bounds via List Induction

From `BuildingBlocks.ActualPrimeBlockMagnitude`:

```lean
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

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean
lake env lean formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.ActualScatteringMomentMagnitude.literal_multiplier_magnitude' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualScatteringMomentMagnitude.actual_prime_multiplier_magnitude' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualPrimeBlockMagnitude.actual_block_amplitude_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
```
The formalization contains zero `sorry` placeholders and strictly zero custom axioms.
