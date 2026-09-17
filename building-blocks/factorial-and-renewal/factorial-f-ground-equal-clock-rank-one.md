# Rank-one carrier and heavy-age escape of the whole-block Picone cubic

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 original-metric theorem, 2026-09-16. Let \(X\ge3\) be an integer, \(s=c\log X\) with fixed \(c>0\), \(B_X=g_{2X}-g_{X-1}\), \(f_X=T_sB_X\), and
\[
\mathfrak C_X=4\int_1^\infty\frac{E(x)}{xF(x)}|f_X(x)|^2dx
=-4\langle f_X,b_F f_X\rangle_{L^2(dx)},
\quad E=\psi-x,
\quad b_F=-E/(xF). \tag{1}
\]
The entire \(\Lambda\)-minus-density block, every prime power, both hard endpoints, the literal seed convention, and the complete compound-Poisson age law are retained. The result sharpens the PNT absolute bound for this **cubic baseline**. It does not sign it or prove RH.

## Exact low-frequency rank-one carrier

The exact Fourier numerator of the full block is
\[
\widehat{UB_X}(\xi)=\frac{D_X(\xi)}{1/2+i\xi},
\quad D_X(\xi)=\int_{(X-1,2X]}y^{-1/2-i\xi},dE(y),
\quad D_X(0)=\sum_{X\le n\le2X}\frac{\Lambda(n)}{\sqrt n}
-2(\sqrt{2X}-\sqrt{X-1}). \tag{2}
\]
There is no \(X-1\) atom and the \(2X\) atom is retained if present. Let \(\beta_X^{\rm H}(x)=1_{x\ge X}/x\) denote the Hardy step (not the ground coefficient \(\beta_R=\sup_{x\ge R}|b_F(x)|\)), and put \(A_X=\sqrt X D_X(0)\). Then \(\widehat{U(A_X\beta_X^{\rm H})}(\xi)=D_X(0)X^{-i\xi}/(1/2+i\xi)\). This is the unique one-step Hardy carrier matching the block's zero-frequency amplitude at the scale \(X\).

Choose a quantitative PNT envelope \(\Delta_X=C_0e^{-a\sqrt{\log(X-1)}}\), so \(|E(y)|\le y\Delta_X\) on \(y\ge X-1\). Factor \(D_X(\xi)=X^{-i\xi}\widetilde D_X(\xi)\). Stieltjes integration by parts, now with \(y^{-1/2}\log(y/X)(y/X)^{-i\xi}\), gives on every fixed band \(|\xi|\le\delta_0\)
\[
|\widetilde D_X(\xi)-D_X(0)|
\le C\sqrt X\Delta_X|\xi|. \tag{3}
\]
The bound is uniform because \(y/X\in[1-1/X,2]\), so every differentiated \(\log(y/X)\) factor is bounded; the signed \(dE\) is kept together before estimating. Also \(\|B_X\|_2^2+\|A_X\beta_X^{\rm H}\|_2^2\ll X\Delta_X^2\).

The complete process multiplier is \(e^{-s\Phi(i\xi)}\), with \(\rho(\xi)=\operatorname{Re}\Phi(i\xi)\asymp|\xi|\) near zero and a positive gap off a fixed zero neighborhood. Plancherel, (3), and \(\int\xi^2e^{-cs|\xi|}d\xi\asymp s^{-3}\), followed by contraction on the exponentially damped high band, prove the **global original-\(L^2\) rank-one estimate**
\[
\boxed{\displaystyle
f_X=A_X T_s\beta_X^{\rm H}+r_X,
\qquad \|r_X\|_2^2\ll_c\frac{X\Delta_X^2}{s^3}.} \tag{4}
\]
No restriction to a compact physical or clock interval is made. The estimate is absolute, not relative when \(D_X(0)\) is anomalously small. It uses the full signed prime-minus-density numerator, not an absolute sum of births.

The carrier has an exact physical profile. Let \(\mathsf P_s\) be the complete all-prime age law and define, for \(t\ge0\),
\[
k_s(t)=\int_{[0,t]}e^{-(t-a)/2}\mathsf P_s(da),
\quad k_s(t)=0\ (t<0),
\quad J_s=\int_0^\infty k_s(t)^2dt.
\tag{5}
\]
Then for \(x=Xe^t\),
\[
T_s\beta_X^{\rm H}(x)=\frac{k_s(t)}{\sqrt{Xx}},
\qquad J_s=\frac1{2\pi}\int_{\mathbb R}
\frac{e^{-2s\rho(\xi)}}{1/4+\xi^2}d\xi
\sim\frac{2}{\pi^2s}. \tag{6}
\]
Thus the rank-one contribution to (1) is exactly the smoothed arithmetic score
\[
\boxed{\displaystyle
\mathfrak C_X^{(1)}
=4D_X(0)^2\int_0^\infty
\frac{E(Xe^t)}{Xe^tF(Xe^t)}k_s(t)^2dt
=4D_X(0)^2J_s\,
\mathbb E_{\pi_s}\!\left[\frac{E(Xe^t)}{Xe^tF(Xe^t)}\right],
\quad \pi_s(dt)=k_s(t)^2dt/J_s.} \tag{7}
\]
This is a genuine one-dimensional smoothed \(E\) correlation, with the actual \(F\) denominator and all histories inside \(k_s\). The measure \(\pi_s\) is a probability law but is **not** supported at bounded \(t\).

The global error from (4), using \(\beta_{X-1}=\sup_{x\ge X-1}|b_F(x)|\), is
\[
|\mathfrak C_X-\mathfrak C_X^{(1)}|
\le4\beta_{X-1}\bigl(2|A_X|\|T_s\beta_X^{\rm H}\|_2\|r_X\|_2+\|r_X\|_2^2\bigr)
\ll_c\beta_{X-1}\frac{X\Delta_X^2}{s^2}. \tag{8}
\]
The \(s^{-2}\) estimate is a controlled absolute rank-one error; it does not assert that (7) dominates if \(D_X(0)\) is small or its signed score average vanishes.

## Heavy-jump tail and a stronger cubic bound

The complete positive jump measure \(\nu(da)=B(a)da/a\) has finite mass but infinite first moment. Its Laplace exponent obeys \(\Phi(q)/q\to\infty\) as \(q\downarrow0\); the established sharper asymptotic is \(\Phi(q)=-2q\log q+O(q)\). Let \(S_s\sim\mathsf P_s\). For any fixed \(C>0\), choose \(q>0\) with \(\Phi(q)>qC\). Chernoff's inequality gives
\[
\mathsf P_s([0,Cs+1])
\le e^{q(Cs+1)}\mathbb E e^{-qS_s}
\le e^q e^{-\kappa_Cs},
\quad \kappa_C=\Phi(q)-qC>0. \tag{9}
\]
In particular the complete law's mass leaves every fixed linear-age window; replacing it by its zero-jump or any fixed-depth history is invalid here.

This escape holds in the exact physical \(L^2\) output, not merely in probability. For any \(g\in L^2(dx)\) supported on \([X-1,\infty)\), its log representative \(Ug\) is supported to the right of \(\log X-1\). On \(v\le\log X+Cs\), every contributing age is at most \(Cs+1\). Minkowski applied to the **positive probability law as a whole** gives
\[
\|1_{x\le Xe^{Cs}}T_sg\|_2
\le\mathsf P_s([0,Cs+1])\|g\|_2
\le e^qe^{-\kappa_Cs}\|g\|_2. \tag{10}
\]
No absolute interchange of the signed \(\Lambda\)-minus-density block or infinite triple measure occurs: first form \(B_X\in L^2\), then apply the bounded positive convolution semigroup. Equation (10) also applies to \(HB_X\), which has the same causal support.

The original ground score satisfies \(\sup_{x\ge R}|b_F(x)|\ll e^{-\nu\sqrt{\log R}}\). Split (1) at \(R=Xe^{Cs}\). The early part uses (10) with \(g=B_X\), the late part uses \(\|T_sB_X\|_2^2\ll_c X\Delta_X^2/s\):
\[
|\mathfrak C_X|
\ll_c X\Delta_X^2 e^{-2\kappa_Cs}
 +\frac{X\Delta_X^2}{s}
e^{-\nu\sqrt{\log X+Cs}}. \tag{11}
\]
Given **any fixed** \(A>0\), choose fixed \(C\) so \(\nu\sqrt{1+cC}>A\); then \(s=c\log X\), and the first term in (11) is eventually smaller than the second desired scale because \(e^{-\kappa_C c\log X}\) beats \(e^{-A\sqrt{\log X}}\). Hence
\[
\boxed{\displaystyle
|\mathfrak C_X|
\ll_{A,c}\frac{X\Delta_X^2}{\log X}
e^{-A\sqrt{\log X}}
\qquad\text{for every fixed }A>0.} \tag{12}
\]
This is a genuine strengthening of the former fixed-exponent PNT absolute bound for the cubic. It remains \(X^{1-o(1)}\) at the level of available data and is not an RH-scale estimate or a sign theorem.

The same escape applies to the rank-one probability \(\pi_s\). Since \(k_s(t)\le\mathsf P_s([0,t])\), (9) gives
\[
\pi_s([0,Cs])\le \frac{Cs\,e^{-2\kappa_Cs+O(1)}}{J_s}
\ll_C s^2e^{-2\kappa_Cs}. \tag{13}
\]
Thus the score average in (7) samples \(x\ge Xe^{Cs}=X^{1+cC}\) with probability tending to one for every fixed \(C\). The heavy-jump tail is precisely why a compact-age or fixed-polynomial physical cutoff would not preserve the rank-one main term. The global \(L^2\) proof and the split estimate (11) avoid that error.

Finally, the first-order Picone remainder also benefits from this same weighted escape if needed: applying (10) to \(HB_X\) shows \(\|b_FHf_X\|_2\ll_{A,c}(X\Delta_X^2/s)^{1/2}e^{-A\sqrt{\log X}}\) for every fixed \(A\). Inserting this into the exact score identity \(Q_X=2\operatorname{Re}\langle(I-H)f_X,b_FHf_X\rangle-\|b_FHf_X\|_2^2\) yields \(|Q_X|\ll_{A,c}X\Delta_X^2s^{-1}e^{-A\sqrt{\log X}}\). This does not sign the full Picone cross or control coherent sums of different birth blocks; it is an absolute equal-clock whole-block improvement.
