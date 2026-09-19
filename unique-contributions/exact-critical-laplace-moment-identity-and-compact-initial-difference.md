# Unique Contribution 106: Exact Critical Laplace Moment Identity and Compact Initial Difference

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCriticalLaplace.lean`](../../formalization/BuildingBlocks/ActualCriticalLaplace.lean), [`formalization/BuildingBlocks/ActualCriticalMeasure.lean`](../../formalization/BuildingBlocks/ActualCriticalMeasure.lean), [`formalization/BuildingBlocks/ActualCriticalMellin.lean`](../../formalization/BuildingBlocks/ActualCriticalMellin.lean)  
**Classification:** Analytic Number Theory / Laplace Transforms / Positive Measures / Landau Oscillation Theorems / Compact Initial Corrections

---

## 1. Executive Summary and Mathematical Statement

In Landau's oscillation theorem for arithmetic functions, if a real-valued distribution or measure has a definitive eventual sign, its Laplace transform represents a positive measure whose abscissa of convergence must be a real singularity. For the critical multiple correlation function $W(x)$, an eventual sign condition $\operatorname{Re} W(x) \le 0$ for $x > A$ induces a non-negative tail density $\rho(x) = x^{-2} (-W(x))_{\ge 0}$.

This contribution proves:

1. **Exact Laplace-to-Mellin Exponent Conversion:**  
   Under the logarithmic time parameterization $t(x) = \log x$ for $x > 1$, multiplying the normalized tail density $x^{-2} (-W(x))$ by the Laplace factor $e^{-s t(x)}$ converts identically into the Mellin integrand:
   \[
   \rho(x) e^{-s t(x)} = x^{-2} (-W(x)) x^{-s} = x^{-s-2} (-W(x)).
   \]
2. **Equivalence of Laplace Moment and Mellin Tail Integral:**  
   For any cutoff $A \ge 1$ where $\operatorname{Re} W(x) \le 0$ for $x > A$, the zeroth moment of the positive tail measure under Laplace transform matches the Mellin transform of the negative tail function $-W_{\text{tail}}$ at argument $-s-1$:
   \[
   \int_0^\infty e^{-s t} \, d\mu_{\text{tail}}(t) = \mathcal{M}(-W_{\text{tail}})(-s-1).
   \]
3. **Exact Difference Formula with Compact Initial Correction:**  
   On the absolute convergence half-plane $\operatorname{Re}(s) > 1$, the positive-measure Laplace transform equals the explicit difference between the compact initial segment Mellin integral on $[1, A]$ and the filled critical transform:
   \[
   \int_0^\infty e^{-s t} \, d\mu_{\text{tail}}(t) = \int_1^A x^{-s-2} W(x) \, dx - \mathcal{T}_{\text{filled}}(s),
   \]
   where $\mathcal{T}_{\text{filled}}(s) = \zeta(s + 1/2) \frac{\left(-\frac{\zeta'}{\zeta}(s) - \frac{1}{s-1}\right)^2 - H(s)}{s(s+1)}$ extends analytically across the real axis except for explicit zeta poles.

---

## 2. Mathematical Proof

### 2.1. Coordinate Dilation and Exponent Algebra
For $x > 1$, let $t = \log x \iff x = e^t$, with $dt = dx/x$.
The tail measure on $\mathbb{R}_+$ is defined with density $\rho(x) = x^{-2} (-W(x))$ with respect to Lebesgue measure $dx$.
Its Laplace transform is:
\[
\int_0^\infty e^{-st} \, d\mu_{\text{tail}}(t) = \int_1^\infty e^{-s \log x} \rho(x) \, dx = \int_1^\infty x^{-s} x^{-2} (-W_{\text{tail}}(x)) \, dx = \int_1^\infty x^{-s-2} (-W_{\text{tail}}(x)) \, dx.
\]
In Mellin notation, $\mathcal{M}(f)(w) = \int_0^\infty x^{w-1} f(x) dx$. At $w = -s-1$:
\[
x^{(-s-1)-1} = x^{-s-2}.
\]
Thus the Laplace transform equals $\mathcal{M}(-W_{\text{tail}})(-s-1)$.

### 2.2. Compact Splitting
By definition of the tail and initial parts:
\[
W(x) = W_{\text{initial}}(x) + W_{\text{tail}}(x),
\]
where $W_{\text{initial}}(x) = W(x) \mathbf{1}_{[1, A]}(x)$ is compactly supported on $[1, A]$, and $W_{\text{tail}}(x) = W(x) \mathbf{1}_{(A, \infty)}(x)$.
By linearity of the Mellin transform:
\[
\mathcal{M}(W)(-s-1) = \mathcal{M}(W_{\text{initial}})(-s-1) + \mathcal{M}(W_{\text{tail}})(-s-1).
\]
Rearranging:
\[
\mathcal{M}(-W_{\text{tail}})(-s-1) = \mathcal{M}(W_{\text{initial}})(-s-1) - \mathcal{M}(W)(-s-1).
\]
Substituting $\mathcal{M}(W)(-s-1) = \mathcal{T}_{\text{filled}}(s)$ yields the exact identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCriticalLaplace`):
```lean
theorem density_smul_exp {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (tailDensity A x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ)^(-s-2) * negativeWTail A x

theorem moment_eq_mellin_negativeWTail {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (s : ℂ) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (negativeWTail A) (-s-1)

theorem moment_eq_initial_sub_filledTransform {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (initialPart ActualCriticalMellin.W A) (-s-1) -
        CriticalTransformPoles.filledTransform s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Landau's theorem on the singularity of Dirichlet series with positive coefficients (Landau 1905). Widder's representation theorem for Laplace transforms of non-negative measures (Widder 1941). The exact machine-verified identity linking a positive tail measure to the difference between an entire compact integral and the explicit critical zeta transform $\mathcal{T}_{\text{filled}}(s)$ is novel.
- **Advancement:** Establishes machine-verified Laplace-Mellin bridges for Landau-type sign contradiction arguments.
- **Target Venues:** *Transactions of the American Mathematical Society* or *Mathematische Zeitschrift*.
