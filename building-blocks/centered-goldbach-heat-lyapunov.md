# The centered Goldbach heat energy at the critical boundary

This note joins the centered heat Lyapunov criterion to the additive
Goldbach coefficients without analytic continuation of an infinite signed
Dirichlet series. The bridge is finite at every observation horizon and
keeps the exact centering terms.

Put

$$
a_n=\Lambda(n)-1,
\qquad
D(t)=\sum_{n\geq1}a_ne^{-nt}
=\sum_{n\geq1}\Lambda(n)e^{-nt}-\frac1{e^t-1}.
\tag{1}
$$

Let

$$
R_a(k)=\sum_{m+n=k}a_ma_n,
\qquad
R_\Lambda(k)=\sum_{m+n=k}\Lambda(m)\Lambda(n).
$$

Since $\Lambda(1)=0$, direct expansion gives the exact centered Goldbach
coefficient

$$
\boxed{
R_a(k)=R_\Lambda(k)-2\psi(k-1)+(k-1)
}
\qquad(k\geq2).
\tag{2}
$$

For $T\geq0$, define

$$
K_T(k)=\frac{e^{-ke^{-T}}-e^{-k}}k
$$

and

$$
\mathscr H(T)
=1+\sum_{k\geq2}R_a(k)K_T(k).
\tag{3}
$$

## Exact finite-horizon identity

For every finite $T\geq0$, all series below converge absolutely and

$$
\boxed{
\mathscr H(T)
=1+\int_{e^{-T}}^1|D(t)|^2\,dt.
}
\tag{4}
$$

Indeed, exponential decay makes the double series absolutely convergent on
$[e^{-T},1]$. Therefore

$$
\begin{aligned}
\int_{e^{-T}}^1D(t)^2\,dt
&=\sum_{m,n\geq1}a_ma_n
  \int_{e^{-T}}^1e^{-(m+n)t}\,dt\\
&=\sum_{m,n\geq1}a_ma_n
  \frac{e^{-(m+n)e^{-T}}-e^{-(m+n)}}{m+n}\\
&=\sum_{k\geq2}R_a(k)K_T(k).
\end{aligned}
\tag{5}
$$

The right side of equation (3) is thus positive despite the signs of its
individual centered Goldbach coefficients.

## RH as zero growth of centered Goldbach heat

The centered heat criterion uses

$$
C(t)=\sum_{n\geq1}\Lambda(n)e^{-nt}-(1+t^{-1})e^{-t}.
\tag{6}
$$

The two centered sources differ by

$$
E_0(t)=C(t)-D(t)
=\frac1{e^t-1}-(1+t^{-1})e^{-t}
=-\frac12+O(t)
\qquad(t\downarrow0).
\tag{7}
$$

Hence $E_0\in L^2(0,1)$. If

$$
b_C(v)=e^{-v/2}C(e^{-v}),
\qquad
b_D(v)=e^{-v/2}D(e^{-v}),
$$

then

$$
\int_0^\infty|b_C(v)-b_D(v)|^2\,dv
=\int_0^1|E_0(t)|^2\,dt<\infty.
\tag{8}
$$

The triangle inequality now compares the two accumulated energies in both
directions by constants independent of $T$. Their logarithmic growth
exponents are equal. The centered heat theorem therefore gives

$$
\boxed{
\mathrm{RH}
\quad\Longleftrightarrow\quad
\limsup_{T\to\infty}\frac{\log\mathscr H(T)}T=0.
}
\tag{9}
$$

More sharply, a nontrivial zero $\rho=\beta+i\gamma$ with $\beta>1/2$
forces

$$
\limsup_{T\to\infty}\frac{\log\mathscr H(T)}T
\geq2\beta-1.
\tag{10}
$$

The equivalent finite-scale target is

$$
\boxed{
\mathrm{RH}
\quad\Longleftrightarrow\quad
\exists A,K,T_0>0\ \forall T\geq T_0:
\mathscr H(2T)\leq AT^K\mathscr H(T).
}
\tag{11}
$$

This is the critical $\sigma=1$ form of the additive-to-multiplicative
bridge. The Mellin-Barnes identity samples an infinite positive vertical
norm for $\sigma>1$. Equation (4) instead keeps a finite heat cutoff at the
boundary and asks whether its energy grows subexponentially as the cutoff is
removed.

## What remains

Ordinary Goldbach existence only states that $R_\Lambda(k)>0$ for even
$k>2$. It does not control the centered coefficient in equation (2), whose
two deterministic terms have the same size as the average main term. A proof
must use the signs of the complete centered sequence across scales.

The exact shell identity

$$
\mathscr H(2T)-\mathscr H(T)
=\int_{e^{-2T}}^{e^{-T}}|D(t)|^2\,dt
\tag{12}
$$

shows the missing theorem in additive language. One needs an unconditional
renormalization estimate comparing the new shell with the accumulated past
by at most a polynomial in $T$. The divisor renewal equation is a plausible
source of such a comparison because the change $T\mapsto2T$ is precisely
$t\mapsto t^2$, but no such inequality is proved here.

Status: equations (1) through (8) and (12) are unconditional. Equations
(9) through (11) consume the written centered heat Lyapunov theorem. The
scale comparison described after equation (12) remains open.


## Formal signed heat energy and the actual series

[GoldbachHeatQuadratic.lean](BuildingBlocks/GoldbachHeatQuadratic.lean) proves the classical gamma-integral identity for arbitrary real coefficients and every $s>0$:
$$
\Gamma(s)\sum_{1\le m,n\le N}\frac{a_ma_n}{(m+n)^s}
=\int_0^\infty t^{s-1}\left(\sum_{n=1}^N a_ne^{-nt}\right)^2dt.
$$
`finiteHeat_square_integrable` derives integrability, and `finiteEnergy_nonneg` gives nonnegativity with all signed cross terms retained. For the actual coefficients $a_n=\Lambda(n)-1$, the module proves $a_1=-1$ and the discrete sum-three coefficient $2(1-\log2)$. This differs from the $-2\log2$ atom of the mixed continuous source in the [reverse-scale audit](centered-goldbach-reverse-scale-audit.md).

[GoldbachHeatComparison.lean](BuildingBlocks/GoldbachHeatComparison.lean) formalizes the full bilinear expansion and Cauchy–Schwarz inequality. `vonMangoldt_energy_le_centered` applies them to the exact identity $\Lambda=(\Lambda-1)+1$, including $n=1$.

[GoldbachHeatSeries.lean](BuildingBlocks/GoldbachHeatSeries.lean) derives absolute convergence of the actual prime and centered heat series for each $t>0$ from the elementary bound $\Lambda(n)\le\log n$. It proves finite-cutoff convergence and the complete centering identity
$$
A_d(t)=D(t)+\frac1{e^t-1}-\left(1+\frac1t\right)e^{-t},
\qquad
A_d(t)=\sum_{n\ge1}\Lambda(n)e^{-nt}-\left(1+\frac1t\right)e^{-t}.
$$
These modules establish the finite quadratic comparison and literal positive-time series. An infinite Mellin identity or the critical-horizon arithmetic bound is not inferred from pointwise convergence. The proofs use the classical gamma integral, geometric series and quadratic-form Cauchy–Schwarz. The modules compile; their principal axiom checks contain only `propext`, `Classical.choice` and `Quot.sound`.
