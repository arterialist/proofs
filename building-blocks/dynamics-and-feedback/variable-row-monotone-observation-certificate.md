# Variable-row and monotone canonical-observation certificate

## Outcome

The finite-Gram prototype now uses the actual number of observation rows.
If the canonical observation has complex dimension \(d\), a joint-nullspace
calculation has

\[
  2+2d                                                     \tag{1}
\]

real rows: mean, ground arrival \(a_c\), and the real and imaginary parts of
all \(d\) coordinates.  No part of the finite construction assumes \(d=1\).

The effective route chosen here is a monotone Galerkin/Schur semidecision.
It needs no preselected “successful” pair \((M,L)\).  Each canonical finite
edge projection gives a global positive under-approximation of the full
one-jump observation.  If any enumerated stage passes the signed Schur test,
that stage proves the full comparison.  Failure of finitely many stages has
no negative meaning.

No actual stage can yet be populated.  The current source has an explicit
radius-two interval for \(\alpha_2\), but no validated \(\psi_2\), second
spectral floor, or signed low-block entries.

## 1. Exact variable-row projection

Let \(h_1,\ldots,h_m\) be real even raw splines.  For a complex observation
\(J:H_C\to\mathbb C^d\), define the real row map

\[
 \mathcal Lh=\bigl(
 \langle h,1_C\rangle,\langle h,a_c\rangle,
 \Re(Jh)_0,\Im(Jh)_0,\ldots,
 \Re(Jh)_{d-1},\Im(Jh)_{d-1}\bigr)\in\mathbb R^{2+2d}.
                                                               \tag{2}
\]

Choose correction functions \(z_1,\ldots,z_{2+2d}\) with
\(\mathcal L_rz_s=\delta_{rs}\), and put

\[
 \phi_j=h_j-\sum_{r=1}^{2+2d}(\mathcal L_rh_j)z_r.         \tag{3}
\]

Then \(\mathcal L\phi_j=0\) exactly.  A raw mesh needs at least
\(2+2d+N\) independent functions to leave an \(N\)-dimensional constrained
space.  The old five-hat mesh can leave one generic direction only in the
conditional case \(d=1\); it is not an actual-source mesh once \(d\) is
unknown.

For interval computation, form the constraint matrix

\[
 D_{rs}=\mathcal L_r(g_s),                                 \tag{4}
\]

certify its invertibility, and evaluate (3) with a verified inverse.  An
interval residual merely containing zero is not proof of exact membership;
the algebraic definition (3) supplies exact cancellation and interval
arithmetic encloses only the resulting coefficients and Gram entries.

Any interval implementation must record

```text
constraints.observation_dimension_complex = d
constraints.row_names =
  mean, a_c, Re_J_0, Im_J_0, ..., Re_J_(d-1), Im_J_(d-1)
```

and rejects any other row count.

## 2. A genuinely nested canonical observation

The individual dyadic partition maps \(\mathcal O_{M,L}\) from the preceding
note are coefficient-one contractions, but partitions at different windows
need not literally be nested.  For the monotone certificate use the
following cumulative construction.

Enumerate lexicographically all labelled compact edge cells

\[
 D_r=D_{q,\sigma,I},                                      \tag{5}
\]

where \(q=p^k\), \(\sigma=\pm1\), and \(I\) is a rational dyadic interval.
The cell is intersected with a rational exterior window and uses the full
one-jump density

\[
 d\mathsf P_1=
 \frac{\Lambda(q)}{\sqrt q}
 \frac{\psi(u)\psi(v)\Phi(u)\Phi(v)}
 {(a+\ell(u))(a+\ell(v))}\,du,
 \qquad v=u+\sigma\log q.                                 \tag{6}
\]

Thus every finite stage contains finitely many complete \(p^k\) branches
and both orientations, while the denominators retain the departure rate of
all prime powers.

Let \(\chi_r=1_{D_r}\in L^2(\mathsf P_1)\).  Apply deterministic
Gram--Schmidt in enumeration order, setting a dependent or zero vector to
zero.  Let \(e_r\) denote the resulting orthonormal nonzero filters and

\[
 P_nh=\sum_{r\le n}\langle h,e_r\rangle e_r.              \tag{7}
\]

Then \(P_n\le P_{n+1}\le I\), and the density of rational simple functions
gives \(P_n\to I\) strongly.  Define

\[
 C_\infty x=A_\infty(Tx-c_Q(x)q),\qquad
 C_nx=P_nC_\infty x.                                      \tag{8}
\]

The exact operator order is

\[
 \boxed{0\le C_n^*C_n\le C_{n+1}^*C_{n+1}
                  \le C_\infty^*C_\infty.}                \tag{9}
\]

It follows only from orthogonal projection and preserves coefficient one:

\[
 \|C_nx\|^2\le\|C_\infty x\|^2
              \le\mathscr D(Tx-c_Q(x)q).                  \tag{10}
\]

All unobserved continuous energy, longer prime histories, and omitted
prime-edge cells remain in the nonnegative difference.  They are not
deleted from the original theta form.

The order in (9) is on one fixed core Hilbert space and one common form
domain.  The codomains of the observations may grow because they are
identified with nested subspaces of the complete edge space.  If instead
one imposes every observation coordinate as a constraint, the spaces

\[
 K_n=\ker L_{\rm mean}\cap\ker L_{a_c}\cap\ker C_n
\]

shrink: \(K_\infty\subset K_{n+1}\subset K_n\).  Positivity on a finite
\(K_n\) then restricts to \(K_\infty\), but matrices formed in separately
chosen bases of the changing \(K_n\) are not Loewner-comparable.  The
positive-Gram argument below uses the fixed-domain interpretation and does
not infer (9) from changing nullspace matrices.

For a low core basis \(u_1,\ldots,u_N\), the finite observation Gram is

\[
 (G_n)_{ij}=\langle C_nu_j,C_nu_i\rangle.                 \tag{11}
\]

One can avoid explicit Gram--Schmidt.  Put

\[
 R_{rs}=\langle\chi_s,\chi_r\rangle_{L^2(\mathsf P_1)},
 \qquad V_{rj}=\langle C_\infty u_j,\chi_r\rangle.         \tag{12}
\]

For the first \(n\) raw cells,

\[
 \boxed{G_n=V_n^*R_n^\dagger V_n,}                        \tag{13}
\]

with the Moore--Penrose inverse on the certified range of \(R_n\).  A
validated replay must either certify the nonzero pivots in Gram--Schmidt or
give a rank-revealing interval factorization of \(R_n\).  Formula (13)
combines overlapping filters coherently; entrywise absolute bounds would
lose the useful cancellation.

## 3. Monotone signed-core certificate

Let \(H_0\) denote every signed term other than the one-jump observation:

\[
 H_0=L_C-\alpha I+a_c\otimes1+1\otimes a_c
 -a^{-1}\mathcal S^*\mathcal S+d_Q^{-1}k_Q\otimes k_Q.    \tag{14}
\]

Define

\[
 H_n=H_0+C_n^*C_n,qquad
 H_\infty=H_0+C_\infty^*C_\infty.                         \tag{15}
\]

Equation (9) gives \(H_n\le H_\infty\).  Therefore

\[
 \boxed{H_n\ge0\quad\Longrightarrow\quad H_\infty\ge0.} \tag{16}
\]

No observation-tail estimate occurs in this implication.

For the first \(N\) killed-core modes, enclose

\[
 H_{n,N}=H_{0,N}+G_{n,N},qquad
 h_{n,N}\le\lambda_{\min}(H_{n,N}).                       \tag{17}
\]

Let \(C_{V,n}\) bound \(H_n-L_C\) and
\(\Lambda_{N+1}\le\lambda_{N+1}(L_C)\).  The exact optimized two-block test
is

\[
 h_{n,N}>0,qquad
 g_{n,N}:=\Lambda_{N+1}-C_{V,n}>0,qquad
 \boxed{h_{n,N}g_{n,N}\ge C_{V,n}^2.}                    \tag{18}
\]

When (18) holds, one may choose

\[
 C_{V,n}^2/g_{n,N}\le\varepsilon\le h_{n,N}              \tag{19}
\]

in the finite-block Young inequality, proving \(H_n\ge0\), hence (16).

The exact-rational Schur inequalities (17)--(19) are suitable for a future interval implementation.  No numerical stage is published here: the available sources do not supply a validated low block, complement floor, or observation Gram.  The actual classification is therefore

> **INCOMPLETE — no finite stage has been evaluated.**

## 4. Why this removes a stopping choice, and what it does not prove

The fixed canonical enumeration produces these cells successively.  A passing stage is a
complete proof and needs no assertion that the stage is “large enough.”
This is a semidecision procedure: it may run forever if the full signed form
has zero bottom or is negative.

If a separate argument proves a strict full margin

\[
 H_\infty\ge mI,qquad m>0,                               \tag{20}
\]

and supplies an observation-tail modulus

\[
 \|(C_\infty^*C_\infty-C_n^*C_n)|_{D(E_C)\to D(E_C)^*}
 \le t_n<m,                                               \tag{21}
\]

then \(H_n\ge(m-t_n)I\), giving an explicit stopping stage.  The published
compactness proof supplies neither \(m\) nor \(t_n\).  Qualitative strong
convergence alone does not give a computable index.

Compact resolvent still gives a useful qualitative completeness statement:
monotone closed-form convergence makes the spectral bottoms of \(H_n\)
increase to that of \(H_\infty\), provided the common semibounded form
domain is retained.  Thus a strictly positive full bottom forces eventual
success, but this statement is not an effective numerical bound.

## 5. First actual interval data

The existing triangular radius-two Rayleigh certificate gives the proved
rational bounds

\[
 \frac12-10^{-20}\le\alpha_2
 <\frac12-10^{-546},                                     \tag{22}
\]

equivalently

\[
 10^{-546}<\frac12-\alpha_2\le10^{-20}.                  \tag{23}
\]

The existing [radius-two rational-gap certificate](../theta-and-heat/theta-radius-two-rational-gap-propagation.md) and its [exact rational replay](../../formalization/verification/theta_radius_two_J3_rational_upper_check.py) prove the lower gap endpoint from the finite theta-series estimate.  This is usable immediately wherever only an outward interval for \(\alpha_2\) is required.

It is not an eigenfunction certificate.  The first observation entries
(6), (12), and (13) still require:

* a validated normalized Galerkin vector \(\psi_h\);
* a strong residual bound;
* a lower separation from the second exterior eigenvalue;
* a weighted/local sup-norm error enclosure;
* positive rational intervals for \(a\) and \(\mu\); and
* finite-head plus all-power tails for the departure rate \(\ell\).

The interval (22) does not provide any of these profile data.  Thus it is
the first actual scalar input, not a claim that an observation Gram entry
has been evaluated.

## 6. Formal status

The formal artifact is `BuildingBlocks/MonotoneObservationSchur.lean`.  The existing canonical observation ledger and radius-two rational-gap certificate provide source definitions and the first scalar interval, but no stage data are encoded as a numerical certificate.

The Lean module proves finite-stage lifting (16), the tail-margin
variant (20)--(21), the optimized two-block product test, and the variable
constraint count.  It compiles with Lean 4.24.0, warnings treated as errors,
with no `sorry` and no new axioms.  Operator convergence and all theta
matrix entries remain explicit analytic hypotheses.
