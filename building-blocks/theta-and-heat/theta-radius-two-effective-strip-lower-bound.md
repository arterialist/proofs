# An explicit lower bound on the radius-two barrier strip

Use the explicit cubic barrier from
`theta-radius-two-effective-prime-return-tail.md`:

\[
 M=10^{500},\qquad
 w(u)=1+(M-1)\chi(|u|-5)\quad (|u|>2),
\]

extended by zero to \([-2,2]\), where
\(\chi(s)=0\) for \(s\leq0\), \(\chi(s)=3s^2-2s^3\) on \([0,1]\), and
\(\chi(s)=1\) for \(s\geq1\).  Thus \(1\leq w\leq M\) on the exterior,
\(w\) is radially nondecreasing, and its exterior Lipschitz constant is at
most \(2M\).  This note proves the deliberately coarse bound

\[
 \boxed{
 (D-(1/2-d_0))w(u)\geq-10^{503}
 \quad\text{for almost every }2<|u|\leq25,820,006,
 }
\tag{1}
\]

where \(d_0=10^{-546}\).  In fact the proof gives the stronger right side
\(-577M\).  Every prime power is retained.

## 1. The negative continuous part

Write

\[
 r(t)=\frac{e^{-t/2}}{1-e^{-2t}},\qquad t>0.
\]

The elementary bound

\[
 tr(t)\leq1
\tag{2}
\]

holds on the whole positive axis.  For \(0<t\leq1\),
\(1-e^{-2t}\geq2t/(1+2t)\), and
\(2/(1+2t)\geq e^{-t/2}\); the latter follows by differentiating its
logarithm, whose minimum on this interval is at \(t=1\).  For \(t\geq1\),
\(te^{-t/2}\leq2/e<1-e^{-2}\), proving (2).

If \(w(v)>w(u)\), then both points are exterior and radial monotonicity gives

\[
 0<w(v)-w(u)\leq2M\,\bigl||v|-|u|\bigr|
 \leq2M|v-u|.
\tag{3}
\]

A destination in the killed core instead has \(w(v)=0\) and contributes
with the favorable sign.  Therefore, using \(b(u)=2\cosh(u/2)\geq2\),
\(\int\Phi\leq\frac12\int b\Phi=1/2\), and (2),

\[
\begin{aligned}
 D_{\rm c}w(u)
 &\geq-\frac{2M}{b(u)}
   \int_{\mathbb R}|u-v|r(|u-v|)\Phi(v)\,dv\\
 &\geq-\frac{2M}{b(u)}\int_{\mathbb R}\Phi(v)\,dv
 \geq-\frac M2.
\end{aligned}
\tag{4}
\]

This estimate is uniform up to the hard boundary.  The singular core
killing there is nonnegative and was discarded.

## 2. A global full-prime-power departure bound

Let

\[
 \beta_{\rm p}(u)=\frac1{b(u)}
 \sum_{n\geq2}\frac{\Lambda(n)}{\sqrt n}
 [\Phi(u-\log n)+\Phi(u+\log n)]
\tag{5}
\]

be the complete prime departure rate.  The elementary full-Chebyshev bound

\[
 \psi(x)\leq4(\log2)x<3x\qquad(x\geq1)
\tag{6}
\]

follows from the standard central-binomial argument and includes all proper
prime powers.  Consequently, for every integer \(j\geq0\),

\[
 \sum_{e^j\leq n<e^{j+1}}\frac{\Lambda(n)}{\sqrt n}
 \leq3e\,e^{j/2}.
\tag{7}
\]

Set

\[
 G(v)=e^{|v|/2}\Phi(v),\qquad
 T=\sum_{k\in\mathbb Z}\sup_{k\leq v\leq k+1}G(v).
\tag{8}
\]

For \(u\geq2\), use \(b(u)\geq e^{u/2}\).  On the downward interval
\(u-j-1\leq v\leq u-j\), one has
\(e^{(j-u)/2}\Phi(v)\leq G(v)\).  The same inequality holds on the upward
interval \(u+j\leq v\leq u+j+1\).  Any translated partition into unit
intervals meets each integer unit interval at most twice.  Equations
(5)--(8), first for each orientation and then together, give

\[
 \beta_{\rm p}(u)\leq4e\cdot3\,T.
\tag{9}
\]

Here is a fully elementary bound for \(T\).  The complete theta envelope
gives, for \(t\geq0\),

\[
 G(t)\leq128\exp(5t-3e^{2t}).
\tag{10}
\]

The right side decreases because its logarithmic derivative is
\(5-6e^{2t}<0\).  Put \(a_j=128e^{5j-3e^{2j}}\).  Evenness gives

\[
 T\leq2\sum_{j\geq0}a_j.
\]

Using \(e>8/3\) gives \(a_0=128e^{-3}<7\).  Also \(e<3\), \(e^2>7\)
give

\[
 a_1<128\cdot243\cdot2^{-21}<\frac1{64},
\]

and, for \(j\geq1\),

\[
 \frac{a_{j+1}}{a_j}
 =e^5\exp[-3e^{2j}(e^2-1)]<\frac12.
\]

Thus

\[
 \boxed{T<2(7+2/64)<16.}
\tag{11}
\]

Since \(e<3\), (9) and (11) imply the global estimate

\[
 \boxed{\beta_{\rm p}(u)<576\qquad(u\geq2).}
\tag{12}
\]

Reflection gives the same estimate for \(u\leq-2\).  As
\(w(u)-w(v)\geq-M\) for every destination, including the killed core,

\[
 D_{\rm p}w(u)\geq-M\beta_{\rm p}(u)>-576M.
\tag{13}
\]

## 3. The uniform strip constant

Combine (4) and (13), then use \(0<w\leq M\) and
\(0<1/2-d_0<1/2\):

\[
\begin{aligned}
 (D-(1/2-d_0))w(u)
 &>-576M-\frac M2-\frac M2\\
 &=-577M>-10^{503}.
\end{aligned}
\tag{14}
\]

This holds on the entire exterior, so in particular on the required finite
strip \(2<|u|\leq U\), with \(U=25,820,006\).  The bound is intentionally
not optimized.  Its role is to give one checkable finite lower constant for
the later continuous-cutoff payment.
