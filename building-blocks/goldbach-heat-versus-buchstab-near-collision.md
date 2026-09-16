# Complete Lambda/Goldbach heat and the Buchstab near-collision covariance

This note audits whether the complete Mangoldt and additive heat identities
close the Type-I/friable relation

\[
 2\mathfrak C=\mathfrak F+\mathfrak B
 +O_\varepsilon(Y^{1+\varepsilon}|I|).
\]

They do not supply an additional signed row relation.  After exact
Möbius inversion, the complete-Lambda Hermitian form is the same
two-Möbius local covariance with extra dilation variables.  Recovering the
undilated Möbius row requires a nonlocal, unstable inverse of convolution
by \(\log\).

## 1. What the requested identity is exactly

With the notation of the Buchstab reduction,

\[
 S_Y=F_{Y,z}-B_{Y,z}+E_{Y,Z}.
\]

Therefore, without an inequality,

\[
\boxed{
 2\mathfrak C(Y,z;I)=\mathfrak F(Y,z;I)+\mathfrak B(Y,z;I)
 -\int_I|S_Y(\phi)-E_{Y,Z}(\phi)|^2\,d\phi.}           \tag{1}
\]

Since \(E_{Y,Z}\) is negligible, removing the \(|I|\) loss is exactly the
localized Möbius estimate

\[
 \int_I|S_Y(\phi)|^2d\phi
 \ll_\varepsilon Y^{1+\varepsilon}|I|.                \tag{2}
\]

Thus an additive-source identity helps only if it transfers its positive
energy to (2) with a local, uniformly bounded inverse.

## 2. Exact complete-Lambda dilation identity

Put

\[
 S_Y(\phi)=\sum_{d\ge1}\mu(d)e^{-d/Y}e^{id\phi},
 \qquad
 A_Y(\phi)=\sum_{n\ge1}\Lambda(n)e^{-n/Y}e^{in\phi}.
\]

The full divisor identity \(\Lambda=\mu*\log\) gives

\[
\boxed{
 A_Y(\phi)=\sum_{r\ge2}(\log r)
 S_{Y/r}(r\phi).}                                     \tag{3}
\]

Every prime square and higher prime power is retained in (3).  There is
no \(r=1\) term because \(\log1=0\).

Squaring (3) on the actual arc gives

\[
\boxed{\begin{aligned}
 \int_I|A_Y(\phi)|^2d\phi
 ={}&\sum_{d,e\ge1}\mu(d)\mu(e)
 \sum_{r,s\ge2}(\log r)(\log s)e^{-(dr+es)/Y}\\
 &\qquad\qquad\times K_I(dr-es),
\end{aligned}}                                        \tag{4}
\]

where \(K_I(v)=\int_Ie^{iv\phi}d\phi\).  Formula (4) is
the same signed two-Möbius near-collision kernel as the Buchstab
covariance, with the additional complete dilation pair \((r,s)\).
Goldbach coefficients are its additive companion:

\[
 [z^N]A(z)^2
 =\sum_{dr+es=N}\mu(d)\mu(e)(\log r)(\log s).          \tag{5}
\]

Thus the complete Goldbach identity retains all powers but changes the
constraint from the difference \(dr-es\) in (4) to the antidiagonal
\(dr+es=N\) in (5).  It does not impose a sign on a fixed local
near-collision row.

The additive heat form likewise reads

\[
 \int_0^\infty|A_t|^2dt
 =\sum_{d,e}\mu(d)\mu(e)
   \sum_{r,s\ge2}\frac{(\log r)(\log s)}{dr+es},       \tag{6}
\]

up to the chosen radial normalization.  It is again the dilated
two-Möbius covariance, now integrated against a positive sum kernel.

## 3. Density, pole, and origin terms

For the actual centered source write

\[
 A_Y^\circ=A_Y-D_Y-O_Y,
\]

where \(D_Y\) is the exact density integral and \(O_Y\) is the origin
atom used in the source definition.  Then

\[
 \|A_Y^\circ\|_I^2
 =\|A_Y\|_I^2+|D_Y+O_Y\|_I^2
 -2\operatorname{Re}\langle A_Y,D_Y+O_Y\rangle_I.     \tag{7}
\]

Equations (3)--(4) remain exact in the first and mixed terms.  The
density and origin add deterministic one-Möbius rows; they do not create
the missing \(r=s=1\) two-Möbius coefficient.  Hence retaining them does
not turn (4) into (2).  Dropping them would be incorrect, but including
them leaves the inversion issue unchanged.

## 4. The local divisor identity is tautological on a large-prime packet

For \(p>z\), \(m<z<p\), and \(m>1\), complete Lambda gives

\[
 0=\Lambda(pm)=\sum_{d\mid pm}\mu(d)\log(pm/d).        \tag{8}
\]

Splitting divisors as \(d\mid m\) and \(pd\mid pm\), and using
\(\mu(pd)=-\mu(d)\), the two sums cancel exactly; the remaining
\((\log p)\sum_{d\mid m}\mu(d)\) is zero.  Thus (8) only rederives the
Buchstab sign.  It gives no relation between \(pm\) and a distinct
friable integer \(n\) selected by \(K_I(n-pm)\).

For \(m=1\), (8) is \(\Lambda(p)=\log p\), which supplies the prime
weight but still no neighboring friable sign.  Selberg symmetrization
sums identities of the form (8) and therefore cannot manufacture the
missing near-collision relation.

## 5. Why inversion loses locality

In Dirichlet-series coordinates, (3) is multiplication by

\[
 \sum_{r\ge1}\frac{\log r}{r^s}=-\zeta'(s),
\]

so formally recovering the Möbius series from the Mangoldt series uses

\[
 \frac{1/\zeta(s)}{-\zeta'(s)/\zeta(s)}=-\frac1{\zeta'(s)}. \tag{9}
\]

No zero-free or boundedness statement for this inverse is available in
the needed strip, and assuming one would insert a new analytic premise.
At the finite arithmetic level the same problem is visible without
complex analysis: convolution by \(\log\) has value zero at the identity,
so it is not invertible in the causal Dirichlet-convolution algebra.

One may expose \(\mu(n)\) from the future coefficient \(\Lambda(2n)\):

\[
 \mu(n)\log2=\Lambda(2n)
 -\sum_{\substack{d\mid2n\\d\ne n}}
      \mu(d)\log(2n/d).                               \tag{10}
\]

All divisors in the last sum are earlier than \(n\), but the observation
is at the future endpoint \(2n\).  On Fourier arcs, extracting the even
coefficients of \(A_{2Y}(\phi/2)\) is a nonlocal projection.  It has no
uniform local-arc contraction estimate, so (10) does not transfer the
Goldbach heat bound to (2).

## 6. Exact remaining statement

Substitution of complete Lambda into the Goldbach or heat energy yields
(4)--(7), not a cancellation of the Buchstab covariance.  Any claimed
bridge removing \(|I|\) must therefore prove a local inverse estimate of
the form

\[
 \|S_Y\|_{L^2(I)}^2
 \le C\|A_{cY}^\circ\|_{\mathcal H(I')}^2
 +O_\varepsilon(Y^{1+\varepsilon}|I|),                \tag{11}
\]

with the future dilation, density, origin, and arc projection all
explicit.  Equations (3), (9), and (10) show that no such estimate follows
from the algebraic identities alone.

Thus the complete additive identities reduce back to the same signed
two-Möbius local covariance: in the Buchstab coordinates it is
\(K_I(n-pm)\); in the complete-Lambda coordinates it is
\(K_I(dr-es)\).  A new local inverse or a direct signed covariance bound
is still required.  No generic dispersion estimate is duplicated here.
