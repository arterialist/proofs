# Actual long-clock cofactor row as a positive cumulative-source average

Attribution: RH Agent3 and its mathematical auditor; independent review of the displayed calculations by RH Proof. The completed-boundary theorem is consumed from the earlier division source.

Written mathematics, independently audited by the Sol medium math worker.
This studies the established complete causal
process acting on the literal finite odd window. It constrains the
geometry of the actual signed work row, rather than bounding an
arbitrary previous state. It proves neither an RH-size source bound
nor a sign for the Weil form, and is not yet a Lean theorem.

Use the fixed real universal window \(z=Z^\vee\), with
\(\widehat z(\xi)=\beta\xi^2+O(\xi^3)\), \(\beta>0\).
For the complete actual process, \(\rho(\xi)\sim\pi|\xi|\) at zero
and there is a positive gap outside every neighborhood of zero.
Its exact smoothed relative-age kernel is
\[
K_s(v)=\frac1{2\pi}\int e^{-2s\rho(\xi)}
|\widehat z(\xi)|^2e^{i\xi v}d\xi
=\mathbb E C_Z(v+B_s-A_s).
\tag{1}
\]
The expectation includes the no-jump atom and all continuous histories.

## Uniform signed kernel profile, including its derivative

Fourier scaling and dominated convergence give
\[
\sup_{x\in\mathbb R}|s^5K_s(sx)-G(x)|\longrightarrow0,\qquad
\sup_{x\in\mathbb R}|s^6K_s'(sx)-G'(x)|\longrightarrow0,
\tag{2}
\]
where
\[
G(x)=\frac{24\beta^2}{\pi}\Re(2\pi-ix)^{-5}.
\tag{3}
\]
For the first limit, the scaled Fourier integrand converges to
\(\beta^2y^4e^{-2\pi|y|}\) in \(L^1(dy)\).
For the derivative multiply it by \(iy\).
On a fixed small-frequency interval the cusp and quadratic zero
give dominating functions \(Ce^{-a|y|}|y|^4\) and
\(Ce^{-a|y|}|y|^5\). Outside that interval the corresponding
unscaled integrals are bounded by \(e^{-2s\delta}\) times fixed
Schwartz integrals, and remain negligible after multiplication by
\(s^5\) or \(s^6\). Thus (2) is uniform in the observation coordinate.
No moment of a complete history age or density derivative is assumed.

Writing \(A=2\pi\),
\[
G(x)=\frac{24\beta^2}{\pi}
\frac{A(A^4-10A^2x^2+5x^4)}{(A^2+x^2)^5}.
\]
The two positive roots are
\[
x_*=2\pi\sqrt{1-2/\sqrt5},\qquad
x^{**}=2\pi\sqrt{1+2/\sqrt5}.
\]
The profile is positive for \(|x|<x_*\), negative for
\(x_*<|x|<x^{**}\), and positive for \(|x|>x^{**}\).
Consequently it is not globally a nonnegative kernel.

## Actual finite cutoff lies in the central region

Fix \(c>1/x_*\), put \(s=c\log n\), and take \(n\) sufficiently
large depending on the fixed process, packet and \(c\). All ratios
of integers \(1\le m,l\le n\) satisfy
\[
|\log(m/l)|\le\log n=s/c.
\]
Since \(G\) has a positive minimum on \([-1/c,1/c]\), (2) implies
\[
K_s(v)\ge m_c/(2s^5)>0,\qquad |K_s'(v)|\le C_c/s^6
\quad (|v|\le\log n).
\tag{4}
\]
Thus positivity holds for every actual finite-source pair in this
clock regime; the negative scaled annulus lies outside the cutoff.

Define the actual source-row weight
\[
w_n(x)=x^{-1/2}K_s(\log(n/x)),\qquad 1\le x\le n.
\]
It is positive and, by (4), strictly decreasing for large \(n\):
\[
w_n'(x)=x^{-3/2}
[-\tfrac12K_s(\log(n/x))-K_s'(\log(n/x))]<0.
\tag{5}
\]

## Exact signed arithmetic row and its terminal atom

For odd \(n\), let \(a_m=\Lambda(m)-2\), including \(a_1=-2\).
The established successor work is exactly
\[
W_n=\frac{2a_n}{\sqrt n}R_n,\qquad
R_n=\sum_{\substack{m<n\\m\text{ odd}}}a_m w_n(m)
=\sum_{\substack{m<n\\m\text{ odd}}}\Lambda(m)w_n(m)
-2\sum_{\substack{m<n\\m\text{ odd}}}w_n(m).
\tag{6}
\]
Every odd proper prime power is retained. Both terms in the last
difference have positive weights; their signed difference remains
an arithmetic question.

Put \(b=n-1\) and
\(A_o(x)=\sum_{m\le x,\,m\text{ odd}}(\Lambda(m)-2)\).
Exact finite Abel summation, including the state-one jump, gives
\[
\boxed{R_n=A_o(b)w_n(b)
+\int_1^b A_o(x)(-w_n'(x))dx.}
\tag{7}
\]
In particular the row is a positive average of the actual signed
cumulative source. Precisely,
\[
\nu_n=\frac{w_n(b)}{w_n(1)}\delta_b
+\frac{-w_n'(x)}{w_n(1)}\mathbf1_{[1,b]}dx
\]
is a probability measure, since its total mass is
\((w_n(b)+w_n(1)-w_n(b))/w_n(1)=1\), and
\(R_n=w_n(1)\int A_o\,d\nu_n\).
The terminal atom is literal and has not been removed. Its small
mass does not justify dropping its product with the unbounded
terminal source, or taking an infinite-cutoff source limit.

The original source is also retained explicitly:
\[
A_o(x)=\psi(x)-x+q(x),\qquad
q(x)=x-2\lfloor(x+1)/2\rfloor
-(\log2)\lfloor\log x/\log2\rfloor,\quad x\ge1.
\tag{8}
\]
Thus (7) uses the original cumulative error with its exact even-power
and odd-count correction; at the seed these are \(-1\) and \(-1\).
Freezing both at \(b\) retains the same terminal value in (7).

The positive weights imply conditional sign constraints on (7):
if the cumulative source is nonpositive throughout the averaging
range, then \(R_n\le0\), and similarly for a nonnegative source.
No such unconditional source sign is asserted. The sign of \(W_n\)
also contains the actual successor coefficient \(a_n\).
At even \(n\) the source increment and \(W_n\) vanish, while clock
dissipation remains.

Entrywise positivity of (4) does not allow dropping signed centered
pairs, comparing their energy to the square of their coefficient
sum, or signing a Weil scalar. Equations (6)-(8) locate the missing
constraint in a linked positive average of the actual cumulative
source. Its required cumulative signed upper-work/RH-size bound is
still unproved. The calculation is not a substitute criterion or
a claim of full RH or complete Lean formalization.

## Power response and why the terminal atom cannot be dropped

The linear average in (7) can be calibrated without replacing the
actual source or asserting an isolated actual zero contribution.
Fix a complex \(\rho\) with \(\Re\rho>1/2\), put
\(z_\rho=\rho-1/2\), and consider the cumulative model
\(A_\rho(x)=x^\rho\), \(x\ge1\), with its literal jump of size one
at \(x=1\). Denote the functional in (7) by \(\mathcal T_n(A)\).
Finite integration by parts and \(v=\log(n/x)\) give exactly
\[
\mathcal T_n(A_\rho)=w_n(1)+
\rho n^{z_\rho}
\int_{\log(n/(n-1))}^{\log n}
e^{-z_\rho v}K_s(v)dv,\qquad s=c\log n.
\tag{9}
\]
The origin term is included, not erased by integration by parts.
Equation (2) bounds \(s^5K_s(v)\) uniformly for all real \(v\),
and for fixed \(v\), it tends to \(G(0)>0\).
Since \(\Re z_\rho>0\), dominated convergence against
\(e^{-\Re z_\rho v}\) shows
\[
\boxed{\mathcal T_n(A_\rho)=
\left[\frac{\rho G(0)}{z_\rho}+o(1)\right]
\frac{n^{z_\rho}}{(c\log n)^5}.}
\tag{10}
\]
Here \(G(0)=3\beta^2/(4\pi^6)\). The origin contribution
\(w_n(1)=O(s^{-5})\) is smaller than the growing model term.
The leading coefficient is nonzero.

In fact the terminal atom and the interior average separately satisfy
\[
A_\rho(n-1)w_n(n-1)
=[G(0)+o(1)]\,n^{z_\rho}s^{-5},
\]
\[
\int_1^{n-1}A_\rho(x)(-w_n'(x))dx
=[G(0)/(2z_\rho)+o(1)]\,n^{z_\rho}s^{-5}.
\tag{11}
\]
For the interior use (5), the same dominated convergence for \(K_s\),
and the uniform bound \(K_s'=O(s^{-6})\) from (2).
Thus the normalized probability mass of the endpoint may tend to
zero while its product with the source remains at leading order.
Its omission would change the coefficient in (10).

For the model \(-x^\rho/\rho\), shaped like a single cumulative
explicit-formula term, (10)'s coefficient is
\(-G(0)/(\rho-1/2)\), also nonzero. This is solely a linear
response calculation. It does not isolate, dominate, or justify
termwise treatment of the conditionally convergent zero expansion
of the actual zeta source. It supplies no new RH criterion.
The positive-average geometry attenuates these growing power models
only by a logarithmic factor; it does not eliminate their power
growth. A proof for the actual source still requires an arithmetic
constraint on the signed cumulative residual.

## Exact finite division boundary and its incompatible positive-power cone

The negative cofactor-boundary identity in
r34-signed-division-core-boundary.md applies to complete power weights
\(x^{-\sigma}\), \(\sigma>1\), and positive mixtures of such weights
when the relevant exchanges converge. This is a useful actual
division constraint, but its weight hypothesis must be checked
before transferring it to the present source row.

For the literal row weight in (5), its logarithmic slope is
\[
-\frac{xw_n'(x)}{w_n(x)}
=\frac12+\frac{K_s'(\log(n/x))}{K_s(\log(n/x))}
=\frac12+O_c(1/\log n)
\quad(1\le x\le n),
\tag{12}
\]
uniformly. For large \(n\) this lies, for example, in \((1/4,3/4)\).
Consequently \(xw_n(x)\) is strictly increasing.
In contrast, any positive mixture
\[
W(x)=\int_{[1,\infty)}x^{-\sigma}\,\eta(d\sigma),
\qquad\eta\ge0,
\]
with finite values on an interval makes \(xW(x)\) nonincreasing:
for \(x_2>x_1\), each integrand satisfies
\(x_2^{1-\sigma}\le x_1^{1-\sigma}\).
No derivative interchange is needed for this argument.
Thus the actual \(w_n\) cannot equal such a positive mixture,
even on a nondegenerate subinterval of \([1,n]\).
Positivity and decrease of \(w_n\) alone do not supply the
stronger power-cone property.

The finite division identity itself remains valid without that
property. For integers \(2\le K\le n\), define
\[
\Phi_{K,n}=
\sum_{\substack{k<K\\k\text{ odd}}}\log k
\sum_{\substack{d\text{ odd}\\dk<n}}\mu(d)w_n(dk),\qquad
c_K(r)=\sum_{\substack{k\mid r\\k<K}}\mu(r/k)\log k.
\]
Here \(\mu(d)\) is the arithmetic Möbius function.
Finite regrouping by the exact product \(r=dk\) gives
\[
\boxed{\Phi_{K,n}=
\sum_{\substack{r<K\\r\text{ odd}}}\Lambda(r)w_n(r)
+\sum_{\substack{K\le r<n\\r\text{ odd}}}c_K(r)w_n(r).}
\tag{13}
\]
For \(r<K\), the full divisor identity
\(\sum_{k\mid r}\mu(r/k)\log k=\Lambda(r)\) proves the core.
The term \(k=1\) is included and vanishes because \(\log1=0\).
Products equal to \(K\) belong to the boundary; products equal
to \(n\) are excluded from the literal predecessor source.
Every proper odd prime power and every allowed cofactor is retained.
Taking \(K=n\) recovers the full prime-power row in (6).
Its centered subtraction \(-2\sum_{r<n,\,r\text{ odd}}w_n(r)\)
remains separate and retains the nonzero state-one contribution.

Already at \(K=4\), the actual odd boundary coefficients include
\[
c_4(9)=-\log3,\qquad c_4(45)=+\log3.
\tag{14}
\]
For a sufficiently large clocked cutoff \(n>45\), both weights
are strictly positive by (4), so these are actual boundary
contributions of opposite signs. This says nothing by itself
about the sign of their complete sum.

Equation (13) makes no use of an infinite Dirichlet series or of
an inverse zeta factor on the critical line. It also does not
commute the divisor identity with a different observation or
successor-history process. The available complete negative
boundary theorem for the power cone cannot be invoked for
this actual weight by positivity alone. A new cancellation
constraint on the signed finite boundary, or directly on (7),
is still required for the missing upper-work bound.
There is a separate endpoint issue: even for a power-cone
weight, the existing sign theorem controls a completed boundary;
it does not automatically sign the terminally truncated odd
boundary in (13). Such a transfer would also need to retain
and bound its exterior, with the parity restriction accounted for.
This limits one proposed transfer; it does not exclude other
division methods or prove/refute RH.

## Second-order divisor positivity leaves exact odd centering terms

The finite algebra in this added section has been checked locally;
it is not a newly compiled Lean result.

The repository's prime-filter-selberg-identities.md already formalizes
the full Selberg identity and the nonnegative distinct-prime function
\[
D_2=\Lambda*\Lambda-P_2,\qquad
P_2(r)=\Lambda(r)(\log r-\Lambda(r)).
\]
These cannot be used as a sign for the actual odd centered coefficients
without their compensation. Extend \(a(r)=\Lambda(r)-2\) on positive
odd integers by zero on even integers. For odd \(r\), ordinary finite
Dirichlet convolution gives exactly
\[
\boxed{(a*a)(r)=(\Lambda*\Lambda)(r)-4\log r+4\tau(r)
=D_2(r)+P_2(r)-4\log r+4\tau(r).}
\tag{15}
\]
Indeed the two mixed sums each contain
\(\sum_{d\mid r}\Lambda(d)=\log r\), and the constant product
contributes four for each divisor. In particular \((a*a)(1)=4\):
the state-one pair is retained. For an odd prime \(p\),
\[
(a*a)(p)=8-4\log p,
\]
which is negative for \(p\ge11\). At the proper prime power \(9\),
\[
(a*a)(9)=(\log3-2)(\log3-6)>0,\qquad D_2(9)=0.
\]
Thus the omitted residual is neither uniformly nonnegative nor
uniformly nonpositive, even on actual arithmetic indices where the
distinct-prime function vanishes.

For any finite product weight \(V(r)\), (15) gives the exact identity
\[
\sum_{\substack{m,l\text{ odd}\\ml<n}}a(m)a(l)V(ml)
=\sum_{\substack{r<n\\r\text{ odd}}}
[D_2(r)+P_2(r)-4\log r+4\tau(r)]V(r).
\tag{16}
\]
Products equal to \(n\) are excluded. All proper prime powers and the
pair at one remain. Taking a positive \(V\), including the actual
positive row weight above, does not erase the signed residual.

This is multiplicative product grouping, not the process norm:
the latter uses independent cutoffs \(m,l\le n\) and the ratio
kernel \(K_s(\log(m/l))/\sqrt{ml}\), rather than \(V(ml)\).
No comparison between these two pairings has been proved here.
The existing Selberg positivity therefore leaves both the exact
odd centering correction and a product-to-ratio transfer to justify
before it could bound the linked process work. This inspection
does not yield a new RH-size estimate or repeat the existing
Selberg formalization as an RH proof.
