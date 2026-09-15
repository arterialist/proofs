# A constant exterior test has positive actual killing energy

[PhysicalKillingPositivity.lean](BuildingBlocks/PhysicalKillingPositivity.lean) proves that for every R>0 and real c unequal to zero,
\[
E_O(c)>0,
\]
where the actual killed energy is the complete theta continuous-plus-prime energy of the zero exterior extension. This is positivity for this test, not a uniform spectral lower bound or ground construction.

For every a>0, set d=min(R,a)/2. The nonempty open interval
\[
I=(-R-a,-R-a+d)
\]
consists of starting points u with |u|>R and |u+a|<R. The zero extension therefore has values c and 0 at the two endpoints. Its actual squared edge integrand on I is exactly
\[
\Phi(u+a)\Phi(u)c^2>0.
\]
The proof supplies measurability of the zero extension and of the ENNReal edge integrand, then uses the positive Lebesgue measure of I and the support characterization of a positive nonnegative integral. Consequently the actual killed edge mass is positive for every positive displacement. No finite-edge-energy premise is assumed.

The displacement a=log 2 is an actual prime jump with strictly positive coefficient Lambda(2)/sqrt(2)=log(2)/sqrt(2). That positive term is bounded above by the complete ENNReal prime sum. The complete prime energy is therefore positive, and adding the nonnegative continuous energy proves the full killed-energy conclusion. Every other prime power remains in the sum; none is removed from the definition. The published reverse-edge identity retains the other orientation.

A constant test has zero internal-only jump differences. This calculation shows why deleting core-crossing costs changes the actual killed energy even for that elementary test. It does not establish finiteness of the constant's killed energy, exclude all low spectral modes, pay the covariance residual, or prove RH.

Root supplied the interval geometry, actual edge-integral positivity and full-prime consumer, using the covariance branch's published energy foundation. The argument uses classical positivity of nonnegative integrals and a retained actual prime term; no novelty claim is made.

All three declarations compile with only propext, Classical.choice and Quot.sound, without warnings in this module.
