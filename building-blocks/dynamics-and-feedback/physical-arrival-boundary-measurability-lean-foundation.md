# Literal continuous arrival measurability and squared boundary logarithms

[PhysicalArrivalBoundary.lean](../../formalization/BuildingBlocks/PhysicalArrivalBoundary.lean) defines
\[
B_c(v)=\int_{\mathbb R}r(|v-w|)\,1_{\{|w|>R\}}\Phi(w)\psi(w)\,dw,
\qquad \ell(d)=\max(0,-\log d).
\]
The kernel and source are imported from the literal published continuous-kernel and complete prime-arrival modules.

Almost everywhere strong measurability of \(\psi\) gives almost everywhere strong measurability of the exterior source: \(\Phi\) is continuous and the exterior set is measurable. The kernel \(r(|v-w|)\) is jointly measurable, including its Lean value at \(v=w\). Multiplication by the source composed with the second projection gives an almost everywhere strongly measurable integrand on the product Lebesgue space. The parameter-integral theorem then proves almost everywhere strong measurability of \(B_c\).

This theorem requires no bound on \(\psi\). It consequently does not assert absolute convergence of the integral. Lean's Bochner integral assigns zero to a nonintegrable function; actual interior integrability must still be proved before this definition is identified with the absolutely convergent arrival in the written analysis. No ground property is encoded in the definition.

The boundary integrability proof uses the explicit majorant
\[
(\log x)^2\le16x^{-1/2},\qquad 0<x\le1.
\]
Indeed, the real-power logarithm estimate gives \(|\log x|x^{1/4}\le4\). Squaring and multiplying by \(x^{-1/2}\) gives the majorant. The latter is integrable on \((0,1)\), since its exponent exceeds \(-1\). Thus the squared logarithm is integrable there.

For positive \(x\), \(\ell(x)^2\) equals the indicator of \((0,1)\) times \((\log x)^2\). Restricting that globally integrable indicator proves
\[
\ell^2\in L^1((0,L))
\]
for every real \(L\), including empty intervals. Translation and reflection then prove, for \(R>0\),
\[
\ell(R-v)^2,\ \ell(R+v)^2\in L^1((-R,R)).
\]
Boundary point values have no effect on these Lebesgue statements.

The parameter measurability and squared-logarithm facts are prerequisites for the written continuous-arrival bound. The inequality for the literal parameter integral, its absolute convergence at interior core points, and its full core \(L^2\) conclusion remain to be connected in Lean. The published prime module retains all prime powers and both shifts. Neither these results nor arrival positivity construct a killed ground, prove its operator equation, identify the coherent-core signed row, or cancel the two Weil poles. RH and the arithmetic covariance residual estimate remain open.

Root also formalizes squared integrability of the complete logarithmic majorant
\[
J_{R,M,c}(v)=M\left[\frac32\ell(R-v)+\frac32\ell(R+v)+c\right],
\qquad R>0.
\]
The theorem is valid for arbitrary real M and c. It combines the two shifted squared-logarithm integrals and the finite-interval constant integral, using the pointwise bound
\[
J_{R,M,c}(v)^2\le9M^2\left[\ell(R-v)^2+\ell(R+v)^2+c^2\right].
\]
This supplies the integrable squared majorant for the planned arrival estimate. It does not assert that the literal continuous arrival satisfies that estimate or that its defining integral is absolutely convergent. Those source consumers remain separate obligations.

The theta covariance research branch supplied six declarations. Root independently reviewed the actual source and product-space measurability, the total integral convention, power domination and translated boundary intervals. Root supplied the squared-majorant consumer. The methods are classical measurability and integrable domination; no novelty claim is made.

All seven printed declarations independently compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.
