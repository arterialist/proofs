# Prime-factor count and log-size nearly lock at the smooth saddle

Fix $c>0$, write $L=\log N$, $\ell=\log L$, and set
$y=cL^2$. Let $\sigma$ minimize the squarefree-smooth Rankin
objective from [the cutoff note](../dynamics-and-feedback/log-squared-smooth-transport-boundary.md).
Select each prime $p\le y$ independently with probability

$$
q_p=\frac{p^{-\sigma}}{1+p^{-\sigma}},
$$

and let $K$ be the number selected and $S$ the logarithm of their
product. The saddle equation gives $\mathbb ES=L$. The exact finite
variance matrix has entries

$$
A_j=\sum_{p\le y}q_p(1-q_p)(\log p)^j
\quad(j=0,1,2),
$$

where $A_0=\operatorname{Var}K$,
$A_1=\operatorname{Cov}(K,S)$, and
$A_2=\operatorname{Var}S$.

**Covariance theorem.** As $N\to\infty$,

$$
A_0\sim\frac{L}{2\ell},\qquad A_1\sim L,
\qquad A_2\sim2L\ell,
$$

and the best linear-prediction residual satisfies

$$
\min_{b\in\mathbb R}\operatorname{Var}(K-bS)
=A_0-\frac{A_1^2}{A_2}
\sim\frac{L}{2\ell^3},
\qquad
1-\operatorname{Corr}(K,S)^2\sim\ell^{-2}.\tag{1}
$$

This is a statement about linear prediction, **not** conditional
variance. In fact $\operatorname{Var}(K\mid S)=0$ exactly: the real
number $S$ identifies the squarefree integer by unique factorization.
Equation (1) quantifies a simpler fact: at this saddle, even a *linear*
estimate from log-size predicts the prime-factor count almost perfectly.

For the proof, put $\alpha=1-\sigma$ and $t=\log y$. The PNT and the
saddle equation give $\alpha=1/2+O_c(1/\ell)$ and
$U=y^\alpha/\alpha=L+o(L/\ell^k)$ for every fixed $k$. Partial
summation then gives

$$
\begin{aligned}
A_0&=U\left(\frac1t+\frac1{\alpha t^2}
                  +\frac2{\alpha^2t^3}+O_c(t^{-4})\right),\\
A_1&=U+o(L/t^k),\\
A_2&=U\left(t-\frac1\alpha\right)+o(L/t^k).
\end{aligned}
$$

Subtracting $A_1^2/A_2$ leaves
$U/(\alpha^2t^3)(1+O_c(t^{-1}))$, proving (1).

There is also an exact parity diagnostic. Let

$$
\Phi(\theta)=\mathbb E[(-1)^K e^{-i\theta S}]
=\prod_{p\le y}\frac{1-p^{-\sigma-i\theta}}{1+p^{-\sigma}},
\qquad \theta_*=\pi A_1/A_2.
$$

The product formula and a prime-weighted Taylor expansion near the
top of the prime range give

$$
\log|\Phi(\theta_*)|
=-\left(\frac{\pi^2}{4}+o(1)\right)\frac L{\ell^3},
\qquad
\log|\Phi(0)|=-(1+o(1))\frac L\ell.\tag{2}
$$

To check the first estimate without a Gaussian assumption, set
$\delta_p=\pi-\theta_*\log p$ and use the exact identity
$|1-q_p+q_pe^{i\delta_p}|^2
=1-4q_p(1-q_p)\sin^2(\delta_p/2)$.
For $p>y e^{-\ell^{1/3}}$, the phase $\delta_p=o(1)$ uniformly;
the omitted primes have exponentially small weight on the scale
$L/\ell^3$. The quadratic term is
$-\pi^2(A_0-A_1^2/A_2)/2$, and the fourth-order remainder is
$o(L/\ell^3)$. The second estimate follows by expanding the
zero-frequency Euler factors.

At $c=1$, the unsigned support exceeds $\sqrt N$ by a factor
$\exp[(\frac{1+\log2}{2}+o(1))L/\ell]$. The resonant parity decay
in (2) has exponent only $L/\ell^3$. It cannot, on its own, pay that
support excess. The marginal decay at $\theta=0$ cannot be substituted
for the sharp cutoff $S\le L$, because the cutoff couples parity to
log-size. This calculation gives **no** upper or lower bound for the
actual signed prefix $F_y(N)$ or its Abel energy. It identifies a
specific reason that independent-sign heuristics miss the critical
coupling.

This is written analysis using the PNT and elementary independent
Bernoulli identities. It is not Lean-formalized and makes no claim of
priority over general smooth-number saddle theory.
