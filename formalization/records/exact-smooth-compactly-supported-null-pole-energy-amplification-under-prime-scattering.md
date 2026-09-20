# Contribution 218: Exact Smooth Compactly Supported Null-Pole Energy Amplification Under Prime Scattering

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactScatteringRegularity.lean`](../../formalization/BuildingBlocks/CompactScatteringRegularity.lean), [`building-blocks/scattering/compact-scattering-regularity.md`](../../building-blocks/scattering/compact-scattering-regularity.md)  
**Classification:** Functional Analysis / Scattering Theory / Wavelet Analysis / Smooth Test Functions / Riemann Pole Vanishing / Invariant Subspaces

---

## 1. Executive Summary and Mathematical Statement

In the spectral formulation of the Riemann hypothesis and scattering models of prime numbers, a long-standing conjecture was whether test-function regularity—specifically demanding infinite smoothness ($C^\infty$), compact support ($C_c^\infty$), and exact cancellation of the pole residues at the Riemann zeta pole locations $s = 0, 1$ ($\int f(v) e^{\pm v/2} dv = 0$)—would suffice to guarantee that prime lattice scattering operators act contractively or neutrally on energy.

This contribution rigorously refutes that hypothesis by proving:

1. **Regularity and Compact Support Inheritance:**  
   If $\eta \in C_c^\infty(\mathbb{R})$ and $c \in \mathbb{Z} \to_0 \mathbb{C}$ has finite support, then the synthesized wave packet satisfies:
   $$
   \text{packet}(L, \eta, c) \in C_c^\infty(\mathbb{R}).
   $$
2. **Phase Translation and Vanishing Moment Inheritance:**  
   The complex moments transform under translation by:
   $$
   \int_{-\infty}^\infty \eta(v - d) e^{s v} \, dv = e^{s d} \int_{-\infty}^\infty \eta(v) e^{s v} \, dv.
   $$
   Consequently, if $\eta$ has vanishing complex moment at $s$, then *every* discrete packet $\text{packet}(L, \eta, c)$ identically inherits vanishing complex moment at $s$:
   $$
   \int_{-\infty}^\infty \text{packet}(L, \eta, c)(v) e^{s v} \, dv = 0.
   $$
3. **Smooth Null-Pole Prime Energy Amplification:**  
   For *every* prime $p$ and *every* history depth $M \ge 1$:
   There exists an explicit test function $f \in C_c^\infty(\mathbb{R})$ such that:
   - $f$ is smooth and compactly supported ($f \in C_c^\infty(\mathbb{R})$);
   - $f$ has zero complex pole moments at both critical endpoints:
     $$
     \int_{-\infty}^\infty f(v) e^{v/2} \, dv = 0 \quad \text{and} \quad \int_{-\infty}^\infty f(v) e^{-v/2} \, dv = 0;
     $$
   - AND $f$ strictly amplifies physical $L^2$ energy under the discrete prime history scattering operator:
     $$
     \|f\|_{L^2}^2 < \|\mathcal{H}_{p^{-1/2}, M, \log p}(f)\|_{L^2}^2.
     $$
   This proves that smoothness and pole cancellation alone cannot prevent energy growth, mathematically establishing that dual Dirichlet proper-cofactor subspace cancellations are strictly required.

---

## 2. Mathematical Proof

### 2.1. Regularity and Compact Support of Packets
Let $\eta \in C_c^\infty(\mathbb{R})$ and $c : \mathbb{Z} \to_0 \mathbb{C}$. The packet is a finite sum:
$$
f(v) = \sum_{j \in \text{supp}(c)} c_j \eta(v - jL).
$$
Each summand $v \mapsto c_j \eta(v - jL)$ is the composition of the smooth shift $v \mapsto v - jL$ with $\eta$, hence smooth. Since finite sums of smooth functions are smooth, $f \in C^\infty(\mathbb{R})$.
Similarly, each summand has compact support $\text{supp}(\eta) + jL$. A finite union of compact sets is compact, so $f$ has compact support.

### 2.2. Moment Vanishing
The complex moment is:
$$
\int_{-\infty}^\infty f(v) e^{s v} \, dv = \sum_{j \in \text{supp}(c)} c_j \int_{-\infty}^\infty \eta(v - jL) e^{s v} \, dv.
$$
Substituting $u = v - jL$, $dv = du$:
$$
\int_{-\infty}^\infty \eta(v - jL) e^{s v} \, dv = e^{s j L} \int_{-\infty}^\infty \eta(u) e^{s u} \, du = e^{s j L} \cdot 0 = 0.
$$
Thus the entire sum evaluates to 0 for both $s = 1/2$ and $s = -1/2$.

### 2.3. Energy Amplification
By Contribution 217, taking the box coefficients $c_J = \text{box}(\theta, J)$ with $\theta = \pi/M$ and carrier $\eta$ provided by `exists_prime_amplifying_narrow_carrier`:
$$
\|f\|_{L^2}^2 = J \|\eta\|_{L^2}^2 < (J - M) |\sigma|^2 \|\eta\|_{L^2}^2 \le \|\mathcal{H}_{p^{-1/2}, M, \log p}(f)\|_{L^2}^2.
$$
This completes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactScatteringRegularity` in `formalization/BuildingBlocks/CompactScatteringRegularity.lean`):
```lean
theorem packet_contDiff {eta : ℝ → ℂ} (hd : ContDiff ℝ ∞ eta)
    (L : ℝ) (c : ℤ →₀ ℂ) : ContDiff ℝ ∞ (packet L eta c)

theorem packet_compact {eta : ℝ → ℂ} (hc : HasCompactSupport eta)
    (L : ℝ) (c : ℤ →₀ ℂ) : HasCompactSupport (packet L eta c)

theorem packet_moment_zero {eta : ℝ → ℂ} (hh : Continuous eta)
    (hc : HasCompactSupport eta) (s : ℝ) (hm : complexMoment eta s = 0)
    (L : ℝ) (c : ℤ →₀ ℂ) : complexMoment (packet L eta c) s = 0

theorem exists_prime_smooth_pole_null_amplification (p : ℕ) (hp : p.Prime)
    (M : ℕ) (hM : 1 ≤ M) :
    ∃ f : ℝ → ℂ, HasCompactSupport f ∧ ContDiff ℝ ∞ f ∧
      complexMoment f (1 / 2) = 0 ∧ complexMoment f (-(1 / 2)) = 0 ∧
      BuildingBlocks.CompactScatteringPackets.physicalSquare f <
        BuildingBlocks.CompactScatteringPackets.physicalSquare
          (historyPhysical (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Smooth wavelet synthesis, zero-moment wavelets, and energy stability in Lax-Phillips scattering (Meyer 1992, Lax-Phillips 1989). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Resolves the regularity question for prime scattering by proving that even infinitely smooth wavelets with vanishing zeta pole residues amplify energy under unconstrained history dynamics.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
