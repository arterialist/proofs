# Unique Contribution 317: Exact Finite Haar Energy Decomposition and Coarse-Mode Conservation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CrossHorizonHaarFinite.lean`](../../formalization/BuildingBlocks/CrossHorizonHaarFinite.lean), [`building-blocks/cross-horizon/haar.md`](../../building-blocks/cross-horizon/haar.md)  
**Classification:** Harmonic Analysis / Wavelet Theory / Haar Decomposition / Dyadic Packets / Gauge Invariance / Coarse Mode Obstructions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In multiscale signal analysis and cross-horizon comparisons of number-theoretic clocks (such as the finite Möbius clock $\mathcal{C}(N) = \sum_{d \in (D, T), d \le N} \mu(d)(1 - q^{N/d})$), dyadic wavelet transforms decompose total energy into scale-by-scale details. When examining whether recursive wavelet filtering can eliminate large-scale background shifts, the exact behavior of the constant projection (coarse mode) is critical.

This contribution proves:

1. **Exact Finite Haar Energy Decomposition:**  
   For any balanced dyadic packet $p$ of depth $k$ with $2^k$ real leaves:
   \[
   \|p\|^2 = \mathcal{E}_{\text{coarse}}(p) + \mathcal{E}_{\text{detail}}(p),
   \]
   where $\mathcal{E}_{\text{coarse}}(p) = \frac{(\text{total}(p))^2}{2^k}$, and $\mathcal{E}_{\text{detail}}(p)$ is the exact sum of dyadically weighted squared Haar detail coefficients $\sum \frac{(T_{\text{left}} - T_{\text{right}})^2}{2^{j+1}}$.
2. **Coarse-Detail Recursion and Energy Transfer:**  
   When two dyadic packets of depth $k$ are merged into a parent node of depth $k+1$:
   \[
   \mathcal{E}_{\text{coarse}}(\text{left}) + \mathcal{E}_{\text{coarse}}(\text{right}) = \mathcal{E}_{\text{coarse}}(\text{node}(\text{left}, \text{right})) + \mathcal{E}_{\text{rootDetail}}(\text{left}, \text{right}),
   \]
   where $\mathcal{E}_{\text{rootDetail}} = \frac{(\text{total}(\text{left}) - \text{total}(\text{right}))^2}{2^{k+1}}$.
   This shows that merging blocks transfers precisely their total discrepancy into newly exposed Haar energy while preserving the parent coarse mode.
3. **Exact Gauge Invariance of Nonconstant Haar Details:**  
   For any constant shift $c \in \mathbb{R}$ applied uniformly to all leaves ($x \mapsto x + c$):
   \[
   \text{haarCoefficients}(\text{gaugeShift}(c, p)) = \text{haarCoefficients}(p),
   \]
   and:
   \[
   \mathcal{E}_{\text{detail}}(\text{gaugeShift}(c, p)) = \mathcal{E}_{\text{detail}}(p).
   \]
4. **Irreducibility and Conservation of the Coarse Residual:**  
   \[
   \|p\|^2 - \mathcal{E}_{\text{detail}}(p) = \mathcal{E}_{\text{coarse}}(p).
   \]
   Recursive Haar filtering can never discard or diminish the unresolved coarse projection.
5. **Exact Application to Finite Möbius Clock Packets:**  
   On any dyadic block $H \le N < H + 2^k$, the finite Möbius clock packet decomposes into gauge-invariant Haar details and a conserved coarse projection:
   \[
   \|\mathcal{C}\|^2 = \frac{\left(\sum_{i=0}^{2^k-1} \mathcal{C}(H+i)\right)^2}{2^k} + \mathcal{E}_{\text{detail}}(\mathcal{C}).
   \]

---

## 2. Mathematical Proof

### 2.1. Dyadic Energy Identity
By induction on tree depth $k$:
- Base case $k=0$: Leaf $x$ has $\|x\|^2 = x^2$, $\mathcal{E}_{\text{coarse}} = x^2/2^0 = x^2$, and $\mathcal{E}_{\text{detail}} = 0$. Equality holds.
- Inductive step $k \to k+1$: Let $p = \text{node}(\text{left}, \text{right})$.
  By induction hypothesis:
  \[
  \|p\|^2 = \|\text{left}\|^2 + \|\text{right}\|^2 = \mathcal{E}_{\text{coarse}}(\text{left}) + \mathcal{E}_{\text{coarse}}(\text{right}) + \mathcal{E}_{\text{detail}}(\text{left}) + \mathcal{E}_{\text{detail}}(\text{right}).
  \]
  Using the algebraic identity:
  \[
  \frac{A^2}{2^k} + \frac{B^2}{2^k} = \frac{(A+B)^2}{2^{k+1}} + \frac{(A-B)^2}{2^{k+1}},
  \]
  we substitute $A = \text{total}(\text{left})$ and $B = \text{total}(\text{right})$.
  The term $\frac{(A+B)^2}{2^{k+1}}$ is $\mathcal{E}_{\text{coarse}}(p)$, while $\frac{(A-B)^2}{2^{k+1}}$ is added to $\mathcal{E}_{\text{detail}}(\text{left}) + \mathcal{E}_{\text{detail}}(\text{right})$ to form $\mathcal{E}_{\text{detail}}(p)$.
  Thus $\|p\|^2 = \mathcal{E}_{\text{coarse}}(p) + \mathcal{E}_{\text{detail}}(p)$.

### 2.2. Gauge Invariance
Shifting each leaf by $c$ shifts the total of a depth-$k$ packet by $2^k c$.
For any node at depth $j+1$ with children of depth $j$:
\[
\text{total}(\text{left}') - \text{total}(\text{right}') = (\text{total}(\text{left}) + 2^j c) - (\text{total}(\text{right}) + 2^j c) = \text{total}(\text{left}) - \text{total}(\text{right}).
\]
The shift $c$ cancels identically, establishing full gauge invariance for all nonconstant coefficients.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CrossHorizonHaarFinite` in `formalization/BuildingBlocks/CrossHorizonHaarFinite.lean`):
```lean
theorem squareEnergy_eq_coarse_add_haar {k : ℕ} (p : DyadicPacket k) :
    squareEnergy p = coarseEnergy p + haarDetailEnergy p

theorem child_coarse_recursion {k : ℕ} (left right : DyadicPacket k) :
    coarseEnergy left + coarseEnergy right =
      coarseEnergy (.node left right) + rootDetail left right

theorem haarCoefficients_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    haarCoefficients (gaugeShift c p) = haarCoefficients p

theorem haarDetailEnergy_gaugeShift {k : ℕ} (p : DyadicPacket k) (c : ℝ) :
    haarDetailEnergy (gaugeShift c p) = haarDetailEnergy p

theorem mobiusClock_squareEnergy_decomposition
    (D T H k : ℕ) (q : ℝ) :
    DyadicPacket.squareEnergy (mobiusClockPacket D T H k q) =
      DyadicPacket.coarseEnergy (mobiusClockPacket D T H k q) +
        DyadicPacket.haarDetailEnergy (mobiusClockPacket D T H k q)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Haar (1910) *Zur Theorie der orthogonalen Funktionensysteme*; Daubechies (1992) *Ten Lectures on Wavelets*; Mallat (1999) *A Wavelet Tour of Signal Processing*. Machine verification of exact dyadic packet Haar energy decompositions, gauge invariance, and coarse-mode conservation in Lean 4 is new.
- **Advancement:** Establishes an exact inductive wavelet algebra for dyadic sequences, proving gauge invariance of details and the impossibility of eliminating the coarse projection via multiscale filtering.
- **Target Venues:** *Applied and Computational Harmonic Analysis* or *IEEE Transactions on Signal Processing*.
