# Heavy-age localization for the true time-ordered Picone block matrix

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 original-metric note, 2026-09-16. This adapts the complete-law escape in [factorial-f-ground-equal-clock-rank-one.md](factorial-f-ground-equal-clock-rank-one.md) to formulas (2)--(9) of [factorial-f-ground-global-later-clock-dyadic.md](factorial-f-ground-global-later-clock-dyadic.md). The important new issue is the earlier prefix \(H_{t-1}=g_{Y-1}-g_{A-1}\), whose physical support starts at the fixed \(A-1\), not at the current scale \(Y-1\). All literal prime-power births, density ramps, observing prime powers, and ordered jump histories remain in the original \(L^2(dx)\). No RH assumption or infinite-terminal limit is made.

## The age threshold with the fixed early prefix

Fix \(A\ge3\), \(c>0\), and a current dyadic block \(I_t=[Y,b_t]\cap\mathbb Z\), \(Y=a_t\), \(L=\log Y\). Let \(s\in[s_{Y-1},s_{b_t}]\), so \(s=cL+O_{A,c}(1)\). The complete compound-Poisson age law is \(\mathsf P_s=e^{-s\lambda}\sum_{k\ge0}s^k\nu^{*k}/k!\), with Laplace exponent \(\Phi(q)=\int(1-e^{-qa})\nu(da)\). Its full-prime asymptotic is
\[
\Phi(q)=2q\log(1/q)+O(q)\qquad(q\downarrow0). \tag{1}
\]
The density of \(\nu\) includes every proper-power interval of every prime. Write \(S_s\sim\mathsf P_s\). For any physical source \(h\) supported in \([a_h,\infty)\), the exact convolution representation under \(Ug(v)=e^{v/2}g(e^v)\) gives
\[
\boxed{\displaystyle
\|1_{x\le R}T_sh\|_2
\le\mathsf P_s\bigl([0,\log(R/a_h)]\bigr)\|h\|_2.} \tag{2}
\]
Indeed at output \(x\le R\), a history of age \(a>\log(R/a_h)\) samples below the source's support and vanishes; Minkowski bounds the remaining **positive law as a whole**. No signed-source or history series is interchanged absolutely.

Choose fixed \(0<\theta<1\) and set \(\ell_s=\theta s\log s\), \(R_s=Y e^{\ell_s}\). For a current-block source \(a_h\ge Y-1\), (2) needs only ages \(a\le\ell_s+O(1)\). For the earlier prefix, however, \(a_h=A-1\), and the exact permitted maximum is
\[
\log\frac{R_s}{A-1}
=\ell_s+\log\frac{Y}{A-1}
=\theta s\log s+\frac{s}{c}+O_{A,c}(1). \tag{3}
\]
The additional \(s/c\) is indispensable; omitting it would falsely assign the prefix current-block support. It remains lower order than \(s\log s\).

Choose \(r\) with \(\theta/2<r<1/2\), and set \(q=s^{-r}\). Chernoff's inequality, (1), and (3) give uniformly for current and fixed-prefix sources
\[
\begin{aligned}
\mathsf P_s\bigl(S_s\le\ell_s+\log(Y/(A-1))+O(1)\bigr)
&\le\exp\{q[\ell_s+s/c+O(1)]-s\Phi(q)\}\\
&\le\exp\{-(2r-\theta+o(1))s^{1-r}\log s\}.
\end{aligned} \tag{4}
\]
Since \(r<1/2\), this is smaller than \(e^{-K\sqrt{s\log s}}\) for **every fixed** \(K>0\) once \(s\) is large. This is a quantitative full-history statement; the zero-jump atom is included in the Chernoff bound.

## Ground-weight localization for sources and drift

Let \(\Delta_Y=C_0e^{-a\sqrt{\log(Y/2)}}\) be the unconditional PNT envelope and \(\beta_R=\sup_{x\ge R}|b_F(x)|\), \(b_F=xF'/F\). The established factorial-ground estimate gives \(\beta_R\ll e^{-\nu\sqrt{\log R}}\). At \(R_s=Ye^{\theta s\log s}\),
\[
\log R_s=L+\theta s\log s
=(\theta c+o(1))L\log L,
\qquad
\beta_{R_s}\ll e^{-\kappa\sqrt{L\log L}} \tag{5}
\]
for every fixed \(0<\kappa<\nu\sqrt{\theta c}\), after adjusting the constant. The exponent from (4) dominates this root-\(L\log L\) scale, even after polynomial factors in \(L\).

The source families used by the exact block identity are: \(P_t\), each current prefix/suffix \(P_{t,k}\), \(P_t-P_{t,k}\), the fixed-start prefix \(H_{t-1}\), and their sums \(H_t,H_{t-1}+P_{t,k}\). The PNT/Mellin estimate from the global dyadic note gives for all these \(h\), uniformly in \(k,t\),
\[
\|h\|_2\ll_{A}\sqrt Y\Delta_Y,
\quad\|T_sh\|_2\ll_{A,c}M_Y,
\quad\|\mathsf A T_sh\|_2\ll_{A,c}M'_Y,
\quad
M_Y=\frac{\sqrt Y\Delta_Y}{\sqrt L},
\quad M'_Y=\frac{\sqrt Y\Delta_Y\log L}{L^{3/2}}, \tag{6}
\]
where \(\mathsf A=\lambda I-\nu*\) is the bounded complete generator in log coordinates. It commutes with \(T_s\) and \(H\), satisfies \(\|\mathsf Ah\|_2\le2\lambda\|h\|_2\), and preserves the source's lower support: its convolution term shifts only to the right. Thus (2)--(4) apply equally to \(h\), \(Hh\), \(\mathsf Ah\), and \(H\mathsf Ah\), with source norm at most a fixed multiple of \(\sqrt Y\Delta_Y\).

For any such \(h\), split \(b_FHT_sh\) at \(R_s\). On the early region \([Y-1,R_s]\), use \(\beta_{Y-1}\) and (2)--(4), paying the **prefix** threshold (3) when needed. On the late region use (5) and (6). The early factor \(e^{-c_1s^{1-r}\log s}\sqrt Y\Delta_Y\) is eventually smaller than \(M_Ye^{-\kappa\sqrt{L\log L}}\), and also smaller than \(M'_Ye^{-\kappa\sqrt{L\log L}}\). Consequently, uniformly throughout the block clock interval,
\[
\boxed{\displaystyle
\|1_{x\ge Y-1}b_FHT_sh\|_2
\ll_{A,c,\kappa}M_Ye^{-\kappa\sqrt{L\log L}},
\qquad
\|1_{x\ge Y-1}b_FH\mathsf A T_sh\|_2
\ll_{A,c,\kappa}M'_Ye^{-\kappa\sqrt{L\log L}}.} \tag{7}
\]
The restriction \(x\ge Y-1\) is essential for fixed-start prefixes; without a current-block factor, an early prefix alone cannot use the late ground weight. For a current-block source, the restriction is automatic. These are original-\(L^2\) estimates; the full \(F\) and all its later prime-power observations remain encoded by the Picone identity.

Whenever at least one of two inputs is a current-block source, all three terms of
\[
Q(u,v)=\langle(I-H)u,b_FHv\rangle
+\langle b_FHu,(I-H)v\rangle
-\langle b_FHu,b_FHv\rangle \tag{8}
\]
are supported on \(x\ge Y-1\). Apply (6)--(7), \(\|I-H\|=1\), and \(\|H\|\le2\). For ordinary source pairs and for one-generator drift pairs respectively this yields
\[
|Q(T_sh,T_sk)|\ll_{A,c,\kappa}M_Y^2e^{-\kappa\sqrt{L\log L}},
\qquad
|Q(\mathsf A T_sh,T_sk)|+|Q(T_sh,\mathsf A T_sk)|
\ll_{A,c,\kappa}M_YM'_Ye^{-\kappa\sqrt{L\log L}}. \tag{9}
\]
The current-block condition cannot be dropped: (7) only controls the fixed-prefix score on its late overlap, not its standalone early Picone form.

## Consequence for the exact time-ordered increment

The exact block formula from the global note is
\[
\mathscr D_t=q_{\sigma_t}(H_t)-q_{\sigma_t}(H_{t-1})
+\sum_{k=a_t-1}^{b_t-1}\int_{s_k}^{s_{k+1}}
\{q'_s(H_t)-q'_s(H_{t-1}+P_{t,k})\}ds. \tag{10}
\]
The baseline difference equals \(q_{\sigma_t}(P_t)+2Q(T_{\sigma_t}H_{t-1},T_{\sigma_t}P_t)\), so every term has a current-block factor. For the drift, write \(V=H_{t-1}+P_{t,k}\), \(W=P_t-P_{t,k}\). Then \(H_t=V+W\) and the derivative difference is exactly
\[
q'_s(H_t)-q'_s(V)
=-2\operatorname{Re}\bigl[Q(\mathsf A T_sV,T_sW)
+Q(\mathsf A T_sW,T_sV)
+Q(\mathsf A T_sW,T_sW)\bigr]. \tag{11}
\]
All pairs in (11) have a current suffix \(W\), including when \(V\) starts at fixed \(A-1\). The full block clock interval has length \(s_{b_t}-s_{Y-1}=O_c(1)\). Equations (9)--(11) therefore upgrade the former PNT-scale bound to
\[
\boxed{\displaystyle
|\mathscr D_t|
\ll_{A,c,\kappa}
\frac{Y\Delta_Y^2}{\log Y}
e^{-\kappa\sqrt{\log Y\log\log Y}},
\quad 0<\kappa<\nu\sqrt{\theta c},\quad 0<\theta<1.} \tag{12}
\]
The drift alone has the sharper factor \((\log\log Y)/\log Y\) relative to the baseline, exactly as in the original formula (8), with the same heavy-age ground gain. Since \(\theta\) may be chosen arbitrarily close to one, any fixed \(\kappa<\nu\sqrt c\) is admissible after fixing \(\theta\in((\kappa/(\nu\sqrt c))^2,1)\) and \(r\in(\theta/2,1/2)\). In particular (12) implies an arbitrary fixed root-\(\log Y\) ground improvement. The parameter choices and constants are fixed before \(Y\to\infty\); no growing-parameter optimization is asserted.

The terminal sum of the **absolute** block bounds still does not converge. For dyadic \(Y=2^jA\), its envelope is
\[
\frac{Y\Delta_Y^2}{\log Y}
e^{-\kappa\sqrt{\log Y\log\log Y}}
=\frac{Y}{\log Y}
\exp\{-2a\sqrt{\log Y}-\kappa\sqrt{\log Y\log\log Y}+O(1)\}
=Y^{1-o(1)}. \tag{13}
\]
Thus the improved estimate remains non-summable over all later blocks and gives no infinite-terminal Cauchy criterion or RH bound. The exact telescope (10) could still contain source-specific cancellation; the positive age law and PNT absolute estimates do not sign it. This note proves only the localized bound with the fixed-prefix age loss explicitly paid.
