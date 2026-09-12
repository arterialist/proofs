# The proper-power constant in the prime-square sampling balance

This written companion to the [coupled prime-square balance](coupled-prime-square-birth-balance.md) uses classical quantitative PNT and partial summation. It retains every proper power and the entire proper-power diagonal in an explicit convergent constant. The first-power compensated residual is a separate problem. These statements are not formalized in Lean.

Fix $x>0$, put $a=\sqrt x$, and retain the exact notation
$$
T_{\ge2}(P,Q;x)=\frac1x\sum_{p\le P}\frac1{p^2}
\sum_{\substack{q\le Q,\ j\ge2\\q^j\le xp^2}}\log q
\tag{1}
$$
from the [coupled prime square birth balance](coupled-prime-square-birth-balance.md). Both $p$ and $q$ run over primes. All inequalities are inclusive. Then there is a finite real constant $C_x$ such that
$$
\boxed{T_{\ge2}(P,\infty;x)
=\frac1{\sqrt x}\log\log P+C_x+o(1/\log P).}
\tag{2}
$$
The complete contribution of exponents $j\ge3$ converges absolutely. The constant retains the entire diagonal $q=p$ belonging to the proper-power sum.

For the old-generator cutoff $Q=P$, the same constant occurs:
$$
\boxed{T_{\ge2}(P,P;x)
=\frac1{\sqrt x}\log\log P+C_x
-\frac{\kappa_x}{\log P}+o(1/\log P),}
\tag{3}
$$
where
$$
\kappa_x=
\begin{cases}
0,&0<x\le1,\\[2mm]
\displaystyle\frac{\sqrt x\log\sqrt x-\sqrt x+1}{x},&x>1.
\end{cases}
\tag{4}
$$
For $x\le1$, the proper-power expressions with $Q=P$ and $Q=\infty$ are exactly equal at every cutoff. For $x>1$, only the square channel is lost once $P\ge x$, and its deficit has leading constant $\kappa_x>0$.

These are statements about the proper-power component alone. They imply no fine expansion of the full first-power source or its compensated residual.

## Exact separation into the square and higher channels

Write
$$
\begin{aligned}
H_2(P;x)&=\frac1x\sum_{p\le P}\frac{\theta(ap)}{p^2},\\
H_{\ge3}(P;x)&=\frac1x\sum_{p\le P}\frac1{p^2}
\sum_{j\ge3}\theta((xp^2)^{1/j}).
\end{aligned}
\tag{5}
$$
Then $T_{\ge2}(P,\infty;x)=H_2(P;x)+H_{\ge3}(P;x)$ exactly. The sums over $j$ are finite for each sampled argument, because $\theta(v)=0$ for $v<2$.

Chebyshev's estimate gives, for $y\ge8$,
$$
\sum_{j\ge3}\theta(y^{1/j})
\le Cy^{1/3}+Cy^{1/4}\log(2y)
\le C' y^{1/3}.
\tag{6}
$$
For $y<8$, the sum is zero. The last inequality follows from boundedness of $\log(2y)y^{-1/12}$. Therefore
$$
H_{\ge3}(\infty;x):=
\frac1x\sum_p\frac1{p^2}\sum_{j\ge3}\theta((xp^2)^{1/j})<\infty.
\tag{7}
$$
All terms are nonnegative, so this is also absolute convergence of the complete double sum. More precisely,
$$
0\le H_{\ge3}(\infty;x)-H_{\ge3}(P;x)
\le Cx^{-2/3}\sum_{p>P}p^{-4/3}
=O_x(P^{-1/3}/\log P).
\tag{8}
$$
For the last estimate, use $\pi(t)\le Ct/\log t$ and partial summation, with its strict lower cutoff. Thus no exponent $j\ge3$ contributes another divergent term.

## The square channel and its convergent PNT correction

Use the established unconditional envelope
$$
|\theta(t)-t|\le Ct\,\rho(t),\qquad
\rho(t)=e^{-c\sqrt{\log t}}\quad(t\ge2),
\tag{9}
$$
after enlarging constants on the initial interval. It follows, for example, from the primary $\psi$ bound of Trudgian, *Updating the error term in the prime number theorem*, [Theorem 1](https://arxiv.org/pdf/1401.2689), by absorbing its logarithmic prefactor and then removing the proper powers. Chebyshev bounds give $\psi(t)-\theta(t)=O(\sqrt t)$, which can be absorbed in the same envelope after decreasing $c>0$.

The exact decomposition of the square channel is
$$
H_2(P;x)=\frac1a\sum_{p\le P}\frac1p
+\frac1x\sum_{p\le P}\frac{\theta(ap)-ap}{p^2}.
\tag{10}
$$
For fixed $x$, sufficiently large $p$ satisfy
$$
|\theta(ap)-ap|\le C_x p\,\rho(p).
\tag{11}
$$
Indeed the fixed change $\log p\mapsto\log p+\log a$ only changes the envelope by a bounded factor. The finitely many smaller arguments, including $ap<2$, are retained in the constant.

The prime-weighted envelope has a convergent tail:
$$
\sum_{p>P}\frac{\rho(p)}p
=O\!\left(\frac{\rho(P)}{\sqrt{\log P}}\right).
\tag{12}
$$
To verify this, apply partial summation to $h(t)=\rho(t)/t$. The upper boundary $\pi(t)h(t)$ tends to zero, and
$$
|h'(t)|=\frac{\rho(t)}{t^2}
\left(1+\frac{c}{2\sqrt{\log t}}\right).
$$
Together with $\pi(t)\le Ct/\log t$, this bounds the tail by a constant times
$$
\int_P^\infty\frac{\rho(t)}{t\log t}
\left(1+\frac{c}{2\sqrt{\log t}}\right)dt
=O\!\left(\frac{\rho(P)}{\sqrt{\log P}}\right).
$$
The substitution $u=\sqrt{\log t}$ gives the last bound. The negative lower boundary term in the exact formula can either be retained or bounded by its absolute value; it is smaller than this estimate.

It follows that
$$
C_{2,x}^{\rm err}:=\frac1x\sum_p
\frac{\theta(ap)-ap}{p^2}
\tag{13}
$$
converges absolutely, with tail $O_x(\rho(P)/\sqrt{\log P})$.

For completeness, the same envelope gives a precise convergent prime-harmonic constant. Let
$$
B_{\rm pr}=\lim_{P\to\infty}
\left(\sum_{p\le P}\frac1p-\log\log P\right).
$$
Its existence and an error bound follow directly from $\theta$. Using the inclusive prime at two,
$$
\sum_{p\le P}\frac1p
=\frac{\theta(P)}{P\log P}
+\int_2^P\theta(t)\frac{\log t+1}{t^2(\log t)^2}dt.
\tag{14}
$$
Consequently
$$
B_{\rm pr}
=-\log\log2+\frac1{\log2}
+\int_2^\infty[\theta(t)-t]
\frac{\log t+1}{t^2(\log t)^2}dt.
\tag{15}
$$
The error integral converges absolutely by (9), and its tail has the bound used in (12). The upper endpoint error is $O(\rho(P)/\log P)$. Thus
$$
\sum_{p\le P}\frac1p
=\log\log P+B_{\rm pr}
+O\!\left(\frac{\rho(P)}{\sqrt{\log P}}\right).
\tag{16}
$$

Combining (8), (10), (13), and (16) proves the more quantitative version of (2):
$$
\boxed{
T_{\ge2}(P,\infty;x)
=\frac1a\log\log P+C_x
+O_x\!\left(\frac{e^{-c\sqrt{\log P}}}{\sqrt{\log P}}
+\frac{P^{-1/3}}{\log P}\right),}
\tag{17}
$$
where the actual convergent constant is
$$
\boxed{C_x=\frac{B_{\rm pr}}a+C_{2,x}^{\rm err}
+H_{\ge3}(\infty;x).}
\tag{18}
$$
Both error terms are $o(1/\log P)$. This proves convergence of the centered proper-power sum, not merely boundedness.

## The complete proper-power diagonal stays in the constant

The diagonal $q=p$ in (1), summed through all exponents $j\ge2$, has limit
$$
\boxed{
D_{\ge2,x}=\frac1x\sum_p\frac{\log p}{p^2}
\max\left(0,\,1+\left\lfloor\frac{\log x}{\log p}\right\rfloor\right).}
\tag{19}
$$
It is zero for $x<1$. For $x\ge1$, it includes the square $j=2$ for every prime, and all the additional powers $j\ge3$ with $p^{j-2}\le x$. Those additional diagonal terms involve only finitely many primes and powers. The square diagonal converges since $\sum_p(\log p)/p^2<\infty$; its tail is $O(1/P)$ by Chebyshev partial summation.

Every term of (19) is included in (18), through the exact sums (5). Thus the off-diagonal proper-power sum has centered constant $C_x-D_{\ge2,x}$, and adding the literal diagonal restores $C_x$. The first-power diagonal belongs to $T_1$, not to this proper-power constant, and is not added a second time.

At $Q=P$, every outer diagonal $q=p$ is admitted by construction. The loss computed next is entirely off diagonal.

## The exact loss at the old-generator cutoff

If $0<x\le1$, then for every $p\le P$, every $j\ge2$, and every $q^j\le xp^2$,
$$
q^2\le q^j\le xp^2\le P^2,
$$
so $q\le P$. Therefore
$$
T_{\ge2}(P,P;x)=T_{\ge2}(P,\infty;x)
\qquad(0<x\le1)
\tag{20}
$$
at every cutoff.

If $x>1$ and $P\ge x$, then all exponents $j\ge3$ are still retained:
$q^3\le q^j\le xP^2\le P^3$ implies $q\le P$.
The only lost channel is $j=2$. Its exact nonnegative deficit is
$$
\boxed{
\Delta_2(P;x):=
T_{\ge2}(P,\infty;x)-T_{\ge2}(P,P;x)
=\frac1x\sum_{P/a<p\le P}
\frac{\theta(ap)-\theta(P)}{p^2},\qquad a=\sqrt x>1.}
\tag{21}
$$
At $p=P/a$, the summand would be zero; the strict lower threshold in (21) is consistent with including every equality sample in the original retained sum.

PNT separates its main part:
$$
\Delta_2(P;x)
=\frac1x\sum_{P/a<p\le P}\frac{ap-P}{p^2}
+O_x\!\left(\frac{\rho(P)}{\log P}\right).
\tag{22}
$$
To bound the error, use (9) uniformly on $[P,aP]$ and
$\sum_{P/a<p\le P}p^{-2}=O_x(1/(P\log P))$, a consequence of Chebyshev counting.

The main coefficient is obtained from the ordinary prime counting limit, with no independence premise. Define the continuous function on $[0,1]$
$$
\Phi_a(u)=
\begin{cases}
0,&0\le u\le1/a,\\
(au-1)/u^2,&1/a<u\le1.
\end{cases}
$$
Its continuity at $1/a$ follows from the vanishing numerator. Since
$\pi(uP)/\pi(P)\to u$, finite Riemann partitions give
$$
\frac1{\pi(P)}\sum_{p\le P}\Phi_a(p/P)
\longrightarrow
\int_{1/a}^1\left(\frac a u-\frac1{u^2}\right)du
=a\log a-a+1.
\tag{23}
$$
But the main sum in (22) is $1/(xP)$ times this unnormalized prime sum. Using $\pi(P)\sim P/\log P$ therefore proves
$$
\boxed{
\Delta_2(P;x)=\frac{a\log a-a+1}{x\log P}
+o(1/\log P).}
\tag{24}
$$
The numerator is positive for $a>1$, because its derivative is $\log a$ and it vanishes at one. Subtracting (24) from (17) proves (3)--(4).

The logarithmic proper-power divergence is therefore generated by the square channel; higher powers and the complete proper-power diagonal remain in the convergent constant. The old generator cutoff preserves that constant and loses only the explicit vanishing square mass when $x>1$. These conclusions do not provide the finer full-source residual estimate that would be needed to expand the complete compensated prime-square sampling at the same scale.
