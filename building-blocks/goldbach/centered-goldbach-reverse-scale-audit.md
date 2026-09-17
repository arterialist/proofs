# Actual centered heat evolution and the remaining doubling estimate

The [critical heat criterion](../theta-and-heat/critical-heat-lyapunov-exponent.md) and [centered Goldbach spectral bridge](goldbach-multiplicative-spectral-bridge.md) identify the polynomial logarithmic-horizon doubling condition with RH. The calculations below determine what the actual heat semigroup and additive positivity supply without assuming that condition.

Let
$$
F(t)=\sum_{n\ge2}\Lambda(n)e^{-nt},\qquad
B(t)=(1+t^{-1})e^{-t},\qquad C(t)=F(t)-B(t),
$$
$$
\mathscr A(T)=1+\int_{e^{-T}}^1C(t)^2\,dt.
$$
All proper prime powers remain in every occurrence of $\Lambda$.

## The exact signed additive measure

Put $\sigma=d\psi-1_{[1,\infty)}dx-\delta_1$. Its heat transform is exactly $C$. The complete additive convolution is the locally finite signed measure
$$
\boxed{\quad
\sigma*_{\!+}\sigma
=\sum_{k\ge4}\left(\sum_{m+n=k}\Lambda(m)\Lambda(n)\right)\delta_k
 -2\sum_{n\ge2}\Lambda(n)\delta_{n+1}+\delta_2
 +1_{\{x\ge2\}}\,[x-2\psi(x-1)]\,dx .
\quad}
\tag{1}
$$
The density endpoints do not affect the measure. Its heat transform is $C(t)^2\ge0$, with absolute convergence for every $t>0$.

Formula (1) follows by expanding all nine ordered pairs of the three terms in $\sigma$. In particular the two Lebesgue factors give $(x-2)_+dx$, and the two delta--Lebesgue terms give $2\,1_{x\ge2}dx$. Their sum is the density $x\,1_{x\ge2}dx$. The original endpoint atom is therefore retained exactly.

There is an actual negative coefficient:
$$
(\sigma*_{\!+}\sigma)(\{3\})=-2\log2<0.
\tag{2}
$$
There are no two positive prime-power arrivals summing to three. Thus positivity of the uncentered Goldbach coefficients is not positivity of the centered convolution measure. Positivity of its heat transform is a different assertion and does not remove its signed cross terms.

The spectral bridge uses the discrete centered source
$A_d(t)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nt}$.
The two normalizations are related by the exact bounded correction
$$
C(t)=A_d(t)+d(t),\qquad
d(t)=\frac1{e^t-1}-(1+t^{-1})e^{-t},\qquad
d(t)\longrightarrow-\tfrac12\quad(t\downarrow0).
\tag{3}
$$
Consequently $D_0=\int_0^1|d(t)|^2dt<\infty$. Minkowski gives
$$
\left|\sqrt{\mathscr A(T)-1}
-\left(\int_{e^{-T}}^1|A_d(t)|^2dt\right)^{1/2}\right|
\le\sqrt{D_0}.
\tag{4}
$$
After adding one the two energies are bounded above and below by fixed multiples of one another, uniformly in $T$. Thus they have the same exponential growth exponent and equivalent polynomial doubling properties. No density or endpoint term is silently changed in passing between the two criteria.

## Forward semigroup identity and backward observation

For every integer $m\ge1$, positivity gives the true uncentered comparison
$$
F(mt)\le e^{-2(m-1)t}F(t).
$$
The exact centered inequality is therefore
$$
C(mt)\le e^{-2(m-1)t}C(t)
       +e^{-2(m-1)t}B(t)-B(mt).
\tag{5}
$$
It is one-sided and its explicit deterministic defect is of size $1/t$ as $t\downarrow0$ for fixed $m>1$. It does not bound $|C(mt)|$, still less $|C(t/m)|$. The integer heat identity acts forward in $t$, whereas horizon doubling replaces the smallest observed heat time $t$ by $t^2$.

Differentiating the actual absolutely convergent series gives
$$
C'(t)+C(t)=D(t),\qquad
D(t)=\frac{e^{-t}}{t^2}
-\sum_{n\ge2}(n-1)\Lambda(n)e^{-nt}.
\tag{6}
$$
For $s<t$,
$$
C(s)=e^{t-s}C(t)-J_t(s),\qquad
J_t(s)=\int_s^t e^{u-s}D(u)\,du.
$$
Taking $t=e^{-T}$, the complete horizon increment is
$$
\boxed{\quad
\mathscr A(2T)-\mathscr A(T)
=\frac{e^{2(t-t^2)}-1}{2}C(t)^2
-2C(t)\int_{t^2}^t e^{t-s}J_t(s)\,ds
+\int_{t^2}^tJ_t(s)^2\,ds .
\quad}
\tag{7}
$$
All boundary terms and mixed innovation terms are retained. The forcing $D$ is a difference of positive quantities. No assertion about its actual global sign is made here. Positivity of $\Lambda$ alone does not estimate the last two terms of (7) by a polynomial in $T$ times the already observed energy.

## A proved unconditional finite-horizon bound

There is an unconditional improvement on the elementary exponential bound, but it still has positive exponential scale. A primary quantitative input is Johnston and Yang, *Some explicit estimates for the error term in the prime number theorem*, Theorem 1.4:
$$
|\psi(x)-x|\le0.026x(\log x)^{1.801}
 \exp[-0.1853(\log x)^{3/5}(\log\log x)^{-1/5}],
\qquad x\ge23.
$$
The theorem is stated in the [author paper](https://arxiv.org/html/2204.01980v2#S1.SS2). Only its classical asymptotic consequence is needed below; no numerical constants are optimized.

Set $\omega(L)=L^{3/5}(\log L)^{-1/5}$ for large $L$. The exact Stieltjes integration by parts, including $\sigma$'s atom at one, is
$$
C(t)=t\int_1^\infty(\psi(x)-x)e^{-tx}\,dx.
\tag{8}
$$
On $1\le x\le t^{-1/2}$, the elementary bound
$|\psi(x)-x|\ll x\log(2x)$ gives a contribution $O(\log(2/t))$.
On $x\ge t^{-1/2}$, absorb the logarithmic factor in a smaller positive constant in the exponent and use monotonicity of $\omega(\log x)$. Since
$t\int_0^\infty xe^{-tx}dx=1/t$, (8) gives
$$
|C(t)|\le C_1 t^{-1}\exp[-c_1\omega(\log(1/t))]
\quad(0<t<t_1).
$$
Changing variables $t=e^{-v}$, and splitting the resulting $v$-integral at $T/2$, proves
$$
\boxed{\quad
\mathscr A(T)\le C_2\{1+\exp[T-c_2\omega(T)]\},\qquad
\mathscr A(2T)-\mathscr A(T)
\le C_3\exp[2T-c_3\omega(T)]
\quad(T\ge T_1).
\quad}
\tag{9}
$$
The polynomial factors and the $T$-factor from the split integral are absorbed in a smaller $c_2,c_3>0$. These estimates use the actual centered source and all prime powers. Their loss is still exponential in the logarithmic horizon. They do not prove zero Lyapunov exponent or the polynomial relative bound.

## Where the zero sum remains

None of these calculations replaces the full zeta contribution by a finite zero sample. For $\Re s>1$, the exact Mellin identity is
$$
\int_0^\infty C(t)t^{s-1}dt
=\Gamma(s)\left[-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1}\right].
\tag{10}
$$
At every nontrivial zero $\rho$ of multiplicity $m_\rho$, the continuation on the right has residue $-m_\rho\Gamma(\rho)\ne0$. The entire zero divisor, including multiplicities, is retained by this identity. Any legitimate contour-shift zero expansion must keep all the corresponding residues and its remaining contour term.

The heat-energy argument therefore still applies: a zero with real part $\beta>1/2$ forces
$\limsup T^{-1}\log\mathscr A(T)\ge2\beta-1$.
Estimate (9) is compatible with every such $\beta<1$, so it excludes none. The exact semigroup identity (7) is compatible with that obstruction too; a useful new estimate would have to control its signed innovation at reverse heat scales.

Equations (1)--(9) provide closed actual finite-horizon identities and an unconditional PNT-scale bound. They do not feed the RH-scale CoarsePrimitiveBound. Inverting heat smoothing or bounding its reverse-scale energy would require further quantitative cancellation. Positivity controls the uncentered Goldbach measure and the value of a centered square, but not the centered convolution coefficients or the required polynomial doubling ratio.


## Proof and formal scope

The additive convolution, reverse-time variation-of-constants formula and critical-energy comparison above are written proofs. The PNT input is Johnston and Yang's Theorem 1.4, not a new zero-free region. The existing finite endpoint algebra in [GoldbachSuccessorTransfer.lean](../../formalization/BuildingBlocks/GoldbachSuccessorTransfer.lean) does not formalize the signed convolution, Duhamel formula or the analytic growth estimate here.
