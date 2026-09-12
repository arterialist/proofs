# Stable scattering for the centered divisor score

This is a written proof using the [semilocal negative-frequency Hardy convention](semilocal-weighted-scattering.md). It is not a Lean formalization.

Let $\tau(n)$ count the positive divisors of $n$, let $\gamma$ be Euler's constant, and put

$$
\bar c(n)=\tau(n)-\log n-2\gamma,\qquad
B(x)=\sum_{n\le x}\bar c(n).
$$

With $D(N)=\sum_{n\le N}\tau(n)$ and $H(N)=\log(N!)-D(N)+2\gamma N$, the exact prefix is

$$
B(x)=-H(\lfloor x\rfloor).
\tag{1}
$$

The score includes $\bar c(1)=1-2\gamma$. Define the real phase and unitary multiplier, for every real $X\ge2$, by

$$
\Phi_X(t)=2(1-2\gamma)t+
2\sum_{2\le n\le X}\frac{\bar c(n)}{\sqrt n\log n}\sin(t\log n),
\qquad U_X=M_{e^{i\Phi_X}}.
\tag{2}
$$

The linear term is the continuous value of the $n=1$ summand. The endpoint $n=X$ is included when $X$ is an integer.

Use the same Hardy projection $P$ on $L^2(\mathbb R,dt)$ as the prime scattering construction. For a fixed real Schwartz function $\chi$, write

$$
N_\chi(U)=\|M_\chi(P-U^*PU)\|_1.
$$

Then the elementary hyperbola estimate gives

$$
N_\chi(U_X)=O_\chi\bigl((1+\log X)^{5/2}\bigr).
\tag{3}
$$

More generally, suppose

$$
|B(x)|\le Cx^\theta(\log x)^m\quad(x\ge2),
\qquad 0<\theta<\tfrac12,\quad m\ge0.
\tag{4}
$$

There is then a smooth real phase $\Phi_\infty$, with $\Phi_X\to\Phi_\infty$ locally smoothly, such that $U_\infty=M_{e^{i\Phi_\infty}}$ satisfies

$$
\begin{aligned}
N_\chi(U_\infty)&<\infty,\\
N_\chi(U_\infty U_X^*)&\le
C_{\chi,C,\theta,m}X^{\theta-1/2}(\log X)^{m+3/2},\\
\|M_\chi(\Delta(U_\infty)-\Delta(U_X))\|_1
&=N_\chi(U_\infty U_X^*),\qquad \Delta(U)=P-U^*PU.
\end{aligned}
\tag{5}
$$

In particular the classical divisor estimates imply, unconditionally,

$$
N_\chi(U_\infty U_X^*)=O_\chi\bigl(X^{-1/6}(\log X)^{3/2}\bigr).
\tag{6}
$$

The result concerns the centered divisor-averaged score in the same localized trace topology as the prime problem. It provides no inverse estimate for divisor averaging.

## Arithmetic input

The hyperbola identity, with $M=\lfloor\sqrt N\rfloor$, is

$$
D(N)=2\sum_{d\le M}\left\lfloor\frac Nd\right\rfloor-M^2.
$$

Using $\sum_{d\le M}1/d=\log M+\gamma+O(M^{-1})$ gives

$$
D(N)=N\log N+(2\gamma-1)N+O(\sqrt N).
$$

The elementary integral estimate $\log(N!)=N\log N-N+O(\log N)$ therefore gives $B(x)=O(\sqrt x)$, including the real-cutoff convention in (1).

For a bound below the square-root exponent, write the classical divisor remainder as

$$
\Delta_D(x)=D(x)-x\log x-(2\gamma-1)x.
$$

Huxley's primary paper establishes exponent $131/416$ with a fixed logarithmic factor. Since $131/416<1/3$, its unoptimized consequence is $\Delta_D(x)=O(x^{1/3})$. Thus (1) and the factorial estimate give (4) with $\theta=1/3,m=0$, which suffices for (6). [M. N. Huxley, *Exponential sums and lattice points III*, Proceedings of the London Mathematical Society 87, 2003, pp. 591–609, DOI 10.1112/S0024611503014485](https://www.cambridge.org/core/journals/proceedings-of-the-london-mathematical-society/article/abs/exponential-sums-and-lattice-points-iii/7B28024FEB1C199035C5C7D7F6783072). No optimal exponent or logarithmic factor is needed here.

## The generic signed-column estimate used

For a finite real measure $\mu$ supported in $(0,\infty)$, put

$$
\vartheta(t)=2\int\frac{\sin(at)}a\,\mu(da),\qquad
T_{j,r}(t)=\int_{[r,\infty)}\frac{(a-r)^j}{a}e^{iat}\,\mu(da),
\quad j=0,1,2.
$$

Let $b_0=(1+t^2)\chi-\chi''$. The established Fourier-column factorization gives

$$
N_\chi(M_{e^{i\vartheta}})
\le\sqrt{\pi/24}\left(
\int_{\mathbb R}\int_0^\infty
|b_0T_{0,r}-2i\chi'T_{1,r}+\chi T_{2,r}|^2\,dr\,dt
\right)^{1/2}.
\tag{7}
$$

This is [the collective signed-phase estimate, equation (9)](signed-scattering-tail-energy.md). It factors through the harmonic-oscillator inverse and retains the full signed history tails before squaring. We apply it only to finite sums, whose phases are bounded. The limiting multiplier will be obtained by trace-norm and strong convergence, so no boundedness assumption on $\Phi_\infty$ is needed.

## The finite-cutoff estimate and its lower endpoint

Remove the fixed linear seed from (2), and take

$$
\mu_X=\sum_{2\le n\le X}\bar c(n)n^{-1/2}\delta_{\log n}.
$$

Write $a_0=\log2$, $A=\log X$, $\ell=\max(r,a_0)$ and

$$
F_j(a,r,t)=e^{(-1/2+it)a}\frac{(a-r)^j}{a}.
$$

For almost every $0<r<A$, Stieltjes integration by parts gives exactly

$$
T_{j,r}(t)=B(X)F_j(A,r,t)
-B(e^\ell-)F_j(\ell,r,t)
-\int_\ell^A B(e^a)\partial_aF_j(a,r,t)\,da.
\tag{8}
$$

The upper value $B(X)$ includes the endpoint atom. The lower value is a left limit; in particular $B(2-)=1-2\gamma$, not zero. For $r>A$ the column vanishes.

Under the elementary bound $B(x)=O(\sqrt x)$, the upper term in (8) has $L^2(dr)$ norm $O(A^{j-1/2})$. For $r<a_0$ the lower term has fixed norm. For $r\ge a_0$ it vanishes if $j\ge1$, while for $j=0$ its squared norm is bounded by $C\int_{a_0}^A a^{-2}da$.

For the integral term use

$$
\|\mathbf1_{0<r<a}(a-r)^j\|_{L^2(dr)}
=\frac{a^{j+1/2}}{\sqrt{2j+1}}.
\tag{9}
$$

Differentiating $F_j$ and applying Minkowski therefore bounds its norm by

$$
C(1+|t|)\int_{a_0}^A
\bigl(a^{j-1/2}+a^{j-3/2}\bigr)\,da.
$$

For $j=0,1,2$ this is at most $C(1+|t|)(1+A)^{5/2}$. The Schwartz factors in (7) absorb $1+|t|$, proving (3) for the phase without its seed. The fixed multiplier $e^{2i(1-2\gamma)t}$ has finite localized norm by the weighted divided-difference factorization. Commuting-multiplier subadditivity restores that seed and proves (3) as stated.

## Tails below the square-root exponent

Assume (4), put $\kappa=1/2-\theta>0$, and let $Y\ge X\ge2$, with $C_0=\log Y$. Apply (7) to

$$
\mu_{X,Y}=\sum_{X<n\le Y}\bar c(n)n^{-1/2}\delta_{\log n}.
$$

This gives the phase $\Phi_Y-\Phi_X$; the seed cancels. For $0<r\le A$, its exact column is

$$
T_{j,r}^{X,Y}=B(Y)F_j(C_0,r,t)-B(X)F_j(A,r,t)
-\int_A^{C_0}B(e^a)\partial_aF_j(a,r,t)\,da.
\tag{10}
$$

For $A<r<C_0$, replace $A$ in the lower term and integral by $r$, and replace $B(X)$ by $B(e^r-)$. This includes atoms at the history threshold. These countably many threshold values do not change the history norm. There is no column for $r>C_0$.

The two endpoint terms with fixed endpoints have norms bounded by constants times

$$
e^{-\kappa A}A^{m+j-1/2}
+e^{-\kappa C_0}C_0^{m+j-1/2}.
$$

The moving lower endpoint vanishes for $j\ge1$. For $j=0$ its norm is bounded by

$$
C\left(\int_A^{C_0}e^{-2\kappa r}r^{2m-2}\,dr\right)^{1/2}
\le C_{\kappa,m}e^{-\kappa A}A^{m-1}.
$$

Using (9) for the integral term gives

$$
C(1+|t|)\int_A^{C_0}e^{-\kappa a}
\bigl(a^{m+j-1/2}+a^{m+j-3/2}\bigr)\,da.
$$

Exponential tail integration bounds all these expressions, uniformly in $Y\ge X$, by

$$
\|T_{j,\cdot}^{X,Y}(t)\|_2
\le C_{C,\theta,m}(1+|t|)
X^{\theta-1/2}(\log X)^{m+3/2},
\qquad j=0,1,2.
\tag{11}
$$

The constants may depend on $\kappa$; no uniform assertion as $\theta\uparrow1/2$ is made. Equation (7) now proves

$$
N_\chi(U_YU_X^*)
\le C_{\chi,C,\theta,m}
X^{\theta-1/2}(\log X)^{m+3/2}.
\tag{12}
$$

## Passing to the actual limiting phase

Ordinary partial summation using (4) proves convergence of the series in (2) and of each fixed derivative, uniformly on compact $t$ intervals. More precisely the tail of the $j$th derivative is bounded by

$$
C_j(1+|t|)X^{\theta-1/2}(\log X)^{m+j-1},
$$

with the same interpretation of negative logarithmic powers as in the original sine kernel. This defines $\Phi_\infty$. Dominated convergence gives strong convergence $U_X\to U_\infty$, and also for the adjoints.

For commuting multipliers the exact defect cocycle gives

$$
\Delta(U_Y)-\Delta(U_X)
=U_X^*\Delta(U_YU_X^*)U_X.
\tag{13}
$$

Since $M_\chi$ commutes with $U_X$, (12) makes $M_\chi\Delta(U_X)$ Cauchy in trace norm. Its strong limit is $M_\chi\Delta(U_\infty)$, which identifies the trace-class limit and proves all of (5). Equations (4) with $\theta=1/3,m=0$ and (5) give (6). A fixed gamma or rational baseline with finite localized norm can be multiplied into every $U_X$ and $U_\infty$ without changing the relative multiplier in (5).

The same proof constructs a finite positive auxiliary storage quantity. Namely the exact signed column combinations $b_0T_0-2i\chi'T_1+\chi T_2$ are Cauchy in $L^2(dt\,dr)$ by (11). Their squared limiting norm is finite and nonnegative, and their tail norm has the rate in (11). Thus the full Brownian/Stieltjes storage exists for this actual coarse score, retaining its signed cross terms. This auxiliary positivity is not positivity of the Weil form.

## Exact Dirichlet score and the limit of coarsening

For $\Re s>1$, absolute convergence gives

$$
\sum_{n\ge1}\bar c(n)n^{-s}
=\zeta(s)^2+\zeta'(s)-2\gamma\zeta(s).
\tag{14}
$$

The double and simple poles at $s=1$ cancel, so the right side is entire. The prefix estimate (4) makes the series holomorphic on $\Re s>\theta$, where it equals that continuation. In particular the actual limiting phase has derivative

$$
\Phi_\infty'(t)
=2\operatorname{Re}\left[
\zeta(1/2-it)^2+\zeta'(1/2-it)-2\gamma\zeta(1/2-it)\right].
\tag{15}
$$

The [successor-clock normalization](successor-counterphase-trace-norm.md) proves that, before centering, $\tau-\log$ is the divisor average of $1-\Lambda$, with its $n=1$ term included. Its Dirichlet series is obtained by multiplying $\zeta+\zeta'/\zeta$ by $\zeta$. Thus the coarse score has removed the logarithmic-derivative denominator. The stable coarse phase proves no bounded inverse for that operation, no estimate on the unaveraged prime score, and no positivity of the Weil form.
