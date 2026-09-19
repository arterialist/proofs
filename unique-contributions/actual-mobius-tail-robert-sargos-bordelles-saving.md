# Rectangle-wise Robert--Sargos--Bordellès saving for the actual Möbius tail

**Date:** 20 September 2026
**Status:** unconditional written theorem; independently checked against the
primary source statements and the exact packet reduction. Priority is stated
to the best of the targeted literature search, not as an absolute claim.

The full statement and proof are in
[the analytic note](../building-blocks/weil-and-spectral/actual-mobius-tail-robert-sargos-bordelles-saving.md).

For the exact Möbius-weighted packet sum

\[
P_1(T)=\sum_{m\geq1}\mu(m)L_m(T),
\qquad N=T^\lambda,\quad H=N/T,\quad 2<\lambda<29/14,
\]

the theorem proves a power-saving prefix estimate through

\[
K_E=T^{2(\lambda+1)/5-1/420}.
\]

More precisely,

\[
\sum_{m\leq K_E}\mu(m)L_m(T)
\ll T^{-\min\{(29-14\lambda)/60,1/2000\}}.
\]

The new analytic endpoint is

\[
d<\frac{2(\lambda+1)}5,
\]

which strictly improves the preceding endpoint \((3\lambda+1)/6\) by
\((7-3\lambda)/30\).

The improvement is not a new exponential-sum theorem. It is a new
rectangle-wise use of two published estimates with their full coefficient
architecture retained. The dual Robert--Sargos orientation controls
\(d/2\leq a\leq(3d-\lambda)/2\); the Bordellès estimate controls the
remaining rectangles. Their limiting exponents meet at that switch and give
a uniform power margin below the stated endpoint.

The audit checked the primary Robert--Sargos theorem, both coefficient slots,
hard-cutoff separation, all eight rectangle exponents, the switch range,
small and large Poisson shells, the Type-I terms, and the final loss budget.
The theorem advances the exact signed sum used by this repository. It does
not bound the remaining tail beyond \(K_E\) and does not prove RH.
