# Verified Unique Contribution 33: Two Canceled Moments in the Integer-Cell Renewal Primitive and Uniform Convex-Cone Sign Deficit

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary Reference:** [`building-blocks/factorial-and-renewal/renewal-bernoulli-cell-phase-cancellation.md`](../../building-blocks/factorial-and-renewal/renewal-bernoulli-cell-phase-cancellation.md)  
**Lean Formalization:** [`formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean`](../../formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean)  
**Target Venue:** *Journal of Mathematical Analysis and Applications* or *Communications in Mathematical Physics*

---

## 1. Executive Statement of Novelty and Core Result

In the analysis of the causal renewal operator associated with the Riemann zeta function, the integer-minus-continuum discrepancy kernel $H(v) = \sum_{m \le e^v} m^{-1/2} - \zeta(1/2) - 2e^{v/2}$ and its integrated primitive $J(v) = \int_0^v H(w)dw$ fluctuate with mean asymptote $\ell = \int_0^\infty H(w)dw = 4 + \zeta'(1/2)$.

On late logarithmic intervals $[\log n, \log(n+1)]$, the local coordinate $v = \log(n+r)$ with $r \in [0, 1]$ expands the discrepancy $J(v) - \ell$ into Bernoulli polynomial profiles:
\[
J(\log(n+r)) - \ell = n^{-3/2}f_0(r) + n^{-5/2}f_1(r) + n^{-7/2}f_2(r) + O(n^{-9/2}),
\]
where $f_0(r) = -\frac{1}{2}B_2(r) = -\frac{1}{2}r^2 + \frac{1}{2}r - \frac{1}{12}$.

**Theorem (Double Moment Cancellation and Uniform Negative Cell Sign).**  
1. **Vanishing Moments:** The leading profile $f_0$ has identically vanishing mean and vanishing first moment, and the first correction $f_1$ has vanishing mean:
   \[
   \int_0^1 f_0(r)dr = 0, \qquad \int_0^1 r f_0(r)dr = 0, \qquad \int_0^1 f_1(r)dr = 0.
   \]
2. **Surviving Phase Coefficient:** For any complex frequency $z \in \mathbb{C}$, the cell Laplace transform $I_n(z) = \int_{\log n}^{\log(n+1)} e^{-zv}(J(v)-\ell)dv$ satisfies the uniform asymptotic:
   \[
   I_n(z) = -\frac{(2z+7)(2z+9)}{2880} n^{-z-9/2} + O_K(n^{-\operatorname{Re}z - 11/2}),
   \]
   governed by the machine-verified exact polynomial moment identity:
   \[
   \int_0^1 \left[f_2(r) - (z+1)r f_1(r) + \frac{(z+1)(z+2)}{2}r^2 f_0(r)\right]dr = -\frac{(2z+7)(2z+9)}{2880}.
   \]
3. **Double-Primitive Strict Negativity:** The twice-integrated profiles are nonpositive across the entire real line and strictly negative on the open unit cell:
   \[
   \int_0^r (r-t)f_0(t)dt = -\frac{r^2(1-r)^2}{24} \le 0, \qquad \int_0^r (r-t)f_1(t)dt = -\frac{r^3[1+3r(1-r)]}{144} < 0 \quad (\forall r \in (0, 1]).
   \]
4. **Uniform Convex-Cone Sign Deficit:** There exists an integer $n_0$ such that for every $n \ge n_0$, every real frequency $x \ge 0$, and every positive, decreasing, convex $C^2$ test weight $w(r) \ge 0$:
   \[
   \int_0^1 w(r)(J(\log(n+r)) - \ell)dr < 0.
   \]
   In particular, the cutoff $n_0$ is completely independent of the unbounded frequency $x$.

---

## 2. Mathematical Proof Architecture

### 2.1 Euler–Maclaurin Cell Expansion
Using DLMF 25.11.43, the partial sum $A_n = \sum_{m=1}^n m^{-1/2} - \zeta(1/2)$ expands as:
\[
A_n = 2\sqrt{n} + \frac{1}{2\sqrt{n}} - \frac{1}{24n^{3/2}} + \frac{1}{384n^{7/2}} + O(n^{-11/2}).
\]
Within the cell $v = \log(n+r)$, $H(v) = A_n - 2\sqrt{n+r}$. Expanding $H(v)dv = H(\log(n+r))\frac{dr}{n+r}$ in powers of $n^{-1}$ yields:
\[
H dv = \left[n^{-3/2}h_0(r) + n^{-5/2}h_1(r) + n^{-7/2}h_2(r) + O(n^{-9/2})\right]dr,
\]
with $h_0(r) = 1/2 - r$. Integrating to $r$ and subtracting the tail asymptotic $\ell - J(\log n) = \frac{1}{12n^{3/2}} - \frac{23}{2880n^{7/2}} + O(n^{-9/2})$ produces the polynomial cell profiles $f_0(r), f_1(r), f_2(r)$.

### 2.2 Algebraic Moment Cancellation
Integration of polynomial terms in Lean 4 certifies:
- $\int_0^1 f_0 = [-r^3/6 + r^2/4 - r/12]_0^1 = -1/6 + 1/4 - 1/12 = 0$.
- $\int_0^1 r f_0 = [-r^4/8 + r^3/6 - r^2/24]_0^1 = -1/8 + 1/6 - 1/24 = 0$.
- $\int_0^1 f_1 = [5r^4/48 - r^3/12 - r^2/48]_0^1 = 5/48 - 4/48 - 1/48 = 0$.

Because the Taylor expansion of $e^{-zv}dv = n^{-z-1}(1 + r/n)^{-z-1}dr$ begins $n^{-z-1}[1 - (z+1)r/n + \frac{(z+1)(z+2)}{2}r^2/n^2 + \dots]$, the vanishing of $\int f_0$ and $\int r f_0$ forces the first two orders $n^{-z-5/2}$ and $n^{-z-7/2}$ to vanish completely. The leading surviving term at order $n^{-z-9/2}$ is determined by the linear combination:
\[
\int_0^1 f_2 - (z+1)\int_0^1 r f_1 + \frac{(z+1)(z+2)}{2}\int_0^1 r^2 f_0 = -\frac{7}{576} - \frac{z+1}{144} - \frac{(z+1)(z+2)}{720} = -\frac{(2z+7)(2z+9)}{2880}.
\]

### 2.3 Double Integration and Integration by Parts
Let $F_n(r) = J(\log(n+r)) - \ell$ and $G_n(r) = \int_0^r (r-t)F_n(t)dt$.
The double primitives of $f_0$ and $f_1$ evaluate to exact algebraic squares:
\[
\int_0^r (r-t)f_0(t)dt = -\frac{r^2(1-r)^2}{24} \le 0, \qquad \int_0^r (r-t)f_1(t)dt = -\frac{r^3[1+3r(1-r)]}{144} \le 0.
\]
For any decreasing convex weight $w \ge 0$, integration by parts twice yields:
\[
\int_0^1 w(r)F_n(r)dr = w(1)G_n'(1) - w'(1)G_n(1) + \int_0^1 w''(r)G_n(r)dr < 0,
\]
since $w(1) \ge 0$, $G_n'(1) < 0$, $w'(1) \le 0$, $G_n(1) < 0$, $w''(r) \ge 0$, and $G_n(r) < 0$ on $(0, 1]$.

---

## 3. Literature Comparison

| Feature | Standard Renewal Kernel | Euler Discrepancy Audits | This Work |
|---|---|---|---|
| **Cell Discrepancy** | Unbounded fluctuations | Single-cell $O(n^{-3/2})$ bound | Exact Bernoulli expansion $f_0, f_1, f_2$ |
| **Leading Moments** | Not computed | Assumed non-vanishing | **Proved $\int f_0 = 0$ and $\int r f_0 = 0$** |
| **Surviving Phase** | Qualitative | Unknown | **Exact $-\frac{(2z+7)(2z+9)}{2880} n^{-z-9/2}$** |
| **Cell Sign** | Oscillating inside cell | Ambiguous sign | **Uniformly negative for all $x \ge 0$** |
| **Lean 4 Formalization** | None | None | **Fully verified in `RenewalBernoulliCellMoments.lean`** |

---

## 4. Formalization and Reproducibility

- Lean 4 formalization: [`formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean`](../../formalization/BuildingBlocks/RenewalBernoulliCellMoments.lean)
- All proofs machine-checked under Lean 4.24.0.
- Foundational axioms: strictly `[propext, Classical.choice, Quot.sound]`.
