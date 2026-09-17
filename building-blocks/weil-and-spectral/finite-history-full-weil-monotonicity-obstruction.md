# Actual finite scattering histories need not increase the full Weil form

This is a written proof of a failed comparison hypothesis for the actual local factors. It is not a Lean formalization, a negative Weil test, or an RH result. It does not settle the prescribed fixed gamma-binary carrier family. It excludes the universal assertion that every finite actual scattering history increases the full signed form on compact pole-null physical packets.

## Normalization and actual operator

Use the full form and Fourier convention in the central [theta Weil chapter](../theta-and-heat/theta-weil-jump-form.md):

\[
 Q(f)=B(f)+A(f)-2\sum_{n\ge2}\Lambda(n)n^{-1/2}\Re C_f(\log n),
\]
\[
 A(f)=\frac1{2\pi}\int a(\xi)|\widehat f(\xi)|^2d\xi,
 \quad a(\xi)=\Re\psi(1/4+i\xi/2)-\log\pi,
 \quad C_f(s)=\int f(v+s)\overline{f(v)}dv.
\]
Here B(f)=2 Re(M_f(1/2) overline(M_f(-1/2))). The archimedean normalization is the Fourier version of [Connes–Consani, Appendix B, equations (149)–(154)](https://alainconnes.org/wp-content/uploads/Selecta.pdf). No prime-power truncation is used: compact support makes the displayed arithmetic sum finite.

Fix an actual prime p, L=log p, and an integer M>=1. With tau_s f(v)=f(v-s), the actual finite-history operator is

\[
 V_{p,M}f=-p^{-1/2}\tau_Lf
 +(1-p^{-1})\sum_{j=0}^{M-1}p^{-j/2}\tau_{-jL}f.
\tag{1}
\]

Its Mellin multiplier is exactly
\[
 -p^{z-1/2}+(1-p^{-1})\sum_{j=0}^{M-1}p^{-j(z+1/2)},
\]
the finite history of u_p(z)=(1-p^{z-1/2})/(1-p^{-z-1/2}). These are actual arithmetic coefficients, not substituted scalar multipliers.

## Real compact pole-null packets

Choose a nonzero real eta in C_c^infinity, supported in an interval of length delta<log 2. For t>=1 define the real packet

\[
 f_t=-t^{-2}(\partial_v^2-1/4)(\eta(v)\cos(tv))
 =\eta\cos(tv)+2t^{-1}\eta'\sin(tv)
   -t^{-2}(\eta''-\eta/4)\cos(tv).
\tag{2}
\]

It has exactly the same compact support bound. Twice integrating by parts gives, for either a=+1/2 or a=-1/2,
\[
 M_{f_t}(a)=-t^{-2}(a^2-1/4)M_{\eta\cos(tv)}(a)=0.
\]
Every translation, and hence (1), preserves both zero moments. Consequently B(f_t)=B(V_{p,M}f_t)=0 exactly. There is no approximate pole correction.

Put N=||eta||_2^2>0. The oscillatory integral of eta^2 at frequency 2t tends to zero faster than any inverse power by integration by parts. Equation (2) and Cauchy–Schwarz therefore give
\[
 ||f_t||_2^2=N/2+O(t^{-1}).                 \tag{3}
\]

## Exact finite-history norm deficit

All shifts in (1) are distinct integer multiples of L. Their physical supports are disjoint since delta<log 2<=L. Thus, for every t, their cross inner products vanish exactly, and

\[
 ||V_{p,M}f_t||_2^2=\alpha_{p,M}||f_t||_2^2,
\]
\[
 \alpha_{p,M}=p^{-1}+(1-p^{-1})^2\sum_{j=0}^{M-1}p^{-j}
 =1-(1-p^{-1})p^{-M}<1.                 \tag{4}
\]

The final equality follows from the finite geometric sum. In particular, the deficit is positive for every finite M, although it tends to zero as M increases.

## Full gamma asymptotic and every arithmetic atom

The [classical digamma expansion, DLMF 5.11.2](https://dlmf.nist.gov/5.11.E2), gives
\[
 a(\xi)=\log|\xi|-\log(2\pi)+O(|\xi|^{-1})
 \quad (|\xi|\longrightarrow\infty),
\]
and continuity at finite real xi gives |a(xi)|<=C log(2+|xi|).

Equation (2) is a sum of modulations at +t and -t with envelopes whose Schwartz seminorms are uniformly bounded for t>=1. Its finitely many translates have the same property, with constants depending on p,M,eta. It follows that, for g_t=f_t and for g_t=V_{p,M}f_t,

\[
 A(g_t)=\log t\,||g_t||_2^2+O_{p,M,\eta}(1).       \tag{5}
\]

Here is an explicit justification of the uniform remainder. Write each Fourier summand as H_t(xi-t) or H_t(xi+t), where H_t and all required Schwartz bounds are uniform. On |xi-t|<=t/2, the difference a(xi)-log t is uniformly bounded. Outside that interval, bound it by C[log t+log(2+|xi-t|)] and use rapid decay of H_t. The latter contribution is uniformly bounded (indeed vanishes after taking a sufficiently high decay order). The same reasoning applies around -t. Cross products obey 2|XY|<=|X|^2+|Y|^2, so the corresponding weighted remainder is bounded as well. Plancherel identifies the unweighted integral as ||g_t||_2^2. This proves (5) without any statement about zeta zeros.

For f_t itself, C_f_t(log n)=0 for every n>=2 because delta<log 2. For V_{p,M}f_t, the entire support has diameter at most ML+delta. Therefore its complete arithmetic contribution includes only integers n<=exp(ML+delta). Cauchy–Schwarz and (3)–(4) give the uniform bound

\[
 \left|2\sum_{n\ge2}\Lambda(n)n^{-1/2}
       \Re C_{V_{p,M}f_t}(\log n)\right|
 \le 2||V_{p,M}f_t||_2^2
       \sum_{2\le n\le e^{ML+\delta}}\Lambda(n)n^{-1/2}
 =O_{p,M,\eta}(1).                         \tag{6}
\]

Every prime power in this finite interval remains in (6). Neither the gamma integral nor any boundary/pole term is dropped.

## Signed conclusion and precise scope

Combining (3)–(6), with the exact zero pole terms, proves

\[
 \boxed{Q(V_{p,M}f_t)-Q(f_t)
 =-\frac{N}{2}(1-p^{-1})p^{-M}\log t
   +O_{p,M,\eta}(1).}                    \tag{7}
\]

The change is strictly negative for all sufficiently large t for every fixed actual prime p and every finite M>=1. Both forms themselves are eventually positive: their leading terms are N log(t)/2 and alpha_(p,M) N log(t)/2 respectively. Thus (7) is a failure of universal finite-history monotonicity, not a counterexample to Weil positivity or RH.

The packet shape varies with t, and the threshold in (7) depends on M. This does not contradict the existing small signed transfer error for a fixed smooth carrier and a prescribed growing history depth. In particular (7) supplies no conclusion on the sign of the fixed gamma-binary growing-prime family, no growing-prime bound uniform in t, and no estimate on its actual residual R_J(E). It shows why a proof cannot use universal finite-history Q-monotonicity as the missing baseline sign argument.

This application of the standard gamma asymptotic and finite geometric sum has no novelty claim. A numerical computation or an assumed zero expansion is unnecessary for its sign conclusion. Lean formalization of (5) and (7) is not claimed.


## Exact prime contribution for a narrower physical bump

Independent root review gives a more explicit version retaining the whole prime term. Choose the same nonzero real smooth eta with support diameter delta<log(1+p^(-M)). This stronger width bound implies delta<log 2. Among integers n>=2, an overlap at log n can occur only when n=p^k, 1<=k<=M. Indeed two translated supports can overlap only if |log n-k log p|<delta for one such k. The nearest larger integer to p^k has logarithmic distance log(1+p^(-k))>=log(1+p^(-M)); the nearest smaller integer has a still larger distance. All other arithmetic atoms are therefore zero by support, rather than being truncated.

Put r=p^(-1) and d=(1-r)r^M, so alpha=1-d. Direct summation of the actual translated coefficients gives, for every 1<=k<=M,

\[
 C_{V_{p,M}f_t}(kL)=-(1-r)r^{M-k/2}\|f_t\|_2^2.
\]

For k<M, the coefficient is the sum of the negative pair joining the shift L to the shift -(k-1)L, and the positive pairs among shifts 0,-L,...,-(M-1)L:

\[
 -(1-r)r^{k/2}+(1-r)^2r^{k/2}
 \sum_{j=0}^{M-1-k}r^j=-(1-r)r^{M-k/2}.
\]

For k=M there is only the negative pair and the same formula holds. Hence the complete signed prime contribution is exactly

\[
 -2\sum_{n\ge2}\Lambda(n)n^{-1/2}\Re C_{V_{p,M}f_t}(\log n)
 =2M\log p\,d\|f_t\|_2^2.
\tag{8}
\]

Every p^k has Lambda(p^k)=log p. The original f_t has zero prime contribution. No parity, prime-power or endpoint term is removed.

The same Fourier-envelope proof sharpens (5) to

\[
 A(g_t)=\log(t/(2\pi))\|g_t\|_2^2+o(1).
\]

For clarity, on |xi-t|<=t/2 the remainder is bounded by C(1+|xi-t|)/t using the digamma asymptotic. Uniform Schwartz envelopes make this integral tend to zero. On the complement rapid decay pays the logarithmic bound; the negative-frequency bump and all cross products obey the same argument. There are finitely many translates with fixed p,M. Thus both gamma remainders are o(1), without a limit uniform in growing M.

Combining the exact norm deficit, pole cancellation and (8) yields

\[
 \boxed{Q(V_{p,M}f_t)-Q(f_t)
 =\frac{\|\eta\|_2^2}{2}d
   \log\frac{2\pi p^{2M}}t+o(1).}
\tag{9}
\]

The error from replacing ||f_t||^2 by ||eta||^2/2 is O(log(t)/t), which tends to zero. This identifies the full finite prime contribution behind the negative unnormalized comparison. It gives an asymptotic as t tends to infinity at fixed p,M, not a certified sign threshold at t=2pi p^(2M).

The distinction between norm conventions matters. Since Q is quadratic, the norm-preserving output alpha^(-1/2)V_(p,M)f_t instead satisfies

\[
 \boxed{Q(\alpha^{-1/2}V_{p,M}f_t)-Q(f_t)
 \longrightarrow\frac{M\log p\,d}{\alpha}\|\eta\|_2^2>0.}
\tag{10}
\]

Thus (7) and (9) refute unnormalized finite-history monotonicity. They do not refute a norm-preserving comparison; this narrow high-frequency family has the positive limit (10). Neither convention supplies the missing global sign for arbitrary tests or the prescribed growing-history carrier.

RH Agent3 contributed (1)–(7). RH Proof independently checked the physical shifts, exact pole moments, complete arithmetic cutoff, gamma-envelope argument and primary gamma normalization, and derived the exact arithmetic evaluation (8) and refinements (9)–(10). These are written proofs using classical Fourier and gamma asymptotics, with no priority claim. No Lean formalization or unconditional RH estimate is asserted.

## A different envelope refutes universal norm-preserving comparison

The positive limit (10) depends on the width excluding all neighboring integers. A fixed smooth plateau of support diameter 1/4 permits neighboring primes. The [finite-prime certificate](norm-preserving-full-weil-prime-counterexample.md) uses the actual prime 10007 and an unbounded actual modulation sequence to make all neighboring first-prime phases negative, while retaining every even-power contribution. An exact rational margin proves a negative limiting norm-preserving difference. Both individual full forms remain positive at high frequency. Thus the normalized universal comparison also fails, with a different support and phase condition; the narrow-envelope positive theorem above remains valid. Nine arithmetic theorems are compiled in Lean, including the exhaustive even-power classification for arbitrary prime bases and even exponents; the analytic comparison remains written mathematics.
