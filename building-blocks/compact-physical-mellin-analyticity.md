# Entire compact physical Mellin weights and exact circle pole terms

[CompactPhysicalMellinAnalytic.lean](BuildingBlocks/CompactPhysicalMellinAnalytic.lean) proves entire analyticity of the literal bilateral Mellin transform for continuous compactly supported input. It derives the actual first-moment derivative
\[
\frac{d}{dz}M_z(f)=M_z(vf),\qquad
M_z(f)=\int_{\mathbb R}f(v)e^{zv}\,dv.
\]
For each z, the norm of the differentiated integrand is continuous on the product of the closed unit ball around z and the compact topological support of f. Its finite upper bound is an integrable constant on the restricted support measure. The proof supplies parameter measurability, integrability at z, derivative measurability, the bound, and pointwise differentiation before invoking the dominated parametric integral theorem. It then restores the whole-line integral, including the actual first-moment integrand. No derivative-under-integral premise is assumed.

The reflected-conjugate dictionary is
\[
\overline{M_{-\bar z}(g)}=M_{-z}(\bar g).
\]
Thus the actual paired weight is the product of two entire functions, with the second composed with z->-z. This avoids differentiating conjugation as though it were complex linear. Paired weights, their centered version F(s)=W(s-1/2), and the complete finite physical-history weights are proved entire and analytic at every complex point. Continuity and compact support of the history inputs are derived from the published actual operators.

For any entire F, the exact circle identity is
\[
\oint_{|w-c|=R}\frac{F(w)}{w-s}\,dw=2\pi i F(s),
\qquad |s-c|<R.
\]
The circle interior condition is explicit. Applying this to the actual centered weight, with both literal moments M_{-1/2}(f)=M_{1/2}(f)=0, proves
\[
\oint_{|w-c|=R}\frac{F(w)}w\,dw=0,
\qquad
\oint_{|w-c|=R}\frac{F(w)}{w-1}\,dw=0
\]
when both 0 and 1 lie strictly inside the circle. The same two identities hold after every complete finite generator block and depth, because the actual bilateral moment cancellations are preserved. These are proved circle-integral cancellations, upgrading the previously proved zero local coefficients. The complete xi logarithmic-derivative formula still contains both rational corrections; this theorem concerns their specified weighted circle integrals.

The signed scattering research branch supplied the thirteen declarations. Root independently reviewed compact domination, the literal first-moment derivative, the conjugation dictionary, full-history regularity and the circle hypotheses. These formalize classical compact-transform and Cauchy identities using mathlib; no novelty claim is made.

This does not shift a zeta contour, sum all actual zero residues, prove zero-count or horizontal-bound estimates, invert the weighted gamma multiplier, establish the full Weil formula, or sign the arithmetic source. Those remain separate obligations. No RH conclusion follows from entire test weights or these rational-term cancellations.

All thirteen printed declarations independently compile with only propext, Classical.choice and Quot.sound, without warnings in this module.
