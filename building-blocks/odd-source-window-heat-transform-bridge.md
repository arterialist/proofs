# The odd source in the window and heat transforms

Written mathematics, not Lean formalized. Root independently checked
the signed-work transfer developed by RH Agent3, including its disjoint
power-of-two age cost, exact odd Poisson phase, PNT derivative calculation
and absolutely summable signed-work error.
The uniform upper work budget remains unproved.

For Re s>1 let

\[
F_o(s)=\sum_{n\ge1,\ n\text{ odd}}(\Lambda(n)-2)n^{-s}.
\]

Absolute convergence and the complete even Mangoldt support give

\[
F_o(s)=-\frac{\zeta'(s)}{\zeta(s)}
-\frac{\log2}{2^s-1}-2(1-2^{-s})\zeta(s).                  \tag{1}
\]

The second term is the sum over every positive power of two.
The odd-density term uses the exact odd Dirichlet series, not half
the full integer series. At any actual nontrivial zero rho with
Re rho>0, the last two terms are holomorphic locally, and the
first has residue minus the positive multiplicity of rho.

Use W(y)=y^(-1/2)Z(log y), with smooth support strictly inside
(1,2), and define the actual window J(P)=P^(-1/2)sum_odd
(Lambda(n)-2)W(n/P), P>=1. Put j(U)=J(exp U).
For Re z>1/2, full absolute Fubini and y=n/P give

\[
\int_0^\infty e^{-zU}j(U)dU
=M_z(Z)\,[F_o(z+1/2)+2],\qquad
M_z(Z)=\int e^{zv}Z(v)dv.                                \tag{2}
\]

The +2 is mandatory. The odd source has coefficient -2 at n=1,
but its window value is zero at every P>=1; every other positive
odd n is at least 3, so its whole scaled support lies in P>1.
There is no partially clipped n=2 odd endpoint. Indeed its factor is
integral_1^2 y^(z-1/2)W(y)dy=M_z(Z).

The actual additive heat source O(t)=sum_odd(Lambda(n)-2)e^(-nt)
has, for Re s>1, the separate exact transform

\[
\int_0^\infty t^{s-1}O(t)dt=\Gamma(s)F_o(s).              \tag{3}
\]

Here the n=1 contribution is retained, without the +2 correction.
The common arithmetic Dirichlet source in (2) and (3) is therefore
explicit, and both transformations keep odd proper prime powers.
For the fixed universal packet pair, M_z(Z) is a translate factor
times the existing nonvanishing bilateral filter. It retains every
off-critical source pole; gamma also has no zeros.

These identities do not identify the positive additive-pair heat
norm with the signed window work. They use different smoothing
weights and different integration domains. In particular a formal
division by either multiplier does not prove a bounded inverse on
the vertical-line norm space. Any proposed quantitative transfer
must supply the appropriate norm estimate and retain the n=1 port.
Neither (2) nor (3) proves the missing upper signed budget, positive
heat continuation, ordinary Goldbach, or RH.

The subsequent [finite-source norm comparison](odd-heat-balanced-window-norm-comparison.md) supplies a bounded one-direction Gamma/window multiplier for each fixed 0<eta<1. It retains the state-one cost and the partially admitted terminal window. Its required uniform cutoff bound remains open.
