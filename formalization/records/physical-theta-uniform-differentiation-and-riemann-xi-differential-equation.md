# Contribution 80: Physical Theta Uniform Differentiation and Riemann Xi Differential Equation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PhysicalThetaUniform.lean`](../../formalization/BuildingBlocks/PhysicalThetaUniform.lean)  
**Classification:** Analytic Number Theory / Classical Analysis / Theta Functions / Riemann Xi-Function / Uniform Convergence of Series

---

## 1. Executive Summary and Mathematical Statement

In Riemann's second proof of the functional equation for $\zeta(s)$, the completed xi-function $\xi(s)$ is expressed as the Mellin transform of the Jacobi theta seed $\omega(x) = \sum_{n=1}^\infty e^{-\pi n^2 x}$. In logarithmic coordinates $x = e^{2u}$, the physical theta seed function is given by:
$$
S(u) = \sum_{n=1}^\infty e^{u/2} e^{-\pi n^2 e^{2u}}.
$$

This contribution proves:

1. **Local Weierstrass M-Test Envelopes:**  
   On any compact interval $[A, B] \subset \mathbb{R}$, the summand $S_n(u) = e^{u/2} e^{-\pi n^2 e^{2u}}$ and its first two derivatives satisfy uniform bounds:
   $$
   |S_n(u)| \le E_{\mathrm{seed}}(A, B, n) = e^{B/2} e^{-\pi e^{2A} n},
   $$
   $$
   |S_n'(u)| \le E_{\mathrm{slope}}(A, B, n), \quad |S_n''(u)| \le E_{\mathrm{curv}}(A, B, n),
   $$
   where all envelope sequences $E(A, B, \cdot)$ are geometrically summable over $n \in \mathbb{N}$.
2. **Term-by-Term Twice Differentiability:**  
   The infinite series $S(u) = \sum_{n=1}^\infty S_n(u)$ is twice continuously differentiable on all of $\mathbb{R}$, with derivatives computed term-by-term:
   $$
   S'(u) = \sum_{n=1}^\infty S_n'(u), \quad S''(u) = \sum_{n=1}^\infty S_n''(u).
   $$
3. **Exact Xi-Potential Differential Equation:**  
   The second derivative of the physical theta seed satisfies the exact differential identity:
   $$
   S''(u) - \frac{1}{4} S(u) = \Phi(u),
   $$
   where $\Phi(u) = \sum_{n=1}^\infty (4 \pi^2 n^4 e^{4u} - 6 \pi n^2 e^{2u}) e^{u/2} e^{-\pi n^2 e^{2u}}$ is the kernel of the Riemann xi-function $\xi(s) = \int_{-\infty}^\infty \Phi(u) \cosh((s - 1/2)u) \, du$.
4. **Significance for Spectral Realization:**  
   Rigorous verification of the differential link between the raw Jacobi theta series and the xi-potential $\Phi(u)$ establishes that the operator $\mathcal{H}_0 = -\frac{d^2}{du^2} + \frac{1}{4}$ generates the xi-potential directly from the theta field, without any formal or uncertified interchange of differentiation and summation.

---

## 2. Mathematical Proof

### 2.1. Argument Monotonicity and Envelopes
Let $\theta_n(u) = \pi n^2 e^{2u}$. For $u \in [A, B]$, $\theta_n(u) \ge \pi n^2 e^{2A} \ge \pi n e^{2A}$ since $n^2 \ge n$.
The exponential factor is bounded by $\exp(-\theta_n(u)) \le \exp(-\pi e^{2A} n)$.
The prefactor $e^{u/2} \le e^{B/2}$.
The derivatives introduce polynomial factors in $\theta_n(u) \le \pi n^2 e^{2B}$.
By the ratio test, $\sum_{n=1}^\infty n^k \exp(-c n) < \infty$ for any $c > 0$ and $k \ge 0$, establishing summability of all three envelopes.

### 2.2. Term-by-Term Differentiation
Applying `hasDerivAt_tsum_of_isPreconnected` on the open interval $(u-1, u+1)$ establishes that $S'(u) = \sum S_n'(u)$ and $S''(u) = \sum S_n''(u)$.

### 2.3. Summand Differential Identity
For each single term $S_n(u) = e^{u/2} e^{-\pi n^2 e^{2u}}$:
$$
S_n'(u) = \left(\frac{1}{2} - 2 \pi n^2 e^{2u}\right) S_n(u),
$$
$$
S_n''(u) = \left(\frac{1}{4} - 6 \pi n^2 e^{2u} + 4 \pi^2 n^4 e^{4u}\right) S_n(u).
$$
Subtracting $\frac{1}{4} S_n(u)$:
$$
S_n''(u) - \frac{1}{4} S_n(u) = (4 \pi^2 n^4 e^{4u} - 6 \pi n^2 e^{2u}) S_n(u) = \Phi_n(u).
$$
Summing over $n \ge 1$ by absolute convergence yields $S''(u) - \frac{1}{4} S(u) = \Phi(u)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PhysicalThetaUniform`):
```lean
theorem seedSum_hasDerivAt (u : ℝ) : HasDerivAt seedSum (slopeSum u) u

theorem slopeSum_hasDerivAt (u : ℝ) : HasDerivAt slopeSum (curvatureSum u) u

theorem seedSum_second_deriv : deriv (deriv seedSum) = curvatureSum

theorem seedSum_differential_identity (u : ℝ) :
    deriv (deriv seedSum) u - seedSum u / 4 = phi u

theorem phi_continuous : Continuous phi
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** The identity $\Phi(u) = S''(u) - \frac{1}{4} S(u)$ is classical (dating back to Riemann, 1859). However, its machine verification with rigorous local uniform derivative envelopes and exchange of summation and limits had not been formalized in Lean 4.
- **Advancement:** Provides a Lean 4 proof of the stated classical second-order differential identity linking the Jacobi theta function to Riemann's xi-function kernel. Priority among formalizations is not established by this audit.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Annalen*.
