# Radial mean and truncated orthogonality above the central curve

This note continues the corrected uncentered decomposition

\[
 \mathcal R_X^\varepsilon
 =\mathcal P_X^\varepsilon+\mathcal D_X^\varepsilon
  +\mathcal C_X^\varepsilon+\mathcal L_X^\varepsilon.
\tag{1}
\]

The centered birth diagonal \(\mathcal D_X^\varepsilon=O(X^2)\) is already
paid.  Here the radial term is evaluated after an exact exchange of the
coupled clock and angle, using the established positive-real
Lambert--Mellin representation.  The truncation cross is then rewritten by
full-circle Poisson orthogonality.  The radial target is not obtained: its
hard-clock tail contains the Abel-smoothed Mertens value at square-root
scale.  The truncation boundary has both signs and restores a signed
two-index correlation.

Put

\[
 r=e^{-1/X},\quad \rho=r^2=e^{-2/X},\quad
 \Delta=X^{-1/2},\quad
 \alpha=\frac12-\eta_\varepsilon>0,\quad
 \kappa=\alpha^{-1},
\tag{2}
\]

and retain the original clock

\[
 w(t)=t^{-2}-[t(e^t-1)]^{-1}.
\tag{3}
\]

Write

\[
 F_X(\theta,t)=H_t(re^{i\theta}),\qquad
 m_X(t)=H_t(\rho),\qquad C_X=F_X-m_X.
\tag{4}
\]

The unpaid condition is

\[
 t>b_\varepsilon(\theta)
 =\max(|\theta|,X^{-1})^\alpha.
\tag{5}
\]

No integral with \(t\le b_\varepsilon(\theta)\) is used below.

## 1. Exact angular weight after swapping the coupled domain

For fixed \(t\), define

\[
 \delta_X(t)=
 \begin{cases}
 0,&t\le X^{-\alpha},\\
 \min(\Delta,t^\kappa),&t>X^{-\alpha}.
 \end{cases}
\tag{6}
\]

Then (5) is equivalent, up to measure-zero endpoints, to
\(|\theta|<\delta_X(t)\).  Consequently Tonelli's theorem gives the exact
positive identity

\[
 \boxed{\quad
 \mathcal P_X^\varepsilon
 =\int_0^\infty |m_X(t)|^2w(t)\Omega_X(t)\,dt,
 \quad}
\tag{7}
\]

where

\[
 \Omega_X(t)=\frac1{2\pi}
 \int_{|\theta|<\delta_X(t)}
 \frac{d\theta}{|1-re^{i\theta}|^2}.
\tag{8}
\]

The elementary Poisson integral evaluates (8) without comparison loss:

\[
 \boxed{\quad
 \Omega_X(t)=\mathbf1_{t>X^{-\alpha}}
 \frac{2}{\pi(1-r^2)}
 \arctan\!\left(
 \frac{1+r}{1-r}\tan\frac{\delta_X(t)}2
 \right).
 \quad}
\tag{9}
\]

As soon as the far domain is nonempty, \(\delta_X(t)>X^{-1}\).  Since
\((1+r)/(1-r)\asymp X\), (9) implies absolute constants \(c,C>0\)
such that

\[
 \boxed{\quad
 cX\,\mathbf1_{t>X^{-\alpha}}
 \le\Omega_X(t)\le
 CX\,\mathbf1_{t>X^{-\alpha}}.
 \quad}
\tag{10}
\]

Thus the coupled curve does not give a small angular factor for the radial
mean.  It merely removes clocks below \(X^{-\alpha}\).

## 2. What the proved Lambert--Mellin line gives

The exact positive-real identity, with \(x=2/X\), is

\[
 m_X(t)=H(e^{-x},t)
 =\frac1{2\pi i}\int_{\sigma-i\infty}^{\sigma+i\infty}
 \Gamma(s)\frac{(1-q)\operatorname{Li}_s(q)}{q\zeta(s)}
 x^{-s}\,ds,qquad q=e^{-t},\quad\sigma>1.
\tag{11}
\]

This is the established all-composition Lambert--Mellin observable.  On
\(0<t\le1\),

\[
 \left|\frac{(1-q)\operatorname{Li}_{\sigma+iy}(q)}q\right|
 \le C_\sigma t,
\tag{12}
\]

while for \(t\ge1\) it is bounded by an absolute constant depending on
\(\sigma\).  Also
\(|1/\zeta(\sigma+iy)|\le\zeta(\sigma)\), and
\(\Gamma(\sigma+iy)\) is integrable in \(y\).  Hence

\[
 |m_X(t)|\le C_\sigma X^\sigma\min(t,1).
\tag{13}
\]

Because \(t^2w(t)=O(t)\) at zero and \(w(t)=O(t^{-2})\) at infinity,
(7), (10), and (13) yield the unconditional radial estimate

\[
 \boxed{\quad
 \mathcal P_X^\varepsilon\ll_\sigma X^{1+2\sigma}
 \qquad(\sigma>1).
 \quad}
\tag{14}
\]

Thus the proved half-plane gives \(X^{3+\delta}\) for every fixed
\(\delta>0\), not \(X^{2+\varepsilon}\).  Moving (11) to
\(\sigma=1/2+o(1)\) would cross the zeros of \(\zeta\); the numerator is
nonzero in the hard-clock limit.  The desired gain is therefore not an
unused consequence of the established Lambert--Mellin bound.

## 3. The hard-clock radial obstruction

Let

\[
 A_X=\sum_{d\ge1}\mu(d)e^{-2d/X}.
\tag{15}
\]

The exact Lambert formula gives

\[
 m_X(t)=(1-q)\sum_{d\ge1}
 \frac{\mu(d)\rho^d}{1-q\rho^d},
\tag{16}
\]

and hence

\[
 m_X(t)-A_X
 =-q\sum_{d\ge1}\mu(d)\rho^d
 \frac{1-\rho^d}{1-q\rho^d}.
\tag{17}
\]

For \(t\ge1\), this implies

\[
 |m_X(t)-A_X|\le C X e^{-t}.
\tag{18}
\]

Take \(L_X=1+\log(4CX)\).  Then the right side of (18) is at most
\(1/4\) on \([L_X,\infty)\).  On this interval the whole central arc is
admissible, \(\Omega_X(t)\ge cX\), and
\(w(t)\ge c_0t^{-2}\).  Restricting the positive radial integral gives

\[
 \boxed{\quad
 \mathcal P_X^\varepsilon
 \ge \frac{c_1X}{L_X}
 (|A_X|-1/4)_+^2.
 \quad}
\tag{19}
\]

Therefore an all-\(\varepsilon\) estimate
\(\mathcal P_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}\) would force

\[
 |A_X|\ll_\varepsilon X^{1/2+\varepsilon}\sqrt{\log X}.
\tag{20}
\]

This is the square-root Abel--Möbius scale.  Bounds of (20) for every
positive \(\varepsilon\), after absorbing \(\sqrt{\log X}\), are the
standard smoothed Mertens formulation of the zero-free half-plane
\(\operatorname{Re}s>1/2\), hence of RH.  Equation (19) is not a proof that
the radial target fails; it proves that paying it unconditionally would
already supply the missing arithmetic cancellation.

## 4. Exact truncated-orthogonality cross

For \(0\le\delta\le\pi\), define

\[
 J_{n,X}(\delta)=\frac1{2\pi}
 \int_{|\theta|<\delta}
 \frac{A_n(\theta)}{|1-re^{i\theta}|^2}\,d\theta,
 \qquad
 A_n(\theta)=r^ne^{in\theta}-r^{2n}.
\tag{21}
\]

The full-circle Poisson mean is exact:

\[
 J_{n,X}(\pi)=0.
\tag{22}
\]

Indeed the \(n\)-th Fourier coefficient of
\(|1-re^{i\theta}|^{-2}\) is \(r^n/(1-r^2)\), so the two terms in
(21) cancel.  Swapping the coupled domain in the truncation cross and
using \(C_X=\sum_nh_nA_n\) gives

\[
 \boxed{\quad
 \mathcal L_X^\varepsilon
 =2\operatorname{Re}\int_{X^{-\alpha}}^\infty
 w(t)\overline{m_X(t)}
 \sum_{n\ge1}h_n(t)J_{n,X}(\delta_X(t))\,dt.
 \quad}
\tag{23}
\]

Equivalently, (22) writes the last sum as the negative integral over the
omitted angular complement.  This is exact polarization/orthogonality,
not a Cauchy--Schwarz estimate.

The moving boundary does not have a fixed sign.  Symmetry gives

\[
 \boxed{\quad
 J_{n,X}'(\delta)=\frac1\pi
 \frac{r^n\cos(n\delta)-r^{2n}}
 {|1-re^{i\delta}|^2}.
 \quad}
\tag{24}
\]

At \(\delta=0\), the numerator is \(r^n-r^{2n}>0\).  If
\(n\ge\pi\sqrt X\), then \(\delta=\pi/n\le\Delta\), and the numerator is
\(-r^n-r^{2n}<0\).  Thus the literal endpoint flux changes sign inside the
central arc for the simultaneous growing indices relevant to the Abel
horizon.  There is no nonnegative boundary payment.

Finally expand the radial mean in the same birth basis:

\[
 m_X(t)=\sum_{k\ge1}\rho^kh_k(t).
\tag{25}
\]

Then (23) becomes the exact signed two-index form

\[
 \boxed{\quad
 \mathcal L_X^\varepsilon
 =2\operatorname{Re}\sum_{n,k\ge1}\rho^k
 \int_{X^{-\alpha}}^\infty
 h_n(t)h_k(t)J_{n,X}(\delta_X(t))w(t)\,dt.
 \quad}
\tag{26}
\]

Inserting
\(h_n=\sum_{ad=n}\mu(d)p_a\) restores the same ordered dilation/cofactor
variables \((a,d),(b,e)\) as the centered covariance.  In particular its
\((a,b)=(1,2)\) part contains the affine relation \(d-2e=h\), now weighted
by the exact truncated Poisson coefficient \(J_{d,X}\) and the radial
factor \(\rho^{2e}\).  Hence exact orthogonality turns
\(\mathcal L_X^\varepsilon\) into another signed affine correlation; it
does not telescope it into a favorable endpoint.

## 5. Consequence for the paid portion

The exact swap (7)--(10) and Lambert--Mellin estimate (14) do not pay the
radial term at the target scale.  The lower bound (19) identifies the
sharp obstruction.  Equations (23)--(26) improve the description of the
truncation term beyond Cauchy--Schwarz, but its boundary flux has both signs
and its complete expansion returns to the surviving affine Möbius rows.

Thus the newly exposed terms cannot presently enlarge the paid portion of
the live remainder beyond the already proved diagonal
\(\mathcal D_X^\varepsilon=O(X^2)\).  A proof of the radial target would
already give square-root Abel--Möbius cancellation, while a proof of the
truncation target requires a one-sided estimate for (26).  The original
weight, coupled boundary, radial endpoint, every divisor order, and all
prime powers remain.  No RH premise or conclusion is asserted.
