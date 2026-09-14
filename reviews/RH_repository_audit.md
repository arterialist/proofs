**Repository snapshot** [<u>c6118c60438d</u>](https://github.com/arterialist/proofs/tree/c6118c60438defa1282c960a76e0fde9a0a92265) audited 13 September 2026 UTC

| **Bottom line** This is not a meaningful advance toward proving RH in the strong sense of removing a known barrier or proving a new unconditional critical strip estimate. It is, however, a substantial formalization and reformulation project. Its strongest result is a credible Lean checked implication from one explicit eventual arithmetic sign to full RH. The repository does not prove that sign. The written converse appears mathematically plausible but contains several dense analytic steps that still require conventional expert refereeing. The fairest label is an interesting RH equivalent criterion and formal proof infrastructure, not a partial proof of RH. |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# Executive assessment

The requested defensive disclaimers were ignored as evidence. The conclusion below comes from the theorem statements, definitions, dependency graph, proof bodies, build records, computational certificates, and comparison with neighboring RH criteria in the literature.

| **Question**                                                       | **Audit finding**                                                                                                                                                           | **Assessment**                           |
|--------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| Does the Lean theorem conclude actual RH                           | Yes. BuildingBlocks.Target is definitionally mathlib RiemannHypothesis, and the flagship theorem concludes it.                                                              | Strong                                   |
| Is RH proved unconditionally                                       | No. The only premise of the flagship theorem is eventual nonpositivity of an explicit W, but that premise is unproved.                                                      | No                                       |
| Does Lean formalize the hard direction RH implies the W asymptotic | No. The converse and the asymptotic −x^(3/2) log²x divided by 6 are prose mathematics.                                                                                      | Material gap in coverage                 |
| Are there hidden project axioms or placeholders                    | No occurrences of axiom, sorry, admit, or opaque in executable project code after comments were removed.                                                                    | Strong source evidence                   |
| Is the formal build independently reproduced here                  | Not fully. The pinned repository includes a current successful 2812 job build record; this audit environment could not launch Lean 4.24 after installation.                 | Independent reproduction unconfirmed     |
| Does the work narrow the RH bottleneck                             | Not yet. Every direct route ends at an eventual sign, subpower norm, energy, positivity, or continuation estimate that remains open and is RH scale.                        | Low proof progress                       |
| Is there research value short of an RH proof                       | Yes. The multiplicity robust shifted zeta multiplier, explicit arithmetic criterion, formal Landau continuation chain, and many obstruction results are potentially useful. | Moderate formal and methodological value |

# Verdict

If meaningful advance means a new unconditional theorem that moves the best known zero free region, improves a critical exponent, or proves a previously inaccessible estimate whose remaining gap is visibly smaller than RH, the answer is no. Nothing in the repository establishes the decisive sign or norm bound, and the missing estimates are not routine clean up.

If meaningful advance includes producing a new explicit RH equivalent criterion with a machine checked forward implication and a reusable formal analytic apparatus, the answer is qualified yes. That is a real contribution, but it should be evaluated as a formal methods and criterion paper. Its significance depends on independent checking of the written reverse implication and on a literature search establishing that the exact criterion or proof architecture is new.

The repository therefore advances the organization and formal verification of one route to RH more than it advances the mathematical probability that RH has been solved.

# Scope and method

The audit pinned the public main branch at the commit shown on the title page. It covered the entire repository tree and then concentrated mathematical review on the routes that claim direct RH implications or equivalences. The review was deliberately asymmetrical: central analytic steps received line by line attention; auxiliary finite identities and hundreds of supporting lemmas received corpus wide structural, dependency, and placeholder checks plus family level spot checks.

- 305 Markdown files repository wide, including 302 files in building-blocks of which 301 are chapters; 69,080 building-block Markdown lines and about 564,000 lexical words.

- 221 Lean files repository wide: 215 modules in BuildingBlocks, one aggregate module, and five audit files. All 215 core modules are reachable from the aggregate import.

- 29,260 lines of core Lean, with 1,795 nonprivate theorem or lemma declarations and 1,920 when private declarations are included.

- 52 Python certificate or verification scripts. A standard library subset ran successfully; many Arb and symbolic scripts could not run because python flint, SymPy, and related packages were absent. That is an environment limitation, not evidence that the certificates are false.

- The repository has a pinned Lean 4.24.0 toolchain and pinned mathlib commit, but no visible GitHub Actions workflow. The committed build log reports successful completion of all 2,812 jobs at the audited commit.

This is not a substitute for journal refereeing of every one of roughly half a million words. The appendices make the coverage boundary explicit: every report section and every Lean module is inventoried, while correctness confidence is strongest for the central checked implication and lower for long unformalized analytic arguments.

# What the flagship result actually says

The central arithmetic quantity retains all prime powers. Let c(n) be the distinct prime part of the von Mangoldt self convolution, let V be its centered first Riesz sum, and aggregate V over all positive integer multiples with square root weight.

> W(x) = sum over d ≤ x of sqrt(d) V(x divided by d)

The Lean theorem is exactly the following one way implication.

> If W(x) ≤ 0 for every sufficiently large real x then RiemannHypothesis

Its formal Mellin transform on real part s greater than 1 is

> integral W(x) x^(−s−2) dx = zeta(s+1/2) \[G(s)^2 − H(s)\] divided by \[s(s+1)\]

Here G is the centered logarithmic derivative of zeta and H is the same prime correction. The multiplier zeta(s+1/2) is nonzero for real part s greater than 1/2. Consequently an off line zeta zero of any multiplicity leaves a double pole rather than being cancelled. This multiplicity robustness is the most interesting design feature of the criterion.

## The Lean proof chain

| **Stage**                     | **Representative modules**                                   | **What is checked**                                                                                |
|-------------------------------|--------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| Arithmetic definition         | ActualCenteredMellin and ActualCriticalMellin                | Finite cutoff definitions of V and W including endpoints and reality                               |
| Mellin identity               | CriticalMultipleMellin and ActualCriticalMellin              | Absolute convergence and equality on real part s greater than 1                                    |
| Positive tail measure         | ActualCriticalMeasure and ActualCriticalLaplace              | Eventual sign becomes a positive measure and its Laplace moment matches the transform              |
| Landau step                   | LandauSingularity and LaplaceConvergenceAnalytic             | A finite convergence abscissa must be a real singularity; the unbounded below case is also handled |
| Analytic continuation         | ActualCriticalConvergence and RealAxisAnalyticContinuation   | The sign premise yields a holomorphic continuation throughout real part s greater than 1/2         |
| Pole exclusion and reflection | CriticalTransformPoles CriticalTransformContinuationRH Scope | Any off line zero forces order −2; zeta symmetry converts right half zero freedom to full RH       |
| Final theorem                 | ActualCriticalSignCriterion                                  | The only mathematical premise is eventual nonpositivity of the explicit W                          |

## Lean trust audit

- Target integrity. BuildingBlocks.Target is a definition of mathlib RiemannHypothesis. The theorem does not redefine RH into a weaker local statement.

- Premise integrity. The final filter form has one premise, eventual W real part at most zero. Convergence, continuation, and pole exclusion are conclusions of imported lemmas rather than additional final hypotheses.

- Multiplicity integrity. The pole theorem records analytic order m at a zero and proves meromorphic order −2 with nonzero trailing coefficient proportional to m squared.

- Dependency integrity. The aggregate dependency graph reaches every core Lean module. A comment stripped lexical scan found zero project axiom, sorry, admit, and opaque declarations.

- Axiom reporting. Repository audit logs for selected theorem families report only propext, Classical.choice, and Quot.sound. There is not yet a dedicated committed print axioms transcript for the flagship final theorem.

- Build evidence. The committed log is consistent with a complete Lake build, but the absence of CI and the failed independent launcher in this audit keep build reproducibility one notch below fully confirmed.

A clean formal theorem can still be mathematically uninformative if its hypothesis merely restates RH. Here the hypothesis is at least concrete and arithmetical. But the formalization does not show that the sign is easier to prove than RH, and the later arithmetic formula exposes mixed sign terms rather than a monotonicity mechanism.

# The written reverse implication

The chapter on square root aggregation claims a full equivalence. Under RH it decomposes W into an oscillatory part N star and a deterministic same prime part T star, then claims

> N star(x) = O(x^(3/2) log x) and T star(x) = (1/6) x^(3/2) log²x + O(x^(3/2) log x)

This would indeed give eventual negativity. The constants and exponents are internally coherent: the same prime square contribution has the stated one third coefficient before aggregation, and harmonic summation supplies the additional one half logarithm. The shifted zeta factor also has the claimed triple endpoint singularity with negative leading coefficient.

## Why the prose argument is plausible

- The contour shift is to real part 1/2 plus epsilon, so under RH the zeta zeros remain to its left.

- The local logarithmic derivative expansion counts multiplicities and the local zero count gives an integrable weighted sum over ordinates.

- The zeta factor on real part 1 plus epsilon has only logarithmic growth away from height zero, while its pole near height zero produces at worst a logarithm because G is locally bounded there.

- Choosing epsilon equal to one over log x converts the boundary integral estimate into the stated x^(3/2) log x error.

- The prime square main term follows from a quantitative prime number theorem and partial summation; higher prime powers are lower order.

## What still needs refereeing or formalization

**1.** Write the Hadamard local zero decomposition with a precise cited theorem and prove every uniformity claim in epsilon and height. The current paragraph is credible but compressed.

**2.** State a complete Mellin inversion and contour shift lemma, including truncation, horizontal sides, behavior near the pole at one half, and the separate treatment of the H term.

**3.** Give an explicit derivation of the deterministic T asymptotic, not only the PNT slogan, including the uniform fixed compact range after aggregation.

**4.** Formalize at least the boundary integral estimate and the contour shift. Those are the high leverage parts of the reverse implication.

**5.** Obtain an independent analytic number theory referee report. A successful Lean forward implication does not transfer assurance to the prose converse.

I found no immediate fatal contradiction in the written equivalence. That is weaker than finding it publishably complete. The right rating is plausible with material proof compression, not verified.

# Assessment of the other proof families

| **Family**                           | **What is genuinely obtained**                                                                                                                   | **Why it does not yet advance an RH proof**                                                                                                         |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| Coarse primitive energy              | A Lean checked theorem turns a dyadic primitive energy bound into full RH, with local convergence and zero exclusion.                            | The energy bound is unproved and already has RH scale for every epsilon. It is a conditional reduction.                                             |
| Distinct prime sign                  | A detailed prose equivalence using centered convolution and a negative same prime bias.                                                          | Its unconditional sign is open, and its RH direction leans on delicate zero sum estimates and finite zero information.                              |
| Successor feedback and resolvent     | Numerous exact renewal, inverse, pole filter, and final interval criteria; several finite signs and asymptotics.                                 | Every decisive global sign, subpower bound, or boundary positivity statement remains open. Some constructions prove that tempting local signs fail. |
| Scattering source and energy         | Exact transforms, norm identities, compact tests, pole filters, and an RH equivalent total dissipation criterion.                                | The needed full source estimate or finite dissipation is not proved. Existing unconditional estimates stop at weaker growth.                        |
| Theta and Weil operator routes       | Substantial domain analysis, return operators, positivity components, and counterexamples to overly strong interpolation or factorization ideas. | No full Weil positivity or sharp half gap is established. Many of the strongest results are negative diagnostics.                                   |
| Cyclotomic constructions             | Exact finite parts, valuation updates, quadrature decompositions, and explicit selection obstructions.                                           | The uncontrolled derivative history or correlation remains exactly where cancellation is required.                                                  |
| Möbius divisor and hyperbola methods | Useful formal identities, endpoint corrections, finite transfer theorems, and a medium range hyperbola estimate.                                 | The bounds do not reach the full range or the critical exponent needed to imply RH without an RH strength input.                                    |
| Prime probability and covariance     | Exact probability laws, covariance decompositions, counterexamples to negative association, and finite certificates.                             | The mixed covariance remainder is unsigned; local or pairwise negativity does not control the full arithmetic sum.                                  |

The volume of auxiliary work is not meaningless. The negative results are often the most reliable contribution because they rule out attractive shortcuts: finite theta cutoffs can have nonreal zeros, positive radial pieces do not fix signed divisor coefficients, negative pair covariance fails under conditioning, and simple bounded source assumptions do not control Möbius inversion. These results improve research hygiene, but they do not accumulate into a proof unless one route closes its stated global estimate.

# Novelty and literature context

Eventual sign criteria for RH are an established genre. Suzuki proves RH equivalences using eventual negativity of weighted von Mangoldt summatory functions and a Landau Mellin argument. Banks and Sinha develop RH equivalent asymptotics for generalized von Mangoldt functions and convolution powers. Therefore the mere existence of another eventual sign criterion is not by itself a major advance.

The repository may nevertheless contain a novel exact criterion. Its most distinctive device is multiplying the centered distinct prime transform by zeta shifted by one half, so an off line zero of any multiplicity retains a double pole while the deterministic same prime term gains an extra logarithm. I did not find this exact W in the comparison papers reviewed. That supports possible novelty, not priority. Establishing novelty requires a broader expert literature search and a conventional paper that isolates the theorem from the surrounding program.

The use of Platt and Trudgian style rigorous zero verification and explicit PNT estimates is appropriate for finite or quantitative subclaims. Such computations cannot establish an infinite eventual sign by themselves. The repository generally respects this distinction.

# How much confidence to place in each layer

| **Layer**                                                              | **Confidence**   | **Reason**                                                                                        |
|------------------------------------------------------------------------|------------------|---------------------------------------------------------------------------------------------------|
| Exact scope of final Lean theorem                                      | High             | Direct inspection of definitions and final theorem statement                                      |
| Absence of project placeholders and custom axioms                      | High             | Complete comment stripped scan of all 215 core modules                                            |
| Successful build at pinned commit                                      | Moderate to high | Current committed full build transcript but no independent successful rebuild in this environment |
| Correctness of formal implication assuming the Lean kernel and mathlib | High             | Dependency chain is explicit and covers the analytic continuation and pole argument               |
| Correctness of written RH implies asymptotic                           | Moderate         | No obvious fatal error found; several dense analytic steps are not expanded or formalized         |
| Novelty of the exact criterion                                         | Low to moderate  | Nearby methods are known; exact priority has not been established                                 |
| Meaningful progress toward solving RH                                  | Low              | No unconditional decisive estimate is proved and all direct routes stop at RH scale premises      |

# A publication quality next step

**1.** Extract a single paper around the square root multiple criterion. Keep the statement, explicit arithmetic formula, Mellin identity, multiplicity robust pole argument, reverse asymptotic, and one obstruction showing why the sign is hard.

**2.** Add CI that runs lake build and a dedicated print axioms audit for ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos at the pinned toolchain and mathlib revision.

**3.** Formalize the RH to asymptotic direction or, at minimum, the epsilon uniform boundary integral and contour shift. This would align the formal artifact with the claimed equivalence rather than only its conditional half.

**4.** Package the Python certificates with a lock file or environment specification and a one command runner that distinguishes dependency failures from mathematical failures.

**5.** Commission two independent reviews: one analytic number theorist for correctness and novelty, and one Lean reviewer for reproducibility and abstraction boundaries.

**6.** State a credible attack on the eventual sign that uses structure not already equivalent to RH. Without that, the criterion remains a reformulation rather than a route with demonstrated traction.

# Conclusion

Ignoring every author disclaimer does not change the mathematics. The repository proves a conditional theorem whose condition is concrete, nontrivial, and potentially new, but it does not prove the condition. Its strongest formal contribution is real: the final implication to full RH is not vacuous, does not assume simplicity, and appears free of project axioms and placeholders. Its strongest written claim, the converse asymptotic, is plausible enough to merit expert review but not yet secure enough to treat as established from this audit alone.

My balanced classification is therefore: substantial independent formalization project, potentially publishable RH equivalent criterion, useful collection of obstructions and exact identities, and no present meaningful advance toward an actual proof of RH in the narrow research sense.

# Appendix A complete report section coverage

The main Building blocks report contains 82 thematic sections. The table below inventories every section and its linked chapter count. Status labels are lexical scope indicators from the report text, not independent proofs of correctness. They show why the corpus cannot be scored by theorem count alone: written proofs, finite certificates, open premises, and counterexamples frequently coexist.

| **Report section**                                     | **Chapter count** | **Reported scope**                                                  |
|--------------------------------------------------------|-------------------|---------------------------------------------------------------------|
| Full cutoff probability and conditional dependence     | 5                 | written; certified finite/computational; obstruction/counterexample |
| A formal negative dyadic divisor average               | 1                 | Lean-linked; written                                                |
| An actual arithmetic sign sufficient for RH            | 1                 | open premise                                                        |
| Discrete harmonic convolution, regularity and aliasing | 1                 | Lean-linked; written; open premise; obstruction/counterexample      |
| Harmonic prime Laplacian and infinite flow             | 1                 | written                                                             |
| Retained ages, prime histories and source completion   | 8                 | written                                                             |
| Local poles at zeta zeros                              | 0                 | unspecified                                                         |
| Explicit floor correction                              | 0                 | Lean-linked                                                         |
| Möbius hyperbola product estimate                      | 1                 | Lean-linked; written; open premise                                  |
| A regular source with a large Möbius inverse           | 1                 | written; obstruction/counterexample                                 |

**Appendix A — continued**

| **Report section**                     | **Chapter count** | **Reported scope**             |
|----------------------------------------|-------------------|--------------------------------|
| Finite primitive-energy bounds         | 2                 | unspecified                    |
| Exact hyperbola endpoint correction    | 1                 | certified finite/computational |
| A conditional route to full RH         | 1                 | open premise                   |
| Finite Mertens-to-prime transfer       | 1                 | unspecified                    |
| Angular height and two boundary ranges | 1                 | unspecified                    |
| Local two-history forcing              | 1                 | unspecified                    |
| GCD threshold kernels                  | 1                 | written                        |
| Cyclotomic eta finite parts            | 1                 | written                        |
| Theta cutoff completion obstruction    | 1                 | written                        |
| Shifted Fourier correlations           | 1                 | written                        |

**Appendix A — continued**

| **Report section**                                              | **Chapter count** | **Reported scope**                                                                |
|-----------------------------------------------------------------|-------------------|-----------------------------------------------------------------------------------|
| Theta radial-weight positivity                                  | 1                 | written; open premise                                                             |
| Cosh-base universal-factor approximation obstruction            | 1                 | written; certified finite/computational                                           |
| An eventual-sign criterion from distinct-prime convolution      | 1                 | written; certified finite/computational; open premise                             |
| A complete Bernstein obstruction for theta Mellin interpolation | 1                 | written; certified finite/computational; open premise; obstruction/counterexample |
| Square-root aggregation of the sign criterion                   | 1                 | written; certified finite/computational; open premise                             |
| Undamped prime products in Nyman–Beurling approximation         | 1                 | written                                                                           |
| Local Möbius signs and dense history energy                     | 1                 | written                                                                           |
| Cyclotomic activity, quadrature and boundary reductions         | 2                 | written                                                                           |
| Incomplete-box carry covariance                                 | 1                 | written                                                                           |
| Entropy of the cyclic divisor observable                        | 1                 | written; obstruction/counterexample                                               |

**Appendix A — continued**

| **Report section**                                     | **Chapter count** | **Reported scope**                                                       |
|--------------------------------------------------------|-------------------|--------------------------------------------------------------------------|
| The actual theta arcsine mixing law                    | 1                 | written; open premise                                                    |
| A noncomplete Bernstein function with real-zero output | 1                 | unspecified                                                              |
| Prime-division matching obstructions                   | 2                 | unspecified                                                              |
| Integrated divisor histories                           | 1                 | written                                                                  |
| Integrated prime-channel triangle                      | 1                 | written                                                                  |
| Integer histories and finite determinants              | 4                 | obstruction/counterexample                                               |
| Theta and cyclotomic finite tests                      | 3                 | certified finite/computational; obstruction/counterexample               |
| Formal prime filters and signed convolution            | 3                 | unspecified                                                              |
| Restrictions on theta multiplier constructions         | 11                | certified finite/computational; open premise; obstruction/counterexample |
| Signed divisor packets                                 | 1                 | open premise                                                             |

**Appendix A — continued**

| **Report section**                                   | **Chapter count** | **Reported scope**             |
|------------------------------------------------------|-------------------|--------------------------------|
| Arithmetic feature and stability tests               | 2                 | obstruction/counterexample     |
| High-frequency radial cutoff laws                    | 1                 | open premise                   |
| Temporal covariance and coherent division markings   | 2                 | unspecified                    |
| Haar completion and Weil damping                     | 2                 | obstruction/counterexample     |
| Coherent late-prime packets                          | 1                 | unspecified                    |
| Support flow and relative prime determinants         | 2                 | obstruction/counterexample     |
| A certified fixed-support prime complement           | 1                 | certified finite/computational |
| Finite-codimension local Weil extensions             | 1                 | obstruction/counterexample     |
| Prime-support deletion and a central divisor block   | 2                 | unspecified                    |
| Reciprocal approximation and elementary prime energy | 3                 | obstruction/counterexample     |

**Appendix A — continued**

| **Report section**                                        | **Chapter count** | **Reported scope**                                                       |
|-----------------------------------------------------------|-------------------|--------------------------------------------------------------------------|
| Unitary prime phases                                      | 1                 | certified finite/computational                                           |
| Semilocal scattering and signed arithmetic phases         | 1                 | open premise                                                             |
| Actual successor and product-location cutoffs             | 3                 | unspecified                                                              |
| Two-history storage and inverse division                  | 1                 | obstruction/counterexample                                               |
| The actual theta jump operator                            | 21                | certified finite/computational; open premise; obstruction/counterexample |
| Prime-division Feynman–Kac paths                          | 1                 | open premise                                                             |
| Small-prime grouping and centered reconstruction          | 1                 | unspecified                                                              |
| Local cutoff versus complete-period covariance            | 1                 | certified finite/computational; obstruction/counterexample               |
| Variable-length Möbius–divisor blocks                     | 1                 | certified finite/computational                                           |
| Positive-kernel transfer of the signed divisor correction | 1                 | unspecified                                                              |

**Appendix A — continued**

| **Report section**                                          | **Chapter count** | **Reported scope**                                                  |
|-------------------------------------------------------------|-------------------|---------------------------------------------------------------------|
| The actual source in a mixed additive-energy space          | 6                 | written                                                             |
| A positive successor-seed process and its signed response   | 3                 | written                                                             |
| Fixed-observation heat and exact source thresholds          | 2                 | unspecified                                                         |
| All-order profiles and signed arithmetic bands              | 3                 | certified finite/computational; obstruction/counterexample          |
| The centered prime kernel and its domains                   | 7                 | written; certified finite/computational; obstruction/counterexample |
| Formalized complete successor-seed integrals                | 1                 | written                                                             |
| Arithmetic carry arrivals and exact boundary signs          | 2                 | unspecified                                                         |
| Complete centered arrival energy and positive-age evolution | 3                 | written                                                             |
| Coprime interior histories with nonunit divisor layers      | 2                 | written; certified finite/computational                             |
| Common cyclotomic scales and exact clipping defects         | 1                 | written; certified finite/computational                             |

**Appendix A — continued**

| **Report section**                                                | **Chapter count** | **Reported scope**                                                               |
|-------------------------------------------------------------------|-------------------|----------------------------------------------------------------------------------|
| Natural cutoff, relative charge and retained heat memory          | 4                 | written                                                                          |
| All-prime finite activity and the exact probability law           | 1                 | unspecified                                                                      |
| Even-character separation and its conditional arithmetic consumer | 1                 | certified finite/computational; open premise                                     |
| Compensated causal memory and its original derivative             | 7                 | written                                                                          |
| Integer-history cells, curvature and minimum clocks               | 4                 | written; certified finite/computational; obstruction/counterexample              |
| Compact causal defects and the moving signed packet               | 10                | written; certified finite/computational                                          |
| Positive successor primitive and the complete W comparison        | 2                 | certified finite/computational                                                   |
| Positive potentials and original-energy curvature                 | 10                | Lean-linked; written; certified finite/computational; obstruction/counterexample |
| Density smoothing and literal diagonal-time arithmetic readouts   | 7                 | written; certified finite/computational                                          |
| Complete theta returns, excursion metric and clock boundary       | 3                 | written                                                                          |

**Appendix A — continued**

| **Report section**                                         | **Chapter count** | **Reported scope**                                                                |
|------------------------------------------------------------|-------------------|-----------------------------------------------------------------------------------|
| Exterior poles and constrained theta elimination           | 4                 | Lean-linked; written                                                              |
| Frozen-source loading, successor renewal and variable time | 90                | written; certified finite/computational; open premise; obstruction/counterexample |

## Complete chapter index

The 301 chapter filenames below complete the corpus ledger. The Building blocks README is omitted because its 82 sections are listed above.

| **Chapter**                                         | **Chapter**                                      | **Chapter**                                        |
|-----------------------------------------------------|--------------------------------------------------|----------------------------------------------------|
| actual-Abel-factorial-division-positivity.md        | actual-Abel-feedback-Mellin-kernel.md            | actual-W-positive-primitive-analysis.md            |
| actual-charge-arrival-loading.md                    | actual-coherent-division-lattice-remainder.md    | actual-coherent-successor-quadrature-refinement.md |
| actual-core-Weil-arch-row-radical-projection.md     | actual-core-explicit-weil-cross-family.md        | actual-core-screw-increment-readout.md             |
| actual-critical-sign-criterion.md                   | actual-division-lattice-dual-cosine.md           | actual-finite-history-curvature-domains.md         |
| actual-harmonic-doubling.md                         | actual-integer-birth-positive-quadrature.md      | actual-memory-spatial-sign.md                      |
| actual-prefix-refinement.md                         | actual-short-time-psi-correlation.md             | actual-source-causal-charge-law.md                 |
| actual-source-mixed-dirichlet-completion.md         | actual-source-successor-primitive.md             | actual-successor-fifth-primitive-failure.md        |
| actual-successor-frequency-cutoff.md                | actual-successor-resolvent-boundary-criterion.md | actual-successor-resolvent-primitive-order.md      |
| actual-successor-resonance-charge-cocycle.md        | additive-energy-reflection-domain.md             | admitted-prime-square-counterphase.md              |
| age-resolved-prime-history-lift.md                  | all-prime-fixed-source-drift-curvature.md        | angular-height-boundary.md                         |
| arithmetic-subject-index.md                         | bernstein-theta-growth-nonreal-zeros.md          | bounded-factor-matching.md                         |
| causal-history-overflow.md                          | causal-rectangle-frequency-cutoff.md             | centered-infinite-prime-birth-kernel.md            |
| centered-prime-domain-counterexample.md             | centered-prime-mellin-domain.md                  | centered-prime-natural-source-graph.md             |
| charge-compensated-clock-response.md                | charge-compensated-successor-memory.md           | coarse-conditional-rh.md                           |
| coarse-divisor-scattering-storage.md                | coarse-energy-rh-criterion.md                    | coarse-primitive.md                                |
| coherent-core-positive-observation-inner-history.md | coherent-core-theta-domain-and-cutoff.md         | coherent-division-marking.md                       |
| coherent-large-label-matching.md                    | collective-successor-charge-square-response.md   | collective-successor-seed-long-memory.md           |
| combined-prime-density-covariance.md                | compact-compensated-causal-response.md           | compact-positive-scattering-observation.md         |

**Complete chapter index — continued**

| **Chapter**                                  | **Chapter**                                  | **Chapter**                                         |
|----------------------------------------------|----------------------------------------------|-----------------------------------------------------|
| compensated-memory-integral-conservation.md  | compensated-successor-finite-transport.md    | compensated-successor-total-variation-relaxation.md |
| complete-prime-history-entropy.md            | composite-gram-obstruction.md                | conditional-prime-dependence.md                     |
| continuum-scattering-counterphase.md         | cosh-universal-factor-closure.md             | counting-birth-full-generator.md                    |
| coupled-prime-square-birth-balance.md        | critical-charge-local-square-mean.md         | critical-natural-charge-two-sided-unboundedness.md  |
| cutoff-period-gcd-obstruction.md             | cyclotomic-activity-necessity.md             | cyclotomic-activity-quadrature.md                   |
| cyclotomic-adjacent-history-correction.md    | cyclotomic-boundary-formal-interface.md      | cyclotomic-common-scale-norm.md                     |
| cyclotomic-coprime-interior-history.md       | cyclotomic-eta-finite-parts.md               | cyclotomic-fusion-response.md                       |
| cyclotomic-old-inverse-pairs.md              | cyclotomic-restricted-range-refinements.md   | cyclotomic-selected-recovery.md                     |
| cyclotomic-valuation-update.md               | cyclotomic-weighted-orbit-obstructions.md    | density-prime-covariance.md                         |
| diagonal-process-time-W-transform.md         | distinct-prime-sign-criterion.md             | division-renewal-dyadic-average.md                  |
| divisor-birth-decoder.md                     | divisor-observable-entropy.md                | divisor-successor-overlap.md                        |
| dyadic-prime-process-variation.md            | even-character-zero-separation.md            | exact-prime-scattering-fibers.md                    |
| exact-seed-renewal-asymptotic.md             | factorial-ground-screw-increment-consumer.md | factorial-ground-state-original-l2-domain.md        |
| factorial-potential-integer-interpolation.md | factorial-source-clock-loading.md            | finite-arithmetic-energy-tools.md                   |
| finite-division-lattice-port-cancellation.md | finite-prime-mobius-consumer.md              | fixed-cauchy-prime-covariance-seed.md               |
| fixed-observation-prime-heat.md              | fixed-prime-successor-depth.md               | fixed-source-centered-cutoff-law.md                 |
| full-history-same-prime-residual.md          | full-prime-successor-potential-midpoint.md   | full-prime-two-energy-certificate.md                |
| full-prime-two-relative-energy-tail.md       | full-w-off-critical-excursions.md            | gcd-threshold-kernels.md                            |

**Complete chapter index — continued**

| **Chapter**                                     | **Chapter**                                      | **Chapter**                                          |
|-------------------------------------------------|--------------------------------------------------|------------------------------------------------------|
| global-divisor-blocks.md                        | goldbach-additive-source-consumer.md             | goldbach-literal-successor-counting-transport.md     |
| grouped-quadratic-multipliers.md                | growing-time-actual-source-cocycle.md            | haar-prime-energy-completion.md                      |
| haar-profile-all-order-moments.md               | half-neighbor-phase-rigidity.md                  | harmonic-convolution.md                              |
| harmonic-prime-laplacian-flow.md                | harmonic-quadrature-correction.md                | hyperbola-endpoint.md                                |
| hyperbola-product.md                            | incomplete-carry-covariance.md                   | infinite-centered-birth-energy.md                    |
| integer-face-feedback-obstruction.md            | integer-renewal-and-phase-memory.md              | integrated-divisor-history.md                        |
| integrated-prime-channel-triangle.md            | inverse-boundary-division-constraints.md         | jordan-mixed-correction.md                           |
| late-age-prime-boundary-transfer.md             | late-age-vk-history-entropy.md                   | late-prime-packet-energy.md                          |
| literal-compensated-successor-iterates.md       | local-weil-extension-obstruction.md              | long-time-signed-source-rank-one.md                  |
| macroscopic-sector-sign.md                      | mertens-prime-transfer.md                        | mixed-integer-feedback-kernel.md                     |
| natural-arrival-cutoff-completion.md            | natural-cutoff-positive-history-charge.md        | natural-cutoff-successor-primitive.md                |
| noncomplete-bernstein-real-zero-example.md      | one-prime-boundary-product-cutoff.md             | ordered-division-rods.md                             |
| original-l2-evolved-source-gram-work.md         | paired-metric-conservation-and-source-ports.md   | partial-mobius-dense-history.md                      |
| picone-frozen-source-work.md                    | positive-age-preserves-arithmetic-loading.md     | positive-history-observation-original-cutoff-port.md |
| positive-history-successor-charge-relaxation.md | positive-prime-comparison-in-mixed-completion.md | positive-primitive-two-port-drift-curvature.md       |
| positive-successor-seed-jump-process.md         | presieved-prime-pair-completion.md               | prime-allocation-critical-identity.md                |
| prime-clique-cutoff.md                          | prime-density-relative-determinant.md            | prime-discrepancy-scattering-norm.md                 |
| prime-division-feynman-kac.md                   | prime-division-unmatched.md                      | prime-energy-first-moment.md                         |

**Complete chapter index — continued**

| **Chapter**                                    | **Chapter**                                    | **Chapter**                                  |
|------------------------------------------------|------------------------------------------------|----------------------------------------------|
| prime-filter-selberg-identities.md             | prime-hard-wall.md                             | prime-innovation-finite-band-flux.md         |
| prime-power-gram-correction.md                 | prime-product-nyman-test.md                    | prime-revelation-martingale.md               |
| prime-score-negative-covariance.md             | prime-square-proper-power-constant.md          | prime-support-removal-asymptotics.md         |
| prime-transport-in-mixed-completion.md         | prime-two-anticausal-energy.md                 | product-location-frequency-cutoff.md         |
| prolate-projection-certificate.md              | quartic-reciprocal-defect-region.md            | rational-scattering-pole-factor.md           |
| real-window-phase-sobolev-orders.md            | reciprocal-quotient-windows.md                 | regular-source-mobius-obstruction.md         |
| scattering-subject-index.md                    | second-compensated-successor.md                | second-successor-tilted-order.md             |
| semilocal-weighted-scattering.md               | sharp-causal-readout-energy-growth.md          | shifted-fourier-density.md                   |
| short-time-source-and-W-successor-transfer.md  | signed-birth-budget-to-canonical-scattering.md | signed-division-core-boundary.md             |
| signed-divisor-band-correlations.md            | signed-divisor-packets.md                      | signed-divisor-positive-kernel-transfer.md   |
| signed-prime-bath.md                           | signed-scattering-phase-transport.md           | signed-scattering-tail-energy.md             |
| signed-source-successor-stabilization.md       | signed-support-flow.md                         | single-observation-scattering-criterion.md   |
| small-prime-grouping.md                        | sqrt-multiple-sign-criterion.md                | squarefree-cutoff-stability-obstructions.md  |
| successor-averaging-retained-charge-profile.md | successor-clock-arithmetic-calibration.md      | successor-clock-scattering-energy.md         |
| successor-collective-prime-compatibility.md    | successor-counterphase-trace-norm.md           | successor-division-curved-log-comparison.md  |
| successor-division-kernel-moments.md           | successor-division-quadratic-log-readout.md    | successor-division-two-order-cancellation.md |
| successor-feedback-RH-converse.md              | successor-feedback-arithmetic-kernel.md        | successor-feedback-kernel-scaling.md         |
| successor-feedback-linear-inverse-core.md      | successor-feedback-tail-Abel-poles.md          | successor-heat-finite-memory-repair.md       |

**Complete chapter index — continued**

| **Chapter**                                           | **Chapter**                                       | **Chapter**                                        |
|-------------------------------------------------------|---------------------------------------------------|----------------------------------------------------|
| successor-quadrature-cusp-asymptotic.md               | successor-resolvent-all-ages-RH-converse.md       | successor-resolvent-common-halfline-RH-converse.md |
| successor-second-increment-trace-criterion.md         | successor-seed-maximal-translation.md             | temporal-floor-covariance.md                       |
| theta-affine-comparison-conditional-edge-energy.md    | theta-arcsine-law.md                              | theta-bessel-factorization-obstructions.md         |
| theta-coefficient-flow.md                             | theta-complete-ground-covariance-clock.md         | theta-constrained-schur-across-ground-pole.md      |
| theta-continuous-remainder-explicit-gap.md            | theta-cross-arrival-density-calibration.md        | theta-cross-profile-positive-rank-repair.md        |
| theta-cross-profile-weak-score-tests.md               | theta-cutoff-completion.md                        | theta-derivative-kernel-logconcavity.md            |
| theta-equality-space.md                               | theta-exterior-threshold-index-transport.md       | theta-extra-weight-divisible-synthesis.md          |
| theta-full-continuous-comparison-failure.md           | theta-full-cross-arrival-covariance-repair.md     | theta-ground-normalized-cross-arrival.md           |
| theta-ground-score-action-covariance-repair.md        | theta-ground-sign-prime-convolution.md            | theta-groundstate-bounded-weighted-crossing.md     |
| theta-groundstate-covariance-comparison-literature.md | theta-groundstate-explicit-mass-and-gap-bounds.md | theta-groundstate-green-covariance.md              |
| theta-heat-collision.md                               | theta-interior-borel-synthesis.md                 | theta-jump-eigenfunction-regularity.md             |
| theta-jump-subject-index.md                           | theta-jump-tail-renewal.md                        | theta-killed-core-return-comparison.md             |
| theta-killed-return-compact-infinite-rank.md          | theta-killed-return-ground-pole.md                | theta-mellin-bernstein-obstruction.md              |
| theta-mellin-parabola-obstruction.md                  | theta-mellin-quantum-speed-bound.md               | theta-natural-exponent-concavity.md                |
| theta-natural-exponent-third-derivative.md            | theta-odd-zero-mode-synthesis.md                  | theta-operator-factorization-obstructions.md       |
| theta-positive-jump-mixture.md                        | theta-positive-routing-obstruction.md             | theta-prime-component-cross-profile-bound.md       |
| theta-prime-profile-full-form-domain.md               | theta-quotient-indicator-lens.md                  | theta-radial-arithmetic-sign.md                    |
| theta-radial-cutoff-asymptotics.md                    | theta-radial-positivity.md                        | theta-regular-zero-mode-synthesis.md               |

**Complete chapter index — continued**

| **Chapter**                                | **Chapter**                                 | **Chapter**                                |
|--------------------------------------------|---------------------------------------------|--------------------------------------------|
| theta-return-clock-boundary-compactness.md | theta-return-clock-domain-bound.md          | theta-score-matched-affine-gap.md          |
| theta-small-jump-levy-density.md           | theta-stronger-weight-synthesis.md          | theta-true-affine-odd-score-calibration.md |
| theta-two-halfline-affine-covariance.md    | theta-two-halfline-failure-at-radius-two.md | theta-two-halfline-odd-score-failure.md    |
| theta-weil-jump-form.md                    | theta-zero-mode-form-smoothing.md           | total-clock-dissipation-and-signed-work.md |
| transformed-actual-arrival-loading.md      | two-history-bilinear-storage.md             | two-history-forcing.md                     |
| two-history-storage-laplace-transfer.md    | two-prime-compact-filter-generation.md      | two-prime-mixed-scattering.md              |
| two-prime-unilateral-boundary.md           | uniform-full-product-arch-freezing.md       | uniform-partial-prime-cosines.md           |
| uniform-prime-time-successor-packet.md     | uniform-successor-driver-square-bound.md    | unitary-prime-phase-lift.md                |
| variable-time-source-exponent.md           | voronoi-mobius-central-block.md             | weighted-prefix-centered-source-gram.md    |
| weighted-scattering-composition.md         | weil-damping-obstruction.md                 | zero-abscissa-scattering-growth.md         |
| zero-three-halves-moment-analytic-bound.md |                                             |                                            |

# Appendix B complete Lean module coverage

All 215 modules below are transitively imported by the aggregate BuildingBlocks module. Listing them makes the scope of the source and dependency scan reproducible. Detailed mathematical review was concentrated on the critical sign chain; the remaining modules received structural and family level review.

| **Module**                      | **Module**                | **Module**                  |
|---------------------------------|---------------------------|-----------------------------|
| ActualCenteredMellin            | ActualCriticalConvergence | ActualCriticalLaplace       |
| ActualCriticalMeasure           | ActualCriticalMellin      | ActualCriticalSignCriterion |
| AggregateShiftEnergy            | AllPrimeMemoryKernel      | AncestryFlow                |
| ArithmeticTransport             | BirthDivisorCoupling      | Bridge                      |
| CarryWindowVariance             | CausalFilterEnergy        | ChronologicalDivisibility   |
| ChronologicalPowerRatio         | CoarseBlockAnalytic       | CoarseContinuation          |
| CoarseDyadicBase                | CoarseDyadicBound         | CoarseInitialIdentity       |
| CoarsePrimeBounds               | CoarsePrimitive           | CoarsePrimitiveCriterion    |
| CoarseSummation                 | CompensatedMemoryKernel   | Continuation                |
| ContractionRecovery             | CriticalCoordinatePairing | CriticalMultipleMellin      |
| CriticalTransformContinuationRH | CriticalTransformPoles    | CriticalTransformRH         |
| CriticalTransformRealAxis       | CyclotomicBoundaryBridge  | CyclotomicBoundarySums      |
| CyclotomicDivisorPairs          | CyclotomicFareyBasic      | CyclotomicFareyBounds       |
| CyclotomicFareyEndpoints        | CyclotomicFareyGeometry   | CyclotomicFareyMass         |
| CyclotomicFareyPartition        | CyclotomicInteraction     | CyclotomicOldFactor         |
| CyclotomicPrefix                | DistinctPrimeDynamics     | DistinctPrimeRieszMellin    |
| DistinctPrimeTent               | DivisionDyadicFactorial   | DivisionDyadicPrimeAverage  |
| DivisionRod                     | DivisorEntropy            | DivisorForcingBound         |
| DivisorOverlap                  | EtaBaselineMellin         | EtaRieszDirichlet           |
| EtaRieszKernel                  | ExactPrimePowerCRT        | FiniteShiftEnergy           |
| FiniteTransport                 | FixedCoefficient          | FloorCorrection             |
| FloorMellin                     | FourierAliasTail          | FractionalApproximation     |
| HalvingRecovery                 | HarmonicPrimePhase        | HarmonicPrimeWeightBound    |
| HarmonicPrimeWeights            | HyperbolaEndpoint         | HyperbolaMertens            |

**Appendix B — continued**

| **Module**                            | **Module**                   | **Module**                     |
|---------------------------------------|------------------------------|--------------------------------|
| HyperbolaProduct                      | IntegerBirthDiscreteAbel     | IntegerBirthDiscreteCorrection |
| IntegerBirthExponentialHats           | IntegerBirthKernel           | IntegerBirthLaplaceOrder       |
| IntegerBirthSourceBound               | LandauSingularity            | LaplaceConvergenceAbscissa     |
| LaplaceConvergenceAnalytic            | LaplaceMomentDerivatives     | LcmDifferenceProduct           |
| LocalAnalytic                         | LocalLandauExtension         | LogDerivative                  |
| LogDerivativePole                     | LogarithmicOverlap           | MeanCorrection                 |
| MellinCompactCorrection               | MemoryChargeCutoff           | MemoryChargeEnergy             |
| MemoryChargeFubini                    | MertensArithmetic            | MertensCutoff                  |
| MertensPrimeTransfer                  | MixedEnergyAnchoring         | MixedEnergyBilinear            |
| MixedEnergyKernel                     | MixedEnergySuccessorStep     | MobiusVaughan                  |
| Model                                 | OriginalWIdentification      | PolygonalCoarseEnergy          |
| PositiveExponentialMoments            | PositiveTaylorMoments        | PrimeBlockSource               |
| PrimeDensityFilter                    | PrimeEnergy                  | PrimeFirstMoment               |
| PrimeHistoryCoefficientIdentification | PrimeHistoryFullW            | PrimeLogConvolutionTransfer    |
| PrimeLogFilter                        | PrimeLogFilterReverse        | PrimeMemoryChargeDecay         |
| PrimePhaseFactorization               | PrimePrimitiveContraction    | PrimePrimitiveFormula          |
| PrimeSeedActivityBound                | PrimeSeedActivityTail        | PrimeSeedAllPrimeDerivative    |
| PrimeSeedAllPrimeLevy                 | PrimeSeedAllPrimeSquare      | PrimeSeedCausalSupport         |
| PrimeSeedCompoundPoisson              | PrimeSeedCutoffConvergence   | PrimeSeedDelay                 |
| PrimeSeedDerivativeMeasure            | PrimeSeedDerivativeVariation | PrimeSeedFiniteDerivative      |
| PrimeSeedInfiniteMean                 | PrimeSeedJumps               | PrimeSeedLaplaceExponent       |
| PrimeSeedLawComparison                | PrimeSeedLevy                | PrimeSeedMass                  |
| PrimeSeedMemory                       | PrimeSeedPointwise           | PrimeSeedPrimeSums             |
| PrimeSeedSemigroup                    | PrimeSeedSquare              | PrimeSeedSquareConvergence     |

**Appendix B — continued**

| **Module**                        | **Module**                          | **Module**                       |
|-----------------------------------|-------------------------------------|----------------------------------|
| PrimeSeedWeakDerivative           | PrimeSignedAverage                  | PrimeSourceDistinctFilter        |
| PrimeSourceVEvaluation            | QuotientMass                        | RHContinuation                   |
| RealAxisAnalyticContinuation      | ReciprocalIsometry                  | ReflectedConvolutionTransfer     |
| ReflectionEnergy                  | ReflectionFilter                    | RegularSource                    |
| RiemannZetaCenteredLogDeriv       | RieszDirichlet                      | RieszTentMellin                  |
| SamePrimeAggregationKernel        | SamePrimeAggregationMonotone        | SamePrimeBirthConvolution        |
| SamePrimeBlockCalibration         | SamePrimeDirichlet                  | SamePrimeFirstSquare             |
| SamePrimeHistoryProbability       | SamePrimeHistoryResidual            | SamePrimeStrictDelay             |
| Scope                             | SecondWindow                        | SelbergCenteredPairing           |
| SelbergDistinctPrimes             | SelbergIdentity                     | SelbergLogReflection             |
| SelbergReflection                 | SelbergReflectionBound              | SelbergSpectralModes             |
| SelbergTent                       | ShiftedZetaMultiplier               | SmoothDivisorStopping            |
| SmoothPrimeReadout                | SuccessorCharge                     | SuccessorChargeEnergy            |
| SuccessorCompensatedL2            | SuccessorCriticalLift               | SuccessorFeedbackAbelClock       |
| SuccessorFeedbackAbelLaplace      | SuccessorFeedbackBoundary           | SuccessorFeedbackClippedKernel   |
| SuccessorFeedbackClock            | SuccessorFeedbackDecay              | SuccessorFeedbackDifference      |
| SuccessorFeedbackDirichlet        | SuccessorFeedbackFloorAgeDerivative | SuccessorFeedbackFloorBoundary   |
| SuccessorFeedbackFloorHolomorphic | SuccessorFeedbackFloorKernel        | SuccessorFeedbackFloorL1         |
| SuccessorFeedbackFloorPairing     | SuccessorFeedbackGamma              | SuccessorFeedbackIndexCorrection |
| SuccessorFeedbackMellinTail       | SuccessorFeedbackPowerDifference    | SuccessorFeedbackRootTranslation |
| SuccessorFeedbackSource           | SuccessorMemoryKernel               | SummableIntegrals                |
| Target                            | TiltedPrimeCumulative               | TiltedPrimeIntegral              |
| TwoCrossingMoment                 | TwoHistoryForcing                   | WeightedPrimePowers              |
| WindowVariance                    | ZetaPole                            |                                  |

# Sources

- [<u>Pinned repository snapshot</u>](https://github.com/arterialist/proofs/tree/c6118c60438defa1282c960a76e0fde9a0a92265)

- [<u>Building blocks report</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/README.md)

- [<u>Flagship Lean theorem</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/BuildingBlocks/ActualCriticalSignCriterion.lean)

- [<u>Formal criterion explanation</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/actual-critical-sign-criterion.md)

- [<u>Written square root equivalence</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/sqrt-multiple-sign-criterion.md)

- [<u>Critical convergence proof</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/BuildingBlocks/ActualCriticalConvergence.lean)

- [<u>Critical pole and continuation proof</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/BuildingBlocks/CriticalTransformContinuationRH.lean)

- [<u>Pinned build record</u>](https://github.com/arterialist/proofs/blob/c6118c60438defa1282c960a76e0fde9a0a92265/building-blocks/verification/build.txt)

- [<u>Masatoshi Suzuki On variants of Chebyshevs conjecture</u>](https://arxiv.org/html/2411.07436v3)

- [<u>William Banks and Saloni Sinha generalized von Mangoldt functions</u>](https://arxiv.org/abs/2209.11768)

- [<u>Dave Platt and Tim Trudgian rigorous zero verification</u>](https://arxiv.org/abs/2004.09765)

- [<u>Daniel Johnston and Andrew Yang explicit PNT error estimates</u>](https://arxiv.org/abs/2204.01980)

## Audit limitations

This review is independent but not anonymous peer review. It did not reproduce the full Lean build because the installed Lean 4.24 launcher failed in the audit container, and it did not execute certificate scripts whose optional Arb or symbolic dependencies were unavailable. The absence of an obvious flaw in a long prose proof is not a correctness certificate. Novelty conclusions are necessarily provisional because the comparison search was targeted rather than exhaustive.
