# Collective Lambert-to-theta Gram: exact kernel and first signed block

## Classification

The fully summed Lambert central form is an exact positive Toeplitz Gram
before any absolute value is taken. Its coefficient array retains every
quotient layer:

\[
 c_{N,X}(t)=e^{-N/X}(1-e^{-t})
 \sum_{d\mid N}\mu(d)e^{-(N/d-1)t}.                  \tag{1}
\]

Writing the form with (1) preserves all interference between angular
frequencies. A proposed theta comparison has a similarly exact Gram form
only after a source realization \(S_{N,t}\) has been specified. The
complete theta covariance then retains the continuous jump kernel, both
orientations, and every prime power inside its resolvent.

The smallest hard-clock frequency block, \(N=1,2\), already has a strong
signed cancellation. Its actual coefficient vector is proportional to
\((1,-s_X(t))\), with \(s_X(t)=1+O(X^{-1})\), and the central Gram on that
vector is only \(O(X^{-1})\) of its diagonal size. It is nonnegative, not
a negative counterexample. The common-mode line is coercive, while the
actual hard-clock row lies near the weak antisymmetric line.

No finite comparison with the complete theta covariance can yet be
decided, because the corresponding source vectors \(S_{1,t}\) and
\(S_{2,t}\) have not been constructed. Positivity of the theta covariance
does not determine the energy of their difference. The first missing
scalar is the complete covariance

\[
 \|S_{1,t}-s_X(t)S_{2,t}\|_{\mathcal R_R}^2.          \tag{2}
\]

This identifies a plausible comparison subspace and the exact finite test,
but supplies neither a passing comparison nor a counterexample for the
actual theta source.

## 1. The complete central Gram

Put \(r=e^{-1/X}\), \(q=e^{-t}\), and

\[
 p_a(t)=(1-q)q^{a-1}.
\]

The exact Lambert expansion is

\[
 H_t(re^{i\theta})
 =\sum_{a,d\ge1}p_a(t)\mu(d)e^{-ad/X}e^{iad\theta}
 =\sum_{N\ge1}c_{N,X}(t)e^{iN\theta}.                \tag{3}
\]

Thus nonsquarefree terminal divisors vanish through \(\mu(d)\), while
every quotient collision \(N=ad\) remains in (1). This does not remove
proper prime powers from theta: they belong to the complete theta
background covariance below rather than to the terminal Möbius label.

For the central window define

\[
 \Theta_X(t)=
 \{\theta:|\theta|<X^{-1/2},\ t>b_\varepsilon(\theta)\},
\]

\[
 K_{X,t}(N,M)=
 \frac{w(t)}{2\pi}\int_{\Theta_X(t)}
 \frac{e^{i(N-M)\theta}}
      {|1-re^{i\theta}|^2}\,d\theta.                 \tag{4}
\]

The set and denominator are reflection invariant, so \(K_{X,t}\) is a
real symmetric Toeplitz kernel. For every finite coefficient vector \(z\),

\[
 \sum_{N,M}z_N\overline{z_M}K_{X,t}(N,M)
 =\frac{w(t)}{2\pi}\int_{\Theta_X(t)}
   \frac{|\sum_Nz_Ne^{iN\theta}|^2}
        {|1-re^{i\theta}|^2}\,d\theta\ge0.            \tag{5}
\]

The fully summed central remainder is

\[
 \boxed{
 \mathcal R_X^\varepsilon
 =\sum_{N,M\ge1}\int_0^\infty
 c_{N,X}(t)\overline{c_{M,X}(t)}
 K_{X,t}(N,M)\,dt.}                                 \tag{6}
\]

Equivalently, before grouping quotient collisions,

\[
 \mathcal R_X^\varepsilon
 =\sum_{a,d,b,e\ge1}\mu(d)\mu(e)e^{-(ad+be)/X}
 \int_0^\infty p_a(t)p_b(t)
 K_{X,t}(ad,be)\,dt.                                \tag{7}
\]

Equations (6)--(7) retain every angular frequency, quotient layer, clock,
and signed cross term before squaring. Formula (5), rather than
entrywise positivity, is the source of nonnegativity.

## 2. The complete theta covariance Gram

Let

\[
 \mathcal R_R=(a_R+A_{{\rm rem},R})^{-1}
\]

on the centered subspace of \(L^2(\gamma_R)\). The residual generator
contains the continuous remainder and every atom
\(\pm\log p^k\), for every prime power \(p^k\). Reflection commutes with
\(\mathcal R_R\).

Suppose an actual collective source realization has been constructed.
For every \(\lambda=(a,d,t)\), let
\(S_\lambda^\rightarrow\) and \(S_\lambda^\leftarrow\) be its two
oriented centered weighted sources, after the common affine subtraction.
Set

\[
 S_\lambda^\pm=
 2^{-1/2}(S_\lambda^\rightarrow\pm S_\lambda^\leftarrow).
\]

The complete covariance entry is

\[
 \Theta_R(\lambda,\lambda')
 =\sum_{\sigma\in\{+,-\}}
 \langle\mathcal R_RS_\lambda^\sigma,
                    S_{\lambda'}^\sigma\rangle_{\gamma_R}.  \tag{8}
\]

The exact pulled-back theta form would be

\[
 \boxed{
 \mathcal Q_{X,R}^\theta
 =\sum_{a,d,b,e}\mu(d)\mu(e)e^{-(ad+be)/X}
 \int\!\!\int p_a(t)p_b(s)
 \Theta_R((a,d,t),(b,e,s))\,dt\,ds.}                \tag{9}
\]

Both orientations occur in (8); all prime powers occur inside
\(\mathcal R_R\). The odd affine regression, when used, subtracts its
exact positive rank-one Gram in the odd block and must be included in
\(\Theta_R\), not appended after an entrywise estimate.

Formula (9) is exact conditional on the source realization. No published
map assigns the Lambert labels \((a,d,t)\) to these weighted sources with
an \(e^{o(X)}\) norm. Consequently (9) is presently a certificate format,
not an evaluated comparison.

## 3. The exact \(N=1,2\) central block

At fixed \(t\), equation (1) gives

\[
 c_{1,X}(t)=e^{-1/X}(1-q),
\]

\[
 c_{2,X}(t)=e^{-2/X}(1-q)(q-1)
            =-s_X(t)c_{1,X}(t),\qquad
 s_X(t)=e^{-1/X}(1-q).                               \tag{10}
\]

Put

\[
 k_0=K_{X,t}(1,1),\qquad k_1=K_{X,t}(1,2).
\]

Since the window is symmetric,

\[
 k_0-k_1=
 \frac{w(t)}{2\pi}\int_{\Theta_X(t)}
 \frac{1-\cos\theta}{|1-re^{i\theta}|^2}\,d\theta.
\]

For \(X\ge1\), \(|\theta|\le X^{-1/2}\) gives

\[
 0\le k_0-k_1\le\frac{k_0}{2X}.                     \tag{11}
\]

The signed block contraction is exactly

\[
 \begin{split}
 &|c_{1,X}(t)|^2
 \{k_0(1+s_X(t)^2)-2k_1s_X(t)\}\\
 &\qquad=
 |c_{1,X}(t)|^2
 \{k_0(1-s_X(t))^2+2s_X(t)(k_0-k_1)\}.              \tag{12}
 \end{split}
\]

For \(t\ge\log X\), \(q\le X^{-1}\), \(0\le s_X(t)\le1\), and

\[
 0\le1-s_X(t)
 \le (1-e^{-1/X})+q\le\frac2X.
\]

Combining this with (11) yields

\[
 0\le (12)\le
 |c_{1,X}(t)|^2k_0\left(\frac4{X^2}+\frac1X\right). \tag{13}
\]

The diagonal majorant of the same block is
\(|c_1|^2k_0(1+s_X^2)\). Hence its signed-to-diagonal ratio is
\(O(X^{-1})\) throughout the hard-clock region. This is cancellation in
the actual quotient-summed coefficient array, not a deletion of a
positive term.

The two eigenlines of the Toeplitz matrix are the common mode \((1,1)\),
with eigenvalue \(k_0+k_1\), and the difference mode \((1,-1)\), with
eigenvalue \(k_0-k_1\). Thus the common-mode subspace is a plausible
coercive block, but the actual hard-clock coefficient vector in (10)
approaches the weak difference mode.

## 4. The first theta generalized-eigenvalue test

For the corresponding two theta sources write

\[
 A=\langle\mathcal R_RS_1,S_1\rangle,\quad
 B=\Re\langle\mathcal R_RS_1,S_2\rangle,\quad
 C=\langle\mathcal R_RS_2,S_2\rangle.                \tag{14}
\]

Their energy on the actual signed row is

\[
 Q_R(s)=A-2sB+s^2C
       =\|\mathcal R_R^{1/2}(S_1-sS_2)\|^2.          \tag{15}
\]

Positivity gives \(A,C\ge0\) and \(B^2\le AC\), but it gives no positive
lower bound for (15). Both extremes are compatible with those facts:

* if the transformed sources coincide, \(Q_R(1)=0\);
* if they are orthogonal with equal norm, \(Q_R(1)=2A\).

Therefore positivity, parity, and retention of prime powers do not decide
the first block. A comparison
\(G_{X,t}\le L_XQ_{R,t}\) on this block is equivalent to positivity of
the residual matrix

\[
 \begin{pmatrix}
 L_XA-k_0&L_XB-k_1\\
 L_XB-k_1&L_XC-k_0
 \end{pmatrix}.                                      \tag{16}
\]

For a real symmetric \(2\times2\) matrix this means its two diagonals are
nonnegative and

\[
 (L_XB-k_1)^2
 \le(L_XA-k_0)(L_XC-k_0).                            \tag{17}
\]

The reverse comparison uses the reversed residual. Equations (14)--(17)
are the smallest finite interval certificate to evaluate. No entry in
(14) is currently published, because \(S_1,S_2\) themselves depend on
the missing collective source map.

## 5. Consequence for the collective route

The \(N=1,2\) computation gives no negative finite counterexample to the
complete theta covariance. It instead shows that any useful comparison
must preserve a cancellation of relative size \(X^{-1}\) already in the
first Lambert block. Entrywise absolute values lose it.

The common-mode line is locally coercive but does not contain the hard
clock coefficient row. Enlarging the block makes the central kernel a
short-arc concentration matrix; its weak directions encode increasingly
many moment cancellations of the Möbius coefficient vector. A uniform
collective comparison therefore needs a source map that matches those
weak directions in the complete theta covariance. The first required
datum is (15), followed by the finite residual test (17).

This leaves the moving analytic estimate explicit: after constructing
the source map and passing the finite Gram comparison, the
[moving-radius audit](theta-moving-radius-weighted-covariance-audit.md)
supplies only the source-specific denominator and localized-tail bounds.
It does not manufacture the Gram entries in (14). No claim here assumes
RH or proves the full theta comparison.
