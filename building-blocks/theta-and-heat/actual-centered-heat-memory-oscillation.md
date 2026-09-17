# Oscillation of the actual centered-heat memory factor

Independently reviewed written proof, 2026-09-17. This note continues the exact complete-source
cutoff flow in the [finite centered-heat Gram theorem](actual-centered-heat-cutoff-extrema.md).
It proves a signed lower-oscillation statement for the history factor in
that flow, including integer cutoffs. It gives no bound at the RH scale.

Write
\[
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad E(x)=\psi(x)-x,\qquad
I_X=\int_1^X\frac{E(y)}{(X+y)^3}\,dy\quad(X>1).
\tag{1}
\]
The initial density cell and every prime-power atom are present in
\(E\). The companion theorem obtains
\(C_X(t)=t\int_1^X E(y)e^{-ty}dy\) after the entering atom and
frozen terminal charge cancel by integration by parts. Its complete
heat Gram \(\mathcal H(X)=\int_0^\infty C_X(t)^2dt\) is continuous
across every prime-power arrival, with
\[
\mathcal H'(X)=4E(X)I_X
\tag{2}
\]
away from the arrivals. The factor \(I_X\) is continuous for \(X>1\).

**Theorem.** Choose any critical-line zeta zero
\(\rho=1/2+i\gamma\) with \(|\rho+1|>81/16\), and write
\[
c_\rho=\frac{m_\rho}{|\rho|}
\left|\int_0^1\frac{t^{\rho}}{(1+t)^3}\,dt\right|>0,
\tag{3}
\]
where \(m_\rho\) is its multiplicity. Such zeros exist
unconditionally. Then
\[
\limsup_{n\to\infty} n^{3/2}I_n\ge c_\rho,\qquad
\liminf_{n\to\infty} n^{3/2}I_n\le-c_\rho.
\tag{4}
\]
In particular the exact actual memory factor \(I_X\) takes both
strict signs arbitrarily far out, even when sampled at integers.

Set \(X=e^U\), \(y=e^v\), and define
\[
A(v)=e^{-v/2}E(e^v)\mathbf1_{v\ge0},\qquad
D(U)=e^{3U/2}I_{e^U}\quad(U\ge0).
\]
Direct substitution, including the lower endpoint \(y=1\), gives the
one-sided convolution
\[
D(U)=\int_0^U A(v)k(U-v)\,dv,\qquad
k(w)=\mathbf1_{w\ge0}\frac{e^{-3w/2}}{(1+e^{-w})^3}.
\tag{5}
\]
The elementary bound \(\psi(x)\le\sum_{n\le x}\log n
=O(x\log(2x))\) implies \(D(U)=O((1+U)e^{U/2})\). Thus its
Laplace transform converges absolutely for \(\Re z>1/2\).

For \(\Re z>1/2\), put \(s=z+1/2\). The ordinary prime-power
Dirichlet series and Stieltjes integration give
\[
\begin{aligned}
\widehat A(z)
 &=\int_1^\infty E(x)x^{-s-1}\,dx
   =-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1},\\
K(z):=\widehat k(z)
 &=\int_0^1\frac{t^{z+1/2}}{(1+t)^3}\,dt,\\
\widehat D(z)&=K(z)
 \left[-\frac{\zeta'(z+1/2)}
 {(z+1/2)\zeta(z+1/2)}-\frac1{z-1/2}\right].
\tag{6}
\end{aligned}
\]
The term \(-1/(s-1)\) is the exact continuous-density subtraction.
Its pole at \(s=1\) cancels the pole of
\(-\zeta'(s)/(s\zeta(s))\); no terminal or initial atom has been
dropped. The kernel \(K\) is holomorphic for \(\Re z>-3/2\).
For real \(1/2\le s<1\), \(\zeta(s)<0\): the alternating eta
series is positive while \(1-2^{1-s}<0\). Hence (6) is holomorphic
at every real \(z\in[0,1/2]\), including both endpoints.

The multiplier does not erase all critical-line zeros. Let
\(z=\rho-1/2\), where \(\rho=1/2+i\gamma\) is a zero, and put
\(a=\rho+1\). With \(f(w)=(1+e^{-w})^{-3}\),
\[
K(\rho-1/2)=\int_0^\infty e^{-aw}f(w)\,dw,\qquad
f(0)=\frac18,\quad f'(0)=\frac3{16}.
\]
Writing \(q=e^{-w}\), \(f'(w)=3q/(1+q)^4\). It increases to
\(81/256\) at \(q=1/3\) and then decreases to zero. Thus
\(\int_0^\infty|f''(w)|\,dw
=2(81/256)-3/16=57/128\). Two integrations by parts yield
\[
\left|K(\rho-1/2)-\frac1{8a}\right|
\le\frac{3/16+57/128}{|a|^2}
=\frac{81}{128|a|^2}.
\tag{7}
\]
In particular \(K(\rho-1/2)\ne0\) whenever
\(|\rho+1|>81/16\). By [Hardy and Littlewood's critical-line-zero
theorem](https://projecteuclid.org/journals/acta-mathematica/volume-41/issue-none/Contributions-to-the-theory-of-the-riemann-zeta-function-and/10.1007/BF02422942.pdf),
there are infinitely many such zeros. At any one of them the bracket
in (6) has residue \(-m_\rho/\rho\), so \(\widehat D\) has a genuine
nonreal pole at \(z=i\gamma\), of residue
\[
r_\rho=-\frac{m_\rho K(\rho-1/2)}{\rho},
\qquad |r_\rho|=c_\rho.
\tag{8}
\]

Let \(\sigma\) be the real abscissa of *absolute* Laplace
convergence of \(D\). The elementary growth bound gives
\(\sigma\le1/2\). The pole at \(i\gamma\) gives \(\sigma\ge0\):
if \(\sigma<0\), the Laplace integral would be holomorphic there and
analytic uniqueness would contradict the pole in (8). There are
two cases.

If \(\sigma>0\), an eventual upper bound \(D(U)\le B\) would make
\(B-D(U)\) eventually nonnegative. Adding a constant does not change
the positive absolute abscissa \(\sigma\): for any real \(x>0\),
the Laplace integral of the constant converges, and the triangle
inequality works both ways. Landau's positivity principle would
force the transform of \(B-D\) to be singular at real \(\sigma\).
But by (6) it differs from \(-\widehat D(z)+B/z\) only by a finite
interval's entire transform, so it is holomorphic at every real
\(\sigma\in(0,1/2]\). This is impossible. The same argument applied
to \(B+D\) excludes any eventual lower bound. Thus in this case
\(\limsup D(U)=+\infty\) and \(\liminf D(U)=-\infty\).

If \(\sigma=0\), the integral (6) equals its meromorphic
continuation for every \(\Re z>0\). It is regular at \(z=0\), while
it has residue \(r_\rho\) at \(z=i\gamma\). Therefore, as \(x\downarrow0\),
\[
x\widehat D(x)\longrightarrow0,\qquad
x\widehat D(x+i\gamma)\longrightarrow r_\rho.
\tag{9}
\]
Suppose \(D(U)\le c\) eventually for some \(0\le c<c_\rho\).
The nonnegative tail \(N(U)=c-D(U)\), restricted to \(U\ge U_0\),
has a Laplace transform satisfying
\[
|\widehat N(x+i\gamma)|\le\widehat N(x)\qquad(x>0).
\]
The omitted finite interval contributes an entire function and
vanishes after multiplication by \(x\downarrow0\). By (9), the two
sides multiplied by \(x\) tend to \(c_\rho\) and \(c\),
respectively, a contradiction. Applying the same argument to
\(N(U)=c+D(U)\) excludes an eventual lower bound \(-c\).
Since this works for every \(c<c_\rho\),
\[
\limsup_{U\to\infty}D(U)\ge c_\rho,\qquad
\liminf_{U\to\infty}D(U)\le-c_\rho.
\tag{10}
\]
The Landau principle used above follows by expanding a nonnegative
tail transform at a real point just right of its abscissa:
its sign-adjusted Taylor coefficients are nonnegative moments.
Analytic continuation through the real abscissa would imply
convergence to its left by monotone convergence.

Finally these limits survive integer sampling. The elementary bound
\(E(x)=O(x\log(2x))\) gives
\[
I_X=O\!\left(\frac{\log(2X)}X\right),\qquad
I'_X=\frac{E(X)}{(2X)^3}
-3\int_1^X\frac{E(y)}{(X+y)^4}\,dy
=O\!\left(\frac{\log(2X)}{X^2}\right)
\tag{11}
\]
between prime-power arrivals. Hence for \(J(X)=X^{3/2}I_X\),
\(J'(X)=O(\log(2X)/\sqrt X)\) there. As \(J\) is continuous
across every arrival, for integers \(n\to\infty\)
\[
\sup_{n\le X\le n+1}|J(X)-J(n)|
=O\!\left(\frac{\log n}{\sqrt n}\right)=o(1).
\tag{12}
\]
Equations (10)--(12) prove (4), including the unbounded case.

The result supplies a quantitative signed arithmetic constraint on
the memory factor. It does not determine the signs of \(I_n\)
specifically at the infinitely many upward-crossing prime-power
cutoffs, does not bound the size of \(\mathcal H(X)\), and supplies
no RH estimate or Lean formalization.
