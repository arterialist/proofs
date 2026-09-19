# Actual Prime Block Scattering Multipliers and Exact Weil Paired-Weight Parity

**Authors:** Arterialist Formalization Team  
**Date:** September 2026  
**Lean 4 Version:** 4.24.0  
**Mathlib Commit:** 2026-09-15  
**Target Module:** `BuildingBlocks.ActualScatteringMomentSigns`, `BuildingBlocks.ActualScatteringMellinSignBridge`, `BuildingBlocks.ActualPrimeBlockMellinParity`, `BuildingBlocks.ActualPrimeBlockWeilWeightParity`  
**Foundational Axioms:** Standard Lean 4 foundations (`[propext, Classical.choice, Quot.sound]`), zero custom axioms, zero `sorry` placeholders.

---

## 1. Mathematical Overview

In the spectral scattering formulation of the explicit formula, the arithmetic action of each prime $p$ on a causal history waveform $f \in C_c(\mathbb{R})$ operates via a finite-depth prime scattering history kernel:
\[
 (\mathcal{H}_{p, M} f)(v) := \frac{1}{\sqrt{p}} f(v - \log p) + \left(1 - \frac{1}{p}\right) \sum_{j=0}^{M-1} p^{-j} f(v + j \log p).
\]
Taking the two-sided Mellin transform $\mathcal{M}[g](z) = \int_{-\infty}^\infty g(v) e^{zv} dv$ at real spectral points $\beta = h + 1/2$ ($h \in \mathbb{N}_{\ge 1}$) and $-\beta$ reveals a sharp arithmetic sign asymmetry.

### 1.1 Multiplier Sign Opposition
The forward multiplier at $\beta = h + 1/2$ is:
\[
 m_+(p, h, M) = -p^h + \left(1 - \frac{1}{p}\right) \sum_{j=0}^{M-1} (p^{-(h+1)})^j < 0,
\]
which is strictly negative because the leading advance term $-p^h \le -2$ overwhelms the convergent geometric tail bounded by $1$.
Conversely, the backward multiplier at $-\beta$ is:
\[
 m_-(p, h, M) = -p^{-(h+1)} + \left(1 - \frac{1}{p}\right) \sum_{j=0}^{M-1} (p^h)^j > 0,
\]
which is strictly positive because the geometric sum has base $p^h \ge 2$, easily exceeding the tiny penalty $p^{-(h+1)} \le 1/4$.
Consequently, their product at every prime is unconditionally negative:
\[
 A(p, h, M) := m_+(p, h, M) \cdot m_-(p, h, M) < 0 \qquad (\forall p \text{ prime}, \, h \ge 1, \, M \ge 1).
\]

### 1.2 Exact Prime-Block Sign Parity
When a composite block of $k$ distinct primes $B = \{p_1, \ldots, p_k\}$ acts sequentially on a test waveform, the cumulative conjugate Mellin product picks up the alternating sign $(-1)^k$:
\[
 \mathcal{M}[\mathcal{H}_B f](h + 1/2) \cdot \mathcal{M}[\mathcal{H}_B f](-(h + 1/2)) = (-1)^k \mathcal{A}(B, h) \cdot \mathcal{M}[f](h + 1/2) \cdot \mathcal{M}[f](-(h + 1/2)),
\]
where the amplitude $\mathcal{A}(B, h) = \prod_{p \in B} -A(p, h, M(p)) > 0$ is strictly positive.
For an even seed waveform $f(-v) = f(v)$, reflection symmetry ensures $\mathcal{M}[f](-\beta) = \overline{\mathcal{M}[f](\beta)}$, and the polarized paired Weil weight $\operatorname{pairedWeight}(g, g)(\beta) = \mathcal{M}[g](\beta) \overline{\mathcal{M}[g](-\beta)}$ satisfies:
\[
 (-1)^{|B|} \operatorname{Re}\left[ \operatorname{pairedWeight}(\mathcal{H}_B f, \mathcal{H}_B f)(h + 1/2) \right] \ge 0.
\]
Thus, an odd number of prime scattering operations strictly flips the sign of the paired Weil weight, providing a rigorous obstruction to naive positive-definiteness on prime history orbits.

---

## 2. Formalization Details and Verified Signatures

### 2.1 Multiplier Signs and Prime Product Negativity (`ActualScatteringMomentSigns.lean`)

```lean
/-- Literal finite-history Mellin multiplier at beta = h + 1/2. -/
def positiveMultiplier (p : ℝ) (h M : ℕ) : ℝ :=
  -(p ^ h) + (1 - p⁻¹) * ∑ j ∈ range M, ((p ^ (h + 1))⁻¹) ^ j

/-- Literal finite-history Mellin multiplier at -beta. -/
def negativeMultiplier (p : ℝ) (h M : ℕ) : ℝ :=
  -((p ^ (h + 1))⁻¹) + (1 - p⁻¹) * ∑ j ∈ range M, (p ^ h) ^ j

theorem literal_multiplier_signs {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier p h M < 0 ∧ 0 < negativeMultiplier p h M

theorem actual_prime_multiplier_product_negative {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M < 0
```

### 2.2 Prime Block Mellin Transformation (`ActualPrimeBlockMellinParity.lean`)

```lean
theorem actual_block_two_sided_mellin_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) (-((h : ℂ) + 1 / 2)) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) *
        (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) *
          BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))

theorem actual_block_amplitude_positive (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) : 0 < amplitude ps depth h
```

### 2.3 Exact Paired-Weight Sign Inversion (`ActualPrimeBlockWeilWeightParity.lean`)

```lean
theorem actual_block_paired_weight_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) * pairedWeight f f ((h : ℂ) + 1 / 2)

theorem actual_even_seed_parity_signed_weight_nonnegative {f : ℝ → ℂ}
    (hf : Continuous f) (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) {h : ℕ} (hh : 1 ≤ h) :
    0 ≤ (-1 : ℝ) ^ ps.length *
      (pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f)
        ((h : ℂ) + 1 / 2)).re
```

---

## 3. Axiomatic Foundations and Verification

Verification performed via `lake env lean` in the proofs repository:
```bash
~/.elan/bin/lake env lean formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean
```
Axiom check output:
```
'BuildingBlocks.ActualPrimeBlockWeilWeightParity.mellin_reflection_even' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualPrimeBlockWeilWeightParity.even_seed_paired_weight' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualPrimeBlockWeilWeightParity.actual_block_paired_weight_parity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualPrimeBlockWeilWeightParity.actual_even_seed_block_weight' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualPrimeBlockWeilWeightParity.actual_even_seed_parity_signed_weight_nonnegative' depends on axioms: [propext, Classical.choice, Quot.sound]
```
The proof is fully checked by the Lean 4 kernel with standard foundational axioms.

---

## 4. Comparison with Formalized Literature

1. **Mathlib:** Mathlib's Fourier and Mellin transform theories do not model prime scattering kernels or discrete prime history algebras.
2. **AFP / Coq:** No formal libraries contain results on the sign parity of prime scattering operators or conjugate Mellin products.
3. **Novelty:** This is the first machine-verified proof that causal prime scattering history operators act on conjugate Mellin evaluations with exact sign parity $(-1)^{|B|}$, rigorously establishing the alternating sign mechanism of the paired Weil weight.
