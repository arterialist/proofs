# Uniform second-logarithmic divisor envelope

Let $L=\log X$, $X\ge e$, and retain the moving ceiling

\[
 a_d(y)=\max(1,y/d).
\]

The nonnegative absolute majorant for the second-log remainder in the exact identity

\[
 \frac{L}{L+\log v}=1-\frac{\log v}{L}
 +\frac{(\log v)^2}{L(L+\log v)}
\]

is

\[
 Q_d(y)=e^y\int_{a_d(y)}^\infty e^{-2dv}(\log v)^2\,dv,
 \qquad |R_d(y)|\le L^{-2}Q_d(y).
\]

This keeps the moving ceiling exactly. Since $\log v\le v$ for $v\ge1$, direct integration gives

\[
 \int_a^\infty e^{-2dv}v^2dv
 =e^{-2da}\left(\frac{a^2}{2d}+\frac a{2d^2}+\frac1{4d^3}\right).
\]

Therefore, for every integer $d\ge1$,

\[
 Q_d(y)\le
 \begin{cases}
 \dfrac54 d^{-1}e^{y-2d},&0<y\le d,\\[4pt]
 \dfrac{2y^2+2y+1}{4d^3}e^{-y},&y>d.
 \end{cases}
\tag{1}
\]

The two pieces imply the explicit row bound

\[
 \|Q_d\|_{L^2(0,\infty)}^2
 \le 9\frac{e^{-2d}}{d^2},
 \qquad
 \|Q_d\|_2\le3\frac{e^{-d}}d.
\tag{2}
\]

For the second line, use $2y^2+2y+1\le5y^2$ and

\[
 \int_d^\infty y^4e^{-2y}dy
 =e^{-2d}\left(\frac{d^4}2+d^3+\frac{3d^2}2+
 \frac{3d}2+\frac34\right)
 \le\frac{21}{4}d^4e^{-2d}.
\]

Consequently Minkowski gives the common, packet-independent bound

\[
 \left\|\sum_{d\mid P^\#}\mu(d)R_d\right\|_2
 \le\frac3{L^2}\sum_{d\ge1}\frac{e^{-d}}d
 =\frac{-3\log(1-e^{-1})}{L^2}.
\tag{3}
\]

No count of the divisors of $P^\#$ occurs.

For the requested split, set $D=L^2$. The low part is bounded by the complete integer envelope on $1\le d\le D$. The high part satisfies

\[
 \left\|\sum_{d\mid P^\#,\ d>D}\mu(d)R_d\right\|_2
 \le \frac3{L^2}\sum_{d>D}\frac{e^{-d}}d
 \le \frac{3e^{-(D+1)}}{L^2(D+1)(1-e^{-1})}.
\tag{4}
\]

Thus the high-divisor contribution is $O(e^{-L^2}/L^4)$ with a displayed absolute constant. This is stronger than the qualitative tail claimed in the simultaneous-expansion note.

A pointwise bound also controls the sampled norm. Splitting at `d<y` in (1), using $\sum d^{-3}\le\zeta(3)<5/4$, yields the convenient common envelope

\[
 \sum_{d\ge1}Q_d(y)\le2(1+y^2)e^{-y}.
\tag{5}
\]

For integer $X\ge1$, group `j` into blocks $kX\le j<(k+1)X$. Since $1-e^{-2/X}\le2/X$, (5) gives

\[
 (1-e^{-2/X})\sum_{j\ge1}
 \left(\sum_dQ_d(j/X)\right)^2
 \le8\sum_{k\ge0}(1+(k+1)^2)^2e^{-2k}<100.
\tag{6}
\]

Hence the sampled Green norm of the aggregate second-log remainder is at most `10/L²`, uniformly in $P$ and $X\ge e$.

This proves the second-logarithmic divisor-envelope component. It does not prove the separate zero-free-region PNT remainder, the moving integer-ceiling error, or the claim that sampling the signed piecewise-smooth `F_P,J_P` changes their continuous inner products by `O(1/X)` uniformly in growing `P`. Those remain the next analytic obligations.

[FiniteDivisorEnvelopeSplit.lean](BuildingBlocks/FiniteDivisorEnvelopeSplit.lean) formalizes the exact low/tail split, domination of the low divisor packet by the complete integer envelope, and the corresponding absolute-sum inequality. The integral estimates above remain written real analysis.
