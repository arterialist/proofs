# Contribution 310: Exact Compact Physical Mellin Holomorphy and Pole-Null Cauchy Residue Vanishing

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean`](../../formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean), [`building-blocks/contour-inversion/pole-null.md`](../../building-blocks/contour-inversion/pole-null.md)  
**Classification:** Complex Analysis / Several Complex Variables / Mellin Inversion / Cauchy Integral Formula / Spectral Pole Cancellation / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the contour inversion of physical history-Mellin transforms paired against Dirichlet series kernels, the poles of the shifted zeta function and multiplier kernels at $s = 0$ and $s = 1$ threaten to introduce parasitic residue terms that contaminate the spectral density. When the physical state satisfies the dual spectral null conditions:
$$
\mathcal{M}[f](-1/2) = 0 \quad \text{and} \quad \mathcal{M}[f](1/2) = 0,
$$
the corresponding centered weight $\mathcal{W}_{f, g}(s) = \text{pairedWeight}(f, g)(s - 1/2)$ vanishes at both poles $s = 0$ and $s = 1$.

This contribution proves:

1. **Exact Vanishing of Cauchy Residue Circle Corrections:**  
   For any continuous, compactly supported test functions $f, g : \mathbb{R} \to \mathbb{C}$ satisfying the physical null conditions $\mathcal{M}[f](\pm 1/2) = 0$, and for any circle $C(c, R)$ enclosing $0$ and $1$:
   $$
   \oint_{C(c, R)} \frac{\mathcal{W}_{f, g}(w)}{w} dw = 0 \quad \text{and} \quad \oint_{C(c, R)} \frac{\mathcal{W}_{f, g}(w)}{w - 1} dw = 0.
   $$
   Consequently, the parasitic boundary residues at $s = 0$ and $s = 1$ vanish identically.
2. **Invariance Under Finite Prime Block Conditioners:**  
   For any finite family of primes $\{p_1, \dots, p_k\} \subset \mathbb{N}_{\ge 2}$ and scale cutoff $M$, the block-conditioned state $f_{\text{block}} = \text{blockPhysical}(ps, M, f)$ retains compact support, continuity, and the dual pole-null condition, ensuring exact circle residue vanishing for conditioned states:
   $$
   \oint_{C(c, R)} \frac{\mathcal{W}_{\text{block}}(w)}{w} dw = 0 \quad \text{and} \quad \oint_{C(c, R)} \frac{\mathcal{W}_{\text{block}}(w)}{w - 1} dw = 0.
   $$
3. **Global Entire Holomorphy of Compact Physical Mellin Transforms:**  
   For any continuous function $f$ with compact support, its Mellin transform $z \mapsto \int_{\mathbb{R}} f(v) e^{zv} dv$ is entire (complex-differentiable everywhere on $\mathbb{C}$), with derivative given by the moment Mellin transform $\mathcal{M}[v f(v)](z)$.
4. **Holomorphy of Paired and Centered Weights:**  
   The paired weight $z \mapsto \mathcal{M}[f](z) \cdot \overline{\mathcal{M}[g](-\bar{z})}$ and the centered weight $s \mapsto \mathcal{W}_{f, g}(s)$ are entire holomorphic functions on $\mathbb{C}$.
5. **Exact Cauchy Residue Representation for Entire Functions:**  
   For any entire function $F : \mathbb{C} \to \mathbb{C}$ and $s$ inside the circle $C(c, R)$:
   $$
   \oint_{C(c, R)} \frac{F(w)}{w - s} dw = 2\pi i F(s).
   $$

---

## 2. Mathematical Proof

### 2.1. Dominated Parameter Differentiation for Compact Supports
Let $f$ be continuous with compact support $K = \text{tsupport}(f)$.
The integrand $F(w, v) = f(v) e^{w v}$ has derivative with respect to $w$:
$$
F'(w, v) = v f(v) e^{w v}.
$$
For $w$ in the closed ball $\bar{B}(z, 1)$ and $v \in K$, $|F'(w, v)| \le \sup_{u \in \bar{B}(z, 1), v \in K} |v f(v) e^{u v}| = C < \infty$ because $\bar{B}(z, 1) \times K$ is compact.
Since $K$ has finite Lebesgue measure, the constant $C$ is integrable on $K$.
By dominated convergence of parametric integrals (`hasDerivAt_integral_of_dominated_loc_of_deriv_le`), $\mathcal{M}[f](z)$ is complex differentiable everywhere, hence entire.

### 2.2. Entire Paired Weights
By the conjugate Mellin dictionary:
$$
\overline{\mathcal{M}[g](-\bar{z})} = \mathcal{M}[\bar{g}](-z).
$$
Since $g$ is continuous and compactly supported, $\bar{g}$ is continuous and compactly supported, so $\mathcal{M}[\bar{g}](z)$ is entire.
Thus $z \mapsto \mathcal{M}[\bar{g}](-z)$ is entire, and the product $\mathcal{W}(z) = \mathcal{M}[f](z) \mathcal{M}[\bar{g}](-z)$ is entire.

### 2.3. Vanishing Cauchy Circle Integrals
By the Cauchy Integral Formula for entire functions:
$$
\oint_{C(c, R)} \frac{\mathcal{W}(w)}{w} dw = 2\pi i \mathcal{W}(0), \qquad \oint_{C(c, R)} \frac{\mathcal{W}(w)}{w - 1} dw = 2\pi i \mathcal{W}(1).
$$
Evaluating at $s = 0$ corresponds to $z = 0 - 1/2 = -1/2$, so $\mathcal{W}(0) = \text{pairedWeight}(f, g)(-1/2) = \mathcal{M}[f](-1/2) \cdot \dots = 0 \cdot \dots = 0$.
Evaluating at $s = 1$ corresponds to $z = 1 - 1/2 = 1/2$, so $\mathcal{W}(1) = \text{pairedWeight}(f, g)(1/2) = \mathcal{M}[f](1/2) \cdot \dots = 0 \cdot \dots = 0$.
Therefore, both integrals vanish identically.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactPhysicalMellinAnalytic` in `formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean`):
```lean
theorem physical_mellin_entire {f : ℝ → ℂ} (hf : Continuous f)
    (hfc : HasCompactSupport f) :
    Differentiable ℂ (BuildingBlocks.FullComplexHistoryMellin.mellin f)

theorem entire_weight_circle_coefficient (F : ℂ → ℂ) (hF : Differentiable ℂ F)
    (c s : ℂ) (R : ℝ) (hs : s ∈ Metric.ball c R) :
    (∮ w in C(c, R), F w / (w - s)) = (2 * Real.pi * Complex.I) * F s

theorem pole_null_circle_corrections {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (h0 : (0 : ℂ) ∈ Metric.ball c R) (h1 : (1 : ℂ) ∈ Metric.ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w / w) = 0 ∧
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w / (w - 1)) = 0

theorem finite_block_pole_null_circle_corrections {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (h0 : (0 : ℂ) ∈ Metric.ball c R) (h1 : (1 : ℂ) ∈ Metric.ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w / w) = 0 ∧
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w / (w - 1)) = 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Paley–Wiener theorem (Paley & Wiener 1934); Hörmander (1983) *The Analysis of Linear Partial Differential Operators I*; Titchmarsh (1948) *Introduction to the Theory of Fourier Integrals*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes certified elimination of parasitic pole residues at $s=0, 1$ in complex contour inversion for both bare and prime-block conditioned physical states.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
