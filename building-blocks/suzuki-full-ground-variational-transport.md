# Quantitative transport of Suzuki's full localized Weil ground

Independently reviewed written proof, 2026-09-17. This studies the full lowest eigenvalue of
Suzuki's localized Weil operator, including both pole terms, the
archimedean multiplier, and every admitted actual von Mangoldt weight.
It gives an exact variational evolution sandwich and a quantitative
modulus, including across prime-power support thresholds. Neither
estimate establishes positivity at all windows or RH.

Use the fixed-window pullback of the [prime-power onset note](suzuki-prime-power-support-spectral-flow.md).
For a normalized \(\phi\) supported on \([-1,1]\), let
\[
\begin{aligned}
P_a(\phi)&=2a\Re(I_+(a)\overline{I_-(a)}),&
I_\pm(a)&=\int_{-1}^1\phi(s)e^{\pm as/2}ds,\\
\Gamma_a(\phi)&=\frac1{2\pi}\int_{\mathbb R}
 m(\eta/a)|\widehat\phi(\eta)|^2d\eta,&
m(\xi)&=\Re\psi(1/4+i\xi/2)-\log\pi,\\
R_\phi(t)&=\Re\int_{\mathbb R}\phi(s+t)\overline{\phi(s)}ds,&
u_n&=\log n,\quad w_n=\Lambda(n)/\sqrt n.
\end{aligned}
\tag{1}
\]
All functions are extended by zero. The form, its normalized ground
space, and lowest value are
\[
q_a(\phi)=P_a(\phi)+\Gamma_a(\phi)
-2\sum_{u_n<2a}w_nR_\phi(u_n/a),\quad
\mathcal G_a=\{\|\phi\|_2=1:q_a(\phi)=\lambda(a)\},\quad
\lambda(a)=\inf_{\|\phi\|_2=1}q_a(\phi).
\tag{2}
\]
The closed forms share the domain
\(\mathcal D=\overline{C_c^\infty(-1,1)}^{\,\|\cdot\|_{\log}}\),
where \(\|\phi\|_{\log}^2=\|\phi\|_2^2+
\mathcal E_{\log}(\phi)\) and \(\mathcal E_{\log}\) is defined below.
Indeed \(m(\eta/a)=\log(2+|\eta|)+O_J(1)\) on each compact
window interval, while the pole and finitely many admitted shifts
are bounded \(L^2\) forms. This is the common closure in Suzuki's
scaled formula; it is contained in \(H^{\log}(-1,1)\). Suzuki
proves that \(\mathcal G_a\) is nonempty and \(\lambda(a)\) is
continuous. His support nesting gives \(\lambda(a)\ge\lambda(b)\)
for \(a<b\); the result below resolves that inequality into the
actual terms.

Fix a compact interval \(J=[A,B]\subset(0,\infty)\) and put
\(\mathcal N_J=\{n\ge2:u_n\le2B,\ \Lambda(n)>0\}\). This set is
finite. For any \(c\in J\), one may sum over all \(n\in\mathcal N_J\)
in (2), since \(R_\phi(t)=0\) for \(t\ge2\), including \(t=2\).
Thus no endpoint atom is silently omitted. For \(A\le a<b\le B\)
define the signed full transport
\[
\begin{aligned}
\mathscr D_{a,b}(\phi):=q_a(\phi)-q_b(\phi)
&=\Gamma_a(\phi)-\Gamma_b(\phi)
  +P_a(\phi)-P_b(\phi)\\
&\quad+2\sum_{n\in\mathcal N_J}w_n
\left[R_\phi(u_n/b)-R_\phi(u_n/a)\right].
\end{aligned}
\tag{3}
\]
The displayed sum includes all prime powers that arrive anywhere
between \(a\) and \(b\), with their exact \(\Lambda(n)/\sqrt n\).

**Theorem 1 (exact variational sandwich).** For every \(A\le a<b\le B\),
\[
\boxed{\quad
\max_{\phi\in\mathcal G_a}\mathscr D_{a,b}(\phi)
\ \le\ \lambda(a)-\lambda(b)\
\le\ \min_{\phi\in\mathcal G_b}\mathscr D_{a,b}(\phi).
\quad}
\tag{4}
\]
In particular the exact source transport is nonnegative on
*every ground vector at the later window*:
\(\mathscr D_{a,b}(\phi_b)\ge0\) for \(\phi_b\in\mathcal G_b\).
Indeed, \(q_b(\phi_a)\ge\lambda(b)\) gives the first inequality,
and \(q_a(\phi_b)\ge\lambda(a)\) gives the second. The extrema exist
because a ground eigenspace is finite-dimensional. No differentiability
of an eigenbranch or boundary trace is assumed. Formula (4) holds
across prime-power births as well as between them. This ground
transport sign is variational and holds for any fixed symmetric
global form restricted to nested supports; it is not by itself an
arithmetic bound on the actual coefficients.
For a possible zero crossing, (4) gives the exact one-sided
detector
\[
\max_{\phi\in\mathcal G_a}\mathscr D_{a,b}(\phi)>\lambda(a)
\quad\Longrightarrow\quad \lambda(b)<0.
\tag{4a}
\]
Conversely \(\lambda(b)\ge0\) requires
\(\mathscr D_{a,b}(\phi)\le\lambda(a)\) for every
\(\phi\in\mathcal G_a\). The modulus below bounds the size of a
short-step transport, but not its sign at the tiny actual margin.

The gamma term has a strict, uniform direction under dilation. The
digamma series gives, for \(\xi>0\),
\[
m'(\xi)=\frac{\xi}{2}\sum_{k=0}^\infty
\frac{k+1/4}{((k+1/4)^2+\xi^2/4)^2}>0,\qquad
\xi m'(\xi)\longrightarrow1\quad(\xi\to\infty).
\tag{5}
\]
Let \(K_m=\sup_{\xi\in\mathbb R}|\xi m'(\xi)|<\infty\).
Since \(|\widehat\phi(\eta)|\le\|\phi\|_1\le\sqrt2\) for a unit
vector supported on \([-1,1]\), its Fourier probability measure
\((2\pi)^{-1}|\widehat\phi(\eta)|^2d\eta\) puts at most
\(2\delta/\pi\) mass in \([-\delta,\delta]\).
Set \(\delta=\pi/4\) and
\[
\kappa_J=\frac12
\inf_{\substack{c\in J\\|\eta|\ge\pi/4}}
\frac{|\eta|}{c^2}m'(|\eta|/c)>0.
\tag{6}
\]
Positivity follows from (5), continuity, and the positive limit
\(1/c\) at large \(|\eta|\). Differentiating \(\Gamma_c\) under
the integral gives for every unit \(\phi\)
\[
\kappa_J(b-a)\le
\Gamma_a(\phi)-\Gamma_b(\phi)
\le\frac{K_m}{A}(b-a).
\tag{7}
\]
This is a uniform archimedean downward drift, independent of the
prime coefficients.

Here is a quantitative control of the other terms on actual ground
vectors. Define
\[
\mathcal E_{\log}(\phi)=\frac1{2\pi}\int
\log(2+|\eta|)|\widehat\phi(\eta)|^2d\eta.
\]
There is a finite \(M_J\) with
\(\mathcal E_{\log}(\phi)\le M_J\) for every
\(\phi\in\mathcal G_c\), \(c\in J\): uniformly on \(J\),
\(\Gamma_c(\phi)\ge\mathcal E_{\log}(\phi)-C_J\);
the pole and the finite prime sum are bounded on the unit sphere;
and one fixed smooth unit test bounds all \(\lambda(c)\) above.
For \(h>0\) put
\[
\omega_M(h)=\sqrt h+
\frac{2M}{\log(2+h^{-1/2})},\qquad \omega_M(0)=0.
\tag{8}
\]
The Fourier identity
\[
R_\phi(t)=\frac1{2\pi}\int_{\mathbb R}
\cos(\eta t)|\widehat\phi(\eta)|^2d\eta
\]
and a split at \(|\eta|=h^{-1/2}\) show that
\[
|R_\phi(t+h)-R_\phi(t)|\le\omega_M(h)
\quad\text{when}\quad
\|\phi\|_2=1,\quad\mathcal E_{\log}(\phi)\le M.
\tag{9}
\]
The low-frequency cosine difference is at most \(\sqrt h\);
the high-frequency probability mass is at most
\(M/\log(2+h^{-1/2})\), with cosine difference at most two.
For \(a,b\in J\) the \(n\)-th shift changes by
\[
h_n=u_n(1/a-1/b)=\frac{u_n(b-a)}{ab}.
\tag{10}
\]
Direct Cauchy--Schwarz on \(I_\pm\) and their derivatives gives
\[
|P_b(\phi)-P_a(\phi)|\le
L_J(b-a),\qquad L_J=4(1+B)e^B
\tag{11}
\]
for every normalized \(\phi\). Combining (4) and (7)--(11) yields
\[
\begin{aligned}
0\le\lambda(a)-\lambda(b)
&\le (K_m/A+L_J)(b-a)
+2\sum_{n\in\mathcal N_J}w_n\omega_{M_J}(h_n),\\
\lambda(a)-\lambda(b)
&\ge(\kappa_J-L_J)(b-a)
-2\sum_{n\in\mathcal N_J}w_n\omega_{M_J}(h_n).
\end{aligned}
\tag{12}
\]
In particular \(\lambda\) has the explicit local modulus
\[
|\lambda(a)-\lambda(b)|
=O_J\!\left(\frac1{\log(1/|a-b|)}\right)
\qquad (a,b\in J,\ |a-b|\downarrow0).
\tag{13}
\]
This includes the support thresholds, whereas Suzuki's continuity
theorem gives no rate. The lower estimate in (12) may be negative;
it does not assert strict ground flow at every window.
For the actual coefficients the prime budget in this modulus is
already large on growing windows. Partial summation and the prime
number theorem give
\[
\sum_{\log n\le2B}\frac{\Lambda(n)}{\sqrt n}
=\int_1^{e^{2B}}x^{-1/2}d\psi(x)
=(2+o(1))e^B\qquad(B\to\infty).
\tag{13a}
\]
Thus (12) is a local continuity bound, not an all-window protective
margin: it does not turn Zhu's small certified value of \(\lambda\)
into positivity at arbitrary later support.

**Finite symmetric coefficient countermodel.** Keep \(P_a\) and
\(\Gamma_a\) *exactly as above*, and on \(0<a\le1/2\) replace the
single admitted reflected prime pair at \(\pm\log2\) by a positive
weight \(M\):
\[
q_a^{(M)}(\phi)=P_a(\phi)+\Gamma_a(\phi)
-2M R_\phi((\log2)/a).
\tag{14}
\]
The convention \(R_\phi(t)=0\) for \(t\ge2\) ensures that this pair
enters at the same threshold \(a=(\log2)/2\). There are no other
prime-power shifts on this window because \(2a\le1<\log3\).
For the normalized even constant \(\phi_0=1/\sqrt2\),
\(R_{\phi_0}(t)=1-t/2\) for \(0\le t\le2\). At \(a=1/2\),
\[
q_{1/2}^{(M)}(\phi_0)
=P_{1/2}(\phi_0)+\Gamma_{1/2}(\phi_0)
-2M(1-\log2),
\tag{15}
\]
which is negative for sufficiently large finite \(M>0\).
For all sufficiently small \(a\), this model coincides with the
zero-prime Suzuki form and has positive ground value by Suzuki's
small-window theorem. The same log-form compactness and the
quantitative bound above give continuity, so its ground value
crosses zero before \(a=1/2\). The countermodel retains the exact
pole and gamma terms, positive coefficient, paired \(\pm\log2\)
reflection, and threshold geometry. It is not the actual
\(\Lambda(2)/\sqrt2\) coefficient system, nor is it asserted to
obey the full analytic zeta functional equation.

For clarity, even the full *analytic reflection equation* by itself
cannot secure zero location: if \(\xi(s)\) is the usual completed zeta
function, then for \(0<r<1/2\),
\[
\xi_r(s)=\xi(s)\frac{(s-1/2)^2-r^2}{1/4-r^2}
\tag{16}
\]
is entire of order one, has the same symmetry
\(\xi_r(s)=\xi_r(1-s)\), and has zeros at
\(s=1/2\pm r\) inside the critical strip. The factor equals one
at \(s=0,1\), so the completed endpoint normalization and the
corresponding zeta pole residue are unchanged. Dividing by the
usual gamma/pole completion changes the Dirichlet/Euler-product
coefficients, so this is a functional-equation counterexample
only, not a model of the actual von Mangoldt source.

The genuine zeta coefficients and its functional equation are both
fixed in (2)--(4). The calculation shows exactly where a proof would
need a signed relation among the pole increment, archimedean drift,
and prime correlations of the *actual* moving ground state. Neither
the reflection symmetry nor the finite coefficient positivity supplies
it. Zhu's independently certified positive window \(a=0.8\) for
the actual coefficients is consistent with this bound and does not
extend it to all windows. No RH or Lean claim follows.

Primary sources: [Suzuki, *Weil's quadratic form via the screw
function*, arXiv:2606.09096v2, especially §§2.4, 4](https://arxiv.org/html/2606.09096v2);
[Zhu, *Weil positivity in compact windows*, arXiv:2608.24827v2](https://arxiv.org/html/2608.24827v2).
No novelty or priority claim is made for the general variational
principle.
