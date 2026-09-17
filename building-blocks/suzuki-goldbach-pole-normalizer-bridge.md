# Suzuki's pole normalizer and the centered Goldbach square

This is an exact local bridge between Suzuki's multiplicative coefficient
family and **additive** Goldbach pairs. It identifies the centering forced
by the zeta pole and the state-one endpoint. It does not prove a Goldbach
representation or an RH-scale bound.

Let
\[
c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega}),
\qquad c_0(n)={\bf1}_{n=1},
\qquad c'_0(n)=2\Lambda(n),
\qquad c''_0(n)=4(\Lambda*\Lambda)(n),                 \tag{1}
\]
with the finite Möbius divisor sum used at \(\omega=0\). The star in
(1) is **multiplicative** Dirichlet convolution. The three coefficient
facts are compiled in
[SuzukiCoefficientVariation.lean](BuildingBlocks/SuzukiCoefficientVariation.lean)
and [SuzukiGoldbachVariation.lean](BuildingBlocks/SuzukiGoldbachVariation.lean).
Suzuki's original coefficient and Dirichlet quotient are in
[his paper](https://arxiv.org/html/1204.1827v2).

## The uncentered additive square keeps two different histories

For a total \(N\ge2\), sum over ordered positive pairs and put
\[
 A_\omega(N)=\sum_{a+b=N}c_\omega(a)c_\omega(b),\qquad
 R_\Lambda(N)=\sum_{a+b=N}\Lambda(a)\Lambda(b).       \tag{2}
\]
Finite differentiation and the fact that \(c_0=\delta_1\) give
\[
\boxed{A'_0(N)=4\Lambda(N-1),\qquad
 A''_0(N)=8(\Lambda*\Lambda)(N-1)+8R_\Lambda(N).}  \tag{3}
\]
The first summand in the second formula is a multiplicative two-history
at the shifted state \(N-1\), coming from the two \((1,N-1)\)
endpoint orientations. The second is the genuine additive Goldbach
pair count. For example, at \(N=5\) the endpoint contributes
\(8(\log2)^2\) from \(N-1=4\), while the additive pairs \(2+3\)
and \(3+2\) contribute \(16\log2\log3\). Equating these two
convolutions would lose the state-one endpoint.

Subtracting the fixed seed coefficient before squaring isolates the
additive channel. Write \(u_\omega(n)=c_\omega(n)-c_0(n)\). Then
\(u_0=0\), \(u'_0=2\Lambda\), and
\[
\boxed{\left.\partial_\omega^2
 \sum_{a+b=N}u_\omega(a)u_\omega(b)\right|_{\omega=0}
 =8R_\Lambda(N).}                                  \tag{4}
\]
This is the compiled `additiveSquare_second_deriv` theorem in the
second Lean file. Its ordered antidiagonal includes zero and one;
the zero-index factors vanish, and \(\Lambda(1)=0\).

## The pole residue supplies the exact centering

For \(\omega>0\), the Dirichlet quotient
\(\zeta(s-\omega)/\zeta(s+\omega)\) has its rightmost pole at
\(s=1+\omega\), with residue
\[
 a_\omega=\frac1{\zeta(1+2\omega)}.
\]
The normalized zeta function at its pole gives the analytic extension
\(a_0=0\), \(a'_0=2\). Consequently the source
\[
 d_\omega(n)=c_\omega(n)-{\bf1}_{n=1}-a_\omega n^\omega
 \quad(n\ge1)                                          \tag{5}
\]
has \(d_0(n)=0\) and
\[
 d'_0(n)=2\{\Lambda(n)-1\}.                         \tag{6}
\]
In particular \(d'_0(1)=-2\): the density subtraction retains the
otherwise easy-to-miss initial endpoint. The smooth term
\(a_\omega y^\omega\) is the derivative of the normalizing main
term \(a_\omega y^{1+\omega}/(1+\omega)\) in Suzuki's exact
[discrepancy representation](suzuki-hankel-exponential-boundary-layer.md).
It is not an invented Goldbach correction.

Let \(C_\omega(N)=\sum_{a+b=N}d_\omega(a)d_\omega(b)\). Its second
variation is
\[
\boxed{C''_0(N)=8\sum_{a+b=N}(\Lambda(a)-1)(\Lambda(b)-1)
 =8\{R_\Lambda(N)-2\psi(N-1)+(N-1)\}.}            \tag{7}
\]
The finite sum includes both orientations, every prime power, and
the terms with \(a=1\) or \(b=1\). This is exactly the signed centered
Goldbach coefficient of the [heat-energy identity](centered-goldbach-heat-lyapunov.md).

For every fixed \(t>0\), exponential damping permits termwise
differentiation of
\(F_\omega(t)=\sum_{n\ge1}d_\omega(n)e^{-nt}\) near zero:
the finite divisor sum and each fixed derivative are bounded by
\(O_{\delta,k}(\tau(n)n^\delta(1+\log n)^k)\) for
\(|\omega|\le\delta\). Therefore
\[
 F_0(t)=0,\quad F'_0(t)=2D(t),\quad
 \boxed{\left.\partial_\omega^2 F_\omega(t)^2\right|_0
 =8D(t)^2
 =8\sum_{N\ge2}c_Ne^{-Nt}},                    \tag{8}
\]
where \(D(t)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nt}\) and
\(c_N=R_\Lambda(N)-2\psi(N-1)+(N-1)\).

The square in (8) is nonnegative as a whole, but individual \(c_N\)
can be negative; the even coefficient \(c_4<0\) is already certified
in [CenteredGoldbachPositiveTransferObstruction.lean](BuildingBlocks/CenteredGoldbachPositiveTransferObstruction.lean).
Thus positivity of Suzuki's \(c_\omega(n)\), positivity of the raw
Goldbach pair counts, and positivity of the complete heat square do
not upper-bound its centered critical energy. The missing estimate is
still the RH-equivalent scale comparison for \(D(t)^2\), or an
independent one-sided bound for the completed Suzuki variation.

The Lean theorem currently proves (4) and \(c_0=\delta_1\) with only
standard logical axioms. Equations (3) and (5)--(8), including the
analytic pole-normalizer derivative and infinite heat exchange, are
written proofs awaiting separate formalization. They use the already
compiled finite coefficient and centered Goldbach identities, not
an assumption that Goldbach or RH holds.
