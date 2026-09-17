# Exact endpoint conservation for the actual chirped prime cross

**Status:** unconditional written analytic proof, 18 September 2026.
The finite endpoint identity with actual `Lambda(p^k)=log p`, the
`Lambda(n)/n` weight, and strict collar endpoints is Lean-compiled in
[CriticalChirpedEndpointFinite.lean](../../formalization/BuildingBlocks/CriticalChirpedEndpointFinite.lean).
The same file proves that any cutoff `N>=exp(D+w)` captures every term
of the actual cross for all separations `d<=D`; larger cutoffs agree.
The construction and estimates for the analytic packet remain written.
It gives a signed average over packet separations, not a pointwise
prime-phase estimate or RH. No literature-priority claim is made.

Use the fixed `0<w<log 2`, `a`, and `eta` of the
[chirped constellation](chirped-critical-span-constellation.md), and
let `q_T` be its compactly supported pole-null packet. Write

\[
C_T(y)=\int_{\mathbb R}q_T(x+y)\overline{q_T(x)}\,dx,
\qquad
P_T(d)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                  C_T(\log n-d),\quad d\ge0.
\tag{1}
\]

For each fixed `d`, the sum is finite because `C_T` is supported in
`[-w,w]`. The full actual prime-power cross in the complete Weil form
is `P_T(d)` whenever two disjoint packets are separated by `d>w`.

Define the compact primitive

\[
F_T(v)=\int_{-w}^{v}e^{y/2}C_T(y)\,dy
\quad(-w\le v\le w),
\qquad F_T(v)=0\quad(v\notin[-w,w]).
\tag{2}
\]

The extension by zero is continuous at both endpoints. Indeed,
Fubini and the change of variable `z=x+y` give the exact pole identity

\[
\int_{-w}^{w}e^{y/2}C_T(y)\,dy
=\left(\int q_T(z)e^{z/2}dz\right)
 \overline{\left(\int q_T(x)e^{-x/2}dx\right)}
=E_+(q_T)\overline{E_-(q_T)}=0.
\tag{3}
\]

Both `E_+` and `E_-` vanish separately because
`q_T=(\partial_x^2-1/4)u_T/\|(\partial_x^2-1/4)u_T\|_2` with smooth
compact `u_T`. The correlation estimate
`|C_T(y)|<=C_m(1+T|y|)^(-m)` for any fixed `m>1` consequently yields

\[
\|F_T\|_\infty\le e^{w/2}\int_{-w}^{w}|C_T(y)|dy
\ll_{a,w,\eta}T^{-1}.
\tag{4}
\]

There is also an exact pointwise residual identity. With
`psi(X)=sum_(n<=X)Lambda(n)`, the continuous prime background has
zero pairing by (3):

\[
\int_0^\infty x^{-1/2}C_T(\log x-d)\,dx
=e^{d/2}\int_{-w}^{w}e^{y/2}C_T(y)\,dy=0.
\]

Since `d psi` has the literal jump `Lambda(n)` at every prime power,
for each `d>=0` we therefore have the finite Stieltjes identity

\[
P_T(d)=\int_0^\infty x^{-1/2}C_T(\log x-d)
                    \,d\bigl(\psi(x)-x\bigr).
\tag{4a}
\]

This identifies the full cross with actual prime fluctuations, but
does not bound the Stieltjes integral pointwise.

**Endpoint identity.** For every `D>=0`,

\[
\boxed{\quad
\int_0^D e^{-d/2}P_T(d)\,dd
=-\sum_{e^{D-w}<n<e^{D+w}}
   \frac{\Lambda(n)}{n}F_T(\log n-D).
\quad}\tag{5}
\]

The strict collar may be replaced by inclusive endpoints because
`F_T(-w)=F_T(w)=0`. To prove (5), only
`n<=e^{D+w}` can contribute on `0<=d<=D`, so the interchange of sum
and integral is finite. For each such `n`, put `y=log n-d`:

\[
\int_0^D e^{-d/2}C_T(\log n-d)\,dd
=n^{-1/2}\int_{\log n-D}^{\log n}e^{y/2}C_T(y)\,dy.
\tag{6}
\]

Since `log n>=log 2>w`, the upper limit contains the whole positive
end of the correlation support. If `n<=e^{D-w}`, the lower limit also
contains the whole negative end, and (3) makes (6) zero. If
`n>=e^{D+w}`, (6) is zero by support. In the remaining collar,
(3) turns (6) into `-n^(-1/2)F_T(log n-D)`. Multiplying by the
outer factor `Lambda(n)/sqrt n` proves (5), including prime powers
and both boundary cases.

The unconditional Chebyshev bound `psi(X)<=C X`, with
`psi(X)=sum_(n<=X)Lambda(n)` including all prime powers, gives

\[
\sum_{e^{D-w}<n<e^{D+w}}\frac{\Lambda(n)}n
\le e^{-D+w}\psi(e^{D+w})\ll_w1.
\tag{7}
\]

Combining (4)--(7) gives the uniform signed conservation law

\[
\boxed{\quad
\sup_{D\ge0}\left|\int_0^D e^{-d/2}P_T(d)\,dd\right|
\ll_{a,w,\eta}T^{-1}.
\quad}\tag{8}
\]

For comparison, the triangle inequality and the elementary
`psi(X)<<X` bound give only
`int_0^D e^(-d/2)|P_T(d)| dd << D` without using the chirp or
pole-null moment. Equation (8) is uniform even as `D` grows.

In particular, the integral over any `0<=A<=B` is
`O_{a,w,eta}(T^(-1))`, uniformly in both endpoints. More generally,
if `g` is absolutely continuous on `[0,D]`, integration by parts in
(8) gives

\[
\left|\int_0^D e^{-d/2}P_T(d)g(d)\,dd\right|
\ll_{a,w,\eta}T^{-1}
 \left(|g(D)|+\int_0^D|g'(d)|\,dd\right).
\tag{9}
\]

## Prime-number-theorem sharpening at a moving endpoint

Both pole transforms vanish separately, so (3) has a second zero.
For real `s`, set
`M_T(s)=int e^(s y) C_T(y) dy
       =E_s(q_T) overline(E_(-s)(q_T))`.
Compact support permits differentiation. At `s=1/2`, both factors
vanish, hence `M_T(1/2)=M_T'(1/2)=0`. Since
`F_T'(y)=e^(y/2)C_T(y)` and `F_T(+-w)=0`, integration by parts gives

\[
\int_{-w}^{w}F_T(y)\,dy
=-\int_{-w}^{w}y e^{y/2}C_T(y)\,dy
=-M_T'(1/2)=0.
\tag{10}
\]

Let `N=e^D`, define
`epsilon(D)=sup_(Ne^(-w)<=x<=Ne^w) |psi(x)-x|/x`, and put
`K_(T,D)(x)=x^(-1)F_T(log x-D)`. The classical prime number theorem
gives `epsilon(D)->0` as `D->infinity`, independently of `T`.
The continuous integral of `K_(T,D)` is exactly zero by (10).
Thus (5) is the Stieltjes pairing
`-int K_(T,D) d(psi-x)`. The kernel vanishes at its literal support
endpoints, so Stieltjes integration by parts has no boundary term.
Writing `y=log x-D`,

\[
K_{T,D}'(x)=x^{-2}\bigl(F_T'(y)-F_T(y)\bigr),
\qquad
\int_0^\infty x|K_{T,D}'(x)|dx
\le\int_{-w}^{w}(|F_T'(y)|+|F_T(y)|)dy
\ll_{a,w,\eta}T^{-1}.
\]

Consequently the actual prime-power error obeys the stronger uniform
signed bound

\[
\boxed{\quad
\left|\int_0^D e^{-d/2}P_T(d)\,dd\right|
\ll_{a,w,\eta}\frac{\epsilon(D)}{T},
\qquad \epsilon(D)\longrightarrow0\quad(D\longrightarrow\infty).
\quad}\tag{11}
\]

In particular, `sup_(T>=T_0) T |int_0^D e^(-d/2)P_T(d)dd| -> 0`
as `D->infinity`. This uses only the unconditional prime number
theorem, not an RH-scale error estimate. It is still averaged in
`d`; differentiating it does not give a pointwise bound on `P_T(D)`.
The prime number theorem remains compatible with hypothetical zeros
strictly inside the critical strip, so neither does (11) exclude one.

## Exact first weighted moment

The endpoint law also has a convergent first moment. For this step an
ordinary quantitative PNT error is enough: for example,
[Johnston--Yang, Theorem 1.1](https://arxiv.org/pdf/2204.01980), gives
`|psi(x)-x|/x << (log x)^1.515 exp(-0.8274 sqrt(log x))` for `x>=2`.
Thus `epsilon(D)` in (11) is integrable on `[0,infinity)` and
`D epsilon(D)->0` as `D->infinity` (the bounded initial interval is
harmless). Put
`J_T(D)=int_0^D e^(-d/2)P_T(d) dd`; then (11) gives
`J_T in L^1(0,infinity)` and `D J_T(D)->0`.

For `Re z>1/2`, absolute convergence allows the exact Laplace
calculation. Write `E_z(v)=int v(x)e^(zx) dx` and
`Z_T=||(partial_x^2-1/4)u_T||_2`, where
`u_T(x)=a(x)e^(i eta T x^2-iTx)`:

\[
\begin{split}
\mathcal L_T(z)
&:=\int_0^\infty e^{-zd}P_T(d)\,dd\\
&=\left(-\frac{\zeta'}{\zeta}\right)(z+\tfrac12)
  E_z(q_T)\overline{E_{-\bar z}(q_T)}\\
&=\left(-\frac{\zeta'}{\zeta}\right)(z+\tfrac12)
  \frac{(z^2-\tfrac14)^2}{Z_T^2}
  E_z(u_T)\overline{E_{-\bar z}(u_T)}.
\end{split}\tag{12}
\]

The factorization uses `log n>w` for every `n>=2`, so the full
support of `C_T(log n-d)` lies in `d>0`; the Dirichlet series contains
every `Lambda(p^k)`. The last line is integration
by parts in the compact support of `u_T`. No zero location is assumed.

Set `z=1/2+sigma` with real `sigma>0`. The pole of `-zeta'/zeta`
at `1` has residue `1`, while
`(z^2-1/4)^2=sigma^2(1+sigma)^2`. Hence

\[
\lim_{\sigma\downarrow0}
\frac{\mathcal L_T(\tfrac12+\sigma)}{\sigma}
=\frac{E_{1/2}(u_T)\overline{E_{-1/2}(u_T)}}{Z_T^2}.
\tag{13}
\]

On the other hand, integration by parts at each `sigma>0` gives
`mathcal L_T(1/2+sigma)
 =sigma int_0^infinity e^(-sigma D)J_T(D) dD`.
The integrability above permits dominated convergence in this
identity. A final finite-cutoff integration by parts, using
`D J_T(D)->0`, proves the exact improper-integral sum rule

\[
\boxed{\quad
\int_0^\infty d\,e^{-d/2}P_T(d)\,dd
=-\frac{E_{1/2}(u_T)\overline{E_{-1/2}(u_T)}}{Z_T^2}.
\quad}\tag{14}
\]

The phase derivative of `u_T` stays bounded away from zero in units
of `T` on the fixed support. Repeated integration by parts makes both
numerator factors `O_m(T^(-m))` for every `m`, while `Z_T asymp T^2`.
Thus the signed moment in (14) is `O_A(T^(-A))` for every fixed
`A>0`. This is an exact conservation identity for actual prime
powers, not a pointwise estimate: the Laplace formula is initially
valid only for `Re z>1/2`, and its meromorphic continuation can still
have poles from hypothetical off-line zeros.

Equations (8)--(9) use the pole-null moment and a linear Chebyshev
bound; (11)--(14) add the prime number theorem and the zeta pole.
Every version retains all
prime powers. None controls `|P_T(d)|` at an individual separation;
a narrow positive or negative spike can have a small integral.
Nor does the weight `e^(-d/2)` amplify the transform at an off-line
zero. A selected-zero argument still needs an additional signed
estimate or spectral isolation.
