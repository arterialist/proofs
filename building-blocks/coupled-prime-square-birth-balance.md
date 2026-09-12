# The coupled prime-square birth balance

This written proof gives an exact double prime-power sum and two distinct PNT scaling laws. The [proper-power companion](prime-square-proper-power-constant.md) retains the next logarithmic term and its convergent constant. Neither note assumes independence of primes or gives an RH-scale residual estimate. These statements are not formalized in Lean.

Fix $x>0$. The actual causal source is
$$
g(y)=1_{y\ge1}\frac{\psi(y)-y}{y},\qquad
\psi(y)=\sum_{q^j\le y}\log q,
$$
where $q$ ranges over primes and $j\ge1$. Define
$$
S_P(x)=\sum_{p\le P}g(xp^2),\qquad
\psi_Q(y)=\sum_{\substack{q\le Q\\j\ge1,\ q^j\le y}}\log q,
\qquad
T(P,Q;x)=\sum_{p\le P}\frac{\psi_Q(xp^2)}{xp^2}.
\tag{1}
$$
The outer variable $p$ also ranges over primes. The cutoff $Q\ge0$ restricts the prime generators; all their powers remain. Write $T(P,\infty;x)$ for the full expression. It is already equal to $T(P,Q;x)$ for any $Q\ge xP^2$, so all sums at a fixed $P$ are finite.

The exact threshold identity is
$$
\boxed{T(P,Q;x)=\frac1x
\sum_{\substack{q\le Q,\ j\ge1\\q^j\le xP^2}}
(\log q)\!
\sum_{\substack{p\le P\\p\ge q^{j/2}/\sqrt x}}\frac1{p^2}.}
\tag{2}
$$
Both threshold inequalities are inclusive. In particular, when $q^j=xp^2$, the corresponding term is present.

For the generator cutoff $Q=\lambda xP^2$, the limiting balance is
$$
\boxed{\sup_{0\le\lambda\le1}
\left|\frac{T(P,\lambda xP^2;x)}{\pi(P)}
-(2\sqrt\lambda-\lambda)\right|\longrightarrow0.}
\tag{3}
$$
The complementary new-generator contribution is
$$
U(P,Q;x)=\sum_{p\le P}
\frac{\psi(xp^2)-\psi_Q(xp^2)}{xp^2}\ge0.
$$
It satisfies
$$
\boxed{\sup_{0\le\lambda\le1}
\left|\frac{U(P,\lambda xP^2;x)}{\pi(P)}
-(1-\sqrt\lambda)^2\right|\longrightarrow0.}
\tag{4}
$$
This is an actual arithmetic coupling, derived from PNT without a prime-independence assumption.

At the distinct moving cutoff $Q=P$, a separate argument gives the sharper subextensive retained mass
$$
\boxed{T(P,P;x)\sim\frac{4\sqrt P}{\sqrt x\,\log P}.}
\tag{5}
$$
It cannot be deduced by inserting the vanishing parameter $\lambda=1/(xP)$ into (3), whose uniform error is only $o(1)$ after normalization by $\pi(P)$.

## Exact source and threshold conventions

For $y<1$, both $\psi_Q(y)$ and the causal $g(y)$ vanish. Thus the finite set of outer primes with $xp^2<1$ is handled by
$$
k_x(P)=\#\{p\le P:xp^2<1\},
\qquad
\boxed{S_P(x)=T(P,\infty;x)-\pi(P)+k_x(P).}
\tag{6}
$$
For $x\ge1$, $k_x(P)=0$. The strict inequality in its definition is intentional: at $xp^2=1$, one has $g(1)=-1$, so that sample belongs to the density subtraction in (6). For any fixed $x>0$, $k_x(P)$ is eventually a fixed finite number.

Formula (2) follows by interchanging the finite sums in (1) and solving
$q^j\le xp^2$ for $p$. Equivalently its inner kernel is
$$
H_P(a)=\sum_{a\le p\le P}p^{-2}
=\int_{[a,P]}t^{-2}\,d\pi(t).
\tag{7}
$$
Its lower endpoint is included. Replacing the interval by $(a,P]$ would incorrectly remove an equality sample when $a$ is prime.

The associated compensated source identity retains the full density:
$$
\boxed{S_P(x)=T(P,Q;x)+U(P,Q;x)-\pi(P)+k_x(P).}
\tag{8}
$$
No subtraction of a prime-independent model replaces any of its finite terms.

## The literal diagonal and all proper powers

Split $\psi_Q$ into its first-power and proper-power parts:
$$
\psi_Q(y)=\theta(\min(Q,y))+
R_Q(y),\qquad
R_Q(y)=\sum_{\substack{q\le Q\\j\ge2,\ q^j\le y}}\log q.
$$
Accordingly
$$
T(P,Q;x)=T_1(P,Q;x)+T_{\ge2}(P,Q;x),
$$
where
$$
\boxed{T_1(P,Q;x)=
\sum_{p\le P}\frac{\theta(\min(Q,xp^2))}{xp^2},\qquad
T_{\ge2}(P,Q;x)=\sum_{p\le P}\frac{R_Q(xp^2)}{xp^2}.}
\tag{9}
$$

The complete diagonal $q=p$, including every admitted diagonal power, is exactly
$$
\boxed{T_{=}(P,Q;x)=\frac1x
\sum_{p\le\min(P,Q)}\frac{\log p}{p^2}
\max\left(0,\left\lfloor2+\frac{\log x}{\log p}\right\rfloor\right).}
\tag{10}
$$
For $x\ge1$, this includes both $j=1$ and $j=2$, as well as every $j\ge3$ with $p^{j-2}\le x$. For $0<x<1$, only $j=1$ can occur, and then only when $p\ge1/x$. In all cases
$$
0\le T_{=}(P,Q;x)\le C_x
\sum_p\frac{\log p}{p^2}<\infty,
\tag{11}
$$
uniformly in the two cutoffs.

For an explicitly disjoint decomposition, the first-power diagonal is
$$
T_{=}^{(1)}=\frac1x
\sum_{\substack{p\le\min(P,Q)\\p\ge1/x}}\frac{\log p}{p^2},
$$
and set
$$
T_{\ne}^{(1)}=T_1-T_{=}^{(1)},\qquad
T_{=}^{(\ge2)}=T_{=}-T_{=}^{(1)},\qquad
T_{\ne}^{(\ge2)}=T_{\ge2}-T_{=}^{(\ge2)}.
\tag{12}
$$
These four nonnegative terms partition the exact sum. In particular, the diagonal and proper-power parts are not added twice.

All proper powers have the uniform bound
$$
\boxed{0\le T_{\ge2}(P,Q;x)=O_x(\log\log(3P)),}
\tag{13}
$$
with no restriction on $Q$. Indeed Chebyshev's estimate $\theta(v)\le Cv$ gives
$$
0\le R_Q(y)\le\psi(y)-\theta(y)
=\sum_{j\ge2}\theta(y^{1/j})
\le C\sqrt y+C y^{1/3}\log(2y)
\le C'\sqrt y.
\tag{14}
$$
For $y<4$ the sum is empty; the inequalities may therefore be used for all $y>0$ after adjusting constants. Consequently
$$
T_{\ge2}(P,Q;x)\le \frac C{\sqrt x}\sum_{p\le P}\frac1p
=O_x(\log\log(3P)).
$$
The reciprocal-prime upper bound follows from Chebyshev counting and partial summation. No power has been omitted to obtain (13).

## The fixed-fraction generator cutoff

Only standard PNT is used in the following limiting arguments. It is enough to take $\theta(y)=y+o(y)$ and $\pi(y)\sim y/\log y$. These also follow from the primary quantitative $\psi$ estimate in Trudgian, *Updating the error term in the prime number theorem*, [Theorem 1](https://arxiv.org/pdf/1401.2689), after removing the proper powers via (14).

Fix $0<\lambda\le1$, and put $Q=\lambda xP^2$. The first-power summand in (9) has continuum comparison
$$
\frac{\min(Q,xp^2)}{xp^2}
=\min\left(1,\frac{\lambda}{(p/P)^2}\right)
=:k_\lambda(p/P).
\tag{15}
$$
For $\lambda>0$, set $k_\lambda(0)=1$, so that it is continuous on $[0,1]$. PNT proves
$$
T_1(P,\lambda xP^2;x)
=\sum_{p\le P}k_\lambda(p/P)+o(\pi(P)).
\tag{16}
$$
To see the error without overlooking small sample arguments, fix $\varepsilon>0$ and choose $Y_\varepsilon$ such that
$|\theta(y)-y|\le\varepsilon y$ for every $y\ge Y_\varepsilon$.
For sufficiently large $P$, $Q\ge Y_\varepsilon$. Every prime
$p\ge\sqrt{Y_\varepsilon/x}$ then has
$\min(Q,xp^2)\ge Y_\varepsilon$, and its error in (15) is at most
$\varepsilon k_\lambda(p/P)\le\varepsilon$.
There are only finitely many excluded primes, with bounded total contribution by Chebyshev's estimate. Divide by $\pi(P)$, let $P\to\infty$, and then $\varepsilon\to0$.

The normalized prime samples $p/P$ have the uniform continuum counting limit:
$$
\frac{\pi(uP)}{\pi(P)}\longrightarrow u\qquad(0<u\le1).
\tag{17}
$$
For continuous functions on $[0,1]$, finite Riemann partitions and (17) therefore prove convergence of their averages over these samples to the ordinary integral. Applied to (15),
$$
\frac1{\pi(P)}\sum_{p\le P}k_\lambda(p/P)
\longrightarrow
\int_0^1\min(1,\lambda/u^2)du
=\sqrt\lambda+\lambda\int_{\sqrt\lambda}^1u^{-2}du
=2\sqrt\lambda-\lambda.
\tag{18}
$$
At $\lambda=0$, the generator sum is exactly zero and the same limiting formula holds. The proper-power contribution (13) is $o(\pi(P))$, uniformly in the generator cutoff. Thus (16)--(18) establish the pointwise version of (3).

For uniformity, both $T(P,\lambda xP^2;x)$ and its limiting function
$f(\lambda)=2\sqrt\lambda-\lambda$ are nondecreasing in $\lambda$. Take a fixed finite grid
$\lambda_j=(j/K)^2$, $0\le j\le K$. On adjacent grid points the increase in $f$ is at most $2/K$. Monotonicity bounds the error at every intermediate point by the maximum grid-point error plus $2/K$. First let $P\to\infty$, for this fixed grid, and then $K\to\infty$. This proves (3), including parameters tending to zero. It uses no unproved uniform PNT approximation at a vanishing generator cutoff.

At $\lambda=1$, $Q=xP^2$ contains every prime generator occurring in every sampled $\psi(xp^2)$. Hence
$$
T(P,xP^2;x)=T(P,\infty;x),\qquad
T(P,\infty;x)/\pi(P)\longrightarrow1.
\tag{19}
$$
Subtract (3) from (19). Since $U=T(P,\infty;x)-T(P,Q;x)$ exactly, this gives the uniform complementary law (4). The full compensated source (6) consequently satisfies $S_P(x)=o(\pi(P))$; this normalization is much coarser than an RH-scale residual bound.

## The moving old-generator cutoff $Q=P$

Set
$$
A=\sqrt{P/x}.
$$
For all sufficiently large $P$, $A<P$. Equation (9) now gives the exact inclusive split
$$
T_1(P,P;x)=
\sum_{p\le A}\frac{\theta(xp^2)}{xp^2}
+\frac{\theta(P)}x\sum_{A<p\le P}\frac1{p^2}.
\tag{20}
$$
If $A$ itself is prime, its summand belongs to the first part. Both expressions agree at the threshold, but it is counted only once.

By PNT, the individual ratios $\theta(xp^2)/(xp^2)$ tend to one as $p\to\infty$. A fixed initial prime segment has negligible average, giving
$$
\sum_{p\le A}\frac{\theta(xp^2)}{xp^2}
\sim\pi(A)\sim\frac A{\log A}
\sim\frac{2\sqrt P}{\sqrt x\,\log P}.
\tag{21}
$$
This includes the finite causal exclusions when $x<1$.

The required prime-square tail is
$$
\sum_{p>A}p^{-2}\sim\frac1{A\log A}.
\tag{22}
$$
For example, with the strict lower cutoff, partial summation gives
$$
\sum_{p>A}p^{-2}=-\frac{\pi(A)}{A^2}
+2\int_A^\infty\frac{\pi(t)}{t^3}dt.
$$
PNT gives respectively the leading values
$-1/(A\log A)$ and $2/(A\log A)$, with smaller relative error. This verifies the coefficient one and retains the lower endpoint.

Subtracting the corresponding tail beyond $P$, and using $\theta(P)\sim P$, yields
$$
\begin{aligned}
\frac{\theta(P)}x\sum_{A<p\le P}p^{-2}
&\sim\frac{P}{xA\log A}\\
&\sim\frac{2\sqrt P}{\sqrt x\,\log P}.
\end{aligned}
\tag{23}
$$
The removed tail beyond $P$, after multiplication by $\theta(P)/x$, is $O_x(1/\log P)$, negligible at this scale. Finally the complete proper-power part is $O_x(\log\log P)$ by (13), also negligible. Adding (21) and (23) proves (5). The complete diagonal (10) is only $O_x(1)$, so the same leading old-generator mass comes from distinct-prime first-power pairs.

The old retained contribution is therefore $o(\pi(P))$, while the omitted generators $q>P$ supply mass asymptotic to $\pi(P)$. Their exact relation is
$$
U(P,P;x)=T(P,\infty;x)-T(P,P;x).
$$
One cannot infer an expansion
$\pi(P)-4\sqrt P/(\sqrt x\log P)+o(\sqrt P/\log P)$
for this omitted part merely from (19): the uncontrolled error in the full normalization can exceed the old-generator scale. The theorem identifies the extensive birth balance and the precise retained old mass while leaving the centered actual residual in (6) intact. It supplies no RH-scale bound for that residual and makes no assertion of prime independence.
