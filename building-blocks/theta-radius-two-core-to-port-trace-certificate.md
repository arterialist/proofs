# Radius-two core-to-port trace certificate

This note addresses only the surviving even joint-null comparison

\[
 Q(Tx,Tx)\le E_C[x]-\alpha _2\|x\|_C^2,
 \qquad x\in\mathcal K_{\rm ev},                         \tag{1}
\]

for the actual split $C=[-2,2]$, $O=\mathbb R\setminus C$.  It does not
assert the sharp theta gap or RH.  The complete continuous kernel, both
orientations of every prime power, the killed endpoint cost, and the common
score constraints are retained.

## 1. The exact radius-two objects

Put

\[
 b(u)=2\cosh(u/2),\qquad d\nu=b\Phi\,du,\qquad
 \rho(u)=\frac{e^{-|u|/2}}{b(u)},
\]

and

\[
 \eta(ds)=r(|s|)\,ds+
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       (\delta_{\log n}+\delta_{-\log n})(ds),
 \qquad r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.                 \tag{2}
\]

The positive core-to-exterior operator is

\[
 (Bx)(u)=\frac1{b(u)}\int_{u+s\in C}\Phi(u+s)x(u+s)\,\eta(ds). \tag{3}
\]

Thus (3) contains the continuous integral and the two terms

\[
 \frac1{b(u)}\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \left[
  1_C(u+\log n)\Phi(u+\log n)x(u+\log n)
 +1_C(u-\log n)\Phi(u-\log n)x(u-\log n)
 \right].                                                \tag{4}
\]

Let $D\psi _2=\alpha _2\psi _2$ be the normalized positive even killed
ground, and set

\[
 d\gamma=\rho\psi _2\,d\nu,\qquad
 a=\gamma(O)=\int_O\rho\psi _2\,d\nu>0.                \tag{5}
\]

On

\[
 \mathcal K_{\rm ev}=\{x\in D(E_C)_{\rm ev}:
 \langle x,1_C\rangle=0,
 \langle x,a_c\rangle=0,
 Jx=0\},                                                  \tag{6}
\]

the ground centering vanishes, so $Tx=Bx$, and parity removes the odd
affine column.  Therefore the port form in (1) is exactly

\[
 Q(Bx,Bx)=\frac1a\int_O\frac{\psi _2(u)}{\rho(u)}
                         |Bx(u)|^2\,d\nu(u).              \tag{7}
\]

## 2. The strongest published trace estimate and an explicit constant ledger

The published weighted-crossing theorem proves

\[
 \|\rho^{-1/2}B x\|_{L^2(O,\nu)}\le B_\rho\|x\|_{L^2(C,\nu)}. \tag{8}
\]

Its proof can be made into the following nonnumerical but fully explicit
radius-two ledger.  After conjugation to Lebesgue measure, the continuous
kernel is

\[
 K_c(u,v)=r(|u-v|)
 \sqrt{\frac{e^{|u|/2}\Phi(u)\Phi(v)}{b(v)}}.            \tag{9}
\]

Use the two endpoint rectangles

\[
 R_+=(2,3)\times(1,2),\qquad R_-=(-3,-2)\times(-2,-1)
\]

in ((u,v)\).  Since $t r(t)<1$, each local singularity is bounded by its
smooth-factor supremum times (1/(s+t)).  Define

\[
 M_{\rm loc}:=
 \sup_{(u,v)\in R_+}
 \sqrt{\frac{e^{u/2}\Phi(u)\Phi(v)}{b(v)}}               \tag{10}
\]

(the negative endpoint has the same value by evenness), and

\[
 H_{\rm rem}^2:=
 \iint_{(O\times C)\setminus(R_+\cup R_-)}|K_c(u,v)|^2\,du\,dv. \tag{11}
\]

The separation from the two adjacent corners and theta decay make (11)
finite.  The Carleman norm is exactly $\pi$, hence

\[
 \|\rho^{-1/2}B_c\|\le2\pi M_{\rm loc}+H_{\rm rem}.      \tag{12}
\]

For the full prime part put

\[
 P_2:=\sum_{n\ge2}\sum_{\sigma=\pm1}\Lambda(n)
 \sup_{v\in[-2,2]}
 \sqrt{\frac{e^{|v+\sigma\log n|/2}
                 \Phi(v+\sigma\log n)\Phi(v)}
                {n\,b(v)}}.                              \tag{13}
\]

The theta tail makes (13) convergent; proper prime powers and both
orientations remain in the sum.  One may therefore take

\[
 \boxed{B_\rho^{\rm pub}=2\pi M_{\rm loc}+H_{\rm rem}+P_2.} \tag{14}
\]

If $P_\infty\ge\|\psi _2\|_\infty$, (7)--(8) give

\[
 Q(Bx,Bx)\le \frac{P_\infty(B_\rho^{\rm pub})^2}{a}\|x\|^2. \tag{15}
\]

Writing

\[
 \lambda_{C,K}=\inf_{0\ne x\in\mathcal K_{\rm ev}}
                  \frac{E_C[x]}{\|x\|^2},                \tag{16}
\]

the scalar certificate is

\[
 \frac{P_\infty(B_\rho^{\rm pub})^2}{a}
       \le\lambda_{C,K}-\alpha _2.                       \tag{17}
\]

This is the sharpest consequence of the presently published *norm* proof.
It cannot currently be evaluated: the barrier supplies only a huge upper
bound for $P_\infty$; (14) has not been interval-evaluated; no useful
positive lower enclosure for $a$, nor a validated lower enclosure for
(16), is published.  The proved interval
$10^{-2918}<1/2-\alpha _2<10^{-20}$ does not fill any of these gaps.

## 3. A stronger cancellation-aware Jensen--Schur trace bound

There is an exact improvement that avoids $P_\infty\|B\|^2$. Regard (3)
as integration against its positive crossing kernel $k(u,dv)$, relative to
core measure, and put

\[
 \ell(u)=(B1_C)(u),\qquad
 W_2=B^*\!\left(\frac{\psi _2}{\rho}\ell\right).         \tag{18}
\]

Cauchy--Schwarz against the same arrival measure, before separating the
continuous and prime parts, gives

\[
 |Bx(u)|^2\le \ell(u)B(|x|^2)(u).                        \tag{19}
\]

Tonelli and adjointness then give the complete trace estimate

\[
 \boxed{
 Q(Bx,Bx)\le\frac1a\int_C W_2(v)|x(v)|^2\,d\nu(v).}      \tag{20}
\]

All continuous--prime and prime--prime coherence has been retained until the
single positive-kernel Cauchy step.  In particular, $W_2$ contains the full
square of the combined crossing column, rather than separate norms for its
summands.

Let

\[
 \kappa_C=B^*1_O.                                        \tag{21}
\]

The killed core form decomposes exactly as

\[
 E_C[x]=E_{CC}[x]+\int_C\kappa_C(v)|x(v)|^2\,d\nu(v),
 \qquad E_{CC}[x]\ge0.                                  \tag{22}
\]

Consequently the pointwise condition

\[
 \boxed{\quad W_2(v)/a+\alpha _2\le\kappa_C(v)
       \quad\text{for a.e. }v\in[-2,2]\quad}             \tag{23}
\]

would prove (1), even without using the constraints.  The weaker and more
relevant constrained Hardy condition is

\[
 \int_C\frac{W_2}{a}|x|^2d\nu
 \le E_{CC}[x]+\int_C(\kappa_C-\alpha _2)|x|^2d\nu,
 \qquad x\in\mathcal K_{\rm ev}.                         \tag{24}
\]

Equations (18), (21), and (24) are the first explicit scalar/function data
for a direct trace proof.  No source inspected here gives a rigorous
enclosure of $W_2/a-\kappa_C+\alpha _2$, so (23) is a proposed certificate,
not a proved sign.  Unlike (17), it is sensitive to the common support and to
the actual combined arrival column.

## 4. Three mechanisms tested after the exterior reserve cancellation

### 4.1 Endpoint Hardy/Carleman mechanism

The local singularity is exactly Carleman-type and (12) is rigorous.  But it
controls the crossing by the core $L^2$ norm.  The needed comparison is
form-relative, namely (24).  The published logarithmic boundary layer is for
the *exterior ground*; it supplies no core Hardy inequality with the weight $W_2$.  Thus the first missing statement in this mechanism is precisely
(24), with a constant at most one.  Reusing the Carleman norm (pi) as that
constant is invalid because the right-hand norms differ.

### 4.2 Positive edge routing or effective-resistance mechanism

One might route each port edge through internal core edges and charge the
result to $E_{CC}$.  The actual derivative equality directions rigorously
exclude every capacity-one positive finite-path routing of the complete pole
conductance into the jump conductance: equality forces almost every route to
have one edge, while direct domination fails off the prime-power lines.  This
obstruction applies exactly to that positive routing class.  It does not
exclude the weighted, constraint-dependent multiplication comparison (24),
a signed route, or an infinite limiting construction.

### 4.3 Constraint-aware compact spectral mechanism

The map $x\mapsto Bx/\rho$ is compact from the core form domain to
$L^2(\gamma)$.  Hence (1) is a compact generalized spectral comparison on
the closed joint-nullspace, provided the supply form is positive there.  This
is the viable mechanism that uses the mean, ground-arrival, and finite
observation constraints rather than discarding them.  Compactness alone gives
no effective largest generalized eigenvalue; it must be certified by a
finite block plus an explicit complement estimate.

These mechanisms use different data.  Equation (24) is a positive-kernel
multiplication/Hardy estimate, routing compares edge measures, and the last
method uses cancellation in the constrained spectral subspace.

## 5. First exact finite-dimensional generalized eigenvalue condition

Choose real even core form vectors $\phi _1,\ldots,\phi _N$.  Define

\[
 M_{ij}=\langle\phi_j,\phi_i\rangle_C,\qquad
 A_{ij}=E_C(\phi_j,\phi_i)-\alpha _2M_{ij},               \tag{25}
\]

and the complete port Gram

\[
 P_{ij}=\frac1a\int_O\frac{\psi _2}{\rho}
                (B\phi_j)\overline{(B\phi_i)}\,d\nu.     \tag{26}
\]

Each $B\phi_j$ is given by (3)--(4).  Thus (26), without any dropped term,
contains continuous--continuous, both mixed continuous--prime terms, and all
prime-power/orientation cross covariances.

Let the constraint matrix $R_N$ have rows

\[
 $(\langle\phi_j,1_C\rangle)_j$,\qquad
 (\langle\phi_j,a_c\rangle)_j,qquad
 (\langle J_\ell\phi_j\rangle)_j                         \tag{27}
\]

for every component $J_\ell$ of the fixed finite observation. Odd score
rows vanish because the basis is even.  Let the columns of $Z_N$ span the
*exact* kernel of $R_N$.  The first finite condition is

\[
 \boxed{Z_N^*(A_N-P_N)Z_N\succeq0.}                      \tag{28}
\]

If $Z_N^*A_NZ_N>0$, (28) is equivalently

\[
 \lambda_{\max}\!\left(
 (Z_N^*A_NZ_N)^{-1/2}Z_N^*P_NZ_N
 (Z_N^*A_NZ_N)^{-1/2}\right)\le1.                       \tag{29}
\]

A rigorously enclosed vector $c$ with
$c^*Z_N^*P_NZ_Nc>c^*Z_N^*A_NZ_Nc$ is an actual
finite-subspace counterexample to (1).  Conversely, a positive result for
(28) alone is not a full-space proof.

For a full certificate, decompose the exact constrained space into the trial
range and a form-orthogonal complement.  If the difference form has trial
margin $a_N$, complement margin $d_N$, and mixed-block absolute constant $b_N$, Young's inequality gives the sufficient conditions

\[
 a_N\ge\varepsilon>0,qquad
 d_N\ge b_N^2/\varepsilon.                               \tag{30}
\]

No published data currently provide rigorous intervals for all entries
(25)--(27), a positive lower enclosure for the constrained supply matrix, and
an explicit complement $(d_N,b_N)$.  Therefore neither a passing eigenvalue
nor a finite counterexample is claimed.  The first unevaluated finite data
are the port entries (26), because they require a validated enclosure of the
normalized killed ground together with full theta/prime tails.  The next
missing datum is the constrained complement bound in (30).

## 6. Lean artifact and status

`lean/CorePortGeneralizedEigen.lean` proves, over exact real quadratic data:

* equivalence of compressed difference positivity and port domination;
* validity of a single finite failure witness;
* the generalized Rayleigh quotient criterion and a uniform
  generalized-eigenvalue certificate;
* interval lower/upper enclosure propagation; and
* the trial-plus-complement Young certificate (30).

It compiles with Lean 4.24, contains no `sorry` or new axiom, and its axiom
report lists only Mathlib's standard `propext`, `Classical.choice`, and
`Quot.sound`.  The theta kernels, killed-ground enclosure, constraint rows,
and complement estimates remain explicit analytic inputs.
