# Causal clock mixers do not close the observation-null covariance

This note tests Hardy, Volterra, Mellin, scattering, and semigroup-style
mixing on the exact remaining subspace

\[
 K_J=\ker J\cap1_C^\perp\cap a_c^\perp\cap k_Q^\perp.
\tag{1}
\]

On this infinite-dimensional subspace the complete signed core form has no
finite observation, mean, or affine odd correction:

\[
 \boxed{\langle Hx,x\rangle
 =E_C[x]-\alpha\|x\|^2-a^{-1}\|\mathcal Sx\|_\gamma^2,
 \qquad x\in K_J.}
\tag{2}
\]

Thus the exact missing theta inequality is

\[
 \boxed{a^{-1}\|\mathcal Sx\|_\gamma^2
 \le E_C[x]-\alpha\|x\|^2\quad(x\in K_J).}
\tag{3}
\]

The result below does not disprove (3).  It proves that (3), or the
finite-\(X\) bulk estimate, cannot be obtained by inserting any bounded
causal/translation-covariant clock mixer and then using the actual
fixed-core crossing map.  A mixer that is not bounded below loses the
original covariance; a mixer that retains the late-clock profile still
has no bounded source correspondence through \(K_J\).

## 1. Exact flattening of the clock

Put \(t=e^u\) and

\[
 m(u)=e^uw(e^u).
\tag{4}
\]

The unitary clock flattening is

\[
 (\mathcal Vf)(u)=m(u)^{1/2}f(e^u),
 \qquad
 \mathcal V:L^2((0,\infty),w(t)dt)\to L^2(\mathbb R,du).
\tag{5}
\]

At the late-clock end,

\[
 m(u)=e^{-u}-\frac1{e^{e^u}-1}
 =e^{-u}(1+O(e^{u-e^u})).
\tag{6}
\]

Let \(L=\log2\), and let \(T=e^U\).  The normalized restriction of the
actual uncentered bulk field to \(T<t<2T\), after angular normalization by
the nonzero polynomial \(P_X\), satisfies

\[
 \mathcal Vg_U
 =h_X(\theta)\,\tau_U\varphi(u)+r_U,
 \qquad \|r_U\|=O_X(e^{-T}),
\tag{7}
\]

where

\[
 h_X=P_X/\|P_X\|_{L^2(d\omega_X)},\qquad
 \varphi(s)=c_Le^{-s/2}1_{[0,L]}(s),\qquad \|\varphi\|_2=1,
\tag{8}
\]

and \((\tau_Uf)(u)=f(u-U)\).  Formula (7) is the exact-weight version of
the late-shell asymptotic: (6) determines \(\varphi\), while the Lambert
error is \(O_X(e^{-T})\).

The central angular measure \(d\omega_X\), radial mean \(P_X\), and moving
clock cutoff are all retained.  Taking \(T\) above the moving cutoff only
partitions the original positive integral.

## 2. Translation-covariant bounded mixers

Let \(\mathscr M_X\) be a bounded operator on the flattened joint
angle-clock space and suppose

\[
 \mathscr M_X\tau_U=\tau_U\mathscr M_X
 \qquad(U\in\mathbb R).
\tag{9}
\]

This is the exact logarithmic-clock form of dilation covariance.  It
includes:

- Mellin multipliers and unit-modulus scattering multipliers;
- bounded causal convolutions
  \((Kh)(u)=\int_0^\infty k(s)h(u-s)ds\), including exponential
  Volterra kernels;
- dilation-covariant Hardy operators after the unitary conjugation (5);
- bounded compositions and angular matrix combinations of these
  operators.

Set

\[
 v_X=\mathscr M_X(h_X\otimes\varphi).
\tag{10}
\]

Boundedness, (7), and covariance give

\[
 \mathscr M_X\mathcal Vg_U
 =\tau_Uv_X+O_X(e^{-e^U}).
\tag{11}
\]

There are only two possibilities.

If \(v_X=0\), then

\[
 \|\mathscr M_X\mathcal Vg_U\|\to0
 \quad\text{while}\quad\|g_U\|=1.
\tag{12}
\]

The mixer has zero lower singular value on the actual late-clock family
and cannot transfer the original positive covariance.

If \(v_X\ne0\), translations are weakly null and their correlations
vanish at infinity:

\[
 \langle\tau_Uv_X,\tau_Vv_X\rangle\to0
 \quad(|U-V|\to\infty).
\tag{13}
\]

After taking a separated sequence \(U_j\), the mixed actual sources remain
uniformly separated.  They have not been returned to one compact theta
region; the mixer has merely translated one fixed output profile.

This dichotomy proves

\[
 \boxed{\text{every bounded translation-covariant mixer either kills the
 actual late profile or retains a separated translate family.}}
\tag{14}
\]

## 3. Theta multiplier and scattering

In flattened coordinates the ordinary physical theta insertion has
multiplier

\[
 s(u)^2=\frac{M\Phi(u)}{\cosh(u/2)},
 \qquad s(u)\to0\quad(u\to+\infty).
\tag{15}
\]

It is bounded.  For every fixed \(v\) in the joint source space,
dominated convergence gives

\[
 \|s\,\tau_Uv\|^2
 =\int s(U+y)^2|v(y)|^2dy\longrightarrow0.
\tag{16}
\]

Consequently, in the nonzero case of (14),

\[
 \|s\,\mathscr M_X\mathcal Vg_U\|\to0.
\tag{17}
\]

A unitary scattering multiplier commutes with translations and preserves
the norm before multiplication by \(s\); it does not change this
conclusion.  More generally, every bounded Mellin response is already
included in \(\mathscr M_X\).

The actual all-place theta semigroup is not a logarithmic translation
multiplier: its theta density and prime-return coefficients depend on
location.  No identity has been proved that makes it intertwine the
Lambert dilation histories.  If one requires such a semigroup-based mixer
to satisfy the exact covariance (9), it falls under (14).  If covariance
is dropped, using the semigroup is a different nonlocal proposal and must
prove directly that it preserves the Lambert source form; boundedness or
the Markov property alone does not do so.  A fixed-core heat regularizer is
compact because the fixed core has compact resolvent, so it also cannot
provide a bounded inverse on the separated family.

## 4. Restriction to the observation-null subspace

The restriction

\[
 \mathcal S|_{K_J}:K_J\cap D(E_C)\longrightarrow L^2(\gamma)
\tag{18}
\]

is compact, since \(\mathcal S:D(E_C)\to L^2(\gamma)\) is compact.  The
extra null constraints do not improve its lower singular value.

Let \(\mathcal W_\gamma\) denote the exact unitary from the flattened
clock space to the density-matched \(L^2(\gamma)\) source space.  Suppose a
mixed angularly collective source correspondence existed with uniformly
bounded preimages \(x_j\in K_J\):

\[
 \mathcal Sx_j=\mathcal W_\gamma\tau_{U_j}v_X+o(1),
\tag{19}
\]

If the mixer has finitely many angular channels, use the
finite direct sum of (18).  If it is pointwise in angle, apply a bounded
angular functional for which the corresponding component of \(v_X\) is
nonzero.  In either case (13) makes the right side non-precompact, whereas
compactness of (18) makes \(\{\mathcal Sx_j\}\) precompact.  This is a
contradiction.

If instead \(v_X=0\), (12) shows that the mixed source cannot dominate
\(\|\mathcal Sx\|_\gamma\), so replacing the last term of (2) by the mixed
norm would prove only a weaker inequality and would not establish (3).

Hence clock mixing does not yield the missing weighted-covariance estimate
on \(K_J\):

\[
 \boxed{\text{no bounded causal/translation-covariant mixer gives both
 a lower bound for the actual covariance and a bounded source
 correspondence through }\mathcal S|_{K_J}.}
\tag{20}
\]

## 5. Complete field and the first affine row

The argument uses the uncentered complete field.  Its \(a=1\) term is the
radial profile in (7).  The \((1,2)\) row remains before mixing with
coefficient

\[
 2\int_{T}^{2T}(1-e^{-t})^2e^{-t}w(t)dt>0
\tag{21}
\]

and with its unchanged affine Möbius correlation.  A mixer can annihilate
this row only by putting that source direction in its kernel; then it is
not form preserving for the complete signed field.  Angular truncation and
the moving lower endpoint are unchanged.

## 6. Scope

The no-go theorem (20) covers bounded mixers that respect logarithmic
clock translations/dilations, including the natural Hardy, Volterra,
Mellin, and scattering constructions, with arbitrary bounded angular
mixing.  It also covers compact fixed-core semigroup regularization.

It does not cover an arbitrary abstract isometry, a location-dependent
operator that breaks clock dilation covariance, or a nonlinear estimate
tailored to the single unsplit field.  For such a proposal, the required
content is already the genuinely nonlocal arithmetic inequality

\[
 \mathfrak A_X^{\rm bulk}\ll_\varepsilon X^{1+\varepsilon}
\tag{22}
\]

or, on the theta side, the weighted covariance inequality (3) together
with an exact Lambert-to-crossing source correspondence.  Neither follows
from the explicit \(P_\infty\), the finite observations, or positivity of
a compression of \(H\).
