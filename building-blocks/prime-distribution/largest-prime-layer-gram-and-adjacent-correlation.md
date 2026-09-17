# Largest-prime layer Gram and the adjacent filtration correlation

The exact finite-\(X\) reduction leaves one quadratic form:

\[
\mathfrak A_X^{\mathrm{bulk}}
=\left\|\sum_{\sqrt X<d<X\log X}\mu(d)\Phi_{X,d}\right\|^2,
\tag{1}
\]

with

\[
\langle\Phi_{X,d},\Phi_{X,e}\rangle
=\mathcal G_X(d,e)
=\sum_{a,b\ge1}\kappa_{a+b-2}
e^{-2\max(ad,be)/X}.
\tag{2}
\]

Here

\[
\kappa_m
=m\log m-(2m+1)\log(m+1)+(m+1)\log(m+2)>0.
\tag{3}
\]

All successor histories \(a,b\), the complete gamma/prime-power clock
second variation, strict division, and the exact exponential weight remain.
By the preceding finite-\(X\) theorem,

\[
\mathfrak A_X^{\mathrm{bulk}}\ll_\varepsilon X^{1+\varepsilon}
\quad\Longrightarrow\quad
R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}.
\tag{4}
\]

This note decomposes (1) uniquely by largest prime and tests whether the
resulting filtration is martingale-like. It is not: disjoint arithmetic
layers are not orthogonal in the Gram metric. The exact remaining dependency
is an adjacent-stage correlation between each new largest-prime packet and
the complete predecessor.

## 1. Unique largest-prime packets

Put

\[
D_X=\lceil\sqrt X\rceil,\qquad T_X=\lceil X\log X\rceil,
\qquad \mathcal B_X=\{D_X<d<T_X\}.
\tag{5}
\]

For a prime \(q<T_X\), define its admissible cofactor set

\[
\mathcal M_q(X)=
\left\{
m\ge1:
\frac{D_X}{q}<m<\frac{T_X}{q},\
\mu(m)\ne0,\
P^+(m)<q
\right\}.
\tag{6}
\]

The convention \(P^+(1)=1\) is used. Every squarefree
\(d\in\mathcal B_X\) has a unique representation

\[
d=qm,\qquad q=P^+(d),\qquad m\in\mathcal M_q(X),
\tag{7}
\]

and

\[
\mu(d)=-\mu(m).
\tag{8}
\]

Define the largest-prime packet

\[
\boxed{
U_q=-\sum_{m\in\mathcal M_q(X)}
\mu(m)\Phi_{X,qm}.
}
\tag{9}
\]

Then the bulk vector has the exact disjoint-support decomposition

\[
F_X^{\mathrm{bulk}}
:=\sum_{d\in\mathcal B_X}\mu(d)\Phi_{X,d}
=\sum_{\substack{q<T_X\\q\ {\rm prime}}}U_q.
\tag{10}
\]

No integer is duplicated, and every composite repair is assigned to the
layer of its actual largest prime.

## 2. Exact layer Gram

For primes \(p,q<T_X\), equations (2) and (9) give

\[
\boxed{\begin{aligned}
\langle U_p,U_q\rangle
={}&
\sum_{\substack{m\in\mathcal M_p(X)\\
n\in\mathcal M_q(X)}}
\mu(m)\mu(n)\\
&\quad\times
\sum_{a,b\ge1}\kappa_{a+b-2}
e^{-2\max(apm,bqn)/X}.
\end{aligned}}
\tag{11}
\]

The signs in (11) are the inherited Möbius signs of the cofactors. Both
minus signs in (9) cancel. In affine-displacement form,

\[
\boxed{\begin{aligned}
\langle U_p,U_q\rangle
={}&
\sum_{a,b\ge1}\kappa_{a+b-2}
\sum_{h\in\mathbb Z}
\sum_{\substack{m\in\mathcal M_p(X),\,n\in\mathcal M_q(X)\\
apm-bqn=h}}
\mu(m)\mu(n)\\
&\qquad\times
\exp\!\left[-\frac{apm+bqn+|h|}{X}\right].
\end{aligned}}
\tag{12}
\]

Thus even adjacent largest-prime layers contain growing-slope affine
two-point Möbius correlations. The conditions
\(P^+(m)<p\), \(P^+(n)<q\) do not turn them into one-variable sums.

## 3. Exact weighted Stokes representation

For \(a\ge1\), define the signed layer prefix

\[
L_{q,a}(y)=
\sum_{\substack{m\in\mathcal M_q(X)\\aqm\le Xy}}\mu(m).
\tag{13}
\]

Using

\[
e^{-2\max(A,B)/X}
=2\int_{\max(A/X,B/X)}^\infty e^{-2y}\,dy,
\tag{14}
\]

equation (11) becomes

\[
\boxed{
\langle U_p,U_q\rangle
=2\sum_{a,b\ge1}\kappa_{a+b-2}
\int_0^\infty e^{-2y}
L_{p,a}(y)L_{q,b}(y)\,dy.
}
\tag{15}
\]

This is the exact largest-prime weighted Stokes formula. It retains the
moving endpoints

\[
m\le \frac{Xy}{aq},\qquad
n\le \frac{Xy}{bq},
\tag{16}
\]

and the bulk endpoints in (6). All future multiples \(a,b\) are present.

Formula (15) is a Gram pairing, not a boundary cancellation. The layer
prefixes for different primes are neither nested nor disjoint as functions
of \(y\). Their cofactor ceilings move at different rates, and the
largest-prime restrictions change with the layer. Integration by parts
therefore returns the same products \(L_{p,a}L_{q,b}\); it does not telescope
them.

## 4. Failure of martingale orthogonality

Order the primes and set

\[
F_{q^-}=\sum_{p<q}U_p,\qquad F_q=F_{q^-}+U_q.
\tag{17}
\]

The adjacent filtration increment is exactly

\[
\boxed{
\|F_q\|^2-\|F_{q^-}\|^2
=\|U_q\|^2+\mathcal C_q,
\qquad
\mathcal C_q:=2\langle F_{q^-},U_q\rangle.
}
\tag{18}
\]

Its cross term is

\[
\boxed{\begin{aligned}
\mathcal C_q
={}&2\sum_{p<q}
\sum_{\substack{n\in\mathcal M_p(X)\\m\in\mathcal M_q(X)}}
\mu(n)\mu(m)\\
&\quad\times
\sum_{a,b\ge1}\kappa_{a+b-2}
e^{-2\max(apn,bqm)/X}.
\end{aligned}}
\tag{19}
\]

A martingale mechanism would require
\(\mathcal C_q=0\), while a contractive admission mechanism would require

\[
\mathcal C_q\le-\|U_q\|^2.
\tag{20}
\]

Neither follows from the arithmetic filtration. The coefficient supports of
\(U_p\) and \(U_q\) are disjoint, but every entry
\(\mathcal G_X(d,e)\) is strictly positive. The observation map
\(d\mapsto\Phi_{X,d}\) therefore destroys support orthogonality.

The exact cumulative condition is obtained by summing (18):

\[
\boxed{
\mathfrak A_X^{\mathrm{bulk}}
=\sum_q\|U_q\|^2+\sum_q\mathcal C_q.
}
\tag{21}
\]

Consequently the bound needed in (4) is equivalent to the adjacent-stage
inequality

\[
\boxed{
\sum_q\mathcal C_q
\le-\sum_q\|U_q\|^2+O_\varepsilon(X^{1+\varepsilon}).
}
\tag{22}
\]

Equation (22) gives the exact required scale. The negative cross-layer work
must cancel the complete positive layer diagonal, up to the sole allowed
\(X^{1+\varepsilon}\) remainder.

There is also a literal adjacent-stage dichotomy. Put

\[
\mathfrak D_X=\sum_q\|U_q\|^2,\qquad
N_X=\#\{q:U_q\ne0\}.
\tag{22a}
\]

Since \(q<T_X=X\log X+O(1)\), the elementary prime-counting upper bound gives
\(N_X\ll X\). If
\(\mathfrak D_X\le 2C_\varepsilon X^{1+\varepsilon}\), the entire layer
diagonal is already at the allowed scale. Otherwise (22) forces

\[
\sum_q\mathcal C_q\le-\frac12\mathfrak D_X,
\tag{22b}
\]

and hence at least one actual adjacent filtration step satisfies

\[
\boxed{
\mathcal C_q\le-\frac{\mathfrak D_X}{2N_X}
\le-c\frac{\mathfrak D_X}{X}.
}
\tag{22c}
\]

Thus any martingale-style proof must either bound the sum of packet
self-energies directly or produce a specific predecessor--new-layer
correlation of the scale in (22c). Positivity supplies neither alternative.

## 5. Schur complement test

Let \(\mathcal H_{q^-}\) be the closed span of the preceding layer packets.
Decompose

\[
U_q=P_{q^-}U_q+(I-P_{q^-})U_q.
\tag{23}
\]

The Schur complement gives the nonnegative innovation

\[
\|(I-P_{q^-})U_q\|^2\ge0.
\tag{24}
\]

But the actual update uses coefficient one:

\[
\|F_{q^-}+U_q\|^2
=\|F_{q^-}+P_{q^-}U_q\|^2
+\|(I-P_{q^-})U_q\|^2.
\tag{25}
\]

The Schur complement controls only the last positive term. It gives no sign
to

\[
2\langle F_{q^-},P_{q^-}U_q\rangle
+\|P_{q^-}U_q\|^2,
\tag{26}
\]

which is precisely the correlated part of (18). Optimizing a scalar multiple
of \(U_q\) would change the actual Möbius coefficient and is not permitted.

Thus neither the martingale filtration nor its Schur complement proves
(20) or (22).

## 6. Window commutator and loss of a Boolean telescope

Without the bulk window, finite prime incidence has the linear identity

\[
\prod_{p\le q}(I-V_p)e_1
-\prod_{p<q}(I-V_p)e_1
=-V_q\prod_{p<q}(I-V_p)e_1.
\tag{27}
\]

Let \(P_{\mathcal B_X}\) be coefficient restriction to the bulk interval.
The actual packet is the corresponding largest-prime part of

\[
-P_{\mathcal B_X}V_q
\prod_{p<q}(I-V_p)e_1.
\tag{28}
\]

The restriction does not intertwine dilation:

\[
P_{\mathcal B_X}V_q
\ne V_qP_{\mathcal B_X}.
\tag{29}
\]

Their commutator is supported at the two moving cofactor endpoints
\(D_X/q\) and \(T_X/q\), exactly those in (6). Hence the linear Boolean
telescope survives only before observation and truncation. Squaring after
the affine observation produces (19), including every cross layer.

This is the weighted-Stokes obstruction in the largest-prime filtration.

## 7. A quantitative prime--composite cancellation forced by (4)

The obstruction has a concrete arithmetic size. Split the bulk vector into
its prime and composite parts:

\[
P_X=-\sum_{\substack{p\in\mathcal B_X\\p\ {\rm prime}}}\Phi_{X,p},
\qquad
C_X=\sum_{\substack{d\in\mathcal B_X\\d\ {\rm composite}}}
\mu(d)\Phi_{X,d}.
\tag{30}
\]

Then

\[
F_X^{\mathrm{bulk}}=P_X+C_X.
\tag{31}
\]

Every entry of \(\mathcal G_X\) is positive. Retaining only
\(a=b=1\), and primes \(X\le p<2X\), gives

\[
\begin{aligned}
\|P_X\|^2
&\ge \kappa_0
\sum_{\substack{X\le p<2X\\X\le q<2X\\p,q\ {\rm prime}}}
e^{-2\max(p,q)/X}\\
&\ge \kappa_0e^{-4}
\{\pi(2X)-\pi(X)\}^2
\gg \frac{X^2}{\log^2X}.
\end{aligned}
\tag{32}
\]

If (4)'s bulk hypothesis holds, then

\[
\begin{aligned}
2\langle P_X,C_X\rangle
&=\|F_X^{\mathrm{bulk}}\|^2-\|P_X\|^2-\|C_X\|^2\\
&\le
-c\frac{X^2}{\log^2X}
+O_\varepsilon(X^{1+\varepsilon}).
\end{aligned}
\tag{33}
\]

For any fixed \(0<\varepsilon<1\), the main term is strictly negative for
large \(X\). Since the prime coefficient in \(P_X\) is \(-1\), equation
(33) is the explicit necessary prime--composite correlation

\[
\boxed{
\sum_{\substack{p\in\mathcal B_X\\p\ {\rm prime}}}
\sum_{\substack{d\in\mathcal B_X\\d\ {\rm composite}}}
\mu(d)
\sum_{a,b\ge1}\kappa_{a+b-2}
e^{-2\max(ap,bd)/X}
\gg \frac{X^2}{\log^2X}.
}
\tag{34}
\]

This is not a positivity consequence. It is forced by the desired bound.
Because there are \(O(X)\) bulk primes below \(X\log X\), (34) also forces at
least one bulk prime \(p\) to satisfy

\[
\boxed{
\sum_{\substack{d\in\mathcal B_X\\d\ {\rm composite}}}
\mu(d)
\sum_{a,b\ge1}\kappa_{a+b-2}
e^{-2\max(ap,bd)/X}
\gg \frac{X}{\log^2X}.
}
\tag{35}
\]

Equation (35) is a specific largest-prime-layer row at the required scale.
Decomposing its composite sum by \(P^+(d)\) gives the exact cross-layer
packets (11). No argument forces the mass to lie in the immediately
preceding prime layer; it may be distributed over many earlier and later
largest-prime layers. Claiming an adjacent-\(p\) telescope would therefore
add an unsupported locality premise.

The genuinely adjacent object supplied by the filtration is instead
\(\mathcal C_q\) in (19), and its exact collective requirement is (22).

## 8. Classification and connection to the far remainder

Largest-prime decomposition is exact and useful: it identifies every
composite repair with a unique admission layer and exposes the full
cross-layer Gram. It does not create a martingale.

The radical geometric mechanisms tested here reduce as follows:

- martingale orthogonality fails because \(\mathcal G_X(d,e)>0\) across
  disjoint coefficient supports;
- the Schur complement isolates a positive innovation but leaves the actual
  correlated coefficient-one update unsigned;
- weighted Stokes is the exact prefix product (15), with moving cofactor
  endpoints and no telescope;
- Boolean incidence telescopes linearly before the bulk restriction, while
  its window commutator restores the endpoint packets;
- any proof of the target must establish the collective adjacent-stage
  cancellation (22), and in particular the prime--composite correlation
  (34).

Combining such a bound with (21) gives
\(\mathfrak A_X^{\mathrm{bulk}}\ll_\varepsilon X^{1+\varepsilon}\);
the exact finite-\(X\) implication (4) then yields

\[
R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}.
\tag{36}
\]

No part of (22), (34), or (35) is proved here. They are explicit arithmetic
dependencies. The largest-prime geometry is therefore structural and
obstructive rather than coercive.

## 9. Review checks

1. Unique factorization gives (7), and squarefreeness gives (8).
2. Both packet signs in (9) cancel in the bilinear form, proving (11).
3. Inserting the tail identity (14) into (11) gives the factor \(2\) in
   (15).
4. Expanding \(\|\sum_qU_q\|^2\) in prime order proves (21) exactly.
5. The commutator in (29) is supported precisely where multiplication by
   \(q\) crosses \(D_X\) or \(T_X\).
6. The \(a=b=1\) term has coefficient
   \(\kappa_0=\log2\), and \(p,q\in[X,2X]\) give the factor at least
   \(e^{-4}\), proving (32).
7. Prime-only cross terms have positive sign, so the negative term required
   in (33) must come from composites.

The authoritative repository was not modified. No RH premise, fixed-prime
limit, discarded prime power, off-domain division state, or Gamma-limit
error is used.
