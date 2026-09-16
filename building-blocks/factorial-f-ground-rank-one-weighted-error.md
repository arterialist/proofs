# The rank-one cubic error retains quantitative heavy-age escape

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 audited supplement, 2026-09-16. This checks the weighted error left open between [factorial-f-ground-equal-clock-rank-one.md](factorial-f-ground-equal-clock-rank-one.md) and [factorial-f-ground-quantitative-heavy-age.md](factorial-f-ground-quantitative-heavy-age.md). It concerns the **equal-clock whole-block cubic only**, in the original physical metric. It supplies no sign, time-ordered transfer, terminal limit, or RH result.

Let \(S=\log X\), \(s=cS\), \(B_X=g_{2X}-g_{X-1}\), and
\[
d_X=D_X(0)=\int_{(X-1,2X]}y^{-1/2}\,dE(y),\qquad
A_X=\sqrt X\,d_X,\qquad
u_X=A_XT_s\beta_X^{\rm H},\quad
r_X=T_s(B_X-A_X\beta_X^{\rm H}). \tag{1}
\]
Here \(\beta_X^{\rm H}=1_{x\ge X}/x\). Both *inputs* in (1) are supported on \([X-1,\infty)\); in particular the residual is an exact convolution of a right-supported input, not just an abstract \(L^2\) difference. The signed source and full age law are unchanged. The reviewed rank-one estimates give
\[
|d_X|\ll\sqrt X\Delta_X,\quad
\|B_X-A_X\beta_X^{\rm H}\|_2\ll\sqrt X\Delta_X,\quad
\|u_X\|_2=|d_X|J_s^{1/2}\ll_c |d_X|s^{-1/2},\quad
\|r_X\|_2\ll_c\sqrt X\Delta_Xs^{-3/2}. \tag{2}
\]
The exact identity \(\|A_X\beta_X^{\rm H}\|_2=|d_X|\) fixes the normalization in (2).

Let \(\nu>0\) be any fixed constant for which the actual factorial ground obeys
\(\sup_{x\ge R}|b_F(x)|\ll e^{-\nu\sqrt{\log R}}\) for all sufficiently large \(R\). Fix any \(\kappa<\nu\sqrt c\). Choose \(a\in(0,1)\) close enough to \(1\) that \(\kappa<\nu\sqrt{ac}\), and choose \(r\in(a/2,1/2)\). Set
\[
L=a s\log s,\quad R=Xe^L,\quad
\varepsilon_X=e^{-\kappa\sqrt{S\log S}},\quad
\vartheta_s=\mathsf P_s(S_s\le L+1). \tag{3}
\]
The actual complete jump law has \(\Phi(q)=2q\log(1/q)+O(q)\). Chernoff with \(q=s^{-r}\) gives a fixed \(d>0\) and, for large \(s\),
\[
\vartheta_s\le e^{-d s^{1-r}\log s},\qquad
\sup_{x\ge R}|b_F(x)|\ll_{c,\kappa}\varepsilon_X. \tag{4}
\]
Since \(1-r>1/2\), \(\vartheta_s^2\) is smaller than \(\varepsilon_Xs^{-m}\) for every fixed \(m>0\). This statement includes the no-jump and every multi-jump history.

For any right-supported input \(h\) on \([X-1,\infty)\), causality and Minkowski give
\[
\|1_{x\le R}T_sh\|_2\le\vartheta_s\|h\|_2. \tag{5}
\]
Apply (5) **separately** to the two inputs in (1). Using \(\|A_X\beta_X^{\rm H}\|_2=|d_X|\) and (2), split their weighted cross at \(R\):
\[
\begin{aligned}
\int_1^\infty |b_Fu_Xr_X|dx
&\le \|b_F\|_{L^\infty[X-1,R]}\,
\|1_{x\le R}u_X\|_2\|1_{x\le R}r_X\|_2
+\|b_F\|_{L^\infty[R,\infty]}\|u_X\|_2\|r_X\|_2\\
&\ll_c |d_X|\sqrt X\Delta_X\vartheta_s^2
+\varepsilon_X\frac{|d_X|\sqrt X\Delta_X}{s^2}
\ll_{c,\kappa}\varepsilon_X\frac{|d_X|\sqrt X\Delta_X}{s^2}. \tag{6}
\end{aligned}
\]
The identical split for the residual square gives
\[
\int_1^\infty |b_F||r_X|^2dx
\ll_{c,\kappa}\varepsilon_X\frac{X\Delta_X^2}{s^3}. \tag{7}
\]
No weighted spectral assertion is needed: the \(s^{-3/2}\) global residual norm is used only on the late side, and the unsmoothed residual input norm only on an early side whose clock probability is smaller than the desired scale by every fixed power of \(s\).

For \(f_X=u_X+r_X\), let
\(\mathfrak C_X=-4\langle f_X,b_Ff_X\rangle\) and
\(\mathfrak C_X^{(1)}=-4\langle u_X,b_Fu_X\rangle\), with the exact score representation of the latter in the rank-one note. Equations (6)--(7) prove the strengthened **absolute** weighted error
\[
\boxed{\displaystyle
|\mathfrak C_X-\mathfrak C_X^{(1)}|
\ll_{c,\kappa}\varepsilon_X
\left(\frac{|d_X|\sqrt X\Delta_X}{s^2}
+\frac{X\Delta_X^2}{s^3}\right)
\ll_{c,\kappa}\varepsilon_X\frac{X\Delta_X^2}{s^2},
\qquad 0<\kappa<\nu\sqrt c.} \tag{8}
\]
The factor \(4\) in the definition contributes \(8\) times the absolute cross and \(4\) times the residual square; it is harmless in the displayed \(O\)-constant. This improves the unweighted-ground error \(O(\beta_{X-1}X\Delta_X^2/s^2)\) in the exact way needed to compare it with the heavy-age cubic envelope. The main carrier obeys \(|\mathfrak C_X^{(1)}|\ll_{c,\kappa}\varepsilon_X |d_X|^2/s\), so (8) is lower by \(1/s\) against the **maximal PNT-sized carrier envelope** when \(|d_X|\asymp\sqrt X\Delta_X\).

It is not a relative asymptotic to the **signed value** \(\mathfrak C_X^{(1)}\). The score average in its exact formula can cancel, and \(d_X\) itself may be exceptionally small. If \(d_X=0\), the carrier vanishes while (8) leaves a residual cubic of order at most \(\varepsilon_X X\Delta_X^2/s^3\). Thus the rank-one readout identifies a smoothed signed observable but cannot, without a lower bound on that signed observable or a separate estimate of the residual, determine the sign or leading size of the actual cubic.
