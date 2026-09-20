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
 0<\kappa<\frac{\lambda-2}{5},\qquad
 d_F=\frac{3\lambda}{5}-\kappa,
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

by every fixed amount below `(lambda-2)/5`, since

\[
 d_*+\frac{\lambda-2}{5}=\frac{3\lambda}{5}.
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
 \qquad \delta_0=\frac{\lambda-2}{5}-\kappa.
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
 \xi_0=\lambda-2.
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

## Buffered subset argument

For either term in the surviving K=3 expansion, let `e_1,...,e_j` be the exponents of the factors
inside the expanded smaller coefficient. Their sum is `x`. Put

\[
 A_0=\frac{5\delta-\xi}{2},\qquad
 B_0=1-\frac{d+\xi}{2}.
\tag{22}
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
\tag{23}
\]

\[
 x>A_0+\tau,qquad
 x-A_0-\tau>2\gamma_0+2\delta,
 \qquad \gamma_0=\frac{4-\lambda}{10}.
\tag{24}
\]

If a subset has exponent sum

\[
 A_0+\tau<s<B_0-\tau,
\tag{25}
\]

combine it with the factors of total exponent `w+y=(d+xi)/2`. The resulting

\[
 \alpha=\frac{d+\xi}{2}+s
\]

lies a fixed distance inside (19), so (16) or (17) saves a fixed power. The
empty subset is allowed when `A_0+tau<0`.

Suppose no subset satisfies (25). Every atom is at most `A_0+tau` or at
least `B_0-tau`. If the total of the small atoms exceeded `A_0+tau`, the
first partial sum crossing that threshold would be at most
`2(A_0+tau)<B_0-tau`, contradicting the failure of (25). Their total is at
most `A_0+tau`. The inequality `x>A_0+tau` forces a large atom, while
`2(B_0-tau)>x` makes it unique. Since `u<B_0-tau`, that atom cannot carry an
`a_0` coefficient. It is one of the unweighted convolutional `1` factors.
Its exponent `z` satisfies

\[
 z\ge x-A_0-\tau>2\gamma_0+2\delta.
\tag{26}
\]

The buffer prevents any loss when a dyadic `xi` approaches `5delta` within
`O(1/log T)`.

## Divisor-bounded long-free lemma

The long-free input needed in (26) is the following general form of Robert
and Sargos' Theorem 3, equations (6.8)--(6.9). Let `m=qz`, `m~D`, with `z`
an unweighted dyadic variable of exponent `rho`, and let the complementary
`q` coefficient be bounded by a fixed divisor function. The normalized
packet block is

\[
 \ll_\varepsilon T^\varepsilon\left(
 D^{1/2}N^{-1/4}T^{-\rho/4}+DN^{-1/2}T^{-\rho/2}
 +\frac{D}{T\sqrt N}\right).
\tag{27}
\]

The proof uses only the divisor bound on the outer coefficient. Literal
factor-product cutoffs are retained until partial summation in `z`, which
uses the unweighted maximal sum in equation (6.8). No Mellin character is
placed on `z`. The other factorization variables form the outer
divisor-bounded coefficient. The selected atom in (26) has coefficient
exactly one, so (27) applies. At `d=d_*+delta`, condition (26) puts all three
terms a fixed power below one.

Equations (15) and (23)--(27) cover every Type II rectangle with a
uniform power. This is the complete `b_0*b_0*1` term in (6).

## Equality contact and exact history cancellation

Termwise estimation loses its strict margin at `d=3lambda/5`. At the
limiting geometry take

\[
 \delta=\frac{\lambda-2}{5},\qquad \xi=\lambda-2,
 \qquad x=\frac{5-\lambda}{5}.
\]

In the all-unit part of `a_0^{*3}*1^{*2}`, put all three `a_0` factors at
the unit and choose the two free-factor exponents

\[
 p_0=\frac{5-2\lambda}{5},\qquad q_0=\frac\lambda5.
\]

They sum to `x`; both ordered placements occur.  The Robert--Sargos and
Bordellès intervals meet at one excluded endpoint: the only short subset
is exactly at that contact, while `q_0` and the total product lie beyond
the Bordellès upper endpoint. The long-free threshold is also exactly

\[
 2\gamma_0+2\delta=\frac\lambda5=q_0.
\]

Thus none of the three estimates has a strict power margin on this valid
cubic all-unit cross.  This is the actual termwise equality contact after
the one-nonunit histories below are combined exactly.

### Exact mixed-semiprime history count

Let `p` and `q` be distinct primes with
`p<=U<q`, so

\[
 a_0(p)=\mu(p)=-1,\qquad a_0(q)=a_0(pq)=0.
\]

At `n=pq`, the histories in
`-3 a_0^{*2}*1+a_0^{*3}*1^{*2}` with exactly one nonunit `a_0` factor
cancel exactly.  The quadratic term has two positions for `p`, hence

\[
 -3\,(2\mu(p))=6.
\]

The cubic term has three positions for `p` and two ordered splittings of
the remaining prime `q` between its two free factors, hence

\[
 3\,\tau(q)\mu(p)=3\cdot2\cdot(-1)=-6.
\]

Therefore the particular one-nonunit history used in the termwise equality
contact is absent from the combined K=3 identity.  The surviving total
coefficient comes from the all-unit histories.  They
contribute `-3` in the quadratic term and
`(1*1)(pq)=tau(pq)=4` in the cubic term.  Therefore

\[
 \bigl(-3+\tau(pq)\bigr)
 +\bigl(-3(2\mu(p))+3\tau(q)\mu(p)\bigr)
 =1=\mu(pq).
\tag{27a}
\]

The all-unit coefficient has the sharper decomposition

\[
 \tau(pq)-3
 =-1+\bigl(\tau(pq)-2\bigr)
 =-1+2=1.
\tag{27b}
\]

Here `-1` is the net single-free-factor packet: the two cubic splittings
`(1,pq)` and `(pq,1)` combine with the three negative quadratic copies.
The remaining `+2` consists of the ordered nontrivial free splittings
`(p,q)` and `(q,p)`.

More generally, before smoothing or taking absolute values, let `A_c` be
the coefficient of the complementary signed factor and let `W` be a common
product weight.  The complete all-unit contribution is exactly

\[
 -\sum_{c,r}A_cW(c,r)L_{cr}
 +\sum_c\sum_{v,w\ge2}A_cW(c,vw)L_{cvw}.
\tag{27c}
\]

The first term has one free factor of exponent
`x=(5-lambda)/5`, strictly beyond the long-free threshold.  The second term
contains the two ordered cross histories

\[
 2\sum_{c\asymp C}A_c
   \sum_{p\asymp P}\sum_{q\asymp Q}
      W(c,pq)L_{cpq}.
\tag{27d}
\]

Here `p` and `q` are unrestricted integers.  A literal distinct-prime
semiprime sector is only one slice of (27d), not the complete endpoint
residual.  These two all-unit histories reproduce the critical two-scale
geometry with positive unweighted coefficients.  Hence the displayed
one-nonunit contact cancels, while the cubic all-unit cross remains.  The
equality endpoint is not proved.

This provenance rules out using `mu(p)mu(q)=+1` as evidence for a separate
local-sign cancellation mechanism.  A possible future cancellation would
have to retain the negative single-free packet together with the positive
prime-pair packet, rather than assign Möbius signs to the two free factors.

The identities in (27a)--(27b), including `tau(pq)=4`, `mu(pq)=1`, and the
two ordered nontrivial splits, are
formalized in
`formalization/BuildingBlocks/ActualMobiusK3SemiprimeHistory.lean` and
checked by
`formalization/verification/ActualMobiusK3SemiprimeHistoryAudit.lean`.
Lean verifies the resulting multiplicity identity after the history
enumeration above; the cutoff definition of `a_0` and the enumeration of
the convolution tuples remain written mathematics.

### Why regrouping the all-unit splits has no strict margin

The ordered nontrivial splits are unweighted in either free variable, so
Robert--Sargos Theorem 3, equations (6.8)--(6.9), applies directly.  Taking
the long variable of exponent `q=lambda/5` in (27), however, gives

\[
 \frac d2-\frac\lambda4-\frac q4=0,
 \qquad
 d-\frac\lambda2-\frac q2=0
 \quad\left(d=\frac{3\lambda}{5}\right).
\tag{27e}
\]

Thus both leading terms meet the normalization exactly.  Taking the short
variable of exponent `p=1-2lambda/5` is worse: the corresponding exponents
are `(3lambda-5)/20` and `(3lambda-5)/10`, both positive.

One can instead collapse the hard dyadic product `r=pq`.  Its coefficient

\[
 B(r)=\#\{(p,q):p\asymp P,\ q\asymp Q,\ pq=r\}
\]

is divisor-bounded, and hard product cutoffs can be retained in `B`.
Robert--Sargos Theorem 1 allows this coefficient.  With

\[
 H=P,\qquad M=PQ,\qquad HC=PC=Q^2,
\]

its four relative factors are

\[
 T^{-1/4},\qquad (PC)^{-1/4}=Q^{-1/2},
 \qquad (PQ)^{-1/2},\qquad T^{-1/2}.
\tag{27f}
\]

The raw exponent is `1+lambda/5`, while the packet target is
`1+lambda/10`; hence the required relative saving is exactly
`Q^{-1/2}=T^{-lambda/10}`.  The second term of (27f) is therefore saturated.
The other three terms have strict margins for `2<lambda<29/14`.

The hard dyadic ranges do not prevent the collapse, but they do prevent
using the stronger unweighted Theorem 3 in the collapsed variable: `B(r)`
is a divisor-bounded factorization coefficient, not the constant-one
coefficient on a complete interval.  Enlarging its support is not an
absolute majorization of an exponential sum.  Thus direct use of the
unweighted long variable and collapsed use of the coefficient-bearing
theorem reach the same endpoint with no fixed power to spare.

The identities in (27e)--(27f) and the positivity of all nonsaturated
margins are checked in
`formalization/BuildingBlocks/ActualMobiusCriticalSemiprimeAliasDispersion.lean`.

### A second K=3 expansion of the signed outer factor

The coefficient `A_c` in (27c) must not be treated as `mu(c)`.  Return to
the original variables `c=st`, where `s>U` is the untouched signed Möbius
factor and `t` is the original free factor.  At the equality geometry write

\[
 y=\log_T s,\qquad \omega=\log_T t,
 \qquad y+\omega=C=\frac{4\lambda}{5}-1.
\]

Since the smaller signed exponent is `x=(5-lambda)/5`, orientation gives
`0<=omega<=lambda-2` and `x<=y<=C`.  Direct calculation yields

\[
 2u<y<3u.
\tag{27g}
\]

Thus the same exact K=3 identity may be applied to `mu(s)` before
separation.  Its `3a_0` term and cubic-tail remainder vanish by support.
The one-nonunit histories cancel as in (27a).  In its all-unit part, the
net single-free `s` atom has exponent at least `x>lambda/5`, so the
long-free estimate controls it strictly.  What remains has two new
unweighted free factors, say `v,w`, together with the old free factor `t`;
their exponent sum is `C`.

Put

\[
 L=C-\frac\lambda5=\frac{3\lambda}{5}-1,
 \qquad U_1=1-\frac\lambda5=x.
\]

If a subset of the new outer free atoms has exponent `S` with
`L<S<U_1` and `S ne lambda/5`, grouping it with the old `Q` factor gives
an exponent strictly inside one of the Robert--Sargos or Bordellès
intervals.  If an outer atom has exponent at least `U_1`, the long-free
estimate applies.  An atom in `(L,U_1)` either gives the strict grouping or
is itself the repeated value `lambda/5`.  If there is no such atom, every
atom is at most `L`; order them arbitrarily and take the first partial sum
exceeding `L`.  Since

\[
 2L<U_1
\]

throughout `lambda<29/14`.  The partial sum therefore lies in `(L,U_1)`.
After excluding the strict grouping case, it must equal `lambda/5`.
Consequently the only repeated contact has an outer subproduct of exponent
`lambda/5` and complementary exponent `L`.  The scale identities are

\[
 C=\frac\lambda5+L,qquad
 \left(1-\frac{2\lambda}{5}\right)+L=\frac\lambda5,
\tag{27h}
\]

and

\[
 0<L<u<\frac\lambda5.
\tag{27i}
\]

Hence the second expansion does not produce another signed cancellation.
It either gives a strict analytic grouping or reduces the remaining contact
to a self-similar unweighted geometry: two factors of scale `Q`, while the
old `P` factor times the new short complementary block also has scale `Q`.
This is a sharper residual than (27d), but no estimate for that symmetric
three-`Q` configuration is proved here.

Lean checks (27g)--(27i), including the support range for every
`0<=omega<=lambda-2`, in
`formalization/BuildingBlocks/ActualMobiusK3BottomSlice.lean`.  The second
history expansion and the subset dichotomy remain written mathematics.

## Type I terms and packet shells

The inherited Bourgain Type I estimate is

\[
 |S_{\rm I}|\ll_\varepsilon T^\varepsilon N^{-1/2}
 \left(D^{1/2}UT^{13/84}+\frac DT\right).
\tag{28}
\]

At `d=d_*+delta`, its first exponent is

\[
 E_{\rm I}=\frac{42\lambda-103}{1260}+\frac\delta2.
\tag{29}
\]

For `delta<=delta_0`,

\[
 E_{\rm I}\le\frac{168\lambda-355}{1260}-\frac\kappa2<0.
\tag{30}
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
