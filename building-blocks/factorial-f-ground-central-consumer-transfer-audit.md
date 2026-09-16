# Original-metric F-ground-to-central-consumer transfer audit

RH Agent3, 2026-09-16. **Status:** exact finite formulas and a coercivity obstruction, independently audited by RH Agent1. No RH claim and no exclusion of a future arithmetic-specific theorem. This is written analysis, not a Lean formalization.

## Literal sources, forms, and boundaries

Let \(E(x)=\psi(x)-x\), including every prime power at its right endpoint, and
\[
f_N(x)=g_N^\Lambda(x)=\frac{E(\min(x,N))}{x},\quad
Hf(x)=\frac1x\int_1^xf(y)\,dy,\quad
F(x)=\log x-\sum_{m\le x}\frac{\Lambda(m)}m+\frac{\psi(x)}x.
\]
Here \(f_1=-1/x\). Every finite \(f_N\) lies in physical \(L^2((1,\infty),dx)\), and \(h_N=Hf_N\) belongs to the closed form domain \(\mathcal D=\{h\in L^2:h\in AC_{\rm loc},xh'\in L^2,h(1+)=0\}\). For \(N\ge2\), \(h_N/F\to-1\) at one. With \(J_N=\int_1^Nf_N\), its exact frozen tail is
\[
f_N(x)=E(N)/x,\qquad h_N(x)=\{J_N+E(N)\log(x/N)\}/x\quad(x\ge N). \tag{1}
\]
The observing prime sum extends beyond \(N\); its \(m>N\) tail is
\(\sum_{m>N}\Lambda(m)|J_N+E(N)\log(m/N)|^2/(m^2F(m))\), finite but not zero in general.

The original factorial ground identity, on this domain in physical \(dx\), is
\[
\|R_Ff\|_2^2=\|f\|_2^2+B_C(f)-B_P(f),\quad
R_F=I-H-b_FH,\quad b_F=xF'/F=-E/(xF), \tag{2}
\]
\[
B_C(f)=\int_1^\infty\frac{|Hf(x)|^2}{F(x)}dx,\qquad
B_P(f)=\sum_{m\ge2}\frac{\Lambda(m)|Hf(m)|^2}{F(m)}. \tag{3}
\]
Each term is separately finite. The **positive square** is coercive:
\(6000^{-2}\|f\|_2^2\le\|R_Ff\|_2^2\le57\|f\|_2^2\). The studied **signed** form is instead
\[
Q(f)=B_P(f)-B_C(f)=\|f\|_2^2-\|R_Ff\|_2^2
=2\Re\langle(I-H)f,b_FHf\rangle-\|b_FHf\|_2^2. \tag{4}
\]
For \(v_n=f_n-f_{n-1}\), \(s_n=c\log n\), and \(A\ge3\), the finite true-later-clock matrix satisfies
\[
\mathscr C_{A,N}=\sum_{i,j=A}^N
Q(T_{s_{\max(i,j)}}v_i,T_{s_{\max(i,j)}}v_j)
=Q(T_{s_N}(f_N-f_{A-1}))
-\sum_{k=A-1}^{N-1}\int_{s_k}^{s_{k+1}}
\frac d{ds}Q(T_s(f_k-f_{A-1}))\,ds. \tag{5}
\]
The fixed prefix subtraction, terminal evolution, and signed clock drift prevent a bound on \(\mathscr C_{A,N}\) alone from bounding even \(Q(f_N)\). Neither (4) nor (5) bounds the positive terms \(\|f_N\|^2\) or \(\|R_Ff_N\|^2\).

The physical error energy has the exact boundary split
\[
\|f_N\|_2^2=\int_1^N\frac{E(x)^2}{x^2}dx+\frac{E(N)^2}{N}. \tag{6}
\]
Thus \(\|f_N\|_2^2\ll_\epsilon N^\epsilon\) for every \(\epsilon>0\) is RH-equivalent: the terminal charge yields \(E(N)\ll_\epsilon N^{1/2+\epsilon}\), and RH gives the converse by the classical Chebyshev estimate. A **positive** bound \(\|R_Ff_N\|_2^2\ll_\epsilon N^\epsilon\) would imply RH by coercivity. A small signed \(Q(f_N)\) does not give it.

The factorial/Möbius source lives in a different original clock Hilbert space \(L^2((0,\infty),w(t)dt)\), where \(w(t)=t^{-2}-[t(e^t-1)]^{-1}\). Its exact horizon coefficient and positive energy are
\[
G_N(t)=(1-e^{-t})\sum_{k\ge1}e^{-(k-1)t}M(\lfloor N/k\rfloor),
\qquad Q_N^\mu=\int_0^\infty|G_N(t)|^2w(t)dt. \tag{7}
\]
The generating field satisfies \(H_t(z)/(1-z)=\sum_{N\ge1}G_N(t)z^N\), where \(H_t(z)=(1-e^{-t})\sum_{d\ge1}\mu(d)z^d/(1-e^{-t}z^d)\). With \(r=e^{-1/X}\) and \(\rho=r^2\), exact full-circle Parseval gives
\[
\sum_{N\ge1}\rho^NQ_N^\mu
=\frac1{2\pi}\int_{-\pi}^{\pi}\int_0^\infty
\frac{|H_t(re^{i\theta})|^2w(t)}{|1-re^{i\theta}|^2}\,dt\,d\theta. \tag{8}
\]
The live positive consumer restricts (8) to \(|\theta|<X^{-1/2}\) and \(t>b_\epsilon(\theta)\). Its \(O_\epsilon(X^{2+\epsilon})\) bound is RH-equivalent after the proved outer-angle and low-clock payments. Directly, with \(D_X=\sum_N\rho^NM(N)^2\), the established comparison is \(a_0D_X-CX^2\le R_X^\epsilon\le\sum_{k\ge1}D_{X/k}\). These are positive Möbius squares with literal floor fibers. Equations (1)–(5) contain neither the Möbius source, the \(w(t)dt\) weight, nor the Poisson denominator. The complete Dirichlet series \(\sum\Lambda(n)n^{-z}=-\zeta'/\zeta(z)\) and \(\sum\mu(n)n^{-z}=1/\zeta(z)\) are related by a logarithmic derivative, but this supplies no bounded horizon-preserving form map between (5) and (8).

## Exact failure of generic coercivity for the actual ground

Choose any sufficiently large prime \(p\), \(0<\delta<1/10\), and real smooth bumps \(h_-\in C_c^\infty(p-\delta,p+\delta)\), with \(h_-(p)=1\), and \(h_+\in C_c^\infty(p+2\delta,p+3\delta)\), nonzero. Their supports are disjoint; the second contains no integer. For \(f_\pm=(xh_\pm)'\), the lower endpoint vanishes, so \(Hf_\pm=h_\pm\) exactly. Shrinking \(\delta\) with \(p\) fixed gives
\[
Q(f_-)=\Lambda(p)/F(p)-\int h_-^2/F>0,\qquad
Q(f_+)=-\int h_+^2/F<0. \tag{9}
\]
Their \(Q\)-cross is zero since the Hardy images have disjoint support and no shared prime sample. Therefore \(f=f_-+a f_+\), with \(a^2=Q(f_-)/[-Q(f_+)]\), is nonzero and satisfies \(Q(f)=0\) while \(\|f\|_2>0\). Scaling \(f\) makes both positive physical and Picone-square energies arbitrarily large while keeping the signed form zero. The example uses the **actual** \(F\) and actual all-prime-power observation measure, arbitrarily far right. It is a form-domain counterexample, not an arithmetic counterexample for the fixed \(f_N\).

For any \(f\) supported in \([Y,\infty)\), Hardy causality, \(\|H\|\le2\), and (4) also yield
\[
|Q(f)|\le4\beta_Y(1+\beta_Y)\|f\|_2^2,\qquad
\beta_Y=\operatorname*{ess\,sup}_{x\ge Y}|b_F(x)|\longrightarrow0 \tag{10}
\]
by PNT. Hence no scale-independent lower comparison of \(|Q|\) with the physical norm exists on late sources. The clock-history term in (5) adds another signed quantity; it does not yield a generic coercivity identity.

**Transfer classification.** A new source-specific theorem may still relate the actual \(\Lambda\)-driven \(f_N\) and \(\mu\)-driven \(G_N\), but it must explicitly control the positive Picone/physical norm (including \(E(N)^2/N\)), or directly control \(D_X\) or the central arc, while retaining clock drift and outer/radial reserves. The signed F-ground global-matrix bound alone has no such implication from the present exact identities. Example (9) rules out a universal form inequality, not an arithmetic-only theorem.
