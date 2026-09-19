# A three-factor extension of the complete Möbius prefix

**Status.** This is an unconditional written analytic estimate. The uses of
the Robert--Sargos and Bordellès theorems, cutoff smoothing, and Poisson-shell
summation are written mathematics. Lean checks the exponent identities,
support inequalities, fixed-buffer ledger, Type I margin, and endpoint
algebra; it does not formalize the external analytic estimates.

## Statement

Let

\[
 N=T^\lambda,\qquad H=N/T,\qquad 2<\lambda<\frac{29}{14},
\]

and retain the normalized pole-null packet and the coefficient row

\[
 L_m(T)=\sum_{n\ge1}(\log n)g_N(mn),\qquad
 P_1(T)=\sum_{m\ge1}\mu(m)L_m(T).
\]

Fix

\[
 0<\kappa<\frac{\lambda-2}{10},\qquad
 d_F=\frac\lambda2+\frac15-\kappa,
 \qquad K_F=T^{d_F}.
\tag{1}
\]

Then there is a constant `c_F=c_F(lambda,kappa)>0` such that

\[
 \boxed{\sum_{m\le K_F}\mu(m)L_m(T)\ll_{\lambda,\kappa}T^{-c_F}.}
\tag{2}
\]

Consequently,

\[
 \boxed{P_1(T)=\sum_{m>K_F}\mu(m)L_m(T)+O_{\lambda,\kappa}(T^{-c_F}).}
\tag{3}
\]

The endpoint in (1) strictly exceeds the preceding endpoint

\[
 d_*:=\frac{2(\lambda+1)}5
\]

by every fixed amount below `(lambda-2)/10`, since

\[
 d_*+\frac{\lambda-2}{10}=\frac\lambda2+\frac15.
\tag{4}
\]

The theorem is unconditional. It controls the complete original Vaughan
partition through `K_F`. It does not control every rectangle in a separately
chosen unrestricted dyadic partition of `(mu*mu)*1`, and it does not prove
the Riemann hypothesis.

## Exact Vaughan and three-factor identities

Put

\[
 a_0=\mu1_{n\le U},\qquad b_0=\mu-a_0,
 \qquad U=T^u,\qquad u=\frac{42\lambda-55}{126}.
\tag{5}
\]

The original exact decomposition is

\[
 \mu=2a_0-a_0*a_0*1+b_0*b_0*1.
\tag{6}
\]

The first two terms are Type I. The last term is the uncollapsed Type II sum

\[
 \sum_{r,s>U}\sum_{t\ge1}\mu(r)\mu(s)L_{rst}(T).
\tag{7}
\]

For the smaller Möbius factor in a hard Type II rectangle, use the further
exact identity

\[
 \mu=3a_0-3a_0^{*2}*1+a_0^{*3}*1^{*2}
      +b_0^{*3}*1^{*2}.
\tag{8}
\]

It follows from `b_0*1=epsilon-a_0*1` by expanding the third power. Both
(6) and (8) are applied pointwise before smoothing or Mellin separation.

## Rectangle notation and the combined separation

On a dyadic Type II triple write

\[
 r\asymp T^x,\qquad s\asymp T^y,\qquad t\asymp T^w,
 \qquad x+y+w=d.
\]

Orient the rectangle so that `x<=y`, and set

\[
 \xi=w+y-x=w+|x-y|.
\tag{9}
\]

Then

\[
 x=\frac{d-\xi}{2},\qquad
 w+y=\frac{d+\xi}{2}.
\tag{10}
\]

Thus the free-factor length and the aspect ratio enter through the single
parameter `xi`. This is the same uncollapsed `b_0*b_0*1` partition used in
[the free-factor pruning theorem](actual-mobius-tail-free-factor-pruning.md),
not a recombined coefficient partition.

Write

\[
 d=d_*+\delta,
 \qquad \delta_0=\frac{\lambda-2}{10}-\kappa.
\tag{11}
\]

For the new dyadic blocks and their overlap with the preceding concrete
prefix, use

\[
 -\frac1{420}\le\delta\le\delta_0.
\tag{12}
\]

Set the fixed switch

\[
 \xi_0=\frac{\lambda-2}{2}.
\tag{13}
\]

The free-factor pruning argument controls every rectangle with

\[
 \xi>5\delta
\tag{14}
\]

and gives a margin `(xi-5delta)/8`, together with the other fixed margins
listed there. In particular, for `xi>=xi_0`,

\[
 \xi-5\delta\ge5\kappa.
\tag{15}
\]

It remains to control `xi<=xi_0` with a uniform power.

The published statement uses `delta>=0` because it was formulated as an
extension past `d_*`. Its proof and displayed exponents apply unchanged on
the transition interval `-1/420<=delta<0`: every occurrence of `delta` in
the limiting margins improves as `delta` decreases. Thus (15) is uniform on
the whole interval (12).

## Exponential-sum ranges

Group the arithmetic variables into lengths `A=T^alpha` and
`B=T^{d-alpha}`, with `alpha>=d/2`. Robert and Sargos,
[*Three-dimensional exponential sums with monomials*, Theorem 1,
equation (1.3)](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf),
give the normalized exponents

\[
 R_1=\frac{d+\alpha-\lambda}{4},\qquad
 R_2=\frac{3d-\lambda-1-\alpha}{4},
\]

\[
 R_3=\frac{d+\alpha-\lambda}{2},\qquad
 R_4=d-\frac{\lambda+1}{2}.
\tag{16}
\]

Bordellès,
[*Short sums of restricted Möbius functions*, Lemma 2.7](https://doi.org/10.4064/aa142-4-5),
gives

\[
 B_1=\frac{2d}{3}-\frac\lambda3-\frac\alpha6,
 \qquad B_2=\frac{\alpha-1}{2},
\]

\[
 B_3=d-\frac\alpha2-\frac\lambda2,
 \qquad B_4=d-\frac{\lambda+1}{2}.
\tag{17}
\]

The two theorems allow the separated grouped coefficients occurring here;
fixed divisor bounds are absorbed into `T^epsilon`. Equations (15) and (16)
are power saving on

\[
 3d-\lambda-1<\alpha<\lambda-d
 \quad\hbox{and}\quad
 4d-2\lambda<\alpha<1,
\tag{18}
\]

respectively. These intervals overlap because `5d<3lambda`. Their union
contains

\[
 3d-\lambda-1<\alpha<1.
\tag{19}
\]

## Unequal-aspect K=3 expansion

Apply (8) to the smaller factor of exponent `x=(d-xi)/2`. In the range
`xi<=xi_0`, the inequalities

\[
 u<x<3u
\tag{20}
\]

hold with fixed margins. Thus the `3a_0` term and the
`b_0^{*3}*1^{*2}` remainder vanish. Only

\[
 -3a_0^{*2}*1+a_0^{*3}*1^{*2}
\tag{21}
\]

remain.

For the all-short part of the second term, let

\[
 c_1+c_2+c_3=x,\qquad
 0\le c_1\le c_2\le c_3\le u.
\]

Then `x-2u<=c_1<=x/3`. Group the untouched factor of exponent `y`, the
original free factor of exponent `w`, and the smallest short factor. By
(10),

\[
 d-2u\le\alpha=w+y+c_1\le\frac{2d+\xi}{3}.
\tag{22}
\]

The first Robert--Sargos margin is therefore

\[
 \frac{\lambda-2-5\delta-\xi}{12}.
\tag{23}
\]

For `xi<=xi_0` and `delta<=delta_0`, its numerator is at least `5kappa`.
The second and fourth margins remain fixed and positive. This handles the
all-short component uniformly.

## Buffered subset argument

For either term in (20), let `e_1,...,e_j` be the exponents of the factors
inside the expanded smaller coefficient. Their sum is `x`. Put

\[
 A_0=\frac{5\delta-\xi}{2},\qquad
 B_0=1-\frac{d+\xi}{2}.
\tag{24}
\]

Choose the fixed buffer

\[
 \tau=\kappa.
\]

The parameter range gives, uniformly for `-1/420<=delta<=delta_0` and
`0<=xi<=xi_0`,

\[
 u<B_0-\tau,qquad
 2(A_0+\tau)<B_0-\tau,qquad
 2(B_0-\tau)>x,
\tag{25}
\]

\[
 x>A_0+\tau,qquad
 x-A_0-\tau>2\gamma_0+2\delta,
 \qquad \gamma_0=\frac{4-\lambda}{10}.
\tag{26}
\]

If a subset has exponent sum

\[
 A_0+\tau<s<B_0-\tau,
\tag{27}
\]

combine it with the factors of total exponent `w+y=(d+xi)/2`. The resulting

\[
 \alpha=\frac{d+\xi}{2}+s
\]

lies a fixed distance inside (19), so (16) or (17) saves a fixed power. The
empty subset is allowed when `A_0+tau<0`.

Suppose no subset satisfies (27). Every atom is at most `A_0+tau` or at
least `B_0-tau`. If the total of the small atoms exceeded `A_0+tau`, the
first partial sum crossing that threshold would be at most
`2(A_0+tau)<B_0-tau`, contradicting the failure of (27). Their total is at
most `A_0+tau`. The inequality `x>A_0+tau` forces a large atom, while
`2(B_0-tau)>x` makes it unique. Since `u<B_0-tau`, that atom cannot carry an
`a_0` coefficient. It is one of the unweighted convolutional `1` factors.
Its exponent `z` satisfies

\[
 z\ge x-A_0-\tau>2\gamma_0+2\delta.
\tag{28}
\]

The buffer prevents any loss when a dyadic `xi` approaches `5delta` within
`O(1/log T)`.

## Divisor-bounded long-free lemma

The long-free input needed in (28) is the following general form of Robert
and Sargos' Theorem 3, equations (6.8)--(6.9). Let `m=qz`, `m~D`, with `z`
an unweighted dyadic variable of exponent `rho`, and let the complementary
`q` coefficient be bounded by a fixed divisor function. The normalized
packet block is

\[
 \ll_\varepsilon T^\varepsilon\left(
 D^{1/2}N^{-1/4}T^{-\rho/4}+DN^{-1/2}T^{-\rho/2}
 +\frac{D}{T\sqrt N}\right).
\tag{29}
\]

The proof uses only the divisor bound on the outer coefficient. Literal
factor-product cutoffs are retained until partial summation in `z`, which
uses the unweighted maximal sum in equation (6.8). No Mellin character is
placed on `z`. The other factorization variables form the outer
divisor-bounded coefficient. The selected atom in (28) has coefficient
exactly one, so (29) applies. At `d=d_*+delta`, condition (28) puts all three
terms a fixed power below one.

Equations (15), (23), and (25)--(29) cover every Type II rectangle with a
uniform power. This is the complete `b_0*b_0*1` term in (6).

## Type I terms and packet shells

The inherited Bourgain Type I estimate is

\[
 |S_{\rm I}|\ll_\varepsilon T^\varepsilon N^{-1/2}
 \left(D^{1/2}UT^{13/84}+\frac DT\right).
\tag{30}
\]

At `d=d_*+delta`, its first exponent is

\[
 E_{\rm I}=\frac{42\lambda-103}{1260}+\frac\delta2.
\tag{31}
\]

For `delta<=delta_0`,

\[
 E_{\rm I}\le\frac{105\lambda-229}{1260}-\frac\kappa2<0.
\tag{32}
\]

The second exponent is `-(lambda+6)/10+delta<0`. The remaining decomposition
conditions also hold: `5delta<lambda-2`,
`delta<(103-42lambda)/630`, and `d-u<1` follow from (1) and (11).

The physical-shell estimates above retain a fixed margin. Below the physical
shell, the packet's first-order zero supplies the required summable power;
above it, Schwartz decay does so. Product smoothing, divisor normalization,
Mellin separation, and the logarithmic number of dyadic boxes cost
`T^epsilon`. Endpoint strips are bounded in the original `m` sum before the
convolution identities. Choosing `epsilon` below the minimum displayed
margin proves (2) throughout (12). At its lower endpoint,
`d=d_*-1/420`, exactly the concrete cutoff of the preceding prefix theorem.
That theorem controls all lower blocks with a fixed power, while the present
support, buffer, pruning, and Type I margins are uniform on the complete
closed transition interval `-1/420<=delta<=0`. The two estimates therefore
splice without dyadic boxes approaching `d_*` through a zero-margin gap.

## Scope

The gain comes from expanding one factor inside the original uncollapsed
Vaughan Type II term, then combining that result with the published
free-factor and aspect-ratio pruning estimate. It proves the complete prefix
bound (2). It does not assert a bound for every independently prescribed
block of the global identity `(mu*mu)*1=mu`, where a different slicing may
couple the coefficients. The residual tail `m>K_F` remains uncontrolled.
No RH conclusion follows.

The exponent identities, support inequalities, fixed-buffer ledger, Type I
margin, negative-delta transition, and endpoint calculation are checked in
[`ActualMobiusK3BottomSlice.lean`](../../formalization/BuildingBlocks/ActualMobiusK3BottomSlice.lean).
