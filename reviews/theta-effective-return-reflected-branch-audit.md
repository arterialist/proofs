# Audit of the radius-two effective reflected return

Let the radius-two barrier be extended by zero on \([-2,2]\), let its height be \(M\), and choose its transition so that it equals \(M\) for \(|u|\ge6\).  Put

\[
 k:=M-w.
\]

Then \(k\) is even, nonnegative, and supported in \([-6,6]\).  It is piecewise smooth rather than globally absolutely continuous: because the killed barrier is zero on the closed core and equals one immediately outside it, \(k\) has hard jumps at \(u=\pm2\).

## 1. Exact prime sign and main mass

Write \(K_u\) for the full prime destination operator and \(b_{\rm p}(u)=K_u(1)\).  The positive generator has prime part

\[
 D_{\rm p}f(u)=b_{\rm p}(u)f(u)-K_u(f).
\]

Since constants are annihilated and \(k(u)=0\) for \(u>6\),

\[
 D_{\rm p}w(u)=D_{\rm p}(M-k)(u)=K_u(k)\ge0.
 \tag{1}
\]

Thus the arrival sign is positive.  Only the reflected branch remains, because \(k(u+\log q)=0\):

\[
 D_{\rm p}w(u)=
 \frac1{2\cosh(u/2)}
 \sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 \Phi(u-\log q)k(u-\log q).
 \tag{2}
\]

Set \(F=\Phi k\).  Since

\[
 \frac1{2\cosh(u/2)}=
 \frac{e^{-u/2}}{1+e^{-u}},
\]

the exact Stieltjes calculation gives, for almost every \(u>6\),

\[
 D_{\rm p}w(u)=
 \frac{I_-+R_-(u)}{1+e^{-u}},
 \qquad
 I_-:=\int_{\mathbb R}e^{-v/2}F(v)\,dv,
 \tag{3}
\]

where

\[
 R_-(u)=
 \int_{[-6,6]}
 \eta(e^{u-v})e^{-v/2}
 \left(dF(v)+\frac12F(v)\,dv\right),
 \qquad
 \eta(x)=\frac{\psi_{\rm Ch}(x)-x}{x}.
 \tag{4}
\]

The sign before \(R_-\) is plus.  Formula (4) is a signed Stieltjes integral; replacing \(dF\) by \(F'(v)\,dv\) loses the two hard-core atoms.

The normalization is exact.  Since

\[
 d\mu_-(v)=(1-\tanh(v/2))\,d\nu(v)
 =2e^{-v/2}\Phi(v)\,dv,
\]

evenness of \(k\) gives

\[
 2I_-=\mu_-(k)=\nu(k)=M-m,
 \qquad m:=\int_{O_2}w\,d\nu.
\]

Therefore the main term in (3) is exactly

\[
 \boxed{\frac{\lambda(M-m)}{1+e^{-u}}},
 \qquad \lambda=\frac12.
 \tag{5}
\]

There is no missing factor of two.

## 2. Endpoint terms

The general partial-summation identity contains

\[
 e^{-u/2}F(u)-\int_u^\infty e^{-v/2}F(v)\,dv.
\]

Both terms vanish for \(u>6\).  This also retains the lower arithmetic endpoint \(E(1)=-1\): its coefficient is \(F(u)=0\).  At the support endpoints \(v=\pm6\), the chosen smooth transition has \(F(\pm6)=0\), so an atom landing exactly there contributes zero.

The hard-core jumps do contribute to (4).  In distributional notation,

\[
 \Delta F(-2)=+\Phi(2),
 \qquad
 \Delta F(2)=-\Phi(2).
\]

Their combined signed contribution is

\[
 \Phi(2)\left[
 e\,\eta(e^{u+2})-e^{-1}\eta(e^{u-2})
 \right].
 \tag{6}
\]

The values assigned at the two hard endpoints affect the arithmetic sum only when a prime power lands exactly at an endpoint, a countable set of \(u\).  The killed-generator barrier inequality is an almost-everywhere statement, so (3)--(6) are exact in the required sense after fixing any consistent BV representative.  A pointwise-for-every-\(u\) version must add those isolated landing terms explicitly rather than claim that \(F\) is absolutely continuous.

The correct error norm is consequently

\[
 C_F^{\rm BV}:=
 \int_{[-6,6]}e^{-v/2}
 \left|dF(v)+\frac12F(v)\,dv\right|,
 \tag{7}
\]

or the slightly coarser sum of the two total variations.  Then

\[
 |R_-(u)|\le
 C_F^{\rm BV}\sup_{v\in[-6,6]}|\eta(e^{u-v})|.
 \tag{8}
\]

Thus the proposed bound \(C_F\le10^5M\) is usable without change only if \(C_F\) was defined by (7) and already includes (6).  If \(10^5M\) bounded only the smooth derivative integral, enlarge it by the two jump atoms.  The harmless coarse replacement \(C_F^{\rm BV}\le2\cdot10^5M\) preserves every numerical conclusion below; no optimization is needed.

## 3. The continuous term is nonnegative

For \(u>6\), \(w(u)=M\) and hence

\[
 D_{\rm arch}w(u)=
 \frac1{2\cosh(u/2)}
 \int_{\mathbb R}\Phi(v)r(|u-v|)
 [w(u)-w(v)]\,dv
 =\frac1{2\cosh(u/2)}
 \int\Phi(v)r(|u-v|)k(v)\,dv\ge0.
 \tag{9}
\]

This includes destinations in the killed core, where \(w=0\) and \(k=M\).  Therefore the continuous part may be discarded in a lower bound for \(Dw(u)\).  It may not be described as zero; it is generally strictly positive.

## 4. Audit of \(U=25{,}820{,}006\)

Trudgian's full-Chebyshev estimate can be written

\[
 |\eta(y)|\le
 \epsilon_0(y):=
 \sqrt{\frac8{17\pi}}\,z_y^{1/2}e^{-z_y},
 \qquad
 z_y=\sqrt{\frac{\log y}{6.455}},
 \qquad y\ge23.
 \tag{10}
\]

The right side decreases once \(z_y\ge1/2\).  For \(v\in[-6,6]\) and \(u\ge U\),

\[
 \log(e^{u-v})\ge u-6.
\]

At

\[
 U:=25{,}820{,}006
\]

one has exactly

\[
 \sqrt{\frac{U-6}{6.455}}=2000.
\]

Consequently

\[
 \sup_{v\in[-6,6]}|\eta(e^{u-v})|
 \le \sqrt{\frac8{17\pi}}\sqrt{2000}\,e^{-2000}
 <45e^{-2000}<45\cdot10^{-600}.
 \tag{11}
\]

The last inequality uses only \(e>2\) and \(2^{10}>10^3\).  Under the proposed \(C_F^{\rm BV}\le10^5M\), (8) gives

\[
 |R_-(u)|<4.5\cdot10^{-594}M.
 \tag{12}
\]

Even after the safe enlargement \(C_F^{\rm BV}\le2\cdot10^5M\), the right side is below \(9\cdot10^{-594}M\).  The denominator in (5) costs at most

\[
 \lambda(M-m)\frac{e^{-u}}{1+e^{-u}}
 \le\frac M2e^{-u},
 \tag{13}
\]

which is far smaller still.  Hence, for \(d_0=10^{-546}\), (11)--(13) imply the deliberately coarse but sufficient estimate

\[
 Dw(u)\ge \lambda(M-m)-\frac{d_0M}{4}
 \qquad(u\ge U)
 \tag{14}
\]

almost everywhere.  Using the already established \(m/M<d_0\) and \(\alpha_2<\lambda-d_0\),

\[
 (D-\alpha_2)w(u)
 >d_0M-\lambda m-\frac{d_0M}{4}
 >\frac{d_0M}{4}.
 \tag{15}
\]

Thus \(U=25{,}820{,}006\) is a valid cutoff with enormous slack.  The required corrections are structural rather than numerical: use the positive arrival sign in (1), retain the denominator in (5), and define the Stieltjes error by the BV measure (7), including the signed hard-core atoms (6).
