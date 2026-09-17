# Moving-radius theta covariance: a valid denominator bound and the carrier obstruction

## Classification

Let \(C_R=[-R,R]\), \(O_R=\mathbb R\setminus C_R\), and let
\(D_R\psi_R=\alpha_R\psi_R\), with \(\psi_R>0\), even, and
\(\|\psi_R\|_{L^2(\nu)}=1\). Put

\[
 \rho(u)=\frac1{e^{|u|}+1},\qquad
 d\gamma_R=\rho\psi_R\,d\nu,\qquad
 a_R=\gamma_R(O_R),
\]

and, for a centered exterior source \(f\perp\psi_R\),

\[
 J_R(f)=\int_{O_R}\frac{\psi_R}{\rho}|f|^2\,d\nu.
\]

Two conclusions survive an audit of the proposed moving-radius argument.

1. The published shrinking trial, normalized-ground tail, and
   physical-mass conversion prove
   \[
      a_R\ge \exp(-C_a e^{2R})                         \tag{1}
   \]
   for all sufficiently large \(R\). Consequently, for
   \(R_X=\beta\log X\), \(0<\beta<1/2\),
   \[
      (a_{R_X}+\eta_{R_X})^{-1}
      \le \exp(C_aX^{2\beta})=e^{o(X)}.               \tag{2}
   \]
   This holds for every residual gap \(\eta_R\ge0\). The later endpoint
   ground estimate sharpens the clock mass to
   \(-\log a_R\le(\pi/2)e^{2R}+O(e^{21R/20})\). It is a genuine
   moving-radius estimate and does not use a moving ground supremum.

2. For an exterior source with an exact terminal-carrier representation,
   support beyond \(U_X\ge\tfrac12\log X-O(1)\), and terminal carrier norm
   \(K_X=e^{o(X)}\), the published ground tail proves
   \[
      \frac{J_{R_X}(f_X)}{a_{R_X}+\eta_{R_X}}
      \le \exp[-cX+o(X)]=o(X).                       \tag{3}
   \]

The second statement is conditional on the weighted carrier bound. The
critical-radius extension (13d) also applies when the terminal support starts
a fixed distance beyond \(R=\tfrac12\log X\). The current source papers do not
prove that bound for the complete finite-\(X\) Lambert
field. In fact, an exact coefficientwise, quotient-layer-preserving lift
of that field cannot have \(K_X=e^{o(X)}\): a prime hard-clock coefficient
forces \(K_X\ge\exp(cX-O(\log X))\). Thus (3) applies to theta-generated
localized packets with an independently verified carrier bound, but not
to the actual Lambert source through the proposed absolute path synthesis.

This is an obstruction for that named synthesis class. It does not rule
out a collective signed comparison performed after the complete angular
and clock sums.

## 1. Exact normalization and the moving denominator

Write

\[
 b(u)=2\cosh(u/2),\qquad d\nu=b\Phi\,du,\qquad
 G_R(u)=\Phi(u)\psi_R(u).
\]

Since \(\rho=e^{-|u|/2}/b\), the definitions give the exact identities

\[
 a_R=\int_{O_R}e^{-|u|/2}G_R(u)\,du,                 \tag{4}
\]

\[
 J_R(f)=\int_{O_R}b(u)^2e^{|u|/2}G_R(u)|f(u)|^2\,du. \tag{5}
\]

Let

\[
 w_R=e^{-\sqrt R/8},\qquad T_R=R+6w_R,\qquad
 m_R=\int_{O_R}G_R(u)\,du.
\]

The [sharp internal/exterior estimate](theta-internal-exterior-crossing-sharp-bound.md)
and the [physical-mass conversion](theta-ground-physical-mass-concentration.md)
give, with absolute constants and for all sufficiently large \(R\),

\[
 \int_{|u|>T_R}G_R(u)\,du\le\frac12m_R,
 \qquad
 m_R\ge c e^{-Ce^R}\omega(T_R),                    \tag{6}
\]

where \(\omega^2=\Phi/b\). Hence

\[
 a_R\ge\frac12e^{-T_R/2}m_R
      \ge \frac c2e^{-Ce^R-T_R/2}\omega(T_R).       \tag{7}
\]

The positive first theta term gives

\[
 \omega(t)^2\ge \pi^2e^{4t}e^{-\pi e^{2t}}          \tag{8}
\]

eventually. Since \(w_R\to0\), one may enlarge the fixed threshold so
that \(e^{12w_R}\le2\). Substituting (8) into (7) and absorbing the
terms of order \(e^R+R\) proves (1). No residual spectral gap, Harnack
constant, or ground supremum occurs in this argument. Since
\(a_R+\eta_R\ge a_R>0\), (2) follows with the displayed direction.

The older fixed-strip proof of \(a_R>0\) is insufficient here because its
strip and ground bound depend on \(R\) without a rate. Equations (6)--(8)
are the source of the moving rate.

## 2. The valid localized-source estimate

For \(U\ge R+6w_R\), the same sharp crossing theorem and the shrinking
trial give

\[
 \begin{split}
 r_{R,U}:={}&\|\psi_R1_{O_U}\|_{L^2(\nu)}\\
 \le{}&Cw_R^{-1}e^{C(R+U)}
 \exp\!\left[-\frac\pi2e^{2U}+\frac\pi2e^{2R}
                    +Cw_Re^{2R}\right].             \tag{9}
 \end{split}
\]

This retains the singular continuous crossing and both orientations of
every prime-power crossing. Cauchy--Schwarz, in the exact theta measure,
gives

\[
 \begin{split}
 \int_{|u|\ge U}e^{|u|/2}G_R(u)\,du
 &\le r_{R,U}
 \left(\int_{|u|\ge U}e^{|u|}\omega(u)^2\,du\right)^{1/2}\\
 &\le
 \exp[-\pi e^{2U}+\tfrac\pi2e^{2R}
          +Cw_Re^{2R}+C(R+U)].                      \tag{10}
 \end{split}
\]

The second inequality uses the upper theta envelope
\(\omega(u)^2\le Ce^{4|u|}e^{-\pi e^{2|u|}}\).

For one directed prime-power edge \(u=v+\sigma\log q\), conjugating the
core input \(x\) by
\(\xi(v)=\sqrt{b(v)\Phi(v)}x(v)\) gives the exact source identity

\[
 J_R(f)=\frac{\Lambda(q)^2}{q}
 \int \omega(v)^2|\xi(v)|^2e^{|u|/2}G_R(u)\,dv.     \tag{11}
\]

For a coherent sum of paths, combine every arithmetic coefficient,
orientation, incidence sign, and earlier multiplier before squaring. If
this produces an exact terminal representation

\[
 J_R(f_X)=\int |H_X(v)|^2e^{|u(v)|/2}G_R(u(v))\,dv, \tag{12}
\]

with \(|u(v)|\ge U_X\) and
\(\|H_X\|_\infty\le K_X\), then (10) and (1) imply

\[
 \frac{J_R(f_X)}{a_R+\eta_R}
 \le K_X^2
 \exp[-c e^{2U_X}+Ce^{2R}+C(R+U_X)].               \tag{13}
\]

At \(R_X=\beta\log X\), \(\beta<1/2\), and
\(U_X\ge\tfrac12\log X-O(1)\), equation (13) proves (3) whenever
\(\log K_X=o(X)\). A polynomial carrier is sufficient but unnecessary.
Finite unions of collars are allowed when the logarithm of their number is
\(o(X)\), because their positive bounds may then be summed.

Equation (12) must be checked for the complete coherent source before the
absolute bound is taken. Splitting orientations or prime orders first can
discard favorable cross terms; omitting prime powers changes the ground
tail used in (9).

### A critical-radius terminal-offset corollary

The [endpoint ground collar and relative-energy bound](theta-ground-endpoint-relative-energy.md) sharpen the clock-mass estimate (1). For \(R\to\infty\), set \(X=e^{2R}\) and \(w=8X^{-19/40}\). That result proves
\[
 -\log a_R\le \frac{\pi}{2}X+O(X^{21/40}).
\tag{13a}
\]
The sharp two-endpoint crossing estimate gives a matching exponent for the normalized tail. If \(U=R+\kappa\) for a fixed \(\kappa>0\), divide its crossing norm by the endpoint trial gap
\(\delta_R\ge d_0e^Rw\,\omega(R+2w)^2\). The far exterior lower error is smaller than half this gap for large \(R\). The ground projection inequality then yields
\[
 \log r_{R,U}
 \le-\frac{\pi}{2}e^{2U}+\frac{\pi}{2}X
       O(Xw+R).
\tag{13b}
\]
The weighted physical Cauchy–Schwarz estimate used in (10) contributes another
\(-\pi e^{2U}/2+O(U)\). Combining it with (13a) gives
\[
 \frac{\int_{|u|\ge U}e^{|u|/2}G_R(u)\,du}{a_R}
 \le
 \exp\!\left[-\pi(e^{2\kappa}-1)X
                  O(X^{21/40}+R)\right].
\tag{13c}
\]
Thus the localized-source conclusion (3) also holds at the critical moving radius
\[
 R_X=\tfrac12\log X,\qquad U_X\ge R_X+\kappa,
 \qquad \log K_X=o(X),\qquad\kappa>0.
\tag{13d}
\]
The fixed positive terminal offset supplies the exponential margin. This corollary still requires the exact carrier representation (12). The Lambert prime row in Section 4 violates its subexponential carrier bound, so (13d) does not establish the missing comparison for that source.

There is a second tradeoff at the shrinking endpoint collar. Set \(U=T=R+6w\). The explicit normalized tail from the endpoint crossing theorem is
\[
 r_{R,T}\le\frac{896}{d_0w}
             \exp(10w-2\pi Xw).
\]
The theta envelope and its positive first term give
\[
 \left(\int_{|u|\ge T}e^{|u|}\omega(u)^2du\right)^{1/2}
 \le C e^{-T/2}\omega(T).
\]
The improved physical-mass bound gives
\(a_R\ge c e^{-T/2-Ce^{R/20}}\omega(T)\). Consequently
\[
 \frac{\int_{|u|\ge T}e^{|u|/2}G_R(u)du}{a_R}
 \le \exp[-(2\pi+o(1))Xw].
\tag{13e}
\]
At \(R_X=\tfrac12\log X\), an exact carrier supported beyond
\(T_X=R_X+48X^{-19/40}\) therefore also satisfies (3) if
\(\log K_X=o(X^{21/40})\). A polynomial carrier meets this stronger norm condition. The unproved carrier control for the actual Lambert field is unchanged.

## 3. Why the published inputs do not prove the carrier hypothesis

The fixed-radius weighted crossing theorem proves \(J_R(B_Rx)<\infty\)
and boundedness for each fixed \(R\). It gives no rate for the operator
norm as \(R\to\infty\). The unweighted endpoint estimate

\[
 \|f_X\|_{L^2(\nu)}\le X^Ae^{-\kappa X}             \tag{14}
\]

does not repair this. The weight in (5) contains the moving ground and
\(\rho^{-1}\), and an \(L^2\) bound on the core profile does not imply the
\(L^\infty\) carrier bound used in (12)--(13).

This is visible already in (11): the normalized conjugated input \(\xi\)
is part of the terminal carrier. Arithmetic path length and prime-window
normalization do not bound \(\|\xi\|_\infty\). The available ground tail
is an \(L^2(\nu)\) estimate; pairing it as in (10) consumes an
\(L^\infty\) bound on the other factor. A valid replacement could be:

* a uniform \(L^\infty\), bounded-variation, or Sobolev bound for the
  actual terminal carrier;
* a moving pointwise ground-tail estimate strong enough to pair with an
  \(L^2\) carrier; or
* a matched \(L^p\)-\(L^{p'}\) pair of moving estimates.

None is supplied by the collar support statement alone. Thus the claim
\(K_X\le X^A\) cannot be inferred from \(k\le\log_2X+O(1)\), and it is not
part of the presently published localized-source theorem.

## 4. Exact prime-row obstruction for the Lambert source

The complete finite-\(X\) Lambert field is

\[
 H_t(re^{i\theta})=(1-q)\sum_{a,d\ge1}
   q^{a-1}\mu(d)e^{-ad/X}e^{iad\theta},
 \qquad q=e^{-t}.                                      \tag{15}
\]

At a prime frequency \(p\in[X,2X]\), both quotient factorizations are
present and their exact sum is

\[
 c_{p,X}(t)=-(1-q)e^{-p/X}(1-q^{p-1}).                \tag{16}
\]

For \(t\ge1\),

\[
 |c_{p,X}(t)|\ge e^{-2}(1-e^{-1})^2=:c_0>0.          \tag{17}
\]

The nontrivial divisor layer \(d=p,a=1\) has one prime source step. Every
placement of a path with displacement \(\log p\) has an endpoint of
absolute value at least \((\log p)/2\). The theta envelope therefore
bounds its normalized endpoint amplitude by

\[
 X^Ae^{-\kappa X}.                                    \tag{18}
\]

The trivial layer \(d=1,a=p\) has no source displacement, but its exact
quotient weight is at most \(e^{-(p-1)}\). Consequently any exact
coefficientwise, quotient-layer-preserving path lift with total absolute
carrier mass \(M_{p,X}(t)\) satisfies

\[
 c_0\le M_{p,X}(t)X^A
       (e^{-\kappa X}+e^{-(X-1)}),                  \tag{19}
\]

and hence

\[
 \boxed{M_{p,X}(t)\ge\exp(\kappa'X-O(\log X)).}      \tag{20}
\]

Bertrand's theorem supplies such a prime in every large dyadic interval.
The quotient-layer weights sum to one, and the \(k!\) ordered histories of
a squarefree endpoint cost at most the endpoint itself; neither creates
this exponential loss. It is the reciprocal theta endpoint factor.

Equation (20) is the precise obstruction to inserting the actual Lambert
field into (13) with \(K_X=e^{o(X)}\). It does not contradict (13) for
theta-generated packets: those packets begin after multiplication by the
small endpoint factor and need not reproduce the order-one coefficient
(17).

## 5. The remaining moving theorem

The denominator is no longer the moving-radius obstruction. The open
possibility is a collective signed comparison made after summing all
angular frequencies, quotient layers, clocks, and path orientations. It
must avoid an absolute carrier majorant and compare the original central
Gram kernel directly with the complete theta covariance kernel on the one
actual coefficient array (15).

The prime-row calculation rules out deriving such a theorem by
coefficientwise inversion. It does not rule out cancellation between
different frequencies on the shrinking central arc. The exact missing
statement is therefore a collective kernel inequality with constant
\(e^{o(X)}\), or an equivalent source-specific bound on the fully summed
\(J_R/(a_R+\eta_R)\). No current collar, barrier, parity, finite
observation, or scattering theorem proves it.

All assertions above retain exact ground centering: on
\(a_{c,R}^{\perp}\), the centered source equals \(B_Rx\). Away from that
constraint a nonlocalized constant column is added, so the endpoint-tail
estimate cannot be applied unchanged. No statement here assumes a
location for the zeta zeros or proves the Riemann hypothesis.
