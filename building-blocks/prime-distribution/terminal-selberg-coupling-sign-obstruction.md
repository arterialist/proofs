# The terminal Selberg coupling has no eventual damping sign

**Status:** unconditional statement about the ordinary von Mangoldt function.
It rules out one proposed sign step in the terminal-mode argument; it does not
improve a prime-error bound or prove the Riemann hypothesis. No priority claim
is made for the underlying Mellin or oscillation methods.

Let \(\psi(x)=\sum_{n\le x}\Lambda(n)\), and, for real \(x\ge1\), set

\[
D(x)=\sum_{n\le x}(x-n)\Lambda(n)-\frac{x^2}{2},\qquad
M(x)=D(2x)-D(x),\qquad
C(X)=\sum_{a\le X}a\Lambda(a)M(X/a).
\tag{1}
\]

For integral \(X\), \(M(X)=\int_X^{2X}(\psi(t)-t)\,dt\) is exactly the
terminal mass in the [low-mode reduction](coarse-primitive-low-mode-fourier-reduction.md).
Its Selberg equation contains \(C(X)\) as the signed self-coupling term.

**Proposition.** As \(X\to\infty\) through positive integers,

\[
\frac{C(X)}{X^2}\longrightarrow
2\log2-\frac94-\frac32\gamma
=-1.7295291362324\ldots<0,
\tag{2}
\]

where \(\gamma\) is Euler's constant. Both \(M(X)>0\) and \(M(X)<0\)
hold for arbitrarily large integers \(X\). Consequently \(M(X)C(X)\)
has both signs infinitely often. In particular, the proposed eventual
damping condition \(M(X)C(X)\le0\) is false for the actual \(\Lambda\).

**Proof of the limit.** Write \(f(y)=M(y)/y^2\). The classical quantitative
prime number theorem \(\psi(y)-y=O(y e^{-c\sqrt{\log y}})\), with a possibly
smaller positive \(c\), gives \(f(y)=O(e^{-c\sqrt{\log y}})\). In particular
\(\int_1^\infty |f(y)|\,dy/y<\infty\), and the exact normalization is

\[
\frac{C(X)}{X^2}
=\sum_{a\le X}\frac{\Lambda(a)}a f(X/a).
\tag{3}
\]

On each fixed range \(1\le X/a\le A\), the weighted prime number theorem
turns (3) into \(\int_1^A f(y)\,dy/y\). This passage includes the endpoints:
\(M\) is continuous, and a single endpoint has harmonic \(\Lambda\)-mass
\(O(\log X/X)\). The tail is uniform in \(X\). Indeed, on the dyadic band
\(2^j A\le X/a<2^{j+1}A\), Chebyshev's estimate \(\psi(t)=O(t)\) gives
\(\sum\Lambda(a)/a=O(1)\), whereas the supremum of \(|f|\) on that band
is \(O(e^{-c'\sqrt{\log(2^jA)}})\). These bounds are summable in \(j\).
Thus (3) tends to

\[
I=\int_1^\infty M(y)y^{-3}\,dy.
\tag{4}
\]

For \(\Re s>1\), direct termwise integration gives

\[
F_D(s):=\int_1^\infty D(y)y^{-s-2}\,dy
=\frac{-\zeta'(s)/\zeta(s)}{s(s+1)}-\frac1{2(s-1)}.
\tag{5}
\]

The pole at \(s=1\) cancels. Since
\(-\zeta'/\zeta(s)=1/(s-1)-\gamma+O(s-1)\),
\(F_D(1)=-3/4-\gamma/2\). On \(1\le y<2\), \(D(y)=-y^2/2\), so
\(J(1):=\int_1^2D(y)y^{-3}dy=-\log2/2\). Changing variables in the
\(D(2y)\) part of (4) gives

\[
I=3F_D(1)-4J(1)=2\log2-\frac94-\frac32\gamma,
\]

which proves (2).

**Proof of the sign changes.** Put
\(J(s)=\int_1^2D(y)y^{-s-2}dy\), an entire function. The Mellin
transform of \(M\), initially for \(\Re s>1\), is

\[
F_M(s)=\int_1^\infty M(y)y^{-s-2}dy
=(2^{s+1}-1)F_D(s)-2^{s+1}J(s).
\tag{6}
\]

At a zeta zero \(\rho\) of multiplicity \(m\), its residue is
\(-m(2^{\rho+1}-1)/(\rho(\rho+1))\), which is nonzero when
\(0<\Re\rho<1\). A known critical-line zero therefore gives a nonreal
pole on \(\Re s=1/2\). In contrast, (6) is regular at every real
\(s\in[1/2,1]\): \(\zeta(s)<0\) for real \(0<s<1\), and the apparent pole
at \(1\) cancels in (5).

Suppose \(M(n)\ge0\) for every sufficiently large integer \(n\).
Between its finitely many breakpoints on each unit interval,
\(M'(y)=2\psi(2y)-\psi(y)-3y=O(y)\); continuity then implies
\(M(y)+Ky\ge0\) for all sufficiently large real \(y\), for some fixed
\(K\). The Mellin transform of \((M(y)+Ky)/y\) is \(F_M(s)+K/s\), up to
an entire contribution from an initial finite interval. Its real
abscissa of convergence lies in \([1/2,1]\): the quantitative prime
number theorem gives convergence at \(1\), while the nonreal pole in
(6) prevents convergence to the left of \(1/2\). [Landau's positivity
lemma](https://arxiv.org/html/2411.07436#S2) requires a singularity at
that *real* abscissa. Formula (6) and \(K/s\) have none on \([1/2,1]\),
a contradiction. The same argument applied to \(-M\) rules out eventual
nonpositivity. Integer sign changes follow as asserted.

The quantitative prime-number-theorem input is classical; for one
proof see [Green's prime-number notes](https://people.maths.ox.ac.uk/greenbj/papers/primenumbers.pdf).
The existence of a critical-line zero is recorded in
[DLMF §25.10](https://dlmf.nist.gov/25.10). The conclusion only rejects
the indicated damping sign. The RH-scale bound for \(M\) and the remaining
low Fourier modes are still open.
