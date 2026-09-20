# The divisor graph cannot generically coerce the terminal boundary contrast

## Status and scope

This note tests a direct interaction between additive succession and complete
multiplicative divisor history. The additive observable is the exact terminal
contrast of the harmonic Mangoldt boundary. The multiplicative control is the
finite Hermitian divisor-graph deficit. A concrete vector proves that no
uniform coercivity inequality between these two forms has the scale needed
for the coarse terminal estimate.

The argument is an unconditional written consequence of the
[published Balazard harmonic Mangoldt inequality](https://arxiv.org/html/2312.05138)
and the exact divisor identity
$\sum_{d\mid m}\Lambda(d)=\log m$. It retains every prime power. It is not a
Lean theorem and makes no novelty claim. It rules out an arbitrary-vector
Poincaré bridge; it does not rule out a new estimate special to the actual
harmonic-boundary vector.

## 1. Complete divisor-history form

For $N\ge2$ and $g:\{1,\ldots,N\}\to\mathbb C$, put

\[
 V_N(g)=\sum_{n\le N}\frac{|g(n)|^2}{n},                           \tag{1}
\]

\[
 P_N(g)=2\sum_{dn\le N}\frac{\Lambda(d)}{dn}
 \operatorname{Re}\bigl(g(n)\overline{g(dn)}\bigr),               \tag{2}
\]

and

\[
 Q_N(g)=(\log N)V_N(g)-P_N(g).                                    \tag{3}
\]

The exact ground-state decomposition in
`CompactWeilDivisorEnergyFinite.lean` writes $Q_N$ as the complete
nonnegative divisor-history square plus the pointwise harmonic boundary.
Balazard's inequality therefore gives

\[
 Q_N(g)\ge0.                                                       \tag{4}
\]

There is also a matching elementary upper envelope. Edgewise,

\[
 2\left|\operatorname{Re}\bigl(g(n)\overline{g(dn)}\bigr)\right|
 \le |g(n)|^2+|g(dn)|^2.                                          \tag{5}
\]

The outgoing square coefficient at $n$ is

\[
 \frac1n\sum_{d\le N/n}\frac{\Lambda(d)}d
 \le\frac{\log(N/n)}n,                                            \tag{6}
\]

where the floor cutoff is retained and Balazard is followed by monotonicity
of the logarithm. Reindexing the incoming square by $m=dn$ gives exactly

\[
 \frac{|g(m)|^2}{m}\sum_{d\mid m}\Lambda(d)
 =\frac{\log m}{m}|g(m)|^2.                                       \tag{7}
\]

The two coefficients in (6)--(7) add to $(\log N)/n$ at each vertex.
Consequently

\[
 |P_N(g)|\le(\log N)V_N(g),
 \qquad
 \boxed{0\le Q_N(g)\le2(\log N)V_N(g).}                           \tag{8}
\]

## 2. The exact terminal contrast

Take $N=2X$, with dyadic $X\ge4$, and define

\[
 \alpha_X(n)=
 \begin{cases}
 X,&1\le n<X,\\
 -(2n-2X+1),&X\le n<2X,\\
 0,&n=2X.
 \end{cases}                                                       \tag{9}
\]

For the harmonic boundary $B(n)$, the boundary-dependent part of the exact
terminal mass is

\[
 L_X(B)=\sum_{n=1}^{2X}\alpha_X(n)B(n).                            \tag{10}
\]

The omitted $n=0$ coefficient is $X B(0)=0$. Thus (10) is exactly the
boundary contrast already obtained from finite Abel summation, with both
dyadic endpoints fixed.

One might hope for a graph Poincaré estimate

\[
 |L_X(g)|^2\le C_X Q_{2X}(g)                                      \tag{11}
\]

for every finite vector $g$, with $C_X$ small enough to transfer the graph
positivity to the terminal channel. The following literal test vector rules
out the required scale:

\[
 g_X(n)=n\alpha_X(n).                                              \tag{12}
\]

Set

\[
 S_X=\sum_{n=1}^{2X}n\alpha_X(n)^2.
\]

Then, without an inequality,

\[
 L_X(g_X)=S_X=V_{2X}(g_X).                                        \tag{13}
\]

Combining (8), (11), and (13) gives

\[
 S_X^2\le C_XQ_{2X}(g_X)
 \le2C_X\log(2X)S_X,
\]

and hence

\[
 C_X\ge\frac{S_X}{2\log(2X)}.                                   \tag{14}
\]

On the subinterval $X/2\le n<X$, there are $X/2$ integers,
$n\ge X/2$, and $\alpha_X(n)=X$. Therefore

\[
 S_X\ge\frac{X^4}{4},
 \qquad
 \boxed{C_X\ge\frac{X^4}{8\log(2X)}.}                            \tag{15}
\]

The dual norm forced by (15) is at least of order
$X^2/\sqrt{\log X}$. A generic divisor-graph coercivity argument therefore
cannot produce the required $X^{3/2+\varepsilon/2}$ terminal scale.

## 3. What the test decides

The mechanism tested here uses the actual two structures:

1. additive succession produces the early-versus-late coefficient
   $\alpha_X$;
2. multiplicative histories produce the complete $\Lambda(d)/(dn)$ graph,
   including proper prime powers and the exact incoming divisor logarithm.

Their generic Hilbert-space coupling is quantitatively too weak by one power
of $X$ in the squared coercivity constant. Changing phases or completing the
same positive graph cannot repair this vector obstruction.

The result leaves one narrower possibility: the actual boundary
$B(n)=\log n-\sum_{d\le n}\Lambda(d)/d$ may obey a correlation law not shared
by arbitrary graph vectors. Such a law must use its exact additive jump
sequence and multiplicative divisor relations together. It cannot follow
from Hermitian positivity, the Balazard sign, or the graph norm alone.

## Verification status

Equations (5)--(15) are a written finite proof. The identities behind
(4), (7), and the exact terminal contrast are separately Lean-verified in
[CompactWeilDivisorEnergyFinite.lean](../../formalization/BuildingBlocks/CompactWeilDivisorEnergyFinite.lean)
and
[HarmonicBoundaryHistory.lean](../../formalization/BuildingBlocks/HarmonicBoundaryHistory.lean).
The assembled coercivity obstruction is not yet formalized in Lean. No RH
estimate or implication is claimed.
