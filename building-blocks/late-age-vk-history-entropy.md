# Growing-prime completion from the actual smooth-history entropy

The [exact two-port formulas](late-age-prime-boundary-transfer.md) admit a stronger growing-prime completion when the smooth-history count retains each prime logarithm. This written proof uses the classical Vinogradov–Korobov PNT remainder and retains the causal seed and every prime power.

Write
$$
\Phi(R)=\frac{R^{3/5}}{(\log R)^{1/5}},\qquad R\ge3.
$$
The Vinogradov–Korobov form of the PNT supplies fixed positive constants such that
$$
|\beta(v)|\le C e^{-c\Phi(v)}\quad(v\ge3).
\tag{1}
$$
The primary source is Daniel Johnston, [Zero-density estimates and the optimality of the error term in the prime number theorem, Corollary 2.3 and equations 2.10–2.11](https://arxiv.org/html/2411.13791v2). Its polynomial prefactor can be absorbed by decreasing the positive exponential constant. Only the classical shape (1) is used here.

## An exact count retaining every prime logarithm

Let $S$ be a nonempty finite prime set, $k=|S|$, $h_p=\log p$, and $H=\sum_{p\in S}h_p$. Define
$$
N_S(y)=\#\{d\in\mathbb Z_{\ge1}:\ \forall\text{ primes }p\mid d,\ p\in S;\ \log d\le y\},
$$
where the notation means that all prime factors lie in $S$, and includes $d=1$. For $y\ge0$,
$$
N_S(y)\le\frac{(y+H)^k}{k!\prod_{p\in S}h_p}.
\tag{2}
$$
Indeed, for every exponent vector $\nu\in\mathbb N_0^k$ with $\sum\nu_ph_p\le y$, its box $\prod_p[\nu_ph_p,(\nu_p+1)h_p)$ has volume $\prod h_p$. These boxes are disjoint and lie in the positive simplex $\sum x_p\le y+H$, of volume $(y+H)^k/k!$.

The corresponding exact partition-function bound is
$$
N_S(y)\le\inf_{\epsilon>0}e^{\epsilon y}
\prod_{p\in S}(1-p^{-\epsilon})^{-1}.
\tag{3}
$$
It follows by summing $e^{-\epsilon\log d}$ over all admitted histories. The inequality $1-e^{-x}\ge xe^{-x}$, followed by $\epsilon=k/(y+H)$, gives the slightly weaker factorial-free version of (2).

For $S=\{p:p\le P\}$, elementary Chebyshev bounds give $k\asymp P/\log P$, $H\ll P$, and
$$
\left(\prod_{p\le P}\log p\right)^{1/k}\gg\log P.
\tag{4}
$$
For the last assertion, all but $O(\sqrt P/\log P)$ of the primes exceed $\sqrt P$; their logarithms are at least $\tfrac12\log P$. The small primes change the geometric mean by a bounded factor. Thus, for a fixed absolute $C$ and all $m\ge0$,
$$
\log N_S(m+1+H)
\le C\frac P{\log P}\log\!\left(C\frac{m+1+P}{P}\right).
\tag{5}
$$

## Full tail and both actual ports

Use the exact notation of the baseline source. For the actual late input
$f_{R,T}=1_{[R,\infty)}\chi_T a$, its inverse port obeys
$$
\sup_{0<u<H}e^{u/2}|b_S(f_{R,T})(-u)|
\le C(2^k-1)\prod_{p\in S}(1+p^{-1})
\sum_{m\ge\lfloor R\rfloor}e^{-c\Phi(m)}N_S(m+1+H).
\tag{6}
$$
This is the baseline formula with its complete squarefree numerator and complete smooth-history denominator. All estimates are uniform in the upper cutoff $T\ge R$. The forward port is exactly zero if $R\ge H$.

Suppose
$$
P=P(R)=o(\Phi(R)).
\tag{7}
$$
Then the right side of (6) is $O(e^{-c'\Phi(R)})$ for some fixed $c'>0$.

Here is the uniform tail check. If $P\le R^{1/4}$, the logarithm of the count and the finite numerator factors at $m=R$ is $O(R^{1/4}\log R)=o(\Phi(R))$. If $P>R^{1/4}$, then $\log P\asymp\log R$, while (7) implies $P<R^{2/3}$ eventually. Equation (5) and the numerator factors therefore cost $O(P)=o(\Phi(R))$. For fixed $P$ in either case, the ratio
$$
\frac{\log(C(m+1+P)/P)}{\Phi(m)}
$$
decreases for all $m\ge R-1$ once $R$ is sufficiently large. To check this, its numerator has logarithmic derivative at most $1/\log(C(m+1+P)/P)$ with respect to $\log m$, whereas that of $\Phi(m)$ tends to $3/5$. In the present range the former tends uniformly to zero. The fixed numerator factors divided by $\Phi(m)$ also decrease. Consequently the entire positive count cost is at most $c\Phi(m)/2$ throughout the infinite tail. Finally,
$$
\sum_{m\ge R-1}e^{-c\Phi(m)/2}
\ll e^{-c'\Phi(R)}.
\tag{8}
$$
For example, substitution $t=\Phi(x)$ bounds this integral by a polynomial in $t$ times $e^{-ct/2}$; decreasing the exponent absorbs that polynomial.

Thus the exact actual completion satisfies
$$
\eta_S(f_{R,T})=0,\qquad
\sup_{0<u<H}e^{u/2}|b_S(f_{R,T})(-u)|
+\|b_S(f_{R,T})\|_2
\ll e^{-c'\Phi(R)}.
\tag{9}
$$
The weighted $L^2(0,H)$ bound has the additional factor $\sqrt H$, which can be absorbed by decreasing $c'$. The baseline age-transform derivative estimates follow unchanged. In particular every fixed $a<3/5$ permits $P\le R^a$; (7) gives the more precise logarithmic boundary. There is no claim that the endpoint with a fixed positive ratio $P/\Phi(R)$ works with arbitrary constant.

## A positive two-port completion, with its exact scope

For fixed $S$, (6) defines the full-source inverse port $b_S(a)$ by a cutoff limit. The forward port $\eta_S(a)$ depends only on the input through age $H$, so it is also well defined. Embed all port spaces by zero extension in $L^2(\mathbb R_-)$, and set
$$
\Gamma_S=(\eta_S(a),b_S(a)),\qquad
\mathcal K_S=|\Gamma_S\rangle\langle\Gamma_S|.
\tag{10}
$$
This positive block operator includes the mixed blocks $|\eta_S\rangle\langle b_S|$ and its adjoint.

The original square-root PNT bound alone gives
$$
\|\Gamma_S\|\le e^{CP}\qquad(S=\{p\le P\}).
\tag{11}
$$
For the inverse port, insert the crude count $(C(m+1+H))^k$ in the baseline bound with $R=0$. Splitting $(m+1+H)^k\le2^{k-1}((m+1)^k+H^k)$, the substitution $x=\sqrt m$ bounds the first sum by a constant to the power $k$ times $\Gamma(2k+2)$. The logarithm of the full bound is $O(k\log(k+H+2))=O(P)$. For the forward port, unitarity and finite dependence give $\|\eta_S(a)\|_2\le\|1_{[0,H]}a\|_2\ll e^{H/2}$.

Let $\Gamma_{S,R}$ use the actual source cut off after $R$, with a bounded transition of length at most one. Equations (9)–(11), with a harmless unit shift in $R$, show that under (7)
$$
\|\mathcal K_S-\mathcal K_{S,R}\|_1
\le(\|\Gamma_S\|+\|\Gamma_{S,R}\|)
\|\Gamma_S-\Gamma_{S,R}\|
\ll e^{-c''\Phi(R)}.
\tag{12}
$$
This is an actual cutoff-stability assertion with growing generators. Positivity of a Gram operator alone places no restriction on the arithmetic. The complete signed readout is still
$$
f*f-p_+*q_+=\eta_S*q_++b_S*Z.
$$
It couples these completed ports to interior histories. No positive factorization of that readout through (10), and no convergence of the canonical compensated prime multiplier in localized trace norm, is asserted here.
