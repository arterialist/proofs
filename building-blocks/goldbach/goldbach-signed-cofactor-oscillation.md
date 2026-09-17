# Signed Goldbach cofactor crossings

The signed cofactor in the literal Goldbach successor loss takes both
signs arbitrarily far out. Its one-step change is at most quadratic in
$\log s$, so infinitely many actual integer cutoffs have a
polylogarithmically small cofactor. This is a sparse statement. It
does not give the uniform RH-scale bound.

Keep every prime power and the endpoint $a_1=\Lambda(1)-1=-1$.
For integer $y\ge1$, write

\[
E_y=\psi(y)-y,\qquad q_y=E_y/y,
\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}\quad(s\ge4).
\tag{1}
\]

## Exact one-step law

Since $E_{y+1}-E_y=\Lambda(y+1)-1$,

\[
q_{y+1}-q_y=
\frac{\Lambda(y+1)-1}{y+1}
-\frac{E_y}{y(y+1)}.
\tag{2}
\]

The new pair at horizon $s+1$ has $m=s-1$ and complementary
argument $2$. Thus

\[
\boxed{\begin{aligned}
Q_{s+1}-Q_s={}&\Lambda(s-1)q_2\\
&+\sum_{m=2}^{s-2}\Lambda(m)
 \left[
 \frac{\Lambda(s+1-m)-1}{s+1-m}
 -\frac{E_{s-m}}{(s-m)(s+1-m)}
 \right].
\end{aligned}}
\tag{3}
\]

The complete von Mangoldt function occurs on both legs. The
endpoint term $\Lambda(s-1)q_2$ is not suppressed.
[GoldbachCofactorSuccessorFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorSuccessorFinite.lean)
compiles (2), the exact finite convolution step, and its
identification with the earlier signed correction.

The compiled [Chebyshev bound](../../formalization/BuildingBlocks/CoarsePrimeBounds.lean)
gives $|E_y|\le C_0y$ with $C_0=4\log2+1$, and the elementary bound
$0\le\Lambda(n)\le\log n$ holds for $n\ge2$. In (3), put
$y=s-m$ and $C=4\log2$. Retaining the complementary birth gives

\[
|q_{y+1}-q_y|
\le \frac{\Lambda(y+1)+C+2}{y+1}
\quad(2\le y\le s-2).
\]

Finite summation by parts, with $\psi(n)\le Cn$, gives

\[
\sum_{n\le s}\frac{\Lambda(n)}n
=\frac{\psi(s)}s+\sum_{n<s}\frac{\psi(n)}{n(n+1)}
\le C(2+\log s).
\]

The complementary $\Lambda(y+1)/(y+1)$ terms form a subrow of
this sum, while the remaining reciprocal sum is at most
$1+\log s$. Consequently

\[
\boxed{|Q_{s+1}-Q_s|
\le \log s\left[
 |q_2|+C(2+\log s)+(C+2)(1+\log s)
 \right]
\ll \log^2(2s).}
\tag{4}
\]

The [quadratic successor module](../../formalization/BuildingBlocks/GoldbachCofactorSuccessorQuadratic.lean)
compiles this sharpened bound, including the summation-by-parts
identity and complementary-leg reindexing.

The step bound retains complete $\Lambda$ births before taking
absolute values; it makes no claim about the sign of $Q_s$.

The [uniform interval-sieve argument](goldbach-signed-cofactor-sieve-step.md)
further sharpens the written step estimate to

\[
|Q_{s+1}-Q_s|\ll
\log(s+1)[\log\log(3s+3)]^2.
\tag{4'}
\]

Its sieve and prime-power estimates have not been formalized in Lean.
There is also a finite, one-sided parity gain: when $s+1$ is odd,
the even prime-power leg is a power of two, and

\[
Q_{s+1}-Q_s\le 2\log(s+1).
\]

[GoldbachCofactorOddStepFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean)
compiles this inequality with the endpoint $\Lambda(s-1)q_2\le0$.
It also compiles transfer of an upper bound at even $s$ to the
following odd cutoff with this logarithmic cost. The inequality
does not control downward steps.

## Actual zeta zeros force both signs

The [source identity](goldbach-signed-cofactor-volterra-source.md)
gives, for $t>0$,

\[
\mathcal Q(t)=\sum_{s\ge4}Q_se^{-st}=P(t)A_2(t),\qquad
P(t)=\sum_{n\ge1}\Lambda(n)e^{-nt}>0,
\tag{5}
\]
\[
A_2(t)=\sum_{y\ge2}\frac{E_y}{y}e^{-ty}
      =e^{-t}+\int_t^\infty\frac{D(u)}{1-e^{-u}}\,du,
\qquad
D(u)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nu}.
\tag{6}
\]

The convergent-series product in (5), with every prime power
and $\Lambda(1)=0$, is compiled for real $e^{-t}\in(0,1)$ in
[GoldbachCofactorParitySeries.lean](../../formalization/BuildingBlocks/GoldbachCofactorParitySeries.lean).
The Volterra integral in (6) remains written analysis.

The $e^{-t}$ term removes the label-one error $E_1=-1$.
To check that the actual zero information survives, let
$M_2(w)=\int_0^\infty A_2(t)t^{w-1}\,dt$, initially for
$\Re w>1$. Fubini and (6) give

\[
\boxed{
M_2(w)=\Gamma(w)+
\frac{1}{w}\left[
\Gamma(w)\left(-\frac{\zeta'(w)}{\zeta(w)}-\zeta(w)\right)
+B(w)\right],}
\tag{7}
\]

where

\[
B(w)=\int_0^\infty D(u)u^{w-1}
 \left(\frac{u}{1-e^{-u}}-1\right)du.
\tag{8}
\]

The bracket in (8) is $O(u)$ at zero. Chebyshev gives
$D(u)=O(u^{-1})$ there, while $D(u)$ decays exponentially at
infinity. Hence $B$ is holomorphic on $\Re w>0$. At a nontrivial
zero $\rho$ of multiplicity $m_\rho$, (7) has residue

\[
\operatorname*{Res}_{w=\rho}M_2(w)
=-\frac{m_\rho\Gamma(\rho)}{\rho}\ne0.
\tag{9}
\]

There is no real singularity of $M_2$ on $(0,\infty)$:
$\zeta(x)<0$ for $0<x<1$, there are no zeros for $x>1$,
and the pole terms of $-\zeta'/\zeta-\zeta$ cancel at $1$.
For $0<x<1$, the sign follows from the positive alternating
eta series and $1-2^{1-x}<0$.

Classically, zeta has a nonreal zero on the critical line
([DLMF §25.10](https://dlmf.nist.gov/25.10)). Thus (9)
places a nonreal pole of $M_2$ at real part $1/2$.
Chebyshev gives $A_2(t)=O(t^{-1})$, so the Laplace transform
of $v\mapsto A_2(e^{-v})$ has finite convergence abscissa
$\sigma\le1$, and the pole gives $\sigma\ge1/2$.

Fix any $0\le\theta<1/2$ and $C>0$. If
$A_2(e^{-v})+Ce^{\theta v}$ were nonnegative for all large
$v$, Landau's positive-Laplace theorem, whose abstract form is
compiled in [LandauSingularity.lean](../../formalization/BuildingBlocks/LandauSingularity.lean),
would force a
singularity at the real point $\sigma$. The added exponential
has its only pole at $\theta<\sigma$; deleting a finite initial
interval changes the transform by an entire function. Equation
(7) is regular at every real point of $[1/2,1]$, a
contradiction. Apply the same argument to
$Ce^{\theta v}-A_2(e^{-v})$. Therefore

\[
\limsup_{t\downarrow0}t^\theta A_2(t)=+\infty,\qquad
\liminf_{t\downarrow0}t^\theta A_2(t)=-\infty
\quad(0\le\theta<1/2).
\tag{10}
\]

PNT gives $P(t)\sim t^{-1}$. From (5) and (10),
$t^{1+\theta}\mathcal Q(t)$ is unbounded in both signs.
This gives a coefficient-level statement. Fix
$0\le\alpha<1/2$ and choose $\alpha<\theta<1/2$.
The elementary estimate
$\sum_{s\ge4}s^\alpha e^{-st}=O_\alpha(t^{-1-\alpha})$
shows that an eventual upper bound $Q_s\le Cs^\alpha$
would imply
$\limsup_{t\downarrow0}t^{1+\theta}\mathcal Q(t)\le0$.
That contradicts the positive excursions. An eventual
lower bound $Q_s\ge-Cs^\alpha$ similarly contradicts the
negative excursions. Since $C$ is arbitrary,

\[
\boxed{\limsup_{s\to\infty}\frac{Q_s}{s^\alpha}=+\infty,
\qquad
\liminf_{s\to\infty}\frac{Q_s}{s^\alpha}=-\infty
\quad(0\le\alpha<1/2).}
\tag{11}
\]

The stronger step bound (4') turns these excursions into runs of one
sign. For each fixed $0<\alpha<1/2$, there are arbitrarily
late positive and negative blocks of consecutive cutoffs,
each of length
$\gg_\alpha s^\alpha/[\log(2s)(\log\log(3s))^2]$, on which
$Q_n\ge s^\alpha$ or $Q_n\le-s^\alpha$, respectively.
Indeed, choose an excursion with $|Q_s|\ge2s^\alpha$;
over the stated number of neighboring steps, (4') changes
$Q$ by at most $s^\alpha$. The block length tends to
infinity because $\alpha>0$.

Between any sufficiently late positive and negative values,
there is either a zero coefficient or an adjacent sign
change. At an adjacent change, both coefficients have
absolute value at most $|Q_{s+1}-Q_s|$. Equation (4') proves

\[
\boxed{\text{Infinitely many integers }s\text{ satisfy }
       |Q_s|\ll\log(2s)[\log\log(3s)]^2.}
\tag{12}
\]

The Mellin continuation, interval-sieve bound (4'), Landau
application, and infinite oscillation and crossing conclusions
are written analysis. The finite source step, explicit bound (4),
one-sided odd-total step, and convergent-series product in (5)
are Lean-compiled; a Lean formalization of (7)–(12) remains open. The sparse
cutoffs in (12) do not exclude any off-critical zero or prove RH.
