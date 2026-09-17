# Rank-one baseline cross for the true later-clock prefix and current block

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 original-metric note, 2026-09-16. This treats **only** the global block baseline cross in formula (3) of [factorial-f-ground-global-later-clock-dyadic.md](factorial-f-ground-global-later-clock-dyadic.md), at its actual common later clock. The earlier prefix begins at fixed \(A-1\), while the current full dyadic block begins at \(Y-1\). The note keeps their different support thresholds, complete compound-Poisson histories, the original factorial ground \(F\), all observing prime powers, and the literal density ramps. It does not assume RH or replace the full time-ordered matrix by this one baseline term.

## Exact zero modes and their common carrier

Fix \(A\ge3\), a full block \([Y,2Y-1]\) with \(Y\ge2A\), and baseline \(s=s_{Y-1}=c\log(Y-1)\). Put
\[
H^-_Y=g_{Y-1}-g_{A-1},
\qquad P_Y=g_{2Y-1}-g_{Y-1},
\quad E=\psi-x,
\quad d\mu=d\psi-dx. \tag{1}
\]
Thus \(H^-_Y=\int_{(A-1,Y-1]}\beta_y,d\mu(y)\) and \(P_Y=\int_{(Y-1,2Y-1]}\beta_y,d\mu(y)\), where \(\beta_y(x)=1_{x\ge y}/x\). The intervals and their right endpoints retain every \(\Lambda(p^k)\) atom and every density cell. The fixed seed \(g_1\) cancels in these differences but remains in the complete expansion of each \(g_N\).

Their exact Mellin numerators and zero modes are
\[
\begin{aligned}
D^-_Y(\xi)&=\int_{(A-1,Y-1]}y^{-1/2-i\xi}\,dE(y),
&M^-_Y&=D^-_Y(0),\\
D^+_Y(\xi)&=\int_{(Y-1,2Y-1]}y^{-1/2-i\xi}\,dE(y),
&M^+_Y&=D^+_Y(0).
\end{aligned} \tag{2}
\]
Both physical Fourier transforms equal their numerator divided by \(1/2+i\xi\). The zero modes are actual weighted prime-minus-density sums. Their **linear** addition is exact:
\[
M^-_Y+M^+_Y
=\int_{(A-1,2Y-1]}y^{-1/2}dE(y)
=M^-_{2Y}. \tag{3}
\]

Use the common normalized physical Hardy step \(\beta_Y(x)=1_{x\ge Y}/x\), with \(\widehat{U\beta_Y}(\xi)=Y^{-1/2-i\xi}/(1/2+i\xi)\). Define the common full-history carrier \(\phi_{Y,s}=T_s\beta_Y\). The unique coefficients matching the two zero modes at scale \(Y\) are \(a_Y=\sqrt Y M^-_Y\) and \(d_Y=\sqrt Y M^+_Y\).

The growing-prefix Mellin estimate needed for a **global** rank-one remainder is not obtained by treating its interval as a short current block. Put \(\Delta_Y=C_0e^{-a\sqrt{\log(Y/2)}}\). For \(\widetilde D^-_Y(\xi)=Y^{i\xi}D^-_Y(\xi)\), Stieltjes summation by parts with the weight \(y^{-1/2}\log(y/Y)(y/Y)^{-i\xi}\) gives
\[
\sup_{|\xi|\le\delta_0}
|\partial_\xi\widetilde D^-_Y(\xi)|
\ll_A\sqrt Y\Delta_Y. \tag{4}
\]
Here is the uniformity check at the fixed lower endpoint. The boundary there costs \(O_A(\log Y)\), absorbed by \(\sqrt Y\Delta_Y\) for large \(Y\). In the integral, substitute \(y=Ye^{-k}\). The ratio of the decreasing PNT envelope at \(Ye^{-k}\) to \(\Delta_Y\) is at most \(\exp(O(a\sqrt{k+1}))\), while the Jacobian contributes \(e^{-k/2}\). Hence \(\int_0^\infty(1+k)e^{-k/2+O(a\sqrt{k+1})}dk<\infty\). This proves (4) despite the prefix's logarithmically long source range. The current block has \(|\partial_\xi(Y^{i\xi}D^+_Y(\xi))|\ll\sqrt Y\Delta_Y\) more directly, since \(y/Y\in[1-1/Y,2]\).

The complete process multiplier has \(\rho(\xi)=\operatorname{Re}\Phi(i\xi)\asymp|\xi|\) near zero and a spectral gap away from zero. The PNT source norms of both \(H^-_Y\) and \(P_Y\), and of their two reference steps, are \(O_A(\sqrt Y\Delta_Y)\). Apply (4) on the low band and contraction on the exponentially damped high band. With no compact physical cutoff,
\[
\boxed{\displaystyle
T_sH^-_Y=a_Y\phi_{Y,s}+r^-_Y,
\qquad T_sP_Y=d_Y\phi_{Y,s}+r^+_Y,
\qquad \|r^-_Y\|_2+\|r^+_Y\|_2
\ll_{A,c}\frac{\sqrt Y\Delta_Y}{s^{3/2}}.} \tag{5}
\]
This is absolute rather than relative if a zero mode is small. It uses no termwise absolute bound on the signed prime histories.

## Full-prime-power moving Picone kernel

Define the exact original-metric kernel
\[
\boxed{\displaystyle
\mathcal G_{Y,s}:=YQ(\phi_{Y,s},\phi_{Y,s})
=Y\left[
\sum_{m\ge2}\frac{\Lambda(m)|H\phi_{Y,s}(m)|^2}{F(m)}
-\int_1^\infty\frac{|H\phi_{Y,s}(x)|^2}{F(x)}dx
\right].} \tag{6}
\]
All observing prime powers \(m\ge Y\), including arbitrarily late ones, remain. To make its nonlocality explicit, let \(\mathsf P_s\) be the complete all-prime age law and put
\[
j_s(t)=\int_{[0,t]}(t-a)e^{-(t-a)/2}\mathsf P_s(da)
\quad(t\ge0),\qquad j_s(t)=0\quad(t<0). \tag{7}
\]
Since \(H\beta_Y(x)=1_{x\ge Y}\log(x/Y)/x\) and \(H\) commutes with \(T_s\), one has \(H\phi_{Y,s}(Ye^t)=j_s(t)/\sqrt{Y\cdot Ye^t}\). Therefore (6) is exactly
\[
\boxed{\displaystyle
\mathcal G_{Y,s}
=\sum_{m\ge Y}\frac{\Lambda(m)}{mF(m)}
j_s\!\left(\log\frac mY\right)^2
-\int_0^\infty\frac{j_s(t)^2}{F(Ye^t)}dt
=\int_{[Y,\infty)}\frac{j_s(\log(x/Y))^2}{xF(x)}\,dE(x).} \tag{8}
\]
The lower endpoint is harmless: \(j_s(0)=0\), so an atom at \(Y\) contributes zero. Equation (8) retains \(F\), the continuum density, all prime powers, and every path of the complete positive age law; it is not a fixed universal constant or a local \(p\to2p\) conductance. Picone's score identity supplies its alternative exact \(b_F\) form.

The exact true-block baseline cross thus has the rank-one leading formula
\[
\boxed{\displaystyle
2Q(T_sH^-_Y,T_sP_Y)
=2M^-_Y M^+_Y\mathcal G_{Y,s}
+\mathcal E_{Y,s}.} \tag{9}
\]

## Weighted error and the prefix's genuine age loss

For the error in (9), a bare unweighted Cauchy estimate would lose the ground improvement. The support of the residual source producing \(r^-_Y\) still starts at fixed \(A-1\), because the reference \(\beta_Y\) does not erase the actual prefix. The current residual starts at \(Y-1\). At \(R_s=Ye^{\theta s\log s}\), \(0<\theta<1\), the prefix's maximum permitted age is
\[
\log\frac{R_s}{A-1}=\theta s\log s+\frac{s}{c}+O_{A,c}(1), \tag{10}
\]
whereas the current residual and \(\beta_Y\) need only \(\theta s\log s+O(1)\). With \(q=s^{-r}\), \(\theta/2<r<1/2\), the complete exponent \(\Phi(q)=2q\log(1/q)+O(q)\) gives an early-age probability \(\le\exp[-(2r-\theta+o(1))s^{1-r}\log s]\) even after the \(s/c\) prefix loss. This beats every fixed \(e^{-K\sqrt{\log Y\log\log Y}}\). On the late region, the exact ground coefficient satisfies \(\sup_{x\ge R_s}|b_F(x)|\ll e^{-\kappa\sqrt{\log Y\log\log Y}}\) for any fixed \(\kappa<\nu\sqrt{\theta c}\).

Apply this split to the four sources underlying \(a_Y\phi,r^-_Y,d_Y\phi,r^+_Y\), and to their Hardy images. Each source has norm \(O_A(\sqrt Y\Delta_Y)\); its clocked norm is \(O_{A,c}(\sqrt Y\Delta_Y/\sqrt s)\) for a leading part, or \(O_{A,c}(\sqrt Y\Delta_Y/s^{3/2})\) for a residual. The positive-law Minkowski estimate from the true-time-ordered heavy-age note therefore makes every \(b_FH\) factor gain \(e^{-\kappa\sqrt{\log Y\log\log Y}}\) at its corresponding clocked norm, despite the fixed-start prefix. Polarize
\[
Q(u,v)=\langle(I-H)u,b_FHv\rangle
+\langle b_FHu,(I-H)v\rangle
-\langle b_FHu,b_FHv\rangle
\]
on the three error pairings \((a_Y\phi,r^+_Y),(r^-_Y,d_Y\phi),(r^-_Y,r^+_Y)\). This proves
\[
\boxed{\displaystyle
|\mathcal E_{Y,s}|
\ll_{A,c,\kappa}
\frac{Y\Delta_Y^2}{s^2}
e^{-\kappa\sqrt{\log Y\log\log Y}},
\qquad 0<\kappa<\nu\sqrt{\theta c}.} \tag{11}
\]
The error is one additional clock factor below the PNT envelope for the full baseline cross. It is not relative to the main term when \(M^-_Y\), \(M^+_Y\), or \(\mathcal G_{Y,s}\) is small.

## Telescope test and surviving arithmetic condition

At the zero-mode level, (3) is exact. If one also combines the rank-one diagonal of the current block with (9), the algebraic coefficient identity is
\[
(M^+_Y)^2+2M^-_YM^+_Y
=(M^-_{2Y})^2-(M^-_Y)^2. \tag{12}
\]
But the coefficient is multiplied at this block by the **moving signed kernel** \(\mathcal G_{Y,s_{Y-1}}\). For successive full blocks \(Y_t=2^tA\), let \(M_t=\int_{(A-1,2Y_t-1]}y^{-1/2}dE(y)\) and \(G_t=\mathcal G_{Y_t,s_{Y_t-1}}\). The formal finite summation-by-parts identity for the rank-one baseline-plus-diagonal terms is
\[
\sum_{t=0}^{T}G_t(M_t^2-M_{t-1}^2)
=G_TM_T^2-\sum_{t=0}^{T-1}(G_{t+1}-G_t)M_t^2,
\quad M_{-1}=0. \tag{13}
\]
There is no cancellation of the second term unless one proves a source-specific estimate for the variation of the nonlocal \(F\)-weighted kernels (8). The cross alone does not telescope even with a constant kernel; the diagonal is needed for (12). Equation (13) is an exact algebraic description of the surviving kernel-variation obligation, not a claim that the actual sum diverges. The true time-ordered drift remains separate and is not replaced by this baseline identity. No sign of \(G_t\) or RH conclusion is inferred.
