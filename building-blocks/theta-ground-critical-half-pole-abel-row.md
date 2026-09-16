# The actual theta ground row has a compensated half-pole boundary value

The [exponential weak-ground theorem](theta-ground-exponential-weak-cross-row.md) pairs the actual killed theta ground with tests decaying faster than \(e^{-|v|/2}\). At the boundary exponent \(1/2\), its prime and pole terms separately diverge. Keeping their exact density cancellation gives a finite Abel boundary value and a fixed-core constraint on the ground's approach to its [flat tail](theta-killed-ground-flat-tail-and-pole-balance.md). This does not give a sign for the mixed row or a moving-core covariance estimate.

Fix \(R>0\), the normalized positive even killed ground \(\psi_R\), its physical history \(G_R=\Phi\psi_R1_{|u|>R}\), and
\[
 b(u)=2\cosh(u/2),\qquad
 \delta_R=1/2-\alpha_R>0,\qquad
 \mu_R=\int b(u)G_R(u)du,\qquad
 c_R=\frac{\mu_R}{2\delta_R}.
\]
The ground is bounded and \(G_R\) has every absolute exponential moment. For \(\beta>1/2\) let \(z_\beta(v)=e^{-\beta|v|}\). The complete physical mixed form \(\mathscr K(G_R,z_\beta)\), both poles, and the complete Weil row \(Q_R(\beta)\) are absolutely defined by the earlier weak theorem.

## Exact prime-density and pole cancellation

Write \(\Psi(X)=\sum_{n\le X}\Lambda(n)\) and \(E(X)=\Psi(X)-X\) for \(X\ge1\). Let
\[
 f_{u,\pm,\beta}(X)=X^{-1/2}z_\beta(u\pm\log X).
\]
For \(\beta>1/2\), split the complete prime measure as \(d\Psi=dX+dE\). The density part of the physical prime pairing has kernel \(e^{|u-v|/2}\), whereas the two-pole pairing has kernel \(2\cosh((u-v)/2)\). Their difference is exactly \(e^{-|u-v|/2}\). Consequently
\[
 \boxed{\quad
 Q_R(\beta)=A(G_R,z_\beta)
  +\iint G_R(u)z_\beta(v)e^{-|u-v|/2}du\,dv
  -\mathcal D_R(\beta),
 \quad}                                                        \tag{1}
\]
where \(A\) is the actual archimedean physical form and the **signed** all-prime-power discrepancy is
\[
 \mathcal D_R(\beta)=
 \int G_R(u)\sum_{\pm}\int_{(1,\infty)}
            f_{u,\pm,\beta}(X)\,dE(X)\,du.
\tag{2}
\]
The interval \((1,2)\), where the prime measure is empty but \(dE=-dX\), remains in (2).

Stieltjes integration by parts retains the lower endpoint \(E(1)=-1\):
\[
 \int_{(1,\infty)}f_{u,\pm,\beta}\,dE
 =f_{u,\pm,\beta}(1)
  -\int_1^\infty E(X)\,\partial_X f_{u,\pm,\beta}(X)\,dX.
\tag{3}
\]
There is no contact atom where \(u\pm\log X=0\), because the test is continuous there. The endpoint at infinity vanishes by the complete PNT error, even at \(\beta=1/2\).

## Finite boundary value and all polynomial Abel moments

The full prime-power PNT error gives constants \(a,C>0\) with
\[
 |E(X)|\le CXe^{-a\sqrt{\log X}}\qquad(X\ge1)
\tag{4}
\]
after enlarging \(C\) near one; see [Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689). Fix \(B>1/2\). For every integer \(k\ge0\), every \(\beta\in[1/2,B]\), and away from the single derivative cusp,
\[
 |\partial_X\partial_\beta^k f_{u,\pm,\beta}(X)|
 \le C_{k,B}e^{B|u|}(1+|u|+\log X)^kX^{-2}.
\tag{5}
\]
Thus the right side of (3), integrated against \(G_R(u)du\), is finite and continuously differentiable any fixed number of times down to \(\beta=1/2\): the decisive tail integral is
\[
 \int_1^\infty(1+\log X)^k
           e^{-a\sqrt{\log X}}\frac{dX}{X}<\infty.
\tag{6}
\]
The exponential moments of \(G_R\) pay the factors in \(u\). The archimedean pairing in (1) has the same regularity: \(\widehat z_\beta(\xi)=2\beta/(\beta^2+\xi^2)\), and every fixed \(\beta\)-derivative lies uniformly in the logarithmic Fourier form space for \(\beta\in[1/2,B]\). The positive convolution term in (1) is handled by ordinary dominated convergence.

It follows that (1) has a finite one-sided \(C^\infty\) boundary extension
\[
 \boxed{\quad
 Q_R^*:=\lim_{\beta\downarrow1/2}Q_R(\beta)
 =A(G_R,z_{1/2})
 +\iint G_R(u)z_{1/2}(v)e^{-|u-v|/2}du\,dv
 -\mathcal D_R(1/2),
 \quad}                                                        \tag{7}
\]
where \(\mathcal D_R(1/2)\) is defined by the convergent right side of (3), not by subtracting two divergent raw integrals. This is a compensated boundary value, not an assertion that the physical prime or pole pairing exists separately at \(\beta=1/2\).

Indeed, evenness gives \(M_{\pm1/2}(G_R)=\mu_R/2\), while
\(M_{\pm1/2}(z_\beta)=1/(\beta-1/2)+1/(\beta+1/2)\). Hence the exact two-pole term is
\[
 P_{\rm pole}(G_R,z_\beta)
 =\mu_R\left(\frac1{\beta-1/2}+\frac1{\beta+1/2}\right),
\]
and (7) implies the finite-part identity
\[
 \boxed{\quad
 \lim_{\beta\downarrow1/2}
  \left[\mathscr K(G_R,z_\beta)
          +\frac{\mu_R}{\beta-1/2}\right]
 =Q_R^*-\mu_R.
 \quad}                                                        \tag{8}
\]
Both divergent coefficients are retained and cancel only in the full row.

## A ground-tail consequence

Let \(\mathcal B_R\) be the complete positive core arrival in the earlier weak-ground theorem. Its full signed measure is
\[
 d\widetilde\eta_R=
 [\delta_R1_O b\psi_R+1_C\mathcal B_R-\mu_Rb/2]du.
\]
For \(\beta>1/2\), the weak ground equation gives
\[
 Q_R(\beta)
 =-\int_C z_\beta(u)[\mathcal B_R(u)-\mu_Rb(u)/2]du
  -\delta_R\int_O z_\beta(u)b(u)[\psi_R(u)-c_R]du.
\tag{9}
\]
The core integral is smooth in \(\beta\). Equations (7) and (9) therefore prove the fixed-core Abel constraint
\[
 \boxed{\quad
 \lim_{\beta\downarrow1/2}
 \int_O e^{-\beta|u|}b(u)[\psi_R(u)-c_R]du
 =-\frac{Q_R^*+
   \int_C e^{-|u|/2}[\mathcal B_R(u)-\mu_Rb(u)/2]du}{\delta_R}
 \in\mathbb R.
 \quad}                                                        \tag{10}
\]
Moreover the same finite limit exists after inserting \(|u|^k\) for every fixed integer \(k\ge0\), by differentiating (9) \(k\) times and using the proved boundary regularity. These are Abel limits of signed deviations. They do not imply absolute integrability, an eventual sign, or a convergence rate uniform in \(R\).

The half-line exponential source \(u_\beta(v)=\sqrt{2\beta}e^{-\beta v}1_{v\ge0}\) from the coherent two-source family satisfies \(Q(G_R,u_\beta)=\sqrt{\beta/2}\,Q_R(\beta)\) by parity. It therefore has the finite compensated limit \(Q_R^*/2\) as \(\beta\downarrow1/2\). This does not identify the full Weil row between that source and its companion \(z_t\), nor settle the affine covariance or RH.

The Stieltjes endpoint and PNT bound are the same complete arithmetic ingredients as in the [PNT-scale weak-row theorem](theta-weak-ground-pnt-density-cancellation.md). The new statement concerns the half-pole boundary exponent and all its polynomial Abel derivatives. This is written analysis, without Lean formalization or a sign conclusion.
