# Exponential physical sources as actual weak tests of the killed theta ground

The actual two-source coherent-core family has finite logarithmic Fourier energy but does not have the theta weighted source norm. It can nevertheless be paired with the actual exterior ground equation. The resulting identity is a mixed weak test, with the core arrival term and the spectral distance retained. It gives neither a covariance bound nor a sign for the coherent core.

Fix the actual core $C=[-R,R]$, its exterior $O=\mathbb R\setminus C$, and the positive even normalized killed ground $\psi$, extended by zero on $C$. Let
$$
G=\Phi\psi1_O,\quad b=2\cosh(v/2),\quad
J=b/\Phi,\quad \delta=1/2-\alpha>0.
$$
The actual ground is bounded, $\|\psi\|_\infty=P_\infty<\infty$. Its physical source $G$ belongs to the logarithmic Fourier form space $\mathcal H$ and has every absolute exponential moment. Write
$$
\mathscr K=A-S,\qquad
Sz(v)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
  [z(v+\log n)+z(v-\log n)],
$$
with the actual archimedean multiplier and every prime power. The letter $\mathscr K$ here denotes the physical form, not the positive covariance clock.

All pairings below are real; conjugation gives the complex version. The form and hard-cut domain statements used here are the public [theta jump eigenfunction regularity](theta-jump-eigenfunction-regularity.md) (16.1), [theta killed core return comparison](theta-killed-core-return-comparison.md), and [theta prime profile full form domain](theta-prime-profile-full-form-domain.md). These give admissible compact hard tests and bounded hard projections on $\mathcal H$.

## The mixed domain and the complete prime tail

Let $z\in\mathcal H$ be locally bounded and satisfy, for some $\beta>1/2$,
$$
|z(v)|\le C_z e^{-\beta|v|}\quad(v\in\mathbb R).
\tag{1}
$$
The bound can be imposed only outside a compact set and enlarged to (1). No membership of $z/\Phi$ in $L^2(\nu)$ is assumed.

The complete physical prime pairing is absolutely convergent. Indeed, for either sign,
$$
\int |G(v)z(v\pm\log n)|\,dv
\le C_z n^{-\beta}\int e^{\beta|v|}G(v)\,dv,
$$
so
$$
\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \int |G(v)|\bigl(|z(v+\log n)|+|z(v-\log n)|\bigr)\,dv
\le 2C_z\!\left(\int e^{\beta|v|}G(v)\,dv\right)
 \sum_{n\ge2}\frac{\Lambda(n)}{n^{\beta+1/2}}<\infty.
\tag{2}
$$
The last convergence follows even from $\Lambda(n)\le\log n$. It does not use PNT or a replacement of the prime measure by its density. The archimedean pairing is continuous on $\mathcal H\times\mathcal H$.

Put $z_L=1_{[-L,L]}z$. Uniform boundedness of hard projections and density of compact smooth functions give $z_L\to z$ in $\mathcal H$. Each $z_L/\Phi$ has finite theta norm and belongs to the actual form domain. Equation (2), dominated convergence, and the archimedean form convergence show
$$
\mathscr K(G,z_L)\longrightarrow\mathscr K(G,z).
\tag{3}
$$
The same conclusions apply after the fixed core or exterior projection.

## Extension of the ground equation, including the core

Define the actual positive core arrival, for almost every $v\in C$, by
$$
\mathcal B_R(v)=\int_O r(|v-w|)G(w)\,dw
 +\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
   [G(v+\log n)+G(v-\log n)],
\qquad r(s)=\frac{e^{-s/2}}{1-e^{-2s}}.
\tag{4}
$$
The continuous singularity at a hard boundary is handled by the crossing operator, not by asserting a uniformly bounded arrival rate. In fact $\mathcal B_R=bB^*\psi$ on $C$, so it belongs to $L^2(C,dv)$ by the bounded actual crossing theorem and equivalence of the smooth positive weights on $C$. Consequently its pairing against locally bounded $z$ is finite. This also identifies (4) with its complete weak arrival sum.

Apply the original killed ground equation to the compact test $1_Oz_L/\Phi$. The exact physical form relation gives
$$
\mathscr K(G,1_Oz_L)=-\delta\int_O b(v)\psi(v)z_L(v)\,dv.
$$
For the disjoint core test, the off-diagonal sign is negative:
$$
\mathscr K(G,1_Cz_L)=-\int_C\mathcal B_R(v)z_L(v)\,dv.
$$
Because $b(v)\le2e^{|v|/2}$, the exterior integrand is absolutely integrable under (1), using boundedness of $\psi$. Passing to the limit in (3) proves
$$
\boxed{\quad
\mathscr K(G,z)
=-\delta\int_O b(v)\psi(v)z(v)\,dv
  -\int_C\mathcal B_R(v)z(v)\,dv.
\quad}
\tag{5}
$$
Both integrals in (5) are retained. The expression on the right is minus pairing against a positive, locally finite measure
$$
d\eta_R=\delta1_O b\psi\,dv+1_C\mathcal B_R\,dv,
\tag{6}
$$
whose absolute exponential tests at rates greater than $1/2$ are finite. Its total mass is not asserted finite. In particular, a nonnegative admissible $z\not\equiv0$ has a nonpositive mixed form, with strict negativity when its positive set meets $O$ in positive measure.

## The actual coherent-core family

Consume the checked family in [actual core explicit weil cross family](actual-core-explicit-weil-cross-family.md), with its scaling kernel denoted here by $K_{\rm sc}$:
$$
h_t(v)=-\sqrt{te^{|v|}}K_{\rm sc}(te^{|v|}),\qquad
u_\beta(v)=\sqrt{2\beta}e^{-\beta v}1_{v\ge0},\qquad
z_t=\frac{\beta h_t-h_t'}{\sqrt{2\beta}},
\quad 1/2<\beta<1.
\tag{7}
$$
For each fixed $t>0$, the checked local BV regularity, logarithmic form energy, and exponential tails put all three sources under (1). Constants need not be uniform as $t\downarrow0$. The exact convolution identity $u_\beta*\widetilde z_t=h_t$ and its prime contribution $2Q(t)$ belong to that source; (5) does not replace this convolution by multiplication.

Since $G$, the form, and $\eta_R$ are even, odd parts of these weak tests vanish. Thus
$$
\boxed{\quad
\mathscr K(G,z_t)=\sqrt{\beta/2}\,\mathscr K(G,h_t)
=-\sqrt{\beta/2}\int h_t\,d\eta_R,
\quad}
\tag{8}
$$
and
$$
\mathscr K(G,u_\beta)
=-\sqrt{\beta/2}\int e^{-\beta|v|}\,d\eta_R<0.
\tag{9}
$$
The weak derivative $h_t'$ is odd; continuity of $h_t$ means its first derivative has no delta at the origin. Its cusp remains part of the archimedean form. Since $h_t$ is signed, positivity of $\eta_R$ supplies no sign in (8).

If pole projection adds fixed multiples of $\Phi$ and $\Phi'$, these also satisfy the test hypotheses. Formula (5) applies to each correction separately. No pole correction is discarded, and this extension does not identify the mixed ground row with the full Weil row between $u_\beta$ and $z_t$.

## The full mixed Weil row and its exact pole compensation

Let $\mu=\int\psi1_O\,d\nu=\int bG\,dv>0$ and $\lambda=1/2$. Evenness gives $M_{1/2}(G)=M_{-1/2}(G)=\mu/2$. The actual physical Weil form includes the polarized pole term, so its mixed row is
$$
Q(G,z)=\mathscr K(G,z)
 +M_{1/2}(G)M_{-1/2}(z)+M_{-1/2}(G)M_{1/2}(z).
$$
It follows directly from (5), retaining both poles, that
$$
\boxed{\quad
Q(G,z)=-\int z\,d\widetilde\eta_R,
\qquad
d\widetilde\eta_R=
\left[\delta1_O b\psi+1_C\mathcal B_R-\lambda\mu b\right]dv.
\quad}
\tag{10}
$$
The compensating term is a signed density on the whole line. None of the three terms in this measure is removed by a tail approximation. Each pairing in (10) converges under (1).

This also checks the literal two-pole projection in this mixed row. Define
$$
z^\circ=z-[M_{1/2}(z)+M_{-1/2}(z)]\Phi
-2[M_{-1/2}(z)-M_{1/2}(z)]\Phi'.
\tag{11}
$$
Using $M_s(\Phi)=1/2$ and $M_s(\Phi')=-s/2$ at $s=\pm1/2$ shows that both moments of $z^\circ$ vanish. The actual original identity $E(\psi1_O,1)=0$ and the physical form relation imply
$$
\mathscr K(G,\Phi)=-\lambda\mu,\qquad
\mathscr K(G,\Phi')=0.
$$
The second equality is parity, with both sides in their stated mixed domains. Therefore, without needing a new general radical theorem on exponential sources,
$$
\boxed{\qquad
Q(G,z^\circ)=\mathscr K(G,z^\circ)=Q(G,z).
\qquad}
\tag{12}
$$
This is an equality for the specified actual ground row. It does not claim that $z^\circ/\Phi$ has gained a finite theta norm.

For the actual family (7), let $H_t=M_{1/2}(h_t)=M_{-1/2}(h_t)$. Equations (8) and (10) give
$$
Q(G,z_t)=\sqrt{\beta/2}
\left[-\int h_t\,d\eta_R+\mu H_t\right]
=-\sqrt{\beta/2}\int h_t\,d\widetilde\eta_R.
\tag{13}
$$
Thus the small pole value $H_t$ has its exact coefficient, while the actual signed ground-arrival integral remains. The large pole derivative from the coherent-core source is not bounded or discarded by this identity.

This provides an actual ground-equation consumer for the exponential two-source family, despite the divergent individual theta norms. Obtaining a bound for $Q_{\rm core}(t)$, or for the constrained covariance error, requires a further signed estimate linking these mixed rows; none is assumed here.

## Attribution and formal scope

The domain and ground-transform inputs are proved in the linked theta chapters. The weak equation, parity and form-resolvent operations are classical methods, applied here with the full prime-power arrival and both poles retained. These mixed-domain, Green and correction identities are written proofs. The full mixed-domain identities are not yet formalized, and no sign for the remaining arithmetic row is asserted.

## Compiled prime-tail prerequisites

[WeakGroundPrimeTail.lean](BuildingBlocks/WeakGroundPrimeTail.lean) proves the exponential shift bounds, Bochner overlap integrability and domination, and absolute convergence of the complete prime row with both orientations and every integer n ≥ 2 retained. Its hypotheses include a nonnegative ground weight, the finite exponential moment, and measurable overlap integrands. Identifying these hypotheses for the killed ground, the logarithmic-form and archimedean cutoff limits, core arrivals, and the full weak ground equation remain written steps. See [the formalization source map](theta-exponential-weak-prime-tail-lean-prerequisites.md). These results do not prove covariance smallness or RH.

[WeakGroundPrimeCutoff.lean](BuildingBlocks/WeakGroundPrimeCutoff.lean) additionally proves the prime part of (3) along natural-number cutoff radii, with the indicator applied to the translated test coordinate. Bochner dominated convergence handles each overlap, and series dominated convergence retains both shifts and the complete Mangoldt row. See [the precise source map](theta-exponential-weak-prime-cutoff-limit.md). This does not certify the archimedean part of (3).

[ThetaExteriorPrimeIntegrability.lean](BuildingBlocks/ThetaExteriorPrimeIntegrability.lean) connects the literal theta moments to (2) for G(v)=1_(|v|>R) Phi(v) psi(v). It proves nonnegativity from psi >= 0 and derives every fixed exponential moment from almost-everywhere measurability and boundedness of psi. Consequently complete prime-overlap absolute summability no longer requires a separate moment premise. For continuous exponential tests, overlap measurability is also derived from the actual translated test and integrability of G. General exponential tests retain the explicit overlap-measurability premise.

This root integration preserves the exact exterior indicator, both orientations and every Mangoldt index. The multiplier psi is supplied with explicit hypotheses; the theorem does not construct or certify an eigenfunction. Actual ground existence, bounded representative identification, logarithmic form limits, continuous and prime core arrivals, and the full equation (5) remain separate formalization obligations. No sign for the signed test h_t follows.

All three new bridge declarations independently compile using only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in the new module. For the source z_t, whose derivative contact need not be continuous at zero, the general theorem retains measurable-overlap hypotheses rather than silently applying the continuous-test theorem.

[Literal complete core arrival](physical-ground-complete-core-arrival-foundation.md) compiles the complete prime-arrival series, almost-everywhere absolute convergence and an explicit local bound from the bounded exterior source. It also gives a written direct logarithmic bound for the continuous arrival and full core L2 regularity. The continuous and L2 consumers, actual ground construction and eigenvalue equation remain unformalized. No arithmetic sign or RH conclusion follows.
