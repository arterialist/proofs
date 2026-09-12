# Discrete harmonic convolution: regularity, spectrum, and aliasing

For the exact integer harmonic operator

$$
(\mathcal Hf)(t)=\sum_{n\le e^t}\frac1n f(t-\log n),
\qquad
(a*b)(t)=\int_0^t a(u)b(t-u)\,du,
$$

mean cancellation and control of the sampling error are separate requirements. The first theorem isolates them, permits continuous or mixed spectrum, and includes the Besicovitch mean-square argument as a special case. An exact counterexample shows why bounded energy and even a primitive tending to zero do not suffice. A second theorem controls frequency escape through an exponential bound on total variation instead of spectral tightness.

The application to the critical arithmetic sum $W$ is an alternative proof of a known conditional leading term. The [square-root sign criterion](sqrt-multiple-sign-criterion.md) already proves that asymptotic with the stronger error $O(x^{3/2}\log x)$ and establishes its eventual-sign equivalence with RH. No priority claim is made. These arguments are written analysis, not Lean formalizations.

## A time-domain theorem

Let $a,b\in L^2_{\rm loc}([0,\infty))$ satisfy

$$
\int_0^T|a|^2+\int_0^T|b|^2\le C(1+T).
\tag{E}
$$

For a function $f$, the translation condition used here is

$$
\lim_{\delta\downarrow0}\limsup_{T\to\infty}
\sup_{0\le h\le\delta}\frac1T
\int_0^T|f(u+h)-f(u)|^2du=0.
\tag{TC}
$$

**Theorem.** If at least one of $a,b$ satisfies (TC), then

$$
\boxed{\mathcal H(a*b)(t)-\int_0^t(a*b)(s)ds=o(t^2).}
\tag{1}
$$

If their Cesàro means $m_a,m_b$ exist, it follows that

$$
\boxed{\mathcal H(a*b)(t)=\frac{m_am_b}{2}t^2+o(t^2).}
\tag{2}
$$

For the zero conclusion alone, it suffices that one factor has zero Cesàro mean and one factor satisfies (TC). These may be different factors; the other mean need not exist.

Here and below the convolution is bilinear, without complex conjugation. To prove (1), suppose $b$ satisfies (TC), and put $g=a*b$. Cauchy–Schwarz gives $|g(s)|\le C'(s+1)$. Also

$$
\begin{aligned}
g(s+h)-g(s)
={}&\int_0^s a(u)[b(s+h-u)-b(s-u)]du\\
&+\int_s^{s+h}a(u)b(s+h-u)du.
\end{aligned}
$$

For every $\varepsilon>0$, (TC) and Cauchy–Schwarz bound the first integral, uniformly for sufficiently small $h\ge0$, by
$C_1\varepsilon(s+1)+C_\varepsilon$. The second is bounded by
$C\sqrt{s+1}\,\|b\|_{L^2(0,1)}$ for $h\le1$. Absorbing this sublinear term gives some $\delta>0$ and $C_\varepsilon$ such that

$$
|g(s+h)-g(s)|\le C_2\varepsilon(s+1)+C_\varepsilon
\quad(s\ge0,\ 0\le h\le\delta).
\tag{3}
$$

The coefficient $C_2$ is independent of $\varepsilon$. Local $L^2$ bounds handle the initial compact interval. Extend $g$ by zero to negative arguments; enlarging $C_\varepsilon$ makes (3) valid across zero as well.

For the exact quadrature, write $N=\lfloor e^t\rfloor$, $I_n=[\log n,\log(n+1)]$, and $\ell_n=\log(1+1/n)$. The portion of the last interval beyond $t$ contributes zero. Thus the difference in (1) equals

$$
\sum_{n=1}^N(1/n-\ell_n)g(t-\log n)
+\sum_{n=1}^N\int_{I_n}[g(t-\log n)-g(t-u)]du.
\tag{4}
$$

The first sum is $O(t+1)$ because $0\le1/n-\ell_n\le1/(2n^2)$. Choose $D$ so that $\ell_D\le\delta$. The finitely many cells $n<D$ contribute $O_D(t+1)$. On the remaining cells, (3) bounds the integrand by $C_2\varepsilon(t+1)+C_\varepsilon$, and their total length is at most $t+1$. Divide by $t^2$, take a limsup, then let $\varepsilon\downarrow0$. This proves (1), including $n=1$ and the last partial cell.

Put $A(T)=\int_0^T a$ and $B(T)=\int_0^T b$. Fubini gives

$$
\int_0^t g(s)ds=\int_0^t a(v)B(t-v)dv.
$$

If $B(T)=m_bT+o(T)$, the right side is
$m_b\int_0^t A(v)dv+o(t^2)$, since $\int_0^t|a|=O(t)$. This proves (2) when $A(T)=m_aT+o(T)$. If instead just $A(T)=o(T)$, use the symmetric identity $\int_0^t b(v)A(t-v)dv$ and $\sup_{u\le t}|A(u)|=o(t)$ to obtain $o(t^2)$ without a mean assumption on $b$.

## A spectral sufficient condition

Extend $a$ by zero to the negative half-line and define

$$
a_T=a\mathbf1_{[0,T]},\qquad
\widehat a_T(\xi)=\int_0^T a(u)e^{-i\xi u}du,
\qquad d\mu_T(\xi)=\frac{|\widehat a_T(\xi)|^2}{2\pi T}\,d\xi.
$$

Assume the finite-window spectral measures satisfy

$$
\sup_{T\ge1}\mu_T(\mathbb R)=M<\infty,
\tag{S1}
$$

$$
\lim_{K\to\infty}\limsup_{T\to\infty}\mu_T(|\xi|>K)=0,
\tag{S2}
$$

$$
\lim_{\eta\downarrow0}\limsup_{T\to\infty}\mu_T([-\eta,\eta])=0.
\tag{S3}
$$

**Corollary.** These assumptions imply $\mathcal H(a*a)(t)=o(t^2)$. No convergence of $\mu_T$ or autocorrelation is required.

Plancherel turns (S1) into (E). For $0\le h\le\delta\le1$, applying Plancherel to $a_{T+1}$ gives

$$
\frac1T\int_0^T|a(u+h)-a(u)|^2du
\le\frac{T+1}{T}
\left(\delta^2K^2M+4\mu_{T+1}(|\xi|>K)\right).
$$

Choose $K$ using (S2), then choose $\delta$. This proves (TC).
For the mean, pair $a_T$ with $\mathbf1_{[0,T]}$ in Fourier space and split at $|\xi|=\eta$. Since
$\int_{|\xi|>\eta}|\widehat{\mathbf1_{[0,T]}}(\xi)|^2d\xi\le8/\eta$, Cauchy–Schwarz yields

$$
\frac{|A(T)|}{T}
\le\sqrt{\mu_T([-\eta,\eta])}
+\sqrt{\frac{4M}{\pi T\eta}}.
\tag{5}
$$

First let $T\to\infty$, then $\eta\downarrow0$. Assumption (S3) gives $A(T)=o(T)$, completing the proof. High-frequency tightness supplies regularity; low-frequency exclusion supplies cancellation. The time-domain theorem requires only the resulting properties. In its bilinear zero-mean form, tightness may be supplied by one factor and low-frequency exclusion by the other.

A familiar sufficient setting is existence, for every $h\in\mathbb R$, of

$$
R(h)=\lim_{T\to\infty}\frac1T
\int_{\mathbb R}a_T(u+h)\overline{a_T(u)}du,
$$

with $R$ continuous at zero and its spectral measure $\mu$ satisfying $\mu(\{0\})=0$. Bochner's theorem and the continuity theorem for finite measures give $\mu_T\Rightarrow\mu$, hence (S1) and (S2). The portmanteau bound on $[-\eta,\eta]$ gives (S3). This permits continuous and mixed spectral measures.

The periodogram and autocorrelation framework is classical; see [Wiener, *Generalized harmonic analysis*, Acta Mathematica 55, 1930](https://archive.ymsc.tsinghua.edu.cn/pacm_download/117/5459-11511_2006_Article_BF02546511.pdf), especially Sections 1–4 and 11. The discrete quadrature argument (4) is proved here rather than attributed to an autocorrelation or Eberlein-convolution theorem.

## Why mean cancellation alone fails

There is a real measurable $a$ with $|a|\le1$ and $A(T)\to0$, but along $t_j\to\infty$,

$$
\boxed{\frac{\mathcal H(a*a)(t_j)}{t_j^2}\longrightarrow\frac1{36}.}
\tag{6}
$$

For the construction, let $L_j=2^{2^j}$, $t_j=3L_j$, and $M_j=\sum_{i<j}L_i=o(L_j)$. Choose integers $q_j\ge j$ so that

$$
\operatorname{dist}(2\pi q_j\log n,2\pi\mathbb Z)\le1/j
\qquad(1\le n\le\lfloor e^{L_j}\rfloor).
\tag{A}
$$

Such arbitrarily large integers exist by simultaneous recurrence on a finite torus. Explicitly, pigeonholing $Q^r+1$ multiples of an $r$-dimensional vector into $Q^r$ boxes gives a positive integer return with coordinate error at most $1/Q$. As $Q\to\infty$, either these returns are unbounded, or a fixed positive return is exact and its multiples are arbitrarily large.

Put $\omega_j=2\pi q_j$ and

$$
a(t)=\sum_{j\ge1}a_j(t),\qquad
 a_j(t)=\mathbf1_{[L_j,2L_j]}(t)\cos(\omega_jt).
$$

The supports are disjoint, and future blocks do not meet $[0,t_j]$. Every completed block has integral zero because $L_j,q_j$ are integers. Within block $j$, $A(T)=\sin(\omega_jT)/\omega_j$, and in the gaps $A(T)=0$. Hence $A(T)\to0$.

For $2L_j\le s\le3L_j$, direct integration gives

$$
(a_j*a_j)(s)=\frac{s-2L_j}{2}\cos(\omega_js)
+\frac{\sin(\omega_j(s-2L_j))}{2\omega_j},
$$

and this convolution vanishes for $s<2L_j$. Thus its harmonic sum at $t_j$ uses exactly $n\le e^{L_j}$. Condition (A) aligns all these cosine factors within $1/j$ of phase zero. The exact triangular sum

$$
B(L)=\sum_{n\le e^L}\frac{L-\log n}{n}
=\int_0^L\sum_{n\le e^u}\frac1n\,du
=\frac12L^2+O(L)
$$

therefore gives

$$
\frac{\cos(1/j)}2 B(L_j)-\frac{L_j+1}{2\omega_j}
\le\mathcal H(a_j*a_j)(t_j)
\le\frac12 B(L_j)+\frac{L_j+1}{2\omega_j}.
$$

The middle expression is $L_j^2/4+o(L_j^2)$. If $b_j=\sum_{i<j}a_i$, its support has measure $M_j$ and $|b_j|\le1$. Thus
$|2a_j*b_j+b_j*b_j|\le3M_j$ on $[0,t_j]$, and the complete contribution of earlier blocks is at most $3M_j(1+t_j)=o(L_j^2)$. Dividing by $t_j^2=9L_j^2$ proves (6).

The continuous integral is nevertheless $\int_0^t(a*a)=a*A=O(t)$, since $A$ is bounded. The discrete discrepancy alone has quadratic size. Increasing frequencies were chosen to align at the actual sample locations $\log n$ while oscillating between them. This proves that (TC) cannot simply be dropped from the time-domain theorem. It is not an example involving the prime-counting error.

## An exponential variation bound also suffices

**Theorem.** Suppose $a$ is locally of bounded variation and, for some finite $\kappa\ge0$,

$$
E_t:=\int_0^t|a|^2=O(t),\qquad
A(t)=\int_0^t a=o(t),\qquad
\operatorname{TV}_{[0,t]}(a)=O(e^{\kappa t}).
\tag{7}
$$

Then $\mathcal H(a*a)(t)=o(t^2)$. This conclusion does not require (TC) or spectral tightness.

The needed multiplier estimate is, for fixed $C,K>0$ and $0<\varepsilon<1/2$,

$$
\sup_{K/t\le|\tau|\le e^{Ct}}
\left|M_t(\tau)\right|
\le(2\varepsilon+2/K)t+D(1+t e^{-ct}),
\qquad M_t(\tau)=\sum_{n\le e^t}n^{-1-i\tau}.
\tag{8}
$$

The positive constants $c,D$ depend only on $C,\varepsilon$; the lower threshold for $t$ may also depend on $K$.
For $|\tau|\le e^{\varepsilon t}$, discard $n\le\lceil e^{2\varepsilon t}\rceil$, at cost $2\varepsilon t+O(1)$. Euler summation on the remainder differs from its integral by $O((1+|\tau|)e^{-2\varepsilon t})$. The integral is at most $2/|\tau|\le2t/K$.

For $e^{\varepsilon t}\le|\tau|\le e^{Ct}$, discard $n\le e^{\varepsilon t}$, at cost $\varepsilon t+O(1)$. Choose a fixed integer $k\ge3$ with $k\varepsilon>C$ and put $\eta=\varepsilon/(2k)$. On a partial dyadic interval $(N,N+Y]\subseteq(N,2N]$, with $N\ge e^{\varepsilon t}$, intervals with $Y<Ne^{-\eta t}$ have the trivial bound $Ne^{-\eta t}+1$.
For $Y\ge Ne^{-\eta t}$, the phase $f(x)=-\tau\log x/(2\pi)$ has, up to a sign, positive $k$th derivative with bounds $\lambda\asymp_k|\tau|N^{-k}$ and $\Lambda/\lambda\le2^k$. The main theorem, equation (2), of [Arias de Reyna, *Explicit van der Corput's d-th derivative estimate*](https://arxiv.org/html/2407.02094v1) gives

$$
\frac1Y\left|\sum_{N<n\le N+Y}n^{-i\tau}\right|
\ll_k Y^{-2/2^k}
+(|\tau|N^{-k})^{1/(2^k-2)}
+\bigl(|\tau|(Y/N)^k\bigr)^{-2/2^k}.
$$

Its condition $\lfloor Y\rfloor>k$ holds eventually. The three controlling quantities satisfy

$$
Y\ge e^{(\varepsilon-\eta)t},\qquad
|\tau|N^{-k}\le e^{-(k\varepsilon-C)t},\qquad
|\tau|(Y/N)^k\ge e^{\varepsilon t/2}.
$$

Thus every long interval has sum $O_{C,\varepsilon}(Ne^{-c_1t})$. The short-interval bound, including its $+1$, has the same form after reducing $c_1>0$. Partial summation with $1/n$ gives $O_{C,\varepsilon}(e^{-c_1t})$ for every full or partial dyadic block. There are $O(t)$ such blocks. This proves (8) uniformly through the final incomplete block.

For the Fourier step, extend $a_t=a\mathbf1_{[0,t]}$ by zero to $\mathbb R$, and put

$$
B_t=\sup_{0\le u\le t}|A(u)|,
\qquad V_t=\operatorname{TV}_{\mathbb R}(a_t).
$$

Endpoint representatives may be chosen so that
$V_t\le2\operatorname{TV}_{[0,t]}(a)+2|a(0+)|$.
Plancherel gives $\widehat a_t^2\in L^1$, so pointwise convolution inversion and finite summation give the exact identity

$$
\mathcal H(a*a)(t)=\frac1{2\pi}\int_{\mathbb R}
e^{i\tau t}\widehat a_t(\tau)^2M_t(\tau)\,d\tau.
\tag{9}
$$

For $|\tau|\le K/t$, integration by parts using $A$ gives
$|\widehat a_t(\tau)|\le(1+K)B_t$.
Bounded variation on the whole line gives
$|\widehat a_t(\tau)|\le V_t/|\tau|$ and
$\int_{|\tau|>R}|\widehat a_t|^2\le2V_t^2/R$.
Splitting (9) at $K/t$ and $e^{Ct}$, and using $|M_t|\le t+1$, yields the finite-scale estimate

$$
\begin{aligned}
|\mathcal H(a*a)(t)|\le{}&
\frac{K(t+1)(1+K)^2}{\pi t}\,B_t^2\\
&+E_t\bigl[(2\varepsilon+2/K)t+D(1+t e^{-ct})\bigr]\\
&+\frac{(t+1)V_t^2}{\pi e^{Ct}}.
\end{aligned}
\tag{10}
$$

Choose $C>2\kappa$. Then $B_t=o(t)$, $E_t=O(t)$, and $V_t=O(e^{\kappa t})$. Divide (10) by $t^2$, let $t\to\infty$, then $\varepsilon\downarrow0$ and $K\to\infty$. This proves the theorem.

The hypothesis permits functions excluded by (TC). For example, $a(t)=\sin(t^2)$ has bounded primitive, $E_t=O(t)$, and total variation at most $t^2$, but for every fixed $h>0$,

$$
\frac1T\int_0^T|a(u+h)-a(u)|^2du\longrightarrow1.
$$

The last assertion follows from product-to-sum and the bounded Fresnel integrals; the cross term has zero average. Thus its high frequencies need not remain in a fixed compact band for the variation theorem to apply.

Conversely, the frequencies $\omega_j$ of the aliasing construction must eventually exceed $e^{CL_j}$ for each fixed $C>0$. Otherwise (8), with $t=L_j$, contradicts $|M_{L_j}(\omega_j)|\ge\cos(1/j)\sum_{n\le e^{L_j}}1/n\sim L_j$. The variation within the current cosine block is $4q_jL_j$. Consequently that construction violates every fixed exponential variation bound. This identifies a quantitative obstruction to its recurrence mechanism.

## Arithmetic history phase resolution

Let $X>1$, $N=\lfloor X\rfloor$, and $h_N=\sum_{n\le N}1/n$. In the Hilbert space with orthonormal basis $|1\rangle,\ldots,|N\rangle$, define the unit vectors

$$
|\Omega_X(\tau)\rangle
=h_N^{-1/2}\sum_{n\le N}n^{-1/2}e^{-i\tau\log n}|n\rangle.
$$

Their exact overlap, with the inner product conjugate-linear in its first argument, is

$$
\langle\Omega_X(\sigma),\Omega_X(\tau)\rangle
=\frac{M_{\log X}(\tau-\sigma)}{h_N}.
$$

Suppose $\tau_X,\sigma_X$ are real and, for a fixed $C>0$,
$|\tau_X-\sigma_X|\log X\to\infty$ while $|\tau_X-\sigma_X|\le X^C$. Then their overlap tends to zero. Indeed, for every fixed $K>0$, estimate (8) applies eventually with $t=\log X$; divide it by $h_N\sim t$, then let $\varepsilon\downarrow0$ and $K\to\infty$.

This is an unconditional phase-resolution statement for a precisely defined finite family of integer-history states, including $1$, composites and every prime power. It gives a Hilbert-space interpretation of the multiplier estimate. It does not assert a physical phase transition or a bound for the prime-counting error.

## Besicovitch approximation and the arithmetic application

If $f$ is approximable by finite trigonometric polynomials in

$$
\|f\|_{B^2}^2=\limsup_{T\to\infty}\frac1T\int_0^T|f|^2,
$$

then (E), existence of its Cesàro mean, and (TC) follow. The mean is the limit of the constant coefficients, because
$\limsup_T|T^{-1}\int_0^T(f-P)|\le\|f-P\|_{B^2}$.
For (TC), write $f=P+r$. Uniformly for $0\le h\le\delta$, the translated remainder is bounded using its prefix integral up to $T+\delta$; its normalized limsup is at most $\|r\|_{B^2}^2$. The finite polynomial has mean-square translation difference tending to zero with $\delta$. Let the approximation error tend to zero. Thus (2) recovers

$$
\mathcal H(a*b)(t)=\frac{m_am_b}{2}t^2+o(t^2)
$$

for $B^2$ factors. This proof uses no bounded zeta-multiplier operator on the full Besicovitch space.

For the exact arithmetic observable, use every prime power in $\psi$ and put

$$
\sigma=d\psi-dx-\delta_1,\qquad e(x)=\psi(x)-x,
\qquad N(x)=\iint(x-ab)_+\,d\sigma(a)d\sigma(b),
$$

$$
T(x)=\sum_{p^j\le x}(x-p^j)(j-1)(\log p)^2,
\qquad N_*(x)=\sum_{d\le x}\sqrt d\,N(x/d),
\qquad T_*(x)=\sum_{d\le x}\sqrt d\,T(x/d),
\qquad W=N_*-T_*.
$$

Expanding the measure gives the published normalization

$$
N(x)=\sum_{ab\le x}(x-ab)\Lambda(a)\Lambda(b)
-\sum_{n\le x}\Lambda(n)\frac{x^2-n^2}{n}
+\frac{x^2}{2}\log x+\frac{x^2}{4}-\frac14.
$$

The tent sums vanish at $x\le1$, but $e(1)=-1$. Set

$$
a(t)=e^{-t/2}e(e^t),\qquad k(t)=e^{-3t/2}.
$$

Stieltjes integration by parts, extending $e$ by zero below $1$ to retain its atom, gives

$$
N(x)=xC(x)-\int_1^xC(y)dy,
\qquad C(x)=\int_1^x e(u)e(x/u)\frac{du}{u}.
$$

Indeed, integrating the tent in its second variable gives $uJ(x/u)$, where $J(y)=\int_1^y e(v)dv$, and integration by parts in $u$ gives the displayed identity. Exact finite dilation and convolution commute, yielding

$$
\boxed{e^{-3t/2}N_*(e^t)
=\mathcal H(a*a)(t)-(k*\mathcal H(a*a))(t).}
\tag{11}
$$

The weight is exactly $\sqrt d\,(e^t/d)^{3/2}/e^{3t/2}=1/d$.
More generally, (2) and $k*t^2=\tfrac23t^2+O(t)$ show that a mean $m_a$ would contribute $m_a^2t^2/6$ on the right of (11). A persistent mean therefore cannot be omitted when changing a counting normalization.

Under RH, Akbary, Ng, and Shahabi supply $B^2$ approximation of this actual $a$ by

$$
P_U(t)=-2\operatorname{Re}\sum_{0<\gamma\le U}
\frac{e^{i\gamma t}}{1/2+i\gamma},
$$

counting zeros with multiplicity. Their Theorem 1.2, Corollary 1.3(a), explicit formula (1.5), and proof on printed pp. 18–19 give these particular truncations. The frequencies are nonzero since $\zeta(1/2)\ne0$, so $m_a=0$. No simplicity or linear independence is assumed. See [Akbary, Ng, and Shahabi, *Limiting distributions of the classical error terms of prime number theory*](https://www.cs.uleth.ca/~akbary/Akbary-Ng-Shahabi.pdf). Equation (11) then gives $N_*(x)=o(x^{3/2}\log^2x)$, since convolution with $k$ preserves $o(t^2)$.

The variation route has a separate unconditional arithmetic input. Chebyshev's bound gives $|a(t)|=O(e^{t/2})$, and between its jumps
$a'(t)=-a(t)/2-e^{t/2}$. The jump at $\log n$ is $\Lambda(n)/\sqrt n$. Partial summation gives

$$
\sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}
=\frac{\psi(x)}{\sqrt x}
+\frac12\int_1^x\frac{\psi(u)}{u^{3/2}}du=O(\sqrt x).
$$

Both continuous and jump variation are therefore $O(e^{t/2})$. Thus bounded mean energy and zero mean would suffice through (7)–(10), without pure-point approximation or spectral tightness. Those two cancellation assumptions are not established unconditionally here.

For completeness, the full diagonal can be estimated without the prime number theorem. With $Z(y)=\sum_{d\le y}(y-d)/\sqrt d$, integral comparison and finite rearrangement give

$$
0\le\frac43y^{3/2}-Z(y)\le2y,
\qquad T_*(x)=\sum_{p^j\le x}(j-1)(\log p)^2p^jZ(x/p^j).
$$

Chebyshev's bound, $\log(N!)=\sum_{d\le N}\Lambda(d)\lfloor N/d\rfloor$, and Stirling's formula give $\sum_{n\le y}\Lambda(n)/n=\log y+O(1)$. Removing the convergent proper-power sum and partially summing yields
$\sum_{p\le y}(\log p)^2/p=\tfrac12\log^2y+O(\log y)$.
Also $\sum_{p\le y}(\log p)^2=O(y\log y)$. Hence the square terms contribute
$x^{3/2}\log^2x/6+O(x^{3/2}\log x)$. All higher powers together are bounded by
$\tfrac43x^{3/2}\sum_p(\log p)^2\sum_{j\ge3}(j-1)p^{-j/2}=O(x^{3/2})$.
Consequently

$$
T_*(x)=\frac16x^{3/2}\log^2x+O(x^{3/2}\log x),
\qquad W(x)\sim-\frac16x^{3/2}\log^2x\quad\text{under RH}.
$$

This recovers the leading term of the [stronger existing Mellin theorem](sqrt-multiple-sign-criterion.md) by a different mechanism. The generalization concerns the inputs allowed by the convolution argument, not a new RH equivalence.

There is a further arithmetic limit on its use: (E) alone for this actual $a$ already implies RH. It makes $\int_0^\infty a(t)e^{-zt}dt$ absolutely convergent and holomorphic for $\Re z>0$, by Cauchy–Schwarz and exponential decay. On $\Re z>1/2$ this transform equals

$$
-\frac{\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)}-\frac1{z-1/2}.
$$

The pole at $z=1/2$ cancels. Any zeta zero $\rho$ with $\Re\rho>1/2$ would produce a nonzero pole at $z=\rho-1/2$, contradicting holomorphy. Thus the spectral conditions do not supply an unconditional arithmetic estimate. The [formal sign implication](actual-critical-sign-criterion.md) remains the already established direction from eventual $W\le0$ to RH.
