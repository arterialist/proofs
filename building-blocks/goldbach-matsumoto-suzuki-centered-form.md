# Matsumoto-Suzuki form of the centered Goldbach square

This note uses the repository's exact specialization of the
Matsumoto-Suzuki function

\[
S(v)=H_1(e^v),\qquad v\in\mathbb R,
\]

including its reflected zero sum, gamma and trivial-zero term, and value

\[
S(0)=\gamma+2-\log(4\pi). \tag{1}
\]

No screw positivity is assumed. In the cited Matsumoto-Suzuki result, the
global screw condition is itself equivalent to RH.

The source formulas audited here are equations (2) and (4) of
`goldbach-screw-configuration-successor-current.md`, together with the
literal derivative identity in
`goldbach-literal-successor-counting-transport.md`. The former is marked
in the repository as an author proof under independent review; the
classical Matsumoto-Suzuki explicit formula it quotes is the input used
below.

## Exact finite centered coefficients

Put

\[
a_n=\Lambda(n)-1,
\qquad
D(t)=\sum_{n\ge1}a_ne^{-nt},
\]

where \(\Lambda(1)=0\), so the initial endpoint is \(a_1=-1\). For a
finite cutoff \(Y\), define

\[
D_Y(t)=\sum_{1\le n\le Y}a_ne^{-nt}. \tag{2}
\]

Then

\[
\boxed{
D_Y(t)^2=\sum_{N=2}^{2Y}c_N^{(Y)}e^{-Nt},
\qquad
c_N^{(Y)}=
\sum_{\substack{m+n=N\\1\le m,n\le Y}}
(\Lambda(m)-1)(\Lambda(n)-1).}
\tag{3}
\]

Every orientation, prime power, and endpoint is present. If \(N\le Y+1\),
the cutoff coefficient is the complete coefficient

\[
c_N=\sum_{m=1}^{N-1}a_ma_{N-m}
=R_N-2\psi(N-1)+(N-1), \tag{4}
\]

where

\[
R_N=\sum_{m=1}^{N-1}\Lambda(m)\Lambda(N-m). \tag{5}
\]

Ordinary succession gives the exact finite birth

\[
\boxed{
c_{N+1}-c_N
=\sum_{m=1}^{N-1}\Lambda(m)
 [\Lambda(N+1-m)-\Lambda(N-m)]
-2\Lambda(N)+1.}
\tag{6}
\]

Thus the two endpoint births and the full prime-power arrival remain visible
inside the centered coefficient.

The first two cases audit the endpoint convention:

\[
c_2=1,
\qquad
c_3=2-2\log 2.
\tag{6a}
\]

Both agree with (4) and with one application of (6).

## Exact Matsumoto-Suzuki heat functional

The repository's literal source identity is

\[
a(v)=e^{-v/2}[\psi(e^v)-e^v]
=(\partial_v-\tfrac12)S(v)-G_\infty(v), \tag{7}
\]

where

\[
G_\infty(v)=e^{-v/2}
 \left[\log(2\pi)+\tfrac12\log(1-e^{-2v})\right]. \tag{8}
\]

The logarithmic singularity at zero is locally integrable and must stay
with the full expression. The exact centered heat used in the Goldbach
notes is

\[
C(t)=t\int_1^\infty[\psi(x)-x]e^{-tx}dx. \tag{9}
\]

After \(x=e^v\), equations (7) to (9) give

\[
C(t)=t\int_0^\infty e^{3v/2}e^{-te^v}
 [ (\partial_v-\tfrac12)S(v)-G_\infty(v)]dv. \tag{10}
\]

This form already retains the complete zero sum through \(S\). Integrating
the derivative once makes the endpoint explicit. Since the heat kernel
decays superexponentially at infinity,

\[
\boxed{
\begin{aligned}
C(t)={}&-te^{-t}S(0)\\
&-t\int_0^\infty e^{3v/2}e^{-te^v}(2-te^v)S(v)dv\\
&-t\int_0^\infty e^ve^{-te^v}
 \left[\log(2\pi)+\tfrac12\log(1-e^{-2v})\right]dv.
\end{aligned}}
\tag{11}
\]

The discrete centered source differs by the exact elementary endpoint

\[
D(t)=C(t)-E_0(t),
\qquad
E_0(t)=\frac1{e^t-1}-(1+t^{-1})e^{-t}. \tag{12}
\]

Define the right side of (11), including its endpoint, by
\(\mathcal L_t(S)\). Then the exact positive-form identity is

\[
\boxed{
\sum_{N\ge2}c_Ne^{-Nt}
=|\mathcal L_t(S)-E_0(t)|^2
=D(t)^2\ge0.}
\tag{13}
\]

This is a rank-one positive form on the complete Matsumoto-Suzuki source.
It preserves the zero sum, gamma integral, trivial-zero correction, and
the initial value (1). Its positivity is unconditional because it is a
square. It does not assert that the screw kernel of \(S\) is positive.

## What Goldbach positivity controls

Let

\[
L(t)=\sum_{n\ge1}\Lambda(n)e^{-nt},
\qquad
U(t)=\sum_{n\ge1}e^{-nt}=\frac1{e^t-1}. \tag{14}
\]

Then

\[
D(t)^2=L(t)^2-2L(t)U(t)+U(t)^2. \tag{15}
\]

The uncentered Goldbach representations are exactly

\[
L(t)^2=\sum_{N\ge2}R_Ne^{-Nt}, \tag{16}
\]

and every \(R_N\) is nonnegative. Binary Goldbach existence at an even
integer says only that one such coefficient is positive. Even if a
representation \(N=p+q\) is known, it gives merely

\[
R_N\ge\log p\log q>0. \tag{17}
\]

This is negligible compared with the two centered terms
\(2\psi(N-1)\) and \(N-1\), both of linear size. It supplies no sign for
\(c_N\), no upper bound for \(|c_N|\), and no upper bound for (13).

Known lower bounds for representations on an average set have the same
logical limitation. They lower-bound selected coefficients of \(L^2\),
whereas (15) requires cancellation between \(L^2\), \(2LU\), and \(U^2\).
A lower bound on the first positive term cannot upper-bound their complete
square.

The unconditional bounds

\[
L(t)\ll t^{-1},\qquad U(t)\asymp t^{-1} \tag{18}
\]

give only

\[
D(t)^2\ll t^{-2}. \tag{19}
\]

PNT improves this qualitatively to \(o(t^{-2})\). Neither Goldbach
existence nor the positive representation series (16) yields the
RH-strength \(O_\varepsilon(t^{-1-\varepsilon})\) centered estimate.

## The finite Hankel test and its limitation

For a finite complex vector \(x=(x_1,\ldots,x_J)\), the centered additive
coefficients define the Hankel form

\[
\mathcal H_c(x)=\sum_{i,j=1}^Jc_{i+j}x_i\overline{x_j}. \tag{20}
\]

This form is not positive in general. Equation (13) instead states the
positivity of the complete scalar generating series when evaluated at the
positive exponential character \(N\mapsto e^{-Nt}\). It does not imply
positivity of the finite Hankel matrices \((c_{i+j})\). Coefficient
truncation destroys the square because the \(c_N\) themselves change sign.

By contrast, the Toeplitz form generated by \(|D(e^{i\theta})|^2\) is
positive, but its coefficients are multiplicative-shift autocorrelations

\[
\sum_n a_{n+k}a_n,
\]

not the additive Goldbach coefficients \(c_N\). Replacing the Hankel form
by this Toeplitz form changes the arithmetic problem.

## Precise obstruction from the screw function

The unconditional explicit formula (11) is an identity, not a positive
kernel theorem. A positive screw form for all finite configurations would
impose the Matsumoto-Suzuki screw condition, which the cited theorem makes
equivalent to RH. Therefore one cannot use global screw positivity as an
unconditional input to bound (13).

Finite Goldbach existence does not repair this. It constrains some positive
coefficients in (16) but says nothing about the sign of the zero-sum and
gamma cross terms inside \(\mathcal L_t(S)\). Dropping those terms changes
both (11) and its endpoint value.

There is also a simple functional obstruction. For any positive sequence
\(\lambda_n\), every additive representation coefficient

\[
\sum_{m+n=N}\lambda_m\lambda_n
\]

is nonnegative, and it is positive whenever the support has a
representation of \(N\). This property alone allows, for example,
\(\lambda_n=2\) at every integer. Its centered heat relative to the unit
reference is

\[
\left(\sum_n(\lambda_n-1)e^{-nt}\right)^2=U(t)^2\asymp t^{-2}, \tag{21}
\]

far above the desired scale. Thus representation existence and positivity
cannot imply a centered heat-energy gain without quantitative cancellation
against the reference source.

## New exact consumer

Equation (11) identifies a source-faithful consumer distinct from the LCM
and divisor formulations:

\[
\boxed{
\mathcal Q_t^{\rm MS}
=\left| -te^{-t}S(0)
-t\int_0^\infty e^{3v/2}e^{-te^v}(2-te^v)S(v)dv
-\mathcal A_\infty(t)-E_0(t)
\right|^2,}
\tag{22}
\]

where \(\mathcal A_\infty(t)\) is the last explicit gamma integral in
(11). Exactly,

\[
\mathcal Q_t^{\rm MS}=D(t)^2
=\sum_{N\ge2}c_Ne^{-Nt}. \tag{23}
\]

A useful theorem would upper-bound (22) using a finite Matsumoto-Suzuki
form while retaining its zero sum and endpoint. The unconditional explicit
formula alone gives no such bound. Global positivity would be RH-equivalent,
and Goldbach representation lower bounds control the wrong side of the
centered cancellation.

The bounded conclusion is therefore precise. The positive identity (13)
and its finite version (3) are exact and preserve every requested source
term. They provide a new zero-sum/gamma consumer, but existing Goldbach
existence and unconditional representation lower bounds yield no
one-sided improvement over the PNT-scale centered heat estimate.

[CenteredGoldbachTruncatedHeat.lean](BuildingBlocks/CenteredGoldbachTruncatedHeat.lean) formalizes the truncated heat square, support through $2Y$, the complete interior prime/$\psi$ coefficient and the exact successor difference. The infinite zero-sum and gamma functional remain Lean obligations.
