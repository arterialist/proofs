# Complete finite later-clock matrix: scalar zero mode and non-summable residual

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 conditional reduction and endpoint audit, 2026-09-16. This combines the rank-one prefix/current-block baseline, its derivative drift, and the adjacent moving-kernel calculation. The identity below is for the **actual finite later-clock polarized Picone matrix** in physical \(L^2(dx)\), including a partial last dyadic block, all literal \(\Lambda\)-minus-density births, observing prime powers, and complete age histories. It is not an RH proof, an infinite-terminal identity, or an equivalence with the RH consumer.

Fix \(A\ge3\), \(c>0\), and \(N\ge A\). Put \(s_n=c\log n\), \(E=\psi-x\), \(v_n=\Lambda(n)\beta_n-\int_{n-1}^n\beta_y\,dy\), and
\[
m_n=\int_{(n-1,n]}y^{-1/2}dE(y)
=\frac{\Lambda(n)}{\sqrt n}-2(\sqrt n-\sqrt{n-1}),\quad
M_k=\sum_{n=A}^km_n=\int_{(A-1,k]}y^{-1/2}dE(y),\quad M_{A-1}=0. \tag{1}
\]
For \(t\ge0\), let \(Y_t=2^tA\), \(b_t=\min(2Y_t-1,N)\), and retain only nonempty blocks; write \(T\) for the last one. Let \(h_k=g_k-g_{A-1}\), \(q_s(h)=Q(T_sh,T_sh)\), and
\[
G_Y(s)=YQ(T_s\beta_Y,T_s\beta_Y)
=\int_{[Y,\infty)}\frac{j_s(\log(x/Y))^2}{xF(x)}dE(x), \tag{2}
\]
where \(j_s=\eta_s*(t e^{-t/2}1_{t\ge0})\). Formula (2) includes all future prime-power observations and the negative continuum, with the actual \(F\) denominator. The matrix of interest is
\[
\mathscr C_{A,N}=\sum_{i,j=A}^N
Q(T_{s_{\max(i,j)}}v_i,T_{s_{\max(i,j)}}v_j). \tag{3}
\]

## One exact finite scalar decomposition

For any block \(I_t=[Y,b]\), including the truncated last one, and any \(Y\le n\le b\), let \(\sigma=s_{Y-1}\) and define the **exact** residual
\[
\begin{aligned}
e_t(n):={}&q_\sigma(h_n)-q_\sigma(h_{Y-1})
-G_Y(\sigma)(M_n^2-M_{Y-1}^2)\\
&+\sum_{k=Y-1}^{n-1}\int_{s_k}^{s_{k+1}}
\Bigl\{q'_s(h_n)-q'_s(h_k)
-G'_Y(s)(M_n^2-M_k^2)\Bigr\}ds.
\end{aligned} \tag{4}
\]
All source endpoints in (4) are literal: \(h_k=\int_{(A-1,k]}\beta_y,dE(y)\). The block time-ordering identity and finite summation by parts give exactly
\[
\boxed{\displaystyle
\mathscr C_{A,N}=\sum_{t<T}\sum_{n=Y_t}^{2Y_t-1}
G_{Y_t}(s_n)(M_n^2-M_{n-1}^2)
+\sum_{n=Y_T}^{N}G_{Y_T}(s_n)(M_n^2-M_{n-1}^2)
+\sum_{t<T}e_t(2Y_t-1)+e_T(N).} \tag{5}
\]
No full-block term at \(2Y_T-1\) is inserted when \(N<2Y_T-1\). In particular, \(N=A\) reduces to the one-birth term at \(s_A\), with the initial \(M_{A-1}=0\).

The reviewed prefix-block rank-one and derivative estimates are uniform in the moving cut \(n\) and therefore apply to the partial last block. Let \(L_t=\log Y_t\), \(\Delta_t=C e^{-a\sqrt{\log(Y_t/2)}}\) be an actual PNT envelope, and choose fixed \(0<\kappa<\nu\sqrt c\), where \(\sup_{x\ge R}|b_F(x)|\ll e^{-\nu\sqrt{\log R}}\). Then, after adjusting the heavy-age cutoff parameter to this \(\kappa\),
\[
\boxed{\displaystyle
\sup_{Y_t\le n\le b_t}|e_t(n)|
\ll_{A,c,\kappa}
\frac{Y_t\Delta_t^2}{L_t^2}
e^{-\kappa\sqrt{L_t\log L_t}}.} \tag{6}
\]
The baseline error is the dominant \(L_t^{-2}\) term; the integrated derivative residual is smaller by \(\log L_t/L_t\). For finitely many small \(Y_t\), increase the constant. Equation (6) is an absolute bound, not a claim of a favorable sign.

There is a cleaner global scalar form. Apply Abel summation to the two scalar sums in (5). At every completed block boundary \(b_t=2Y_t-1=Y_{t+1}-1\), define the **same-clock physical kernel jump**
\[
J_t=G_{Y_{t+1}}(s_{b_t})-G_{Y_t}(s_{b_t}). \tag{7}
\]
The next block's first clock interval \([s_{b_t},s_{b_t+1}]\) is included in its derivative sum; it is not silently absorbed into \(J_t\). With \(M_{A-1}=0\), (5) becomes
\[
\boxed{\begin{aligned}
\mathscr C_{A,N}={}&G_{Y_T}(s_N)M_N^2
-\sum_{t<T}J_tM_{b_t}^2\\
&-\sum_{t=0}^T\sum_{k=Y_t-1}^{b_t-1}
M_k^2\int_{s_k}^{s_{k+1}}G'_{Y_t}(s)ds
+\mathcal R_{A,N},\\
\mathcal R_{A,N}:={}&\sum_{t<T}e_t(b_t)+e_T(N).
\end{aligned}} \tag{8}
\]
Here \(G'\) is the full clock jump-Stokes response, with all future prime-power/density observations; \(J_t\) is the explicit [\(Y_t,2Y_t\)) excluded endpoint plus shifted tail from [the adjacent moving-kernel variation](factorial-f-ground-moving-kernel-variation.md). Formula (8) separates the scalar terminal score, physical kernel jumps, within-block clock derivative, and nonzero-mode residual. It is exact for every finite \(N\).

The scalar physical jump has the heavy-age continuity estimate \(|J_t|\ll e^{-\kappa\sqrt{L_t\log L_t}}/L_t^2\); the clock derivative over a fixed block interval is \(O(e^{-\kappa\sqrt{L_t\log L_t}}\log L_t/L_t^2)\), with a smaller local interval when appropriate. Together with \(|M_k|^2\ll_A Y_t\Delta_t^2\) they recover only terminal-scale positive majorants. Likewise (6) implies
\[
|\mathcal R_{A,N}|\ll_{A,c,\kappa}
\sum_{t\le T}\frac{Y_t\Delta_t^2}{L_t^2}
e^{-\kappa\sqrt{L_t\log L_t}}, \tag{9}
\]
and this dyadic sum **diverges** as \(N\to\infty\): its summands are \(Y_t^{1-o(1)}\). Consequently no signed condition on the first three scalar terms of (8) alone can yield a terminal Cauchy criterion from the current estimates. The residual needs its own stronger signed or source-specific bound.

## A sufficient condition, and its exact status

Define \(\mathcal B_N\) to be the first three lines on the right of (8), excluding \(\mathcal R_{A,N}\). One clean sufficient **two-part** condition for the actual finite matrix to have a terminal limit is:
\[
\begin{cases}
\displaystyle\sup_{N'\ge N\ge K}|\mathcal B_{N'}-\mathcal B_N|\longrightarrow0
& (K\to\infty),\\[1mm]
\displaystyle\sum_{t\ge0}\sup_{Y_t\le n\le2Y_t-1}|e_t(n)|<\infty.
\end{cases} \tag{10}
\]
The first line is a **signed arithmetic balance condition** on the explicit endpoint, same-clock F-ground kernel jumps, and jump-Stokes clock derivatives; it must hold uniformly for partial last blocks. The second is a separate nonzero-mode summability condition. It is stronger than merely asking the completed-block residual series to converge, but makes the partial-endpoint issue transparent. Under (10), \(\mathcal B_N\) is Cauchy and \(\mathcal R_{A,N}\) is Cauchy by the absolute series and \(e_t(n)\to0\), so (8) gives a limit for \(\mathscr C_{A,N}\).

This is a **conditional sufficient reduction**, not an unconditional estimate. Its first line is not implied by the pointwise PNT/Plancherel bounds, and its second line is not implied by (6). Nor is (10) currently known to imply RH: no exact transfer from this indefinite factorial Picone matrix's terminal limit to the positive central-arc RH consumer has been proved. It is therefore neither an established RH-equivalent criterion nor a demonstrated genuinely independent theorem. The tempting shortcut \(M_k\ll_\epsilon k^\epsilon\) for every \(\epsilon>0\) must not be inserted here: Stieltjes inversion between \(M\) and \(E\) shows that family is itself equivalent to \(E(x)\ll_\epsilon x^{1/2+\epsilon}\), hence to RH. Any progress from (8) needs a signed bound on the actual jump/clock combination **and** independent control of the nonzero-mode residual, without assuming that zero-mode shortcut.
