# Complete literal core arrival belongs to L2

For \(R>0\), define the actual exterior source and complete arrival by
\[
G(w)=1_{\{|w|>R\}}\Phi(w)\psi(w),\qquad
B_c(v)=\int r(|v-w|)G(w)\,dw,
\]
\[
B_p(v)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [G(v+\log n)+G(v-\log n)],\qquad \mathcal B_R=B_c+B_p.
\]
The literal \(\Phi\), kernel \(r(s)=e^{-s/2}/(1-e^{-2s})\), source, and prime series are the published definitions. Assume \(\psi\) is almost everywhere strongly measurable and \(|\psi|\le P\) almost everywhere, where \(P\ge0\). No ground/eigenfunction property is assumed.

## Quantitative kernel mass

The published kernel-away-from-zero integrability theorem discharges convergence for every \(d>0\). Splitting \((d,\infty)\) into \((d,1]\) and \((1,\infty)\) when \(d\le1\), the near logarithmic primitive and far exponential estimate prove
\[
\int_d^\infty r(s)\,ds
\le\frac32\ell(d)+\frac2{1-e^{-2}},
\qquad \ell(d)=\max(0,-\log d).
\]
For \(d\ge1\), comparison with the exponential tail gives the constant bound directly. The exact exponential-majorant integral is
\[
\int_d^\infty\frac{e^{-s/2}}{1-e^{-2}}\,ds
=\frac{2e^{-d/2}}{1-e^{-2}}.
\]
The exported mass estimates contain no additional integrability premise.

## Bound for the actual source integral

Let \(T\) be the published theta tailConstant and \(M=PT\). For \(|v|<R\), put \(d=(R-|v|)/2>0\). The support-separation argument gives
\[
|r(|v-w|)G(w)|\le
M[k_d(v-w)+k_d(w-v)],\qquad k_d(s)=1_{\{s>d\}}r(s).
\]
Both majorant terms are integrable. The actual source integral is already proved absolutely convergent at every interior core point. Integral monotonicity, the norm-integral bound, and translation/reflection invariance now prove
\[
|B_c(v)|\le2M\left[\frac32\ell(d)+\frac2{1-e^{-2}}\right].
\]
This inequality is about the literal source integral, not a postulated arrival profile.

The logarithm division identity gives
\[
\ell(d_0/2)\le\ell(d_0)+\log2\quad(d_0>0).
\]
Since \(R-|v|\) equals one of \(R-v,R+v\), and both boundary logarithms are nonnegative,
\[
\ell((R-|v|)/2)\le\ell(R-v)+\ell(R+v)+\log2.
\]
Consequently
\[
|B_c(v)|\le
2M\left[\frac32\ell(R-v)+\frac32\ell(R+v)
+\frac32\log2+\frac2{1-e^{-2}}\right].
\]
This is exactly the published coreMajorant with multiplier \(2M\) and constant \(3\log2/2+2/(1-e^{-2})\).

## Full core regularity and scope

The published squared-majorant theorem and almost everywhere measurability of \(B_c\) give square integrability and MemLp exponent 2 on the open core. The open and closed core restrictions of Lebesgue measure are equal, so the result transfers to \([-R,R]\). Boundary values are irrelevant to this transfer; finite pointwise boundary arrivals are not asserted.

The independently published complete prime-arrival MemLp theorem applies on that same closed core with the same source hypotheses. Addition therefore gives
\[
\mathcal B_R\in L^2([-R,R],dv),\qquad
\int_{[-R,R]}|\mathcal B_R|^2\,dv<\infty.
\]
[PhysicalContinuousArrivalMass.lean](BuildingBlocks/PhysicalContinuousArrivalMass.lean) exports the kernel mass estimates, actual source bound, continuous regularity, literal completeCoreArrival, and complete core MemLp/square-integrability conclusions. Every prime power and both orientations remain. The constants are deliberately loose; numerical L2 integral constants are not separately exported.

This completes the literal arrival regularity prerequisite for bounded measurable input. Constructing the actual normalized positive even killed ground, proving its boundedness from its actual operator equation, identifying the full closed form and crossing adjoint, and proving the weak mixed-ground identity remain separate Lean obligations. The actual Weil identity additionally retains both pole terms and its exact theta/derivative projection corrections. No ground is defined by assuming that identity, and no arithmetic residual sign, sharp gap, or RH result is established here.

The theta covariance branch supplied these fourteen proofs. Root independently reviewed the actual integral, both translated majorants, the endpoint null-set transfer and the complete prime-series consumer, and compiled the central module. These are classical domination and logarithmic integrability methods; no novelty claim is made.
