# The completed Suzuki curvature changes sign arbitrarily late

The coefficient identity \(c''_0=4\Lambda*\Lambda\) does not give a
one-sided second variation of Suzuki's arithmetic Hankel kernel. In
fact, the second variation of the **completed** kernel takes both
signs arbitrarily far out. The gamma and pole terms are essential to
this statement. It is a constraint on a proposed proof mechanism, not
a counterexample to positivity at any fixed \(\omega>0\) or a proof
of RH.

Use [Suzuki's definitions (A.1)--(A.2) and Mellin identity
(A.4)](https://arxiv.org/html/1204.1827v2), and put
\[
 k_\omega(t)=g_\omega^{\langle1\rangle}(t),\qquad
 R_\omega(x)=\sqrt{x}h_\omega^{\langle1\rangle}(x)
   =x^{-1/2}\sum_{n<x}c_\omega(n)k_\omega(n/x),
 \qquad c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega}).
 \tag{1}
\]
The endpoint term is zero for positive \(\omega\). For a fixed
\(x>1\) outside the integers, the finite sum and the incomplete-beta
formula continue analytically through \(\omega=0\). Define
\(r_j(x)=\left.\partial_\omega^jR_\omega(x)\right|_{\omega=0}\).
Write \(\gamma_\xi(u)=\tfrac12u(u-1)\pi^{-u/2}\Gamma(u/2)\),
\(\xi=\gamma_\xi\zeta\), and
\(q(s)=\xi'(\tfrac12+s)/\xi(\tfrac12+s)\).

**Theorem.** For every \(X>1\) there are nonintegral \(x_+,x_->X\)
such that \(r_2(x_+)>0\) and \(r_2(x_-)<0\). More precisely, for
each prime power \(m=p^k\),
\[
 r_2(x)=\frac{4\Lambda(m)}{\sqrt m}
          \log\!\left(1-\frac m x\right)+O_m(1)
          \longrightarrow-\infty\qquad(x\downarrow m).
 \tag{2}
\]
The complete Laplace transform, initially on a sufficiently far
right half-plane, is
\[
 \int_1^\infty r_2(x)x^{-s-1}\,dx
     =\frac{4q(s)^2}{s}.
 \tag{3}
\]
For comparison, the first variation has transform \(-2q(s)/s\).
In the half-plane \(u=s+1/2>1\), the numerator in (3) is
\[
 4q(s)^2=4\left[
   \sum_{n\ge2}\frac{(\Lambda*\Lambda)(n)}{n^u}
  -2\frac{\gamma_\xi'(u)}{\gamma_\xi(u)}
       \sum_{n\ge2}\frac{\Lambda(n)}{n^u}
  +\left(\frac{\gamma_\xi'(u)}{\gamma_\xi(u)}\right)^2
  \right].                                                   \tag{4}
\]
The apparent pole at \(u=1\) cancels in \(q\). The two mixed and
gamma-only terms in (4) are part of the actual kernel, so the
nonnegative multiplicative \(\Lambda*\Lambda\) term alone cannot
determine its sign.

To prove (2), the incomplete-beta formula has the locally uniform
endpoint expansion, for \(\omega\) near zero and \(t\uparrow1\),
\[
 k_\omega(t)=
 \frac{(2\pi)^\omega}{\Gamma(1+\omega)}
 (1-t)^\omega\bigl(1+O(1-t)\bigr).
 \tag{5}
\]
One can obtain it directly by integrating Suzuki's formula for
\(g_\omega\): its first term is
\((2\pi)^\omega\Gamma(\omega)^{-1}(1-y)^{\omega-1})
times an analytic factor tending to one at \(y=1\); the remaining
term has one extra power of \(1-y\). Thus
\(k_0(t)=t^{-1/2}\) in the interior and
\(k'_0(t)=\log(1-t)+O(1)\) at the right endpoint. The [finite
coefficient identities](suzuki-coefficient-prime-history-variation.md)
give \(c'_0(m)=2\Lambda(m)\). The arriving prime power's term in the
second derivative of (1) is therefore
\(4\Lambda(m)k'_0(m/x)/\sqrt{x}\). All earlier terms stay bounded
as \(x\downarrow m\), proving (2).

For completeness, away from integer endpoints the whole real-space
curvature is
\[
 r_2(x)=\frac{k''_0(1/x)}{\sqrt x}
 +\frac4{\sqrt x}\sum_{2\le n<x}\Lambda(n)k'_0(n/x)
 +4\sum_{2\le n<x}\frac{(\Lambda*\Lambda)(n)}{\sqrt n}.
 \tag{6}
\]
The logarithmic endpoint singularities in (6) are locally
integrable. The beta formula and the elementary coefficient bounds
give absolute convergence of its Laplace integral sufficiently far
right. There, one may differentiate Suzuki's Mellin identity
\[
 \int_1^\infty R_\omega(x)x^{-s-1}\,dx
 =\frac1s\frac{\xi(s+1/2-\omega)}{\xi(s+1/2+\omega)}
 \tag{7}
\]
twice. To justify differentiation at the endpoint parameter, first
continue the finite beta formula to a small complex neighborhood of
zero and take \(\Re s\) large; its power growth at \(t=0\) and
integrable logarithmic behavior at \(t=1\) provide a common
majorant. The logarithm of the ratio in (7) is odd in \(\omega\),
so its second derivative at zero is the square of its first,
\(4q(s)^2\). This proves (3), retaining the completed gamma and
pole contribution.

It remains to show the positive values arbitrarily late. Suppose
instead that \(r_2(x)\le0\) for all sufficiently large nonintegral
\(x\). The tail of \(-r_2(e^y)\) is a nonnegative, locally
integrable function with a finite Laplace convergence abscissa
\(\sigma\); the initial compact interval contributes an entire
function. The transform in (3) has a double pole at
\(s=i\gamma\ne0\) for each zero \(\xi(1/2+i\gamma)=0\), of any
multiplicity. The classical existence of critical-line zeros
([DLMF, §25.10(i)](https://dlmf.nist.gov/25.10.i)) therefore forces
\(\sigma\ge0\). On the other hand,
\(4q(s)^2/s\) is holomorphic at every real \(s>0\), since \(\xi\)
has no real zeros there, and also at \(s=0\), since the functional
equation gives \(q(0)=0\) and \(\xi(1/2)\ne0\).
[Landau's theorem for nonnegative Laplace transforms](https://arxiv.org/html/1204.1827v2)
forces a real singularity at the finite abscissa \(\sigma\), a
contradiction. The repository's
[positive-measure Landau theorem](BuildingBlocks/LandauSingularity.lean)
formalizes the general analytic principle, but this application to
Suzuki's curvature is a written proof, not a Lean theorem.

The conclusion concerns \(\partial_\omega^2R_\omega|_0\), rather
than \(R_\omega\) at a fixed positive parameter. In particular,
the factor \((1-m/x)^\omega\) in (5) makes the Taylor expansion
nonuniform as \(x\downarrow m\); the negative divergence in (2)
cannot be used to disprove the still-open uniform positive-parameter
[Hankel sign target](suzuki-hankel-uniform-sign-target.md).
