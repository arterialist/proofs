# Uniform coercivity on complete prime-power two-window spaces

For every prime power \(q=p^k\ge8\), the complete actual-zeta Weil form is
uniformly positive on **every real smooth test supported in two narrow
windows centered at** \(\pm\tfrac12\log q\), provided only that the two
global pole moments vanish. The two packet profiles may be independent;
their individual pole moments need not vanish. This extends the earlier
[isolated prime-power antisymmetric packet](actual-prime-power-two-packet-positive-cones.md)
without requiring Zhu's small coercivity constant. It is a restricted
positive subspace result, not positivity on the full Weil test space and
not an implication to RH.

Put \(d=\log q\), \(w=1/(4q)\), and take arbitrary real
\(u,v\in C_c^\infty((-w/2,w/2))\). Set
\[
f(x)=u(x+d/2)+v(x-d/2),\qquad
M_\pm(f)=\int_{\mathbb R} e^{\pm x/2}f(x)\,dx.
\]
Assume \(M_+(f)=M_-(f)=0\), and let \(f\ne0\). In the normalization of
the [full actual Weil form](three-window-global-pole-null-weil-bound.md),
\[
\boxed{\quad Q(f)>\frac{23}{42}\|f\|_2^2.\quad} \tag{1}
\]
This is an infinite-dimensional globally pole-null subspace at every
prime-power scale. It includes proper powers, both packet signs and
arbitrary transfer of pole moments between the two windows.

## A source-explicit bound for one narrow packet

Write
\[
\Gamma(g)=\frac1{2\pi}\int_{\mathbb R}|\widehat g(t)|^2h(t)\,dt,
\qquad h(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi .
\]
For every nonzero smooth \(g\) supported in an interval of width at most
\(1/28\),
\[
\Gamma(g)>\frac43\|g\|_2^2. \tag{2}
\]
Here is a rational certificate. The [digamma series](https://dlmf.nist.gov/5.7.E6)
gives, for \(t\ge0\),
\[
h(t)=h(0)+\sum_{n\ge0}
\frac{16t^2}{(4n+1)((4n+1)^2+4t^2)}.
\]
Thus \(h\) is even and increasing on \([0,\infty)\). The
[quarter-digamma value](https://dlmf.nist.gov/5.4.E19) is
\(h(0)=-\gamma-\pi/2-3\log2-\log\pi\). The elementary bounds
\(\gamma<3/5\), \(\pi<22/7\), \(\log2<7/10\), and
\(\log\pi<6/5\) give \(h(0)>-383/70>-11/2\).
For \(\gamma<3/5\), note that
\(H_n-\log(n+1/2)\downarrow\gamma\) and
\(1-\log(3/2)<3/5\); the logarithm bounds follow from the cubic
Taylor lower sums of \(e^{7/10}\) and \(e^{6/5}\).

By Cauchy--Schwarz, \(|\widehat g(t)|^2\le w\|g\|_2^2\). Folding the
Plancherel probability density to \(t\ge0\) gives a density bounded
by \(w/\pi<1/84\). Monotonicity and comparison with the uniform
density on \([0,84]\) therefore imply
\[
\frac{\Gamma(g)}{\|g\|_2^2}
\ge \frac1{84}\int_0^{84}h(t)\,dt
\ge \frac1{84}\sum_{j=0}^{83}h(j).
\]
The exact integer floor sum
\[
\sum_{j=0}^{83}\sum_{n=0}^{63}
\left\lfloor\frac{160000j^2}
{(4n+1)((4n+1)^2+4j^2)}\right\rfloor
=5{,}744{,}337>5{,}740{,}000
=84\left(\frac{11}{2}+\frac43\right)10^4
\]
proves (2). The four consecutive 21-row blocks are
\(1{,}126{,}550\), \(1{,}452{,}301\), \(1{,}553{,}555\), and
\(1{,}611{,}931\). These exact values and their strict threshold are
checked by Lean in
[ActualWeilTwoWindowCoercivity.lean](../../formalization/BuildingBlocks/ActualWeilTwoWindowCoercivity.lean).

## Complete prime-power and gamma rows

The packet supports are disjoint, so
\(\|f\|_2^2=\|u\|_2^2+\|v\|_2^2\). For \(n\ge2\), the self-window
correlations vanish because \(w<\log2\). A cross-window correlation
can survive only when \(|\log n-d|<w\). Nearest-integer logarithmic
spacing at \(q\ge8\) makes \(n=q\) the sole eligible integer.
Consequently the **complete** prime-power row is
\(-2c_q\langle u,v\rangle\), where
\(c_q=\Lambda(q)/\sqrt q=(\log p)/\sqrt q\). No proper powers are
discarded; their true von Mangoldt coefficients are retained.

The global moment conditions kill both pole terms exactly, even when
\(M_\pm(u)\) and \(M_\pm(v)\) are nonzero. For the off-diagonal
archimedean kernel
\(k(s)=e^{-s/2}/(1-e^{-2s})\), the full form is
\[
Q(f)=\Gamma(u)+\Gamma(v)
-2c_q\langle u,v\rangle-2I(u,v),\qquad
I(u,v)=\iint u(x)v(y)k(d+y-x)\,dx\,dy.
\]
The kernel decreases for \(s>0\), and Cauchy--Schwarz gives
\(|I(u,v)|\le w k(d-w)\|u\|_2\|v\|_2\). The prior
[support calculation](actual-prime-power-two-packet-positive-cones.md)
establishes \(d-w>2\) for \(q\ge8\), so
\(k(d-w)<k(\log2)=4/(3\sqrt2)<1\) and
\(wk(d-w)<1/28\). Also
\(c_q\le\log q/\sqrt q\le2/e<3/4\); the middle maximum follows by
differentiation and \(e>8/3\). Applying (2),
\(2|\langle u,v\rangle|\le\|u\|_2^2+\|v\|_2^2\), and the same
inequality to \(\|u\|_2\|v\|_2\) yields (1):
\(4/3-3/4-1/28=23/42\).

The Lean module kernel-checks the nearest-integer active window, exact
finite certificate, and the scalar implication from named analytic
gamma, prime-row, cross-kernel and pole-null identification hypotheses.
The Fourier and digamma integral argument and full Weil-form
identification are written above, not formalized in Lean. The uniform
bound applies only to these two windows; sums across distinct scales
have additional cross rows, and no density or RH conclusion follows.
