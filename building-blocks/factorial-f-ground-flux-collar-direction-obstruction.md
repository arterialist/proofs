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

This selected-block positivity does not advance the all-cutoff Weil sign by itself. If RH were false, (10) would strengthen to unbounded excursions of both signs, yet those excursions would still have near-zero crossings and the sequence (12)--(13). An all-cutoff argument must control the signed correlation in (4), or provide an *upper* bound on its relevant centered energy strong enough to make \(|D_X+R_X^\gamma|\le C_h\) for every large even \(X\). The positive flux floor and Goldbach-pair expansion contain neither estimate.
