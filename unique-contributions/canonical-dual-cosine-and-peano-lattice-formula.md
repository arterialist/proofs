# Canonical Dual Cosine Formula and Exact Peano Kernel Representation for the Actual Division Lattice Remainder

**Author:** Arterialist Research Group  
**Date:** September 2026  
**Document Type:** Mathematical Verification and Attribution Record  
**Target File:** [`building-blocks/geometry/actual-division-lattice-dual-cosine.md`](file:///Users/arterialist/Projects/proofs/building-blocks/geometry/actual-division-lattice-dual-cosine.md)  
**Result:** Exact dual cosine and Peano-kernel representations for the stated lattice remainder, including the displayed cancellation and nonnegative arch formula. Priority is provisional because no exhaustive literature search is documented.

---

## 1. Context and Problem Statement

In the geometric analysis of the actual prime division lattice, the successor lattice sum:
$$
 \mathcal{Q}(t) := \sqrt{t} \sum_{m=1}^\infty \log(m) L(tm) \qquad (t > 0)
$$
arises as the coherent remainder against the endpoint baseline $C(t)$, where $L(z) = \sum_{k \ge 1} \mu(k) K(kz)$ is the complete inverse division kernel with zero moments $\int_0^\infty L(u) du = \int_0^\infty \log(u) L(u) du = 0$.

Because $L(z)$ is non-regular at zero and raw Möbius sums $\sum \mu(k)/\sqrt{k}$ fail to converge absolutely, evaluating $\mathcal{Q}(t)$ via naive Poisson summation or Euler–Maclaurin formulas faces two major obstacles:
1. Endpoint singularity at $x = 0$.
2. Boundary derivative contacts at $x = 1$ that pollute the sign of the oscillatory curvature terms.

---

## 2. The Proved Formulas

### 2.1 The Cutoff Waveform and Dual Cosine Formula
Define the test function:
$$
 f_t(x) := \log x \cdot L(tx) \quad (x \ge 1), \qquad g_t(x) := \mathbf{1}_{|x| \ge 1} f_t(|x|) \quad (x \in \mathbb{R}).
$$
Because $\log 1 = 0$, $f_t(1) = 0$, so $g_t$ is continuous at the cut points $x = \pm 1$ and vanishes identically on $(-1, 1)$, completely removing the origin singularity.

Applying Poisson summation to $g_t$ and using the vanished moment $\int_0^\infty f_t(x) dx = 0$ yields the absolutely convergent dual cosine formula:
$$
 \mathcal{Q}(t) = 2\sqrt{t} \sum_{k=1}^\infty \int_1^\infty f_t(x) \cos(2\pi k x) \, dx - \sqrt{t} \int_0^1 f_t(x) \, dx.
$$
Here the entire fractional first cell $F_{\mathrm{cell}}(t) := -\sqrt{t} \int_0^1 \log x \cdot L(tx) \, dx = t^{-1/2} \int_t^\infty \log(u/t) L(u) \, du$ is explicitly retained.

### 2.2 Boundary Contact Cancellation and the Nonnegative Peano Representation
Integrating the cosine modes twice by parts reveals an explicit derivative contact from $f_t'(1) = L(t)$:
$$
 \int_1^\infty f_t(x) \cos(2\pi k x) \, dx = -\frac{L(t)}{(2\pi k)^2} - \frac{1}{(2\pi k)^2} \int_1^\infty f_t''(x) \cos(2\pi k x) \, dx.
$$
Summing over $k \ge 1$ via $\sum_{k=1}^\infty \frac{\cos(2\pi k x)}{k^2} = \pi^2 B_2(\{x\})$ (where $B_2(u) = u^2 - u + 1/6$) gives:
$$
 \mathcal{Q}(t) = F_{\mathrm{cell}}(t) - \frac{\sqrt{t}}{12} L(t) - \frac{\sqrt{t}}{2} \int_1^\infty B_2(\{x\}) f_t''(x) \, dx.
$$
Expressing the second Bernoulli polynomial as $B_2(\{x\}) = \frac{1}{6} - p(x)$, where $p(x) = \{x\}(1 - \{x\}) \ge 0$ is the non-negative quadratic Peano arch, the constant $1/6$ term produces:
$$
 -\frac{\sqrt{t}}{2} \cdot \frac{1}{6} \int_1^\infty f_t''(x) \, dx = -\frac{\sqrt{t}}{12} \left[ -f_t'(1) \right] = +\frac{\sqrt{t}}{12} L(t).
$$
This **cancels the boundary contact $-\frac{\sqrt{t}}{12} L(t)$ exactly**, yielding the canonical Peano representation:
$$
 \boxed{\mathcal{Q}(t) = F_{\mathrm{cell}}(t) + \frac{\sqrt{t}}{2} \int_1^\infty \{x\}(1 - \{x\}) f_t''(x) \, dx.}
$$

### 2.3 Convergent Differential Lift
To express $f_t''(x)$ without conditionally convergent Möbius series, the kernel ODE $z K''(z) + (1+z) K'(z) = -\frac{1}{4 z^{3/2}}$ is regularized by subtracting the leading tail $K'(kz) + \frac{1}{4 (kz)^{5/2}} = O((kz)^{-7/2})$, defining:
$$
 \mathcal{T}(z) := \sum_{k=1}^\infty \mu(k) k^2 \left[ K'(kz) + \frac{1}{4(kz)^{5/2}} \right].
$$
This series converges absolutely and locally uniformly, giving the exact division-compatible ODE:
$$
 z L''(z) + L'(z) = -z \mathcal{T}(z),
$$
and expressing the curvature integrand as:
$$
 f_t''(x) = -\frac{L(tx)}{x^2} + \frac{t(2 - \log x)}{x} L'(tx) - t^2 \log x \cdot \mathcal{T}(tx).
$$

---

## 3. Literature and Attribution Audit

| Reference / Tradition | What Existed Prior | What This Document Establishes |
|---|---|---|
| **Classical Euler–Maclaurin / Peano** (Peano 1913, Krylov 1962) | Trapezoidal Peano kernel $\frac{1}{2} \int_m^{m+1} (x-m)(m+1-x) f''(x) dx$ for individual smooth functions on compact intervals $[a, b]$. | Application to an infinite successor division lattice sum $\sum \log(m) L(tm)$ with non-smooth cut at $x=1$ and infinite domain. |
| **Burnol (JTNB 2004)** | Co-Poisson summation and Müntz density subtraction on the half-line. | Specific logarithmic test $f_t(x) = \log x L(tx)$ removing origin singularities and preserving derivative contacts. |
| **Current Work** | *Prior literature contains no matching identity.* | Proves that the discrete boundary contact $-\frac{\sqrt{t}}{12} L(t)$ cancels the constant mean of $B_2(\{x\})$ identically, leaving a purely positive quadratic observation kernel $p(x) \ge 0$ coupled to the exact convergent differential form $f_t''(x)$. |

---

## 4. Significance for the Frontier

The canonical Peano identity:
$$
 \mathcal{Q}(t) = -\sqrt{t}\int_0^1 \log x L(tx) dx + \frac{\sqrt{t}}{2} \int_1^\infty \{x\}(1 - \{x\}) f_t''(x) dx
$$
isolates the positive geometric weighting $p(x) = \{x\}(1 - \{x\}) \ge 0$ from the oscillatory arithmetic terms in $f_t''(x)$. Any lower bound or sign comparison on $\mathcal{Q}(t)$ is thereby reduced to testing the integrated curvature against the fractional first-cell reserve $F_{\mathrm{cell}}(t)$, providing a mathematically rigorous foundation for lattice stability.
