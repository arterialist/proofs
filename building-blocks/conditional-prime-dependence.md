# Exact failure of conditional prime-score negative dependence

This note concerns the full law $P_x(n)\propto(x-n)/\sqrt n$ for every integer $n<x$. It does not alter the two-history scores or their proper prime powers. It proves that the [negative cross-prime covariance theorem](prime-score-negative-covariance.md) for the unconditioned law does not survive the exact conditioning used in a prime-revelation martingale. It then derives the correction required in a conditional variance argument. The proof is written mathematics with an exact integer/rational certificate, not a Lean formalization. No priority claim is made.

## The precise law after revealing prime exponents

Let $E$ be the finite set of already revealed primes, with revealed exponents $e_r$. Put

$$
d=\prod_{r\in E}r^{e_r},\qquad Q=\prod_{r\in E}r,
\qquad y=x/d.
$$

On every branch of positive probability, the remaining integer $n/d$ has law

$$
Z_Q(y)=\sum_{\substack{m<y\\(m,Q)=1}}\frac{y-m}{\sqrt m},
\qquad
P_y^Q(m)=\frac{y-m}{\sqrt m Z_Q(y)}\mathbf1_{(m,Q)=1}.
\tag{1}
$$

Indeed the original mass at $dm$ is $\sqrt d\,(y-m)/\sqrt m$, and its common factor cancels. The holes $(m,Q)>1$ are essential. For an unrevealed prime $p$, the remaining actual score is still

$$
m_p(m)=\log p\sum_{j=1}^{v_p(m)}p^{j/2}.
$$

Write $\mu_p^Q(y)=E_y^Qm_p$.

## An admissible branch with strictly positive covariance

Take

$$
x=20806=2\cdot101\cdot103,
\quad E=\{r:r\text{ prime},r<101\},
\quad e_r=0\text{ for all }r\in E.
\tag{2}
$$

This branch has positive probability, for example through $n=1$. Its remaining support consists of 1 and every integer below $x$ whose prime factors are at least 101. Set $p=101$ and $q=103$, and remove the two harmless positive logarithms by writing

$$
A=Z_Q(x)E_y^Q[m_p/\log p],\quad
B=Z_Q(x)E_y^Q[m_q/\log q],
\quad
C=Z_Q(x)E_y^Q[m_pm_q/(\log p\log q)].
$$

Here $y=x$. A joint contribution requires $pq$ to divide $n$. Since $x=2pq$, the only positive-weight such state is $n=pq$. Therefore

$$
C=pq=10403.
\tag{3}
$$

All proper powers in the marginal scores are retained. The only possible powers are $p,p^2$ and $q,q^2$, giving exactly

$$
A=101Z_Q(206)+10605,\qquad
B=103Z_Q(202)+10197.
\tag{4}
$$

The supports of both small partition functions are 1 and the following 21 primes:

$$
101,103,107,109,113,127,131,137,139,149,151,
157,163,167,173,179,181,191,193,197,199.
$$

Their sum is 3167. Since their square roots exceed 10,

$$
Z_Q(206)<205+1159/10=3209/10,
\quad
Z_Q(202)<201+1075/10=617/2.
$$

Consequently

$$
A<430159/10,\qquad B<83945/2.
\tag{5}
$$

For a lower bound on the full $Z_Q(x)$, it suffices to retain 1 and the primes in three short ranges. Their exact counts are 143 in (100,1000], 135 in (1000,2000], and 127 in (2000,3000]. Every one is an allowed state. Using $\sqrt{1000}<32$, $\sqrt{2000}<45$, and $\sqrt{3000}<55$ gives

$$
Z_Q(x)>
20805+143\frac{19806}{32}
+135\frac{18806}{45}+127\frac{17806}{55}
=\frac{182025127}{880}.
\tag{6}
$$

The [exact integer/rational certificate](certificates/conditional_prime_dependence.py) checks these finite prime counts and bounds by integer trial division and rational arithmetic. Run `python3 building-blocks/certificates/conditional_prime_dependence.py` from the repository root, without `-O`.

Combining (3), (5), and (6) gives the strict rational bound

$$
\boxed{CZ_Q(x)-AB>
\frac{304780716961}{880}>0.}
\tag{7}
$$

Multiplication by $\log(101)\log(103)/Z_Q(x)^2$ proves

$$
\boxed{\operatorname{Cov}_x
(m_{101},m_{103}\mid v_r(n)=0\text{ for every prime }r<101)>0.}
\tag{8}
$$

Only lower bounds were used on the full partition function. All omitted allowed primes, semiprimes, and proper powers make that lower bound stronger; none was removed from the actual law.

## The conditional regression itself increases

The same example directly defeats the monotone-regression property that a sequential proof might need. After the branch (2), reveal $v_{101}(n)$.

If $v_{101}(n)=1$, the residual law has cutoff 206 and excludes 101 as well as the earlier primes. Its 103-score mean divided by $\log(103)$ is

$$
\frac{103}{Z_{101Q}(206)}>
\frac{103}{3209/10}>\frac14.
\tag{9}
$$

If $v_{101}(n)=0$, its numerator is at most $B$, while its denominator is the full $Z_Q(x)$ minus the unnormalized mass of 101-divisible states. The latter mass equals $\sqrt{101}Z_Q(206)<11(3209/10)$. Equations (5)-(6) imply

$$
Z_Q(x)-\sqrt{101}Z_Q(206)>4(83945/2)>4B.
$$

Hence

$$
E[m_{103}\mid\text{branch (2)},v_{101}(n)=0]
<\frac{\log103}{4}
<E[m_{103}\mid\text{branch (2)},v_{101}(n)=1].
\tag{10}
$$

The $v_{101}=2$ branch has 103-score zero. All three branches have positive probability. Thus the conditional regression is not even monotone in the revealed exponent.

## The exact conditional covariance and its required correction

For any branch (1) and two distinct unrevealed primes $p,q$, the same finite size-bias calculation as in the unconditioned proof remains valid, but with every hole retained:

$$
\boxed{\operatorname{Cov}_y^Q(m_p,m_q)
=\frac{\log p}{Z_Q(y)}
\sum_{p^j<y}p^jZ_Q(y/p^j)
[\mu_q^Q(y/p^j)-\mu_q^Q(y)].}
\tag{11}
$$

The substitution $m=p^j d$ preserves $(m,Q)=1$ because $p\nmid Q$. It also preserves the $q$-score because $p\ne q$. Formula (11) retains every admissible prime power.

Define the actual positive regression cost

$$
\mathcal C_{p,q}^Q(y)=\frac{\log p}{Z_Q(y)}
\sum_{p^j<y}p^jZ_Q(y/p^j)
[\mu_q^Q(y/p^j)-\mu_q^Q(y)]_+.
\tag{12}
$$

Then

$$
\operatorname{Cov}_y^Q(m_p,m_q)
=\mathcal C_{p,q}^Q(y)-\mathcal N_{p,q}^Q(y)
\le\mathcal C_{p,q}^Q(y),
\tag{13}
$$

where $\mathcal N$ is the same explicit sum with the opposite positive part. In the unconditioned theorem $Q=1$, monotonicity makes $\mathcal C$ identically zero. Equation (8) proves that this deletion is invalid for revealed-history branches.

For any finite collection $U$ of remaining primes, a correct conditional variance bound is therefore

$$
\boxed{\operatorname{Var}_y^Q\left(\sum_{p\in U}m_p\right)
\le\sum_{p\in U}\operatorname{Var}_y^Q(m_p)
+2\sum_{\substack{p<q\\p,q\in U}}
\min\{\mathcal C_{p,q}^Q(y),\mathcal C_{q,p}^Q(y)\}.}
\tag{14}
$$

The minimum is allowed because the covariance is symmetric and either ordered size-bias bound applies. The exact variance identity instead retains $\mathcal C-\mathcal N$ in every pair.

## A corrected monotonicity statement with an explicit hole cost

The means $\mu_q^Q$ are continuous and locally piecewise differentiable. Define their accumulated downward variation

$$
V_q^Q(y)=\int_1^y[-(\mu_q^Q)'(t)]_+dt.
\tag{15}
$$

Then $\mu_q^Q+V_q^Q$ is nondecreasing, and for $1<t<y$,

$$
\mu_q^Q(t)-\mu_q^Q(y)\le V_q^Q(y)-V_q^Q(t).
$$

This yields a second useful bound on (11):

$$
\operatorname{Cov}_y^Q(m_p,m_q)
\le\frac{\log p}{Z_Q(y)}
\sum_{p^j<y}p^jZ_Q(y/p^j)
[V_q^Q(y)-V_q^Q(y/p^j)].
\tag{16}
$$

This variation is determined by exact finite arithmetic sums. On an interval with fixed cutoff supports, put

$$
A_Q(t)=\sum_{\substack{n<t\\(n,Q)=1}}n^{-1/2},\quad
T_Q(t)=\frac{\sum_{n<t,(n,Q)=1}\sqrt n}{A_Q(t)}.
$$

For an integer $a\ge2$ with $(a,Q)=1$, the derivative of $F_a^Q(t)=aZ_Q(t/a)/Z_Q(t)$, when $t>a$, is exactly

$$
(F_a^Q)'(t)=
\frac{A_Q(t)A_Q(t/a)}{Z_Q(t)^2}
[aT_Q(t/a)-T_Q(t)].
\tag{17}
$$

Also $\mu_q^Q=\log(q)\sum_jF_{q^j}^Q$. The full-integer comparison that made the bracket in (17) positive does not hold automatically after excluding primes. Equations (15)-(17) retain precisely the downward variation that was absent in that proof.

## What the prime-revelation martingale must retain

Let $\mathcal F$ be the current revealed-history sigma-field and reveal the next exponent $H_p=v_p(n)$. Put

$$
G(H_p)=E[\sum_{q\text{ still unrevealed after }p}m_q\mid \mathcal F,H_p].
$$

The increment of the Doob martingale for the remaining score sum has conditional variance

$$
\operatorname{Var}(m_p+G(H_p)\mid \mathcal F)
=\operatorname{Var}(m_p\mid \mathcal F)
+\operatorname{Var}(G(H_p)\mid \mathcal F)
+2\sum_q\operatorname{Cov}(m_p,m_q\mid \mathcal F).
\tag{18}
$$

Thus a rowwise negative-regression argument must pay the positive costs in (12), or keep the signed covariances exactly. The example proves that their omission cannot be justified branch by branch.

At the whole-history level, the identity

$$
\operatorname{Cov}(m_p,m_q)
=E\operatorname{Cov}(m_p,m_q\mid \mathcal F)
+\operatorname{Cov}(E[m_p\mid \mathcal F],E[m_q\mid \mathcal F])
\tag{19}
$$

explains where compensation can occur. The proven negative unconditioned covariance does not imply negativity of its first conditional term on every branch. A successful martingale argument must retain this compensation across histories together with the separate density cost. The same-prime diagonal variances and the separate density contribution remain part of the full arithmetic balance. This note establishes no eventual sign in the [actual arithmetic criterion](actual-critical-sign-criterion.md) and no RH conclusion.
