# Localized resonant lower bounds for signed smooth prefixes

Fix $c>0$. Put $L=\log N$, $\ell=\log L$, $y=cL^2$, and define

$$
F_y(x)=\sum_{n\le x,\ P^+(n)\le y}\mu(n),\qquad
\Psi(x,y)=\#\{n\le x:P^+(n)\le y\}.
$$

Let $\sigma$ be the unique positive solution of

$$
L=\sum_{p\le y}\frac{\log p}{p^\sigma+1},
$$

and set $Z=\prod_{p\le y}(1+p^{-\sigma})$. All asymptotic statements below hold as $N\to\infty$, with $c$ fixed. Write $r=L/\ell^3$ and $a=\pi^2/4$.

**Theorem (actual hard prefixes, with fixed smoothness bound).** There is a real $x$ with

$$
N\exp(-4L/\ell)\le x\le N\exp(4L/\ell)
$$

such that

$$
|F_y(x)|\ge x^\sigma Z\exp\{-(a+o(1))r\}
       \ge \Psi(x,y)\exp\{-(a+o(1))r\}.
\tag{1}
$$

There is also an integer $B$ satisfying $\log B=L+O(L/\ell)$ for which, with the fixed $y=c(\log N)^2$,

$$
\frac{Z_B(F_y)}{B}\ge
 B^{2\sigma-1}Z^2\exp\{-(2a+o(1))r\},
\qquad
Z_B(f)=(1-e^{-2/B})\sum_{m\le B}e^{-2m/B}f(m)^2.
\tag{2}
$$

Here replacing the displayed $B$ by a nearby $X$ in its prefactor changes the exponent by only $O(1)$. More precisely the proof constructs a dyadic $X=2^k$ with $\log X=L+O(L/\ell)$ and $B=2X$, then obtains $Z_B(F_y)/B \ge  X^{2\sigma-1} Z^2 \exp{-(2a+o(1))r}$.

Consequently, if

$$
A_c=\frac{1+\log 2}{2}+\frac{\log c}{4},
$$

then the witness in (1) satisfies

$$
|F_y(x)|\ge\sqrt{x}\,\exp\{(A_c+o(1))L/\ell\},
\tag{3}
$$

and the energy witness satisfies

$$
Z_B(F_y)/B\ge\exp\{(2A_c+o(1))L/\ell\}.
\tag{4}
$$

For $c=1$, $A_c=(1+\log 2)/2>0$. Thus both actual signed-prefix amplitude and its Abel energy exceed their square-root benchmarks at some nearby horizon. The same conclusion holds for every fixed $c>e^{-2}/4$.

**Proof.** Independently select each prime $p\le y$ with probability $q_p=p^{-\sigma}/(1+p^{-\sigma})$. Let $K$ count selected primes and $S$ sum their logarithms. Then $\mathbb E S=L$, $\operatorname{Var} S=A_2\sim 2L \ell$, and every summand of $S$ is bounded by $\log y\sim 2\ell$. Put

$$
A_j=\sum_{p\le y}q_p(1-q_p)(\log p)^j\quad(j=0,1,2),
\qquad \theta_*=\pi A_1/A_2.
$$

The exact finite Euler product is

$$
T:=\sum_{P^+(n)\le y}\mu(n)n^{-\sigma-i\theta_*}
 =Z\,\mathbb E[(-1)^K e^{-i\theta_*S}].
$$

The covariance computation in the [prime-count/log-size resonance note](smooth-prime-count-log-size-resonance.md) gives $A_0-A_1^2/A_2\sim L/(2\ell^3)$. For completeness, write $\delta_p=\pi-\theta_* \log p$. The identity

$$
|1-q_p+q_pe^{i\delta_p}|^2
 =1-4q_p(1-q_p)\sin^2(\delta_p/2)
$$

shows that the primes $p>y \exp(-\ell^{1/3})$ contribute

$$
\log|T/Z|=-\tfrac12\sum_{p\le y}q_p(1-q_p)\delta_p^2+o(r).
$$

Indeed $max |\delta_p|=O(\ell^{-2/3})$ in this top range, so the fourth-order remainder is $o(r)$; the omitted primes have total $q_p$-mass $o(r)$ by the prime number theorem. The quadratic sum is exactly $\pi^2(A_0-A_1^2/A_2)$. Thus

$$
|T|=Z\exp\{-(a+o(1))r\}.\tag{5}
$$

Let $H=4L/\ell$, $a_N=Ne^{-H}$, and $b_N=Ne^H$. Bernstein's inequality gives

$$
\Pr(|S-L|\ge H)
\le 2\exp\left\{-\frac{H^2}{2(A_2+(\log y)H/3)}\right\}
=\exp\{-(4+o(1))r\}.\tag{6}
$$

The absolute value of the omitted weighted coefficients outside $(a_N,b_N]$ is at most $Z$ times (6). Since $4>a$, the truncated twisted sum

$$
W=\sum_{\substack{a_N<n\le b_N\\P^+(n)\le y}}\mu(n)n^{-\sigma-i\theta_*}
$$

still satisfies $|W|\ge Z \exp{-(a+o(1))r}$. This is where the global Bernoulli characteristic is converted to a statement about a **hard cutoff**. A central-limit-sized window would not suffice: its tails are much larger than (5).

Set $s=\sigma+i \theta_*$ and $M=max_{a_N\le t\le b_N}|F_y(t)|/t^\sigma$. Abel summation gives the exact identity

$$
W=F_y(b_N)b_N^{-s}-F_y(a_N)a_N^{-s}
  +s\int_{a_N}^{b_N}F_y(t)t^{-s-1}\,dt.
$$

Hence $|W|\le (2+2H|s|)M$. Since $\log(2+2H|s|)=O(\ell)=o(r)$, (1) follows. Rankin gives $Q(x,y)\le x^\sigma Z$ for the squarefree count. For the full smooth count,

$$
\Psi(x,y)\le x^\sigma\prod_{p\le y}(1-p^{-\sigma})^{-1}
=x^\sigma Z\prod_{p\le y}(1-p^{-2\sigma})^{-1}.
$$

As $\sigma=1/2+O_c(1/\ell)$, the logarithm of the last product is $O_c(\log \ell)=o(r)$, proving the second inequality in (1).

For energy, choose a $C^1$ function $w(v)$ supported on $|v-L|\le 5L/\ell$, equal to one for $|v-L|\le 4L/\ell$, with $|w'|\ll \ell/L$. Define

$$
T_w=\sum_{P^+(n)\le y}\mu(n)n^{-s}w(\log n).
$$

The same tail estimate (6) gives $|T_w|\ge Z \exp{-(a+o(1))r}$. Stieltjes integration by parts, with both endpoint terms zero, yields

$$
T_w=\int F_y(e^v)e^{-sv}\{s w(v)-w'(v)\}\,dv.
$$

Cauchy–Schwarz and $\int |sw-w'|^2dv \ll  L/\ell$ imply

$$
\int_{|v-L|\le5L/\ell}|F_y(e^v)|^2e^{-2\sigma v}\,dv
\gg \frac{Z^2}{L/\ell}\exp\{-(2a+o(1))r\}.
\tag{7}
$$

Partition this log interval into the intersecting dyadic blocks $[\log X, \log(2X)]$, where $X=2^k$. There are $O(L/\ell)$ of them, so one block contributes at least $Z^2 \exp{-(2a+o(1))r}$ after absorbing polynomial factors. On that block,

$$
\int_X^{2X}F_y(t)^2\,dt
\ge X^{2\sigma+1}Z^2\exp\{-(2a+o(1))r\}.
$$

Take $B=2X$. Because $F_y(t)=F_y(floor t)$ and the integrand is nonnegative, the integral is bounded by $\sum_{m\le B}F_y(m)^2$. Also $(1-e^{-2/B})e^{-2m/B}\gg 1/B$ for $m\le B$. Therefore $Z_B(F_y)/B\gg B^{-2} \int_X^{2X}F_y(t)^2dt$, giving (2).

Finally, the prime number theorem in the squarefree saddle equation gives

$$
\sigma=\frac12+\frac{\log(2\sqrt c)}{2\ell}+O_c(\ell^{-2}),
\qquad \log Z=\frac{L}{2\ell}+O_c(L/\ell^2).
$$

Thus $\sigma L+\log Z-L/2=(A_c+o(1))L/\ell$. Changing $L$ to $\log x$ or $\log B$ within $O(L/\ell)$ changes the excess over the square-root benchmark by $O_c(L/\ell^2)$, proving (3) and (4).

**Boundary and literature caveats.** The theorem keeps $y=c(\log N)^2$ fixed while varying the prefix horizon. Its witnesses satisfy $y/(\log x)^2=c+O_c(1/\ell)$ and $y/(\log B)^2=c+O_c(1/\ell)$; it does **not** prove the same lower bound on the exact diagonal $y=c(\log x)^2$ with a fixed prescribed $c$. The bump argument proves an energy lower bound without assuming a local smooth-number count.

The argument does not put the energy witness at the **prescribed** horizon $N$. To truncate the twisted sum below $N$ by the same absolute-tail method, a tilted mean $L-D$ needs $D>(\pi+o(1))L/\ell$: Bernstein's upper-tail exponent is asymptotically $D^2/(4L \ell)$, and it must beat the resonant exponent $(\pi^2/4)L/\ell^3$. A lower-tail cutoff is also needed, so the extracted energy may lie anywhere across a wider interval below $N$. Its location is not controlled closely enough by this proof to infer $Z_N(F_{(\log N)^2})/N>1$ at $c=1$. This is a limitation of the localization argument, not a claim that such an energy bound is false.

The uniform estimate of de la Bretèche and Tenenbaum, *Friable averages of oscillating arithmetic functions*, Cor. 1.4, contains both an $\exp[-c_0 u/(\log 2u)^2]$ term and an $\exp[-(\log y)^r]$ term. At $y\sim (\log x)^2$, the second term dominates, so this theorem should not be described as matching the effective published upper bound. It does rule out a hypothetical uniform pure bound $|F_y(x)|\le \Psi(x,y) \exp[-(\pi^2/2+\varepsilon)u/(\log u)^2]$ throughout these nearby pairs. Hildebrand's 1984 paper on smooth numbers and RH concerns the unsigned $\Psi$, not a signed-prefix lower bound. No priority claim is made here.

References: [de la Bretèche--Tenenbaum (2024)](https://arxiv.org/pdf/2207.04777); [Hildebrand (1984)](https://doi.org/10.1112/S0025579300012481).
