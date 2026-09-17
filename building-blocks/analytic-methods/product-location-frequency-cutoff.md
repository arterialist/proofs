# Product locations give a quarter-power frequency cutoff for the full W

This is an unconditional refinement of the actual successor-frequency
construction. It uses the fact that two integer histories have product
locations $\log n+\log m=\log(nm)$, and an elementary short-interval
divisor bound. It uses no RH or bounded mean-square-energy assumption. This is a written proof, not a Lean formalization.
The retained finite-frequency integral is signed and is not bounded here.

Use $a(s)=e^{-s/2}(\psi(e^s)-e^s)$, with $a(0)=-1$, and the fixed causal cutoff $f_t=\chi_ta$ from the [successor theorem](../successor-and-division/actual-successor-frequency-cutoff.md). Here $t\ge1$, $\chi_t=1$ on $[0,t]$, decreases linearly to zero on $[t,t+1]$, and is zero thereafter. The exact derivative measure is

$$
Df_t=\mu_t+w_t(s)\,ds,
\quad
\mu_t=-\delta_0+\sum_{n\ge2}
\chi_t(\log n)\frac{\Lambda(n)}{\sqrt n}\delta_{\log n},
$$
$$
w_t=\chi_t'a-\chi_t(a/2+e^{s/2}).
\tag{1}
$$

Fix a Chebyshev constant $B$ with $\psi(y)\le By$ for $y\ge1$. Then

$$
|w_t(s)|\le C_B e^{s/2}{\bf1}_{[0,t+1]}(s),
\qquad
\|Df_t\|_{\rm TV}\le C_B e^{t/2}.
\tag{2}
$$

The second estimate follows by partial summation of sum Lambda(n)/sqrt n,
and integration of the first estimate. All constants below are uniform in $t$. Let $q_t=f_t*f_t$ be whole-line convolution. On $0\le u\le t$ it agrees exactly with $g(u)=(a*a)(u)$. Its second derivative is the finite measure

$$
D^2q_t=\mu_t*\mu_t+2\mu_t*(w_t\,ds)
+(w_t\,ds)*(w_t\,ds),
\qquad
\|D^2q_t\|_{\rm TV}\le C_B e^t.
\tag{3}
$$

## Local mass of the complete product-history derivative

For Y>=1 and 0<H<=C Y, the elementary hyperbola estimate gives

$$
\sum_{Y<n\le Y+H}\tau(n)
\le2\sum_{d\le\sqrt{Y+H}}(H/d+1)
\ll_C H\log(2Y)+\sqrt Y.
\tag{4}
$$

Every divisor pair of n has a member at most sqrt n, which proves the
first inequality, even when H is smaller than one. This is an upper
bound, so counting a square pair twice is harmless.

The atomic total variation in (3) is dominated by the measure with
mass 1 at zero and mass

$$
\frac{(\Lambda*\Lambda)(n)+2\Lambda(n)}{\sqrt n}
\tag{5}
$$

at log n, for n>=2. Indeed 0<=chi_t<=1, and the two negative initial-atom
cross terms have been included in absolute value. Since
(Lambda*Lambda)(n)<=log²(n) tau(n), (4) implies for u>=0 and 0<h<=1

$$
|\mu_t*\mu_t|([u-h,u+h])
\le C(1+u)^3\bigl[e^{u/2}h+1\bigr].
\tag{6}
$$

For bounded u the initial atom is absorbed by the constant. For larger
u, take Y comparable to exp u and H bounded by a constant times
exp(u)h, and divide (4) by sqrt Y. Every proper prime power remains
in (5); no primality approximation is used.

The remaining measure in (3) has a density v_t satisfying

$$
|v_t(r)|\le C_B e^{r/2}(1+r)\qquad(r\ge0).
\tag{7}
$$

For the mixed part, use (2) and
sum_{n<=exp r} Lambda(n)/n <= B(1+r); the initial atom contributes
at most C_B exp(r/2). For the density-square part, the product of the
two exponential bounds integrates to at most C_B r exp(r/2).
Therefore (6) also holds, with a B-dependent constant, for the entire
measure |D²q_t|:

$$
|D^2q_t|([u-h,u+h])
\le C_B(1+u)^3\bigl[e^{u/2}h+1\bigr].
\tag{8}
$$

## A smooth finite-frequency approximation

Choose once and for all a real even smooth function m, equal to one
on [-1,1] and zero outside [-2,2]. Define, using the Fourier convention
fhat(xi)=integral f(s)exp(-i xi s)ds,

$$
R=\mathcal F^{-1}\!\left[\frac{1-m(\xi)}{(i\xi)^2}\right],
\qquad R_\Omega(z)=\Omega^{-1}R(\Omega z),\qquad \Omega\ge2.
\tag{9}
$$

The multiplier in (9) vanishes near zero, is smooth, and has integrable
derivatives of every order. It is itself integrable. Fourier inversion
and repeated integration by parts imply, for every integer M>=0,

$$
|R(z)|\le C_M(1+|z|)^{-M}.
\tag{10}
$$

In particular, the error identity is exact in distributions and as
continuous functions:

$$
q_t-m(D/\Omega)q_t=R_\Omega*D^2q_t.
\tag{11}
$$

The Fourier transform of the approximation in (11) is
m(xi/Omega) fhat_t(xi)². This is the complex square, not a periodogram.

For 0<=u<=t, split the last convolution into |r-u|<=1 and its complement.
On the first part, decompose into intervals of radii 1/Omega,
2/Omega, 4/Omega, and so on. Using (8) and (10) with M>1 gives

$$
\int_{|r-u|\le1}|R_\Omega(u-r)|\,d|D^2q_t|(r)
\le C_B(1+u)^3
\left[\frac{e^{u/2}}{\Omega^2}+\frac1\Omega\right].
$$

On the complement, (3) and (10) give C_{B,M} exp(t) Omega^(-M-1).
Thus

$$
\boxed{
|g(u)-m(D/\Omega)q_t(u)|
\le C_{B,M}\left\{
(1+u)^3\left[\frac{e^{u/2}}{\Omega^2}+\frac1\Omega\right]
+\frac{e^t}{\Omega^{M+1}}\right\}
\quad(0\le u\le t).
}
\tag{12}
$$

The far-support estimate is essential: q_t also has values beyond t,
and those have not been silently removed. At u=0, its second derivative
has the retained initial atom; the 1/Omega term covers that endpoint.

## Harmonic scales, the causal filter, and the literal same-prime cost

Let Hf(s)=sum_{d<=exp s} f(s-log d)/d, and k(s)=exp(-3s/2) on s>=0.
Summing (12) at u=s-log d, with 0<=s<=t, uses
$\sum d^{-3/2}\le\zeta(3/2)$ and $\sum_{d\le e^s}1/d\le1+s$. It gives

$$
|Hg(s)-H[m(D/\Omega)q_t](s)|
\le C_{B,M}\left[
\frac{e^{s/2}(1+s)^3}{\Omega^2}
+\frac{(1+s)^4}{\Omega}
+\frac{(1+s)e^t}{\Omega^{M+1}}\right].
\tag{13}
$$

The same fixed q_t is used at all times s. Applying the complete filter
I-k* increases the supremum bound by at most 1+integral k=5/3.
Use the exact multiplier from the successor note,

$$
\mathcal M_t(\xi)=
\frac{1/2+i\xi}{3/2+i\xi}e^{i\xi t}
\sum_{d\le e^t}d^{-1-i\xi}
+\frac{e^{-3t/2}}{3/2+i\xi}\sum_{d\le e^t}\sqrt d.
$$

Then the actual arithmetic residual has the finite-frequency formula

$$
\boxed{
\frac{W(e^t)}{e^{3t/2}}
=\frac1{2\pi}\int_{|\xi|\le2\Omega}
m(\xi/\Omega)\widehat f_t(\xi)^2\mathcal M_t(\xi)\,d\xi
-\frac{S_{\rm crit}(e^t)}{e^{3t/2}}+\mathcal E_{t,\Omega},
}
\tag{14}
$$
$$
\boxed{
|\mathcal E_{t,\Omega}|\le C_{B,M}
\left[
\frac{e^{t/2}(1+t)^3}{\Omega^2}
+\frac{(1+t)^4}{\Omega}
+\frac{(1+t)e^t}{\Omega^{M+1}}\right].
}
\tag{15}
$$

Here Scrit is the full literal same-prime sum defined in the successor
note. The continuous density, all ordered pairs, proper powers,
baseline, critical scales, and both causal endpoints remain in (14).

Taking M=4 and Omega=exp(t/4)(1+t)² in (15) proves

$$
\mathcal E_{t,\Omega}=O_B((1+t)^{-1}).
\tag{16}
$$

Thus the full normalized W is recovered, with error tending to zero,
from frequencies of size at most $2x^{1/4}(1+\log x)^2$. This is an actual
product-history regularity theorem. It bounds the discarded frequencies;
it does not bound the retained signed integral or establish eventual
negativity of W. The method's further opportunity is to combine these
localized phase constraints with the exact division-renewal identities,
without replacing their signed arithmetic content by a mean-square
assumption.
