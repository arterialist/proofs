# A super-root-log gain from quantitative heavy-age escape

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 unconditional refinement, 2026-09-16. This sharpens the equal-clock estimate in [factorial-f-ground-equal-clock-rank-one.md](factorial-f-ground-equal-clock-rank-one.md), still far from RH. Fix \(c>0\), let \(s=c\log X\), \(B_X=g_{2X}-g_{X-1}\), and retain the full actual finite-activity jump law \(\mathsf P_s\), original physical \(L^2(dx)\), actual \(F\), and every prime power. Write \(\Delta_X\) for the usual PNT envelope of \(|E(x)|/x\) on \([X-1,\infty)\).

The complete age Laplace exponent obeys \(\Phi(q)=2q\log(1/q)+O(q)\) as \(q\downarrow0\). Choose fixed \(0<a<1\) and \(a/2<r<1/2\), then put \(q=s^{-r}\) and \(L=a s\log s\). Chernoff gives, for any fixed constant \(K\),
\[
\mathsf P_s(S_s\le L+K)
\le \exp\{q(L+K)-s\Phi(q)\}
\le \exp\{-(2r-a+o(1))s^{1-r}\log s\}. \tag{1}
\]
Because \(1-r>1/2\), this probability decays faster than \(\exp[-D\sqrt{s\log s}]\) for every fixed \(D\). For a physical input supported on \([X-1,\infty)\), the causal convolution/Minkowski bound up to \(R=Xe^L\) uses only ages at most \(L+1\). Consequently
\[
\|1_{x\le R}T_sB_X\|_2
\le\mathsf P_s(S_s\le L+1)\|B_X\|_2,
\quad \|B_X\|_2^2\ll X\Delta_X^2. \tag{2}
\]
On \(x\ge R\), the genuine ground coefficient has
\[
\sup_{x\ge R}|b_F(x)|\ll
\exp[-\nu\sqrt{\log X+a s\log s}]
\le\exp[-\kappa\sqrt{\log X\log\log X}] \tag{3}
\]
for any fixed \(0<\kappa<\nu\sqrt{ac}\) and sufficiently large \(X\). Use the established \(\|T_sB_X\|_2^2\ll_c X\Delta_X^2/s\). Equations (1)–(3) split the actual cubic \(4\int E|T_sB_X|^2/(xF)\) into an early term negligible against the late term, proving
\[
\boxed{|\mathfrak C_X|\ll_{c,\kappa}
\frac{X\Delta_X^2}{\log X}
\exp[-\kappa\sqrt{\log X\log\log X}]}\quad
(0<\kappa<\nu\sqrt c). \tag{4}
\]
For a requested \(\kappa<\nu\sqrt c\), choose \(a<1\) sufficiently near 1, then \(r\in(a/2,1/2)\); constants and the threshold depend on these fixed choices. Applying the same early/late split to \(HB_X\), whose causal support is also \([X-1,\infty)\), yields the corresponding weighted bound on \(b_FH T_sB_X\). The exact Picone identity and \(\|T_sB_X\|_2^2\ll X\Delta_X^2/s\) therefore extend (4), with a possibly smaller positive \(\kappa\), to \(|Q(T_sB_X,T_sB_X)|\). No sign, infinite-terminal limit, or RH-scale estimate follows; the upper bound remains \(X^{1-o(1)}\).
