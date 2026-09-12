# The completed successor resolvent and its boundary sign criterion

The actual geometric successor average exists for every fixed parameter
$0<r<1$, as a convergent correction to the completed arithmetic source.
As $r\uparrow1$, its physical source tends uniformly to zero. Consequently,
positivity of its difference primitive on a common final age interval
along a sequence $r\uparrow1$ would imply RH. That sign is **unproved**.
The established [positive-primitive interval](actual-successor-resolvent-primitive-order.md)
is $0<r\le1/32$ and does not reach this boundary.

This note proves the full parameter domain and limiting statement and
then gives the conditional RH implication. It uses the literal ordinary
successor, every prime power, the initial charge correction, and the
unchanged density. No finite absolute charge or global $L^1$ norm is
assigned to the completed source.

## 1. The actual sources and a polynomial bound on their successive differences

Write, for $x=e^v\ge1$,
$$
g(x)=\frac{\psi(x)}x-1,\qquad a(v)=\sqrt x\,g(x),\qquad
a_0(v)=e^{-v/2},
$$
with zero extension to negative ages. Use exactly
$$
(Sf)(v)=\sqrt{\frac{x}{x+1}}f(\log(x+1)),\quad
Cf=Sf-\kappa(f)a_0,\quad
\kappa(f)=\frac12\int_0^\infty(Sf-f)(v)\,dv.
$$
Set $a_j=C^ja$, $\kappa_j=\kappa(a_j)$,
$d_j=a_j-a_{j-1}$ for $j\ge1$, and
$e_j=\kappa(S^ja)$ for $j\ge0$.
The exact recurrence, proved in the
[literal successor source](literal-compensated-successor-iterates.md), is
$$
a_j=S^ja-\sum_{i<j}\kappa_iS^{j-1-i}a_0,
\qquad
\kappa_j=\sum_{i=0}^j R_{j-i}e_i.
\tag{1}
$$
Here $R_j$ is the actual seed renewal sequence. Its
[proved all-index bound](exact-seed-renewal-asymptotic.md) is
$$
0<R_j\le(j+1)^{-1/2}.
\tag{2}
$$
We retain the complete signed drivers $e_i$ in (1).

For every real $y\ge1$, the interval $(y,y+1]$ contains at most one
integer. Thus the elementary estimates $\Lambda(n)\le\log n$ and
$\psi(y)\le y\log y$ give
$$
|g(y+1)-g(y)|
\le\frac{2\log(y+1)}{y+1}.
\tag{3}
$$
Consequently
$$
\|(S-I)S^ja\|_{L^1(dv)}
=\int_1^\infty\frac{|g(x+j+1)-g(x+j)|}{\sqrt x}\,dx
\le C\frac{\log(j+2)}{\sqrt{j+1}}.
\tag{4}
$$
To obtain the last bound, split at $x=j+1$. On the first interval
the logarithmic quotient is at most $C\log(j+2)/(j+1)$ and
$\int_1^{j+1}x^{-1/2}dx\le2\sqrt{j+1}$. On the second interval
it is at most $C\log(2x)/x$, whose weighted integral has the stated
bound. This also covers $j=0$ after increasing the absolute constant.
In particular, $|e_j|$ has the same bound.

The discrete convolution of $(j+1)^{-1/2}$ with itself is uniformly
bounded: split its index interval in half and sum $i^{-1/2}$ on each
half. Equations (1), (2), and (4) therefore imply
$$
\boxed{|\kappa_j|\le C\log(j+2).}
\tag{5}
$$

Put
$$
q_0=1,\quad q_l=\frac{\arctan\sqrt l}{\sqrt l}\ (l>0),
\qquad b_l=q_l-q_{l+1}>0.
$$
The exact seed identities are
$$
\|a_0\|_1=2,\quad
\|(S-I)S^la_0\|_1=2b_l,\quad \sum_{l\ge0}b_l=1.
$$
Subtract consecutive instances of (1):
$$
d_j=(S-I)S^{j-1}a
-\sum_{i=0}^{j-2}\kappa_i(S-I)S^{j-2-i}a_0
-\kappa_{j-1}a_0.
\tag{6}
$$
Every initial and feedback term is present. Using (4), (5), and the
summable seed differences gives the improved bound
$$
\boxed{\|d_j\|_1\le C\log(j+2)\qquad(j\ge1).}
\tag{7}
$$
Also $\int d_j=0$: the first actual compensated difference has zero
integral, and $d_j=C^{j-1}d_1$, while $C$ preserves the integral on
causal $L^1$. This assertion uses the bounded $L^1$ operator only at
each finite iterate; its crude exponential norm bound is not used in
(7).

## 2. Every fixed parameter below one defines the completed resolvent

For any fixed $0<r<1$, (7) proves absolute $L^1$ convergence of
$$
\boxed{\overline a_r-a=\sum_{j\ge1}r^jd_j,
\qquad
\overline P_r(v)=\int_0^v(\overline a_r-a)
=\sum_{j\ge1}r^jP_j(v),\quad P_j=Id_j.}
\tag{8}
$$
The primitive series converges uniformly in $v\ge0$; it is continuous
and vanishes at both zero and infinity for each fixed $r$.
The triangular identity $a_k-a=\sum_{j\le k}d_j$ and absolute
convergence give the literal geometric interpretation
$$
\overline a_r=a+(1-r)\sum_{k\ge0}r^k(a_k-a).
\tag{9}
$$
It is in this sense that $(1-r)\sum r^kC^ka$ is defined. The summands
$a_k$ need not themselves be integrable.

The same estimates are uniform over the actual natural cutoffs
$g_N(x)=E_\psi(\min(x,N))/x$. To see this, the counterpart of (3) is
bounded by $C(1+\log(y+1))/(y+1)$ uniformly in $N$, including the one
interval crossing $N$ and the frozen tail. The same proof of (4)--(7)
then applies. The known first-difference convergence
$d_{1,N}\to d_1$ in $L^1$ gives convergence of each fixed $d_{j,N}$.
Dominated summation using (7) proves, for each fixed $r<1$,
$$
(\overline a_{r,N}-a_N)\longrightarrow(\overline a_r-a)
\quad\hbox{in }L^1.
\tag{10}
$$
No uniform assertion as $r\uparrow1$ is made in (10).

Let
$$
Q(r)=\sum_{j\ge0}q_jr^j,\qquad E(r)=\sum_{j\ge0}e_jr^j,
\qquad c_r=\frac{E(r)}{Q(r)}.
$$
All these series converge absolutely. The exact scalar renewal and
(9) give
$$
\boxed{\overline g_r(x):=x^{-1/2}\overline a_r(\log x)
=(1-r)\sum_{k\ge0}r^k g(x+k)
-r c_r\sum_{l\ge0}\frac{r^l}{x+l},\qquad x\ge1,}
\tag{11}
$$
and $\kappa(\overline a_r)=c_r$ as a relative charge. In particular
the density contribution to the first term of (11) is exactly $-1$.
Equation (5) and the literal shifted-source formula also bound $a_j$
on each bounded age interval by $C_V(1+\log^2(j+2))$. Thus (9) and
(11) represent locally bounded actual functions, not only distributions.

## 3. An exact signed kernel controls the charge near the boundary

For $j\ge0$ define physical kernels
$$
H_j(y)=\mathbf1_{y\ge j+1}(y-j)^{-1/2},
\qquad
w_r(y)=(1-r)\sum_{j\ge0}r^j[H_j(y)-H_0(y)].
$$
Although the individual $H_j$ have infinite mass, their differences
are integrable and have zero integral. Direct integration of the
negative part on $[1,j+1)$ and the positive part on $[j+1,\infty)$ gives
$$
\|H_j-H_0\|_1=4(\sqrt{j+1}-1).
\tag{12}
$$
With $n=(1-r)^{-1}$, Jensen's inequality for the geometric index gives
$$
\boxed{\|w_r\|_1\le4\sqrt n,
\qquad\int_1^L|w_r(y)|dy\le4\sqrt L\quad(L\ge1).}
\tag{13}
$$
For the second estimate, separately integrate $H_j$ and $H_0$ only
over $[1,L]$; each integral is at most $2\sqrt L$.

The exact relation to the signed arithmetic driver is
$$
\boxed{E(r)=\frac1{2r}\int_1^\infty g(y)w_r(y)dy.}
\tag{14}
$$
For justification, sum the relative differences in (4) to obtain
$$
\sum_{j\ge0}r^j[g(x+j+1)-g(x+j)]
=r^{-1}\left[(1-r)\sum_{j\ge0}r^jg(x+j)-g(x)\right].
$$
Absolute weighted convergence follows from (4). For a fixed shift
$j$, changing variables at a finite upper cutoff and then taking its
limit identifies the weighted integral of $g(x+j)-g(x)$ with
$\int g(H_j-H_0)$. The upper endpoint strip is
$O_j(\log R/\sqrt R)$ and tends to zero. The remaining kernel is
absolutely integrable against $g$: either the elementary logarithmic
bound or the boundedness supplied by PNT suffices. Summation in $j$
is then justified by (12) and the geometric weights. No difference
of divergent absolute source charges is taken.

The exact $q_j$ formula and an improper Riemann sum give
$$
Q(r)\sim\frac{\pi^{3/2}}2\sqrt n\qquad(r\uparrow1).
\tag{15}
$$
Indeed $q_j=\pi/(2\sqrt j)+O(j^{-1})$, the leading series has
asymptotic $\sqrt\pi\sqrt n$, and the error is $O(\log n)$.

The unconditional quantitative PNT gives constants $C,c>0$ with
$$
|g(y)|\le C\exp(-c\sqrt{\log y})\quad(y\ge1).
\tag{16}
$$
For example, this follows from
[Trudgian's Theorem 1](https://arxiv.org/pdf/1401.2689), absorbing its
logarithmic prefactor and enlarging the constant on the initial range.
Split (14) at $L=\sqrt n$. Equations (13)--(16), with $r\ge1/2$,
prove for some smaller $c_1>0$
$$
\boxed{|c_r|\le C\left[n^{-1/4}
+\exp(-c_1\sqrt{\log n})\right],
\qquad |c_r|\log n\longrightarrow0.}
\tag{17}
$$
The local part of the kernel has normalized mass $O(n^{-1/4})$;
the other part samples only the proved PNT range. This is a signed
source estimate with a complete kernel, not an assumption that
$\sum e_j$ converges.

## 4. The completed physical average tends uniformly to zero

The first term of (11) tends uniformly to zero for $x\ge1$.
For an explicit bound, split its geometric index at $\lfloor\sqrt n\rfloor$.
The small-index weights have total mass $O(n^{-1/2})$ and $g$ is
bounded. All other samples have argument at least $\sqrt n$, where
(16) applies uniformly. Moreover
$$
0\le r\sum_{l\ge0}\frac{r^l}{x+l}
\le r\sum_{l\ge0}\frac{r^l}{1+l}
=-\log(1-r)=\log n.
$$
Together with (17), this proves
$$
\boxed{\sup_{x\ge1}|\overline g_r(x)|
\le C(1+\log n)\left[n^{-1/4}
+\exp(-c_2\sqrt{\log n})\right]\longrightarrow0.}
\tag{18}
$$
In particular $\overline a_r\to0$ uniformly on every bounded age
interval, and
$$
\boxed{\overline P_r(v)\longrightarrow
-\int_0^v a(u)du\quad\hbox{locally uniformly in }v\ge0.}
\tag{19}
$$
Uniform convergence in the physical supremum norm does not give
convergence in the critical $L^1$ or $L^2$ norm. The limit (19) is
also not asserted uniformly on the entire age half-line. Each
$\overline P_r$ has zero terminal value for fixed $r$; no terminal
value is inferred by interchanging the two limits.

## 5. The conditional boundary sign implies RH

Suppose there exist $V\ge0$ and a sequence $r_m\uparrow1$ such that
$$
\overline P_{r_m}(v)\ge0\qquad(v\ge V,\ m\ge1).
\tag{20}
$$
The same fixed $V$ is essential for this statement. More generally,
pointwise eventual nonnegativity in $m$ for each fixed $v\ge V$
would suffice. Equation (19) gives
$$
F(v):=-\int_0^v a(u)du\ge0\qquad(v\ge V).
\tag{21}
$$

For $\Re s>1/2$, the literal source transform is
$$
A(s)=\int_0^\infty e^{-sv}a(v)dv
=\frac{-\zeta'(s+1/2)}{(s+1/2)\zeta(s+1/2)}
-\frac1{s-1/2},
\qquad \mathcal L_F(s)=-\frac{A(s)}s.
\tag{22}
$$
These are initially absolutely convergent integral identities.
The expression on the right is holomorphic near every positive
real $s$: the zeta pole at $s=1/2$ cancels exactly, and zeta has no
real zero for $s+1/2>1/2$. On $(0,1)$ the latter fact follows from
the positive alternating eta series and its factor
$1-2^{1-z}<0$; on $(1,\infty)$ it follows from the Euler product.

Apply the positive-Laplace abscissa lemma proved in
[the classical positive-Laplace lemma and its proof](theta-positive-jump-mixture.md)
to the nonnegative final part of $F$. The finite initial segment has
an entire transform. If the integral's convergence abscissa were
positive, its real boundary point would have to be singular, contrary
to (22) and the just-checked real-axis regularity. Therefore the
actual Laplace integral is holomorphic throughout $\Re s>0$.
This conclusion concerns convergence of the integral, not merely
meromorphic continuation of its formula.

But an actual nontrivial zero $\rho$ with $\Re\rho>1/2$ and
multiplicity $m_\rho$ contributes to $-A(s)/s$ a pole at
$s_\rho=\rho-1/2$, with residue
$$
\frac{m_\rho}{\rho(\rho-1/2)}\ne0.
$$
It cannot be cancelled by the other terms in (22). This contradicts
holomorphy of the actual integral. The functional equation then
excludes nontrivial zeros to the left as well, proving RH under (20).

Thus (20) is an exact sufficient arithmetic sign condition for this
specific completed successor family. Its proof for parameters
approaching one remains open. The proved small-parameter positivity
is a starting interval, not a proof of (20), and no converse is
asserted here. The
[fixed-cutoff averaged profile](successor-averaging-retained-charge-profile.md)
retains the signed charge on an expanding physical scale; that theorem
has different quantifiers and supplies no missing sign in (20).

## Classical input and formal scope

The positive-Laplace abscissa principle is classical. [Suzuki, Proposition 1, Section 2.4](https://link.springer.com/article/10.1007/s11139-025-01238-9) states its Mellin form and cites Widder, *The Laplace Transform*, Chapter II, Theorem 5b. The self-contained positive-moment proof is linked above. The actual-source kernel, remainder and sign implications here are written proofs; no new priority claim is made. The repository already formalizes the general finite-abscissa obstruction in [LandauSingularity.lean](BuildingBlocks/LandauSingularity.lean) and the local extension step in [LocalLandauExtension.lean](BuildingBlocks/LocalLandauExtension.lean). Those modules do not formalize this particular arithmetic transform or its unproved sign premise.

This chapter preserves a written mathematical proof. The actual resolvent, its arithmetic sign or profile consumer, and its stated limiting quantifiers are not asserted to be Lean formalized.
