# Actual gamma factor, completed-zeta boundary and entire xi

The module [ActualArchimedeanFactor.lean](BuildingBlocks/ActualArchimedeanFactor.lean) uses mathlib's actual `Complex.Gamma`, `Complex.Gammaℝ`, `riemannZeta`, `completedRiemannZeta` and pole-free `completedRiemannZeta₀`. Its gamma factor is
\[
\Gamma_{\mathbb R}(s)=\pi^{-s/2}\Gamma(s/2).
\]
For Re(s)>0, the gamma values are nonzero and differentiable. The module derives the exponential representation and the exact logarithmic derivative
\[
\frac{\Gamma_{\mathbb R}'}{\Gamma_{\mathbb R}}(s)
 =-\frac{\log\pi}{2}+\frac12\frac{\Gamma'}{\Gamma}(s/2).
\]
At s=1/2+it it therefore proves the actual multiplier
\[
2\operatorname{Re}\frac{\Gamma_{\mathbb R}'}{\Gamma_{\mathbb R}}(1/2+it)
 =-\log\pi+\operatorname{Re}\frac{\Gamma'}{\Gamma}(1/4+it/2).
\]
No hypothesis on zeta zeros enters these gamma identities.

For Re(s)>1, mathlib's actual von Mangoldt Dirichlet identity gives
\[
-\frac{\zeta'}{\zeta}(s)=\sum_{n\ge0}\frac{\Lambda(n)}{n^s},
\]
with absolute summability proved separately. The n=0 term is explicitly reconciled with the LSeries convention using Lambda(0)=0, and Lambda(1)=0 too. Every prime power remains.

The completed-zeta factorization is proved for Re(s)>0. For the derivative calculation on Re(s)>1, the pointwise factorization is promoted to equality on a neighborhood, and actual gamma and zeta nonvanishing and differentiability are supplied. This proves
\[
\frac{\widehat\zeta'}{\widehat\zeta}(s)
 =-\frac{\log\pi}{2}+\frac12\frac{\Gamma'}{\Gamma}(s/2)
 -\sum_{n\ge0}\frac{\Lambda(n)}{n^s}.
\]
Here the hat denotes mathlib's completedRiemannZeta, not the pole-cleared xi function. This closes the right-boundary integrand correspondence. It is not a contour-shift theorem.

The additional entire function is defined by
\[
\xi(s)=\frac{1+s(s-1)\widehat\zeta_0(s)}2,
\]
where the subscript denotes mathlib's pole-free completed function. The module proves complex differentiability everywhere, xi(0)=xi(1)=1/2, xi(1-s)=xi(s), and
\[
\xi(s)=\frac{s(s-1)\widehat\zeta(s)}2\quad(s\ne0,1).
\]
For Re(s)>0 and s unequal to 1, its zeros are exactly the actual zeta zeros. The entire definition avoids treating the total-function values at completed-zeta poles as zeros. The module does not prove that these zeros are on the critical line.

The signed scattering research branch supplied the fourteen declarations. Root independently reviewed normalization, positive-real-part hypotheses, the neighborhood derivative step, natural-index corrections and the xi pole values and zero equivalence. These are formalizations of classical identities using existing mathlib analytic results; no novelty claim is made. Weighted gamma growth and integrability, kernel inversion, contour limits, actual zero multiplicities and residue sums, the complete explicit formula and the original signed arithmetic estimate remain further obligations. No RH conclusion follows.

All fourteen printed declarations independently compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.
