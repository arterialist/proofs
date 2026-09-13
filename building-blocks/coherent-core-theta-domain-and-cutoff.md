# The coherent core cross pair: theta domains and correlated cutoff action

Use the [actual theta normalization](theta-weil-jump-form.md):
$$
 d\nu(v)=2\cosh(v/2)\Phi(v)\,dv,\quad \lambda=\frac12,\qquad
 \Phi(v)\sim4\pi^2e^{9|v|/2}e^{-\pi e^{2|v|}}.
 \tag{1}
$$
Retain the [explicit two-source family](actual-core-explicit-weil-cross-family.md)
$$
 h_t(v)=-\sqrt{te^{|v|}}K(te^{|v|}),\quad
 u(v)=\sqrt{2\beta}e^{-\beta v}\mathbf1_{v\ge0},\quad
 z_t=(\beta-\partial_v)h_t/\sqrt{2\beta},
 \quad \tfrac12<\beta<1.
 \tag{2}
$$
Every cutoff limit below is at fixed $t>0$. No uniform theta
Hilbert bound as $t\downarrow0$ is asserted.

## 1. Actual domains

The large-argument kernel expansion and its derivative give
$$
 \begin{aligned}
 h_t(v)&=-e^{-|v|}/(6t)+O_t(e^{-2|v|}),\\
 z_t(v)&=-(\beta+1)e^{-v}/(6t\sqrt{2\beta})+O_t(e^{-2v})
 &&(v\to+\infty),\\
 z_t(v)&=(1-\beta)e^v/(6t\sqrt{2\beta})+O_t(e^{2v})
 &&(v\to-\infty).
 \end{aligned}
 \tag{3}
$$
Hence neither quotient belongs to the theta Hilbert space:
$$
 \boxed{\|f/\Phi\|_\nu^2
 =\int\frac{2\cosh(v/2)}{\Phi(v)}|f(v)|^2\,dv=\infty,
 \qquad f=u,z_t.}
 \tag{4}
$$
In particular they are outside the closed jump-form domain.
Subtracting finite compact source profiles or theta derivatives
does not remove these nonzero exponential tails.

For any $1/2<\alpha<\beta$, the sources themselves have finite
exponentially weighted $L^1,L^2$, and BV norms.
The value jump of $u$ at zero is retained. The function $h_t$
is continuous, so its first weak derivative has no delta;
$z_t$ can have a finite value jump at zero.

Let $\chi_R$ be smooth even, between zero and one, equal to one
on $[-R,R]$, zero outside $[-R-1,R+1]$, with uniformly bounded
derivatives. Set
$$
 u_R=\chi_Ru,\quad z_R=\chi_Rz_t,\quad
 U_R=u_R/\Phi,\quad Z_R=z_R/\Phi.
 \tag{5}
$$
These compact BV quotients are in the closed theta form domain.
Indeed they lie in $H^s$ for every $0<s<1/2$, by the Fourier
bound $|\widehat f(\xi)|\le\min(\|f\|_1,\operatorname{TV}(f)/|\xi|)$.
Mollification with common compact support converges in $H^s$.
For small arch jumps, the conductance on that support is bounded
by $C/a$, and $H^s$ controls the square differences.
Larger arch jumps have a bounded local $L^2$ estimate.
The complete prime form is bounded in $L^2(\nu)$, by the bounded
departure rate and weighted-shift operator in public section 8.
Thus this mollification converges in the closed form norm as well.

## 2. Full polarized ground identity in source variables

All forms are linear in the first argument. Put
$$
 C_{f,g}(a)=\int f(v+a)\overline{g(v)}\,dv,\quad
 M_\pm(f)=\int e^{\pm v/2}f(v)\,dv,
$$
$$
 B(f,g)=M_+(f)\overline{M_-(g)}
       +M_-(f)\overline{M_+(g)}.
 \tag{6}
$$
Let $\mathcal A(f,g)$ be the polarized arch Fourier form with
the actual multiplier
$\Re\psi_{\rm digamma}(1/4+i\xi/2)-\log\pi$, and set
$$
 \mathcal P(f,g)=\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 [C_{f,g}(\log q)+C_{f,g}(-\log q)].
 \tag{7}
$$
Then $Q(f,g)=\mathcal A(f,g)-\mathcal P(f,g)+B(f,g)$.
The cutoff ground identity is exactly
$$
 \boxed{Q(u_R,z_R)=E_{\rm jump}(U_R,Z_R)-D_R+B(u_R,z_R),}
$$
$$
 D_R=\lambda\langle U_R,Z_R\rangle_\nu
 =\int\frac{\chi_R(v)^2\cosh(v/2)}{\Phi(v)}
 u(v)\overline{z_t(v)}\,dv.
 \tag{8}
$$
Both pole columns follow directly from
$\nu(f/\Phi)=M_+(f)+M_-(f)$ and
$\nu(\tau f/\Phi)=M_+(f)-M_-(f)$:
$$
 E_{\rm pole}(f/\Phi,g/\Phi)
 =\lambda\langle f/\Phi,g/\Phi\rangle_\nu-B(f,g).
 \tag{9}
$$
Thus no pole-null condition or removed column is hidden in (8).
Equivalently,
$$
 E_{\rm jump}(U_R,Z_R)-D_R
 =\mathcal A(u_R,z_R)-\mathcal P(u_R,z_R).
 \tag{10}
$$
Every prime power crossing the cutoff remains in (7).

## 3. Correlated differentiation before any separate estimate

The literal causal contact is
$$
 (\beta+\partial_v)u=\sqrt{2\beta}\,\delta_0.
 \tag{11}
$$
Let $\widetilde f(v)=\overline{f(-v)}$, and put $h_R=\chi_Rh_t$.
Then
$$
 (\beta+\partial_v)u_R=\sqrt{2\beta}\delta_0+\chi_R'u,\quad
 z_R=\frac{(\beta-\partial_v)h_R+\chi_R'h_t}{\sqrt{2\beta}}.
 \tag{12}
$$
Since $h_R$ is even and $\chi_R'h_t$ is odd, transfer the
derivative inside the convolution. This gives the exact formula
$$
 \boxed{u_R*\widetilde z_R
 =h_R+\frac{(\chi_R'u)*h_R-u_R*(\chi_R'h_t)}{\sqrt{2\beta}}.}
 \tag{13}
$$
The first term comes from the actual origin atom in (11).
Both cutoff derivative ports are necessary at finite $R$.
Replacing the cross correlation by $h_R$ alone is not exact.

Write $\mathscr W(F)$ for the translation-invariant physical Weil
distribution on correlation kernels. On the present Lipschitz,
exponentially decaying kernels it has the concrete expression
$$
 \begin{aligned}
 \mathscr W(F)={}&\int 2\cosh(a/2)F(a)\,da
 -(\gamma_E+\log\pi)F(0)\\
 &+\int_0^\infty
 \frac{2e^{-2a}F(0)-e^{-a/2}[F(a)+F(-a)]}{1-e^{-2a}}\,da\\
 &-\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 [F(\log q)+F(-\log q)].
 \end{aligned}
 \tag{14}
$$
The arch numerator at zero is taken as a combined expression.
It is $O(a)$; no separate divergent diagonal integral is used.
Therefore (13) gives the complete finite boundary form
$$
 Q(u_R,z_R)=\mathscr W(h_R)
 +\frac{\mathscr W((\chi_R'u)*h_R)
              -\mathscr W(u_R*(\chi_R'h_t))}{\sqrt{2\beta}}.
 \tag{15}
$$
This applies the derivative relation before estimating either source.
Without cutoffs the same relation gives
$u*\widetilde z_t=h_t$, and $Q(u,z_t)=\mathscr W(h_t)$.

Theta conjugation changes that derivative. With
$\sigma_\Phi=\Phi'/\Phi$, $\nabla_\Phi=\partial_v+\sigma_\Phi$,
and $H=h_t/\Phi,\ U=u/\Phi,\ Z=z_t/\Phi$, the exact local
distributional identities are
$$
 \boxed{(\beta+\nabla_\Phi)U
       =\frac{\sqrt{2\beta}}{\Phi(0)}\delta_0,\qquad
 Z=(\beta-\nabla_\Phi)H/\sqrt{2\beta}.}
 \tag{16}
$$
The covariant term cannot be omitted. These are local distribution
identities, not operator-domain statements for the excluded functions.
Also the formal adjoint of $\nabla_\Phi$ in $L^2(\nu)$ is
$-\partial_v-\tfrac12\tanh(v/2)$, not $-\nabla_\Phi$.
Consequently the source-space derivative transfer is not a
theta-Hilbert adjoint argument.

## 4. Finite paired limit and its necessary subtraction

For fixed $t$, the cutoffs converge in exponentially weighted
$L^1$ and BV norms. Their Fourier transforms are uniformly
$O((1+|\xi|)^{-1})$, which controls the arch cross integral
against its logarithmic multiplier. Their correlations obey
$$
 |C_{u_R,z_R}(a)|\le C_{t,\alpha}(1+|a|)e^{-\alpha|a|},
 \qquad \tfrac12<\alpha<\beta.
 \tag{17}
$$
This dominates the complete prime sum, including all powers, and
the two pole moments converge by the same exponential margin.
Hence
$$
 \boxed{\lim_R[E_{\rm jump}(U_R,Z_R)-D_R]
 =\mathcal A(u,z_t)-\mathcal P(u,z_t).}
 \tag{18}
$$
The limit is independent of cutoffs with these approximation bounds.

The ports in (13) also tend to zero in the domain of (14).
For example
$\|e^{\alpha|\cdot|}\chi_R'u\|_1
=O(e^{-(\beta-\alpha)R})$, and the corresponding bound for
$\chi_R'h_t$ is $O_t(e^{-(1-\alpha)R})$.
Convolving with the uniformly bounded weighted norms of $u_R,h_R$
gives convergence with an exponential uniform bound and a Lipschitz
bound. This controls every term of (14).
It permits removing the ports in the paired source limit, but does
not make the ports small after division by $\Phi$ in theta norm.

The subtraction in (18) is indispensable. On the positive tail
where $\chi_R=1$, the integrand of $D_R$ is asymptotic to
$$
 -\frac{\beta+1}{48\pi^2t}
 \exp\{\pi e^{2v}-(\beta+5)v\}.
 \tag{19}
$$
Thus $D_R\to-\infty$. Equation (10) shows the jump cross value
also tends to $-\infty$, while their difference has the finite
limit (18). For each separate diagonal, the same equation has a
finite source right side and a positive divergent norm, so both
diagonal jump energies tend to $+\infty$.
Small finite pole coordinates cannot replace this divergent local
cross counterterm.

Finally the actual uncut factorization gives
$$
 \mathcal P(u,z_t)=2\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
 h_t(\log q)=-2Q_{\rm core}(t),\quad
 Q_{\rm core}(t)=\sqrt t\sum_{q\ge2}\Lambda(q)K(tq),
$$
$$
 B(u,z_t)=2H_t,\qquad H_t=M_{1/2}(h_t)=M_{-1/2}(h_t).
 \tag{20}
$$
The complete correlated ground identity is therefore
$$
 \boxed{Q(u,z_t)=
 \lim_R[E_{\rm jump}(U_R,Z_R)-D_R]+2H_t
 =\mathcal A(u,z_t)+2Q_{\rm core}(t)+2H_t.}
 \tag{21}
$$
This supplies a precise paired boundary form with the origin atom,
covariant derivative, cutoff ports, and both pole columns intact.
It establishes neither a Hilbert-space identification for the uncut
quotients nor positivity of the cross row.

## Direct theta-source factorization has infinite cost

This statement concerns the unchanged kernel $h_t$, not the
renormalized cutoff identity above. Put
$$
 w(v)=\frac{\Phi(v)}{2\cosh(v/2)},\qquad
 \|f\|_\Theta^2=\int_{\mathbb R}\frac{|f(v)|^2}{w(v)}\,dv
 =\|f/\Phi\|_{L^2(\nu)}^2.
 \tag{22}
$$
Actual theta decay implies that there are constants $A,b>0$ with
$$
 0<w(v)\le A\exp(-b e^{2|v|})\quad(v\in\mathbb R).
 \tag{23}
$$
The exponential prefactors in the theta asymptotic are absorbed
by reducing $b>0$; increasing $A$ covers the bounded central
interval.

For every pair of finite-norm sources, their cross correlation has
the pointwise bound
$$
 \boxed{|f*\widetilde g(v)|
 \le A e^{-b e^{|v|}}\|f\|_\Theta\|g\|_\Theta
 \qquad(v\in\mathbb R).}
 \tag{24}
$$
To prove it, write $f=\sqrt w\,F$, $g=\sqrt w\,G$,
where $F,G\in L^2(dv)$. Cauchy--Schwarz gives
$$
 |f*\widetilde g(v)|
 \le\sup_x\sqrt{w(x+v)w(x)}\,\|F\|_2\|G\|_2.
 $$
The geometric inequality
$$
 e^{2|x+v|}+e^{2|x|}
 \ge2e^{|x+v|+|x|}\ge2e^{|v|}
 $$
and (23) prove (24) with precisely the stated constants.

There is no representative ambiguity in (24). Since $w$ is
bounded, finite theta norm implies ordinary $L^2$ membership.
The defining correlation integral is absolutely convergent for
every fixed $v$, is independent of changes on null sets, and
is continuous in $v$ by $L^2$ translation continuity.
It is this canonical continuous representative that occurs in (24).

For a countable family with
$$
 C=\sum_j\|f_j\|_\Theta\|g_j\|_\Theta<\infty,
 $$
the cross-correlation series converges uniformly and absolutely,
and its continuous sum $H$ satisfies
$$
 |H(v)|\le AC e^{-b e^{|v|}}.
 \tag{25}
$$
Scalar coefficients may be included by inserting their absolute
values in $C$. In view of (3), no $h_t$ for fixed $t>0$
can equal such a sum: its nonzero exponential tail violates (25).
This excludes both finite sums and norm-product-summable infinite
families. Equality almost everywhere is also excluded, because
both sides have continuous representatives.

There is a quantitative finite-scale cost. Choose one fixed $T>0$
with $K(T)>0$, which exists by the proved large-$T$ asymptotic,
and put $\kappa_T=\sqrt T K(T)>0$.
For $0<t\le T$, let $v_t=\log(T/t)$. Then
$$
 h_t(v_t)=-\kappa_T,\qquad e^{|v_t|}=T/t.
 $$
Any sum as above satisfying
$|H(v_t)-h_t(v_t)|\le\kappa_T/2$ must therefore have
$$
 \boxed{C\ge\frac{\kappa_T}{2A}\exp(bT/t).}
 \tag{26}
$$
This is a cost bound for pointwise approximation at the specified
actual scale; no unsupported passage from an unrelated norm to
pointwise evaluation is used.

The conclusion is limited to direct finite-cost factorization of
the unchanged $h_t$ by actual finite-theta-norm sources.
It leaves the correlated physical distribution, its renormalized
cutoff limit, and ground identities that change the source intact.

## Dependencies and formal scope

The [scaling kernel](successor-feedback-kernel-scaling.md), [explicit signed factorization](actual-core-explicit-weil-cross-family.md) and [theta jump form](theta-weil-jump-form.md) fix the actual sources and normalization. The complete prime term equals twice the [coherent core observation](coherent-core-positive-observation-inner-history.md); its physical source cutoff is the [signed port](positive-history-observation-original-cutoff-port.md). The covariance and polarization identities, bounded-variation Fourier estimate and weighted Cauchy–Schwarz factorization bound are classical tools.

This is a written proof, including the finite-cost obstruction for the unchanged kernel. It does not assert a theta-Hilbert identification of the uncut sources, a sign of the polarized row, or a Lean formalization of the correlated cutoff limit.

The [exact radical projection](actual-core-Weil-arch-row-radical-projection.md) removes both source pole moments while preserving the full physical Weil pairing. Its prime-port constant is exactly compensated by the archimedean row. This supplies a pole-null pair but does not remove the theta-domain obstruction or prove its cross-row sign.
