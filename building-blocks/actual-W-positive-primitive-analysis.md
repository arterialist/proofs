# The actual W criterion: a positive successor primitive, cumulative comparison, and oscillation

The Riemann hypothesis remains unproved. This note proves a finite-window
comparison for the actual $W$ expression and proves that the corresponding
unsmoothed difference has both signs arbitrarily far out. These results
use the actual von Mangoldt source, every prime power, the ordinary
successor, and the unchanged same-prime subtraction. They do not establish
the eventual sign required by the RH criterion.

The cumulative comparison is
$$
\boxed{\int_1^x\left(\log\frac xy\right)^2
       \frac{W(y)-W_b(y)}{y^3}\,dy>0\qquad(x>1),}
 \tag{1}
$$
where $W_b$ is the precisely specified compensated-successor comparison
below. Nevertheless $W_b-W$ takes both signs at arbitrarily large
arguments. All results here are written mathematical proofs; they have
not yet been translated into Lean. The two finite interval computations
are rigorous Arb/Acb certificates, with their infinite tails bounded
analytically.

## 1. The actual arithmetic readout and its source product

Write
$$
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad E(x)=\psi(x)-x,\qquad
 \sigma=\sum_{n\ge2}\Lambda(n)\delta_n-dx-\delta_1
 \quad\hbox{on }[1,\infty).
$$
Its right-continuous cumulative is $E$, including $E(1)=-1$.
Define
$$
N(x)=\iint(x-uv)_+\,d\sigma(u)d\sigma(v),
$$
$$
T_{\rm same}(x)=
 \sum_{\substack{p^m\le x\\m\ge2}}
 (m-1)(\log p)^2(x-p^m),\qquad
 V=N-T_{\rm same},\qquad
 W(x)=\sum_{d\le x}\sqrt d\,V(x/d).
 \tag{2}
$$
The factor $m-1$ counts all ordered pairs of positive exponents of the
same prime. This is the exact distinct-prime $W$ criterion, with
density and initial terms included.

Use the critical age source and fixed causal filter
$$
a(v)=e^{-v/2}E(e^v)1_{v\ge0},\quad
 k(v)=e^{-3v/2}1_{v\ge0},\quad L_0=I-k*,\quad
 \rho_*=\sum_{d\ge1}d^{-1}\delta_{\log d}.
$$
Two integrations by parts in (2), with the initial atom retained, give
$$
n(v):=e^{-3v/2}N(e^v)=L_0(a*a)(v).
 \tag{3}
$$
For example, the same identity follows directly in the absolute
Laplace half-plane from
$$
A(s):=\mathcal L_a(s)
 =\frac{D(s+1/2)}{s+1/2}-\frac1{s-1/2},
 \qquad D(z)=-\frac{\zeta'(z)}{\zeta(z)},
$$
and $\mathcal L_n(s)=(s+1/2)A(s)^2/(s+3/2)$.
The convolution $a*a$ is a reflected bilinear integral, not a
Hermitian norm square.

Put
$$
\vartheta(v)=(e^{-v/2}-e^{-3v/2})1_{v\ge0},
$$
$$
\tau(v)=e^{-3v/2}T_{\rm same}(e^v)
 =\sum_{p,m\ge2}(m-1)(\log p)^2p^{-m/2}
                       \vartheta(v-m\log p)\ge0.
$$
Then the original readout is exactly
$$
\boxed{w_a(v):=e^{-3v/2}W(e^v)
       =\rho_*[L_0(a*a)-\tau](v).}
 \tag{4}
$$
All sums at a fixed age are finite.

The ordinary causal successor and its relative charge compensation are
$$
(Sa)(v)=\sqrt{\frac{x}{x+1}}a(\log(x+1)),\quad x=e^v,\qquad
 b=Ca=Sa-\kappa a_0,\quad a_0(v)=e^{-v/2}1_{v\ge0}.
$$
The established actual-source primitive theorem gives
$$
P(v)=\int_0^v[b(u)-a(u)]\,du,\quad P(0)=0,\quad P(v)>0\ (v>0),
$$
$$
P(v)=2\kappa e^{-v/2}
       +O(e^{-v/2-c_0\sqrt v}),\qquad
 0.2789<\kappa<0.279.
 \tag{5}
$$
These are unconditional inputs from the actual-source positivity proof
in [the full actual-source primitive proof](actual-source-successor-primitive.md).
They assert positivity of $P$, not of $P'$.

Define the comparison, using exactly the same $\tau$,
$$
w_b=\rho_*[L_0(b*b)-\tau],\qquad
 W_b(x)=x^{3/2}w_b(\log x).
 \tag{6}
$$
This does not redefine the original $W$. Since $b=a+P'$,
$$
\Delta w:=w_b-w_a
 =\rho_*L_0[a*P'+P'*a+P'*P'].
 \tag{7}
$$
The common same-prime term cancels in this difference only because it
is identical in (4) and (6). Both mixed source orders remain in (7).

## 2. A global upper envelope for the positive primitive

The quantitative input used below is
$$
\boxed{0<P(v)<\frac{93}{100}
 (e^{-v/2}-e^{-3v/2})\quad(v>0).}
 \tag{8}
$$
Here is the proof, including the bounded arithmetic part. Write
$F(x)=P(\log x)$. On $n<x<n+1$,
$$
F'(x)=
 \frac{x\Lambda(n+1)-\psi(n)-\kappa(x+1)}
      {x^{3/2}(x+1)}.
 \tag{9}
$$
Replace $\kappa$ by $\kappa_{\rm lo}=2789/10000$, keeping $F(1)=0$,
to obtain $F_{\rm up}$. Then
$$
F_{\rm up}(x)-F(x)=2(\kappa-\kappa_{\rm lo})(1-x^{-1/2})\ge0.
$$
On a cell with $\Lambda(n+1)=0$, its derivative is negative. Otherwise
the derivative numerator has positive slope, so its only possible
interior stationary point is a minimum. Thus the maximum on each cell
is attained at an endpoint. The multiplier $x^{3/2}/(x-1)$ also
attains its maximum at an endpoint of every cell in $[2,23]$;
its only positive interior critical point is a minimum at $x=3$.

The endpoint increments are exactly
$$
\begin{split}
 F_{\rm up}(n+1)-F_{\rm up}(n)
 ={}&2\psi(n+1)(\arctan\sqrt{n+1}-\arctan\sqrt n)\\
 &+2(\psi(n)+\kappa_{\rm lo})
             ((n+1)^{-1/2}-n^{-1/2}).
 \end{split}
 \tag{10}
$$
The [bounded envelope certificate](certificates/primitive-envelope-W-transform.py)
uses 192-bit Arb intervals and includes every prime-power arrival
through $23$. It proves all four endpoint products are below
$63/100$ on every cell $n=2,\ldots,22$. Consequently
$$
\frac{x^{3/2}F(x)}{x-1}<0.63\quad(2\le x\le23).
$$
For the first cell $0\le v<\log2$, including the right derivative at zero and the left derivative limit at $\log2$, (9) gives
$$
P'(v)\le\frac{\log2}{2}-\frac{\kappa_{\rm lo}}{\sqrt2}<0.15,
 \qquad
 e^{-v/2}(1-e^{-v})\ge\frac{v}{2\sqrt2}.
$$
The envelope ratio there is below $0.3\sqrt2<0.43$. Continuity of the primitive extends this integrated bound to $v=\log2$. The right derivative at that endpoint includes the shifted birth at $3$ and is not bounded by the first-cell derivative estimate.

For $x\ge23$, the already proved equal-mass error-kernel estimate is
$$
\left|P(\log x)-\frac{2\kappa}{\sqrt x}\right|
 <\frac{2\epsilon}{\sqrt x}
 \quad\hbox{if }|E(y)|\le\epsilon y\quad(y\ge x).
$$
[Trudgian's unconditional Theorem 1](https://arxiv.org/pdf/1401.2689)
supplies the decreasing relative error at $23$:
$$
\epsilon_{23}=\sqrt{\frac8{17\pi}}\,z^{1/2}e^{-z},
 \qquad z=\sqrt{\frac{\log23}{6.455}}.
$$
The same interval certificate proves
$$
\sqrt x P(\log x)<2\kappa+2\epsilon_{23}<0.88
 <0.93\,\frac{22}{23}\le0.93(1-1/x).
$$
This establishes (8) for all ages, rather than extrapolating a finite
calculation.

## 3. Exact transforms and a strict real comparison

For almost every $x\in(n,n+1)$, the literal successor gives
$$
d(\log x):=P'(\log x)
 =x^{-1/2}
 \left[\Lambda(n+1)-\frac{\psi(n+1)}{x+1}-\kappa\right].
 \tag{11}
$$
Chebyshev's bound and $\Lambda(n)\le\log n$ imply
$$
|d(v)|\le C(1+v)e^{-v/2}.
$$
Thus
$$
\Gamma(s):=\mathcal L_d(s)=s\mathcal L_P(s)
$$
is holomorphic for $\Re s>-1/2$. Integration by parts retains
$$
\Gamma(0)=0,\qquad \Gamma'(0)=\int_0^\infty P(v)\,dv=:M>0.
 \tag{12}
$$
The identities are convergent integrals on the stated domain.

An exact series used again below is
$$
\boxed{\Gamma(s)=T(s+1/2)-\frac{\kappa}{s+1/2},\quad
 T(z)=\sum_{j\ge1}\frac{(z)_j}{j!}\frac{D(z+j)}{z+j}.}
 \tag{13}
$$
To derive it, the two continuous baseline terms in $(S-I)a$ cancel.
After $y=x+1$, its transform is
$$
\int_2^\infty \psi(y)y^{-z-1}
       [(1-1/y)^{-z}-1]\,dy.
$$
Expand the bracket in its binomial series and use
$\int_1^\infty\psi(y)y^{-w-1}dy=D(w)/w$.
The expansion is locally normally convergent for $\Re z>0$:
the large-$j$ von Mangoldt tails decrease geometrically, while
the Pochhammer coefficients grow at most polynomially on compact
sets. This proves (13) on the full domain needed here.

The envelope gives, for every real $s>0$,
$$
0<\Gamma(s)<
 \frac{0.93s}{(s+1/2)(s+3/2)}
 <\frac1{s+1/2}.
 \tag{14}
$$
For real $z>1$, the elementary inequality
$D(z)<1/(z-1)$ can be proved directly. Give the positive integers
the probability $\Pr(N=n)=n^{-z}/\zeta(z)$. For $m\ge2$,
group $n\ge m$ into blocks $mk,\ldots,mk+m-1$, obtaining
$\Pr(N\ge m)<m^{1-z}$. The tail integral for $\log N$ then gives
$\mathbb E\log N<1/(z-1)$, which is the asserted inequality.
Hence
$$
A(s)<-\frac1{s+1/2}\qquad(s>1/2).
 \tag{15}
$$
At $s=1/2$, unconditional PNT makes
$\int e^{-v/2}|a(v)|\,dv$ finite. The actual integral equals the
filled Laurent value $A(1/2)=-1-\gamma<-1$.
The individual divergent terms in the formula for $A$ have
not been integrated separately at this endpoint.

Since $B(s):=\mathcal L_b(s)=A(s)+\Gamma(s)$, (14)--(15) give
$$
A(s)<B(s)<0\quad(s\ge1/2).
$$
Let $J(s)=(s+1/2)/(s+3/2)$. Then the exact difference (7) has
$$
\mathcal L_{\Delta w}(s)
 =\zeta(s+1)J(s)\Gamma(s)[2A(s)+\Gamma(s)]
 <-\frac{\zeta(s+1)}{s+3/2}\Gamma(s)<0
 \quad(s\ge1/2).
 \tag{16}
$$
All transforms in (16) converge absolutely even at $s=1/2$.
Weighted $a,b$ are in $L^1$, the aggregation has finite weighted
mass $\zeta(3/2)$, and
$$
\mathcal L_\tau(s)=
 \frac{Q_{\rm same}(s+1/2)}{(s+1/2)(s+3/2)},\quad
 Q_{\rm same}(z)=\sum_p\frac{(\log p)^2}{(p^z-1)^2}
$$
is finite there. This is a comparison of actual convergent averages.

## 4. A finite-window signed comparison from the factorial identity

The next argument strengthens (16) without adding an arithmetic
smoothing measure. Tilt the sources:
$$
\alpha(v)=e^{-v/2}a(v)=\frac{\psi(e^v)}{e^v}-1,\qquad
 \beta(v)=e^{-v/2}b(v).
$$
Let $A_0(v)=\int_0^v\alpha$ and $B_0(v)=\int_0^v\beta$.
For real $x\ge1$, $m=\lfloor x\rfloor$,
$$
A_0(\log x)=\sum_{n\le x}\frac{\Lambda(n)}n-
                      \frac{\psi(x)}x-\log x.
$$
Using $\log(m!)=\sum_{n\le x}\Lambda(n)\lfloor x/n\rfloor$
gives the exact nonnegative representation
$$
\boxed{-xA_0(\log x)=x\log x-\log(m!)
       +\sum_{n\le x}\Lambda(n)(1-\{x/n\}).}
 \tag{17}
$$
It holds also at noninteger $x$. All terms on the right are
nonnegative, and the first is strictly positive for $x>1$.
Thus $A_0(v)<0$ for every $v>0$.

More quantitatively,
$$
A_0(v)=-v\quad(0\le v\le\log2),\qquad
 A_0(v)\le-\frac{\log2}{2}\quad(v\ge\log2).
 \tag{18}
$$
For the latter assertion, discard the final sum in (17). The bound
$\log(m!)/x-\log x$ decreases on each cell, so its maximum is at
$x=m$. For $m=2$ it is $-\log2/2$; for $m\ge3$, AM--GM gives
$$
\log m-\frac{\log(m!)}m
 \ge\log\frac{2m}{m+1}\ge\log\frac32>\frac{\log2}{2}.
$$

Put $p(v)=e^{-v/2}P(v)$. The cumulative successor increment is
$$
D_0(v):=B_0(v)-A_0(v)
 =p(v)+\frac12\int_0^vp(u)\,du>0.
 \tag{19}
$$
By (8), with $r=e^{-v}$,
$$
D_0(v)\le0.93\left(\frac14+\frac r2-\frac{3r^2}4\right)
 \le0.93\min\{v,1/3,1-e^{-v}\}.
$$
The quadratic has maximum $1/3$; its derivative as a function of
$v$ is at most $1$, and it vanishes at zero. Equations
(18)--(19) show
$$
B_0(v)\le-0.07v<0\quad(0<v\le\log2),
$$
$$
B_0(v)\le-\frac{\log2}{2}+0.31<0\quad(v\ge\log2).
$$
Therefore
$$
\boxed{A_0(v)<B_0(v)<0\qquad(v>0).}
 \tag{20}
$$

Let $U=-A_0$, $V=-B_0$. Then $U>V>0$ on positive ages,
and both vanish at zero. The continuous positive function
$$
Q=U*U-V*V=(U-V)*(U+V)>0
$$
satisfies, with whole-line causal derivatives,
$$
\alpha*\alpha-\beta*\beta=Q''.
 \tag{21}
$$
There is no initial atom in $\alpha=-U'$ or $\beta=-V'$.
Tilting the exact $W$ difference yields
$$
Z(v):=e^{-v/2}(w_a-w_b)(v)
 =\rho_{3/2}*(I-k_2*)Q'',
$$
$$
\rho_{3/2}=\sum_{d\ge1}d^{-3/2}\delta_{\log d},
 \qquad k_2(v)=e^{-2v}1_{v\ge0}.
$$
If $\mathcal I$ denotes causal integration, the once-integrated
filter has the positive kernel
$$
K_0(v)=1-\int_0^ve^{-2u}du
       =\frac{1+e^{-2v}}2\quad(v\ge0).
$$
Consequently
$$
\boxed{\mathcal I^3 Z=\rho_{3/2}*K_0*Q>0\quad(v>0).}
 \tag{22}
$$
All convolutions here need only local absolute integrability.
The $d=1$ atom and strict positivity of $Q$ give strictness
at every positive age. Changing variables $y=e^t$ in
$\mathcal I^3Z(v)=\tfrac12\int_0^v(v-t)^2Z(t)dt$
proves (1).

This argument uses the actual filter rather than assuming it preserves
pointwise order. The additional integration that produces $K_0$
is essential. The result does not imply a sign for the unintegrated
difference.

## 5. A certified pole proves that the unsmoothed difference oscillates

The right side of (16) continues meromorphically to $\Re s>-1/2$
and is analytic at every real point of that interval. The apparent
pole of $A$ at $s=1/2$ is removable. At $s=0$,
$\Gamma(s)=Ms+O(s^2)$ cancels the pole of $\zeta(s+1)$.
Its value there is $(2/3)A(0)M$, a continuation value, not an
assertion of an unweighted convergent integral.

At a critical-line zero $\rho=1/2+i\gamma_0$ of any multiplicity
$m\ge1$, the possible residue is
$$
\operatorname{Res}_{s=i\gamma_0}\mathcal L_{\Delta w}(s)
 =-\frac{2m\,\zeta(1+i\gamma_0)}{3/2+i\gamma_0}
                    \Gamma(i\gamma_0).
 \tag{23}
$$
Only one nonzero residue is needed. Its nonvanishing is established
by [the runnable interval certificate](certificates/successor-W-difference-zero.py),
using 256-bit Arb/Acb arithmetic and no zero-location oracle.

Take the exact rational heights
$$
t_-=14.13472514173469379045,\qquad
 t_+=14.13472514173469379046.
$$
The [completed zeta function and its reflection identity](https://dlmf.nist.gov/25.4)
show that
$\xi(1/2+it)=\tfrac12 z(z-1)\pi^{-z/2}\Gamma_{\rm Euler}(z/2)\zeta(z)$,
$z=1/2+it$, is exactly real for real $t$. The certificate proves
$$
\xi(1/2+it_-)>10^{-23},\qquad
 \xi(1/2+it_+)<-3\cdot10^{-24}.
$$
Continuity supplies an actual critical-line zero with height
$\gamma_0\in(t_-,t_+)$. The other factors defining $\xi$ do not
vanish in this bracket. No simplicity or uniqueness is assumed.

Evaluate (13) throughout the entire height bracket through $j=256$.
Writing $c_j=(\rho)_j/j!$, for $j\ge256$,
$$
|c_{j+1}/c_j|=|\rho+j|/(j+1)\le1
$$
because $14<\Im\rho<15$. For $\sigma\ge256+1/2$, the decreasing
function integral estimate gives
$$
D(\sigma)\le\sum_{n\ge2}(\log n)n^{-\sigma}
 \le2^{-\sigma}\left[\log2+
       \frac{2\log2}{\sigma-1}+\frac2{(\sigma-1)^2}\right]
 <2\cdot2^{-\sigma}.
$$
Thus the entire omitted tail is bounded by
$$
\left|\sum_{j>256}c_j\frac{D(\rho+j)}{\rho+j}\right|
 \le \frac{2|c_{256}|}{256+1/2}\,2^{-256-1/2}<10^{-70}.
 \tag{24}
$$
The evaluator uses actual zeta Taylor coefficients to enclose the
logarithmic derivatives, equivalently their absolutely convergent
full von Mangoldt series. With only the accepted coarse interval
$0.2789<\kappa<0.279$, it proves throughout the bracket
$$
-0.125<\Re\Gamma(i\gamma_0)<-0.124,\qquad
 -0.186<\Im\Gamma(i\gamma_0)<-0.184,
$$
$$
0.323<\Re\zeta(1+i\gamma_0)<0.325,
$$
$$
0.0095<
 \Re\left[-\frac{2\zeta(1+i\gamma_0)\Gamma(i\gamma_0)}
                       {3/2+i\gamma_0}\right]<0.0097.
 \tag{25}
$$
The unknown positive multiplicity multiplies this nonzero quantity,
so (23) is a genuine pole.

Suppose now that $\Delta w$ had either sign beyond some finite age.
Its absolute tail would be a nonnegative locally integrable function
with Laplace convergence abscissa $b\in[0,1/2]$. Absolute convergence
at $1/2$ gives the upper bound. An abscissa below zero would give a
holomorphic integral on a half-plane containing the pole (23), which
is impossible by uniqueness of continuation.

The elementary nonnegative-tail Laplace singularity argument now
contradicts analyticity at the real point $b$. To see it directly,
take an analytic disk about $b$, choose $c=b+\varepsilon$ close
enough to $b$, and expand leftward to $c-2\varepsilon$. The
Taylor terms for a nonnegative tail $q$ are
$$
\frac{(2\varepsilon)^j}{j!}
        \int_0^\infty v^j e^{-cv}q(v)\,dv\ge0.
$$
Analyticity makes their sum finite. Tonelli identifies it with the
Laplace integral at $b-\varepsilon$, contradicting the definition
of the abscissa.

The functions in (7) are continuous: the source convolutions are
continuous and vanish at zero, and aggregation is locally finite.
It follows that
$$
\boxed{\text{for every }V,\text{ there are }v_+,v_->V
       \text{ with }\Delta w(v_+)>0,\quad\Delta w(v_-)<0.}
 \tag{26}
$$
Multiplication by $e^{3v/2}>0$ gives the same assertion for
$W_b-W$. This rules out either eventual pointwise ordering of the
two comparisons while preserving the finite-window inequality (1).

## 6. The unchanged RH obstruction and the exact remaining terms

For any nontrivial zero $\rho$ of multiplicity $m$, $A$ and
$B=A+\Gamma$ have the same residue $-m/\rho$ at
$s_\rho=\rho-1/2$. The correction is analytic there.
If $\Re\rho>1/2$, the same-prime transform is analytic there and
$\zeta(\rho+1/2)\ne0$ by its Euler product. Hence
$$
\boxed{[(s-s_\rho)^{-2}]\mathcal L_{w_a}
       =[(s-s_\rho)^{-2}]\mathcal L_{w_b}
       =\frac{m^2\zeta(\rho+1/2)}{\rho(\rho+1)}\ne0.}
 \tag{27}
$$
The difference has at most a simple pole at the same location,
with residue
$$
-\frac{2m\zeta(\rho+1/2)}{\rho+1}\Gamma(s_\rho).
$$
This residue may vanish at other zeros; the argument above certifies
only the one actually needed for (26).

The literal signed remainder can also be displayed without concealing
the source-density cancellation. Put
$$
e_s(v)=Sa(v),\quad b_0=\frac{\log2}{2}-1-\kappa,\quad
 \nu_{\rm succ}=\sum_{n\ge3}\Lambda(n)\frac{\sqrt{n-1}}n
                                      \delta_{\log(n-1)},
$$
$$
h(v)=\frac{e^{3v/2}}{1+e^v},\quad Z_{\rm succ}=\nu_{\rm succ}-h(v)\,dv,
$$
$$
\eta_c(v)=
 \left(-\frac32+\frac1{1+e^v}\right)e_s(v)
 +\frac32(k*e_s)(v)+\frac32\kappa k(v).
$$
Whole-line distributional differentiation gives
$$
L_0b'=b_0\delta_0+Z_{\rm succ}+\eta_c(v)\,dv .
$$
Prime two belongs to $b_0$; it is not also inserted into
$\nu_{\rm succ}$. The complete substitution in (4) is
$$
\begin{split}
 w_a=\rho_*[\, &L_0(b*b)+L_0(P'*P')-2b_0P\\
 &-P*Z_{\rm succ}-Z_{\rm succ}*P
 -P*\eta_c-\eta_c*P-\tau\,].
 \end{split}
 \tag{28}
$$
This identity keeps all mixed terms. If $\nu_{\rm succ}$ is considered
alone, positivity of $P$ produces the negative term
$-2P*\nu_{\rm succ}$. Its leading density contribution cancels
exactly with $+2P*h$ from the continuous term. Keeping just the
negative contribution would omit part of the actual expression.

Indeed the centered mixed term itself has a positive, absolutely
convergent weighted integral:
$$
\int_0^\infty e^{-v/2}
 [-P*Z_{\rm succ}-Z_{\rm succ}*P](v)\,dv
 =2\left(\gamma-\frac{\log2}{2}\right)\mathcal L_P(1/2)>0.
 \tag{29}
$$
One obtains (29) by partial summation at finite cutoffs:
$$
\int_{[0,V]}e^{-v/2}Z_{\rm succ}(dv)
 =\sum_{n\le e^V+1}\frac{\Lambda(n)}n-\log(e^V+1)
                  +\frac{\log2}{2}
 \longrightarrow-\gamma+\frac{\log2}{2}.
$$
The cumulative of $Z_{\rm succ}$, after multiplication by
$e^{-v/2}$, is in $L^1$ by PNT. The identity
$P*Z_{\rm succ}=P'*[Z_{\rm succ}([0,\cdot])]$ and weighted Young
justify absolute convergence and the convolution limit. The separate
weighted masses of $\nu_{\rm succ}$ and $h\,dv$ are infinite,
so their limiting integrals cannot be split before cancellation.
Aggregation multiplies (29) by $\zeta(3/2)$.

Equations (1), (26), (27), and (28) are simultaneous constraints on
the same actual arithmetic construction. A proof of the required
eventual sign must control the full remaining reflected product and
its signed interactions. Neither the positive primitive nor its
proved cumulative comparison supplies that final estimate.


The source product and same-prime subtraction use the [complete arithmetic W identity](prime-allocation-critical-identity.md). The finite-window proof uses the exact factorial divisor count and causal integration. The oscillation proof is the classical nonnegative-tail Laplace singularity argument, written out above, applied to a certified actual zeta pole. These methods and the explicit PNT input are retained without a priority claim. The comparison does not establish the eventual W sign.


## Formalized actual tilted first moment

[TiltedPrimeCumulative](BuildingBlocks/TiltedPrimeCumulative.lean) and [TiltedPrimeIntegral](BuildingBlocks/TiltedPrimeIntegral.lean) formalize the actual first-moment input to the cumulative comparison. They reuse the repository's exact `psi`, `logFactorial` and `logarithmicPrimeMass` definitions, the formal factorial/prime-power double count, and mathlib's classical Abel summation. No PNT or RH hypothesis is present.

In namespace `BuildingBlocks.TiltedPrimeCumulative`, `cumulative_factorial_identity` proves for every real $x>0$ the exact formula

$$
-xC(x)=x\log x-\log(\lfloor x\rfloor!)
 +\sum_{1\le n\le\lfloor x\rfloor}\Lambda(n)
 \left[1-\left(\frac xn-\left\lfloor\frac{\lfloor x\rfloor}{n}\right\rfloor\right)\right],
$$

where $C(x)=\sum_{n\le\lfloor x\rfloor}\Lambda(n)/n-\psi(\lfloor x\rfloor)/x-\log x$. Every remainder term is nonnegative. Theorems `cumulative_neg` and `cumulative_le_neg_log_two_half` prove $C(x)<0$ for $x>1$ and $C(x)\le-\log2/2$ for $x\ge2$, including noninteger cutoffs.

In namespace `BuildingBlocks.TiltedPrimeIntegral`, `prime_error_intervalIntegrable` and `prime_error_integral_eq` prove the literal finite-interval integrability and identity

$$
\int_1^x\frac{\psi(\lfloor t\rfloor)-t}{t^2}\,dt=C(x),\qquad x\ge1.
$$

Theorems `prime_error_integral_neg` and `prime_error_integral_le_neg_log_two_half` transfer both signed consequences to this actual integral. The integrated modules and their primary axiom checks passed, with only `propext`, `Classical.choice` and `Quot.sound`.

This formalizes a concrete arithmetic dependency of the written cumulative W proof. The $0.93$ primitive envelope, the full convolution comparison, its oscillation certificate and its analytic continuation remain written or computer-assisted results. The modules prove no eventual W sign.

The [second-successor extension](second-successor-tilted-order.md) gives a strict three-source cumulative chain. The [complete geometric average](actual-successor-resolvent-primitive-order.md) gives a further small-parameter cumulative comparison. Neither establishes pointwise W order; arbitrary-iterate primitive positivity is refuted by the [fifth-stage certificate](actual-successor-fifth-primitive-failure.md).
