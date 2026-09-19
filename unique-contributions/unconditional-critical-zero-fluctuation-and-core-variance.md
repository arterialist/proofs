# Verified Unique Contribution 29: Unconditional Critical-Zero Fluctuation Bounds and Mean-Square Spectral Measure for the Coherent Prime Core

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary Reference:** [`building-blocks/zeta-and-zeros/coherent-core-critical-zero-fluctuation.md`](../../building-blocks/zeta-and-zeros/coherent-core-critical-zero-fluctuation.md)  
**Related Lean Formalizations:** [`formalization/BuildingBlocks/ActualPhysicalResidues.lean`](../../formalization/BuildingBlocks/ActualPhysicalResidues.lean), [`formalization/BuildingBlocks/ActualZeroCircleResidues.lean`](../../formalization/BuildingBlocks/ActualZeroCircleResidues.lean)  
**Target Venue:** *Proceedings of the American Mathematical Society* or *Mathematische Zeitschrift*

---

## 1. Executive Statement of Novelty

Let $K(z) = \int_0^\infty e^{-u} q^0(u, z) du - z^{-1/2}$ be the physical shifted birth kernel with $q^0(u, y) = u^{-1/2}\arcsin\sqrt{u/y}$ ($u < y$) and $\frac{\pi}{2\sqrt{u}}$ ($u \ge y$). The **coherent prime core** is defined by:
\[
Q(t) := \sqrt{t} \sum_{n \ge 2} \Lambda(n) K(tn), \qquad 0 < t \le 1.
\]
In scale coordinates $v = -\log t \ge 0$, let $q(v) := Q(e^{-v})$. Let $a_0 := \frac{\zeta'(1/2)}{\zeta(1/2)} \in \mathbb{R}$ be the real residue of the meromorphically continued core transform at $z = 0$, and let:
\[
M_K(s) := \int_0^\infty K(z) z^{s-1} dz = \frac{\sqrt{\pi} \Gamma(s) \tan(\pi s)}{2s}, \qquad 1/2 < \operatorname{Re}s < 3/2.
\]

**Theorem (Unconditional Core Oscillation and Spectral Variance Lower Bound).**  
1. *Pointwise Fluctuation Amplitudes:* For **every** critical-line zero $\rho = 1/2 + i\gamma$ of $\zeta(s)$ with multiplicity $m_\rho \ge 1$, let $d_\rho := m_\rho |M_K(\rho)| > 0$. Then $q(v)$ fluctuates unconditionally around $a_0$ with amplitude at least $d_\rho$:
\[
\limsup_{v \to \infty} q(v) \ge a_0 + d_\rho, \qquad \liminf_{v \to \infty} q(v) \le a_0 - d_\rho.
\]
2. *Unconditional Mean-Square Energy Lower Bound:* The second-moment energy $E(T) := \int_0^T |q(v) - a_0|^2 dv$ satisfies:
\[
\limsup_{T \to \infty} \frac{E(T)}{T} \ge \sum_{\substack{\rho : \operatorname{Re}\rho = 1/2}} m_\rho^2 |M_K(\rho)|^2 > 0.
\]
The sum runs over all distinct critical-line zeros (counting both $+i\gamma$ and $-i\gamma$).

This result does **not** assume the Riemann Hypothesis, does **not** assume zero simplicity ($m_\rho = 1$), and does **not** require any hypothetical statistical distribution of zero gaps. Positivity is guaranteed unconditionally because Hardy (1914) proved that $\zeta(s)$ possesses infinitely many zeros on $\operatorname{Re}s = 1/2$.

---

## 2. Rigorous Proof Architecture

### Step 1: Exact One-Sided Mellin Identity and Meromorphic Continuation
For $1/2 < \operatorname{Re}z < 1$, with $s = z + 1/2$:
\[
\widehat{q}(z) := \int_0^\infty q(v) e^{-zv} dv = -\frac{\zeta'(s)}{\zeta(s)} M_K(s) - J(s),
\]
where $J(s) = \sum_{n \ge 2} \Lambda(n) n^{-s} \int_n^\infty K(u) u^{s-1} du$ is holomorphic for $\operatorname{Re}s < 3/2$ since $K(u) = \frac{1}{6u^{3/2}} + O(u^{-5/2})$.

By Chebyshev's bound, $q(v) = O(e^{v/2})$, so the Laplace integral converges for $\operatorname{Re}z > 1/2$. The right-hand side continues meromorphically to $\operatorname{Re}z > 0$:
- On the real segment $(0, 1/2]$, $\zeta(z+1/2)$ has no real zeros, and the simple zero of $M_K(s)$ at $s = 1$ identically cancels the simple pole of $\zeta(s)$ at $s = 1$.
- At $z = 0$, the simple pole of $M_K(z+1/2) = -z^{-1} + O(1)$ yields:
  \[
  \operatorname{Res}_{z=0} \widehat{q}(z) = \frac{\zeta'(1/2)}{\zeta(1/2)} = a_0.
  \]
- At each critical zero $z = i\gamma$, the logarithmic derivative $-\zeta'/\zeta$ has a simple pole of residue $-m_\rho$, while $M_K(1/2+i\gamma) \ne 0$ because $\Gamma(1/2+i\gamma) \ne 0$ and $\tan(\pi(1/2+i\gamma)) = i\coth(\pi\gamma) \ne 0$:
  \[
  \operatorname{Res}_{z=i\gamma} \widehat{q}(z) = -m_\rho M_K(\rho).
  \]

### Step 2: Landau Positive-Mellin Barrier and Pointwise Fluctuations
Suppose for contradiction that $q(v) \le C$ for all $v \ge V$. Then $h_C(v) := (C - q(v)) \mathbf{1}_{[V, \infty)}(v) \ge 0$.  
Its Laplace transform $\widehat{h}_C(z) = \frac{C e^{-Vz}}{z} - \widehat{q}(z) + \int_0^V q(v) e^{-zv} dv$ has non-negative coefficients. By Landau's theorem on Dirichlet series / Laplace integrals with non-negative kernels, the abscissa of convergence $\sigma_c$ must be a singularity.

Because $\widehat{q}(z)$ is holomorphic on $(0, 1/2]$, $\widehat{h}_C(z)$ has no real positive singularity, forcing $\sigma_c \le 0$. Thus $\widehat{h}_C(z)$ converges for all $\operatorname{Re}z > 0$. Positivity of the kernel implies:
\[
|\widehat{h}_C(\varepsilon + i\gamma)| \le \widehat{h}_C(\varepsilon), \qquad \forall \varepsilon > 0.
\]
Multiplying by $\varepsilon$ and taking $\varepsilon \downarrow 0$:
\[
\lim_{\varepsilon \downarrow 0} \varepsilon |\widehat{h}_C(\varepsilon + i\gamma)| = m_\rho |M_K(\rho)| = d_\rho,
\]
\[
\lim_{\varepsilon \downarrow 0} \varepsilon \widehat{h}_C(\varepsilon) = C - a_0.
\]
Hence $C - a_0 \ge d_\rho$, proving $\limsup_{v \to \infty} q(v) \ge a_0 + d_\rho$.  
Applying the identical argument to $(q(v) - C) \mathbf{1}_{[V, \infty)}(v) \ge 0$ proves $\liminf_{v \to \infty} q(v) \le a_0 - d_\rho$.

### Step 3: Asymptotic Character Orthogonality and Spectral Projection
For distinct critical ordinates $\gamma_1, \dots, \gamma_N$ with residues $r_j = -m_j M_K(1/2+i\gamma_j)$, consider the character basis $\phi_j(v) = e^{i\gamma_j v}$ under the probability measure $d\mu_\varepsilon(v) = \varepsilon e^{-\varepsilon v} dv$ on $[0, \infty)$:
\[
G_{jk}(\varepsilon) := \int_0^\infty \phi_j(v) \overline{\phi_k(v)} d\mu_\varepsilon(v) = \frac{\varepsilon}{\varepsilon - i(\gamma_j - \gamma_k)} \xrightarrow{\varepsilon \downarrow 0} \delta_{jk}.
\]
The projection of $q - a_0$ onto this orthonormalized basis gives:
\[
c_j(\varepsilon) := \int_0^\infty (q(v) - a_0) \overline{\phi_j(v)} d\mu_\varepsilon(v) = \varepsilon \widehat{q-a_0}(\varepsilon + i\gamma_j) \xrightarrow{\varepsilon \downarrow 0} r_j.
\]
By Bessel's inequality / finite-dimensional projection in $L^2(d\mu_\varepsilon)$:
\[
\varepsilon \int_0^\infty |q(v) - a_0|^2 e^{-\varepsilon v} dv \ge \mathbf{c}(\varepsilon)^* G(\varepsilon)^{-1} \mathbf{c}(\varepsilon) \xrightarrow{\varepsilon \downarrow 0} \sum_{j=1}^N |r_j|^2.
\]
Stieltjes integration by parts links the Laplace-Abel second moment to the Cesàro second moment:
\[
\varepsilon \int_0^\infty e^{-\varepsilon v} dE(v) = \varepsilon^2 \int_0^\infty e^{-\varepsilon T} E(T) dT \le \limsup_{T \to \infty} \frac{E(T)}{T} + o(1).
\]
Taking the supremum over all finite subsets $\{\gamma_1, \dots, \gamma_N\}$ proves:
\[
\limsup_{T \to \infty} \frac{E(T)}{T} \ge \sum_{\substack{\rho : \operatorname{Re}\rho = 1/2}} m_\rho^2 |M_K(\rho)|^2 > 0.
\]

---

## 3. Comparison with Prior Literature

| Result / Source | Scope / Kernel | Relies on RH? | Simplicity of Zeros? | Multiplicity Sensitive? |
|---|---|---|---|---|
| **Landau (1908)** | $\psi(x) - x$ | No | Not required | No quantitative lower bound on variance |
| **Ingham (1936)** | $\sum_\rho \frac{x^\rho}{\rho}$ | No | Assumed simple zeros | Requires zero-free subregions |
| **Cramér (1920)** | $\int_1^X (\frac{\psi(x)-x}{\sqrt{x}})^2 dx$ | **Assumes RH** | Assumed simple zeros | Cesàro limit $C_0 = \sum \frac{1}{\gamma^2}$ conditional on RH |
| **Present Theorem** | **Coherent Core $Q(t)$** | **No (Unconditional)** | **Arbitrary multiplicities $m_\rho \ge 1$** | **Yes: quadratic weight $m_\rho^2 |M_K(\rho)|^2$** |

---

## 4. Attributions and Mathematical Deductions

1. **Hardy's Critical Line Theorem (1914):** Provides the existence of at least one (and in fact infinitely many) zeros with $\operatorname{Re}\rho = 1/2$, guaranteeing that the spectral variance lower bound is strictly positive.
2. **Landau's Abscissa Theorem (1905):** Provides the boundary singularity obstruction for Laplace transforms of non-negative distributions.
3. **Novelty Confirmation:** The explicit closed-form multiplier $M_K(s) = \frac{\sqrt{\pi}\Gamma(s)\tan(\pi s)}{2s}$, its exact cancellation of the pole at $s = 1$, the exact real residue $a_0 = \zeta'(1/2)/\zeta(1/2)$, and the unconditional character projection proving $\limsup E(T)/T \ge \sum m_\rho^2 |M_K(\rho)|^2$ are entirely original to this research program.
