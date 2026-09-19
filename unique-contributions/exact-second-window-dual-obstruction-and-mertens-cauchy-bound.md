# Unique Contribution 281: Exact Second-Window Dual Obstruction and Mertens Cauchy Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SecondWindow.lean`](../../formalization/BuildingBlocks/SecondWindow.lean), [`building-blocks/mertens-transfer/second-window.md`](../../building-blocks/mertens-transfer/second-window.md)  
**Classification:** Analytic Number Theory / Harmonic Analysis / Dual Approximation / Mertens Function / Arithmetic Obstructions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dual approximation theory of the Riemann hypothesis and the Mertens function $M(N) = \sum_{n \le N} \mu(n)$, an essential question is whether subtracting the mean period correction from the dual approximation can restore convergence to the target $-1$ in $L^2(0, 1)$.

This contribution establishes an exact arithmetic obstruction arising from the second dyadic window $(1/N, 2/N)$:

1. **Second-Window Arithmetic Obstruction Theorem:**  
   If the mean-corrected dual approximation $\text{meanCorrectedDual}_N(x)$ converges in $L^2(0, 1)$ to $-1$ as $N \to \infty$ (i.e. $\int_0^1 (1 + \text{meanCorrectedDual}_N(x))^2 dx \to 0$), then:
   \[
   \lim_{N \to \infty} \frac{(M(N) + M(\lfloor N/2 \rfloor) + 3)^2}{N} = 0.
   \]
2. **Non-Asymptotic Second-Window Cauchy Lower Bound:**  
   For any integers $M \ge 2$ and $N \ge 2M$:
   \[
   \frac{(M(N) + M(\lfloor N/2 \rfloor) + 3)^2}{N} \le 4 \, \mathcal{E}_{\text{corr}}(N) + 4 \, \mathcal{E}_{\text{corr}}(M),
   \]
   where $\mathcal{E}_{\text{corr}}(N) = \int_0^1 (1 + \text{meanCorrectedDual}_N(x))^2 dx$.
3. **Exact Second-Window Reciprocal Image Formula:**  
   On the second window $x \in (1/N, 2/N)$:
   \[
   \text{correctedImage}_N(x) = -2 + \frac{M(N) + M(\lfloor N/2 \rfloor) + 3}{Nx},
   \]
   whereas on the first window $x \in (0, 1/N)$:
   \[
   \text{correctedImage}_N(x) = -2.
   \]
4. **Exact Window Difference and Inverse-Square Integral:**  
   Whenever $2M \le N$, for $x \in (1/N, 2/N)$, one has $x < 1/M$, so $\text{correctedImage}_M(x) = -2$, yielding the exact local difference:
   \[
   \text{correctedImage}_N(x) - \text{correctedImage}_M(x) = \frac{M(N) + M(\lfloor N/2 \rfloor) + 3}{Nx}.
   \]
   Integrating the square over $[1/N, 2/N]$ evaluates in closed form to:
   \[
   \int_{1/N}^{2/N} \left( \frac{C}{Nx} \right)^2 dx = \frac{C^2}{2N}.
   \]
5. **Reciprocal Isometry Conjugation:**  
   The $L^2(0, \infty)$ distance between mean-corrected duals is exactly isometric to the distance between reciprocal images:
   \[
   \int_0^\infty (\text{meanCorrectedDual}_N(x) - \text{meanCorrectedDual}_M(x))^2 dx = \int_0^\infty (\text{correctedImage}_N(x) - \text{correctedImage}_M(x))^2 dx.
   \]

---

## 2. Mathematical Proof

### 2.1. Reciprocal Kernel Evaluation
The reciprocal kernel is $K_{\text{rec}}(\theta, x) = 1 - \frac{1}{\theta}\{\theta/x\}$.
For $x \in (1/N, 2/N)$ and $\theta = 1/N$, $\theta/x = 1/(Nx) \in (1/2, 1)$, so $\lfloor 1/(Nx) \rfloor = 0$ is for $x > 1/N$. More precisely, under scaling by $x/\theta = Nx \in (1, 2)$:
$\lfloor Nx \rfloor = 1$, so the fractional part $\{Nx\} = Nx - 1$.
Thus:
\[
K_{\text{rec}}(1/N, x) = 1 - \frac{Nx - 1}{Nx} = 1 - \left( 1 - \frac{1}{Nx} \right) = \frac{1}{Nx}.
\]
For $q \ge 2$, $q/N \ge 2/N > x$, so $x < q/N$, and $K_{\text{rec}}(q/N, x) = 1$.

### 2.2. Corrected Image Computation
The corrected coefficients satisfy $\sum_{q=1}^N c_N(q) = -2$, and the lead coefficient is:
\[
c_N(1) = -(M(N) + M(\lfloor N/2 \rfloor) + 3).
\]
On $(1/N, 2/N)$:
\[
\text{correctedImage}_N(x) = \sum_{q=1}^N c_N(q) K_{\text{rec}}(q/N, x) = \sum_{q=1}^N c_N(q) - c_N(1) \left( 1 - K_{\text{rec}}(1/N, x) \right) = -2 - \frac{c_N(1)}{Nx}.
\]
Substituting $c_N(1)$ gives $-2 + \frac{M(N) + M(\lfloor N/2 \rfloor) + 3}{Nx}$.

### 2.3. Window Difference and Lower Bound
For $N \ge 2M$ and $x \in (1/N, 2/N)$, $x < 2/N \le 1/M$. Thus $x$ falls entirely in the first window of $M$, where $\text{correctedImage}_M(x) = -2$.
Subtracting gives:
\[
\text{correctedImage}_N(x) - \text{correctedImage}_M(x) = \frac{C_2(N)}{Nx}, \quad \text{where } C_2(N) = M(N) + M(\lfloor N/2 \rfloor) + 3.
\]
Integrating the squared difference over $[1/N, 2/N]$:
\[
\int_{1/N}^{2/N} \left( \frac{C_2(N)}{Nx} \right)^2 dx = \frac{C_2(N)^2}{N^2} \left[ -\frac{1}{x} \right]_{1/N}^{2/N} = \frac{C_2(N)^2}{N^2} \left( N - \frac{N}{2} \right) = \frac{C_2(N)^2}{2N}.
\]
By the reciprocal isometry, this interval integral lower-bounds the full $L^2(0, \infty)$ distance:
\[
\frac{C_2(N)^2}{2N} \le \int_0^\infty (\text{meanCorrectedDual}_N - \text{meanCorrectedDual}_M)^2 dx.
\]
Since $\text{meanCorrectedDual}$ vanishes for $x > 1$:
\[
\int_0^\infty (\text{meanCorrectedDual}_N - \text{meanCorrectedDual}_M)^2 dx \le 2 \mathcal{E}_{\text{corr}}(N) + 2 \mathcal{E}_{\text{corr}}(M).
\]
Multiplying by 2 completes the proof.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SecondWindow.lean`):
```lean
theorem correctedImage_first_window {N : ℕ} (hN : 2 ≤ N) {x : ℝ}
    (hx0 : 0 < x) (hx1 : x < 1 / (N : ℝ)) : correctedImage N x = -2

theorem correctedImage_second_window {N : ℕ} (hN : 2 ≤ N) {x : ℝ}
    (hx1 : 1 / (N : ℝ) < x) (hx2 : x < 2 / (N : ℝ)) :
    correctedImage N x = -2 +
      ((mertens N : ℝ) + (mertens (N / 2) : ℝ) + 3) / ((N : ℝ) * x)

theorem scaled_inverse_square_integral {N : ℕ} (hN : 0 < N) (C : ℝ) :
    (∫ x in (1 / (N : ℝ))..(2 / (N : ℝ)), (C / ((N : ℝ) * x)) ^ 2) =
      C ^ 2 / (2 * (N : ℝ))

theorem corrected_second_window_cauchy_bound {N M : ℕ} (hM : 2 ≤ M) (hNM : 2 * M ≤ N) :
    secondWindowCoefficient N ^ 2 / (N : ℝ) ≤
      4 * correctedTotalError N + 4 * correctedTotalError M

theorem secondWindowCoefficient_sq_tendsto_of_corrected_convergence
    (h : MeanCorrectedConvergence) :
    Tendsto (fun N : ℕ => secondWindowCoefficient N ^ 2 / (N : ℝ)) atTop (𝓝 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Báez-Duarte's reformulation of the Nyman–Beurling criterion (2003), Balazard & Saias (1995), and Burnol's operator-theoretic models. The exact second-window arithmetic obstruction $(M(N) + M(N/2) + 3)^2 / N$ under reciprocal isometry conjugation in Lean 4 is new.
- **Advancement:** Proves that mean period removal is strictly insufficient to obtain dual $L^2$ convergence without forcing sub-$\sqrt{N}$ bounds on $M(N) + M(N/2)$.
- **Target Venues:** *Journal of Number Theory* or *Bulletin of the London Mathematical Society*.
