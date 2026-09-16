# Positive-kernel Cauchy reduction and the radius-two endpoint obstruction

Fix \(C=[-2,2]\), \(O=\mathbb R\setminus C\), and the actual crossing
operator

\[
 (Bx)(u)=\frac1{b(u)}\int_{u+s\in C}\Phi(u+s)x(u+s)\,\eta(ds),
 \qquad u\in O,                                           \tag{1}
\]

where

\[
 \eta(ds)=r(|s|)\,ds+
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 (\delta_{\log n}+\delta_{-\log n})(ds),\qquad
 r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.                         \tag{2}
\]

Every prime power and both orientations occur in (2). Let
\(D\psi _2=\alpha _2\psi _2\) be the normalized positive even exterior
ground, put

\[
 \rho(u)=\frac{e^{-|u|/2}}{b(u)},\qquad
 a=\int_O\rho\psi _2\,d\nu>0,\qquad
 q(u)=\frac{\psi _2(u)}{\rho(u)}.                         \tag{3}
\]

This note proves the positive-kernel reduction used in the preceding
core-to-port note. It then tests its pointwise killed-potential certificate
at the hard boundary. The pointwise certificate fails there by an extra
square root of a logarithm. The constrained form comparison remains open.

## 1. Abstract kernel theorem

Let \((C,\nu_C)\) and \((O,\nu_O)\) be sigma-finite measure spaces. Let
\(K(u,dv)\) be a nonnegative kernel from \(O\) to \(C\), and assume the
displayed integrals below are defined in \([0,\infty]\). Set

\[
 (B_Kx)(u)=\int_Cx(v)K(u,dv),\qquad
 \ell_K(u)=K(u,C).                                       \tag{4}
\]

For every measurable complex \(x\), Cauchy-Schwarz against the single
measure \(K(u,dv)\) gives

\[
 |B_Kx(u)|^2
 \le \ell_K(u)\int_C|x(v)|^2K(u,dv).                    \tag{5}
\]

Let \(q\ge0\) be measurable and define the pulled measure

\[
 \mathsf W_K(dv)
 =\int_O q(u)\ell_K(u)K(u,dv)\,d\nu_O(u).                \tag{6}
\]

Tonelli applied to (5) gives the exact Jensen-Schur reduction

\[
 \boxed{\quad
 \int_Oq(u)|B_Kx(u)|^2\,d\nu_O(u)
 \le\int_C|x(v)|^2\,\mathsf W_K(dv).
 \quad}                                                  \tag{7}
\]

If \(\mathsf W_K\ll\nu_C\), write \(W_K=d\mathsf W_K/d\nu_C\). Then the
right side of (7) is \(\int_CW_K|x|^2d\nu_C\).

The order of operations matters. If

\[
 K=K_{\rm cont}+\sum_{n\ge2}\sum_{\sigma=\pm1}K_{n,\sigma}, \tag{8}
\]

then both \(B_Kx\) and \(\ell_K\) in (5) use the full sum (8). Expanding
\(q\ell_KK\) in (6) retains the continuous-continuous part, both mixed
continuous-prime parts, and every prime-power/orientation cross term.
No triangle inequality separates these columns.

For the theta crossing kernel, symmetry with respect to \(d\nu\) identifies

\[
 \ell=B1_C,\qquad
 W_2=B^*(q\ell),\qquad
 \kappa_C=B^*1_O.                                       \tag{9}
\]

Equations (3), (7), and (9) prove

\[
 \boxed{\quad
 Q(Bx,Bx)=\frac1a\int_Oq|Bx|^2d\nu
 \le\frac1a\int_CW_2|x|^2d\nu.
 \quad}                                                  \tag{10}
\]

The definition of \(W_2\) may first be read as an extended nonnegative
density. The failure result below needs only a rigorous lower bound for this
density. It does not assume a global pointwise upper bound for \(W_2\).

## 2. Continuous formulas near the positive endpoint

Write

\[
 v=2-d\in C,\qquad u=2+y\in O,\qquad d,y>0.              \tag{11}
\]

For the continuous part of (1),

\[
 \ell_{\rm c}(2+y)
 =\frac1{b(2+y)}\int_{-2}^{2}\Phi(z)r(2+y-z)\,dz,         \tag{12}
\]

\[
 \kappa_{{C},{\rm c}}(2-d)
 =\frac1{b(2-d)}
   \int_{2}^{\infty}\Phi(u)r(u-2+d)\,du
 +O(1).                                                  \tag{13}
\]

The \(O(1)\) in (13) is the continuous contribution from the negative
exterior component. It is uniform for small \(d\).

Choose a fixed \(0<\delta<1/4\). The singular constants can be chosen
explicitly. For \(0<t<1/2\),

\[
 \frac{e^{-1/4}}{2t}\le r(t)\le\frac1t.                  \tag{14}
\]

The lower inequality uses \(1-e^{-2t}\le2t\) and
\(e^{-t/2}\ge e^{-1/4}\). The upper inequality is the established
\(tr(t)<1\). Define the concrete collar extrema

\[
 \Phi_-=\min_{[2-\delta,2+\delta]}\Phi,\quad
 \Phi_+=\max_{[2-\delta,2+\delta]}\Phi,\quad
 b_-=\min_{[2-\delta,2+\delta]}b,\quad
 b_+=\max_{[2-\delta,2+\delta]}b.                       \tag{15}
\]

They are positive and finite. For example, the part of (12) with
\(z\in[2-\delta,2]\) gives the explicit lower bound

\[
 \ell_{\rm c}(2+y)\ge
 \frac{e^{-1/4}\Phi_-}{2b_+}
 \log\!\left(\frac{y+\delta}{y}\right).                 \tag{16}
\]

The same interval split, using the upper halves of (14)--(15) and a bounded
far part, gives the upper bound below. Thus, after shrinking the collar,

\[
 c_\ell\log(1/y)\le\ell(2+y)\le C_\ell\log(1/y)
 \qquad(0<y<\delta).                                    \tag{17}
\]

The prime part does not change this order. On the fixed \(u\)-collar its
crossing indicators leave only locally finite small shifts. The remaining
all-power series converges uniformly by the theta tail and
\(\Lambda(n)\le\log n\). All its summands are nonnegative.

The same argument in (13), plus uniform convergence of the complete prime
departure series on \(v\in[2-\delta,2]\), gives

\[
 \boxed{\quad
 \kappa_C(2-d)\le C_\kappa\log(1/d)
 \qquad(0<d<\delta).
 \quad}                                                  \tag{18}
\]

A matching lower logarithmic bound also follows from the positive
continuous integral, but only (18) is needed below.

## 3. The exterior ground changes one logarithm into three halves

Use \(G=\Phi\psi _2\). The proved two-sided boundary theorem for the actual
fixed killed ground gives constants \(c_G,C_G>0\) and a smaller collar with

\[
 \frac{c_G}{\sqrt{\log(1/y)}}\le G(2+y)
 \le\frac{C_G}{\sqrt{\log(1/y)}}.                        \tag{19}
\]

Because \(\Phi\rho\) is positive and smooth at \(u=2\), (19) is equivalent,
up to fixed collar constants, to

\[
 \frac{c_q}{\sqrt{\log(1/y)}}\le q(2+y)
 \le\frac{C_q}{\sqrt{\log(1/y)}}.                        \tag{20}
\]

Combining the lower halves of (17) and (20),

\[
 q(2+y)\ell(2+y)\ge c_1\sqrt{\log(1/y)}.                 \tag{21}
\]

Now retain only the continuous positive part in \(B^*(q\ell)\). Equations
(9), (11), (15), and the lower collar bounds for \(\Phi/b\) give

\[
 W_2(2-d)
 \ge c_2\int_0^\delta
       \frac{\sqrt{\log(1/y)}}{d+y}\,dy.                 \tag{22}
\]

For \(d<y<\delta\), \(d+y\le2y\), so

\[
 \begin{aligned}
 W_2(2-d)
 &\ge \frac{c_2}{2}\int_d^\delta
        \frac{\sqrt{\log(1/y)}}{y}\,dy\\
 &=\frac{c_2}{3}
   \left[(\log(1/d))^{3/2}-(\log(1/\delta))^{3/2}\right].
                                                               \tag{23}
 \end{aligned}
\]

Thus, after one final shrink of the collar,

\[
 \boxed{\quad
 W_2(2-d)\ge c_W(\log(1/d))^{3/2}.
 \quad}                                                  \tag{24}
\]

Reflection gives the same conclusion at \(-2\).

## 4. The pointwise certificate fails

The proposed pointwise sufficient condition was

\[
 \frac{W_2(v)}a+\alpha _2\le\kappa_C(v).                 \tag{25}
\]

Here \(a>0\) is a fixed finite number. Equations (18) and (24) show

\[
 \frac{W_2(2-d)}{a\,\kappa_C(2-d)}
 \ge c\,\sqrt{\log(1/d)}\longrightarrow\infty.           \tag{26}
\]

In particular there is \(d_0>0\) such that

\[
 \frac{W_2(2-d)}a+\alpha _2>\kappa_C(2-d),
 \qquad 0<d<d_0.                                        \tag{27}
\]

The first exact sign obstruction is the continuous adjacent endpoint
corner. Prime powers are nonnegative in \(W_2\) and cannot repair (27). The
obstruction does not depend on the enormous pointwise upper bound for
\(\psi _2\). It uses the proved lower boundary profile.

This local failure does not disprove

\[
 \frac1a\int_CW_2|x|^2d\nu
 \le E_{CC}[x]+\int_C(\kappa_C-\alpha _2)|x|^2d\nu,
 \qquad x\in\mathcal K_{\rm ev}.                         \tag{28}
\]

The internal logarithmic energy \(E_{CC}\) is absent from (25) and may pay
the extra \((\log(1/d))^{1/2}\) in (24). The remaining analytic problem is
now sharper: prove a boundary Hardy inequality for the weight
\((\log(1/d))^{3/2}\), with its exact \(W_2\) coefficient, on the common
mean, arrival, and observation nullspace. A uniform multiplication bound by
\(\kappa_C-\alpha _2\) is impossible.

## 5. Lean formalization

lean/PositiveKernelCauchy.lean proves the finite-kernel version of:

* the rowwise weighted Cauchy inequality;
* the exact pulled-weight inequality (7);
* its division by a positive normalization;
* combination of continuous and arithmetic kernel columns before Cauchy;
* combination of their row masses; and
* the implication from a pointwise killed-potential certificate to the
  energy inequality.

The finite theorem is the exact algebra used by simple-function
approximations of a nonnegative sigma-finite kernel. Tonelli and monotone
convergence are the analytic passage to (7). The module compiles with Lean
4.24 and has no sorry or new axiom. The endpoint bounds use the already
proved two-sided ground theorem and the displayed actual kernel formulas.
They are written proofs, not new Lean analytic theorems.
