# The centered infinite-prime birth kernel

This written proof constructs the complete centered kernel on birth profiles and an absolute integral domain. Its endpoint estimates use the classical prime number theorem; the [multiplier-domain theorem](centered-prime-mellin-domain.md) gives the corresponding maximal original-space realization, and the [fixed-source law](fixed-source-centered-cutoff-law.md) refines the cutoff error. The analytic statements are not formalized in Lean.

For a prime cutoff $P$, define the actual centered operator
$$
 \mathcal C_P=\sum_{p\le P}(L_p-2p^{-1}I),
 \qquad A_P=\mathcal C_Ph_1,
 \qquad h_t(x)=\mathbf1_{x\ge t}/x.
\tag{1}
$$
All functions vanish on $x\le0$. The full signed scale series is
$$
L_p=\frac2pI+p^{-3/2}(D_p+D_{1/p})
 -(1-p^{-1})\sum_{j\ge2}p^{-j/2}(D_{p^j}+D_{p^{-j}}),
\qquad D_af(x)=\sqrt a\,f(ax). \tag{1a}
$$
Every $D_a$ is unitary on $L^2(\mathbb R,dx)$, so the series converges absolutely in operator norm for fixed $p$. Its change to logarithmic coordinates is proved in the [multiplier-domain note](centered-prime-mellin-domain.md). We prove that $A_P$ converges in $L^2(\mathbb R)$ to an explicit pointwise-finite prime kernel $A$, and that
$$
 \boxed{A(x)\sim-\frac2{\sqrt x\log x}\quad(x\to\infty),
 \qquad
 A(x)\sim-\frac2{\sqrt x\log(1/x)}\quad(x\downarrow0).}
\tag{2}
$$
The cutoff convergence has the sharp squared-norm equivalent
$$
 \boxed{\|A-A_P\|_2^2\sim\frac4{\log P}.}
\tag{3}
$$
Each endpoint contributes $2/\log P$. These are unconditional consequences of the exact full profile and the classical PNT; one quantitative primary input is Trudgian, [*Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689). The centered operator is constructed here on birth profiles and an explicit integral domain, not on the full natural source without an additional cancellation argument.

## 1. Exact centered profile and compact exactness

Put $c_p=1-p^{-1}$. Using $D_a h_1(x)=a^{-1/2}x^{-1}\mathbf1_{x\ge1/a}$ in (1a), and summing its geometric tails, gives for $x\ge1$,
$$
 (L_p-2p^{-1}I)h_1(x)
   =\frac1x\left[\frac{\mathbf1_{p\le x}}p
            -c_p\sum_{j\ge2}\mathbf1_{p^j\le x}\right].
\tag{4}
$$
The first term in (4) is the reciprocal-prime contribution. It remains part of the exact formula.

For $0<x<1$, put $r=1/x$. Apart from the immaterial threshold values,
$$
 (L_p-2p^{-1}I)h_1(1/r)
        =-r\,p^{-\lceil\log_p r\rceil}\mathbf1_{p<r}.
\tag{5}
$$
Using $p\le r$ instead changes only a countable set of values. The strict version in (5) also treats the threshold $x=1/p$ correctly, where the full signed profile cancels. At other threshold points one may retain the right-continuous convention inherited from $h_t$; all energy and norm statements are unchanged.

Consequently the pointwise-finite limit is
$$
 \boxed{A(x)=\frac1x\left[
           \sum_{p\le x}\frac1p
             -\sum_{j\ge2}\sum_{p^j\le x}(1-p^{-1})\right]
                       \quad(x\ge1),}
\tag{6}
$$
and
$$
 \boxed{A(1/r)=-r\sum_{p<r}p^{-\lceil\log_p r\rceil}
                                     \quad(r>1),}
\tag{7}
$$
with the preceding threshold convention. The upper sum over $j$ in (6) is finite, bounded by $\log_2x$. No prime power has been removed.

Only primes $p\le\max(x,1/x)$ can contribute. Therefore
$$
 \boxed{A_P(x)=A(x)\quad\text{if }P>\max(x,1/x),}
\tag{8}
$$
almost everywhere, and uniformly in the sense of exact equality on every fixed compact subinterval of $(0,\infty)$ once $P$ is sufficiently large. In particular $A$ vanishes on $(1/2,2)$. This compact exactness alone does not control either infinite endpoint; those estimates follow next.

## 2. The large-coordinate tail

Let $\pi(y)$ denote the number of primes at most $y$, and let
$H(y)=\sum_{p\le y}p^{-1}$. Chebyshev's bound and partial summation give
$$
 \pi(y)\ll y/\log(2y),\qquad H(y)\ll\log\log(3y).
\tag{9}
$$
In (6), the prime-square term is
$\pi(\sqrt x)-H(\sqrt x)$. All terms with $j\ge3$ together have magnitude at most
$$
 \sum_{3\le j\le\log_2x}\pi(x^{1/j})
                                  =O(x^{1/3}\log(2x)).
$$
Thus the exact full sum has the estimate
$$
 A(x)=-\frac{\pi(\sqrt x)}x
       +O\!\left(x^{-2/3}\log(2x)
                            +\frac{\log\log(3x)}x\right).
\tag{10}
$$
PNT gives $\pi(\sqrt x)\sim2\sqrt x/\log x$, proving the first equivalent in (2). The same estimates give a uniform bound
$$
 |A(x)|\le\frac C{\sqrt x\log x}
                                      \quad(x\text{ sufficiently large}).
\tag{11}
$$
The reciprocal-prime term and every higher power are retained in (10), even though they have smaller order than the prime-square term at this endpoint.

## 3. The small-coordinate tail

For $\sqrt r<p<r$, the exponent in (7) is exactly two. These primes give
$$
 -r\sum_{\sqrt r<p<r}p^{-2}.
\tag{12}
$$
To control all the remaining primes, split at $r^{1/3}$. For every prime,
$r p^{-\lceil\log_p r\rceil}\le1$. Therefore the primes below $r^{1/3}$ contribute at most $\pi(r^{1/3})=O(r^{1/3})$. For $r^{1/3}<p<\sqrt r$, the exponent is three, and
$$
 r\sum_{p>r^{1/3}}p^{-3}
           \le r\sum_{n>r^{1/3}}n^{-3}=O(r^{1/3}).
$$
An exact endpoint $r=p^2$ adds at most one bounded term to this estimate. Hence
$$
 \boxed{A(1/r)=-r\sum_{\sqrt r<p<r}p^{-2}+O(r^{1/3}).}
\tag{13}
$$
This bound groups the higher powers without dropping them.

PNT and partial summation give
$$
 \sum_{p>y}p^{-2}\sim\frac1{y\log y},
 \qquad
 \sum_{p>y}p^{-2}\ll\frac1{y\log y}.
\tag{14}
$$
For example the exact tail formula is
$-\pi(y)y^{-2}+2\int_y^\infty\pi(u)u^{-3}du$; substituting $\pi(u)\sim u/\log u$ proves the equivalent and its coefficient. The omitted tail beyond $r$, after multiplication by $r$, is only $O(1/\log r)$. Substitution of (14) with $y=\sqrt r$ into (13) proves
$$
 A(1/r)\sim-\frac{2\sqrt r}{\log r},
 \qquad |A(1/r)|\le\frac{C\sqrt r}{\log r}
                                    \quad(r\text{ sufficiently large}).
\tag{15}
$$
This is the second equivalent in (2).

Both endpoint squares are asymptotic to $4/[x\log^2x]$, using the appropriate reciprocal logarithm at zero. They are integrable. Together with compact local boundedness, this proves $A\in L^2(\mathbb R)$.

## 4. Sharp cutoff error at the small-coordinate endpoint

Write $D_P=A-A_P$. It vanishes on $[1/P,P]$ almost everywhere. For $r\in[P,P^2]$, all missing primes satisfy $P<p<r$ and have exponent two. Hence
$$
 D_P(1/r)=-r\sum_{P<p<r}p^{-2}.
\tag{16}
$$
Under $x=1/r$, the squared norm uses $dx=dr/r^2$. By (14),
$$
 \int_P^{P^2}\frac{|D_P(1/r)|^2}{r^2}dr
       \le P^2\left(\sum_{p>P}p^{-2}\right)^2
                             =O((\log P)^{-2}).
\tag{17}
$$

For every $r>1$, each term of $A_P(1/r)$ has magnitude at most one. Thus
$$
 |A_P(1/r)|\le\pi(P)\ll P/\log P.
\tag{18}
$$
Using (15), the difference between the squared norms of $D_P$ and $A$ beyond $r=P^2$ is bounded in absolute value by
$$
 \begin{aligned}
 &2\pi(P)\int_{P^2}^\infty\frac{|A(1/r)|}{r^2}dr
            +\pi(P)^2\int_{P^2}^\infty\frac{dr}{r^2}\\
 &\qquad\ll\frac{P}{\log P}\frac1{P\log P}
                       +\frac{P^2}{\log^2P}\frac1{P^2}
             =O((\log P)^{-2}).
 \end{aligned}
\tag{19}
$$
Finally (15), with a uniform relative error on $r\ge P^2$, gives
$$
 \int_{P^2}^\infty\frac{|A(1/r)|^2}{r^2}dr
          \sim4\int_{P^2}^\infty\frac{dr}{r\log^2r}
          =\frac2{\log P}.
$$
Combining this with (17)--(19) proves
$$
 \boxed{\int_0^1|D_P(x)|^2dx\sim\frac2{\log P}.}
\tag{20}
$$

## 5. Sharp cutoff error at infinity

For $P\le x\le P^2$, a missing prime $p>P$ has $p^2>x$, so it contributes only the reciprocal term in (6). Thus
$$
 D_P(x)=\frac1x\sum_{P<p\le x}\frac1p.
\tag{21}
$$
The transition region has squared integral
$$
 \int_P^{P^2}|D_P(x)|^2dx
       \ll\frac{\log^2\log(3P)}P
                         =o((\log P)^{-2}).
\tag{22}
$$

For the far region, a useful finite-prime bound is
$$
 \sum_{p\le P}\frac1{\log p}\ll\frac P{\log^2P}.
\tag{23}
$$
To prove it, split at $\sqrt P$. Below that point the sum is $O(\sqrt P)$; above it use $1/\log p\le2/\log P$ and (9). In (6) truncated at $P$, the number of retained powers of each prime is at most $\log x/\log p$. Equations (9) and (23) therefore give
$$
 |A_P(x)|\le C\frac{P\log x}{x\log^2P}
                                \quad(x\ge P^2,\ P\text{ large}).
\tag{24}
$$
The retained reciprocal-prime term is included in this bound.

Using (11) and (24),
$$
 \int_{P^2}^\infty|A_P(x)|^2dx
   \ll\frac{P^2}{\log^4P}
                  \int_{P^2}^\infty\frac{\log^2x}{x^2}dx
   =O((\log P)^{-2}),
$$
$$
 \int_{P^2}^\infty|A(x)A_P(x)|dx
   \ll\frac P{\log^2P}\int_{P^2}^\infty x^{-3/2}dx
   =O((\log P)^{-2}).
\tag{25}
$$
On the other hand, (2) implies
$$
 \int_{P^2}^\infty|A(x)|^2dx
          \sim4\int_{P^2}^\infty\frac{dx}{x\log^2x}
          =\frac2{\log P}.
$$
Together with (22) and (25), this proves
$$
 \boxed{\int_1^\infty|D_P(x)|^2dx\sim\frac2{\log P}.}
\tag{26}
$$
Equations (20) and (26) establish (3), and in particular prove the full $L^2$ convergence directly. They also give the quantitative bound $\|A-A_P\|_2\ll(\log P)^{-1/2}$. No convergence of the uncentered reciprocal-prime identity term has been assumed.

## 6. Scaled birth profiles and a concrete operator domain

Every finite centered operator commutes with dilations. The identity $h_t(x)=t^{-1}h_1(x/t)$ therefore gives
$$
 \mathcal C_Ph_t(x)=t^{-1}A_P(x/t).
$$
Taking the $L^2$ limit defines
$$
 \boxed{\mathcal C_\infty h_t(x)=t^{-1}A(x/t),\qquad t>0,}
\tag{27}
$$
with the exact norm scaling
$$
 \|\mathcal C_\infty h_t-\mathcal C_Ph_t\|_2^2
           =t^{-1}\|A-A_P\|_2^2
           \sim\frac4{t\log P}.
\tag{28}
$$
The limit is locally exact in the physical coordinate when $P>\max(x/t,t/x)$. Since the mixed energy obeys $\mathcal E(f)\le8\|f\|_2^2$, (28) also proves convergence in that energy, with the upper bound $O(1/(t\log P))$ for the squared energy error. No sharp energy equivalent is inferred from this one-sided comparison.

A useful absolute integral domain follows. Let $\mu$ be a signed or complex measure on $(0,\infty)$ with
$$
 V_{1/2}(\mu)=\int_0^\infty t^{-1/2}\,d|\mu|(t)<\infty.
\tag{29}
$$
Then $f_\mu=\int h_t\,d\mu(t)$ exists as an $L^2$ Bochner integral, because $\|h_t\|_2=t^{-1/2}$. The centered images also have the absolute integral limit
$$
 \boxed{\mathcal C_\infty f_\mu
       =\int_0^\infty t^{-1}A(\,·\,/t)\,d\mu(t),}
\tag{30}
$$
and
$$
 \|\mathcal C_\infty f_\mu-\mathcal C_Pf_\mu\|_2
       \le V_{1/2}(\mu)\|A-A_P\|_2
       \ll\frac{V_{1/2}(\mu)}{\sqrt{\log P}}.
\tag{31}
$$
For fixed $P$, commutation with the integral uses its bounded $L^2$ operator. The limit uses (28) and the weighted variation in (29). It is independent of the representation of $f_\mu$, since it is the actual limit of these same finite operators applied to that function.

In particular each actual finite arrival has an unambiguous limit,
$$
 \mathcal C_\infty v_N
   =\Lambda(N)N^{-1}A(\,·\,/N)
        -\int_{N-1}^{N}t^{-1}A(\,·\,/t)dt.
\tag{32}
$$
This retains its continuum ramp, all prime powers, and the signed cancellation. Finite sums of such arrivals and a fixed admissible seed are also in the constructed domain.

The full natural source measure $d\psi(t)-dt$ does not satisfy the absolute variation condition (29): its atomic and continuous parts have disjoint variation, and even $\int_1^\infty t^{-1/2}dt$ diverges. This does not exclude a limit by arithmetic cancellation. It identifies why (30) alone cannot pass from all finite admissions to the natural infinite source, even though the birth kernel and every finite arrival now have centered limits. That source passage, the metric properties of the centered operator, and the full RH sign require further arguments.
