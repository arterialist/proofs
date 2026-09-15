# Continuous arrival kernel and its boundary primitive

The module [PhysicalContinuousArrival.lean](BuildingBlocks/PhysicalContinuousArrival.lean) uses the literal archimedean kernel
\[
r(s)=\frac{e^{-s/2}}{1-e^{-2s}},\qquad s>0.
\]
It proves positive denominator, nonnegative kernel, and the exact denominator lower estimate
\[
1-e^{-2s}\ge\frac{2s}{1+2s}.
\]
The latter follows from \(e^{2s}\ge1+2s\), without a replacement kernel or small-distance truncation.

The resulting rational bound is
\[
r(s)\le e^{-s/2}\frac{1+2s}{2s}.
\]
For \(0<s\le1\) the compiled bound is \(r(s)\le3/(2s)\). This is a larger constant than the sharper written \(1/s\) estimate in physical-ground-complete-core-arrival-foundation.md; it preserves the same logarithmic boundary growth. For \(s\ge1\),
\[
r(s)\le\frac{e^{-s/2}}{1-e^{-2}}.
\]
The module proves continuity on \((0,\infty)\), integrability on \((1,\infty)\), and for \(0<d\le1\),
\[
\int_d^1 r(s)\,ds
\le-\frac32\log d.
\]
The majorant integral equality is proved for every \(d>0\); the kernel integral inequality uses \(d\le1\).

For a bounded literal exterior source \(G=1_O\Phi\psi\), this supplies the continuous-kernel estimates behind the written bound
\[
|B_c(v)|\le M\left[\tfrac32\ell(R-v)+
 \tfrac32\ell(R+v)+\frac4{1-e^{-2}}\right],
\qquad -R<v<R,
\]
where \(\ell(d)=\max(0,-\log d)\) and \(|G|\le M\). The displayed source-arrival inequality, parameter measurability, squared-logarithm integrability, and full arrival \(L^2\) conclusion are still written consumers, not theorems of this module. Boundary values are not asserted finite.

This module contains no ground eigenfunction, killed form, spectral premise, or Weil pole manipulation. It formalizes the literal continuous kernel as a prerequisite for the full core arrival. The separately published prime-arrival module retains all prime powers and both shifts. Ground construction, actual operator-domain identification, the complete weak ground equation, and the covariance residual estimate remain open in Lean or in mathematics as previously stated. No RH claim is made.

The theta covariance research branch supplied these ten declarations. Root independently reviewed the positive-denominator hypotheses, comparison directions, finite interval endpoints and improper-integral domination. These are classical exponential and logarithmic estimates; no novelty claim is made.

All ten printed declarations independently compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.
