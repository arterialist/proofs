# Actual local zero-circle residues and complete history comparison

[ActualZeroCircleResidues.lean](BuildingBlocks/ActualZeroCircleResidues.lean) turns the proved actual local logarithmic-derivative coefficient into an exact small-circle integral. It does not shift a global zeta contour or sum all zeros.

For an analytic f with finite order m at s, local analytic factorization gives
\[
\frac{f'(w)}{f(w)}=\frac m{w-s}+H(w),
\]
where H is analytic near s. The proof obtains the factor's nonvanishing and differentiability on a neighborhood before deriving this identity. It then chooses epsilon>0 so every closed ball of radius 0<R<epsilon lies inside both the analytic neighborhood of H and the neighborhood where the identity holds.

For every entire test F on those circles,
\[
\oint_{|w-s|=R}F(w)\frac{f'(w)}{f(w)}\,dw=2\pi i\,mF(s).
\]
The radius is chosen before F, so it is independent of the entire test. The proof checks circle integrability of the rational and regular terms before splitting their integral. Cauchy's formula supplies the rational term and Cauchy-Goursat cancels the analytic regular term. Positive radius excludes the center from the circle. The statement includes m=0 at nonzeros.

The theorem applies to actual xi at every complex s, with its proved finite analytic order. For actual zeta it applies on Re(s)>0, s unequal to 1, and identifies m with the actual xi multiplicity using the published order equality. No finite-order or multiplicity assumption is left on these actual-function consumers.

For continuous compact physical f,g, the proved entire centered weight F(s)=W(f,g)(s-1/2) can be replaced by any actual complete finite history block. One common radius works for every finite generator set P with p>=2 and every depth M. The resulting coefficient is exactly
\[
2\pi i\,m(s)\prod_{p\in P}V(p,s-1/2,M)V(p,1/2-s,M)F(s).
\]
All forward and backward history terms remain in V. The theorem only requires integer generators p>=2, and therefore applies in particular to prime sets. It does not restrict s to the critical line or turn paired complex weights into absolute squares off that line.

Subtracting the original actual zeta circle integral gives the exact signed difference
\[
2\pi i\,m(s)\left[\prod_{p\in P}V(p,s-1/2,M)V(p,1/2-s,M)-1\right]F(s).
\]
With an explicit delta>0 and |Re(s-1/2)|<=1/2-delta, the published complete block-defect estimate bounds its norm by
\[
|2\pi i\,m(s)|\,|F(s)|
\left(\exp\sum_{p\in P}(2B_p+B_p^2)-1\right),
\quad B_p=\frac{e^{-M\delta\log p}}{1-e^{-\delta\log p}}.
\]
The interior gap is a retained hypothesis of this comparison. No uniform gap for every actual zero or summability of these coefficients is inferred.

The signed scattering research branch supplied the eight declarations. Root independently reviewed local nonvanishing, the closed-ball choice, integrability before splitting, actual order transfer, complete multiplier dictionary and the quantitative gap premise. These formalize classical local residue and Cauchy identities; no novelty claim is made.

Global contours, zero counting, infinite residue-sum convergence, gamma inversion, the full Weil formula and arithmetic sign control remain separate obligations. Local residue matching and a small complete history defect do not locate actual zeros or prove RH.

All eight printed declarations independently compile with only propext, Classical.choice and Quot.sound, without warnings in this module.
