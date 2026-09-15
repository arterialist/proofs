# Arithmetic probability, succession and phase

These notes study exact integer laws and operators that occur in the arithmetic sign problem. The links below separate proved identities, conditional implications and refuted strengthening attempts. Written proofs are not Lean theorems unless a note names the corresponding source and declarations.

## The triangular cutoff law

For $x>1$, the full law is

$$
P_x(n)=\frac{x-n}{\sqrt n\,Z_x}\mathbf1_{n<x},
\qquad Z_x=\sum_{n<x}\frac{x-n}{\sqrt n}.
$$

The [allocation identity](prime-allocation-critical-identity.md) first derives this law from two negative-binomial Euler histories. It retains their literal same-prime allocation diagonal, the endpoint atom and both continuous density terms in the exact formula for $W$.

The [prime-score covariance theorem](prime-score-negative-covariance.md) proves strict negative covariance for distinct active primes. Its proof proceeds through a finite-grid martingale, a strict power-sum ratio, monotonicity of every integer dilation ratio, and an exact prime-power size-bias identity. A separate increment-ratio proof and Gao's majorization theorem give different proofs of the power-sum comparison. The same chapter extends the full-law inequality to upper-orthant products and exponential moments, then gives an exactly certified failure of negative association at cutoff $570$ for increasing functions of disjoint prime groups.

The [conditional counterexample and corrected costs](conditional-prime-dependence.md) use the same law after revealing prime exponents. Excluding all primes below $101$ at $x=20806$ makes the $101$- and $103$-scores positively correlated. A rational certificate verifies the finite counts used in the proof. Thus full-law pairwise negative covariance cannot be substituted for negative dependence on every revealed-history branch. The note gives the exact positive regression costs and the conditional variance identity that must replace that substitution.

The [density-prime covariance theorem](density-prime-covariance.md) proves strict increase of the density mean and an exact negative covariance, which contributes positively to $W$. The [combined balance](combined-prime-density-covariance.md) then proves, at every real cutoff,

$$
\frac{W}{Z}=E R-T-\mathcal D-1-2e.
$$

It also gives unconditional bounds and the leading compensation between these terms. The difference $E R-T$ remains unsigned. Same-prime diagonal terms and correlations between conditional means remain part of any further argument.

## Succession and multiplicative phases

The [half-neighbor rigidity theorem](half-neighbor-phase-rigidity.md) recovers every adjacent difference from the observed odd/even half by the identity $m^2-1=(m-1)(m+1)$. Wirsing–Zagier rigidity then classifies unimodular completely multiplicative functions of finite defect as $n^{it}$. It also proves divergence for every nontrivial prime-proportional angle. The complex-power calculation in the same note shows precisely why this classification imposes no midpoint condition in the critical strip.

The [unitary phase lift](unitary-prime-phase-lift.md) applies the scalar theorem to the joint spectral measure of commuting prime unitaries. Finite defect on a cyclic subspace forces a self-adjoint scale generator $T$. Its exact defect multiplier satisfies $\psi(t)\sim\pi|t|/2$, and its form domain is $\operatorname{Dom}|T|^{1/2}$. This is a statement about unitary representations; the unilateral counting maps and nonunitary off-line zero phases require additional arguments.

Related constructions retain different information:

| Construction | Proved content and remaining limitation |
| --- | --- |
| [Divisor-conjugated successor](divisor-successor-overlap.md) | Signed Gram identities and local counterexamples; its full coherent norm requires a classical RH-equivalent Mertens bound. |
| [Integer renewal and phase memory](integer-renewal-and-phase-memory.md) | Ordered renewal identities and interference; no global cancellation estimate follows from path counting alone. |
| [Coherent division marking](coherent-division-marking.md) | Incidence-algebra chain identities with a specified decoder. |
| [Prime-clique cutoff](prime-clique-cutoff.md) | Exact arithmetic births; the stated critical-strip limit is not zeta. |
| [Face-feedback obstruction](integer-face-feedback-obstruction.md) | A counterexample to the specified positive-resolvent repair. |

The [harmonic prime Laplacian and flow](harmonic-prime-laplacian-flow.md) turn complete integer phase resolution into a quantitative lower bound with the physical prime weights $1/p$. The resulting actual line-one periodization has an infinite prime divergence with finite edge energy and absolutely summable weighted flux. Its full-multiplicity integer phase inequality, exact harmonic average, lcm coefficient formula and closed finite coefficient bound are formalized; the analytic flow and its $O(\log P/\sqrt P)$ admission error are written proofs.

## From finite arithmetic identities to an analytic consumer

The [prime-filter and Selberg identities](prime-filter-selberg-identities.md) and [finite arithmetic energy tools](finite-arithmetic-energy-tools.md) supply formalized finite identities and conditional estimates. Their individual notes identify the Lean declarations and the unformalized analytic inputs.

The [division renewal and dyadic average](division-renewal-dyadic-average.md) give an exact signed renewal law and a uniform negative bound for the actual integer dyadic divisor sum. Both the factorial inequality and its identification with the full prime-power average are formalized. The written boundary-cancellation and signed-transfer identities explain why that one-history sign does not yet control the critical two-history convolution.

The [harmonic-convolution theorem](harmonic-convolution.md) proves general time-domain, spectral and bounded-variation cancellation mechanisms for exact integer dilations. Its arithmetic application retains every prime power and gives an RH-conditional leading term. The required mean-energy estimate for the actual prime error is not established unconditionally.

The [actual arithmetic sign criterion](actual-critical-sign-criterion.md) is the formal downstream implication: a stated eventual sign of the complete arithmetic sum implies RH. It does not prove that sign. The local identities, covariance results and phase classifications above are possible inputs to this consumer, not substitutes for its missing global estimate.

The [scattering subject index](scattering-subject-index.md) follows a second analytic route from full prime-power discrepancy to a relative trace norm. It includes an unconditional density-cancellation estimate and the exact single-observation RH criterion, with its subpower premise still open.

## Actual finite-frequency readouts

The [successor cutoff theorem](actual-successor-frequency-cutoff.md) controls clustered integer jumps and retains the causal endpoint multiplier and literal same-prime cost in the full $W$. It gives square-root and $x^{3/8}$ frequency scales by different support arguments, and proves that the actual integrand takes both signs.

The [causal rectangle decomposition](causal-rectangle-frequency-cutoff.md) gives a cube-root cutoff by localizing both histories. The [integer-product argument](product-location-frequency-cutoff.md) then uses local divisor counts and a smooth Fourier kernel to recover normalized $W$ from frequencies at most $2x^{1/4}(1+\log x)^2$, with error $O(1/\log x)$. These estimates control discarded frequencies. The retained signed integral remains unbounded.

The [finite-band dyadic flux](prime-innovation-finite-band-flux.md) is a distinct consumer of the successor-tail estimate. Its particular causal innovation has full flux $1/2$, and the finite-band flux converges to that value unconditionally. It gives no positivity statement for all Weil tests.

The [opposite-history storage collection](scattering-subject-index.md#opposite-histories-and-their-signed-boundary) connects the actual inverse division strip to its Fourier modes, finite seam, folded storage cancellation and unilateral meromorphic transfer. It retains the initial zero bilinear response and the true off-line double poles, while controlling the projected product cutoff for each fixed prime.

## Prime-power overlap and the exact counting process

The [prime-power Gram theorem](prime-power-gram-correction.md) gives a positive discrete square decomposition for arbitrary signed coefficients on every prime chain. The [composite counterexample](composite-gram-obstruction.md) proves that this comparison fails for arbitrary divisor coefficients at cutoff $27$, with an executable rational certificate. It does not refute the comparison on a particular density vector.

The [mixed Jordan correction](jordan-mixed-correction.md) computes that particular prime–density cross term exactly and proves its adverse sign. Its pure density correction and the residual after scalar density cancellation retain genuine reciprocal-zeta poles; the stated eventual sign conditions imply RH. The full $W$ comparison is not proved.

The [counting-birth chapter](counting-birth-full-generator.md) constructs the unique successor-only pure-birth transport of the triangular law, including integer activation. Its full time-dependent arithmetic generator has both signs arbitrarily far out. The exact distributional birth forcing has a complete arithmetic sign classification. A divisibility-upset counterexample on $100<x<101$ rules out a coupling whose paths only increase by divisibility, while leaving the proved counting transport intact.

The [prime-division Feynman–Kac construction](prime-division-feynman-kac.md) retains the physical square-root division rates and their positive path weight. The completed first moment is exact, while a prime start already makes the completed second moment infinite. Its stable finite adjoint leaves a signed integrated prime error, and the fixed Chebyshev majorant has a positive unpaid baseline of order $x^2\log x$. These give precise path and aggregate obstructions without discarding the constructed representation.

The [macroscopic-prime sector](macroscopic-sector-sign.md) has a proved unconditional collective sign: the entire largest-prime contribution $P^+(n)>\sqrt x$ equals $-(1+\gamma)\zeta(3/2)x^2+o(x^2)$. Its proof keeps the cofactor readout and uses a uniform moving-prime tail bound. It leaves the complementary sector unsigned.

The [dyadic harmonic identity](actual-harmonic-doubling.md) retains the next-interval discrepancy, newly admitted integer scales and the initial contribution of the critical filter. The [endpoint-sensitive quadrature identity](harmonic-quadrature-correction.md) factors the exact harmonic error as $a*(R*Da)$ and gives an unconditional classical-PNT saving, still above the critical scale. Its actual derivative jumps have both signs. These finite identities provide separate methods from the mean-cancellation theorem.

The [prime-revelation martingale](prime-revelation-martingale.md) gives the exact finite-Euler conditional law and full Doob variance decomposition. A fixed one-prime branch has a positive conditional defect of order $y\log y$, so the full square budget cannot be proved separately on every history. The unconditional comparison must allow compensation between histories.

The [power-sized excursion theorem](full-w-off-critical-excursions.md) is a classical Landau consequence of the exact full-$W$ transform. Any zero $\beta+i\gamma$ with $\beta>1/2$ forces both unbounded positive and negative values of $W(x)/x^{3/2+\eta}$ for every $0<\eta<\beta-1/2$, with no dominant-zero or phase-alignment assumption. It is a conditional diagnostic, not evidence that such a zero exists.

## Cyclotomic counting and division geometry

The [adjacent-history construction](cyclotomic-adjacent-history-correction.md) places the exact two Farey-parent histories in a common cyclotomic field and computes the correction to reciprocal transport. A fixed actual pair has a positive clipped response, so the proposed reciprocal conservation and universal nonpositive response both fail.

The [finite fusion construction](cyclotomic-fusion-response.md) identifies selected one- and two-prime updates with eigenvalue moduli of classical SU(2) fusion matrices after a stochastic normalization. Its sign permits deficit growth, and all selected contributions already have a polylogarithmic absolute bound. A three-prime factor exceeds one, and the [selected recovery certificate](cyclotomic-selected-recovery.md) proves an actual decrease of clipped deficit below the threshold at cutoff 1533. Full-phase ratios and the partial-history transport explain why the finite stochastic bound does not extend to the full observable.

The [restricted-range refinements](cyclotomic-restricted-range-refinements.md) sharpen individual boundary costs while linking to the existing final reduced-coordinate region. [Exact valuation reduction](cyclotomic-valuation-update.md) removes neutral events using classical root-of-unity identities; neither valuation gaps nor norm-one resultants force favorable phase signs. [Delayed inverse pairs](cyclotomic-old-inverse-pairs.md) retain the entire intervening history and a threshold potential. Their positive corrected remainder is certified on three actual pairs, and the unresolved overlapping-charge problem is stated separately.

The [actual-prefix refinement theorem](actual-prefix-refinement.md) gives the exact two-row carry law, empirical bias and logarithmic information saturation. The [finite-prime Möbius consumer](finite-prime-mobius-consumer.md) retains every induced quotient cutoff and density correction, then proves a linear lower bound for the absolute prime-increment sum. These preserve the initial counting/division construction and its precise unresolved signed estimate.

## Full-support allocation and sign changes

The [prime-support removal theorem](prime-support-removal-asymptotics.md) preserves the actual marginal history, proves both response signs before each sufficiently large prime square, and computes a macroscopic deficit for every independent reservoir. Its exact fractional-allocation criterion is a finite max-flow/min-cut application. The full-set cut still requires the unproved full-support sign; fractional allocation alone does not supply it.

The [small-prime grouping theorem](small-prime-grouping.md) proves a uniform $N/\log N$ lower bound for the full grouped absolute majorant, including growing smoothness cutoffs. Its exact logarithmic-integral centering retains the original error with coefficient one and a weighted history correction. The centered source has the same power bound as the prime error for each fixed exponent above $1/2$; that bound is not proved.

## Source regularity and signed inversion

The [fixed regular-source obstruction](regular-source-mobius-obstruction.md) constructs separated tents on exact floor quotients, then applies Banach–Steinhaus to obtain one source for each exponent below $2/3$. Its size and first-difference bounds hold everywhere, while its signed Möbius inverse exceeds every eventual bound of that power. This formalized auxiliary counterexample does not satisfy the exact arithmetic increment identity for the centered divisor forcing.

The [cutoff-versus-period example](cutoff-period-gcd-obstruction.md) separates local sawtooth energy from the classical complete-period gcd form by a linear factor. It complements the exact incomplete carry formulas and the signed divisor-history covariance; none permits replacing the full actual arithmetic vector by an arbitrary-coefficient bound without an additional argument.

The [variable-length divisor-block proof](global-divisor-blocks.md) keeps the transform frequency inside a three-dimensional classical exponential-sum estimate and preserves a separate elementary correlation proof. Its terminal constant-quotient identity explains the arithmetic information left outside those block bounds.

## Age cells and completed prime boundaries

The [retained-age representation](age-resolved-prime-history-lift.md) leads to the [two-prime unilateral identity](two-prime-unilateral-boundary.md), with the actual source and both boundary terms preserved. The [causal-history port model](causal-history-overflow.md) identifies these as discarded line outputs under a unitary direct-integral map; the source energy is retained in that map.

Two distinct completion mechanisms follow. The [absolute coefficient tilt](late-age-prime-boundary-transfer.md) gives deterministic operator tails, while the same note's actual-source PNT estimate pays for every smooth history. The [entropy-count refinement](late-age-vk-history-entropy.md) uses the classical Vinogradov–Korobov remainder to allow $P=o(R^{3/5}/(\log R)^{1/5})$. This history count differs from the [geometric probability entropy](complete-prime-history-entropy.md), which controls averaged overflow. Their positive Gram and overflow quantities do not remove coherent cross terms.

The [full-product gamma-freezing theorem](uniform-full-product-arch-freezing.md) preserves the signed clipping term uniformly in the admitted prime set. The [successor/source compatibility theorem](successor-collective-prime-compatibility.md) supplies a complete prime-power commutator and an unconditional initial-boundary limit. Its PNT translation modulus does not presume finite global energy of the actual critical source. These statements provide inputs to further estimates; none supplies the missing RH-scale bound.

The [positive-kernel transfer](signed-divisor-positive-kernel-transfer.md) gives a separate global method for the signed divisor correction: exact finite Möbius rearrangement, the corrected Balazard–Daval kernel mass and an asymptotic profile transfer. It complements individual divisor-block estimates while retaining the direct signed Mertens term.

## Energy completion, adjoints and the actual readout

The [actual successor modulus](successor-collective-prime-compatibility.md) supplies the [mixed additive completion](actual-source-mixed-dirichlet-completion.md). Its low-frequency weight is proportional to $|\xi|$, while its high-frequency weight stays bounded, preserving the source's jumps. [Prime transport](prime-transport-in-mixed-completion.md) and [positive comparison](positive-prime-comparison-in-mixed-completion.md) distinguish the old operators from the conjugated unitary reference, with every metric defect retained.

The [anchored boundary energy](additive-energy-reflection-domain.md) controls local source windows even though full reflection leaves the completed source domain. The [paired source-port theorem](paired-metric-conservation-and-source-ports.md) then removes the arithmetic cutoff at each fixed observation window. The [sharp whole-space readout theorem](sharp-causal-readout-energy-growth.md) proves why energy membership alone cannot replace source-specific cancellation: its complete harmonic/filter norm has exponential scale and both signs. All six notes are written mathematics.

## A positive successor-seed process and its signed response

The [fixed-Cauchy covariance identity](fixed-cauchy-prime-covariance-seed.md) identifies the complete centered prime generator with the Gram form of its actual successor boundary profiles. It proves a fixed-observation $L^2$ limit and an exact two-port graph for every even Wiener multiplier of the ground profile, including nonlinear finite-prime heat. The [long-memory theorem](collective-successor-seed-long-memory.md) gives $B(v)=2/v-4/v^2+O(v^{-3})$ with a rapidly decaying density remainder.

The [positive jump process](positive-successor-seed-jump-process.md) uses the finite measure $B(v)\,dv/v$ to construct an all-prime probability law and a uniformly bounded orbit in the mixed source space. Its common causal inner factor preserves the actual prime response. The original centered generator is a domain-qualified derivative of this evolution; positive probability and bounded evolution alone do not control that signed response. These are written proofs using classical Bernstein, compound-Poisson, Hardy and PNT methods.

## Fixed-prime depth geometry

The [successor-depth theorem](fixed-prime-successor-depth.md) classifies all limiting normalized division depths at fixed offsets. Its classical smooth-part upper bound and effective CRT attainment have different strengths: the upper threshold is non-effective, while every admissible simplex-face vector has an explicit congruence construction. The infinite-offset extension proves the sharp subpolynomial scale for uniform observation horizons. The finite CRT and lcm inputs are already formalized; the analytic classification is a written proof.


## Fixed-observation heat and exact source thresholds

The [complete prime-heat theorem](fixed-observation-prime-heat.md) identifies the centered generator with a line-one zeta logarithm and its full proper-power correction. Two global domination methods support complex subcritical convergence, a meromorphic scalar continuation, the critical-window uniform law and an explicit large-age profile. The scalar integrability threshold is $1/2$; the ground seed's squared-norm threshold is $1/4$. Exact finite-source cancellation shifts the threshold, while an actual two-birth example proves that the successor need not preserve it. The [partial-cosine companion](uniform-partial-prime-cosines.md) retains every cutoff endpoint in the PNT proof. These are fixed-observation and finite-source theorems; no joint completion of the unrestricted arithmetic source or RH bound follows.


## All-order profiles and signed arithmetic bands

The [actual-window Sobolev theorem](real-window-phase-sobolev-orders.md) combines the Montgomery–Vaughan mean-value theorem with full geometric derivatives and Bell coefficients. It retains a separate elementary frequency-separation proof and gives explicit order bounds, arbitrary moving-threshold control and a canonical high-height remainder estimate. The [Haar moment identity](haar-profile-all-order-moments.md) instead computes the exact weighted profile energy from the full geometric law, including the finite-cutoff exponential-moment boundary and its high-order obstruction. Haar moments do not replace actual-window moments.

The [signed divisor-band theorem](signed-divisor-band-correlations.md) sums complete common-divisor histories at each reduced ratio before estimating them. It proves exact finite-difference cancellation and opposite signed sharp-boundary examples, while retaining the unresolved collective off-diagonal band sum. These are written methods with classical attribution, not fixed-observation RH estimates.


## Coupled prime-square admissions and centered source domains

The [coupled prime-square balance](coupled-prime-square-birth-balance.md) retains both prime generators and all admitted powers. Its generator cutoff $Q=\lambda xP^2$ has the uniform normalized law $2\sqrt\lambda-\lambda$, while $Q=P$ has a separately proved retained mass $4\sqrt P/(\sqrt x\log P)$. The [proper-power refinement](prime-square-proper-power-constant.md) preserves the logarithmic square contribution, all higher powers and the literal diagonal in a convergent constant; the old-generator loss has an explicit $1/\log P$ coefficient.

The [finite-source graph](centered-prime-natural-source-graph.md) and [sharp centered cutoff theorem](fixed-source-centered-cutoff-law.md) keep the innovation mass $M_N=1+\sum_{n\le N}\Lambda(n)/\sqrt n-2\sqrt N$ and its cross terms. Their fixed-source conclusions cannot be substituted for a uniform infinite-source bound; a precise [domain counterexample](centered-prime-domain-counterexample.md) illustrates that distinction.

## Carry arrivals and period-sensitive covariance

The [carry chapter](incomplete-carry-covariance.md) preserves distinct finite-Fourier and CRT proofs. It gives the exact positive growing-box arrival law, including old prime-power boundary rows, and complete-period covariance $(\gcd(d,e)^2-1)/(4de)$. Its explicit incomplete-box formula has positive covariance for the actual prime levels $11,13$ at cutoff $13$, as well as the earlier negative examples. Complete-period orthogonality therefore supplies no boundary-sign repair. These carry statements remain written proofs; the similarly named Lean module proves a separate finite-variance inequality.


## Actual centered loading at the integer clock

The [complete birth energy](infinite-centered-birth-energy.md) gives $\mathcal E(C_\infty h_t)\sim16/(t\log t)$. The [actual increment theorem](transformed-actual-arrival-loading.md) retains $v_n=(\Lambda(n)-1)h_n-b_n$, its unit-cell ramp and all cross corrections, proving total loading $16\log N$. Prime arrivals provide this leading order; density-only cells separately contribute $16\log\log N$, and proper-power loading is finite. The first error term is not small enough to combine these into a two-term expansion.

[Fixed positive-age evolution](positive-age-preserves-arithmetic-loading.md) preserves the same leading constants, even for infinite mean age. Neither bounded evolution in the original mixed source space nor summable ramp errors supplies the missing cumulative signed cross-work estimate for its centered image.


The [coprime-interior history theorem](cyclotomic-coprime-interior-history.md) gives a distinct exact gcd-layer correction retaining nonunit divisors. Two actual interior phases have opposite cyclotomic updates before the first reduced common-multiple scale, while both full clipped updates vanish. Its shifted CRT count explains why disjoint unshifted divisor sectors can already communicate through successor paths. An exact symbolic checker preserves the full prefix derivatives and clipping scope.

The [common-scale relative norm](cyclotomic-common-scale-norm.md) preserves a distinct norm-transitivity proof alongside the gcd-layer factorization. Its positive permutation average controls fibre means only. The exact algebraic trace, weight correction and clipping identities identify the remaining information, and a complete-prefix fixture shows why a nonzero weighted unit contribution cannot be read as a clipped deficit.


The [even-character separation theorem](even-character-zero-separation.md) removes a common-numerator-zero ambiguity in twisted Möbius/cyclotomic consumers. It preserves the full family quantifier over an unbounded set of prime conductors, allows the nonvanishing character to depend on the point, and supplies an exact height-dependent conductor threshold. Its continuation criterion is RH-equivalent; the all-epsilon summatory estimate for $\mu*\chi$ is an explicitly unproved sufficient premise, with no conductor-uniform constant required for the implication.

The [three-step matching extension](bounded-factor-matching.md#6-a-finite-example-with-genuinely-cheap-head-edges) retains an exact finite example with cheap head edges, a good-time dual, and the conditional extension to other fixed ratios. Its full positive-cost majorant has logarithmic growth exponent $5$; the signed coarse energy remains outside that lower bound.

The [original-graph coherent matching proof](coherent-large-label-matching.md) preserves the exact observable-distance identity, an actual three-edge cancellation repair, and complete fixed-matching energy and primal–dual certificates. Its whole-interval dual gives exponent $5-4/k$ for the positive majorant; the ratio-eight proof uses a different good-time argument.

## Positive successor primitive and the complete W comparison

The [actual primitive theorem](actual-source-successor-primitive.md) proves positivity at every positive age by exact arithmetic-cell extrema and a classical explicit PNT tail. The [complete W comparison](actual-W-positive-primitive-analysis.md) gives strict cumulative ordering, while a certified actual zero and a Laplace singularity argument prove that the unsmoothed difference has both signs arbitrarily far out. It retains the identical same-prime subtraction, density cancellation and unchanged off-critical double-pole coefficient. These are written and computer-assisted proofs, not the missing eventual W sign.


## Positive potentials and original-energy curvature

The [natural-cutoff primitive theorem](natural-cutoff-successor-primitive.md) proves strict positivity at every positive age for every $N\ge2$, including the frozen terminal tail. Its bounded Arb certificate complements the full-source proof. The [two-port construction](positive-primitive-two-port-drift-curvature.md) retains the complete midpoint terms and exact successor contact. A [short finite-measure proof](all-prime-fixed-source-drift-curvature.md) gives the all-prime limit at fixed $N$; a distinct [block-variation proof](full-prime-successor-potential-midpoint.md) gives uniform $H^2$ potentials and joint original-$L^2$ convergence of the successor correction. Individual columns and the full midpoint sign remain outside that conclusion.

The [actual cutoff-2, prime-2 computation](actual-finite-history-curvature-domains.md) exhibits a nonzero derivative of a Dirac mass, refuting the proposed nonnegative-curvature-measure hypothesis while retaining a valid Sobolev pairing. The [formal theorem mapping](all-prime-fixed-source-drift-curvature.md#formalized-energy-and-contact-forms) records the compiled unit-step estimate, lag-gradient form, contact bound $9$ and physical kernel expansion. The prime-column and logarithmic-commutator identities remain written proofs.


The [Haar refinement calculation](haar-prime-energy-completion.md#the-exact-refinement-forcing-before-fourier-completion) now includes the full divisor-coefficient update, independent translated forcing bound, a positive actual forcing certificate including the endpoint power, and its explicit pair/boundary obligation. The [uncentered overlap proof](temporal-floor-covariance.md#the-uncentered-overlap-formula) retains a separate geometric derivation of the same signed kernel and its exact fractional-part correction.


The [actual tilted first moment](actual-W-positive-primitive-analysis.md#formalized-actual-tilted-first-moment) now has Lean proofs at every real cutoff: exact factorial remainder, Abel integral, strict negativity after $1$ and the uniform bound $-\log2/2$ after $2$. The [critical-coordinate port modules](all-prime-fixed-source-drift-curvature.md#formal-critical-coordinate-ports) separately prove the causal successor/predecessor ranges and contact pairing under their stated $L^2$ and support hypotheses. These do not formalize the full W comparison or unrestricted anticausal curvature.

The [actual prime-two energy theorem](prime-two-anticausal-energy.md) proves the full-power, cutoff-two energy change is less than $-1/10$, with a passing bounded Arb certificate and all negative ages and unbounded tails retained. This complements the derivative-of-atom obstruction in the same example, without asserting a uniform sign for larger sources or prime sets.


## Frozen-source loading, successor renewal and variable time

The [charge-loading proof](actual-charge-arrival-loading.md) gives the exact two-term arithmetic square sum with a convergent proper-power/ramp constant and its seeded signed work. The [original-space birth Gram](original-l2-evolved-source-gram-work.md) transfers that loading through complete pairs of process histories with an error uniform over all times. Its terminal norm remains unevaluated.

The [literal compensated iterates](literal-compensated-successor-iterates.md) have an exact scalar renewal representation, a positive bounded reference orbit and a full signed arithmetic driver. This proves a finite-source bound independent of iteration count, not positivity of arbitrary source iterates. The [variable-time theorem](variable-time-source-exponent.md) proves the exact growth exponent $\max(\kappa_0-\delta,0)$ for schedules of exponent $\delta$, including oscillating subpolynomial schedules. It retains the no-jump term and frozen endpoint; sufficiently long polynomial times can have zero exponent without an RH conclusion. These source/renewal results are written proofs, separate from the formal process dependencies.


The [long-time signed-source expansion](long-time-signed-source-rank-one.md) retains the exact charge-square term and a source-curvature correction of order $t^{-3}$. Actual cutoffs two and six have opposite correction signs, certified by bounded Arb arithmetic. Its direct absorption proof needs subpolynomial times with $t/\log^{3/2}N\to\infty$; the variable-Laplace method applies to every subpolynomial schedule. Neither supplies the required source bound.

The [uniform successor-driver theorem](uniform-successor-driver-square-bound.md) proves an actual $\ell^2$ constraint by full-line $H^1$ control and integer sampling, with a completed difference-integral consumer. The same exact reference renewal has synthesis norm of order $\sqrt k$. This identifies the loss from using the square-sum estimate without further signed arithmetic information, while retaining the complete driver Gram.


The [cutoff-centered Gram estimate](weighted-prefix-centered-source-gram.md) replaces logarithmic moment losses by an explicit finite weighted-prefix supremum. Finite Abel absorption then works for every diverging subpolynomial schedule, conditional on the actual evolved subpower estimate. This sharpens the older direct rank-one consumer while preserving its proof as a distinct method; the variable-Laplace theorem also covers bounded schedules. The unknown prefix supremum is retained until it is absorbed, never assumed bounded.


The [distinguished-return repair](integer-renewal-and-phase-memory.md#distinguished-return-after-incidence-inversion) recovers the literal state-one renewal after incidence inversion, where an uncorrected resolvent loses the return event. Its marked full-division histories derive both von Mangoldt kernels and a positive real dressed trace, with exact finite energy/variance bounds. The complete trace still has a persistent mixed-prime coefficient. A passing exact symbolic certificate retains primitive-word counts, boundary matrices and finite complex-clock counterexamples; the classical Bowen–Lanford, Rota and Redheffer precedents are explicit.


The [presieved prime-pair completion](presieved-prime-pair-completion.md) derives exact Ramanujan/CRT masked spectra and a scalar-charge obstruction for primorial $W\ge30$, $h\ge4W$. A distinct full nonuniform completion on the actual interval $(64,128]$ gives a certified lower bound above $16.90$, where the optimal scalar bound is below $-61.02$. The rational/Arb certificate passes with every allowed coordinate and prime-power exception retained. Cheap weighted completion at growing scales, the cyclic density cost and signed endpoint contributions remain unresolved.

The [local reflection and filter identities](actual-W-positive-primitive-analysis.md#formal-local-reflection-and-the-literal-exponential-filter) are formalized in [ReflectionEnergy](BuildingBlocks/ReflectionEnergy.lean) and [ReflectionFilter](BuildingBlocks/ReflectionFilter.lean). Actual local $L^2$ data suffice for the exact reflected convolution, mixed defect and positive filtered-square kernel; Fubini and integrability are derived. These identities leave the full $W$ sign open.

The [complete same-prime history theorem](full-history-same-prime-residual.md) retains every proper power and proves $-s(v)\le\int s(v-r)d\mu-s(v)\le0$ for every causal probability law. The residual is strictly negative after $\log4$ when positive delays have positive mass. Its finite-sum, measurability and integral proof is formalized; PNT constants and full $W$ consumers remain written. The same dependency chain proves actual chronological divisibility monotonicity and the product-event Turán bound.

The [formal prime-block chain](actual-W-positive-primitive-analysis.md#formal-prime-block-calibration-distinct-pairs-and-density-terms) now identifies the full-power sum with the existing $\psi$, calibrates the same-prime filter, expands the actual source into ordered distinct pairs and both density orders, and evaluates each normalized coefficient with exact endpoints. Local $L^2$ and all integral exchanges are derived. The final finite-$V$ assembly and harmonic aggregation remain separate consumers.

The [prime hard-wall proof](prime-hard-wall.md) retains exact integer occupations and exhibits both marginal covariance signs despite conditional repulsion. It gives positive-slack and logistic representations, explicit Möbius and full-power cutoff errors, and a positive-temperature mixture obstruction. The limiting contour loses uniform absolute control; no critical-strip bound follows. The squarefree Möbius, full-power Liouville and Mangoldt readouts remain distinct.

The [actual factorial Picone identity](picone-frozen-source-work.md) retains the initial source and the entire observing prime tail. Its [closed-domain proof](factorial-ground-state-original-l2-domain.md) gives an explicit bounded inverse on the original $L^2$ space and the exact singular endpoint. The [growing-clock theorem](factorial-source-clock-loading.md) proves uniform absolute summability of the prime-minus-density diagonal difference and equal leading logarithmic coefficients for both positive loadings. It retains the signed mixed work and separate clock terms; no bound on those terms or zeta spectral identification follows. These results are written, not Lean-formalized.

The [literal successor transport of the additive Goldbach source](goldbach-literal-successor-counting-transport.md) gives exact positive birth kernels, their full pair escape probability and an $O(X)$ shifted counting deficit from Chebyshev. Compensation retains the linear and squared charge ports. The ordinary weighted comparison has a finite constant and remaining error $O(\log X/X)$; the PNT calibration gives deficit $2X+o(X)$. The source identification uses the classical Matsumoto–Suzuki explicit formula. No additive existence, global screw-sign or RH bound is inferred. This is written mathematics, not Lean.

The [centered additive circle consumer](goldbach-additive-source-consumer.md) transfers the Goldston–Suriajaya positive majorant to the original frozen-source norm and complete clock action, retaining the seed and terminal square. Its subpower majorant hypothesis remains open. The [factorial-ground screw decomposition](factorial-ground-screw-increment-consumer.md) produces an explicit positive square plus the full ratio-prime, Hardy, gamma and contact residual; the residual has a nonzero $\varepsilon\log(1/\varepsilon)$ small-configuration term. The distinct [coherent-core screw readout](actual-core-screw-increment-readout.md) retains the signed full-kernel observation. Its general screw-cone counterexample does not determine the actual zeta sign. All three consumers are written proofs.

The [complete time-ordered factorial birth correction](time-ordered-factorial-birth-trace-class.md) is trace class, including the seed and first density cell. It retains the actual later admission time for each pair and gives the exact prime-minus-density budget as its quadratic form on finite all-ones vectors. The trace-norm tail is uniform with the stated PNT decay; an explicit rank-one example shows why trace class alone does not bound the growing all-ones direction at RH scale. This is written mathematics.

The [finite-horizon centered Goldbach heat identity](centered-goldbach-heat-lyapunov.md) places the additive coefficients $R_\Lambda(k)-2\psi(k-1)+(k-1)$ directly inside the positive heat energy whose Lyapunov exponent detects off-critical zeros. It converts the missing step into a polynomial comparison between consecutive logarithmic heat horizons. The [reverse-scale audit](centered-goldbach-reverse-scale-audit.md) records the exact signed Duhamel innovation and the best bound obtained from unconditional PNT input. The [successor neutrality theorem](goldbach-successor-critical-scale-neutrality.md) shows that the exact positive successor transport preserves rather than improves that critical scale. The [scaling-kernel hard-wall audit](goldbach-scaling-kernel-hard-wall.md) gives a second exact Goldbach dual and quantifies the cutoff-dependent projector degree below absolute convergence. The [Euler-discrepancy audit](prime-division-euler-discrepancy.md) fixes the causal endpoint convention, proves the positive-cell formulas and sign-changing centered remainder, and separates the actual heat response from false unrestricted BIBO stability. The accompanying Lean modules formalize the closed endpoint, compensation, projector, and renewal-arch algebra; the analytic Lyapunov consumer remains written mathematics.

The [amplitude-level successor heat transfer](successor-heat-lyapunov-transfer.md) retains every prime power and the full continuous successor tail in an exact Volterra identity. The transported and original critical profiles differ by finite energy, giving two-sided energy comparisons and the same RH-equivalent Lyapunov and doubling conditions. It does not prove the missing scale bound and has no Lean formalization.

The [original integer-birth feedback bridge](actual-integer-birth-positive-quadrature.md#formal-identification-with-the-original-feedback) now identifies the existing relative driver with the complete $\Lambda$-weighted birth difference in Lean. The half-density integral and absolute countable Fubini prerequisites are proved, and the exact Abel identity retains $b_j\psi(j)$ at every clock. The original $E$ is unchanged; its near-one positivity remains open.

The [max-to-sum process comparison](max-sum-process-transfer.md) proves the sharp $\pi/4$ upper bound and a reverse bound after complete prime-history damping, with the original frozen endpoint retained. Its RH equivalence cites the established fixed-clock original-source theorem. The [heat-generator identity](heat-generator-origin-flux.md) retains the negative-age origin flux on finite horizons and the signed birth pairing; three actual work intervals have an exact rational certificate. These analytic statements remain written, and the required subpower energy estimate remains open.

The [integer-history low-band identity](integer-history-low-band-pairing.md) joins the actual weighted prime prefix and frozen endpoint to factorial forcing and complete Euler edge memory. Its Bernoulli synthesis retains the origin and terminal cancellation. The [coupled Bernoulli energy](coupled-bernoulli-history-energy.md) exposes partial-divisor cross terms in the original max-kernel norm, with exact small-source rational certificates. Coprime and same-prime cross terms can be negative; the positive total and unconditional PNT bounds still do not control the missing RH-scale pairing. Both are written proofs.

The [effective-PNT subquadratic proof](centered-W-subquadratic-pnt.md) establishes $V(x)=o(x^2)$ and $W(x)=o(x^2)$ by an endpoint-exact double Stieltjes formula and two dominated-convergence arguments. The complete same-prime subtraction is bounded by $O(x^{3/2}\log^2x)$. The corrected [projector allocation](prime-state-projector-boundary.md) retains the separate $n=1$ sector, so its leading cancellation involves state $1$, primes and composites. These asymptotics are written proofs with classical PNT input, not RH-scale sign bounds.


The [formal signed Goldbach heat chain](centered-goldbach-heat-lyapunov.md#formal-signed-heat-energy-and-the-actual-series) links `finiteEnergy_eq_heat_integral`, `finitePairing_sq_le` and `mixedCenteredHeat_eq` to the classical gamma integral, full signed finite energy and exact actual density baseline. Positive-time series convergence is proved; no infinite Mellin interchange or RH bound is assumed.


The [infinite heat and density-cost formalization](centered-goldbach-heat-lyapunov.md#formal-density-cost-and-the-infinite-identity) maps `centeredEnergy_eq_heat_integral` and `finiteEnergy_centered_tendsto` to the complete actual ordered-pair series for real $s>2`. `mixed_energy_le_centered` and its reverse prove the finite-horizon comparison with no caller-supplied source integrability assumption.


The [actual common-clock counterexample](cross-age-common-clock-relative-work.md) derives the exact two-history birth Gram and certifies both a positive symmetric history port and a positive zero-frequency mass difference at $N=14$, $j=12$. A complete-process spectral argument proves eventual positive uncharged relative work, while the initial work is negative. The same-history negative square cannot be substituted for this full average.


The [actual factorial terminal theorem](factorial-terminal-neutrality.md) combines a negative-Laplace lower-tail estimate with the PNT-small late factorial coefficient. It proves asymptotic isometry on $T_{c\log N}g_N$ for fixed $c>0$ and the same nonnegative source exponent. The bounded Hermitian correction remains signed, including both clock cross orders and all observing prime powers.


[GoldbachHeatConvolution.lean](BuildingBlocks/GoldbachHeatConvolution.lean) proves `shiftedGoldbach_eq_prime_psi` and `centeredHeat_square_eq_goldbach`. The shifted index $j$ denotes additive total $j+2$, retaining $n=1$ and both complete Mangoldt marginals. The [source mapping](centered-goldbach-heat-lyapunov.md#formal-complete-additive-readout) distinguishes positive heat energy from signed additive coefficients.

The [odd-centered parity reduction](goldbach-odd-centered-finite-energy-reduction.md) evaluates powers of two and odd-lattice density as a finite-energy correction. `GoldbachOddCentering`, `GoldbachOddPairs` and `GoldbachWeightedOddPairs` formalize its finite coefficient foundations, exact count and symmetric weighted expansion. The [balanced window identity](balanced-odd-goldbach-window-energy.md), [transform bridge](odd-source-window-heat-transform-bridge.md) and [finite-source heat/window norm comparison](odd-heat-balanced-window-norm-comparison.md) remain written analytic proofs. A uniform bound on the partially admitted terminal window is still required; no critical-energy or prime-existence estimate follows from the coefficient identities.

The [actual clocked cutoff-window transfer](actual-clocked-window-odd-heat-transfer.md) controls the complete causal process output by the literal finite odd heat energy, with a fixed-band gap and all paired histories retained. The [original frozen-metric map](odd-cutoff-heat-original-frozen-metric-map.md) identifies that heat profile with a Gamma(3/2) convolution of the original frozen source plus a correction of squared norm at most 5. Its unrestricted squared operator norm is pi/4. Both are independently reviewed written proofs, not Lean theorems. No reverse estimate, observation/process commutation, signed Weil positivity or RH-strength bound is claimed.

The [actual paired-history block sign change](actual-paired-history-block-sign-change.md) proves that every finite compact scattering block with at least two distinct primes has both positive and negative correction atoms at every positive history depth. Unique prime factorization excludes coordinate collisions. The origin coefficient and total mass are distinguished. This independently audited written proof limits measure-sign deductions; it provides no sign or upper bound for the full Weil scalar and no RH conclusion.

The [original density and seed charge](original-density-seed-charge-cancellation.md), [frozen-source birth work](frozen-birth-exact-original-metric-work.md) and [triangular birth Gram](frozen-birth-triangular-gram.md) have compiled finite foundations in the eleven `Charge*` modules linked from the building-blocks index. They reuse the complete central psi and existing relative charge, retain the terminal square and density ramps, and prove the full signed finite quadratic. Real-density identification, the integer-cell norm presentation and total birth-loading action are distinguished as written statements. No global L2 assumption, all-age charge sign or RH-strength energy bound is introduced.

[ChargeFrozenIntegrability](BuildingBlocks/ChargeFrozenIntegrability.lean) adds the literal frozen source's global L¹ membership and absolute convergence of every real-frequency Fourier integral, with [precise scope](frozen-source-fourier-integrability.md). [ChargeFrozenFourier](BuildingBlocks/ChargeFrozenFourier.lean) proves the [exact finite-source Fourier–Mellin identity](frozen-source-exact-fourier-mellin.md), retaining every Mangoldt power, the actual density integral and seed −1. The [uniform spectral envelope and actual logarithmic-moment application](frozen-source-spectral-logarithmic-bound.md) are compiled in `ChargeFrozenSpectralBound` and `ChargeFrozenLogMoment`, reusing the existing unconditional Chebyshev and Abel bounds. [ChargeFrozenFourierNorm](BuildingBlocks/ChargeFrozenFourierNorm.lean) supplies the [actual global L² and autocorrelation prerequisites](frozen-source-plancherel-prerequisites.md), including frequency conversion and the physical terminal square. [ChargeFrozenPlancherel](BuildingBlocks/ChargeFrozenPlancherel.lean) certifies the [exact angular spectral mass identity](frozen-source-exact-plancherel.md) and the logarithmic-moment bound with physical mass. These results do not provide the original RH estimate.

The [finite paired scattering formalization](paired-scattering-finite-formalization.md) proves the exact actual local coefficients and the uniform half-strip bound in Lean. The [full-zero proof](dyadic-full-zero-sum-transport-proof.md), [large-history repair](dyadic-full-weil-large-history-repair.md), [linear-age transfer](linear-age-full-signed-scattering-transfer.md) and [uniform paired repair](paired-multiplier-uniform-strip-repair.md) retain every actual zero, observing prime power, archimedean term and compact history. Their complete analytic transfer estimates remain written proofs and recover the signed original readout without bounding or signing it.

The [cutoff-clock net work](clocked-cutoff-net-work-dissipation.md) and [actual square-completion defect](actual-source-square-completion-defect.md) retain the full clock on each new source increment and the frozen constant tail. Actual prefix mass forces a mismatch from the unrestricted maximizer and cancels the leading generic cost. The remaining cumulative signed work has no RH-scale upper bound. These are independently reviewed written proofs, not an RH advance or a process/Weil-form identification.


## Native integer births and clocked cumulative history

The [native birth-probe construction](integer-birth-probe-joint-history-and-work-transfer.md) and [independent proof](integer-birth-probe-independent-review.md) give bounded normalized synthesis cost for a compact translated probe and absolutely summable signed-work transport to the established full-factor scalar. [IntegerBirthHistory](BuildingBlocks/IntegerBirthHistory.lean) compiles the exact coefficient telescope, literal cumulative-history successor identity, original psi error reconstruction, logarithmic remainder strictly between zero and one, and boundary-inclusive finite pairing. [IntegerBirthGram](BuildingBlocks/IntegerBirthGram.lean) compiles the literal dv-metric seed Gram 1/max(m,l), product and finite-square integrability, and the complete finite signed-coefficient energy expansion. Analytic approximation, PNT work tails and inverse clock estimates remain written proofs.

The [clocked cofactor average](actual-clocked-cofactor-row-positive-average.md) preserves the actual odd source, complete kernel histories and terminal atom. Its [native history transfer](clocked-cofactor-native-birth-probe-transfer.md) pays the deterministic seed/parity/power correction. The [terminal metric calculation](clocked-native-probe-terminal-metric.md) shows that this exact row probe has squared norm asymptotic G(0)^2 b/s^10 and growing normalized birth synthesis cost of order b/s^5. These written results retain the terminal cancellation; neither positive probe geometry nor the compiled Gram square supplies the missing signed arithmetic upper-work bound. RH and the full analytic Lean formalization remain unfinished.

The [unit terminal-cell readout](native-terminal-unit-probe-exact-error-readout.md) distinguishes frozen and drifting density conventions exactly. Its normalized readout is E(b)/sqrt(b(b+1)), with the drifting convention retaining the explicit logarithmic remainder. Bounded unit readout does not control the unnormalized terminal row. This is independently reviewed written mathematics.

The [growing compact Euler product bound](compact-euler-growing-product-admission-bound.md) proves uniform norm and inverse bounds at fixed depth M>=3, and a summable dyadic signed archimedean admission error at M>=5 under the coarse source energy hypothesis. Depth two has a logarithmic inverse cost. This is written transport mathematics; the complete signed arithmetic row and RH bound remain open.

The [finite centered additive heat formalization](finite-centered-additive-heat-formalization.md) certifies the complete actual finite Lambda source Gram, genuine continuum density, seed and successor in Lean. All powers and both mixed orientations remain. Classical gamma and positive Fourier-weight calculations are compiled; actual source Fourier identification and the RH-strength upper bound remain open.

- [Three narrow windows with global pole-moment carriers](three-window-global-pole-null-weil-bound.md): independently reviewed written Weil positivity on a restricted support family, retaining prime 2, power 4 and all inter-window pole moments; seven scalar budget declarations compiled. No growing-family or RH claim.

- [Global pole constraints and complete binary histories](binary-global-pole-history-extremizer.md), with the [gamma-plus-binary partial-form counterexample](gamma-binary-partial-form-counterexample.md): independently reviewed written constrained extremizers and a failure of a single-place positive completion; all powers of 2 retained, five scalar inputs compiled, full other-place row unestimated.

## Common-score theta covariance form algebra

The [conditional-edge estimator](theta-affine-comparison-conditional-edge-energy.md) retains one common score coefficient across the complete continuous and prime components. [ConditionalScoreQuadratic](BuildingBlocks/ConditionalScoreQuadratic.lean) proves its [general square completion, positive bilinear rank remainder and exact separate-optimization penalty](theta-common-score-separate-optimization-penalty.md), including zero-energy cases. The actual edge-domain identification remains written; a small separately optimized expression does not certify the required joint residual smallness.

### Exponential weak ground prime tails

[Prime-tail prerequisites](theta-exponential-weak-prime-tail-lean-prerequisites.md) and [compiled Lean](BuildingBlocks/WeakGroundPrimeTail.lean): literal all-integer Mangoldt coefficients, both shifts, integrable overlaps, and complete absolute convergence for exponential tests with decay exponent greater than one half. Actual ground moment identification and the remaining weak equation are written prerequisites.

[Complete prime-cutoff convergence](theta-exponential-weak-prime-cutoff-limit.md), compiled in [WeakGroundPrimeCutoff.lean](BuildingBlocks/WeakGroundPrimeCutoff.lean), passes the translated test cutoff through both Bochner overlaps and the full prime-power series under these same moment and measurability premises.

## Local finite-history scattering signs

[Local compact scattering](compact-local-scattering-no-contraction.md) and [compiled Lean](BuildingBlocks/CompactLocalScatteringSigns.lean): exact original complex-power multiplier dictionary, finite geometric histories, attenuation at zero and amplification at pi/(M log p), for every prime and M ≥ 1. Physical compact pole-null test realization remains written; no actual-source or dyadic-product sign follows.

## Actual physical theta series

[Literal series foundation](physical-theta-series-lean-foundation.md), compiled in [PhysicalThetaSeries.lean](BuildingBlocks/PhysicalThetaSeries.lean): exact positive-index normalization, all-real absolute convergence and measurability, positive half-line. No even surrogate replaces the actual series; parity is proved in the subsequent Poisson module; actual ground moments remain unfinished.

[Finite scattering packets](BuildingBlocks/CompactScatteringPackets.lean) compiles seven prerequisites for the direct physical proof: literal interval support separation, disjoint finite norm squares, integrated translation-invariant norms, isolated coefficient energy, and a finite amplification length. The complete operator assembly remains written.

[Exact finite-box coefficient stencil](BuildingBlocks/CompactScatteringCoefficients.lean): complete positive/negative local history indices, exact interior phase factorization and squared norms, and actual prime interior amplification. This is coefficient algebra; the full physical operator regrouping is now compiled in [CompactScatteringOperator](BuildingBlocks/CompactScatteringOperator.lean), including an actual prime finite-packet gain theorem under stated bump hypotheses.

[Literal theta seed derivatives](physical-theta-seed-differential-foundation.md), compiled in [PhysicalThetaSeed.lean](BuildingBlocks/PhysicalThetaSeed.lean): actual first/second derivatives and exact term identity, including n=0; scalar sum reconstruction with proved summability. This does not yet identify the derivative of the infinite sum.

[Actual theta infinite differentiation and continuity](physical-theta-local-derivative-interchange.md), compiled in [PhysicalThetaUniform.lean](BuildingBlocks/PhysicalThetaUniform.lean): fixed-interval summable envelopes justify both differentiations and full-series continuity. The scalar reconstruction is now identified with the derivative of the actual sum; the subsequent Poisson module proves parity; moment integrability remains separate.

[True theta parity via Gaussian Poisson summation](physical-theta-true-poisson-parity.md), compiled in [PhysicalThetaParity.lean](BuildingBlocks/PhysicalThetaParity.lean), proves the exact integer Gaussian dictionary, actual derivative parity, literal Phi evenness and strict positivity on the full real line. Exponential moments, the xi transform, the actual killed-ground equation and arithmetic residual smallness remain unfinished.
[Narrow pole-null scattering carrier](narrow-pole-null-scattering-carrier.md): actual smooth bump construction, two exponential moment cancellations and positive physical square mass, with a complete finite prime amplification consumer. No actual-source or RH sign estimate follows.

[Actual theta exponential moments](physical-theta-exponential-moments.md), compiled in [PhysicalThetaMoments.lean](BuildingBlocks/PhysicalThetaMoments.lean), proves integrability of exp(beta |u|) Phi(u) for every fixed real beta from a literal Gaussian bound. It also proves bounded measurable multiplier and exterior-indicator consumers. This closes the moment-integrability prerequisite listed above; actual killed-ground construction, boundedness, the full ground equation, xi identification and arithmetic residual smallness remain unfinished.
[Growing-prime scattering bounds in original notation](growing-prime-scattering-lean-bounds.md): actual p-dependent histories and both orientations, uniform half-strip block norm, quantitative interior defect and complete weighted-sum split. No critical-line or signed arithmetic bound is assumed or proved.

[Literal complete core arrival](physical-ground-complete-core-arrival-foundation.md) compiles the complete prime-arrival series, almost-everywhere absolute convergence and an explicit local bound from the bounded exterior source. It also gives a written direct logarithmic bound for the continuous arrival and full core L2 regularity. The continuous and L2 consumers, actual ground construction and eigenvalue equation remain unformalized. No arithmetic sign or RH conclusion follows.

[Full physical history Mellin weights](full-physical-history-mellin-weights.md) compiles the exact complex Mellin multiplier of the complete physical history, the reflected-conjugate cross weight and finite history compositions. Its infinite-sum consumers retain explicit summability and gap premises. Actual zeta-zero and explicit-formula consumers and the signed arithmetic estimate remain unfinished.

[Physical correlation Mellin and arithmetic cutoff](physical-correlation-mellin-arithmetic-cutoff.md) formalizes the exact reflected-conjugate correlation transform, weighted integrability, full physical-history multiplier and joint finite-translate prime-power cutoff. The infinite arithmetic and explicit-formula consumers and signed estimate remain unfinished.

[Continuous arrival kernel foundation](physical-continuous-arrival-kernel-lean-foundation.md) compiles the literal kernel bounds, its logarithmic boundary primitive and far-tail integrability. The source parameter integral, full core L2 consumer and actual weak-ground equation remain further obligations.

[Complete arithmetic correlation support](complete-arithmetic-correlation-support.md) compiles automatic absolute convergence and a stable cutoff for the full prime-power correlation row from literal compact supports. It includes the full joint finite-translate row and common-cutoff consumers for actual physical histories. The complete explicit formula and signed arithmetic estimate remain unfinished.

[Continuous arrival measurability and squared boundary](physical-arrival-boundary-measurability-lean-foundation.md) compiles source and parameter-integral measurability, squared-logarithm integrability at both core boundaries and the full logarithmic squared majorant. Absolute convergence and the majorant inequality for the actual arrival remain separate consumers.

[Complete prime arrival core regularity](physical-prime-arrival-core-regularity.md) now compiles almost-everywhere strong measurability and actual core L2 membership from the literal bounded exterior source, retaining every prime power and both orientations. The full continuous arrival and weak-ground equation remain separate consumers.

[Actual continuous source interior convergence](physical-continuous-source-interior-convergence.md) now compiles absolute integrability of the literal continuous arrival at every interior core point from a bounded measurable exterior multiplier. This resolves the total-integral convention there. Its quantitative boundary bound, full continuous core L2 consumer and weak-ground equation remain unfinished.

[Actual completed-zeta boundary and xi](actual-completed-zeta-boundary-and-xi.md) compiles gamma normalization, the complete von Mangoldt right-boundary logarithmic derivative and an entire xi with correct pole values and actual positive-half-plane zeta-zero correspondence. Contour limits, multiplicity residues, the full explicit formula and the signed estimate remain unfinished.

[Complete literal core arrival L2](physical-complete-core-arrival-l2-lean.md) now compiles the quantitative boundary bound for the actual continuous integral and L2 membership of its sum with the complete prime arrival on the closed core. This closes the continuous and full-core regularity obligations mentioned above, under the stated bounded measurable multiplier hypotheses. Actual killed-ground construction, its operator equation, the full Weil identity and the arithmetic sign estimate remain unfinished.

[Actual xi multiplicities and local logarithmic derivative](actual-completed-zeta-boundary-and-xi.md) now proves finite actual zero orders, xi/zeta order equality on the positive half-plane away from 1, isolated xi zeros, and the punctured logarithmic-derivative limit with the actual multiplicity. The xi right-boundary formula retains both rational pole corrections and every von Mangoldt term. Global contour limits, infinite residue sums, the full explicit formula and the signed arithmetic estimate remain unfinished.

[Ground-clock mixed commutator cancellation](theta-ground-mixed-commutator-cancellation.md) retains the actual two-path rate defect and both holding rows. Four compiled pointwise identities establish the full algebra and reversal antisymmetry. The real quadratic commutator cancels in the written finite-cutoff operator argument; it cannot pay the conditional residual. Continuum substitutions and operator limits remain unformalized, and the symmetric mixed product remains an unresolved estimate.

[Literal theta measure and exterior ground space](physical-theta-measure-ground-space-foundation.md) compiles the finite positive theta measure, its Lebesgue null-set dictionary and the exact physical weighted square cost. A separate arrival consumer derives complete core L2 from measurability and a bound only in the exterior theta space, proving the literal source is unchanged by zero extension. Actual ground construction, boundedness and its full operator equation remain unfinished.

[Actual physical local zero weights](actual-physical-local-residue-weights.md) compiles continuous bilateral Mellin weights, actual multiplicity-bearing xi/zeta local coefficients and full finite-history multipliers. It retains both endpoint corrections and proves zero local pole coefficients for pole-null tests, with a constructed nonzero carrier consumer. Entire analyticity, global contour limits, infinite zero sums and the signed arithmetic estimate remain unfinished.

[Literal theta killed jump energy](physical-theta-jump-energy-quotient-foundation.md) defines the complete extended continuous-plus-prime energy on the actual theta Hilbert spaces and proves representative invariance and absolute-value contraction. Zero extension retains core-crossing killing costs; reverse-edge symmetry retains both orientations in the single-count convention. Closedness, smooth-core density, operator construction, the actual ground and the arithmetic sign estimate remain unfinished.

[Entire compact physical Mellin weights](compact-physical-mellin-analyticity.md) proves the actual first-moment derivative, entire paired/centered/full-history weights and exact cancellation of both weighted rational pole terms on circles containing 0 and 1. This closes the compact-weight analyticity obligation; global zeta contours, infinite residue sums, gamma inversion and the arithmetic sign estimate remain unfinished.

[Scalar structure of the literal killed energy](physical-theta-jump-homogeneity-domain.md) proves exact extended quadratic homogeneity for each continuous and complete prime component and the full/killed energies. It transfers the identity to actual exterior Hilbert vectors and proves the candidate finite-energy domain contains zero and is closed under all real scalars. Addition closure is established by the subsequent exterior-subspace batch. Closedness, operator construction and the actual ground equation remain unfinished.

[Positive killing cost for a constant exterior test](physical-constant-killing-positivity.md) proves positive actual edge mass at every positive displacement and positive complete killed energy for R>0 and a nonzero constant. The full prime sum retains its positive log(2) term and all other powers. This exposes a boundary cost lost by internal-only edges; no uniform spectral gap or RH sign estimate follows.

[Actual local zero-circle residues](actual-zero-circle-residues.md) proves exact multiplicity-bearing xi/zeta circle integrals with a radius independent of the entire physical test. Full finite history blocks retain the complete paired multiplier, with an exact signed circle difference and a norm comparison under an explicit interior gap. Global contours, infinite zero sums and the arithmetic sign estimate remain unfinished.

[Finite killed-energy exterior subspace](physical-theta-jump-addition-domain-subspace.md) compiles extended addition bounds with every prime power retained and transfers them to actual exterior Hilbert vectors through almost-everywhere representative invariance. The exact finite-energy carrier is now a real submodule. Closedness, polarization, smooth-core density, the represented operator and the arithmetic gap remain unfinished.

[Completed-zeta circle pole corrections](completed-zeta-circle-pole-corrections.md) proves the actual completed-zeta/xi logarithmic derivative dictionary, circle integrability and both exact rational corrections. Actual compact pole-null weights cancel both terms before and after every finite complete history block. Boundary xi nonvanishing is explicit; interior zeros are unrestricted. Global contours, infinite residue sums and the arithmetic sign estimate remain unfinished.

[Odd prime reflection-atom obstruction](theta-odd-prime-atom-obstruction.md) proves a positive disjoint compact-test cross form from the actual log(2) reflection edge, while the full continuous term is of smaller order and every other prime-power term vanishes by support. It excludes positivity of the odd halfline semigroup for a closed realization with this literal form, including every real measurable multiplication sign gauge. The gauge argument derives the needed test-domain inclusion from absolute-value closure under assumed positivity. This is written mathematics; the sharp spectral gap and RH remain open.

[Full signed compensation on flattened pole-null packets](q-flat-all-place-signed-compensation.md) retains all prime powers, exact autocorrelation endpoints and both pole-density cancellations. It gives the complete finite Green residual comparison and an exact readout in the ORIGINAL frozen source through compact Stieltjes integration by parts. Raw positive bulk terms cannot be treated independently of their exponentially large canceling endpoint densities. The signed residual bound remains open; this is reviewed written mathematics, not a Lean theorem or RH proof.

[Odd reflection-triangle packing](theta-odd-smeared-reflection-triangle-packing.md) gives the exact global cycle row, defect and every unused continuous and prime-power cost. The allocated-row-only sharp target fails on an actual odd equality mode with positive unused same-side energy. [Prime-square rerouting](theta-odd-prime-square-rerouting-obstruction.md) has an exact harmonic-conductance cost that diverges for literal theta weights along powers of 2; periodic odd tests also exclude norm payment by a single-base ladder. Three Lean theorems certify the local cycle and weighted-route algebra only. Global packing, the joint sharp estimate and RH remain open.
