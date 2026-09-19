# Unique Contribution 98: Exact Two-Sided Physical Scattering Mellin Bridge and History Dictionaries

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualScatteringMellinSignBridge.lean`](../../formalization/BuildingBlocks/ActualScatteringMellinSignBridge.lean), [`formalization/BuildingBlocks/FullComplexHistoryMellin.lean`](../../formalization/BuildingBlocks/FullComplexHistoryMellin.lean), [`formalization/BuildingBlocks/ActualScatteringMomentSigns.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentSigns.lean)  
**Classification:** Analytic Number Theory / Scattering Operators / Mellin Transforms / Two-Sided Moment Signs

---

## 1. Executive Summary and Mathematical Statement

In the spectral theory of prime scattering operators acting on test wave packets $f \in C_c(\mathbb{R}, \mathbb{C})$, the preservation of Weil quadratic positivity requires understanding how the Mellin transform $\mathcal{M}(f)(s)$ behaves under the scattering evolution across the reflection symmetry $s \mapsto -s$.

This contribution proves:

1. **Positive History Dictionary:**  
   For any prime scale $p \ge 2$, integer moment index $h \in \mathbb{N}$, and truncation depth $M$:
   \[
   \mathcal{H}_p\left(h + \frac{1}{2}, M\right) = \mathcal{P}_p^+(h, M) = p^h \sum_{j=0}^M \left( \frac{1}{p^{h+1}} \right)^j.
   \]
2. **Negative History Dictionary:**  
   At the reflected moment point $s = -(h + 1/2)$:
   \[
   \mathcal{H}_p\left(-\left(h + \frac{1}{2}\right), M\right) = \mathcal{P}_p^-(h, M) = \frac{1}{p^{h+1}} \sum_{j=0}^M (p^h)^j.
   \]
3. **Exact Two-Sided Physical Scattering Mellin Factorization:**  
   For any prime $p \ge 2$ and any continuous test carrier with compact support $f \in C_c(\mathbb{R}, \mathbb{C})$, the two-sided product of Mellin moments of the scattered wave packet $\mathcal{S}_{p, M} f$ satisfies the exact factorization:
   \[
   \mathcal{M}(\mathcal{S}_{p, M} f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(\mathcal{S}_{p, M} f)\left(-\left(h + \frac{1}{2}\right)\right) = \left( \mathcal{P}_p^+(h, M) \cdot \mathcal{P}_p^-(h, M) \right) \cdot \left[ \mathcal{M}(f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(f)\left(-\left(h + \frac{1}{2}\right)\right) \right].
   \]
4. **Spectral Moment Sign Invariance:**  
   Because $\mathcal{P}_p^+(h, M) > 0$ and $\mathcal{P}_p^-(h, M) > 0$ are strictly positive real numbers, the two-sided Mellin product sign:
   \[
   \operatorname{sgn}\left( \mathcal{M}(\mathcal{S}_{p, M} f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(\mathcal{S}_{p, M} f)\left(-\left(h + \frac{1}{2}\right)\right) \right) = \operatorname{sgn}\left( \mathcal{M}(f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(f)\left(-\left(h + \frac{1}{2}\right)\right) \right)
   \]
   is invariant under the physical scattering transformation for all primes $p$, depths $M$, and moments $h$.

---

## 2. Mathematical Proof

### 2.1. Complex History Multplier Specialization
The full complex history multiplier is:
\[
\mathcal{H}_p(s, M) = p^{s - 1/2} \sum_{j=0}^M p^{-j(s + 1/2)}.
\]
- At $s = h + 1/2$: $s - 1/2 = h$ and $-(s + 1/2) = -(h + 1)$, so $p^{s-1/2} = p^h$ and $p^{-j(s+1/2)} = (p^{-(h+1)})^j$, matching $\mathcal{P}_p^+(h, M)$.
- At $s = -(h + 1/2)$: $s - 1/2 = -(h + 1)$ and $-(s + 1/2) = -(-h) = h$, so $p^{s-1/2} = p^{-(h+1)}$ and $p^{-j(s+1/2)} = (p^h)^j$, matching $\mathcal{P}_p^-(h, M)$.

### 2.2. Two-Sided Mellin Evaluation
By the physical scattering Mellin theorem (`actual_history_mellin`), $\mathcal{M}(\mathcal{S}_{p, M} f)(s) = \mathcal{H}_p(s, M) \mathcal{M}(f)(s)$.
Multiplying the evaluations at $s = h + 1/2$ and $s = -(h + 1/2)$ and substituting the dictionaries yields the product factorization.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualScatteringMellinSignBridge`):
```lean
theorem positive_history_dictionary (p : ℝ) (h M : ℕ) :
    originalHistory p ((h : ℂ) + 1 / 2) M =
      (positiveMultiplier p h M : ℂ)

theorem negative_history_dictionary (p : ℝ) (h M : ℕ) :
    originalHistory p (-((h : ℂ) + 1 / 2)) M =
      (negativeMultiplier p h M : ℂ)

theorem actual_physical_two_sided_mellin (p h M : ℕ) (hp : p.Prime)
    {f : ℝ → ℂ} (hf : Continuous f) (hc : HasCompactSupport f) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (BuildingBlocks.CompactScatteringOperator.historyPhysical
      (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (BuildingBlocks.CompactScatteringOperator.historyPhysical
      (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) (-((h : ℂ) + 1 / 2)) =
    ((positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M : ℝ) : ℂ) *
      (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) * BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Mellin transforms of wave packets under unitary scattering are classical in harmonic analysis. However, the exact dictionary matching between complex history series and real discrete multipliers with strict two-sided moment sign preservation under physical prime scattering is novel.
- **Advancement:** Establishes machine-verified two-sided Mellin moment sign invariance under prime scattering operators.
- **Target Venues:** *Journal of Functional Analysis* or *Integral Equations and Operator Theory*.
