# Suzuki's first variation is a weighted prime-power clock

The first parameter derivative of [Suzuki's arithmetic Hankel kernel](https://arxiv.org/html/1204.1827v2) has an explicit real-space form. It keeps the complete gamma and pole correction beside every prime power and turns the usual Chebyshev error criterion for RH into a growth criterion for one completed variation. This is a source identification and an equivalent target, not an unconditional bound or an RH proof.

For \(x>1\) outside the integers, write
\[
R_\omega(x)=\sqrt{x}\,h_\omega^{\langle1\rangle}(x)
 =\frac1{\sqrt x}\sum_{n<x}c_\omega(n)k_\omega(n/x),
\quad
k_\omega=g_\omega^{\langle1\rangle},
\quad
r_1(x)=\left.\partial_\omega R_\omega(x)\right|_0.
\tag{1}
\]
The finite coefficient variation \(c'_0(n)=2\Lambda(n)\) is
[compiled in Lean](BuildingBlocks/SuzukiCoefficientVariation.lean).
For fixed \(0<t<1\), \(k_0(t)=t^{-1/2}\). Differentiating the finite
sum gives
\[
r_1(x)=\frac{k'_0(1/x)}{\sqrt x}
       +2\sum_{2\le n<x}\frac{\Lambda(n)}{\sqrt n}.
\tag{2}
\]
The strict cutoff matters: at integer \(x=n\), the arriving term
has \(k_\omega(1)=0\) for every positive \(\omega\). After
differentiation at zero, its limit as \(x\downarrow n\) from above
is \(2\Lambda(n)/\sqrt n\). The parameter derivative and that
endpoint limit do not commute.

## The completed gamma correction

Expanding [Suzuki's incomplete-beta formula (A.1)](https://arxiv.org/html/1204.1827v2)
at \(\omega=0\) gives the exact derivative
\[
k'_0(t)=-\frac4t+
\frac1{\sqrt t}\left[
4+\log\pi+\gamma+\log(1-t^2)
+\int_{t^2}^1\frac{u^{1/4}-1}{1-u}\,du
\right],
\qquad 0<t<1,
\tag{3}
\]
where \(\gamma\) is Euler's constant. Here is the expansion with
normalizations shown. The prefactor of Suzuki's first complementary
beta term is \(-4\omega^2+O(\omega^3)\), and that beta integral is
\(\omega^{-1}+O_t(1)\); together they contribute
\(-4\omega/t\). The prefactor of the second term is
\(\omega+\omega^2(4+\log\pi+\gamma)+O(\omega^3)\).
Its beta integral is
\[
\frac1\omega+\log(1-t^2)
+\int_{t^2}^1\frac{u^{1/4}-1}{1-u}\,du+O_t(\omega).
\]
This proves (3) without dropping the gamma term.

Define
\[
\kappa=\gamma+\frac{\pi}{2}+\log(8\pi),
\qquad
J(x)=\int_0^{x^{-2}}\frac{u^{1/4}}{1-u}\,du.
\tag{4}
\]
The substitution \(u=v^4\) and partial fractions give
\(\int_0^1(u^{1/4}-1)/(1-u)\,du
=-4+\pi/2+3\log2\). Substituting \(t=1/x\) into (3)
therefore gives
\[
\boxed{\quad
r_1(x)=
2\sum_{2\le n<x}\frac{\Lambda(n)}{\sqrt n}
-4\sqrt x+\kappa-J(x).
\quad}
\tag{5}
\]
For \(x\ge2\), \(0<J(x)\le(16/15)x^{-5/2}\).
Thus the entire completed archimedean contribution beyond
\(-4\sqrt x\) is a bounded constant with a decaying positive
correction. Equation (5) retains all prime powers, the literal
integer cutoff, and the completed gamma and pole terms.

## The resulting RH criterion

Let \(S(x)=\sum_{2\le n<x}\Lambda(n)/\sqrt n\). Since
\(\kappa-J(x)=O(1)\), equation (5) makes
\(r_1(x)=O_\varepsilon(x^\varepsilon)\) for every
\(\varepsilon>0\) equivalent to
\[
S(x)=2\sqrt x+O_\varepsilon(x^\varepsilon)
\quad\text{for every }\varepsilon>0.
\tag{6}
\]
This is exactly the critical-scale weighted Chebyshev error.
Abel summation, with the cutoff approached from nonintegral \(x\),
gives
\[
S(x)=\frac{\psi(x^-)}{\sqrt x}
 +\frac12\int_1^x\frac{\psi(y)}{y^{3/2}}\,dy,
\qquad
\psi(x^-)=\sqrt x\,S(x)
 -\frac12\int_1^x\frac{S(y)}{\sqrt y}\,dy.
\tag{7}
\]
The first identity transfers
\(\psi(x)-x=O_\varepsilon(x^{1/2+\varepsilon})\) to (6);
the second transfers (6) back to that bound on \(\psi-x\).
The jumps \(\Lambda(n)/\sqrt n\ll(\log n)/\sqrt n\)
let either bound pass across integer endpoints.
The standard Mellin identity for \(-\zeta'/\zeta\) then makes
the all-\(\varepsilon\) Chebyshev bound equivalent to the full RH.

In fact the classical RH bound
\(\psi(x)-x=O(\sqrt x\log^2x)\), available for example in
[Schoenfeld's original paper](https://doi.org/10.1090/S0025-5718-1976-0457374-X),
gives \(S(x)-2\sqrt x=O(\log^3x)\) by (7).
Conversely \(r_1(x)=O(\log^3x)\) implies (6), and hence RH.
Therefore, on nonintegral \(x\to\infty\),
\[
\boxed{\quad
\mathrm{RH}
\ \Longleftrightarrow\
 r_1(x)=O(\log^3x)
\ \Longleftrightarrow\
 \forall\varepsilon>0,\ r_1(x)=O_\varepsilon(x^\varepsilon).
\quad}
\tag{8}
\]
The [completed-variation sign theorem](suzuki-completed-curvature-sign-obstruction.md)
already shows unconditionally that \(r_1\) takes both signs
arbitrarily far out. That does not establish either growth bound
in (8). The Lean coefficient and prefix derivatives cover the
finite arithmetic part of (1)--(2); the incomplete-beta
derivative, (5), and the analytic equivalence (8) remain written
mathematics.
