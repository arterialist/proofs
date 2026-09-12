# Two cancelled logarithmic moments of the actual division kernel

Let $K$ be the explicit signed kernel in
[the successor scaling theorem](successor-feedback-kernel-scaling.md), and set
$$
L(t)=\sum_{k\ge1}\mu(k)K(kt),\qquad t>0.
\tag{1}
$$
This is the leading scaling kernel for the actual division weights
$\varphi_r(m)=\sum_{k\ge1}\mu(k)W_r(km)$.
We prove, unconditionally,
$$
\boxed{\int_0^\infty L(t)\,dt=0,\qquad
\int_0^\infty L(t)\log t\,dt=0,\qquad
\int_0^\infty L(t)(\log t)^2dt=\pi^{3/2}.}
\tag{2}
$$
All three integrals converge absolutely. These identities force positive,
negative, then positive values of this specific arithmetic kernel at
three increasing arguments. The same ordered signs occur in the actual
division weights at states proportional to $(1-r)^{-1}$.
They do not determine the sign of their complete logarithmic readout.

## Convergence with every division history retained

The scaling theorem proves
$$
K(t)=O(t^{-1/2})\quad(t\downarrow0),\qquad
K(t)=\frac1{6t^{3/2}}+O(t^{-5/2})\quad(t\to\infty),
$$
$$
tK'(t)=-b(t)/2,
\quad b(t)=O(t^{-1/2})\ (t\downarrow0),
\quad b(t)=O(t^{-3/2})\ (t\to\infty).
\tag{3}
$$
Consequently (1) is absolutely and locally uniformly convergent on
$(0,\infty)$, and $L$ is continuous. Its tail is already positive:
$$
L(t)=\frac1{6\zeta(3/2)t^{3/2}}+O(t^{-5/2}).
\tag{4}
$$
The ordinary Euler product justifies the leading coefficient, and
$\sum k^{-5/2}<\infty$ controls the remainder without any sign
assumption on $\mu$.

To pass integrals through the complete division limit, write
$M_\mu(x)=\sum_{k\le x}\mu(k)$. We use the classical unconditional
estimate
$$
|M_\mu(x)|\le Cx e^{-c\sqrt{\log x}}\qquad(x\ge2)
\tag{5}
$$
for some positive constants. A primary explicit version, with an extra
factor $\log x$, is Lee and Leong, Theorem 1.1, equation (9), in
[arXiv:2208.06141v5](https://arxiv.org/pdf/2208.06141v5).
Reducing the positive exponential constant absorbs that factor; increasing
$C$ covers the finite initial range. No numerical constant or verified
zero height from their theorem is needed here.

For an integer $N\ge1$, ordinary Abel summation gives the exact tail
$$
L(t)-\sum_{k\le N}\mu(k)K(kt)
=-M_\mu(N)K(Nt)-t\int_N^\infty M_\mu(x)K'(xt)\,dx.
\tag{6}
$$
The endpoint at infinity vanishes by (3), even with the elementary
bound $|M_\mu(x)|\le x$. For any fixed nonnegative integer $q$,
the integrals of $|K(t)|(1+|\log t|^q)$ and
$t|K'(t)|(1+|\log t|^q)$ are finite. Substitution in (6) therefore gives
$$
\begin{split}
&\int_0^\infty\left|L(t)-\sum_{k\le N}\mu(k)K(kt)\right|
 (1+|\log t|^q)\,dt\\
&\qquad\le C_q\left[
\frac{|M_\mu(N)|}{N}(1+\log^q N)
+\int_N^\infty\frac{|M_\mu(x)|}{x^2}(1+\log^q x)\,dx\right]
\longrightarrow0.
\end{split}
\tag{7}
$$
Here the limit follows from (5). This proves the required weighted
$L^1$ convergence. In particular it avoids an invalid absolute
interchange using the divergent series $\sum |\mu(k)|/k$.

## The two cancellations and the first surviving moment

Put $J_q=\int_0^\infty K(t)(\log t)^qdt$. The exact kernel calculation
gives $J_0=0$ and $J_1=\pi^{3/2}/2$; $J_2$ is finite by (3).
For a finite division sum, substitution $u=kt$ gives
$$
\int\sum_{k\le N}\mu(k)K(kt)\,dt
=J_0\sum_{k\le N}\frac{\mu(k)}k=0,
$$
$$
\int\sum_{k\le N}\mu(k)K(kt)\log t\,dt
=J_1\sum_{k\le N}\frac{\mu(k)}k,
$$
$$
\int\sum_{k\le N}\mu(k)K(kt)(\log t)^2dt
=J_2\sum_{k\le N}\frac{\mu(k)}k
-2J_1\sum_{k\le N}\frac{\mu(k)\log k}{k}.
\tag{8}
$$
All integrals in (8) are over $(0,\infty)$.
Estimate (5) ensures convergence of both series at their boundary and
continuity there from real $s>1$. The Euler product identities and
the residue-one pole of $\zeta$ at one give
$$
\sum_{k\ge1}\frac{\mu(k)}k=0,\qquad
\sum_{k\ge1}\frac{\mu(k)\log k}{k}=-1.
\tag{9}
$$
Indeed they are respectively the boundary values of
$1/\zeta(s)$ and $-(1/\zeta)'(s)$, while
$1/\zeta(s)=(s-1)+O((s-1)^2)$.
Taking limits in (8) using (7) proves (2).

## A signed shape forced by actual division inversion

By (4), $L$ is strictly positive for all sufficiently large $t$.
Since its integral is zero, it is negative somewhere. Suppose it had
only the arrangement of a nonpositive initial interval followed by a
nonnegative final interval, separated at some $a>0$. Then
$$
L(t)(\log t-\log a)\ge0
$$
everywhere, with strict positivity on an open part of the positive
tail. Its integral would be positive, contrary to the first two
equalities in (2). More generally, if no positive value preceded a
negative value, such a separator would exist. Hence there are
$$
0<t_1<t_2<t_3,\qquad L(t_1)>0,\quad L(t_2)<0,\quad L(t_3)>0.
\tag{10}
$$
This conclusion concerns the actual Möbius-inverted kernel, not an
arbitrary signed test function.

There is a compatible positive family that retains both cancellations.
For every fixed $0<\eta<1/2$,
$$
\boxed{\int_0^\infty L(t)[t^\eta-1-\eta\log t]\,dt
=\frac{\sqrt\pi\,\Gamma(1+\eta)\tan(\pi\eta)}
{2(1+\eta)\zeta(1+\eta)}>0.}
$$
Indeed integration of $K'=-b/(2t)$ against $t^{1+\eta}$
gives the numerator divided by $2(1+\eta)$; the absolute division
sum in this range multiplies it by $1/\zeta(1+\eta)$.
The two removed terms vanish by (2).
The [direct integral proof below](#direct-beta-integral-proof-of-the-positive-power-pairing)
also proves the exact Mellin evaluation without analytic continuation.
This comparison extends to nonnegative mixtures of these weights
when integrable, but makes no assertion for arbitrary convex functions
of $\log t$, or for the cancelled affine logarithm itself.

The global coefficient error in the scaling theorem, summed absolutely
over multiples of $m$, also proves
$$
\frac{\varphi_{1-h}(m)}{\sqrt h}
=L(hm)-\sqrt h\sum_{k\ge1}\mu(k)E_1(hmk)+O_{a,b}(h)
=L(hm)+O_{a,b}(\sqrt h)
\tag{11}
$$
uniformly for integers $m\ge2$ with $a\le hm\le b$, where
$0<a<b<\infty$. The sum of $E_1(hmk)$ is uniformly absolutely
bounded on such a compact interval. Its signed contribution has been
retained before taking this error estimate.

Choose $m_i(h)=\lfloor t_i/h\rfloor$. For all sufficiently small
$h>0$, these are ordered nonterminal states and (10)--(11) give
$$
\varphi_{1-h}(m_1(h))>0,\qquad
\varphi_{1-h}(m_2(h))<0,\qquad
\varphi_{1-h}(m_3(h))>0.
\tag{12}
$$
Thus a single threshold separating negative and positive division
weights cannot describe this boundary regime. The exact feedback
$\sum_{m\ge2}\varphi_r(m)\log m$ still combines every state and
retains the causal endpoint correction. Its eventual sign remains open.

## Direct beta-integral proof of the positive power pairing


Recall $K'=-b/(2t)$, where
$$
 b(t)=\int_0^\infty e^{-x}
 [\mathbf1_{t>x}(t-x)^{-1/2}-t^{-1/2}]\,dx.
$$
The cumulative of the expression in brackets is
$2\sqrt{(t-x)_+}-2\sqrt t$. For $0<\eta<1/2$,
integration by parts and positive Tonelli therefore give
$$
 \begin{aligned}
 \int_0^\infty
 [\mathbf1_{t>x}(t-x)^{-1/2}-t^{-1/2}]t^\eta\,dt
 &=2\eta\int_0^\infty
 [\sqrt t-\sqrt{(t-x)_+}]t^{\eta-1}\,dt\\
 &=\frac{\eta x^{\eta+1/2}}{\eta+1/2}
 B(1/2,1/2-\eta).
 \end{aligned}
 \tag{A3}
$$
For the last equality write the square-root difference as
$\frac12\int_0^{\min(t,x)}(t-u)^{-1/2}du$.
Averaging (A3) against $e^{-x}dx$, and using the gamma reflection
identity, gives
$$
 \int_0^\infty b(t)t^\eta\,dt
 =\sqrt\pi\,\Gamma(1+\eta)\tan(\pi\eta).
 \tag{A4}
$$
All signed integrals are absolute in this range. Integrating $K'$
once more yields
$$
 \int_0^\infty K(t)t^\eta\,dt
 =\frac{\sqrt\pi\,\Gamma(1+\eta)\tan(\pi\eta)}
 {2(1+\eta)}.
 \tag{A5}
$$
Now $\sum|\mu(k)|k^{-1-\eta}<\infty$. Thus the full division
sum in this power moment is an absolute exchange, and the Euler
product divides (A5) by $\zeta(1+\eta)$. The two already proved
logarithmic cancellations give the displayed positive pairing with $t^\eta-1-\eta\log t$.


Here $L(t)$ equals $J(t)$ in [the linear exterior proof](successor-feedback-linear-inverse-core.md), rather than that chapter's separate endpoint sum. The weighted-$L^1$ limit above is the step that permits the logarithmic cancellations at the Euler-product boundary.

This chapter contains written proofs and applications of the stated classical inputs. No Lean formalization of its scaling, moment or signed-core conclusion is asserted, and no unconditional boundary sign for the actual feedback is claimed.

The [complete discrete comparison](successor-division-curved-log-comparison.md) proves the actual weighted integer limit from this beta integral, with fixed-exponent scope. The [two-order cancellation proof](successor-division-two-order-cancellation.md) computes the separate endpoint kernel moments and the exact logarithmic seed defect.
