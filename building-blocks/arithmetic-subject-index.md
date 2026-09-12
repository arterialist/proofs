# Arithmetic probability, succession and phase

These notes study exact integer laws and operators that occur in the arithmetic sign problem. The links below separate proved identities, conditional implications and refuted strengthening attempts. Written proofs are not Lean theorems unless a note names the corresponding source and declarations.

## The triangular cutoff law

For $x>1$, the full law is

$$
P_x(n)=\frac{x-n}{\sqrt n\,Z_x}\mathbf1_{n<x},
\qquad Z_x=\sum_{n<x}\frac{x-n}{\sqrt n}.
$$

The [allocation identity](prime-allocation-critical-identity.md) first derives this law from two negative-binomial Euler histories. It retains their literal same-prime allocation diagonal, the endpoint atom and both continuous density terms in the exact formula for $W$.

The [prime-score covariance theorem](prime-score-negative-covariance.md) proves strict negative covariance for distinct active primes. Its proof proceeds through a finite-grid martingale, a strict power-sum ratio, monotonicity of every integer dilation ratio, and an exact prime-power size-bias identity. Gao's majorization theorem supplies a second route to the nonstrict power-sum comparison.

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
