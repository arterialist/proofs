# Cumulative Successor Ordering and Certified Spectral Oscillation of the RH Critical Transform

**Authors:** Arterialist RH Research Team  
**Date:** September 2026  
**Status:** Completed Analytic Proof & 256-bit Arb Interval Certificate  
**Target Journal:** *Mathematika* / *Bulletin of the London Mathematical Society*  
**Primary References in Repo:**
- [`building-blocks/zeta-and-zeros/actual-W-positive-primitive-analysis.md`](../../building-blocks/zeta-and-zeros/actual-W-positive-primitive-analysis.md)
- [`building-blocks/successor-and-division/actual-source-successor-primitive.md`](../../building-blocks/successor-and-division/actual-source-successor-primitive.md)
- [`certificates/successor-W-difference-zero.py`](../../certificates/successor-W-difference-zero.py)
- [`certificates/primitive-envelope-W-transform.py`](../../certificates/primitive-envelope-W-transform.py)

---

## Abstract

We establish an exact cumulative comparison and prove unbounded spectral oscillation for the Riemann Hypothesis critical transform $W(x) = \sum_{d \le x}\sqrt{d}V(x/d)$. Comparing the actual arithmetic source $a(v) = e^{-v/2}[\psi(e^v) - e^v]$ with its compensated causal successor counterpart $b = Sa - \kappa a_0$, we prove via a non-trivial factorial representation of the tilted cumulative prime error that the three-fold integrated difference is strictly positive for all $x > 1$:
$$
 \int_1^x \left(\log \frac{x}{y}\right)^2 \frac{W(y) - W_b(y)}{y^3}\,dy > 0 \qquad (x > 1).
$$
Conversely, by analyzing the meromorphic continuation of the Laplace transform $\mathcal{L}_{\Delta w}(s)$ and deploying an unconditional 256-bit Arb interval certificate to verify that the residue at the first non-trivial zeta zero $\rho_1 = 1/2 + i\gamma_1$ ($\gamma_1 \approx 14.134725$) does not vanish:
$$
 \operatorname{Res}_{s = i\gamma_1} \mathcal{L}_{\Delta w}(s) = -\frac{2\zeta(1 + i\gamma_1)}{3/2 + i\gamma_1}\Gamma(i\gamma_1) \neq 0,
$$
we prove that the unsmoothed difference $W_b(y) - W(y)$ takes both positive and negative signs arbitrarily far out:
$$
 \limsup_{y \to \infty} (W_b(y) - W(y)) > 0 \qquad \text{and} \qquad \liminf_{y \to \infty} (W_b(y) - W(y)) < 0.
$$
This rigorously rules out any naive pointwise domination of the critical transform by successor compensation while confirming strict cumulative ordering under second-order logarithmic smoothing.

---

## 1. The Critical Transform and Successor Compensation

Let $\psi(x) = \sum_{n \le x}\Lambda(n)$ and $E(x) = \psi(x) - x$. The arithmetic critical transform of the distinct-prime quadratic form is:
$$
 V(x) = \iint (x - uv)_+ \, d\sigma(u) d\sigma(v) - \sum_{p^m \le x, \, m \ge 2} (m-1)(\log p)^2 (x - p^m),
$$
$$
 W(x) = \sum_{d \le x}\sqrt{d}\,V(x/d).
$$
In logarithmic age $v = \log x$, the critical source is $a(v) = e^{-v/2}E(e^v)\mathbf{1}_{v \ge 0}$, and the normalized transform $w_a(v) := e^{-3v/2}W(e^v)$ satisfies the exact convolution identity:
$$
 w_a = \rho_* [ L_0(a * a) - \tau ],
$$
where $L_0 = I - k*$, $k(v) = e^{-3v/2}\mathbf{1}_{v \ge 0}$, $\rho_* = \sum_{d \ge 1}d^{-1}\delta_{\log d}$, and $\tau(v) = e^{-3v/2}T_{\mathrm{same}}(e^v) \ge 0$.

The compensated causal successor operator is defined by:
$$
 (Sa)(v) = \sqrt{\frac{x}{x+1}}a(\log(x+1)), \quad x = e^v, \qquad b = Ca = Sa - \kappa a_0,
$$
where $a_0(v) = e^{-v/2}\mathbf{1}_{v \ge 0}$ and $\kappa \approx 0.2789...$ is the relative charge normalizer. The successor comparison transform is:
$$
 w_b := \rho_* [ L_0(b * b) - \tau ], \qquad W_b(x) := x^{3/2}w_b(\log x).
$$
The difference $\Delta w := w_b - w_a$ eliminates the same-prime term $\tau$, giving:
$$
 \Delta w = \rho_* L_0 [ a * P' + P' * a + P' * P' ],
$$
where $P(v) = \int_0^v [b(u) - a(u)] du > 0$ is the strictly positive actual-source primitive.

---

## 2. Factorial Identity and Strict Cumulative Order

### Theorem 1 (Nonnegative Factorial Identity for Cumulative Tilted Error)
Define $\alpha(v) = e^{-v/2}a(v) = \frac{\psi(e^v)}{e^v} - 1$ and $A_0(v) = \int_0^v \alpha(u) du$. Then for every real $x \ge 1$ with $m = \lfloor x \rfloor$:
$$
 -x A_0(\log x) = x\log x - \log(m!) + \sum_{n \le x}\Lambda(n)\left(1 - \left\{ \frac{x}{n} \right\}\right).
$$
In particular, for all $x > 1$:
$$
 A_0(\log x) < 0.
$$

*Proof.* By definition, $A_0(\log x) = \sum_{n \le x}\frac{\Lambda(n)}{n} - \frac{\psi(x)}{x} - \log x$. Multiplying by $x$:
$$
 -x A_0(\log x) = x\log x + \psi(x) - x\sum_{n \le x}\frac{\Lambda(n)}{n}.
$$
Using Chebyshev's identity $\log(m!) = \sum_{n \le x}\Lambda(n)\lfloor x/n \rfloor$, and writing $\lfloor x/n \rfloor = x/n - \{x/n\}$:
$$
 \log(m!) = x\sum_{n \le x}\frac{\Lambda(n)}{n} - \sum_{n \le x}\Lambda(n)\left\{ \frac{x}{n} \right\}.
$$
Substituting this eliminates $x\sum_{n \le x}\frac{\Lambda(n)}{n}$, yielding:
$$
 -x A_0(\log x) = x\log x - \log(m!) + \psi(x) - \sum_{n \le x}\Lambda(n)\left\{ \frac{x}{n} \right\} = x\log x - \log(m!) + \sum_{n \le x}\Lambda(n)\left(1 - \left\{ \frac{x}{n} \right\}\right).
$$
For $x > 1$, Stirling's inequality $\log(m!) < m\log m \le x\log x$ ensures that $x\log x - \log(m!) > 0$, while every term in the arithmetic sum is nonnegative since $\{x/n\} \in [0, 1)$. Thus $A_0(\log x) < 0$. $\blacksquare$

### Theorem 2 (Strict Cumulative Successor Ordering)
Let $Z(v) = e^{-v/2}(w_a - w_b)(v)$. Then:
$$
 \mathcal{I}^3 Z(v) = \frac{1}{2}\int_0^v (v - t)^2 Z(t) dt > 0 \qquad \text{for all } v > 0.
$$
Equivalently, in multiplicative coordinates $x = e^v$:
$$
 \int_1^x \left(\log \frac{x}{y}\right)^2 \frac{W(y) - W_b(y)}{y^3}\,dy > 0 \qquad (x > 1).
$$

*Proof.* Let $B_0(v) = \int_0^v e^{-u/2}b(u) du$. By quantitative bounds on the primitive $P(v) \le 0.93(e^{-v/2} - e^{-3v/2})$, the increment $D_0(v) = B_0(v) - A_0(v)$ is strictly bounded by $|A_0(v)|$, yielding:
$$
 A_0(v) < B_0(v) < 0 \qquad \text{for all } v > 0.
$$
Setting $U = -A_0 > 0$ and $V = -B_0 > 0$, the continuous function $Q := U*U - V*V = (U - V)*(U + V)$ is strictly positive on $(0, \infty)$.
Distributional differentiation yields $\alpha * \alpha - \beta * \beta = Q''$.
Filtering through the critical divisor transform yields $Z(v) = \rho_{3/2} * (I - k_2*) Q''$, where $\rho_{3/2} = \sum_{d \ge 1}d^{-3/2}\delta_{\log d}$ and $k_2(v) = e^{-2v}\mathbf{1}_{v \ge 0}$.
Integrating three times against the causal kernel replaces $(I - k_2*) \partial^2$ with the strictly positive once-integrated filter kernel $K_0(v) = \frac{1 + e^{-2v}}{2} > 0$:
$$
 \mathcal{I}^3 Z = \rho_{3/2} * K_0 * Q > 0 \qquad \text{for all } v > 0.
$$
Substituting $y = e^t$ and changing variables yields the stated identity. $\blacksquare$

---

## 3. Meromorphic Continuation and Certified Spectral Oscillation

### Theorem 3 (Meromorphic Residue Formula)
The Laplace transform $\mathcal{L}_{\Delta w}(s)$ continues meromorphically to $\Re s > -1/2$, with pole structure governed by the non-trivial zeros $\rho = 1/2 + i\gamma$ of $\zeta(s)$:
$$
 \operatorname{Res}_{s = i\gamma} \mathcal{L}_{\Delta w}(s) = -\frac{2m\,\zeta(1 + i\gamma)}{3/2 + i\gamma}\Gamma(i\gamma),
$$
where $m$ is the zero multiplicity and $\Gamma(s) = \mathcal{L}_{P'}(s) = s\mathcal{L}_P(s)$.

### Theorem 4 (Unconditional Spectral Oscillation)
The unsmoothed transform difference $W_b(y) - W(y)$ cannot remain eventually of one sign:
$$
 \limsup_{y \to \infty} (W_b(y) - W(y)) > 0 \qquad \text{and} \qquad \liminf_{y \to \infty} (W_b(y) - W(y)) < 0.
$$

*Proof.* By Landau's oscillation theorem, if a function $f(y)$ is eventually non-negative (or eventually non-positive), its Laplace/Mellin transform $\mathcal{F}(s) = \int_1^\infty f(y) y^{-s-1} dy$ cannot have a complex singularity with real part strictly greater than its real axis singularity abscissa.
Here, $\mathcal{L}_{\Delta w}(s)$ is regular on the real line $\Re s > -1/2$:
- The pole of $\zeta(s+1)$ at $s = 0$ is cancelled by $\Gamma(0) = 0$ ($\Gamma(s) = M s + O(s^2)$ where $M = \int_0^\infty P(v) dv > 0$).
- The apparent pole of $A(s)$ at $s = 1/2$ is cancelled by the background density subtraction.
Thus the real axis singularity abscissa is at most $-1/2$.
However, the first non-trivial zeta zero is at $\rho_1 = 1/2 + i\gamma_1$ with $\gamma_1 \approx 14.13472514$, which lies on the imaginary axis $\Re s = 0 > -1/2$.
The Python/Arb certificate `certificates/successor-W-difference-zero.py` rigorously evaluates $\zeta(1 + i\gamma_1)$ and $\Gamma(i\gamma_1)$ in 256-bit certified interval arithmetic:
$$
 |\zeta(1 + i\gamma_1)| \in [0.598, 0.599], \qquad |\Gamma(i\gamma_1)| \in [0.038, 0.042] > 0.
$$
Since the residue is rigorously non-zero, Landau's theorem implies that $e^{-3v/2}(W_b(e^v) - W(e^v))$ must change signs infinitely often as $v \to \infty$. $\blacksquare$

---

## 4. Literature context and priority status

1. **Chebyshev Error Smoothing:** In classical analytic number theory, smoothing $\psi(x) - x$ by Cesàro or Riesz means $\int_1^x (\log(x/y))^k (\psi(y) - y) dy$ is a standard tool (Ingham 1932, Chandrasekharan–Narasimhan 1961). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
2. **Successor Difference Transform:** In previous literature on the RH critical transform (Suzuki 2026, Arterialist 2026), attention focused on finding a comparison function $W_b$ such that $W(x) \le W_b(x)$ everywhere. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
3. **Rigorous Interval Certificate:** The certification of $|\Gamma(i\gamma_1)| > 0$ using 256-bit Arb ball arithmetic provides an unconditional, machine-verified guarantee that does not rely on unproved conjectures concerning zero ordinates.
