# Finite constrained Gram certificate scheme for the coherent radius-two port

The endpoint analysis reduces the surviving inequality

\[
 Q(Bx,Bx)\le E_C[x]-\alpha _2\|x\|^2,
 \qquad x\in\mathcal K_{\rm ev},                         \tag{1}
\]

to a compact spectral calculation. This note gives a complete finite
certificate scheme: an explicit constrained spline construction, exact matrix
entries retaining the continuous kernel and every prime power, a complement
tail bound, and the generalized eigenvalue test that proves (1).

No numerical certificate is claimed. The killed-ground and constrained
spectral interval data needed to run the test have not yet been produced.

## 1. An exact constrained basis from even splines

Choose a rational mesh

\[
 0=t_0<t_1<\cdots<t_M=2.                                \tag{2}
\]

Let \(h_1,\ldots,h_m\) be the even extensions of the standard continuous
piecewise-linear hat functions on this mesh. Cubic B-splines may replace
them without changing the certificate. These functions are Lipschitz and
belong to the actual killed core form domain. Their endpoint values are not
forced to vanish; the hard-boundary killing is part of the form.

On the real even sector, list the independent constraint rows

\[
 \mathcal L_1x=\langle x,1_C\rangle,\qquad
 \mathcal L_2x=\langle x,a_c\rangle,\qquad
 \mathcal L_{2+j}x=(Jx)_j.                               \tag{3}
\]

If an observation component is complex, include its real and imaginary
parts as separate real rows. Select smooth even interior splines
\(g_1,\ldots,g_r\) such that

\[
 D_{\ell k}=\mathcal L_\ell(g_k)                         \tag{4}
\]

is invertible. A rigorous interval implementation must certify a positive
lower bound for the smallest singular value of \(D\). Define

\[
 z_k=\sum_q g_q(D^{-1})_{qk},\qquad
 \phi_j=h_j-\sum_{\ell=1}^r\mathcal L_\ell(h_j)z_\ell.   \tag{5}
\]

Then \(\mathcal L_\ell(z_k)=\delta_{\ell k}\) and every
\(\phi_j\) lies in \(\mathcal K_{\rm ev}\) exactly. Formula (5) applies the
common affine subtraction before any Gram entry is formed.

Discard exact linear dependencies among the \(\phi_j\). The resulting
space \(V_N\subset\mathcal K_{\rm ev}\) is the finite trial space.

## 2. Exact mass and killed-energy entries

Let \(\widetilde\phi_j\) denote the zero extension of \(\phi_j\) outside
\(C=[-2,2]\). Define

\[
 M_{ij}=\int_C\phi_j(v)\overline{\phi_i(v)}\,d\nu(v).     \tag{6}
\]

The continuous killed matrix is

\[
 K^{\rm c}_{ij}
 =\frac12\iint_{\mathbb R^2}
  [\widetilde\phi_j(v)-\widetilde\phi_j(u)]
  \overline{[\widetilde\phi_i(v)-\widetilde\phi_i(u)]}
  r(|u-v|)\Phi(u)\Phi(v)\,du\,dv.                        \tag{7}
\]

Zero extension makes (7) include the two core-to-exterior killing collars.
No boundary term is added afterward.

The complete arithmetic matrix is

\[
 \begin{aligned}
 K^{\rm p}_{ij}
 =\frac12\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \sum_{\sigma=\pm1}\int_{\mathbb R}
 &[\widetilde\phi_j(u+\sigma\log n)-\widetilde\phi_j(u)]\\
 {}\times&
 \overline{[\widetilde\phi_i(u+\sigma\log n)
                    -\widetilde\phi_i(u)]}
 \Phi(u)\Phi(u+\sigma\log n)\,du .
                                                               \tag{8}
 \end{aligned}
\]

The factor \(1/2\) compensates for the two directed orientations. Formula
(8) retains internal lines, departure lines, both orientations, and every
proper prime power. Set

\[
 K_N=K_N^{\rm c}+K_N^{\rm p},\qquad
 A_N=K_N-\alpha _2M_N.                                  \tag{9}
\]

The diagonal singularity in (7) is interval-enclosable. On each pair of
spline cells, subtract the first-order difference before dividing by
\(|u-v|\); the remainder is continuous. Cell pairs away from the diagonal
use ordinary interval quadrature. The theta series for \(\Phi\) and its
derivatives can be truncated with the published exponential tail.

For (8), compute \(n\le N_{\rm p}\) directly. The uniform all-power theta
tail bounds the remainder, using \(\Lambda(n)\le\log n\). No prime-only
asymptotic replaces this tail.

## 3. Exact coherent port entries

For every constrained basis function,

\[
 \begin{aligned}
 (B\phi_j)(u)=\frac1{b(u)}\bigg[
 &\int_C r(|u-v|)\Phi(v)\phi_j(v)\,dv\\
 &+\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
   \sum_{\sigma=\pm1}
   1_C(u+\sigma\log n)
   \Phi(u+\sigma\log n)\phi_j(u+\sigma\log n)
 \bigg].
                                                               \tag{10}
 \end{aligned}
\]

Define the full port Gram

\[
 P_{ij}
 =\frac1a\int_O\frac{\psi _2(u)}{\rho(u)}
       (B\phi_j)(u)\overline{(B\phi_i)(u)}\,d\nu(u).      \tag{11}
\]

The sum in (10) occurs before multiplication in (11). Thus (11) retains:

* continuous-continuous covariance;
* both continuous-prime mixed terms;
* prime-prime covariance between distinct powers and orientations;
* crossings from both hard boundaries; and
* the exact ground normalization \(a=\int_O\rho\psi _2d\nu\).

An interval evaluation truncates the theta series, the exterior
\(u\)-integral, and the prime sum only after forming the coherent columns.
The weighted crossing estimates give explicit tails for all three
truncations. A validated enclosure of \(\psi _2\), including its
normalization, is still required.

## 4. Canonical constrained spectral coordinates

For the clean complement theorem, let
\(e_1,e_2,\ldots\) be the exact \(L^2(C,\nu)\)-orthonormal eigenbasis of the
killed form restricted to \(\mathcal K_{\rm ev}\):

\[
 E_C(e_j,y)=\lambda_j\langle e_j,y\rangle
 \quad(y\in\mathcal K_{\rm ev}),\qquad
 \lambda_1\le\lambda_2\le\cdots.                         \tag{12}
\]

The compact core embedding gives \(\lambda_j\to\infty\). The spline matrices
(6)--(9), the constraint projection (5), and a validated
Galerkin-residual/separation theorem enclose the exact spectral projector
onto \(e_1,\ldots,e_N\), the eigenvalues through \(\lambda_{N+1}\), and every
entry

\[
 \widehat P_{ij}=Q(Be_j,Be_i),\qquad i,j\le N.            \tag{13}
\]

In these coordinates the supply is diagonal:

\[
 \widehat A_N=\operatorname{diag}
   (\lambda_1-\alpha _2,\ldots,\lambda_N-\alpha _2).      \tag{14}
\]

A certificate must verify all diagonal lower bounds in (14) are positive.

## 5. Generalized eigenvalue and complement tail

Define the finite generalized port ratio

\[
 r_N=\lambda_{\max}\left(
 \widehat A_N^{-1/2}\widehat P_N\widehat A_N^{-1/2}
 \right).                                                \tag{15}
\]

Let

\[
 P_0=\frac{P_\infty}{a}
 \left(2\pi M_{\rm loc}+H_{\rm rem}+P_2\right)^2,         \tag{16}
\]

using the explicit full weighted-crossing ledger from the earlier note.
Then

\[
 Q(Bx,Bx)\le P_0\|x\|^2.                                 \tag{17}
\]

For \(y\perp\{e_1,\ldots,e_N\}\) in \(\mathcal K_{\rm ev}\),

\[
 E_C[y]-\alpha _2\|y\|^2
 \ge(\lambda_{N+1}-\alpha _2)\|y\|^2.                    \tag{18}
\]

Therefore the rigorous complement ratio is

\[
 \beta_N=\frac{P_0}{\lambda_{N+1}-\alpha _2}.             \tag{19}
\]

The denominator must have a positive lower enclosure. Positivity of the port
Gram controls the mixed block. The resulting simple sufficient certificate
is

\[
 \boxed{\qquad r_N+\beta_N\le1.\qquad}                   \tag{20}
\]

Indeed, for \(x=x_N+y\), Cauchy in the port Hilbert space bounds the mixed
pairing by the geometric mean of the two port diagonals. The normalized
two-component port vector then has squared norm at most
\(r_N+\beta_N\) times the total supply.

A sharper certificate retains the normalized mixed norm

\[
 \delta_N=
 \left\|
 \widehat A_N^{-1/2}P_N^{\rm port}
 A_{\rm tail}^{-1/2}
 \right\|.                                               \tag{21}
\]

If interval arithmetic gives

\[
 r_N\le1,\qquad \beta_N\le1,\qquad
 \delta_N^2\le(1-r_N)(1-\beta_N),                        \tag{22}
\]

then the exact two-block Schur complement proves (1). The coarse Cauchy
bound \(\delta_N^2\le r_N\beta_N\) reduces (22) to (20).

The endpoint theorem can improve (19): split the complement with the
explicit logarithmic collar cutoff \(2-|v|<e^{-S}\). On that block use

\[
 \beta_{\rm end}(S)
 =\frac{P_0}{c_0S-C_1}.                                  \tag{23}
\]

On the interior high-frequency block use a validated lower Fourier or Ritz
floor. Cutoff commutator norms enter the mixed constant (21). Every quantity
in (23) is interval-enclosable, but current barrier constants make the
coarse \(P_0\) enormous. A direct coherent tail norm would be much sharper.

## 6. Minimal numerical certificate

The following finite data suffice:

1. An interval matrix for (4) with a positive lower singular-value bound.
2. Interval matrices \(M_N,K_N^{\rm c},K_N^{\rm p}\), including certified
   theta and full-prime tails.
3. A validated normalized killed ground and intervals for
   \(\alpha _2\), \(a\), and the port matrix (11).
4. Validated constrained eigenvalue intervals through
   \(\lambda_{N+1}\), including Galerkin residual and spectral separation.
5. Either the coarse constant \(P_0\) in (16), or a sharper interval
   enclosure of the complement source norm and mixed norm (21).
6. An interval generalized eigensolver proving (20), or the sharper Schur
   inequalities (22).

Items 1--2 reduce to finite interval integration plus explicit series tails.
The earliest absent data are item 3, the normalized killed-ground enclosure,
and item 4, the constrained spectral separation at radius two. The previous
written Galerkin theorem specifies their certificate format but contains no
validated numerical eigenpair. Without these data, neither a passing
certificate nor a finite failure witness is justified.

## 7. Lean artifact

[FiniteConstrainedPortCertificate.lean](../../formalization/BuildingBlocks/FiniteConstrainedPortCertificate.lean) formalizes:

* the low-plus-tail certificate \(r+\beta\le1\);
* the sharper two-block determinant/Schur margin;
* propagation of interval numerator and denominator bounds to a generalized
  quotient; and
* conversion of a global port ceiling and complement spectral floor into
  the tail ratio (19).

It compiles with Lean 4.24 and contains no sorry or new axiom. Matrix
Hermiticity, interval entries, killed-ground validation, and spectral
separation remain explicit analytic inputs.
