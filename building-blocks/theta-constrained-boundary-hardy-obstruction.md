# The exact pulled weight is not controlled by the killed core form

This note tests the remaining sufficient inequality after the pointwise
certificate failed. At radius two, the proposed constrained Hardy estimate is

\[
 \frac1a\int_C W_2(v)|x(v)|^2\,d\nu(v)
 \le E_{CC}[x]+\int_C(\kappa_C-\alpha _2)|x|^2\,d\nu,
 \qquad x\in\mathcal K_{\rm ev}.                         \tag{1}
\]

Here \(W_2=B^*((\psi _2/\rho)B1_C)\) is the exact pulled weight from the
positive-kernel Cauchy reduction. The core space retains evenness, zero mean,
the ground-arrival constraint, and every component of the fixed finite
observation \(J\).

I prove that (1) fails. More strongly, \(W_2\) is not form-bounded with
respect to the killed core form on this finite-codimensional even subspace.
This is an obstruction to the Jensen-Schur majorant. It is not a
counterexample to the original port inequality
\(Q(Bx,Bx)\le E_C[x]-\alpha _2\|x\|^2\), because rowwise Cauchy loses the
cancellation inside the actual crossing column.

## 1. The correct logarithmic boundary coordinate

Near the positive endpoint write

\[
 d=2-v,\qquad s=\log(1/d),\qquad d=e^{-s}.                \tag{2}
\]

If \(m=b\Phi\) is the density of \(d\nu\), the exact unitary boundary
coordinate is

\[
 (Ux)(s)=e^{-s/2}\sqrt{m(2-e^{-s})}\,x(2-e^{-s}).         \tag{3}
\]

Indeed \(d\nu(v)=m(2-e^{-s})e^{-s}ds\), so (3) preserves the \(L^2\) norm.
The endpoint estimates from the preceding note become

\[
 \kappa_C(2-e^{-s})\lesssim s,\qquad
 W_2(2-e^{-s})\gtrsim s^{3/2}.                           \tag{4}
\]

Thus the killing part of the ground-state transform sees the multiplier
\(s\), while the pulled weight sees \(s^{3/2}\). Multiplication by
\(\sqrt{\kappa_C}\) leaves the unbounded ratio

\[
 \frac{W_2}{\kappa_C}\gtrsim\sqrt{s}.                    \tag{5}
\]

The internal form would have to supply the missing half-power. It does not.
A fixed profile translated to \(s=L\) has physical scale \(e^{-L}\). The
logarithmic jump form charges only \(O(L)\), which is the logarithm of the
inverse physical scale. The pulled weight charges \(L^{3/2}\).

This is not an \(H^{1/2}\) form in disguise. In one physical dimension, an
\(H^{1/2}\) seminorm has kernel \(|v-w|^{-2}\). The actual adjacent theta
kernel is \(r(|v-w|)\asymp|v-w|^{-1}\). Its high-frequency multiplier is
\(\log|\xi|+O(1)\), as in the established archimedean symbol formula.
For the normalized dilation

\[
 f_\varepsilon(d)=\varepsilon^{-1/2}\chi(d/\varepsilon),
\qquad
 \widehat f_\varepsilon(\xi)
 =\varepsilon^{1/2}\widehat\chi(\varepsilon\xi),         \tag{6}
\]

the multiplier calculation is exact up to a bounded low-frequency term:

\[
 \int_{\mathbb R}\log(2+|\xi|)
       |\widehat f_\varepsilon(\xi)|^2d\xi
 =\log(1/\varepsilon)\|\chi\|_2^2+O_\chi(1).             \tag{7}
\]

By contrast, its homogeneous \(H^{1/2}\) seminorm is of order
\(\varepsilon^{-1}\). The theta form supplies the logarithmic quantity in
(7), not this stronger fractional derivative. In the \(s\)-coordinate,
\(Uf_\varepsilon\) is a fixed profile translated by
\(\log(1/\varepsilon)\), up to uniformly bounded collar coefficients. A
translation-invariant local derivative seminorm cannot create the missing
\(s^{3/2}\) potential.

## 2. Even normalized boundary packets

Choose a nonzero real
\(\chi\in C_c^\infty((1,2))\). For small \(\varepsilon>0\), define

\[
 p_\varepsilon^+(v)
 =N_\varepsilon\varepsilon^{-1/2}
   \chi\!\left(\frac{2-v}{\varepsilon}\right),\qquad
 p_\varepsilon^-(v)=p_\varepsilon^+(-v),                 \tag{8}
\]

and

\[
 p_\varepsilon
 =\frac{p_\varepsilon^++p_\varepsilon^-}{\sqrt2}.        \tag{9}
\]

Choose \(N_\varepsilon\) so that
\(\|p_\varepsilon\|_{L^2(C,\nu)}=1\). Smoothness and positivity of \(m\) at
the endpoints give two fixed positive bounds for \(N_\varepsilon\). The two
supports are disjoint and lie where
\(\varepsilon<2-|v|<2\varepsilon\).

Put \(L_\varepsilon=\log(1/\varepsilon)\). The endpoint lower bound for
\(W_2\), uniform on this collar after adjusting its constant, gives

\[
 \boxed{\quad
 \int_CW_2|p_\varepsilon|^2d\nu
 \ge c_W L_\varepsilon^{3/2}.
 \quad}                                                  \tag{10}
\]

## 3. The complete killed energy of a packet is only logarithmic

The continuous internal form is

\[
 E_{CC}^{\rm c}[p]
 =\frac12\iint_{C\times C}|p(v)-p(w)|^2
   r(|v-w|)\Phi(v)\Phi(w)\,dv\,dw.                       \tag{11}
\]

On the fixed core, \(r(t)\le C/t\) for \(0<t\le1\), and it is bounded for
larger \(t\). Split (11) at \(|v-w|=\varepsilon\).

For the near part, extend each smooth packet by zero. Its Lipschitz constant
is \(O(\varepsilon^{-3/2})\), so

\[
 |p(v)-p(w)|^2
 \le C\varepsilon^{-3}|v-w|^2.
\]

The \(1/|v-w|\) singularity then integrates to \(O(1)\) over a collar of
length \(O(\varepsilon)\). For the far part, use
\(|p(v)-p(w)|^2\le2|p(v)|^2+2|p(w)|^2\). The remaining radial integral is

\[
 \int_\varepsilon^1\frac{dt}{t}=L_\varepsilon.           \tag{12}
\]

Hence

\[
 E_{CC}^{\rm c}[p_\varepsilon]\le C_1L_\varepsilon+C_2. \tag{13}
\]

Every internal prime displacement has length at least \(\log2\). Only the
finitely many \(n\) with \(\log n\le4\) can join two core points. Retaining
both orientations and every proper prime power therefore gives

\[
 E_{CC}^{\rm p}[p_\varepsilon]\le C_3\|p_\varepsilon\|^2=C_3. \tag{14}
\]

The complete exterior killing rate satisfies
\(\kappa_C(v)\le C_\kappa\log(1/(2-|v|))+C_4\) on the two endpoint collars.
Consequently

\[
 \int_C\kappa_C|p_\varepsilon|^2d\nu
 \le C_5L_\varepsilon+C_6.                              \tag{15}
\]

Combining (13)--(15), including the harmless fixed
\(-\alpha _2\|p_\varepsilon\|^2\), gives

\[
 E_C[p_\varepsilon]-\alpha _2\|p_\varepsilon\|^2
 \le C_7L_\varepsilon+C_8.                              \tag{16}
\]

All prime powers and both orientations are present in this upper bound.
Their core-internal part is finite because the core diameter is four, and
their departure part is included in (15).

## 4. Imposing the common constraints exactly

Let the independent real constraint functionals on the even core space be

\[
 \mathcal L_1x=\langle x,1_C\rangle,\qquad
 \mathcal L_2x=\langle x,a_c\rangle,\qquad
 \mathcal L_{2+j}x=(Jx)_j.                               \tag{17}
\]

The arrival functional \(a_c\) and all components of \(J\) are bounded on
core \(L^2\). Since the packet supports shrink and their \(L^2\) norms equal
one,

\[
 \mathcal L_i(p_\varepsilon)\longrightarrow0             \tag{18}
\]

for every \(i\). This follows directly from absolute continuity of the
\(L^2\) integral of each Riesz representer over the shrinking collars.

Choose smooth even functions \(z_1,\ldots,z_r\), all supported in one fixed
compact subset \([-2+\delta_0,2-\delta_0]\) of the open core, that are
biorthogonal to a maximal independent list of the functionals:

\[
 \mathcal L_i(z_j)=\delta_{ij}.                           \tag{19}
\]

Such a family exists because the union of smooth even compactly supported
interior tests is dense in even core \(L^2\). A linear combination of the
bounded functionals that vanished on every such test would have zero Riesz
representer and would not belong to the independent list. Once finitely many
tests give full rank, the union of their supports lies in one compact
interior interval, which defines \(\delta_0>0\).

Define the exactly corrected packet

\[
 x_\varepsilon
 =p_\varepsilon-\sum_{j=1}^r
   \mathcal L_j(p_\varepsilon)z_j.                       \tag{20}
\]

Then \(x_\varepsilon\in\mathcal K_{\rm ev}\), and (18) gives
\(\|x_\varepsilon-p_\varepsilon\|_{L^2}\to0\).
For small \(\varepsilon\), the correctors and packet have disjoint supports.
The multiplication form therefore has no cancellation on the packet
collars:

\[
 \int_CW_2|x_\varepsilon|^2d\nu
 \ge\int_CW_2|p_\varepsilon|^2d\nu
 \ge c_WL_\varepsilon^{3/2}.                             \tag{21}
\]

The jump-form inequality
\(|(p-z)(v)-(p-z)(w)|^2
 \le2|p(v)-p(w)|^2+2|z(v)-z(w)|^2\), together with (18),
shows that the fixed correction contributes \(o(1)\) times fixed form
energies. Thus, after enlarging constants,

\[
 E_C[x_\varepsilon]-\alpha _2\|x_\varepsilon\|^2
 \le C_9L_\varepsilon+C_{10}.                            \tag{22}
\]

## 5. Decisive failure and exact remaining scope

Since \(a>0\) is fixed,

\[
 \frac{a^{-1}\int_CW_2|x_\varepsilon|^2d\nu}
      {E_C[x_\varepsilon]-\alpha _2\|x_\varepsilon\|^2}
 \longrightarrow\infty                                  \tag{23}
\]

along any tail where the denominator is positive. If the denominator is
nonpositive on a subsequence, (1) already fails there because its left side
is positive. Therefore (1) fails for exactly constrained even form vectors.
No finite constant can make the pulled multiplication weight form-bounded
on \(\mathcal K_{\rm ev}\).

The failure mechanism is local and exact:

* the combined crossing row mass contributes one logarithm;
* the killed ground contributes its inverse square-root logarithm;
* pulling the product back through the adjacent continuous kernel integrates
  \(\sqrt{\log(1/y)}/(d+y)\), producing \(\log(1/d)^{3/2}\);
* the physical logarithmic core form sees only \(\log(1/\varepsilon)\).

This rules out the entire positive-kernel Cauchy route, including versions
that impose the current finite common constraints after taking the pulled
weight. It does not rule out an estimate for the original coherent quantity
\(Q(Bx,Bx)\). A successful argument must keep more of the \(v\)-dependence
inside \(Bx(u)\), rather than replacing its square by
\((B1_C)(u)B(|x|^2)(u)\).

## 6. Lean artifact

lean/ConstrainedHardyObstruction.lean formalizes:

* exact removal of finitely many linear constraints by a biorthogonal
  corrector family;
* the cubic-versus-quadratic growth comparison with
  \(t=\sqrt{\log(1/\varepsilon)}\);
* persistence of the growth obstruction after a bounded finite correction;
  and
* preservation of a packet lower bound when the fixed correctors have
  disjoint support.

It compiles with Lean 4.24 and contains no sorry or new axiom. The boundary
kernel estimates, packet form estimates, density of smooth even interior
tests, and convergence (18) are analytic inputs stated and proved above.
