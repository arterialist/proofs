# Actual continuous arrival converges at every interior core point

Use the literal published theta kernel, exterior source, and continuous kernel:
\[
G(w)=1_{\{|w|>R\}}\Phi(w)\psi(w),\qquad
r(s)=\frac{e^{-s/2}}{1-e^{-2s}}.
\]
Assume \(\psi\) is almost everywhere strongly measurable and \(|\psi|\le P\) almost everywhere, with \(P\ge0\). No eigenfunction property is assumed. The actual theta tail theorem gives
\[
|G(w)|\le P T e^{-|w|}\le M,\qquad M=PT,
\]
where \(T\) is the previously published tailConstant.

For any \(d>0\), the kernel is integrable on \((d,\infty)\). When \(d\le1\), continuity on \([d,1]\) gives integrability there, and the published exponential far bound gives integrability on \((1,\infty)\). Their union covers \((d,\infty)\). When \(d>1\), restriction of the far-tail theorem suffices. Consequently
\[
k_d(s)=1_{\{s>d\}}r(s)
\]
is integrable on the whole real line and nonnegative.

Fix \(|v|<R\), and put \(d=(R-|v|)/2>0\). The two functions \(k_d(v-w)\) and \(k_d(w-v)\) are integrable by translation and reflection of Lebesgue measure. If \(G(w)\ne0\), its exterior support gives \(|w|>R\). The triangle inequality then gives
\[
|v-w|\ge |w|-|v|>R-|v|>d.
\]
At least one of \(v-w,w-v\) equals \(|v-w|>d\), so
\[
r(|v-w|)\le k_d(v-w)+k_d(w-v).
\]
The source bound therefore yields the integrable domination
\[
|r(|v-w|)G(w)|
\le M[k_d(v-w)+k_d(w-v)].
\]
When \(G(w)=0\), the same inequality follows from nonnegativity of the majorant. The integrand is almost everywhere strongly measurable by the earlier source theorem and the measurable kernel.

Thus, for EVERY interior core point,
\[
\int_{\mathbb R}|r(|v-w|)G(w)|\,dw<\infty.
\]
[PhysicalContinuousSourceConvergence.lean](BuildingBlocks/PhysicalContinuousSourceConvergence.lean) formalizes this literal integrability statement. It discharges the nonintegrable-zero ambiguity in the previously defined Bochner parameter integral at these points, so continuousArrival is the actual absolutely convergent continuous arrival on the interior core. No finite boundary value or uniformly bounded arrival rate is asserted.

The next remaining connection is a quantitative logarithmic bound on this actual integral, followed by the already published squared core-majorant consumer. Interior integrability alone does not supply that global \(L^2\) conclusion. The complete prime part is handled separately with all prime powers and both shifts. The actual killed form, its spectral ground construction and boundedness, its operator equation, the complete weak ground identity with both pole corrections, and the arithmetic covariance residual estimate remain separate obligations. No RH conclusion follows.

The theta covariance research branch supplied these five declarations. Root independently reviewed the almost-everywhere source bound, strict interior distance, hard support, both signed directions and translated whole-line domination. These are classical integrability arguments; no novelty claim is made.

## A direct written bound using the same majorant

The majorant in the compiled convergence proof gives, for d=(R-|v|)/2 and M=PT,
\[
|B_c(v)|\le2M\int_d^\infty r(s)\,ds.
\]
The two translated positive kernels have the same whole-line integral. Splitting at 1 and using the compiled near and far estimates gives
\[
\int_d^\infty r(s)\,ds\le\frac32\ell(d)+\frac2{1-e^{-2}},\qquad d>0.
\]
For d greater than 1, the near part is absent and the far estimate alone suffices. For the interior distances, R-|v| is the minimum of R-v and R+v. Since ell is nonnegative and decreasing on the positive axis,
\[
\ell\!\left(\frac{R-|v|}2\right)
 \le\ell(R-v)+\ell(R+v)+\log2.
\]
Thus the actual arrival has the written bound
\[
|B_c(v)|\le M\left[3\ell(R-v)+3\ell(R+v)+3\log2+\frac4{1-e^{-2}}\right].
\]
This is the compiled `coreMajorant` with multiplier 2M and constant c=(3 log2+4/(1-exp(-2)))/2. Its square is already known integrable. Together with parameter measurability it proves the written full continuous core L2 conclusion. The displayed integral comparisons and their connection to the actual arrival still require Lean formalization; this paragraph does not extend the compiled declaration count. Root independently recorded this domination route; the theta covariance branch is formalizing the same route. It does not require the sharper directional constants.

All five printed declarations independently compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.
