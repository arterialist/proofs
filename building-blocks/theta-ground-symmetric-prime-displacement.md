# Symmetric ground displacements and the exact hard-boundary cost

Use the actual notation of [theta ground outward prime sampling](theta-ground-outward-prime-sampling.md): the normalized positive even exterior ground state has physical representative
$f=g+g^\vee$, where $g=\Phi\psi1_{(R,\infty)}$, and
$d=1/2-\alpha>0$. Write $J=b/\Phi$ and $G_-=\int e^{u/2}g(u)du$. Here $R\ge1$. All constants with subscript $R$ refer to this fixed actual ground state; none is claimed uniform after division by $G_-^2$.

## Finite inward translation with its lost strip

For $|t|<\min(R,\tfrac12\log2)$, put
$$
 F_t(u)=g(u-t)+g(-u-t),\qquad
 N(t)=2\int_R^\infty J(u+t)g(u)^2du.
\tag{1}
$$
The full translated histories have disjoint positive and negative halves. They belong to the full physical logarithmic form domain with finite weighted norm. For negative displacement this follows even more directly than for positive displacement, since $J(u-t)\le J(u)$ for $u>R$ and $0<t<R$. Translation is applied to the zero-extended histories; no derivative of $g$ is taken.

For $t>0$, split the inward history exactly as
$$
 F_{-t}=k_t+\ell_t,\qquad
 k_t=1_O F_{-t},\quad \ell_t=1_C F_{-t}.
\tag{2}
$$
Thus $\ell_t$ is supported on $R-t<|u|\le R$, whereas $k_t$ is admissible for the original killed problem. The established hard-indicator form-domain splitting applies to these histories. Set
$$
 m_t=\|\ell_t\|_J^2
 =2\int_R^{R+t}J(u-t)g(u)^2du,
 \qquad \|k_t\|_J^2=N(-t)-m_t\le1.
\tag{3}
$$
Let $K(\cdot,\cdot)$ denote the polarized physical form $A-S$, and define the nonnegative cross-arrival pairing
$$
 X_t=-K(k_t,\ell_t)\ge0.
$$
The local multiplication part has no cross contribution, because the supports are disjoint. The continuous contribution to $X_t$ is the integral of the actual positive kernel $r(|u-v|)k_t(u)\ell_t(v)$; its prime contribution is
$$
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \int_{\mathbb R}\ell_t(u)
     [k_t(u+\log n)+k_t(u-\log n)]du.
\tag{4}
$$
Thus both directions and every prime power remain. The exact boundary correction is
$$
 E_{\rm bd}(t)=K(\ell_t)+d m_t-2X_t.
\tag{5}
$$
Ground minimality applied only to $k_t$, followed by expansion of $K(F_{-t})$, gives
$$
 K(F_{-t})\ge-dN(-t)+E_{\rm bd}(t).
\tag{6}
$$
There is no assertion that $E_{\rm bd}$ is nonnegative.

Define for either sign of $t$
$$
 C(t)=\int_{2R}^\infty r(v+2t)(g*g)(v)dv,
 \qquad
 P(t)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}(g*g)(\log n-2t).
$$
The full translation identity $K(F_t)=2K(g)-2(C(t)+P(t))$ still holds. Combining the outward inequality with (6) proves the exact symmetric estimate
$$
\boxed{\begin{aligned}
 P(0)\ge{}&\frac{P(t)+P(-t)}2
 +\frac{C(t)+C(-t)}2-C(0)\\
 &-\frac d4[N(t)+N(-t)-2]+\frac14E_{\rm bd}(t).
\end{aligned}}
\tag{7}
$$
The continuous contribution now has a favorable sign: the exact expansion
$C(t)=\sum_{j\ge0}e^{-(4j+1)t}G(2j+1/2)^2$ implies
$(C(t)+C(-t))/2-C(0)\ge0$.

## What the proved boundary regularity actually pays

The bounded-ground logarithmic-Laplacian argument already proved for this actual operator gives, for a sufficiently small fixed $a_R>0$,
$$
 0\le g(R+y)\le\frac{C_R}{\sqrt{\log(a_R/y)}}
 \quad(0<y<a_R/e).
\tag{8}
$$
This is the boundary estimate from Hernández-Santamaría–López Ríos–Saldaña, Theorem 1.1, applied after the full-prime localization established in [theta ground normalized cross arrival](theta-ground-normalized-cross-arrival.md):
https://arxiv.org/html/2401.18033v2 . In particular, it is an estimate for the actual ground state, with the full prime forcing retained.

For sufficiently small $t$, (3) and boundedness of $J$ on the fixed boundary collar imply
$m_t\le C_R t/\log(1/t)$. The full original form is nonnegative, so
$$
 K(\ell_t)+d m_t
 =\mathcal E(\ell_t/\Phi)-\alpha m_t\ge-\alpha m_t.
\tag{9}
$$
One can improve the crude cross-operator estimate
$X_t\le b_R\sqrt{m_t}$ to the actual bound
$$
 X_t\le C_Rt.
\tag{10}
$$
Here is the singular part of the proof. At the positive boundary use lost-strip distance $s\in(0,t)$ and kept distance $x>0$. The two amplitudes are $g(R+t-s)$ and $g(R+t+x)$, and the singular kernel is bounded by $C_R/(s+x)$. For $0<x<t$, both amplitudes are $O_R(\log(1/t)^{-1/2})$, and
$\int_0^t\int_0^t(s+x)^{-1}dxds=2t\log2$.
For $t<x<a_R/4$, the lost amplitude is $O_R(\log(1/t)^{-1/2})$, and the remaining integral is bounded by
$$
 \frac{C_Rt}{\sqrt{\log(1/t)}}
 \int_t^{a_R/4}\frac{dx}{x\sqrt{\log(a_R/(x+t))}}
 \le C_Rt.
$$
The negative boundary is identical. Continuous interactions outside these collars have bounded arrival density. So do all the prime interactions in (4): the uniformly shifted actual theta envelope makes the full prime series locally uniformly bounded for $t$ in a fixed small interval. Pairing either bounded arrival with the lost strip costs $O_R(t/\sqrt{\log(1/t)})$. This proves (10), including all long jumps.

Consequently the available one-sided estimate is
$$
 \boxed{\ E_{\rm bd}(t)\ge-C_Rt.\ }
\tag{11}
$$
This improves the square-root boundary bound but does not prove a quadratic boundary cost, or any useful bound on $C_R/G_-^2$.

## The norm really has a quadratic symmetric difference

Only the smooth, explicitly known weight is differentiated. The actual theta series and its first two derivatives give
$|J''(u)|/J(u)\le C e^{4u}$ for $u\ge1$. For example, the degree-four polynomial obtained by differentiating the leading theta summand twice, together with the positive leading-term lower bound and the exponentially convergent remaining summands, gives this estimate directly. Enlarging the constant extends the bound to the compact interval $1/2\le u\le1$, which covers inward shifts when $R=1$.

Let $X_0$ and $L_0$ be those in (11)–(14) of the outward source. The second finite-difference identity for $J$ and the established exponential domination of $X=e^{2|u|}$ under $\psi^2\nu$ give, for sufficiently small $t\le1/(L_0X_0)$,
$$
 \boxed{\quad
 |N(t)+N(-t)-2|\le C t^2X_0^2.
 \quad}
\tag{12}
$$
Indeed the integrand is at most
$Ct^2X^2e^{L_0tX}$, and the shifted-exponential comparison gives
$\mathbb E[X^2e^{L_0tX}]\le C X_0^2$.
Thus the first-order theta displacement has genuinely canceled; no regularity of $\psi$ beyond the proved form and weighted-tail properties enters this step.

Averaging (7) over $0<t<T$, applying (11)–(12), and retaining the favorable continuous term if desired gives
$$
 P(0)\ge\frac1{4T}\int_{2R}^\infty(g*g)(v)
 \sum_{e^{v-2T}\le n\le e^{v+2T}}
             \frac{\Lambda(n)}{\sqrt n}\,dv
 -C dT^2X_0^2-C_RT.
\tag{13}
$$
The constants absorb only the displayed integration factors. Integer endpoint choices affect a countable set of $v$, hence do not change this identity or inequality. The exact density value of the first term is $(\sinh T/T)G_-^2$. If
$\epsilon_{R-T}=\sup_{x\ge e^{2(R-T)}}|\psi_{\rm Ch}(x)-x|/x$, weighted partial summation yields
$$
 \boxed{\quad
 \frac{P(0)}{G_-^2}\ge\frac{\sinh T}{T}
 -\frac{\epsilon_{R-T}e^T}{2T}
 -C T^2X_0^2\frac d{G_-^2}
 -\frac{C_RT}{G_-^2}.
 \quad}
\tag{14}
$$
Its proved small-displacement range still includes $T\le1/(L_0X_0)\le e^{-2R}/L_0$, as well as the fixed boundary collar restrictions. Neither (12) nor (14) proves a wider useful prime window. The unresolved quantity is now explicitly the normalized boundary cost, in addition to the relative spectral distance for larger displacements. The logarithmic trace estimate establishes (11), not $o(t)$, and cannot by itself be substituted for a second-order boundary estimate.

Finally, dividing a trial history by its weighted norm does not remove these terms: the homogeneous Rayleigh inequality for the normalized trial is exactly the inequality used in (6)–(7). A translation made unitary for the weighted norm instead multiplies the translated profile by a nonconstant square-root ratio of $J$; its physical same-side jump energies no longer cancel by translation invariance. Such a deformation would need a new estimate for those literal kernel changes. No sign of the even Weil form or passing normalized prime comparison is assumed here.

## Prime-free collars: positive self-energy does not give a positive boundary correction

There is a useful exact sign distinction in (5). Since the off-diagonal physical form is nonpositive,
$K(k_t,\ell_t)=-X_t$, the correction is
$$
 E_{\rm bd}=K(\ell_t)+dm_t+2K(k_t,\ell_t),
\tag{15}
$$
not the expression with minus twice that polarized cross term. Thus positive arrivals decrease this boundary correction.

Nevertheless, the proposed positive self-energy estimate is valid. Choose $t<\log2$ so that no prime-power logarithm belongs to $(2R-2t,2R)$. Explicitly, let $q_R=\max\{p^j<e^{2R}:p\text{ prime},\ j\ge1\}$, which exists for $R\ge1$, and set $t_R^{\rm gap}=(2R-\log q_R)/2>0$. The condition $0<t<\min(\log2,t_R^{\rm gap})$ suffices. A logarithm exactly equal to $2R$ has a zero-measure intersection of the two collars and contributes zero. No prime shift connects either collar to itself, or the two collars to each other. Hence
$\langle\ell_t,S\ell_t\rangle=0$.

For the unitary Fourier convention $\widehat l(\xi)=(2\pi)^{-1/2}\int e^{-i\xi u}l(u)du$, any function $l$ supported on a set of measure at most $m$ satisfies
$$
 \int_{-T}^T|\widehat l(\xi)|^2d\xi
 \le\frac{Tm}{\pi}\|l\|_2^2.
$$
The actual even increasing multiplier $\mathfrak a$ therefore gives
$$
 \langle l,Al\rangle\ge
 \left[\mathfrak a(T)-
  (\mathfrak a(T)-\mathfrak a(0))\frac{Tm}{\pi}\right]\|l\|_2^2.
\tag{16}
$$
Taking $m=2t$, any fixed $T$ with $\mathfrak a(T)>0$ gives positive $K(\ell_t)$ once
$t<\pi\mathfrak a(T)/(2T[\mathfrak a(T)-\mathfrak a(0)])$.
Alternatively $T=\pi/(4t)$ yields the lower coefficient
$(\mathfrak a(T)+\mathfrak a(0))/2$, of order $\tfrac12\log(1/t)$.
This proves positivity of the strip's self-energy, but leaves its negative interaction with the retained history.

The actual ground equation specifies that interaction more sharply. For $w\in(R,R+t)$, define the full opposite-half arrivals
$$
 A_t(w)=C_t^{\rm arr}(w)+P_t^{\rm arr}(w),
$$
$$
 C_t^{\rm arr}(w)=\int_R^\infty r(w+v-2t)g(v)dv,
 \qquad
 P_t^{\rm arr}(w)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                 g(\log n-w+2t).
\tag{17}
$$
Here $g$ is zero outside its actual positive-half support, so no further artificial cutoff is imposed. All terms converge on this fixed collar by the actual theta envelope. The original ground equation, tested against $g1_{(R,R+t)}$, and translation invariance of the same-side form give
$$
\boxed{\begin{aligned}
 E_{\rm bd}(t)={}&4\int_R^{R+t}g(w)
 \left[A_0(w)-A_t(w)
       -d\{J(w)-J(w-t)\}g(w)\right]dw\\
 &-\{K(\ell_t)+dm_t\}.
\end{aligned}}
\tag{18}
$$
This is a weak form identity. The strip test is admissible by the established hard-indicator domain splitting; it does not assert that the translated history is in the operator domain, or differentiate $\psi$. One way to check the factors is to write $\mathscr B=K+d\langle\cdot,\cdot\rangle_J$. Then
$E_{\rm bd}=2\mathscr B(\ell_t,F_{-t})-\mathscr B(\ell_t,\ell_t)$, and the two identical boundary collars supply the factor four in (18).

The continuous arrival increases under inward displacement, so
$C_t^{\rm arr}\ge C_0^{\rm arr}$, and $J(w)\ge J(w-t)$. Consequently, in a prime-free collar where (16) makes the self-energy positive, the assertion $E_{\rm bd}\ge0$ would require
$$
\begin{aligned}
4\int_R^{R+t}g(w)
 [P_0^{\rm arr}(w)-P_t^{\rm arr}(w)]dw
\ge{}&K(\ell_t)+dm_t\\
 &+4d\int_R^{R+t}[J(w)-J(w-t)]g(w)^2dw\\
 &+4\int_R^{R+t}g(w)
       [C_t^{\rm arr}(w)-C_0^{\rm arr}(w)]dw.
\end{aligned}
\tag{19}
$$
Every term on the right is nonnegative in this regime. Thus this finite-deformation mechanism reduces the desired favorable boundary sign to a concrete, signed, ground-dependent prime-arrival inequality. The prime-free condition removes only lost–lost prime edges; it does not remove lost–retained prime edges in (17). No monotonicity of the actual rough ground profile is known that would give (19). Positive kernels alone have the wrong direction for that inference.

## Attribution and formal scope

This is written mathematics, with no Lean formalization of the displayed domain, transport or sampling estimates. The linked ground-state, theta-form and classical boundary estimates supply the stated domains. All arithmetic arrival terms and normalization costs are retained. No RH conclusion or passing full affine comparison is asserted.
