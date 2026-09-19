# Domain correction for Suzuki's 2026 Corollary 1.6, version 1

**Classification:** correction to a conjectural limit formulation, not a refutation of the operator program

**Primary source:** [Suzuki, arXiv:2606.09096v1, Corollary 1.6](https://arxiv.org/html/2606.09096v1#S1.SS2)

Version 1 asks whether one can choose $\theta=\theta(a)$ and a finite normalizer $\phi(a,z)$ so that, as $a\to\infty$,

$$
e^{\phi(a,z)}W(a,\theta(a);z)
\longrightarrow
z^2\frac{\xi(1/2-iz)}{\xi'(1/2-iz)}
$$

uniformly on every compact subset of $\mathbb C$. This is a conditional criterion in the preprint, not a theorem asserting that the convergence holds. The earlier page incorrectly reversed the limit to $a\downarrow0$.

The proposed finite-valued all-plane limit has a domain problem. Put $X(z)=\xi(1/2-iz)$. Hardy's theorem gives infinitely many real zeros of $X$. Between consecutive such zeros, Rolle's theorem gives a real point $c$ with $X'(c)=0$ and $X(c)\ne0$. Hence $z^2X(z)/X'(z)$ has genuine real poles away from zero. Ordinary uniform convergence to that meromorphic function on every compact subset of $\mathbb C$ cannot hold as stated.

One must be careful about the normalizer. Version 1 requires $\phi(a,z)$ to be finite but does not state that it is holomorphic. Therefore the familiar claim that the left-hand sides are entire is not justified without an extra hypothesis on $\phi$. With holomorphic normalizers, contour integrals rule out even locally uniform convergence on punctured neighborhoods that enclose a pole. A plausible corrected domain is $\mathbb C\setminus\mathbb R$, together with explicit holomorphy and normalization conditions, but proving that limit remains a separate problem.

This issue is narrow. Suzuki's Theorems 1.1 through 1.5 construct and analyze localized operators and self-adjoint extensions independently of the conjectural limit formula. The correction does not refute those results or the broader spectral program.

Version 2 changes the proposed limit to

$$
\frac{\xi(1/2-iz)}
 {\xi(1/2-iz)+\xi'(1/2-iz)},
$$

while retaining $a\to\infty$ and compact-uniform wording. That revision confirms that the v1 quotient should not be treated as an uncorrectable flaw in the entire paper. The repository's longer argument is in [the limit-domain audit](../building-blocks/weil-and-spectral/suzuki-2026-corollary-1-6-limit-domain-audit.md).
