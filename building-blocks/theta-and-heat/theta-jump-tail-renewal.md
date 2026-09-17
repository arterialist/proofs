# Theta jump tail renewal and two contraction obstructions

For the actual closed theta jump form, the semigroup has a finite-time return law at both spatial tails. The folded semigroup fails to preserve increasing functions, and no positive uniform Euclidean Lipschitz contraction holds. The proofs retain all prime powers and the continuous infinite activity. Neither obstruction decides the $L^2(\nu)$ spectral gap.

Use the full kernel $\Phi$, $\lambda=1/2$, $d\nu=2\cosh(u/2)\Phi(u)du$, $\mu_\pm=(1\pm\tanh(u/2))\nu$ and $r(a)=e^{-a/2}/(1-e^{-2a})$ from the [ground-state chapter](theta-weil-jump-form.md). The operator $\mathcal L\ge0$ is associated with its positive jump form; the Markov generator is $\mathcal G=-\mathcal L$. The [regularity chapter](theta-jump-eigenfunction-regularity.md) proves the maximal-domain statement used below. Section numbers continue those chapters. These are written proofs, not Lean formalizations.

## 19. Actual finite-time tail renewal

Write $P_t=e^{-t\mathcal L}$ and
$\|f\|_{\rm BL}=\|f\|_\infty+\operatorname{Lip}(f)$.
For every finite $T$, the actual closed semigroup has bounded Lipschitz representatives satisfying
$$
\sup_{0\le s\le T}\operatorname{Lip}(P_s f)
\le C_T\|f\|_{\rm BL},\qquad
\|P_s f\|_\infty\le\|f\|_\infty.
\tag{19.1}
$$
No global contraction rate is asserted in the first inequality.

To prove this with the infinite activity retained, let $\mathcal G_\varepsilon$ omit only archimedean displacements $a<\varepsilon$, keeping every prime power. Put $c(u)=1/(2\cosh(u/2))$. Its total rate is bounded uniformly in $u$ by $C(1+\log(1/\varepsilon))$, so $P_t^\varepsilon=e^{t\mathcal G_\varepsilon}$ is a conservative sup-norm contraction. For bounded $C^1$ functions,
$$
(\mathcal G_\varepsilon g)'=
\mathcal G_\varepsilon g'+B_\varepsilon g.
$$
The derivative of each rate coefficient is
$c'(u)\Phi(u\pm a)+c(u)\Phi'(u\pm a)$.
Grouping the prime powers into unit intervals of $\log q$, Chebyshev's estimate and theta decay give
$$
\sup_u c(u)\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
\left(|\Phi'(u-\log q)|+|\Phi'(u+\log q)|\right)<\infty.
$$
The same bound with $\Phi$ controls the $c'$ term. For the continuous part use
$|g(u\pm a)-g(u)|\le\min(a\|g'\|_\infty,2\|g\|_\infty)$.
Since $\int_0^1a r(a)\,da<\infty$,
$$
\|B_\varepsilon g\|_\infty
\le C_0\|g\|_\infty+C_1\|g'\|_\infty
\tag{19.2}
$$
uniformly in $\varepsilon$. Duhamel's formula and Gronwall give (19.1) for the truncated semigroups. Uniform smooth approximation extends it to bounded Lipschitz tests.

For $0<\delta<\varepsilon$, the compensated omitted integrand gives
$$
\|(\mathcal G_\varepsilon-\mathcal G_\delta)g\|_\infty
\le C\varepsilon\operatorname{Lip}(g),
\qquad
\sup_{t\le T}\|P_t^\varepsilon f-P_t^\delta f\|_\infty
\le C_T\varepsilon\|f\|_{\rm BL}.
\tag{19.3}
$$
Thus the truncated semigroups converge uniformly on every bounded time interval. Their positive forms increase to the full edge form. The maximal-form/core equivalence in [section 16 of the regularity chapter](theta-jump-eigenfunction-regularity.md) identifies the limit with the original closed form; the increasing closed-form convergence theorem gives strong resolvent and hence strong $L^2(\nu)$ semigroup convergence. This identifies the uniform limit with $P_t$. The standard form theorem is stated, with historical attribution, in [Simon, Theorem 10.12](https://math.caltech.edu/SimonPapers/R61.pdf). No alternative boundary extension or $C_0$-Feller hypothesis is needed.

In particular the integrated evolution equation holds in sup norm. Indeed (19.1), (19.3), and the bounded generator estimate imply
$$
\sup_{s\le T}\|
\mathcal G_\varepsilon P_s^\varepsilon f-\mathcal G P_s f
\|_\infty
\le C_T\varepsilon(1+\log(1/\varepsilon))\|f\|_{\rm BL}.
$$
Passing to the limit in the bounded-generator equation gives
$P_t f=f+\int_0^t\mathcal G P_s f\,ds$.
The integrand is continuous in time: for fixed $\varepsilon$, $\mathcal G_\varepsilon P_s f$ is sup-norm continuous, and its difference from $\mathcal G P_s f$ is uniformly $O_T(\varepsilon)$.

Let
$$
\epsilon(u)=\omega_\psi(e^{u/2})+e^{-u}+e^{-c e^u},
\qquad
\omega_\psi(Y)=\sup_{x\ge Y}|\psi(x)/x-1|.
$$
The Stieltjes integration-by-parts proof of the prime return estimate applies to bounded Lipschitz tests, since $\Phi g$ is absolutely continuous with the needed derivative bound almost everywhere. Both that estimate and the compensated archimedean estimate are uniform on bounded BL balls. Applying them to (19.1) gives
$$
\frac{d}{dt}P_t f(u)+\lambda P_t f(u)
=\lambda\mu_-(P_t f)+r_u(t),\qquad
\sup_{t\le T}|r_u(t)|\le C_T\|f\|_{\rm BL}\epsilon(u).
$$
Therefore, uniformly for $0\le t\le T$ as $u\to+\infty$,
$$
\boxed{
P_t f(u)=e^{-\lambda t}f(u)
+\lambda\int_0^t e^{-\lambda(t-s)}\mu_-(P_s f)\,ds
+O_T(\|f\|_{\rm BL}\epsilon(u)).
}
\tag{19.4}
$$
Reflection gives the negative-tail formula with $\mu_+$. The exponential factor follows from the limiting evolution equation, without assuming an event with no archimedean jumps.

For even $f$, reflection symmetry keeps $P_s f$ even, and conservation gives $\mu_-(P_s f)=\nu(P_s f)=\nu f$. Thus
$$
\boxed{
P_t f(u)=e^{-\lambda t}f(u)+(1-e^{-\lambda t})\nu f
+O_T(\|f\|_{\rm BL}\epsilon(|u|))
\quad(f\text{ even}).
}
\tag{19.5}
$$
This is an actual finite-time stationary return law in the even sector. Its constants depend on $T$; it gives no estimate for all starting points or a sharp global spectral contraction.

## 20. Folded stochastic order is broken by the actual first prime jump

The even sector can be identified with functions on $r=|u|\ge0$. Its prime generator is
$$
\mathcal G_{\rm p}H(r)=\frac1{2\cosh(r/2)}
\sum_q\frac{\Lambda(q)}{\sqrt q}
\left[\Phi(r+\log q)(H(r+\log q)-H(r))
+\Phi(|r-\log q|)(H(|r-\log q|)-H(r))\right].
\tag{20.1}
$$
The continuous part replaces the prime sum by the integral against $r(a)\,da$. All prime powers remain in (20.1).

Set $a=\log2$, $b=3a/4$, and $r_0=a/4$. For starting points below $b$, the rate of entering $[b,\infty)$ has a strictly downward discontinuity at $r_0$: the reflected $q=2$ destination $a-r$ leaves this set as $r$ increases through $r_0$. Every forward prime-power destination and every reflected destination for $q\ge3$ stays above $b$ near $r_0$. The jump in this upward rate is exactly
$$
J=\frac{\log2}{\sqrt2}
\frac{\Phi(3\log2/4)}{2\cosh(\log2/8)}>0.
\tag{20.2}
$$
The complete remaining prime series is smooth locally. The continuous upward rate is
$$
\frac1{2\cosh(r/2)}
\int_b^\infty\Phi(v)[r(v-r)+r(v+r)]\,dv;
$$
it is smooth because $b-r$ stays strictly positive. These contributions cannot cancel (20.2).

A smooth test proves a semigroup obstruction without assigning a generator value to the discontinuous indicator. Put $h_0=a/16$, $I=[r_0-h_0,r_0+h_0]$. Choose smooth increasing $H_\delta$, zero below $b-\delta$, one above $b+\delta$, and set
$r_\pm=r_0\pm h$, $\delta=h/2$. For small $0<h\le h_0$, both initial values $H_\delta(r_\pm)$ are zero. The reflected $q=2$ target has value one at $r_-$ and zero at $r_+$, whereas all the other prime targets have value one at both points.

After removing that single reflected atom, denote the remaining generator contribution by $B_\delta(r)$. There is a constant $C$, independent of small $\delta$, with $\sup_I|B_\delta'|\le C$. For the continuous term, change to destination variable $v$; the derivative then falls on $r(v-r)+r(v+r)$, away from its diagonal singularity. Theta decay controls the full differentiated prime series. With
$$
J_* =\min_{r\in I}\frac{\log2}{\sqrt2}
\frac{\Phi(a-r)}{2\cosh(r/2)}>0,
$$
one has
$$
\mathcal G H_\delta(r_-)-\mathcal G H_\delta(r_+)
\ge J_*-2Ch>0
\tag{20.3}
$$
whenever $h<\min(h_0,J_*/[4(C+1)])$.

The even extension $H_\delta(|u|)$ is smooth, is constant outside a compact interval, and belongs to the actual operator domain. Alternatively section 19 directly supplies its pointwise sup-norm evolution equation. Since its values agree at $r_-$ and $r_+$, (20.3) implies
$P_tH_\delta(r_-)>P_tH_\delta(r_+)$ for all sufficiently small positive $t$.
Thus the folded semigroup does not preserve increasing functions. Centering the test leaves the contradiction unchanged, as does any increasing change of coordinate. This excludes the proposed stochastic-order route to a Sturm-type gap argument. It does not exclude every weaker single-crossing condition on a specially restricted test class; such a condition is not equivalent to stochastic order.

## 21. No positive uniform Euclidean Lipschitz contraction

There is no $K>0$ such that
$$
\operatorname{Lip}(P_t f)\le e^{-Kt}\operatorname{Lip}(f)
\quad\text{for every bounded Lipschitz }f\text{ and every }t\ge0.
\tag{21.1}
$$
Consequently the corresponding uniform Euclidean $W_1$ contraction of transition laws also cannot hold. The obstruction retains the continuous infinite activity, and is stronger than an assertion about the singularity of atomic measures.

Choose $\beta\in C_c^\infty([-4,4])$ with $\beta(0)=0$, $\beta'=1$ on $[-1/2,1/2]$, $|\beta'|\le1$, and $|\beta|\le1$. Such a function results by integrating a smooth even zero-integral derivative consisting of one central positive bump and two disjoint compensating negative bumps. For large $u>0$, put
$$
Q=\lfloor e^{2u}\rfloor,\qquad \delta=(100Q^2)^{-1},\qquad
Z_u=\{u\}\cup\{u\pm\log q:q\le Q,\ \Lambda(q)>0\},
$$
$$
f_u(x)=\delta\sum_{z\in Z_u}\beta((x-z)/\delta).
\tag{21.2}
$$
Different centers have separation at least $1/(2Q)$, so their supports are disjoint. Thus $f_u$ is compact smooth, $\operatorname{Lip}(f_u)=1$, $\|f_u\|_\infty\le\delta$, and its derivative is one near every center.

Every actual prime destination has function value zero: selected destinations are centers, and destinations for $q>Q$ lie beyond all bump supports, at distance at least $\log((Q+1)/Q)>4\delta$ from the nearest possible selected endpoint. Hence the rate-derivative terms vanish exactly when differentiating $\mathcal G_{\rm p}f_u$ at $u$. The selected destination slopes are one and the remaining ones zero, so
$$
(\mathcal G_{\rm p}f_u)'(u)
=-\frac1{2\cosh(u/2)}
\sum_{q>Q}\frac{\Lambda(q)}{\sqrt q}
[\Phi(u+\log q)+\Phi(u-\log q)].
\tag{21.3}
$$
All omitted destinations have absolute value at least $u-\log2$. Grouping prime powers in unit logarithmic intervals and using Chebyshev's bound makes (21.3) superexponentially small.

For the archimedean derivative, write
$(\mathcal G_{\rm arch}f_u)'=\mathcal G_{\rm arch}f_u'+B_{\rm arch}f_u$, as in section 19. The first term has no contribution for $a<\delta/2$, because the derivative is exactly one there. On $\delta/2\le a\le1$, bound the derivative difference by two; on $a>1$, use the complete continuous incoming rate. With $c(u)=1/(2\cosh(u/2))$,
$$
\mathcal G_{\rm arch}f_u'(u)
\ge-Ce^{-u}-C\log(2/\delta)c(u)
\sup_{|v-u|\le1}\Phi(v).
$$
The coefficient-derivative term uses
$|f_u(u\pm a)-f_u(u)|\le\min(a,\delta)$, which cancels the diagonal singularity:
$$
|B_{\rm arch}f_u(u)|
\le C\delta e^{-u}
+C\delta\log(2/\delta)c(u)
\sup_{|v-u|\le1}[\Phi(v)+|\Phi'(v)|].
$$
Since $\log(2/\delta)=O(u)$, the local theta terms decay superexponentially. Therefore
$$
\boxed{(\mathcal G f_u)'(u)\ge-Ce^{-u},
\qquad f_u'(u)=1,\qquad\|f_u\|_\infty\longrightarrow0.}
\tag{21.4}
$$
No bound uniform in $u$ on higher derivatives of the tests is used.

If (21.1) held, take $v>u$ within the interval where $f_u'=1$. Its initial difference is $v-u$. The sup-norm evolution equation from section 19 gives, after letting $t\downarrow0$ at these two fixed points,
$$
\frac{\mathcal Gf_u(v)-\mathcal Gf_u(u)}{v-u}\le-K.
$$
Now let $v\downarrow u$; smoothness of the generator expression gives $(\mathcal Gf_u)'(u)\le-K$, contradicting (21.4) for large $u$. Bounded Lipschitz duality makes this also a necessary condition for the stated $W_1$ estimate.

This closes uniform positive infinitesimal Euclidean contraction as a proof mechanism. It does not decide nonexpansion at $K=0$, a different metric, fixed-time smoothing, estimates with a prefactor, or the $L^2(\nu)$ spectral gap. In particular the finite-time stationary return in (19.5) and the failure of (21.1) are compatible.

