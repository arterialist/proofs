# Literal exterior source and complete core arrival

Let \(R>0\), \(C=[-R,R]\), and let the real function \(\psi\) be almost everywhere measurable with \(|\psi|\le P\), where \(P\ge0\). Use the literal theta series \(\Phi\) from `PhysicalThetaSeries`, with its proved parity and exponential tails. Define
\[
G(w)=1_{\{|w|>R\}}\Phi(w)\psi(w),\qquad
T=A\exp\!\left(\frac{(9/2+1)^2}{2\pi}\right),\quad M=PT.
\]
Here \(A\) is the finite amplitude in `PhysicalThetaMoments`. Its actual tail theorem gives \(\Phi(w)\le T e^{-|w|}\), hence \(|G(w)|\le M e^{-|w|}\le M\) almost everywhere. No ground or eigenfunction property is assumed by these definitions.

## Compiled prime arrival

The Lean module [PhysicalGroundPrimeArrival.lean](BuildingBlocks/PhysicalGroundPrimeArrival.lean) defines exactly
\[
B_p(v)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [G(v+\log n)+G(v-\log n)],\qquad
D=\sum_{n\ge2}\frac{\Lambda(n)}{n^{3/2}}<\infty.
\]
Every prime power and both orientations remain in the sum. Translation preserves Lebesgue measure; the countable intersection of the translated almost everywhere bounds therefore controls all sampled arguments for almost every (v). The individual absolute summand is bounded by
\[
2M e^{|v|}\frac{\Lambda(n)}{n^{3/2}}.
\]
Consequently the sum is absolutely convergent almost everywhere and
\[
|B_p(v)|\le2MD e^{|v|}.
\]
These statements and the source's exponential moment integrability are compiled. All eight printed declarations use only `propext`, `Classical.choice`, and `Quot.sound`; the build has no warnings. Measurability and the following \(L^2\) consumers are written analysis here, not additional compiled declarations. The measurable partial sums converge almost everywhere, so \(B_p\) has an almost everywhere measurable representative. In particular
\[
\int_C |B_p(v)|^2\,dv\le 8R M^2D^2e^{2R}.
\tag{1}
\]

## The continuous arrival has a logarithmic boundary bound

Retain the literal continuous kernel
\[
r(s)=\frac{e^{-s/2}}{1-e^{-2s}},\qquad
B_c(v)=\int_{|w|>R}r(|v-w|)G(w)\,dw.
\]
For \(s>0\), \(1-e^{-2s}\ge2s/(1+2s)\), so
\[
sr(s)\le(1/2+s)e^{-s/2}\le2e^{-3/4}<1.
\]
For \(s\ge1\), also \(r(s)\le e^{-s/2}/(1-e^{-2})\). Put
\[
\ell(d)=\max(0,-\log d)\quad(d>0),\qquad
c=\frac4{1-e^{-2}}.
\]
For \(-R<v<R\), the right and left exterior distances start at \(d_+=R-v\) and \(d_-=R+v\). The part with \(s<1\) on either side has absolute integral at most \(M\int_d^1 ds/s=M\ell(d)\) when \(d<1\), and is absent when \(d\ge1\). The two parts with \(s\ge1\) together are bounded by \(Mc\), since each is at most \(2M/(1-e^{-2})\). Thus the integral is absolutely convergent and
\[
|B_c(v)|\le M[\ell(R-v)+\ell(R+v)+c].
\tag{2}
\]
The two boundary points may be discarded as a null set; no bounded arrival rate is asserted there. Parameter-integral measurability follows from the measurable kernel and source, with absolute convergence in the interior. Moreover
\[
\int_0^{2R}\ell(d)^2\,dd\le\int_0^1(-\log d)^2\,dd=2.
\]
Using \((a+b+c)^2\le3(a^2+b^2+c^2)\) in (2) gives the explicit bound
\[
\int_C |B_c(v)|^2\,dv\le M^2(12+6Rc^2).
\tag{3}
\]
This proves continuous core arrival regularity directly from the bounded literal source; it does not invoke an already identified crossing operator.

## Full arrival and the remaining ground identification

Combining (1) and (3), the complete literal arrival
\[
\mathcal B_R=B_c+B_p
\]
belongs to \(L^2(C,dv)\), with
\[
\|\mathcal B_R\|_2^2
\le M^2(24+12Rc^2+16RD^2e^{2R}).
\]
If \(\psi\ge0\) almost everywhere, both arrivals and their sum are nonnegative almost everywhere. Every locally bounded test on the core pairs absolutely with this arrival, by Cauchy–Schwarz on the finite interval.

This supplies the literal arrival object and its local regularity. It does not construct the normalized positive even killed ground, identify its closed-form or operator domain, or prove its eigenvalue equation. To obtain the actual weak identity one must still construct that ground and establish, with the actual physical form,
\[
\mathscr K(G,z)
=-\delta\int_O 2\cosh(v/2)\psi(v)z(v)\,dv
-\int_C\mathcal B_R(v)z(v)\,dv.
\]
The continuous arrival cannot be omitted, and this equation cannot be made a definition of an arbitrary bounded \(\psi\). The full Weil row additionally retains both pole terms and the exact \(\Phi,\Phi'\) projection corrections. Arrival positivity alone does not sign the original coherent-core family or prove the covariance residual estimate. No RH conclusion follows from these bounds.

The theta covariance research branch supplied this arrival construction and proof. Root independently reviewed the translated almost-everywhere hypotheses, complete prime-power series and the direct continuous boundary estimate. The methods are classical domination, translation invariance and logarithmic integrability; no novelty claim is made.

[Continuous arrival kernel foundation](physical-continuous-arrival-kernel-lean-foundation.md) compiles the literal kernel bounds, its logarithmic boundary primitive and far-tail integrability. The source parameter integral, full core L2 consumer and actual weak-ground equation remain further obligations.

[Continuous arrival measurability and squared boundary](physical-arrival-boundary-measurability-lean-foundation.md) compiles source and parameter-integral measurability, squared-logarithm integrability at both core boundaries and the full logarithmic squared majorant. Absolute convergence and the majorant inequality for the actual arrival remain separate consumers.

[Complete prime arrival core regularity](physical-prime-arrival-core-regularity.md) now compiles almost-everywhere strong measurability and actual core L2 membership from the literal bounded exterior source, retaining every prime power and both orientations. The full continuous arrival and weak-ground equation remain separate consumers.

[Actual continuous source interior convergence](physical-continuous-source-interior-convergence.md) now compiles absolute integrability of the literal continuous arrival at every interior core point from a bounded measurable exterior multiplier. This resolves the total-integral convention there. Its quantitative boundary bound, full continuous core L2 consumer and weak-ground equation remain unfinished.
