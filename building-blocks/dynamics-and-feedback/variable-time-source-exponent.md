# Exact source exponent under variable process time

The complete positive prime process gives an exact relation between its time scale and the power-growth exponent of the actual frozen source. The proof combines a low-Laplace observation with finite Stieltjes inversion, then uses the diffuse-process estimate from the [source-correlation theorem](../prime-distribution/actual-short-time-psi-correlation.md). These are written analytic results; the formal probability construction does not formalize the source reconstruction below.

Let $T_tf=\mu_t*f$ be the [complete prime process](../successor-and-division/positive-successor-seed-jump-process.md), with no killing and

$$
\Phi(q)=\int_0^\infty(1-e^{-qv})F(v)dv,\qquad
F(v)\le\frac C{(1+v)^2}.
$$

Here $F$ is the actual full-prime Lévy density. Write $E(x)=\psi(x)-x$ right-continuously and, for integer $N\ge2$,

$$
a_N(v)=e^{-v/2}E(\min(e^v,N))\mathbf1_{v\ge0},\qquad
Q_N(t)=\|T_ta_N\|_2^2.
$$

The source includes its literal frozen tail, so

$$
Q_N(0)=\int_1^N\frac{|E(x)|^2}{x^2}dx+\frac{|E(N)|^2}N.
\tag{1}
$$

For an arbitrary nonnegative schedule $t_N$, put

$$
\kappa_t=\limsup_{N\to\infty}\frac{\log(1+Q_N(t_N))}{\log N},
\qquad
\kappa_0=\limsup_{N\to\infty}\frac{\log(1+Q_N(0))}{\log N}.
$$

Contraction and Chebyshev's bound give $0\le\kappa_t\le\kappa_0\le1$. We prove that, if

$$
\frac{\log(1+t_N)}{\log N}\longrightarrow\delta\in[0,\infty),
$$

then

$$
\boxed{\kappa_t=\max(\kappa_0-\delta,0).}
\tag{2}
$$

No monotonicity of $t_N$ or alignment with large source values is required. In particular every subpolynomial schedule preserves the exponent, while polynomial times can reduce it. This theorem does not evaluate $\kappa_0$.

## Low-Laplace observation with a moving parameter

First suppose only that $\limsup\log(1+t_N)/\log N\le\delta<\infty$. Splitting the defining integral at $1/q$ and using $1-e^{-qv}\le\min(qv,1)$ gives

$$
\Phi(q)\le C_1q[1+\log(1/q)],\qquad 0<q\le1.
\tag{3}
$$

For $N\ge3$ choose

$$
q_N=\frac1{(1+t_N)\log^2N},\qquad s_N=\tfrac12+q_N.
$$

Then

$$
q_N\log N\le\frac1{\log N},\qquad
t_N\Phi(q_N)\le
\frac{C_1[1+\log(1+t_N)+2\log\log N]}{\log^2N}
=O_\delta(1/\log N).
\tag{4}
$$

For real $X\ge1$ define the finite signed Mellin sum

$$
D_X(s)=-1+\sum_{2\le n\le X}\Lambda(n)n^{-s}-\int_1^Xx^{-s}dx.
$$

The exact frozen-source Laplace identity is $\int_0^\infty e^{-qv}a_N(v)dv=D_N(\tfrac12+q)/(\tfrac12+q)$. The process multiplies this transform by $e^{-t_N\Phi(q)}$. Pairing its output with $e^{-qv}\mathbf1_{v\ge0}$ proves

$$
|D_N(s_N)|\le\frac{s_N}{\sqrt{2q_N}}
e^{t_N\Phi(q_N)}\|T_{t_N}a_N\|_2.
\tag{5}
$$

Thus, for every $a>(\kappa_t+\delta)/2$,

$$
|D_N(s_N)|\le C_aN^a
\tag{6}
$$

at every sufficiently large integer cutoff. The explicit observation cost before absorbing logarithms is at most

$$
C\sqrt{1+t_N}\log N
\exp\!\left(\frac{C_1[1+\log(1+t_N)+2\log\log N]}{\log^2N}\right).
$$

The frozen terminal contribution is already present in the Laplace identity. This step uses no positive age moment or total-variation bound for an inverse process.

## Real cells and exact Abel reconstruction

For $X\in[n,n+1)$, $n\ge3$, set $q_X=q_n$ and $s_X=s_n$. Holding the parameter fixed across that cell gives

$$
D_X(s_X)-D_n(s_n)=-\int_n^Xy^{-s_n}dy,
\qquad |D_X(s_X)-D_n(s_n)|\le n^{-1/2}.
\tag{7}
$$

Consequently $|D_X(s_X)|\le C_aX^a$, $q_X\to0$ and $q_X\log X\to0$. At an integer endpoint the next sum includes its complete arithmetic atom.

Put $M_X=D_X(\tfrac12)$. It is the cumulative mass of

$$
d\omega(y)=y^{-1/2}\left[-\delta_1+
\sum_{n\ge2}\Lambda(n)\delta_n-\mathbf1_{(1,\infty)}(y)dy\right].
$$

For each fixed $X$ and its selected $q_X$, finite Fubini yields

$$
D_X(\tfrac12+q_X)
=X^{-q_X}M_X+q_X\int_1^Xx^{-q_X-1}M_xdx.
\tag{8}
$$

Indeed $X^{-q}+q\int_y^Xx^{-q-1}dx=y^{-q}$. The parameter in this one integral is $q_X$, not $q_x$. The formula includes $M_1=D_1(s)=-1$ and the right-endpoint prime-power atom.

Choose $b>(\kappa_t+\delta)/2$ and then $a$ strictly between those numbers. Define the finite prefix supremum

$$
F_b(X)=\sup_{1\le x\le X}\frac{|M_x|}{x^b}.
$$

Local finite variation makes it finite. For all sufficiently large $X$, $q_X<b$, and (8) gives

$$
\begin{aligned}
\frac{|M_X|}{X^b}
&\le X^{q_X-b}|D_X(\tfrac12+q_X)|
+q_XF_b(X)X^{q_X-b}\int_1^Xx^{b-q_X-1}dx\\
&\le C+\frac{q_X}{b-q_X}F_b(X).
\end{aligned}
\tag{9}
$$

The first constant is uniform because $a<b$ and $q_X\log X\to0$. Choose $X_0$ with $q_X/(b-q_X)\le1/2$ for all $X\ge X_0$ and retain $F_0=F_b(X_0)$. Taking prefix suprema gives

$$
F_b(X)\le\max(F_0,C+\tfrac12F_b(X))\le\max(F_0,2C).
$$

Hence $M_X=O_b(X^b)$. This absorption does not require a monotone parameter or removal of an initial boundary constant.

A second finite Abel identity, now with fixed exponent $1/2$, is

$$
E(X)=\sqrt X M_X-\tfrac12\int_1^Xx^{-1/2}M_xdx.
\tag{10}
$$

It retains $E(1)=M_1=-1$ and yields

$$
|E(X)|\le C_b\left(1+\frac1{2b+1}\right)X^{b+1/2},
\qquad
Q_N(0)\le C_b'\left[\frac{N^{2b}-1}{2b}+N^{2b}\right].
\tag{11}
$$

The second term is the frozen-tail square. Thus $\kappa_0\le2b$; letting $b\downarrow(\kappa_t+\delta)/2$ proves

$$
\boxed{\max(\kappa_0-\delta,0)\le\kappa_t\le\kappa_0.}
\tag{12}
$$

If $\kappa_t+\delta=0$, every calculation still uses $b>0$ before taking the limit.

## Matching upper bound from the complete diffuse process

Let $\lambda=\int F>0$. The [complete-process variation estimate](../prime-distribution/dyadic-prime-process-variation.md) and the [exact correlation formula](../prime-distribution/actual-short-time-psi-correlation.md) give

$$
\mu_t*\mu_t^\vee=e^{-2\lambda t}\delta_0+q_t(v)dv,
\qquad \|q_t\|_\infty\le C/t,\qquad t\ge1.
$$

Therefore

$$
Q_N(t)\le e^{-2\lambda t}Q_N(0)+\frac Ct\|a_N\|_1^2.
\tag{13}
$$

The no-jump atom has not been absorbed into the diffuse estimate. Write $L=\log N$, $u_N^2=\int_0^L|a_N|^2$ and $b_N=|E(N)|/\sqrt N$. The exact tail has $L^1$ norm $2b_N$ and squared $L^2$ norm $b_N^2$, so twice applying Cauchy–Schwarz gives

$$
\|a_N\|_1\le\sqrt L\,u_N+2b_N,\qquad
\|a_N\|_1^2\le(L+4)Q_N(0).
\tag{14}
$$

Together with contraction this proves the uniform estimate

$$
Q_N(t)\le\min\left(1,e^{-2\lambda t}+\frac{C(\log N+4)}t\right)Q_N(0),
\qquad t\ge1.
\tag{15}
$$

The coefficient $4$ records the frozen tail.

## Oscillating schedules and the exact time exponent

Set $\delta_- =\liminf\log(1+t_N)/\log N$ and $\delta_+=\limsup\log(1+t_N)/\log N$. If both are finite, then

$$
\boxed{\max(\kappa_0-\delta_+,0)\le\kappa_t
\le\max(\kappa_0-\delta_-,0).}
\tag{16}
$$

The lower bound is (12). For the upper bound, if $\delta_->0$, take $0<\epsilon<\delta_-$. Eventually $t_N\ge N^{\delta_--\epsilon}/2$ and $Q_N(0)\le N^{\kappa_0+\epsilon}$. Formula (15) gives, for every fixed $A>0$,

$$
Q_N(t_N)\le C_\epsilon(\log N+4)
N^{\kappa_0-\delta_-+2\epsilon}+O_A(N^{-A}).
\tag{17}
$$

Taking the nonnegative exponent and then $\epsilon\downarrow0$ proves the upper bound. If $\delta_-=0$, use contraction at all times, including small-time members of the schedule. If $\delta_+=\infty$, only the trivial lower bound zero is asserted. If $\delta_-=\infty$, (17) with any finite lower time exponent gives $\kappa_t=0$.

When the time exponent converges, (16) proves (2). The separate [Mellin source calibration](../prime-distribution/actual-short-time-psi-correlation.md) identifies $\kappa_0=2\Theta-1$, where $\Theta$ is the supremum of the real parts of the nontrivial zeta zeros. Thus

$$
\kappa_t=\max(2\Theta-1-\delta,0).
$$

The direct proof of (2) used no information about zeros. A subpower norm at subpolynomial times is equivalent to the unsmoothed subpower target. At a positive polynomial time exponent it only forces $\kappa_0\le\delta$. In particular $\delta\ge1$ already gives zero nonnegative exponent unconditionally, including $t_N=N$; it does not assert bounded norms or prove RH.

The [complete birth Gram](original-l2-evolved-source-gram-work.md) retains the corresponding signed loading and terminal work. The [literal successor renewal](../successor-and-division/literal-compensated-successor-iterates.md) is a different finite-source construction; neither identity supplies the unevaluated subpower estimate.
