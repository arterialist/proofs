# The exact Vaughan remainder of a pole-null terminal prime packet

This note tests a direct arithmetic route to a fixed-power saving for
the [stretched-exponential terminal score](odd-terminal-stretched-exponential-signed-cancellation.md).
The route starts from the exact identity \(\Lambda=\mu*\log\), rather
than its zero expansion. The packet's double Mellin nullity makes
the elementary Vaughan terms small, but leaves a signed Type II
remainder with absolute mass at least a fixed multiple of \(\sqrt X\).
This is a precise failure of termwise positivity or triangle estimates
on that remainder. It does not rule out a signed bilinear estimate.

Let \(v\), \(g=v*v\), and \(I_g>0\) be as in the linked note. For
\(X=e^{2a}\), set
\[
 w_X(x)=x^{-1/2}g(\log(X/x)),\qquad
 K(X)=\sum_{n\ge2}\Lambda(n)w_X(n).
 \tag{1}
\]
The support of \(w_X\) is contained in
\([Xe^{-3/2},Xe^{-1/2}]\), and
\(K(X)=K_v(a)\). It is also the exact successor readout
\(K(X)=\sum_n(\Lambda(n)-1)w_X(n)+O_v(X^{-1/2})\), by the
vanishing integral in (6) and Euler summation. Write \(*\) for
Dirichlet convolution, and put
\(U=V=X^{1/4}\). With
\(\mu_{\le V}=\mu 1_{n\le V}\) and
\(\Lambda_{\le U}=\Lambda 1_{n\le U}\), the exact Vaughan identity is
\[
 \Lambda=\mu_{\le V}*\log+\Lambda_{\le U}
 -\Lambda_{\le U}*\mu_{\le V}*1
 +\mu_{>V}*\Lambda_{>U}*1.
 \tag{2}
\]
It follows at once from \(\Lambda=\mu*\log\),
\(\log=\Lambda*1\), and \(\mu*1=\varepsilon\); the same standard
identity appears in the [complete Vaughan reduction](friable-prime-cross-vaughan-reduction.md).
Define its final
weighted term by
\[
 \mathcal T(X)=\sum_{r>V}\sum_{s>U}\sum_{\ell\ge1}
 \mu(r)\Lambda(s)w_X(rs\ell).
 \tag{3}
\]
Every sum in (3) is finite. All prime powers in \(\Lambda(s)\), all
cofactors \(\ell\), and the actual Möbius signs are retained.

**Theorem.** As \(X\to\infty\),
\[
 \boxed{\quad K(X)=\mathcal T(X)+O_v(1).\quad}
 \tag{4}
\]
Yet the sum of absolute values of the terms in (3) obeys
\[
 \boxed{\quad
 \sum_{r>V}\sum_{s>U}\sum_{\ell\ge1}
 |\mu(r)|\Lambda(s)|w_X(rs\ell)|
 \ge\left(\frac{6\log2}{\pi^2}I_g+o(1)\right)\sqrt X.
 \quad}
 \tag{5}
\]
Thus bounding the Type II remainder term by term cannot give
\(K(X)=O(X^{(1-\delta)/2})\) for any fixed \(\delta>0\).
The theorem isolates the signed arithmetic estimate such a route
would need; it does not claim that estimate is false for the actual
\(\Lambda\).

## Two vanishing moments remove the elementary terms

The Mellin transform of \(g\) is \(F_g(z)=F_v(z)^2\). Since
\(F_v(1)=0\), this transform has a double zero at \(z=1\). Changing
variables \(x=Xe^{-y}\) and differentiating at that point give
\[
 \int_0^\infty w_X(x)\,dx=0,\qquad
 \int_0^\infty(\log x)w_X(x)\,dx=0.
 \tag{6}
\]
Consequently, for every \(d>0\),
\[
 \int_0^\infty w_X(dt)\,dt=0,
 \qquad
 \int_0^\infty(\log t)w_X(dt)\,dt=0.
 \tag{7}
\]
The compact smooth profile also gives
\(\int|w_X'(x)|dx=O_v(X^{-1/2})\) and
\(\int|w_X(x)|dx/x=O_v(X^{-1/2})\).

For \(1\le d\le Xe^{-3/2}\), the support of
\(t\mapsto w_X(dt)\) lies in \([1,\infty)\). Euler summation,
(7), and total variation
therefore yield, uniformly in this range,
\[
 \sum_{m\ge1}w_X(dm)=O_v(X^{-1/2}),\qquad
 \sum_{m\ge1}(\log m)w_X(dm)
   =O_v(X^{-1/2}\log X).
 \tag{8}
\]
The \(\mu_{\le V}*\log\) term in (2) contributes
\(O_v(VX^{-1/2}\log X)=O_v(X^{-1/4}\log X)\).
The \(\Lambda_{\le U}\) term vanishes, since its support lies below
the support of \(w_X\). For the third term, \(rs\le UV=X^{1/2}\),
so (8), \(\sum_{s\le U}\Lambda(s)=O(U)\), and
\(\sum_{r\le V}|\mu(r)|\le V\) give
\[
 \left|\sum_{r\le V}\sum_{s\le U}
   \mu(r)\Lambda(s)\sum_{\ell\ge1}w_X(rs\ell)\right|
 \ll_v UVX^{-1/2}=O_v(1).
 \tag{9}
\]
Substituting into (2) proves (4). The same proof with
\(U=V=X^\theta\), \(0<\theta<1/2\), gives an elementary-term error
\(O_v(X^{\theta-1/2}\log X+X^{2\theta-1/2})\) whenever
\(X^{2\theta}<Xe^{-3/2}\).

## A squarefree Type II row already has full-scale mass

To prove (5), keep only \(\ell=1\) and ordinary primes
\(2U<p\le4U\) in its absolute-value sum. Their paired divisor
\(r\) lies in \([Xe^{-3/2}/p,Xe^{-1/2}/p]\), which is above \(V\)
for large \(X\). The elementary squarefree count
\[
 \sum_{r\le y}\mu(r)^2=\frac6{\pi^2}y+O(\sqrt y)
 \tag{10}
\]
and partial summation for the fixed smooth profile give, uniformly
for \(2U<p\le4U\),
\[
 \sum_r\mu(r)^2|w_X(pr)|
 =\frac6{\pi^2}\frac{\sqrt X}{p}I_g
  +O_v(p^{-1/2}).
 \tag{11}
\]
Indeed, the integral main term follows from
\(r=Xe^{-y}/p\), and the squarefree-count error is
\(O((X/p)^{1/2}\operatorname{Var}|w_X(p\cdot)|)
 =O_v(p^{-1/2})\). By the prime number theorem,
\(\sum_{2U<p\le4U}(\log p)/p=\log2+o(1)\); the sum of the errors
in (11), after multiplication by \(\log p\), is
\(O_v(U^{1/2}\log U)=o(\sqrt X)\). This proves (5).

The obstruction is confined to an absolute-value treatment of this
exact Vaughan remainder. A signed cancellation among its Möbius rows
could still be substantially stronger than (5). The
[sparse coherent-weight countermodel](sparse-prime-weight-ground-positive-terminal-sign-countermodel.md)
does not satisfy the identity \(\Lambda=\mu*\log\): already at a
modified prime \(p\), its coefficient differs by
\((\lambda_p-1)\log p\). Thus it does not refute the exact arithmetic
reduction (4), while it does refute any attempted bound based only on
prime support, PNT, and positive factorial ground. Standard Vaughan
or Heath–Brown rearrangements may exploit further signed correlations;
this calculation shows exactly where a direct zero-frequency
triangle estimate stops.
