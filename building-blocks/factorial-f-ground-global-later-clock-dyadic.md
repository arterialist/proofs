# Global dyadic assembly of the true later-clock factorial Picone matrix

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 unconditional identity and PNT-scale bound, 2026-09-16. This note assembles the actual later-clock matrix across all dyadic birth blocks, including its first and last endpoints. It yields no infinite-terminal limit and no RH bound. The source is the literal \(v_n=\Lambda(n)\beta_n-\int_{n-1}^n\beta_y\,dy\), with every prime power, density cell, and subsequent observing prime power included. The metric is physical \(L^2(dx)\), and \(Q=B_P-B_C\) uses the actual factorial ground \(F\).

Fix \(c>0\), an integer \(A\ge3\), and \(N\ge A\). Write \(s_n=c\log n\), \(q_s(h)=Q(T_sh,T_sh)\), and \(q'_s(h)=-2\operatorname{Re}Q(\mathsf A T_sh,T_sh)\). Partition the integers \([A,N]\) into contiguous, dyadic-length blocks \(I_t=[a_t,b_t]\cap\mathbb Z\), where \(a_0=A\), \(a_t=2^tA\) for \(t\ge1\), \(b_t=\min(2^{t+1}A-1,N)\), and omit empty blocks. Thus \(a_t-1=b_{t-1}\) for \(t\ge1\). Put
\[
P_t=\sum_{n\in I_t}v_n=g_{b_t}-g_{a_t-1},\quad
H_t=\sum_{r\le t}P_r=g_{b_t}-g_{A-1},\quad H_{-1}=0,
\quad P_{t,k}=\sum_{a_t\le n\le k}v_n,
\]
where \(P_{t,a_t-1}=0\). Let \(\sigma_t=s_{a_t-1}\). The exact true-time matrix is
\[
\mathscr C_{A,N}=\sum_{i,j=A}^N Q(T_{s_{\max(i,j)}}v_i,T_{s_{\max(i,j)}}v_j). \tag{1}
\]
The convention \(s_{A-1}\) is only an integration baseline before the first included birth; it changes no entry in (1).

## Exact block identities

Assign an ordered pair to the block containing its larger index. Its contribution from block \(t\), including earlier--later and within-block pairs, equals
\[
\boxed{\displaystyle
\mathscr D_t=q_{\sigma_t}(H_t)-q_{\sigma_t}(H_{t-1})
+\sum_{k=a_t-1}^{b_t-1}\int_{s_k}^{s_{k+1}}
\{q'_s(H_t)-q'_s(H_{t-1}+P_{t,k})\}\,ds.} \tag{2}
\]
Indeed at the common baseline the form difference contains exactly those pairs whose maximum is in \(I_t\). On \((s_k,s_{k+1})\), the active pairs from that set have at least one index greater than \(k\); their derivative is the displayed difference. At \(k=a_t-1\), the partial current block is zero. At \(k=b_t-1\), only pairs containing \(v_{b_t}\) remain. There is no integral beyond \(s_{b_t}\). Thus \(\mathscr C_{A,N}=\sum_t\mathscr D_t\), exactly.

Expanding the common-time difference in (2) gives the complete block diagonal plus ordered cross terms:
\[
q_{\sigma_t}(H_t)-q_{\sigma_t}(H_{t-1})
=q_{\sigma_t}(P_t)+2Q(T_{\sigma_t}H_{t-1},T_{\sigma_t}P_t). \tag{3}
\]
The \(2\) counts both polarized orders. This is an exact source-specific regrouping of **all** earlier blocks into the literal prefix \(H_{t-1}\), not an estimate on individual far block pairs. The same expansion of the derivative in (2) separates the within-block drift from the cross drift. It does not give either part a sign.

The boundary terms in (2) telescope across contiguous blocks. Since \(\sigma_{t+1}=s_{b_t}\), the \(q'_s(H_t)\) drift cancels the gap between consecutive baselines, leaving the equivalent global endpoint identity
\[
\boxed{\displaystyle
\mathscr C_{A,N}=q_{s_N}(g_N-g_{A-1})
-\sum_{k=A-1}^{N-1}\int_{s_k}^{s_{k+1}}
q'_s(g_k-g_{A-1})\,ds.} \tag{4}
\]
Here \(g_{A-1}-g_{A-1}=0\) makes the \(k=A-1\) integrand vanish. Identity (4) checks every internal endpoint and shows what survives the exact telescope: the derivative of the growing prefix. It is a finite identity only; passing \(N\to\infty\) requires a separate domain and cancellation argument.

## Uniform PNT bounds for the source-specific prefix

Let \(\delta(x)=C e^{-a\sqrt{\log x}}\) be a decreasing zero-free-region PNT envelope for \(|E(y)|/y\), where \(E=\psi-x\). On \(I_t\), let \(Y=a_t\), \(L=\log Y\), \(\Delta_Y=\delta(Y/2)\), and \(\beta_Y=\sup_{x\ge Y-1}|b_F(x)|\). For \(t\ge1\), the literal prefix \(H_{t-1}=g_{Y-1}-g_{A-1}\) has Mellin numerator
\[
\widehat{UH_{t-1}}(\xi)=\frac{1}{1/2+i\xi}
\int_{(A-1,Y-1]}y^{-1/2-i\xi}\,dE(y). \tag{5}
\]
Stieltjes integration by parts, including the fixed lower endpoint, and the fact that \(\sqrt y\delta(y)\) eventually increases, give
\[
\sup_\xi|\widehat{UH_{t-1}}(\xi)|\ll_A\sqrt Y\Delta_Y,
\qquad \|H_{t-1}\|_2^2\ll_A Y\Delta_Y^2. \tag{6}
\]
For the current block \(P_t\) and every current prefix or suffix, the same bounds hold with constants independent of \(t,k\). For the last truncated block this remains valid because its endpoint is at most \(2Y-1\). Thus for \(s\in[s_{Y-1},s_{b_t}]\), the exact compound-Poisson Fourier multiplier and its low-frequency behavior \(\rho(\xi)\asymp|\xi|\), \(|\Phi(i\xi)|\ll |\xi|\log(2/|\xi|)\) imply
\[
\|T_sh\|_2\ll_{A,c}\frac{\sqrt Y\Delta_Y}{\sqrt L},
\qquad
\|\mathsf A T_sh\|_2\ll_{A,c}
\frac{\sqrt Y\Delta_Y\log L}{L^{3/2}}, \tag{7}
\]
for each of these prefixes and suffixes, once \(Y\) is sufficiently large. Finitely many smaller blocks are absorbed into the constants.

For the current-block increment in (2), the common baseline can be estimated without losing the late support: every term in (3) contains \(P_t\), whose support is \([Y-1,\infty)\); every derivative difference in (2) likewise contains either \(P_t-P_{t,k}\) or \(P_t+P_{t,k}\) paired with an earlier/current prefix. Causality keeps this late support after \(T_s\) and \(\mathsf A\). Therefore the Picone factor is \(\beta_Y\), even though \(H_{t-1}\) starts at the fixed \(A-1\). Cauchy--Schwarz, (7), and \(s_{b_t}-s_{Y-1}\le c\log(2Y/(Y-1))\ll_c1\) yield
\[
\boxed{\displaystyle
\mathscr D_t=q_{\sigma_t}(P_t)
+2Q(T_{\sigma_t}H_{t-1},T_{\sigma_t}P_t)
+O_{A,c}\!\left(\beta_Y(1+\beta_Y)
\frac{Y\Delta_Y^2\log L}{L^2}\right),} \tag{8}
\]
\[
|\mathscr D_t|\ll_{A,c}\beta_Y(1+\beta_Y)
\frac{Y\Delta_Y^2}{L}. \tag{9}
\]
The first block uses \(H_{-1}=0\) and has the same estimate with \(Y=A\). Equations (8)--(9) cover the whole true later-clock matrix, not only adjacent blocks; the far block interactions are summed before absolute values via \(H_{t-1}\).

Since the terminal dyadic scale dominates the sum of the positive PNT envelopes, (9) gives, for fixed \(A,c\) and \(N\to\infty\),
\[
\boxed{\displaystyle
|\mathscr C_{A,N}|\ll_{A,c}
1+\frac{N\exp(-d\sqrt{\log N})}{\log N}}
\quad\text{for some }d>0. \tag{10}
\]
This is an unconditional finite-terminal bound. The right side grows like \(N^{1-o(1)}\), so the estimates (6)--(9) provide no Cauchy criterion or improper infinite-terminal pairing. Indeed \(\sum_t Y_t e^{-d\sqrt{\log Y_t}}/\log Y_t=\infty\) for \(Y_t=2^tA\). This only identifies what the current bounds fail to prove; it does **not** claim that the actual signed matrix diverges.

The exact telescope (4) is potentially useful, but (6)--(7) applied to its terminal prefix retain the fixed early support and do not recover a late \(\beta_Y\) for the individual terms. The local regrouping (2)--(3) recovers that factor, while leaving the common-time signed cross \(2Q(T_{\sigma_t}H_{t-1},T_{\sigma_t}P_t)\). A stronger theorem would need a source-specific cancellation of those baseline crosses together with the block diagonals, or a signed control of the derivative of the growing prefix in (4). Neither follows from PNT, the positive clock law, or the current Plancherel estimates. No RH-equivalent input is used here, and (10) does not imply RH.
