# The alternating Goldbach cofactor has a positive Abel main term

The even and odd signed-cofactor coefficients each have unbounded
positive and negative excursions. Their *difference as Abel sums*,
however, has an explicit positive main term. This is a parity law for
the actual von Mangoldt function, including every prime power; it is
not a pointwise sign or an RH-scale bound.

Put $E_y=\psi(y)-y$, $q_y=E_y/y$, and

\[
P(z)=\sum_{n\ge1}\Lambda(n)z^n,
\qquad A(z)=\sum_{y\ge1}q_yz^y,
\qquad A_2(z)=\sum_{y\ge2}q_yz^y=A(z)+z.
\tag{1}
\]

The last equality keeps $q_1=E_1=-1$. The exact additive
convolution is $F(z)=P(z)A_2(z)=\sum_{s\ge4}Q_sz^s$ for $|z|<1$.
For real $r\uparrow1$, write $h=1-r$. We prove

\[
\boxed{P(-r)\sim-\frac1h,\qquad
A_2(-r)\sim-\frac12\log\frac1h,\qquad
F(-r)\sim\frac1{2h}\log\frac1h.}
\tag{2}
\]

## The even prime-power row

The only even integers with nonzero von Mangoldt weight are
$2^k$, $k\ge1$, and each has weight $\log2$. Thus

\[
P_{\rm even}(r):=
\sum_{\substack{n\ge1\\n\ \mathrm{even}}}\Lambda(n)r^n
=(\log2)\sum_{k\ge1}r^{2^k},
\qquad P(-r)=2P_{\rm even}(r)-P(r).
\tag{3}
\]

The finite version of (3), including the exact power-of-two
cutoff $k\le\lfloor\log_2N\rfloor$, is compiled in
[GoldbachCofactorOddStepFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean).
Absolute convergence permits the infinite limit for $r<1$.

Take $K=\lceil\log_2(1/h)\rceil$. The first $K$ terms of the
lacunary sum are at most $K$. For $k>K$,
$r^{2^k}\le e^{-h2^k}\le e^{-2^{k-K}}$, so its tail is bounded
by a fixed convergent series. Consequently
$P_{\rm even}(r)=O(\log(1/h))=o(h^{-1})$.

PNT gives $\psi(N)\sim N$. Finite Abel summation followed by
$N\to\infty$ gives

\[
P(r)=(1-r)\sum_{N\ge1}\psi(N)r^N\sim h^{-1},
\tag{4}
\]

because $h^2\sum_{N\ge1}Nr^N=r\to1$. Combining (3) and
(4) proves the first limit in (2). No odd prime or proper
prime power is removed from $P$.

## The centered source fixes the sign and coefficient

Let $a_n=\Lambda(n)-1$ for $n\ge1$ and
$D(z)=\sum_{n\ge1}a_nz^n=P(z)-z/(1-z)$.
Since $E_y=\sum_{n=1}^ya_n$, the endpoint-corrected Abel
identity gives

\[
(1-z)\sum_{y\ge1}E_yz^y=D(z),\qquad
A'(z)=\frac{D(z)}{z(1-z)}\quad(0<|z|<1).
\tag{5}
\]

These series and their derivatives converge locally uniformly in
the unit disk. The finite Abel identity, including its terminal
atom, is compiled in
[GoldbachCofactorVolterraFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorVolterraFinite.lean);
the convergent cofactor product is compiled in
[GoldbachCofactorParitySeries.lean](../../formalization/BuildingBlocks/GoldbachCofactorParitySeries.lean).

Set $B(r)=A(-r)$. The first limit in (2) and (5) give

\[
B'(r)=\frac{D(-r)}{r(1+r)}
\sim-\frac1{2(1-r)},
\qquad D(-r)=P(-r)+\frac r{1+r}.
\tag{6}
\]

Integrating (6) from any fixed $r_0\in(0,1)$ shows
$B(r)\sim-\tfrac12\log(1/h)$. Since $A_2(-r)=B(r)-r$,
the second limit in (2) follows. Multiplication by the first
limit gives the positive main term for $F(-r)$.

Equivalently, with $r=e^{-t}$,

\[
\boxed{F(-e^{-t})\sim\frac{1}{2t}\log\frac1t}
\qquad(t\downarrow0).
\tag{7}
\]

The exact parity projections therefore have
$F_{\rm even}(r)-F_{\rm odd}(r)=F(-r)>0$ for all $r$
sufficiently close to one. This is a sign for a weighted
*difference of parity sums*, not for individual $Q_s$.
The term in (7) is $o(t^{-1-\theta})$ for every fixed
$\theta>0$, so it does not suppress the zero-driven excursions
used in the [parity oscillation proof](goldbach-signed-cofactor-parity-oscillation.md).

The power-of-two identity and finite source identities are
Lean-compiled with standard axioms. PNT, the boundary integration
and the asymptotics (2) and (7) are written analysis. They provide
an unconditional global parity phase law, not a uniform bound on
$Q_s$ or a proof of RH.
