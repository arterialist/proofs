# Signed smooth energy at the exact log-squared horizon

Fix $c>0$ and let $N\to\infty$ through integers. Write $L=\log N$, $\ell=\log L$, and $y=cL^2$. Throughout an energy sum, $y$ is held fixed. Define

$$
F_y(x)=\sum_{\substack{n\le x\\P^+(n)\le y}}\mu(n),\qquad
M(x)=\sum_{n\le x}\mu(n),\qquad
Z_N(f)=(1-e^{-2/N})\sum_{m\le N}e^{-2m/N}f(m)^2,
$$

and $T_N(y)=Z_N(M)-Z_N(F_y)$.

## Exact-horizon lower bound

For every fixed $c>0$,

$$
\log\frac{Z_N(F_{cL^2})}{N}\ge
\left(1+\log 2+\frac12\log c+o(1)\right)\frac{L}{\ell}.
\tag{1}
$$

Unlike the [earlier one-sided estimate](signed-smooth-same-horizon-large-constant.md), this bound has no fixed leading-order localization loss. Its proof uses a complex stationary phase and a compact Fourier filter; a positive-probability tail bound alone is too weak at this scale.

Let $c_*=e^{-2}/4$. The coefficient in (1) is positive precisely when $c>c_*$. For **each fixed** $c>c_*$, the following is an RH-equivalent sign criterion:

$$
\mathrm{RH}\quad\Longleftrightarrow\quad
T_N(c(\log N)^2)\le0
\quad\text{for every sufficiently large integer }N.
\tag{2}
$$

The forward implication gives strict negativity. Neither (1) nor (2) proves that sign unconditionally. Equality $c=c_*$ is not covered by the positive leading coefficient. For $c<c_*$, the [squarefree support argument](log-squared-smooth-transport-boundary.md) rules out eventual nonpositivity.

## The resonant finite Euler product

Choose $\sigma$ from the squarefree saddle equation

$$
L=\sum_{p\le y}\frac{\log p}{p^\sigma+1}.
$$

Put $t=\log y$, $a_p=p^{-\sigma}$, $q_p=a_p/(1+a_p)$, $u_p=\log p$, $Z=\prod_{p\le y}(1+a_p)$, and

$$
P(\theta)=\prod_{p\le y}(1-a_pe^{-i\theta u_p}),
\qquad H(\theta)=\log|P(\theta)|,
\qquad A_j=\sum_{p\le y}q_p(1-q_p)u_p^j.
$$

All these products and sums are finite. The prime number theorem, with its standard zero-free-region error and partial summation, gives

$$
\sigma=\frac12+\frac{\log2+\frac12\log c}{2\ell}+O_c(\ell^{-2}),
\quad A_2\sim Lt,
\quad R:=A_0-\frac{A_1^2}{A_2}\sim\frac{4L}{t^3},
\quad\log Z=\frac{L}{t}+O_c(L/t^2).
\tag{3}
$$

The error from replacing $q_p(1-q_p)$ by $p^{-\sigma}$ is polynomial in $t$, while the main terms are of order $L/t^j$. Under the corresponding endpoint prime measure, $t-\log p$ tends with every fixed moment to an exponential variable of mean $2$ and variance $4$.

Set $\theta_*=\pi A_1/A_2$. For $\delta_p=\pi-\theta_*u_p$, the exact identity

$$
\left|1-q_p+q_pe^{i\delta_p}\right|^2
=1-4q_p(1-q_p)\sin^2(\delta_p/2)
$$

and the saddle relation $\sum_pq_p(1-q_p)\delta_pu_p=0$ give

$$
H(\theta_*)=\log Z-\frac{\pi^2}{2}R+O_c(L/t^5),
\qquad H'(\theta_*)=O_c(L/t^3).
\tag{4}
$$

Here the fourth-order error is $O_c(L/t^5)$: on $p>y\exp(-t^{1/3})$, $|\delta_p|\ll(1+t-\log p)/t$ and the fourth endpoint moment is bounded; the omitted lower primes contribute $o(L/t^K)$ for each fixed $K$. On a fixed small neighborhood of $\pi/t$, the exact Euler-factor second derivative is $-(1+o(1))Lt$. Thus a unique local maximum $\theta_0=\theta_*+O_c(t^{-4})$ exists there, with

$$
\log\frac{Z}{|P(\theta_0)|}
=\left(2\pi^2+o(1)\right)\frac{L}{t^3}.
\tag{5}
$$

The maximum at $-\theta_0$ is its conjugate. These are the only two near-maximal phases in the bounded window needed below. For clarity, fix $\eta=10^{-4}$ and $r=L/t^3$. For all sufficiently large $N$:

* If $|\theta\mp\theta_0|\le\eta/(2t)$, then $H(\theta)\le H(\theta_0)-(Lt/4)(\theta\mp\theta_0)^2$.
* If $|\theta|\le104/t$ and $\theta$ is outside those two neighborhoods, then $H(\theta)\le H(\theta_0)-r$.

Here is a quantitative verification of the second assertion. For each fixed odd $j$ with $|j|\le35$, the same exact-factor calculation at $\theta_j^*=j\pi A_1/A_2$ yields a local maximum $\theta_j=\theta_j^*+O_j(t^{-4})$ of height

$$
H(\theta_j)=\log Z-\frac{j^2\pi^2}{2}R+O_j(L/t^5).
$$

The $|j|\ge3$ peaks are lower than the first two by more than $100r$ eventually. Outside fixed $\eta/(2t)$ neighborhoods of all odd phases, the top-prime factors have a fixed phase gap from their parity maxima, costing $\gg_\eta L/t\gg r$. Within a first-phase neighborhood, strict curvature supplies the asserted loss from $\theta_0$. This uses the exact factors throughout; a coarse approximation to $H$ with error $O(L/t^2)$ would not resolve the $r$ scale.

## A compact filter below $\log N$

Let $T=P(\theta_0)$. Define the complex inclusion weights

$$
r_p=\frac{-p^{-\sigma-i\theta_0}}{1-p^{-\sigma-i\theta_0}},
\quad m=\sum_{p\le y}r_pu_p,
\quad V=\sum_{p\le y}r_p(1-r_p)u_p^2.
$$

Because $H'(\theta_0)=\operatorname{Im}m=0$, the number $m$ is **exactly real**. Endpoint moments and the quadratic expansion of $r_p$ give

$$
D:=L-m=\left(2\pi^2+o(1)\right)\frac{L}{t^2},
\quad \operatorname{Re}V\sim Lt,
\quad |\operatorname{Im}V|/\operatorname{Re}V=o(1).
\tag{6}
$$

Take $W=D/2$, $k=\lceil10L/t^3\rceil$, $h=W/(4k)$, and $\rho_h=(2h)^{-1}\mathbf1_{[-h,h]}$. Define

$$
g=\mathbf1_{[-3W/4,\,3W/4]}*\rho_h^{*k},
\qquad w(v)=g(v-m).
$$

Then $0\le w\le1$, $w=1$ on $[m-W/2,m+W/2]$, and

$$
\operatorname{supp}w\subset
[L-3D/2,L-D/2]\subset(-\infty,L).
\tag{7}
$$

With $\widehat g(\nu)=\int g(v)e^{-i\nu v}\,dv$,

$$
\widehat g(\nu)=\frac{2\sin(3W\nu/4)}{\nu}
\operatorname{sinc}(h\nu)^k,
\quad \|\widehat g\|_1=O(t),
\quad h/t\to\pi^2/40.
\tag{8}
$$

The exact Fourier inversion identity for the *signed* localized sum is

$$
\frac{T_w}{T}
=\frac1{2\pi}\int_{\mathbb R}\widehat g(\nu)e^{im\nu}
\frac{P(\theta_0+\nu)}{P(\theta_0)}\,d\nu,
\qquad
T_w=\sum_{P^+(n)\le y}\mu(n)n^{-\sigma-i\theta_0}w(\log n).
\tag{9}
$$

Near $\nu=0$, exact stationarity cancels the linear phase:

$$
e^{im\nu}\frac{P(\theta_0+\nu)}{P(\theta_0)}
=\exp\!\left(-V\nu^2/2+O(Lt^2|\nu|^3)\right).
\tag{10}
$$

On $|\nu|\le t/\sqrt{Lt}$, the cubic remainder contributes $o(1)$ even after the $O(t)$ transform norm; replacing $V$ by $\operatorname{Re}V$ also costs $o(1)$. The resulting Gaussian integral equals $\mathbb E g(X)=1-o(1)$ for $X\sim N(0,\operatorname{Re}V)$, since $W^2/\operatorname{Re}V\asymp L/t^5\to\infty$. From this central window to $\eta/(2t)$, exact local curvature makes the integral $o(1)$.

For all other frequencies with $|\nu|\le100/t$, the fixed-index resonance estimate bounds the product by $|T|e^{-r}$, except near the conjugate phase $\nu=-2\theta_0$. There, $|h\nu|\in[1.5,1.6]$ eventually, so $|\operatorname{sinc}(h\nu)|\le2/3$ and (8) suppresses that entire contribution by $O((2/3)^k)$. Finally, for $|\nu|\ge100/t$,

$$
\int_{|\nu|\ge100/t}|\widehat g(\nu)|\,d\nu
\le\frac4k(100h/t)^{-k}.
$$

The exact global bound $|P(\theta)|\le Z$, $100h/t\ge24$ eventually, and $Z/|T|\le e^{21r}$ make the normalized high-frequency integral at most $e^{-10r}$. Thus every noncentral contribution in (9) is $o(1)$, proving

$$
T_w=(1+o(1))T.
\tag{11}
$$

This is a localized signed resonance, not an assertion that a complex coefficient distribution has positive probability. It also makes no separate claim about unsmoothed hard signed tails.

## Abel energy and the RH criterion

For $s=\sigma+i\theta_0$, Stieltjes integration by parts gives

$$
T_w=\int_{\operatorname{supp}w}F_y(e^v)e^{-sv}
\bigl(sw(v)-w'(v)\bigr)\,dv.
$$

The filter satisfies $\int|sw-w'|^2dv=O(W)$. Cauchy–Schwarz and (11) therefore yield

$$
\int_{\operatorname{supp}w}F_y(e^v)^2e^{-2\sigma v}\,dv
\gg |T|^2/W.
$$

Because the support lies in $[L-3D/2,L-D/2]$, converting $dv=dx/x$ to the weighted integer sum in $Z_N$ costs only $e^{-O(D)}$; the remaining factors give

$$
\frac{Z_N(F_y)}N
\ge N^{2\sigma-1}Z^2\exp[-O_c(L/t^2)].
\tag{12}
$$

Taking logarithms of (12) and using (3) proves (1).

Under RH, [Soundararajan's Theorem 1](https://arxiv.org/pdf/0705.0723) yields $Z_N(M)/N\le\exp(o(L/\ell))$. When $c>c_*$, (1) makes $Z_N(F_y)/N\to\infty$ at scale $\exp(\kappa_cL/\ell)$, so $T_N(y)<0$ eventually. Conversely, the unconditional squarefree Rankin estimate gives $Z_N(F_y)\le N^{1+o(1)}$ for any fixed $c>0$. If $T_N(y)\le0$ eventually, then $Z_N(M)\le N^{1+o(1)}$, which implies RH by the Abel-energy/Mellin argument in the [transport boundary note](log-squared-smooth-transport-boundary.md). This proves (2).

The prime-number-theorem saddle and the exponent-two smoothness boundary have classical antecedents in [Hildebrand's RH criterion](https://doi.org/10.1112/S0025579300012481) and [Hildebrand--Tenenbaum's saddle method](https://tenenb.perso.math.cnrs.fr/PPP/Psi%2B.pdf). The proof above concerns the signed smooth Möbius energy at one fixed observation horizon. Its publication priority has not been established by this note; the central arithmetic sign in (2) remains open.
