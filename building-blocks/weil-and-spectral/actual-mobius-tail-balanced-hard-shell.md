# A balanced Möbius shell after global recombination

**Status:** corrected exact global recombination and component-shell
analysis, 20 September 2026. The
coefficient identity, multiplicativity, prime-power values, and
the arithmetic-function identities
\((a*\mu)*\zeta=a\), \((\mu*\mu)*\zeta=\mu\), and
\((\mu*\mu)*\zeta*\zeta=1\) are formalized and axiom-audited in
[`ActualMobiusConvolution.lean`](../../formalization/BuildingBlocks/ActualMobiusConvolution.lean).
The cross term cannot be discarded on a fixed free-factor slice. It cancels
exactly only after the full free-factor sum, before any factor-dependent
partition. The reciprocal energy reduction, power budget, and Poisson
short-interval form are written mathematics, not Lean. The displayed shell
is one region of a new partition of the globally rewritten sum; a complete
analysis of every region in that new partition has not been proved. No
signed energy gain, larger Möbius cutoff, or Riemann-hypothesis result is
claimed.

The [primary-source applicability audit](actual-mobius-tail-balanced-literature-audit.md)
records why the closest published linear, polynomial, modular-inverse, and
short-interval estimates do not supply the fixed-power reciprocal energy
gain required below.

The [square-factor pruning](actual-mobius-tail-squarefactor-pruning.md)
removes, with a fixed power error, the portion in which the square component
of \(q\) is large after this global recombination.

This note gives the corrected recombination at the endpoint of the
[rectangle-wise Möbius-tail estimate](actual-mobius-tail-robert-sargos-bordelles-saving.md).

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

On a fixed free-factor slice, \((a*\mu)(q)\) is not covered by the inherited
Bourgain Type-I estimate: writing \(q=av\) leaves the long coefficient
\(\mu(v)\). Instead, return to the original \(m\)-shell before introducing
factor-dependent dyadic or Mellin weights. Since \(L_{tq}(T)=L_m(T)\)
depends only on \(m=tq\), and \(m\asymp D>U\),

\[
 \sum_{tq=m}(a*\mu)(q)
 =(a*\mu*1)(m)
 =a(m)=0.
\tag{2}
\]

Consequently

\[
 \sum_{tq=m}\bigl((b*b)(q)-(a*a)(q)\bigr)
 =\sum_{tq=m}(\mu*\mu)(q).
\tag{2a}
\]

This is the same global identity \((\mu*\mu)*1=\mu\). It is essential that
(2) be used before slicing the free factor; no weighted-long-variable
Type-I estimate is asserted. Dyadically repartition the right side of (2a).
This is a new complete partition, not a termwise replacement inside the old
fixed-slice partition. Bounds from the two partitions cannot be mixed unless
all complementary regions are accounted for.
Its arithmetic coefficient is

\[
c(q)=(\mu*\mu)(q).
\tag{2b}
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

After Fourier and Mellin separation of one balanced region in the globally
recombined expression, the resulting shell has the form

\[
\mathcal H_{t,J,Q}=
\frac1{L\sqrt N}
\sum_{k\asymp J}\gamma_k
\sum_{q\asymp Q}c(q)W_k(q/Q)
e\!\left(-\frac{kN}{tq}\right),
\tag{6}
\]

where \(t\asymp1\), \(Q\asymp D/t\), \(J\asymp L=D/H\), and
\(|\gamma_k|\leq1\). The cancellation in (2) has already occurred before
this fixed-slice formula is formed.

At the current analytic endpoint

\[
d_*=\frac{2(\lambda+1)}5,
\]

the balanced Robert--Sargos exponent is

\[
\frac{5d-2\lambda-2}{8},
\]

which is zero at \(d=d_*\). If the arithmetic structure in (2b) yields an
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

Equation (7) quantifies the missing input for this region. It would move the
component-shell endpoint, but does not move the complete tail without bounds
for every complementary region in the new partition. Generic
arbitrary-coefficient large-sieve bounds do not use (2b) and stop at
\(\sigma=0\).

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
coefficients \(\beta_b\), define

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

Equations (13)--(16) identify the exact signed-energy improvement that would
move the limiting rectangle. They do not assert that this improvement is
currently known.

## Delta-symbol compatibility check

Introducing a new variable \(q\) and a delta symbol for \(rs=q\) does not
by itself expose a classical Kloosterman sum. A standard additive expansion
would separate the shell into factors of the schematic form

\[
 \sum_{q\asymp Q}W(q/Q)e(-kN/(tq))e(-a q/c)
 \quad\text{and}\quad
 \sum_{r,s}\mu(r)\mu(s)e(a rs/c).
\tag{16a}
\]

The first factor still has a mixed reciprocal-linear phase. Poisson
summation produces a stationary-phase transform depending jointly on
\(kN/t\), \(a/c\), and the dual frequency, rather than a complete
Kloosterman sum to which the Weil bound applies directly. The second factor
is an incomplete Möbius-weighted bilinear sum; completing it discards the
signed arithmetic being sought. Consequently a delta-symbol insertion plus
the classical Weil bound alone does not supply (13). This is a compatibility
check, not an impossibility theorem: a useful delta route would need an
additional theorem controlling the transformed reciprocal phase together
with the actual Möbius weights and all packet parameters.

## Exact short-interval form

Poisson inversion in the \(k\)-sum rewrites (6), up to the established
smooth packet factors, as

\[
\frac1{\sqrt N}
\sum_{\ell\asymp N/(tQ)}
\sum_{q\asymp Q}c(q)
F\!\left(L\left[\ell-\frac{N}{tq}\right]\right).
\tag{17}
\]

The center attached to \(\ell\) is \(q_\ell=N/(t\ell)\), the effective
window length is \(Q/T\), and adjacent centers are spaced by order
\(Q^2/N\). At \(Q=T^{d_*}\), these are polynomially short intervals.
Thus (17) is an exact arithmetic restatement of the same obstruction, not a
known short-interval estimate for \(\mu*\mu\).
