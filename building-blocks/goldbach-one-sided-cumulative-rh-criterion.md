# One-sided cumulative Goldbach bounds and the actual heat response

Let $\Lambda(1)=0$ and retain every prime power. For real $X\ge0$ put

\[
R_\Lambda(n)=\sum_{a+b=n}\Lambda(a)\Lambda(b),\qquad
S_\Lambda(X)=\sum_{n\le X}R_\Lambda(n),\qquad
S_{\rm even}(X)=\sum_{\substack{n\le X\\2\mid n}}R_\Lambda(n).
\tag{1}
\]

The pairs are ordered. All sums use the right-continuous $n\le X$
endpoint convention.

## The one-sided criteria

Each of the following assertions, by itself, is equivalent to RH:

\[
\begin{array}{ll}
\text{lower:}&\displaystyle
S_\Lambda(X)\ge\frac{X^2}{2}-C_\varepsilon X^{3/2+\varepsilon},\\[2mm]
\text{upper:}&\displaystyle
S_\Lambda(X)\le\frac{X^2}{2}+C_\varepsilon X^{3/2+\varepsilon},
\end{array}
\quad\text{for every $\varepsilon>0$ and all sufficiently large $X$.}
\tag{2}
\]

The same separate equivalences hold with $S_{\rm even}$ in place of
$S_\Lambda$. In each line $C_\varepsilon$ and the starting point may
depend on $\varepsilon$. No one-sided estimate in (2) is proved
unconditionally here. This is a different formulation of the
established **two-sided** RH/Goldbach average theorem recorded by
[Bhowmik and Halupczok, Section 4](https://arxiv.org/pdf/1809.06920);
priority of the one-sided formulation is not asserted.

A single fixed exponent already gives a quantitative zero-free strip.
For $0\le\delta<1/2$, either one-sided bound in (2) with the error
$C X^{3/2+\delta}$ excludes zeros with
$\Re\rho>1/2+\delta$. The proof below uses the comparison
$A e^{\delta v}$, including the constant comparison when $\delta=0$.
The statement at $\delta=0$ is a sufficient condition, not a claimed
consequence of RH with this exact error exponent.

There is also an **unconditional** two-sided oscillation consequence:
for every $0<\eta<1/2$,

\[
\limsup_{X\to\infty}
 \frac{S_\Lambda(X)-X^2/2}{X^{3/2-\eta}}=+\infty,
\qquad
\liminf_{X\to\infty}
 \frac{S_\Lambda(X)-X^2/2}{X^{3/2-\eta}}=-\infty.
\tag{2a}
\]

The same conclusion holds for $S_{\rm even}$. The heat transform also
gives an endpoint $\Omega_\pm(X^{3/2})$ estimate with an explicit
(small) positive constant, proved below. Stronger Goldbach oscillation
bounds were established under RH by
[Mossinghoff and Trudgian](https://jtnb.centre-mersenne.org/item/10.5802/jtnb.1202.pdf);
no priority claim is made for the endpoint conclusion here.

## RH gives both inequalities

Let $\psi(x)=\sum_{n\le x}\Lambda(n)$ and
$E(x)=\psi(x)-x$. The exact ordered-convolution identity is

\[
S_\Lambda(X)=\sum_{a\le X}\Lambda(a)\psi(X-a)
=\int_0^X\psi(u)\,du
 +\sum_{a\le X}\Lambda(a)E(X-a).
\tag{3}
\]

Indeed $\sum_{a\le X}\Lambda(a)(X-a)=\int_0^X\psi(u)du$;
when $a=X$ that term is zero. Terms with $a=1$ or $b=1$ vanish
because $\Lambda(1)=0$. Under RH, the classical complete-power
estimate $E(x)=O_\varepsilon(x^{1/2+\varepsilon})$ holds for every
$\varepsilon>0$. Enlarging the constant on a bounded interval and
using $\psi(X)=O(X)$ gives

\[
\int_0^X\psi(u)du=\frac{X^2}{2}+O_\varepsilon(X^{3/2+\varepsilon}),
\quad
\left|\sum_{a\le X}\Lambda(a)E(X-a)\right|
\le\sup_{0\le u\le X}|E(u)|\,\psi(X)
=O_\varepsilon(X^{3/2+\varepsilon}).
\tag{4}
\]

Thus RH gives the two-sided estimate and hence either line of (2).

## Either one-sided inequality gives RH

Set $P(t)=\sum_{n\ge1}\Lambda(n)e^{-nt}$ for $t>0$. The complete
additive heat identity and Stieltjes integration by parts give

\[
P(t)^2=\sum_{n\ge1}R_\Lambda(n)e^{-nt}
=t\int_0^\infty e^{-tX}S_\Lambda(X)\,dX.
\tag{5}
\]

All ordered pairs and jump endpoints in (1) appear in (5). Fix
$0<\varepsilon<1/2$. The lower line of (2), after enlarging its
constant to cover bounded $X$, implies

\[
P(t)^2\ge t^{-2}
-C_\varepsilon\Gamma(5/2+\varepsilon)t^{-3/2-\varepsilon}.
\tag{6}
\]

Since $P(t)\ge0$, taking the positive square root for small $t$
gives $P(t)\ge t^{-1}-C'_\varepsilon t^{-1/2-\varepsilon}$.
The upper line gives, by the same identity and square root,
$P(t)\le t^{-1}+C'_\varepsilon t^{-1/2-\varepsilon}$.
The explicit baseline $P_0(t)=(1+t^{-1})e^{-t}=t^{-1}+O(t)$
therefore turns either line of (2) into one side of

\[
b(v)=e^{-v/2}\{P(e^{-v})-P_0(e^{-v})\}
=O_\varepsilon(e^{\varepsilon v})
\quad\text{in the corresponding one-sided sense.}
\tag{7}
\]

For completeness, this **one-sided subpower heat bound** already
implies RH. Suppose an off-critical zero $\rho$ has
$\beta=\Re\rho>1/2$, and choose
$0<\varepsilon<\min(\beta-1/2,1/2)$. From the lower version of (7),
$q(v)=b(v)+A_\varepsilon e^{\varepsilon v}$ is nonnegative for all
large $v$; from the upper version use
$q(v)=A_\varepsilon e^{\varepsilon v}-b(v)$. The unconditional PNT
error makes the tail Laplace convergence abscissa $\sigma\le1/2$.
The actual heat transform

\[
\widehat b(z)=\Gamma(z+\tfrac12)
\left[-\frac{\zeta'(z+\tfrac12)}{\zeta(z+\tfrac12)}
-\frac{z+\tfrac12}{z-\tfrac12}\right]
\tag{8}
\]

has a pole of residue $-m_\rho\Gamma(\rho)\ne0$ at
$z=\rho-1/2$, so $\sigma\ge\beta-1/2>\varepsilon$.
The transform of the positive exponential comparison has its only
real pole at $z=\varepsilon<\sigma$, and discarding the finite initial
history adds only an entire function. Hence the tail transform is
holomorphic at the real point $\sigma\in(\varepsilon,1/2]$:
$\zeta(s)<0$ for real $1/2<s<1$, and the apparent singularity at
$s=1$ cancels. This contradicts Landau's positive-Laplace theorem,
formalized abstractly in
[LandauSingularity.lean](BuildingBlocks/LandauSingularity.lean).
No zero can lie to the right of $1/2$; reflection gives RH. The actual
heat transform and this application of Landau are written analysis,
not Lean theorems. The uncentered additive heat square itself is
formalized in
[GoldbachPrimeHeatConvolution.lean](BuildingBlocks/GoldbachPrimeHeatConvolution.lean).
The finite ordered identity in (3), its exact discrete integral of
$\psi$, and the match to the existing shifted heat coefficient are
formalized in
[GoldbachCumulativeFinite.lean](BuildingBlocks/GoldbachCumulativeFinite.lean).
The infinite discrete Abel identity connecting that cumulative sum to
the actual positive prime heat square is formalized in
[GoldbachCumulativeAbel.lean](BuildingBlocks/GoldbachCumulativeAbel.lean).
The continuous Stieltjes integral, heat asymptotic and Landau
application remain written mathematics.

The same calculation proves (2a). If, for some $0<\eta<1/2$, either
one-sided bound
$S_\Lambda(X)-X^2/2\ge-CX^{3/2-\eta}$ or
$S_\Lambda(X)-X^2/2\le CX^{3/2-\eta}$ held eventually, (5) and a
positive square root would give the corresponding one-sided bound
$b(v)=O(e^{-\eta v})$. Add or subtract $A e^{-\eta v}$ to make a
nonnegative tail. A nontrivial zeta zero on the critical line exists
([DLMF §25.10](https://dlmf.nist.gov/25.10)), so its nonreal pole in
(8) forces the tail convergence
abscissa $\sigma\ge0$. The PNT bound gives $\sigma\le1/2$. The
exponential comparison has its real pole at $-\eta<\sigma$, while
(8) is regular at every real point of $[0,1/2]$. Landau again gives
a contradiction. Failure of each eventual one-sided bound for every
constant $C$ is exactly the two unbounded ratios in (2a).

## Oscillation at the critical endpoint

Choose any known critical-line zero $\rho=1/2+i\gamma$ of multiplicity
$m_\rho$ and put $A_\rho=m_\rho|\Gamma(\rho)|>0$. Then the actual
heat response satisfies

\[
\limsup_{v\to\infty}b(v)\ge A_\rho,
\qquad
\liminf_{v\to\infty}b(v)\le-A_\rho.
\tag{8a}
\]

Here is a direct positive-Laplace proof. Suppose $b(v)\le C$ on a
final half-line $v\ge V$. The nonnegative function $q(v)=C-b(v)$
there has transform

\[
Q_V(z)=\frac{Ce^{-Vz}}{z}-\widehat b(z)+H_V(z),
\tag{8b}
\]

where $H_V$ is entire: the negative-time heat response decays
superexponentially, and the remaining omitted interval is bounded.
The pole of (8) at $z=i\gamma$ has residue
$-m_\rho\Gamma(\rho)$, so (8b) has residue
$m_\rho\Gamma(\rho)$ there. The absolute convergence abscissa
$\sigma$ of $Q_V$ is finite and lies in $[0,1/2]$: the pole gives
$\sigma\ge0$, and the PNT bound gives $\sigma\le1/2$.
If $\sigma>0$, Landau would force a real singularity at $\sigma$,
but (8b) has none on $(0,1/2]$. Thus $\sigma=0$ and $Q_V(z)$ is
the genuine positive Laplace integral whenever $\Re z>0$.
Positivity gives $|Q_V(s+i\gamma)|\le Q_V(s)$ for $s>0$.
Multiply by $s$ and let $s\downarrow0$; the two Laurent limits are
$A_\rho$ and $C$, respectively, because $\widehat b$ is regular
at real $z=0$. Hence $C\ge A_\rho$. Applying the same argument to
$C+b(v)\ge0$ proves (8a). In particular the result is unconditional;
if RH is false, the stronger unbounded two-sided response oscillation
already follows from the one-sided criterion in the
[actual-response audit](actual-heat-renewal-cell-trace-audit.md).

The exact heat identity (5) transfers (8a) to the cumulative count.
Writing $D(X)=S_\Lambda(X)-X^2/2$ and
$H=\Gamma(5/2)=3\sqrt\pi/4$, an eventual bound
$D(X)\le cX^{3/2}$ gives

\[
P(t)^2-t^{-2}
=t\int_0^\infty e^{-tX}D(X)\,dX
\le cH t^{-3/2}+O(t).
\tag{8c}
\]

Since the unconditional PNT gives $tP(t)\to1$ and
$P_0(t)=t^{-1}+O(t)$, divide (8c) by $P(t)+t^{-1}$ and multiply
by $\sqrt t$ to obtain
$\limsup_{v\to\infty}b(v)\le cH/2$.
The lower bound transfers identically. Therefore

\[
\boxed{\displaystyle
\limsup_{X\to\infty}\frac{D(X)}{X^{3/2}}
\ge\frac{8A_\rho}{3\sqrt\pi}>0,
\qquad
\liminf_{X\to\infty}\frac{D(X)}{X^{3/2}}
\le-\frac{8A_\rho}{3\sqrt\pi}<0.}
\tag{8d}
\]

The odd-total correction is $O(X\log^2X)=o(X^{3/2})$,
so (8d) also holds with $S_{\rm even}(X)-X^2/2$ in place of $D(X)$.
The explicit constant here is a residue-transfer bound, not a claim
that it improves the stronger conditional oscillation constants in
the cited literature. The transform, Landau application, and limiting
heat transfer in this section remain written analysis, not Lean theorems.

## Even totals and ordinary Goldbach existence

The [exact odd-power formula](goldbach-even-only-cumulative-criterion.md)
gives
$0\le S_\Lambda(X)-S_{\rm even}(X)\le2X(\log X)^2$
for $X\ge3$. This is $o(X^{3/2+\varepsilon})$ for every
$\varepsilon>0$, so each one-sided assertion in (2) is equivalent to
the corresponding assertion for even totals, with the error absorbed
in its constant. This parity transfer retains odd prime powers; it
does not silently remove them.

Ordinary Goldbach existence gives a much smaller heat lower estimate.
If every even $n\ge4$ is a sum of two primes, then
$R_\Lambda(n)\ge(\log2)^2$ at those even $n$, hence

\[
P(t)^2\ge(\log2)^2\sum_{m\ge2}e^{-2mt}
=\frac{(\log2)^2}{2t}+O(1).
\tag{9}
\]

This direct consequence is only of order $t^{-1}$, whereas (6)
requires control around the $t^{-2}$ main term to reach the
RH-equivalent one-sided error. It does not rule out a different,
stronger implication from Goldbach existence; it identifies the gap
in this heat-transfer route.
