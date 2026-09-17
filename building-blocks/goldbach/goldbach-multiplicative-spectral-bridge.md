# A spectral bridge from centered Goldbach pairs to zeta zeros

This note records the exact additive--multiplicative identity developed
during the RH investigation.  It explains what a Goldbach estimate must
control in order to cross the critical boundary.  The identity is
classical Mellin--Barnes analysis; its application to the centered
von Mangoldt coefficients is an RH criterion, not an unconditional
proof of the required estimate.

## 1. Additive pairs as a multiplicative spectral norm

Let $(a_n)_{n\ge1}$ be a finitely supported real sequence and put

$$
A(w)=\sum_{n\ge1}a_n n^{-w}.
\tag{1}
$$

For every real $\sigma>0$,

$$
\boxed{
\sum_{m,n\ge1}\frac{a_ma_n}{(m+n)^\sigma}
=
\frac1{2\pi}\int_{-\infty}^{\infty}
\frac{|\Gamma(\sigma/2+it)|^2}{\Gamma(\sigma)}
\left|A(\sigma/2+it)\right|^2\,dt .
}
\tag{2}
$$

Indeed, the Mellin--Barnes beta identity gives

$$
\frac1{(m+n)^\sigma}
=\frac1{2\pi}\int_{-\infty}^{\infty}
\frac{\Gamma(\sigma/2+it)\Gamma(\sigma/2-it)}
     {\Gamma(\sigma)}
m^{-\sigma/2-it}n^{-\sigma/2+it}\,dt.
\tag{3}
$$

Summing (3) and using the reality of $a_n$ proves (2).  Equivalently,
if

$$
R_a(k)=\sum_{m+n=k}a_ma_n,
\tag{4}
$$

then the Dirichlet series of the additive convolution is the positive
weighted vertical-line norm

$$
\sum_{k\ge2}\frac{R_a(k)}{k^\sigma}
=
\frac1{2\pi\Gamma(\sigma)}
\int_{\mathbb R}|\Gamma(\sigma/2+it)|^2
|A(\sigma/2+it)|^2\,dt.
\tag{5}
$$

For infinite sequences, (5) follows by truncation whenever either side
is absolutely convergent and the corresponding limiting argument is
valid.

## 2. The centered prime coefficient

Take

$$
a_n=\Lambda(n)-1.
\tag{6}
$$

Its multiplicative transform is

$$
\boxed{
A(w)=-\frac{\zeta'(w)}{\zeta(w)}-\zeta(w),
\qquad \Re w>1.
}
\tag{7}
$$

The additive side is the centered Goldbach correlation

$$
R_a(k)
=\sum_{m+n=k}(\Lambda(m)-1)(\Lambda(n)-1).
\tag{8}
$$

Because the double series is absolutely convergent for $\sigma>2$,
(5) gives the unconditional identity

$$
\boxed{
\sum_{k\ge2}\frac{R_a(k)}{k^\sigma}
=
\frac1{2\pi\Gamma(\sigma)}
\int_{\mathbb R}|\Gamma(\sigma/2+it)|^2
\left|-\frac{\zeta'}{\zeta}(\sigma/2+it)
      -\zeta(\sigma/2+it)\right|^2dt,
\quad \sigma>2.
}
\tag{9}
$$

This is the precise interaction between the additive operation
$m+n=k$ and the multiplicative prime spectrum: the beta kernel turns
the Goldbach quadratic form into an $L^2$ norm of the multiplicative
Dirichlet transform.

## 3. Crossing below two is exactly RH-level

Let

$$
\mathcal G(w)
=-\frac{\zeta'(w)}{\zeta(w)}-\zeta(w)
\tag{10}
$$

denote the meromorphic continuation of (7).  Consider the assertion

$$
\boxed{
\mathcal E(\sigma):=
\frac1{2\pi\Gamma(\sigma)}
\int_{\mathbb R}|\Gamma(\sigma/2+it)|^2
|\mathcal G(\sigma/2+it)|^2dt<\infty
\quad\text{for every }1<\sigma<2.
}
\tag{11}
$$

Then (11) implies RH.  If $\rho=\beta+i\gamma$ were a nontrivial zero
with $1/2<\beta<1$, choose $\sigma=2\beta$.  If the multiplicity is
$m\ge1$, local zero factorization gives

$$
-\frac{\zeta'(w)}{\zeta(w)}
=-\frac{m}{w-\rho}+O(1).
\tag{12}
$$

The term $\zeta(w)$ is holomorphic at $\rho$, while
$\Gamma(\beta+i\gamma)\ne0$.  Along $w=\beta+it$, the integrand in
(11) is therefore bounded below by a positive constant times

$$
\frac1{|t-\gamma|^2}
\tag{13}
$$

on a punctured neighborhood of $\gamma$.  Its integral diverges,
contradicting (11).  Hence zeta has no zero with real part greater than
$1/2$; the functional equation supplies the reflected half and proves
RH.

Conversely, under RH every line $\Re w=\sigma/2>1/2$ is separated from
the nontrivial zeros.  Standard fixed-strip bounds for
$\zeta'/\zeta$ and $\zeta$, together with the exponential decay of
$|\Gamma(\sigma/2+it)|$, make (11) finite.  Thus

$$
\boxed{
\mathrm{RH}
\quad\Longleftrightarrow\quad
\mathcal E(\sigma)<\infty
\text{ for every }1<\sigma<2.
}
\tag{14}
$$

## 4. Exact missing additive theorem

Formula (9) lives initially in $\sigma>2$, where the additive double
sum is absolutely convergent.  A proof based on Goldbach information
must continue the *positive spectral norm*, not merely the signed
Dirichlet series, into $1<\sigma<2$ and show it remains finite there.
Cancellation in

$$
\sum_k R_a(k)k^{-\sigma}
\tag{15}
$$

does not by itself imply finiteness of (11), because the right side is
nonnegative and detects the nonintegrable square of every logarithmic
derivative pole.

This identifies the additive-to-multiplicative bridge without hiding
the RH-scale step:

$$
\boxed{
\text{centered Goldbach control strong enough to prove (11)}
\quad\Longrightarrow\quad
\mathrm{RH}.
}
\tag{16}
$$

Ordinary Goldbach existence or an unsigned main term does not provide
(11).  The required input is a positive continuation/energy estimate
for the complete centered correlation, uniformly across every
vertical line $1/2<\Re w<1$.
