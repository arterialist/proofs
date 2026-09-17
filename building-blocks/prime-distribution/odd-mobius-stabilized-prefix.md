# The stabilized odd-Möbius prefix below a prime admission

Let \(p\) be an odd prime, \(D=\prod_{\ell<p,\ \ell\text{ prime}}\ell\),
\(c_2(n)=\mu(n)1_{2\nmid n}\), and

\[
A_D(n)=\sum_{\substack{d\mid D\\d\mid n}}
            \mu(d)c_2(n/d).                                  \tag{1}
\]

For every \(1\leq n<p\), every divisor with nonzero Möbius weight
uses primes below \(p\), hence lies in \(D\). Therefore

\[
A_D(n)=a(n):=(\mu*\mu_{\mathrm{odd}})(n),\qquad
\mu_{\mathrm{odd}}(n)=\mu(n)1_{2\nmid n}.                \tag{2}
\]

At the newly admitted prime itself, only \(d=1\) is available in
(1), so \(A_D(p)=\mu(p)=-1\), whereas \(a(p)=-2\). This one-unit
endpoint distinction is essential:

\[
S_D(p):=\sum_{n\leq p}A_D(n)
=\sum_{n<p}a(n)-1.                                      \tag{3}
\]

The local factors of \(a\) make its exact coefficient transparent. If
\(n=2^b\prod_{\ell\text{ odd}}\ell^{e_\ell}\), then the 2-factor is
\(1,-1,0\) for \(b=0,1,\geq2\), respectively. At an odd prime the
factors for exponent \(e=0,1,2,\geq3\) are \(1,-2,1,0\).
Consequently, if \(b\leq1\) and every odd \(e_\ell\leq2\), and if
\(t=\#\{\ell\text{ odd}:e_\ell=1\}\), then

\[
a(n)=(-1)^{b+t}2^t;                                  \tag{4}
\]

otherwise \(a(n)=0\). In particular, for **squarefree** \(n<p\),

\[
A_D(n)=\mu(n)2^{\omega_{\mathrm{odd}}(n)}.           \tag{5}
\]

Equation (5) does not extend to every nonsquarefree number by putting
zero on the right: odd prime squares contribute \(+1\). For example
\(a(9)=1\) and \(a(18)=-1\); only a third odd prime power or \(4\mid n\)
forces zero. The exact Dirichlet series is

\[
\sum_{n\geq1}\frac{a(n)}{n^s}
=\frac{1}{(1-2^{-s})\zeta(s)^2}
=(1-2^{-s})\prod_{\ell\text{ odd prime}}(1-\ell^{-s})^2,
\qquad \Re s>1.                                             \tag{6}
\]

These facts supply no one-sided all-scale sign. The stabilized prefix
\(\sum_{n\leq x}a(n)\) equals \(+1\) at \(x=1\) and \(-2\) at
\(x=3\). The actual admission prefix in (3) is \(-3\) at \(p=5\)
and \(+1\) at \(p=23\), as checked in the
[principal-mode certificate](../../formalization/verification/post_branch_principal_mode_x2.py).
The elementary all-scale absolute bound is

\[
\left|\sum_{n\leq x}a(n)\right|
\leq\sum_{n\leq x}\tau(n)
=\sum_{d\leq x}\left\lfloor\frac xd\right\rfloor
\leq x(1+\log x),\qquad x\geq1,                        \tag{7}
\]

because \(|a(n)|\leq\tau(n)\). Strong cancellation at a square-root
scale would require a global estimate for this doubled-Möbius prefix;
it does not follow from the local factors or the finite stabilization.
Moreover, the complete energy's principal mode also contains an
Abel-weighted past and future, as the
[separate sign audit](../prime-history/post-branch-principal-mode-x2.md) retains.

The [Lean finite module](../../formalization/BuildingBlocks/StableOddMobiusPrefixFinite.lean)
uses Mathlib's actual Möbius function. It proves that a squarefree
divisor of positive \(n<p\) divides the literal product of all primes
below \(p\), then discharges the hypothesis and proves (2) for every
positive \(n<p\). It also proves the distinct \(-1\) versus \(-2\)
prime-endpoint coefficients, conditional there only on the explicit
fact \(p\nmid D\). The local Euler-product coefficient formula and
analytic claims in this note are not claimed as Lean theorems.
