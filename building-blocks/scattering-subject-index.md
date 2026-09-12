# Semilocal scattering and signed arithmetic phases

This collection fixes the complete finite-place multiplier and the negative-frequency Hardy projection throughout. Every admitted prime contributes all of its powers, including powers beyond the place cutoff. These are written proofs. No Lean source here proves the analytic scattering estimates or the missing RH premise.

## The fixed finite-place operator

The [semilocal foundation](semilocal-weighted-scattering.md) starts with Connes–Consani's distinction between exact triangularity and triangularity modulo compact operators. It identifies the compact negative part with the singular values of the lower corner, proves ordinary Schwartz-weighted trace class, and gives the exact finite signed trace. For a fixed nonzero compact test, the canonical positive and negative weighted traces both diverge as places are added, even though their difference stabilizes. Separate bounds therefore lose the required cancellation.

The [continuum counterphase](continuum-scattering-counterphase.md) retains the exact conjugated cocycle, restores the two pole moments, and subtracts the principal prime density before taking a norm. Its compactness and winding do not imply positivity. It also proves that this multiplier fails to preserve the actual theta transform image, so the physical test must remain fixed.

The [rational pole factor](rational-scattering-pole-factor.md) replaces the decaying half of that counterphase by $(1+2it)/(1-2it)$. Gamma recurrence shifts the baseline from $1/4$ to $5/4$, and the replacement error is at most $\sqrt{2/(X\log X)}$ in Hilbert–Schmidt norm, uniformly in the complete finite prime product.

## Collective estimates before the signed readout

The [signed tail energy](signed-scattering-tail-energy.md) gives an exact Hilbert–Schmidt identity with the Brownian kernel $\min(a,b)$. A harmonic-oscillator factorization yields a sufficient trace-norm bound that retains every prime–prime and prime–density cross term.

The [frequency-transport proof](signed-scattering-phase-transport.md) instead couples the prime measure with the continuum in one dimension. A $1/2$-Hölder bound for moving Hardy frequency intervals retains the endpoint mass and gives the unconditional estimate

$$
N_\chi(\widehat U_X)
=O_\chi\!\left(\sqrt X e^{-c\sqrt{\log X}}+\log X+1\right)
=o_\chi(\sqrt X).
$$

The [discrepancy-to-norm theorem](prime-discrepancy-scattering-norm.md) inserts the complete signed prime-power discrepancy into the tails before taking their $L^2$ norm. It proves

$$
\psi(x)-x=O(x^{\beta}\log^m x)\quad\Longrightarrow\quad
N_\chi(\widehat U_X)=O_\chi(X^{\beta-1/2}\log^{m+3/2}X+\log X+1)
$$

for $\beta>1/2$. Its stated boundary estimate at $\beta=1/2$ has one extra logarithmic power. This is a different proof from the transport estimate and avoids its geometric mean of unsigned mass and discrepancy.

## The remaining norm criterion

The [single-observation theorem](single-observation-scattering-criterion.md) proves that one fixed everywhere-positive Schwartz observation satisfying $N_\chi(\widehat U_X)=O_\epsilon(X^{\sigma+\epsilon})$ for every $\epsilon>0$ excludes all zeros with real part greater than $1/2+\sigma$. The proof uses local $L^1$-valued continuation and the positive residue of a zero of any multiplicity. It needs no globally rightmost zero.

Consequently RH is equivalent to the subpower bound for that one observation. The available unconditional $o(\sqrt X)$ estimate is weaker, and no sign of the full Weil form follows from the finiteness of these auxiliary norms. The [arithmetic subject index](arithmetic-subject-index.md) records the counting, division and covariance identities that may supply further input.

## A particular positive finite-band input

The [dyadic innovation flux](prime-innovation-finite-band-flux.md) keeps both projection commutators and the exact initial seed. Orthogonal Fourier bands reduce the error to a seed-tail overlap and a quadratic tail term. The resulting flux tends to $1/2$ without a mean-energy assumption. This one-prime probe does not imply a sign on arbitrary tests or on the complete all-place form. Its arithmetic Fourier estimate is indexed in the [actual cutoff collection](arithmetic-subject-index.md#actual-finite-frequency-readouts).

## Exact growth and one actual test

The [zero-abscissa calibration](zero-abscissa-scattering-growth.md) proves $\limsup\log(1+N_\chi(\widehat U_X))/\log X=\Theta-1/2$, without requiring the supremum $\Theta$ to be attained. It supplies the full half-integer explicit-formula proof of $\psi(x)-x=O(x^\Theta\log^2x)$, citing Dudek's theorem with its exact hypotheses.

The [compact positive observation](compact-positive-scattering-observation.md) uses the classical Arias de Reyna bump and an irrational dilation with relative phase $i$. Its one compact smooth complex even test has both pole moments zero and strictly positive squared Fourier modulus on the entire real line. Thus the norm-growth criterion can use an actual compact test, while the sign of that test's single scalar Weil value still does not decide RH.

## Opposite histories and their signed boundary

The [two-history storage identity](two-history-bilinear-storage.md) transports the two copies by a prime factor and its inverse, preserving the complex Fourier square. Its discrete current gives an exact finite-strip conservation law and the full $W$ consumer. The initial bilinear response is zero because its two boundary contributions cancel. The one-history seed norm $1/2$ cannot replace it.

The [inverse-boundary constraints](inverse-boundary-division-constraints.md) retain the nonconstant division-error modes, the positive finite seam, and the exact arithmetic rotation operator. They prove a positive first-prime-window pairing with its mixed correction controlled. A separate folding identity annihilates every nonzero dyadic mode of causal storage and transfers those modes to the combined exterior boundary. Neither result signs the complete readout.

The [fixed-prime product cutoff](one-prime-boundary-product-cutoff.md) extends quarter-power approximation to the separately projected bilinear histories. The proof pays for every rational product location, causal-projection atom and terminal taper. Its constants depend on the fixed prime; it is not a growing-prime estimate or a ratio-location norm estimate.

The [unilateral Laplace transfer](two-history-storage-laplace-transfer.md) uses the actual inverse boundary to cancel artificial prime-filter resonances. True off-line zeta zeros retain their original double-pole coefficients in the causal storage; the exterior boundary has at most a simple pole there. This identifies the remaining arithmetic content and supplies no bound that excludes those poles.

## Additive discretization and the centered divisor score

The [successor-clock counterphase](successor-counterphase-trace-norm.md) replaces continuum density by the exact integer clock with uniformly bounded localized trace cost and a vanishing corrected tail. It retains the origin coefficient $c(1)=1$ in the exact divisor average of $1-\Lambda$. Its kernel proof separately controls distant input columns.

The [centered divisor storage theorem](coarse-divisor-scattering-storage.md) gives unconditional convergence in that same trace topology for $\tau(n)-\log n-2\gamma$. The elementary divisor bound gives a polynomial logarithmic norm bound; the classical exponent below $1/2$ gives a limiting phase with error $O_\chi(X^{-1/6}(\log X)^{3/2})$. Its entire Dirichlet score has canceled the logarithmic-derivative denominator. No bounded inverse for the divisor average or prime-score estimate follows.

## Nonlinear successor increments

The [successor-clock energy](successor-clock-scattering-energy.md) identifies the localized Hilbert–Schmidt norm with a sum of first-increment $L^2$ energies of the actual unitary phase. The gamma factor, complete prime-power measure and continuum subtraction enter the ratio before its modulus.

The [second-increment criterion](successor-second-increment-trace-criterion.md) uses Peller's real-line theorem and a proved dyadic inverse-multiplier argument to recover the localized trace norm from the literal steps $\log(1+1/(2n))$. Its $L^1$ second differences retain both phase increment and phase curvature. A subpower bound for this sum would meet the RH norm criterion; that arithmetic estimate remains open.

## Exact local factors and composition obstructions

The [one-prime fiber calculation](exact-prime-scattering-fibers.md) gives the exact eigenvalues $\pm p^{-1/2}$, continuous multiplicity and positive/negative trace densities of the pure local factor. The gamma factor is absent in this calculation.

The [actual two-prime interaction](two-prime-mixed-scattering.md) changes sign for $p=2,q=3$, even on compact pole-null theta tests. It retains every power and supplies a physical crossing-interval Gram formula and resolvent bound. This is an auxiliary second moment, not a negative Weil witness.

The [weighted composition theorem and counterexample](weighted-scattering-composition.md) distinguish the subadditive localized trace norm from the weighted absolute trace. An explicit scalar example refutes the latter's uncorrected triangle inequality. The repaired bound includes a nonlocal commutator cost, which is smaller for an actual prime and remains finite at real zeros of the test transform by a proved modulus-measure estimate and Peller's theorem.

The [two-prime compact-filter theorem](two-prime-compact-filter-generation.md) generates every compact smooth pole-null test with fixed support enlargement and finite derivative loss. Matveev's two-log bound supplies the quantitative separation needed by the Sasane–Sasane/Hörmander division theorem. Generating the test space does not control the mixed quadratic term or establish positivity.

The [theta jump chapter](theta-weil-jump-form.md) supplies the complete physical-space form behind the weighted Weil trace, including its closed domain, essential threshold and exact negative index. The two operators are linked by form values on actual tests, not by an asserted unitary equivalence.

## Earlier relative-determinant constructions

The [prime-density determinant chapter](prime-density-relative-determinant.md) retains the full first-prime trace, exact cutoff boundary and the unconditional line-one limit. An actual prime-cell reference gives a holomorphic relative determinant for $\Re s>0$, with arithmetic retained in its reference factor. For the independent logarithmic-integral reference, ordered matching is optimal over all unitaries and the trace distance diverges for every real $0<\sigma\le1/2$, even after finite-rank repairs. These are different comparisons; neither controls the canonical compensated prime multiplier.

The [fixed-support signed complement theorem](signed-prime-bath.md) gives a distinct form-level estimate: the actual unrepresented space has a certified positive margin, and its interaction with the retained space is an explicit finite Gram term. It does not follow from an absolute trace-distance bound, and the unevaluated Gram term remains essential.

## A positive successor-seed process and its signed response

The [fixed-Cauchy covariance identity](fixed-cauchy-prime-covariance-seed.md) identifies the complete centered prime generator with the Gram form of its actual successor boundary profiles. It proves a fixed-observation $L^2$ limit and an exact two-port graph for every even Wiener multiplier of the ground profile, including nonlinear finite-prime heat. The [long-memory theorem](collective-successor-seed-long-memory.md) gives $B(v)=2/v-4/v^2+O(v^{-3})$ with a rapidly decaying density remainder.

The [positive jump process](positive-successor-seed-jump-process.md) uses the finite measure $B(v)\,dv/v$ to construct an all-prime probability law and a uniformly bounded orbit in the mixed source space. Its common causal inner factor preserves the actual prime response. The original centered generator is a domain-qualified derivative of this evolution; positive probability and bounded evolution alone do not control that signed response. These are written proofs using classical Bernstein, compound-Poisson, Hardy and PNT methods.


## Fixed-observation heat and exact source thresholds

The [complete prime-heat theorem](fixed-observation-prime-heat.md) identifies the centered generator with a line-one zeta logarithm and its full proper-power correction. Two global domination methods support complex subcritical convergence, a meromorphic scalar continuation, the critical-window uniform law and an explicit large-age profile. The scalar integrability threshold is $1/2$; the ground seed's squared-norm threshold is $1/4$. Exact finite-source cancellation shifts the threshold, while an actual two-birth example proves that the successor need not preserve it. The [partial-cosine companion](uniform-partial-prime-cosines.md) retains every cutoff endpoint in the PNT proof. These are fixed-observation and finite-source theorems; no joint completion of the unrestricted arithmetic source or RH bound follows.


## All-order profiles and signed arithmetic bands

The [actual-window Sobolev theorem](real-window-phase-sobolev-orders.md) combines the Montgomery–Vaughan mean-value theorem with full geometric derivatives and Bell coefficients. It retains a separate elementary frequency-separation proof and gives explicit order bounds, arbitrary moving-threshold control and a canonical high-height remainder estimate. The [Haar moment identity](haar-profile-all-order-moments.md) instead computes the exact weighted profile energy from the full geometric law, including the finite-cutoff exponential-moment boundary and its high-order obstruction. Haar moments do not replace actual-window moments.

The [signed divisor-band theorem](signed-divisor-band-correlations.md) sums complete common-divisor histories at each reduced ratio before estimating them. It proves exact finite-difference cancellation and opposite signed sharp-boundary examples, while retaining the unresolved collective off-diagonal band sum. These are written methods with classical attribution, not fixed-observation RH estimates.


## The centered generator: kernel, domain and finite source

The [birth-kernel construction](centered-infinite-prime-birth-kernel.md) proves complete prime-cutoff convergence and the two equal endpoint contributions to its norm. The [Mellin-domain proof](centered-prime-mellin-domain.md) identifies $-2\log|\zeta(1+2i\nu)|$ plus a smooth bounded proper-power remainder, with an explicit maximal self-adjoint domain. Strong resolvent convergence and vector convergence on a sufficient weighted domain are stated separately.

The [domain counterexample](centered-prime-domain-counterexample.md) lies in the mixed completion but its centered histories diverge even against an actual two-pole-null test. For finite actual sources, the [two-sided ground graph](centered-prime-natural-source-graph.md) instead gives a convergent expression with its temporal cross term intact. The [sharp cutoff law](fixed-source-centered-cutoff-law.md) proves a common two-ended tail and its exact norm, additive-energy and polarized constants for every fixed finite complex innovation. No uniform passage to the full source is asserted.


The [single-clock formalization](positive-successor-seed-jump-process.md#formalized-single-clock-dependencies) now proves the actual seed's complete unweighted, half-weighted and squared integrals in Lean. This validates a common dependency of the fixed-Cauchy graph and positive-process constructions; it does not formalize their collective convergence or operator assertions.
