# Exact division renewal and a negative dyadic divisor average

The complete integer dyadic divisor sum is strictly negative with a uniform margin. Its factorial inequality and identification with the actual prime-power sum are formalized in Lean. The causal renewal, weighted integral and boundary-cancellation identities are written proofs. No priority or RH claim is made.

Let $\psi(x)=\sum_{n\le x}\Lambda(n)$, with every prime power included, and set

$$
a(t)=e^{-t/2}(\psi(e^t)-e^t),\qquad
\beta(t)=e^{-t/2}a(t),\qquad
Hf(t)=\sum_{d\le e^t}\frac{f(t-\log d)}d.
$$

All formulas below are for $t\ge0$, and the functions are extended by zero to negative arguments. In particular $a(0)=\beta(0)=-1$. The separate dyadic discrepancy below is denoted $b_2$.

## Exact finite renewal

For $x=e^t$ and $N=\lfloor x\rfloor$, the actual division identity gives

$$
\sum_{d\le x}\psi(x/d)
=\sum_{n\le x}\sum_{k\mid n}\Lambda(k)
=\log(N!).
$$

Consequently

$$
H\beta(t)=e^{-t}\log(N!)-H_N=: \ell(t),
\qquad H_N=\sum_{j=1}^N\frac1j. \tag{1}
$$

This is a finite renewal equation for $\beta$, including its initial value and all cutoff atoms. The classical [Stirling and digamma expansions](https://dlmf.nist.gov/5.11) imply, uniformly over real $t\ge0$,

$$
\ell(t)=-(1+\gamma)+O((1+t)e^{-t}). \tag{2}
$$

The convolution consumer is exact:

$$
H(\beta*\beta)=\beta*\ell. \tag{3}
$$

The unconditional bound of [Johnston–Yang, Theorem 1.1](https://arxiv.org/pdf/2204.01980) gives $|\beta(t)|\le9.39t^{1.515}e^{-0.8274\sqrt t}$ for $t\ge\log2$, so $\beta\in L^1(0,\infty)$. Taking Laplace transforms in (1), using $s\zeta(1+s)\to1$, proves $\int_0^\infty\beta(t)\,dt=-(1+\gamma)$. Dominated convergence in (3) therefore gives $H(\beta*\beta)(t)\to(1+\gamma)^2$. For the critical convolution,

$$
e^{-t/2}H(a*a)(t)
=\sum_{d\le e^t}d^{-3/2}(\beta*\beta)(t-\log d),
$$

so its weighted integral equals $\zeta(3/2)(1+\gamma)^2$, and its weighted absolute integral is at most $\zeta(3/2)\|\beta\|_1^2$. This exponential weight does not yield an RH-scale pointwise estimate.

## The finite dyadic average

Put $L=\log2$,

$$
b_2(t)=a(t+L)-\frac{a(t)}{\sqrt2}
=\frac{\psi(2x)-\psi(x)-x}{\sqrt{2x}},
\quad
v(t)=e^{-t/2}b_2(t)
=\frac{2\beta(t+L)-\beta(t)}{\sqrt2}.
$$

With $M=\lfloor2x\rfloor$, applying the division identity at both endpoints yields

$$
\sum_{d\le x}\left[\psi(2x/d)-\psi(x/d)-x/d\right]
=\log(M!/N!)-xH_N,
$$

$$
Hv(t)=\frac1{\sqrt2}\left[\frac{\log(M!/N!)}x-H_N\right]. \tag{4}
$$

Extending the first $\psi$-sum from $d\le x$ to $d\le2x$ adds zero terms: for $d>x$, its argument is in $[1,2)$. At $d=x$ the argument 2 remains in the original sum, so that prime endpoint is retained.

At every integer $x=N\ge1$, (4) has a uniform strict negative sign. Define

$$
A_N=NH_N-\log((2N)!/N!),\qquad \delta=\frac32-\log4>0.
$$

Factorial and harmonic recurrences give exactly

$$
A_{N+1}-A_N=H_N+1-\log(4N+2). \tag{5}
$$

Convexity of $1/t$ and the trapezoidal integral estimate give

$$
H_N\ge\log N+\frac12+\frac1{2N}.
$$

Using $\log(1+u)\le u$ in (5) proves $A_{N+1}-A_N\ge\delta$. Since $A_1=1-\log2>\delta$, induction yields

$$
\boxed{A_N>N\delta,\qquad Hv(\log N)<-\delta/\sqrt2.} \tag{6}
$$

An alternative proof sufficient for (5) uses the strict bound $H_N>1/2+\log(N+1/2)$. For $N\ge6$, it follows from the increasing lower Euler--Mascheroni sequence and $H_6-\log7>1/2$; the five smaller values follow from finite exponential-series lower bounds. The Lean proof uses this second route.

## Exact cancellation of the dyadic boundary

Write $B=H(\beta*\beta)$. Then

$$
\boxed{H(\beta*v)(t)=\frac1{\sqrt2}
\left[2B(t+L)-B(t)+2\int_t^{t+L}\ell(u)\,du\right].} \tag{7}
$$

Here is the complete boundary calculation. On $[0,L)$, $\beta=-1$, hence $(\beta*\beta)(s)=s$ for $0\le s\le L$. Directly splitting the convolution gives

$$
(\beta*\beta(\cdot+L))(t)
=(\beta*\beta)(t+L)+\int_t^{t+L}\beta(u)\,du.
$$

Applying $H$ to the first term loses exactly

$$
U(t)=\sum_{x<d\le2x}\frac{\log(2x/d)}d
$$

relative to $B(t+L)$. Applying $H$ to the integral gives $\int_t^{t+L}\ell(u)\,du+U(t)$, because all newly introduced arguments of $\beta$ lie in $[0,L)$. Thus the two copies of $U$ cancel exactly, proving (7).

The weight distinction is explicit. For $Kf(t)=\sum_{d\le e^t}d^{-1/2}f(t-\log d)$, one has $Kb_2=\sqrt x\,Hv$ and $K(a*b_2)=\sqrt x\,H(\beta*v)$. Equations (6)--(7) do not assert a sign for the critical $H(a*b_2)$.

The negative complete average is not termwise or prefix negativity. At $x=10$ its first divisor term is $\log(92378)-10>0$, from the actual events $11,13,16,17,19$. Indeed $92378>3^{10}>e^{10}$. The complete divisor sum is nevertheless negative by (6).

## Exact signed transfer and its arithmetic action

The Dirichlet multiplier taking $K$ to $H$ has coefficients

$$
c(n)=\frac1n\prod_{p\mid n}(1-\sqrt p).
$$

Thus $e^{-t/2}Ha(t)=\sum_{n\le e^t}c(n)n^{-1/2}\ell(t-\log n)$. These coefficients are signed, so the preceding finite sign cannot be transferred by assuming an inverse bound.

There is a precise one-sided action on the actual birth coefficients. The causal jumps of $\ell$ are $r(n)=(\log n-1)/n$, including $r(1)=-1$. Put $\widetilde c(n)=c(n)/\sqrt n$. Here $*_D$ denotes Dirichlet convolution. With $\mu$ the Möbius function, the classical identities $\mu*_{D}\log=\Lambda$ and $\mu*_{D}\mathbf1=\delta_1$ give

$$
(\widetilde c*_D r)(n)=\frac{S(n)-1}{n^{3/2}},
\qquad S(n)=\sum_{d\mid n}\sqrt d\,\Lambda(d).
$$

This is positive for every $n\ge3$: either an odd prime divisor already contributes more than 1, or $n=2^j$, $j\ge2$, and $S(n)\ge2\log2>1$. The coefficients at 1 and 2 are negative. This establishes positivity of the eventual birth forcing, while retaining the continuous drift and making no sign claim for the full function.

## Formal statements and dependencies

The [factorial module](BuildingBlocks/DivisionDyadicFactorial.lean) proves the exact recurrence and strict bound for

$$
A_N=NH_N-\log((2N)!/N!).
$$

The [prime-average module](BuildingBlocks/DivisionDyadicPrimeAverage.lean) defines

$$
D_N=\sum_{d=1}^N\left[\psi(\lfloor2N/d\rfloor)-\psi(\lfloor N/d\rfloor)-\frac Nd\right]
$$

using the repository's actual von Mangoldt sum, and proves $D_N=-A_N$. Natural-number division in the Lean source implements these floors. It reuses the already published `BuildingBlocks.MertensTransfer.logFactorial_eq_sum_psi` in [MertensArithmetic](BuildingBlocks/MertensArithmetic.lean), so the integer prime-to-factorial identification is part of the formal result.

All declarations below have namespace `BuildingBlocks`.

| Declaration | Formal statement |
| --- | --- |
| `harmonic_gt_log_half_shift` | $H_N>1/2+\log(N+1/2)$ for $N\ge1$. |
| `dyadicFactorialDeficit_succ` | The exact recurrence (5), including $N=0$. |
| `dyadicFactorialDeficit_increment_gt` | $A_{N+1}-A_N>\delta$ for $N\ge1$. |
| `dyadicFactorialDeficit_gt` | $A_N>N\delta$ for $N\ge1$. |
| `dyadicFactorial_margin_pos` | $\delta=3/2-\log4>0$. |
| `dyadicFactorial_average_lt`, `dyadicFactorial_average_neg` | The normalized factorial expression is below $-\delta<0$. |
| `sum_psi_two_mul_div_eq_logFactorial` | The upper-cutoff extension adds only zero prime sums. |
| `dyadicDivisorPrimeDiscrepancy_eq_factorial`, `dyadicDivisorPrimeDiscrepancy_eq_neg_deficit` | $D_N=\log((2N)!/N!)-NH_N=-A_N$. |
| `dyadicDivisorPrimeDiscrepancy_lt`, `dyadicDivisorPrimeDiscrepancy_neg`, `dyadicDivisorPrimeDiscrepancy_div_lt` | $D_N<-N\delta<0$ and $D_N/N<-\delta$ for $N\ge1$. |

The modules compile with Lean 4.24.0 and the repository's pinned mathlib. Their public theorems depend only on `propext`, `Classical.choice` and `Quot.sound`. The factorial proof uses mathlib's Euler–Mascheroni bounds, logarithm estimates and finite exponential-series inequalities. The source follows the repository's MIT license; mathlib retains Apache 2.0.

The divisor identities are classical Möbius inversion, specifically [DLMF 27.5.5](https://dlmf.nist.gov/27.5.E5). The written trapezoidal proof and the formal half-shift proof are retained as distinct routes to the factorial bound. Neither proves a sign for the critical two-history convolution in [the harmonic theorem](harmonic-convolution.md) or the eventual-sign premise of [the RH criterion](actual-critical-sign-criterion.md).
