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


The [formalized delay chain](positive-successor-seed-jump-process.md#formalized-delay-history-and-prime-sum-distinctions) retains both the nonzero first interval and every finite terminal history. The accompanying prime-sum module formalizes Euler divergence of aggregate mass, summability of component squares and absence of an integrable majorant, without dropping collective cross terms.


The centered domain has an exact [large-birth energy asymptotic](infinite-centered-birth-energy.md) obtained from its full arithmetic jump variation. Its [actual source loading](transformed-actual-arrival-loading.md) and [fixed positive-age invariance](positive-age-preserves-arithmetic-loading.md) retain the signed finite-history balance. These theorems concern actual centered arrivals on their established domain, not a bounded all-source centered operator or a sign for the Weil form.


The [formalized finite-prime measure and law](positive-successor-seed-jump-process.md#formalized-finite-prime-jump-measure-and-probability-law) retain the literal age-divided seed and all convolution powers. Their proved probability normalization and original-series identity do not assert the later all-prime limit or operator response.

The [finite-prime time-semigroup theorem](positive-successor-seed-jump-process.md#formalized-finite-prime-time-semigroup) is formalized as `seedProcess_add`, extending the exact probability construction by convolution of all paired jump histories. Its finite-set scope leaves the written all-prime completion and operator-domain theorems separate.


## Completed source charges and finite retained memory

The [literal natural cutoffs](natural-arrival-cutoff-completion.md) converge in the mixed energy by their exact derivative measures and a PNT envelope. The [successor charge-cocycle](actual-successor-resonance-charge-cocycle.md) then defines a bounded relative charge with positive actual value $\kappa$, without assigning an absolute charge to the infinite source. Its one-prime return profile has zero mean, while the [collective square response](collective-successor-charge-square-response.md) has a nonzero half-Mellin moment. The [finite-memory repair](successor-heat-finite-memory-repair.md) compensates the first $m$ relative moments on a causal BV heat graph space; the removed profiles, negative-output packet and restored mixed terms remain part of every complete readout. All these analytic statements remain written proofs.


The [all-prime activity and probability construction](positive-successor-seed-jump-process.md#formalized-all-prime-finite-activity-and-probability-semigroup) now has a formal Chebyshev dependency and exact pointwise seed-density identification. Its probability-semigroup theorem is unconditional. The [quantitative activity tail](positive-successor-seed-jump-process.md#formalized-quantitative-activity-tail) is also formalized, with exact cutoff endpoints and bound $32/\log P$ for $P\ge8$. Finite-prime law convergence is formalized in the subsequent section; analytic/operator consumers retain their separate written scope.


## Uniform compensated-memory kernels and spatial consequences

[Maximal translation control](successor-seed-maximal-translation.md) is the variable-shift input for the [complete charge-compensated kernel](charge-compensated-successor-memory.md). Its bounded $\mathcal E_c\to L^1$ extension retains the initial strip and admits joint natural-source/prime limits. The distinct [reference-decomposition proof](compensated-memory-integral-conservation.md) establishes exact zero integral. Combining this with the [local arithmetic calibration](successor-clock-arithmetic-calibration.md) yields the [calibrated logarithmic mean and finite exceptional logarithmic measure](actual-memory-spatial-sign.md); it supplies no signs on the countable birth set. The [derivative theorem](charge-compensated-clock-response.md) keeps $Ha_0=a_0-\delta_0$, its weak test pairing and the separate zero-endpoint-reference repair. The complete differentiated response is controlled in $W^{-1,1}$, not asserted to be in $L^1$. All six analytic chapters are written proofs; their all-prime probability dependency has the separate Lean coverage described above.


## Integer-history cells, curvature and minimum clocks

The [prime-clique chapter](prime-clique-cutoff.md#the-full-two-complex-and-its-metric) now retains the complete two-complex homology, scalar flatness classification, positive class trace and exact finite real pole. Its minimum-clock proof applies to each directed trace class. The [original rod extraction](integer-renewal-and-phase-memory.md#lowest-clock-extraction-and-its-logarithmic-defect) preserves a different clock method and proves that extraction does not commute with the logarithm. The [curvature chapter](integer-face-feedback-obstruction.md#curvature-absorption-and-the-complete-graded-square) includes the exact chain completion, full-clock independent-face counterexample and six-state interacting-face calculation. Four passing exact certificates accompany these written results; no Lean or RH theorem is claimed.

[Cutoff-law convergence](positive-successor-seed-jump-process.md#formalized-cutoff-law-convergence-and-its-normalization) now has an exact formal event-distance bound and uniform bounded-time quantifiers. [Infinite mean and causal support](positive-successor-seed-jump-process.md#formalized-infinite-mean-and-the-zero-jump-atom) retain the actual zero-jump atom and the nonintegrable age observable. These support the written memory-domain constructions without converting event convergence into an unbounded-observable estimate.

The [formal exponent estimate](positive-successor-seed-jump-process.md#formalized-closed-half-plane-exponent-and-complete-tail) holds uniformly on $\Re s\ge0$, with exact omitted-measure error; it does not include the separate holomorphy or law-transform theorem.


## Compact causal defects and the moving signed packet

The [compact-memory theorem](compact-compensated-causal-response.md) proves compactness into physical $L^1$ and, after differentiation, the full-line causal $W^{-1,1}$ quotient retaining the endpoint atom. The [exact scalar charge law](actual-source-causal-charge-law.md) supplies strict causal-port signs, one charge crossing and an ordered crossing sequence for every derivative. The [positive-history operator proof](positive-history-successor-charge-relaxation.md) gives the full finite-time $L^1$ response. Its [natural-cutoff consumer](natural-cutoff-positive-history-charge.md) has negative total mass for every positive time and all cutoffs. The [finite-transport proof](compensated-successor-finite-transport.md) retains both rank terms and the complete two-history kernel; the [uniform prime/time packet theorem](uniform-prime-time-successor-packet.md) tracks fixed, growing and all-prime cutoffs at scale $t\log t$. These are written source/operator theorems, distinct from the formal probability dependencies and from any full Weil sign.

The [causal energy anchor](actual-source-mixed-dirichlet-completion.md#formalized-causal-energy-anchor) is formalized for measurable real sources vanishing almost everywhere below $1$, with possibly infinite energy. It retains the exact reciprocal-max weight and the logarithmic change of coordinates. Completion and actual PNT source membership remain written proofs.

The [literal successor charge](actual-successor-resonance-charge-cocycle.md#formalized-integrable-successor-charge) is formalized for real $L^1(0,\infty)$ inputs, including the initial interval, successor integrability and exact compensated charge conservation. The extension to the actual nonintegrable source remains separate.

The [finite-energy relative-charge bound](actual-successor-resonance-charge-cocycle.md#formalized-relative-charge-at-finite-mixed-energy) is also formalized: the literal kernel product is integrable and its half-integral is bounded by $\sqrt{\mathcal E(H)}$, without an absolute-charge or unweighted-integrability premise. Actual PNT membership and arithmetic positivity remain written.


The [formal finite-prime memory construction](charge-compensated-successor-memory.md#formalized-finite-prime-memory-domains) proves the original successor commutator with both absolutely integrable columns, then substitutes every finite set of literal full prime profiles. It also proves the compensated $L^2$ adjoint, bounded memory output, existence of its relative charge and both original-reference rank terms. The uncut source and uniform mixed-energy-to-$L^1$ completion retain their separate written scope.


## Density smoothing and literal diagonal-time arithmetic readouts

The [fixed-component proof](compensated-successor-total-variation-relaxation.md) extracts a uniform interval from the actual prime-two density, proves a cutoff-uniform $t^{-1/2}$ variation bound, and retains the complete two-history packet comparison. The [dyadic proof](dyadic-prime-process-variation.md) uses the full arithmetic tail to obtain the sharp all-prime order $t^{-1}$ and the finite-cutoff crossover. Fixed finite cutoffs cannot retain that full rate at all times.

The [short-time source transfer](short-time-source-and-W-successor-transfer.md) controls the actual compensated correction uniformly over natural cutoffs and the completed potential, including both mixed orders in the complete $W$ readout. The [diagonal-time transform](diagonal-process-time-W-transform.md) gives a direct complex-contour proof of a classical Lévy resolvent formula and tracks every off-critical arithmetic double pole. Bounds for arbitrarily small fixed time ratios imply RH; the required bounds remain open, while sufficiently large time ratios already satisfy them unconditionally. These are written analytic results, distinct from the formal probability dependencies.

The [transposed memory-charge theorem](charge-compensated-successor-memory.md#formalized-transposed-charge-and-complete-corrected-kernel) now proves absolute Fubini and the complete corrected column in Lean, with an actual finite-prime specialization and both original-reference rank terms. Its domain is half-line $L^2$; the all-prime mixed-source estimates retain their separate written proof.


The [actual frozen-source correlation theorem](actual-short-time-psi-correlation.md) retains both frozen endpoint terms and the complete difference-age law. A primary unconditional PNT bound gives a logarithmic smoothing gain. A distinct finite Stieltjes/Abel reconstruction proves that logarithmic process time preserves the source's nonnegative power-growth exponent; the Mellin proof identifies it with $2\Theta-1$. Thus one fixed positive time coefficient already suffices for the global-source RH criterion. This does not evaluate that exponent or supply the open subpower bound. Its exact multiplicative-interval identity also explains why an upper Selberg-integral estimate has the wrong sign to bound the full averaged norm.

The [tilted real compact test](compact-positive-scattering-observation.md#a-tilted-real-test-that-retains-every-zero-in-the-critical-strip) retains a distinct Fourier-inversion smooth-bump proof and an exact strip-wide pole filter. It gives full zero coverage for a conditional growth bound on the actual translation kernel, including multiple zeros. Neither global positivity nor that arithmetic bound is established.


## Complete theta returns, excursion metric and clock boundary

The [killed-core return theorem](theta-killed-core-return-comparison.md) constructs the bounded crossing operator despite infinite archimedean activity, sums the complete exterior history, and gives the exact Schur form, excursion metric and positive two-pole correction. Its weighted Poincaré comparison has an explicit constant that loses the sharp threshold as the core grows. The [actual clock-domain bound](theta-return-clock-domain-bound.md) controls the row weight by the exact killing energy on the full core form domain. The [boundary theorem](theta-return-clock-boundary-compactness.md) then obtains the square-root logarithmic clock bound and compact resolvent at fixed core and fixed energy, using primary logarithmic-Laplacian regularity. These are written proofs with classical trace-process attribution; none establishes the full-core gap $1/2$ or a uniform threshold limit.


## Exterior poles and constrained theta elimination

The [complete return is compact and infinite rank](theta-killed-return-compact-infinite-rank.md), although the crossing operator itself is noncompact. Its fixed-core exterior has the threshold in essential spectrum and a mandatory discrete ground state below it. The [exterior index theorem](theta-exterior-threshold-index-transport.md) transports every finite negative matrix into either far half-line; it also proves that imposing the actual pole moments removes exactly the unconditional constant direction. The remaining count is the established count of distinct nonreal conjugate xi-zero pairs, without a simplicity assumption.

The [ground-pole theorem](theta-killed-return-ground-pole.md) proves a unique positive exterior ground state and a nonzero return residue. The [constrained Schur construction](theta-constrained-schur-across-ground-pole.md) passes coherently through that pole on an explicitly larger interval, retaining the full affine moment source, signed finite-rank correction and two-parameter extension Gram. Its maximal threshold reaches $1/2$ exactly when the open RH gap holds. The bordered inverse does not extend the positive excursion-clock measure across its pole. These are written proofs, not Lean theorems.


## Frozen-source loading, successor renewal and variable time

The [charge-loading proof](actual-charge-arrival-loading.md) gives the exact two-term arithmetic square sum with a convergent proper-power/ramp constant and its seeded signed work. The [original-space birth Gram](original-l2-evolved-source-gram-work.md) transfers that loading through complete pairs of process histories with an error uniform over all times. Its terminal norm remains unevaluated.

The [literal compensated iterates](literal-compensated-successor-iterates.md) have an exact scalar renewal representation, a positive bounded reference orbit and a full signed arithmetic driver. This proves a finite-source bound independent of iteration count, not positivity of arbitrary source iterates. The [variable-time theorem](variable-time-source-exponent.md) proves the exact growth exponent $\max(\kappa_0-\delta,0)$ for schedules of exponent $\delta$, including oscillating subpolynomial schedules. It retains the no-jump term and frozen endpoint; sufficiently long polynomial times can have zero exponent without an RH conclusion. These source/renewal results are written proofs, separate from the formal process dependencies.


The [formal collective square proof](positive-successor-seed-jump-process.md#formalized-all-prime-square-integrability) now establishes the literal all-prime $B\in L^2$ from the existing unconditional Chebyshev theorem and finite activity, including every cross term. Its [memory consumer](charge-compensated-successor-memory.md#formalized-all-prime-memory-and-cutoff-convergence) proves the full corrected all-prime kernel on half-line $L^2$ inputs and cutoff convergence uniformly over all output ages and the input unit ball. The cutoff retains exactly $p<P$; no numerical square-convergence rate or formal mixed-energy-to-$L^1$ extension is asserted.


The [long-time signed-source expansion](long-time-signed-source-rank-one.md) retains the exact charge-square term and a source-curvature correction of order $t^{-3}$. Actual cutoffs two and six have opposite correction signs, certified by bounded Arb arithmetic. Its direct absorption proof needs subpolynomial times with $t/\log^{3/2}N\to\infty$; the variable-Laplace method applies to every subpolynomial schedule. Neither supplies the required source bound.

The [uniform successor-driver theorem](uniform-successor-driver-square-bound.md) proves an actual $\ell^2$ constraint by full-line $H^1$ control and integer sampling, with a completed difference-integral consumer. The same exact reference renewal has synthesis norm of order $\sqrt k$. This identifies the loss from using the square-sum estimate without further signed arithmetic information, while retaining the complete driver Gram.


The [formal decaying memory charge](charge-compensated-successor-memory.md#formalized-decaying-charge-on-the-finite-energy-domain) now extends the actual transposed kernel directly to causal finite mixed energy, with norm at most $J_B$ and original-reference rank-output norm at most $2J_B$. It retains the real activation threshold and proves positivity of $d_B$, without assuming absolute source charge or unweighted source $L^2$. The rest of the completed commutator and its endpoint derivative remain written.


The [cutoff-centered Gram estimate](weighted-prefix-centered-source-gram.md) replaces logarithmic moment losses by an explicit finite weighted-prefix supremum. Finite Abel absorption then works for every diverging subpolynomial schedule, conditional on the actual evolved subpower estimate. This sharpens the older direct rank-one consumer while preserving its proof as a distinct method; the variable-Laplace theorem also covers bounded schedules. The unknown prefix supremum is retained until it is absorbed, never assumed bounded.


The [full continuous remainder gap](theta-continuous-remainder-explicit-gap.md) retains a positive same-half-line minorant and an actual two-strip bridge. An exact Hermitian two-cell matrix gives an explicit positive gap for every centered source at fixed core, and adding every internal prime-power edge preserves it. The theorem distinguishes this full continuous remainder from a prime-only comparison. Its positive fraction has not been shown to overcome the complete affine core deficit.


The [distinguished-return repair](integer-renewal-and-phase-memory.md#distinguished-return-after-incidence-inversion) recovers the literal state-one renewal after incidence inversion, where an uncorrected resolvent loses the return event. Its marked full-division histories derive both von Mangoldt kernels and a positive real dressed trace, with exact finite energy/variance bounds. The complete trace still has a persistent mixed-prime coefficient. A passing exact symbolic certificate retains primitive-word counts, boundary matrices and finite complex-clock counterexamples; the classical Bowen–Lanford, Rota and Redheffer precedents are explicit.


The [formal cutoff charge estimate](charge-compensated-successor-memory.md#formalized-quantitative-cutoff-for-the-rank-charge) bounds the original-reference rank error by $2(64\log2+30)\sqrt{\mathcal E}/(P\log P)$ for $P\ge8$, retaining exactly $p<P$. The [literal clock-jump module](positive-successor-seed-jump-process.md#formalized-literal-clock-jumps-and-their-complete-mass-budget) proves every one-sided prime-power limit, the cell derivative and the complete geometric mass budget. Identifying that budget with the distributional derivative variation remains a separate step.


The [exact seed renewal](exact-seed-renewal-asymptotic.md) has a strictly decreasing renewal sequence with $r_n\sim2/(\pi^2\sqrt n)$. The chapter verifies Caravenna–Doney’s boundary-index theorem and retains an independent moment/monotonicity proof using Kaluza’s sign mechanism. The [signed-source stabilization](signed-source-successor-stabilization.md) gives a strong dilated profile at each fixed cutoff, with limiting squared norm $28\zeta(3)M_N^2/\pi^4$. Its explicit uniform remainder requires $k\ge\max(4,(N-1)^2)$.

The [growing-time source cocycle](growing-time-actual-source-cocycle.md) retains both signed birth orders and exact process dissipation. Complete dyadic diagonal loading tends to $2\log2/(\pi^2c)$, and actual PNT makes the time-linearization errors absolutely summable. The whole successor budget transfers with an explicit error involving the still unknown terminal norm. A positive first admission and a small-time increasing first norm refute universal stepwise sign shortcuts.


The [formal derivative chain](positive-successor-seed-jump-process.md#formalized-weak-derivative-and-exact-jordan-variation) now proves the actual full-clock weak derivative and exact finite-prime Jordan variation. Prime births cannot cancel proper-power decay atoms. The all-prime positive and negative components are locally finite with an exact closed-age cutoff, but each has infinite total mass. The formal full-prime test identity retains that distinction; it does not assert a globally finite signed derivative.

The [complete all-prime cutoff-two energy certificate](full-prime-two-energy-certificate.md) proves an original-energy decrease greater than $1/200$ for the actual unit-coefficient coherent prime sum. Its [joint-tail proof](full-prime-two-relative-energy-tail.md) retains the positive $H^{-2}$ leading term and all mixed errors. The passing Arb certificate encloses every omitted prime and both age tails; no general-source or arbitrary-prime-coefficient comparison follows.

The actual [second successor](second-compensated-successor.md) has a strictly positive difference primitive and a [second cumulative W comparison](second-successor-tilted-order.md), while the [fifth primitive](actual-successor-fifth-primitive-failure.md) is strictly negative on an explicit initial interval. Passing Arb certificates retain every arithmetic tail. A [complete geometric average](actual-successor-resolvent-primitive-order.md) restores positivity for $0<r\le1/32$. Its [all-parameter correction and boundary criterion](actual-successor-resolvent-boundary-criterion.md) retain the common-age quantifier; the [literal feedback transform](successor-feedback-tail-Abel-poles.md) preserves every off-critical pole. The required near-one sign remains open. [Fixed-source geometric and Cesàro profiles](successor-averaging-retained-charge-profile.md) retain signed charge on expanding scales, with no growing-source interchange.

The [conditional feedback calibration](successor-feedback-RH-converse.md) proves RH implies an eventual margin $E(r)>5/3$, with exact logarithmic-clock mean and nonzero variance. Together with the forward pole argument it gives an RH equivalence; failure of RH forces unbounded excursions of both signs. No unconditional final-interval sign is proved.

The [factorial-division proof](actual-Abel-factorial-division-positivity.md) gives positive nonterminal inverse weights for $r\le1/2048$ and an explicit finite moving core for every $r<1$, retaining the negative initial mass and the ordered factorial endpoint. The distinct [Chebyshev quadrature proof](actual-Abel-feedback-Mellin-kernel.md) keeps the collective causal-boundary correction and derives the same feedback pole filter. A final-interval sign for one fixed inverse weight would imply RH plus simplicity; that stronger sign is not proved.

The [actual feedback source and increment formalization](successor-feedback-tail-Abel-poles.md#formalized-actual-source-and-ordinary-increments) retains the causal seed, every prime power, the exact new-birth/density difference and absolute relative-kernel charge. Chebyshev proves the driver series converges for $|r|<1$. The separate [terminal-strip module](successor-feedback-tail-Abel-poles.md#the-retained-terminal-strip) now identifies charge with half the increment integral. The analytic pole mechanism and arithmetic sign criterion remain written.

The [exact arithmetic feedback kernel](successor-feedback-arithmetic-kernel.md) gives a factorial endpoint-versus-cell budget and a linear moving cutoff for its negative prime-power coefficients. Its [global scaling proof](successor-feedback-kernel-scaling.md) retains the collective endpoint constant. After division inversion, the [linear positive exterior](successor-feedback-linear-inverse-core.md) forces negative logarithmic mass at moving nonterminal states. The [weighted-Mertens moment proof](successor-division-kernel-moments.md) establishes two cancelled logarithmic moments and an ordered positive-negative-positive shape, plus a distinct direct beta-integral comparison. The exact total feedback sign remains open. The [complete discrete curved-log comparison](successor-division-curved-log-comparison.md) proves a positive normalized limit for each fixed exponent between zero and one half, with the full Jordan-divisor readout. The [two-order cancellation proof](successor-division-two-order-cancellation.md) gives exact seed and endpoint contributions and isolates the signed logarithmic quadrature defect; its unconditional Mertens bound does not determine the feedback sign.

The [historical presieved completion](presieved-prime-pair-completion.md#9-an-independent-cyclotomic-and-sturm-proof-of-the-finite-example) now also retains its independent truncated-power/cyclotomic and exact Sturm proof of the scalar optimum, with a separately passing mathematical certificate. The general scalar obstruction and the single finite nonuniform repair retain their different scopes.

The [actual feedback driver](successor-feedback-tail-Abel-poles.md#formalized-actual-source-and-ordinary-increments) now has a formal square-root/logarithmic decay bound and an absolutely convergent holomorphic Dirichlet transform on $\Re z>1/2$. [SuccessorFeedbackDecay](BuildingBlocks/SuccessorFeedbackDecay.lean) and [SuccessorFeedbackDirichlet](BuildingBlocks/SuccessorFeedbackDirichlet.lean) derive this from the full arithmetic source; the later analytic continuation and RH sign consumer remain written.

The [quadratic logarithmic endpoint](successor-division-quadratic-log-readout.md) has unconditional normalized limit $\pi^{3/2}$, using the classical full Selberg weight. The distinct [coherent lattice identity](actual-coherent-division-lattice-remainder.md), [mean-removal refinement](actual-coherent-successor-quadrature-refinement.md) and [dual cosine/centered ODE proof](actual-division-lattice-dual-cosine.md) retain the entire physical correction, fractional cell and periodic curvature. The signed first-logarithm comparison remains unproved.

The [signed finite division boundary](signed-division-core-boundary.md) proves a negative cofactor budget with a uniform moving-cutoff asymptotic and the complete factorial endpoint. [Exact lattice-port cancellation](finite-division-lattice-port-cancellation.md) identifies the remaining exterior as positive quadrature tending to zero. [Integer-birth convex interpolation](actual-integer-birth-positive-quadrature.md) then gives $E(e^{-t})=b_t\mathscr D_K-C+b_t\Gamma_K+D$, with $\Gamma_K\ge0$ and $D\asymp t\log(1/t)>0$. The constant-scale finite-core lower bound remains unproved. These are distinct written arithmetic proofs with all prime powers retained.

The [formal floor/index/clock corrections](successor-feedback-tail-Abel-poles.md#formal-floor-index-and-clock-corrections) now retain the literal floor and initial driver, continue the index error to $\Re z>-1/2$, and prove the bounded actual clock discrepancy has an absolutely convergent holomorphic Mellin error on $\Re s>0$. The full pole/sign consumer remains written.

The [actual theta collision proof](theta-heat-collision.md) retains the modular endpoint and certifies one ordinary double zero in a strictly negative-time box. Its collision direction and signed fourth-moment obstruction are exact. The [coefficient-flow proof](theta-coefficient-flow.md) refutes favorable normalized-quadratic monotonicity on actual coefficients, then gives conditional adjacent-defect and reciprocal-cubic repairs, certified for every $t\in[0,1/2]$ and shift $0\le n\le8$. Higher shifts, degrees and global descent remain open. Complete-tail Arb and exact symbolic certificates are included; the classical theta/heat normalization is attributed to its literature.

The [original V/W identity](actual-W-positive-primitive-analysis.md#formal-identification-with-the-original-v-and-w) is formalized through [OriginalWIdentification](BuildingBlocks/OriginalWIdentification.lean): every full-power source term, density order, same-prime subtraction and harmonic multiple agrees with the central Mellin definitions, including $x\le1$. The open sign bound is unchanged.

The [signed birth-budget comparison](signed-birth-budget-to-canonical-scattering.md) bounds the actual canonical scattering norm by $(1+\log N)\sqrt{1+J_N+D_c(N)}$, with exact seed, gamma, all admitted powers and signed source work. Its [square-tail proof](admitted-prime-square-counterphase.md) retains an explicit continuum phase costing $O_\chi(\log\log N)$, plus a vanishing relative error. The [clock-action theorem](total-clock-dissipation-and-signed-work.md) identifies finiteness of the full accumulated dissipation with RH; that finiteness is not proved unconditionally.

The [local charge square mean](critical-charge-local-square-mean.md) is proved under RH without spacing, simplicity or independent-ordinate assumptions. The [two-sided charge oscillation construction](critical-natural-charge-two-sided-unboundedness.md) is unconditional, gives an alternate finite-frequency proof of a classical consequence, and derives the exact scalar-work liminf and sequential profile closure. Scalar work and process-weighted source work retain different clock terms.

The [formal Gamma and Abel-clock conversion](successor-feedback-tail-Abel-poles.md#formal-gamma-conversion-and-complete-abel-clock-remainder) now proves the actual integral equals $\Gamma(z)D_e(z)$ plus the complete endpoint/index/clock remainder. That remainder is holomorphic on $\Re z>0$; the floor-kernel zeta continuation remains separate.

The [complete cusp asymptotic](successor-quadrature-cusp-asymptotic.md) sharpens the correction to $D(t)=\zeta(3/2)t\log(1/t)/(4\pi)+O(t)$ and gives the same leading term for the mean-removed error $\epsilon(t)$. The proof controls every distance cell behind each integer birth uniformly before summing all prime powers. Chebyshev and the factorial identity suffice; the finite-core sign remains open.

The [literal positive-age Laplace profile](successor-feedback-tail-Abel-poles.md#formal-positive-age-laplace-profile) is now formalized: $H(h)=E(1-e^{-h})$, its initial value and Jacobian are exact, and its absolutely convergent transform agrees with the complete Gamma/index/clock formula for $\Re s>1/2$.

The [analytic zero-moment bound](zero-three-halves-moment-analytic-bound.md) proves $\sum_\rho m_\rho/|\gamma_\rho|^{3/2}<.509$ under RH, using the paired canonical product and a direct gamma/Jensen estimate. It supplies the [uniform common-halfline resolvent converse](successor-resolvent-common-halfline-RH-converse.md), with the older zero-counting argument retained as an alternate proof. The [endpoint extension](successor-resolvent-all-ages-RH-converse.md) gives positivity at every positive age for all sufficiently large $r<1$. Together with the forward criterion this is an RH equivalence; the required sign remains unproved unconditionally.

The [factorial-potential interpolation](factorial-potential-integer-interpolation.md) has a complete correction tending to a negative constant below $-1/4000$, despite eventual cell convexity. The distinct [positive observation of the common-inner history](coherent-core-positive-observation-inner-history.md) retains an explicit unit seed and gives an actual one-step ordering of size $\kappa\pi^{3/2}\sqrt t/2$. Its [original finite-source port](positive-history-observation-original-cutoff-port.md) is signed and has a Chebyshev cutoff $N\asymp t^{-2}\log^2(2/t)$ for vanishing error. The [mixed integer feedback kernel](mixed-integer-feedback-kernel.md) preserves its positive contact, renewal killing and both terminal terms. No collective core lower bound follows from these exact representations.

The [literal floor-kernel formalization](successor-feedback-tail-Abel-poles.md#formal-literal-floor-kernel) retains the upper endpoint $y-1$, proves absolute finite integrability for $\Re z\ge0$ and parameter analyticity for $\Re z>0$, and gives the exact continuous-kernel discrepancy. The later spatial derivative and arithmetic continuation remain separate.

The [formal integer-birth chain](actual-integer-birth-positive-quadrature.md#formal-complete-birth-interpolation-and-exponential-hats) proves cell convexity, a uniform complete-source majorant, both Laplace Fubini identities and the exact exponential hat factor, retaining $U_n(0)=0$ and every prime power. The original $E+C$ identification, strict defect and cusp asymptotic are outside this formal batch.

The [explicit coherent-core cross family](actual-core-explicit-weil-cross-family.md) factors the full arithmetic kernel as a difference of two correlations, with the complete pole moments retained. The [theta-domain and correlated-cutoff proof](coherent-core-theta-domain-and-cutoff.md) shows that the uncut quotients have infinite theta norm. Its paired limit retains the origin atom, both derivative ports and a divergent cross counterterm before subtraction. Direct finite-cost theta-source factorization of the unchanged kernel is impossible; the renormalized physical Weil identity remains valid. No cross-row sign follows.

The [formal spatial floor-error derivative](successor-feedback-tail-Abel-poles.md#formal-spatial-derivative-and-its-complete-zero-mass-error) now retains the moving endpoint and excludes only the countable integer corners. Its complete whole-line derivative error is integrable, has zero mass and costs at most twice the literal floor discrepancy in $L^1$. Arithmetic pairing and pole continuation remain separate.

The [actual factorial Picone identity](picone-frozen-source-work.md) retains the initial source and the entire observing prime tail. Its [closed-domain proof](factorial-ground-state-original-l2-domain.md) gives an explicit bounded inverse on the original $L^2$ space and the exact singular endpoint. The [growing-clock theorem](factorial-source-clock-loading.md) proves uniform absolute summability of the prime-minus-density diagonal difference and equal leading logarithmic coefficients for both positive loadings. It retains the signed mixed work and separate clock terms; no bound on those terms or zeta spectral identification follows. These results are written, not Lean-formalized.

The [complete archimedean row and radical projection](actual-core-Weil-arch-row-radical-projection.md) removes both pole moments of the actual coherent-core cross pair. It proves the full constant-scale gamma/pole asymptotic and extends the theta radical to these specific exponential/BV sources. The nonzero prime-port shift cancels against the archimedean correction in the full Weil form, so pole removal provides no arithmetic gain. This is a written source-space identity, with no theta-norm or Lean claim.

The [formal arithmetic floor pairing](successor-feedback-tail-Abel-poles.md#formal-arithmetic-pairing-holomorphic-floor-remainder-and-age-endpoints) retains the shifted endpoint and full tail against the literal bounded $\psi$ source. Its exact remainder is holomorphic on $\Re z>0$, and both age boundary terms vanish with no assumed source limit. [FloorPairing](BuildingBlocks/SuccessorFeedbackFloorPairing.lean), [FloorHolomorphic](BuildingBlocks/SuccessorFeedbackFloorHolomorphic.lean) and [FloorBoundary](BuildingBlocks/SuccessorFeedbackFloorBoundary.lean) prove these statements; the driver-to-zeta continuation remains separate.

The [literal successor transport of the additive Goldbach source](goldbach-literal-successor-counting-transport.md) gives exact positive birth kernels, their full pair escape probability and an $O(X)$ shifted counting deficit from Chebyshev. Compensation retains the linear and squared charge ports. The ordinary weighted comparison has a finite constant and remaining error $O(\log X/X)$; the PNT calibration gives deficit $2X+o(X)$. The source identification uses the classical Matsumoto–Suzuki explicit formula. No additive existence, global screw-sign or RH bound is inferred. This is written mathematics, not Lean.

The [formal discrete birth correction](actual-integer-birth-positive-quadrature.md#formal-discrete-return-and-complete-geometric-correction) retains the exact return at and after birth, sums it to the central $\psi(j)$, and proves complete geometric double-sum convergence. Original feedback identification remains separate. The [causal root translation](successor-feedback-tail-Abel-poles.md#formal-causal-root-translation) has exactly zero signed mass and $L^1$ norm $4(\sqrt{t+1}-1)$, with both boundary strip and tail retained.

The [centered additive circle consumer](goldbach-additive-source-consumer.md) transfers the Goldston–Suriajaya positive majorant to the original frozen-source norm and complete clock action, retaining the seed and terminal square. Its subpower majorant hypothesis remains open. The [factorial-ground screw decomposition](factorial-ground-screw-increment-consumer.md) produces an explicit positive square plus the full ratio-prime, Hardy, gamma and contact residual; the residual has a nonzero $\varepsilon\log(1/\varepsilon)$ small-configuration term. The distinct [coherent-core screw readout](actual-core-screw-increment-readout.md) retains the signed full-kernel observation. Its general screw-cone counterexample does not determine the actual zeta sign. All three consumers are written proofs.

The [complete time-ordered factorial birth correction](time-ordered-factorial-birth-trace-class.md) is trace class, including the seed and first density cell. It retains the actual later admission time for each pair and gives the exact prime-minus-density budget as its quadratic form on finite all-ones vectors. The trace-norm tail is uniform with the stated PNT decay; an explicit rank-one example shows why trace class alone does not bound the growing all-ones direction at RH scale. This is written mathematics.

The [original integer-birth feedback bridge](actual-integer-birth-positive-quadrature.md#formal-identification-with-the-original-feedback) now identifies the existing relative driver with the complete $\Lambda$-weighted birth difference in Lean. The half-density integral and absolute countable Fubini prerequisites are proved, and the exact Abel identity retains $b_j\psi(j)$ at every clock. The original $E$ is unchanged; its near-one positivity remains open.

The [max-to-sum process comparison](max-sum-process-transfer.md) proves the sharp $\pi/4$ upper bound and a reverse bound after complete prime-history damping, with the original frozen endpoint retained. Its RH equivalence cites the established fixed-clock original-source theorem. The [heat-generator identity](heat-generator-origin-flux.md) retains the negative-age origin flux on finite horizons and the signed birth pairing; three actual work intervals have an exact rational certificate. These analytic statements remain written, and the required subpower energy estimate remains open.

The [integer-history low-band identity](integer-history-low-band-pairing.md) joins the actual weighted prime prefix and frozen endpoint to factorial forcing and complete Euler edge memory. Its Bernoulli synthesis retains the origin and terminal cancellation. The [coupled Bernoulli energy](coupled-bernoulli-history-energy.md) exposes partial-divisor cross terms in the original max-kernel norm, with exact small-source rational certificates. Coprime and same-prime cross terms can be negative; the positive total and unconditional PNT bounds still do not control the missing RH-scale pairing. Both are written proofs.


The [formal continuous Abel kernel](successor-feedback-tail-Abel-poles.md#formal-continuous-abel-derivative-and-cancellation) proves `smoothAbelKernel_hasDerivAt` for $\Re z>0$, $y>1$. Its derivative has integrable zero-mass cancellation and an absolutely convergent actual-source pairing for $\Re z>1/2$. The proof keeps the initial cell and uses the exact causal-root translation norm.


The [heat/scaling derivative bridge](actual-heat-scaling-derivative-bridge.md) retains the deterministic density correction, source-terminal atom and primitive anchor. Equations (15)–(19) distinguish band energies, complex-square convolution readouts and whole-line Hermitian coercivity. Equations (20)–(22) sharpen the derivative multiplier to the exact bounds $1/\pi\le|m|^2\le\pi/4$, compare finite centered-Goldbach heat and scaling-derivative energies in both directions, and bound the derivative of each actual ground average by that positive heat energy. None is a finite-horizon heat-energy estimate. The [range proof](heat-to-killed-ground-range-obstruction.md) gives the divergent inverse-gamma cost for every fixed killed ground and its full signed Gram representations.


The [cross-age work calculation](cross-age-common-clock-relative-work.md) uses the actual complete-law multiplier and original physical metric. The fixed-source sign change has a source-dependent onset; it does not apply automatically at $s=c\log N$. All seed terms remain separate from the uncharged counterexample.


The [factorial clock correction](factorial-terminal-neutrality.md#4-the-actual-clock-correction-retains-a-signed-transport-drift) keeps $R_FD_v-D_vR_F=[b_F(e^{-v}x)-b_F(x)]D_vH$ in the original $L^2$ domain. The exact paired-history drift contains a mixed term and a square; positive history weights give no sign for their sum.
