# Signed largest-prime moments of Möbius convolution powers

Let $b_k=\mu^{*k}$ be the $k$-fold Dirichlet convolution of the actual Möbius function. Weighting these coefficients by a fixed positive power of the largest prime factor gives an explicit negative principal mean. The same factorization identifies the complete cofactor measure in $\ell^1$, with its signs retained. The proof uses the prime number theorem, finite factorization and dominated sums. The finite $k=2$ companion checks the arithmetic large-prime partition; the asymptotic and infinite-series arguments remain written mathematics. No priority claim is made.

## Statements

Write $P^+(n)$ for the largest prime factor of $n>1$, and set $P^+(1)=1$. Fix an integer $k\ge1$ and a real $\beta>0$. For real $X>1$, define

$$
 S_{k,\beta}(X)=\sum_{1\le n\le X}b_k(n)P^+(n)^\beta,
 \qquad
 A_{k,\beta}(X)=\sum_{1\le n\le X}|b_k(n)|P^+(n)^\beta,
 \qquad s=1+\beta.
$$

Every sum uses the actual integer support $1\le n\le\lfloor X\rfloor$. As real $X\to\infty$,

$$
 S_{k,\beta}(X)\sim
 -\frac{k}{(1+\beta)\zeta(s)^k}
 \frac{X^{1+\beta}}{\log X},
 \tag{1}
$$

and the sharp absolute-weight comparison from the same argument is

$$
 A_{k,\beta}(X)\sim
 \frac{k}{1+\beta}
 \left(\frac{\zeta(s)}{\zeta(2s)}\right)^k
 \frac{X^{1+\beta}}{\log X}.
 \tag{2}
$$

Thus the signed sum is strictly negative for all sufficiently large real cutoffs. Its magnitude and the absolute-weight sum have the same power and logarithmic order. Their leading constants satisfy

$$
 \frac{A_{k,\beta}(X)}{|S_{k,\beta}(X)|}
 \longrightarrow
 \frac{\zeta(s)^{2k}}{\zeta(2s)^k}>1.
 \tag{3}
$$

For example, $k=2$ and $\beta=1$ give $S_{2,1}(X)\sim-(36/\pi^4)X^2/\log X$ and $A_{2,1}(X)\sim(225/\pi^4)X^2/\log X$. Their limiting magnitude ratio, also the signed cofactor norm, is $25/4$. These are asymptotic constants without a displayed finite onset.

For each fixed $k,\beta$ there is an onset $X_0(k,\beta)$ such that every real $X\ge X_0$ satisfies

$$
 -\frac{3k}{2(1+\beta)\zeta(s)^k}
 \frac{X^{1+\beta}}{\log X}
 \le S_{k,\beta}(X)
 \le
 -\frac{k}{2(1+\beta)\zeta(s)^k}
 \frac{X^{1+\beta}}{\log X}<0.
 \tag{4}
$$

The cofactor is $R(n)=n/P^+(n)$, including $R(1)=1$. Once $S_{k,\beta}(X)\ne0$, define the finite signed measure on the positive integers by

$$
 \nu_X(m)=\frac{1}{S_{k,\beta}(X)}
 \sum_{\substack{n\le X\\R(n)=m}}
 b_k(n)P^+(n)^\beta.
 \tag{5}
$$

It has total mass one. The complete countable limit is

$$
 \sum_{m\ge1}\left|
 \nu_X(m)-\nu_{k,\beta}(m)\right|\longrightarrow0,
 \qquad
 \nu_{k,\beta}(m)=\zeta(s)^k b_k(m)m^{-s}.
 \tag{6}
$$

Its total mass is one and its absolute norm is

$$
 \|\nu_{k,\beta}\|_{\ell^1}
 =\frac{\zeta(s)^{2k}}{\zeta(2s)^k}.
 \tag{7}
$$

This is a signed measure: $\nu_{k,\beta}(1)=\zeta(s)^k>1$, while every prime has negative mass. The convergence in (6) is proved directly in $\ell^1$; it does not use a probability normalization or a positive-measure convergence argument.

## Coefficients and a summable bound

For a prime $p$, the local Euler polynomial is

$$
 \sum_{j\ge0}b_k(p^j)u^j=(1-u)^k.
$$

Hence $b_k(p^j)=(-1)^j\binom{k}{j}$ for $0\le j\le k$, and it vanishes for $j>k$. In particular $b_k(1)=1$ and $b_k(p)=-k$. The function is multiplicative. The absolute local polynomial is $(1+u)^k$, so for every real $s>1$, absolutely convergent Euler products give

$$
 \sum_{m\ge1}\frac{b_k(m)}{m^s}=\zeta(s)^{-k},
 \qquad
 \sum_{m\ge1}\frac{|b_k(m)|}{m^s}
 =\left(\frac{\zeta(s)}{\zeta(2s)}\right)^k.
 \tag{8}
$$

Let $d_k=1^{*k}$ be the positive $k$-fold divisor function. Comparing each local binomial coefficient gives $|b_k(n)|\le d_k(n)$. Counting ordered positive integer $k$-tuples with product at most $X$ then yields

$$
 \sum_{n\le X}d_k(n)
 \le X\left(1+\log X\right)^{k-1}
 \qquad(X\ge1).
 \tag{9}
$$

Indeed, after fixing the first $k-1$ coordinates, the last has at most $X$ divided by their product choices. Extending those coordinates independently to $1,\ldots,\lfloor X\rfloor$ gives $XH_{\lfloor X\rfloor}^{k-1}$, and $H_N\le1+\log N$. For $k=1$, this is the direct bound $\lfloor X\rfloor\le X$.

## Exact large-prime split

Put

$$
 B_\beta(y)=\sum_{p\le y}p^\beta.
$$

The prime number theorem and Abel summation give

$$
 B_\beta(y)\sim
 \frac{y^{1+\beta}}{(1+\beta)\log y},
 \qquad
 B_\beta(y)\le C_\beta\frac{y^{1+\beta}}{\log(2y)}
 \quad(y\ge2).
 \tag{10}
$$

The asymptotic follows by inserting $\pi(t)\sim t/\log t$ into
$B_\beta(y)=y^\beta\pi(y)-\beta\int_2^y t^{\beta-1}\pi(t)\,dt$, with the ordinary endpoint convention at two. The coefficient is $1-\beta/(1+\beta)=1/(1+\beta)$. The upper bound follows for large $y$ and extends to $y\ge2$ by increasing $C_\beta$.

If $P^+(n)>\sqrt X$, write $n=pm$ with $p=P^+(n)$. Then $m<\sqrt X<p$, so $p\nmid m$, the large prime occurs only once, and
$b_k(pm)=-k b_k(m)$. Conversely, every $m<\sqrt X$ and prime $\sqrt X<p\le X/m$ gives precisely one such integer. The exact large-prime sector is therefore

$$
 S^{>}_{k,\beta}(X)
 =-k\sum_{m<\sqrt X}b_k(m)
 \left[B_\beta(X/m)-B_\beta(\sqrt X)\right].
 \tag{11}
$$

The lower subtraction excludes $p=\sqrt X$ when $X$ is a prime square. Every state with $P^+(n)\le\sqrt X$, including the unit and all repeated largest-prime powers, remains in the complementary sector. Its absolute contribution satisfies

$$
 \sum_{\substack{n\le X\\P^+(n)\le\sqrt X}}
 |b_k(n)|P^+(n)^\beta
 \le X^{1+\beta/2}(1+\log X)^{k-1}
 =o\!\left(\frac{X^{1+\beta}}{\log X}\right).
 \tag{12}
$$

The last step uses fixed $k$ and fixed positive $\beta$.

## Dominated rows and both moments

Set $T_X=X^{1+\beta}/\log X$. Extend the $m$-row of (11) by zero for $m\ge\sqrt X$. For $X\ge4$, (10) bounds its normalized absolute value by

$$
 \frac{k|b_k(m)|B_\beta(X/m)\mathbf1_{m<\sqrt X}}{T_X}
 \le 2kC_\beta |b_k(m)|m^{-1-\beta}.
 \tag{13}
$$

On active rows $m<\sqrt X$, we have $\log X/\log(2X/m)\le2$; the other rows are zero. The right side is summable by (8). For each fixed $m$, the normalized row tends to
$-k b_k(m)m^{-1-\beta}/(1+\beta)$; the normalized $B_\beta(\sqrt X)$ subtraction tends to zero. Dominated summation and (12) prove (1).

Applying the same argument to $|b_k|$ replaces the large-prime coefficient by $+k|b_k(m)|$. Equation (8) then gives (2). Dividing the two asymptotics proves (3). Its strict inequality also follows directly from

$$
 \frac{\zeta(s)^2}{\zeta(2s)}
 =\prod_p\frac{1+p^{-s}}{1-p^{-s}}>1.
$$

The result determines a negative sign and the signed leading constant. It gives no improvement in the power of $X$ or the logarithmic order relative to (2).

## Complete cofactor convergence in $\ell^1$

Let $C_X(m)$ denote the unnormalized fiber in (5). Its large-prime part is the single row of (11):

$$
 C_X^{>}(m)=-k b_k(m)
 \left[B_\beta(X/m)-B_\beta(\sqrt X)\right]
 \mathbf1_{m<\sqrt X}.
 \tag{14}
$$

Define $v(m)=-k b_k(m)m^{-s}/(1+\beta)$. The summable bound (13), together with pointwise convergence, proves

$$
 \left\|C_X^{>}/T_X-v\right\|_{\ell^1}\longrightarrow0.
 \tag{15}
$$

This is dominated convergence applied to the absolute difference on the whole countable cofactor space. Grouping the complementary sector by cofactor can only decrease its absolute norm. Equation (12) therefore gives
$\|C_X^{\le}/T_X\|_{\ell^1}\to0$. Consequently $C_X/T_X\to v$ in $\ell^1$.

The total $v_0=\sum_m v(m)=-k\zeta(s)^{-k}/(1+\beta)$ is nonzero, and $S_{k,\beta}(X)/T_X\to v_0$. Thus

$$
 \left\|\frac{C_X}{S_{k,\beta}(X)}-rac{v}{v_0}\right\|_{\ell^1}
 \le
 \frac{T_X}{|S_{k,\beta}(X)|}
 \left\|\frac{C_X}{T_X}-v\right\|_{\ell^1}
 +\left|\frac{T_X}{S_{k,\beta}(X)}-\frac1{v_0}\right|
 \|v\|_{\ell^1}\longrightarrow0.
 \tag{16}
$$

This proves (6), and (8) gives (7). The absolute norms of the finite measures also converge to (7).

For a fixed cofactor $m$, the exact nonunit fiber is
$\{pm:p\text{ prime},\ P^+(m)\le p\le X/m\}$. Equality $p=P^+(m)$ includes a repeated largest prime. The unit contributes separately when $m=1$. These states were retained in the complementary sector of (12), not deleted from the finite law. In particular the cofactor-one fiber contains every prime as well as the unit.

## Finite formal companion

For $k=2$, the coefficient is the existing actual Mathlib arithmetic function `balancedMobiusCoefficient` in [ActualMobiusConvolution.lean](../../formalization/BuildingBlocks/ActualMobiusConvolution.lean). Its multiplicativity, prime value $-2$, prime-square value $1$, and vanishing on higher prime powers were already formalized there.

The additional [finite companion](../../formalization/BuildingBlocks/ActualMobiusLargePrimeSector.lean) uses the actual prime set

$$
 Q_N=\{p:2\le p\le N,\ p\text{ prime},\ N<p^2\},
 \qquad
 S_N=\{n:1\le n\le N,\ \exists p\in Q_N,\ p\mid n\}.
$$

Its weighted finite statement, for every natural $N$ and every real function $f$, is

$$
 \sum_{n\in S_N}b_2(n)f(n)
 =-2\sum_{p\in Q_N}\sum_{1\le m\le\lfloor N/p\rfloor}
 b_2(m)f(pm).
 \tag{17}
$$

The arithmetic behind (17) keeps all integers. If $1\le n\le N$, $p\mid n$, and $N<p^2$, then $m=n/p<p$, so $p$ is coprime to $m$ and is the actual largest prime of $n$. Two distinct prime divisors with squares exceeding $N$ would have product greater than $N$, so the large prime is unique. Multiplication $(p,m)\mapsto pm$ is therefore a bijection onto $S_N$. Small-prime squares may remain in $m$; no squarefree restriction is imposed on $n$ or its cofactor. The complement identity retains every other integer in $[1,N]$, including the unit when $N\ge1$. For $N=\lfloor X\rfloor$, the integer condition $N<p^2$ is equivalent to $X<p^2$, so the finite sector preserves real cutoff and prime-square seams.

The declarations `BuildingBlocks.ActualMobiusLargePrimeSector.weighted_large_sector_reindex` and `weighted_complete_partition` state (17) and the complete complementary partition. The same module proves unique large-prime divisibility, the cofactor's positivity and coprimality, maximality among actual prime divisors, the pair-product bijection, and the zero, one and unit boundaries. The source and [separate axiom audit](../../formalization/verification/ActualMobiusLargePrimeSectorAudit.lean) passed narrow checks under the repository's Lean 4.24.0 setup. All sixteen audited declarations depend only on the standard whitelist `propext`, `Classical.choice` and `Quot.sound`; both weighted identities depend on exactly those three axioms. Only the finite $k=2$ arithmetic partition and weighted reindexing are kernel-checked content. PNT, Abel summation, the general Euler products, the infinite dominated sums, the asymptotics and signed $\ell^1$ limit in (1)–(16) remain independently reviewed written analysis.

## Provenance and scope

The largest-prime/cofactor method is classical. [Alladi and Erdős, *On an additive arithmetic function*](https://msp.org/pjm/1977/71-2/pjm-v71-n2-p01-s.pdf), Pacific Journal of Mathematics **71** (1977), 275–294, develop largest-prime moment estimates; the familiar unsigned $\beta=1$ constant is $\pi^2/12$. [Wen Sun, arXiv2609.11735v1, Theorem 2.6](https://arxiv.org/pdf/2609.11735v1) gives the matching positive-divisor parameter formula at $\gamma=1$. The present proof estimates the actual signed coefficients directly; it does not substitute a negative parameter into a probability law.

[Tenenbaum, *Note on a paper by Joung Min Song*](https://www.impan.pl/shop/en/publication/transaction/download/product/83323), Acta Arithmetica **97** (2001), 353–360, includes complex multiplicative weights under a positive prime-mean parameter $\kappa$ and a sublinear-logarithmic prime deviation condition. Here $b_k(p)=-k$, so $\sum_{p\le z}|b_k(p)-\kappa|\log(p)/p\sim(k+\kappa)\log z$ violates that condition for every $\kappa>0$. That theorem is related context, not an input to the proof above. A bounded primary-source comparison did not locate a literal earlier statement of (1) or (6); broader priority remains unresolved, and no originality or first-formalization claim is made.

All parameters are fixed. The note gives no effective onset, convergence rate, uniformity as $\beta\downarrow0$, growing-$k$ or varying-$\beta$ result. It does not establish a weighted critical-tail estimate at $s=1$. The signed moment and finite arithmetic partition are supporting results; they supply no upper bound for the complete original $F$, $W$, ordered drift or coarse energy, and no RH proof or RH-frontier gain.
