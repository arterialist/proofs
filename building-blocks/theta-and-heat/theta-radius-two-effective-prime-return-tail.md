# Effective full-Chebyshev return for the radius-two barrier

This note makes the outer part of the barrier in
`theta-groundstate-bounded-weighted-crossing.md` effective for the fixed
radius-two data

\[
 d=\frac12-\alpha_2>d_0:=10^{-546},\qquad S=5,
 \qquad M=10^{500}.
\tag{1}
\]

It concerns only the outer-strip estimate.  It retains every prime power
through the full Chebyshev function
\(\psi(x)=\sum_{n\leq x}\Lambda(n)\).

## 1. A fixed barrier and its compact defect

Let

\[
 \chi(s)=
 \begin{cases}
 0,&s\leq0,\\
 3s^2-2s^3,&0<s<1,\\
 1,&s\geq1.
 \end{cases}
\]

On \(O_2=\mathbb R\setminus[-2,2]\), put

\[
 w(u)=1+(M-1)\chi(|u|-5),
\]

and extend \(w\) by zero to the killed core.  Thus \(1\leq w\leq M\) on
\(O_2\), \(w=1\) for \(2<|u|\leq5\), \(w=M\) for \(|u|\geq6\), and
\(|w'|\leq2M\) away from the two hard-core jumps.  Set

\[
 k=M-w,\qquad F=\Phi k,
 \qquad A=6.
\tag{2}
\]

Then \(k\) is even, nonnegative, supported on \([-A,A]\), and has jumps of
size one at \(\pm2\).  The already established tail and mass estimates for
this choice give, with \(d=1/2-\alpha_2\),

\[
 m:=\int_{O_2}w\,d\nu,
 \qquad \frac mM<d,
 \qquad \frac m2<\frac{dM}{2}.
\tag{3}
\]

## 2. Exact prime return and bounded-variation remainder

For \(u>A\), the upward destination \(u+\log q\) lies outside the support
of \(k\).  Hence the prime part of the killed generator is exactly

\[
 D_{\rm p}w(u)=\frac1{b(u)}
 \sum_{q\geq2}\frac{\Lambda(q)}{\sqrt q}
 F(u-\log q),
 \qquad b(u)=2\cosh(u/2).
\tag{4}
\]

Only \(e^{u-A}\leq q\leq e^{u+A}\) can occur.  At a value of \(u\) for
which a prime power lands exactly at either killed-core endpoint, use the
exterior trace in the calculation below.  The actual killed value is zero,
so replacing that trace by the actual value only adds a nonnegative amount
to (4).  Equivalently, one may delete the exceptional atom, perform partial
summation on the adjacent smooth intervals, and then restore its
nonnegative contribution.  Thus no arithmetic endpoint atom is lost from
the lower bound.

Put

\[
 W_u(x)=x^{-1/2}F(u-\log x),
 \qquad a=e^{u-A},\quad c=e^{u+A}.
\]

The support-endpoint values are zero.  Stieltjes integration by parts with
\(E(x)=\psi(x)-x\), applied on the smooth pieces and then recombined, gives,
with the two internal jumps retained in the variation measure,

\[
 \int_{[a,c]}W_u\,d\psi
 =\int_a^cW_u(x)\,dx-\int_{[a,c]}E(x)\,dW_u(x).
\tag{5}
\]

Suppose

\[
 |E(x)|\leq \varepsilon_*x\qquad(a\leq x\leq c).
\tag{6}
\]

Changing variables \(v=u-\log x\) in the main term and in the total
variation gives

\[
 \frac1{b(u)}\int_a^cW_u(x)\,dx
 =\frac1{1+e^{-u}}\int_{-A}^{A}e^{-v/2}F(v)\,dv,
\tag{7}
\]

and

\[
 \frac1{b(u)}\left|\int_{[a,c]}E\,dW_u\right|
 \leq \frac{\varepsilon_*}{1+e^{-u}}C_F,
\tag{8}
\]

where the endpoint-complete bounded-variation constant is

\[
 C_F=
 \int_{-A}^{A}e^{-v/2}|F'_{\rm ac}(v)+F(v)/2|\,dv
 +\sum_{v\in\{-2,2\}}e^{-v/2}|F(v+)-F(v-)|.
\tag{9}
\]

There are no terms at \(\pm A\), since \(k\) is continuous and zero there.
Formula (9), rather than an integral of the classical derivative alone, is
needed because of the killed-core jumps.

The theta normalization gives

\[
 \int_{\mathbb R}e^{-v/2}\Phi(v)\,dv=\frac12.
\]

Evenness of \(w\) and \(\Phi\) gives

\[
 \int_{\mathbb R}e^{-v/2}\Phi(v)w(v)\,dv=\frac m2.
\]

Consequently the main integral in (7) is exactly

\[
 \int_{-A}^{A}e^{-v/2}F(v)\,dv=\frac{M-m}{2}.
\tag{10}
\]

Combining (4)--(10) proves the explicit full-prime-power lower bound

\[
 \boxed{
 D_{\rm p}w(u)\geq
 \frac{M-m}{2(1+e^{-u})}
 -\frac{C_F\varepsilon_*}{1+e^{-u}}
 }
 \qquad(u>A).
\tag{11}
\]

## 3. A coarse explicit bound for the fixed variation

The elementary complete-theta envelopes already used at radius two imply,
for \(t\geq0\),

\[
 \Phi(t)\leq128e^{9t/2-3e^{2t}}<16,
\qquad
 |\Phi'(t)|\leq2560e^{13t/2-3e^{2t}}<512.
\tag{12}
\]

For the derivative bound, writing \(y=e^{2t}\geq1\), its exponent is
\((13/4)\log y-3y\), whose maximum occurs at \(y=13/12\); the inequality
\(\log(13/12)<1/12\) makes that maximum less than \(-5/2\), while
\(e^{5/2}>5\).  Evenness gives (12) on the negative half-line as well.

Since \(0\leq k\leq M\) and \(|k'|\leq2M\) on its smooth pieces,

\[
 |F'_{\rm ac}+F/2|
 \leq (512+32+8)M=552M.
\]

Also

\[
 \int_{-6}^{6}e^{-v/2}\,dv=4\sinh3<2e^3<54.
\]

The two jumps in \(k\) have size one, so their contribution in (9) is less
than \(16(e+e^{-1})<64\leq64M\).  Thus

\[
 \boxed{C_F<30000M<10^5M.}
\tag{13}
\]

## 4. Trudgian's explicit remainder and an outer endpoint

For \(x\geq23\), the full-Chebyshev estimate used in the radius-two notes is

\[
 \frac{|\psi(x)-x|}{x}
 \leq \sqrt{\frac8{17\pi}}\sqrt z\,e^{-z},
 \qquad z=\sqrt{\frac{\log x}{6.455}}.
\tag{14}
\]

The right side decreases for \(z\geq1/2\).  Choose

\[
 \boxed{U=25,820,006=6+6.455\,(2000)^2.}
\tag{15}
\]

If \(u\geq U\), then every \(x\) in the active interval satisfies
\(x\geq e^{u-A}\), hence its parameter in (14) is at least \(2000\).
Using \(\sqrt{2000}<45\), \(e>2\), and \(2^{10}>10^3\), one obtains

\[
 \varepsilon_*<45\,2^{-2000}<10^{-598}.
\tag{16}
\]

The continuous part of \(Dw(u)\) is nonnegative for \(u>A\), since
\(w(u)=M\) is the maximum of the barrier and the killed generator is a sum
of nonnegative departure differences.  From (11),

\[
\begin{aligned}
 (D-\alpha_2)w(u)
 &\geq dM-\frac m2
 -\left(\frac{M-m}{2}e^{-u}+C_F\varepsilon_*\right)\\
 &>\frac{dM}{2}
 -\left(\frac M2e^{-u}+10^{-593}M\right).
\end{aligned}
\tag{17}
\]

At \(u\geq U\), the bracket is less than \(2\cdot10^{-593}M\), which is
less than \(d_0M/4\).  Since \(d>d_0\), (17) yields

\[
 \boxed{
 (D-\alpha_2)w(u)\geq\frac{dM}{4}
 \quad\text{for }u\geq25,820,006.
 }
\tag{18}
\]

Reflection of the even kernel and barrier gives the same estimate for
\(u\leq-25,820,006\).  Therefore the formerly qualitative outer endpoint
in the fixed radius-two barrier can be taken to be

\[
 \boxed{U=25,820,006.}
\]

This does not make the later choice of the continuous cutoff
\(\varepsilon\) effective on the bounded strip \(2<|u|\leq U\); it closes
only the full-Chebyshev prime-return remainder and the outer-tail step for
the fixed barrier.
