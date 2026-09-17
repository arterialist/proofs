# A signed frequency-transport bound for the actual counterphase

This is a written theorem, with conventions and finite trace domains fixed in the [semilocal foundation](semilocal-weighted-scattering.md). It is not a Lean formalization.

This note proves a collective weighted trace-norm bound after canceling the first-prime continuum density. It uses the stable counterfactor of section 6 of [continuum scattering counterphase](continuum-scattering-counterphase.md). Every proper prime power remains in the actual multiplier. The estimate gives unconditional $o(\sqrt X)$ growth for each fixed Schwartz observation. It does not give a sign for the actual Weil form.

Write
$$
N_\chi(U)=\|M_\chi\Delta(U)\|_{\mathcal S_1},\qquad
\Delta(U)=P-U^*PU,
$$
where $\chi\in\mathcal S(\mathbb R)$. The constants below depend on finitely many Schwartz seminorms of $\chi$. They are consequently uniform over a family bounded in those seminorms.

## 1. Weighted intervals and frequency increments

Let $E_a=M_{e^{iat}}$, and let $\Pi_I$ be the physical-frequency interval projection for an interval $I$ of length $\ell$. Uniformly in the position of $I$,
$$
\boxed{\|M_\chi\Pi_I\|_{\mathcal S_1}
 \le C_\chi(\sqrt\ell+\ell).}
\tag{1}
$$
For $0<\ell\le1$, translate the interval center to zero. This conjugation is by a modulation and commutes with $M_\chi$. In mixed Mellin/physical coordinates the operator has kernel
$\chi(t)e^{it\xi}/\sqrt{2\pi}$, with $\xi\in I\subset[-1/2,1/2]$. Applying $L_t=1+t^2-\partial_t^2$ in the output variable gives Hilbert-Schmidt norm at most
$$
\frac{\sqrt\ell}{\sqrt{2\pi}}
\left(\|(1+t^2)\chi-\chi''\|_2
 +\|\chi'\|_2+\tfrac14\|\chi\|_2\right).
$$
Since $\|L_t^{-1}\|_{\mathcal S_2}=\pi/\sqrt{24}$, factoring through $L_t^{-1}$ proves (1) for small intervals. Splitting a longer interval into at most $\lceil\ell\rceil$ pieces proves the general bound. This proof includes ordinary trace class; it does not differentiate interval projections.

Put $H(a)=[P,M_{\sin(at)}]$. For every $A\ge1$ and $0\le a,b\le A$,
$$
\boxed{
\|M_\chi[H(a)-H(b)]\|_{\mathcal S_1}
\le C_\chi\{\sqrt{|a-b|}+(1+A)|a-b|\}.}
\tag{2}
$$
Here and below constants may be enlarged by an absolute factor. To prove (2), first use the exact identity
$[P,E_a]=E_a(E_a^*PE_a-P)$. The projection difference is a signed physical interval projection of length $|a|$. For $a,b$ of the same sign its intervals are nested. Subtraction gives one narrow interval of length $\delta=|a-b|$, plus a multiplier $e^{i(a-b)t}-1$ multiplying the interval of length $|b|$. The first term is bounded by (1). For $\delta\le1$, the finite seminorms used in (1), applied to $\chi(t)(e^{i\delta t}-1)$, are bounded by $C_\chi\delta$. This follows by differentiating at most twice and using $|e^{i\delta t}-1|\le\delta|t|$. Thus the second term is bounded by $C_\chi\delta(\sqrt b+b)$. Apply the same argument to the negative exponent and divide their difference by $2i$. For $\delta>1$, the triangle bound from (1) is absorbed by the right side of (2). In particular
$$
\|M_\chi H(a)\|_{\mathcal S_1}
 \le C_\chi(\sqrt a+a),\qquad a\ge0.
\tag{3}
$$
The square-root term is not replaceable by an unproved derivative of the moving projection. This is why the following argument uses a transport coupling.

## 2. An exact finite-measure coupling, with its endpoint mass

Let $\mu,\lambda$ be finite positive measures supported in $[a_0,A]$, where $a_0>0$. Put
$$
D(a)=\mu([a_0,a])-\lambda([a_0,a]),\quad
M=\max(\mu([a_0,A]),\lambda([a_0,A])),\quad
J=\int_{a_0}^A|D(a)|da.
$$
Add the missing total mass to the smaller measure at the endpoint $A$, and call the resulting equal-mass measures $\widetilde\mu,\widetilde\lambda$. Their monotone quantile coupling $\pi$ has total mass $M$ and obeys
$$
\int|a-b|\,\pi(da,db)=J.
\tag{4}
$$
For example, (4) follows by writing $|a-b|=\int|1_{a\le t}-1_{b\le t}|dt$. Monotone quantiles make the inner indicators nested, so integration over their common mass parameter gives the absolute difference of the cumulative distributions. The endpoint augmentation leaves the original cumulative difference unchanged for $t<A$.

The exact signed operator identity is
$$
\int H(a)(\mu-\lambda)(da)
 =D(A)H(A)+\int[H(a)-H(b)]\pi(da,db).
\tag{5}
$$
The endpoint term is present even when $A$ is an actual atom location. In particular the mass of a prime at the cutoff is never discarded. All integrals in (5) are Bochner integrals after multiplication by $M_\chi$, by (2).

Equations (2)–(5), followed by Cauchy-Schwarz with respect to $\pi$, give
$$
\boxed{
\left\|M_\chi\int H(a)(\mu-\lambda)(da)\right\|_{\mathcal S_1}
\le C_\chi\left[
 |D(A)|(A+\sqrt A)+\sqrt{MJ}+(1+A)J
\right].}
\tag{6}
$$
This estimates the signed measure collectively. It does not sum the separate norms of the two positive measures.

## 3. Passing from a signed phase to its actual unitary

For a bounded real phase $\theta$ with $M_\chi[P,M_\theta]$ trace class, differentiation in the parameter $s$ gives
$$
\Delta(e^{i\theta})
 =-i\int_0^1e^{-is\theta}[P,M_\theta]e^{is\theta}ds.
$$
The bounded multiplication operators depend continuously in operator norm on $s$, so this is also a weighted trace-class Bochner identity. Since $M_\chi$ commutes with them,
$$
\boxed{N_\chi(e^{i\theta})
 \le\|M_\chi[P,M_\theta]\|_{\mathcal S_1}.}
\tag{7}
$$
The bounded phases below satisfy this hypothesis by (3), (6), and absolutely convergent prime-power sums.

For commuting scalar multipliers, the exact conjugated cocycle also gives
$$
N_\chi(UV)\le N_\chi(U)+N_\chi(V).
\tag{8}
$$
We use (8) only after the large first-prime density has canceled inside one signed phase. Applying it separately to the original prime factor and its continuum counterfactor would lose (6).

## 4. The actual first primes, the fixed origin factor, and every proper power

Let $X\ge e$, $A=\log X$, and $a_0=\log2$. Use the actual measures
$$
\mu_X=\sum_{p\le X}p^{-1/2}\delta_{\log p},\qquad
\lambda_X(da)=1_{[a_0,A]}(a)\frac{e^{a/2}}a\,da.
\tag{9}
$$
In particular the prime $2$ is included. Their cumulative difference is
$$
D_X(a)=\sum_{p\le e^a}p^{-1/2}
 -\int_2^{e^a}\frac{dx}{\sqrt x\log x},
\qquad a_0\le a\le A.
\tag{10}
$$
Set $M_X$ and $J_X$ from these measures as in section 2.

The origin interval is deliberately kept separate. Its density $e^{a/2}/a$ has infinite mass at zero, so it is not one of the finite measures in (9). Its sine phase
$$
\theta_0(t)=2\int_0^{a_0}\frac{e^{a/2}}a\sin(at)da
$$
is nevertheless bounded and real. Equation (3) shows directly that
$$
\|M_\chi[P,M_{\theta_0}]\|_{\mathcal S_1}
 \le2C_\chi\int_0^{a_0}e^{a/2}(a^{-1/2}+1)da<\infty.
\tag{11}
$$
Thus it is an admissible fixed factor, independent of $X$.

Let
$$
U_0=M_{\pi^{-it}\Gamma(5/4+it/2)/\Gamma(5/4-it/2)}\,e^{i\theta_0(t)}.
$$
The [fixed-factor trace-class proof](semilocal-weighted-scattering.md) and (11) give $N_\chi(U_0)<\infty$. With the actual stable renormalization
$\widehat U_X=U_X R V_{\log X}^+$, one has, up to an irrelevant constant phase, the exact factorization
$$
\widehat U_X=U_0e^{i\theta_X},\qquad
\theta_X(t)=-2\int\sin(at)(\mu_X-\lambda_X)(da)
 -2\sum_{p\le X}\sum_{k\ge2}\frac{p^{-k/2}}k\sin(kt\log p).
\tag{12}
$$
This follows by integrating the actual local logarithmic phase derivative with value zero at $t=0$. No critical-line infinite Euler product occurs.

The complete proper-power part in (12) obeys, by (3),
$$
\begin{aligned}
\left\|M_\chi\left[P,
 \sum_{p\le X,k\ge2}\frac{p^{-k/2}}k\sin(kt\log p)
 \right]\right\|_{\mathcal S_1}
 &\le C_\chi\sum_{p\le X}\frac{\log p}{p(1-p^{-1/2})}\\
 &=O_\chi(\log X).
\end{aligned}
\tag{13}
$$
Here $\sqrt{k\log p}\le C k\log p$ for $p\ge2,k\ge2$. The last estimate is the elementary Chebyshev upper-bound calculation already used for the full local factors. Thus no proper power is discarded, including powers greater than $X$.

Combining (6)–(8) and (12)–(13) proves the finite, quantitative theorem
$$
\boxed{
N_\chi(\widehat U_X)
\le N_\chi(U_0)+C_\chi\left[
 \log X+|D_X(A)|(A+\sqrt A)
 +\sqrt{M_XJ_X}+(1+A)J_X
\right].}
\tag{14}
$$
The right side is determined by the actual prime locations and a specified positive-density measure. Its endpoint mismatch and its transport cost are explicit.

## 5. Consequence of the unconditional prime-number-theorem remainder

For completeness, the analytic number theory input needed in this section is exactly
$$
\vartheta(x)-x=O\left(xe^{-c\sqrt{\log x}}\right)
\tag{15}
$$
for some $c>0$. One explicit primary input is [Johnston–Yang, Theorem 1.1](https://arxiv.org/abs/2204.01980), which gives a bound of this shape for $\psi(x)-x$. The elementary proper-power bound $\psi(x)-\vartheta(x)=O(\sqrt x\log^2x)$ gives (15), after decreasing $c$. No RH-quality estimate is used. Alternatively (14) stands independently of (15) as a finite arithmetic inequality.

Here is the full passage from that input. Put $w(x)=x^{-1/2}/\log x$, $E(x)=\vartheta(x)-x$. Stieltjes integration, with the prime at $2$ included and $E(2-)=-2$, gives
$$
D_X(a)=w(e^a)E(e^a)+2w(2)-\int_2^{e^a}E(x)w'(x)dx.
\tag{16}
$$
Since $|w'(x)|\le Cx^{-3/2}/\log x$ for $x\ge2$, (15) implies, for some $c_1>0$,
$$
|D_X(a)|\le C\frac{e^{a/2}}a e^{-c_1\sqrt a}
\quad(a\ge a_0),
\tag{17}
$$
after enlarging $C$ on a fixed initial interval. To verify the integral bound directly, split at $x=e^{a/2}$. The lower part is exponentially smaller in $a$; on the upper part the zero-free-region factor is at most $e^{-(c/\sqrt2)\sqrt a}$, and $\int x^{-1/2}/\log x\,dx\ll e^{a/2}/a$. The same split in the variable $a$ proves, after a possible decrease of $c_1$,
$$
J_X\le C\frac{\sqrt X}{\log X}e^{-c_1\sqrt{\log X}},
\qquad
M_X\le C\frac{\sqrt X}{\log X}.
\tag{18}
$$
The mass bound follows from Chebyshev and partial summation, or directly from (17) and the density mass.

Substitution in (14) proves that some absolute $c_2>0$ satisfies
$$
\boxed{
N_\chi(\widehat U_X)
 =O_\chi\left(\sqrt X\,e^{-c_2\sqrt{\log X}}+\log X+1\right)
 =o_\chi(\sqrt X).}
\tag{19}
$$
The constants are uniform over a bounded set of the finitely many Schwartz seminorms used in sections 1 and 4 and in the fixed-factor trace-class estimate.

For the actual fixed compact pole-null test, $\chi=|\widehat f|^2$, the trace readout is still exactly $Q(f)$ once $\log X$ exceeds its support diameter. Thus (19) is a collective operator-norm cancellation before taking that readout. It improves the separate prime-triangle growth, while its right side still grows and gives no nonnegative lower bound. It also leaves all conjugated cross terms in the underlying cocycle intact. A sharper comparison can act on this renormalized operator, rather than spending its bound on the removable first-prime continuum phase.
