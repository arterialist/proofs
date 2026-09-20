# Contribution 272: Exact Dual Fractional-Approximation L² Lower Bound and Mertens Obstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FractionalApproximation.lean`](../../formalization/BuildingBlocks/FractionalApproximation.lean), [`building-blocks/prime-distribution/fractional-approximation-mertens.md`](../../building-blocks/prime-distribution/fractional-approximation-mertens.md)  
**Classification:** Analytic Number Theory / Fractional Parts / Mertens Function / $L^2$ Approximation / Change of Variables / Periodic Errors / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the Báez-Duarte and Nyman-Beurling approaches to the Riemann Hypothesis, the characteristic function $\chi_{(0,1)}$ or constant function $-1$ is approximated in $L^2(0, 1)$ by linear combinations of dilated fractional parts:
$$
D_N(x) = \sum_{q=1}^N c_{N, q} \left\{ \frac{q}{N x} \right\} - \left\{ \frac{1}{N x} \right\}.
$$
An open question in analytic number theory has been whether explicit lower bounds can be established relating the $L^2$ approximation error to the classical Mertens function $M(N) = \sum_{n=1}^N \mu(n)$.

This contribution proves:

1. **Unconditional Dual $L^2$ Mean-Square Error Lower Bound:**  
   For all $N \ge 1$, the $L^2(0, 1)$ error of the dual fractional approximation against $-1$:
   $$
   E_2(N) = \int_0^1 (1 + D_N(x))^2 dx
   $$
   satisfies the unconditional lower bound:
   $$
   E_2(N) \ge \frac{(M(N) + 1)^2}{16 N}.
   $$
   Equivalently,
   $$
   \frac{M(N)^2}{N} \le 32 E_2(N) + \frac{2}{N}.
   $$
2. **Normalized Mertens Limit Convergence Theorem:**  
   If the dual fractional approximation error converges to zero in $L^2(0, 1)$:
   $$
   \lim_{N \to \infty} E_2(N) = 0 \implies \lim_{N \to \infty} \frac{M(N)^2}{N} = 0.
   $$
3. **Mertens Oscillation Obstruction (Conditional Route Exclusion):**  
   If $M(N)$ oscillates such that $M(N)^2 / N \not\to 0$ (e.g. following Odlyzko-te Riele or known $\Omega_\pm(\sqrt{N})$ oscillations), then the dual fractional approximation $D_N$ CANNOT converge to $-1$ in $L^2(0, 1)$:
   $$
   \neg \left( \frac{M(N)^2}{N} \to 0 \right) \implies \neg \left( E_2(N) \to 0 \right).
   $$
4. **Exact Jacobian Change of Variables on Shrinking Window:**  
   Under the change of variables $x = \frac{1}{Ny}$ on the shrinking dyadic window $[1/(2N), 1/N]$, with Jacobian $|dx/dy| = \frac{1}{N y^2}$:
   $$
   \int_{1/(2N)}^{1/N} (1 + D_N(x))^2 dx = \frac{1}{N} \int_1^2 \frac{R_N(y)^2}{y^2} dy,
   $$
   where $R_N(y) = 1 + \sum_{q=1}^N c_{N, q} \{qy\} - \{y\}$ is 1-periodic.
5. **Exact Periodic Error Mean Value:**  
   The mean value of $R_N(y)$ across any unit period is identically:
   $$
   \int_0^1 R_N(y) dy = \int_1^2 R_N(y) dy = \frac{M(N) + 1}{2}.
   $$

---

## 2. Mathematical Proof

### 2.1. Periodicity and Mean Value of $R_N(y)$
Using the identity $\int_0^1 \{qy\} dy = 1/2$ for all integers $q \ge 1$:
$$
\int_0^1 R_N(y) dy = 1 + \sum_{q=1}^N c_{N, q} \int_0^1 \{qy\} dy - \int_0^1 \{y\} dy = 1 + \frac{1}{2} \sum_{q=1}^N c_{N, q} - \frac{1}{2}.
$$
Since $\sum_{q=1}^N c_{N, q} = M(N)$ (the grouped quotient sum over Möbius values):
$$
\int_0^1 R_N(y) dy = 1 + \frac{M(N)}{2} - \frac{1}{2} = \frac{M(N) + 1}{2}.
$$

### 2.2. Cauchy-Schwarz on Unit Interval
By Cauchy-Schwarz on $[1, 2]$ of length $1$:
$$
\int_1^2 R_N(y)^2 dy \ge \left( \int_1^2 R_N(y) dy \right)^2 = \frac{(M(N) + 1)^2}{4}.
$$

### 2.3. Weighted Integral and Window Energy
Since $y \le 2$ on $[1, 2]$, $y^2 \le 4$, so:
$$
\int_1^2 \frac{R_N(y)^2}{y^2} dy \ge \frac{1}{4} \int_1^2 R_N(y)^2 dy \ge \frac{(M(N) + 1)^2}{16}.
$$
Substituting into the Jacobian pullback:
$$
E_2(N) \ge \int_{1/(2N)}^{1/N} (1 + D_N(x))^2 dx = \frac{1}{N} \int_1^2 \frac{R_N(y)^2}{y^2} dy \ge \frac{(M(N) + 1)^2}{16 N}.
$$

### 2.4. Mertens Square Squeeze
Using $(a+1)^2 = a^2 + 2a + 1 \ge a^2/2 - 1$:
$$
\frac{M(N)^2}{N} \le 32 E_2(N) + \frac{2}{N}.
$$
Taking $N \to \infty$ with $E_2(N) \to 0$ forces $M(N)^2 / N \to 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/FractionalApproximation.lean`):
```lean
theorem quotient_coefficient_sum (N : ℕ) :
    ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) = (mertens N : ℝ)

theorem reciprocalError_periodic (N : ℕ) :
    Function.Periodic (reciprocalError N) 1

theorem reciprocalError_mean_zero_one (N : ℕ) :
    (∫ y in (0 : ℝ)..1, reciprocalError N y) = ((mertens N : ℝ) + 1) / 2

theorem reciprocalError_mean_square_lower (N : ℕ) :
    ((mertens N : ℝ) + 1) ^ 2 / 4 ≤
      ∫ y in (1 : ℝ)..2, reciprocalError N y ^ 2

theorem dualWindowEnergy_eq_weighted {N : ℕ} (hN : 0 < N) :
    dualWindowEnergy N = (1 / (N : ℝ)) *
      ∫ y in (1 : ℝ)..2, reciprocalError N y ^ 2 / y ^ 2

theorem dualMeanSquareError_lower {N : ℕ} (hN : 0 < N) :
    ((mertens N : ℝ) + 1) ^ 2 / (16 * (N : ℝ)) ≤ dualMeanSquareError N

theorem mertens_sq_le_dual_error {N : ℕ} (hN : 0 < N) :
    (mertens N : ℝ) ^ 2 / (N : ℝ) ≤ 32 * dualMeanSquareError N + 2 / (N : ℝ)

theorem mertens_sq_normalized_tendsto_of_dual_error
    (h : Tendsto dualMeanSquareError atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)

theorem dual_error_not_tendsto_of_mertens_oscillation
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto dualMeanSquareError atTop (𝓝 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Nyman-Beurling-Báez-Duarte criterion for the Riemann Hypothesis, fractional-part approximation in $L^2(0, 1)$ (Báez-Duarte 2003, Burnol 2002, Bettin-Conrey 2013). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects $L^2$ fractional-part approximation directly to the oscillation of the Mertens function, proving that $\Omega(\sqrt{N})$ Mertens growth obstructs $L^2$ convergence.
- **Target Venues:** *Advances in Mathematics* or *Journal of Functional Analysis*.
