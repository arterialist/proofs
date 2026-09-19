# Unique Contribution 296: Exact Physical Block Mellin Scattering and Low-High Frequency Exponential Decoupling

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FullComplexHistoryMellin.lean`](../../formalization/BuildingBlocks/FullComplexHistoryMellin.lean), [`building-blocks/compact-scattering/full-complex-history-mellin.md`](../../building-blocks/compact-scattering/full-complex-history-mellin.md)  
**Classification:** Spectral Theory / Scattering Operators / Mellin Transforms / Prime Channel Decoupling / Exponential Error Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral scattering formulation of the physical Riemann operator, the interaction between test profiles $f, g \in C_c(\mathbb{R})$ and finite collections of prime scattering channels $s \subset \{p \ge P\}$ is governed by sequential history modifications:
\[
\text{blockPhysical}(s, M, f) = \prod_{p \in s}^\circ \mathcal{S}_{p, M} f.
\]
A central problem in resolving the spectral zeros of the scattering system is proving that prime channels decouple exponentially from the interior of the critical strip $|\text{Re}(z)| \le 1/2 - \delta$ as the memory depth $M \to \infty$.

This contribution proves:

1. **Spectral Readout Low-High Frequency Decomposition:**  
   Let $s$ be a finite set of primes with $p \ge P > 1$, and let $\{z_i\}_{i \in I}$ be any discrete spectral sequence in the critical strip $|\text{Re}(z_i)| \le 1/2$ such that $\sum_i \|\mathcal{W}(f, g)(z_i)\| < \infty$. For any interior low-frequency subset $\text{low} \subset I$ where $|\text{Re}(z_i)| \le 1/2 - \delta$ ($\delta > 0$), the total spectral perturbation is bounded by:
   \[
   \left\| \sum_{i \in I} \mathcal{W}(\mathcal{S}_s f, \mathcal{S}_s g)(z_i) - \sum_{i \in I} \mathcal{W}(f, g)(z_i) \right\| \le (e^{|s|(2B+B^2)} - 1) \sum_{i \in \text{low}} \|\mathcal{W}(f, g)(z_i)\| + (3^{|s|} + 1) \sum_{i \in \text{high}} \|\mathcal{W}(f, g)(z_i)\|,
   \]
   where $B = e^{-M \delta \log P} \frac{1 + \delta \log P}{\delta \log P}$.
2. **Exponential Decoupling in the Interior:**  
   Because $B = O(P^{-M\delta})$, the low-frequency coefficient $(e^{|s|(2B+B^2)} - 1) \to 0$ exponentially fast as $M \to \infty$, proving that deep memory completely quenches prime scattering interference in the strip interior.
3. **Exact Multiplicative Paired Weight Factorization:**  
   For any smooth compactly supported profiles $f, g \in C_c(\mathbb{R})$:
   \[
   \mathcal{W}(\text{blockPhysical}(s, M, f), \text{blockPhysical}(s, M, g))(z) = \left( \prod_{p \in s} \mathcal{M}_{p, M}(z)\mathcal{M}_{p, M}(-z) \right) \mathcal{W}(f, g)(z).
   \]
4. **Exact Action on Mellin Transforms:**  
   The physical scattering operator $\mathcal{S}_{p, M}$ acts on the Mellin transform $\widehat{f}(z) = \int_\mathbb{R} f(v) e^{zv} dv$ by exact pointwise multiplier multiplication:
   \[
   \widehat{\mathcal{S}_{p, M} f}(z) = \mathcal{M}_{p, M}(z) \widehat{f}(z).
   \]
5. **Regularity Preservation:**  
   The physical prime block operator maps $C_c(\mathbb{R})$ into $C_c(\mathbb{R})$, preserving continuity and compact support across arbitrary finite prime blocks.

---

## 2. Mathematical Proof

### 2.1. Translation and Mellin Multipliers
For a shift $f_d(v) = f(v - d)$:
\[
\widehat{f_d}(z) = \int_\mathbb{R} f(v-d) e^{zv} dv = e^{zd} \int_\mathbb{R} f(u) e^{zu} du = e^{zd} \widehat{f}(z).
\]
Applying this to the physical history formula:
\[
\mathcal{S}_{r, M, L} f(v) = -r f(v - L) + (1 - r^2) \sum_{m=0}^{M-1} r^m f(v + m L).
\]
Taking Mellin transforms:
\[
\widehat{\mathcal{S}_{r, M, L} f}(z) = \left( -r e^{z L} + (1 - r^2) \sum_{m=0}^{M-1} r^m e^{-m z L} \right) \widehat{f}(z) = \mathcal{M}(r, e^{zL}, e^{-zL}, M) \widehat{f}(z).
\]
Setting $r = 1/\sqrt{p}$ and $L = \log p$ recovers the arithmetic multiplier $\mathcal{M}_{p, M}(z)$.

### 2.2. Multiplicative Paired Weight
The paired weight is defined as $\mathcal{W}(f, g)(z) = \widehat{f}(z) \overline{\widehat{g}(-\bar{z})}$.
Since $\overline{\mathcal{M}_{p, M}(-\bar{z})} = \mathcal{M}_{p, M}(-z)$ (due to real coefficients):
\[
\mathcal{W}(\mathcal{S} f, \mathcal{S} g)(z) = \mathcal{M}_{p, M}(z) \widehat{f}(z) \cdot \mathcal{M}_{p, M}(-z) \overline{\widehat{g}(-\bar{z})} = \mathcal{M}_{p, M}(z)\mathcal{M}_{p, M}(-z) \mathcal{W}(f, g)(z).
\]
Iterating over all $p \in s$ gives the product formula.

### 2.3. Low-High Frequency Splitting
Using the critical strip uniform bounds (Unique Contribution 285):
- In the low region $|\text{Re}(z)| \le 1/2 - \delta$, the defect $|\mathcal{M}_{p, M}(z)\mathcal{M}_{p, M}(-z) - 1| \le 2B + B^2$ where $B = e^{-M\delta \log P} \frac{1+\delta\log P}{\delta\log P}$.
  Product telescoping gives $|\prod_{p \in s} \mathcal{M}_p(z)\mathcal{M}_p(-z) - 1| \le e^{|s|(2B+B^2)} - 1$.
- In the high region, each multiplier satisfies $|\mathcal{M}_p(z)\mathcal{M}_p(-z)| \le 3$, giving the trivial bound $3^{|s|} + 1$.
Combining the sums yields the claimed theorem.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FullComplexHistoryMellin` in `formalization/BuildingBlocks/FullComplexHistoryMellin.lean`):
```lean
theorem actual_history_mellin (p : ℕ) (hp : 2 ≤ p) {f : ℝ → ℂ}
    (hh : Continuous f) (hc : HasCompactSupport f) (M : ℕ) (z : ℂ) :
    mellin (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) z =
      GrowingPrimeScatteringBounds.originalHistory (p : ℝ) z M * mellin f z

theorem finite_prime_block_paired_weight {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : Finset ℕ) (hs : ∀ p ∈ s, 2 ≤ p) (M : ℕ) (z : ℂ) :
    pairedWeight (blockPhysical s.toList M f) (blockPhysical s.toList M g) z =
      (∏ p ∈ s, GrowingPrimeScatteringBounds.paired p z M) * pairedWeight f g z

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
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Lax–Phillips (1967) scattering theory; Melrose (1993) geometric scattering theory; Connes (1999) and Meyer (2001) spectral realizations. Machine verification of the non-local block history Mellin multiplier theorem and low-high frequency exponential decoupling in Lean 4 is new.
- **Advancement:** Connects physical space compactly supported wavefunctions directly to complex spectral readouts in the critical strip, rigorously proving that large memory depth $M$ decouples prime channels exponentially in the interior.
- **Target Venues:** *Journal of Spectral Theory* or *Communications in Mathematical Physics*.
