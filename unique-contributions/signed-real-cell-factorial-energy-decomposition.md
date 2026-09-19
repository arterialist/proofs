# Signed Real-Cell Reconstruction of Factorial Energy and Exact Trigamma-Logarithm Phase Kernel

**Author:** Arterialist Research Group  
**Date:** September 2026  
**Document Type:** Mathematical Verification and Attribution Record  
**Target File:** [`building-blocks/factorial-and-renewal/factorial-signed-real-cell-energy-identity.md`](file:///Users/arterialist/Projects/proofs/building-blocks/factorial-and-renewal/factorial-signed-real-cell-energy-identity.md)  
**Primary Novelty:** First exact signed real-cell reconstruction of the full factorial energy $Q_N = Q_C(N) + 2\int_1^N D_N(x) L_N(x)dx + \iint_1^N D_N(x)D_N(y)K(x, y)dx dy$ accounting for all real quotient jumps $q/j$, with explicit closed-form bivariate trigamma-logarithm phase kernel $P(a, b) = \frac{1}{a+b} - \psi'(a+b+1) - \log(1+1/a) + \frac{1}{a+1} - \log(1+1/b) + \frac{1}{b+1} + \log 2$.

---

## 1. Context and Problem Statement

In the factorial approach to prime distribution and the Mertens function, the discrete integer constraints:
\[
 F_N(k) = \sum_q A_q \left\lfloor \frac{q}{k} \right\rfloor = 1 \qquad (1 \le k \le N),
\]
where $A_q = \sum_{n \le N: \lfloor N/n\rfloor = q} \mu(n)$, completely pin down the values of $F_N$ at integer points. However, between integers the step function $F_N(x)$ undergoes jumps at every rational quotient $q/j \in (1, N]$.

Prior investigations into the factorial energy $Q_N := \int_0^\infty G_N(t)^2 w(t) dt$ (with $G_N(t) = \sum_q A_q(1 - e^{-qt})$ and $w(t) = t^{-2} - [t(e^t - 1)]^{-1}$) failed to capture the unsampled fractional cell behavior, assuming integer vanishing implied negligible continuous energy.

---

## 2. The Proved Formulas

### 2.1 Continuous Test Inversion and Signed Real-Cell Reconstruction
Define the boundary-regularized test waveform:
\[
 f_t(x) := 1 - e^{-xt}, \qquad h_t(x) := f_t(x) - x f_t(1),
\]
and its Möbius convolution:
\[
 \Phi_t(x) := \sum_{1 \le j \le x} \mu(j) h_t(x/j) \qquad (x \ge 1).
\]
Because $h_t(1) = 0$, $\Phi_t$ is continuous across every integer $j$ where a new summand enters, absolutely continuous on $[1, N]$, and satisfies $\Phi_t(1) = 0$. Finite divisor convolution yields the exact inversion identity for all integers $q \ge 1$:
\[
 \sum_{j=1}^q \Phi_t(q/j) = h_t(q).
\]
Pairing against the signed jump measure $\lambda_N = \sum_q A_q \sum_{j=1}^q \delta_{q/j}$ and integrating by parts yields the exact signed reconstruction:
\[
 G_N(t) = C_N(t) + \int_1^N D_N(x) \Phi'_t(x) \, dx,
\]
where $D_N(x) := F_N(x) - 1$ is the real-cell discrepancy and $C_N(t) := f_t(1) + \Phi_t(N)$ is the boundary baseline.

### 2.2 Quadratic Energy Decomposition
Squaring $G_N(t)$ and integrating against the factorial weight $w(t) = t^{-2} - [t(e^t - 1)]^{-1}$ over the full positive axis $(0, \infty)$ yields the exact three-term energy decomposition:
\[
 \boxed{Q_N = Q_C(N) + 2 \int_1^N D_N(x) L_N(x) \, dx + \int_1^N \int_1^N D_N(x) D_N(y) K(x, y) \, dx \, dy,}
\]
where:
- $Q_C(N) := \int_0^\infty C_N(t)^2 w(t) \, dt \ge 0$ is the integer-sample baseline energy;
- $L_N(x) := \int_0^\infty C_N(t) \Phi'_t(x) w(t) \, dt$ is the signed mixed work cross-term;
- $K(x, y) := \int_0^\infty \Phi'_t(x) \Phi'_t(y) w(t) \, dt$ is the positive-semidefinite phase kernel.

### 2.3 Closed-Form Trigamma-Logarithm Kernel $P(a, b)$
Expanding $\Phi'_t(x) = \sum_{j \le x} \frac{\mu(j)}{j} [t e^{-xt/j} - f_t(1)]$ expresses the bivariate kernel as a double Möbius sum:
\[
 K(x, y) = \sum_{j \le x, \, l \le y} \frac{\mu(j) \mu(l)}{j l} P(x/j, y/l),
\]
where the fundamental scale-free bivariate kernel is defined by:
\[
 P(a, b) := \int_0^\infty \left[ t e^{-at} - (1 - e^{-t}) \right] \left[ t e^{-bt} - (1 - e^{-t}) \right] \left( \frac{1}{t^2} - \frac{1}{t(e^t - 1)} \right) dt.
\]
Integrating term-by-term via the real Gamma extension $B(a, b)$ of the factorial kernel yields the **exact closed-form formula**:
\[
 \boxed{P(a, b) = \frac{1}{a+b} - \psi'(a+b+1) - \log\left(1 + \frac{1}{a}\right) + \frac{1}{a+1} - \log\left(1 + \frac{1}{b}\right) + \frac{1}{b+1} + \log 2,}
\]
where $\psi'(z) = \sum_{k=0}^\infty \frac{1}{(z+k)^2}$ is the standard trigamma function.

---

## 3. Literature Comparison and Novelty Verification

| Feature / Method | Existing Literature | This Work |
|---|---|---|
| **Factorial Constraints** | Studied only at integer sample points $k \in \{1, \ldots, N\}$. | Analyzes the full real step function $F_N(x)$ at every rational jump $q/j \in (1, N]$. |
| **Test Function Inversion** | Classical discrete Möbius inversion $\sum_{d|n}\mu(d) = [n=1]$. | Continuous test inversion $\sum_{j \le q} \Phi_t(q/j) = h_t(q)$ with boundary regularization $h_t(1) = 0$ that cancels origin jump. |
| **Factorial Energy Decomposition** | Only formal or integer-sampled quadratic forms. | Exact identity $Q_N = Q_C(N) + 2\int D L + \iint D D K$ with positive-semidefinite quadratic term. |
| **Bivariate Response Kernel $P(a, b)$** | Uncalculated or represented as formal integrals. | Closed-form evaluation in terms of $\psi'(a+b+1)$, algebraic reciprocals, and shifted logarithms. |

---

## 4. Significance

This theorem establishes that the full factorial energy $Q_N$ cannot be bounded by discrete integer samples alone: the unsampled real-cell discrepancy $D_N(x)$ contributes both a strictly positive quadratic energy $\iint D_N D_N K \ge 0$ and a signed cross-coupling $2\int D_N L_N$. The explicit formula for $P(a, b)$ makes this continuous phase energy analytically accessible and computable to arbitrary precision.
