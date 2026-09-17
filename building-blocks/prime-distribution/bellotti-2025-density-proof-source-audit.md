# A convolution identity in Bellotti 2025 v1 requires repair

This note checks one source step used in several prime-error estimates.
It does **not** assert that Bellotti's stated density or prime-number-theorem
estimates are false. It records a specific false equality in the posted
[2025 v1 proof, §3.1.1](https://arxiv.org/html/2508.02041), and identifies
independent inputs sufficient for the \(\varepsilon\)-loss bounds used here.

Bellotti defines the Barban–Vehov weights \(\psi_d,\theta_d\), writes
\(h=\psi*\theta\) for Dirichlet convolution, and then identifies

\[
(h*1)(n)=(\psi*\theta*1)(n)
\stackrel{\text{claimed}}{=}(\psi*1)(n)(\theta*1)(n)
=\Psi(n)\Theta(n).
\tag{1}
\]

Dirichlet convolution is not pointwise multiplication. To check (1)
using the paper's own weights, take a prime \(p<\min(U,W)\). Then
\(\psi_1=\theta_1=1\), \(\psi_p=-1\), and
\(\theta_p=-\log(W/p)/\log W\ne0\). Consequently

\[
(\psi*\theta*1)(p)=1+\psi_p+\theta_p=\theta_p\ne0,
\qquad
(\psi*1)(p)(\theta*1)(p)
=(1+\psi_p)(1+\theta_p)=0.
\tag{2}
\]

The paper uses (1) to replace coefficients of \(\zeta(s)M(s)\) by
\(\Psi(n)\Theta(n)\) in the lower-bound argument for Lemma 3.1.
Equation (2) shows that replacement is not established by the
displayed calculation. Results downstream from that lower bound,
including the posted proof of Corollary 1.4's \(O(1)\) near-edge
zero count and Theorem 1.5's \(\varepsilon\)-free PNT constant,
need an independent proof before being used as unconditional inputs.
This audit does not rule out a correction to the paper.

For the bounds in this repository that allow an arbitrarily small
exponent loss, the following distinct sources suffice:

- The [2024 Bellotti zero-free-region theorem](https://arxiv.org/abs/2306.10680)
  gives an asymptotic Korobov–Vinogradov constant
  \(A_0=1/48.0718\), independently of the 2025 convolution identity.
- The classical Ingham density estimate, stated and made explicit in
  [Chourasiya–Simonič](https://arxiv.org/abs/2507.15184), is
  \(N(\sigma,T)\ll T^{3(1-\sigma)/(2-\sigma)}(\log T)^5\).
  For each fixed \(B>0\), at
  \(\sigma=1-B A_0(\log T)^{-2/3}(\log\log T)^{-1/3}\)
  it gives \(N(\sigma,T)=T^{o(1)}\). In a dyadic zero sum whose
  optimal \(\log T\asymp\Phi(x)\), that costs \(e^{o(\Phi(x))}\),
  which an \(\varepsilon\Phi(x)\) loss absorbs.
- [Johnston's PNT estimate](https://arxiv.org/abs/2411.13791)
  gives \(|\psi(x)-x|/x\ll e^{-\omega(x)}
  (\log x)^9/(\log\log x)^3\) from the zero-free profile.
  With \(\omega(x)=(d+o(1))\Phi(x)\), this implies
  \(|\psi(x)-x|\ll_\varepsilon x e^{-(d-\varepsilon)\Phi(x)}\).

These replacements preserve the leading constants in results stated
with arbitrary \(\varepsilon>0\). They do not prove the exact
\(\varepsilon=0\) PNT transfer or the \(O(1)\) near-edge count.
