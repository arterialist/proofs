# Strict density-prime covariance under the full cutoff law

For the actual cutoff law

$$
Z_x=\sum_{n<x}\frac{x-n}{\sqrt n},\qquad
P_x(n)=\frac{x-n}{\sqrt n Z_x},\qquad x>1,
$$

put $z_x(n)=x/n-1$ and

$$
m_p(n)=\log p\sum_{j=1}^{v_p(n)}p^{j/2},\qquad
S(n)=\sum_p m_p(n).
$$

Then the exact actual signs are

$$
\boxed{\operatorname{Cov}_x(z_x,m_p)<0\quad(x>p),}
\qquad
\operatorname{Cov}_x(z_x,m_p)=0\quad(1<x\le p),
\tag{1}
$$

$$
\boxed{\operatorname{Cov}_x(z_x,S)<0\quad(x>2).}
\tag{2}
$$

In the full two-history formula this covariance enters with a minus sign. It is therefore a positive contribution that needs compensation, not a negative correction that supplies the missing sign of $W$. The [cross-prime covariance theorem](prime-score-negative-covariance.md) supplies its separate pairwise sign. Their [combined balance](combined-prime-density-covariance.md) still leaves an unsigned remainder. This finite-sum proof is not formalized in Lean; no priority claim is made.

## The cutoff density mean strictly increases

Define

$$
\beta(x)=E_xz_x
=\frac{\sum_{n<x}(x-n)^2/n^{3/2}}
       {\sum_{n<x}(x-n)/\sqrt n}.
$$

We first prove that $\beta$ is continuous and strictly increasing on $(1,\infty)$. At an integer a newly included summand has weight zero in both numerator and denominator; this proves continuity. On $(N,N+1)$, write

$$
A_N=\sum_{n\le N}n^{-1/2},\quad
B_N=\sum_{n\le N}n^{-3/2},\quad
C_N=\sum_{n\le N}n^{1/2}.
$$

Then

$$
\beta(x)=\frac{x^2B_N-2xA_N+C_N}{xA_N-C_N},
\quad
\beta'(x)=\frac{H_N(x)}{(xA_N-C_N)^2},
$$

$$
H_N(x)=x^2A_NB_N-2xB_NC_N+A_NC_N.
\tag{3}
$$

For $N=1$, directly $\beta(x)=x-1$. For $N\ge2$, $N A_N>C_N$, so

$$
H_N'(x)=2B_N(xA_N-C_N)>0\quad(x\ge N).
$$

The four small cases have the rational lower bounds

$$
H_2(2)>0.2928,\qquad H_3(3)>2.7970,\qquad
H_4(4)>9.3958,\qquad H_5(5)>21.7517.
\tag{4}
$$

The [exact rational certificate](../../certificates/cutoff_density_monotonicity.py) verifies these bounds using

$$
\begin{array}{c|cc}
n&10^6\,l_n&10^6\,u_n\\\hline
1&1000000&1000000\\
2&1414213&1414214\\
3&1732050&1732051\\
4&2000000&2000000\\
5&2236067&2236068\\
6&2449489&2449490
\end{array}
$$

Each row satisfies $l_n^2\le n\le u_n^2$ by integer squaring. In (4), use

$$
A_- =\sum 1/u_n,\ B_- =\sum1/(nu_n),\ C_- =\sum l_n,
\quad B_+=\sum1/(nl_n),\ C_+=\sum u_n,
$$

and the lower bound
$N^2 A_- B_- - 2N B_+ C_+ + A_- C_-$.

The same root bounds give

$$
D_6:=6A_6-2C_6>17/100.
$$

For $N\ge6$,

$$
D_{N+1}=D_N+A_N-\sqrt{N+1}>D_N.
$$

Indeed, for $N\ge4$,

$$
A_N\ge1+\frac{N-1}{\sqrt N}
=\sqrt N+1-\frac1{\sqrt N}
\ge\sqrt N+\frac12>\sqrt{N+1}.
$$

Thus $D_N>0$ for all $N\ge6$. For $x\ge N$ this gives

$$
H_N(x)=xB_N(xA_N-2C_N)+A_NC_N>0.
$$

Together with the small cases and continuity, (3) proves the claimed strict increase of $\beta$ on its whole domain. The argument covers every real cutoff, including the changes of support at integers.

## Exact prime-color size bias

Expanding a single actual color and writing $n=p^j d$ gives

$$
Z_x E_xm_p
=\log p\sum_{p^j<x}p^j Z_{x/p^j},
\tag{5}
$$

$$
Z_x E_x(z_x m_p)
=\log p\sum_{p^j<x}p^j Z_{x/p^j}\,\beta(x/p^j).
\tag{6}
$$

To check the factor, the weight before summing over $d$ is

$$
\frac{x-p^jd}{\sqrt{p^jd}}p^{j/2}
=p^j\frac{x/p^j-d}{\sqrt d}.
$$

Moreover $z_x(p^jd)=z_{x/p^j}(d)$. All sums are finite; no Euler-product limit or prime-counting estimate is used. Subtracting the product of means yields the exact positive-gap representation

$$
\boxed{
-\operatorname{Cov}_x(z_x,m_p)
=\frac{\log p}{Z_x}\sum_{p^j<x}
p^j Z_{x/p^j}\,[\beta(x)-\beta(x/p^j)].
}
\tag{7}
$$

Every displayed term is strictly positive. The sum is nonempty exactly when $x>p$, proving (1). Summing (7) over all actual prime powers proves (2). This retains repeated prime powers and the complete cutoff dependence.

The scores and density term are derived from the complete measure identity in [prime allocation](prime-allocation-critical-identity.md). The certificate uses Python's standard library only. Run `python3 certificates/cutoff_density_monotonicity.py` from the repository root without `-O`; the monotonicity beyond the finite starting cases is the analytic induction above.
