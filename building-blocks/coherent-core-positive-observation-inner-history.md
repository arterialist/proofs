# The coherent core as a positive observation of the retained inner history

The actual readout $Q$ has an exact representation as a positive observation of a signed history. The proof uses the [scaling kernel](successor-feedback-kernel-scaling.md) and its [centered differential equation](actual-division-lattice-dual-cosine.md), retaining the initial source and every prime power. Here $t=-\log r$ is the geometric successor parameter, distinct from prime-process time. No lower bound for $Q$ is assumed or concluded.

Write

$$
K'(u)=-\frac{b(u)}{2u},\qquad
b(u)=\int_0^u e^{-x}(u-x)^{-1/2}dx-u^{-1/2},\qquad
b'(u)+b(u)=\frac1{2u^{3/2}}.
\tag{1}
$$

The [kernel moments](successor-division-kernel-moments.md) are $\int_0^\infty K=0$ and $\int_0^\infty K(u)\log u\,du=\pi^{3/2}/2$, both absolutely convergent. We use the complete source

$$
Q(t)=\sqrt t\sum_{n\ge2}\Lambda(n)K(tn).
\tag{2}
$$

## A centered forcing with one sign change

Set

$$
F(u)=K'(u)+\frac1{4u^{5/2}},\qquad
w(u)=-u^2F(u)=\frac{u b(u)}2-\frac1{4\sqrt u}.
\tag{3}
$$

This is the single-kernel centered forcing from the division ODE; no divergent Möbius series is separated. Put $H(u)=2u^{3/2}b(u)$. Equation (1) gives

$$
H'(u)=1+\left(\frac3{2u}-1\right)H(u).
\tag{4}
$$

As $u$ tends to zero, the integral in (1) gives $H(u)=-2u+O(u^2)$, so $H<1$ initially. Expanding $(u-x)^{-1/2}$ through the quadratic term for $x\le u/2$ and bounding the exponentially small complementary part gives

$$
b(u)=\frac1{2u^{3/2}}+\frac3{4u^{5/2}}+O(u^{-7/2}).
\tag{5}
$$

Thus $H(u)=1+3/(2u)+O(u^{-2})>1$ eventually. At every point $H=1$, equation (4) gives $H'=3/(2u)>0$. Continuity and this strictly upward crossing imply that $H$ crosses $1$ exactly once. Since $w=(H-1)/(4\sqrt u)$, $w$ is negative before that point and positive after it.

Moreover, the differential equation for K gives

$$
w(u)=u(uK'(u))'.
$$

Integrating by parts twice proves

$$
\int_0^\infty w(u)du=\int_0^\infty K(u)du=0.
\tag{6}
$$

All boundary terms vanish: at zero K=-u^(-1/2)+O(1), K'=1/(2u^(3/2))+O(u^(-1/2)); at infinity K=1/(6u^(3/2))+O(u^(-5/2)). The integrals of |w| converge at both ends.

Consequently

$$
\boxed{V(u)=-\int_0^u w(z)dz=\int_u^\infty w(z)dz>0\quad(u>0).}
\tag{7}
$$

This positive function is distinct from the inner operator $\mathcal V$ below. The small- and large-argument expansions are

$$
V(u)=\frac12\sqrt u+\frac13u^{3/2}+O(u^{5/2}),\qquad
V(u)=\frac3{4\sqrt u}+O(u^{-3/2}),
\tag{8}
$$

respectively. A further integration by parts, using the logarithmic $K$ moment, gives the useful finite normalization

$$
\int_0^\infty\frac{V(u)}u du
=\int_0^\infty w(u)\log u\,du
=\int_0^\infty K(u)(\log u+2)du
=\frac{\pi^{3/2}}2.
\tag{9}
$$

Thus $(2/\pi^{3/2})V(u)\,du/u$ is a positive probability measure. No arithmetic sign is inferred from this probability normalization.

## Exact pairing with the actual prefix contrast

Define the continuous logarithmic prefix

$$
\Psi_1(y)=\sum_{n\le y}\Lambda(n)\log(y/n)
=\int_1^y\frac{\psi(x)}x dx\quad(y\ge1),
$$

and set both $\psi$ and $\Psi_1$ to zero for $0<y<1$. There is no jump in $\Psi_1$ at an integer birth because its new logarithmic coefficient is zero there. Chebyshev gives $|\Psi_1(y)|\le Cy$.

The K equation and its decaying boundary data give the Green representation

$$
K(z)=-\int_z^\infty uF(u)\log(u/z)du.
\tag{10}
$$

Absolute Fubini is valid after summing with Lambda(n), because the resulting logarithmic prefix is O(u/t) and integral |w| is finite. Hence

$$
Q(t)=\sqrt t\int_0^\infty\frac{w(u)}u\Psi_1(u/t)du.
\tag{11}
$$

Put $A(y)=\Psi_1(y)/y$ for $y>0$, with $A=0$ on $(0,1)$. This is continuous and locally absolutely continuous, and

$$
A'(y)=\frac{\psi(y)-\Psi_1(y)}{y^2}
$$

almost everywhere. Integrating (11) by parts with w=-V' gives

$$
\boxed{Q(t)=\sqrt t\int_0^\infty\frac{V(u)}{u^2}
\big[\psi(u/t)-\Psi_1(u/t)\big]du.}
\tag{12}
$$

The boundary terms vanish at zero because A vanishes there and at infinity because A is bounded and V tends to zero. Absolute convergence follows from $|\psi(y)-\Psi_1(y)|\le Cy$ and (9). Every prime-power arrival is retained in the signed bracket. The positivity of V says nothing by itself about that bracket.

The actual bracket is negative at a finite horizon. At $y=222$,
\[
 \psi(222)-\Psi_1(222)
 =\sum_{p^k\le222}(\log p)
       \bigl[1-\log(222/p^k)\bigr]<-19/1000.             \tag{12a}
\]
The [exact-rational certificate](verification/prime_prefix_contrast_222.py)
enumerates all 61 prime powers and bounds each logarithm by five terms of
$2\operatorname{artanh}z$, with the positive geometric tail retained.
It uses no floating-point sign decision. On $(222,223)$, $\psi$
is constant and $\Psi_1$ increases, so
$A'(y)<0$ throughout $(222,223)$. This is a certified finite
counterexample to pointwise positivity of the input in (12) and to
monotonicity of the normalized logarithmic prefix $A$; it does not
determine the sign of the integrated $Q(t)$ or RH. It is not a Lean
formalization.

The finite obstruction persists at arbitrarily large scales. Write
$B(y)=\psi(y)-\Psi_1(y)$, with the same complete prime-power source and
right-continuous cutoff as above.

**Theorem (critical-scale oscillation of the actual prefix contrast).**
For every critical-line zero $\rho=1/2+i\gamma$ of multiplicity
$m_\rho$,

$$
\limsup_{y\to\infty}\frac{B(y)}{\sqrt y}\ge\frac{m_\rho}{|\rho|},
\qquad
\liminf_{y\to\infty}\frac{B(y)}{\sqrt y}\le-\frac{m_\rho}{|\rho|}.
\tag{12b}
$$

Such zeros exist unconditionally by
[Hardy's 1914 theorem](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014).
Thus $B$ takes both signs arbitrarily far out, and
$A(y)=\Psi_1(y)/y$ has intervals of increase and decrease arbitrarily far
out.

**Proof.** Absolute Fubini for $\Re s>1$ gives the exact Mellin transform

$$
\begin{aligned}
\mathcal B(s)&=\int_1^\infty B(y)y^{-s-1}\,dy\\
&=\left(\frac1s-\frac1{s^2}\right)
  \sum_{n\ge2}\frac{\Lambda(n)}{n^s}
=\frac{s-1}{s^2}\left(-\frac{\zeta'(s)}{\zeta(s)}\right).
\end{aligned} \tag{12c}
$$

Indeed, an atom at $n$ contributes $n^{-s}/s$ to the Mellin transform of
$\psi$ and $n^{-s}/s^2$ to that of $\Psi_1$. The pole of
$-\zeta'/\zeta$ at $s=1$ is canceled by $s-1$. There are no zeta zeros on
the positive real axis: for $0<s<1$, the alternating eta series is
positive and $\zeta(s)=\eta(s)/(1-2^{1-s})<0$, while $\zeta(s)>0$ for
$s>1$. Thus $\mathcal B$ is holomorphic near every positive real point.
At any nontrivial zero $\rho$ of multiplicity $m_\rho$, however, it has
the nonzero residue

$$
\operatorname{Res}_{s=\rho}\mathcal B(s)
=-m_\rho\frac{\rho-1}{\rho^2}. \tag{12d}
$$

Set $b(v)=e^{-v/2}B(e^v)$ for $v\ge0$. Its Laplace transform is
$\widehat b(z)=\mathcal B(z+1/2)$ for $\Re z>1/2$.
Suppose $b(v)\le C$ for all $v\ge V$, and put
$q(v)=(C-b(v))\mathbf1_{[V,\infty)}(v)\ge0$. For $\Re z>1/2$,

$$
\widehat q(z)=\frac{Ce^{-Vz}}z-\mathcal B(z+1/2)
   +\int_0^V e^{-zv}b(v)\,dv. \tag{12e}
$$

Chebyshev gives $b(v)=O(e^{v/2})$, so the convergence abscissa
$\sigma_c$ of this positive Laplace integral is at most $1/2$. The
pole (12d) at $z=i\gamma$ forces $\sigma_c\ge0$; otherwise the
integral would be holomorphic at that point. If $\sigma_c>0$,
[Landau's positive-Mellin theorem](https://arxiv.org/html/2411.07436#S2.SS4)
forces a real singularity there. Equation (12e) has none on the positive
real axis, including $z=1/2$ where the zeta pole was canceled.
Therefore $\sigma_c=0$.

For $\varepsilon>0$, positivity gives
$|\widehat q(\varepsilon+i\gamma)|\le\widehat q(\varepsilon)$.
Multiply by $\varepsilon$ and let it tend to zero. The left side tends
to the absolute residue of $-\mathcal B$ at $\rho$,
$m_\rho|\rho-1|/|\rho|^2=m_\rho/|\rho|$; the right side tends to $C$,
because $\mathcal B(1/2)$ is finite. Hence every eventual upper bound
on $b$ has $C\ge m_\rho/|\rho|$. Repeating the argument with
$q(v)=(C+b(v))\mathbf1_{[V,\infty)}(v)$ gives the corresponding lower
bound, proving (12b). Between prime-power arrivals, $B$ is continuous,
so each late strict sign holds on a nonempty interval where
$A'=B/y^2$ has the corresponding sign.
$\square$

The proof applies classical Landau theory to this retained prime-power
prefix. It rules out eventual pointwise positivity in (12). The sign of
the integrated readout $Q(t)$ remains open. This analytic theorem is a
written proof; its Lean formalization remains to be done.

Equivalently, the negative and positive parts of w have the same finite mass and separated supports. Formula (11) is a positive mass times the difference of two averages of the actual normalized prefix A at smaller and larger scales. A is not asserted monotone; replacing this signed difference by an assumed monotonicity would be an additional arithmetic premise.

## The original source and its common inner factor

For $x\ge1$ let $g(x)=\psi(x)/x-1$, and set

$$
a(v)=e^{v/2}g(e^v)\mathbf1_{v\ge0},\qquad
 a_0(v)=e^{-v/2}\mathbf1_{v\ge0}.
$$

All convolutions below are literal causal convolutions. Algebraically, for $y\ge1$,

$$
\psi(y)-\Psi_1(y)
=1+y\left[g(y)-\frac1y\int_1^y g(x)dx\right].
\tag{13}
$$

Also

$$
a(v)-(a_0*a)(v)
=e^{v/2}\left[g(e^v)-e^{-v}\int_1^{e^v}g(x)dx\right].
\tag{14}
$$

Define the positive weight and the explicit seed

$$
k_t(v)=\frac{V(te^v)}{\sqrt{te^v}},\qquad
F_{\rm seed}(t)=\sqrt t\int_t^\infty\frac{V(u)}{u^2}du.
\tag{15}
$$

Substitution in (12) yields the full actual-source identity

$$
\boxed{Q(t)=F_{\rm seed}(t)+
\int_0^\infty k_t(v)\,[a(v)-(a_0*a)(v)]dv.}
\tag{16}
$$

The [original common-inner graph](actual-source-mixed-dirichlet-completion.md) uses $\mathcal V=-I+a_0*$. Thus the signed history in (16) is exactly $-\mathcal V a$. This is a literal source map, not an analogy with a different energy space. The actual $a$ is not assumed in global $L^2$: the causal convolution is locally defined, and the scalar pairing is absolutely convergent for every fixed t by Chebyshev and the exponential decay of $k_t$ at large age. The same identity can first be read on finite age intervals and passed to the limit with those bounds.

Equation (8) gives

$$
F_{\rm seed}(t)=1+O(\sqrt t),\quad
k_t(v)=\frac12+\frac{te^v}3+O((te^v)^2)
\quad(te^v\to0),
$$

$$
k_t(v)=\frac3{4te^v}+O((te^v)^{-2})\quad(te^v\to\infty).
\tag{17}
$$

This positive observation has a broad nearly constant region followed by decay. It is not globally decreasing: its initial derivative in the variable te^v is positive. Accordingly the established monotone-observation signs of the successor primitive cannot be applied without an additional argument.

## The quantitative core question in the retained-history coordinate

The [integer-birth convex-interpolation theorem](actual-integer-birth-positive-quadrature.md) gives

$$
E(e^{-t})=b_t Q(t)-C(t)+D(t),\qquad
b_t=\frac{t}{1-e^{-t}},\quad D(t)>0.
$$

Therefore a sufficient, still unproved, full-expression comparison is

$$
\int_0^\infty k_t(v)[a(v)-(a_0*a)(v)]dv
\ge\frac{C(t)}{b_t}-F_{\rm seed}(t)
\tag{18}
$$

for every sufficiently small $t$. The right side tends to zero using the established PNT normalization $C(t)\to1$; neither its sign nor the left side's sign is asserted. With the corrected finite-core decomposition, the positive exterior may instead be retained explicitly on the right before testing the core.

The unit seed in (16) is essential. It participates in the limiting cancellation with the physical lower-boundary correction C(t); it is not discarded as a small inverse coefficient. The known positive quadratic-log readout, positivity of V, and the common-inner graph alone do not prove (18). The construction isolates an actual signed history observation on which a source-specific successor or factorial comparison would have to act.

## An actual one-step ordering under the specific observation

The following one-step comparison uses the actual source. Its proof supplies no uniform growing-iterate comparison.

The adjoint of the causal a0 convolution acting on k_t has the explicit form

$$
(a_0^*k_t)(v)=\sqrt u\int_u^\infty V(z)z^{-2}dz,
\quad u=te^v.
$$

The Green equation gives $K'(u)=u^{-1}\int_u^\infty V(z)z^{-2}dz-V(u)/u^2$. Hence

$$
\boxed{[(I-a_0^*)k_t](v)=\eta(te^v),\quad
\eta(u)=-u^{3/2}K'(u)=\frac{\sqrt u\,b(u)}2.}
\tag{19}
$$

Writing the Dawson function as $D(x)=e^{-x^2}\int_0^x e^{y^2}dy$, (1) gives $\eta(u)=\sqrt uD(\sqrt u)-1/2$. In particular $\eta(u)=-1/2+u+O(u^2)$ at zero and $\eta(u)=1/(4u)+O(u^{-2})$ at infinity.

Use the same explicit density seed for the affine observation

$$
\mathfrak Q_t[f]=F_{\rm seed}(t)+\int_0^\infty\eta(te^v)f(v)dv.
\tag{20}
$$

For the original source this is Q(t). On the corrected source it means exactly this affine functional, with all initial and density terms unchanged; it is not an assertion that the corrected source has nonnegative prime coefficients.

Let the actual compensated successor be $Ca=Sa-\kappa a_0$, with $Sa(v)=e^{v/2}g(e^v+1)$, and put $P_1(v)=\int_0^v(Ca-a)$. The [actual successor normalization](actual-source-successor-primitive.md) is $\int_1^\infty[g(x+1)-g(x)]x^{-1/2}dx=2\kappa$, with $\kappa>0$. Consequently the literal tail formula is

$$
P_1(\log x)=\frac{2\kappa}{\sqrt x}
-\int_x^\infty\frac{g(y+1)-g(y)}{\sqrt y}dy.
\tag{21}
$$

The last integral equals

$$
-\int_x^{x+1}\frac{g(z)}{\sqrt z}dz
+\int_{x+1}^\infty g(z)[(z-1)^{-1/2}-z^{-1/2}]dz.
$$

Its two nonnegative kernel masses are equal, each $2(\sqrt{x+1}-\sqrt x)$. Chebyshev bounds $e^{v/2}|P_1(v)|$ uniformly, and the actual PNT bound gives

$$
P_1(v)=2\kappa e^{-v/2}+O(e^{-v/2-c\sqrt v}).
\tag{22}
$$

Integrating by parts in the difference of (20), with P1(0)=0 and its decaying tail retained, yields

$$
\mathfrak Q_t[a]-\mathfrak Q_t[Ca]
=\int_0^\infty te^v\eta'(te^v)P_1(v)dv.
\tag{23}
$$

The prime denotes derivative with respect to the displayed scalar argument. The absolute integrability needed here follows from the expansions of eta and (22).

After substituting $u=te^v$ and dividing by $\sqrt t$, the integral in (23) is

$$
\int_t^\infty\eta'(u)u^{-1/2}
[e^{v/2}P_1(v)]_{v=\log(u/t)}du.
$$

The function $|\eta'(u)|u^{-1/2}$ is integrable on $(0,\infty)$. Dominated convergence therefore gives the limit $2\kappa\int_0^\infty\eta'(u)u^{-1/2}du$. Its exact value is elementary: integration by parts with $\eta+1/2$, whose boundary products vanish, and the positive integral representation of Dawson give

$$
\begin{aligned}
\int_0^\infty\eta'(u)u^{-1/2}du
&=\int_0^\infty\frac{D(x)}x dx\\
&=\int_0^1\int_0^\infty e^{-x^2(1-s^2)}dx\,ds
=\frac{\pi^{3/2}}4.
\end{aligned}
\tag{24}
$$

Tonelli applies to the nonnegative Gaussian integrand. Thus

$$
\boxed{\mathfrak Q_t[a]-\mathfrak Q_t[Ca]
=\frac{\kappa\pi^{3/2}}2\sqrt t+o(\sqrt t)>0}
\tag{25}
$$

for all sufficiently small positive t. Splitting the scaled integral at $u=\sqrt t$ and applying (22) gives a stretched-exponential relative remainder after reducing c, if desired.

This is a genuine signed comparison for the actual source and the specific observation in (18). Its size tends to zero. To convert it into a constant-scale core estimate by successor iteration would require a uniform signed accumulation theorem; pointwise positivity of every iterated primitive is contradicted by the [fifth-primitive example](actual-successor-fifth-primitive-failure.md). No such accumulation or core lower bound is asserted here.

## Original cutoff, attribution and formal scope

The [original finite-source port](positive-history-observation-original-cutoff-port.md) evaluates the common-inner adjoint and retains the frozen terminal source, initial atom and strict prime-minus-density exterior. Its remainder is signed. The [mixed integer kernel](mixed-integer-feedback-kernel.md) gives a distinct clock/birth representation with a positive contact and the exact renewal killing term. Neither construction proves the core lower bound (18).

The Green representation, positive integral normalization, causal convolution adjoint, Dawson integral and dominated-convergence arguments are classical tools. Their actual arithmetic observation and the one-step ordering are written proofs. No Lean claim is made for these observation identities or their arithmetic sign targets.

The [explicit physical Weil cross pair](actual-core-explicit-weil-cross-family.md) gives another exact readout of this core. Its [theta-domain theorem](coherent-core-theta-domain-and-cutoff.md) retains the correlated cutoff ports and counterterm; the original observation is not identified with a finite theta-Hilbert norm.
