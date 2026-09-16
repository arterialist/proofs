# Pole-null density and first-prime indefiniteness in the odd Weil form

Independently reviewed written proof, 2026-09-17. These are source-specific no-go results for using the polar moment constraint or a fixed sign of the arithmetic remainder as an all-scale coercivity mechanism. They keep Suzuki's actual complete von Mangoldt prime-power shifts, the continuum density, the archimedean form and both odd-reflection and direct-shift histories. They do not prove positivity or RH; Lean formalization remains open.

Write Suzuki's odd form on $(0,a)$ as
\[
\mathcal W_a[u]=\mathcal A_a[u]+K_a[u]-\mathcal R_a[u],
\quad K_a=G_a-2|h_a\rangle\langle h_a|,
\quad h_a(x)=\sqrt2\sinh(x/2),
\quad dE(X)=d\psi(X)-dX.
\tag{1}
\]
Here $\mathcal R_a=\int_{[1,e^{2a})}X^{-1/2}T_{\log X,a}\,dE(X)$ uses the exact odd shift/reflection operator, including every prime power. The [continuum-polar decomposition](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md) proves $0\le K_a\le4I$. The full odd pole-null condition is $\langle h_a,u\rangle=0$; for an odd test on $(-a,a)$ this kills both exponential pole moments.
Explicitly, after zero-extending $u$ outside $(0,a)$, the operator is
\[
(T_{\ell,a}u)(x)
=u(x+\ell)+\mathbf1_{x>\ell}u(x-\ell)
-\mathbf1_{0<\ell-x<a}u(\ell-x),\qquad 0<x<a.
\tag{1a}
\]
The first term vanishes automatically when $x+\ell\ge a$. This formula keeps the direct same-side histories and the negative odd reflection in every correlation below.

**Theorem (asymptotic pole-null density in the actual form).** Fix any $f\in C_c^\infty(0,\infty)$. There are $u_a\in C_c^\infty(0,a)$ for all sufficiently large $a$ such that
\[
\langle h_a,u_a\rangle=0,
\qquad \|u_a-f\|_2\longrightarrow0,
\qquad \mathcal W_a[u_a]-\mathcal W_a[f]\longrightarrow0.
\tag{2}
\]
The form $\mathcal W_a[f]$ is independent of $a$ once the window contains the fixed support of $f$. With the classical PNT error, the two convergences in (2) have bounds $O(e^{-a/2})$ in $L^2$ and $O(e^{-c\sqrt a})$ in form value for some $c>0$ depending only on the fixed shapes. Thus positivity on the pole-null odd subspace for every sufficiently large window would imply positivity on *every* compact odd test. Pole-nullity alone does not reduce the all-scale odd positivity problem.

To prove this, fix a nonnegative nonzero $\eta\in C_c^\infty(1,2)$ and put $\eta_a(x)=\eta(a-x)$. For $a$ larger than the support of $f$ plus $3$, define
\[
c_a=\frac{\langle h_a,f\rangle}{\langle h_a,\eta_a\rangle},
\qquad u_a=f-c_a\eta_a.
\tag{3}
\]
The denominator is positive and, by changing variables $s=a-x$,
\[
\langle h_a,\eta_a\rangle
=\frac{e^{a/2}}{\sqrt2}\int_1^2e^{-s/2}\eta(s)ds
+O(e^{-a/2}).
\]
Hence $c_a=O_f(e^{-a/2})$, (3) is exactly pole-null, and $\|u_a-f\|_2=O_f(e^{-a/2})$. The archimedean form of $\eta_a$ is uniformly bounded: its sine transform is a linear combination of the fixed Schwartz sine and cosine transforms of $\eta$, with coefficients $\sin(at)$ and $\cos(at)$. The same is true for its mixed form with fixed $f$ by Cauchy--Schwarz in the absolute multiplier $|\Re\psi(1/4+it/2)-\log\pi|$. Since $K_a\le4I$, the archimedean plus $K_a$ change is $O_f(e^{-a/2})$.

It remains to check the **actual** prime discrepancy; its operator norm is too large for a norm-only argument. For a smooth compactly supported function $k_a(\ell)$ whose support lies in $[\kappa a-B,\kappa a+B]$, $\kappa\in\{1,2\}$, and whose $W^{1,1}$ norm is bounded independently of $a$, the complete Chebyshev error $E(X)=\psi(X)-(X-1)$ satisfies
\[
\begin{aligned}
\int e^{-\ell/2}k_a(\ell)\,dE(e^\ell)
&=-\int E(e^\ell)e^{-\ell/2}
  \bigl(k_a'(\ell)-\tfrac12k_a(\ell)\bigr)d\ell\\
&=O_{k,B}\!\left(e^{\kappa a/2-c_0\sqrt a}\right).
\end{aligned}\tag{4}
\]
There is no endpoint term because $k_a$ vanishes at the ends of its compact support. The second line follows from the classical unconditional prime-number-theorem error $E(X)\ll X e^{-c\sqrt{\log X}}$ for some $c>0$; it also includes all proper prime powers. The constants are uniform for translated copies of any fixed smooth shape.

Use odd extensions to write $\langle v,T_{\ell,a}w\rangle$ as a sum of ordinary shift correlations. For the separated fixed $f$ and remote $\eta_a$, this correlation is a smooth translated shape supported where $\ell=a+O_f(1)$; (4) with $\kappa=1$ gives
\[
\langle f,\mathcal R_a\eta_a\rangle
=O_f(e^{a/2-c_0\sqrt a}). \tag{5}
\]
For $\eta_a$ paired with itself, same-side shifts have $\ell=O(1)$ and contribute $O_\eta(1)$, while opposite-side odd reflections have $\ell=2a+O_\eta(1)$ and by (4) with $\kappa=2$ contribute $O_\eta(e^{a-c_0\sqrt a})$. Consequently
\[
\mathcal R_a[\eta_a]=O_\eta(1+e^{a-c_0\sqrt a}),
\quad
|c_a\langle f,\mathcal R_a\eta_a\rangle|
+|c_a|^2|\mathcal R_a[\eta_a]|
=O_f(e^{-c_0\sqrt a}). \tag{6}
\]
Polarization of $\mathcal R_a[f-c_a\eta_a]$, together with the archimedean/$K_a$ estimate, proves (2). Notice the scope: the remote bump is cheap in the **complete actual form only after** the prime sum is paired with its continuum density and the PNT error is used. A bound on the prime-shift operator alone would lose an $e^{a/2}$ factor in (5) and would not prove the theorem.

The correction $J_af=f-c_a(f)\eta_a$ is linear. On any fixed finite-dimensional space of compact smooth tests, the estimates above are uniform on its unit sphere. Polarization therefore gives convergence of the entire pulled-back Gram matrix, $\mathcal W_a(J_af,J_ag)\to\mathcal W(f,g)$, for every pair in that space. In particular, any fixed finite collection of negative odd-form directions survives on exactly pole-null tests in sufficiently large windows.

**Corollary (both signs of the exact remainder on fixed pole-null tests).** There are real, exactly pole-null $u^+,u^-\in C_c^\infty(0,\infty)$, supported in one fixed compact interval, such that for every sufficiently large $a$,
\[
\mathcal R_a[u^+]>0,\qquad \mathcal R_a[u^-]<0.
\tag{7}
\]
For a direct construction, write $h(x)=\sqrt2\sinh(x/2)$, let $L=\log2$, choose $b>0$ such that none of $2b,2b+L,2b+2L$ is $\log n$ for an integer $n\ge2$, and fix nonnegative even $\eta\in C_c^\infty(-1,1)$ with $\|\eta\|_2=1$. Use the real unit-$L^2$ bumps $q_{\delta,x}(y)=\delta^{-1/2}\eta((y-x)/\delta)$. Choose a third fixed center $c>b+L$ generically so that all new pairwise differences and sums among $b,b+L,c$ also avoid $\log n$, $n\ge2$. The sole permitted prime-power overlap is then the direct $n=2$ shift between the first two centers. Set
\[
d_{\delta,s}=-\frac{\langle h,q_{\delta,b}+s q_{\delta,b+L}\rangle}
{\langle h,q_{\delta,c}\rangle},\qquad
u_{\delta,s}=q_{\delta,b}+s q_{\delta,b+L}+d_{\delta,s}q_{\delta,c},
\quad s\in\{+1,-1\}.
\]
The denominator is positive, $d_{\delta,s}=O_{b,c}(1)$ as $\delta\downarrow0$, and $\langle h,u_{\delta,s}\rangle=0$ exactly. For sufficiently small $\delta$, all reflected and all other direct prime-power shifts miss the three narrow supports. The $n=2$ contribution is exactly $2s\Lambda(2)/\sqrt2$. The continuum prime square satisfies $G[u_{\delta,s}]=O_{b,c}(\delta)$, since its kernel is bounded on the fixed compact support and $\|u_{\delta,s}\|_1=O(\sqrt\delta)$. Since $\mathcal R=P_{\rm prime}-P_{\rm cont}=P_{\rm prime}+G$,
\[
\mathcal R[u_{\delta,s}]
=2s\frac{\log2}{\sqrt2}+O_{b,c}(\delta).
\tag{8}
\]
Fix $\delta$ small enough to make the two signs strict, and take $u^\pm=u_{\delta,\pm1}$. Their support and remainder values are unchanged when $a$ grows past the fixed support. Thus neither $\mathcal R_a\ge0$ nor $\mathcal R_a\le0$ holds on the pole-null subspace at all large windows; a full-form estimate must retain the archimedean and Green terms.

There is a **sharp first-prime threshold** for this indefiniteness. If $a\le L/2$, no prime-power shift has positive overlap on $(-a,a)$, so $P_a^{\rm odd}=0$ and $\mathcal R_a=G_a\ge0$. For every fixed $a>L/2$ and every $m$ real linear functionals on $C_c^\infty(0,a;\mathbb R)$, however, $\mathcal R_a$ takes both signs on their common kernel. To prove it, take $k=m+1$ distinct points $x_j$ in $(L/2-\varepsilon,L/2)$ and set $y_j=L-x_j$, where $\varepsilon>0$ is small enough that every center lies in $(0,a)$, every difference between centers is less than $L$, and every sum lies strictly below $\log3$. Use sufficiently narrow, disjoint unit-$L^2$ bumps with the same even shape at these $2k$ centers. The only prime-power overlap is the *reflected* $n=2$ shift, pairing $x_j$ with $y_j$; distinctness ensures no cross-pair sum equals $L$. By the minus sign in (1a), the prime operator has exactly $k$ blocks
\[
\begin{pmatrix}0&-w_2\\-w_2&0\end{pmatrix},
\qquad w_2=\frac{\log2}{\sqrt2},
\]
and no other entries. The continuum Green form has matrix norm $O_k(\delta)$, uniformly in $a$: all centers stay in a fixed compact neighborhood of $L/2$, its kernel has a common bound $M$, and disjointness gives $\|u\|_1^2\le 2k\delta\|\eta\|_1^2\|u\|_2^2$ for a coefficient vector $u$ in this span. Thus $0\le G_a[u]\le2kM\delta\|\eta\|_1^2\|u\|_2^2$. Choose $\delta$ so that this bound is below $w_2\|u\|_2^2/2$. On the prime matrix's positive and negative eigenspaces, respectively, the exact remainder then obeys
\[
\mathcal R_a[u_+]\ge w_2\|u_+\|_2^2,
\qquad \mathcal R_a[u_-]\le-\tfrac12w_2\|u_-\|_2^2.
\tag{9}
\]
Each eigenspace has dimension $k$, so its intersection with the common kernel of the $m$ functionals has dimension at least $k-m=1$. Since $k$ is arbitrary, both sign indices are infinite, even after *any* finite set of real linear test constraints at **each** $a>L/2$. Complex linear constraints can be treated as twice as many real conditions. This is a uniform-magnitude signed estimate for $\mathcal R$, not the full Weil form: the archimedean cost of unit narrow bumps grows like $\log(1/\delta)$ and can pay the fixed prime overlap.

The normalizations of the odd form and prime shifts come from [Suzuki, *Weil's quadratic form via the screw function*, §2.4](https://arxiv.org/html/2606.09096v2). For an explicit source of the unconditional input $|\psi(X)-X|\ll Xe^{-c\sqrt{\log X}}$, see [Fiori--Kadiri--Swidinsky, *Sharper bounds for the Chebyshev function $\psi(x)$*](https://arxiv.org/abs/2204.02588). [Connes--Consani, Appendix C, Proposition C.1](https://alainconnes.org/wp-content/uploads/Selecta.pdf) already proves a broader Weil-criterion fact: finitely many Mellin vanishing conditions, including the poles, do not change RH equivalence. The density result here is a quantitative analogue for Suzuki's expanding **odd operator form**, using the actual prime-minus-continuum correlations. It is not a priority claim or an estimate for the sign of the full Weil form.
