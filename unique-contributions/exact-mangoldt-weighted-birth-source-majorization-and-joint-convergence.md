# Unique Contribution 291: Exact Mangoldt-Weighted Birth-Source Majorization and Joint Convergence

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/IntegerBirthSourceBound.lean`](../../formalization/BuildingBlocks/IntegerBirthSourceBound.lean), [`building-blocks/birth-kernel/source-bounds.md`](../../building-blocks/birth-kernel/source-bounds.md)  
**Classification:** Analytic Number Theory / Dirichlet Series / Birth Kernels / Von Mangoldt Weights / Piecewise Linear Interpolation / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the integer birth kernel framework, the raw birth source $U(n, u) = q(n, u) - 1/\sqrt{n}$ encodes the instantaneous rate of prime-power entry, while its piecewise linear interpolant $\widetilde{U}(n, u)$ regularizes the discrete transitions. Proving that the regularized total source majorizes the exact arithmetic source unconditionally across all prime powers requires establishing joint summability with von Mangoldt weights.

This contribution proves:

1. **Complete Von Mangoldt-Weighted Source Majorization:**  
   For all real clock arguments $u \ge 0$:
   \[
   \sum_{n=0}^\infty \Lambda(n+2) U(n+2, u) \le \sum_{n=0}^\infty \Lambda(n+2) \widetilde{U}(n+2, u),
   \]
   with both infinite sums proven absolutely convergent!
2. **Exact Analytic Defect Identity:**  
   The defect between the regularized and exact sources decomposes into the convergent termwise difference:
   \[
   \sum_{n=0}^\infty \Lambda(n+2) \widetilde{U}(n+2, u) - \sum_{n=0}^\infty \Lambda(n+2) U(n+2, u) = \sum_{n=0}^\infty \Lambda(n+2) \left( \widetilde{U}(n+2, u) - U(n+2, u) \right).
   \]
3. **Uniform Scale-Invariant First-Moment Bound:**  
   For every birth location $n \ge 2$ and every argument $u \ge 0$:
   \[
   |U(n, u)| \le \frac{(\pi + 1) u}{n \sqrt{n}}, \qquad |\widetilde{U}(n, u)| \le \frac{(\pi + 1) u}{n \sqrt{n}}.
   \]
4. **Absolute Von Mangoldt Decay at Critical Exponent 3/2:**  
   Rigorous deduction via Dirichlet $L$-series theory that:
   \[
   \sum_{n=1}^\infty \frac{\Lambda(n)}{n \sqrt{n}} = \sum_{n=1}^\infty \frac{\Lambda(n)}{n^{3/2}} < \infty.
   \]
5. **Joint Clock-Birth Two-Dimensional Absolute Summability:**  
   For any clock damping parameter $t > 0$, the double series across both birth indices and clock integers converges absolutely:
   \[
   \sum_{n=0}^\infty \sum_{j=0}^\infty e^{-tj} \Lambda(n+2) |U(n+2, j)| < \infty, \qquad \sum_{n=0}^\infty \sum_{j=0}^\infty e^{-tj} \Lambda(n+2) |\widetilde{U}(n+2, j)| < \infty.
   \]

---

## 2. Mathematical Proof

### 2.1. First-Moment Envelope for the Raw Source
For $0 \le u \le n$, convexity of $u \mapsto q(n, u)$ yields:
\[
0 \le U(n, u) \le \left( \frac{\pi}{2} - 1 \right) \frac{u}{n \sqrt{n}} \le \frac{(\pi + 1) u}{n \sqrt{n}}.
\]
For $u \ge n$, $q(n, u) = \frac{\pi}{2 \sqrt{u}}$, so:
\[
|U(n, u)| = \left| \frac{\pi}{2 \sqrt{u}} - \frac{1}{\sqrt{n}} \right| \le \frac{\pi + 1}{\sqrt{n}} \le \frac{(\pi + 1) u}{n \sqrt{n}}.
\]
Thus the bound $|U(n, u)| \le \frac{(\pi + 1) u}{n \sqrt{n}}$ holds universally for all $u \ge 0$.

### 2.2. Preservation Under Linear Interpolation
Let $j = \lfloor u \rfloor$. The interpolant is the convex combination:
\[
\widetilde{U}(n, u) = (j + 1 - u) U(n, j) + (u - j) U(n, j+1).
\]
Applying the triangle inequality and the bounds at $j$ and $j+1$:
\[
|\widetilde{U}(n, u)| \le (j + 1 - u) \frac{(\pi + 1) j}{n \sqrt{n}} + (u - j) \frac{(\pi + 1)(j + 1)}{n \sqrt{n}} = \frac{(\pi + 1) u}{n \sqrt{n}}.
\]

### 2.3. Summability and Majorization
Because $\sum \frac{\Lambda(n)}{n^{3/2}} < \infty$, the comparison test shows that both $\sum \Lambda(n+2) U(n+2, u)$ and $\sum \Lambda(n+2) \widetilde{U}(n+2, u)$ converge absolutely for each fixed $u \ge 0$.
Since $U(n, u) \le \widetilde{U}(n, u)$ pointwise by the established interpolation property, termwise monotonicity under $\Lambda(n) \ge 0$ preserves the inequality in the infinite sum.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.IntegerBirthSourceBound` in `formalization/BuildingBlocks/IntegerBirthSourceBound.lean`):
```lean
theorem U_abs_bound {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    |U n u| ≤ boundConstant*u/((n : ℝ)*Real.sqrt n)

theorem interpolant_abs_bound {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    |interpolant n u| ≤ boundConstant*u/((n : ℝ)*Real.sqrt n)

theorem summable_mangoldt_bound :
    Summable (fun n : ℕ => ArithmeticFunction.vonMangoldt n / ((n : ℝ)*Real.sqrt n))

theorem actual_source_interpolation_le {u : ℝ} (hu : 0 ≤ u) :
    (∑' n : ℕ, sourceTerm n u) ≤ ∑' n : ℕ, interpolatedTerm n u

theorem actual_source_defect_identity {u : ℝ} (hu : 0 ≤ u) :
    (∑' n : ℕ, interpolatedTerm n u)-(∑' n : ℕ, sourceTerm n u) =
      ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2)*(interpolant (n+2) u-U (n+2) u)

theorem exponential_clock_absolute {t : ℝ} (ht : 0 < t) :
    Summable (fun z : ℕ × ℕ => ‖Real.exp (-t*(z.2 : ℝ))*sourceTerm z.1 z.2‖) ∧
    Summable (fun z : ℕ × ℕ => ‖Real.exp (-t*(z.2 : ℝ))*interpolatedTerm z.1 z.2‖)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet series of arithmetic functions (Apostol 1976), Prime Number Theorem in $L$-series representations, and interpolation theory. Machine-checked proofs of von Mangoldt-weighted birth source convergence and two-dimensional double-sum integrability in Lean 4 are new.
- **Advancement:** Establishes that the continuous piecewise linear smoothing of discrete prime-power birth rates preserves absolute summability and provides an exact upper barrier for the full arithmetic source.
- **Target Venues:** *Journal of Number Theory* or *Constructive Approximation*.
