# Möbius--Stokes future boundary and the surviving hard reservoir

This gives an exact moving-horizon boundary
flux identity for the affine bulk form and locates the limit of the
large-prime/friable cancellation.  It also proves an unconditional lower
bound showing which part of the actual Möbius source that cancellation
does not control.  No RH estimate is asserted.

## 1. The bulk future cone before taking a norm

Put

\[
 D=\lceil\sqrt X\rceil,\qquad T=\lceil X\log X\rceil,
 \qquad N=\lfloor Xy\rfloor,
\]

and define the literal moving bulk prefixes

\[
 F_a(y)=\sum_{\substack{D<d<T\\ad\le N}}\mu(d),
 \qquad a\ge1.                                           \tag{1}
\]

Only \(a\le L(y):=\lfloor N/(D+1)\rfloor\) occur.  The exact affine
bulk quadratic from the finite-\(X\) reduction is

\[
 \mathfrak A_X^{\rm bulk}
 =2\sum_{a,b\ge1}\kappa_{a+b-2}
       \int_0^\infty e^{-2y}F_a(y)F_b(y)\,dy.             \tag{2}
\]

Using the literal clock representation

\[
 \kappa_{a+b-2}=\int_0^\infty
 (1-q)^2q^{a+b-2}w(t)\,dt,\qquad q=e^{-t},               \tag{3}
\]

equation (2) becomes the source-preserving future-cone identity

\[
\boxed{
 \mathfrak A_X^{\rm bulk}
 =2\int_0^\infty e^{-2y}\int_0^\infty w(t)
 \left|(1-q)\sum_{a=1}^{L(y)}F_a(y)q^{a-1}\right|^2
 dt\,dy.}                                                \tag{4}
\]

All Möbius signs, future multiples, the original clock, and both moving
bulk endpoints occur in (4).

## 2. Exact discrete Stokes formula

Define the accumulated future charge

\[
 C_A(y)=\sum_{a\le A}F_a(y)
 =\sum_{\substack{D<d<T\\d\le N}}
   \mu(d)\min\!\left(A,\left\lfloor\frac Nd\right\rfloor\right),
 \qquad 1\le A\le L.                                    \tag{5}
\]

Abel summation in the future index gives exactly

\[
\boxed{
 \sum_{a=1}^{L}F_aq^{a-1}
 =(1-q)\sum_{A=1}^{L-1}C_Aq^{A-1}+C_Lq^{L-1}.}           \tag{6}
\]

Thus the observed bulk field in (4) is

\[
\boxed{
 G_{X,y}(q)
 =(1-q)^2\sum_{A=1}^{L-1}C_A(y)q^{A-1}
 +(1-q)C_L(y)q^{L-1}.}                                  \tag{7}
\]

This is a literal Möbius--Stokes formula.  The first term is the interior
future flux; the second is the escaping moving-endpoint charge.  There is
no fixed-cell limit in (5)--(7).

For the complete, unwindowed source, \(D=0,T=\infty,L=N\), and divisor
renewal gives

\[
 C_N=\sum_{a\le N}M(\lfloor N/a\rfloor)
 =\sum_{d\le N}\mu(d)\left\lfloor\frac Nd\right\rfloor=1. \tag{8}
\]

This is precisely the endpoint reached by the exact all-largest-prime
telescoping and its negative adjacent-layer cancellations.  For the bulk
window, the discrepancy from one is the commutator flux through
\(d=D\) and \(d=T\); formula (5) keeps it rather than extending the
cofactor range.

## 3. The noncommuting boundary: hard clock sees \(C_1\), not \(C_L\)

At the opposite endpoint of the same path,

\[
 C_1(y)=F_1(y)
 =\sum_{D<d<\min(T,N+1)}\mu(d).                          \tag{9}
\]

In particular, for \(1\le y\le2\) and large \(X\),

\[
 C_1(y)=M(N)-M(D).                                      \tag{10}
\]

The hard-clock endpoint \(q=0\) in (7) is exactly

\[
 G_{X,y}(0)=C_1(y),                                     \tag{11}
\]

whereas the completed future-cone/prime-admission identity (8) fixes the
other endpoint \(C_L\).  This is the precise noncommutation of the
fixed-prime and growing-horizon limits: completing every future face
controls the terminal boundary charge but does not control the initial
Möbius charge sampled by the original clock.

The gap is quantitative.  From (1), \(|F_a(y)|\le N/a\).  Therefore, if
\(q\le N^{-2}\),

\[
 \left|G_{X,y}(q)-(1-q)F_1(y)\right|
 \le(1-q)N\sum_{a\ge2}\frac{q^{a-1}}a
 \le \frac2N.                                          \tag{12}
\]

More sharply, for \(0<q\le1/4\),

\[
 \left|G_{X,y}(q)-(1-q)F_1(y)\right|
 \le 2Nq.                                               \tag{12a}
\]

Consequently a nonzero initial charge cannot be screened by later future
faces until \(q\) reaches its source-specific capacity scale
\(|F_1|/N\).  Taking

\[
 t\ge \log\!\frac{8N}{|F_1|+N^{-1}}
\]

in the original clock gives the nonlinear form

\[
\boxed{
 \int_0^\infty w(t)|G_{X,y}(e^{-t})|^2dt
 \ge c\,
 \frac{\bigl(|F_1(y)|-N^{-1}\bigr)_+^2}
 {\log\!\left(eN/(|F_1(y)|+N^{-1})\right)}.}            \tag{12b}
\]

The denominator is the exact hard-clock capacity cost: an initial charge
of size \(m\) remains visible through a clock tail of mass
\(\asymp1/\log(eN/m)\).  This uses the actual coefficient bound in (1),
not a generic analytic-function derivative estimate.

For \(t\ge2\log N\), the original weight satisfies
\(w(t)\ge c/t^2\), and \(1-q\ge1/2\).  Hence

\[
\boxed{
 \int_{2\log N}^{\infty}w(t)|G_{X,y}(e^{-t})|^2dt
 \ge \frac{c}{\log N}
       \left(|F_1(y)|-\frac4N\right)_+^2.}              \tag{13}
\]

Integrating (13) over \(1\le y\le2\), on which \(e^{-2y}\) is bounded
below, and grouping the intervals where \(\lfloor Xy\rfloor=n\), gives

\[
\boxed{
 \mathfrak A_X^{\rm bulk}
 \ge \frac{c}{X\log X}
 \sum_{X\le n<2X}
 \left(|M(n)-M(D)|-\frac4n\right)_+^2.}                \tag{14}
\]

Using (12b) instead gives the stronger Orlicz-capacity constraint

\[
 \mathfrak A_X^{\rm bulk}\ge\frac cX
 \sum_{X\le n<2X}
 \frac{\bigl(|M(n)-M(D)|-n^{-1}\bigr)_+^2}
 {\log\!\left(en/(|M(n)-M(D)|+n^{-1})\right)}.          \tag{14a}
\]

This lower bound uses only a positive subregion of the original clock.
It cannot be canceled by the soft-clock negative large-prime/friable
cross because the square in (4) has already recombined every packet.

## 4. Consequence for an external-reservoir proof

The target bulk estimate

\[
 \mathfrak A_X^{\rm bulk}\ll_\varepsilon X^{1+\varepsilon} \tag{15}
\]

would force the dyadic mean-square reserve bound

\[
 \sum_{X\le n<2X}|M(n)-M(\lceil\sqrt X\rceil)|^2
 \ll_\varepsilon X^{2+\varepsilon}\log X,              \tag{16}
\]

up to the harmless positive-part threshold in (14).  Equation (16) is
not supplied by the endpoint law \(C_L=1\), by the sign of one adjacent
largest-prime cross, or by positivity of the bulk Gram kernel.

This identifies the exact missing reservoir mechanism.  It must control
the whole path

\[
 C_1,C_2,\ldots,C_L,
 \qquad C_A-C_{A-1}=F_A,                                \tag{17}
\]

in the clock weight of (7), while retaining the actual coefficient one
at every future face.  An identity involving only the terminal flux
\(C_L\), even the exact largest-prime/friable cancellation, cannot bound
the hard component (14).  A useful next input would be a source-specific
weighted Poincare estimate for this path whose boundary term includes
\(C_1\); omitting it would contradict (11)--(14).

The Stokes identity (7) is constructive and exact, but its hard endpoint
shows why the currently known negative boundary cancellation does not yet
bound the sole remainder.  Full RH remains open.

## 5. Exact prime-dilation boundary flux for the hard endpoint

The surviving endpoint itself has a two-face Stokes formula.  For any
prime \(p\), split every squarefree integer uniquely into the part not
divisible by \(p\) and its \(p\)-multiple.  With

\[
 B_{D,N}=\sum_{D<d\le N}\mu(d),
\]

the identity \(\mu(pm)=-\mu(m)\) for \(p\nmid m\) gives

\[
\boxed{\begin{aligned}
 B_{D,N}={}&
 \sum_{\substack{\max(D,N/p)<m\le N\\p\nmid m}}\mu(m)\\
 &-\sum_{\substack{D/p<m\le\min(D,N/p)\\p\nmid m}}\mu(m).
\end{aligned}}                                         \tag{18}
\]

The first line is the escaping upper horizon face.  The second is the
negative small-cofactor face created when multiplication by \(p\) crosses
the lower bulk boundary.  Formula (18) is the coefficient-level version
of the exact negative large-prime/small-friable cross; both endpoints move
with \(p\), and no cofactor range is extended.

When \(p>N/D\), it simplifies to

\[
 B_{D,N}=
 \sum_{\substack{D<m\le N\\p\nmid m}}\mu(m)
 -\sum_{\substack{D/p<m\le N/p\\p\nmid m}}\mu(m).       \tag{19}
\]

This explains why the negative boundary packet is real but does not by
itself contract the hard reserve: the same identity carries an upper face
containing the unsmoothed bulk sum.  Squaring or averaging (18) over
large primes requires the signed cross between these two faces.  Bounding
them separately restores the quadratic loss.  Thus the next genuinely new
estimate would have to control the cross in (18) uniformly as
\(p\asymp N/D\), in the capacity weight (14a); its negative sign alone is
not enough.
