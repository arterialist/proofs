# Complete prime arrival measurability and core L2 membership

The module [PhysicalPrimeArrivalRegularity.lean](../../formalization/BuildingBlocks/PhysicalPrimeArrivalRegularity.lean) uses the literal exterior source and complete arrival defined in `PhysicalGroundPrimeArrival`:
\[
G(v)=1_{\{|v|>R\}}\Phi(v)\psi(v),\qquad
B_p(v)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [G(v+\log n)+G(v-\log n)].
\]
Assume psi is almost everywhere strongly measurable and its absolute value is almost everywhere bounded by a nonnegative P. No ground or eigenfunction property is assumed.

The source is almost everywhere strongly measurable by the compiled literal-source theorem. Each translated source remains so because Lebesgue translation is measure preserving. Thus each actual arrival term and every finite partial sum is almost everywhere strongly measurable. The previously compiled absolute-summability theorem gives convergence to the actual tsum on one almost-everywhere set. Taking the limit along finite index sets proves almost everywhere strong measurability of B_p. Every Mangoldt index and both orientations remain; the proof does not replace the sum by a prime-only series.

The previous bound and the new nonnegativity theorem for the finite prime mass D give
\[
|B_p(v)|\le2PTD e^{|v|}\le2PTD e^R
\quad\text{almost everywhere on }[-R,R].
\]
Here T is the literal theta tail constant and D is the complete sum of Lambda(n)/n^(3/2). The core interval has finite Lebesgue measure. The bounded-function Lp theorem therefore proves the actual formal conclusion `MemLp (primeArrival R psi) 2 (volume.restrict (Icc (-R) R))`. The statement is valid for every real R, including empty intervals for negative R. It closes the qualitative prime-arrival core L2 consumer. The numerical integral bound written in the earlier arrival chapter is not a separate exported declaration here.

Root supplied these five declarations using the theta covariance branch's published source, absolute convergence and local bound. The method is classical translation, almost-everywhere limits and finite-measure domination; no novelty claim is made. Actual continuous-arrival absolute convergence and its core bound, the full arrival equation, killed-ground construction and domains, and the signed arithmetic estimate are further obligations. This module proves no RH conclusion.

All five printed declarations independently compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.
