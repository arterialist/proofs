# Counting births for the actual cutoff law and the full defect

This is a written mathematical proof for the full finite cutoff law. Its conclusions concern the stated auxiliary comparison or generator, not a sign of the full Weil form.

The $W$ readout is the exact [allocation identity](../prime-distribution/prime-allocation-critical-identity.md), with $H_x(n)=S(n)-1-(x/n-1)/2$ and $Q(z)=z^2/4-R(z)$. The counting generator and the divisibility-order obstruction below concern this specific triangular law, including each activation endpoint.


For $x>1$, let

$$
\rho_x(n)=\frac{x-n}{\sqrt n}\mathbf1_{n<x},\qquad
P_x(n)=\frac{\rho_x(n)}{Z_x},\qquad Z_x=\sum_n\rho_x(n).
$$

There is an exact increasing counting process with these marginals. Its
positive transition rates do not make the full arithmetic defect dissipative:
the complete time-dependent generator has both signs at arbitrarily large
cutoffs.

## Exact counting transport, including activation

Put $A_j=\sum_{r\le j}r^{-1/2}$, $B_j=\sum_{r\le j}\sqrt r$. Between integers,
write $N=\lfloor x\rfloor$, so $Z_x=xA_N-B_N$. The CDF through $n\le N$ is

$$
F_x(n)=\frac{xA_n-B_n}{Z_x},\qquad
\partial_xF_x(n)=\frac{B_nA_N-A_nB_N}{Z_x^2}.
$$

The weighted mean $B_j/A_j$ strictly increases with $j$: the next value
$j+1$ exceeds the weighted mean of $1,\ldots,j$. Thus $\partial_x F_x(n)<0$
for $n<N$, and it is zero for $n=N$. Define

$$
q_x(n)=\frac{\sqrt n\,[A_nB_N-B_nA_N]}{Z_x(x-n)}
\quad(n\le N),\qquad q_x(N)=0.
\tag{1}
$$

These rates are nonnegative. Their probability flux is
$P_x(n)q_x(n)=-\partial_x F_x(n)$, which proves the forward equation

$$
\partial_xP_x(n)=P_x(n-1)q_x(n-1)-P_x(n)q_x(n).
\tag{2}
$$

At an integer $k\ge 2$, the newly active state has weight zero. Every old
weight and the normalizer are continuous. The rate from $k-1$ acquires
its right-hand value, creating the new probability to first order. There
is no probability atom in time or missing endpoint mass. On each compact
time interval there are only finitely many states and the active rates
are bounded, so the forward equations define the nonexplosive pure-birth
process starting at state $1$ for $1<x\le 2$.

For a differentiable time-dependent function $f_x$ on the active states,

$$
\frac d{dx}\mathbb E_x f_x
=\mathbb E_x\mathscr A_x f_x,\qquad
\mathscr A_xf_x(n)=\partial_xf_x(n)+q_x(n)[f_x(n+1)-f_x(n)].
\tag{3}
$$

The expectation is continuous at integer activation. Its two one-sided
derivatives need not agree; each satisfies its corresponding generator
formula. Counting transport is uniquely determined
among processes with only $n\longmapsto n+1$ jumps by its CDF flux.

## The complete arithmetic readout

For every prime $p$, retain all powers in

$$
m_p(n)=\log p\sum_{j=1}^{v_p(n)}p^{j/2},\qquad
S(n)=\sum_pm_p(n),\qquad z=x/n-1.
$$

The full defect is

$$
\mathcal D_x(n)=D_0(n)-z(S(n)-1)+R(z),
\quad D_0(n)=S(n)^2-\sum_pm_p(n)^2-2S(n)+1,
$$

$$
R(z)=\frac1z\int_0^z(z-u)\log(1+u)\,du,
\qquad R(0)=0.
$$

This is exactly $H_x(n)^2-\sum_p m_p(n)^2-Q(z)$, including the same-prime
subtraction and full density contribution. The target is still
$W(x)/Z_x=\mathbb E_x\mathcal D_x$; applying (3) therefore keeps the complete readout.

The elementary bounds needed here are

$$
0\le R(z)\le z^2/6,\qquad 0\le R'(z)\le z/3
\quad(z\ge0).
\tag{4}
$$

They follow from $\log(1+u)\le u$ and
$R(z)=z\int_0^1(1-t)\log(1+zt)dt$. In particular

$$
\partial_x\mathcal D_x(n)=\frac{-(S(n)-1)+R'(z)}n.
\tag{5}
$$

### Uniformly positive defect on multiples of 30 near the cutoff

If $30\mid n$, the three coordinates satisfy
$m_2>9/10$, $m_3>9/5$, $m_5>7/2$. These elementary inequalities can be
proved by the positive series
$\log y=2\sum_{j\ge0}[(y-1)/(y+1)]^{2j+1}/(2j+1)$ and rational lower
bounds on the square roots. For example, use its first term for $y=2$,
first two terms for $y=3$, and first four terms for $y=5$, together with
$\sqrt{2}>7/5$, $\sqrt{3}>5/3$, and $\sqrt{5}>11/5$.

At this three-coordinate lower vector,

$$
D_0-S=2\sum_{p<q}m_pm_q-3\sum_pm_p+1=227/50.
$$

Each coordinate derivative is $2\sum_{q\ne p}m_q-3>0$. The smallest sum of
two of the fixed coordinates is $27/10>3/2$. Increasing any coordinate,
adding further primes, or retaining further powers therefore preserves
the strict inequality $D_0>S+227/50$. If $n<x\le 2n$, then $0<z\le 1$, and

$$
\boxed{\mathcal D_x(n)>277/50\qquad(30\mid n,\ n<x\le2n).}
\tag{6}
$$

Indeed $\mathcal D_x>227/50+(1-z)S+z$, and $S>1$.

### Uniformly negative defect at a prime near the cutoff

For a prime $p\ge 3$, put $m=\sqrt{p}\log p>9/5$. If $p<x\le 2p$, (4) gives

$$
\boxed{
\mathcal D_x(p)=1+z+R(z)-(2+z)m
\le13/6-2m<0.
}
\tag{7}
$$

### Arbitrarily large positive values of the full generator

Let $p$ be prime with $p\equiv29\pmod{30}$, and set $x=p+3/2$. Then
$N=p+1$, and state $p+1$ is a multiple of 30. To lower-bound the actual
rate, write $L=N A_p-B_p$. Since $L\ge A_p\ge 1$,

$$
Z_x=L+A_p/2+1/(2\sqrt N)\le2L,
\quad q_x(p)=\frac23\sqrt{\frac pN}\frac L{Z_x}>\frac16.
$$

By (5), $\partial_x \mathcal D_x(p)\ge -m/p$. Combining (6) and (7),

$$
\begin{aligned}
\mathscr A_x\mathcal D_x(p)
&>-\frac mp+\frac16\left(2m+\frac{253}{75}\right)\\
&=m\left(\frac13-\frac1p\right)+\frac{253}{450}>0.
\end{aligned}
\tag{8}
$$

This includes the explicit time derivative of the density contribution;
it is stronger than merely finding a positive jump difference.

### Arbitrarily large negative values

Let $p$ be prime with $p\equiv1\pmod{30}$, set $x=p+1/2$, and $n=p-1$.
Now $n$ is a multiple of 30. Equations (6)--(7) give
$\mathcal D_x(n+1)-\mathcal D_x(n)<0$ and $q_x(n)>0$. Moreover $S(n)>31/5$ and
$R'(z)\le 1/3$, so (5) is strictly negative. Consequently

$$
\boxed{\mathscr A_x\mathcal D_x(p-1)<0.}
\tag{9}
$$

Dirichlet's theorem on primes in reduced residue classes supplies
arbitrarily large primes in both classes used in (8)--(9). Thus no
eventual pointwise generator sign holds for this exact readout. This
does not decide the sign of its expectation, of its derivative, or of
$W$. A collective estimate remains necessary.

## Exact birth forcing and its complete sign classification

The unnormalized state contribution is, for $x>n$ and $z=x/n-1$,

$$
w_n(x)=\sqrt n\left[D_0(n)z-(S(n)-1)z^2+I(z)\right],
\qquad I(z)=\int_0^z(z-u)\log(1+u)\,du.
$$

For $x\le n$, set $w_n(x)=0$; then $W=\sum_nw_n$. Since
$I(0)=I'(0)=I''(0)=0$ and $I'''(z)=1/(1+z)$, the exact birth jumps are

$$
\boxed{
[W']_n=\frac{D_0(n)}{\sqrt n},\qquad
[W''_{\rm reg}]_n=-\frac{2(S(n)-1)}{n^{3/2}}.
}
\tag{10}
$$

Between integers,

$$
W'''_{\rm reg}(x)=\frac1x\sum_{n<x}n^{-3/2}>0.
$$

This is not a globally positive distributional third derivative. On
$(1,\infty)$ the complete identity is

$$
\boxed{
W'''=
\frac1x\sum_{n<x}n^{-3/2}\,dx
-\sum_{n\ge2}\frac{2(S(n)-1)}{n^{3/2}}\delta_n
+\sum_{n\ge2}\frac{D_0(n)}{\sqrt n}\delta'_n.
}
\tag{11}
$$

The initial data are $W(1)=0$, $W'(1+)=1$, and $W''(1+)=2$. These retain
the original $n=1$ baseline.

The birth coefficient has a complete arithmetic sign classification:

$$
\boxed{
D_0(n)<0\ \Longleftrightarrow\
\left\{
\begin{array}{l}
n\text{ is a prime power},\quad\text{or}\\
n=2p^j\text{ for an odd prime }p\text{ and }j\ge1.
\end{array}\right.
}
\tag{12}
$$

Here $n\ge 2$. At every other integer $n\ge 2$, the coefficient is strictly
positive, and $D_0(1)=1$.

For one prime coordinate, $D_0=1-2m_p<0$. For $n=2p^j$ with $p$ odd,
put $a=m_2(2)$ and $b=m_p(p^j)$. The elementary bounds $9/10<a<1$ give

$$
D_0=2(a-1)b+1-2a<0.
$$

For the upper bound $a<1$, use $\sqrt{2}<10/7$ and $\log(2)<7/10$.
The latter follows, for example, by bounding the positive series for
$\log(2)$ above by $25/36<7/10$.

Every remaining integer with at least two distinct prime factors either
has two odd prime factors, or has a factor $4$ and an odd prime factor.
In the first case, its coordinates dominate $(9/5,7/2)$, where
$D_0=3>0$. In the second case, they dominate $(9/4,9/5)$, where
$D_0=1>0$. The bound for the first coordinate in the second case follows
from $m_2(4)=(\sqrt{2}+2)\log(2)>34/15>9/4$.

Both coordinates in either pair exceed $1$. Increasing either coordinate
increases $D_0$, since its derivative is $2\sum_{q\ne p}m_q-2$.
Adding any further prime coordinate also increases $D_0$, as the existing
sum exceeds $1$. This proves (12), retaining every proper power and every
mixed-prime birth.

This classification describes the exact forcing in (11). It supplies no
estimate comparing the accumulated signed impulses with the continuous
density term and therefore does not establish the target sign of $W$.

## The same laws cannot evolve monotonically by divisibility

The valid counting transport cannot be replaced by a process whose paths
only increase in the divisibility order. An elementary finite example
proves this for the actual law, even though each individual divisibility
event has an increasing probability.

Let $U$ be the global divisibility upset consisting of integers with a
prime divisor at most $47$. Among $1,\ldots,100$, its complement is

$$
D=\{1,53,59,61,67,71,73,79,83,89,97\}.
$$

Write $A=A_{100}$, $B=B_{100}$, and $A_D,B_D$ for the sums restricted to $D$.
Convexity of $t^{-1/2}$ and concavity of $\sqrt{t}$, applied on each unit
interval from $1$ to $100$, give the trapezoidal bounds

$$
A\ge\int_1^{100}t^{-1/2}dt+\frac{1+1/10}{2}=\frac{371}{20},
$$
$$
B\le\int_1^{100}\sqrt t\,dt+\frac{1+10}{2}=\frac{1343}{2}.
$$

Hence $B/A<37$. In contrast, group the primes in $D$ below the successive
squares $8^2$, $9^2$, and $10^2$. All their differences $p-37$ are
positive, so

$$
\begin{aligned}
B_D-37A_D
&=-36+\sum_{p\in D\setminus\{1\}}\frac{p-37}{\sqrt p}\\
&>-36+\frac{62}{8}+\frac{142}{9}+\frac{158}{10}
=\frac{599}{180}>0.
\end{aligned}
$$

Thus $B_D/A_D>37>B/A$, with no numerical approximation to a root required.
For every $100<x<101$, differentiation of the exact cutoff law yields

$$
\boxed{
\frac d{dx}P_x(U)
=-\frac{AB_D-A_DB}{(xA-B)^2}<0.
}
\tag{13}
$$

Any coupling with sample paths increasing by divisibility would make the
indicator of this global upset nondecreasing on every path, contradicting
(13). This excludes such a coupling, including a pure multiplicative
birth process with the stated marginals. It does not exclude the exact
counting process (1)--(3), which changes prime support jointly.
