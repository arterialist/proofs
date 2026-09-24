# The actual squared residual has the prolate exponential scale

This supplements [the raw-vector proof](connes-raw-prolate-residual-gap-obstruction.md). All normalizations, the full compact Weil operator, and the exact smoothing $h^\sharp$ are those of that proof. No positivity or spectral gap is assumed. This note improves its residual lower bound on the same cofinal sequence, but does **not** resolve Temple's quotient.

Write $a=\log\lambda$, $c=2\pi\lambda^2$, $I=(-a,a)$, $k=k_{\rm raw}$, $\kappa=\|k\|_2$, $R=Q(k)/\kappa^2$ and $r=\|(A_a-R)k\|_2/\kappa$. There are fixed constants $C,K>0$ such that
\[
r\le Cc^Ke^{-c}\quad\text{for every sufficiently large }c,
\tag{1}
\]
and
\[
r\ge C^{-1}c^{-K}e^{-c}
\quad\text{when }\lambda^2=N+\tfrac12\text{ is sufficiently large}.
\tag{2}
\]
Thus on that sequence $\log r/c\to-1$. The actual squared residual is $e^{-2c}$ up to polynomial factors, at the same exponential scale as the existing upper bound for any positive gap $E_1-R$.

## Exact operator comparison

From the previous proof, let
\[
F^\sharp=\mathcal E(h^\sharp)=k^\sharp+t,
\qquad e=k-k^\sharp,
\]
where $t$ is supported on $(-\infty,-a)$. The actual origin value has been removed in $h^\sharp$; the full radical identity applies. On the open window it implies the distributional identity
\[
A_a k=A_a e-(At)|_I.
\tag{3}
\]
Here $At$ means the full gamma, pole and all-prime-power expression evaluated inside $I$, not a global $L^2$ assertion about each summand separately. Pairing with compactly supported smooth functions in $I$ proves (3) from the radical identity. The following estimates show that both sides are actual $L^2(I)$ functions, so (3) holds in $L^2$ as well.

The proved bounds, with $B=3/2$, are
\[
|t(-a-u)|+|t'(-a-u)|\le\epsilon e^{-Bu},\quad u>0,
\qquad \epsilon\le\operatorname{poly}(c)e^{-c},
\tag{4}
\]
and
\[
\|e\|_\infty+\|e\|_1+\operatorname{Var}(e)
\le\operatorname{poly}(c)e^{-c}.
\tag{5}
\]
Total variation includes the jumps of the zero extension. The Fourier bound from bounded variation proves not only form control but
\[
\int(1+\log(1+\tau^2))^2|\widehat e(\tau)|^2d\tau
\le C(\|e\|_1+\operatorname{Var}(e))^2.
\tag{6}
\]
Indeed the Fourier transform is bounded by the minimum of the $L^1$ bound and a constant times total variation divided by $|\tau|$, and $\int_1^\infty\log^2(1+\tau^2)\tau^{-2}d\tau<\infty$.

Equation (6) controls the gamma multiplier in $A_a e$. The two pole terms have norm at most $2\lambda\|e\|_1$. The prime shifts have operator norm at most $2\sum_{n<\lambda^2}\Lambda(n)/\sqrt n$, which is polynomial in $c$. Together with $\|e\|_2^2\le\|e\|_\infty\|e\|_1$, these give
\[
\|A_a e\|_2\le\operatorname{poly}(c)e^{-c}.
\tag{7}
\]

For clarity, all terms of $At$ can be bounded directly. Let $\mathfrak r(s)=e^{-s/2}/(1-e^{-2s})$ and $H(d)=\int_d^\infty\mathfrak r(s)ds$. Since $t(x)=0$ for $x\in I$, its gamma contribution there is
\[
-\int_0^\infty\mathfrak r(x+a+u)t(-a-u)du.
\]
Its absolute value is at most $\epsilon H(x+a)$. The function $H$ is square integrable on $(0,\infty)$: it has a logarithmic singularity at zero and decays exponentially at infinity. Thus its window norm is at most $C\epsilon$, uniformly in $a$.

The actual pole moments satisfy
\[
|M_-(t)|\le\epsilon\sqrt\lambda/(B-1/2),\qquad
|M_+(t)|\le\epsilon/(\sqrt\lambda(B+1/2)).
\]
Their contribution in $I$ has norm at most $\epsilon(\lambda+1/2)$ for $B=3/2$.

For the prime part, only $t(x-\log n)$ can be nonzero. Without truncating its infinite sum, (4) gives
\[
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}|t(x-\log n)|
\le\epsilon e^{B(x+a)}
\sum_{n\ge2}\frac{\Lambda(n)}{n^{B+1/2}}.
\tag{8}
\]
The last sum converges at $B+1/2=2$. On the finite window the resulting $L^2$ norm is polynomial in $c$ times $\epsilon$. This deliberately coarse bound keeps every prime power. It uses no prime-error cancellation. Combining these estimates with (3), (7), the prior bound $|R|\le\operatorname{poly}(c)e^{-2c}$ and the prior lower bound $\kappa\ge\kappa_0>0$ proves (1).

## The regular remainder is also exponentially small

The essential improvement over the first proof is that (3) controls the upper-endpoint regular remainder at the same exponential scale as its logarithmic coefficient.

First, (5) strengthens to piecewise $C^2$ bounds of the same scale. Only the terminal collars require an explanation. For a scaled prolate mode write $f(t)=(c^2t^2-\kappa_j)\psi_j(t)$. The endpoint-integrated ODE gives
\[
\psi_j'(t)=-\frac1{1+t}\int_0^1 f(t+u(1-t))du.
\]
On the collar of width $2\eta=1/(50c^2)$ the previous bounds give $|\psi_j|\le\operatorname{poly}(c)e^{-c}$ and $|\psi_j'|\le\operatorname{poly}(c)e^{-c}$. Differentiate this averaged expression once. Since $|f'|\le\operatorname{poly}(c)e^{-c}$, it gives the same type of bound for $\psi_j''$, uniformly up to the endpoint. Derivatives of the specified cutoff cost only polynomial factors. The fixed corrections in $h-h^\sharp$ are exponentially small. Arithmetic summation over at most $\lambda^2$ terms therefore gives
\[
\|e'\|_{\infty,\mathrm{pieces}}+
\|e''\|_{\infty,\mathrm{pieces}}
\le\operatorname{poly}(c)e^{-c}.
\tag{9}
\]

Now take $\lambda^2=N+1/2$ and $x=a-s$, $0<s<\delta_0=1/(10\lambda^2)$. The earlier proof checked every compact prime shift of $e$: it remains on its left smooth branch and above the lower endpoint. Thus the gamma, pole and finite prime terms of $A_a e$, after subtraction of the upper endpoint logarithm, have modulus of continuity at most
\[
\operatorname{poly}(c)e^{-c}\delta(1+|\log\delta|).
\tag{10}
\]
For the gamma term this is exactly the local boundary calculation in the earlier proof, now using the exponentially small bounds (5), (9). Original interior jumps lie at distance at least $\log2$ from the upper endpoint. Smooth cutoff transitions introduce no new jumps; their derivatives are covered by (9).

Here is the local modulus explicitly. Choose a fixed $u_0<\log2$ and set
$b(u)=e(a-u)-B_+$ for $0<u<u_0$. With
$\varepsilon_c=\operatorname{poly}(c)e^{-c}$, (5) and (9) give
$|b(u)|\le\varepsilon_c u$ and $|b'(u)|\le\varepsilon_c$.
After separating the boundary factor $H(s)e(a-s)$, the nearby
interior gamma integral is
\[
 I(s)=\int_0^{u_0}\mathfrak r(|u-s|)[b(s)-b(u)]\,du.
\]
For $0<s<u_0/4$, the pieces of $I(s)-I(0)$ with $u<2s$ are
$O(\varepsilon_c s)$, because
$\mathfrak r(v)\ll v^{-1}$ and $b$ is $\varepsilon_c$-Lipschitz.
For $2s<u<u_0$, write the integrand difference as
$\mathfrak r(u-s)b(s)+[\mathfrak r(u)-\mathfrak r(u-s)]b(u)$.
The bounds $\mathfrak r(u-s)\ll u^{-1}$,
$|\mathfrak r(u)-\mathfrak r(u-s)|\ll s/u^2$, and
$|b(u)|\le\varepsilon_c u$ give
$|I(s)-I(0)|\ll\varepsilon_c s(1+|\log s|)$.
The region $u\ge u_0$ has a kernel with bounded integrable
derivative and contributes $O(\varepsilon_c s)$. Finally
$H(s)=\tfrac12\log(1/s)+C_0+O(s)$ and
$e(a-s)=B_++O(\varepsilon_c s)$ give the same modulus after
subtracting $B_+\log(1/s)/2$. This proves the gamma part of (10).

The tail contribution $At$ is $C^1$ on this one-sided collar, with derivative bounded by $\operatorname{poly}(c)e^{-c}$. Its gamma kernel is evaluated at distances $x+a+u\ge2a-\delta_0$, bounded away from zero for large $a$, so its derivative is directly integrable. The two pole terms have the same elementary derivative bounds as their values. For the infinite prime sum the support condition is
\[
n>e^{x+a}=\lambda^2e^{-s}.
\]
Throughout the collar the threshold lies strictly between $N$ and $N+1$. Hence the index set is exactly $n\ge N+1$, with the usual von Mangoldt zeros included, and no moving-boundary jump occurs. Differentiate each term using (4); the resulting derivative series is absolutely and uniformly dominated by the convergent sum in (8). This proves the asserted derivative bound for the full tail contribution.

The endpoint value of $e$ is $B_+$ because $k^\sharp$ vanishes on a terminal neighborhood. The term $Rk$ has an exponentially smaller collar derivative. Consequently for the actual residual $g=(A_a-R)k$,
\[
g(a-s)=\frac{B_+}{2}\log(1/s)+G(s),\qquad
\sup_{0<s<\delta}|G(s)-G(0)|
\le Cc^Ke^{-c}\delta(1+|\log\delta|).
\tag{11}
\]
The earlier endpoint argument gives $|B_+|\ge C^{-1}c^{9/4}e^{-c}$. Choose a fixed sufficiently large $L$ and set $\delta=c^{-L}$. Then $\delta<\delta_0$ and the error term in the logarithmic collar test is at most $|B_+|/4$. That exact test gives
\[
r\ge\frac{\sqrt\delta\,|B_+|}{4\kappa}
\ge\operatorname{poly}(c)^{-1}e^{-c},
\]
since $\kappa\le\operatorname{poly}(c)$. This proves (2).

## What this decides about Temple's bound

For a positive actual denominator, the known min--max and Rayleigh estimates imply
\[
0<E_1-R\le\operatorname{poly}(c)e^{-2c}.
\]
Combining this with (2) gives only
\[
\frac{r^2}{E_1-R}\ge C^{-1}c^{-K}
\tag{12}
\]
on the cofinal sequence, for some fixed $K$. The right side can tend to zero. Thus (12) **does not falsify** the Temple convergence condition.

No leading polynomial power for the actual gap is supplied by the cited results. In particular the weighted-tail min--max proof uses deliberately crude polynomial losses and does not determine the first excited Weil eigenvalue's asymptotic. Comparing those unspecified powers cannot establish a constant lower bound for (12), and an upper bound on $E_1$ cannot be used as a lower bound on $E_1-R$.

The rigorous conclusion is that the actual residual has exactly the $e^{-c}$ exponential scale, up to polynomial factors, on this sequence. There is no extra exponential saving in the squared numerator available to close Temple's argument. The sign and polynomial-scale size of the actual gap remain unresolved. This note supplies neither an independent positive gap nor a decisive Temple falsifier, and stops without replacing that missing estimate by a hypothesis.
