# The complete centered readout is subquadratic under the classical PNT

For the original arithmetic functions $V,W$, one has unconditionally
$$
V(x)=o(x^2),\qquad W(x)=o(x^2)\qquad(x\to\infty).
$$
This is weaker than the RH-scale sign or growth target. The proof retains the origin atom, every prime power and the complete same-prime subtraction.

## The full signed pair before subtracting same-prime histories

Write $E(x)=\psi(x)-x$ for $x\ge1$, with right-continuous prime-power endpoints, and let
$$
d\nu=-\delta_1+\sum_{n\ge2}\Lambda(n)\delta_n-\mathbf1_{[1,\infty)}dx,
\qquad H(y)=\int_1^y E(b)\,db.
$$
Then $\nu([1,x])=E(x)$, including $E(1)=-1$. For real $x>1$, set
$$
T(x)=\iint_{ab\le x}(x-ab)\,d\nu(a)d\nu(b).
\tag{1}
$$
The integration region is compact and both signed measures have finite variation there. Stieltjes integration by parts gives
$$
\int_{[1,x/a]}(x-ab)\,d\nu(b)=aH(x/a).
$$
A second integration by parts therefore gives the exact identity
$$
T(x)=-\int_1^x E(a)\left[H(x/a)-(x/a)E(x/a)\right]da.
\tag{2}
$$
The upper boundary vanishes because $H(1)=0$. The lower atom was included in the cumulative function $E$ before either integration. The derivative in (2) holds almost everywhere, which suffices for the absolutely continuous inner primitive.

Expanding (1) before any asymptotic estimate yields
$$
\begin{aligned}
T(x)={}&\sum_{ab\le x}(x-ab)\Lambda(a)\Lambda(b)
-\sum_{n\le x}\Lambda(n)\frac{x^2-n^2}{n}\\
&+\frac{x^2}{2}\log x+\frac{x^2}{4}-\frac14.
\end{aligned}
\tag{3}
$$
In particular, the density and origin contributions are exactly the polynomial-logarithmic term displayed here.

## Dominated convergence with the actual PNT error

The classical effective PNT gives constants $C,c>0$ such that
$$
|E(a)|\le Ca\exp(-c\sqrt{\log a})\qquad(a\ge2),
$$
after absorbing logarithmic factors by reducing $c$. Thus
$$
\int_1^\infty\frac{|E(a)|}{a^2}\,da<\infty.
\tag{4}
$$
For a directly applicable quantitative source, [Johnston–Yang, Theorem 1.1](https://arxiv.org/html/2204.01980v2#S1.SS2) bounds $|\psi(a)-a|$ by $9.39a(\log a)^{1.515}\exp(-0.8274\sqrt{\log a})$ for every $a\ge2$.

Put
$$
q(y)=\frac{H(y)-yE(y)}{y^2},\qquad y\ge1.
$$
The elementary bound $E(y)=O(y)$ makes $q$ bounded. The PNT gives $E(y)=o(y)$ and $H(y)=o(y^2)$, hence $q(y)\to0$. Equation (2) becomes
$$
\frac{T(x)}{x^2}
=-\int_1^\infty\mathbf1_{a\le x}\frac{E(a)}{a^2}q(x/a)\,da.
\tag{5}
$$
For each fixed $a$, the integrand tends to zero. Its absolute value is bounded by a constant times the integrable function in (4). Dominated convergence proves $T(x)=o(x^2)$ and also the uniform bound $T(x)=O(x^2)$.

## Same-prime histories and the complete harmonic readout

The original distinct-prime function is
$$
V(x)=T(x)-\tau(x),\qquad
\tau(x)=\sum_p\sum_{\substack{r\ge2\\p^r\le x}}
(r-1)(\log p)^2(x-p^r).
\tag{6}
$$
There are exactly $r-1$ ordered positive depth pairs with total depth $r$. In particular, both orientations and all proper powers remain. For each $p\le\sqrt x$, the sum of $(r-1)(\log p)^2$ is at most $(\log x)^2/2$. Consequently
$$
0\le\tau(x)\le\frac{x^{3/2}(\log x)^2}{2}=o(x^2).
\tag{7}
$$
This elementary bound is sufficient. A bound of order $x\log^3x$ is not used. Equations (5)–(7) prove $V(x)=o(x^2)$ and $|V(x)|\le Cx^2$ for $x>1$. Set $V(x)=0$ for $x\le1$, as in the original definition.

Finally, retain every harmonic multiple in
$$
W(x)=\sum_{d\le x}\sqrt d\,V(x/d).
$$
For each fixed integer $d\ge1$,
$$
\mathbf1_{d<x}d^{-3/2}\frac{V(x/d)}{(x/d)^2}\longrightarrow0,
$$
and its absolute value is at most $Cd^{-3/2}$. This majorant is summable, so countable dominated convergence proves
$$
\boxed{\frac{W(x)}{x^2}\longrightarrow0.}
\tag{8}
$$
The possible endpoint $d=x$ contributes zero. This justifies the subquadratic input to the [three-sector prime-state allocation](prime-state-projector-boundary.md), including the separate state $1$.

## Attribution and formal scope

The effective PNT, Stieltjes integration by parts and dominated convergence are classical. Their application here uses the [original coefficient identification](../zeta-and-zeros/actual-W-positive-primitive-analysis.md), rather than a substitute for $V/W$. The arithmetic definitions and original-source correspondence are formalized in the repository; the asymptotic proof (1)–(8) above is written mathematics. It proves neither eventual $W\le0$ nor the RH-scale growth bound.
