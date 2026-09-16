# Simultaneous Green expansion: rough tail and final assembly

## Common normalization

Put

\[
 L=\log X,\qquad q=e^{-2/X},\qquad
 c_X(n)=\mu(n)1_{(n,X^\#)=1},
\]

and retain every divisor face

\[
 c_{X,P}=\sum_{d\mid P^\#}\mu(d)D_dc_X,
 \qquad
 \mathcal E_X(P)={L^2\over X^2}V_q(c_{X,P}).
\]

The fixed packet is `F_P=sum_{d|P#} mu(d)G_d`, its energy is
`E_P=2||F_P||_2^2`, and the discrepancy is

\[
 \mathcal B(X,P)=\mathcal E_X(P)-E_P.
\tag{1}
\]

These are exactly the definitions in the simultaneous-discrepancy note and
in the sign-free endpoint audit.

The normalization has a necessary factor two:

\[
 (1-e^{-2/X})\sum_{j\ge1}f(j/X)^2\longrightarrow
 2\int_0^\infty f(y)^2\,dy.
\]

Therefore the normalized non-endpoint row
`-F_P+J_P/L+R` has leading energy `E_P=2||F_P||_2^2`, and its linear
density correction is exactly `-4<F_P,J_P>/L`. The complete endpoint vector
below enters with normalized norm exactly `(L/X)||E_(X,P)||_(G,X)`.

## The actual rough-composite row

The coefficient decomposition is

\[
 c_X=\delta_1-1_{\{p>X:\ p\ {prime}\}}+r_X,
\tag{2}
\]

where `r_X(n)=mu(n)` when `n` is composite and every prime divisor of `n`
is larger than `X`, and is zero otherwise.  Since the Möbius coefficient of
every nonsquarefree integer is zero, the nonzero support of `r_X` consists
of squarefree composites.  Such an integer has two distinct prime factors
larger than `X`, and hence

\[
 r_X(n)\ne0\quad\Longrightarrow\quad n>X^2.
\tag{3}
\]

Thus prime powers do not give a nonzero retained row: `mu(p^k)=0` for
`k>=2`.

For one divisor face define its normalized sampled rough packet by

\[
 R_{d,j}^{\rm rough}={L\over X}q^{-j/2}
 \sum_{n\ge\lceil j/d\rceil}r_X(n)q^{dn}.
\tag{4}
\]

Each pair `(d,n)` contributes the endpoint-shaped vector supported on
`j<=dn`. Its exact Green norm is

\[
 \left((1-q)\sum_{j\le dn}q^{2dn-j}\right)^{1/2}
 =\sqrt{q^{dn}-q^{2dn}}\le e^{-dn/X}.
\tag{5}
\]

Finite Minkowski, `|mu(n)|<=1`, and enlargement from the admitted divisors
to all positive integers and from the actual support to every `n>X^2` give

\[
 \boxed{
 \left\|\sum_{d\mid P^\#}\mu(d)R_d^{\rm rough}\right\|_{G,X}
 \le {L\over X}\left\{{e^{-X}\over1-e^{-X}}
 -X\log(1-e^{-X})\right\}
 \le {2Le^{-X}\over1-e^{-1}}.}
\tag{6}
\]

Indeed, `(1-e^{-a})^{-1}<=1+a^{-1}` gives
`sum_(n>X^2)e^(-dn/X)<=e^(-dX)(1+X/d)`; summing in `d` gives the middle
expression. The last inequality uses `-log(1-u)<=u/(1-u)` and `X>=1`.

This has no dependence on the number of faces and is exponentially smaller
than every displayed remainder used below.  If the rest of the normalized
packet has norm at most `C`, its contribution to the energy is at most
`2C epsilon_rough+epsilon_rough^2`, with the right side of (6) as
`epsilon_rough`.

## Assembly

The previously established components, in this normalization, are:

* second logarithmic moment: `O(L^-2)` after summing all divisor faces;
* zero-free-region PNT partial summation:
  `O(exp(-c sqrt L))`, with the explicit common constant recorded in
  `uniform-rough-prime-pnt-partial-summation.md`;
* sampled-to-continuous norm: `O(1/X)`;
* the exact moving-ceiling and endpoint convention: `O(L/X)`;
* the rough-composite row: (6);
* the complete growing-divisor endpoint packet, retained separately.

The first four bounds are uniform for `P<=X`; (6) is uniform in `P` without
that restriction.  Expanding the square and using the exact finite assembly
algebra gives

\[
 \mathcal B(X,P)=-{4\over L}\langle F_P,J_P\rangle
 +O\!\left(L^{-2}+e^{-c\sqrt L}+{L^3\over X}
 +\epsilon_{\rm end}(X,P)+\epsilon_{\rm end}(X,P)^2\right),
\tag{8}
\]

where

\[
 \epsilon_{\rm end}(X,P)={L\over X}
 \left((1-q)\sum_{j\ge1}|E_{X,P}(j)|^2\right)^{1/2},
\]

\[
 E_{X,P}(j)=q^{-j/2}
 \sum_{\substack{d\mid P^\#\\d\ge j}}\mu(d)q^d.
\tag{9}
\]

The `L^3/X` allowance in (8) absorbs the sampling, ceiling, and exponentially
smaller rough-tail terms.

## Endpoint range and reconciliation

Formula (9) is exactly the endpoint vector controlled by
`SignFreeEndpointFrontierFinite` and its audit, and the external scale in
that audit is exactly `L/X`.  There is no second endpoint term.  Therefore,
for every fixed `0<rho<1`, the endpoint contribution in (8) tends uniformly
to zero in the range

\[
 \boxed{
 \log P\le \rho\,\log X\,
 {W(2\log\log X)\over2\log\log X}.}
\tag{10}
\]

The independently audited de la Bretèche--Tenenbaum friable Möbius bound
controls the same endpoint vector above this region, through every fixed
power range

\[
 \boxed{P\le X^{1/2-\varepsilon}\qquad(\varepsilon>0\text{ fixed}).}
\tag{11}
\]

More precisely, the cited friable theorem handles the range where `log P`
is at least a fixed power of `log X`, under `P^2 log P/X -> 0`; the
sign-free range (10) covers all smaller `P` and overlaps it. Since (11) lies
inside `P<=X`, every non-endpoint component is uniform there. Thus (8), with
a remainder tending to zero, is justified throughout (11), using the
explicitly stated classical PNT and friable mean-value inputs.

The former restriction `P<=(3-eta)log X` came from a cruder endpoint face
count and must not be retained. The Lambert-W range (10) is only the
sign-free part of the proof, not the final range. The first unmatched formula
beyond (11) is still decay of the same endpoint norm (9): once `P^2` reaches
the Abel-effective scale, the available friable estimate loses one
logarithm. No conclusion for `P` comparable to `X` follows.

## Lean scope

`BuildingBlocks/SimultaneousGreenAssemblyFinite.lean` formalizes the actual
Möbius zero on nonsquarefree integers, the coefficient modulus bound, exact
six-term discrepancy assembly, the complete triangle-inequality consumer,
the quadratic energy perturbation identity, and finite Minkowski for the
rough packet.  The exponential and Lambert-W estimates above are analytic
arguments with their hypotheses displayed; the Lean module does not assert
either asymptotic.
