**Novelty, Prior Art, and the Missing Step**

*An extensive literature review of arterialist/proofs*

Repository commit c6118c60438defa1282c960a76e0fde9a0a92265

[<u>https://github.com/arterialist/proofs/tree/c6118c60438defa1282c960a76e0fde9a0a92265</u>](https://github.com/arterialist/proofs/tree/c6118c60438defa1282c960a76e0fde9a0a92265)

| **Bottom line:** I cannot honestly certify the requested universal claim that a contribution exists nowhere on the web or that it is definitely significant. The strongest defensible candidate is the repository’s square-root aggregated, same-prime-subtracted W criterion together with its Lean proof of eventual-sign ⇒ RH. Exact-phrase searches found no match, but published adjacent criteria and newly indexed adjacent preprints make a universal negative impossible. The work is a substantial formal/research program and a credible RH-equivalent reduction, not a proof of RH. |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

Prepared from a pinned checkout, a full repository inventory, direct reading of the flagship formal and written proofs, and targeted searches of primary research literature and formalization projects. All novelty labels are calibrated: “classical” means the mechanism is established; “adjacent” means close prior art exists; “not found” means no exact hit was located in the searched corpus; “priority unresolved” means publication-level priority has not been established.

# **Executive assessment**

| **Decision:** In the narrow mathematical sense of advancing a proof of RH, the repository does not yet advance beyond a conditional reduction. In the broader sense of formal infrastructure, exact arithmetic identities, and a potentially new RH-equivalent observable, it is meaningful work. The missing ingredient is an unconditional proof of the eventual sign of the actual W(x), or a logically equivalent RH-strength cancellation estimate. |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

The flagship Lean theorem has a clean shape: if the explicitly defined real arithmetic sum W(x) is eventually nonpositive, then mathlib’s RiemannHypothesis follows. The repository proves the Mellin identity, builds the positive tail measure, invokes a formalized Landau singularity mechanism, continues the transform into Re(s)\>1/2, and excludes off-line zeros by a multiplicity-robust pole argument. The hypothesis is exactly the hard arithmetic sign; it is not proved.

The written square-root criterion goes further conceptually: it claims RH ⇔ eventual negativity of W and, under RH, W(x)=−x^(3/2)log²x/6+O(x^(3/2)log x). This is potentially the most interesting mathematical contribution, but it is not Lean-formalized, its reverse asymptotic has not been independently certified here, and the criterion sits in a mature ecosystem of equivalent sign, convolution, Mellin, theta, Weil, Nyman–Beurling, and operator formulations.

No chapter supplies the missing unconditional cancellation. The probability, renewal, scattering, theta, cyclotomic, matching, Mertens, and energy families repeatedly identify obstructions or conditional consumers. Their breadth is useful for locating failure modes, but breadth is not a substitute for a theorem controlling the actual signed arithmetic aggregate at the critical scale.

## **What the “universal novelty” requirement means**

A web search can establish that a formula was not found in a specified set of indexes and repositories. It cannot prove that the formula has never appeared “anywhere on the web in any shape or form”: unpublished notes, private pages, OCR failures, alternate notation, non-indexed papers, and future or mirrored records defeat that quantifier. “Definitely significant” is likewise a community and peer-review judgment, not a property that can be certified from search results. The report therefore refuses to make that false claim, while identifying the strongest candidate and the exact proof gap.

# **Repository snapshot and audit scope**

| **Item**          | **Observed scope**                                                                                          | **Interpretation**                                                                                                   |
|-------------------|-------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| Pinned source     | 617 tracked tree entries; commit c6118c6; Lean 4.24.0; mathlib f897ebc…                                     | Review is reproducible against a fixed source snapshot.                                                              |
| Written material  | 305 Markdown files; building-blocks contains 302 Markdown files and 301 chapter headings                    | The “301 chapters” are variants of a smaller number of logical families, not 301 independent RH proofs.              |
| Lean              | 221 Lean files; 215 core modules; 29,260 core lines; 1,795 non-private theorem/lemma declarations; 392 defs | Substantial formal engineering and exact theorem coverage.                                                           |
| Dependency graph  | All 215 core modules are reachable from BuildingBlocks.lean                                                 | The aggregate import is broad, but it does not make the open arithmetic premises true.                               |
| Build evidence    | Committed verification/build.txt reports 2,812 jobs and successful BuildingBlocks build                     | Repository-provided build evidence; a fresh independent full rebuild was not reproduced in this environment.         |
| Placeholders      | No code-level sorry/admit/opaque/axiom after comment stripping; “axiom” hits are audit scripts              | No obvious placeholder proof in the audited Lean source.                                                             |
| Certificates      | 52 Python files repo-wide (49 in certificates); many use flint, sympy, numpy, scipy                         | Finite checks are evidence for local claims, not an infinite RH proof; optional dependencies were not all available. |
| Claim directories | unique-contributions/README.md and first-formalizations/README.md both say “No entries yet.”                | The repository itself does not document a formal originality or first-formalization claim.                           |

The full audit also checked the key target path rather than trusting labels. ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos targets mathlib’s RiemannHypothesis definition. Its sole premise is ∀ᶠ x, Re W(x)≤0. The transform-side chain is explicit in ActualCriticalConvergence and CriticalTransformContinuationRH.

# **Literature-review method and novelty rubric**

Searches were run against arXiv, Mathlib documentation, GitHub, publisher/index pages, and broad web indexes. Queries included exact repository identifiers (ActualCriticalSignCriterion, ActualCriticalMellin, sqrt-multiple-sign-criterion, Wcrit), formula fragments (ζ(s+1/2), G(s)^2−H(s), square-root von Mangoldt, same-prime subtraction, distinct-prime convolution), and neighboring traditions (Chebyshev bias, Pólya/Turán, Nyman–Beurling, Weil positivity, spectral operators, formalized zeta, and PNT formalization). The exact identifiers/formulas produced no exact repository hit in the searched corpus. Broad searches did produce close criteria and, in 2026-indexed snippets, adjacent SSRN/Zenodo titles using similar square-root/Chebyshev/Riesz vocabulary; those inaccessible snippets were not treated as mathematical evidence.

| **Label**                         | **Meaning**                                                                                                                             | **What it does not mean**                                                  |
|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| Classical                         | The central construction or theorem is already standard in the literature.                                                              | It does not say the repository’s constants or formal encoding are useless. |
| Adjacent                          | A close theorem, criterion, operator, or proof pattern exists.                                                                          | It does not prove the repository formula is identical.                     |
| Not found                         | No exact hit in the targeted corpus.                                                                                                    | It is not a proof of universal nonexistence or priority.                   |
| Potentially novel                 | A specific combination looks distinct and could merit a paper if independently verified.                                                | It is not yet a publishable novelty claim.                                 |
| Formalization priority unresolved | The Lean implementation appears unusual relative to located projects, but no priority search or independent replay establishes “first.” | It is not a mathematical proof of RH.                                      |
| Open                              | A premise needed for an RH conclusion is still unproved.                                                                                | It is not merely a missing citation or cosmetic gap.                       |

# **Contribution-by-contribution novelty ledger**

The 301 chapter files collapse into the following logically distinct contributions. Each row records the nearest literature, the actual delta, and whether it changes the RH proof status.

| **Contribution family**                                | **Repository claim**                                                                                                                                            | **Nearest prior art**                                                                                                         | **Novelty status**                                                                           | **RH leverage**                                                                                                          |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| 1\. Actual W RH criterion                              | W(x)=Σ\_{d≤x}√d V(x/d), with V a centered Λ\*Λ term after same-prime subtraction; eventual W≤0 ⇒ RH in Lean; written note claims equivalence and RH asymptotic. | Suzuki’s weighted Λ Riesz/sign criterion; Johnston/Pintz integrated Chebyshev criteria; Pólya/Turán/Alkan sign criteria.      | Exact formula not found in targeted search; potentially novel. Sign is open.                 | If eventual sign were proved, RH would follow. Current contribution is a reduction, not proof progress.                  |
| 2\. Same-prime subtraction                             | Subtracts P(p^a)=(a−1)(log p)^2 from the triangular convolution to leave distinct-prime interactions; retains all prime powers.                                 | Banks–Sinha study Λ\*Λ and Λ_k, supported on almost-primes; classical prime-power decompositions.                             | Adjacent concept; exact kernel may be new, but no priority established.                      | Creates a cleaner deterministic prime-square bias; does not bound the remaining off-diagonal sum.                        |
| 3\. Square-root multiplier                             | Aggregates over all integer multiples with √d, giving ζ(s+1/2)(G(s)^2−H(s))/(s(s+1)); shifted multiplier preserves double poles for every zero multiplicity.    | Mellin multipliers and pole-preserving transforms are standard; Suzuki uses related weighted transforms.                      | Potentially novel mechanism in this exact combination; no exact web hit.                     | Makes the one-way pole argument robust to multiple zeros; still consumes the sign premise.                               |
| 4\. Lean sign⇒RH chain                                 | Formalizes actual cutoff sums, Mellin identity, positive tail measure, Landau convergence, analytic continuation, cleared identity, and zero exclusion.         | Mathlib zeta/RH API; Gomes–Kontorovich Lean-RH; Isabelle zeta/PNT formalizations.                                             | Likely a distinctive formalization; priority and independent replay unresolved.              | Meaningful formal-methods contribution; no new unconditional arithmetic theorem.                                         |
| 5\. Multiplicity handling                              | Uses meromorphic order/double-pole obstruction rather than simple zeros or 1/ζ′(ρ); explicit m^2 coefficient.                                                   | Multiplicity-inclusive explicit formulas and zero-grouping estimates are standard; Banks–Sinha group zeros with multiplicity. | Classical idea, careful implementation; formal packaging may be novel.                       | Avoids a common hidden assumption, but cannot locate zeros without the sign/cancellation input.                          |
| 6\. Mellin/Landau positive-measure framework           | Turns −W tail into a positive measure in log coordinates and proves the convergence-abscissa singularity implication in Lean.                                   | Landau/Widder theorem and Suzuki’s Mellin proposition use the same analytic mechanism.                                        | Method is classical; adaptation to W is the possible delta.                                  | Completes the analytic consumer after sign; does not make the measure positive unconditionally.                          |
| 7\. Dyadic primitive-energy criterion                  | An all-ε dyadic primitive energy bound implies RH; Lean formalizes the conditional consumer and finite block identities.                                        | Classical RH-equivalent error/mean-square criteria; Cramér/Brent–Platt–Trudgian mean-square work.                             | Mostly a repackaging with useful formal scope; energy hypothesis open.                       | A second route to RH, not an independent proof.                                                                          |
| 8\. Scattering/resolvent/successor operators           | Many exact transfer, renewal, resolvent, source, clock, and norm identities; several state RH-equivalent subpower or dissipation criteria.                      | Connes trace formula/Weil positivity; Lapidus spectral operators; Suzuki Hilbert-space work.                                  | Terminology and concrete arithmetic models may be new; conceptual family is adjacent.        | No global positivity, gap, or subpower estimate closes the proof.                                                        |
| 9\. Theta/Weil/cyclotomic obstructions                 | Finite-codimension gaps, theta heat tests, Bernstein/Laguerre obstructions, cyclotomic clipping and Fourier examples.                                           | Connes–Consani Weil positivity; theta/heat and Jensen/Pólya literature; cyclotomic/Farey geometry.                            | Local finite results could be publishable if isolated and checked; no universal theorem.     | They rule out proposed shortcuts; the full critical gap remains open.                                                    |
| 10\. Probability/renewal/finite-activity constructions | Exact prime-clock masses, compound-Poisson semigroups, successor seeds, age laws, and source loading.                                                           | Standard renewal, Lévy, semigroup, and probabilistic constructions; arithmetic input is repository-specific.                  | Mostly new packaging/engineering; priority not checked.                                      | Provides a language for the source; positive loading often exposes, rather than solves, the signed cancellation problem. |
| 11\. Möbius, floor, hyperbola, Mertens tools           | Formal floor corrections, endpoint identities, Möbius hyperbola grouping, finite Mertens-to-prime transfer, regular-source counterexample.                      | Classical Stirling, divisor hyperbola, PNT, Mertens, Banach–Steinhaus, Nyman–Beurling machinery.                              | Formal exactness and counterexamples may be useful; mathematical mechanisms are established. | Shows why generic smoothness/size assumptions cannot force the needed arithmetic inverse bound.                          |
| 12\. Matching, graph, and covariance obstructions      | Unmatched vertices, positive majorant growth, covariance sign reversals, finite determinant/Gram examples.                                                      | Sieve/graph matching, Selberg, CRT, covariance and positive-kernel literature.                                                | Potentially novel finite examples; not a global arithmetic estimate.                         | Important negative evidence: termwise positivity, independence, or packet majorants have the wrong sign/scale.           |
| 13\. Numerical and computer-assisted certificates      | Arb/rational/Sturm certificates for finite cutoffs, derivatives, gaps, and example signs.                                                                       | Standard interval arithmetic; Platt–Trudgian finite zero verification and broad numerical RH checks.                          | Engineering contribution; priority and reproducibility depend on scripts/dependencies.       | Finite evidence cannot prove an eventual sign or all-height zero statement.                                              |
| 14\. Additive/Goldbach source consumers                | A parallel source/transport family links additive counts to the same successor/scattering vocabulary.                                                           | Classical Goldbach and Matsumoto–Suzuki explicit-formula work.                                                                | Adjacent and exploratory.                                                                    | Does not identify a new zero-free region or solve the signed W estimate.                                                 |

# **Closest candidate for a genuinely new contribution**

The best candidate is not the sheer volume of chapters. It is the specific observable and its analytic design: start with the actual von Mangoldt function (all prime powers), center against Lebesgue measure and the initial atom, remove the same-prime part of Λ\*Λ, then aggregate by √d. The transform is

∫₁∞ W(x)x^(−s−2) dx = ζ(s+1/2) \[G(s)^2 − H(s)\]/\[s(s+1)\] (Re s\>1),

with H holomorphic on Re(s)\>1/2. At any zeta zero ρ in that half-plane, multiplicity m produces a nonzero double-pole coefficient m²ζ(ρ+1/2)/(ρ(ρ+1)); the shifted multiplier prevents cancellation even when m≥2. Near s=1/2, H has a second-order pole, producing a negative third-order term and the RH-conditional main term −x^(3/2)log²x/6.

Why this is a serious candidate: it is an exact arithmetic formula, it interfaces naturally with a positive-measure Landau theorem, and it removes the simplicity/spacing assumptions that often weaken informal RH criteria. Why it is not certified as the requested “definitely significant” novelty: Suzuki already has a very close Mellin/Landau eventual-sign criterion for a square-root weighted von Mangoldt Riesz sum; Banks–Sinha already treat Λ\*Λ and generalized von Mangoldt convolutions; the repository has no independent publication, priority statement, or external referee report; and exact-phrase absence is not universal nonexistence.

| **Publication-grade test:** To convert this candidate into a defensible contribution, publish the W definition and theorem as a standalone paper, give a complete proof of the RH⇒eventual-sign direction (or clearly mark it conjectural), compare line-by-line with Suzuki and Banks–Sinha, and provide an independently reproducible Lean build plus an explicit axiom/dependency report. |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# **Prior-art map by research tradition**

**Weighted Chebyshev / sign criteria.** Suzuki proves RH equivalences for integrated π−li, θ−x, and a square-root weighted Λ Riesz sum; he explicitly notes that proving the individual eventual sign is challenging and that the best RH zero-sum bound does not settle it. [<u>source</u>](https://arxiv.org/html/2411.07436v3)

**Convolved and generalized von Mangoldt functions.** Banks–Sinha show RH-equivalent uniform estimates for Λ\*⋯\*Λ and generalized Λ_k, with support on integers having few distinct prime divisors. This is the closest prior art for the repository’s convolutional arithmetic. [<u>source</u>](https://arxiv.org/html/2209.11768v2)

**Classical equivalent criteria.** Lagarias (harmonic-number inequalities), Báez–Duarte (zeta-value/Nyman–Beurling conditions), Pólya/Turán/Alkan (eventual sign of weighted Liouville/Möbius sums) demonstrate that an equivalent criterion is not by itself a proof advance. [<u>source</u>](https://arxiv.org/abs/math/0008177)

**Nyman–Beurling and Möbius approximation.** Báez–Duarte and Maier–Rassias study closure and explicit sums; the repository’s undamped prime-product obstructions fit this tradition but do not settle the criterion. [<u>source</u>](https://arxiv.org/abs/math/0505453)

**Formal zeta/RH.** Mathlib documents ζ, analytic continuation, the functional equation, nonvanishing for Re≥1, and the RH proposition. Gomes–Kontorovich formalized an eta-function version; Loeffler–Stoll formalized zeta/L-function infrastructure and record this related work. [<u>source</u>](https://arxiv.org/html/2503.00959v4)

**Formal analytic number theory.** Eberl’s Isabelle chapters and Song–Yao’s Isabelle PNT-with-remainder formalization are the relevant comparison points for proof-assistant scope and attribution. [<u>source</u>](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITP.2019.16)

**Operators, trace, and Weil positivity.** Connes, Connes–Consani, Lapidus, and Suzuki develop trace/Hilbert/spectral formulations in which positivity or invertibility is equivalent to RH or closely related. The repository’s operator vocabulary is adjacent, but its global positivity/gap is open. [<u>source</u>](https://arxiv.org/abs/math/9811068)

**Numerical verification.** Platt–Trudgian verify RH up to height 3×10¹². This is a materially different finite-height claim from an eventual-sign theorem. [<u>source</u>](https://arxiv.org/abs/2004.09765)

**Explicit PNT estimates.** Johnston–Yang provide strong unconditional explicit error bounds derived from zero-free regions and density estimates; these are far weaker than the critical cancellation the repository needs. [<u>source</u>](https://arxiv.org/abs/2204.01980)

## **Formalization comparison**

| **Project**               | **What is formalized**                                                                                           | **Comparison with this repository**                                                                                                               |
|---------------------------|------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Mathlib RiemannZeta       | ζ definition, analytic/functional-equation facts, nonvanishing on Re≥1, formal RiemannHypothesis proposition.    | The repository consumes this target and adds an application-specific arithmetic transform; it does not replace Mathlib’s RH statement.            |
| Gomes–Kontorovich Lean-RH | Standalone and mathlib-supported eta-function formulation: η(s)=0 in the strip implies Re(s)=1/2.                | Different formulation and proof path; repository’s W consumer is more arithmetic but depends on a sign premise.                                   |
| Loeffler–Stoll            | Lean zeta and Dirichlet L-functions, Euler product, functional equation, Dirichlet theorem; formal RH statement. | Closest general Lean analytic-number-theory infrastructure; repository’s novelty, if any, is the W-specific consumer and exact arithmetic source. |
| Eberl / Song–Yao Isabelle | Substantial zeta/L-function and PNT-with-remainder formalization in Isabelle.                                    | Shows formalization of analytic number theory is an active field; “first formalization” requires an explicit cross-assistant comparison.          |
| arterialist/proofs        | 215 core Lean modules, exact finite identities, conditional RH consumers, many written/certificate chapters.     | Breadth and compilation are real; the decisive arithmetic estimates remain assumptions or written open problems.                                  |

# **The missing piece to actually producing the proof**

| **Minimal missing proposition:** There exists A such that for every real x\>A, Re W(x)≤0 (or the strict negative version). This is precisely the sole hypothesis of the formal theorem ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos. |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

The Lean side is therefore not missing a final tactic or a hidden zero case. It is waiting for an unconditional theorem about the actual arithmetic source. The formal chain can be summarized as:

1.  Define the actual cutoff W with all prime powers, endpoint terms, and square-root aggregation.

2.  Prove its Mellin transform on Re(s)\>1: ζ(s+1/2)(G(s)^2−H(s))/(s(s+1)).

3.  Assume eventual nonpositivity, convert −W’s tail into a positive measure in log coordinates, and use Landau to force convergence/holomorphy above 1/2.

4.  Use the shifted ζ multiplier and meromorphic order to show an off-line zero would leave an uncancelled pole, then reflect zeros to obtain RH.

The written RH⇒sign argument identifies the same gap from the other direction. Let N\_\* be the square-root aggregate of the centered convolution and T\_\* the deterministic same-prime term. The desired estimate is

N\_\*(x)=O(x^(3/2) log x), T\_\*(x)=x^(3/2)log²x/6+O(x^(3/2)log x),

which would make W=N\_\*−T\_\* eventually negative. The T\_\* asymptotic is a deterministic prime-square calculation using PNT-scale input. The N\_\* estimate is the hard part: it is a critical-line cancellation statement for a bilinear von Mangoldt expression. If established unconditionally with this strength, its Mellin integral would itself converge and be holomorphic for Re(s)\>1/2, thereby implying RH. It is not an innocuous error term that can be imported from ordinary PNT bounds.

Suzuki’s simpler criterion makes the obstruction concrete: under RH the relevant zero sum is O(√x log²x), but that is not enough to prove the eventual sign. The repository’s W has a larger deterministic negative main term, which is a clever design advantage, but the corresponding bilinear fluctuation is also more complicated. No chapter currently proves the necessary domination.

# **Bidirectional bridge audit: RH ↔ W ↔ Goldbach**

The requested “work backwards and forwards at the same time” test gives a sharp answer. The two directions meet at one arithmetic proposition, but the Goldbach material does not prove that proposition or provide an exact route to it.

| **Direction**                              | **Exact object**                                            | **What is proved**                                                                                                                                    | **What would be needed**                                                                                                            |
|--------------------------------------------|-------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| Backward from RH consumer                  | Lean theorem: eventual Re W(x)≤0 ⇒ RiemannHypothesis.       | The Mellin/Landau/continuation/pole chain is formal and has no extra hidden premise.                                                                  | An unconditional eventual sign of W, or a theorem implying it.                                                                      |
| Backward through W=N\_\*−T\_\*             | N\_\*(x)=Σ\_{d≤x}√d N(x/d); T\_\*(x)=Σ\_{d≤x}√d T(x/d).     | Written PNT calculation gives T\_\*(x)=x^(3/2)log²x/6+O(x^(3/2)log x).                                                                                | The critical cancellation N\_\*(x)=O(x^(3/2)log x) (or any direct domination N\_\*\<T\_\*).                                         |
| Forward from ordinary Goldbach             | r₂(n)=Σ\_{m+k=n}Λ(m)Λ(k)\>0 for even n; G(N)=Σ\_{n≤N}r₂(n). | Only support/positivity is supplied by the conjecture; the repository derives exact additive identities and a positive transport escape bound.        | An averaged, signed error estimate strong enough to control the multiplicative W source.                                            |
| Forward from quantitative average Goldbach | G(N)=N²/2+error, or the circle majorant E_G(N).             | Known theorems transfer such errors to zero-free regions; the repository obtains \|E(N)\|²≤C E_G(N)log N and states E_G=Oε(N^(1+ε)) is RH-equivalent. | A genuinely new signed cancellation inequality connecting additive i+j data to multiplicative ab data; no such identity is present. |

The minimal bridge is therefore not “prove Goldbach.” It is the following explicit theorem (written here with the repository’s normalization):

∃C,x₀\>0 ∀x≥x₀: \|N\_\*(x)\|≤C x^(3/2)log x. (Bridge\*)

Combining (Bridge\*) with the displayed T\_\* asymptotic gives W(x)\<0 eventually, and the formal Lean theorem then gives RH. Conversely, the repository’s written contour argument derives (Bridge\*) under RH. Thus, subject to an independent audit of that written contour proof, (Bridge\*) is an RH-equivalent estimate, not a plausible sublemma that can be imported from routine PNT technology.

## **The Goldbach route, checked in both algebraic domains**

| **Quantity**               | **Algebra / transform**                                                                                               | **Information available**                                                                                      | **Why it stops**                                                                                                                                                               |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Goldbach coefficient       | Additive convolution: r₂(k)=Σ\_{i+j=k}Λ(i)Λ(j); ordinary generating function (ΣΛ(n)zⁿ)².                              | Strong Goldbach asserts a positive coefficient at every even k (and says nothing quantitative about its size). | Coefficient positivity does not bound the phases or magnitude of −ζ′/ζ on Re(s)=1/2+ε.                                                                                         |
| Goldbach average           | S(N)=Σ\_{k≤N}r₂(k), with explicit zero sum plus centered remainder C(N).                                              | Average error N^(2−δ) gives a zero-free strip; N^(3/2+ε)-scale estimates are known to be RH-level.             | This is additive data and retains the integrated PNT zero sum; it is not the product sum in N\_\*.                                                                             |
| Repository source majorant | E_G(N)=∫\|A(r_N,α)\|²\|I_N\|dα; \|E(N)\|²≤C E_G(N)log N.                                                              | A positive, unconditional inequality and conditional RH bound E_G=O(N log³N).                                  | Replacing the signed C(N)=∫A²I_N by E_G discards exactly the cancellation needed for Bridge\*.                                                                                 |
| Critical W source          | Multiplicative convolution: Σ\_{ab≤x}Λ(a)Λ(b), Dirichlet series (−ζ′/ζ)², then √d aggregation multiplies by ζ(s+1/2). | Same-prime subtraction isolates H and preserves all zero multiplicities.                                       | There is no exact map i+j→ab. The successor transport introduces a positive continuous tail and a signed compensation, but only an O(X) additive escape estimate—not Bridge\*. |

This is not merely a matter of notation. Additive convolution is multiplication of ordinary power series, while multiplicative convolution is multiplication of Dirichlet series. Passing from one to the other requires a new transform inequality that preserves the signed zero-sensitive information. None of the 301 written chapters or 215 Lean modules states such an inequality.

The literature confirms the same boundary. Matsumoto records that Goldbach existence is the pointwise assertion r₂(n)\>0, whereas an average asymptotic error of order O(x^(3/2+ε)) is equivalent to RH. Bhowmik–Ruzsa derive only a quasi-RH zero-free strip from an error O(x^(2−δ)); Billington–Cheng–Schettler–Suriajaya similarly show that quantitative average Goldbach errors and zero-free regions determine one another. Matsumoto–Suzuki’s current M-function/screw-function work gives further RH-equivalent Goldbach criteria, but does not turn ordinary existence into the critical cancellation.

A web search also found a 2025 Preprints.org manuscript claiming RH ⇔ bounded symmetric Goldbach offset ⇔ Goldbach. It is not a peer-reviewed source and it does not repair the gap: its step from Goldbach existence (each t\*(E) is finite) to a uniform bound on t\*(E)/(log(E/2))² is an invalid quantifier change, and its assertion that an off-line zero would force the symmetric Goldbach offsets to be unbounded is unsupported. A Goldbach pair may be far from the midpoint, so pointwise existence does not imply a Cramér-scale bound. This is precisely the kind of apparent bridge that fails the backward/forward audit.

| **Bidirectional result:** The search found no closed proof bridge. Backward tracing ends at Bridge\*; forward tracing from Goldbach ends at additive average estimates whose RH-strength versions are already known to be equivalent to RH. A new proof would have to establish a signed additive-to-multiplicative transfer or prove Bridge\* directly. |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# **Beyond the repository: hypotheses that survive the gap test**

The request to reason beyond the indexed literature is useful only if each idea is tested against the exact obstruction above. A route that is merely another equivalent formulation of RH can organize a proof, but it is not the missing lemma. The following screen keeps that distinction explicit.

| **Hypothesis**                           | **What it would assert**                                                                                                                        | **Status after the gap test**                                                                                                                                                                            |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Global total positivity                  | Every relevant Toeplitz/Hankel minor of the completed theta or ξ-kernel is nonnegative (PF∞ / Laguerre–Pólya behavior).                         | A powerful target, but Schoenberg-type theorems make the global statement RH-equivalent or nearly so. The repo has local log-concavity/TP2-style facts and finite obstructions, not all minors.          |
| Hilbert–Pólya factorization              | On the completed Weil space, the shifted operator factors as L−1/2=A\* A (or has a proved nonnegative quadratic form).                          | This would directly prove RH. The repo has theta/Weil identities and finite-core gaps, but no closed full-core factorization; local curvature and simple contraction shortcuts fail.                     |
| Uniform twisted-prime control            | A Gonek–Graham–Lee/Banks–Sinha-strength estimate for Σ\_{n≤x}Λ(n)n^(−it), uniform in x and t at the critical scale.                             | Known to be RH-equivalent. It identifies the missing phase control, but Goldbach positivity does not provide it.                                                                                         |
| Adelic / trace-formula positivity        | A single global trace identity whose local terms are positive and whose archimedean term is exactly the W or Weil quadratic form.               | The local positivity is not the issue; the missing theorem is global positivity after regularization. This is the same Weil-gap problem in different language.                                           |
| Random-matrix or low-lying-zero rigidity | A deterministic theorem excluding even one zero with β\>1/2, perhaps from a universal repulsion law.                                            | Statistical repulsion cannot imply a universal bound. Any fixed off-line zero contributes a term growing like x^(β−1/2), eventually overwhelming the negative x^(3/2)log²x scale.                        |
| Phase-preserving sum–product transfer    | A new inequality couples additive Goldbach phases and multiplicative prime-product phases without taking absolute values, and outputs Bridge\*. | This is the one genuinely different research target found in the audit. No such theorem appears in the repo or in the searched literature; it is a conjecture, not an established contribution or proof. |

The last row can be made concrete. Let a_n=Λ(n)−1 and, with a tent or smooth cutoff K_X, define a two-frequency transform such as

J_X(α,t)=Σ\_{a,b≤X} a_a a_b K_X(a,b) exp(2πiα(a+b)) (ab)^(−it).

Additive Goldbach information controls α-marginals of J_X; the W source is a t/Dirichlet marginal. The conjectural bridge is a phase-preserving norm estimate, uniform in both frequencies, that implies \|N\_\*(x)\|≤C x^(3/2)log x after the exact √d aggregation. This formulation is intentionally stronger than a slogan: it states what a new theorem would have to control, where the two convolution laws meet, and which cancellation cannot be discarded.

| **Novelty boundary:** I found no source displaying this exact joint sum–product estimate, but absence from a web search is not a proof of global novelty. It should be presented as a new conjectural program with no priority claim until a mathematician performs a citation- and database-level search. |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# **Prime-state hypothesis: what is actually unique?**

The repository does contain a beautiful state-space fact, but its logical content is more specific than “the state is unique to primes.” In PrimeSeedDelay.lean, the delay law is

s_L(v)=i_L(v)+exp(−L/2)s_L(v−L), L\>0,

and seed_unique says that causality plus the first interval determines s_L uniquely. The theorem assumes only L\>0; L need not be log p or even the logarithm of an integer. The prime specialization adds the exact activation equivalence j log p≤v iff p^j≤floor(exp v), and the map (p,j)↦p^j is injective when p is prime. This is unique factorization of prime powers, not a primality test for an arbitrary input.

| **State information**                     | **What it certifies**                                                                    | **What it does not certify**                                                                    |
|-------------------------------------------|------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| One delay channel L                       | A unique causal solution of the recurrence for that L.                                   | That L comes from a prime. A composite base such as 6 also gives a valid channel with L=log 6.  |
| A labelled channel (p,j)                  | The event is the prime power p^j and contributes log p to Λ.                             | That the exponent j is 1; 8 is a one-channel event on the 2-channel at j=3.                     |
| The complete valuation vector (v_p(n))\_p | The integer n has a unique factorization; n is prime iff exactly one valuation equals 1. | An efficient way to obtain the vector. Reading the labels is already the factorization problem. |
| The scalar age log n only                 | The product n has a unique logarithmic coordinate once n is known.                       | A unique prime signature. For example log 6=log 2+log 3, so channel labels must be retained.    |

There is an exact Boolean reformulation: for n≥2, n is prime iff Λ(n)=log n. The repository’s prime-power sum computes Λ(n) by first ranging over the prime channels and their powers. Thus the identity can be used as a certificate only if one supplies a short, independently checkable way to establish the relevant channel support. Without that extra certificate, it moves trial division into the state-construction step.

A practical “no trial division” implementation is therefore possible only in the standard certificate sense. A state witness could be a primitive modular orbit or a polynomial congruence, checked with modular exponentiation in time polynomial in log n. Pratt/Lucas certificates and the deterministic AKS test already provide such mechanisms. A new state certificate would be genuinely interesting if it were smaller, faster in a proved model, or if its transition operator also yielded the signed estimates required by Bridge\*; the recurrence identity alone gives none of these.

## **Radical synthesis: prime histories as primitive orbits**

The most beautiful extension is to treat each prime p as a primitive orbit of length log p and p^j as its j-fold traversal. Formally, let a p-channel carry a unitary step U_p and define a regularized transfer family with eigenvalue p^(−s) on that channel. In the half-plane of absolute convergence, its Euler determinant would satisfy

d/ds log det_reg(I−L_s)=Σ\_{p,j≥1} log p·p^(−js)=−ζ′(s)/ζ(s).

This packages the repository’s linear delay histories, all prime powers, and the logarithmic derivative into one dynamical object. The √d aggregation in W then looks like a half-density twist: it moves the determinant to the critical boundary Re s=1/2. The obstruction is exact and unforgiving. The diagonal Euler operator is trace class only well to the right of the critical line; a proof needs a renormalized completion, the archimedean gamma/pole terms, and a symmetry making the boundary family self-adjoint or unitary.

| **Radical proof target:** Construct a Hilbert space and a regularized transfer family L_s for which the completed determinant is ξ(s) up to a nonvanishing factor, L\_(1/2+it) has the required self-adjoint/unitary realization, and W is a positive spectral trace whose remainder obeys Bridge\*. This would turn prime-state uniqueness into a Hilbert–Pólya/Weil proof. No such global construction is present in the repository or established in the literature surveyed here. |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

This route is not a disguised primality algorithm. A boolean prime oracle would only let one enumerate the primitive orbit labels faster. The RH content lies in the global spectral statement: a uniform bound such as Σ\_{n≤X}Λ(n)n^(−it)=X^(1−it)/(1−it)+O(X^(1/2)log^A(XT)) or the equivalent Bridge\* estimate. That is phase cancellation over all states, not recognition of one state.

## **Why unlikely hypotheses still cannot be promoted to a proof**

A “crazy” hypothesis is valuable here only when it yields a checkable deterministic inequality. For example, suppose an off-line zero has real part β\>1/2. The corresponding pole term in the inverse Mellin expansion has size x^(β+1) up to a nonzero coefficient, while the engineered negative term is x^(3/2)log²x. Their ratio is x^(β−1/2)/log²x→∞. Thus even an extraordinarily rare zero, or one with a tiny coefficient, eventually defeats the sign. Probability can prioritize experiments; it cannot replace the uniform exclusion of every such zero.

The same quantifier issue appears in additive conjectures. “For every sufficiently large even N there exists a Goldbach pair” quantifies over N but not over the location, weight, or phase of the pair. Bridge\* is a uniform bound on a signed bilinear sum over all prime powers. Without a theorem that preserves that signed information, the additive statement is too weak regardless of how plausible it is.

## **A proof-development decision tree**

| **If the next experiment proves…**                         | **Then the logical consequence is…**                                                                                     |
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| A global PF∞/Laguerre–Pólya theorem for the actual kernel  | RH follows, but the theorem should be recognized as an RH-equivalent positivity proof, not as a consequence of Goldbach. |
| A closed full-core Weil factorization or spectral gap      | RH follows through the repo’s theta/Weil consumer, subject to domain and trace-class details.                            |
| The joint J_X estimate with the stated critical uniformity | Bridge\* follows, W is eventually negative, and the existing Lean sign consumer completes RH.                            |
| Only an additive average error O(X^(2−δ)) for fixed δ      | Only a fixed zero-free strip/quasi-RH conclusion; the critical line is not reached.                                      |
| Only numerical sign checks or GUE-level evidence           | A finite or probabilistic consistency check; no eventual theorem and no RH proof.                                        |

## **What a successful new proof would have to contain**

| **Candidate completion**        | **Required new theorem**                                                                                                                   | **Current status**                                                                                         |
|---------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Direct W domination             | Unconditional \|N\_\*\|≤C x^(3/2)log x, with all prime powers and sharp real cutoffs.                                                      | Not in repo; equivalent to RH once combined with T\_\*.                                                    |
| Positive-definite decomposition | A global identity T\_\*−N\_\*=P(x)+R(x), with P≥0 and \|R\|\<P eventually, for the complete signed source.                                 | Finite covariance/Gram tests in the repo exhibit sign reversals; no global remainder bound.                |
| Goldbach-to-W transfer          | A theorem converting a quantitative bound for additive C(N) or E_G(N) into Bridge\* without replacing signed data by an absolute majorant. | No exact transform or inequality found; existing average-Goldbach converses are zero-free/RH equivalences. |
| Weil/operator closure           | A full-core positivity or spectral gap whose scalar readout is exactly W and whose lower bound pays the same-prime deficit.                | Only finite-core/conditional gaps and obstruction examples are proved.                                     |

Any one of these would be a major theorem. It cannot be honestly described as a routine finalization step: because sign⇒RH is already formalized, a proof of any candidate with the stated strength would itself be a proof of RH.

## **Why the other routes do not supply the missing lemma**

| **Route in repository**        | **What it proves**                                                                          | **Why it does not close RH**                                                                         |
|--------------------------------|---------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| Dyadic primitive energy        | All-ε bound S_X≲X^(4+ε) ⇒ RH, formalized.                                                   | The all-scale bound is itself unproved and RH-strength.                                              |
| Scattering / clock dissipation | Several norm exponents or finite-dissipation statements are equivalent to zero-abscissa/RH. | The exponent or finite dissipation is not bounded unconditionally.                                   |
| Theta / Weil gap               | Finite-core gaps, compactness, exact affine identities, and obstructions.                   | The sharp full-core lower bound that would pay the affine deficit is open.                           |
| Probability / renewal loading  | Positive source mass, finite activity, semigroup and loading asymptotics.                   | Positive loading exposes a signed cross-work cancellation that remains uncontrolled.                 |
| Möbius / floor / matching      | Finite transfers, explicit obstructions, and local block savings.                           | Generic regularity/size hypotheses do not control the particular Möbius or prime source at RH scale. |
| Numerical certificates         | Finite exact or interval-verified examples.                                                 | Finite ranges cannot establish an eventual statement or exclude all off-line zeros.                  |

# **A realistic advancement program**

The repository is broad enough to support a focused program, but the next advance should be a single theorem with a sharply stated analytic target, not another layer of vocabulary. A credible sequence is:

| **Stage**                            | **Concrete deliverable**                                                                                                                                                                                                                                  |
|--------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Freeze the core observable           | Publish W, V, N, T, G, and H in a short standalone note. Prove all endpoint and prime-power identities independently of the larger operator program.                                                                                                      |
| Finish the written equivalence audit | Have an analytic-number theorist check the RH⇒N\_\*=O(x^(3/2)log x) contour shift, the uniform ε estimate, horizontal integrals, local zero grouping, and deterministic T asymptotic. Formalize the reverse direction only after this audit.              |
| Compare with known criteria          | Give an explicit transformation from W to Suzuki’s weighted Λ criterion and Banks–Sinha’s convolution language, or prove that no such reduction preserves the sign. This is where novelty can become a theorem rather than a naming claim.                |
| Attack one arithmetic estimate       | Choose either a direct bilinear form estimate for N\_\*, a smoothed-to-sharp sign transfer, or a new positive-definite decomposition of the complete signed aggregate. Any result must retain all prime powers and state the exact uniformity in x and ε. |
| Use the obstructions as tests        | Before proposing a positivity proof, run it against the repository’s explicit counterexamples (e.g., n=36,x=72 bracket sign, cutoff covariance reversals, and finite theta/matching obstructions). This prevents a false termwise-positivity shortcut.    |
| Create a reproducibility release     | Add CI, a pinned toolchain bootstrap, certificate dependency versions, generated axiom logs for the flagship theorem, and a small independent checker. The current committed logs are useful but not a substitute for fresh external replay.              |

| **Strategic conclusion:** There is a promising approach to organizing a proof, but no discovered “missing trick” in the current breadth. The only missing step that would convert the work to RH is an unconditional critical-scale cancellation/sign theorem for the actual W (or an equivalent sharp energy, norm, or Weil-gap theorem). Because the repository already proves sign⇒RH, any successful version of that lemma is itself an RH proof and should be evaluated as such. |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# **Reliability, caveats, and what was not claimed**

- The review does not certify that every written chapter is mathematically correct. It reads the flagship proofs and representative obstruction/consumer chapters and records the repository’s own stated scopes.

- The repository’s build.txt and JSON audits report successful Lean builds and allowed transitive axioms (propext, Classical.choice, Quot.sound). The review did not reproduce a clean full rebuild from an empty dependency cache; treat the logs as source-provided evidence.

- Computer-assisted finite certificates are not silently promoted to asymptotic theorems. Missing optional Python packages are an environment limitation, not evidence that a certificate is false.

- No claim is made that the repository’s ideas are wrong. The verdict is about proof status and novelty confidence, not the author’s competence or intent.

- The web review is necessarily time-stamped. New or unindexed manuscripts can change priority; a formal novelty claim requires an author-led database search, citation review, and expert referee comparison.

# **Appendix A — complete chapter-heading inventory**

The repository’s 301 Markdown chapters are represented by 82 top-level headings in building-blocks/README.md. The table below lists every heading and assigns the logical status used in this review. This is a contribution inventory, not a claim that each heading is an independent theorem.

| **README heading**                                                | **Logical family**                             | **Balanced assessment**                                                                                                          |
|-------------------------------------------------------------------|------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| Full cutoff probability and conditional dependence                | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| A formal negative dyadic divisor average                          | Formal or classical arithmetic infrastructure  | Valuable infrastructure or a finite/conditional theorem; novelty is mainly formalization or packaging, not a new RH consequence. |
| An actual arithmetic sign sufficient for RH                       | Core RH criterion / conditional consumer       | Closest to an RH proof, but the decisive eventual sign or equivalent cancellation is open.                                       |
| Discrete harmonic convolution, regularity and aliasing            | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Harmonic prime Laplacian and infinite flow                        | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Retained ages, prime histories and source completion              | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Local poles at zeta zeros                                         | Formal or classical arithmetic infrastructure  | Valuable infrastructure or a finite/conditional theorem; novelty is mainly formalization or packaging, not a new RH consequence. |
| Explicit floor correction                                         | Formal or classical arithmetic infrastructure  | Valuable infrastructure or a finite/conditional theorem; novelty is mainly formalization or packaging, not a new RH consequence. |
| Möbius hyperbola product estimate                                 | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| A regular source with a large Möbius inverse                      | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Finite primitive-energy bounds                                    | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Exact hyperbola endpoint correction                               | Formal or classical arithmetic infrastructure  | Valuable infrastructure or a finite/conditional theorem; novelty is mainly formalization or packaging, not a new RH consequence. |
| A conditional route to full RH                                    | Core RH criterion / conditional consumer       | Closest to an RH proof, but the decisive eventual sign or equivalent cancellation is open.                                       |
| Finite Mertens-to-prime transfer                                  | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Angular height and two boundary ranges                            | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Local two-history forcing                                         | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| GCD threshold kernels                                             | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Cyclotomic eta finite parts                                       | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Theta cutoff completion obstruction                               | Obstruction or negative result                 | Useful boundary-setting or counterexample; it removes a shortcut but does not bound the actual signed source.                    |
| Shifted Fourier correlations                                      | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Theta radial-weight positivity                                    | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Cosh-base universal-factor approximation obstruction              | Obstruction or negative result                 | Useful boundary-setting or counterexample; it removes a shortcut but does not bound the actual signed source.                    |
| An eventual-sign criterion from distinct-prime convolution        | Core RH criterion / conditional consumer       | Closest to an RH proof, but the decisive eventual sign or equivalent cancellation is open.                                       |
| A complete Bernstein obstruction for theta Mellin interpolation   | Obstruction or negative result                 | Useful boundary-setting or counterexample; it removes a shortcut but does not bound the actual signed source.                    |
| Square-root aggregation of the sign criterion                     | Core RH criterion / conditional consumer       | Closest to an RH proof, but the decisive eventual sign or equivalent cancellation is open.                                       |
| Undamped prime products in Nyman–Beurling approximation           | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Local Möbius signs and dense history energy                       | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Cyclotomic activity, quadrature and boundary reductions           | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Incomplete-box carry covariance                                   | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Entropy of the cyclic divisor observable                          | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| The actual theta arcsine mixing law                               | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| A noncomplete Bernstein function with real-zero output            | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Prime-division matching obstructions                              | Obstruction or negative result                 | Useful boundary-setting or counterexample; it removes a shortcut but does not bound the actual signed source.                    |
| Integrated divisor histories                                      | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Integrated prime-channel triangle                                 | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Integer histories and finite determinants                         | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Theta and cyclotomic finite tests                                 | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Formal prime filters and signed convolution                       | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Restrictions on theta multiplier constructions                    | Obstruction or negative result                 | Useful boundary-setting or counterexample; it removes a shortcut but does not bound the actual signed source.                    |
| Signed divisor packets                                            | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Arithmetic feature and stability tests                            | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| High-frequency radial cutoff laws                                 | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Temporal covariance and coherent division markings                | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Haar completion and Weil damping                                  | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Coherent late-prime packets                                       | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Support flow and relative prime determinants                      | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| A certified fixed-support prime complement                        | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Finite-codimension local Weil extensions                          | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Prime-support deletion and a central divisor block                | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Reciprocal approximation and elementary prime energy              | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Unitary prime phases                                              | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Semilocal scattering and signed arithmetic phases                 | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Actual successor and product-location cutoffs                     | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Two-history storage and inverse division                          | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| The actual theta jump operator                                    | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Prime-division Feynman–Kac paths                                  | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Small-prime grouping and centered reconstruction                  | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Local cutoff versus complete-period covariance                    | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Variable-length Möbius–divisor blocks                             | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Positive-kernel transfer of the signed divisor correction         | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| The actual source in a mixed additive-energy space                | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| A positive successor-seed process and its signed response         | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Fixed-observation heat and exact source thresholds                | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| All-order profiles and signed arithmetic bands                    | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| The centered prime kernel and its domains                         | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Formalized complete successor-seed integrals                      | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Arithmetic carry arrivals and exact boundary signs                | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Complete centered arrival energy and positive-age evolution       | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Coprime interior histories with nonunit divisor layers            | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Common cyclotomic scales and exact clipping defects               | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Natural cutoff, relative charge and retained heat memory          | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| All-prime finite activity and the exact probability law           | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Even-character separation and its conditional arithmetic consumer | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Compensated causal memory and its original derivative             | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Integer-history cells, curvature and minimum clocks               | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Compact causal defects and the moving signed packet               | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Positive successor primitive and the complete W comparison        | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Positive potentials and original-energy curvature                 | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |
| Density smoothing and literal diagonal-time arithmetic readouts   | Auxiliary arithmetic/analytic chapter          | A recorded identity, estimate, or experiment; no standalone advance to zero location without an additional RH-scale bound.       |
| Complete theta returns, excursion metric and clock boundary       | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Exterior poles and constrained theta elimination                  | Theta / Weil / cyclotomic / harmonic family    | Exact analytic or finite result, generally adjacent to classical theta, Weil, Jensen, or Fourier machinery; no global RH gap.    |
| Frozen-source loading, successor renewal and variable time        | Arithmetic dynamics / source / operator family | Rich exact identities and conditional norm statements; the required global signed estimate remains outside scope.                |

# **Appendix B — flagship dependency map**

| **Layer**              | **Repository declarations / files**                                                                                               | **Status**                                                                     |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| Arithmetic definition  | ActualCriticalMellin.V, W; W_eq_Icc; W_real; W_zero; OriginalWIdentification                                                      | Formal, actual real cutoff and all positive integer multiples retained.        |
| Mellin identity        | ActualCriticalMellin.hasMellin_W; integral_W_Ioi_one; CriticalTransformPoles.transform                                            | Formal on Re(s)\>1; no continuation of the integral assumed.                   |
| Positive tail measure  | ActualCriticalMeasure.tailMeasure; measurable_W; tailDensity; laplace_mass_eq_norm                                                | Formal under the explicit eventual sign; clipping is not allowed without sign. |
| Landau convergence     | LandauSingularity; LaplaceConvergenceAbscissa; ActualCriticalConvergence.finite_abscissa_le_half                                  | Formal analytic consumer of eventual sign.                                     |
| Continuation and poles | CriticalTransformContinuationRH.cleared; continuation_eventuallyEq_filledTransform; RiemannHypothesis_of_holomorphic_continuation | Formal; order argument handles arbitrary multiplicity.                         |
| Final theorem          | ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos                                                                | Formal one-way theorem; sole premise is eventual Re W≤0.                       |
| Written converse       | sqrt-multiple-sign-criterion.md; distinct-prime-sign-criterion.md                                                                 | Not Lean-formalized; sign remains unproved; RH⇒sign proof needs expert audit.  |

# **Appendix C — selected primary sources and direct links**

These are the principal sources used to calibrate novelty and proof status. The list is selective rather than a complete bibliography of all 301 chapters.

**Suzuki, “On variants of Chebyshev’s conjecture” —** [<u>https://arxiv.org/html/2411.07436v3</u>](https://arxiv.org/html/2411.07436v3) Eventual-sign and Mellin/Landau criteria; explicitly discusses the difficulty of proving individual signs and the insufficiency of the best RH zero-sum bound.

**Banks & Sinha, “The Riemann Hypothesis via the generalized von Mangoldt function” —** [<u>https://arxiv.org/html/2209.11768v2</u>](https://arxiv.org/html/2209.11768v2) RH-equivalent uniform estimates for generalized and convolved von Mangoldt functions; multiplicity-inclusive zero grouping.

**Loeffler & Stoll, “Formalizing zeta and L-functions in Lean” —** [<u>https://arxiv.org/html/2503.00959v4</u>](https://arxiv.org/html/2503.00959v4) Current Lean/Mathlib zeta infrastructure and explicit comparison to Gomes–Kontorovich and Isabelle work.

**Mathlib RiemannZeta documentation —** [<u>https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LSeries/RiemannZeta.html</u>](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LSeries/RiemannZeta.html) Formal ζ definitions, analytic/functional-equation facts, and the RiemannHypothesis proposition consumed by the repository.

**Gomes & Kontorovich, Lean-RH repository —** [<u>https://github.com/AlexKontorovich/Lean-RH</u>](https://github.com/AlexKontorovich/Lean-RH) Eta-function formalization of an RH-equivalent statement.

**Eberl, “Nine Chapters of Analytic Number Theory in Isabelle/HOL” —** [<u>https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITP.2019.16</u>](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITP.2019.16) Substantial proof-assistant formalization of zeta and analytic number theory.

**Song & Yao, Isabelle PNT with remainder —** [<u>https://isa-afp.org/entries/Prime_Number_Theorem.html</u>](https://isa-afp.org/entries/Prime_Number_Theorem.html) Formalized PNT with explicit remainder; relevant formalization comparator.

**Platt & Trudgian, “The Riemann hypothesis is true up to 3·10¹²” —** [<u>https://arxiv.org/abs/2004.09765</u>](https://arxiv.org/abs/2004.09765) Finite-height verification, illustrating the distinction between numerical evidence and an eventual-sign proof.

**Johnston & Yang, “Some explicit estimates for the error term in the prime number theorem” —** [<u>https://arxiv.org/abs/2204.01980</u>](https://arxiv.org/abs/2204.01980) Unconditional explicit PNT errors from zero-free regions/density estimates; not critical-scale RH cancellation.

**Lagarias, “An Elementary Problem Equivalent to the Riemann Hypothesis” —** [<u>https://arxiv.org/abs/math/0008177</u>](https://arxiv.org/abs/math/0008177) Harmonic-number inequality criterion; evidence that equivalent criteria are abundant.

**Báez–Duarte, “A new necessary and sufficient condition for the Riemann hypothesis” —** [<u>https://arxiv.org/abs/math/0307215</u>](https://arxiv.org/abs/math/0307215) Zeta-value criterion.

**Báez–Duarte, “A general strong Nyman–Beurling Criterion” —** [<u>https://arxiv.org/abs/math/0505453</u>](https://arxiv.org/abs/math/0505453) Generalized Nyman–Beurling closure criterion.

**Maier & Rassias, “Explicit estimates of sums related to the Nyman–Beurling criterion” —** [<u>https://arxiv.org/abs/1806.05070</u>](https://arxiv.org/abs/1806.05070) Explicit Möbius/Nyman–Beurling sums.

**Connes, “Trace formula in noncommutative geometry and the zeros of the Riemann zeta function” —** [<u>https://arxiv.org/abs/math/9811068</u>](https://arxiv.org/abs/math/9811068) Trace/spectral approach and RH interpretation.

**Connes & Consani, “Weil positivity and Trace formula, the archimedean place” —** [<u>https://arxiv.org/abs/2006.13771</u>](https://arxiv.org/abs/2006.13771) Weil positivity and semilocal trace-formula framework.

**Gröchenig, “Schoenberg’s characterization of totally positive functions and the Riemann hypothesis” —** [<u>https://arxiv.org/html/2007.12889v1</u>](https://arxiv.org/html/2007.12889v1) Total-positivity/Laguerre–Pólya criteria; useful prior art for distinguishing a new kernel theorem from an RH-equivalent positivity reformulation.

**Kozlov, Peller & Sodin, “Entire functions of exponential type and the Riemann hypothesis” —** [<u>https://aif.centre-mersenne.org/articles/10.5802/aif.3600/</u>](https://aif.centre-mersenne.org/articles/10.5802/aif.3600/) Recent journal treatment of de Branges/van Dantzig/Lee–Yang-type positivity and RH-adjacent criteria.

**Lapidus, “Towards Quantized Number Theory…” —** [<u>https://arxiv.org/abs/1501.05362</u>](https://arxiv.org/abs/1501.05362) Spectral-operator invertibility criteria for RH.

**Suzuki, “On the Hilbert space derived from the Weil distribution” —** [<u>https://arxiv.org/abs/2301.00421</u>](https://arxiv.org/abs/2301.00421) Hilbert-space/Weil-distribution comparison.

**Matsumoto & Suzuki, “M-functions and screw functions: applications to Goldbach’s problem and zeros of the Riemann zeta-function” —** [<u>https://arxiv.org/html/2409.00888v2</u>](https://arxiv.org/html/2409.00888v2) Current Goldbach M-function, explicit-formula, value-distribution, and screw-function criteria; its version is dated August 24, 2026.

**Billington, Cheng, Schettler & Suriajaya, “The Average Number of Goldbach Representations and Zero-Free Regions…” —** [<u>https://arxiv.org/html/2306.09102v2</u>](https://arxiv.org/html/2306.09102v2) Unconditional Fujii formula and converse links between quantitative Goldbach averages, PNT remainders, and zero-free regions.

**Bhowmik & Ruzsa, “Average Goldbach and the Quasi-Riemann Hypothesis” —** [<u>https://pro.univ-lille.fr/fileadmin/user_upload/pages_pros/gautami_bhowmik/Publications/quasi.pdf</u>](https://pro.univ-lille.fr/fileadmin/user_upload/pages_pros/gautami_bhowmik/Publications/quasi.pdf) Power-saving average Goldbach error implies a zero-free strip; the paper explains the generating-function square-root step.

**Matsumoto, “An M-function associated with Goldbach’s problem” —** [<u>https://arxiv.org/html/2101.07446v2</u>](https://arxiv.org/html/2101.07446v2) Defines the weighted Goldbach generating function and records the RH-equivalent O(x^(3/2+ε)) average error.

**Bahbouhi, “A Formal Proof for the Goldbach’s Strong Conjecture by the Unified Prime Equation and the Z Constant” —** [<u>https://www.preprints.org/manuscript/202510.0662</u>](https://www.preprints.org/manuscript/202510.0662) A non-peer-reviewed 2025 preprint making an RH–Goldbach equivalence claim; inspected as a cautionary counterexample, not used as evidence.

**Alkan, “Variations on criteria of Pólya and Turán…” —** [<u>https://www.sciencedirect.com/science/article/pii/S0022314X21000433</u>](https://www.sciencedirect.com/science/article/pii/S0022314X21000433) Eventual sign criteria for weighted Liouville/Möbius sums.

**Mossinghoff & Trudgian, “Between the problems of Pólya and Turán” —** [<u>https://www.cambridge.org/core/journals/proceedings-of-the-american-mathematical-society/article/between-the-problems-of-polya-and-turan/4B4C6A0F5A6CE2E1A2E4F0F1D6D2E4E5</u>](https://www.cambridge.org/core/journals/proceedings-of-the-american-mathematical-society/article/between-the-problems-of-polya-and-turan/4B4C6A0F5A6CE2E1A2E4F0F1D6D2E4E5) Sign-change and multiplicity context for Pólya/Turán families; publisher page may require access.

# **Final verdict**

| **Most defensible conclusion:** This repository meaningfully advances formalization and may contain a publishable new arithmetic RH-equivalent criterion, but it does not yet advance the proof of RH in the sense of establishing a new unconditional zero-free region. The exact missing piece is the eventual sign/cancellation estimate for W. No honest literature review can certify the stronger universal novelty condition requested; the correct next step is independent mathematical verification and publication-level comparison of the W criterion. |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
