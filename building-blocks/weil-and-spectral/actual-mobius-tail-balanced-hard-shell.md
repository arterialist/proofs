# The balanced Möbius-tail hard shell

This note isolates the arithmetic coefficient left at the endpoint of the
[rectangle-wise Möbius-tail estimate](actual-mobius-tail-robert-sargos-bordelles-saving.md).
It is an exact reduction, not a further power-saving estimate.

Let

\[
a(n)=\mu(n)\mathbf 1_{n\leq U},
\qquad b=\mu-a.
\]

The finite Vaughan identity used in the tail decomposition is

\[
\mu=2a-a*a*1+b*b*1.
\]

Keep the free factor in the two triple convolutions explicit. On a fixed
free-factor slice, write the product of the other two variables as \(q\).
Then

\[
(b*b)(q)-(a*a)(q)
=(\mu*\mu)(q)-2(a*\mu)(q).
\tag{1}
\]

Indeed, expanding \(b=\mu-a\) gives

\[
b*b-a*a=\mu*\mu-2a*\mu.
\]

In the new Type-II blocks, \(q\gg U^2\), so \((a*a)(q)=0\) separately as
well. Define the full coefficient on this slice by

\[
d_U(q)=(\mu*\mu)(q)-2(a*\mu)(q).
\tag{1a}
\]

The short factor in \(a*\mu\) has length at most \(U\), but its complementary
factor still carries the coefficient \(\mu\). The inherited Bourgain Type-I
estimate treats an unweighted long variable, so it does not by itself control
this cross-term on a fixed free-factor slice. The identity
\((a*\mu)*\mathbf 1=a\) collapses it only after the complete free-factor sum
is restored. Consequently the exact hard coefficient is \(d_U\), not
\(\mu*\mu\) alone.

One explicitly structured component of \(d_U\) is

\[
c(q)=(\mu*\mu)(q).
\tag{2}
\]

This coefficient is multiplicative. On prime powers,

\[
c(p)=-2,
\qquad c(p^2)=1,
\qquad c(p^j)=0\quad(j\geq3).
\tag{3}
\]

Thus \(c\) is supported on cube-free integers. Every such integer has a
unique representation

\[
q=g^2n,
\]

where \(g,n\) are square-free and coprime, and

\[
c(q)=\mu(n)2^{\omega(n)}.
\tag{4}
\]

For \(\operatorname{Re}s>1\), its Dirichlet series is

\[
\sum_{q\geq1}\frac{c(q)}{q^s}
=\left(\sum_{n\geq1}\frac{\mu(n)}{n^s}\right)^2
=\frac1{\zeta(s)^2}.
\tag{5}
\]

After the established Fourier and Mellin separation, the endpoint shell has
the form

\[
\mathcal H_{t,J,Q}=
\frac1{L\sqrt N}
\sum_{k\asymp J}\gamma_k
\sum_{q\asymp Q}d_U(q)W_k(q/Q)
e\!\left(-\frac{kN}{tq}\right),
\tag{6}
\]

where \(t\asymp1\), \(Q\asymp D/t\), \(J\asymp L=D/H\), and
\(|\gamma_k|\leq1\). An estimate for the \(c\)-component alone does not
control (6) unless the \(a*\mu\) component is also bounded or cancels after
the free-factor slices are recombined.

At the current analytic endpoint

\[
d_*=\frac{2(\lambda+1)}5,
\]

the balanced Robert--Sargos exponent is

\[
\frac{5d-2\lambda-2}{8},
\]

which is zero at \(d=d_*\). If the arithmetic structure in the
\(c\)-component (2) yields an
additional factor \(B^{-\sigma}\), with fixed \(\sigma>0\), the exponent
becomes

\[
\frac{5d-2\lambda-2}{8}-\frac{\sigma d}{2}.
\]

The resulting endpoint would be

\[
d<\frac{2(\lambda+1)}{5-4\sigma}.
\tag{7}
\]

Equation (7) quantifies a possible gain for the \(c\)-component. It does not
move the full endpoint without a matching estimate for the cross-term in
(1a). Generic arbitrary-coefficient large-sieve bounds do not use (2) and
stop at \(\sigma=0\).

## The signed four-variable energy

There is a more precise way to state the input needed inside the
Robert--Sargos argument. Put

\[
P=JA,
\qquad X=\frac{NJ}{AB}.
\]

Choose a real, even, nonnegative function
\(w\in C_c^\infty(\mathbb R)\), supported sufficiently near the origin that
\(\lvert\widehat w\rvert\) is bounded below on the bounded joint-frequency
range in the double large sieve. Set \(\Phi=w*\widetilde w\). Then
\(\widehat\Phi=\lvert\widehat w\rvert^2\geq0\). For the actual normalized
coefficients \(\beta_b\) coming from the full coefficient \(d_U\), define

\[
\mathcal C_\beta(B;X)=
\sum_{b_1,\ldots,b_4\asymp B}
\beta_{b_1}\overline{\beta_{b_2}}
\overline{\beta_{b_3}}\beta_{b_4}
\Phi\!\left(
XB\left[
\frac1{b_1}-\frac1{b_2}-\frac1{b_3}+\frac1{b_4}
\right]
\right).
\tag{8}
\]

Fourier inversion gives the nonnegative representation

\[
\mathcal C_\beta(B;X)
=\frac1X\int_{\mathbb R}
\widehat\Phi(x/X)
\left|\sum_{b\asymp B}\beta_b e(xB/b)\right|^4\,dx.
\tag{9}
\]

The compact support of \(\Phi\) restricts (8) to reciprocal quadruples
satisfying

\[
\left|
\frac1{b_1}-\frac1{b_2}-\frac1{b_3}+\frac1{b_4}
\right|
\ll\frac1{XB}.
\tag{10}
\]

Retaining the coefficients in the double-large-sieve proof yields

\[
|S_0|\ll_\varepsilon
T^\varepsilon P^{1/2}X^{1/4}
\left[
\left(P+\frac{P^2}{X}\right)
\mathcal C_\beta(B;X)
\right]^{1/4}.
\tag{11}
\]

The unsigned reciprocal-spacing count gives only

\[
\mathcal C_\beta(B;X)
\ll_\varepsilon T^\varepsilon
\left(\frac{B^4}{X}+B^2\right).
\tag{12}
\]

At the physical shell \(X\asymp T\), a uniform arithmetic improvement

\[
\mathcal C_\beta(B;T)
\ll_\varepsilon T^\varepsilon
\left(B^4T^{-1-\rho}+B^2\right)
\tag{13}
\]

would improve the limiting amplitude by \(T^{-\rho/4}\). If
\(d=d_*+\delta\), the limiting exponent would become

\[
\frac{5\delta}{8}-\frac\rho4.
\tag{14}
\]

Consequently a final saving \(T^{-\eta}\), after allowing for
\(T^\varepsilon\) losses, requires a strict margin

\[
\rho>\frac52\delta+4\eta.
\tag{15}
\]

This formulation does not by itself extend the full tail estimate. The
bound must hold uniformly for the actual convolution coefficients, cutoffs,
Mellin characters, and the relevant range of \(X=NJ/(AB)\). The remaining
Robert--Sargos terms also impose, at balance,

\[
3\delta+8\eta\leq\frac{4\lambda-6}{5}.
\tag{16}
\]

Equations (13)--(16) identify a signed-energy improvement for the full
coefficient that would move the limiting rectangle. A bound only for the
\(\mu*\mu\) component does not satisfy this input. No such full-coefficient
improvement is asserted here.

## Exact short-interval form

Poisson inversion in the \(k\)-sum rewrites (6), up to the established
smooth packet factors, as

\[
\frac1{\sqrt N}
\sum_{\ell\asymp N/(tQ)}
\sum_{q\asymp Q}d_U(q)
F\!\left(L\left[\ell-\frac{N}{tq}\right]\right).
\tag{17}
\]

The center attached to \(\ell\) is \(q_\ell=N/(t\ell)\), the effective
window length is \(Q/T\), and adjacent centers are spaced by order
\(Q^2/N\). At \(Q=T^{d_*}\), these are polynomially short intervals.
Thus (17) is an exact arithmetic restatement of the same obstruction. The
\(\mu*\mu\) component has additional multiplicative structure, but the full
short-interval coefficient also contains \(-2a*\mu\).
