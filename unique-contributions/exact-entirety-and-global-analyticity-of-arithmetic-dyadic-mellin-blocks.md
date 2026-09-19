# Unique Contribution 237: Exact Entirety and Global Analyticity of Arithmetic Dyadic Mellin Blocks

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseBlockAnalytic.lean`](../../formalization/BuildingBlocks/CoarseBlockAnalytic.lean), [`building-blocks/coarse/coarse-block-analytic.md`](../../building-blocks/coarse/coarse-block-analytic.md)  
**Classification:** Complex Analysis / Analytic Number Theory / Mellin Transforms / Parametric Integrals / Entire Functions / Holomorphic Continuation

---

## 1. Executive Summary and Mathematical Statement

In establishing the meromorphic continuation of prime-counting Dirichlet series and Mellin transforms, the singularity structure of the total transform $\int_1^\infty \Delta(x) x^{-(s+1)} dx$ arises purely from the infinite tail behavior at $x \to \infty$. To prove that no local branch cuts or singularities are introduced by dyadic truncation, each localized dyadic block must be verified to be an entire function of the complex frequency $s \in \mathbb{C}$.

This contribution proves:

1. **Complex Differentiability of Finite Arithmetic Mellin Integrals:**  
   For any positive base $X > 0$, the localized Mellin integral of the discontinuous prime error function $\Delta(x) = \psi(x) - x$:
   \[
   s \mapsto \int_X^{2X} (\psi(x) - x) x^{-(s+1)} \, dx
   \]
   is globally complex-differentiable on the entire complex plane $\mathbb{C}$ (i.e. is an entire function).
2. **Global Analyticity of Dyadic Mellin Blocks:**  
   For every dyadic block index $k \in \mathbb{N}$, the dyadic block function:
   \[
   s \mapsto \text{coarseMellinBlock}(k, s) = \int_{2^k}^{2^{k+1}} (\psi(x) - x) x^{-(s+1)} \, dx
   \]
   is analytic on $\mathbb{C}$ without any singularities:
   \[
   \text{AnalyticOnNhd } \mathbb{C} \, (\text{coarseMellinBlock } k) \, \text{univ}.
   \]
3. **Leibniz Dominated Differentiation for Discontinuous Prime Kernels:**  
   The proof rigorously establishes the interchange of complex differentiation and integration under the parameter-dependent kernel $W(s, x) = \exp(-(s+1)\log(\max(X, x)))$ by constructing compact uniform bounds on cylinders $\overline{B}(s_0, 1) \times [X, 2X]$.

---

## 2. Mathematical Proof

### 2.1. Parametric Kernel Formulation
Define the continuous log-weight $L(x) = \log(\max(X, x))$.
On $[X, 2X]$, $L(x) = \log x$.
Define $W(s, x) = \exp(-(s+1) L(x))$ and its complex derivative $D(s, x) = -L(x) \exp(-(s+1) L(x))$.
For every fixed $x \ge X$, $s \mapsto W(s, x)$ is entire with derivative $D(s, x)$.

### 2.2. Compact Domination and Interchange
For any point $s_0 \in \mathbb{C}$, consider the compact closed ball $\overline{B}(s_0, 1)$.
The cylinder $\overline{B}(s_0, 1) \times [X, 2X]$ is compact in $\mathbb{C} \times \mathbb{R}$.
Since $(s, x) \mapsto D(s, x)$ is jointly continuous, it achieves a maximum modulus $C < \infty$ on this cylinder:
\[
\|D(s, x)\| \le C \quad \text{for all } s \in B(s_0, 1), x \in [X, 2X].
\]
The majorant is:
\[
\|\Delta(x) D(s, x)\| \le C |\Delta(x)|.
\]
Since $\Delta(x)$ is Riemann-integrable / bounded and locally integrable on $[X, 2X]$, the majorant $C |\Delta(x)|$ is integrable on $[X, 2X]$.
By the parametric Leibniz integral theorem (`hasDerivAt_integral_of_dominated_loc_of_deriv_le`), the integral:
\[
I(s) = \int_X^{2X} \Delta(x) W(s, x) \, dx
\]
is complex differentiable at $s_0$. Since $s_0 \in \mathbb{C}$ was arbitrary, $I(s)$ is entire.

### 2.3. Extension to Dyadic Blocks
For $X = 2^k > 0$, $\text{coarseMellinBlock}(k, s)$ coincides with $I(s)$.
Since $I(s)$ is differentiable everywhere on $\mathbb{C}$, it is analytic in a neighborhood of every point $s \in \mathbb{C}$, proving `AnalyticOnNhd ℂ (coarseMellinBlock k) univ`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarseBlockAnalytic.lean`):
```lean
theorem coarsePrime_finiteMellin_differentiable {X : ℝ} (hX : 0 < X) :
    Differentiable ℂ (fun s : ℂ => ∫ x in X..(2 * X),
      (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

theorem coarseMellinBlock_analytic (k : ℕ) :
    AnalyticOnNhd ℂ (coarseMellinBlock k) Set.univ
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Parametric integrals in complex analysis and entire Mellin kernels (Ahlfors 1979, Titchmarsh 1986). The formal verification of entirety for finite Mellin transforms of the actual discontinuous prime counting error $\psi(x) - x$ in Lean 4 is new.
- **Advancement:** Guarantees that all singularities in the prime Mellin transform arise strictly from the infinite summation of dyadic blocks, with every individual block being entire on $\mathbb{C}$.
- **Target Venues:** *Complex Variables and Elliptic Equations* or *Journal of Mathematical Analysis and Applications*.
