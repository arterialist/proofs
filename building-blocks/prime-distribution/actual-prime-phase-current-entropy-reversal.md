# The phase current in the actual prime-error entropy identity

The [zero-to-zero entropy identity](../factorial-and-renewal/full-f-zero-to-zero-reciprocal-ground-entropy-covariance.md)
is strictly negative without oscillatory weighting. This note shows exactly
what happens after a Mellin phase is introduced: the negative term persists
near frequency zero, while an additional phase current permits arbitrarily
large frequencies with the opposite sign. Every prime power in the source
is retained. The weights here differ from those in the Weil form, so this
is not an RH argument.

Put
\[
E(x)=\psi(x)-x,\qquad
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad r(x)=\frac{E(x)}{xF(x)}.
\]
Take \(1<a<b\) with continuous prime-error zeros at both ends:
\(E(a^-)=E(a)=E(b^-)=E(b)=0\). Set
\(H=\int_a^b r(x)^2dx>0\), \(L=b-a\), and, for \(c>0\),
\[
M_c(t)=\int_{[a,b)}\frac{(x/c)^{it}}{F(x)}\,dE(x),
\qquad J_c(t)=\int_a^b(x/c)^{it}r(x)\,dx.
\tag{1}
\]

**Theorem.** For every real \(t\),
\[
\boxed{M_c(t)=-\int_a^b(x/c)^{it}r(x)^2dx-itJ_c(t).}
\tag{2}
\]
In particular \(M_c(0)=-H\). For \(c=\sqrt{ab}\), write
\(\delta=\tfrac12\log(b/a)\). Then
\[
\Re M_c(t)\le-H+t^2\left(\frac{\delta^2H}{2}
                         +\delta\sqrt{HL}\right),
\tag{3}
\]
so \(\Re M_c(t)\le-H/2\) whenever
\[
t^2\le\frac1{\delta^2+2\delta\sqrt{L/H}}.
\tag{4}
\]
Yet, with \(A=\sum_{a\le n<b}\Lambda(n)/F(n)>0\),
\[
\boxed{\limsup_{t\to+\infty}\Re M_c(t)
 =\limsup_{t\to+\infty}|M_c(t)|
 =\limsup_{t\to+\infty}|tJ_c(t)|=A.}
\tag{5}
\]
Moreover, uniformly over continuous-zero intervals with \(a\to\infty\),
\[
\boxed{A/H\longrightarrow\infty.}
\tag{6}
\]
Thus neither \(\Re M_c(t)\) nor \(|tJ_c(t)|\) admits a universal
upper bound by a fixed multiple of the entropy \(H\) on all these
intervals and frequencies.

**Proof.** The factorial ground is continuous through prime-power atoms
and has derivative \(F'=-E/x^2\) almost everywhere. Hence the measure
product rule gives
\[
d(E/F)=F^{-1}dE+r^2dx.
\]
Multiply by \((x/c)^{it}\), integrate over \([a,b)\), and integrate
by parts. The stated zero conditions erase both endpoint terms,
giving (2).

For (3), put \(v=\log(x/c)\). Taking real parts of (2) yields
\[
\Re M_c(t)=-\int_a^b\cos(tv)r^2dx
                  +t\int_a^b\sin(tv)r\,dx.
\]
Use \(1-\cos y\le y^2/2\), \(|\sin y|\le|y|\), and Cauchy–Schwarz.
The centered choice of \(c\) makes \(|v|\le\delta\), proving (3)
and (4).

For (5), expand the signed measure:
\[
M_c(t)=\sum_{a\le n<b}\frac{\Lambda(n)}{F(n)}
 e^{it\log(n/c)}
 -\int_a^b\frac{e^{it\log(x/c)}}{F(x)}dx.
\tag{7}
\]
The integral tends to zero by the Riemann–Lebesgue lemma after
\(x=e^v\). Simultaneous recurrence of the finite real frequencies
\(\{\log(n/c):a\le n<b,\Lambda(n)>0\}\) supplies arbitrarily
large \(t\) for which every atomic phase approaches \(1\). This
requires no independence of the logarithms: approximate recurrence
follows from Dirichlet's pigeonhole argument, and an exact common
period, if present, can simply be repeated. Along that sequence
\(M_c(t)\to A\), while the triangle inequality in (7) bounds its
limsup modulus by \(A\). The first integral in (2) tends to zero
as well, so \(tJ_c(t)\) has the same limsup modulus.

The endpoint conditions give the exact conservation
\(\sum_{a\le n<b}\Lambda(n)=L\). Set
\(\epsilon_a=\sup_{x\ge a}|E(x)|/x\),
\(m_a=\inf_{x\ge a}F(x)\), and
\(B_a=\sup_{x\ge a}F(x)\). The prime number theorem and
\(F(x)\to\kappa_F>0\) give \(\epsilon_a\to0\) and
\(m_a,B_a\to\kappa_F\). Therefore
\[
A\ge L/B_a,
\qquad H\le\epsilon_a^2L/m_a^2,
\qquad A/H\ge\frac{m_a^2}{B_a\epsilon_a^2}\to\infty,
\]
proving (6). \(\square\)

There is a precise autocorrelation version of the sign reversal.
For \(f\in C_c^\infty(\mathbb R)\), put
\(C_f(\ell)=\int_{\mathbb R}f(y+\ell)\overline{f(y)}dy\) and
\[
Q^F_{a,b}[f]=\int_{[a,b)}\frac{C_f(\log x)}{F(x)}\,dE(x).
\]
Fix \(t>0\) and an even real \(\phi\in C_c^\infty(\mathbb R)\)
with \(\|\phi\|_2=1\). The odd functions
\(f_R(y)=\sqrt2R^{-1/2}\phi(y/R)\sin(ty)\) have norms tending
to \(1\), and their autocorrelations converge uniformly on every
compact shift set to \(\cos(t\ell)\). Consequently
\(Q^F_{a,b}[f_R]\to\Re M_1(t)\), which can be positive by (5)
despite the negative zero-frequency mass.

The limitation is essential: \(Q^F\) uses the reciprocal ground
\(F^{-1}\), whereas [Suzuki's odd Weil remainder](../weil-and-spectral/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md)
uses \(x^{-1/2}\) and is compensated by an archimedean log-frequency
form. Equations (2)–(6) identify the phase current missing from a
direct entropy-to-Weil transfer; they do not estimate the full Weil
form. Integration by parts, recurrence, and Riemann–Lebesgue are
classical. A targeted comparison did not locate this exact
actual-source combination; no priority claim is made.
