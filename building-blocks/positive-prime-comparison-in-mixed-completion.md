# A positive prime comparison in the mixed completion

Let $\mathcal E$, $m$, and the actual causal sources $g_T\to g$ be those of [actual-source-mixed-dirichlet-completion.md](actual-source-mixed-dirichlet-completion.md). In particular,
$$
\|f\|_{\mathcal E}^2=\int m(\xi)|\widehat f(\xi)|^2d\xi,
\qquad m(\xi)\sim\pi|\xi|\ (\xi\to0),\qquad m(\xi)\to4\ (|\xi|\to\infty).
$$
The actual source is
$$
g_T(x)=1_{x\ge1}\chi_T(\log x)\left(\frac{\psi(x)}x-1\right).
$$
Its seed jump, density subtraction, every prime power, and both cutoff endpoints remain part of this definition. We use the source note's cutoff-uniform estimates (7)–(10), rather than an unweighted norm for its full limit.

Put $\mathsf S=m(D_x)^{1/2}$. Multiplication by $\sqrt m$ in additive Fourier coordinates extends to a unitary map from the completed $\mathcal E$ space onto $L^2(\mathbb R)$. Surjectivity follows by first truncating any target Fourier function to compact annuli away from zero, where multiplication by $1/\sqrt m$ is bounded. Constants are treated as in the original completion.

For $D_af(x)=\sqrt a f(ax)$, define
$$
V_a=\mathsf S^{-1}D_a\mathsf S.
\tag{1}
$$
These operators are $\mathcal E$-unitary, $V_a^\dagger=V_{1/a}$, and $V_aV_b=V_{ab}$. Their exact Fourier action is
$$
\widehat{V_af}(\xi)
=\sqrt{\frac{m(\xi/a)}{m(\xi)}}\,a^{-1/2}\widehat f(\xi/a).
\tag{2}
$$
Thus the comparison changes the actual dilation on a whole frequency region. It is not a correction supported at the causal boundary.

Fix a prime $p$, write $r=p^{-1/2}$, and set
$$
\widetilde U_p=(I-rV_p)(I-rV_{1/p})^{-1},\qquad
\widetilde L_p=(\widetilde U_p-I)^\dagger(\widetilde U_p-I),\qquad
\widetilde L_P=\sum_{p\le P}\widetilde L_p.
\tag{3}
$$
Both inverse geometric series converge in operator norm. The factors commute, so $\widetilde U_p$ is unitary, its inverse is obtained by interchanging $p$ and $1/p$, and all reference prime operators commute. In particular
$$
\widetilde L_p=2I-\widetilde U_p-\widetilde U_p^{-1}
=\mathsf S^{-1}L_p^{(0)}\mathsf S,
\tag{4}
$$
where $L_p^{(0)}$ is the original critical $L^2(dx)$ prime Laplacian.

## The positive bound and the source on which its gap acts

Split $L^2(dx)$ into the positive and negative half-axes. On either half-axis the unitary logarithmic identification is $F_\pm(v)=e^{v/2}F(\pm e^v)$. Its Fourier transform turns $D_a$ into multiplication by $e^{i\tau\log a}$. Hence, with $\theta=\tau\log p$, the reference symbols are exactly
$$
 u_p(\tau)=\frac{1-re^{i\theta}}{1-re^{-i\theta}},\qquad
 \lambda_p(\tau)=|u_p(\tau)-1|^2
 =\frac{4r^2\sin^2\theta}{1+r^2-2r\cos\theta}.
\tag{5}
$$
Since
$$
1+r^2-2r\cos\theta-\sin^2\theta=(\cos\theta-r)^2,
$$
we obtain the exact single-prime norm and a collective bound:
$$
\boxed{\|\widetilde L_p\|=\frac4p,\qquad
0\le\widetilde L_P\le4\left(\sum_{p\le P}\frac1p\right)I.}
\tag{6}
$$
Equality in the single-prime essential supremum occurs at $\cos\theta=r$. An elementary explicit bound suffices for the sum. For $P\ge2$, set $s=1+1/\log P$. Then
$$
\sum_{p\le P}\frac1p\le e\sum_p p^{-s}
\le e\log\zeta(s)\le e\log(1+\log P).
$$
The middle inequality is the absolutely convergent Euler logarithm, retaining all prime powers; the last follows from the integral bound $\zeta(s)\le1+1/(s-1)$. Therefore
$$
\|\widetilde L_P\|\le4e\log(1+\log P).
\tag{7}
$$

For every $f\in\mathcal E$, its exact positive energy is
$$
\langle f,\widetilde L_Pf\rangle_{\mathcal E}
=\sum_{\pm}\int_{\mathbb R}\left(\sum_{p\le P}\lambda_p(\tau)\right)
\left|\mathcal F_v\left[e^{v/2}(\mathsf Sf)(\pm e^v)\right](\tau)\right|^2d\tau.
\tag{8}
$$
Consequently any established prime-phase lower gap on a measurable band $B$ transfers exactly to the corresponding spectral mass of $\mathsf Sf$ on $B$. This is a gap for the transformed source. In particular, inserting $f=g_T$ does not leave the original critical source $e^{v/2}g_T(e^v)$ unchanged. The multiplier $\mathsf S$ does not in general preserve positive-axis support or the original two causal ports. Formula (8) includes both half-axis channels. Transporting an old readout also requires transporting its tests and boundary operators.

## Exact comparison with the actual prime operators

Define the bounded dilation correction
$$
C_a=D_a-V_a
=\left(I-M_{\sqrt{m(\xi/a)/m(\xi)}}\right)D_a,
\tag{9}
$$
where $M_b$ denotes additive Fourier multiplication. Its group compatibility is the exact identity
$$
C_{ab}=C_aD_b+V_aC_b.
\tag{10}
$$
For a fixed $a$, the coefficient in (9) tends to $1-a^{-1/2}$ at zero frequency and to zero at infinite frequency. Thus even far from causal endpoints it need not vanish.

Let $R_p=(I-rD_{1/p})^{-1}$, which is bounded on $\mathcal E$, and let $U_p=(I-rD_p)R_p$ be the actual prime transport. The bounded inverse and adjoint issues for these actual operators are proved in [prime-transport-in-mixed-completion.md](prime-transport-in-mixed-completion.md). The resolvent identity gives, on the full completion,
$$
\boxed{U_p-\widetilde U_p
=r\left[-C_p+\widetilde U_pC_{1/p}\right]R_p.}
\tag{11}
$$
The order in this formula matters. In particular, $C_a$ need not commute with the reference operators. Indeed,
$R_p-\widetilde R_p=\widetilde R_p rC_{1/p}R_p$, where
$\widetilde R_p=(I-rV_{1/p})^{-1}$; inserting this into the difference of the two transports proves (11).

The actual inverse $U_p^{-1}$ is not bounded on the whole completion. For the actual sources, however, its complete forward-power series converges by the source estimate. Define their actual generator by
$$
L_pg_T=2p^{-1}g_T+p^{-3/2}(D_p+D_{1/p})g_T
-(1-p^{-1})\sum_{j\ge2}p^{-j/2}(D_{p^j}+D_{p^{-j}})g_T.
\tag{12}
$$
This is the original $2I-U_p-U_p^{-1}$ on the actual source domain. It is not the different positive operator $(U_p-I)^\dagger(U_p-I)$.

Expanding the two reference inverse series yields the same expression with every $D_a$ replaced by $V_a$, now converging in operator norm. Subtraction therefore gives the full metric correction on $g_T$:
$$
\boxed{
(L_p-\widetilde L_p)g_T
=p^{-3/2}(C_p+C_{1/p})g_T
-(1-p^{-1})\sum_{j\ge2}p^{-j/2}(C_{p^j}+C_{p^{-j}})g_T.}
\tag{13}
$$
The $2p^{-1}g_T$ terms cancel exactly. Every proper power remains in (13). Here $C_{p^j}$ means $D_{p^j}-V_{p^j}$, not the power $C_p^j$.

## A cutoff-uniform actual-source bound

There are constants $C,c>0$, independent of $T$, such that
$$
\|g_T\|_{\mathcal E}\le C,\qquad
\|D_ag_T\|_{\mathcal E}\le C\sqrt a\,e^{-c\sqrt{\log a}}\ (a\ge2),\qquad
\|D_ag_T\|_{\mathcal E}\le C\ (0<a\le2).
\tag{14}
$$
These are precisely the actual arithmetic increment consequences in the source note. Since $\|V_ag_T\|_{\mathcal E}=\|g_T\|_{\mathcal E}$, they imply
$$
\|C_ag_T\|_{\mathcal E}\le C\left[1+\sqrt a\,e^{-c\sqrt{\log a}}\right]\ (a\ge2),\qquad
\|C_ag_T\|_{\mathcal E}\le C\ (0<a\le2).
$$
For the first terms of (13), multiplication by $p^{-3/2}$ gives $O(p^{-1})$. For $j\ge2$, the positive-dilation contribution is bounded by
$C[e^{-c\sqrt{j\log p}}+p^{-j/2}]$, and the inverse-dilation contribution by $Cp^{-j/2}$. Their geometric part sums to $O(p^{-1})$, uniformly over primes. Therefore
$$
\boxed{
\|(L_P-\widetilde L_P)g_T\|_{\mathcal E}
\le C\sum_{p\le P}\left[\frac1p+
\sum_{j\ge2}e^{-c\sqrt{j\log p}}\right].}
\tag{15}
$$
All the series used for this estimate are absolutely convergent in $\mathcal E$ for each fixed finite admission. For each such admission, (13) converges as $T\to\infty$, using source convergence for each fixed dilation and the summable bound above. Thus (13)–(15) hold for the actual full limit $g$ as well.

One also gets the honest quadratic comparison
$$
\left|\operatorname{Re}\langle g_T,L_Pg_T\rangle_{\mathcal E}
-\langle g_T,\widetilde L_Pg_T\rangle_{\mathcal E}\right|
\le C\sum_{p\le P}\left[\frac1p+
\sum_{j\ge2}e^{-c\sqrt{j\log p}}\right].
\tag{16}
$$
The reference term lies between zero and
$4e\log(1+\log P)\|g_T\|_{\mathcal E}^2$. The available correction bound is neither zero nor relatively small in the growing-prime limit, and its pairing has no sign established here. Thus this constructs a positive comparison with an explicit actual-source error; it does not prove positivity of the original prime generator or preserve the original signed readout without its full conjugation.

All domain, transport and readout assertions in this note are written mathematics. They make no Lean or arithmetic-sign claim.
