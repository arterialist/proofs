# Finite-\(X\) affine bulk, corner, and tail reduction

The local-uniform continuum kernel does not by itself control the sum over
\(O(X^2)\) Möbius pairs. This note upgrades it to a target-scale finite-\(X\)
decomposition by restoring exactly the two regions already paid in the live
goal: the low-clock region and the outer angular arc. Full clock integration
gives the exact coefficients \(\kappa_m\), and the full Poisson circle gives
an exact affine factor \(r^{|ad-be|}/(1-r^2)\). There is then no pairwise
Gamma-limit error to accumulate.

The resulting reduction is:

\[
R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}
\tag{1}
\]

follows from one exact growing-horizon inequality on

\[
\sqrt X<d,e<X\log X.
\tag{2}
\]

The unit/sublinear corner and the large tail are bounded unconditionally in
the same Gram metric. Strict division, all future multiples, every proper
power, and the original clock weight remain.

## 1. Restore only the paid regions

Let

\[
r=e^{-1/X},\qquad z_\theta=re^{i\theta},
\qquad
\eta_\varepsilon=\min(\varepsilon/4,1/4),
\tag{3}
\]

\[
b_\varepsilon(\theta)
=\bigl[\max(|\theta|,X^{-1})\bigr]^{1/2-\eta_\varepsilon}.
\tag{4}
\]

The exact far remainder is

\[
R_X^\varepsilon=
\frac1{2\pi}\int_{|\theta|<X^{-1/2}}
\int_{b_\varepsilon(\theta)}^\infty
\frac{|H_t(z_\theta)|^2w(t)}{|1-z_\theta|^2}
\,dt\,d\theta.
\tag{5}
\]

Define the two complementary positive pieces

\[
P_{X,\mathrm{low}}^\varepsilon=
\frac1{2\pi}\int_{|\theta|<X^{-1/2}}
\int_0^{b_\varepsilon(\theta)}
\frac{|H_t(z_\theta)|^2w(t)}{|1-z_\theta|^2}
\,dt\,d\theta,
\tag{6}
\]

\[
P_{X,\mathrm{out}}=
\frac1{2\pi}\int_{X^{-1/2}\le|\theta|\le\pi}
\int_0^\infty
\frac{|H_t(z_\theta)|^2w(t)}{|1-z_\theta|^2}
\,dt\,d\theta.
\tag{7}
\]

Both are already paid:

\[
P_{X,\mathrm{low}}^\varepsilon
\ll_\varepsilon X^{2+\varepsilon},
\qquad
P_{X,\mathrm{out}}\ll X^2.
\tag{8}
\]

The full-circle, full-clock energy is therefore exactly

\[
\mathcal E_X
=R_X^\varepsilon
+P_{X,\mathrm{low}}^\varepsilon
+P_{X,\mathrm{out}}.
\tag{9}
\]

This identity determines how the moving endpoint accumulates. On a fixed
bulk window, summing the pairwise endpoint error
\(O(X^{2\eta_\varepsilon})\) over \(O(X^2)\) pairs costs

\[
O(X^{2+2\eta_\varepsilon})
\ll_\varepsilon X^{2+\varepsilon}.
\tag{10}
\]

Near the sublinear corner the pairwise bound is not uniform because
\(1-e^{-t}z_\theta^d\) can be small. Equation (9) is the required global
replacement: the entire accumulated endpoint form is the single positive
quantity (6), already bounded at the target scale. No corner-dependent
inverse denominator is introduced.

The same observation handles the angular Gamma-limit tail. Completing
\(|\theta|<X^{-1/2}\) to the full circle adds exactly (7), rather than
summing the nonuniform \(s>\sqrt X\) Fourier error pair by pair.

## 2. Exact finite-\(X\) affine kernel

The actual Lambert field is

\[
H_t(z)=(1-e^{-t})\sum_{d\ge1}
\mu(d)\frac{z^d}{1-e^{-t}z^d}.
\tag{11}
\]

Expanding the future-multiple denominators after finite truncation gives
indices \(a,b\ge1\). Full clock integration contributes

\[
\kappa_{a+b-2}
=\int_0^\infty
(1-e^{-t})^2e^{-(a+b-2)t}w(t)\,dt,
\tag{12}
\]

where

\[
\kappa_m
=m\log m-(2m+1)\log(m+1)+(m+1)\log(m+2)>0.
\tag{13}
\]

This is the complete continuous-minus-gamma/prime-power second variation.
No proper power is deleted.

The full Poisson-circle Fourier coefficient is exact:

\[
\frac1{2\pi}\int_{-\pi}^{\pi}
\frac{e^{ih\theta}}{|1-re^{i\theta}|^2}\,d\theta
=\frac{r^{|h|}}{1-r^2}.
\tag{14}
\]

Consequently

\[
\boxed{
\mathcal E_X=\frac{\mathfrak A_X}{1-r^2},
}
\tag{15}
\]

where

\[
\boxed{\begin{aligned}
\mathfrak A_X
={}&\sum_{a,b\ge1}\kappa_{a+b-2}
\sum_{d,e\ge1}\mu(d)\mu(e)\\
&\quad\times
\exp\!\left[-\frac{ad+be+|ad-be|}{X}\right].
\end{aligned}}
\tag{16}
\]

Equivalently,

\[
\mathfrak A_X
=\sum_{a,b\ge1}\kappa_{a+b-2}
\sum_{d,e\ge1}\mu(d)\mu(e)
e^{-2\max(ad,be)/X}.
\tag{17}
\]

This is an exact finite-\(X\) identity, not an asymptotic Gamma-limit.
Every slope \(a,b\), every affine displacement \(ad-be\), and every Möbius
sign remains. The histories arise from
\(V_mS=S^mV_m\), with strict division
\(V_m^*e_n=1_{m\mid n}e_{n/m}\).

For \(X\ge2\),

\[
\frac1{1-r^2}=\frac1{1-e^{-2/X}}\le X.
\tag{18}
\]

Thus

\[
\mathfrak A_X\ll_\varepsilon X^{1+\varepsilon}
\quad\Longrightarrow\quad
R_X^\varepsilon\le\mathcal E_X
\ll_\varepsilon X^{2+\varepsilon}.
\tag{19}
\]

Equation (16) is the finite-\(X\) version of the affine continuum form in
the preceding note, with no summed radial, angular, or endpoint error.

## 3. Gram structure and diagonal bound

Let

\[
\mathcal G_X(d,e)=
\sum_{a,b\ge1}\kappa_{a+b-2}e^{-2\max(ad,be)/X}.
\tag{20}
\]

The matrix \(\mathcal G_X\) is positive semidefinite. Indeed
\(\kappa_{a+b-2}\) is the Gram matrix of the clock increments

\[
t\longmapsto (1-e^{-t})e^{-(a-1)t},
\tag{21}
\]

and

\[
e^{-2\max(A,B)/X}
=\int_{\max(A,B)}^\infty\frac2X e^{-2y/X}\,dy
\tag{22}
\]

is the Gram matrix of weighted tail indicators. Their tensor product gives
(20).

The exact quadratic is

\[
\mathfrak A_X
=\left\|\sum_{d\ge1}\mu(d)\Phi_{X,d}\right\|^2,
\qquad
\langle\Phi_{X,d},\Phi_{X,e}\rangle=\mathcal G_X(d,e).
\tag{23}
\]

The clock integral gives the elementary bound

\[
\kappa_m\le\frac{C}{(m+1)^2}.
\tag{24}
\]

Grouping \(a,b\) by \(j=\max(a,b)\), there are \(2j-1\) pairs and
\(a+b-2\ge j-1\). Hence

\[
\mathcal G_X(d,d)
\le C\sum_{j\ge1}\frac{e^{-2dj/X}}{j}
=C\{-\log(1-e^{-2d/X})\}.
\tag{25}
\]

In particular,

\[
\boxed{
\mathcal G_X(d,d)\le
\begin{cases}
C\log(eX/d),&1\le d\le X,\\
Ce^{-2d/X},&d\ge X.
\end{cases}}
\tag{26}
\]

The logarithmic divergence at \(d/X\to0\) is the exact
\(u=v=0\) corner found in the continuum calculation.

## 4. Sublinear corner

Put

\[
D_X=\lceil\sqrt X\rceil,\qquad
\mathcal C_X=\{1\le d\le D_X\}.
\tag{27}
\]

By the triangle inequality in the Gram space and (26),

\[
\begin{aligned}
\mathfrak A_X(\mathcal C_X)
&:=\left\|\sum_{d\in\mathcal C_X}\mu(d)\Phi_{X,d}\right\|^2\\
&\le
\left(\sum_{d\le D_X}\sqrt{\mathcal G_X(d,d)}\right)^2\\
&\le C D_X^2\log(eX/D_X)
\ll X\log X.
\end{aligned}
\tag{28}
\]

Thus the entire logarithmic corner, without Möbius cancellation, contributes

\[
\frac{\mathfrak A_X(\mathcal C_X)}{1-r^2}
\ll X^2\log X
\ll_\varepsilon X^{2+\varepsilon}.
\tag{29}
\]

This pays every unit and sublinear self-row simultaneously.

The literal unit vector has

\[
\mathcal G_X(1,1)\le C\log X.
\tag{30}
\]

If \(\mathcal B_X\) denotes the bulk below, its exact symmetric unit--bulk
row is

\[
\mathfrak U_X
=2\sum_{e\in\mathcal B_X}\mu(e)
\sum_{a,b\ge1}\kappa_{a+b-2}
e^{-(a+be+|a-be|)/X}.
\tag{31}
\]

It is not discarded. In the Gram space,

\[
|\mathfrak U_X|
\le2\sqrt{\mathcal G_X(1,1)}
\sqrt{\mathfrak A_X(\mathcal B_X)}
\le C\sqrt{\log X}\,
\sqrt{\mathfrak A_X(\mathcal B_X)}.
\tag{32}
\]

Hence a bulk bound \(O(X^{1+\varepsilon})\) makes the exact unit--bulk row
affordable. Formula (32) is the finite-\(X\) version of the positive
\(u=0\) boundary kernel; it supplies no negative Stokes cancellation.

More generally, all corner--bulk cross terms are retained through

\[
\left\|F_{\mathcal C}+F_{\mathcal B}\right\|^2
\le2\|F_{\mathcal C}\|^2+2\|F_{\mathcal B}\|^2.
\tag{33}
\]

No pairwise absolute sum is taken.

## 5. Large dilation tail

Put

\[
T_X=\lceil X\log X\rceil,\qquad
\mathcal L_X=\{d\ge T_X\}.
\tag{34}
\]

Equations (26) and the Gram triangle inequality give

\[
\begin{aligned}
\mathfrak A_X(\mathcal L_X)
&\le
C\left(\sum_{d\ge T_X}e^{-d/X}\right)^2\\
&\le C X^2e^{-2T_X/X}
\le C.
\end{aligned}
\tag{35}
\]

Thus the infinite large-\(d\) tail and all its future multiples cost
\(O(X)\) after multiplication by \((1-r^2)^{-1}\). Its cross terms with the
bulk and corner are retained by the same Gram norm inequality as (33).

This use of \(T_X=X\log X\) is quantitative. A fixed upper window
\(MX\) would leave \(O(X^3e^{-2M})\) under a pairwise absolute estimate and
would not be uniformly affordable as \(X\to\infty\).

## 6. Exact bulk reduction

Define

\[
\mathcal B_X=\{D_X<d<T_X\},
\tag{36}
\]

and

\[
\boxed{\begin{aligned}
\mathfrak A_X^{\mathrm{bulk}}
={}&\sum_{a,b\ge1}\kappa_{a+b-2}
\sum_{\substack{D_X<d<T_X\\D_X<e<T_X}}
\mu(d)\mu(e)\\
&\quad\times
\exp\!\left[-\frac{ad+be+|ad-be|}{X}\right].
\end{aligned}}
\tag{37}
\]

Write the three Gram vectors as

\[
F_X=F_{\mathcal C}+F_{\mathcal B}+F_{\mathcal L}.
\tag{38}
\]

Then

\[
\mathfrak A_X=\|F_X\|^2
\le3\left(
\mathfrak A_X(\mathcal C_X)
+\mathfrak A_X^{\mathrm{bulk}}
+\mathfrak A_X(\mathcal L_X)\right).
\tag{39}
\]

Combining (28), (35), (39), and (18) proves the finite-\(X\) reduction

\[
\boxed{
\mathfrak A_X^{\mathrm{bulk}}
\ll_\varepsilon X^{1+\varepsilon}
\quad\Longrightarrow\quad
R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}.
}
\tag{40}
\]

Every error outside the bulk is already bounded:

\[
\mathfrak A_X(\mathcal C_X)\ll X\log X,
\qquad
\mathfrak A_X(\mathcal L_X)\ll1.
\tag{41}
\]

The sole new inequality (37)--(40) is a simultaneous growing-horizon
affine Möbius correlation. Its slopes \(a,b\) are unbounded, its divisor
indices range from \(\sqrt X\) to \(X\log X\), and its exact displacement
weight is

\[
\exp[-(ad+be+|ad-be|)/X].
\tag{42}
\]

It is the target-scale finite-\(X\) version of
\(\mathfrak A_{X,\chi}\), with the \(X\)-dependent window
\(\chi_X=1_{(X^{-1/2},\,\log X)}\).

## 7. What has and has not been gained

The local Gamma-limit can be upgraded without accumulating an unaffordable
moving-endpoint error:

- on fixed bulk windows, the direct sum costs
  \(O(X^{2+2\eta_\varepsilon})\), which is affordable;
- at the logarithmic corner, the direct estimate ceases to be uniform, but
  the whole endpoint form is exactly the already-paid positive integral
  (6);
- completing the angular interval introduces exactly the already-paid
  outer integral (7);
- the full completion yields the exact affine form (16), eliminating all
  continuum approximation errors;
- the corner, unit row, and large tail are bounded by (28), (32), and (35).

What remains is (40). The Stokes/Gram geometry does not prove it: positivity
controls the sign of the complete quadratic, not its size on the special
Möbius vector. Via (22), (37) is equivalently a coupled mean square of
Mertens sums at every scale \(Xy/a\). Classical zero-free-region bounds
remain one power too large.

Thus the upgrade produces an exact reduction rather than a proof of the
arithmetic estimate. It isolates the only unbounded component of
\(R_X^\varepsilon\) after all already-paid geometry is restored.

## 8. Verification checks

1. Expanding (11) twice and integrating in \(t\) gives (12) with the index
   \(a+b-2\).
2. The Poisson identity (14) gives
   \(r^{ad+be+|ad-be|}=e^{-2\max(ad,be)/X}\), proving (15)--(17).
3. The endpoint and outer pieces partition the exact domain, proving (9)
   without an approximation or sign change.
4. Grouping \(\max(a,b)=j\) and using
   \(\kappa_{a+b-2}\ll(a+b)^{-2}\) proves (25).
5. The corner sum in (28) is
   \(O(\sqrt X\sqrt{\log X})\) before squaring.
6. Since
   \(\sum_{d\ge X\log X}e^{-d/X}\ll1\), the tail bound (35) has no hidden
   factor \(X\).
7. Equation (39) is the Hilbert inequality
   \(\|x+y+z\|^2\le3(\|x\|^2+\|y\|^2+\|z\|^2)\), so every cross-region term
   is retained.

No fixed-prime limit, RH premise, deleted power, off-domain division state,
or unpaid clock/angular term is used.
