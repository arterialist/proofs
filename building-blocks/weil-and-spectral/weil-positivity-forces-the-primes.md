# Weil positivity and the forcing of prime mass: certified intervals, computations, and conditional rigidity

**Status.** Propositions 3 and 4 are **unconditional**; their proofs are a short argument plus interval-arithmetic computations. Propositions 1 and 2 are proved below in full and are **conditional on the Riemann hypothesis**. They are elementary and probably known; no literature search was done for them. Everything else in sections 3 to 7 is numerical computation with the true primes on finite sets of test functions, in double precision or at 60 digits, and is not proof. An independent review on 10 November 2026 rederived Propositions 1 to 4 and formula (2) and reran the certificates; its corrections are incorporated. Nothing here proves positivity of Weil's functional for any support length, and nothing here proves or bounds anything about zeros of $\zeta$. Section 6 reproduces a phenomenon reported by Connes, Consani and Moscovici. No Lean formalization.

## 1. Setting

For $g\in C_c^\infty(\mathbb R)$ put

$$
\hat g(z)=\int g(u)e^{izu}\,du,\qquad h_g(u)=\int g(v)\overline{g(v-u)}\,dv ,
$$

so that $h_g(-u)=\overline{h_g(u)}$ and $\hat h_g(t)=|\hat g(t)|^2$ for real $t$. Write the nontrivial zeros as $\rho=\tfrac12+i\gamma$. Weil's explicit formula reads

$$
\sum_\rho \hat g(\gamma)\,\overline{\hat g(\bar\gamma)}=W(h_g),
$$

$$
W(h)=\hat g(\tfrac i2)\overline{\hat g(-\tfrac i2)}+\hat g(-\tfrac i2)\overline{\hat g(\tfrac i2)}+\mathcal A(h)-\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\bigl(h(\log n)+h(-\log n)\bigr),
$$

$$
\mathcal A(h)=-(\gamma_E+\log\pi)\,h(0)+2\int_0^\infty\frac{e^{-2u}h(0)-e^{-u/2}\,\tfrac12\bigl(h(u)+h(-u)\bigr)}{1-e^{-2u}}\,du .
$$

The first two terms come from the pole of $\zeta$ and $\mathcal A$ from the factor $\pi^{-s/2}\Gamma(s/2)$. The script [weil_form.py](../../certificates/prime-birth/weil_form.py) implements this formula and checks it against a direct sum over the first 300 zeros, to the accuracy of the omitted tail, about $0.003$. A sharper check is the test function of Proposition 3, where the formula and a sum over zeros agree to $4\cdot10^{-6}$.

If $g$ is supported in an interval of length $L$, then $h_g$ vanishes outside $[-L,L]$, so only the prime powers $n<e^L$ enter. Weil's criterion says that RH holds if and only if $W(h_g)\ge0$ for every $g$. If RH holds then $W(h_g)=\sum_\gamma|\hat g(\gamma)|^2$.

For a signed measure $d$ on $(0,\infty)$ write

$$
W_d(h)=W(h)-\int_{(0,\infty)}\bigl(h(u)+h(-u)\bigr)\,dd(u).
$$

This is Weil's functional with the prime measure $\sum_n\Lambda(n)n^{-1/2}\delta_{\log n}$ replaced by that measure plus $d$. Deleting the prime $p$ corresponds to $d=-\sum_{k\ge1}(\log p)\,p^{-k/2}\,\delta_{k\log p}$, which is a finite measure.

## 2. No finite change of the primes keeps positivity

**Proposition 1 (conditional on RH).** Assume the Riemann hypothesis. Let $d$ be a finite signed Borel measure on $(0,\infty)$, not the zero measure, and suppose $d\ge0$ on $(0,c)$ for some $c>0$. Then there is $g\in C_c^\infty(\mathbb R)$ with $W_d(h_g)<0$.

The condition on $(0,c)$ holds for every $d$ supported in $[\log 2,\infty)$, and for every $d$ such that the modified prime measure is still nonnegative, since the true one has no mass below $\log 2$. So under RH no change of finitely many prime powers keeps positivity: not deleting one, not moving one, not changing one weight, and not adding an atom at any other position. The same holds for infinitely many changes of finite total mass.

*Proof.* Let $\nu$ be the counting measure of the ordinates $\gamma$, which are real by RH. Fourier inversion gives $h_g(u)+h_g(-u)=\frac1\pi\int|\hat g(t)|^2\cos(tu)\,dt$. Since $d$ is finite, Fubini gives

$$
W_d(h_g)=\int|\hat g(t)|^2\,d\nu(t)-\frac1\pi\int|\hat g(t)|^2D(t)\,dt,\qquad D(t)=\int\cos(tu)\,dd(u). \tag{1}
$$

$D$ is bounded and continuous.

*Step 1: if $W_d(h_g)\ge0$ for all $g$, then $D\le0$ everywhere.* Suppose $D(t_0)>0$. The zeros are isolated, so there are $\eta>0$ and an open interval $J$ containing no ordinate $\gamma$ with $D\ge\eta$ on $J$. Take $g_0$ in the Schwartz class with $\hat g_0\in C_c^\infty(J)$, $\hat g_0\not\equiv0$, and put $g_R(u)=g_0(u)\chi(u/R)$ with $\chi\in C_c^\infty$ equal to $1$ near $0$. Then $\hat g_R\to\hat g_0$ in the Schwartz topology, so $|\hat g_R(t)-\hat g_0(t)|\le C_R(1+t^2)^{-1}$ with $C_R\to0$. Because $\sum_\gamma(1+\gamma^2)^{-2}<\infty$ and $\hat g_0$ vanishes at every $\gamma$, the first integral in (1) for $g_R$ tends to $0$. The second tends to $\frac1\pi\int|\hat g_0|^2D\ge\frac\eta\pi\|\hat g_0\|_2^2>0$. So $W_d(h_{g_R})<0$ for large $R$.

*Step 2: $D\le0$ and $d\ge0$ near $0$ force $d=0$.* Take $\psi\in C_c^\infty$ real, even, nonnegative, not zero, supported in $(-c/2,c/2)$, and $\varphi=\psi*\psi$. Then $\varphi\ge0$ is even, supported in $(-c,c)$, and $\hat\varphi=\hat\psi^{\,2}\ge0$. By Fubini and Fourier inversion,

$$
\int\hat\varphi(t)D(t)\,dt=2\pi\int_{(0,c)}\varphi(u)\,dd(u).
$$

The left side is $\le0$ and the right side is $\ge0$, so both vanish. Then $\hat\varphi D\equiv0$ by continuity. The zeros of $\hat\psi$ are isolated, so $D\equiv0$. $D$ is half the Fourier transform of the even measure $d(u)+d(-u)$ on $\mathbb R$, so that measure is zero and $d=0$. $\qquad\blacksquare$

**Proposition 2 (conditional on RH; the same statement on the zero side).** Assume the Riemann hypothesis and let $\nu$ be the counting measure of the ordinates $\gamma$. Let $\kappa$ be a finite even signed Borel measure on $\mathbb R$, not zero, with $\nu+\kappa\ge0$. Put $\hat\kappa(u)=\int e^{itu}\,d\kappa(t)$. Then the functional $h_g\mapsto\int|\hat g|^2\,d(\nu+\kappa)$ is Weil's functional with the prime measure replaced by $\sum_n\Lambda(n)n^{-1/2}\delta_{\log n}-\hat\kappa(u)\,du$, and this measure is not nonnegative on $(0,\infty)$.

So under RH no finite even change $\kappa$ of the zeros along the line that keeps $\nu+\kappa\ge0$, such as moving finitely many of them, lowering a multiplicity, or adding a small continuous density, is compatible with a nonnegative prime measure.

*Proof.* $\hat\kappa$ is real, even, bounded and continuous. Since $\hat h_g=|\hat g|^2$, Fubini gives $\int|\hat g|^2d\kappa=\int h_g(u)\hat\kappa(u)\,du=\int_0^\infty(h_g(u)+h_g(-u))\hat\kappa(u)\,du$, which is the first claim. Suppose the new prime measure is nonnegative. The true prime measure vanishes off the closed discrete set of logarithms of prime powers, so $\hat\kappa\le0$ off that set, hence everywhere on $(0,\infty)$ by continuity, hence on $\mathbb R$ by evenness. Take $\psi\in C_c^\infty$ real, even, nonnegative, not zero, supported in $(-7,7)$, and $\varphi=\psi*\psi$, supported in $(-14,14)$, with $\hat\varphi=\hat\psi^{\,2}\ge0$. By Fourier inversion $\int\varphi\,d\kappa=\frac1{2\pi}\int\hat\varphi(u)\hat\kappa(u)\,du\le0$. The first zero has ordinate $14.1347\ldots$, a classical computation, so there is no ordinate with $|\gamma|<14$ and $\kappa\ge0$ on $(-14,14)$ (any gap $(-c,c)$ would do, and one exists because $\zeta(\tfrac12)\ne0$ and the zeros are discrete) and $\int\varphi\,d\kappa\ge0$. Hence $\hat\varphi\hat\kappa\equiv0$, the zeros of $\hat\psi$ are isolated, so $\hat\kappa\equiv0$ and $\kappa=0$. $\qquad\blacksquare$

The two propositions are mirror images. In the first, the gap that does the work is the absence of prime powers below $2$. In the second it is the absence of zeros below height $14$.

**Remarks.**

1. The proof of Proposition 1 uses RH only through $W(h_g)=\int|\hat g|^2d\nu$ with $\nu$ a positive measure carried by a discrete set, together with $\sum_\gamma(1+\gamma^2)^{-2}<\infty$. If RH fails, $W$ itself is not positive, and the proposition says nothing about which measures $d$ could make $W_d$ positive.
2. The condition near $0$ cannot be dropped. Subtracting from the prime measure an integrable positive definite function, which has its largest value at $u=0$, keeps positivity. A run of [positivity_predicts_next_prime.py](../../certificates/prime-birth/positivity_predicts_next_prime.py) with signed weights, recorded in its header, finds a discrete version of this family: a negative atom at $x=e^u$ between $1.02$ and $1.24$ restores positivity where a prime is missing.
3. The proposition is a statement about all support lengths at once. Section 3 measures how soon the failure shows at finite $L$.

## 3. Each prime power in turn: certified intervals, then computations

The first case can be made rigorous, with no hypothesis. Write $W_0(h)=\int h(u)\,2\cosh(u/2)\,du+\mathcal A(h)$ for the pole and archimedean part of the functional, with no primes.

**Proposition 3 (unconditional; interval arithmetic).** Let $g(u)=\sin(2\pi u)$ for $0\le u\le1$ and $g=0$ elsewhere, so that $h_g(u)=\tfrac12(1-|u|)\cos(2\pi u)+\frac{\sin(2\pi|u|)}{4\pi}$ for $|u|\le1$. Then

$$
-0.1258\le W_0(h_g)\le-0.1075 .
$$

Consequently, if $\mu$ is a nonnegative Borel measure on $(0,\infty)$, finite on $(0,1]$, with $W_0(h_g)-2\int h_g\,d\mu\ge0$, then $\mu\bigl((0.2848,\,1)\bigr)\ge0.215$. In terms of $x=e^u$: the measure has mass at least $0.215$ between $1.329$ and $e$.

*Proof.* For this $g$ the pole term is $2\hat g(\tfrac i2)\hat g(-\tfrac i2)=-4a^2(\cosh\tfrac12-1)/(a^2+\tfrac14)^2$ with $a=2\pi$, and $\mathcal A(h_g)=-\tfrac12(\gamma_E+\log\pi)+2\int_0^1F(u)\,du-\tfrac12\log(1-e^{-2})$ with $F(u)=\bigl(\tfrac12e^{-2u}-e^{-u/2}h_g(u)\bigr)/(1-e^{-2u})$. The script [first_prime_forced_certificate.py](../../certificates/prime-birth/first_prime_forced_certificate.py) encloses $\int_{0.001}^1F$ by interval arithmetic on 1386 subintervals and bounds $|F|\le(1.3+2\pi^2d)/(2(1-d))$ on $[0,d]$, $d=0.001$, from $|n'|\le1.3+2\pi^2d$ for the numerator $n$ and $1-e^{-2u}\ge2u(1-u)$. It returns $W_0(h_g)\in[-0.125771,-0.107579]$. It also certifies $h_g\ge0$ on $[0,0.2848]$ and $h_g\ge-0.250026$ on $[0,1]$. If $W_0(h_g)-2\int h_g\,d\mu\ge0$ then $\int h_g\,d\mu\le-0.0537$, and $\int h_g\,d\mu\ge-0.250026\,\mu((0.2848,1))$. $\qquad\blacksquare$

The same method with $L=0.8$ and $g(u)=\sin\theta+0.192\sin2\theta+0.103\sin3\theta$, $\theta=2\pi u/0.8$, on $[0,0.8]$ gives $W_0(h_g)\in[-0.016499,-0.014629]$, $h_g\ge0$ on $[0,0.2493]$ and $h_g\ge-0.2028$, so under the same hypothesis for this $g$ the measure has mass at least $0.036$ between $x=1.283$ and $x=e^{0.8}<2.2256$ ([first_prime_forced_certificate_general.py](../../certificates/prime-birth/first_prime_forced_certificate_general.py)). In these two cases the shorter support gives the narrower interval and the weaker bound on the mass.

The function $g$ is continuous and piecewise smooth, not in $C_c^\infty$. If the functional with $\mu$ is nonnegative on smooth test functions supported in $(0,1)$, the inequality for this $g$ follows by approximation: $g\in H^1_0(0,1)$, so take smooth $g_n\to g$ in $H^1$ with supports in $(0,1)$; then $h_{g_n}\to h_g$ uniformly and $|h_{g_n}(0)-h_{g_n}(u)|\le\|g_n'\|^2u^2/2$ uniformly in $n$, which gives convergence of the pole term, of $\mathcal A$, and of $\int h\,d\mu$ for $\mu$ finite on $(0,1]$. The only prime power between $1.329$ and $e$ is $2$, with weight $\log2/\sqrt2=0.490$, and for the true primes $W_0(h_g)-2h_g(\log2)\cdot0.490=+0.0082$ (ordinary quadrature: $W_0(h_g)=-0.117427$, $h_g(\log2)=-0.128202$). In words: a system with Riemann's Gamma factor, a simple pole and a nonnegative prime measure whose Weil functional is nonnegative must have a generalized prime below $e$, of weight at least $0.215$ if it has only one there. This says nothing about RH.

**Proposition 4 (unconditional; interval arithmetic; the next five steps).** Let $P$ be $\{2\}$, $\{2,3\}$, $\{2,3,5\}$, $\{2,3,5,7\}$ or $\{2,3,5,7,11\}$, let $\mu_P=\sum(\log p/\sqrt q)\,\delta_{\log q}$ over the powers $q=p^k$ of the primes $p\in P$, and let $\mu'$ be a nonnegative Borel measure supported in $(\log\max P,\infty)$ and finite on bounded sets. With $g=\sum_jc_j\sin(2\pi ju/L)$ on $[0,L]$ as in the table, if $W_0(h_g)-2\int h_g\,d(\mu_P+\mu')\ge0$ then $\mu'$ has at least the stated mass at positions $x=e^u$ in the stated interval.

| $P$ | $L$ | $(c_1,c_2,\dots)$ | $W_0(h_g)-2\int h_g\,d\mu_P$ lies in | mass of $\mu'$ at least | for $x$ between |
|---|---|---|---|---|---|
| $\{2\}$ | $1.25$ | $(0.521,\,1,\,0.318)$ | $[-0.147558,\,-0.141107]$ | $0.1755$ | $2.1358$ and $3.4904$ |
| $\{2,3\}$ | $1.75$ | $(0.396,\,0.749,\,1)$ | $[-0.164271,\,-0.137134]$ | $0.1067$ | $3.3559$ and $5.7547$ |
| $\{2,3,5\}$ | $2.05$ | $(0.262,\,0.514,\,0.749,\,1,\,0.772)$ | $[-0.268578,\,-0.187416]$ | $0.0829$ | $5.1125$ and $7.7680$ |
| $\{2,3,5,7\}$ | $2.5$ | $(0.275,\,0.534,\,0.759,\,0.927,\,1,\,0.831)$ | $[-0.327673,\,-0.154230]$ | $0.0389$ | $7.8214$ and $12.1826$ |
| $\{2,3,5,7,11\}$ | $2.68$ | $(0.233,\,0.459,\,0.670,\,0.857,\,1)$ | $[-0.255932,\,-0.148844]$ | $0.0617$ | $11$ and $14.5852$ |

*Proof.* Same argument as Proposition 3, with the closed form of $h_g$ for a sine polynomial and the enclosures printed by [first_prime_forced_certificate_general.py](../../certificates/prime-birth/first_prime_forced_certificate_general.py), which also certifies that $h_g\ge0$ above $\log\max P$ outside the interval and gives the lower bound for $h_g$ used for the mass. $\qquad\blacksquare$

In the second and third rows $\mu_P$ contains the atom at $4$, and in the last two rows the atoms at $4$, $8$ and $9$. The true prime powers in the five intervals that are not already in $\mu_P$ are $3$, then $5$, then $7$, then $11$, then $13$. The last two rows were computed after the independent review. The certificates do not locate the mass inside the interval: the third one does not exclude mass at $6$. They also give lower bounds $0.215$, $0.1755$, $0.1067$, $0.0829$, $0.0389$, $0.0617$ that are well below the true weights $0.490$, $0.634$, $0.720$, $0.735$, $0.723$, $0.711$. Sharper localisation and the exact weights are what the computations below indicate, and they are not proved.

The remaining statements in this section are computations, not proofs.

Test functions: $g_k(u)=e^{2\pi iku/L}/\sqrt L$ on $[0,L]$, $|k|\le K$. The form $W_d$ on their span is a Hermitian matrix of size $2K+1$. Double precision, so an eigenvalue within about $10^{-11}$ of zero is a numerical zero. Script: [positivity_predicts_next_prime.py](../../certificates/prime-birth/positivity_predicts_next_prime.py).

Start from a list of known atoms, let $L$ grow, and record the first $L$ at which the smallest eigenvalue is negative. Then look for one extra atom, at position $x$ on a grid of step $0.02$ with weight $c\ge0$ chosen to maximise the smallest eigenvalue, and list the positions where the result is not negative.

| known atoms | form stays $\ge0$ up to $L$ | first failure | positions that repair it | weight found | true weight |
|---|---|---|---|---|---|
| none | $0.75$ | $-0.068$ at $L=0.80$ ($x<2.23$) | $[1.94,2.08]$ at $L=0.8$; $\{2.00,2.02\}$ at $0.9$; only $2.00$ at $1.05$ | $0.4900$ | $\log2/\sqrt2=0.49013$ |
| $2$ (and its powers) | $1.10$ | $-0.021$ at $L=1.15$ ($x<3.16$) | only $3.00$ from $L=1.25$ | $0.63428$ | $\log3/\sqrt3=0.63428$ |
| $2,3$ without $4$ | $1.40$ | $-0.021$ at $L=1.45$ ($x<4.26$) | only $4.00$ | $0.34657$ | $\log2/2=0.34657$ |
| $2,3$ (and powers) | $1.60$ | $-0.029$ at $L=1.65$ ($x<5.21$) | only $5.00$ | $0.71976$ | $\log5/\sqrt5=0.71976$ |
| $2,3,5$ (and powers) | $1.95$ | $-0.126$ at $L=2.00$ ($x<7.39$) | only $7.00$ | $0.73548$ | $\log7/\sqrt7=0.73548$ |

Two things in the table are not automatic. The prime power $4$ is found with weight $\log2/2$, the value an Euler product assigns. And with $2,3,5$ present the form stays at numerical zero from $L=1.70$ through $L=1.95$, so nothing is needed at $6$.

The inputs are the pole terms and $\mathcal A$, which are the data of the factor $s(s-1)\pi^{-s/2}\Gamma(s/2)$, together with positivity and the nonnegativity of the new weight. The grid of step $0.02$ contains the integers; nothing else marks them.

The table feeds the exact earlier primes to each step. A version with no such help is [positivity_minimum_mass.py](../../certificates/prime-birth/positivity_minimum_mass.py): put nonnegative unknown weights on the grid $x=1.06,1.08,\dots,5.46$ (221 positions, $L=1.7$, $K=34$) and find the smallest total weight for which the smallest eigenvalue is at least $-10^{-7}$. This is a convex problem. The positions that receive weight above $0.1$ are exactly $2.00$, $3.00$, $4.00$, $5.00$, with weights $0.4886$, $0.6098$, $0.2576$, $0.3770$ against the true $0.4901$, $0.6343$, $0.3466$, $0.7198$. A further $0.22$ is spread over 31 positions, the largest $0.05$ at $4.34$. The same search at $L=2.0$, $K=40$ on 317 positions up to $7.38$ gives weight above $0.03$ at exactly $2.00$, $3.00$, $4.00$, $5.00$, $7.00$ ($0.4887$, $0.5997$, $0.2741$, $0.6172$, $0.3481$; the true weight of $7$ is $0.7355$) and nothing above $10^{-4}$ within $0.02$ of $6$. The weights are biased low, more so toward $e^L$, because the objective removes mass wherever the constraint is loose; the true measure is feasible but is not the minimiser. An earlier greedy attempt, which added one atom at a time at continuous positions and never corrected earlier atoms, failed at the second atom because an error of $6\cdot10^{-4}$ in the first one is already incompatible with positivity later.

Where exactly the form without any prime first fails can be read off with more test functions. Its smallest eigenvalue is about $1.06\cdot10^{-3}$, stable from $K=16$ to $K=72$, for $L$ from $0.73$ to $0.744$. A second eigenvalue falls linearly in $L$ with slope about $-1.4$ and crosses zero between $L=0.744$ and $L=0.746$ for both $K=48$ and $K=72$, that is at $x$ between $2.104$ and $2.109$. So in this computation the form does not need the prime $2$ at the moment it enters ($L=\log2=0.693$); it needs it by $x\approx2.11$, and Proposition 3 certifies the weaker bound $2.2256$.

A second experiment drops the "one atom" assumption. [positivity_feasible_weights.py](../../certificates/prime-birth/positivity_feasible_weights.py) puts nonnegative unknown weights on the grid $x=1.1,1.2,\dots$ below $e^L$ and computes the smallest and largest total weight within $0.2$ of each half-integer for which some choice of all the other weights keeps the smallest eigenvalue above $-10^{-7}$.

| $L$, $K$ | near $1.5$ | near $2$ (true $0.49013$) | near $2.5$ | near $3$ (true $0.63428$) | near $3.5$ | near $4$ (true $0.34657$) |
|---|---|---|---|---|---|---|
| $1.0$, $16$ | $\le2.4\cdot10^{-3}$ | $[0.473,\,0.534]$ | | | | |
| $1.45$, $24$ | $\le1.4\cdot10^{-5}$ | $[0.49004,\,0.49022]$ | $\le1.1\cdot10^{-3}$ | $[0.6299,\,0.6387]$ | $\le0.036$ | wide |
| $2.0$, $40$ | $\le7.0\cdot10^{-6}$ | $[0.490084,\,0.490154]$ | $\le4.0\cdot10^{-4}$ | $[0.6328,\,0.6350]$ | $\le7.8\cdot10^{-3}$ | $[0.328,\,0.354]$ |

In the last row the total near $5$ lies in $[0.660,\,0.730]$ (true $0.71976$) and the total near $6$ is at most $0.012$. The ranges tighten as $L$ grows and are loose near $e^L$. The second and third rows had 13 and 58 stalled Newton iterations, so their ranges may be too narrow.

## 4. A linear program with no primes and no zeros in its input

Write a candidate prime measure as $\mu=(e^{u/2}-\omega(u))\,du$ on $u>0$, where $\omega$ may be a distribution, and put $\omega_c(t)=\int_0^\infty\omega(u)\cos(tu)\,du$. The pole terms equal $\int_0^\infty(h(u)+h(-u))\,2\cosh(u/2)\,du$ and $\mathcal A(h_g)=\frac1{2\pi}\int|\hat g(t)|^2\bigl(\operatorname{Re}\psi(\tfrac14+\tfrac{it}2)-\log\pi\bigr)dt$, so

$$
W_\mu(h_g)=\frac1\pi\int|\hat g(t)|^2\bigl(\omega_c(t)-N(t)\bigr)\,dt,\qquad
N(t)=-\tfrac12\operatorname{Re}\psi\bigl(\tfrac14+\tfrac{it}2\bigr)+\tfrac12\log\pi-\frac{1/2}{1/4+t^2}. \tag{2}
$$

Here $W_\mu$ is Weil's functional with $\mu$ in place of the prime measure. $N$ is an explicit function: $N(0)=0.686$, it is positive for $t<6.126$, and $N(t)\approx-\tfrac12\log(t/2\pi)$ for large $t$. So the pair of conditions "the functional is positive" and "the prime measure is nonnegative" reads

$$
\omega_c-N\ \ge0\ \text{ as a measure in }t,\qquad \omega(u)\le e^{u/2}\ \text{ as a measure in }u .
$$

For the true primes $\omega=e^{u/2}du-\sum_n\Lambda(n)n^{-1/2}\delta_{\log n}$, and under RH $\omega_c-N=\pi\sum_\gamma\delta_\gamma$, where $\omega_c$ is not a function and is defined through its pairing with $|\hat g|^2$ for compactly supported $g$. Both inequalities are then equalities except on a discrete set: the first fails to be an equality only at the zeros, the second only at the prime powers.

The script [explicit_formula_double_positivity_lp.py](../../certificates/prime-birth/explicit_formula_double_positivity_lp.py) solves a truncated version. Unknown: $x(t)=\omega_c(t)$ on a grid in $[0,T]$ with $x\ge N$, and $x=0$ beyond $T$. Then $\omega(u)=\frac2\pi\int_0^Tx(t)\cos(tu)\,dt$. Constraints: $\omega(u)\le e^{u/2}+s$ for $0<u\le U$, and $\omega(u)\ge e^{u/2}-s$ for $u<\log x_0$, which says there is no prime mass below $x_0$. Minimise $s$. The input contains the function $N$, the function $e^{u/2}$ and the number $x_0$. It contains no primes and no zeros.

| $T$, $U$, $x_0$ | $s$ | zero side: centre and mass of the first clusters | prime side: position and mass of the first peaks |
|---|---|---|---|
| $60$, $3$, none | $2.4\cdot10^{-3}$ | $14.01$, $20.14$, $22.95$, $24.55$ | diffuse |
| $200$, $2.5$, $1.9$ | $2.8\cdot10^{-4}$ | $14.12{:}0.99$, $20.91{:}0.97$, $24.78{:}0.91$, $30.25{:}0.92$, $32.79{:}1.04$ | $2.003{:}0.477$, $3.008{:}0.631$, $4.047{:}0.344$, $5.035{:}0.692$ |
| $400$, $3$, $1.9$ | $8\cdot10^{-5}$ | $14.13{:}1.00$, $20.99{:}0.98$, $30.40{:}0.95$, $32.98{:}0.90$, $43.25{:}0.97$, $49.63{:}1.00$ | $2.000{:}0.490$, $3.002{:}0.635$ |
| $400$, $3$, $1.5$ | $8\cdot10^{-5}$ | $14.13{:}1.00$, $20.99{:}0.99$, $30.41{:}0.96$, $32.92{:}0.98$, $43.19{:}0.98$, $48.00{:}0.94$ | $2.000{:}0.485$, $3.002{:}0.628$ |
| $800$, $3.5$, $1.5$ | $1\cdot10^{-5}$ | $14.13{:}1.00$, $21.00{:}0.99$, $25.14{:}0.86$, $32.98{:}0.92$, $43.34{:}0.95$, $47.97{:}0.89$ | $2.000{:}0.487$, $3.000{:}0.629$ |

The true values are zeros at $14.13$, $21.02$, $25.01$, $30.42$, $32.94$, $37.59$, $40.92$, $43.33$, $48.01$, $49.77$ and weights $0.490$, $0.634$, $0.347$, $0.720$ at $2,3,4,5$. With a condition $x_0$ between $1.2$ and $1.9$ the solution has masses close to $1$ near the first zeros and prime-side peaks at $2$, $3$, $4$, $5$ with roughly the right weights. The total mass on the zero side below $T$ agrees with the zero-counting formula ($79.19$ against $79.2$ for $T=200$, $201.64$ against $201.6$ for $T=400$). In the last row the mass within $0.016$ of $\log 6$, $\log 10$, $\log 12$, $\log 14$, $\log 15$ is $10^{-4}$, $1.6\cdot10^{-3}$, $1.6\cdot10^{-3}$, $10^{-4}$, $10^{-4}$. Without the condition (first row) the solution is a different atomic measure and a smooth competitor does almost as well, so the condition near $x=1$ is what brings the minimal-$s$ solution close to the zeta data. This matches the role of the hypothesis "$d\ge0$ near $0$" in Proposition 1. Propositions 1 and 2 say that, under RH, the true pair of measures cannot be changed by a finite amount on either side; they do not exclude other solutions that differ from it by an infinite amount.

**A consequence of RH that mentions neither primes nor zeros.** Let $W_0(h)=\int h(u)\,2\cosh(u/2)\,du+\frac1{2\pi}\int\hat h(t)\bigl(\operatorname{Re}\psi(\tfrac14+\tfrac{it}2)-\log\pi\bigr)dt$ be the pole and archimedean part of the explicit formula, for $h$ real, even, smooth and compactly supported. If RH holds, then

$$
W_0(h)\ge0\quad\text{whenever}\quad \hat h(t)\ge0\ \text{for all real }t\quad\text{and}\quad h(u)\ge0\ \text{for }|u|\ge\log2 .
$$

Indeed the explicit formula gives $W_0(h)=\sum_\gamma\hat h(\gamma)+2\sum_n\Lambda(n)n^{-1/2}h(\log n)$, the ordinates are real under RH, and every $\log n$ in the second sum is at least $\log2$. The linear program above is related to this inequality by duality, heuristically, since it is truncated and discretised: a function $h$ in that cone with $W_0(h)<0$ would show that no pair of nonnegative measures exists, and it would disprove RH. The converse direction would need a closedness argument that is not given here. The function $h_g$ with $W_0(h_g)<0$ found in section 3 at $L=0.8$ is not in the cone: only $n=2$ enters there and the form with the prime $2$ included is positive in the computation, so $h_g(\log2)<0$. Whether the inequality on this cone implies RH is the uniqueness question for the continuous problem, which is open here.

**How much of this is forced.** The table shows one solution, the one with the smallest $s$. [explicit_formula_double_positivity_lp_ranges.py](../../certificates/prime-birth/explicit_formula_double_positivity_lp_ranges.py) fixes the tolerance at $2s^*$ ($T=200$, $U=2.5$, $x_0=1.5$) and computes the smallest and largest mass that any solution can put in a window.

| window | smallest | largest | true |
|---|---|---|---|
| zero side, $t<13$ | $0$ | $0.054$ | $0$ |
| zero side, $[13.6,14.6)$ | $0.522$ | $1.008$ | $1$ |
| zero side, $[15.2,20)$ | $0$ | $0.559$ | $0$ |
| zero side, $[20.5,21.5)$ | $0$ | $1.082$ | $1$ |
| zero side, $[24.5,25.5)$ | $0$ | $1.092$ | $1$ |
| prime side, $x\in[1.9,2.1)$ | $0.447$ | $0.494$ | $0.490$ |
| prime side, $x\in[2.2,2.8)$ | $0$ | $0.129$ | $0$ |

So at this size the constraints pin the weight of the prime $2$ to within ten percent, exclude zero-side mass below height $13$, and force at least half of a unit mass near the first zero. They do not force the second and later zeros: once the tolerance is doubled, the windows around them can be emptied. The agreement of the higher zeros in the table is a property of the minimal-$s$ solution.

**Negative result in degree two.** The same program with the Gamma factor $\Gamma(s)$, conductor $4$ or $3$ and a simple pole, which are the data of the Dedekind zeta functions of $\mathbb Q(i)$ and $\mathbb Q(\sqrt{-3})$, does not return those fields' primes and zeros at $(T,U)=(200,2.5)$, $(300,3)$ or $(400,4.5)$. For conductor $4$ at $(400,4.5)$ the zero-side clusters are at $5.73$, $7.98$, $9.44$, $10.58$, $12.81$ against the true $6.02$, $10.24$, $12.99$, $14.13$, and the prime-side mass is $0.044$ at $2$ and $0.017$ at $5$ against the true $0.490$ and $1.440$. For conductor $3$ a few features are near the truth and most are not. One plausible reason is that nonnegativity of the total prime measure is a much weaker constraint when the measure is a sum of two parts, one of which is signed. Whatever the reason, the degree-one outcome is not evidence of a general mechanism.

Limits of this computation. The third zero comes out split ($24.8$ and $25.6$ or $25.8$) and the accuracy degrades with height, since $U=3$ only involves prime powers below $20$. $s$ is small and positive, not zero, because zeros above $T$ are replaced by a smooth density. Minimising $s$ is one choice of objective; no uniqueness theorem is proved for the continuous problem, and Proposition 1 covers only finite changes and assumes RH. One web search on 10 November 2026 found no paper doing this computation, which is not a claim of novelty.

## 5. How small the smallest eigenvalue is

With the true primes the smallest eigenvalue on $2K+1$ test functions is positive in every case computed, and very small ([weil_form_prime_weight_slack.py](../../certificates/prime-birth/weil_form_prime_weight_slack.py), 60 digits): $1.2\cdot10^{-6}$ at $L=1$, $K=10$; $1.0\cdot10^{-21}$ at $L=2$, $K=10$; $3.7\cdot10^{-25}$ at $L=2$, $K=14$. It still falls as $K$ grows. This is why a change of the weight of $2$ or $3$ by one part in $10^{12}$ already breaks positivity at $L=2$: there are several nearly null directions, and Proposition 1 is the statement that no finite change is compatible with all of them.

## 6. Zeros of the lowest eigenvector

Connes and van Suijlekom ([arXiv 2511.23257](https://arxiv.org/abs/2511.23257)) prove that when the lowest eigenvalue of such a form is simple with an even eigenfunction, the Fourier transform of that eigenfunction has only real zeros. Connes, Consani and Moscovici ([arXiv 2511.22755](https://arxiv.org/abs/2511.22755)) report that these zeros agree with the zeta zeros to high accuracy when only a few primes are used, and state that a proof of convergence would establish RH. The scripts [weil_lowest_eigenvector_zeros.py](../../certificates/prime-birth/weil_lowest_eigenvector_zeros.py) and [weil_lowest_eigenvector_zeros_double.py](../../certificates/prime-birth/weil_lowest_eigenvector_zeros_double.py) reproduce this in the plain Fourier basis above.

| $L$ | prime powers used | first zero of $F$ minus $\gamma_1=14.134725$ | further zeros matched |
|---|---|---|---|
| $0.6$ | none | $+0.80$ | |
| $1.0$ | $2$ | $7.1\cdot10^{-4}$ | $\gamma_2$ to $0.039$ |
| $1.45$ | $2,3,4$ | $2.3\cdot10^{-10}$ | $\gamma_2$ to $7.7\cdot10^{-8}$, $\gamma_5$ to $1.1\cdot10^{-3}$ |
| $2.0$, $K=14$ | $2,3,4,5,7$ | $2.2\cdot10^{-21}$ | $\gamma_2$ to $3.4\cdot10^{-18}$, $\gamma_8$ to $4.8\cdot10^{-6}$ |
| $2.6$, $K=14$ | all below $13.5$ | $1.9\cdot10^{-28}$ | $\gamma_2$ to $4.3\cdot10^{-24}$, $\gamma_6$ to $4.1\cdot10^{-7}$ |

These numbers depend on $K$. They describe this finite basis and are not a statement about the limit over all test functions.

## 7. What positivity at one support length tests

Positivity for a short support is weaker than it looks. Two controls:

**Davenport-Heilbronn.** This function has a functional equation of the same shape, real coefficients, no Euler product, and zeros off the line, the first near $0.8085+85.699i$. Its Weil form ([davenport_heilbronn_weil_form.py](../../certificates/prime-birth/davenport_heilbronn_weil_form.py), checked against a sum over 169 of its zeros) has smallest eigenvalue $0.30$, $4.1\cdot10^{-5}$, $3\cdot10^{-16}$ at $L=1,2,3$, numerical zero at $L=3.5$, and then $-0.73$ at $L=4$ and $-1.33$ at $L=4.5$. Up to $L=3.5$ it looks as positive as the zeta form.

**One displaced pair.** [displaced_zero_positivity.py](../../certificates/prime-birth/displaced_zero_positivity.py) takes the zeta zeros below $3000$ and moves one neighbouring pair at height $T_0$ off the line to real parts $\tfrac12\pm\delta$. The first $L$ with a negative eigenvalue:

| $T_0$ | $\delta=0.05$ | $0.1$ | $0.2$ | $0.3$ | $0.45$ | $\log(T_0/2\pi)$ |
|---|---|---|---|---|---|---|
| $100$ | $2.750$ | $2.750$ | $2.625$ | $2.500$ | $2.375$ | $2.77$ |
| $401$ | $4.250$ | $4.125$ | $3.875$ | $3.500$ | $3.125$ | $4.16$ |
| $1600$ | $5.500$ | $5.375$ | $5.125$ | $4.500$ | $3.875$ | $5.54$ |

A pair close to the line becomes visible when $L$ reaches $\log(T_0/2\pi)$, that is when the primes below $T_0/2\pi$ are in. A pair far from the line is caught earlier. This matches a density count: Fourier transforms of functions supported in an interval of length $L$ can vanish on at most $L/2\pi$ points per unit length, and the zeros near $T_0$ have $\log(T_0/2\pi)/2\pi$ per unit length. It is an observation on a synthetic zero set, not a theorem.

So the computations in sections 3 to 6, which stop between $L=2$ and $L=3$, test RH only against zeros of height below roughly $100$, where it is known.

## 8. What this does not do

RH is equivalent to $W(h_g)\ge0$ for every support length. Proposition 1 assumes that. The computations confirm it on finite sets of test functions for $L\le3$ and say nothing about larger $L$. A proof along these lines would need a lower bound for the smallest eigenvalue that holds for every $L$ and every test function, and the computations show that this eigenvalue is smaller than $10^{-24}$ already at $L=2$. No such bound is proposed here.
