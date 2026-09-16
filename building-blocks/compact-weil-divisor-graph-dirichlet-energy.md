# Exact Dirichlet energy of the finite prime-history graph

The resolved packets in the [compact Weil boundary-packet theorem](compact-weil-boundary-packet-growing-positive-space.md) have an exact prime-power divisor matrix. Its leading spectral bound can be strengthened from $\log N+O(1)$ to $\log N$ **at every cutoff**. More importantly, the difference is an explicit nonnegative energy along multiplicative edges, plus a nonnegative boundary potential. This is a finite arithmetic statement; it does not sign the gamma and pole terms of the Weil form.

For an integer $N\ge2$, let $\Lambda$ be the von Mangoldt function and put

$$
A(x)=\sum_{2\le d\le x}\frac{\Lambda(d)}d,\qquad
(K_N)_{n,m}=
\begin{cases}
\Lambda(d)/\sqrt d,&m=nd\text{ or }n=md\text{ for an integer }d>1,\\
0,&\text{otherwise},
\end{cases}
\quad 1\le n,m\le N.
$$

Every prime power is retained. The two cases defining an off-diagonal entry are mutually exclusive. For $g\in\mathbb C^N$, write $f_n=g_n/\sqrt n$ and $R=\log N$.

**Theorem.** The following identity holds for every $N\ge2$ and $g\in\mathbb C^N$:

$$
\boxed{
\begin{aligned}
\langle f,(RI-K_N)f\rangle
={}&\sum_{\substack{n,d\ge1,\ d>1\\nd\le N}}
   \frac{\Lambda(d)}{nd}|g_n-g_{nd}|^2\\
&+\sum_{n=1}^{N}\frac{\log(N/n)-A(N/n)}n|g_n|^2.
\end{aligned}}
\tag{1}
$$

Both sums are nonnegative. Consequently

$$
\lambda_{\max}(K_N)\le\log N,
\qquad \|K_N\|\le\log N.
\tag{2}
$$

The same operator bound holds for every principal submatrix, including the packet block on labels $2,\ldots,N$.

To prove (1), assign weight $a_{n,d}=\Lambda(d)/(nd)$ to each oriented factorization edge $n\to nd$. The matrix definition gives

$$
\langle f,K_Nf\rangle
=2\operatorname{Re}\sum_{\substack{n,d\ge1,\ d>1\\nd\le N}}
 a_{n,d}\overline{g_n}g_{nd}.
\tag{3}
$$

The coefficient of $|g_m|^2$ when the edge squares in (1) are expanded is

$$
\sum_{2\le d\le N/m}\frac{\Lambda(d)}{md}
+\sum_{\substack{d\mid m\\d>1}}\frac{\Lambda(d)}m
=\frac{A(N/m)+\log m}{m}.
\tag{4}
$$

The last equality is the exact divisor-log identity $\sum_{d\mid m}\Lambda(d)=\log m$. Subtract (3) from the edge-square expansion and add the diagonal potential. Its coefficient becomes
$(A(N/m)+\log m+\log(N/m)-A(N/m))/m=R/m$, proving (1).

Nonnegativity of the potential uses the published all-$x$ inequality

$$
\sum_{d\le x}\frac{\Lambda(d)}d\le\log x\qquad(x\ge1),
\tag{5}
$$

proved as [Theorem 1.3 and in the appendix of Ramaré–Zuniga-Alterman, with Balazard](https://arxiv.org/html/2312.05138). Equation (5) is an input from established mathematics, not a new result of this note. Since $K_N$ is real symmetric with nonnegative entries,
$|\langle f,K_Nf\rangle|\le\langle |f|,K_N|f|\rangle\le R\|f\|_2^2$, which proves (2); zero extension gives the principal-submatrix claim.

This ceiling is sharp to leading order. On $g_n=1$, the edge-square term vanishes, and the [exact Rayleigh collapse](compact-weil-divisor-matrix-sharpness.md) gives

$$
\frac{\langle f,K_Nf\rangle}{\|f\|_2^2}
=\frac{2\sum_{m\le N}(\log m)/m}{\sum_{m\le N}1/m}
=\log N-\gamma+o(1).
\tag{6}
$$

For a completely multiplicative unit phase $g_n=\chi(n)$, each edge-square is $|1-\chi(d)|^2$ times its weight. Thus (1) directly measures the cost of changing a prime generator's phase; the [fixed-prime phase calculation](compact-weil-critical-packet-second-order-tests.md) obtains a finite limiting cost when only finitely many prime coordinates are changed.

Equation (1) is a conservation law for this finite multiplicative graph. It says nothing by itself about the full Weil form: at critical packet frequency $T\asymp N$, the archimedean multiplier couples neighboring **additive** labels, and the two pole moments also enter. A comparison of those terms with the edge energy and boundary potential is still required. [CompactWeilDivisorEnergyFinite.lean](BuildingBlocks/CompactWeilDivisorEnergyFinite.lean) formalizes the real-coefficient finite identity, factor-pair and pointwise boundary regrouping, and edge-square nonnegativity. The complex extension, the analytic input (5), and the gamma/pole comparison are not formalized there.
