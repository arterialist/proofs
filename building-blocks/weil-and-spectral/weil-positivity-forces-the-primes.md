# Weil positivity forces the primes one at a time: computations and a conditional rigidity lemma

**Status.** Proposition 1 is proved below in full and is **conditional on the Riemann hypothesis**. It is elementary and probably known; no literature search was done for it. Sections 3 to 6 are numerical computations with the true primes on finite sets of test functions, in double precision or at 60 digits. They are not proofs. Nothing here proves positivity of Weil's functional for any support length, and nothing here proves or bounds anything about zeros of $\zeta$. Section 5 reproduces a phenomenon reported by Connes, Consani and Moscovici. No Lean formalization.

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

The first two terms come from the pole of $\zeta$ and $\mathcal A$ from the factor $\pi^{-s/2}\Gamma(s/2)$. The script [weil_form.py](../../certificates/prime-birth/weil_form.py) implements this formula and checks it against a direct sum over the first 300 zeros.

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

**Remarks.**

1. The proof uses RH only through $W(h_g)=\int|\hat g|^2d\nu$ with $\nu$ a positive measure carried by a discrete set. If RH fails, $W$ itself is not positive, and the proposition says nothing about which measures $d$ could make $W_d$ positive.
2. The condition near $0$ cannot be dropped. Subtracting from the prime measure a positive definite function, which has its largest value at $u=0$, keeps positivity. The computation in section 3 finds a discrete version of this family: a negative atom at $x=e^u$ between $1.02$ and $1.24$ restores positivity where a prime is missing.
3. The proposition is a statement about all support lengths at once. Section 3 measures how soon the failure shows at finite $L$.

## 3. Computation: each prime power is forced shortly after it enters

Test functions: $g_k(u)=e^{2\pi iku/L}/\sqrt L$ on $[0,L]$, $|k|\le K$. The form $W_d$ on their span is a Hermitian matrix of size $2K+1$. Double precision, so an eigenvalue within about $10^{-11}$ of zero is a numerical zero. Script: [positivity_predicts_next_prime.py](../../certificates/prime-birth/positivity_predicts_next_prime.py).

Start from a list of known atoms, let $L$ grow, and record the first $L$ at which the smallest eigenvalue is negative. Then look for one extra atom, at position $x$ on a grid of step $0.02$ with weight $c\ge0$ chosen to maximise the smallest eigenvalue, and list the positions where the result is not negative.

| known atoms | form stays $\ge0$ up to $L$ | first failure | positions that repair it | weight found | true weight |
|---|---|---|---|---|---|
| none | $0.75$ | $-0.068$ at $L=0.80$ ($x<2.23$) | $[1.94,2.08]$ at $L=0.8$; $\{2.00,2.02\}$ at $0.9$; only $2.00$ at $1.05$ | $0.4900$ | $\log2/\sqrt2=0.49013$ |
| $2$ (and its powers) | $1.10$ | $-0.021$ at $L=1.15$ ($x<3.16$) | only $3.00$ from $L=1.25$ | $0.63428$ | $\log3/\sqrt3=0.63428$ |
| $2,3$ without $4$ | $1.40$ | $-0.021$ at $L=1.45$ ($x<4.26$) | only $4.00$ | $0.34657$ | $\log2/2=0.34657$ |
| $2,3$ (and powers) | $1.60$ | $-0.029$ at $L=1.65$ ($x<5.21$) | only $5.00$ | $0.71976$ | $\log5/\sqrt5=0.71976$ |
| $2,3,5$ (and powers) | $1.95$ | $-0.126$ at $L=2.00$ ($x<7.39$) | only $7.00$ | $0.73548$ | $\log7/\sqrt7=0.73548$ |

Two things in the table are not automatic. The prime power $4$ is forced with weight $\log2/2$, the value an Euler product assigns. And with $2,3,5$ present the form stays at numerical zero from $L=1.70$ through $L=1.95$, so nothing is needed at $6$.

The inputs are the pole terms and $\mathcal A$, which are the data of the factor $s(s-1)\pi^{-s/2}\Gamma(s/2)$, together with positivity and the nonnegativity of the new weight. The script is not told that atoms sit at integers.

The table feeds the exact earlier primes to each step. A version with no such help is [positivity_minimum_mass.py](../../certificates/prime-birth/positivity_minimum_mass.py): put nonnegative unknown weights on the grid $x=1.06,1.08,\dots,5.46$ (221 positions, $L=1.7$, $K=34$) and find the smallest total weight for which the smallest eigenvalue is at least $-10^{-7}$. This is a convex problem. The positions that receive weight above $0.1$ are exactly $2.00$, $3.00$, $4.00$, $5.00$, with weights $0.4886$, $0.6098$, $0.2576$, $0.3770$ against the true $0.4901$, $0.6343$, $0.3466$, $0.7198$. A further $0.22$ is spread over 31 positions, the largest $0.05$ at $4.34$. The weights are biased low, more so toward $e^L$, because the objective removes mass wherever the constraint is loose; the true measure is feasible but is not the minimiser. An earlier greedy attempt, which added one atom at a time at continuous positions and never corrected earlier atoms, failed at the second atom because an error of $6\cdot10^{-4}$ in the first one is already incompatible with positivity later.

A second experiment drops the "one atom" assumption. [positivity_feasible_weights.py](../../certificates/prime-birth/positivity_feasible_weights.py) puts nonnegative unknown weights on the grid $x=1.1,1.2,\dots$ below $e^L$ and computes the smallest and largest total weight within $0.2$ of each half-integer for which some choice of all the other weights keeps the smallest eigenvalue above $-10^{-7}$.

| $L$, $K$ | near $1.5$ | near $2$ (true $0.49013$) | near $2.5$ | near $3$ (true $0.63428$) | near $3.5$ | near $4$ (true $0.34657$) |
|---|---|---|---|---|---|---|
| $1.0$, $16$ | $\le2.4\cdot10^{-3}$ | $[0.473,\,0.534]$ | | | | |
| $1.45$, $24$ | $\le1.4\cdot10^{-5}$ | $[0.49004,\,0.49022]$ | $\le1.1\cdot10^{-3}$ | $[0.6299,\,0.6387]$ | $\le0.036$ | wide |
| $2.0$, $40$ | $\le7.0\cdot10^{-6}$ | $[0.490084,\,0.490154]$ | $\le4.0\cdot10^{-4}$ | $[0.6328,\,0.6350]$ | $\le7.8\cdot10^{-3}$ | $[0.328,\,0.354]$ |

In the last row the total near $5$ lies in $[0.660,\,0.730]$ (true $0.71976$) and the total near $6$ is at most $0.012$. The ranges tighten as $L$ grows and are loose near $e^L$. The second and third rows had 13 and 58 stalled Newton iterations, so their ranges may be too narrow.

## 4. How small the smallest eigenvalue is

With the true primes the smallest eigenvalue on $2K+1$ test functions is positive in every case computed, and very small ([weil_form_prime_weight_slack.py](../../certificates/prime-birth/weil_form_prime_weight_slack.py), 60 digits): $1.2\cdot10^{-6}$ at $L=1$, $K=10$; $1.0\cdot10^{-21}$ at $L=2$, $K=10$; $3.7\cdot10^{-25}$ at $L=2$, $K=14$. It still falls as $K$ grows. This is why a change of the weight of $2$ or $3$ by one part in $10^{12}$ already breaks positivity at $L=2$: there are several nearly null directions, and Proposition 1 is the statement that no finite change is compatible with all of them.

## 5. Zeros of the lowest eigenvector

Connes and van Suijlekom ([arXiv 2511.23257](https://arxiv.org/abs/2511.23257)) prove that when the lowest eigenvalue of such a form is simple with an even eigenfunction, the Fourier transform of that eigenfunction has only real zeros. Connes, Consani and Moscovici ([arXiv 2511.22755](https://arxiv.org/abs/2511.22755)) report that these zeros agree with the zeta zeros to high accuracy when only a few primes are used, and state that a proof of convergence would establish RH. The scripts [weil_lowest_eigenvector_zeros.py](../../certificates/prime-birth/weil_lowest_eigenvector_zeros.py) and [weil_lowest_eigenvector_zeros_double.py](../../certificates/prime-birth/weil_lowest_eigenvector_zeros_double.py) reproduce this in the plain Fourier basis above.

| $L$ | prime powers used | first zero of $F$ minus $\gamma_1=14.134725$ | further zeros matched |
|---|---|---|---|
| $0.6$ | none | $+0.80$ | |
| $1.0$ | $2$ | $7.1\cdot10^{-4}$ | $\gamma_2$ to $0.039$ |
| $1.45$ | $2,3,4$ | $2.3\cdot10^{-10}$ | $\gamma_2$ to $7.7\cdot10^{-8}$, $\gamma_5$ to $1.1\cdot10^{-3}$ |
| $2.0$, $K=14$ | $2,3,4,5,7$ | $2.2\cdot10^{-21}$ | $\gamma_2$ to $3.4\cdot10^{-18}$, $\gamma_8$ to $4.8\cdot10^{-6}$ |
| $2.6$, $K=14$ | all below $13.5$ | $1.9\cdot10^{-28}$ | $\gamma_2$ to $4.3\cdot10^{-24}$, $\gamma_6$ to $4.1\cdot10^{-7}$ |

These numbers depend on $K$. They describe this finite basis and are not a statement about the limit over all test functions.

## 6. What positivity at one support length tests

Positivity for a short support is weaker than it looks. Two controls:

**Davenport-Heilbronn.** This function has a functional equation of the same shape, real coefficients, no Euler product, and zeros off the line, the first near $0.8085+85.699i$. Its Weil form ([davenport_heilbronn_weil_form.py](../../certificates/prime-birth/davenport_heilbronn_weil_form.py), checked against a sum over 169 of its zeros) has smallest eigenvalue $0.30$, $4.1\cdot10^{-5}$, $3\cdot10^{-16}$ at $L=1,2,3$, numerical zero at $L=3.5$, and then $-0.73$ at $L=4$ and $-1.33$ at $L=4.5$. Up to $L=3.5$ it looks as positive as the zeta form.

**One displaced pair.** [displaced_zero_positivity.py](../../certificates/prime-birth/displaced_zero_positivity.py) takes the zeta zeros below $3000$ and moves one neighbouring pair at height $T_0$ off the line to real parts $\tfrac12\pm\delta$. The first $L$ with a negative eigenvalue:

| $T_0$ | $\delta=0.05$ | $0.1$ | $0.2$ | $0.3$ | $0.45$ | $\log(T_0/2\pi)$ |
|---|---|---|---|---|---|---|
| $100$ | $2.750$ | $2.750$ | $2.625$ | $2.500$ | $2.375$ | $2.77$ |
| $401$ | $4.250$ | $4.125$ | $3.875$ | $3.500$ | $3.125$ | $4.16$ |
| $1600$ | $5.500$ | $5.375$ | $5.125$ | $4.500$ | $3.875$ | $5.54$ |

A pair close to the line becomes visible when $L$ reaches $\log(T_0/2\pi)$, that is when the primes below $T_0/2\pi$ are in. A pair far from the line is caught earlier. This matches a density count: Fourier transforms of functions supported in an interval of length $L$ can vanish on at most $L/2\pi$ points per unit length, and the zeros near $T_0$ have $\log(T_0/2\pi)/2\pi$ per unit length. It is an observation on a synthetic zero set, not a theorem.

So the computations in sections 3 to 5, which stop between $L=2$ and $L=3$, test RH only against zeros of height below roughly $100$, where it is known.

## 7. What this does not do

RH is equivalent to $W(h_g)\ge0$ for every support length. Proposition 1 assumes that. The computations confirm it on finite sets of test functions for $L\le3$ and say nothing about larger $L$. A proof along these lines would need a lower bound for the smallest eigenvalue that holds for every $L$ and every test function, and the computations show that this eigenvalue is smaller than $10^{-24}$ already at $L=2$. No such bound is proposed here.
