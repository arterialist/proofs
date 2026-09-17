# Same-horizon smooth energy and an RH sign criterion

This is a one-sided localization of the [resonant hard-prefix theorem](signed-smooth-localized-resonance.md). Fix $c>0$, put $L=\log N$, $\ell=\log L$, and $y=cL^2$, and define

$$
F_y(m)=\sum_{\substack{n\le m\\P^+(n)\le y}}\mu(n),\qquad
M(m)=\sum_{n\le m}\mu(n),\qquad
Z_N(f)=(1-e^{-2/N})\sum_{m\le N}e^{-2m/N}f(m)^2.
$$

All asymptotics are as $N\to\infty$ with $c$ fixed. Set $T_N(y)=Z_N(M)-Z_N(F_y)$.

## Claim

For every fixed $c>0$,

$$
\frac{Z_N(F_y)}N\ge
\exp\left(\left[1+\log2+\frac{\log c}{2}-4\pi+o(1)\right]
\frac L\ell\right).\tag{1}
$$

Hence $Z_N(F_y)/N\to\infty$ whenever

$$
c>c_{\rm large}:=\exp(8\pi-2-2\log2).\tag{2}
$$

This threshold is sufficient for this proof; it is not claimed optimal. For **each fixed** $c>c_{\rm large}$, eventual nonpositivity of $T_N(c(\log N)^2)$ is equivalent to RH. The proof below identifies both directions. The sign itself is not proved unconditionally.

The later [exact-horizon Fourier localization](../prime-distribution/signed-smooth-exact-horizon-energy.md) strengthens (1), removes its leading $4\pi$ localization loss, and establishes the sign equivalence for every fixed $c>e^{-2}/4$. The argument here remains a simpler positive-tail method with a weaker constant.

## Proof and the two localization costs

Put $\eta=\ell^{-1/2}$, $D=(\pi+3\eta)L/\ell$, and $L_0=L-D$. Choose $\sigma$ from the *shifted* squarefree saddle equation, and write

$$
L_0=\sum_{p\le y}\frac{\log p}{p^\sigma+1},
\qquad Z=\prod_{p\le y}(1+p^{-\sigma}).
$$

Independently select each prime $p\le y$ with probability $q_p=1/(p^\sigma+1)$. Let $S$ be the logarithm of their product, $K$ their count, and
$A_j=\sum_{p\le y}q_p(1-q_p)(\log p)^j$. Then $\mathbb ES=L_0$. Put $R=\log y=2\ell+O_c(1)$ and $t=1-\sigma=1/2+O_c(1/\ell)$. Prime-number-theorem partial summation and an endpoint Laplace expansion give

$$
A_1=L_0+O_c(L/R^4),\qquad
A_2=L_0(R-1/t)+O_c(L/R^3),
$$

$$
A_0=\frac{L_0}{R}\left(1+\frac1{tR}+\frac2{(tR)^2}
   +O_c(R^{-3})\right).
$$

Replacing $q_p(1-q_p)$ by $p^{-\sigma}$ contributes only a polynomial-size error in $R$. The PNT remainder after these partial summations is $O_c(L\exp(-a\sqrt R))$ for some $a>0$, hence $O_c(L/R^k)$ for each fixed $k$. Expanding $A_1^2/A_2$ yields

$$
A_2=2L\ell(1+O_c(1/\ell)),\qquad
A_0-\frac{A_1^2}{A_2}=\frac{L}{2\ell^3}(1+O_c(1/\ell)).\tag{3}
$$

At $\theta_*=\pi A_1/A_2$, the exact finite Euler product

$$
T=\sum_{P^+(n)\le y}\mu(n)n^{-\sigma-i\theta_*}
$$

satisfies

$$
|T|=Z\exp\left(-[\pi^2/4+o(\eta)]L/\ell^3\right).\tag{4}
$$

To check the error against $\eta=\ell^{-1/2}$, split at $p=y\exp(-\ell^{1/3})$. Below this, total $q_p$-mass is $O_c((L/\ell)\exp(-\ell^{1/3}/3))=o(\eta L/\ell^3)$. Above it, $|\pi-\theta_*\log p|=O_c(\ell^{-2/3})$; the fourth-order term in the logarithm of the characteristic modulus is $O_c((L/\ell)\ell^{-8/3})=o(\eta L/\ell^3)$. The quadratic term is $\pi^2(A_0-A_1^2/A_2)/2$, whose relative error in (3) is $O_c(1/\ell)=o(\eta)$.

Let $H=(\pi+\eta)L/\ell$. Bernstein's inequality, with summands bounded by $\log y=(2+o(1))\ell$, gives

$$
\Pr(|S-L_0|>H)\le
2\exp\left(-[(\pi+\eta)^2/4+O_c(1/\ell)]L/\ell^3\right).\tag{5}
$$

Indeed $A_2=2L\ell(1+O_c(1/\ell))$ by (3), and the bounded-summand correction $(\log y)H/3$ is only $O(L)$, a relative $O(1/\ell)$ of $A_2$. The exponent in (5) exceeds that in (4) by $(\pi\eta/2+o(\eta))L/\ell^3\to\infty$. Thus the tail is negligible relative to $|T|$. Choose a real $C^1$ bump $0\le w\le 1$, equal to one on $|v-L_0|\le H$, supported within an additional $\eta L/\ell$ on each side, and with $|w'|\ll \ell/(\eta L)$. Its upper support endpoint is

$L_0+H+\eta L/\ell=L-\eta L/\ell<L$,

while its lower endpoint is $L-(2\pi+5\eta)L/\ell$. Thus the smoothed finite sum

$$
T_w=\sum_{P^+(n)\le y}\mu(n)n^{-\sigma-i\theta_*}w(\log n)
$$

is supported entirely on $n\le N$ and still satisfies $|T_w|\ge Z\exp(-(\pi^2/4+o(1))L/\ell^3)$.

Stieltjes integration by parts, with zero bump endpoints, gives

$$
T_w=\int_{\mathbb R}F_y(e^v)e^{-(\sigma+i\theta_*)v}
\bigl((\sigma+i\theta_*)w(v)-w'(v)\bigr)\,dv.
$$

Cauchy–Schwarz and the bump length $O(L/\ell)$ show

$$
\int_{\operatorname{supp}w}F_y(e^v)^2e^{-2\sigma v}\,dv
\gg \frac{Z^2}{\operatorname{poly}(L)}
\exp\left(-(\pi^2/2+o(1))L/\ell^3\right).
$$

Partition the log interval into its $O(L/\ell)$ intersections with dyadic blocks. One block has at least the displayed weighted integral divided by a polynomial factor. On it, every $t$ satisfies $N\exp(-(2\pi+5\eta)L/\ell)\le t\le N$; converting $dv=dt/t$ and using the Abel weights for $m\le N$ yields

$$
\frac{Z_N(F_y)}N\gg \frac{N^{2\sigma-1}Z^2}{\operatorname{poly}(L)}
\exp\left(-(2\sigma+1)(2\pi+5\eta)L/\ell
-(\pi^2/2+o(1))L/\ell^3\right).
$$

The dyadic block can be clipped at $N$; $F_y(t)=F_y(\lfloor t\rfloor)$ converts its integral to squared integer prefixes, apart from an irrelevant final fractional cell. As $\eta\to0$, the PNT saddle gives

$\sigma=1/2+\log(2\sqrt c)/(2\ell)+O_c(\ell^{-2})$,

$\log Z=L/(2\ell)+O_c(L/\ell^2)$.

Consequently $(2\sigma-1)L+2\log Z=[1+\log2+(\log c)/2+o(1)]L/\ell$, while the lower support edge costs $(2\sigma+1)(2\pi+o(1))L/\ell=(4\pi+o(1))L/\ell$. This proves (1). The two factors of $\pi$ in the support distance pay for both Bernstein tails; the conversion to energy doubles that distance.

## Conditional sign consequence

Assuming RH, [Soundararajan's Theorem 1](https://arxiv.org/pdf/0705.0723) gives $M(x)\ll\sqrt{x}\exp((\log x)^{1/2}(\log\log x)^{14})$. Hence

$$
\frac{Z_N(M)}N\le\exp(o(L/\ell)).\tag{6}
$$

For every fixed $c>c_{\rm large}$, (1) and (6) imply, **assuming RH**, that $T_N(y)<0$ for all sufficiently large $N$.

Conversely, for every fixed $c>0$, the squarefree Rankin bound gives $|F_y(m)|\le Q(N,y)\le N^{1/2+o(1)}$ uniformly for $m\le N$, hence $Z_N(F_y)\le N^{1+o(1)}$. If $T_N(y)\le0$ eventually, then $Z_N(M)\le Z_N(F_y)\le N^{1+o(1)}$. The dyadic Abel-energy/Mellin argument in the [smooth transport boundary note](../dynamics-and-feedback/log-squared-smooth-transport-boundary.md) implies RH. Thus for **each fixed** $c>c_{\rm large}$,

$$
\mathrm{RH}\quad\Longleftrightarrow\quad
T_N(c(\log N)^2)\le0\text{ for every sufficiently large integer }N.
\tag{7}
$$

The forward implication gives strict negativity. For every fixed $c<e^{-2}/4$, the support argument in the boundary note gives positive transport on an infinite sequence, so (7) does not extend to all $c>0$. The result is an RH-equivalent sign formulation, not an unconditional RH proof. The smoothness cutoff remains fixed throughout each energy sum.
