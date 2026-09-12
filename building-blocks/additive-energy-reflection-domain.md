# Reciprocal reflection, its energy domain, and the two physical ports

Write $c=e^s>0$. The additive energy is
$$
\|f\|_E^2=\int_0^1\|\tau_hf-f\|_2^2\,dh+
\int_1^\infty\|\tau_hf-f\|_2^2\,\frac{dh}{h^2}
=\langle f,Mf\rangle_2,
$$
where $M=m(D)$, $m(\xi)\asymp\min(|\xi|,1)$,
$m(\xi)\sim\pi|\xi|$ at zero, and $m(\xi)\to4$ at infinity. All additive physical histories are zero on the negative half-line. Let $E_+$ be the closure of $C_c^\infty(0,\infty)$ in this norm. The smaller causal space uses support in $[1,\infty)$.

## The exact change of variables

The unitary map from additive to logarithmic $L^2$ is
$$
(Cf)(v)=e^{v/2}f(e^v).
$$
Consequently
$$
\boxed{(\mathcal R_cf)(x)=\frac{\sqrt c}{x}f(c/x),\quad x>0,
\qquad C\mathcal R_c=R_sC.}
\tag{1}
$$
It is zero on negative $x$. The substitution $y=c/x$ proves that $\mathcal R_c$ is a selfadjoint unitary involution on $L^2(0,\infty)$. For real histories,
$$
(Cf*Ch)(s)=\sqrt c\int_0^\infty f(x)h(c/x)\,\frac{dx}{x}
=\langle f,\mathcal R_ch\rangle_2.
\tag{2}
$$
No modulus square replaces this bilinear convolution.

## Reflection is unbounded in the additive energy

Choose nonzero $f\in C_c^\infty(1,2)$, and let
$D_af(x)=\sqrt a f(ax)$. For $a\downarrow0$,
$$
\|D_af\|_E^2\sim\pi a\int|\xi|\,|\widehat f(\xi)|^2d\xi.
$$
This follows by dominated convergence, using $m(a\xi)/a\le C|\xi|$. But
$\mathcal R_cD_a=D_{1/a}\mathcal R_c$, so another dominated-convergence argument gives
$$
\|\mathcal R_cD_af\|_E^2\longrightarrow4\|f\|_2^2>0.
\tag{3}
$$
Every input in this sequence is causal for small $a$. Thus full reflection has no bounded extension from even the causal energy space into $E_+$.

For completeness, energy convergence of positive-support histories implies local $L^2$ convergence. On the smooth core, split the Fourier transform at $|\xi|=1$. The high part has $L^2$ norm at most $C\|f\|_E$. Write the low part as $A_f+b_f(x)$, where
$$
b_f(x)=(2\pi)^{-1/2}\int_{|\xi|\le1}(e^{ix\xi}-1)\widehat f(\xi)d\xi.
$$
Weighted Cauchy gives $|b_f(x)|\le C|x|\|f\|_E$, since
$\int_{|\xi|\le1}\xi^2/m(\xi)d\xi<\infty$. On the fixed anchor interval $[-2,-1]$, $f=0$, so $|A_f|\le C\|f\|_E$. Hence
$$
\|f\|_{L^2(-R,R)}\le C_R\|f\|_E.
\tag{4}
$$
Completion proves the assertion without choosing an uncontrolled additive constant.

The actual source
$g(x)=1_{x\ge1}(\psi(x)/x-1)$ belongs to this anchored energy completion, but
$$
\boxed{\mathcal R_cg\notin E_+.}\tag{5}
$$
Here (5) means nonmembership in the **anchored positive-support energy space** defined above. The conclusion uses its local $L^2$ realization (4), rather than a tacit identification with the full energy completion modulo constants.
Indeed, $g\notin L^2$ unconditionally. To see the latter, suppose
$a(v)=e^{v/2}g(e^v)\in L^2(0,\infty)$. Its Laplace transform is holomorphic for $\Re z>0$, with
$$
|F_a(\epsilon+i\gamma)|\le\|a\|_2/(2\epsilon)^{1/2}.
$$
Initially for $\Re z>1/2$, the exact arithmetic identity is
$$
F_a(z)=-\frac{\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)}-\frac1{z-1/2}.
\tag{6}
$$
Meromorphic uniqueness extends this identity to $\Re z>0$; the apparent pole at $z=1/2$ cancels. The holomorphic left side excludes any poles arising from zeros to the right of the critical line. At any known critical-line zero $\rho=1/2+i\gamma$, of finite multiplicity $m_\rho\ge1$, the same identity along $z=\epsilon+i\gamma$ gives
$$
F_a(\epsilon+i\gamma)=-\frac{m_\rho}{\rho\epsilon}+O(1),
$$
contradicting the $L^2$ bound. The sole zero-existence input is supplied, for example, by [Platt–Trudgian, *The Riemann hypothesis is true up to $3\cdot10^{12}$*, Theorem 1, p. 2](https://arxiv.org/pdf/2004.09765): their rigorous interval-arithmetic computation places the lowest 12,363,153,437,138 nontrivial zeros on the critical line. This proof uses only the existence of one such zero, not that count or any simplicity assertion; RH is not assumed. Finally,
$$
\int_0^\epsilon|\mathcal R_cg(x)|^2dx
=\int_{c/\epsilon}^\infty|g(y)|^2dy=\infty.
$$
This contradicts (4) if $\mathcal R_cg$ were in $E_+$.

Causal compression has a different domain. For $c\ge1$ and $P=1_{[1,\infty)}$,
$B_c=P\mathcal R_cP$ only reads and outputs $[1,c]$. Therefore
$$
\|B_cf\|_E\le\sqrt8\|B_cf\|_2
\le\sqrt8\|f\|_{L^2(1,c)}\le C_c\|f\|_E.
\tag{7}
$$
The constants here depend on the fixed observation window. This does not extend full reflection to the actual untruncated source.

## The metric changes the neutral boundary

There is an exact physical kernel for the energy metric:
$$
\boxed{M=4I-\kappa*,\qquad
\kappa(h)=\begin{cases}1,&|h|\le1,\\ |h|^{-2},&|h|>1.\end{cases}}
\tag{8}
$$
This follows by expanding the two increment squares; $\int\kappa=4$. In particular, if real nonnegative $u,v\in L^2$ have disjoint supports and are nonzero, then
$$
\langle u,v\rangle_E=-\iint\kappa(x-y)u(x)v(y)dxdy<0.
\tag{9}
$$
For $c>1$, take a nonnegative nonzero smooth $f$ inside $(1,c)$, and such an $h$ supported after $c$. Then $B_ch=0$, whereas
$\langle B_cf,h\rangle_E<0$. Thus the bounded causal reflection (7) is **not selfadjoint in the energy metric**.

Likewise, a nonnegative nonzero smooth boundary history $b$ supported in $(0,1)$ has $\mathcal R_cb$ supported after $c$, for $c\ge1$. Its old physical pairing is zero, but
$$
\langle b,\mathcal R_cb\rangle_E
=-\iint\kappa(x-y)b(x)\mathcal R_cb(y)dxdy<0.
\tag{10}
$$
The boundary is neutral for the physical reflection form, not for its replacement by an energy inner product. Formula (10) exhibits the additional metric coupling, with its sign, rather than assuming it vanishes.

## The boundary energy gives explicit local and readout bounds

There is a stronger, direct version of the anchored local estimate (4). For every positive-support $L^2$ function, expansion of the increment squares and Tonelli give
$$
\begin{split}
\|f\|_E^2
&=\frac12\iint_{\mathbb R^2}\kappa(x-y)|f(x)-f(y)|^2dxdy\\
&=\frac12\iint_{(0,\infty)^2}\kappa(x-y)|f(x)-f(y)|^2dxdy
+\int_0^\infty w(x)|f(x)|^2dx,
\end{split}\tag{15}
$$
where the two cross-half-line regions together contribute exactly one copy of the last integral, and
$$
w(x)=\int_{-\infty}^0\kappa(x-y)dy
=\int_x^\infty\kappa(s)ds
=\begin{cases}2-x,&0<x\le1,\\1/x,&x\ge1.\end{cases}
\tag{16}
$$
In particular,
$$
\boxed{\int_0^\infty w(x)|f(x)|^2dx\le\|f\|_E^2,
\qquad \|f\|_{L^2(0,C)}\le\sqrt{\max(1,C)}\,\|f\|_E.}
\tag{17}
$$
These inequalities extend to $E_+$: an energy-Cauchy sequence is Cauchy in $L^2(w\,dx)$, so it has a unique weighted and local $L^2$ limit. For completeness, the positive-positive difference map in (15) is also Cauchy in its weighted $L^2$ space. A subsequence converging almost everywhere identifies that limit with $f(x)-f(y)$; hence the exact identity (15), and not just its lower bound, holds for the completed representative. This fixes the additive constant without an extra normalization choice.

On the causal subspace, (17) gives the global bound
$$
\|f\|_{L^2([1,\infty),dx/x)}\le\|f\|_E.
\tag{18}
$$
For two such histories and $c\ge1$, weighted Cauchy and the substitution $y=c/x$ now give
$$
\begin{split}
\left|\sqrt c\int_1^c\overline{f(x)}h(c/x)\frac{dx}{x}\right|
&\le\sqrt c\,\|f\|_{L^2([1,c],dx/x)}\|h\|_{L^2([1,c],dx/x)}\\
&\le\boxed{\sqrt c\,\|f\|_E\|h\|_E.}
\end{split}\tag{19}
$$
This defines the fixed-time physical pairing on the causal completion even when the full reflected function lies outside $E_+$. It is still the old pairing with its Jacobian, not the energy inner product. Also (7) can now use the explicit operator bound $\|P\mathcal R_cP\|_{E_+\to E_+}\le\sqrt{8c}$ on the causal subspace. Neither estimate claims uniform control as $c\to\infty$.

## Both ports survive the coordinate change

For a finite cutoff, write its actual logarithmic history as $f_T=Cg_T$. Keep the full fixed two-prime transport $U=U_2U_3$, and set
$$
\widetilde U=C^{-1}UC,\quad p=\widetilde Ug_T,\quad
q=\widetilde U^{-1}g_T,\quad
Z=\widetilde D^{-1}g_T,
$$
where
$$
\widetilde D=\prod_{p_0=2,3}(I-p_0^{-1}E_{1/p_0}),
\quad E_af(x)=f(ax),\quad
\widetilde U=\prod_{p_0=2,3}(I-E_{p_0})(I-p_0^{-1}E_{1/p_0})^{-1}.
$$
These formulas retain the entire geometric resolvents. They are old $L^2(dx)$ identities, not assertions of operator-norm convergence on all of $E$.

Let $\eta=(I-P)p$. The second compact source, on $1/6<x<1$, is exactly
$$
\beta_-(x)=1_{x>1/2}q(2x)+1_{x>1/3}q(3x)-q(6x),
\tag{11}
$$
and is zero outside this interval. Also $\eta$ is supported there. The cutoff input, inverse transport, and delay resolvent are those in the [two-prime unilateral identity](two-prime-unilateral-boundary.md); no freely chosen source is introduced. The square-root prime weights have canceled against the Jacobian factors in (11), not been omitted.

For every $c=e^s\ge1$, the complete physical identity is
$$
\begin{split}
\sqrt c\int_1^c g_T(x)g_T(c/x)\frac{dx}{x}
={}&\sqrt c\int_1^c p(x)q(c/x)\frac{dx}{x}\\
&+\boxed{\sqrt c\int_{1/6}^1
[\eta(x)q(c/x)+\beta_-(x)Z(c/x)]\frac{dx}{x}.}
\end{split}\tag{12}
$$
All integrals are justified by the finite-history $L^2$ identities and Cauchy--Schwarz. The boundary reads interior values on $[c,6c]$, and so remains meaningful under local $L^2$ convergence on these fixed windows. No claim that $\mathcal R_cg$ lies in $E$ is needed for such a localized readout.

The harmonic sum and causal filter can be applied to (12), using exactly the same coefficients, time endpoints, and literal same-prime subtraction as in the [complete harmonic identity](harmonic-convolution.md). For each finite observation time all reciprocal windows are bounded. This retains both ports and the complete signed observable. It does not provide a norm uniform in the observation time or a sign from $E$-positivity.

On finite $L^2$ histories the exact transported conservation remains
$$
\widetilde V^*\mathcal J_c\widetilde V=\mathcal J_c,
\qquad \widetilde V=\operatorname{diag}(\widetilde U,\widetilde U^{-1}),
\quad \mathcal J_c=\begin{pmatrix}0&\mathcal R_c\\\mathcal R_c&0\end{pmatrix},
$$
where the adjoint and form are those of $L^2(dx)$. Indeed, reciprocal reflection interchanges $D_p$ and $D_{1/p}$, so $\mathcal R_c\widetilde U=\widetilde U^{-1}\mathcal R_c$; moving the old unitary transport across the pairing gives the displayed equality. If represented through the energy pairing, the metric inverse must be retained: on domains where it exists,
$\langle F,\mathcal J_cH\rangle_2=\langle F,M_2^{-1}\mathcal J_cH\rangle_E$.
The inverse metric is unbounded at additive frequency zero. Its domain cannot be silently enlarged to include the actual full reflection (5); fixed-window dual corrections are a separate way to define the retained physical pairing.

More explicitly, the energy representation has the form domain
$$
\mathcal D_c=\left\{H\in L^2(0,\infty)^2:
\int_{\mathbb R}\frac{|\widehat{\mathcal J_cH}(\xi)|^2}{m(\xi)}d\xi<\infty\right\},
\tag{13}
$$
where transforms use zero extension, the vector norm includes both components, and the inverse-metric image is taken in the full energy completion. For $F\in L^2(0,\infty)^2$ and
$H\in\mathcal D_c\cap\widetilde V^{-1}\mathcal D_c$, the exact transported-metric conservation is
$$
\boxed{\langle\widetilde VF,M_2^{-1}\mathcal J_c\widetilde VH\rangle_E
=\langle F,M_2^{-1}\mathcal J_cH\rangle_E.}
\tag{14}
$$
Each side equals the corresponding old $L^2$ pairing, so (14) follows directly from the full two-port conservation. Neither invariance of $\mathcal D_c$ under $\widetilde V$ nor boundedness of the displayed inverse-metric operator is assumed. For a smooth compact component $h$, condition (13) is precisely the zero additive mean of $\mathcal R_ch$, namely
$\sqrt c\int_0^\infty h(y)dy/y=0$. This illustrates the domain restriction without asserting it for the actual source.

All domain, transport and readout assertions in this note are written mathematics. They make no Lean or arithmetic-sign claim.
