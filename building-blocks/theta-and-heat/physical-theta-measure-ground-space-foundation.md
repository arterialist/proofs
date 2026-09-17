# Literal theta measure and physical ground-space dictionary

[PhysicalThetaMeasure.lean](../../formalization/BuildingBlocks/PhysicalThetaMeasure.lean) uses the actual published theta series and defines
\[
b(v)=e^{v/2}+e^{-v/2}=2\cosh(v/2),\qquad
m(v)=b(v)\Phi(v),\qquad d\nu=m(v)\,dv,\qquad J(v)=b(v)/\Phi(v).
\]
GroundSpace is the actual real Lp space with exponent 2 and measure \(\nu\). ExteriorGroundSpace uses its restriction to \(\{|v|>R\}\), the actual killed exterior Hilbert space. The exterior measure is also finite. These names specify the spaces where an operator and ground must be constructed; they contain no chosen ground, spectral premise, or operator.

The module proves \(b,m>0\), continuity of \(m\), and measurability of the ENNReal density used by withDensity. Since each term of \(b(v)\) is at most \(e^{|v|/2}\),
\[
0<m(v)\le2e^{|v|/2}\Phi(v).
\]
The already proved literal theta exponential moment at rate \(1/2\) therefore gives integrability of \(m\), and the measure \(\nu\) is finite.

The module does not prove \(\nu(\mathbb R)=1\). The written theta chapter's probability normalization uses its separate exact moment/xi identity; no probability or mass-one instance is inferred from finiteness here.

Strict positivity of the density gives mutual absolute continuity with Lebesgue measure. Consequently almost everywhere propositions, almost everywhere equalities (through the proposition dictionary), and almost everywhere strong measurability transfer in both directions. Thus a measurability or essential-bound conclusion eventually proved in the actual ground Hilbert space will meet the Lebesgue hypotheses of the published literal arrival/moment theorems. This is a measure transfer, not a proof of ground boundedness.

For every real function \(\psi\), the pointwise physical-square identity is
\[
m(v)\psi(v)^2=J(v)(\Phi(v)\psi(v))^2.
\]
The finite measurable density version of the withDensity lintegral theorem then gives the exact extended identity
\[
\int \operatorname{ofReal}(\psi^2)\,d\nu
=\int \operatorname{ofReal}(J(\Phi\psi)^2)\,dv.
\]
No finiteness or measurability of \(\psi\) is assumed for this extended nonnegative integral identity. For almost everywhere strongly measurable \(\psi\) in \(\nu\), the module proves
\[
\psi\in L^2(\nu)
\iff \int \operatorname{ofReal}(J(\Phi\psi)^2)\,dv<\infty.
\]
The exported Lean formulation of the right side is that the ENNReal integral is not infinity. The theorem uses the ordinary real squared-integrability characterization of MemLp exponent 2.

This is the literal weighted norm dictionary needed by the actual killed construction. It does not identify the physical weighted source norm with a logarithmic Fourier norm or admit the exponential weak family into the ground Hilbert space. The complete killed jump form, closability/maximal-domain identification, operator representation, exterior spectral ground existence/simplicity and boundedness, and full weak equation remain to be formalized. No arbitrary \(\psi\) is defined to satisfy that equation, and no pole correction or prime orientation is removed. This module gives no arithmetic residual estimate, sharp gap, or RH conclusion.

The covariance branch supplied the fifteen measure and norm declarations. Root independently reviewed the literal density, exponential domination, both absolute-continuity directions and the extended integral identity. These use classical weighted-measure results; no novelty claim is made.

## Arrival from exterior-space hypotheses alone

[PhysicalExteriorArrival.lean](../../formalization/BuildingBlocks/PhysicalExteriorArrival.lean) is a root consumer of the measure dictionary and complete core-arrival theorem. It assumes almost everywhere strong measurability and the bound |psi|<=P only in exteriorNu R, with P>=0 and R>0. It proves that the zero exterior extension is globally Lebesgue almost everywhere strongly measurable and bounded, by the measurable-indicator restriction theorem and the null-set dictionary.

The literal source is unchanged by this zero extension, pointwise for every input. Both the continuous integral and the full prime-arrival series therefore remain unchanged. Consequently the actual completeCoreArrival R psi belongs to L2 on the closed core under exterior-space hypotheses alone. No regularity or boundedness of psi on the killed core is assumed, and no core values are changed in the conclusion. The source already suppresses those values. These six further declarations derive this domain transfer; they do not establish the missing boundedness of an actual ground or its operator equation.

All twenty-one declarations independently compile with only propext, Classical.choice and Quot.sound. Both changed modules are warning-free, and the combined BuildingBlocks library builds successfully.
