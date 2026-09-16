# Complete-clock flux versus the exact two-collar Weil block

RH Agent3, 2026-09-17. **Status:** unconditional actual-source comparison and a positive two-collar *subsequence*, not an all-cutoff sign, an RH proof, or a Lean formalization. The result keeps the original factorial ground in the flux, every \(\Lambda(p^k)\) in the collar, and the full pole and gamma entries of its Weil block. The selected-cutoff positivity below is compatible with off-critical zeros: signed oscillations cross zero even when their amplitude grows.

Put \(h=\log2\), \(X=2m\) with \(m\ge3\), and \(U=\log(X/4)\), \(V=\log X\). Let \(E(x)=\psi(x)-x\) for right-continuous \(\psi(x)=\sum_{n\le x}\Lambda(n)\), let \(F>0\) be the actual factorial ground with \(F(x)\to\kappa_F>0\), and set \(r(u)=E(e^u)/(e^uF(e^u))\). The [full two-collar computation](successor-cell-even-odd-collar-full-matrix.md) defines the triangular profile
\[
W(t)=\begin{cases}t,&0\le t\le h,\\2h-t,&h\le t\le2h,\\0,&\text{otherwise},\end{cases}
\quad
P_X=\sum_{X/4<d<X}\frac{\Lambda(d)}{\sqrt d}W\!\left(\log\frac Xd\right),
\quad D_X=P_X-I_-^2\sqrt X,
\quad I_-^2=6-4\sqrt2.                                      \tag{1}
\]
Every ordinary prime and proper power in the collar is included. Its *complete* Weil restriction to the unnormalized right and left collar indicators \((R,L)\) is
\[
\boxed{Q_X\big|_{\{R,L\}}=
\begin{pmatrix}C_h&-D_X-R_X^\gamma\\-D_X-R_X^\gamma&C_h\end{pmatrix},
\qquad R_X^\gamma>0,\quad R_X^\gamma=O(X^{-5/2}).}            \tag{2}
\]
Here \(C_h=A_h+2I_-I_+\) contains the complete same-collar gamma and pole entries; \(R_X^\gamma\) is the positive remainder after the small pole term cancels the first cross-gamma term. In the orthonormal collar basis, divide (2) by \(h\). Both prime orientations and every pole/gamma cross entry are retained.

## Exact transform and the direction of the energy comparison

For \(X>4\), the continuous-density replacement of \(P_X\) is exactly \(I_-^2\sqrt X\). Thus, with \(dE=\sum_{n\ge2}\Lambda(n)\delta_n-dx\),
\[
D_X=\int_{[X/4,X]}x^{-1/2}W\!\left(\log\frac Xx\right)dE(x).
\]
The weight vanishes at both endpoints; an atom at the midpoint \(x=X/2\), if present, retains its full coefficient \(h\). Define the signed piecewise kernel
\[
L(t)=W'(t)+\tfrac12W(t)
=\begin{cases}
1+t/2,&0<t<h,\\
-1+h-t/2,&h<t<2h.
\end{cases}                                                       \tag{3}
\]
Stieltjes integration by parts, with no endpoint or midpoint correction because \(W\) is continuous, gives the exact actual-source transform
\[
\boxed{D_X=\int_{X/4}^{X}\frac{E(x)}{x^{3/2}}
                 L\!\left(\log\frac Xx\right)dx
=\sqrt X\int_0^{2h}e^{-t/2}F(Xe^{-t})
                 r(\log X-t)L(t)dt.}                            \tag{4}
\]
The complete-clock score, by contrast, observes the *future*:
\[
G_s(u)=\int_0^\infty K_s(t)r(u+t)dt
       -\int_0^\infty H_s(t)r(u+t)^2dt,
\quad H_s=(h_0*\mathsf P_s)^2,\ K_s=H_s-H_s',\
h_0(t)=te^{-t/2}{\bf1}_{t\ge0}.                               \tag{5}
\]
Equation (4) is a signed compact past-facing functional with the exact varying \(F\); (5) is a heavy-tailed future functional with an additional negative square. Their kernels have different support, signs, and scale. The comparison below does not replace either one by a frozen or linearized source.

The collar functional kills constants in \(E\): since \((e^{t/2}W(t))'=e^{t/2}L(t)\) and \(W(0)=W(2h)=0\),
\[
\int_{X/4}^{X}x^{-3/2}L(\log(X/x))dx=0.
\]
Consequently one may replace \(E(x)\) by \(E(x)-b\) in (4) for *any* constant \(b\). Define
\[
\mathcal E_X(b)=\int_{X/4}^{X}\frac{(E(x)-b)^2}{x^2F(x)^2}dx,
\qquad
B_X^2=\int_{X/4}^{X}\frac{F(x)^2}{x}
                  L(\log(X/x))^2dx.
\]
Cauchy--Schwarz proves the unconditional all-cutoff observation bound
\[
\boxed{|D_X|^2\le B_X^2\,\mathcal E_X(b)\quad\text{for every }b\in\mathbb R,}
\qquad
B_X^2\longrightarrow\kappa_F^2\int_0^{2h}L(t)^2dt
=\kappa_F^2\left(2h+\frac{h^3}{6}\right).                     \tag{6}
\]
The final integral is the sum of the two elementary squares in (3). Taking the weighted least-squares center \(b\) only strengthens (6); the complete-clock flux supplies the *uncentered* case \(b=0\).

Indeed, let \(a_s>0\), \(G_s\), and \(\mathcal C_s\) be the exact complete-clock quantities in the [weighted-flux identity](factorial-f-ground-complete-clock-weighted-flux-energy.md), and put
\[
\mathfrak F_s(X)=\mathcal C_s(V)-\mathcal C_s(U)
                     -\int_U^V e^uG_s(u)du.
\]
That identity and (6) give, without discarding any clock history,
\[
\boxed{\mathfrak F_s(X)=a_s\mathcal E_X(0),\qquad
|D_X|^2\le\frac{B_X^2}{a_s}\mathfrak F_s(X),\qquad
\lambda_{\min}(Q_X|_{\{R,L\}})
\ge\frac{C_h-R_X^\gamma-B_X\sqrt{\mathfrak F_s(X)/a_s}}h.}  \tag{7}
\]
The eigenvalue is stated in the orthonormal collar basis. Formula (7) is an upper bound for the collar *from an upper bound for the flux*. The available arithmetic input goes the other way. [Brent--Platt--Trudgian](https://arxiv.org/pdf/2008.06140) prove \(\int_Y^{2Y}E(x)^2dx\ge Y^2/5374\) for all large \(Y\). Applying this separately to \([X/4,X/2]\) and \([X/2,X]\), and taking \(F(x)\le M_F\) on the tail, yields
\[
\boxed{\mathcal E_X(0)\ge\frac1{2\cdot5374\,M_F^2},\qquad
\mathfrak F_s(X)\ge\frac{a_s}{2\cdot5374\,M_F^2}.}            \tag{8}
\]
Substitution of this *lower* bound into the right side of (7) cannot certify a lower eigenvalue. Nor can increasing the clock amplify the coefficient \(a_s\) past its zero-clock value. If \(A\sim\mathsf P_s\), Jensen's inequality and a shift of \(t\) give
\[
a_s=\int_0^\infty e^{-t}\bigl(\mathbb E h_0(t-A)\bigr)^2dt
\le\mathbb E\!\int_0^\infty e^{-t}h_0(t-A)^2dt
=\tfrac14\mathbb E(e^{-A})\le\tfrac14=a_0.                \tag{9}
\]
Thus the complete positive clock preserves the flux identity but provides no hidden gain in its energy coefficient.

## Actual-prime small-collar subsequence with a positive energy floor

The mismatch is realized by the actual \(\Lambda\) source, not just by a model error function. The [odd-collar oscillation theorem](successor-cell-odd-collar-triangular-prime-oscillation.md) gives a constant \(A_1>0\) such that
\[
\limsup_{m\to\infty}D_{2m}\ge A_1,
\qquad \liminf_{m\to\infty}D_{2m}\le-A_1.                     \tag{10}
\]
For completeness, its Laplace transform has residue \(-r_1F_\triangle(2i\gamma_1)^2\ne0\) at the first critical zero, where \(F_\triangle(z)=2(1-2^{-z/2})/z\), and is regular at positive real points and at zero. If \(D\) were eventually bounded above or below, positive-Laplace Landau would put the transformed nonnegative function's abscissa at zero; comparing its values at \(\epsilon+2i\gamma_1\) and \(\epsilon\) gives the two inequalities (10). The critical zero is nonresonant because \(14<\gamma_1<15\), while \(\gamma_1h\) lies strictly between \(2\pi\) and \(4\pi\). This argument needs no RH assumption.

The nearest-even sampling estimate is equally literal. The triangle \(W\) is one-Lipschitz, and Chebyshev's bound for the full \(\Lambda\) sum gives, for comparable \(X,Y\) with \(|X-Y|\le2\),
\[
|D_X-D_Y|\ll |X-Y|X^{-1/2}.                              \tag{11}
\]
Equations (10)--(11) force infinitely many adjacent even cutoffs \(2m,2m+2\) across which \(D\) changes sign. At either endpoint of each crossing, its absolute value is no larger than the increment. Hence there is an unbounded sequence of exact successor cutoffs \(X_j=2m_j\) with
\[
\boxed{|D_{X_j}|\ll X_j^{-1/2},\qquad
\mathcal E_{X_j}(0)\ge\frac1{2\cdot5374\,M_F^2},\qquad
\mathfrak F_s(X_j)\ge\frac{a_s}{2\cdot5374\,M_F^2}.}       \tag{12}
\]
The proper-power weights remain inside \(D_{X_j}\) and \(E\). This explicitly rules out any eventual reverse coercivity \(\mathfrak F_s(X)\le C|D_X|^2\) for fixed \(s\), or a lower bound for \(|D_X|\) from the flux floor.

The full pole/gamma conclusion is stronger. The exact series in (2) gives \(R_{X_j}^\gamma=O(X_j^{-5/2})\), so both parity forms and the full off-diagonal obey
\[
Q_{X_j}(u_+)=C_h+O(X_j^{-1/2}),\qquad
Q_{X_j}(u_-)=C_h+O(X_j^{-1/2}),\qquad
Q_{X_j}\big|_{\{R,L\}}=C_h I+O(X_j^{-1/2}).              \tag{13}
\]
The constant is strictly positive without assuming RH. Using
\(\psi_{\rm dig}(1/4)=-\gamma-\pi/2-3h\),
\[
C_h=-h(\gamma+\pi/2+3h+\log\pi)
    +(12\sqrt2-16)
    +\frac12\sum_{k\ge0}
       \frac{1-4^{-k}/\sqrt2}{(k+1/4)^2}.
\]
The first ten positive summands exceed \(2.82\) (using \(\sqrt2>1.4142\)); the elementary bounds \(h<0.694\), \(\gamma<0.63\), \(\pi/2<11/7\), \(\log\pi<1.146\), and \(12\sqrt2-16>0.9704\) then give
\[
C_h>2.82+0.9704-0.694(0.63+11/7+3\cdot0.694+1.146)>0.022.
\]
For \(\gamma<0.63\), for example, use \(\gamma<H_{10}-\log10\), \(H_{10}=7381/2520<2.93\), and \(\log10>2.30\). Therefore (13) makes the **complete two-dimensional collar block positive definite** on an unbounded sequence of actual odd successor cutoffs \(N_j=X_j-1\).

The positivity persists through a mesoscopic set of exact cutoffs, but this does not cover all large cutoffs. The proof of (11) applies whenever \(X,Y\) are comparable and \(|X-Y|\le X/2\), with the same absolute constant \(C_{\rm Lip}\) in
\(|D_X-D_Y|\le C_{\rm Lip}|X-Y|/\sqrt X\). Choose a fixed \(\delta>0\) with \(C_{\rm Lip}\delta<C_h/4\). Equations (12)--(13) and \(R_Y^\gamma\to0\) show that, for every sufficiently large center \(X_j\), **every even** \(Y\) with \(|Y-X_j|\le\delta\sqrt{X_j}\) has
\[
\lambda_{\min}(Q_Y|_{\{R,L\}})\ge\frac{C_h}{4h}>0.
\]
There are \(\gg\sqrt{X_j}\) such exact odd successor cutoffs \(Y-1\) per window. The known oscillation gives no bound on the gaps between these windows.

There is also a genuine all-cutoff **relative-form** bound, with an explicit extra energy term. For all sufficiently large \(X\), \(F\le2\) on \([X/4,X]\), so (6) gives \(B_X^2<4(2h+h^3/6)<5.78\), while \(R_X^\gamma<C_h/2\). The elementary inequality \(B_X\sqrt{\mathcal E_X(0)}\le200\mathcal E_X(0)+B_X^2/800\), together with \(C_h>0.022\), implies
\[
\boxed{Q_X\big|_{\{R,L\}}+200\,\mathcal E_X(0)I\ \text{is positive definite for all sufficiently large even }X.} \tag{14}
\]
Indeed its least matrix eigenvalue is greater than
\(C_h/2-5.78/800>0\). Equivalently, for every \(f\in\operatorname{span}\{R,L\}\), the normalization-invariant quadratic statement is
\[
Q_X(f)+\frac{200}{h}\mathcal E_X(0)\|f\|_2^2>0\quad(f\ne0)
\]
at all sufficiently large even \(X\). The added term is **not** part of the original Weil form. Although \(\mathcal E_X(0)=\mathfrak F_s/a_s\) algebraically, no normalization-preserving map from the clocked birth profile to these Weil collar vectors has been proved. A numerical comparison of \(200/a_s\) with a purported birth coefficient therefore has no invariant physical meaning; (14) is only a relative-form bound in the stated Weil normalization.

The actual all-cutoff transport of the signed collar is a different object. At every \(X\) away from the discrete prime-power thresholds \(d,2d,4d\), differentiating the finite sum in (1) with respect to \(u=\log X\) gives
\[
\frac d{du}D_{e^u}
=\sum_{X/2<d<X}\frac{\Lambda(d)}{\sqrt d}
 -\sum_{X/4<d<X/2}\frac{\Lambda(d)}{\sqrt d}
 -\frac{I_-^2}{2}\sqrt X.
\]
Equivalently, if \(A(y)=\sum_{d<y}\Lambda(d)/\sqrt d\) and \(B(y)=A(y)-2\sqrt y\), then
\[
\boxed{\frac d{du}D_{e^u}=B(X)-2B(X/2)+B(X/4)\quad\text{a.e.}} \tag{15}
\]
The continuous main term cancels *exactly* because \(2\sqrt X-4\sqrt{X/2}+2\sqrt{X/4}=I_-^2\sqrt X/2\). Each actual prime-power arrival contributes a \(+1,-2,+1\) pulse as the external cutoff passes \(d,2d,4d\). The full \(\Lambda\) source is still present, but these signed pulses give no monotone propagation from the positive windows to every later cutoff. An all-cutoff result needs cancellation in this second-difference forcing, not a larger lower bound for the positive flux.

## Exact Möbius-history split of the pulse

The divisor identity \(\Lambda=\mu*\log\) does not turn (15) into a positive boundary term. To see exactly what it pays, return to the undifferentiated weight \(w_X(x)=x^{-1/2}W(\log(X/x))\), zero outside \([X/4,X]\), and fix an integer \(1\le T<X/4\). Define
\[
A_T=\sum_{a\le T}\frac{\mu(a)}a,\quad
B_T=\sum_{a\le T}\frac{\mu(a)\log a}a,\quad
J_W=\int_0^{2h}t e^{-t/2}W(t)dt.
\]
For each \(a\le T\), compare \(\sum_{b\ge1}(\log b)w_X(ab)\) with its integral at unit \(b\)-spacing. The finite, endpoint-retaining identity is
\[
\begin{aligned}
D_X={}&\mathcal L_T(X)
 +\sqrt X\{I_-^2(A_T\log X-B_T-1)-J_W A_T\}
 +\mathcal H_T(X),\\
\mathcal L_T(X)={}&\sum_{a\le T}\mu(a)
 \left[\sum_{b\ge1}(\log b)w_X(ab)
       -\frac1a\int_{X/4}^{X}\log(x/a)w_X(x)dx\right],\\
\mathcal H_T(X)={}&\sum_{a>T}\mu(a)
                         \sum_{b\ge1}(\log b)w_X(ab).
\end{aligned}                                                     \tag{16}
\]
Every sum is finite on the weight's support. The \(-1\) in the middle line is the exact \(-dx\) density, not a removed prime-power row. The formula uses \(\int w_X=I_-^2\sqrt X\) and \(\int (\log x)w_X=\sqrt X(I_-^2\log X-J_W)\).

The continuous function \(t\mapsto(\log t)w_X(at)\) vanishes at both support endpoints and has total variation \(O(\log(2X)/\sqrt X)\), uniformly for \(a\le T\). The unit-lattice sum/integral discrepancy is at most its variation, hence
\[
\boxed{|\mathcal L_T(X)|\ll T\log(2X)/\sqrt X.}          \tag{17}
\]
With \(T=X^{1/2-\eta}\), this sector is \(O_\eta(X^{-\eta}\log X)\). This is the same legitimate Type-I lattice payment as in the [full factorial-ground score](factorial-f-ground-type-i-lattice-payment.md), here with the exact triangular collar weight. It does not pay the other two terms of (16). The classical Mertens estimates \(A_T\ll e^{-c\sqrt{\log T}}\) and \(B_T+1\ll e^{-c\sqrt{\log T}}\) make the displayed continuous main only \(O(\sqrt X\log X e^{-c\sqrt{\log T}})\), much larger than a uniform collar bound. Its limiting cancellation uses both \(A_\infty=0\) and \(B_\infty=-1\).

The high-divisor term already contains the explicit \(b=2\) fiber, whenever \(T<X/8\):
\[
\mathcal H_{T,2}(X)=(\log2)
       \sum_{X/8<a<X/2}\mu(a)w_X(2a).                  \tag{18}
\]
Define the full row \(H_2(X)=(\log2)\sum_{a\ge1}\mu(a)w_X(2a)\). For every \(X>8T\), it equals \(\mathcal H_{T,2}(X)\); the same eventual equality holds when \(T=X^{1/2-\eta}\). For \(X=e^{2u}\), its unilateral Laplace transform is, initially for \(\Re z>1\),
\[
\int_0^\infty e^{-zu}H_2(e^{2u})du
=\frac{\log2}{2}\,2^{-(z+1)/2}
  F_\triangle(z)^2\frac1{\zeta((z+1)/2)},
\quad F_\triangle(z)=\int_0^h e^{-zt/2}dt.           \tag{19}
\]
The fixed-\(T\) initial difference between \(H_2\) and \(\mathcal H_{T,2}\) has compact \(u\)-support and adds an entire transform. Since \(F_\triangle(z)\ne0\) for \(\Re z>0\), a separate all-\(\varepsilon\) bound \(H_2(X)=O_\varepsilon(X^\varepsilon)\) would already exclude every off-critical zeta zero. Equation (18) is therefore a signed Möbius correlation, not a free positive payment. The complete \(b\)-sum can cancel it against other rows, so no lower bound for \(D_X\) is inferred from that fiber.

There is an exact but limited dyadic coboundary. Pair \(a\) and \(2a\) for each odd \(a\), using \(\mu(2a)=-\mu(a)\), and relabel the second quotient \(b\mapsto2b\). The full \(\Lambda\) sum becomes
\[
\sum_n\Lambda(n)w_X(n)
=\sum_{a\text{ odd}}\mu(a)
 \left[\sum_{b\text{ odd}}(\log b)w_X(ab)
       +(\log2)\sum_{b\text{ even}}w_X(ab)\right].   \tag{20}
\]
The even bracket collapses, after *all* odd Möbius divisors are summed, to exactly the powers-of-two atoms \(\Lambda(2^k)=\log2\). At most two such powers meet \((X/4,X)\), so their entire collar contribution is \(O(X^{-1/2})\). The odd bracket remains the complete odd prime-power source and carries the zeta poles: \(\zeta_{\rm odd}(s)=(1-2^{-s})\zeta(s)\), and the factor \(1-2^{-s}\) does not vanish when \(\Re s>0\). Thus the 2-adic pairing does not control the centered remainder. Classical [Vaughan's identity](https://arxiv.org/html/math/0606087#S4) and [Heath-Brown's generalized identity](https://geodesic.mathdoc.fr/articles/10.4153/CJM-1982-095-9/) repartition the same \(\mu*\log\) sum into Type I and signed bilinear ranges; they do not supply a zero-frequency sign for (16). The [existing Vaughan terminal-packet audit](odd-terminal-vaughan-zero-frequency-type-ii-barrier.md) exhibits the analogous large absolute Type-II mass. No new all-cutoff bound for \(D_X\) follows from (16)--(20).

This selected-block positivity does not advance the all-cutoff Weil sign by itself. If RH were false, (10) would strengthen to unbounded excursions of both signs, yet those excursions would still have near-zero crossings and the sequence (12)--(13). An all-cutoff argument must control the signed correlation in (4), or provide an *upper* bound on its relevant centered energy strong enough to make \(|D_X+R_X^\gamma|\le C_h\) for every large even \(X\). The positive flux floor and Goldbach-pair expansion contain neither estimate.
