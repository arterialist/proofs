# The first two collective Lambert columns and the fixed-core source range

## Classification

The published theta construction does provide a canonical way to put a
**clock-smeared** Lambert column in the exterior covariance space.  It does
not provide a core vector whose weighted crossing source is that column.
This distinction is already decisive for the first two frequencies.

At a fixed clock value \(t\), the notation \(S_{N,t}\) cannot denote an
\(L^2\) source obtained from density matching: evaluation at \(t\) is a
Dirac mass in the clock variable.  After smearing in the actual clock
measure, the first two joint columns below are well defined and preserve
the exact near-antisymmetric cancellation.  To use the signed-core theta
inequality one must additionally solve two crossing equations.  No
published range theorem or validated solutions supply them.

Conditional on those range equations, the three covariance entries reduce
to explicit weak Poisson identities whose continuous part, both prime
orientations, and every prime power are displayed below.  Thus the first
missing datum is range membership, rather than an unevaluated scalar
quadrature.

## 1. Canonical smeared columns

Fix \(X\ge1\), put \(r=e^{-1/X}\), and retain the angular interval and
moving central set

\[
 I_X=(-X^{-1/2},X^{-1/2}),\qquad
 \Theta_X(t)=\{\theta:|\theta|<X^{-1/2},\ t>b_\varepsilon(\theta)\},
 \qquad
 d\omega_X(\theta)=\frac{d\theta}{2\pi|1-re^{i\theta}|^2}
 \quad(\theta\in I_X).
\tag{1}
\]

The first coefficients of the complete quotient-layer sum are

\[
 c_{1,X}(t)=e^{-1/X}(1-e^{-t}),\qquad
 c_{2,X}(t)=-s_X(t)c_{1,X}(t),
 \quad s_X(t)=e^{-1/X}(1-e^{-t}).
\tag{2}
\]

Let \(h\in L^2((0,\infty),w(t)dt)\) be bounded with compact clock
support.  This hypothesis is only a convenient dense starting class.  The
joint density-matching isometry from the published transfer obstruction is

\[
 (U^\gamma f)(\theta,u)=
 \left[\frac{e^uw(e^u)}
 {\rho(u)\psi(u)b(u)\Phi(u)}\right]^{1/2}
 f(\theta,e^u).
\tag{3}
\]

Formula (3) is exactly the map in
[Angularly collective transfer, equations (7)--(8)](../theta-and-heat/angularly-collective-fixed-core-transfer-obstruction.md#2-exact-joint-density-matching).
The displayed norm identity there is the change of variables \(t=e^u\);
no theta intertwiner is inserted.

Define the two positive-amplitude frequency columns

\[
 \begin{aligned}
 Z_{1,h}&=U^\gamma\!\left[
   \mathbf1_{\Theta_X(t)}h(t)c_{1,X}(t)e^{i\theta}\right],\\
 Z_{2,h}&=U^\gamma\!\left[
   \mathbf1_{\Theta_X(t)}h(t)s_X(t)c_{1,X}(t)e^{2i\theta}\right].
 \end{aligned}
\tag{4}
\]

They belong to
\(L^2(I_X,d\omega_X;L^2(\gamma))\), and isometry gives their norms
and cross product exactly.  In particular the actual \(N=1,2\) Lambert
row is

\[
 Z_{-,h}=Z_{1,h}-Z_{2,h}
 =U^\gamma\!\left[\mathbf1_{\Theta_X(t)}h(t)c_{1,X}(t)
 e^{i\theta}(1-s_X(t)e^{i\theta})\right].
\tag{5}
\]

Consequently

\[
 \|Z_{-,h}\|^2
 =\int_0^\infty |h(t)c_{1,X}(t)|^2 w(t)
 \int_{\Theta_X(t)}|1-s_X(t)e^{i\theta}|^2d\omega_X(\theta)dt.
\tag{6}
\]

This is exactly the \(2\times2\) central Gram contraction, with no
entrywise absolute value.  On \(t\ge\log X\), the existing estimates
\(1-s_X(t)\le2/X\) and
\(1-\cos\theta\le1/(2X)\) retain its \(O(X^{-1})\) cancellation.

For each angular fibre let
\(P_\gamma F=F-a^{-1}\int Fd\gamma\), where \(a=\gamma(O)\), and put
\(Y_{j,h}=P_\gamma Z_{j,h}\).  Since \(P_\gamma\) is linear,

\[
 Y_{-,h}=Y_{1,h}-Y_{2,h}=P_\gamma Z_{-,h},\qquad
 \|Y_{-,h}\|\le\|Z_{-,h}\|.
\tag{7}
\]

Thus the required centering does not split the coherent cancellation.

There is no analogous \(L^2\) vector at one prescribed clock \(t_0\).
Replacing \(h(t)dt\) by \(\delta_{t_0}\) leaves the clock Hilbert space,
and (3) would produce a distribution supported at \(u=\log t_0\), not an
element of \(L^2(\gamma)\).  Fixed-\(t\) formulae are kernel notation and
must be integrated before they become theta sources.

## 2. The exact missing source equations

For the fixed core \(C=[-R,R]\), the actual centered weighted crossing map
is

\[
 \mathcal S_Rx=\rho^{-1}
 \left(B_Rx-\langle x,a_{c,R}\rangle1_O\right),
 \qquad D(E_{C,R})\longrightarrow L^2_0(\gamma).
\tag{8}
\]

Formula (8) is
[Angularly collective transfer, equation (9)](../theta-and-heat/angularly-collective-fixed-core-transfer-obstruction.md#3-finite-angular-mixing-before-crossing).
The boundedness of \(x\mapsto B_Rx/\rho\) and compactness after the core
form embedding are equations (14)--(15) of the
[weighted crossing theorem](../theta-and-heat/theta-groundstate-bounded-weighted-crossing.md#the-weighted-crossing-operator).

The operator \(B_R\) already contains the continuous crossing and both
directions of every crossing displacement \(\log p^k\).  Hence an actual
instantiation of the first two columns requires measurable core fields
\(x_{1,h}(\theta),x_{2,h}(\theta)\) satisfying

\[
 (I\otimes\mathcal S_R)x_{j,h}=Y_{j,h},\qquad j=1,2,
\tag{9}
\]

with the common mean and affine constraints required by the signed-core
consumer.  Equation (9), not merely \(Y_{j,h}\in L^2\), is the source
realization.

No published theorem proves either membership in (9).  The map
\(\mathcal S_R:D(E_{C,R})\to L^2(\gamma)\) is compact.  The established
dyadic-shell argument proves that \(I\otimes\mathcal S_R\) has no bounded
right inverse on the full actual Lambert shell span: projecting
hypothetical preimages onto the limiting angular profile would send a
bounded core sequence to an asymptotically orthogonal sequence in
\(L^2(\gamma)\), contradicting compactness.  This does not prove that
either of the two particular smeared columns lies outside the range.  It
does prove that boundedness of the weighted crossing map cannot be
reversed to construct them, and that no shell-uniform realization may be
assumed.

Thus (4) is a canonical covariance-space construction, while (9) remains
the exact domain/range obstruction to calling these columns actual
signed-core sources.

## 3. The three complete covariance entries

The exterior covariance itself is defined for the centered columns even
before (9) is solved.  Let

\[
 \mathcal R_R=(a+A_{{\rm rem},R})^{-1},\qquad
 v_j(\theta)=\mathcal R_RY_{j,h}(\theta),
\tag{10}
\]

and set

\[
 A_h=\int_{I_X}\langle Y_{1,h},v_1\rangle_\gamma d\omega_X,
 \quad
 B_h=\operatorname{Re}\int_{I_X}
       \langle Y_{1,h},v_2\rangle_\gamma d\omega_X,
 \quad
 C_h=\int_{I_X}\langle Y_{2,h},v_2\rangle_\gamma d\omega_X.
\tag{11}
\]

The convention is that the columns vanish when the corresponding fibre
does not belong to the moving set (1).  The exact signed entry is

\[
 \boxed{\quad A_h-2B_h+C_h
   =\int_{I_X}\langle\mathcal R_RY_{-,h},Y_{-,h}\rangle_\gamma
      d\omega_X.\quad}
\tag{12}
\]

This is the quantity to estimate.  Bounding \(A_h,B_h,C_h\) separately
would discard the cancellation in (5).

For completeness, every entry in (11) has the following explicit
continuous-plus-prime reduction.  For \(i,j\in\{1,2\}\), write

\[
 G_{ij}=\int_{I_X}\langle Y_{i,h},v_j\rangle_\gamma d\omega_X.
\]

The weak Poisson equation gives

\[
 G_{ij}=\int_{I_X}
 \{a\langle v_i,v_j\rangle_\gamma
   +E_c^{\rm rem}(v_i,v_j)+E_p(v_i,v_j)\}\,d\omega_X.
\tag{13}
\]

Here

\[
\begin{aligned}
 E_c^{\rm rem}(F,G)
  =\frac12\iint_{O^2}&(F(v)-F(u))
       \overline{(G(v)-G(u))}\,\psi(u)\psi(v)\Phi(u)\Phi(v)\\
 &\times\left[r(|u-v|)-e^{-(|u|+|v|)/2}\right]du\,dv,
\end{aligned}
\tag{14}
\]

and, with \(q=p^k\) running over every prime power,

\[
\begin{aligned}
 E_p(F,G)=\frac12\sum_{p}\sum_{k\ge1}
 \frac{\log p}{p^{k/2}}\sum_{\epsilon\in\{-1,1\}}
 \int_{\substack{u\in O\\u+\epsilon k\log p\in O}}
 &\bigl(F(u+\epsilon k\log p)-F(u)\bigr)\\
 &\overline{\bigl(G(u+\epsilon k\log p)-G(u)\bigr)}\\
 &\times\psi(u)\psi(u+\epsilon k\log p)
 \Phi(u)\Phi(u+\epsilon k\log p)\,du.
\end{aligned}
\tag{15}
\]

The factor \(1/2\) and the explicit sum over both signs are the directed
conductance convention.  Formula (15) retains every power \(p^k\), not
only primes.  Equations (13)--(15), together with the two weak solves in
(10), are a finite-truncation/interval-enclosable definition of all three
entries.  They are not claimed to have been numerically enclosed here.

Equivalently, one can solve only for the coherent difference
\(v_-=\mathcal R_RY_{-,h}=v_1-v_2\).  Then (12) equals

\[
 \int_{I_X}\{a\|v_-\|_\gamma^2
 +E_c^{\rm rem}(v_-)+E_p(v_-)\}\,d\omega_X,
\tag{16}
\]

which preserves the cancellation through every continuous and arithmetic
edge before any positive estimate is taken.

## 4. What this does and does not supply

Equations (4)--(7) construct the first two collective columns in the
complete exterior covariance space, after the mathematically necessary
clock smearing.  Equations (11)--(16) reduce their three covariance
entries to the actual residual theta form with all orientations and prime
powers.

They do not instantiate the signed-core consumer: that step requires the
two range equations (9), plus their common constraints and controlled core
energy.  Compactness rules out obtaining these data from a bounded
shell-uniform inverse, but does not exclude isolated preimages for a fixed
pair.  Consequently no theta-to-Lambert comparison, RH estimate, or
negative counterexample is asserted.

The accompanying Lean module proves only the reusable linear and
finite-quadratic algebra: two realized columns realize their coherent
difference, centering preserves it, and the mass/continuous/prime split
commutes exactly with the signed \(2\times2\) contraction.  The range,
Poisson, and analytic integral statements remain explicit hypotheses.
