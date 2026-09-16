# Growing-stage consequences of the simultaneous expansion

## Result

Write `L=log X`, and let `A_X(P)` be the complete normalized finite-horizon
energy after admitting all primes at most `P`.  The assembled expansion is

\[
 A_X(P)=E_P+\frac{C_P}{L}+\rho_X(P),\qquad
 C_P=-4\langle F_P,J_P\rangle .                                      \tag{1}
\]

For every fixed `epsilon>0`, uniformly for `P<=X^(1/2-epsilon)`,

\[
 \sup_P|\rho_X(P)|=o(1).                                               \tag{2}
\]

Consequently, for every natural growing stage `P=P(X)` in this range,

\[
 P(X)\longrightarrow\infty
 \quad\Longrightarrow\quad
 A_X(P(X))\longrightarrow E_\infty>0.                                 \tag{3}
\]

Here

\[
 |E_\infty-E_P|<\frac23e^{-2P},\qquad
 E_\infty\ge \frac{e^{-4}(e^2-1)}{16}.                                \tag{4}
\]

Thus the strongest uniform consequence on the full fixed-power range is a
strictly positive plateau.  It is not termwise control of prime admissions.

## Cumulative admissions

For a prime `p`, let `p^-` denote the preceding admission state and put

\[
 \Delta_{X,p}=A_X(p)-A_X(p^-),\qquad
 \Delta_p=E_p-E_{p^-}.
\]

Admissions telescope exactly:

\[
 \sum_{p\le P}\Delta_{X,p}=A_X(P)-A_X(\varnothing).                    \tag{5}
\]

Combining (1) at the two endpoints gives

\[
 \sum_{p\le P}\Delta_{X,p}
 =E_P-E_\varnothing+\frac{C_P-C_\varnothing}{L}
   +\rho_X(P)-\rho_X(\varnothing).                                    \tag{6}
\]

Hence, if `P(X)->infinity` in the fixed-power range, the cumulative admission
tends to `E_infinity-E_emptyset`.  This identity gives no count or sign budget
for the individual summands.  Positive and negative admissions can have
finite total variation while their sum converges to this endpoint difference.

## The stagewise first correction

The first-correction profiles give an exponential bound that is sharper than
mere uniform boundedness of `C_P`.  Before admitting `p`, set

\[
 U_p^G=\sum_{e\mid(p^-)^\#}\mu(e)G_{pe},\qquad
 U_p^J=\sum_{e\mid(p^-)^\#}\mu(e)J_{pe}.
\]

Then `F_p=F_{p^-}-U_p^G`, `J_p=J_{p^-}-U_p^J`, and exactly

\[
 C_p-C_{p^-}
 =4\{\langle U_p^G,J_{p^-}\rangle
       +\langle F_{p^-},U_p^J\rangle
       -\langle U_p^G,U_p^J\rangle\}.                                 \tag{7}
\]

The proved profile estimates

\[
 \|G_d\|_2\le \frac{e^{-d}}{2d},\qquad
 \|J_d\|_2\le \frac{\sqrt3e^{-d}}{4d^2}
\]

give, after enlarging the old squarefree faces to all positive integers,

\[
 \|U_p^G\|_2\le\frac{e^{-p}}{2p(1-e^{-p})},\qquad
 \|U_p^J\|_2\le\frac{\sqrt3e^{-p}}{4p^2(1-e^{-p})}.                   \tag{8}
\]

Since `F_P` and `J_P` are uniformly bounded in `L^2`, (7)-(8) prove

\[
 \boxed{|C_p-C_{p^-}|\ll e^{-p}/p.}                                   \tag{9}
\]

No sign of this correction is used.

## Exact perturbation threshold for one admission

Differencing (1), with both level errors retained, gives

\[
 \Delta_{X,p}-\Delta_p
 =\frac{C_p-C_{p^-}}L+\rho_X(p)-\rho_X(p^-).                           \tag{10}
\]

Therefore the exact sign-transfer test supplied by the expansion is

\[
 \frac{|C_p-C_{p^-}|}{L}+|\rho_X(p)|+|\rho_X(p^-)|<|\Delta_p|.         \tag{11}
\]

The non-endpoint part of each level remainder is

\[
 O\!\left(L^{-2}+e^{-c\sqrt L}+L/X\right).                            \tag{12}
\]

At the small stages relevant below, the sign-free endpoint estimate is

\[
 \eta_{X,p}:=\frac L X\|E_{X,p}^{\rm end}\|_{G,X}
 \le \frac{L}{2X}2^{\pi(p)}.                                         \tag{13}
\]

Its energy perturbation is at most `2B eta_(X,p)+eta_(X,p)^2`, for a uniform
bound `B` on the non-endpoint norm.  Thus (11) is fully quantitative up to the
absolute constants in (12).

For the limiting Green energy one has, for every prime `p`,

\[
 pe^{2p}\Delta_p=-T(p)+R_p,\qquad |R_p|<13/6.                          \tag{14}
\]

For every `delta` with `1/20<delta<1/2`, there are positive and negative
prime subsequences on which

\[
 p^{1-\delta}e^{2p}|\Delta_p|\longrightarrow\infty.                   \tag{15}
\]

On either such subsequence, (9)-(13) transfer the sign provided

\[
 \boxed{\frac{e^p p^{(1-\delta)/2}}{L}\longrightarrow0.}              \tag{16}
\]

Indeed, relative to the scale `e^(-2p)p^(delta-1)`, the density-correction
error is

\[
 O\!\left(\frac{e^p}{Lp^\delta}\right),
\]

and the `L^(-2)` level error is

\[
 O\!\left(\frac{e^{2p}p^{1-\delta}}{L^2}\right).
\]

The latter is the square of the expression in (16).  The zero-free-region,
sampling, and endpoint terms are smaller in this regime.  A convenient
explicit sufficient range, for any fixed `gamma>0`, is

\[
 p\le \log L-
 \left(\frac{1-\delta}{2}+\gamma\right)\log\log L.                    \tag{17}
\]

Since `L=log X`, this is an almost `log log X` admission range.  The simpler
condition `p<=(1-gamma)log log X` is also sufficient.

This is the exact frontier of the present absolute-error argument, not a
necessity theorem.  At larger `p`, (1) still determines the level energy, but
its `O(L^(-2))` error is larger than the known exponentially small individual
margin.  In particular, the fixed-power range
`P<=X^(1/2-epsilon)` does not transfer individual signs without a stagewise
remainder estimate far sharper than the uniform level expansion.

A degree-zero Hodge projection does not remove the endpoint loss.  For any
positive vertex metric `G`, the normalized constant mode
`h=G^(-1)1/(1*G^(-1)1)` satisfies

\[
 \langle h,b\rangle_G=\frac{1^*b}{1^*G^{-1}1}.
\]

For the literal moving endpoint vector, its numerator is exactly
`E_(X,P)(j)`, and

\[
 q^{j/2}E_{X,P}(j)
 =-e^{-2j/X}M(j-1,P)
   +\frac2X\int_j^\infty e^{-2t/X}M(t,P)\,dt.                          \tag{18}
\]

The moving Abel cut and constant-mode projection do not commute.  The
remaining scalar is the same friable Mertens tail already paid in (13).
Even `P=2` changes sign as `j` moves, so capacity positivity supplies no
replacement for the absolute margin test (11).

## Finite-X nonmonotonicity and its limit

The fixed profile has a negative admission at `p=2`.  The exact finite-kernel
calculation at `p=158647` gives a positive admission.  For each of these two
fixed stages, (10) tends to zero as `X->infinity`.  Therefore there is one
finite, though not numerically evaluated, `X_0` such that for every `X>=X_0`
the same finite-horizon admission path contains both a negative step at `2`
and a positive step at `158647`.  This is a genuine finite-X obstruction to
monotone damping in the cutoff variable.

More generally, (15)-(17) produce both signs along diagonal pairs `(X,p(X))`.
They do not prove both signs when `p` is a fixed power of `X`, and they do not
control complete admission `P=X`.

The positive limit (3) also rules out damping to zero throughout the proved
simultaneous range.  It does not rule out a monotone path converging to a
positive plateau; that stronger obstruction comes from the transferred
positive and negative fixed-stage admissions just described.

## Why this does not advance RH

All conclusions occur in the separated-endpoint regime
`P<=X^(1/2-epsilon)`.  Complete admission has `P=X`, where the endpoint is of
the same scale as the non-endpoint plateau and its first coherent component
cancels that plateau.  The remaining weighted Mertens prefix is precisely the
uncontrolled term.  Neither (3) nor the small-stage sign changes estimate it.

The oscillation input in (15) follows unconditionally from known nonreal
zeros and prime-gap interpolation.  It is not a new zero-free statement and
does not imply a square-root Mertens bound.  The result describes an
unconditional partial-admission energy path; it supplies no RH criterion at
the complete cutoff.

## Finite formalization

[GrowingAdmissionSignTransferFinite.lean](BuildingBlocks/GrowingAdmissionSignTransferFinite.lean) proves:

1. the exact difference formula (10) from two level expansions;
2. the bound `|Delta_X-Delta| <= correctionError+2*levelError`;
3. positive and negative strict sign transfer under the corresponding margin;
4. exact finite telescoping of consecutive admissions; and
5. preservation of a positive profile floor under a smaller perturbation.

The module compiles under Lean 4.24.  Every printed theorem depends only on

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorry`, `admit`, or new axiom.  The analytic expansion, friable
endpoint estimate, and oscillation theorem remain explicit written inputs.
