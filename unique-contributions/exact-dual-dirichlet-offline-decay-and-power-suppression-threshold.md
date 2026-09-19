# Exponent algebra for a dual Dirichlet product bound

**Classification:** elementary algebra plus a classical conditional application

**Lean module:** [`DualDirichletOfflineDecay.lean`](../formalization/BuildingBlocks/DualDirichletOfflineDecay.lean)

The formalized result concerns the real exponent

$$
\alpha(\beta,\delta)=\frac12-\beta(1-\delta).
$$

If $\beta=1/2+\varepsilon$, $\varepsilon>0$, and $\delta<\varepsilon/\beta$, Lean proves $\alpha<0$. It also proves monotonicity of $CT^\alpha$ and the exact multiplication identity

$$
(C_\chi T^{1/2-\beta})(C_{\rm poly}T^{\delta\beta})
=(C_\chi C_{\rm poly})T^{\alpha}.
$$

Those are real-power and inequality lemmas. The Lean module does not mention zeta, $\chi(s)$, a Dirichlet polynomial, primes, or proper cofactors. It does not prove the analytic bounds that would instantiate the two factors.

For an actual application, one may combine classical uniform Stirling estimates on a specified vertical region with the triangle inequality

$$
\left|\sum_{n\le y} n^{\rho-1}\right|
\le \sum_{n\le y}n^{\beta-1}
\ll_\beta y^\beta.
$$

With $y\asymp T^\delta$, those separate inputs give the displayed product exponent. This is a classical type of estimate for a short Dirichlet polynomial. The repository's possible new element is its proposed use inside a proper-cofactor decomposition, but that decomposition and the required uniform constants are not proved in this module.

The previous description as a new unconditional all-prime suppression theorem was too strong. The checked content is an algebraic threshold lemma; the analytic product bound follows only after separate hypotheses are verified.
