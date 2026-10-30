# Chebyshev Fluctuation Bound and Centered Growth Resolution

**Module Path**: `formalization/BuildingBlocks/RiemannZetaChebyshevFluctuationBound.lean`  
**Root Module**: `formalization/BuildingBlocks.lean`  
**Audit Path**: `formalization/verification/RiemannZetaChebyshevFluctuationBoundAudit.lean`  
**Dependencies**:
- `BuildingBlocks.CoarsePrimeBounds`
- `BuildingBlocks.HyperbolaProduct`
- `BuildingBlocks.ActualCenteredMellin`
- `BuildingBlocks.ActualFullCenteredMellin`
- `BuildingBlocks.ActualFullCenteredMellinInversion`
- `BuildingBlocks.ActualCriticalGrowthCriterion`
- `BuildingBlocks.ActualCriticalLogMajorant`
- `BuildingBlocks.RiemannZetaPrimeAllocationGrowth`
- `BuildingBlocks.RiemannZetaGrandEquivalence`
- `Mathlib`

---

## 1. Mathematical and Analytic Summary

This module establishes unconditional polynomial upper bounds on the real part of the
centered fluctuation sum $\operatorname{fullNumerator}(x)$ and the critical transform kernel $\mathcal{W}(x)$,
synthesizing two complementary analytic routes:

### Route 1: Discrete Chebyshev Summation
Using the machine-checked linear Chebyshev bound $\psi(N) \le (4 \log 2) N$ from `CoarsePrimeBounds.lean`,
the Dirichlet convolution hyperbola sum satisfies:
$$\sum_{n \le N} (\Lambda * \Lambda)(n) = \sum_{a \le N} \Lambda(a) \psi(\lfloor N / a \rfloor) \le (4 \log 2)^2 N^2.$$
Integrating this with the Riesz tent kernel $(x - n) \le x$ and using the unconditional nonnegativity
of the subtracted diagonal allocation terms $\Lambda(n)(x^2 - n^2)/n \ge 0$, we deduce:
$$\operatorname{Re}(N(x)) \le C_N x^3 \quad (\forall x \ge 0),$$
where $C_N = (4 \log 2)^2 + 1$.
Aggregating over the square-root divisor sum yields the unconditional quartic Chebyshev bound:
$$\operatorname{Re}(\operatorname{fullNumerator}(x)) \le C_N x^4 \quad (\forall x \ge 1).$$
Via the pointwise dominance $\operatorname{Re}(\mathcal{W}(x)) \le \operatorname{Re}(\operatorname{fullNumerator}(x))$,
the critical transform kernel satisfies the identical quartic bound:
$$\operatorname{Re}(\mathcal{W}(x)) \le C_N x^4 \quad (\forall x \ge 1).$$

### Route 2: Complex Contour Perron Inversion
Evaluating the Mellin--Perron inversion identity from `ActualFullCenteredMellinInversion.lean`
along any vertical contour $\operatorname{Re}(s) = c > 2$:
$$\operatorname{fullNumerator}(x) = \frac{1}{2\pi} \int_{-\infty}^\infty x^{c + it} \operatorname{fullFactor}(c - 1 + it) dt,$$
and applying the vertical decay estimate
$$\|\operatorname{perronKernel}(c, x, t)\| \le x^c \frac{\operatorname{verticalAllowance}(c - 1)}{1 + t^2},$$
integration against the standard improper Cauchy integral $\int_{-\infty}^\infty (1 + t^2)^{-1} dt = \pi$ establishes:
$$\|\operatorname{fullNumerator}(x)\| \le \frac{1}{2} \operatorname{verticalAllowance}(c - 1) x^c \quad (\forall c > 2, x > 0),$$
and consequently:
$$\operatorname{Re}(\operatorname{fullNumerator}(x)) \le \frac{1}{2} \operatorname{verticalAllowance}(c - 1) x^c,$$
$$\operatorname{Re}(\mathcal{W}(x)) \le \frac{1}{2} \operatorname{verticalAllowance}(c - 1) x^c.$$

### Route 3: Fluctuation Majorant Synthesis
Connecting centered fluctuation control to the Riemann Hypothesis:
1. **Logarithmic Majorant Bridge**:
   $$\left(\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2} (\log x)^2\right) \implies \text{RiemannHypothesis}$$
2. **Subquadratic Fluctuation Bridge**:
   $$\left(\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2}\right) \implies \text{RiemannHypothesis}$$
3. **Analytic Continuation**:
   Forces global analyticity of $\operatorname{filledTransform}$ on $\operatorname{Re}(s) > 1/2$.
4. **Target Derivation**:
   Constructively proves Mathlib's canonical `Target`.

---

## 2. Audited Machine-Checked Declarations

All 21 theorems below are formally verified in Lean 4.34.1 with **0 `sorry`**, **0 `sorryAx`**,
and strictly depend on standard foundational Lean 4 axioms `[propext, Classical.choice, Quot.sound]`:

1. `sum_vonMangoldt_sq_eq_sum_psi`: Exact hyperbola transformation for Dirichlet convolution.
2. `sum_vonMangoldt_sq_le`: Pointwise quadratic bound $\sum_{n \le N} (\Lambda * \Lambda)(n) \le (4 \log 2)^2 N^2$.
3. `tent_sum_vonMangoldt_sq_le`: Riesz tent cubic bound $\sum_{n \le x} (x - n)(\Lambda * \Lambda)(n) \le (4 \log 2)^2 x^3$.
4. `sum_N_core_le`: Subtracted allocation nonnegativity and core cubic bound $\le (4 \log 2)^2 x^3$.
5. `baseline_re_le`: Baseline asymptotic bound $\operatorname{Re}(B(x)) \le x^3$.
6. `C_N`: Explicit numeric constant $(4 \log 2)^2 + 1$.
7. `C_N_pos`: Positivity $0 < C_N$.
8. `N_re_le`: Centered Mellin cubic bound $\operatorname{Re}(N(x)) \le C_N x^3$.
9. `fullNumerator_re_le_quartic`: Quartic Chebyshev fluctuation bound $\operatorname{Re}(\operatorname{fullNumerator}(x)) \le C_N x^4$ ($x \ge 1$).
10. `W_re_le_quartic`: Quartic critical kernel bound $\operatorname{Re}(\mathcal{W}(x)) \le C_N x^4$ ($x \ge 1$).
11. `eventually_fullNumerator_re_le_quartic`: Eventual quartic fluctuation filter bound at $\infty$.
12. `eventually_W_re_le_quartic`: Eventual quartic critical kernel filter bound at $\infty$.
13. `norm_fullNumerator_le_perron`: Complex Perron contour norm bound $\le \frac{1}{2} \operatorname{verticalAllowance}(c-1) x^c$.
14. `fullNumerator_re_le_perron`: Complex Perron contour real part bound $\le \frac{1}{2} \operatorname{verticalAllowance}(c-1) x^c$.
15. `W_re_le_perron`: Critical kernel Perron contour bound $\le \frac{1}{2} \operatorname{verticalAllowance}(c-1) x^c$.
16. `RiemannHypothesis_of_fullNumerator_log_growth_after`: Cutoff log-majorant fluctuation implication of RH.
17. `RiemannHypothesis_of_eventually_fullNumerator_log_growth`: Filter log-majorant fluctuation implication of RH.
18. `RiemannHypothesis_of_fullNumerator_subquadratic_growth_after`: Cutoff subquadratic fluctuation implication of RH.
19. `RiemannHypothesis_of_eventually_fullNumerator_subquadratic_growth`: Filter subquadratic fluctuation implication of RH.
20. `analyticOnNhd_filledTransform_of_eventually_fullNumerator_log_growth`: Analytic continuation of filled transform.
21. `target_of_eventually_fullNumerator_log_growth`: Mathlib canonical `Target` deduction.

---

## 3. Kernel Verification Summary

```
CHEBYSHEV FLUCTUATION BOUND AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry
```
