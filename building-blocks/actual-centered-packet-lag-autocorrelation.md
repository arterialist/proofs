# Actual finite Goldbach packets realize both late autocorrelation phases

The late-cell renewal primitive has a negative pairing with every
nonnegative decreasing convex test. This note checks that shape premise
against the derivative autocorrelation of the **actual** finite centered
Goldbach packet. Its far-lag phase changes with the terminal prime
error, even though each packet has a nonnegative heat Gram. The result
does not rule out an inequality using the complete uncut response and
its causal history.

For integer $N\ge2$, retain every prime power and the initial
$a_1=-1$ in
\[
a_n=\Lambda(n)-1\quad(1\le n\le N),\qquad
D_N(t)=\sum_{n\le N}a_ne^{-nt},\qquad
d_N(v)=e^{-v/2}D_N(e^{-v}).
\tag{1}
\]
The [direct moving-core readout](actual-moving-core-centered-heat-gram.md#direct-finite-goldbach-readout-without-a-terminal-atom) measures
$\|d_N\|_2^2=\sum_{m,n\le N}a_ma_n/(m+n)\ge0$ without inserting a
compensating terminal atom. Nevertheless its lag autocorrelation
$C_N(s)=\int_{\mathbb R}d_N(v+s)d_N(v)\,dv$ has the exact finite formula
\[
\boxed{\quad
C_N(s)=e^{-s/2}\sum_{n,m\le N}
                 \frac{a_na_m}{m+n e^{-s}},\qquad s\ge0.
\quad}
\tag{2}
\]
Indeed $t=e^{-v}$ turns the integral into
$e^{-s/2}\sum_{n,m}a_na_m\int_0^\infty
 e^{-(m+n e^{-s})t}dt$. All sums are finite, so this retains every
additive cross term and needs no limiting interchange.

Define the two literal packet endpoints
\[
E_N=\sum_{n\le N}a_n=\psi(N)-N,
\qquad L_N=\sum_{n\le N}\frac{a_n}{n}.
\tag{3}
\]
Since the rational function in (2) is analytic at $e^{-s}=0$,
\[
e^{s/2}C_N(s)=E_NL_N+O_N(e^{-s}).
\tag{4}
\]
The smooth packet and all its derivatives decay superexponentially at
$v\to-\infty$ and exponentially at $v\to+\infty$. Differentiation
followed by integration by parts therefore gives, for $f_N=d_N'$,
$C_{f_N}(s):=\int f_N(v+s)f_N(v)dv=-C_N''(s)$. Differentiating (2)
also yields
\[
\boxed{\quad
e^{s/2}C_{f_N}(s)=-\tfrac14E_NL_N+O_N(e^{-s}),
\qquad
e^{s/2}[-C_{f_N}'(s)]=-\tfrac18E_NL_N+O_N(e^{-s}).
\quad}
\tag{5}
\]
The latter is the type of lag weight multiplying $J-\ell$ before
integration by parts in the renewal derivative-energy pairing.

For completeness, the sign of $L_N$ is eventually fixed. Put
$A(x)=\sum_{n\le x}a_n=E(x)+\{x\}$. The unconditional
zero-free-region prime number theorem gives
$A(x)=O(xe^{-c\sqrt{\log x}})+O(1)$, so partial summation makes
$L_N$ converge. For $\Re z>1$ its Dirichlet series is exactly
\[
\sum_{n\ge1}\frac{a_n}{n^z}
=-\frac{\zeta'(z)}{\zeta(z)}-\zeta(z).
\tag{6}
\]
The convergent partial-summation integral permits passage to $z=1$.
The Laurent expansion
$\zeta(1+h)=h^{-1}+\gamma+O(h)$ then gives
\[
\boxed{\quad L_N\longrightarrow-2\gamma<0.\quad}
\tag{7}
\]
Littlewood's unconditional two-sided oscillation of $E(x)$ supplies
infinitely many integer $N$ with $E_N>0$ and infinitely many with
$E_N<0$: between consecutive integers $E(x)=E(\lfloor x\rfloor)
-(x-\lfloor x\rfloor)$, so integer sampling changes its value by
less than one. By (5)--(7), $C_{f_N}(s)$ is eventually positive for
each sufficiently large packet with $E_N>0$, and eventually negative
for each sufficiently large packet with $E_N<0$. In the latter case
the weight $-C_{f_N}'(s)$ is eventually negative too.

## The linked memory beyond the packet cutoff is small

The adverse far-lag sign has a finite payment. Let $U=\log N$ and
$\widetilde J(s)=J(s)-\ell$ be the actual centered renewal primitive.
The [cell audit](causal-renewal-euler-discrepancy-audit.md) proves
$|\widetilde J(s)|\le C_Je^{-3s/2}$ for all sufficiently large $s$.
For $s\ge U$ and $n,m\le N$, the ratio
$r=n e^{-s}/m$ lies in $[0,1]$. Each of the first three derivatives
of the summand in (2) is bounded by $C_j e^{-s/2}/m$, because it is
$m^{-1}e^{-s/2}(1+r)^{-1}$ and $r'=-r$. The elementary complete-prime
prefix bounds give
\[
\sum_{n\le N}|a_n|\le\psi(N)+N\ll N,
\qquad
\sum_{m\le N}\frac{|a_m|}{m}
\le\sum_{m\le N}\frac{\Lambda(m)+1}{m}
\ll\log(2N).
\tag{8}
\]
The second follows by partial summation from Chebyshev's
$\psi(x)\ll x$. Thus, uniformly for $0\le j\le3$ and $s\ge U$,
\[
|C_N^{(j)}(s)|\le C N\log(2N)e^{-s/2}.
\tag{9}
\]
Since $-C_{f_N}'=C_N'''$, the linked late-memory work satisfies
\[
\boxed{\quad
\left|\int_U^\infty\widetilde J(s)
          [-C_{f_N}'(s)]\,ds\right|
\le C N\log(2N)\int_U^\infty e^{-2s}ds
\le C\frac{\log(2N)}N.
\quad}
\tag{10}
\]
The endpoint is of the same order:
$|\widetilde J(U)C_{f_N}(U)|\le C\log(2N)/N$.
Because $H=J'$ on positive lags, integration by parts, with the
infinite endpoint vanishing, gives the equally explicit full-line
renewal-tail payment
\[
\boxed{\quad
\int_U^\infty H(s)C_{f_N}(s)\,ds
=-\widetilde J(U)C_{f_N}(U)
 +\int_U^\infty\widetilde J(s)[-C_{f_N}'(s)]ds
=O\!\left(\frac{\log(2N)}N\right).
\quad}
\tag{11}
\]
The improved decay comes from the linked primitive
$J-\ell=O(e^{-3s/2})$ and its exact boundary term; an absolute
estimate on the oscillating $H$ alone loses that cell cancellation.

## The unresolved packet memory is confined to logarithmic-logarithmic lags

The same centered primitive also gives a relative bound starting well
before the source cutoff. The direct moving-core proof gives
$\|d_N'\|_2/\|d_N\|_2\ll 1+U$ from the gamma heat multiplier. Its
frequency splitting applies once more to $d_N'$:
for $\Omega\ge1$,
\[
\|d_N''\|_2\le\Omega\|d_N'\|_2
 +C M_N(1+\Omega)^2e^{-\pi\Omega/2},
\qquad M_N=\sum_{n\le N}\frac{|a_n|}{\sqrt n}
\ll(1+U)e^{U/2}.
\tag{12}
\]
There is also an $N$-independent lower bound on $\|d_N'\|_2$.
Indeed, with $t=e^{-v}$, the $n=1$ term of
\[
d_N'(v)=t^{1/2}\sum_{n\le N}a_n(nt-\tfrac12)e^{-nt}
\]
is $-t^{1/2}(t-\tfrac12)e^{-t}$. On a fixed interval
$t\in[t_0,t_0+1]$ with $t_0$ sufficiently large, the absolute sum
of the $n\ge2$ terms, bounded using $|a_n|\le1+\log n$, is less
than half this first term, uniformly in $N$. Integrating over that
interval proves $\|d_N'\|_2\ge c_1>0$. Take
$\Omega=2U/\pi$ in (12). The remainder is
$O((1+U)^3e^{-U/2})$, so
\[
\boxed{\quad \|f_N'\|_2\le C(1+U)\|f_N\|_2,
\qquad f_N=d_N'.\quad}
\tag{13}
\]

For any $a\ge\log n_0$ and any real $f\in H^1(\mathbb R)$, its
autocorrelation satisfies $|C_f(a)|\le\|f\|_2^2$ and
$|C_f'(s)|\le\|f'\|_2\|f\|_2$. Centered integration by parts and
$|\widetilde J(s)|\le C_Je^{-3s/2}$ therefore give
\[
\left|\int_a^\infty H(s)C_f(s)\,ds\right|
\le C_J e^{-3a/2}\bigl(\|f\|_2^2+\|f\|_2\|f'\|_2\bigr).
\tag{14}
\]
For the **actual** finite packet, (13)--(14) give, whenever
$K\ge n_0$,
\[
\boxed{\quad
\left|\int_{\log K}^\infty H(s)C_{f_N}(s)\,ds\right|
\le C(1+U)K^{-3/2}\|f_N\|_2^2.
\quad}
\tag{15}
\]
For example, $K=\lceil(1+U)^2\rceil$ makes the right side
$O((1+U)^{-2})\|f_N\|_2^2$, while the cutoff lag is only
$\log K=2\log\log N+O(1)$. The direct absolute estimate
$|H(s)|\ll e^{-s/2}$ would give merely $O(K^{-1/2})\|f_N\|_2^2$;
the stronger power in (15) uses the linked centered primitive and
the packet's heat-frequency bound. This is a relative localization,
not an upper bound on $\|f_N\|_2^2$ or a sign for the remaining
early-lag integral.

## Exact critical-line phase of the complete packet work

The signed quantity can also be written without any cell truncation.
For $\Re z>1/2$, termwise Laplace integration of the literal floor
sum in $H(s)=S_{\lfloor e^s\rfloor}-\zeta(1/2)-2e^{s/2}$ gives
\[
\widehat H(z):=\int_0^\infty e^{-zs}H(s)\,ds
=\frac{\zeta(1/2+z)-\zeta(1/2)}z
 -\frac2{z-1/2}.
\tag{16}
\]
The cell bound $|H(s)|\ll e^{-s/2}$ extends the integral to
$\Re z>-1/2$, with removable values at $z=0,1/2$. Consequently its
real boundary multiplier is the explicit continuous even function
\[
\boxed{\quad
m(\omega):=\operatorname{Re}\widehat H(i\omega)
=\frac{\operatorname{Im}\zeta(1/2+i\omega)}{\omega}
 +\frac1{\omega^2+1/4}\quad(\omega\ne0),
\qquad m(0)=\ell=4+\zeta'(1/2)>0.
\quad}
\tag{17}
\]
Put $S_N(\omega)=\sum_{n\le N}a_n n^{-1/2-i\omega}$.
The exact heat Fourier transform and Plancherel then yield
\[
\boxed{\quad
\int_0^\infty H(s)C_{f_N}(s)\,ds
=\frac1{2\pi}\int_{\mathbb R}
 m(\omega)\omega^2
 |\Gamma(1/2+i\omega)|^2|S_N(\omega)|^2\,d\omega,
\qquad f_N=d_N'.
\quad}
\tag{18}
\]
All integrals converge absolutely: $H\in L^1$, $S_N$ is a finite
Dirichlet polynomial, and the gamma factor decays exponentially.
The formula keeps every $\Lambda(n)-1$ cross term and the initial
$a_1=-1$. It identifies the missing signed packet estimate as a
correlation between the actual finite Dirichlet polynomial and the
critical-line phase of $\zeta$. Positivity of
$\|d_N\|_2^2$ does not determine that correlation.

The lag threshold depends on $N$. In particular this does not assert
a negative test inside $0\le s\le\log N$, nor identify $f_N$ with
the tuned causal derivative $h_\beta'$ of the uncut heat response.
It does show that positive finite Goldbach Grams and the exact
late-cell phase theorem cannot, by themselves, put even the actual
centered finite-packet derivative autocorrelation in the required
nonnegative-convex cone. The terminal value $E_N=D_N(0)$ is precisely
the coefficient of $e^{-v/2}$ in the packet's right heat tail; it
controls the far-lag phase instead of disappearing from it. Equations
(10)--(11) show that this far-lag phase costs only
$O(\log(2N)/N)$ beyond the source cutoff. Any missing RH-scale
estimate lies in the earlier lags and the uncut arithmetic history.
