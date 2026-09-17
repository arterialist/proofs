# Critical-scale oscillation of the signed Goldbach cofactor

The actual signed cofactor has positive and negative excursions of
order at least $\sqrt{s}$ on **each** parity subsequence. This strengthens
the previously recorded $\Omega_\pm(s^\alpha)$ result for every
$\alpha<1/2$ to the critical exponent itself. It is a lower bound, not
an RH-scale upper bound.

Keep every prime power and the actual endpoints:

\[
E_y=\psi(y)-y,\qquad q_y=E_y/y,\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}\quad(s\ge4).
\tag{1}
\]

Let $\rho=\tfrac12+i\gamma$ be any nonreal zeta zero, with multiplicity
$m_\rho\ge1$, and set

\[
R_\rho=\frac{m_\rho|\Gamma(\rho)|}{|\rho|}>0,
\qquad c_\rho=\frac{R_\rho}{\Gamma(3/2)}>0.
\tag{2}
\]

Such a zero exists by Hardy's theorem; see, for example,
[Titchmarsh, *The Theory of the Riemann Zeta-Function*, §10.2](https://sites.math.rutgers.edu/~zeilberg/EM18/TitchmarshZeta.pdf).
For each $p\in\{0,1\}$, the conclusion is

\[
\boxed{
\limsup_{\substack{s\to\infty\\s\equiv p\ (2)}}
       \frac{Q_s}{\sqrt{s}}\ge c_\rho,
\qquad
\liminf_{\substack{s\to\infty\\s\equiv p\ (2)}}
       \frac{Q_s}{\sqrt{s}}\le-c_\rho.}
\tag{3}
\]

No simplicity assumption on $\rho$ is needed. Substituting the first
zero's ordinate and $m_\rho=1$ into (2) gives
$c_\rho\approx4.55\cdot10^{-11}$; a higher multiplicity would only
increase this constant. The proof needs only the symbolic value (2).

## A residue comparison at the boundary

Put $A_2(t)=\sum_{y\ge2}q_y e^{-ty}$ and
$M_2(w)=\int_0^\infty A_2(t)t^{w-1}\,dt$. The
[source calculation](goldbach-signed-cofactor-oscillation.md#actual-zeta-zeros-force-both-signs)
gives a meromorphic continuation of $M_2$ to $\Re w>0$, regular
at every positive real $w$, with

\[
\operatorname*{Res}_{w=\rho}M_2(w)
       =-\frac{m_\rho\Gamma(\rho)}{\rho}.
\tag{4}
\]

Here is a quantitative form of the positive-Laplace argument. Write
$f(v)=A_2(e^{-v})$. Chebyshev gives $f(v)=O(e^v)$ as $v\to\infty$;
as $v\to-\infty$ it decays faster than any exponential. Substitution
$t=e^{-v}$ gives

\[
M_2(w)=\int_{-\infty}^{\infty}f(v)e^{-wv}\,dv
\qquad(\Re w>1).
\tag{5}
\]

Suppose $f(v)\ge-Ce^{v/2}$ for all $v\ge v_0\ge0$, where $C\ge0$.
Then $g(v)=f(v)+Ce^{v/2}\ge0$ on this ray. Its Laplace transform

\[
G(w)=\int_{v_0}^{\infty}g(v)e^{-wv}\,dv
=M_2(w)-\int_{-\infty}^{v_0}f(v)e^{-wv}\,dv
 +\frac{Ce^{(1/2-w)v_0}}{w-1/2}
\tag{6}
\]

initially converges for $\Re w>1$. The omitted finite-end integral
is entire. Let $a$ be the real abscissa of convergence of $G$.
The pole (4) implies $a\ge1/2$; Chebyshev gives $a\le1$.
If $a>1/2$, Landau's positive-Laplace theorem makes the real point
$a$ singular for $G$, whereas (6) is regular there. Hence $a=1/2$.
The [abstract Landau singularity theorem](../../formalization/BuildingBlocks/LandauSingularity.lean)
is also Lean-compiled.

For $\sigma>1/2$, positivity now gives

\[
|G(\sigma+i\gamma)|\le G(\sigma).
\]

Multiply by $\sigma-1/2$ and let $\sigma\downarrow1/2$.
Equation (4) makes the left limit $R_\rho$; regularity of $M_2$
at real $1/2$ makes the right limit $C$. Thus $C\ge R_\rho$.
Applying the same argument to $-f(v)+Ce^{v/2}$ proves

\[
\limsup_{t\downarrow0}t^{1/2}A_2(t)\ge R_\rho,
\qquad
\liminf_{t\downarrow0}t^{1/2}A_2(t)\le-R_\rho.
\tag{7}
\]

This argument allows zeros to the right of the critical line: if
such a pole raises the Laplace abscissa, Landau's theorem rules out
the assumed eventual one-sided bound even before the residue
comparison.

## Transfer to both parity coefficient sequences

Let $P(t)=\sum_{m\ge1}\Lambda(m)e^{-mt}$ and
$\mathcal Q(t)=\sum_{s\ge4}Q_s e^{-st}=P(t)A_2(t)$.
The prime number theorem gives $tP(t)\to1$. Therefore (7) implies

\[
\limsup_{t\downarrow0}t^{3/2}\mathcal Q(t)\ge R_\rho,
\qquad
\liminf_{t\downarrow0}t^{3/2}\mathcal Q(t)\le-R_\rho.
\tag{8}
\]

The [alternating source estimate](goldbach-signed-cofactor-parity-oscillation.md#alternating-source-cancellation)
gives

\[
\sum_{s\ge4}(-1)^sQ_s e^{-st}=O(t^{-1}\log^2(2/t))
      =o(t^{-3/2}).
\]

Hence for $\mathcal Q_p(t)=\sum_{s\ge4,\ s\equiv p\ (2)}Q_s e^{-st}$,
each limsup in (8) is at least $R_\rho/2$, and each liminf is at
most $-R_\rho/2$. Finally, a Riemann sum on either parity lattice
gives

\[
\sum_{\substack{s\ge4\\s\equiv p\ (2)}}\sqrt{s}\,e^{-st}
 \sim\frac{\Gamma(3/2)}{2}t^{-3/2}.
\tag{9}
\]

If the upper coefficient limit in (3) were smaller than $c_\rho$,
then eventually $Q_s\le C\sqrt{s}$ on that parity for some
$C<c_\rho$. Equations (9) and the finitely many earlier terms
would force
$\limsup t^{3/2}\mathcal Q_p(t)\le C\Gamma(3/2)/2<R_\rho/2$,
a contradiction. The lower limit follows symmetrically.

The Mellin continuation, residue comparison, parity Abel estimate,
and coefficient conclusion here remain written analysis. The finite
cofactor identities, convergent-series product, parity projections,
and abstract Landau theorem cited above are Lean-compiled.
