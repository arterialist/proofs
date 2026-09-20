# Contribution 331: Exact Factorial Real-Cell Cross Kernel Isometry and Log-Two Budget Majorization

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialRealCellCrossKernel.lean`](../../formalization/BuildingBlocks/FactorialRealCellCrossKernel.lean), [`building-blocks/factorial/cross-kernel.md`](../../building-blocks/factorial/cross-kernel.md)  
**Classification:** Analytic Number Theory / Integral Transforms / Phase Kernels / Möbius Inversion / Reproducing Kernels / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The study of factorial real-cell phase functions and their energy interactions under weighted Mellin/Fourier transforms requires computing cross-energies between inverse test phases $\psi(x, t) = \sum_{j \le x} \frac{\mu(j)}{j} \phi(x/j, t)$ across independent continuous scales $x, y \ge 1$.

This contribution proves:

1. **Exact Bilinear Phase Integral Identity:**  
   For any scale vectors $a_i, b_j \ge 1$ and real coefficients $c_i, d_j$:
   $$
   \int_0^\infty \left( \sum_i c_i \phi(a_i, t) \right) \left( \sum_j d_j \phi(b_j, t) \right) w(t) \, dt = \sum_i \sum_j c_i d_j \, K_{\text{phase}}(a_i, b_j).
   $$
2. **Exact 2D Floor-Truncated Cross Kernel Representation:**  
   For continuous scales $x, y \ge 1$, the continuous cross-energy is an exact finite double sum:
   $$
   \int_0^\infty \psi(x, t) \psi(y, t) w(t) \, dt = K_{\text{actual}}(x, y),
   $$
   where
   $$
   K_{\text{actual}}(x, y) = \sum_{j=1}^{\lfloor x \rfloor} \sum_{l=1}^{\lfloor y \rfloor} \frac{\mu(j)}{j} \frac{\mu(l)}{l} K_{\text{phase}}\left(\frac{x}{j}, \frac{y}{l}\right).
   $$
3. **Exact Majorization by Log 2 and Inverse Coefficient Budgets:**  
   Using the universal phase kernel bound $|K_{\text{phase}}(u, v)| \le \log 2$ for all $u, v \ge 1$:
   $$
   \|K_{\text{actual}}(x, y)\| \le (\log 2) \cdot B(\lfloor x \rfloor) \cdot B(\lfloor y \rfloor),
   $$
   where $B(N) = \sum_{j=1}^N |\mu(j)/j|$ is the inverse coefficient budget.
4. **Exact Kernel Symmetry:**  
   $K_{\text{actual}}(x, y) = K_{\text{actual}}(y, x)$ unconditionally.

---

## 2. Mathematical Proof

### 2.1. Bilinear Expansion and Integrability
Expanding the product of sums $\sum_i c_i \phi(a_i, t)$ and $\sum_j d_j \phi(b_j, t)$ distributes the product into $\sum_{i, j} c_i d_j \phi(a_i, t) \phi(b_j, t) w(t)$.
By the Cauchy-Schwarz integrability of `phaseRow`, each term is integrable on $(0, \infty)$, allowing the integral and double sum to commute.

### 2.2. Quotient Lower Bound
For $j \in [1, \lfloor x \rfloor]$, $j \le x$, hence $x/j \ge 1$.
Thus the arguments $x/j$ and $y/l$ of $K_{\text{phase}}$ always remain in the domain $[1, \infty)^2$ where $0 \le K_{\text{phase}}(u, v) \le \log 2$.

### 2.3. Budget Majorization
Applying the triangle inequality:
$\|K_{\text{actual}}(x, y)\| \le \sum_{j \le x} \sum_{l \le y} \frac{|\mu(j)|}{j} \frac{|\mu(l)|}{l} |K_{\text{phase}}(x/j, y/l)| \le (\log 2) \left(\sum_{j \le x} \frac{|\mu(j)|}{j}\right) \left(\sum_{l \le y} \frac{|\mu(l)|}{l}\right) = (\log 2) B(\lfloor x \rfloor) B(\lfloor y \rfloor)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialRealCellPhase` in `formalization/BuildingBlocks/FactorialRealCellCrossKernel.lean`):
```lean
theorem phase_bilinear_integral {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c a : ι → ℝ) (d b : κ → ℝ) (ha : ∀ i ∈ s, 1 ≤ a i) (hb : ∀ j ∈ r, 1 ≤ b j) :
    (∫ t in Ioi 0, (∑ i ∈ s, c i * scalarPhase (a i) t) *
      (∑ j ∈ r, d j * scalarPhase (b j) t) * FactorialBinaryEnergy.weight t) =
      ∑ i ∈ s, ∑ j ∈ r, c i * d j * phaseKernel (a i) (b j)

theorem inverseTestPhase_cross_integral {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    (∫ t in Ioi 0, inverseTestPhase x t * inverseTestPhase y t * FactorialBinaryEnergy.weight t) =
      actualCrossKernel x y

theorem actualCrossKernel_norm_le {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    ‖actualCrossKernel x y‖ ≤ log 2 * inverseCoefficientBudget ⌊x⌋₊ * inverseCoefficientBudget ⌊y⌋₊

theorem actualCrossKernel_symm (x y : ℝ) : actualCrossKernel x y = actualCrossKernel y x
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Titchmarsh (1986) *The Theory of the Riemann Zeta-Function*; Montgomery & Vaughan (2007) *Multiplicative Number Theory*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes an exact reproducing kernel formula for inverse test phases across continuous scales, bounding continuous cross-correlations by discrete Möbius budgets.
- **Target Venues:** *Journal of Functional Analysis* or *Integral Equations and Operator Theory*.
