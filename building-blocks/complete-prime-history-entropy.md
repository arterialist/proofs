# Complete geometric prime histories and their entropy crossover

For each prime $p\le X$, independently let

$$
\Pr(\nu_p=1)=p^{-1},\qquad
\Pr(\nu_p=-j)=(1-p^{-1})^2p^{-j},\quad j\ge0.
$$

These are the squared coefficients of the complete Euler unitary, as derived in [the causal-history construction](causal-history-overflow.md). Put $S_X=\sum_{p\le X}\nu_p\log p$, $\mathcal L_X(c)=\mathbb E(-S_X-c)_+$ and $\ell=\log X$. The full geometric sum gives, for real $t<1$,

$$
M_p(t)=\mathbb Ee^{-t\nu_p\log p}
=\frac{1-2/p+p^{-1-t}}{1-p^{t-1}},\qquad
K_X(t)=\sum_{p\le X}\log M_p(t).
$$

The moment domain is exactly $t<1$, already forced by $p=2$. Each local mean is zero and the variance is $2(\log p)^2/(p-1)$. For $0<t<1$, integration of the Chernoff bound gives $\mathcal L_X(c)\le t^{-1}e^{K_X(t)-tc}$.

The following unconditional entropy asymptotic retains every geometric depth.
Locally uniformly for $\kappa>0$,
$$
\boxed{
\log\mathcal L_X(\kappa X)
=-\kappa X+\frac X\ell
\big[(\kappa+1)\log(\kappa+1)-\kappa\log\kappa\big]
+o(X/\ell).}
\tag{1}
$$
This uses the actual finite coefficient law and the PNT. It is not obtained by transferring a remote tail of the limiting Dickman law.

Fix a compact interval $J\subset(0,\infty)$, set $t=1-v/\ell$, $v\in J$, and write $z_p=\log p/\ell$.
The exact MGF above gives uniformly on $J$
$$
\begin{aligned}
K_X(1-v/\ell)&=\frac X\ell[F(v)+o(1)],
&F(v)&=-\log(1-e^{-v}),\\
K_X'(1-v/\ell)&=X[m(v)+o(1)],
&m(v)&=(e^v-1)^{-1},\\
K_X''(1-v/\ell)&=X\ell[q(v)+o(1)],
&q(v)&=e^v/(e^v-1)^2.
\end{aligned}
\tag{2}
$$
Here is the prime-sum justification, including the small-prime endpoint.
For $p\ge3$, put $b_p=1-2/p$, $a_p=p^{-1-t}$.
Then $b_p\ge1/3$, $a_p\le e^{\sup J}p^{-2}$, and the numerator contribution
$R_X=\sum\log(b_p+a_p)$ satisfies
$$
R_X=O_J(\log\log X),\qquad
R_X'=O_J(1),\qquad R_X''=O_J(1).
$$
Indeed its first two derivatives are
$-(\log p)a_p/(b_p+a_p)$ and
$(\log p)^2a_pb_p/(b_p+a_p)^2$.
At $p=2$, the numerator is exactly $2^{-1-t}$, with logarithmic derivative $-\log2$ and second derivative zero, so this endpoint is included.

The denominator sums are exactly
$$
\sum_{p\le X}-\log(1-e^{-vz_p}),\quad
\ell\sum_{p\le X}\frac{z_p}{e^{vz_p}-1},\quad
\ell^2\sum_{p\le X}
\frac{z_p^2e^{vz_p}}{(e^{vz_p}-1)^2}.
$$
The final two summands extend continuously to $z=0$, with values $1/v$, $1/v^2$, uniformly for $v\in J$.
The PNT gives $\pi(X)\sim X/\ell$ and
$\pi(X^{1-\eta})=o(\pi(X))$ for each fixed $\eta>0$.
Thus their normalized prime averages converge to the values at $z=1$.
In the first sum the terms with $p\le\sqrt X$ contribute at most
$O_J(\sqrt X\log\ell)=o(X/\ell)$, using the bound
$C_J+\log(\ell/\log p)$. The remaining terms form a uniformly continuous family on $z\in[1/2,1]$, so the same concentration argument applies. This proves (2) while retaining the full geometric denominators.

For the upper bound in (1), put
$v_\kappa=\log(1+1/\kappa)$, $t_\kappa=1-v_\kappa/\ell$.
Chernoff and (2) give
$$
\log\mathcal L_X(\kappa X)
\le-\kappa X+\frac X\ell[\kappa v_\kappa+F(v_\kappa)]
+o(X/\ell).
\tag{3}
$$
All errors are uniform on compact $\kappa$-intervals inside $(0,\infty)$.

For a matching lower bound let $w=X/\ell^2$, and choose the exact tilt
$t_X\in(0,1)$ with
$$
K_X'(t_X)=\kappa X+w.
$$
It exists uniquely because $K_X'$ is strictly increasing,
$K_X'(0)=0$, and $K_X'(t)\to\infty$ as $t\uparrow1$.
Writing $t_X=1-v_X/\ell$, equation (2) and monotonicity show
$v_X\to v_\kappa$ uniformly on compact $\kappa$-sets.
Explicitly, choose fixed $v_-<v_+$ with
$m(v_-)>\sup\kappa$ and $m(v_+)<\inf\kappa$.
The derivative estimate brackets every $v_X$ in this compact interval, and the strict monotonicity of $m$ identifies its uniform limit.

Let $W_X=-S_X$ and change measure by
$d\mathbb P_{t_X}/d\mathbb P=\exp[t_XW_X-K_X(t_X)]$.
Its mean is $\kappa X+w$ and its variance is
$K_X''(t_X)=O(X\ell)$.
Chebyshev therefore gives
$$
\mathbb P_{t_X}\{\kappa X+w/2\le W_X\le\kappa X+3w/2\}
\ge1-O(\ell^5/X).
$$
On this event the overshoot is at least $w/2$. Consequently
$$
\mathcal L_X(\kappa X)\ge\frac w2
\exp[K_X(t_X)-t_X\kappa X-3t_Xw/2]
[1-O(\ell^5/X)].
$$
Since $w=o(X/\ell)$ and $\log w=o(X/\ell)$, (2) now matches (3). Finally
$\kappa v_\kappa+F(v_\kappa)
=(\kappa+1)\log(\kappa+1)-\kappa\log\kappa$, proving (1).
No local limit theorem or nonlattice assumption was needed.

The exponential tilt describes the retained histories explicitly. Primes remain independent and have exact tilted laws
$$
\Pr_{t_X}(\nu_p=1)=\frac{p^{-1-t_X}}{M_p(t_X)},\qquad
\Pr_{t_X}(\nu_p=-j)=
\frac{(1-p^{-1})^2p^{-(1-t_X)j}}{M_p(t_X)},\quad j\ge0.
$$
For primes with $\log p/\log X\to1$, the positive mass vanishes and the negative depth converges to a geometric law with ratio
$\kappa/(1+\kappa)$ and mean $\kappa$.
Its entropy, obtained directly by summing minus probability times logarithmic probability, is
$(\kappa+1)\log(\kappa+1)-\kappa\log\kappa$.
There are asymptotically $X/\log X$ prime generators in this counting regime. Thus the second-order term records collective geometric-history occupation, even though a single repeated-power event already establishes the exponential lower-rate obstruction for a single admitted prime. This is an exact exponential-tilt description; no equivalence with conditioning on the stop-loss event is claimed.

The argument is a written application of exponential tilting and Chebyshev concentration to the exact finite geometric law. Its only prime asymptotic is the classical PNT; [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689) supplies more than the qualitative estimate needed here. No remote-tail convergence from a limiting law, RH premise, or Lean theorem is used.
