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
The [direct moving-core readout](../theta-and-heat/actual-moving-core-centered-heat-gram.md#direct-finite-goldbach-readout-without-a-terminal-atom) measures
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
The [cell audit](../factorial-and-renewal/causal-renewal-euler-discrepancy-audit.md) proves
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

The critical-line phase has an explicitly negative band. The
[ball-arithmetic check](../../formalization/verification/renewal_critical_phase_interval.py)
encloses the exact value at $\omega=12$ by
\[
\boxed{\quad -0.056<m(12)<-0.054.\quad}
\tag{19}
\]
Continuity supplies symmetric open neighborhoods of $\omega=\pm12$
where $m<0$. A nonzero real Schwartz function with smooth Fourier
transform supported in those neighborhoods therefore has
$\int_0^\infty H(s)C_f(s)ds<0$. This rules out nonnegative
full-line renewal work for arbitrary smooth inputs, even though
$m(0)=\ell>0$. It does **not** give a negative value for the
distinguished prime packet $f_N$; its spectral weight in (18) is fixed
by every $\Lambda(n)-1$ coefficient.

## A critical zero forces a signed actual-packet phase

There is one unconditional arithmetic constraint on that fixed
spectral weight.  Let $\rho=1/2+i\gamma$ be any critical-line zero of
$\zeta$, of multiplicity $r_\rho\ge1$.  The exact packet polynomial
$S_N$ from (18), including $a_1=-1$ and every prime power, satisfies
\[
\boxed{\qquad
\liminf_{N\to\infty}
 \frac{\operatorname{Re}S_N(\gamma)}{\log N}
 \le-r_\rho.
\qquad}                                                    \tag{20}
\]
This is a forced negative excursion of the **actual** centered
prime-power phase, not an assumption of RH or a conclusion about the
sign of the full packet work.  [Hardy's original critical-line-zero
paper](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014)
ensures that the assertion has unconditional instances.  At each such
frequency, the renewal multiplier itself is positive:
\[
 m(\gamma)=\frac1{\gamma^2+1/4}>0,                       \tag{21}
\]
because $\zeta(\rho)=0$ in (17).  The negative band near frequency
$12$ therefore does not contain these exact zero frequencies, although
it can still carry other packet mass.

Here is a one-sided proof of (20) that does not assume a zero-free
half-plane.  Set $D(s)=-\zeta'(s)/\zeta(s)-\zeta(s)$, the actual
Dirichlet series in (6) for $\Re s>1$.  Its residue at $\rho$ is
$-r_\rho$.  For $t\ge0$ put
$B(t)=\operatorname{Re}S_{\lfloor e^t\rfloor}(\gamma)$.
The elementary bound $|\Lambda(n)-1|\le1+\log n$ gives
$B(t)=O(e^{t/2}(1+t))$.  Suppose (20) were false.  Then for some
$0<\varepsilon<r_\rho$ and all sufficiently large $t$,
\[
 C(t):=B(t)+(r_\rho-\varepsilon)t\ge0.               \tag{22}
\]
The passage from integers to all $t$ is valid: between consecutive
$\log N$ the packet is constant and the added linear term increases.

Choose $T$ beyond the start of (22) and let
$L_T(h)=\int_T^\infty C(t)e^{-ht}dt$.  It is a genuine nonnegative
Laplace integral with a finite convergence abscissa $\sigma_c\le1/2$
(unless it converges for every real $h$).  Absolute Dirichlet
convergence and Fubini give, for real $h>1/2$, the meromorphic
identity
\[
 L_T(h)=\frac{D(\rho+h)+D(\bar\rho+h)}{2h}
       +\frac{r_\rho-\varepsilon}{h^2}
       -\int_0^T C(t)e^{-ht}dt.                         \tag{23}
\]
The conjugate pair is essential: it represents the real part of the
twisted actual source by a holomorphic function of $h$.

At any positive real $a$, (23) is analytic unless $\rho+a$ is a zero
of $\zeta$.  If it is a zero of multiplicity $r_a$, conjugacy shows
that (23) has a **simple pole with residue $-r_a/a<0$**.  A
nonnegative Laplace integral with finite abscissa $\sigma_c>0$
must be singular at the positive real point $h=\sigma_c$; this is
the Landau theorem whose local version is compiled in
[LandauSingularity.lean](../../formalization/BuildingBlocks/LandauSingularity.lean).
An analytic value contradicts that theorem, while a negative-residue
pole would make $L_T(h)\to-\infty$ as $h\downarrow\sigma_c$, contrary
to $L_T(h)\ge0$.  Hence $\sigma_c\le0$ (or the transform is entire).
Uniqueness of analytic continuation then identifies (23) with the
convergent Laplace integral at every small positive $h$.  But near
$h=0$, the two zero residues in (23) give
\[
 L_T(h)=-\frac{\varepsilon}{h^2}+O(1/h),
 \qquad h\downarrow0,                                   \tag{24}
\]
again contradicting positivity for small $h>0$.  This proves (20).
RH Proof derived this phase calibration using the classical Landau
singularity mechanism; no priority claim is made.  The argument is
written analysis; the actual Dirichlet-series
identification, meromorphic continuation and final Landau application
have not been formalized together in Lean.

### One fixed packet phase is an RH-scale target

The same exact source has a simple converse target.  For **any one
fixed real** $\omega_0$,
\[
\boxed{\quad
\mathrm{RH}\quad\Longleftrightarrow\quad
  |S_N(\omega_0)|=O_{\varepsilon,\omega_0}(N^\varepsilon)
  \text{ for every }\varepsilon>0.
\quad}                                                    \tag{25}
\]
Indeed, if $|S_N(\omega_0)|=O(N^\delta)$ for one $\delta\ge0$,
summation by parts makes
$\sum_{n\ge1}(\Lambda(n)-1)n^{-1/2-i\omega_0-h}$ converge locally
uniformly for $\Re h>\delta$.  On the smaller region $\Re h>1/2$
it equals $D(1/2+i\omega_0+h)$ by (6), so analytic continuation
makes $D(s)$ holomorphic on $\Re s>1/2+\delta$.  Its apparent pole
at $s=1$ cancels between $-\zeta'/\zeta$ and $-\zeta$, while each
zeta zero gives a nonzero negative residue.  Thus this one packet
bound excludes every zero with real part greater than
$1/2+\delta$.  Taking all $\delta>0$ and using the functional
equation gives RH.

Conversely, the standard RH consequence
$\psi(x)-x=O(x^{1/2}\log^2(2x))$, with all prime powers retained,
and partial summation give
\[
 S_N(\omega_0)=O_{\omega_0}(\log^3(2N))
 \qquad\text{under RH}.                                  \tag{26}
\]
At a critical zero $\omega_0=\gamma$, (20) shows that the
logarithmic scale cannot be replaced by a bounded packet phase.
The criterion (25) is an exact reformulation, not an unconditional
upper estimate.  It reduces the missing arithmetic input to one
fixed twisted complete-prime-power prefix, but provides no way to
prove its subpower bound from the positive heat Gram or successor
transport alone.

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
