# Current RH research status

Updated 19 September 2026. Counting by $n\mapsto n+1$ and multiplicative factorization motivate the arithmetic objects here. The remaining problem is a quantitative bound for their complete signed error. An identity describing that error is not such a bound.

## Checked results and their scope

- [Bounded-height zero exclusion](formalization/BuildingBlocks/RiemannZetaRatioSurplus.lean) proves in Lean that $\zeta(s)\ne0$ when $\operatorname{Re}(s)>1/2$ and $0<\operatorname{Im}(s)\le7.465$. This is formalization progress on a classically known zero-free range.
- The [completed-zeta decomposition](formalization/BuildingBlocks/RiemannZetaPoleDominanceTheorem.lean) and [reflection identities](formalization/BuildingBlocks/RiemannZetaDisplacementReflectionAntisymmetry.lean) are exact identities. They do not establish an additional high-frequency zero-free region.
- [RH criteria and consequences](formalization/BuildingBlocks/RiemannZetaMasterGrandUnification.lean) organize equivalent predicates and conditional implications. The high-frequency Fredholm/trace interfaces still require the decisive estimates as fields. No instance supplying those estimates has been established by these modules.

## Signed prime remainder

The [reciprocal-prime estimate](building-blocks/weil-and-spectral/actual-reciprocal-prime-high-cofactor-saving.md) bounds a small-prime prefix. The [cutoff transfer](building-blocks/weil-and-spectral/actual-proper-cofactor-dirichlet-dual-cancellation.md) controls the omitted cofactor tail and the combined prime row plus truncated proper-cofactor head by $O(T^{-(29-14\lambda)/60})$, for $2<\lambda<29/14$ and the specified cutoff.

For the separate prime row, the [three-dimensional Möbius-tail estimate](building-blocks/weil-and-spectral/actual-mobius-tail-three-dimensional-saving.md) applies Robert and Sargos' monomial exponential-sum theorem to the exact weighted Poisson expansion. It moves the controlled cutoff from
\[
H T^{(29-14\lambda)/116}
\quad\text{to}\quad
H T^{(13-6\lambda)/21}
\]
with a fixed power saving. Equivalently, it writes the prime row as the Möbius tail beyond the larger cutoff plus a power-decaying error. The farther tail remains uncontrolled. The discarded approximate-functional-equation argument still does not bound the complete signed zero sum.

The [dual exponent module](formalization/BuildingBlocks/DualDirichletOfflineDecay.lean) proves real-power algebra. A classical bound for one short dual Dirichlet polynomial is distinct from a uniform estimate for the complete arithmetic expression. The [power-model identity](formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean) $T^\varepsilon T^{-\varepsilon}=1$ does not establish exact cancellation of actual zeta scattering factors. A fixed positive power $T^\delta$ eventually exceeds $\log T$; it cannot be treated as a logarithmic error by choosing a small fixed $\delta$.

Earlier [microcluster](building-blocks/weil-and-spectral/actual-weil-offline-microcluster-mass.md) and [sampling](building-blocks/weil-and-spectral/actual-annulus-sobolev-zero-sampling.md) estimates constrain selected zero configurations or exceptional sets. They do not exclude an isolated off-line zero.

## Other unconditional bounds

The [full factorial clock](building-blocks/factorial-and-renewal/factorial-full-clock-pnt-subquadratic.md) satisfies $Q_N=o(N^2)$ and $|W_N|=o(N^2)$ by the classical PNT. Its RH consumer needs the much stronger one-sided $W_N\ll_\varepsilon N^{1+\varepsilon}$. The [coarse primitive envelope](building-blocks/prime-distribution/coarse-primitive-chebyshev-envelope-dyadic-falsifier.md) is $S_X\le(91/60)(4\log2-1)^2X^5$ by Chebyshev; the missing exponent is $4+\varepsilon$. These are written classical-input consequences, not new published zeta-frontier bounds.

## Displacement correction

With $s=\sigma+it$, $d=\sigma-1/2$, and $\Lambda(s)=\pi^{-s/2}\Gamma(s/2)\zeta(s)$,

$$
D_\sigma(t)=\frac{2d(1/4-d^2)}{|s(s-1)|^2}+2d\Re\Lambda(s)-t\Im\Lambda(s).
$$

For fixed $0<d<1/2$, its leading coefficient is positive: $t^4D_{1/2+d}(t)\to2d(1/4-d^2)$. The negative coefficient reported earlier resulted from using the wrong theta weight. Eventual positivity for a fixed real part is not positivity everywhere and does not exclude zeros.

Further progress requires an independently proved estimate for the actual signed expression. Conditional results should state their inputs directly in the result and its source file.
