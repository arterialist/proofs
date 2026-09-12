# A uniform local square mean for the actual critical charge under RH

Written proof. Conditional conclusions retain their stated RH hypotheses; none proves an unconditional RH-scale bound. Classical explicit-formula, zero-counting, Fourier and operator tools are attributed below and in the linked dependencies.

Let
$$
 M(x)=\sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}-2\sqrt x+1,
 \qquad m(v)=M(e^v)\quad(v\ge0),
 \tag{1}
$$
with all prime powers and natural right-continuous cutoffs.

**Lemma.** Assuming RH, there is a finite constant $C_*$ such that
$$
 \boxed{\displaystyle
 \sup_{V\ge0}\int_V^{V+1}|m(v)|^2\,dv\le C_*.}
 \tag{2}
$$
In particular,
$$
 \int_1^\infty\frac{|m(v)|^2}{v^2}\,dv<\infty,
 \qquad
 \int_R^\infty\frac{|m(v)|^2}{v^2}\,dv\ll R^{-1}
 \quad(R\ge1).
 \tag{3}
$$
No zero-spacing estimate, linear independence, simplicity, or pointwise convergence of the unsmoothed zero series is assumed.

## 1. A frequency-bin inequality

Choose a nonnegative $\chi\in C_c^\infty(\mathbb R)$ with
$\chi\ge1$ on $[0,1]$.
For a finite exponential sum $P(v)=\sum_\lambda a_\lambda e^{i\lambda v}$, put
$$
 A_j=\sum_{j\le\lambda<j+1}|a_\lambda|,\qquad j\in\mathbb Z.
$$
Expanding the square against $\chi(v-V)$, taking absolute values of the Fourier coefficients, and using its rapid Fourier decay gives
$$
 \begin{split}
 \int_V^{V+1}|P(v)|^2\,dv
 &\le\int_{\mathbb R}\chi(v-V)|P(v)|^2\,dv\\
 &\le C\sum_{j,\ell\in\mathbb Z}
       \frac{A_jA_\ell}{(1+|j-\ell|)^2}
 \le C'\sum_j A_j^2.
 \end{split}
 \tag{4}
$$
For the middle estimate, if $\lambda\in[j,j+1)$ and
$\mu\in[\ell,\ell+1)$, then
$(1+|\lambda-\mu|)^{-2}\le C(1+|j-\ell|)^{-2}$.
The last estimate is the elementary Schur/Young bound for the summable sequence
$(1+|j|)^{-2}$.
All dependence on $V$ is a phase of modulus one, so (4) is uniform in the location of the interval.

Under RH write the distinct nontrivial zeros as
$\rho=1/2+i\gamma$, with multiplicity $m_\gamma$, and set
$$
 a_\gamma=-\frac{m_\gamma}{i\gamma},
 \qquad
 S_T(v)=\sum_{0<|\gamma|\le T}a_\gamma e^{i\gamma v}.
 \tag{5}
$$
The unconditional Riemann–von Mangoldt estimate implies that the total zero multiplicity in each unit ordinate interval is $O(\log(2+|j|))$.
There is no zero at $1/2$, and only finitely many ordinates in any bounded interval.
Thus the corresponding bins satisfy
$$
 A_j\ll\frac{\log(2+|j|)}{1+|j|},\qquad
 \sum_j A_j^2<\infty.
 \tag{6}
$$
Equation (4) applies equally to differences of two truncations. Therefore
$S_T$ converges to a real function $S\in L^2_{\mathrm{loc}}(\mathbb R)$, with
$$
 \sup_{V\in\mathbb R}\int_V^{V+1}|S(v)|^2\,dv<\infty.
 \tag{7}
$$
More precisely, for $T\ge2$,
$$
 \sup_{V\in\mathbb R}\int_V^{V+1}|S(v)-S_T(v)|^2\,dv
 \ll\sum_{|j|\ge T-1}\frac{\log^2(2+|j|)}{(1+|j|)^2}
 \ll\frac{\log^2(T+2)}{T}.
 \tag{8}
$$
A bin meeting a truncation boundary causes no problem: its selected coefficient sum is bounded by the full bin sum. The convergence and estimate retain multiplicities even when several distinct zeros lie arbitrarily close together.

## 2. Identification by the full canonical product and Laplace uniqueness

The exact seeded Laplace transform, derived directly from (1), is
$$
 \mathcal M(z)=\int_0^\infty e^{-zv}m(v)\,dv
 =\frac1z\left[-1-\frac{\zeta'}{\zeta}(\tfrac12+z)
                     -\frac1{z-\tfrac12}\right],
 \qquad\Re z>\tfrac12.
 \tag{9}
$$
The $-1/z$ retains $M(1)=-1$; the apparent pole at $z=1/2$ cancels.

Put $F(s)=(s-1)\zeta(s)$, an entire function of order at most one with
$F(0)\ne0$. Its zeros are exactly all nontrivial zeros and the trivial zeros
$-2k$, $k\ge1$, with their multiplicities.
For completeness, the order statement also follows from
$$
 F(s)=2\pi^{s/2}\xi(s)\frac1{s\Gamma(s/2)}:
$$
$\xi$ has order one, and the reciprocal gamma factor divided by $s$ is entire of order one.
The genus-one Hadamard product gives the absolutely locally convergent difference
$$
 \frac{F'}F(s)-\frac{F'}F(\tfrac12)
 =\sum_{\omega:F(\omega)=0}
       \left(\frac1{s-\omega}-\frac1{\tfrac12-\omega}\right).
 \tag{10}
$$
The exponential factor's logarithmic derivative cancels. Absolute convergence follows from the $O(|\omega|^{-2})$ difference; all zero multiplicities are counted.

Let
$$
 C=1-\frac{\zeta'}{\zeta}(\tfrac12),\qquad a_k=2k+\tfrac12.
$$
Since the bracket in (9) equals $-1-F'/F(1/2+z)$, substituting (10) yields, under RH,
$$
 \mathcal M(z)=\frac Cz+
       \sum_{\gamma\ne0}\frac{-m_\gamma}{i\gamma(z-i\gamma)}
       +\sum_{k\ge1}\frac1{a_k(z+a_k)}
       \qquad(\Re z>0).
 \tag{11}
$$
Here (11) means the meromorphic continuation of (9) when
$0<\Re z\le1/2$. Both displayed sums are absolutely locally convergent in the right half-plane. This includes the complete trivial-zero contribution.

Define
$$
 R(v)=\sum_{k\ge1}\frac{e^{-a_kv}}{a_k},\qquad v>0.
 \tag{12}
$$
The series is positive and converges for every $v>0$, with
$$
 R(v)\ll1+|\log v|\quad(0<v\le1),\qquad
 R(v)\ll e^{-5v/2}\quad(v\ge1).
 \tag{13}
$$
For example,
$R(v)\le-\tfrac12e^{-v/2}\log(1-e^{-2v})$.
Thus $R\in L^2(0,\infty)$, including the lower endpoint.

For any $\sigma>0$, (8) and Cauchy–Schwarz on the intervals
$[j,j+1]$ give
$$
 \int_0^\infty e^{-\sigma v}|S_T(v)-S(v)|\,dv
 \le C_\sigma
 \sup_{V\ge0}\|S_T-S\|_{L^2(V,V+1)}
 \longrightarrow0.
 \tag{14}
$$
Consequently termwise Laplace transformation of the finite sums in (5), followed by the limit, gives
$$
 \int_0^\infty e^{-zv}S(v)\,dv
   =\sum_{\gamma\ne0}\frac{-m_\gamma}{i\gamma(z-i\gamma)}
 \quad(\Re z>0).
 \tag{15}
$$
Likewise Tonelli, or absolute Fubini, transforms (12) into the last sum in (11).

It follows that $m(v)$ and $C+S(v)+R(v)$ have the same Laplace transform on $\Re z>1/2$. Uniqueness now gives
$$
 \boxed{m(v)=C+S(v)+R(v)\quad\text{for almost every }v>0.}
 \tag{16}
$$
There is no pointwise zero-sum premise in this argument.
Indeed, for any fixed $\sigma>1/2$, the difference of the two sides times
$e^{-\sigma v}\mathbf1_{v\ge0}$ lies in $L^1(\mathbb R)$;
(9), (11), and (15) say its Fourier transform vanishes identically.
Fourier uniqueness proves (16).
The natural prime-power endpoint convention changes only a countable set, so it has no effect on any of the integrals claimed here.

## 3. The bounds and their scope

Equations (7), (13), and (16) imply (2) immediately. In particular, the initial unit interval is harmless: the possible logarithmic singularity of $R$ is square integrable, and the actual $m$ is itself bounded there.
Partitioning $[R,\infty)$ into unit intervals and using
$\sum_{j\ge0}(R+j)^{-2}\ll R^{-1}$ proves (3).

The argument uses only the unconditional unit-bin zero count together with RH's placement of those frequencies on the real axis. The count follows, for example, from Trudgian's primary Corollary 1 in
[An improved upper bound for the argument of the Riemann zeta-function on the critical line II](https://arxiv.org/pdf/1208.5846).
The all-power explicit formula corresponding to (16), including the positive trivial-zero remainder and midpoint endpoint convention, is equation (36) of
[Suzuki, On variants of Chebyshev's conjecture](https://link.springer.com/article/10.1007/s11139-025-01238-9).
Here its identification is proved through (10)–(16), rather than through unverified pointwise convergence.

The conclusion is a conditional local square-mean estimate for the actual seeded charge. It is compatible with its unconditional two-sided unboundedness: tall excursions can occupy short intervals. It supplies the weighted norm in (3), but makes no independent claim about the full source work, the clock-action comparison, or RH itself.
