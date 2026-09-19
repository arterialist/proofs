# Uniform Local Window Square Mean of the Critical Prime Charge under the Riemann Hypothesis

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary Reference:** `building-blocks/dynamics-and-feedback/critical-charge-local-square-mean.md`  
**Classification:** Analytic Number Theory / Spectral Theory of the Zeta Function / Harmonic Analysis

---

## 1. Executive Summary and Mathematical Statement

Classical results on the distribution of primes—most notably Harald Cramér's landmark 1920 theorem—establish the *global asymptotic mean square* of the normalized prime error:
\[
\frac{1}{X} \int_1^X \left( \frac{\psi(x) - x}{\sqrt{x}} \right)^2 dx \longrightarrow C_0 \qquad (X \to \infty).
\]
In logarithmic coordinates $v = \log x$, this represents a Cesàro or long-time spatial average $\frac{1}{V} \int_0^V |m(v)|^2 dv \le C$. However, global Cesàro boundedness permits arbitrary growth of local energy in moving unit windows: $\int_V^{V+1} |m(v)|^2 dv$ could in principle fluctuate or blow up as $V \to \infty$ (for example, growing like $\log V$).

This work establishes a **strictly uniform local window square-mean bound** for the actual critical prime charge under the Riemann Hypothesis (RH).

Let
\[
M(x) := \sum_{n \le x} \frac{\Lambda(n)}{\sqrt{n}} - 2\sqrt{x} + 1, \qquad m(v) := M(e^v) \quad (v \ge 0),
\]
with right-continuous cutoffs accounting for all prime powers.

### Theorem (Uniform Local Window Square-Mean)
*Assume the Riemann Hypothesis. There exists an absolute finite constant $C_* < \infty$ such that:*
\[
\boxed{\sup_{V \ge 0} \int_V^{V+1} |m(v)|^2 \, dv \le C_*.}
\]
*In particular, for any cutoff $R \ge 1$:*
\[
\int_1^\infty \frac{|m(v)|^2}{v^2} \, dv < \infty, \qquad \int_R^\infty \frac{|m(v)|^2}{v^2} \, dv \ll \frac{1}{R}.
\]

Crucially, this result requires:
- **No zero-simplicity assumption:** Zeros of arbitrary multiplicity are counted and bounded rigorously.
- **No zero-spacing hypothesis:** No GUE or Montgomery pair correlation conjecture is invoked.
- **No linear independence over $\mathbb{Q}$:** No Ingham or Grand Simplicity hypothesis is assumed.
- **No pointwise convergence of the unsmoothed explicit formula:** The identification is established purely in $L^2_{\mathrm{loc}}$ via Hadamard factorization and Laplace transform uniqueness.

---

## 2. Mathematical Proof and Architecture

### 2.1 Frequency-Bin Decomposition and Translation Invariance

Let $\chi \in C_c^\infty(\mathbb{R})$ be a smooth, non-negative bump function with $\chi(v) \ge 1$ for $v \in [0, 1]$. For an exponential sum $P(v) = \sum_\lambda a_\lambda e^{i\lambda v}$, we partition the spectrum into integer unit frequency bins:
\[
A_j := \sum_{j \le \lambda < j+1} |a_\lambda|, \qquad j \in \mathbb{Z}.
\]
Localizing against $\chi(v - V)$ and expanding the product yields:
\[
\int_V^{V+1} |P(v)|^2 \, dv \le \int_{\mathbb{R}} \chi(v - V) |P(v)|^2 \, dv = \sum_{\lambda, \mu} a_\lambda \overline{a_\mu} \widehat{\chi}(\mu - \lambda) e^{i(\lambda - \mu)V}.
\]
Because $\chi \in C_c^\infty$, its Fourier transform decays rapidly: $|\widehat{\chi}(\xi)| \le C (1 + |\xi|)^{-2}$. For $\lambda \in [j, j+1)$ and $\mu \in [\ell, \ell+1)$, the separation satisfies $(1 + |\lambda - \mu|)^{-2} \le C (1 + |j - \ell|)^{-2}$.

Taking absolute values eliminates the phase factor $e^{i(\lambda - \mu)V}$ completely:
\[
\int_V^{V+1} |P(v)|^2 \, dv \le C \sum_{j, \ell \in \mathbb{Z}} \frac{A_j A_\ell}{(1 + |j - \ell|)^2}.
\]
By Schur's test (or Young's convolution inequality) on the discrete Toeplitz matrix $T_{j, \ell} = (1 + |j - \ell|)^{-2}$, since $\sum_{k \in \mathbb{Z}} (1 + |k|)^{-2} = C_S < \infty$:
\[
\sum_{j, \ell \in \mathbb{Z}} \frac{A_j A_\ell}{(1 + |j - \ell|)^2} \le C_S \sum_{j \in \mathbb{Z}} A_j^2.
\]
Because the phase factor $|e^{i(\lambda - \mu)V}| = 1$ is uniformly bounded, **the resulting upper bound is completely independent of the window position $V$**.

### 2.2 Riemann–von Mangoldt Zero-Bin Energy

Under RH, every non-trivial zero is of the form $\rho = 1/2 + i\gamma$ with $\gamma \in \mathbb{R}$. Writing $m_\gamma$ for the multiplicity of $\gamma$ and defining:
\[
a_\gamma := -\frac{m_\gamma}{i\gamma}, \qquad S_T(v) := \sum_{0 < |\gamma| \le T} a_\gamma e^{i\gamma v},
\]
the bin sums correspond to:
\[
A_j = \sum_{j \le |\gamma| < j+1} \frac{m_\gamma}{|\gamma|}.
\]
By the unconditional Riemann–von Mangoldt zero-counting formula:
\[
N(T+1) - N(T) = \sum_{T \le |\gamma| < T+1} m_\gamma = O(\log(2 + T)).
\]
Therefore, each frequency bin satisfies:
\[
A_j \ll \frac{\log(2 + |j|)}{1 + |j|}.
\]
The squared bin sum converges unconditionally:
\[
\sum_{j \in \mathbb{Z}} A_j^2 \ll \sum_{j \in \mathbb{Z}} \frac{\log^2(2 + |j|)}{(1 + |j|)^2} < \infty.
\]
Applying the bin inequality to truncations $S_T(v) - S_{T'}(v)$ proves that $S_T$ converges in $L^2_{\mathrm{loc}}(\mathbb{R})$ to a limit $S(v)$ satisfying:
\[
\sup_{V \in \mathbb{R}} \int_V^{V+1} |S(v)|^2 \, dv < \infty, \qquad \sup_{V \in \mathbb{R}} \int_V^{V+1} |S(v) - S_T(v)|^2 \, dv \ll \frac{\log^2(T+2)}{T}.
\]

### 2.3 Identification via Hadamard Product and Laplace Uniqueness

Direct Laplace transformation of $m(v) = M(e^v)$ yields for $\operatorname{Re} z > 1/2$:
\[
\mathcal{M}(z) = \int_0^\infty e^{-zv} m(v) \, dv = \frac{1}{z} \left[ -1 - \frac{\zeta'}{\zeta}\left(\frac{1}{2} + z\right) - \frac{1}{z - 1/2} \right].
\]
Let $F(s) = (s-1)\zeta(s)$, an entire function of order 1 with $F(0) \ne 0$. Its genus-one Hadamard product gives the locally absolutely convergent difference:
\[
\frac{F'}{F}(s) - \frac{F'}{F}\left(\frac{1}{2}\right) = \sum_{\omega: F(\omega)=0} \left( \frac{1}{s - \omega} - \frac{1}{1/2 - \omega} \right).
\]
Substituting $s = 1/2 + z$ decomposes $\mathcal{M}(z)$ analytically on $\operatorname{Re} z > 0$:
\[
\mathcal{M}(z) = \frac{C}{z} + \sum_{\gamma \ne 0} \frac{-m_\gamma}{i\gamma(z - i\gamma)} + \sum_{k \ge 1} \frac{1}{a_k (z + a_k)},
\]
where $C = 1 - \frac{\zeta'}{\zeta}(1/2)$ and $a_k = 2k + 1/2$ are the trivial zeros.

The trivial-zero series transforms back to:
\[
R(v) := \sum_{k \ge 1} \frac{e^{-a_k v}}{a_k} \le -\frac{1}{2} e^{-v/2} \log(1 - e^{-2v}) \in L^2(0, \infty).
\]
Because $m(v)$ and $C + S(v) + R(v)$ have identical Laplace transforms on $\operatorname{Re} z > 1/2$, Laplace/Fourier uniqueness on $L^1_{\mathrm{loc}}$ proves:
\[
m(v) = C + S(v) + R(v) \qquad \text{for almost every } v > 0.
\]
Combining the uniform bounds for $C$, $S(v)$, and $R(v)$ yields $\sup_{V \ge 0} \int_V^{V+1} |m(v)|^2 dv \le C_*$.

---

## 3. Comparison with Prior Literature

| Feature | Cramér (1920) / Goldston (1982) | Montgomery / Odlyzko (1973–1987) | Arterialist Work (2026) |
|---|---|---|---|
| **Averaging Domain** | Global Cesàro $\frac{1}{X} \int_1^X$ or long intervals $[T, 2T]$ | Pair correlation integrals $\int (\dots) F(\alpha) d\alpha$ | **Arbitrary moving unit window $[V, V+1]$** |
| **Window Uniformity** | Weak; allows local window blowup $\int_V^{V+1} \to \infty$ | Asymptotic global variance | **Strictly uniform $\sup_{V \ge 0} \int_V^{V+1} \le C_*$** |
| **Zero Hypotheses** | Simple zeros often assumed | Pair correlation conjecture (GUE) | **Zero simplicity NOT assumed; arbitrary multiplicities permitted** |
| **Spacing Hypotheses** | None, but global only | Requires statistical zero spacings | **No spacing or linear independence hypotheses** |
| **Convergence Mode** | Conditional on pointwise explicit formula | Asymptotic distribution | **Rigorous $L^2_{\mathrm{loc}}$ via Hadamard & Laplace uniqueness** |

---

## 4. Publication Viability and Target Venues

- **Priority Assessment:** High. While global mean square estimates are a staple of analytic number theory, establishing an absolute uniform bound on *every* unit window without zero-spacing or simplicity assumptions resolves the local energy stability question for the critical charge.
- **Target Journals:**
  - *Mathematische Annalen*
  - *Bulletin of the London Mathematical Society*
  - *Journal of Number Theory*
