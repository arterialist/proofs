# Exact negative cross-prime covariance under the actual cutoff law

For every real $x>1$, use the full arithmetic probability law

$$
Z_x=\sum_{n<x}\frac{x-n}{\sqrt n},\qquad
P_x(n)=\frac{x-n}{\sqrt n Z_x}.
$$

For an actual prime $p$, put

$$
m_p(n)=\log p\sum_{j=1}^{v_p(n)}p^{j/2},
\qquad \mu_p(x)=E_xm_p.
$$

The conclusion is

$$
\boxed{\operatorname{Cov}_x(m_p,m_q)<0
\quad\text{if }p\ne q\text{ and }x>\max(p,q).}
\tag{1}
$$

If one prime is at least $x$, its score vanishes and this covariance is zero. The theorem concerns the full cutoff law on all integers below $x$; it does not assert negative association after arbitrary additional conditioning on prime exponents. Its application to the [actual arithmetic sign criterion](actual-critical-sign-criterion.md) supplies only pairwise signs. The [complete signed balance](combined-prime-density-covariance.md) remains open. The proof below is a finite-sum argument and is not formalized in Lean.

## A finite-grid martingale

Let $X_N$ be uniform on the points $j/(N+1)$, $1\le j\le N$. Conditional on $X_N=j/(N+1)$, define $Y$ by

$$
Y=\begin{cases}
j/(N+2),&\text{with probability }(N+1-j)/(N+1),\\
(j+1)/(N+2),&\text{with probability }j/(N+1).
\end{cases}
$$

Direct calculation gives $E[Y|X_N]=X_N$. The two incoming probabilities at each interior point $k/(N+2)$ add to $1/(N+1)$, and the single incoming probability at each endpoint is also $1/(N+1)$. Thus $Y$ has the law of $X_{N+1}$.

The two conditional outcomes are distinct and have strictly positive probabilities. Strict Jensen inequalities for $\sqrt t$ and $1/\sqrt t$ on $(0,1)$ therefore give

$$
E\sqrt{X_{N+1}}<E\sqrt{X_N},\qquad
E X_{N+1}^{-1/2}>E X_N^{-1/2}.
$$

Write

$$
A_N=\sum_{n=1}^N n^{-1/2},\quad
C_N=\sum_{n=1}^N n^{1/2},\quad T_N=C_N/A_N.
$$

Since both expectations are positive,

$$
\boxed{\frac{T_{N+1}}{N+2}<\frac{T_N}{N+1}.}
\tag{2}
$$

Also $T_N$ itself strictly increases: it is the weighted mean of $1,...,N$ with weights $n^{-1/2}$, and adding the next, strictly larger point increases that mean. For integers $a\ge 2$ and $m\ge 1$, put $N_*=a(m+1)-1$. Applying (2) repeatedly gives

$$
T_N\le T_{N_*}<aT_m
\quad\text{whenever }am\le N<a(m+1).
\tag{3}
$$

This explicit coupling is the entire proof of the needed power-sum ratio. No asymptotic estimate for the sums is involved.

## A direct increment-ratio proof of the same comparison

There is also an elementary proof of (2) that uses neither a probabilistic coupling nor majorization. Set $D_N=(N+1)A_N$, $D_0=C_0=0$, and

$$
\frac{C_N-C_{N-1}}{D_N-D_{N-1}}=\frac1{1+h_N},\qquad
h_N=\frac{A_{N-1}}{\sqrt N}+\frac1N.
$$

For $n\ge2$, monotonicity of $x^{-1/2}$ and integration give

$$
A_{n-1}\le2\sqrt{n-1}-1
<\frac{2(n-1)}{\sqrt n}
<(\sqrt n+\sqrt{n+1})\left(1-\frac1{\sqrt{n(n+1)}}\right).
$$

The last comparison follows by increasing both factors from $2\sqrt n$ and $1-1/n$. The needed bound by the final expression also holds at $n=1$, where $A_0=0$. Multiplying by $1/\sqrt n-1/\sqrt{n+1}$ proves $h_{n+1}>h_n$. Thus the positive increment ratios strictly decrease. Since $C_N/D_N$ is their weighted average with weights $D_j-D_{j-1}>0$, the next ratio is strictly below that average, and $C_{N+1}/D_{N+1}<C_N/D_N$. This is exactly (2), with every finite endpoint included.

## Every integer dilation ratio increases

For an integer $a\ge 2$, set

$$
F_a(x)=\begin{cases}
a Z_{x/a}/Z_x,&x>a,\\
0,&1<x\le a.
\end{cases}
$$

The zero extension matches the numerator at $x=a$. All these functions are continuous, because the cutoff summands vanish when a new integer enters. On an interval $(N,N+1)$ with $N\ge a$, let $m=\lfloor N/a\rfloor\ge1$. The exact finite sums are

$$
Z_x=xA_N-C_N,\qquad
aZ_{x/a}=xA_m-aC_m.
$$

Their quotient derivative is

$$
F_a'(x)=
\frac{A_NA_m(aT_m-T_N)}{Z_x^2}>0
\tag{4}
$$

by (3). Hence $F_a$ is strictly increasing on $(a,\infty)$ and nondecreasing on all of $(1,\infty)$. This proof includes all transitions at integer cutoffs, including multiples of $a$.

Expanding the actual prime-power score gives

$$
\boxed{\mu_p(x)=\log p\sum_{j\ge1}F_{p^j}(x).}
\tag{5}
$$

The sum is locally finite and every summand is continuous and nondecreasing. Its first summand strictly increases for $x>p$. Thus $\mu_p$ vanishes on $(1,p]$ and strictly increases on $(p,\infty)$.

## Exact cross-prime size bias

Let $p\ne q$. Expanding $m_p$, set $n=p^j d$. Since the primes are distinct,
$m_q(p^j d)=m_q(d)$. The full finite sum therefore gives

$$
Z_x E_x(m_pm_q)
=\log p\sum_{p^j<x}p^j Z_{x/p^j}\,\mu_q(x/p^j),
$$
$$
Z_x\mu_p(x)
=\log p\sum_{p^j<x}p^j Z_{x/p^j}.
$$

Subtracting the product of means yields

$$
\boxed{
-\operatorname{Cov}_x(m_p,m_q)
=\frac{\log p}{Z_x}\sum_{p^j<x}p^j Z_{x/p^j}
\,[\mu_q(x)-\mu_q(x/p^j)].
}
\tag{6}
$$

If $x>\max(p,q)$, the sum is nonempty and each bracket is strictly positive. Indeed $x/p^j<x$; if it is at most $q$, the smaller mean is zero, and otherwise strict monotonicity applies. This proves (1) without dropping any prime power or multiplicative scale.

The same proof applies to divisibility indicators: for coprime integers $a,b\ge 2$, their covariance is strictly negative when both are active, since
$P_x(a\mid n)=F_a(x)/\sqrt a$ and conditioning on $a\mid n$ rescales the cutoff to $x/a$. Positive combinations of such indicators with disjoint prime supports inherit a nonpositive pair covariance. This is a pairwise statement, not full negative association.

## Upper-orthant products and exponential moments

Write $D_a(x)=P_x(a\mid n)=F_a(x)/\sqrt a$ for integers $a\ge2$, and $D_1(x)=1$. Exact conditioning on $a\mid n$ rescales the full cutoff to $x/a$. Iteration therefore gives, for any finite family of positive integers $a_i$,

$$
D_{\prod_i a_i}(x)\le\prod_i D_{a_i}(x).
\tag{7}
$$

If $x\le\prod_i a_i$, the left side is zero. Otherwise its exact product expression is $\prod_iD_{a_i}(x/\prod_{j<i}a_j)$, and cutoff monotonicity bounds each factor. The empty product is one. When the $a_i$ are pairwise coprime, the left side is their joint divisibility probability.

Let $S$ be a finite set of distinct primes and let $f_p:\mathbb N_0\to[0,\infty)$ be increasing. On the finite support of the actual law,

$$
f_p(v_p(n))=f_p(0)+\sum_{k\ge1}[f_p(k)-f_p(k-1)]\mathbf1_{p^k\mid n}.
$$

Every coefficient is nonnegative. Expanding the finite product and applying (7) to each term proves

$$
\boxed{E_x\prod_{p\in S} f_p(v_p(n))\le\prod_{p\in S}E_x f_p(v_p(n)).}
\tag{8}
$$

In particular, for nonnegative $t_p$,

$$
E_x\exp\!\left(\sum_{p\in S}t_pm_p(n)\right)
\le\prod_{p\in S}E_xe^{t_pm_p(n)}.
\tag{9}
$$

This gives the usual exponential-moment upper comparison with independent variables having the same one-prime marginals. It is a bound for functions of individual coordinates; grouping several coordinates into one increasing function requires a stronger assertion, which fails below.

## Negative association fails in the full law


Take $x=570$, $P=2\cdot3\cdot5\cdot7\cdot11\cdot13\cdot17$, and the increasing functions
$$
f(n)=\mathbf1_{\gcd(n,P)>1},\qquad
g(n)=\mathbf1_{19\mid n}.
$$
These depend on disjoint prime sets. Put
$$
U(t)=\sum_{1\le n<t}\frac{t-n}{\sqrt n}\,f(n).
$$
With $w_t(n)=(t-n)/\sqrt n$, one has $f(19m)=f(m)$ and $w_{570}(19m)=\sqrt{19}\,w_{30}(m)$. Therefore
$$
\operatorname{Cov}_{570}(f,g)
=D_{19}(570)\left(\frac{U(30)}{Z_{30}}-\frac{U(570)}{Z_{570}}\right)>0.
$$
Here the sign is certified by the rational bounds
$$
\frac{U(30)}{Z_{30}}>\frac{810972}{10^6},\qquad
\frac{U(570)}{Z_{570}}<\frac{809445}{10^6}.
$$
The following finite enclosures supply an exact arithmetic verification. Each table entry encloses $10^6$ times the indicated sum.

| Sum | Lower bound | Upper bound |
|---|---:|---:|
| $Z_{30}$ | 175471059 | 175471061 |
| $U(30)$ | 142302190 | 142302191 |
| $Z_{570}$ | 17312553610 | 17312553645 |
| $U(570)$ | 14013546815 | 14013546841 |

For completeness, these bounds require only integer square roots and rational addition. Let $K=10^8$ and $r_n=\lfloor\sqrt{nK^2}\rfloor$. Then
$$
\frac{K}{r_n+1}<\frac1{\sqrt n}\le\frac K{r_n}.
$$
Sum the resulting rational lower and upper bounds for $(t-n)/\sqrt n$, with or without the condition $\gcd(n,P)>1$. The table follows by outward rounding to multiples of $10^{-6}$. The [standalone rational certificate](certificates/triangular_negative_association.py) verifies every enclosure and both strict comparisons. The probability comparisons follow by integer cross multiplication. It is rigorous finite arithmetic evidence, not a Lean theorem.

The increasing union event $f$ contains negative coefficients when expanded by inclusion-exclusion into divisibility indicators. The prime-power covariance theorem therefore does not extend to negative association. This is a counterexample in the full law, before any conditioning on revealed primes. It differs from the [conditioned cross-prime counterexample](conditional-prime-dependence.md). Neither counterexample determines the sign of the arithmetic $W$.

## Attribution and conditional scope

The power-sum comparison belongs to the classical theory of majorization. In [Gao, *Sums of Powers and Majorization*, Corollary 2.3](https://rgmia.org/papers/v10n2/Powersums.pdf), writing $S_r(N)=\sum_{n=1}^N n^r$, the quantity

$$
P_N(r)=\left(\frac{S_r(N)/N}{S_r(N+1)/(N+1)}\right)^{1/r}
$$

is nonincreasing in $r\le1$. For $f_N=T_N/(N+1)$, direct algebra gives

$$
\frac{f_N}{f_{N+1}}
=\frac{N+2}{N+1}\sqrt{P_N(1/2)P_N(-1/2)}\ge1,
$$

because both factors under the square root are at least $P_N(1)=(N+1)/(N+2)$. This recovers the nonstrict form of (2). The explicit martingale coupling above proves the required strictness directly and keeps this note self-contained. No priority claim is made for the covariance application.

[Conditioned prime dependence](conditional-prime-dependence.md) proves that the negative covariance in (1) can become strictly positive after revealing smaller prime exponents. It retains the exact conditional support and gives the positive regression costs required in a prime-revelation variance bound. Consequently, (1) is not a negative-association theorem and does not justify deleting cross terms on every revealed-history branch.
