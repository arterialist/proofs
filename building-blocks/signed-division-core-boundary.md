# The exact boundary between the prime-power and division cores

Written proof. The complete arithmetic histories and endpoint conventions are part of each statement. No Lean formalization or unconditional feedback-sign conclusion is asserted here.

Retain the actual kernels in [the successor-feedback arithmetic proof](successor-feedback-arithmetic-kernel.md) and [the Abel factorial/division proof](actual-Abel-factorial-division-positivity.md):
$$
 q_0(n)=n^{-1/2},\qquad
 q_j(n)=j^{-1/2}\arctan\sqrt{\frac{j}{\max(1,n-j)}}\quad(j\ge1),
$$
$$
 u_j(n)=q_{j+1}(n)-q_j(n),\qquad
 W_r(n)=\sum_{j\ge0}r^ju_j(n),\qquad
 \varphi_r(m)=\sum_{a\ge1}\mu(a)W_r(am),\quad 0<r<1.
 \tag{1}
$$
The first equality for $W_r$ agrees exactly with the geometric-average formula in the prime-power note. Its terminal maximum with one is unchanged. Both complete readouts are
$$
 E(r)=\sum_{n\ge2}\Lambda(n)W_r(n)
     =\sum_{m\ge2}\varphi_r(m)\log m.
 \tag{2}
$$
We do not reprove a sign criterion for $E$. Instead we prove an exact comparison of its finite cores, with a signed boundary that is uniformly negative at the already established moving division cutoff.

Write
$$
 t_r=(1-r)^{-1},\qquad K_r=\left\lceil16t_r\log(e t_r)\right\rceil.
$$
For every integer $K\ge K_r$, the result is
$$
 \boxed{
 \sum_{m<K}\varphi_r(m)\log m
 \le \sum_{n<K}\Lambda(n)W_r(n)
       -\frac{t_r\log K}{144\sqrt K}.}
 \tag{3}
$$
Thus division does not simply preserve the finite prime-power budget: its core has an additional negative boundary, while its positive exterior has a correspondingly larger total readout. The theorem is unconditional and uniform in $0<r<1$. It does not establish the sign of either core or of their common completed readout.

## 1. Finite cores and the exact signed divisor boundary

For an integer $K\ge2$, define the complete cofactor combination
$$
 c_K(n)=\sum_{\substack{m\mid n\\m<K}}\mu(n/m)\log m.
 \tag{4}
$$
The initial $m=1$ term is present and is zero. For $n<K$, the full divisor identity gives $c_K(n)=\Lambda(n)$. Consequently
$$
 \boxed{
 \sum_{m<K}\varphi_r(m)\log m
 =\sum_{n<K}\Lambda(n)W_r(n)+\mathfrak B_K(r),\qquad
 \mathfrak B_K(r)=\sum_{n\ge K}c_K(n)W_r(n).}
 \tag{5}
$$
All cutoffs in (5) are exact: a divisor equal to $K$ is excluded from the core, and a product equal to $K$ is included in the boundary.

The boundary vanishes on every prime $n\ge K$. On a prime power $p^a\ge K$, it is exactly
$$
 c_K(p^a)=
 \begin{cases}
 -(a-1)\log p,&p^{a-1}<K\le p^a,\\
 0,&K\le p^{a-1}.
 \end{cases}
 \tag{6}
$$
This includes $a=1$, where the first value is zero. Mixed composites retain both signs: for example, at $K=4$,
$$
 c_4(6)=-\log6,\qquad c_4(30)=\log6.
 \tag{7}
$$
We therefore keep (4) intact before estimating its weighted sum.

Convergence is absolute for each fixed $r,K$. The established all-history bound is
$$
 |u_j(n)|\le2\pi(j+1)n^{-3/2}\quad(n\ge2),
 \tag{8}
$$
so $W_r(n)=O_r(n^{-3/2})$. More generally, for $s>1$,
$$
 \begin{split}
 \sum_{n\ge K}|c_K(n)|n^{-s}
 &\le \sum_{m<K}\frac{\log m}{m^s}
                   \sum_{a\ge\lceil K/m\rceil}a^{-s}\\
 &\le \left(1+\frac1{s-1}\right)K^{1-s}
                   \sum_{m<K}\frac{\log m}{m}<\infty .
 \end{split}
 \tag{9}
$$
This also justifies interchanging the full geometric history sum with the boundary. No prime power, large cofactor, or returned history has been removed.

There is an exact finite factorial version, including its endpoint:
$$
 \boxed{
 \sum_{m<K}[\varphi_r(m)-\varphi_r(m+1)]\log(m!)
 +\varphi_r(K)\log((K-1)!)
 =\sum_{n<K}\Lambda(n)W_r(n)+\mathfrak B_K(r).}
 \tag{10}
$$
Finite summation by parts proves (10); in particular, the factorial endpoint term cannot be dropped at a moving cutoff.

## 2. An exact negative boundary for every power kernel

For $s>1$, the elementary divisor identity $\log m=\sum_{d\mid m}\Lambda(d)$ gives
$$
 \begin{split}
 \sum_{n\ge1}c_K(n)n^{-s}
 &=\frac1{\zeta(s)}\sum_{m<K}\frac{\log m}{m^s}\\
 &=\frac1{\zeta(s)}
   \sum_{d<K}\frac{\Lambda(d)}{d^s}
                      \sum_{\substack{a\ge1\\ad<K}}a^{-s}.
 \end{split}
$$
Subtract the complete part $n<K$, which equals
$\sum_{d<K}\Lambda(d)d^{-s}$. This proves
$$
 \boxed{
 \sum_{n\ge K}c_K(n)n^{-s}=-H_K(s),\qquad
 H_K(s)=\frac1{\zeta(s)}
 \sum_{d<K}\frac{\Lambda(d)}{d^s}
                 \sum_{a\ge\lceil K/d\rceil}a^{-s}.}
 \tag{11}
$$
For $K\ge3$, $H_K(s)>0$. Formula (11) performs the cofactor cancellation before absolute values. It replaces the mixed signs of (4) by a single negative, actual prime-power tail. It uses only absolutely convergent Dirichlet series in $s>1$.

For $K\ge16$, a useful explicit lower bound is
$$
 H_K(3/2)\ge
 \frac{\sqrt2}{2\zeta(3/2)}\frac{\log K}{\sqrt K}.
 \tag{12}
$$
Indeed, for $q\ge1$,
$$
 \sum_{a\ge\lceil q\rceil}a^{-3/2}
 \ge \int_{\lceil q\rceil}^{\infty}x^{-3/2}dx
 \ge \sqrt2\,q^{-1/2}.
 \tag{13}
$$
Also the literal factorial identity gives
$$
 \log((K-1)!)
 =\sum_{d<K}\Lambda(d)\left\lfloor\frac{K-1}{d}\right\rfloor
 \le (K-1)\sum_{d<K}\frac{\Lambda(d)}d.
 \tag{14}
$$
An integral lower bound for the logarithm of the factorial yields
$$
 \sum_{d<K}\frac{\Lambda(d)}d
 \ge\log(K-1)-1\ge\tfrac12\log K\qquad(K\ge16).
 \tag{15}
$$
For the final inequality, its difference is increasing in $K$, and at $K=16$ it is $\log(15/4)-1>0$. Inserting (13)--(15) into (11) proves (12). This is a quantitative factorial constraint on the actual boundary; no cancellation estimate for the Möbius function is used.

## 3. Every history before its return has a negative boundary

Set
$$
 a_\ell=\frac{\binom{2\ell}{\ell}}{4^\ell(2\ell+1)},\qquad
 s_\ell=\ell+\tfrac12,\qquad \ell\ge1.
$$
If $j\le K-2$ and $n\ge K$, both adjacent masses remain on the arcsine branch. The exact expansion is
$$
 u_j(n)=\sum_{\ell\ge1}
 a_\ell[(j+1)^\ell-j^\ell]n^{-s_\ell}.
 \tag{16}
$$
All coefficients are positive, and $a_1=1/6$. The endpoint condition $j+1<n$ is strict, including at $n=K$. From (11),
$$
 \boxed{
 \sum_{n\ge K}c_K(n)u_j(n)
 =-\sum_{\ell\ge1}
 a_\ell[(j+1)^\ell-j^\ell]H_K(s_\ell)<0,
 \quad 0\le j\le K-2,\ K\ge3.}
 \tag{17}
$$
The exchange remains absolute despite signed $c_K$: by positivity of (16), its absolute double sum equals $\sum_{n\ge K}|c_K(n)|u_j(n)$, finite by (8)--(9).

Thus the full boundary has the exact decomposition
$$
 \boxed{
 \begin{split}
 \mathfrak B_K(r)
 ={}&-\sum_{j=0}^{K-2}r^j
       \sum_{\ell\ge1}a_\ell[(j+1)^\ell-j^\ell]H_K(s_\ell)
       +\mathfrak R_K(r),\\
 \mathfrak R_K(r)
 ={}&\sum_{j\ge K-1}r^j\sum_{n\ge K}c_K(n)u_j(n).
 \end{split}}
 \tag{18}
$$
The remainder contains every returned history, with its actual terminal maximum. It is not assigned a sign.

Equation (9), at $s=3/2$, and the elementary harmonic bound imply
$$
 \sum_{n\ge K}|c_K(n)|n^{-3/2}
 \le \frac{6\log^2K}{\sqrt K},\qquad K\ge16.
 \tag{19}
$$
Therefore
$$
 \boxed{
 |\mathfrak R_K(r)|
 \le\frac{12\pi\log^2K}{\sqrt K}\,
 r^{K-1}(Kt_r+r t_r^2).}
 \tag{20}
$$
The factor in parentheses is the exact geometric tail
$\sum_{j\ge K-1}(j+1)r^j$, after removing $r^{K-1}$.

## 4. Uniform sign at the existing moving core

Write $t=t_r\ge1$, $L=\log(e t)$, and $K_0=\lceil16tL\rceil$. For all $K\ge K_0$,
$$
 r^{K-1}\le e^{-(K-1)/t},\qquad
 r^{K-1}(Kt+r t^2)\log K\le54e^{-15}.
 \tag{21}
$$
Here are uniform constants for the second inequality. The function
$e^{-(x-1)/t}(xt+t^2)\log x$ decreases for $x\ge16t$, as its logarithmic derivative is at most $-1/t+2/x<0$. At $x=K_0$,
$$
 e^{-(K_0-1)/t}\le e^{-15}t^{-16},\quad
 K_0t+t^2\le t^2(16L+2),\quad \log K_0\le2L+1.
$$
The function $t^{-14}(16L+2)(2L+1)$ decreases for $t\ge1$ and equals $54$ at one. This proves (21).

In particular $r^{K-1}\le e^{-15}<1/2$, so
$$
 \sum_{j=0}^{K-2}r^j=t(1-r^{K-1})\ge t/2.
$$
Keep only $\ell=1$ in the negative term of (18), then apply (12). Its magnitude is at least
$$
 \frac{\sqrt2\,t}{24\zeta(3/2)}
                       \frac{\log K}{\sqrt K}.
 \tag{22}
$$
By (20)--(21), the ratio of the remainder bound to (22) is at most
$$
 \frac{288\pi\zeta(3/2)}{\sqrt2\,t}\,54e^{-15}
 <186624e^{-15}<\frac12 .
 \tag{23}
$$
For an entirely elementary numerical check, $\pi<4$, $\zeta(3/2)<3$, $\sqrt2>1$, and $e>5/2$, with $(5/2)^{15}>373248$, suffice. Thus
$$
 \boxed{
 \mathfrak B_K(r)
 \le-\frac{\sqrt2\,t_r}{48\zeta(3/2)}
                       \frac{\log K}{\sqrt K}
 \le-\frac{t_r\log K}{144\sqrt K},
 \qquad K\ge K_r.}
 \tag{24}
$$
Equations (5) and (24) prove (3). This uses the same explicit moving core already established for the positive division tail, rather than a small-$r$ interval.

## 5. The signed cancellation saves a logarithm

For each fixed $r<1$, the boundary has the sharper equivalent
$$
 \boxed{
 \mathfrak B_K(r)
 =-\frac{1}{3(1-r)\zeta(3/2)}
                   \frac{\log K}{\sqrt K}
   +O_r(K^{-1/2}),\qquad K\longrightarrow\infty.}
 \tag{25}
$$
This gives one fewer logarithm than the absolute cofactor bound (19).

To prove it, the actual full-history kernel has
$$
 W_r(n)=\frac1{6(1-r)}n^{-3/2}+O_r(n^{-5/2}).
 \tag{26}
$$
For $j+1\le n/2$, differentiating the convergent arcsine integral in its history parameter gives
$$
 u_j(n)=\tfrac16n^{-3/2}
                    +O((j+1)n^{-5/2}).
 \tag{27}
$$
Indeed $q_u(n)=n^{-1/2}\int_0^1(1-u z^2/n)^{-1/2}dz$; its $u$-derivative is $\tfrac16n^{-3/2}+O(u n^{-5/2})$ on this range. Sum (27) with the actual weights $r^j$. The remaining histories are bounded by (8), and their geometric tail is $O_r(n^{-5/2})$. Their omitted leading coefficient is equally small. Finitely many small $n$ are absorbed in the fixed-$r$ constant. This proves (26) without replacing returned masses by an arcsine continuation.

Using (9) at $s=5/2$, equations (11) and (26) give
$$
 \mathfrak B_K(r)
 =-\frac{H_K(3/2)}{6(1-r)}
                     +O_r(K^{-3/2}\log^2K).
 \tag{28}
$$
The ordinary integral comparison, with the displayed ceiling retained, gives
$$
 \sum_{a\ge\lceil q\rceil}a^{-s}
       =\frac{q^{1-s}}{s-1}+O_s(q^{-s}),\qquad q\ge1.
$$
Consequently
$$
 H_K(s)=
 \frac{K^{1-s}}{(s-1)\zeta(s)}
                 \sum_{d<K}\frac{\Lambda(d)}d
     +O_s(K^{-s}\psi(K-1)).
 \tag{29}
$$
The accepted elementary Chebyshev bound is $\psi(x)=O(x)$. The same factorial identity (14), now retaining its fractional-part error, shows
$$
 \sum_{d\le m}\frac{\Lambda(d)}d
 =\frac{\log(m!)}m+
       \frac1m\sum_{d\le m}\Lambda(d)\{m/d\}
 =\log m+O(1).
 \tag{30}
$$
The last step uses integral bounds for $\log(m!)$ and Chebyshev's bound. It requires no PNT or Möbius cancellation theorem. Hence
$$
 H_K(3/2)=
 \frac{2}{\zeta(3/2)}\frac{\log K}{\sqrt K}
                          +O(K^{-1/2}),
 \tag{31}
$$
which proves (25).

## 6. The consequence for the two actual budgets

Absolute convergence of (2) and (5) also gives the exact exterior identity
$$
 \boxed{
 \sum_{m\ge K}\varphi_r(m)\log m
 -\sum_{n\ge K}\Lambda(n)W_r(n)
 =-\mathfrak B_K(r).}
 \tag{32}
$$
For $K\ge K_r$, both exterior coefficients are positive by the established moving-tail theorems, and their difference has the strictly positive lower bound in (24). Thus the division exterior necessarily carries the extra amount missing from its finite core. The excess has the explicit leading size (25).

The cofactor boundary's individual mixed-composite signs do not obstruct this comparison: the exact factorial/divisor constraint (11) controls their aggregate before taking absolute values. Returned histories remain an explicit signed error with (20). What remains unproved is the eventual sign of the common full readout $E(r)$. Neither the negative boundary nor the positive exterior comparison supplies it; they give a quantitative, endpoint-correct relation between its two arithmetic budgets.

## 7. Uniform asymptotic at the actual moving core

The fixed-$r$ constant in (25) is not used to pass to $r\uparrow1$. There is a separate uniform estimate. Put
$$
 t=(1-r)^{-1},\qquad K=\left\lceil16t\log(e t)\right\rceil.
$$
Then
$$
 \boxed{
 \mathfrak B_K(r)
 =-\frac{t\log K}{3\zeta(3/2)\sqrt K}
       +O\!\left(\frac t{\sqrt K}\right)
 =-\frac{t\log K}{3\zeta(3/2)\sqrt K}
       \left[1+O\!\left(\frac1{\log(e t)}\right)\right],
 \qquad t\longrightarrow\infty.}
 \tag{33}
$$
All implied constants here are absolute. In particular this is the boundary equivalent at the moving near-one core itself, rather than a fixed-$r$ equivalent evaluated outside its proved range.

First, (11) and the upper integral comparison in (9) give
$$
 0<H_K(s)\le3K^{1-s}\sum_{d<K}\frac{\Lambda(d)}d
             \le C K^{1-s}\log K,
 \qquad s\ge3/2,\quad K\ge16.
 \tag{34}
$$
The constant is independent of $s$. Indeed $1+(s-1)^{-1}\le3$, $1/\zeta(s)\le1$, and (30) controls the actual prime-power sum.

For now let $K\ge16$ be arbitrary and set $J=\lfloor K/2\rfloor$. Retaining every history, (17) gives the exact split
$$
 \begin{split}
 \mathfrak B_K(r)
 ={}&-\frac{t(1-r^J)}6H_K(3/2)\\
 &-\sum_{j=0}^{J-1}r^j
       \sum_{\ell\ge2}a_\ell[(j+1)^\ell-j^\ell]H_K(s_\ell)\\
 &+\sum_{j\ge J}r^j\sum_{n\ge K}c_K(n)u_j(n).
 \end{split}
 \tag{35}
$$
For all early histories, $j+1\le J\le K/2$. In particular (16) is valid throughout $n\ge K$, and the parameter derivative used in (27) has a uniform error:
$$
 0\le u_j(K)-\tfrac16K^{-3/2}
                \le C(j+1)K^{-5/2}.
 \tag{36}
$$
There is no near-terminal arcsine error in this range. Combining the positive higher-coefficient expansion with (34) before taking absolute values yields
$$
 \begin{split}
 0\le
 \sum_{\ell\ge2}a_\ell[(j+1)^\ell-j^\ell]H_K(s_\ell)
 &\le C K\log K
       \left[u_j(K)-\tfrac16K^{-3/2}\right]\\
 &\le C(j+1)\frac{\log K}{K^{3/2}}.
 \end{split}
 \tag{37}
$$
Thus the complete early higher-order contribution has magnitude at most
$$
 C\frac{t^2\log K}{K^{3/2}},
 \tag{38}
$$
because $\sum_{j\ge0}(j+1)r^j=t^2$. The cofactor cancellation in (34)--(37) is what avoids the additional logarithm that the absolute divisor bound (19) would introduce.

For the last line of (35), the valid all-history estimates (8) and (19) give
$$
 \left|\sum_{j\ge J}r^j\sum_{n\ge K}c_K(n)u_j(n)\right|
 \le C\frac{\log^2K}{\sqrt K}\,
       r^J\bigl[(J+1)t+r t^2\bigr].
 \tag{39}
$$
This term includes both the remaining pre-return histories and every returned history. No use of the arcsine branch is made there. The omitted first-order geometric tail when replacing $t(1-r^J)$ by $t$ costs $t r^J H_K(3/2)/6$, which is absorbed by (39), since $K\ge16$.

Equations (31), (35), (38), and (39) prove the uniform finite-parameter estimate
$$
 \boxed{
 \mathfrak B_K(r)
 =-\frac{t\log K}{3\zeta(3/2)\sqrt K}
 +O\!\left(
 \frac t{\sqrt K}
 +\frac{t^2\log K}{K^{3/2}}
 +\frac{r^{\lfloor K/2\rfloor}(Kt+t^2)\log^2K}{\sqrt K}
 \right),\quad K\ge16.}
 \tag{40}
$$
In (31) the remainder is absolute and independent of $r$, so its use here introduces no fixed-$r$ constant.

Finally take the specified $K=\lceil16tL\rceil$, $L=\log(e t)$. The floors and ceilings satisfy
$$
 16tL\le K\le17tL,\qquad
 J\ge K/2-1,\qquad
 r^J\le e^{-J/t}\le e^{-7}t^{-8},\qquad
 \log K\le2L+1.
 \tag{41}
$$
The early error in (40), divided by its main scale $t\log K/\sqrt K$, is $O(t/K)=O(L^{-1})$. The corresponding late error is
$$
 O\!\left(r^J(K+t)\log K\right)
                  =O(t^{-7}L^2),
 \tag{42}
$$
and the first error is $O((\log K)^{-1})=O(L^{-1})$. These bounds prove (33). They also show directly that the total absolute error in (40) is $O(t/\sqrt K)$ on this moving core. By (5) and (32), the same uniform leading amount is subtracted from the division core and added to its exterior. The common full feedback remains unchanged.
