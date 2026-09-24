# Landau singularity and the critical-sign formalization

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/LandauSingularity.lean`](../../formalization/BuildingBlocks/LandauSingularity.lean), [`formalization/BuildingBlocks/ActualCriticalConvergence.lean`](../../formalization/BuildingBlocks/ActualCriticalConvergence.lean), [`formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean)
**Classification:** Analytic Number Theory / Formal Mathematics / Complex Analysis / Tauberian Theory

---

## 1. Executive Summary and Mathematical Statement

Landau's classical 1905 theorem applies to a non-negative Borel measure $\mu$ on $[0, \infty)$ when its Laplace-transform convergence set is nonempty and has a finite real abscissa $\sigma_0 = \inf \{\sigma \in \mathbb{R} \mid \int_0^\infty e^{-\sigma t} d\mu(t) < \infty\}$. The boundary point $\sigma_0$ is necessarily a **singularity** of $L(s) = \int_0^\infty e^{-st} d\mu(t)$. A public general positive-measure continuation package already appears in [Robin1984, `MGFAnalyticContinuation.lean`](https://github.com/kimihiro64/Robin1984/blob/7fbbe0821e33ddb73f953ee2981dc52813f5568a/Robin1984/Mathlib/Probability/Moments/MGFAnalyticContinuation.lean). This report therefore makes no firstness claim for the general theorem; its provisional contribution status is limited to the exact critical-arithmetic bridge and the local complex interface implemented here.

The checked modules provide the following building blocks:

1. **Local complex no-extension interface:**
   Formal proof in Lean 4.24.0 (`LandauSingularity.lean`) that no holomorphic function on any metric disk centered at the real abscissa $\sigma_0$ can agree with the Laplace integral on the right half of the disk:
   $$
   \neg \exists (R > 0) (F : \mathbb{C} \to \mathbb{C}), \operatorname{DifferentiableOn}(\mathbb{C}, F, B(\sigma_0, R)) \wedge \forall z \in B(\sigma_0, R), (\operatorname{Re}(z) > \sigma_0 \implies F(z) = L(z)).
   $$
2. **Abscissa Upper Bound via Continuation:**
   Formal deduction (`ActualCriticalConvergence.lean`) that if an explicit tail measure has a holomorphic continuation along the real axis down to $\sigma = 1/2$, its finite abscissa of convergence $\sigma_0$ cannot exceed $1/2$:
   $$
   \sigma_0 \le 1/2.
   $$
3. **Formal Verification of the Critical Sign Criterion for the Riemann Hypothesis:**
   Formal proof (`ActualCriticalSignCriterion.lean`) linking the arithmetic sum $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$ to the full Riemann Hypothesis:
   $$
   (\exists A \ge 1, \forall x > A, \operatorname{Re}(W(x)) \le 0) \implies \mathrm{RiemannHypothesis}.
   $$
4. **Scope of the sign premise:**
   Eventual non-positivity of this $W(x)$ remains unproved. The known two-sided oscillation theorem concerns $W_b-W$, a different function. The two-sided excursion theorem for the full $W$ assumes an off-critical zeta zero, so it cannot rule out the premise unconditionally.

---

## 2. Mathematical Proof Architecture in Lean 4

### 2.1. Disk Center Displacement and Taylor Majorization
The core lemma (`LocalLandauExtension.lean`) starts with a holomorphic continuation $F$ on $B(a,R)$ that agrees with the Laplace integral to the right of the convergence abscissa $a$. Choose $0<3\delta<R$. The Taylor expansion about $a+\delta$ then has coefficients given by derivatives of the Laplace integral:
$$
\frac{(-1)^n}{n!} F^{(n)}(a + \delta) = \frac{1}{n!} \int_0^\infty t^n e^{-(a + \delta) t} d\mu(t) \ge 0.
$$
Because all derivatives have non-negative signs (up to $(-1)^n$), evaluating the power series at a point to the left of the abscissa ($a - \delta$) involves only non-negative terms. Monotone convergence then proves that the Laplace integral converges at $a - \delta$, contradicting the definition of $a = \sigma_0$ as the infimum of the convergence set.

### 2.2. Deduction of RH from Eventual Non-Positivity
If $W(x) \le 0$ for $x > A$, then $-W(x) \ge 0$ defines a positive tail measure. Its Laplace transform is the negative of the Mellin transform of $W$, up to an entire compact-initial contribution. The exact Mellin identity, initially for $\operatorname{Re}s>1$, is
$$
\int_1^\infty W(x)x^{-s-2}\,dx
=\frac{\zeta(s+1/2)}{s(s+1)}\left[G(s)^2-H(s)\right],
\quad G(s)=-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1},
\quad H(s)=\sum_{n\ge1}\frac{\Lambda(n)(\log n-\Lambda(n))}{n^s}.
$$
The right side is analytic at every real $s>1/2$; $H$ is holomorphic in that half-plane. Landau's theorem forces the tail transform's convergence abscissa to be at most $1/2$. Holomorphy throughout $\operatorname{Re}s>1/2$ then excludes an off-line zeta zero: one would give the displayed Mellin expression a genuine double pole with nonzero coefficient $m^2\zeta(\rho+1/2)/[\rho(\rho+1)]$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0:
```lean
theorem no_holomorphic_extension (hτ : Measurable τ)
    (hτ0 : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hne : (LaplaceConvergenceAbscissa.convergenceSet μ τ).Nonempty)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ)) :
    ¬ ∃ (R : ℝ) (F : ℂ → ℂ), 0 < R ∧
      DifferentiableOn ℂ F (Metric.ball
        ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R) ∧
      (∀ z ∈ Metric.ball
        ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R,
        sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re →
        F z = LaplaceMomentDerivatives.moment μ τ 0 z)

theorem RiemannHypothesis_of_nonpos_after {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature context and status

- **Prior literature:** Landau's theorem is classical, and Robin1984 provides a public general positive-measure analytic-continuation formalization. The checked arithmetic bridge and local complex interface remain a provisional, scope-limited formalization contribution.
- **Advancement:** Connects the actual critical arithmetic sign criterion to the formalized convergence barrier and arbitrary-multiplicity zero obstruction. The eventual sign premise is unproved.
