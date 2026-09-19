# Unique Contribution 303: Exact Prime-Memory Charge Cutoff Decay and Finite-Rank Defect Error

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MemoryChargeCutoff.lean`](../../formalization/BuildingBlocks/MemoryChargeCutoff.lean), [`building-blocks/memory-charge/cutoff.md`](../../building-blocks/memory-charge/cutoff.md)  
**Classification:** Operator Theory / Integral Operators / Finite-Rank Approximations / Prime-Memory Kernel / Quantitative Error Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the operator-theoretic formulation of prime successor feedback, the complete memory defect functional couples the causal source $H$ with all prime powers across the entire integer line:
\[
\mathcal{K}_{\text{all}}(u) = \int_0^\infty e^{-w} \text{allPrimeSeed}(w + u) dw.
\]
To approximate this infinite-dimensional interaction by a computable, finite-rank operator, one truncates the prime spectrum to primes below a cutoff threshold $P$.

This contribution proves:

1. **Explicit Quantitative Finite-Rank Operator Defect Bound:**  
   For any prime cutoff $P \ge 8$ and any causal finite-energy source $H \in L^2(\mathbb{R}^+, dx)$ ($\text{supp}(H) \subset [1, \infty)$):
   \[
   \int_0^\infty \left| e^{-v/2} \int_0^\infty \left( \mathcal{K}_{\text{all}}(u) - \mathcal{K}_{<P}(u) \right) \mathcal{L}(H)(u) du \right| dv \le \frac{2 (64 \log 2 + 30)}{P \log P} \sqrt{\mathcal{E}(H)},
   \]
   where $\mathcal{L}(H)(u) = e^{u/2} H(e^u)$ is the isometric physical lift and $\mathcal{E}(H) = \text{energy}(H)$.
2. **Energy-Form Defect Majorization:**  
   The omitted-prime defect functional satisfies the non-asymptotic bound:
   \[
   \left| \int_0^\infty \mathcal{K}_{\text{rem}}(P, u) \mathcal{L}(H)(u) du \right| \le \frac{64 \log 2 + 30}{P \log P} \sqrt{\mathcal{E}(H)}.
   \]
3. **Pointwise Decay of the Truncated Seed Mass:**  
   The omitted-prime remainder seed $R_P(v) = \text{allPrimeSeed}(v) - \text{finitePrimeSeed}(P, v)$ decays as:
   \[
   R_P(v) \le \frac{64 \log 2 + 30}{\log P}, \qquad \forall v \ge 0,
   \]
   and vanishes identically on $v < \log P$.
4. **Exponentially Weighted Remainder Integral:**  
   The $L^1$ mass of the exponential tail decays at rate $O(1 / (P \log P))$:
   \[
   \int_0^\infty e^{-w} R_P(w) dw \le \frac{64 \log 2 + 30}{P \log P}.
   \]
5. **Exact Operator Linearity:**  
   $\mathcal{K}(R_P) = \mathcal{K}_{\text{all}} - \mathcal{K}_{<P}$ as an exact linear identity of integral kernels.

---

## 2. Mathematical Proof

### 2.1. Support Gap and Pointwise Seed Bound
By prime distribution, no prime below $P$ contributes to $R_P(v)$. For $v < \log P$, every term $\log p \cdot \mathbf{1}_{v \ge \log p}$ for $p \ge P$ vanishes identically, so $R_P(v) = 0$.
For $v \ge \log P \ge 3 \log 2$ (since $P \ge 8$), applying the established prime-seed age bound:
\[
R_P(v) \le \text{allPrimeSeed}(v) \le \frac{64 \log 2 + 30}{v} \le \frac{64 \log 2 + 30}{\log P}.
\]

### 2.2. Exponential Remainder Mass
Because $R_P(w) = 0$ for $w < \log P$:
\[
\int_0^\infty e^{-w} R_P(w) dw = \int_{\log P}^\infty e^{-w} R_P(w) dw \le \frac{64 \log 2 + 30}{\log P} \int_{\log P}^\infty e^{-w} dw.
\]
Since $\int_{\log P}^\infty e^{-w} dw = e^{-\log P} = 1/P$:
\[
\int_0^\infty e^{-w} R_P(w) dw \le \frac{64 \log 2 + 30}{P \log P}.
\]

### 2.3. Operator Bounds on Physical Lifts
The defect kernel $\mathcal{K}_{\text{rem}}(P, u)$ satisfies the pointwise decay bound:
\[
0 \le \mathcal{K}_{\text{rem}}(P, u) \le \left( \int_0^\infty e^{-w} R_P(w) dw \right) e^{-u} \le \frac{64 \log 2 + 30}{P \log P} e^{-u}.
\]
Pairing against the physical lift $f(u) = \mathcal{L}(H)(u)$, we apply Cauchy–Schwarz on $L^2(0, \infty)$:
\[
\left| \int_0^\infty \mathcal{K}_{\text{rem}}(P, u) f(u) du \right| \le \frac{64 \log 2 + 30}{P \log P} \int_0^\infty e^{-u} |f(u)| du \le \frac{64 \log 2 + 30}{P \log P} \| e^{-u/2} f \|_{L^2}.
\]
Substituting $e^{-u/2} \mathcal{L}(H)(u) = H(e^u)$ and converting back to the scale measure $\int_1^\infty |H(x)|^2 dx/x \le \mathcal{E}(H)$ yields the theorem.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/MemoryChargeCutoff.lean`):
```lean
theorem primeSeedRemainder_bound {P : ℕ} (hP : 8 ≤ P) (v : ℝ) :
    primeSeedRemainder P v ≤ (64 * log 2 + 30) / log (P : ℝ)

theorem exponential_remainder_mass_bound {P : ℕ} (hP : 8 ≤ P) :
    (∫ w in Ioi (0 : ℝ), exp (-w) * primeSeedRemainder P w) ≤
      (64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))

theorem remainder_memory_charge_bound_energy {P : ℕ} (hP : 8 ≤ P)
    {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    IntegrableOn (fun u => SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u *
      MixedEnergy.physicalLift H u) (Ioi (0 : ℝ)) ∧
    |∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u *
      MixedEnergy.physicalLift H u| ≤
      ((64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * sqrt ((MixedEnergy.energy H).toReal)

theorem cutoff_memory_charge_rank_error {P : ℕ} (hP : 8 ≤ P)
    {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    let J := ∫ u in Ioi (0 : ℝ),
      (SuccessorCharge.memoryDefectKernel allPrimeSeed u -
        SuccessorCharge.memoryDefectKernel (finitePrimeSeed (primesBelow P)) u) *
          MixedEnergy.physicalLift H u
    IntegrableOn (fun v => exp (-v / 2) * J) (Ioi (0 : ℝ)) ∧
      (∫ v in Ioi (0 : ℝ), |exp (-v / 2) * J|) ≤
        (2 * (64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * sqrt ((MixedEnergy.energy H).toReal)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Gohberg and Krein (1969) *Theory and Applications of Volterra Operators in Hilbert Space*; Simon (2005) *Trace Ideals and Their Applications*. Machine verification of explicit quantitative $O((P \log P)^{-1})$ finite-rank operator error bounds for prime-memory feedback in Lean 4 is new.
- **Advancement:** Establishes a rigorous non-asymptotic finite-rank approximation theorem with verified explicit constants for infinite prime-memory operator equations.
- **Target Venues:** *Journal of Functional Analysis* or *Integral Equations and Operator Theory*.
