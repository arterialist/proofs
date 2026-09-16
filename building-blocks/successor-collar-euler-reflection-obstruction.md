# What Euler reflection does to the two-band successor collar

The [full even/odd collar matrix](successor-cell-even-odd-collar-full-matrix.md)
leaves one signed actual-prime entry \(D_X\). The
[complete-clock flux comparison](factorial-f-ground-flux-collar-direction-obstruction.md)
controls its square only from an **upper** energy bound; the known
energy floor has the opposite direction. This note tests whether
the full logarithmic Euler product and the zeta functional equation
cancel the two-band entry instead. They give an exact reflected
identity, but its two sides carry opposite poles at any off-line
zero. The reflected identity alone supplies no one-sided estimate
for \(D_X\).

Set \(h=\log2\) and
\[
 F(z)=\int_0^h e^{-zs/2}ds
     =\frac{2(1-2^{-z/2})}{z},\qquad F(0)=h.
 \tag{1}
\]
The triangular collar weight is
\(W=\mathbf1_{(0,h)}*\mathbf1_{(0,h)}\).
For real \(X>0\), define
\[
 D_X=\sum_{X/4<d<X}\frac{\Lambda(d)}{\sqrt d}
       W\!\left(\log\frac Xd\right)-F(1)^2\sqrt X,
 \qquad \mathcal D(z)=\int_0^\infty D_{e^{2a}}e^{-za}\,da.
 \tag{2}
\]
The density interpretation of the second term starts at \(X>4\);
the algebraic definition in (2) applies for all \(X>0\). From the
absolutely convergent full prime-power Euler series, initially
for \(\Re z>1\),
\[
 \mathcal D(z)=\frac12F(z)^2H\!\left(\frac{z+1}{2}\right)
                       -\frac{F(1)^2}{z-1},
 \qquad H(s)=-\frac{\zeta'}{\zeta}(s)
           =\sum_{p}\sum_{k\ge1}(\log p)p^{-ks}
           \quad(\Re s>1).
 \tag{3}
\]
The formula meromorphically continues \(\mathcal D\); it does
not continue the Euler series term by term.

## Exact reflected transform

Write \(\zeta(s)=\chi(s)\zeta(1-s)\), with
\(\chi(s)=2^s\pi^{s-1}\sin(\pi s/2)\Gamma(1-s)\).
The [zeta reflection formula](https://dlmf.nist.gov/25.4)
gives the meromorphic identity
\[
 H(s)+H(1-s)=-\frac{\chi'}{\chi}(s).
 \tag{4}
\]
The specific box profile obeys
\(F(-z)^2=2^zF(z)^2\). Substituting \(s=(z+1)/2\)
in (3)--(4) therefore gives
\[
 \boxed{\quad
 \mathcal D(z)+2^{-z}\mathcal D(-z)
 =-\frac12F(z)^2\frac{\chi'}{\chi}
                  \!\left(\frac{z+1}{2}\right)
   -\frac{F(1)^2}{z-1}
   +\frac{2^{-z}F(1)^2}{z+1}.
 \quad}                                                   \tag{5}
\]
This is an exact interaction of the two-band filter with the
functional equation. Its right side contains only gamma and
elementary pole terms.

The identity does not give two convergent prime expansions in one
strip. The Euler series for \(H(s)\) converges absolutely when
\(\Re s>1\); that for \(H(1-s)\) requires \(\Re s<0\).
These half-planes are disjoint. Likewise,
\(\mathcal D(-z)\) in (5) is a meromorphic continuation, not the
convergent Laplace integral of \(D_{e^{2a}}\) when \(\Re z>0\).
Taking absolute values in (5) merely replaces the unknown
\(\mathcal D(z)\) by the unknown reflected transform.

This failure is visible at each hypothetical off-line zero.
Let \(\rho=\beta+i\gamma\) be a zero of multiplicity \(m\), with
\(\beta>1/2\), and put \(z_\rho=2\rho-1\). Since
\(\Re z_\rho>0\), \(F(z_\rho)\ne0\). The transform
\(\mathcal D(z)\) has residue \(-mF(z_\rho)^2\) at
\(z=z_\rho\). Reflection sends \(\rho\) to \(1-\rho\);
as a function of \(z\), \(2^{-z}\mathcal D(-z)\) has
residue \(+mF(z_\rho)^2\) at the same point. They cancel
in (5). Thus regularity of the reflected combination cannot
rule out that zero or bound either summand.

## A real-space reflected-mode test

The same obstruction is quantitative at the actual dyadic kernel.
Fix any \(1/2<\beta<1\), \(\gamma>0\), and
\(\rho=\beta+i\gamma\). Consider the real, reflected quartet
\[
 E_\rho(x)=-2\operatorname{Re}\left(
       \frac{x^\rho}{\rho}
      +\frac{x^{1-\rho}}{1-\rho}\right),\qquad x>0.
 \tag{6}
\]
Use \(dE_\rho\) in place of the actual \(d(\psi(x)-x)\) in
the centered collar Stieltjes integral. Direct integration of the
triangular weight gives
\[
 D_\rho(X)=-2\operatorname{Re}\left[
       F(z_\rho)^2X^{z_\rho/2}
      +F(-z_\rho)^2X^{-z_\rho/2}\right].
 \tag{7}
\]
The first term has amplitude
\(2|F(z_\rho)|^2X^{\beta-1/2}\); the reflected term
decays as \(X^{1/2-\beta}\). Its phase advances by
\(\gamma\log X\), so \(D_\rho(X)\) has excursions of
both signs and unbounded size even when \(X\) is restricted
to even integers. In fact, rounding the real exponential
phase peaks to the nearest even \(X\) changes their phase by
\(O(X^{-1})\).

This mode also shows what source positivity alone can do:
\[
 \frac{d}{dx}\bigl(x+E_\rho(x)\bigr)
 =1-2\operatorname{Re}(x^{\rho-1}+x^{-\rho})>0
 \quad\text{for all sufficiently large }x.
 \tag{8}
\]
Thus a positive eventual continuous prime measure and a
reflected zero quartet do not imply a uniform collar bound.
The mode is a stress test, not an assertion that zeta has an
off-line zero or that \(E_\rho\) is the actual discrete
von Mangoldt source.

There is also a complete Euler-product stress test. Let
\(\xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)\)
and choose \(1/2<\theta<1\). Then
\[
 \Xi_\theta(s)=\xi(s)\xi(2s-\theta)\xi(2s-1+\theta)
 \quad\text{satisfies}\quad
 \Xi_\theta(s)=\Xi_\theta(1-s).
 \tag{9}
\]
Its arithmetic factor
\(Z_\theta(s)=\zeta(s)\zeta(2s-\theta)\zeta(2s-1+\theta)\)
has an absolutely convergent Euler product for \(\Re s>1\),
and every Dirichlet coefficient of its logarithmic prime-power
series is nonnegative:
\[
 -\frac{Z_\theta'}{Z_\theta}(s)
 =\sum_{p,k\ge1}(\log p)p^{-ks}
  +2\sum_{p,k\ge1}(\log p)
        \bigl(p^{k\theta}+p^{k(1-\theta)}\bigr)p^{-2ks}.
 \tag{10}
\]
For the rigorously located first critical zero
\(\rho_0=1/2+i\gamma_0\) used in the
[odd-collar theorem](successor-cell-odd-collar-triangular-prime-oscillation.md),
\(\Xi_\theta\) has a zero at
\(s=(\theta+\rho_0)/2\), whose real part exceeds \(1/2\).
So positive logarithmic Euler coefficients together with a
centered functional equation cannot, as abstract properties,
exclude off-line zeros. This model has additional subunit
poles in \(Z_\theta\), extra archimedean factors, and different
prime-power coefficients. It does not refute a proof that
uses the exact original \(\Lambda\) source and pole data.

The actual open input is still a signed all-cutoff upper
comparison for \(D_X\). Equations (5)--(10) identify why
reflection and coefficient positivity alone do not supply it;
no unconditional improvement over the known prime-error
bounds or full Weil sign is claimed. All calculations here
are written mathematics, not Lean formalizations.
