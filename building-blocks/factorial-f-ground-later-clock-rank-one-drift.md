# Rank-one drift of the true later-clock factorial block matrix

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 original-metric note, 2026-09-16. This continues [factorial-f-ground-prefix-block-rank-one.md](factorial-f-ground-prefix-block-rank-one.md) and analyzes the **derivative drift** in formulas (10)--(11) of [factorial-f-ground-time-ordered-heavy-age.md](factorial-f-ground-time-ordered-heavy-age.md). It does not estimate the moving kernel difference directly. Every literal birth endpoint, density ramp, observing prime power, complete jump history, and the original \(F\)-ground metric is retained. No RH premise or sign claim is made.

## Exact scalar data and kernel derivative

Fix \(A\ge3\), a full current block \(I_t=[Y,b]\cap\mathbb Z\) with \(b=2Y-1\), and \(s_n=c\log n\). For the last truncated block the same formulas hold with its actual \(b\le2Y-1\). Define the literal weighted birth zero modes
\[
m_n=\frac{\Lambda(n)}{\sqrt n}-\int_{n-1}^{n}y^{-1/2}dy,
\qquad M_k=\sum_{n=A}^{k}m_n
=\int_{(A-1,k]}y^{-1/2}dE(y),
\quad M_{A-1}=0. \tag{1}
\]
Thus \(M_{Y-1}\) is the fixed-start earlier-prefix mode and \(M_b-M_{Y-1}\) is the current-block mode. The right endpoint \(k\) includes its prime-power atom; \(n-1\) belongs to the preceding density boundary. The literal seed \(g_1\) cancels in the source difference but is not reassigned zero.

At fixed scale \(Y\), put \(\beta_Y^{\rm H}(x)=1_{x\ge Y}/x\), \(\phi_{Y,s}=T_s\beta_Y^{\rm H}\), and
\[
\mathcal G_Y(s)=YQ(\phi_{Y,s},\phi_{Y,s}),
\quad Q=B_P-B_C,
\quad F(x)=\log x-\sum_{m\le x}\Lambda(m)/m+\psi(x)/x. \tag{2}
\]
The exact physical expression for \(\mathcal G_Y(s)\) is the all-prime-power sum minus density in equation (8) of the preceding prefix-block note, with the complete process profile \(j_s=\mathsf P_s*(t e^{-t/2}1_{t\ge0})\). Since the full generator \(\mathsf A=\lambda I-\nu*\) is bounded and \(Q\) is a bounded original-\(L^2\) form, \(s\mapsto\mathcal G_Y(s)\) is continuously differentiable and
\[
\boxed{\displaystyle
\mathcal G'_Y(s)
=-2Y\operatorname{Re}Q(\mathsf A\phi_{Y,s},\phi_{Y,s}).} \tag{3}
\]
This derivative retains the actual \(F\), all later observing prime powers, and every compound-Poisson path. It is not a sign-definite Dirichlet dissipation, because \(Q\) is signed and the arithmetic observations are not invariant under \(T_s\).

## Uniform derivative rank-one expansion

Let \(V_k=g_k-g_{A-1}=H_{t-1}+P_{t,k}\) and \(W_k=g_b-g_k=P_t-P_{t,k}\), for \(Y-1\le k\le b-1\). Then \(V_k+W_k=g_b-g_{A-1}\), with modes \(M_k\), \(M_b-M_k\), and \(M_b\). The growing-prefix Mellin estimate in the preceding note applies uniformly as \(k\) moves through the current block: after factoring the phase \(Y^{-i\xi}\), each numerator has a Lipschitz error \(O_A(\sqrt Y\Delta_Y|\xi|)\) on a fixed small band, where \(\Delta_Y=C_0e^{-a\sqrt{\log(Y/2)}}\). The current suffix \((k,b]\) has the same estimate because its endpoints stay in \([Y-1,2Y-1]\). Their source norms are \(O_A(\sqrt Y\Delta_Y)\).

The complete multiplier is \(e^{-s\Phi(i\xi)}\), with \(\rho=\operatorname{Re}\Phi(i\xi)\asymp|\xi|\) near zero, a positive high-frequency gap, and \(|\Phi(i\xi)|\ll|\xi|\log(2/|\xi|)\) on a small band. The same low/high Plancherel split therefore gives, uniformly for \(s\in[s_{Y-1},s_b]\),
\[
\boxed{\begin{aligned}
T_sV_k&=\sqrt Y M_k\phi_{Y,s}+r_{k,s},
&\|r_{k,s}\|_2&\ll_{A,c}\frac{\sqrt Y\Delta_Y}{s^{3/2}},\\
\mathsf A T_sV_k&=\sqrt Y M_k\mathsf A\phi_{Y,s}+r^{(1)}_{k,s},
&\|r^{(1)}_{k,s}\|_2&\ll_{A,c}\frac{\sqrt Y\Delta_Y\log s}{s^{5/2}}.
\end{aligned}} \tag{4}
\]
The same bounds hold with \(V_k,M_k\) replaced by \(W_k,M_b-M_k\), and with the full source \(V_k+W_k,M_b\). For the derivative error, the low-frequency square is bounded by \(Y\Delta_Y^2\int\xi^4\log^2(2/|\xi|)e^{-c_0s|\xi|}d\xi\ll Y\Delta_Y^2(\log s)^2/s^5\); the high band is exponentially damped using the boundedness of \(\mathsf A\). No differentiated infinite history series is used.

The actual derivative of a source square is \(q'_s(h)=-2\operatorname{Re}Q(\mathsf A T_sh,T_sh)\). Equations (3)--(4) give its leading scalar uniformly in the moving cut:
\[
\boxed{\displaystyle
q'_s(g_b-g_{A-1})-q'_s(V_k)
=\mathcal G'_Y(s)\bigl(M_b^2-M_k^2\bigr)
+\mathcal R_{k,s}.} \tag{5}
\]

The remainder can be weighted by the same complete-law heavy-age localization, rather than a bare \(\beta_Y\) norm. Choose fixed \(0<\theta<1\), \(\theta/2<r<1/2\), and \(R_s=Y\exp(\theta s\log s)\). The prefix and every residual source in (4) starts no earlier than \(A-1\); its maximum age before \(R_s\) is \(\theta s\log s+s/c+O_{A,c}(1)\). With \(q=s^{-r}\), the exact Laplace exponent \(\Phi(q)=2q\log(1/q)+O(q)\) makes this early-law mass \(\le e^{-(2r-\theta+o(1))s^{1-r}\log s}\). The late ground factor is \(\sup_{x\ge R_s}|b_F(x)|\ll e^{-\kappa\sqrt{\log Y\log\log Y}}\) for fixed \(\kappa<\nu\sqrt{\theta c}\). Generator and Hardy convolution preserve the lower support, so the same weighted gain applies to \(b_FH r_{k,s}\) and \(b_FH r^{(1)}_{k,s}\) at their respective norms in (4). At least one factor in each polarized difference contains the current suffix \(W_k\), so the physical cross begins at \(Y-1\).

That last support assertion uses the **difference before taking absolute values**. Explicitly,
\[
q'_s(V_k+W_k)-q'_s(V_k)
=-2\operatorname{Re}\{Q(\mathsf A T_sV_k,T_sW_k)
+Q(\mathsf A T_sW_k,T_sV_k)
+Q(\mathsf A T_sW_k,T_sW_k)\}.
\]
No standalone fixed-prefix square is estimated; its terms cancel algebraically in this expansion. This is why the late ground restriction is legitimate for every remainder pairing below.

Pair the leading ordinary norm \(O(\sqrt Y\Delta_Y/\sqrt s)\), leading generator norm \(O(\sqrt Y\Delta_Y\log s/s^{3/2})\), and residual norms in (4) in the exact score polarization of \(Q\). One obtains
\[
\boxed{\displaystyle
|\mathcal R_{k,s}|
\ll_{A,c,\kappa}
\frac{Y\Delta_Y^2\log s}{s^3}
e^{-\kappa\sqrt{\log Y\log\log Y}}.} \tag{6}
\]
The bound is uniform in \(k\) and \(s\) in the block. The extra \(1/s\) is the actual rank-one derivative gain over the previously proved full drift envelope \(Y\Delta_Y^2\log s/s^2\) times the same ground factor.

## Integration and the moving-kernel test

The exact derivative portion of the true block formula is
\[
\mathscr V_t=\sum_{k=Y-1}^{b-1}\int_{s_k}^{s_{k+1}}
\{q'_s(g_b-g_{A-1})-q'_s(V_k)\}\,ds. \tag{7}
\]
The full clock interval has length \(s_b-s_{Y-1}=O_c(1)\), so (5)--(6) give
\[
\boxed{\displaystyle
\mathscr V_t
=\sum_{k=Y-1}^{b-1}(M_b^2-M_k^2)
\bigl[\mathcal G_Y(s_{k+1})-\mathcal G_Y(s_k)\bigr]
+O_{A,c,\kappa}\!\left(
\frac{Y\Delta_Y^2\log\log Y}{(\log Y)^3}
e^{-\kappa\sqrt{\log Y\log\log Y}}
\right).} \tag{8}
\]
No factor equal to the number of births is introduced: the integrals \([s_k,s_{k+1}]\) partition one interval of length \(O_c(1)\), and the bound (6) is uniform.

The baseline rank-one formula from the preceding note is
\[
q_{s_{Y-1}}(g_b-g_{A-1})-q_{s_{Y-1}}(g_{Y-1}-g_{A-1})
=\mathcal G_Y(s_{Y-1})(M_b^2-M_{Y-1}^2)
+O_{A,c,\kappa}\!\left(\frac{Y\Delta_Y^2}{(\log Y)^2}
e^{-\kappa\sqrt{\log Y\log\log Y}}\right). \tag{9}
\]
Adding (8) and (9), the scalar part telescopes **within** the block by finite summation by parts:
\[
\boxed{\displaystyle
\mathscr D_t
=\sum_{n=Y}^{b}\mathcal G_Y(s_n)(M_n^2-M_{n-1}^2)
+O_{A,c,\kappa}\!\left(\frac{Y\Delta_Y^2}{(\log Y)^2}
e^{-\kappa\sqrt{\log Y\log\log Y}}\right).} \tag{10}
\]
Thus the derivative drift converts the fixed baseline kernel into the **actual later birth clocks** at leading rank-one order. It does not eliminate the kernel.

To see exactly what remains across blocks, apply finite summation by parts once more to the scalar term in (10). If \(Y_t\) are successive full dyadic starts and \(b_t=2Y_t-1\), then
\[
\begin{aligned}
\sum_t\sum_{n=Y_t}^{b_t}\mathcal G_{Y_t}(s_n)(M_n^2-M_{n-1}^2)
={}&\mathcal G_{Y_T}(s_{b_T})M_{b_T}^2\\
&+\sum_{t<T}
\bigl[\mathcal G_{Y_t}(s_{b_t})
-\mathcal G_{Y_{t+1}}(s_{b_t})\bigr]M_{b_t}^2\\
&-\sum_t\sum_{k=Y_t-1}^{b_t-1}
\int_{s_k}^{s_{k+1}}\mathcal G'_{Y_t}(s)M_k^2ds.
\end{aligned} \tag{11}
\]
The initial \(M_{A-1}=0\). The middle line is the **spatial kernel jump at one shared clock**, \(Y_t\to2Y_t\), with the actual \(F\)-weighted profile (2); the last line is the within-block clock derivative against the growing partial prefix. Neither is algebraically zero. Equation (11) separates the temporal component from the moving-scale component without estimating \(\mathcal G_{2Y}-\mathcal G_Y\) directly. A cancellation between these two signed remainders would be a further arithmetic theorem, not a consequence of the rank-one expansion or the complete positive law. The per-block error in (10) remains PNT-scale and is not absolutely summable to infinity; no infinite-terminal or RH claim follows.
