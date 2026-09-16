# An off-critical mode can have a negative averaged factorial-ground score

Written single-mode calibration, 2026-09-17. This is a smooth source model,
not the actual von Mangoldt measure or a zeta counterexample. It tests
whether negativity of a broad Gaussian average of the factorial-ground
dyadic score can distinguish critical from off-critical oscillation. The
answer is no for one isolated right-of-line mode. No RH estimate or Lean
formalization is claimed.

Use the exact score identity from the
[actual Gaussian mean note](factorial-f-ground-gaussian-mean-negative-bias-under-rh.md):
\[
 G(u)=T_{K'}\log(F/\kappa)-T_Hr^2,
 \qquad J(u)=G(u)-G(u+L),\quad L=\log2,
\tag{1}
\]
where \(r=-\partial_uF/F\), \(T_Ah(u)=\int_0^\infty A(t)h(u+t)dt\),
\(H(t)=t^2e^{-t}\), and \(K(t)=2t(t-1)e^{-t}\). For the actual
source \(F(u)\) abbreviates \(F(e^u)\); here we use the same form
identity for a different smooth source.

Fix \(\kappa>0\), \(A\ne0\), \(0<\alpha<1/2\), and \(\gamma\ge14\).
On a sufficiently late half-line \(u\ge u_0\), define
\[
 F(u)=\kappa+A e^{-\alpha u}\cos(\gamma u)>0,
 \qquad e(u)=-F'(u),\qquad r(u)=e(u)/F(u).
\tag{2}
\]
Thus the corresponding physical signed error is
\(E(x)=x e(\log x)=-x^2\,dF(x)/dx\), of oscillatory size
\(x^{1-\alpha}\); its exponent \(1-\alpha>1/2\) models a zero to
the right of the critical line. This source has no positive
prime-power-atom constraint and is not the actual \(\psi-x\).

For \(c=1/10\) let
\[
 g_U(u)=(2\pi cU)^{-1/2}e^{-(u-U)^2/(2cU)},\qquad
 \mathcal A_UJ=\int_{u_0}^\infty g_U(u)J(u)du.
\tag{3}
\]
The exact large-\(U\) asymptotic is
\[
\boxed{\quad
 \mathcal A_UJ
 =-\frac{A^2}{\kappa^2}
  \frac{(1-e^{-2\alpha L})[\gamma^2+\alpha(1-\alpha)]}
       {(1+2\alpha)^3}
  e^{(-2\alpha+2c\alpha^2)U}
  +o\!\left(e^{(-2\alpha+2c\alpha^2)U}\right).
 \quad}
\tag{4}
\]
The leading coefficient is strictly negative for every allowed
\(\alpha\) and \(\gamma\).

To prove (4), write \(f=F-\kappa\). Uniformly on late tails,
\[
 \log(F/\kappa)=f/\kappa-f^2/(2\kappa^2)+O(f^3),
 \qquad r^2=e^2/\kappa^2+O(|f|e^2).
\tag{5}
\]
The real-frequency-zero parts of the two quadratic expressions are
\[
 [f^2]_0=\frac{A^2}{2}e^{-2\alpha u},\qquad
 [e^2]_0=\frac{A^2}{2}(\alpha^2+\gamma^2)e^{-2\alpha u}.
\tag{6}
\]
Their other frequencies are \(\pm2\gamma\). For \(\lambda>0\),
direct gamma integration gives
\[
 T_He^{-\lambda u}=\frac{2}{(1+\lambda)^3}e^{-\lambda u},
 \qquad
 T_{K'}e^{-\lambda u}
   =\frac{2\lambda(1-\lambda)}{(1+\lambda)^3}e^{-\lambda u}.
\tag{7}
\]
Insert (6) into (1), use \(\lambda=2\alpha\), and apply
\(\Delta_Le^{-\lambda u}=(1-e^{-\lambda L})e^{-\lambda u}\).
The quadratic coefficient is
\[
 -\frac{A^2}{2\kappa^2}(1-e^{-2\alpha L})
 \frac{2\alpha(1-2\alpha)+2(\alpha^2+\gamma^2)}
      {(1+2\alpha)^3}
 =-\frac{A^2}{\kappa^2}(1-e^{-2\alpha L})
 \frac{\gamma^2+\alpha(1-\alpha)}{(1+2\alpha)^3}.
\tag{8}
\]
For any fixed \(a>0\) and real \(\nu\), full-line Gaussian
integration is exact:
\[
 \int_{\mathbb R}g_U(u)e^{-au+i\nu u}du
 =\exp\!\left((-a+i\nu)U+
                 \frac{cU}{2}(-a+i\nu)^2\right).
\tag{9}
\]
The truncated lower tail \(u<u_0\) is exponentially smaller than
the scale in (4), also after multiplication by the finite exponential
factors in (5). The \(\pm2\gamma\) quadratic frequencies gain
\(e^{-2c\gamma^2U}\) relative to the zero-frequency term. The
linear \(\pm\gamma\) term is lower order because its exponent minus
the exponent in (4) is
\[
 \alpha-\frac{3c}{2}\alpha^2-\frac{c}{2}\gamma^2<0
 \qquad(0<\alpha<1/2,\ \gamma\ge14,\ c=1/10).
\tag{10}
\]
The cubic remainders are lower order because their Gaussian decay
exponent differs by \(-\alpha+(5c/2)\alpha^2<0\). Equations
(5)–(10) prove (4).

This calibration has a precise limit. Eventual broad-Gaussian
negativity is not a universal off-line-mode exclusion: it holds in
the explicitly off-critical smooth model (2). The calculation does
not establish that the actual zeta score can have this sign if RH
fails. For the actual source, infinitely many zeros, unknown
near-coincidences of their ordinates, and the exact nonlinear score
would require uniform estimates beyond this fixed-mode calculation.
The actual RH-equivalent target remains a pointwise all-large-base
\(O_\varepsilon(Y^{-1/2+\varepsilon})\) bound for the full score.
