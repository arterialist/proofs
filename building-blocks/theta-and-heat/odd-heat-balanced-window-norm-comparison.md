# Odd heat norm controlled by the balanced window norm

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The analytic conclusions remain written proofs; no novelty claim is made.

Written proof, independently audited by the Sol medium math worker
through the multiplier bound and finite-source inequality. This gives
a quantitative norm comparison for the same actual odd-centered
coefficients, with the origin and cutoff retained. It does not prove
the uniform critical norm estimate or RH and is not Lean formalized.

Use the fixed universal tilted packet \(\phi\) already constructed
in the authoritative compact-observation note, and its translated
correlation \(Z\in C_c^\infty((0,L))\), \(L=\log2\).
For \(0<\eta<1\), put \(z=\eta/2+i\xi\), \(s=z+1/2\).
The exact moment multiplier is

\[
M_zZ=e^{cz}E_\phi(z),\qquad
E_\phi(z)=-z^2(z^2-1/4)^2B_0(z-1)B_0(-z-1).
\]

Here \(c=2L/3\) and
\(B_0(w)=\prod_{j\ge1}\sinh(\epsilon2^{-j}w)/(\epsilon2^{-j}w)\).
The polynomial roots are \(0,1/2,-1/2\); none lies on the chosen
line. Both \(B_0\) arguments have real part separated from zero.

## A lower bound that justifies division

For \(w\) on either argument line, choose \(J=O(\log(2+|w|))\)
so that \(\epsilon2^{-j}|w|\le1/2\) for \(j>J\).
The first \(J\) factors satisfy

\[
\left|\frac{\sinh(\epsilon2^{-j}w)}{\epsilon2^{-j}w}\right|
\ge\frac{|\Re w|}{|w|},
\]

by \(|\sinh(x+iy)|^2=\sinh^2x+\sin^2y\ge x^2\).
For the tail, the analytic logarithm near one is bounded by
\(C|\epsilon2^{-j}w|^2\). Its summed bound is uniform, so the
tail product has a uniform positive lower bound. Nonvanishing on
bounded compact regions handles small \(|w|\). Consequently

\[
|M_{\eta/2+i\xi}Z|
\ge c_\eta\exp[-C_\eta\log^2(2+|\xi|)].
\]

Stirling's vertical gamma estimate now gives the finite constant

\[
\mathsf C_\eta=
\sup_{\xi\in\mathbb R}
\left|\frac{\Gamma((\eta+1)/2+i\xi)}{M_{\eta/2+i\xi}Z}\right|^2
<\infty.
\]

Thus the following division has an actual norm bound. Constants may
depend on the fixed \(\eta\); no uniform limit at \(\eta=0\) or
\(\eta=1\) is claimed.

## Literal finite arithmetic sources

For cutoff \(N\ge1\), retain every odd coefficient
\(a_n=\Lambda(n)-2\), including \(a_1=-2\), and define

\[
O_N(t)=\sum_{n\le N\,,\ n\text{ odd}}a_ne^{-nt},\qquad
J_N(P)=\sum_{n\le N\,,\ n\text{ odd}}a_nn^{-1/2}Z(\log(n/P)),
\quad F_N(s)=\sum_{n\le N\,,\ n\text{ odd}}a_nn^{-s}.
\]

Finite Mellin integration and Mellin Plancherel give exactly

\[
\int_0^\infty t^\eta|O_N(t)|^2dt
=\frac1{2\pi}\int |\Gamma(s)|^2|F_N(s)|^2d\xi,
\]
\[
\int_0^\infty P^{-\eta-1}|J_N(P)|^2dP
=\frac1{2\pi}\int |M_zZ|^2|F_N(s)|^2d\xi.
\]

These are identities for the same finite coefficients. All proper
powers and cutoff endpoint coefficients remain. The heat integral
equals \(\Gamma(\eta+1)\sum_{m,n\le N\,,\ m,n\text{ odd}}
a_ma_n/(m+n)^{\eta+1}\), with every ordered pair and all origin
cross terms included.

Below \(P=1\), the window observes only \(n=1\); odd \(n\ge3\)
cannot enter. Its exact contribution is
\(4I_\eta\), where \(I_\eta=\int_0^Le^{\eta v}Z(v)^2dv\).
The norm bound therefore proves, uniformly in the arithmetic cutoff,

\[
\boxed{
\int_0^\infty t^\eta|O_N(t)|^2dt
\le\mathsf C_\eta
\left[\int_1^\infty P^{-\eta-1}|J_N(P)|^2dP+4I_\eta\right].
}
\]

The right side is the exact positive balanced odd-Goldbach window
norm from the preceding note, with a coefficient cutoff. This is
one direction of norm control; no converse comparison is asserted.

## The actual terminal window cannot be suppressed

For the completed readout \(J\), \(J_N(P)=J(P)\) on
\(1\le P\le N/2\), and \(J_N(P)=0\) for \(P\ge N\).
The interval \(N/2<P<N\) observes a partially admitted window.
Let \(A_o(x)=\sum_{n\le x\,,\ n\text{ odd}}(\Lambda(n)-2)\).
Exactly

\[
A_o(x)=\psi(x)-(\log2)\lfloor\log_2x\rfloor
-2\lfloor(x+1)/2\rfloor,\qquad x\ge1.
\]

Thus \(A_o(x)=E(x)+O(\log(2x))\), with \(A_o(1)=-2\)
retained. In the terminal window, integration by parts gives

\[
J_N(P)=w_P(N)A_o(N)
-\int_P^N A_o(x)w_P'(x)dx,
\quad w_P(x)=P^{-1/2}W(x/P).
\]

The lower support boundary is flat. The displayed endpoint at
\(N\) is generally nonzero. The unconditional PNT envelope gives
only

\[
\int_{N/2}^{N}P^{-\eta-1}|J_N(P)|^2dP
\le C_\eta N^{1-\eta}e^{-b\sqrt{\log N}},
\]

after adjusting constants and absorbing logarithmic ports. This
bound does not control the terminal norm uniformly for
\(0<\eta<1\).

A uniform bound on the actual cutoff window norms for every such
\(\eta\) would, by the proved inequality and Fatou's lemma for
\(O_N(t)\to O(t)\), give the full odd-centered positive heat
norms required by the existing RH consumer. Those cutoff window
bounds are not proved. The inequality supplies the quantitative
source map; the critical estimate and its live terminal port remain
the arithmetic obligation. No completed-source limit or hidden RH
assumption replaces that obligation.
