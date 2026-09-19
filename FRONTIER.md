# Current RH research status

Updated 19 September 2026. Counting by $n\mapsto n+1$ and multiplicative factorization motivate the arithmetic objects here. The remaining problem is a quantitative bound for their complete signed error. An identity describing that error is not such a bound.

## Checked results and their scope

- [Bounded-height zero exclusion](formalization/BuildingBlocks/RiemannZetaRatioSurplus.lean) proves in Lean that $\zeta(s)\ne0$ when $\operatorname{Re}(s)>1/2$ and $0<\operatorname{Im}(s)\le7.465$. This is formalization progress on a classically known zero-free range.
- The [completed-zeta decomposition](formalization/BuildingBlocks/RiemannZetaPoleDominanceTheorem.lean) and [reflection identities](formalization/BuildingBlocks/RiemannZetaDisplacementReflectionAntisymmetry.lean) are exact identities. They do not establish an additional high-frequency zero-free region.
- [RH criteria and consequences](formalization/BuildingBlocks/RiemannZetaMasterGrandUnification.lean) organize equivalent predicates and conditional implications. The high-frequency Fredholm/trace interfaces still require the decisive estimates as fields. No instance supplying those estimates has been established by these modules.

## Signed prime remainder

The [reciprocal-prime estimate](building-blocks/weil-and-spectral/actual-reciprocal-prime-high-cofactor-saving.md) treats a high-cofactor range. The [proper-cofactor Dirichlet reduction](building-blocks/weil-and-spectral/actual-proper-cofactor-dirichlet-dual-cancellation.md) does not discharge the whole remaining signed zero sum or the omitted cofactor tail. The corrected note withdraws its earlier claim to resolve the small-cofactor barrier.

The [dual exponent module](formalization/BuildingBlocks/DualDirichletOfflineDecay.lean) proves real-power algebra. A classical bound for one short dual Dirichlet polynomial is distinct from a uniform estimate for the complete arithmetic expression. The [power-model identity](formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean) $T^\varepsilon T^{-\varepsilon}=1$ does not establish exact cancellation of actual zeta scattering factors. A fixed positive power $T^\delta$ eventually exceeds $\log T$; it cannot be treated as a logarithmic error by choosing a small fixed $\delta$.

Earlier [microcluster](building-blocks/weil-and-spectral/actual-weil-offline-microcluster-mass.md) and [sampling](building-blocks/weil-and-spectral/actual-annulus-sobolev-zero-sampling.md) estimates constrain selected zero configurations or exceptional sets. They do not exclude an isolated off-line zero. The [published-history reviews](reviews/history/README.md) record the checked claims and remaining limits.

## Displacement correction

With $s=\sigma+it$, $d=\sigma-1/2$, and $\Lambda(s)=\pi^{-s/2}\Gamma(s/2)\zeta(s)$,

$$
D_\sigma(t)=\frac{2d(1/4-d^2)}{|s(s-1)|^2}+2d\Re\Lambda(s)-t\Im\Lambda(s).
$$

For fixed $0<d<1/2$, its leading coefficient is positive: $t^4D_{1/2+d}(t)\to2d(1/4-d^2)$. The negative coefficient reported earlier resulted from using the wrong theta weight. Eventual positivity for a fixed real part is not positivity everywhere and does not exclude zeros.

The [claim audit](reviews/current-rh-claim-audit.md) records the evidence and correction scope. The requested commit range has been inventoried and its principal changed claims reviewed; individual theorem and priority checks remain incomplete outside the documented scope. Preserve useful conditional results, state their inputs, and measure further mathematical progress by an independently proved estimate for the actual signed expression.
