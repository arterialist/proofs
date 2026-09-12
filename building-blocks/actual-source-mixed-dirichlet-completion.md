# An additive-clock completion for the actual history

The [actual cutoff-uniform increment theorem](successor-collective-prime-compatibility.md), equations (27)–(32), puts the complete prime-error history in an additive Hilbert space. The proof below gives its exact energy, source-conditioned dilation domain and continuous fixed-window readouts. No bound on the critical unweighted source norm is assumed. These are written proofs, not Lean theorems.

Let
$$
g_T(x)=1_{x\ge1}\chi_T(\log x)\left(\frac{\psi(x)}x-1\right),
\qquad g(x)=1_{x\ge1}\left(\frac{\psi(x)}x-1\right).
$$
Extend these functions by zero to the rest of the real line. The source theorem proves, uniformly over the actual cutoffs,
$$
\|\tau_hg_T-g_T\|_2^2\le
\begin{cases}
Ch,&0<h\le1,\\
Ch\exp(-c\sqrt{\log h}),&h\ge2,
\end{cases}
\tag{1}
$$
with a harmless bounded interpolation for $1<h<2$. For each fixed $h$, these increments converge in $L^2$ to the increment of $g$. The initial jump at $x=1$, all prime powers, and both ends of the cutoff transition are included in this theorem.

## The mixed positive energy

For $f\in L^2(\mathbb R)$, define
$$
\mathcal E(f)=\int_0^1\|\tau_hf-f\|_2^2\,dh
+\int_1^\infty\|\tau_hf-f\|_2^2\frac{dh}{h^2}.
\tag{2}
$$
With the unitary Fourier convention its exact multiplier is
$$
m(\xi)=2\int_0^1(1-\cos(\xi h))\,dh
+2\int_1^\infty\frac{1-\cos(\xi h)}{h^2}\,dh,
\qquad
\mathcal E(f)=\int m(\xi)|\widehat f(\xi)|^2\,d\xi.
\tag{3}
$$
It is positive away from zero and satisfies
$$
m(\xi)\sim\pi|\xi|\quad(\xi\to0),\qquad
m(\xi)\to4\quad(|\xi|\to\infty),
\qquad
m(\xi)\asymp\min(|\xi|,1).
\tag{4}
$$
For the first limit use $\int_0^\infty(1-\cos y)y^{-2}dy=\pi/2$; the removed finite interval contributes only $O(\xi^2)$. The second follows from the Riemann–Lebesgue lemma in the two integrable kernels. Positivity and continuity complete the comparison on compact annuli.

The Hilbert completion for this norm is understood modulo constant distributions. On the causal source class the zero extension pins that freedom. Equation (1) proves
$$
\sup_T\mathcal E(g_T)<\infty,
\qquad
\mathcal E(g_T-g_{T'})\longrightarrow0
\quad(T,T'\to\infty).
\tag{5}
$$
Indeed, use fixed-increment $L^2$ convergence and dominated convergence in (2). At infinity the dominating integral is $\int_2^\infty e^{-c\sqrt{\log h}}dh/h<\infty$. At zero it is $\int_0^1Ch\,dh$. The same jump estimate would make an ordinary $H^{1/2}$ small-increment kernel critical; we do not claim that stronger seminorm.

The limit agrees with the actual locally bounded function $g$. One can check this without choosing a Fourier representative: all cutoffs vanish on a fixed interval below 1, and the positive kernel in (2) controls their $L^2$ difference on any fixed compact interval by its interaction with that anchor interval. Local convergence also follows directly from the specified cutoffs.

## Dilation is an exact source-conditioned consumer

Let $D_af(x)=\sqrt a\,f(ax)$, $a>0$. These are the critical unitary dilations in additive coordinates. Direct change of variable in (2) gives
$$
\mathcal E(D_af)
=\frac1a\int_0^a\|\tau_vf-f\|_2^2\,dv
+a\int_a^\infty\|\tau_vf-f\|_2^2\frac{dv}{v^2}.
\tag{6}
$$
Inserting the actual modulus (1) yields, for fixed positive $C,c'$,
$$
\|D_ag_T\|_{\mathcal E}
\le C\sqrt a\exp(-c'\sqrt{\log a})\quad(a\ge2),
\qquad
\|D_ag_T\|_{\mathcal E}\le C\quad(0<a\le2).
\tag{7}
$$
The bounds are uniform in $T$. For large $a$, the first integral is bounded by $Ca^2e^{-c_2\sqrt{\log a}}$ before its factor $1/a$; the second becomes $a\int_{\log a}^\infty e^{-c\sqrt u}du$. Its polynomial factor in $\sqrt{\log a}$ is absorbed by decreasing the positive exponent. For $a\le1$, the part from $a$ to1 is $O(a\log(1/a))$, and the other parts are bounded. These are estimates on the actual source class, not improved norms for dilations on arbitrary elements of the completed space.

Under $x=e^v$, the critical identification is $a_T(v)=e^{v/2}g_T(e^v)$. A physical translation by $h$ becomes $D_{e^h}$. Therefore the exact all-power collective generator has additive-coordinate expression
$$
L_pg_T=2p^{-1}g_T+p^{-3/2}(D_p+D_{1/p})g_T
-(1-p^{-1})\sum_{j\ge2}p^{-j/2}(D_{p^j}+D_{p^{-j}})g_T.
\tag{8}
$$
Equation (7) proves absolute convergence of this series in the completed Hilbert space, uniformly over $T$. In particular
$$
\|L_pg_T\|_{\mathcal E}
\le C\left[p^{-1}+\sum_{j\ge2}e^{-c'\sqrt{j\log p}}\right].
\tag{9}
$$
Every term has a cutoff limit. Dominated convergence in the absolutely summable history series gives
$$
L_Pg_T=\sum_{p\le P}L_pg_T\longrightarrow L_Pg
\quad\text{in the completed space, for every fixed finite }P.
\tag{10}
$$
This defines the complete collective-history operator on the actual full source even if the source is not in unweighted $L^2$. It does not identify this extension with a bounded operator on the entire completed Hilbert space. The growing-prime constants and the subsequent signed readout require their own estimates.

The metric also changes the adjoints. Critical dilations are unitary in the original $L^2(dx)$, but not in $\mathcal E$; equation (6) gives their changed norm exactly. Therefore neither the old critical adjoint pairing nor positivity of $L_P$ or contraction of its heat evolution is asserted in this new metric. A source-domain extension and a dissipative estimate are separate mathematical obligations.

## The original pole-null tests supply the dual cancellation

For any smooth compactly supported additive test $\varphi$ with $\int\varphi=0$,
$$
\|\varphi\|_{\mathcal E^*}^2
=\int\frac{|\widehat\varphi(\xi)|^2}{m(\xi)}\,d\xi<\infty,
\qquad
|\langle g,\varphi\rangle|
\le\|g\|_{\mathcal E}\|\varphi\|_{\mathcal E^*}.
\tag{11}
$$
At low frequency the numerator is $O(\xi^2)$; at high frequency ordinary Fourier decay suffices. The pairing with the actual limit is obtained by passing from its cutoffs.

Let $f\in C_c^\infty(\mathbb R)$ be an original physical test and put $\varphi(x)=x^{-1/2}f(\log x)$ for $x>0$, zero otherwise. Then
$$
\int_0^\infty\varphi(x)dx=\int_{\mathbb R}e^{v/2}f(v)dv,
\qquad
\int_0^\infty\frac{\varphi(x)}x dx=\int_{\mathbb R}e^{-v/2}f(v)dv.
\tag{12}
$$
Thus one of the exact pole-null moments is precisely the zero additive mean needed in (11), and the second moment is retained as the additional $dx/x$ cancellation. Moreover
$$
\int_0^\infty g(x)\varphi(x)dx
=\int_0^\infty a(v)f(v)dv.
\tag{13}
$$
This is a genuine continuous linear readout of the completed actual history. It is not the complete quadratic Weil criterion.

For a smoothed convolution readout, the additive-coordinate kernel is
$$
K(x,y)=\frac{h(\log(xy))}{\sqrt{xy}},\qquad x,y>0.
\tag{14}
$$
Its full positive-axis marginal is $y^{-1}\int e^{v/2}h(v)dv$, so the same pole-null moment cancels it. Causal compression to $x,y\ge1$ changes that marginal. For a fixed compact physical window, let $K_0$ be this compressed kernel. It is supported on a bounded rectangle. Define $M(y)=\int K_0(x,y)dx$, $c=\int M$, and choose a smooth $w$, of integral1, supported strictly below the source origin. Then
$$
K_0^\flat(x,y)=K_0(x,y)-w(x)M(y)-M(x)w(y)+c\,w(x)w(y)
\tag{15}
$$
has both marginals zero and exactly the same pairing with $g\otimes g$. It belongs to the tensor dual space with weight $1/[m(\xi)m(\eta)]$. To verify this for $K=K_0^\flat$, compact support and both zero marginals give

$$
|\widehat K(\xi,\eta)|\le C|\xi\eta|\quad(|\xi|,|\eta|\le1).
$$

If only $|\xi|\le1$, integrate first in $x$ and subtract the constant exponential using that marginal. Cauchy–Schwarz on its bounded support, followed by Plancherel in $y$, yields

$$
\int_{\mathbb R}|\widehat K(\xi,\eta)|^2d\eta
\le C\xi^2\iint x^2|K(x,y)|^2dxdy.
$$

The symmetric estimate covers small $\eta$. These bounds are integrable after division by $m(\xi)m(\eta)\asymp\min(|\xi|,1)\min(|\eta|,1)$ in the respective regions. Where both frequencies exceed one, ordinary $L^2$ suffices. The causal compression may create jumps, but this argument requires only compact support and $L^2$, not smoothness of the compressed kernel. Hence this fixed-window smoothed bilinear readout is bounded by $\mathcal E(g)\|K_0^\flat\|_{\mathcal E^*\otimes\mathcal E^*}$.

The norm of the completed test kernel is not asserted uniform as its physical window grows. Its marginal corrections explicitly record the causal boundary information. Neither the sign of this bilinear pairing nor a bound for the unsmoothed complete harmonic readout follows from Hilbert-space membership alone.

The positive increment form and its Fourier multiplier use the classical translation/Plancherel construction. Its PNT input and attribution are given in the linked successor theorem. The tensor marginal correction retains the original causal pairing because the anchor function vanishes on the source support. Neither positive energy nor source membership proves positivity of the old prime operator.

The [natural-arrival cutoff proof](natural-arrival-cutoff-completion.md) gives a distinct quantitative construction for the literal frozen-tail approximants, including their full derivative measures and inclusive joins. It identifies the same completed causal source as the smooth logarithmic cutoffs used above.
