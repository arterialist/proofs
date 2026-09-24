# The actual Weil residual of Connes's prolate trial vector

[Connes, equations (19)--(21) and Section 6.6](https://arxiv.org/html/2602.04022)
uses $k_\lambda=\mathcal E(h_\lambda)$ as a trial vector for the
lowest eigenfunction of the compact Weil operator $A_\lambda$.
Its small prolate leakage and its small Weil Rayleigh quotient do not
bound $\|(A_\lambda-R_\lambda)k_\lambda\|$. Here is an exact formula
for that residual, including its boundary behavior. The resulting
lower estimate is nonuniform in $\lambda$; it does not decide the
eigenvector approximation in Section 6.6.

## Full operator and its domain

Put $a=\log\lambda$ and identify
$L^2([\lambda^{-1},\lambda],du/u)$ with $L^2(-a,a)$ by $x=\log u$.
Extend each function by zero outside $(-a,a)$. Define

\[
r(s)=\frac{e^{-s/2}}{1-e^{-2s}}\quad(s>0),\qquad
m_0=\psi(1/4)-\log\pi,\qquad
d_n=\log n,\quad w_n=\frac{\Lambda(n)}{\sqrt n},
\]
\[
M_\pm(f)=\int_{-a}^{a}e^{\pm y/2}f(y)\,dy.
\]

The digamma integral representation gives the exact multiplier
identity

\[
\operatorname{Re}\psi(1/4+it/2)-\log\pi
=m_0+2\int_0^\infty r(s)(1-\cos ts)\,ds.                \tag{1}
\]

Consequently [the full Connes--Consani Weil form, equations
(2.11)--(2.12)](https://arxiv.org/html/2106.01715) has the
following associated operator, for functions in its operator domain:

\[
\boxed{\begin{aligned}
(A_a f)(x)={}&m_0 f(x)
 +\int_{\mathbb R}r(|x-y|)\bigl(f(x)-f(y)\bigr)\,dy\\
 &+e^{x/2}M_-(f)+e^{-x/2}M_+(f)\\
 &-\sum_{d_n<2a}w_n\bigl[f(x+d_n)+f(x-d_n)\bigr],
 \qquad |x|<a .
\end{aligned}}                                               \tag{2}
\]

The integral is the symmetric second-difference operator from (1),
interpreted in $L^2$ when needed. In particular the pole operator has
the two terms shown in (2), without an extra factor of two: its
quadratic form is $2M_+(f)M_-(f)$ for real $f$. The finite shift sum
contains every admitted prime power. At $d_n=2a$ its overlap has
measure zero, so strict versus weak inclusion is immaterial.

There is a useful boundary version of (2). For $|x|<a$, split the
integral at the window endpoints and put

\[
H(d)=\int_d^\infty r(s)\,ds
=\operatorname{artanh}(e^{-d/2})+\arctan(e^{-d/2}).
\]

Then the archimedean integral equals

\[
\int_{-a}^{a}r(|x-y|)(f(x)-f(y))\,dy
 +\bigl[H(a-x)+H(a+x)\bigr]f(x),                       \tag{3}
\]

and $H(d)=\tfrac12\log(4/d)+\pi/4+O(d)$ as $d\downarrow0$.
The second term records the interaction with the zero extension
outside the window.

## The prolate summation vector and its jumps

Let $h_\lambda$ be Connes's nonzero linear combination of the even
prolate functions $h_{0,\lambda},h_{4,\lambda}$ with
$\int_{-\lambda}^{\lambda}h_\lambda(v)\,dv=0$, extended by zero
outside $[-\lambda,\lambda]$. For $x\in(-a,a)$, equation (20) is

\[
k_a(x)=e^{x/2}\sum_{1\le n<\lambda e^{-x}}
                 h_\lambda(ne^x).                            \tag{4}
\]

The convention at equality changes only point values. Formula (4)
is smooth between the finite set of sites

\[
x_n=a-\log n,\qquad 1\le n<\lambda^2.
\]

For $n\ge2$, its right-minus-left jump at $x_n$ is

\[
J_n=-\sqrt{\lambda/n}\,h_\lambda(\lambda).            \tag{5}
\]

At the upper window endpoint the one-sided value is
$B_+:=k_a(a-)=\sqrt\lambda,h_\lambda(\lambda)$. At the lower
endpoint it is

\[
B_-:=k_a(-a+)=\lambda^{-1/2}
       \sum_{1\le n<\lambda^2}h_\lambda(n/\lambda).       \tag{6}
\]

Thus (4), after zero extension, is compactly supported and piecewise
smooth with finitely many jumps. Integration by parts on each smooth
piece gives $\widehat{k_a}(t)=O_\lambda(1/|t|)$. Since the multiplier
in (1) grows like $\log|t|$, one has
$\int |m(t)\widehat{k_a}(t)|^2dt<\infty$. The bounded pole and prime
operators do not change this conclusion. Hence $k_a$ belongs to the
operator domain of $A_a$, not merely its form domain, and (2) is its
actual $L^2$ operator value.

The lower value (6) has an exact Poisson form that displays a small
defect omitted if one assumes $h_\lambda(0)=0$. Use the additive
Fourier convention
$\widehat h(\xi)=\int_{\mathbb R}h(v)e^{2\pi i\xi v}dv$.
For $\lambda^2\notin\mathbb N$, Poisson summation, with the Fourier
series taken in its symmetric sense, gives

\[
\boxed{\quad B_-=
 \sqrt\lambda\sum_{m\ge1}\widehat h_\lambda(m\lambda)
 -\frac{h_\lambda(0)}{2\sqrt\lambda}.\quad}       \tag{7}
\]

If $\lambda^2\in\mathbb N$, the one-sided value in (6) excludes the
last lattice point while Poisson summation assigns a half-value to
the jump at $\lambda$. The right side of (7) then has the additional
term $-h_\lambda(\lambda)/(2\sqrt\lambda)$. One may always use the
finite sum (6), which avoids a convergence convention.

To see why the defect in (7) is genuine, let
$I_j=\int_{-\lambda}^{\lambda}h_{j,\lambda}$ and choose the scalar
normalization $h_\lambda=I_0h_{4,\lambda}-I_4h_{0,\lambda}$.
The compressed Fourier eigenrelations at zero give
$I_0=\chi_0h_{0,\lambda}(0)$ and
$I_4=\chi_2h_{4,\lambda}(0)$. Therefore

\[
h_\lambda(0)
 =(\chi_0-\chi_2)
 h_{0,\lambda}(0)h_{4,\lambda}(0)\ne0,                 \tag{8}
\]

because $\chi_0>\chi_2>0$ and an even nonzero prolate eigenfunction
cannot vanish at zero. The second equality follows from uniqueness
for its regular differential equation at zero. Thus zero integral
only approximately enforces the second condition $h(0)=0$ used in
Connes's exact Poisson identity (21). Equation (7) keeps its defect.

## Residual singularities and a lower estimate

Set $R_a=\langle A_a k_a,k_a\rangle/\|k_a\|_2^2$ and
$g_a=(A_a-R_a)k_a$. Substituting (4) into (2) is a source-exact
formula for the residual. In particular, on sufficiently short
one-sided collars at the endpoints, (3) yields

\[
g_a(a-s)=\frac{B_+}{2}\log(1/s)+G_+(s),\qquad
g_a(-a+s)=\frac{B_-}{2}\log(1/s)+G_-(s),                 \tag{9}
\]

where $G_\pm$ extend continuously to $s=0$. The interior integral in
(3) has a finite one-sided limit because $k_a$ is smooth up to each
window endpoint. The pole terms, $R_ak_a$, and prime translates are
bounded and one-sided smooth there. Some translated jump sites may
coincide with an endpoint, but they remain bounded. They cannot
cancel either logarithm. At an interior site $x_n$, the archimedean
part has the analogous singular term

\[
\frac{J_n}{2}\operatorname{sgn}(x-x_n)
                    \log(1/|x-x_n|)+O_\lambda(1).       \tag{10}
\]

These logarithms are square integrable, in agreement with the domain
argument above. They show that $k_a$ is not an exact eigenvector
whenever $B_+\ne0$ or $B_-\ne0$. The upper coefficient is nonzero
except possibly at isolated scales: the prolate eigenfunctions and
their integrals depend analytically on $c=2\pi\lambda^2$, and the
endpoint determinant $I_0h_{4,\lambda}(\lambda)-I_4h_{0,\lambda}(\lambda)$
is nonzero in the $c\downarrow0$ Legendre limit.

There is also a quantitative, though nonuniform, lower estimate. Let
$0<\delta$ be short enough that the upper and lower collars are
disjoint and contain no interior or translated jump sites. For
$0<s<\delta$, set
$\rho_\delta(s)=\log(\delta/s)-1$. It has mean zero and
$\int_0^\delta\rho_\delta(s)^2ds=\delta$. Define
$\omega_\pm(\delta)=\sup_{0<s<\delta}|G_\pm(s)-G_\pm(0)|$.
Pairing $g_a$ with the two disjoint, normalized copies of
$\rho_\delta$ and applying Bessel's inequality gives

\[
\boxed{\quad
\frac{\|g_a\|_2}{\|k_a\|_2}
\ge\frac{\sqrt\delta}{\|k_a\|_2}
\left\{\sum_{\sigma\in\{+,-\}}
 \left(\frac{|B_\sigma|}{2}
       -\frac{2}{e}\omega_\sigma(\delta)\right)_+^2
\right\}^{1/2}.\quad}                                  \tag{11}
\]

Indeed $\int_0^\delta\rho_\delta=0$,
$\int_0^\delta\log(1/s)\rho_\delta(s)ds=\delta$, and
$\int_0^\delta|\rho_\delta(s)|ds=2\delta/e$.
The same proof works with $A_a-z$ for any real scalar $z$;
subtracting the Rayleigh quotient cannot remove the logarithmic
endpoint coefficients. Continuity gives $\omega_\pm(\delta)\to0$
for each fixed $\lambda$. An asymptotic comparison requires bounds
on $B_\pm$, the moduli $\omega_\pm$, and the actual Weil gap as
$\lambda$ grows. Equation (11) alone supplies no uniform ratio.

The remainder in (9) has a more specific local modulus. Since $k_a$
is smooth on a short one-sided collar and $r(s)=1/(2s)+O(1)$, its
interior integral changes by $O_a(\delta(1+|\log\delta|))$ there.
The other terms have the same or better modulus. Thus some finite
$L_a$ satisfies
$\omega_\pm(\delta)\le L_a\delta(1+|\log\delta|)$
for all sufficiently small $\delta$. This suggests a precise
conditional obstruction. Put $c=2\pi\lambda^2$. If along a cofinal
set of scales $|B_+|$ is bounded below by a polynomial in $c$ times
$e^{-c}$, while $L_a$ and $\|k_a\|_2$ grow at most polynomially and
$0<E_1-R_a$ is bounded above by a polynomial times $e^{-2c}$,
and the endpoint collar admits the width below, choose
$\delta=e^{-c}$ divided by a sufficiently large polynomial. Then
(11) gives $\|g_a\|_2/\|k_a\|_2$ at least a polynomial multiple of
$e^{-3c/2}$, and its ratio to $E_1-R_a$ diverges. These are
**hypotheses**, not consequences of prolate leakage: the needed
lower bound for the endpoint combination and upper bound for the
*Weil* gap are not established here.

## Prolate endpoint data versus the Weil gap

There is an exact bridge from prolate concentration eigenvalues to
the individual endpoint values. On $[-1,1]$, let

\[
(K_c\psi)(x)=\int_{-1}^{1}
 \frac{\sin c(x-y)}{\pi(x-y)}\psi(y)dy,
\quad K_c\psi_j=\nu_j(c)\psi_j,
\quad\|\psi_j\|_2=1,
\quad c=2\pi\lambda^2.
\]

For an even prolate eigenfunction, Feynman--Hellmann and the finite
Fourier eigenrelation give

\[
\boxed{\qquad
\nu_j'(c)=\frac{2\nu_j(c)}{c}|\psi_j(1;c)|^2,
\qquad |\psi_j(1;c)|^2
=\frac c2\frac{d}{dc}\log\nu_j(c).\qquad}            \tag{12}
\]

In fact $K_c'(x,y)=\cos(c(x-y))/\pi$, so its expectation is
$\pi^{-1}|\int\psi_j(y)e^{icy}dy|^2$; at $x=1$ the integral is
$\mu_j\psi_j(1)$ and $|\mu_j|^2=2\pi\nu_j/c$.
Formula (12) controls the magnitudes of $h_{0,\lambda}(\lambda)$
and $h_{4,\lambda}(\lambda)$ separately. The combination in $B_+$
can cancel, so it needs its own estimate. One also cannot
differentiate Connes's asymptotic for $1-\chi_2$ without a separate
uniform derivative argument.

At $a=0.8$, [Zhu's certified parity bounds, Theorem
6.2](https://arxiv.org/html/2608.24827v2) give
$E_1\le2.347\cdot10^{-14}$ and $E_0\ge8.9\cdot10^{-18}$.
Thus if $R_a<E_1$, then

\[
E_1-R_a\le2.34611\cdot10^{-14}.                         \tag{13}
\]

A certified instance of (11) exceeding the right side of (13)
would prove that this particular residual-to-gap test fails at
$a=0.8$. We have not supplied interval enclosures for the prolate
endpoint values or for $\omega_\pm(\delta)$, so no such comparison
is claimed. The figures and eigenfunction matches in
[Connes--Consani, Section 3](https://arxiv.org/html/2106.01715)
are numerical; they do not bound this Weil-operator residual.
Connes's Fact 6.4 controls the Fourier transform of $k_\lambda$,
not the norm in (11). This note supplies no uniform all-scale estimate.

The later [all-scale raw-vector analysis](connes-raw-prolate-residual-gap-obstruction.md)
establishes the endpoint lower bound and a polynomially uniform upper-collar
modulus along $\lambda^2=N+1/2$. Together with an actual two-vector bound
on $E_1$, it shows that the particular residual-to-gap quotient in (3)
cannot tend to zero for this unsmoothed vector. That result does not rule
out a Temple estimate or another route to the ground eigenvector.
