# Building blocks

The [arithmetic subject index](arithmetic-subject-index.md) links the cutoff probability, successor/division and phase results to their analytic consumers, with proved and refuted scopes kept explicit.

Results used in the study of prime-counting errors, with their formal verification scope stated individually. No originality or first-formalization claim is made. Throughout, $\gamma$ is the Euler–Mascheroni constant.

## Full cutoff probability and conditional dependence

The [two-history allocation identity](prime-allocation-critical-identity.md) derives the complete arithmetic $W$ from a positive Euler prior with its exact endpoint and continuous density terms. The [prime-score](prime-score-negative-covariance.md) theorem also proves an upper-orthant product and exponential-moment comparison, while its exact cutoff-$570$ example disproves full negative association. The prime-score and [density-prime](density-prime-covariance.md) covariance theorems have opposing contributions. Their [combined balance](combined-prime-density-covariance.md) proves leading compensation but leaves the decisive remainder unsigned. An [exact conditioned counterexample](conditional-prime-dependence.md) shows why full-law negative pair covariance does not persist on every prime-revelation branch. These are written proofs, with rational certificates for the stated finite checks, and no Lean formalization claim.

## A formal negative dyadic divisor average

The [renewal and dyadic-average note](division-renewal-dyadic-average.md) proves $\sum_{d=1}^N[\psi(2N/d)-\psi(N/d)-N/d]<-N(3/2-\log4)$ for every integer $N\ge1$. The actual prime-power sum, its factorial identification and the strict margin are formalized in Lean. Distinct written proofs retain the causal renewal, exact dyadic boundary cancellation and signed transfer; none supplies the missing critical two-history sign.

## An actual arithmetic sign sufficient for RH

The [eventual-sign criterion](actual-critical-sign-criterion.md) proves in Lean that eventual nonpositivity of the explicitly defined, complete arithmetic sum $W(x)$ implies full mathlib RiemannHypothesis. Its Mellin identity, Landau theorem, continuation and pole exclusion are proved, including multiple zeros. The eventual sign itself remains unproved.

## Centered Goldbach pairs as a multiplicative spectral norm

The [spectral bridge](goldbach-multiplicative-spectral-bridge.md) uses the Mellin--Barnes beta identity to express the Dirichlet series of centered additive pairs as a positive gamma-weighted vertical-line norm of $-\zeta'/\zeta-\zeta$. The identity is unconditional in the absolutely convergent range $\sigma>2$; finiteness of the positive spectral norm for every $1<\sigma<2$ is equivalent to RH. The [scaling-kernel and hard-wall audit](goldbach-scaling-kernel-hard-wall.md) composes this norm with the actual coherent-core Mellin kernel, retains every prime power through an exact root lift, and quantifies why the required projector degree grows with a subcritical cutoff. These results isolate the exact additive-to-multiplicative estimate that ordinary Goldbach existence or a signed continuation does not provide.

## Prime-state hard wall and causal renewal criterion

The [prime-state hard wall](prime-state-hard-wall.md) gives an exact primality separator with sharp composite gap $(2+\sqrt2)/4$, while the [projector boundary analysis](prime-state-projector-boundary.md) proves that the macroscopic state-$1$, prime and composite sectors must be centered before taking the projector limit. The [critical heat criterion](critical-heat-lyapunov-exponent.md) identifies RH with a zero Lyapunov exponent for the centered prime heat source. The [reverse-scale heat audit](centered-goldbach-reverse-scale-audit.md) gives the exact signed horizon innovation and an unconditional PNT-scale bound. The [causal renewal development](prime-division-renewal-lyapunov.md) gives zeta as the scale-shift symbol, while the [Euler-discrepancy audit](prime-division-euler-discrepancy.md) proves its positive primitive and cell asymptotics, supplies the causal trace correction, and shows that the centered remainder changes sign. Unrestricted BIBO stability is false; the source-specific phase/coercivity estimate remains unproved.

## Discrete harmonic convolution, regularity and aliasing

The [written proofs](harmonic-convolution.md) give a general cancellation mechanism for the exact integer harmonic operator. Mean-square translation continuity yields a bilinear mean theorem, with spectral conditions allowing continuous and mixed spectra. A separate exponential-variation theorem permits escaping frequencies, while an exact counterexample shows that bounded mean energy and a vanishing primitive alone do not suffice. The arithmetic application retains every dilation and prime power and gives an alternative proof of the known RH-conditional leading term of $W$. Its general lemmas are unconditional; the arithmetic mean-energy input remains unproved. These results are not formalized in Lean.

## Harmonic prime Laplacian and infinite flow

The [phase and flow theorem](harmonic-prime-laplacian-flow.md) proves a physical $1/p$ Laplacian lower bound on every fixed exponential frequency band. It constructs an unconditional infinite-prime divergence for the actual mean-zero line-one error, with finite edge energy, absolute weighted flux and admission error $O(\log P/\sqrt P)$. The complete prime-factorization inequality, its exact normalized harmonic average, the lcm formula and the closed bound for its prime weights are formalized in the [four linked Lean modules](harmonic-prime-laplacian-flow.md#formalized-factorization-and-scope). The frequency lower bound and infinite-flow statements are written proofs.

## Retained ages, prime histories and source completion

The [age-resolved lift](age-resolved-prime-history-lift.md) keeps the complete cell profile, exact successor wraps, prime-power seams and finite initial-age terms. Its analytic-radius equivalence restates the classical RH error criterion in these coordinates. The [two-prime unilateral theorem](two-prime-unilateral-boundary.md) proves both compact boundary identities, including the common-resonance value and derivative constraints and the actual positive forward normalization.

The [causal-history construction](causal-history-overflow.md) gives exact finite-band overflow with coherent interference, both physical ports and the unitary age-cell dictionary. Its [geometric entropy theorem](complete-prime-history-entropy.md) quantifies the omitted averaged history tail. The independent [gamma-freezing proof](uniform-full-product-arch-freezing.md) controls the full-product clipping error uniformly in the prime set, while retaining its unsigned arithmetic boundary.

For the actual prime-error source, [late-age transfer](late-age-prime-boundary-transfer.md) proves deterministic operator estimates and a PNT-weighted completion of both boundary ports. The [Vinogradov–Korobov refinement](late-age-vk-history-entropy.md) extends completion to all admitted primes through $P=o(R^{3/5}/(\log R)^{1/5})$ and proves trace-norm stability of the associated two-port Gram operator. The [successor compatibility theorem](successor-collective-prime-compatibility.md) gives an exact compressed affine relation, the complete collective boundary seed and cutoff-uniform actual-source commutator estimates. These are written proofs. Separate positive port energies do not establish the signed two-history readout or the fixed-observation RH norm bound.

## Local poles at zeta zeros

[ZetaPole.lean](BuildingBlocks/ZetaPole.lean) proves that if $\zeta(\rho)=0$ and $\rho\ne0,1$, there are a positive integer $m$ and a function $a$ analytic at $\rho$ such that, on a punctured neighborhood,

```math
-\frac{\zeta'(s)}{s\zeta(s)}-\frac{1}{s-1}+\frac{2\gamma}{s}
=\frac{-m/\rho}{s-\rho}+a(s).
```

The residue is $-m/\rho\ne0$, including at multiple zeros. This identifies the singularity that remains after cancellation of a shared reciprocal-zeta term in prime-error formulas. Controlling the remaining arithmetic expression is still necessary to locate the zeros.

The result uses classical analytic zero factorization and logarithmic derivatives; see [Apostol's explicit formula, DLMF 25.16.2](https://dlmf.nist.gov/25.16.E2). Formal dependencies include mathlib's [isolated-zero factorization](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Analytic/IsolatedZeros.lean) and [logarithmic derivative rules](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Calculus/LogDeriv.lean).

[Verification](verification/zeta-pole.json).

## Explicit floor correction

Define

```math
\begin{aligned}
D(q)&=\sum_{k=1}^{q}\left\lfloor\frac{q}{k}\right\rfloor,\\
H(q)&=\log(q!)-D(q)+2\gamma q,\\
\Delta(x)&=D(\lfloor x\rfloor)-x\log x-(2\gamma-1)x,\\
c_0&=\tfrac12\log(2\pi)-\gamma.
\end{aligned}
```

[FloorCorrection.lean](BuildingBlocks/FloorCorrection.lean) proves, for every real $x\ge1$,

```math
\left|H(\lfloor x\rfloor)+\Delta(x)-c_0
+\left(\{x\}-\tfrac12\right)(\log x+2\gamma)\right|
\le\frac{2}{x}.
```

The bound includes integers, where $`\{x\}=0`$. It separates a constant mean from a weighted sawtooth, allowing Fourier estimates to be applied. On an integer block $B<n\le2B$ with $2B\le N$, the residuals at $x=N/n$ sum absolutely to at most $4B^2/N$. This block consequence is a written deduction; the formal theorem is the pointwise bound.

The mathematics follows from the [Stirling expansion and remainder estimates](https://dlmf.nist.gov/5.11). The imported mathlib [Stirling module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/SpecialFunctions/Stirling.lean) credits Moritz Firsching, Fabian Kruse, and Nikolas Kuhn; the [Euler–Mascheroni module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/Harmonic/EulerMascheroni.lean) credits David Loeffler. Mathlib dependencies retain their Apache 2.0 license.

[Verification](verification/floor-correction.json).

## Möbius hyperbola product estimate

[HyperbolaProduct.lean](BuildingBlocks/HyperbolaProduct.lean) proves the finite product-grouping and complementary-divisor identities for

```math
a_N(k)=\sum_{\substack{d\mid k\\k^2\le Nd}}\mu(d).
```

The [written proof](hyperbola-product.md) applies classical Fourier and derivative estimates to obtain, for every $\delta>0$ and integer $\sqrt N\le A\le N/2$,

```math
\left|\sum_{\sqrt N<k\le A}a_N(k)
\left(\{N/k\}-\tfrac12\right)\right|
\ll_\delta N^\delta A^{4/3}N^{-1/3}.
```

Thus products through $N^{5/8}$ contribute $O_\delta(N^{1/2+\delta})$. The analytic estimate is not formalized in Lean. Larger products and the other terms in the prime-error formula remain unresolved. Exact publication priority is unestablished; this entry records a useful application of classical methods.

[Sources and proof](hyperbola-product.md) · [Verification](verification/hyperbola-product.json).

## A regular source with a large Möbius inverse

[RegularSource.lean](BuildingBlocks/RegularSource.lean) proves that for each real $r<2/3$ there is a single sequence $f:\mathbb N\to\mathbb R$ satisfying, for every $q\ge0$,

```math
|f(q)|\le\sqrt q,\qquad |f(q+1)-f(q)|\le1,
```

whose Möbius floor inverse has no eventual bound of order $N^r$:

```math
\nexists C>0,\,N_0\ge1\quad
\forall N\ge N_0:\quad
\left|\sum_{d=1}^{N}\mu(d)f\!\left(\left\lfloor N/d\right\rfloor\right)\right|
\le C N^r.
```

The [complete written proof](regular-source-mobius-obstruction.md) retains both the finite construction and the fixed-source argument. The sequence may depend on $r$. At $N=t^3$, separated tent functions first give a sequence with inverse at least $t^2/64$ for $t\ge256$. The Banach–Steinhaus theorem then yields a fixed sequence for each exponent.

This excludes deriving the desired inverse bound from size and bounded increments alone. It does not give a lower bound for the particular arithmetic source $H$, or settle RH.

The proof uses elementary squarefree counting and the classical uniform boundedness principle. Its formal dependencies include mathlib's [Banach–Steinhaus theorem](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Normed/Operator/BanachSteinhaus.lean), by Jireh Loreaux, and [bounded-function normed spaces](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Topology/ContinuousMap/Bounded/Normed.lean), by Sébastien Gouëzel, Mario Carneiro, Yury Kudryashov, and Heather Macbeth. These dependencies retain their Apache 2.0 license. Priority of this exact counterexample and its formalization is unestablished; no originality claim is made.

[Verification](verification/regular-source.json).

## Finite primitive-energy bounds

[CoarsePrimitive.lean](BuildingBlocks/CoarsePrimitive.lean) bounds weighted integrals of the actual prime error $`e(x)=\psi(\lfloor x\rfloor_+)-x`$. Put $`P_X(t)=\int_X^t e(x)\,dx`$, $`R_X(t)=\int_t^{2X}e(x)\,dx`$ and $`S_X=\int_X^{2X}(P_X(t)^2+R_X(t)^2)\,dt`$.

For $`X>0`$, a continuous complex test function $`w`$ differentiable inside the block, with interval-integrable derivative satisfying $`\lVert w'\rVert\le K`$ for $`K\ge0`$, obeys

```math
\left\lVert\int_X^{2X}e(x)w(x)\,dx\right\rVert
\le\sqrt{2S_X/X}\,\lVert w(2X)\rVert+K\sqrt{XS_X}.
```

The module also proves the exact finite Mellin identity, retaining the terminal mass and integer jumps. It supplies no growth bound for $`S_X`$ or infinite-series continuation theorem. The mathematics uses classical Cauchy–Schwarz and one-sided integration by parts.

[Assumptions, use and attribution](coarse-primitive.md) · [Written RH criterion](coarse-energy-rh-criterion.md) · [Verification](verification/coarse-primitive.json).

## Exact hyperbola endpoint correction

[HyperbolaEndpoint.lean](BuildingBlocks/HyperbolaEndpoint.lean) evaluates the complete signed endpoint count, for every integer $`N\ge1`$:

```math
E(N)=\sum_{d\mid N}\mu(d)\#\{m\mid N/d:m\le\sqrt{N/d}\},
\qquad 2E(N)=1+(-1)^{\Omega(N)}.
```

Here $`\Omega`$ counts prime factors with multiplicity. The original inclusive double-sum equality is also formalized. The full ordinary-to-midpoint sawtooth correction is consequently zero or $`-1/2`$; that real-valued conversion is a written consequence and does not apply to arbitrary restricted outer blocks. The proof uses classical divisor pairing and Möbius inversion.

[Statement, use and attribution](hyperbola-endpoint.md) · [Verification](verification/hyperbola-endpoint.json).

## A conditional route to full RH

[CoarsePrimitiveCriterion.lean](BuildingBlocks/CoarsePrimitiveCriterion.lean) proves that the actual primitive energy bound $`S_{2^k}\le C_\epsilon2^{k(4+\epsilon)}`$, for every $`\epsilon>0`$ and every $`k\ge0`$, implies mathlib's full Riemann hypothesis. The energy bound remains unproved. The formal proof includes local uniform convergence, the zeta identity and exclusion of all nontrivial zeros off the critical line under that hypothesis.

[Statement, proof and attribution](coarse-conditional-rh.md) · [Verification](verification/coarse-conditional-result.json).

## Finite Mertens-to-prime transfer

[MertensPrimeTransfer.lean](BuildingBlocks/MertensPrimeTransfer.lean) converts a bound on the actual Mertens function at every quotient $`\lfloor N/k\rfloor`$, $`1\le k\le K`$, into an explicit bound for $`|\psi(N)-N+2\gamma|`$. The finite hyperbola and partial-summation proof retains its boundary term and all prime powers. The Mertens premise remains to be proved by a consumer.

[Statement, proof and attribution](mertens-prime-transfer.md) · [Verification](verification/mertens-transfer-result.json).

## Angular height and two boundary ranges

The [written theorem](angular-height-boundary.md) bounds the angular height of a cyclotomic prefix by a signed sum of old-root derivative-deficit updates. Exact Farey insertion gives a polylogarithmic positive-birth allowance. Conductors at most $`\sqrt X`$ and ages at most $`\sqrt N`$ have total absolute cost $`O(\sqrt X\log^3X)`$.

The remaining interior interaction is unbounded. The proof uses classical chord concavity, Farey geometry and divisor sums; it has no Lean formalization or originality claim. [Exact finite checks](verification/angular-boundary-result.json) · [Provenance](verification/angular-boundary-provenance.json).

## Local two-history forcing

[TwoHistoryForcing.lean](BuildingBlocks/TwoHistoryForcing.lean) proves the exact mixed response of $h(n)=\log n-\tau(n)+2\gamma$ on coprime factors, its nonpositive sign, and finite Bonferroni bounds for higher interaction coefficients. These local identities do not bound the full signed prime-error energy.

[Statements, proof and sources](two-history-forcing.md).

## GCD threshold kernels

The [written proof](gcd-threshold-kernels.md) gives the signed divisor-square decomposition of $\mathbf1_{\omega(\gcd(k,l))\ge2}$ and shows that fixed weights on its zero-, one-, and at-least-two-prime levels yield a universally positive semidefinite kernel only when all three weights are equal and nonnegative. It identifies why a pointwise nonnegative arithmetic kernel need not define a positive quadratic form. No Lean formalization is claimed.

## Cyclotomic eta finite parts

The [written proof](cyclotomic-eta-finite-parts.md) evaluates the rational-cusp normalization of an eta product with Mertens exponents and its exact tail correction. The correction retains the original cyclotomic derivative, so the modular transformation alone supplies no additional phase-dependent cancellation. No Lean formalization is claimed.

## Theta cutoff completion obstruction

The [written proof](theta-cutoff-completion.md) shows that every finite theta cutoff, and each specified positive even square-root completion, has infinitely many nonreal Fourier-transform zeros at every real heat time. It identifies the endpoint defect and its complex branch contribution despite rapid weighted kernel approximation. The result concerns these approximation families, not zeros of the full Riemann xi function. It uses classical contour asymptotics and Hadamard factorization; no originality or Lean formalization is claimed.

## Shifted Fourier correlations

The [written proof](shifted-fourier-density.md) distinguishes an analytic Wronskian from derivatives of the squared Fourier modulus. A positive analytic Bessel-convolution kernel disproves the general density assertion with the outside-hyperbolic-cosine kernel in Dimitrov–Xu arXiv:1606.05011v1, Theorem 3.2. The corrected kernel yields a density criterion allowing multiple real zeros. No conclusion about the truth of RH, originality, or Lean formalization is claimed.

## Theta radial-weight positivity

The [written proof](theta-radial-positivity.md) shows that every complete radial weight in the actual folded theta expansion is strictly positive, for all real Fourier arguments and every positive vertical shift. An exact Abel/Bessel square identity retains the lower endpoint and all differential terms. The remaining divisor coefficients are signed; positivity of their full sum is unproved. No originality or Lean formalization claim is made.

## Cosh-base universal-factor approximation obstruction

The [written proof](cosh-universal-factor-closure.md) excludes even local positive-axis $L^1$ approximation of the actual theta kernel by $e^{-a_j\cosh(b_ju)}$ times positive even Pólya universal factors, including all parameter escape. Logarithmic curvature forces an entire limit, contradicting a theta boundary singularity. Arbitrary real-zero Fourier approximants remain outside the conclusion. No originality or Lean formalization claim is made.

## An eventual-sign criterion from distinct-prime convolution

The [written proof](distinct-prime-sign-criterion.md) shows that RH is equivalent to eventual negativity of a centered triangular multiplicative convolution after subtracting the contributions from powers of the same prime. A weighted Mellin boundary estimate retains arbitrary zero multiplicities and proves that the negative prime-square bias dominates under RH. The unconditional sign remains unproved, and no Lean formalization or originality claim is made.

## A complete Bernstein obstruction for theta Mellin interpolation

The [written proof](theta-mellin-bernstein-obstruction.md) and [Arb certificate](certificates/theta_mellin_laguerre.py) show that an auxiliary normalized Mellin transform of the complete theta kernel violates the Laguerre inequality and has a nonreal zero. Its entire continuation then excludes every complete Bernstein function matching the actual xi coefficient ratios, including the KPS one-separation subclass. General Bernstein, $B_J$, $D_P$ and RH remain unresolved; this is an Arb-assisted proof, not a Lean formalization.

## Square-root aggregation of the sign criterion

The [written proof](sqrt-multiple-sign-criterion.md) proves that RH is equivalent to eventual negativity of the square-root-weighted sum over multiples of the distinct-prime convolution. Under RH its main term is $-x^{3/2}\log^2x/6$, with error $O(x^{3/2}\log x)$. The proof preserves arbitrary zero multiplicities and needs no finite simplicity verification. The unconditional sign remains open.

## Undamped prime products in Nyman–Beurling approximation

The [written proof](prime-product-nyman-test.md) shows that finite undamped prime-division products fail in the full Nyman–Beurling Hilbert norm even after optimal scalar normalization: the best squared error tends to one. Locally convergent scalar choices instead have divergent full error. This tests that family of approximants, not the criterion itself.

## Local Möbius signs and dense history energy

The [written proof](partial-mobius-dense-history.md) uses the classical truncated Möbius weights with the actual divisor forcing. They obey every division-sign rule up to a growing polylogarithmic prime cutoff, yet their complete prefix/suffix energy has order $X^5$ up to logarithmic factors. Removing all those small-prime edges leaves the same leading cross energy. These are auxiliary weights, not the actual Möbius function.

## Cyclotomic activity, quadrature and boundary reductions

The [written proof](cyclotomic-activity-quadrature.md) separates the clipped old-root update into its exact angular correlation, mesh flux and curvature subtraction. A uniform cyclic-cell estimate bounds the cumulative interior geometric remainder by $12\sqrt X\log((3\pi/4)X^2)$; reduced conductor and reduced age boundary sums are controlled absolutely. An [explicit activity-selection example](cyclotomic-activity-necessity.md) shows why bounded symmetric activities alone cannot control the remaining correlation. Actual derivative history remains essential.

## Incomplete-box carry covariance

The [written proof](incomplete-carry-covariance.md) reduces covariance of two modular carries to flat and triangular one-dimensional sawtooth correlations, with endpoint error at most $(d+e)/(8H)$. Its exact Fourier formula retains incomplete periods and all residue-zero corrections.

## Entropy of the cyclic divisor observable

The [written proof](divisor-observable-entropy.md) gives exact CRT entropy and cyclic shift-energy formulas for $\tau(\gcd(n,r))$. It proves an exponent-uniform anchored entropy comparison with $\log(\sigma(n)/n)$ and a primorial obstruction to a constant observable log-Sobolev bound.

## The actual theta arcsine mixing law

The [written proof](theta-arcsine-law.md) recovers the unique positive arcsine scale law of the actual theta density, its exact tail and its only possible Lévy exponent. Membership of that exponent in $B_J$ remains unproved. The mixing law is not additively infinitely divisible; this does not exclude an exponential-functional representation.

## A noncomplete Bernstein function with real-zero output

The [explicit Bessel example](noncomplete-bernstein-real-zero-example.md) belongs to $B_J$ but not the complete Bernstein class, while its associated entire characteristic function has only real zeros. The construction concerns an auxiliary function and supplies no class-membership theorem for the actual xi function.

## Prime-division matching obstructions

A [finite neighborhood argument](prime-division-unmatched.md), combined with Selberg’s squarefree-factor count, forces at least $(3/(\pi^2\sqrt{2\pi})+o(1))N/\sqrt{\log\log N}$ unmatched vertices in the one-prime division graph. A separate [time-dependent weighted dual](bounded-factor-matching.md) proves that the integrated cost of the three-prime graph and its three-step enlargement grows too quickly for the proposed all-epsilon energy target. Neither statement lower-bounds the actual signed error.

## Integrated divisor histories

The [written proof](integrated-divisor-history.md) keeps exact fractional endpoints, evaluates the common drift through integrated Voronoï theory, and proves that all labels up to $\sqrt X$ can be left unmatched within an $O(X^4)$ energy budget. It also gives sharp per-edge tests showing where uniform stronger savings fail.

## Integrated prime-channel triangle

The [written proof](integrated-prime-channel-triangle.md) gives an elementary $cX^{5/2}$ lower bound for the sum of the integrated largest-prime-channel norms, while retaining the exact density-inclusive finite Gram formula for the signed aggregate. It excludes that triangle majorant alone.

## Integer histories and finite determinants

The [prime-clique cutoff](prime-clique-cutoff.md) has exact arithmetic births and a trace-monoid interpretation, but its real critical-strip limit differs from zeta. The [divisor-conjugated successor](divisor-successor-overlap.md) has an explicit primewise signed Gram kernel and local counterexamples; its full coherent norm is a classical RH-equivalent Mertens quantity. [Literal renewal and phase memory](integer-renewal-and-phase-memory.md) retain path order and negative interference, while [face feedback](integer-face-feedback-obstruction.md) gives an exact obstruction to one proposed positive-resolvent repair.

## Theta and cyclotomic finite tests

The [radial arithmetic sign theorem](theta-radial-arithmetic-sign.md) proves strict cutoff-weight monotonicity and negativity at some actual frequencies for the arithmetic coefficient alone, with the frequency-dependent mixture retained. [Cyclotomic orbit examples](cyclotomic-weighted-orbit-obstructions.md) disprove specified weighted and unweighted contraction claims. A [quartic Jensen region](quartic-reciprocal-defect-region.md), with an exact symbolic certificate, gives four distinct negative roots under explicit reciprocal-defect bounds. None is an all-degree real-zero theorem for xi.

## Formal prime filters and signed convolution

The [prime-filter and Selberg modules](prime-filter-selberg-identities.md) prove exact actual-prime-power primitives, the factor-nine inverse filter estimate, reflected convolution bounds, same-prime subtraction and continuous integer-cell dynamics. [Finite arithmetic tools](finite-arithmetic-energy-tools.md) cover CRT valuation realization, smooth-divisor stopping, shift energies, divisor overlap and scalar entropy loss. The [cyclotomic boundary interface](cyclotomic-boundary-formal-interface.md) keeps its unformalized Farey enumeration, regularized old-factor identity and angular-consumer premises explicit. These are useful formalizations of stated finite identities and conditional implications, without a first-formalization claim.

## Restrictions on theta multiplier constructions

The [Bessel heat and Hankel tests](theta-bessel-factorization-obstructions.md) exclude specified positive-heat mixtures and sufficient radial truncation criteria for the actual theta law. The [Euler–Gaussian factorization theorem](theta-operator-factorization-obstructions.md) excludes a specified sample-interpolation class and its coefficientwise closure, using Carlson uniqueness and the auxiliary Mellin obstruction. General multiplier preservation and RH remain open.

A [certified complete-theta Mellin zero](theta-mellin-parabola-obstruction.md) refutes a proposed sufficient region for every individual conjugate pair. The [grouped multiplier theorem](grouped-quadratic-multipliers.md) proves that suitable genuine real factors can compensate a failing pair; their required occurrence for the actual function remains unproved. The [quantum speed bound](theta-mellin-quantum-speed-bound.md) proves an auxiliary right-opening zero-free region using actual theta variance and projective Hilbert-space geometry.

The [derivative-kernel theorem](theta-derivative-kernel-logconcavity.md) proves strict log-concavity of $-d\Phi(\sqrt v)/dv$ for the complete theta kernel, with an Arb compact proof and an analytic infinite tail. Its shifted Mellin representation extends the quantum-speed region one unit to the left. These auxiliary constraints do not prove RH or Bernstein-function membership.

The [natural-exponent concavity theorem](theta-natural-exponent-concavity.md) proves $\phi_{\mathrm{nat}}'(s)>0$ and $\phi_{\mathrm{nat}}''(s)<0$ for every real $s>-3/2$. Its global reciprocal-score inequality uses complete-theta interval enclosures and an explicit analytic tail. The accompanying [two-crossing lemma](BuildingBlocks/TwoCrossingMoment.lean) formalizes only the abstract non-strict integral comparison. Full Bernstein membership and RH remain open.

The [third-derivative theorem](theta-natural-exponent-third-derivative.md) further proves $\phi_{\mathrm{nat}}'''(s)>0$ on the same entire real interval. A complete-theta interval certificate, analytic tail, and three-crossing moment argument establish the result. The proof is computer-assisted and has no Lean formalization; it does not establish all derivative signs or a positive Lévy representation.

The [small-jump construction](theta-small-jump-levy-density.md) proves that the candidate Lévy density is positive and strictly decreasing near zero, using a uniform complex theta saddle and Bromwich inversion. The [global sign and positive-mixture criterion](theta-positive-jump-mixture.md) characterizes its extension to a nonincreasing Lévy density by one unproved global sign, equivalently an exact positive integral equation. These are written analytic results without Lean formalizations. The global sign remains open, and ordinary Bernstein or $B_J$ membership does not itself imply RH.

A [meromorphic complete Bernstein family](bernstein-theta-growth-nonreal-zeros.md) has the same leading exponent growth and double-logarithmic mixing-tail rate as theta, but its associated entire functions have nonreal zeros. The proof retains these asymptotics under a perturbation that preserves a nonreal Mittag–Leffler zero. It excludes that general real-zero mechanism without identifying the family with the actual theta law.

## Signed divisor packets

The [divisor-cube construction](signed-divisor-packets.md) partitions actual Möbius labels by coprime cores and retains all prefix, suffix and mean terms. For a growing primorial, the interior and packet diagonal have energy $X^{4+o(1)}$; a classical Mertens estimate gives a strict saving over packet magnitudes for the whole signed boundary. Its remaining RH-scale covariance upper bound is unproved.

## Arithmetic feature and stability tests

The [full-divisor birth decoder](divisor-birth-decoder.md) has an exact gcd Gram matrix, minimum-norm density coordinate and orthogonal surplus formula for the actual centered prime input. The [squarefree cutoff examples](squarefree-cutoff-stability-obstructions.md) rule out specified stability and graph-Laplacian mechanisms, including every positive coefficient tilt on two fixed supports. Neither a large auxiliary norm nor failed finite stability implies an RH counterexample.

## High-frequency radial cutoff laws

The [radial cutoff asymptotics](theta-radial-cutoff-asymptotics.md) prove the fixed-parameter uniform logarithmic law, its critical Beta transition and a quantitative transfer of the complete arithmetic sum. The transfer retains its moving frequency, prime powers and terminal mass; the sign of the resulting finite sum remains open.

## Temporal covariance and coherent division markings

The [actual floor-column covariance](temporal-floor-covariance.md) retains temporal means and exhibits a large positive terminal-prime subblock canceled to leading order by its full signed complement. The [coherent division marking](coherent-division-marking.md) reduces complete incidence histories to the prime-power indicator and shows exactly why adjacent-response cancellation fails to control the forcing selector. These identities preserve the actual signs without supplying the missing RH-scale residual estimate.

## Haar completion and Weil damping

The [Haar energy theorem](haar-prime-energy-completion.md) keeps every scale and endpoint atom, proves a single-scale Fourier charge obstruction and an exact cheaper multiscale completion, and identifies the lower forcing estimate still needed. The [Weil damping counterexample](weil-damping-obstruction.md) disproves downward positivity for the actual pole-subtracted family using admissible compact tests. Keeping the poles yields a different positive family only in the stated classical half-plane. Neither result establishes the undamped RH positivity condition.

## Coherent late-prime packets

The [complete-packet calculation](late-prime-packet-energy.md) proves $X^5/\log^2X$ energy at every fixed fractional prime cutoff, with an explicit constant at cutoff $X$. The full packet energy exceeds the sum of its diagonals by order $X/\log X$, while the actual signed readout cancels its leading term. This excludes a scale-independent independent-packet estimate, not the actual RH bound.

## Support flow and relative prime determinants

The [pole-preserving support flow](signed-support-flow.md) gives a complete smooth parametrization, the exact divisor flux, a first-prime obstruction to scalar differential propagation and a sharp logarithmic finite-step modulus. The [relative determinant calculation](prime-density-relative-determinant.md) continues an independent density reference, identifies the exact trace cost of actual prime discrepancy and proves that unitary mixing cannot reduce that cost. Its exact local prime-cell comparison converges below the critical line, while the independent density trace cost diverges at and below the critical boundary. The full cutoff and derivative corrections distinguish these references. Every regularization retains its required first-order restoration.

## A certified fixed-support prime complement

The [signed prime-form theorem](signed-prime-bath.md) proves a $0.3152$ lower bound for the actual Weil form on the infinite-dimensional complement of a specified 766-dimensional admissible cell space at support $[-1,1]$. It retains all prime powers and the signed logistic correction. A standard-library rational certificate verifies its constants. The full retained-plus-complement inequality keeps an unevaluated mixed Gram matrix; the retained numerical eigenvalues are diagnostics only.

## Finite-codimension local Weil extensions

The [local-kernel theorem](local-weil-extension-obstruction.md) proves deficiency indices $(1,1)$ and an $O(T\sqrt{\log T})$ spectral count for every same-space or finite-codimension self-adjoint extension. The prescribed arithmetic kernel requires $\Omega(T\log T)$ surviving poles from classical simple critical-line zeros, so no such extension realizes it. Infinite-codimension realizations and global Weil positivity remain outside this exclusion.

## Prime-support deletion and a central divisor block

The [uniform prime-support theorem](prime-support-removal-asymptotics.md) keeps all prime powers and proves the sharp cost of omitting a fixed amount of lower-prime mass, while negative auxiliary upper-band deletions demonstrate why optimizing support is not the full-support sign criterion. It also gives both marginal signs before each sufficiently large prime square and an exact classical max-flow/min-cut criterion for fractional interaction allocation. The [central Möbius–divisor estimate](voronoi-mobius-central-block.md) proves $O(L^{19/16}\log^6(2L))$ for one block using classical Voronoï and finite shift estimates. The other divisor blocks and their signed total remain unbounded at the RH scale.

## Reciprocal approximation and elementary prime energy

The [reciprocal quotient-window modules](reciprocal-quotient-windows.md) prove an exact Gram isometry, local coefficient recovery and the failure of any fixed finite coefficient repair under an explicit Mertens oscillation premise. The [prime-energy identities](prime-energy-first-moment.md) retain the terminal square and prove an unconditional bounded signed first moment; the signed drift still needs an upper bound. The [ordered division-rod inequalities](ordered-division-rods.md) bound products by endpoints and total gap, with the strictness and empty-family hypotheses explicit. These are formalized finite tools, not proofs of the missing RH estimates.

## Unitary prime phases

[Unitary prime-phase lift](unitary-prime-phase-lift.md) gives a written joint-spectral extension of half-neighbor rigidity. Finite defect yields a self-adjoint scale generator, an exact spectral energy, and the form domain $\operatorname{Dom}|T|^{1/2}$. The proof allows arbitrary spectral multiplicity and distinguishes concentration on a Borel character set from a topological support assertion. It does not identify the counting isometries or the Weil form with this unitary model.

## Semilocal scattering and signed arithmetic phases

The [scattering subject index](scattering-subject-index.md) connects compact negative parts, exact weighted traces, continuum and rational pole corrections, Brownian signed-tail energy, and the two distinct arithmetic norm estimates. A separate single-observation theorem characterizes RH by a subpower norm bound; that unconditional bound remains open. All results in this group are written analytic proofs.

## Actual successor and product-location cutoffs

The [finite-frequency collection](arithmetic-subject-index.md#actual-finite-frequency-readouts) preserves three distinct full-$W$ approximation methods, with square-root, $3/8$, cube-root and quarter-power frequency scales. It also includes the proof that the actual integrand has both signs and the particular positive dyadic flux. The full arithmetic readout, its density terms, all proper powers and its endpoints are retained; no bound for the remaining signed integral is proved.

The scattering collection also proves the [exact observed growth exponent](zero-abscissa-scattering-growth.md) and constructs [one actual compact pole-null observation](compact-positive-scattering-observation.md) with squared Fourier modulus positive everywhere. The common growth exponent is the unknown zero abscissa minus $1/2$; the theorem does not establish that it vanishes.

## Two-history storage and inverse division

The [two-history collection](scattering-subject-index.md#opposite-histories-and-their-signed-boundary) gives finite-strip conservation, exact inverse-boundary constraints, a projected quarter-power cutoff, and unilateral Laplace formulas. Artificial filter poles cancel; hypothetical off-line zeta zeros retain their double poles. These are written identities and estimates, with the full signed storage bound still open.

The [additive-clock and divisor-score pair](scattering-subject-index.md#additive-discretization-and-the-centered-divisor-score) gives exact successor discretization and unconditional convergence for the centered divisor score in the same localized trace topology. The classical divisor bound is sufficient for that convergence; inversion back to the prime score remains uncontrolled.

The [nonlinear successor-increment pair](scattering-subject-index.md#nonlinear-successor-increments) separates the exact Hilbert–Schmidt first-increment energy from Peller's trace-norm second-increment criterion. Both keep the complete arithmetic phase before taking a modulus. Their sampling theorems establish no growth estimate for that phase.

The [local-factor and composition collection](scattering-subject-index.md#exact-local-factors-and-composition-obstructions) preserves exact prime fibers, both signs of the actual two-prime second moment, the weighted-triangle counterexample and its modulus/Peller repair. It also contains the full compact pole-null test generation theorem for two prime filters, with classical attribution and its remaining mixed-term obligation.

## The actual theta jump operator

The [theta jump subject index](theta-jump-subject-index.md) connects the exact Weil ground-state identity, score projection, sharp Poincare target, unconditional essential threshold, and negative-index theorem with its compact zero-isolation proof. Distinct conjugate zero pairs are counted correctly at repeated zeros. The lower gap remains unproved; the chapter also retains specific failed path, curvature and finite-observation comparisons. These are written analytic results.

The [theta eigenfunction regularity chapter](theta-jump-eigenfunction-regularity.md) retains the stronger domain, complete zero sum, threshold-accumulation and multiplicity-sensitive isolator arguments. The [finite-time renewal chapter](theta-jump-tail-renewal.md) proves the actual tail evolution and the two distinct stochastic-order and Euclidean-contraction obstructions.

The independent [theta synthesis route](theta-jump-subject-index.md) is now collected from its exact equality-space description through quotient indicator bounds, Borel contours, weighted duality and smoothing in the actual jump-form norm. It retains the unresolved boundary case and the odd rank-one correction.

The [prime-power square comparison](prime-power-gram-correction.md), [composite counterexample](composite-gram-obstruction.md), [Jordan density correction](jordan-mixed-correction.md), and [exact counting births](counting-birth-full-generator.md) preserve the older arithmetic overlap and transport arguments, including their precise failed extensions.

The [largest-prime sector theorem](macroscopic-sector-sign.md) preserves an unconditional collective arithmetic sign. The [positive-routing theorem](theta-positive-routing-obstruction.md) gives a separate impossibility result for the specified finite-path comparison class, with its equality mechanism explicit.

The older [dyadic harmonic identities](actual-harmonic-doubling.md) and [arithmetic quadrature correction](harmonic-quadrature-correction.md) retain their exact initial atoms, newly admitted scales, and unconditional PNT-size estimates as companions to the general harmonic-convolution theorem.

The [revelation martingale](prime-revelation-martingale.md) retains the full conditional density budget and its proved one-prime obstruction. The [full-$W$ excursion theorem](full-w-off-critical-excursions.md) records the precise two-sided power-scale consequence of any hypothetical off-critical zero.

The historical [adjacent cyclotomic histories](cyclotomic-adjacent-history-correction.md), [finite fusion response](cyclotomic-fusion-response.md), and [selected recovery](cyclotomic-selected-recovery.md) preserve the exact arithmetic construction, classical matrix input and fixed rational counterexamples. Their proof scope includes the actual scalar factors, phases, clipping and circular Farey weights.

The [restricted-range refinements](cyclotomic-restricted-range-refinements.md) retain temporal mass, endpoint deficit, arbitrary age bands, polylogarithmic proper-divisor costs and exact gcd moments. The [valuation reduction](cyclotomic-valuation-update.md) gives classical neutral-update filters with full conductor bookkeeping. The [delayed-inverse construction](cyclotomic-old-inverse-pairs.md) proves the exact threshold-potential remainder and certifies why inverse factors do not imply clipped dissipation.

The [actual-prefix refinement theorem](actual-prefix-refinement.md) gives the exact two-row carry law, empirical bias and logarithmic information saturation. The [finite-prime Möbius consumer](finite-prime-mobius-consumer.md) retains every induced quotient cutoff and density correction, then proves a linear lower bound for the absolute prime-increment sum. These preserve the initial counting/division construction and its precise unresolved signed estimate.

## Prime-division Feynman–Kac paths

The [written construction](prime-division-feynman-kac.md) gives the exact tilted division chain, completed path budget, same-prime drift and full-$W$ adjoint. Its first moment is finite, its one-prime completed second moment can be infinite, and a fixed Chebyshev slack does not cover the baseline. The positive finite semigroup is retained as a proved object; the needed signed arithmetic bound remains open.

## Small-prime grouping and centered reconstruction

The [written grouping theorem](small-prime-grouping.md) preserves all cancellation within each smooth/rough group, yet proves the outer absolute total is at least $(2\gamma-1)N/(4\log N)$ eventually, uniformly for cutoffs through $N/2$. The exact centered identity keeps both endpoints and every proper prime power. Its same-power reconstruction theorem identifies the remaining arithmetic estimate without claiming it.

## Local cutoff versus complete-period covariance

The [sawtooth cutoff theorem](cutoff-period-gcd-obstruction.md) gives consecutive integer labels below $X$ whose actual local energy exceeds their exact common-period gcd form by a factor at least $X/5940$. Its elementary proof retains all gcd multiplicities and attributes the covariance identity to Franel–Landau. It refutes an arbitrary-coefficient subpower comparison, without bounding the actual Möbius-weighted form.

## Variable-length Möbius–divisor blocks

The [global divisor-block chapter](global-divisor-blocks.md) preserves both the elementary correlation estimate and the stronger joint-frequency Robert–Sargos application, uniformly for $\sqrt N\le D\le N/2$ and arbitrary initial subintervals. It gives $O_\delta(N^\delta(N^{1/4}D^{11/16}+D))$, with every floor and truncation cost stated. This extends the range of the central-block method; it supplies no bound for the required full signed total.

## Positive-kernel transfer of the signed divisor correction

The [Balazard–Daval kernel transfer](signed-divisor-positive-kernel-transfer.md) retains the exact direct Mertens term and both smoothing kernels. A logarithmic-time dominated-convergence proof transfers any profile with vanishing logarithmic derivative, with explicit mass constant $(\gamma-1/4)(7/4-\gamma)$. The argument preserves the full signed correction, and does not establish a critical-power Mertens estimate.

## The actual source in a mixed additive-energy space

The [mixed completion](actual-source-mixed-dirichlet-completion.md) contains the untruncated prime-error source unconditionally and supports fixed-window linear and bilinear readouts. Its positive metric has Fourier weight comparable to $\min(|\xi|,1)$. The [prime transport theorem](prime-transport-in-mixed-completion.md) gives exact changed adjoints, an unbounded full-space inverse, a genuine actual-source inverse domain and explicit negative quadratic forms for the old prime operator. A [separate positive comparison](positive-prime-comparison-in-mixed-completion.md) has single-prime norm $4/p$ but transforms both source and readout.

The [reflection-domain theorem](additive-energy-reflection-domain.md) proves an exact boundary-energy decomposition, local embeddings and fixed-window reflection bounds. Full reciprocal reflection of the actual source is outside the anchored completion. The [paired metric identity](paired-metric-conservation-and-source-ports.md) retains every finite-prime inverse history, both compact ports and the full signed harmonic readout after removing the source cutoff. Finally, [sharp readout growth](sharp-causal-readout-energy-growth.md) proves operator norm $\asymp e^{t/2}$, with both signs attained by synthetic unit-energy histories. These written proofs establish the source domain and its limitations; they do not establish the arithmetic sign or transfer the old operator's positivity to the new metric.

## A positive successor-seed process and its signed response

The [fixed-Cauchy covariance identity](fixed-cauchy-prime-covariance-seed.md) identifies the complete centered prime generator with the Gram form of its actual successor boundary profiles. It proves a fixed-observation $L^2$ limit and an exact two-port graph for every even Wiener multiplier of the ground profile, including nonlinear finite-prime heat. The [long-memory theorem](collective-successor-seed-long-memory.md) gives $B(v)=2/v-4/v^2+O(v^{-3})$ with a rapidly decaying density remainder.

The [positive jump process](positive-successor-seed-jump-process.md) uses the finite measure $B(v)\,dv/v$ to construct an all-prime probability law and a uniformly bounded orbit in the mixed source space. Its common causal inner factor preserves the actual prime response. The original centered generator is a domain-qualified derivative of this evolution; positive probability and bounded evolution alone do not control that signed response. These are written proofs using classical Bernstein, compound-Poisson, Hardy and PNT methods.


## Fixed-observation heat and exact source thresholds

The [complete prime-heat theorem](fixed-observation-prime-heat.md) identifies the centered generator with a line-one zeta logarithm and its full proper-power correction. Two global domination methods support complex subcritical convergence, a meromorphic scalar continuation, the critical-window uniform law and an explicit large-age profile. The scalar integrability threshold is $1/2$; the ground seed's squared-norm threshold is $1/4$. Exact finite-source cancellation shifts the threshold, while an actual two-birth example proves that the successor need not preserve it. The [partial-cosine companion](uniform-partial-prime-cosines.md) retains every cutoff endpoint in the PNT proof. These are fixed-observation and finite-source theorems; no joint completion of the unrestricted arithmetic source or RH bound follows.


## All-order profiles and signed arithmetic bands

The [actual-window Sobolev theorem](real-window-phase-sobolev-orders.md) combines the Montgomery–Vaughan mean-value theorem with full geometric derivatives and Bell coefficients. It retains a separate elementary frequency-separation proof and gives explicit order bounds, arbitrary moving-threshold control and a canonical high-height remainder estimate. The [Haar moment identity](haar-profile-all-order-moments.md) instead computes the exact weighted profile energy from the full geometric law, including the finite-cutoff exponential-moment boundary and its high-order obstruction. Haar moments do not replace actual-window moments.

The [signed divisor-band theorem](signed-divisor-band-correlations.md) sums complete common-divisor histories at each reduced ratio before estimating them. It proves exact finite-difference cancellation and opposite signed sharp-boundary examples, while retaining the unresolved collective off-diagonal band sum. These are written methods with classical attribution, not fixed-observation RH estimates.


## The centered prime kernel and its domains

The [complete birth kernel](centered-infinite-prime-birth-kernel.md) has two explicit endpoint tails and squared cutoff error asymptotic to $4/\log P$. The [original-space multiplier](centered-prime-mellin-domain.md) has a maximal self-adjoint domain and a logarithmic frequency-zero singularity. A [mixed-space counterexample](centered-prime-domain-counterexample.md) shows that a PNT-style decay envelope and finite mixed energy do not by themselves justify this infinite-prime limit.

For each finite arithmetic source, the [ground graph](centered-prime-natural-source-graph.md) retains the seed, both temporal directions and their cross term. The [sharp fixed-source law](fixed-source-centered-cutoff-law.md) gives constants $4|M|^2$ and $8|M|^2$ for the original squared norm and additive energy after multiplication by $\log P$, including arbitrary fixed finite complex innovations. A separate [coupled prime-square balance](coupled-prime-square-birth-balance.md) and [proper-power constant](prime-square-proper-power-constant.md) account for all generator cutoffs, inclusive arithmetic endpoints and the exact old-generator deficit. These are written proofs; they do not establish the centered operator on the unrestricted arithmetic source.


## Formalized complete successor-seed integrals

[PrimeSeedMass.lean](BuildingBlocks/PrimeSeedMass.lean) and [PrimeSeedSquare.lean](BuildingBlocks/PrimeSeedSquare.lean) prove positivity, literal floor-profile identification, integrability and the complete masses $2/p$, $\log p/[p(p-1)]$ and $p^{-2}$ for every real $p>1$. The [theorem-to-source table](positive-successor-seed-jump-process.md#formalized-single-clock-dependencies) records the exact declarations. The proofs sum every prime-clock interval and use no arithmetic or RH premise. The all-prime probability process is formalized below; its operator response remains a written proof.

## Arithmetic carry arrivals and exact boundary signs

The [carry covariance chapter](incomplete-carry-covariance.md#5-the-arithmetic-carry-cocycle-and-positive-box-arrivals) also proves a positive exact arrival law for the actual von Mangoldt-weighted box, a distinct CRT proof of complete-period covariance, and a family of incomplete-box positive covariances tending to $1/4$. Its prime-level example $\operatorname{Cov}(\kappa_{11},\kappa_{13})=128/2197$ at cutoff $13$ rules out transferring period orthogonality by a nonpositive boundary assumption. The classical binomial carry interpretation is attributed; no prime-error bound follows from these identities alone.


The [delay and prime-sum formalizations](positive-successor-seed-jump-process.md#formalized-delay-history-and-prime-sum-distinctions) retain the seed's initial interval and terminal history, prove causal uniqueness, and apply Euler's theorem to distinguish divergent total component mass from summable component square mass. Their exact finite-aggregate and no-integrable-majorant theorems preserve the cross-prime limitation.


## Complete centered arrival energy and positive-age evolution

The [large-birth theorem](infinite-centered-birth-energy.md) proves the actual kernel's translation modulus $8/\log(1/h)$ and centered birth energy $16/(t\log t)$, with every inverse prime-power jump retained. The [arithmetic loading theorem](transformed-actual-arrival-loading.md) gives total increment energy asymptotic to $16\log N$, separate density-cell loading $16\log\log N$ and finite proper-power loading; all ramp squares and mixed corrections sum absolutely.

Every fixed nonnegative-age probability law [preserves this leading loading](positive-age-preserves-arithmetic-loading.md), including the complete positive successor process and infinite-mean laws. The exact finite-history balance retains the signed cross work. Its required $-8\log N$ leading cancellation would follow from a separate uniform bound on transformed source energy, which is not proved here. These analytic results remain written proofs.


## Coprime interior histories with nonunit divisor layers

The [exact gcd-layer theorem](cyclotomic-coprime-interior-history.md) expresses an interior cyclotomic update as a signed sum over surviving squarefree gcd layers. Its two checked examples reverse the selected phase sign before the first product scale, but their actual full clipped changes are both zero. The finite incidence proof and exact shifted CRT count preserve the correction that a no-common-multiple argument cannot discard. This is a written proof with a symbolic certificate, not an aggregate cancellation estimate.


The [finite-prime probability construction](positive-successor-seed-jump-process.md#formalized-finite-prime-jump-measure-and-probability-law) is also formalized. `PrimeSeedLevy` proves finite activity for the exact density $B_S(v)/v$, and `PrimeSeedCompoundPoisson` proves probability normalization, time zero and equality with the complete original convolution series, including zero intensity. [PrimeSeedSemigroup](BuildingBlocks/PrimeSeedSemigroup.lean) also proves the exact time-addition law by regrouping all paired jump histories. The all-prime probability construction is formalized below; cutoff-law convergence is formalized below, while operator claims remain written dependencies.

## Common cyclotomic scales and exact clipping defects

The [relative-norm proof](cyclotomic-common-scale-norm.md) reduces the actual upper cyclotomic unit through a nonnegative group-ring exponent, including repeated/shared primes and the degree-one step at 2. It gives the exact algebraic trace, logarithmic averaging operator and character zeros. The full Farey-weighted observable retains explicit fibre covariances and clipping defects. Exact symbolic certificates include a nonzero weighted factor sum whose full clipped increment is zero. This written proof uses classical circular-distribution methods; no Lean formalization is claimed.


## Natural cutoff, relative charge and retained heat memory

The [natural-arrival cutoff theorem](natural-arrival-cutoff-completion.md) proves quantitative convergence of the literal frozen-tail source in the additive mixed energy, with all jumps and the endpoint retained. The [relative successor charge](actual-successor-resonance-charge-cocycle.md) is a bounded functional there and has a strictly positive arithmetic limit, expressed by an absolutely convergent arcsine–zeta series. Its exact memory block retains the scalar feedback. The [finite-memory heat repair](successor-heat-finite-memory-repair.md) gives a bounded compensated successor on a causal BV graph space for $0<\sigma<(2m+1)/4$, with explicit memory packets and no uniform growing-$m$ claim. The [collective square-response proof](collective-successor-charge-square-response.md) explains why zero mean on each prime clock does not remove the positive collective half-moment response. These are written proofs; no full signed Weil or anticausal bound follows.


## All-prime finite activity and the exact probability law

[PrimeSeedActivityBound](BuildingBlocks/PrimeSeedActivityBound.lean) derives actual prime reciprocal-log summability from the existing formal Chebyshev bound by complete dyadic fibres. [PrimeSeedAllPrimeLevy](BuildingBlocks/PrimeSeedAllPrimeLevy.lean) then proves finite activity of the literal $B(v)/v$ measure, identifies the pointwise finite all-prime seed, and constructs its exact probability semigroup and original convolution series. It also proves $B\notin L^1$. The [precise theorem mapping](positive-successor-seed-jump-process.md#formalized-all-prime-finite-activity-and-probability-semigroup) separates this unconditional construction from the operator-domain results and links the subsequent formal cutoff-convergence theorem. No PNT or RH premise enters these modules.


## Even-character separation and its conditional arithmetic consumer

The [even-character family proof](even-character-zero-separation.md) combines finite orthogonality with a paired Hurwitz expansion. Its normalized sum tends locally uniformly to one on $\Re s>0$, away from $1$, and it gives an explicit conductor threshold at a possible zeta zero. The exact Abel consumer retains the conductor prime, the endpoint and arbitrary zero multiplicity. Holomorphic continuation of every quotient in the specified unbounded-conductor family is RH-equivalent; the required arithmetic bound remains unproved. A passing symbolic certificate checks the finite normalization, not the analytic premise. No Lean claim is made.


## Compensated causal memory and its original derivative

The [maximal seed-translation proof](successor-seed-maximal-translation.md) retains every prime-power jump and gives uniform variable-shift control for complete, partial and tail seeds. It supplies the [bounded compensated kernel](charge-compensated-successor-memory.md), a map from the actual causal mixed completion into physical $L^1$, with a joint prime/source cutoff rate. The [integral-conservation proof](compensated-memory-integral-conservation.md) keeps the nonintegrable reference before cancellation. The [arithmetic clock calibration](successor-clock-arithmetic-calibration.md) fixes the retained tail constant, yielding [spatial means and finite-log-measure sign exceptions](actual-memory-spatial-sign.md). The [original derivative response](charge-compensated-clock-response.md) lies in $W^{-1,1}$: the exponential reference has an explicit endpoint atom in its finite-measure remainder, while the zero-endpoint reference gives an $L^1$ remainder. These written proofs give no sampled-birth, anticausal or full Weil sign.

The [quantitative complete-history tail](positive-successor-seed-jump-process.md#formalized-quantitative-activity-tail) is formalized in [PrimeSeedActivityTail](BuildingBlocks/PrimeSeedActivityTail.lean): the exact split retains $p<P$ and omits $p\ge P$, with omitted activity at most $32/\log P$ for natural $P\ge8$. The proof uses the existing Chebyshev dependency and complete dyadic fibres. Probability-law convergence is formalized below.


## Integer-history cells, curvature and minimum clocks

The [prime-clique chapter](prime-clique-cutoff.md#the-full-two-complex-and-its-metric) now retains the complete two-complex homology, scalar flatness classification, positive class trace and exact finite real pole. Its minimum-clock proof applies to each directed trace class. The [original rod extraction](integer-renewal-and-phase-memory.md#lowest-clock-extraction-and-its-logarithmic-defect) preserves a different clock method and proves that extraction does not commute with the logarithm. The [curvature chapter](integer-face-feedback-obstruction.md#curvature-absorption-and-the-complete-graded-square) includes the exact chain completion, full-clock independent-face counterexample and six-state interacting-face calculation. Four passing exact certificates accompany these written results; no Lean or RH theorem is claimed.

The [formal law comparison](positive-successor-seed-jump-process.md#formalized-cutoff-law-convergence-and-its-normalization) gives event error $32u/\log P$, uniformly on bounded time intervals, for the actual retained primes $p<P$. The [formal moment and support theorems](positive-successor-seed-jump-process.md#formalized-infinite-mean-and-the-zero-jump-atom) prove infinite mean age at every positive time and the exact zero-jump atom. These four modules preserve the distinction between finite activity, event convergence and unbounded moments; no RH premise is used.

The [closed-half-plane exponent](positive-successor-seed-jump-process.md#formalized-closed-half-plane-exponent-and-complete-tail) also has a formal literal-integral construction, nonnegative real part and uniform complete-tail error $64/\log P$. Holomorphy and the law-transform identity remain written proofs.


## Compact causal defects and the moving signed packet

The [compact-memory theorem](compact-compensated-causal-response.md) proves compactness into physical $L^1$ and, after differentiation, the full-line causal $W^{-1,1}$ quotient retaining the endpoint atom. The [exact scalar charge law](actual-source-causal-charge-law.md) supplies strict causal-port signs, one charge crossing and an ordered crossing sequence for every derivative. The [positive-history operator proof](positive-history-successor-charge-relaxation.md) gives the full finite-time $L^1$ response. Its [natural-cutoff consumer](natural-cutoff-positive-history-charge.md) has negative total mass for every positive time and all cutoffs. The [finite-transport proof](compensated-successor-finite-transport.md) retains both rank terms and the complete two-history kernel; the [uniform prime/time packet theorem](uniform-prime-time-successor-packet.md) tracks fixed, growing and all-prime cutoffs at scale $t\log t$. These are written source/operator theorems, distinct from the formal probability dependencies and from any full Weil sign.

The [causal energy anchor](actual-source-mixed-dirichlet-completion.md#formalized-causal-energy-anchor) is formalized for measurable real sources vanishing almost everywhere below $1$, with possibly infinite energy. It retains the exact reciprocal-max weight and the logarithmic change of coordinates. Completion and actual PNT source membership remain written proofs.

The [three-step matching extension](bounded-factor-matching.md#6-a-finite-example-with-genuinely-cheap-head-edges) retains an exact finite example with cheap head edges, a good-time dual, and the conditional extension to other fixed ratios. Its full positive-cost majorant has logarithmic growth exponent $5$; the signed coarse energy remains outside that lower bound.

The [literal successor charge](actual-successor-resonance-charge-cocycle.md#formalized-integrable-successor-charge) is formalized for real $L^1(0,\infty)$ inputs, including the initial interval, successor integrability and exact compensated charge conservation. The extension to the actual nonintegrable source remains separate.

The [original-graph coherent matching proof](coherent-large-label-matching.md) preserves the exact observable-distance identity, an actual three-edge cancellation repair, and complete fixed-matching energy and primal–dual certificates. Its whole-interval dual gives exponent $5-4/k$ for the positive majorant; the ratio-eight proof uses a different good-time argument.

The [finite-energy relative-charge bound](actual-successor-resonance-charge-cocycle.md#formalized-relative-charge-at-finite-mixed-energy) is also formalized: the literal kernel product is integrable and its half-integral is bounded by $\sqrt{\mathcal E(H)}$, without an absolute-charge or unweighted-integrability premise. Actual PNT membership and arithmetic positivity remain written.

## Positive successor primitive and the complete W comparison

The [actual primitive theorem](actual-source-successor-primitive.md) proves positivity at every positive age by exact arithmetic-cell extrema and a classical explicit PNT tail. The [complete W comparison](actual-W-positive-primitive-analysis.md) gives strict cumulative ordering, while a certified actual zero and a Laplace singularity argument prove that the unsmoothed difference has both signs arbitrarily far out. It retains the identical same-prime subtraction, density cancellation and unchanged off-critical double-pole coefficient. These are written and computer-assisted proofs, not the missing eventual W sign.


## Positive potentials and original-energy curvature

The [natural-cutoff primitive theorem](natural-cutoff-successor-primitive.md) proves strict positivity at every positive age for every $N\ge2$, including the frozen terminal tail. Its bounded Arb certificate complements the full-source proof. The [two-port construction](positive-primitive-two-port-drift-curvature.md) retains the complete midpoint terms and exact successor contact. A [short finite-measure proof](all-prime-fixed-source-drift-curvature.md) gives the all-prime limit at fixed $N$; a distinct [block-variation proof](full-prime-successor-potential-midpoint.md) gives uniform $H^2$ potentials and joint original-$L^2$ convergence of the successor correction. Individual columns and the full midpoint sign remain outside that conclusion.

The [actual cutoff-2, prime-2 computation](actual-finite-history-curvature-domains.md) exhibits a nonzero derivative of a Dirac mass, refuting the proposed nonnegative-curvature-measure hypothesis while retaining a valid Sobolev pairing. The [formal theorem mapping](all-prime-fixed-source-drift-curvature.md#formalized-energy-and-contact-forms) records the compiled unit-step estimate, lag-gradient form, contact bound $9$ and physical kernel expansion. The prime-column and logarithmic-commutator identities remain written proofs.


The [Haar refinement calculation](haar-prime-energy-completion.md#the-exact-refinement-forcing-before-fourier-completion) now includes the full divisor-coefficient update, independent translated forcing bound, a positive actual forcing certificate including the endpoint power, and its explicit pair/boundary obligation. The [uncentered overlap proof](temporal-floor-covariance.md#the-uncentered-overlap-formula) retains a separate geometric derivation of the same signed kernel and its exact fractional-part correction.


The [actual tilted first moment](actual-W-positive-primitive-analysis.md#formalized-actual-tilted-first-moment) now has Lean proofs at every real cutoff: exact factorial remainder, Abel integral, strict negativity after $1$ and the uniform bound $-\log2/2$ after $2$. The [critical-coordinate port modules](all-prime-fixed-source-drift-curvature.md#formal-critical-coordinate-ports) separately prove the causal successor/predecessor ranges and contact pairing under their stated $L^2$ and support hypotheses. These do not formalize the full W comparison or unrestricted anticausal curvature.

The [actual prime-two energy theorem](prime-two-anticausal-energy.md) proves the full-power, cutoff-two energy change is less than $-1/10$, with a passing bounded Arb certificate and all negative ages and unbounded tails retained. This complements the derivative-of-atom obstruction in the same example, without asserting a uniform sign for larger sources or prime sets.


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


The [ground-state Green covariance](theta-groundstate-green-covariance.md) identifies the maximal transformed jump domain and its conservative semigroup, retaining infinite continuous activity. The [signed-flow comparison](theta-groundstate-covariance-comparison-literature.md) gives an explicit full-conductance current and a weighted conditional bound, with a strict calibration loss. The [weighted crossing theorem](theta-groundstate-bounded-weighted-crossing.md) proves boundedness of the ground state and source map on all core $L^2$ inputs.

The [complete residual clock](theta-complete-ground-covariance-clock.md) changes reference measure with a proved equality of potential domains. It represents the exact covariance and complete gain through every continuous and prime-power history. Its affine formula retains the nonnegative optimizer correction. The continuous gap now applies to this actual covariance, but has not been shown to pay the signed core deficit. These are written proofs with classical ground-state and flow attribution.


The [two-half-line affine comparison](theta-two-halfline-affine-covariance.md) gives an exact contraction factor and retains its nonzero score constraint. Its [actual odd-score failure](theta-two-halfline-odd-score-failure.md) has a complete elementary [radius-two proof](theta-two-halfline-failure-at-radius-two.md). The stronger [continuous-only failure](theta-full-continuous-comparison-failure.md) retains every continuous cross-half-line edge and still gives a lower comparison below $-1/10$. Its necessary sign-energy scale identifies the missing aggregate prime crossings.

The [true affine calibration](theta-true-affine-odd-score-calibration.md) leaves the exact score form unevaluated, retaining the scaled Green covariance and determinant. The [ground-history prime convolution](theta-ground-sign-prime-convolution.md) expresses the cross energy through the literal all-power samples and an absolutely convergent squared-transform Dirichlet integral. Its ground equation gives an absolute logarithmic-frequency budget, but no required relative arithmetic lower bound. A positive continuous gap and failure to pay this affine deficit are compatible.


The [exact seed renewal](exact-seed-renewal-asymptotic.md) has a strictly decreasing renewal sequence with $r_n\sim2/(\pi^2\sqrt n)$. The chapter verifies Caravenna–Doney’s boundary-index theorem and retains an independent moment/monotonicity proof using Kaluza’s sign mechanism. The [signed-source stabilization](signed-source-successor-stabilization.md) gives a strong dilated profile at each fixed cutoff, with limiting squared norm $28\zeta(3)M_N^2/\pi^4$. Its explicit uniform remainder requires $k\ge\max(4,(N-1)^2)$.

The [growing-time source cocycle](growing-time-actual-source-cocycle.md) retains both signed birth orders and exact process dissipation. Complete dyadic diagonal loading tends to $2\log2/(\pi^2c)$, and actual PNT makes the time-linearization errors absolutely summable. The whole successor budget transfers with an explicit error involving the still unknown terminal norm. A positive first admission and a small-time increasing first norm refute universal stepwise sign shortcuts.


The [presieved prime-pair completion](presieved-prime-pair-completion.md) derives exact Ramanujan/CRT masked spectra and a scalar-charge obstruction for primorial $W\ge30$, $h\ge4W$. A distinct full nonuniform completion on the actual interval $(64,128]$ gives a certified lower bound above $16.90$, where the optimal scalar bound is below $-61.02$. The rational/Arb certificate passes with every allowed coordinate and prime-power exception retained. Cheap weighted completion at growing scales, the cyclic density cost and signed endpoint contributions remain unresolved.


The [formal derivative chain](positive-successor-seed-jump-process.md#formalized-weak-derivative-and-exact-jordan-variation) now proves the actual full-clock weak derivative and exact finite-prime Jordan variation. Prime births cannot cancel proper-power decay atoms. The all-prime positive and negative components are locally finite with an exact closed-age cutoff, but each has infinite total mass. The formal full-prime test identity retains that distinction; it does not assert a globally finite signed derivative.

The [complete all-prime cutoff-two energy certificate](full-prime-two-energy-certificate.md) proves an original-energy decrease greater than $1/200$ for the actual unit-coefficient coherent prime sum. Its [joint-tail proof](full-prime-two-relative-energy-tail.md) retains the positive $H^{-2}$ leading term and all mixed errors. The passing Arb certificate encloses every omitted prime and both age tails; no general-source or arbitrary-prime-coefficient comparison follows.

The actual [second successor](second-compensated-successor.md) has a strictly positive difference primitive and a [second cumulative W comparison](second-successor-tilted-order.md), while the [fifth primitive](actual-successor-fifth-primitive-failure.md) is strictly negative on an explicit initial interval. Passing Arb certificates retain every arithmetic tail. A [complete geometric average](actual-successor-resolvent-primitive-order.md) restores positivity for $0<r\le1/32$. Its [all-parameter correction and boundary criterion](actual-successor-resolvent-boundary-criterion.md) retain the common-age quantifier; the [literal feedback transform](successor-feedback-tail-Abel-poles.md) preserves every off-critical pole. The required near-one sign remains open. [Fixed-source geometric and Cesàro profiles](successor-averaging-retained-charge-profile.md) retain signed charge on expanding scales, with no growing-source interchange.

The [conditional feedback calibration](successor-feedback-RH-converse.md) proves RH implies an eventual margin $E(r)>5/3$, with exact logarithmic-clock mean and nonzero variance. Together with the forward pole argument it gives an RH equivalence; failure of RH forces unbounded excursions of both signs. No unconditional final-interval sign is proved.

The [factorial-division proof](actual-Abel-factorial-division-positivity.md) gives positive nonterminal inverse weights for $r\le1/2048$ and an explicit finite moving core for every $r<1$, retaining the negative initial mass and the ordered factorial endpoint. The distinct [Chebyshev quadrature proof](actual-Abel-feedback-Mellin-kernel.md) keeps the collective causal-boundary correction and derives the same feedback pole filter. A final-interval sign for one fixed inverse weight would imply RH plus simplicity; that stronger sign is not proved.

The [actual feedback source and increment formalization](successor-feedback-tail-Abel-poles.md#formalized-actual-source-and-ordinary-increments) retains the causal seed, every prime power, the exact new-birth/density difference and absolute relative-kernel charge. Chebyshev proves the driver series converges for $|r|<1$. The separate [terminal-strip module](successor-feedback-tail-Abel-poles.md#the-retained-terminal-strip) now identifies charge with half the increment integral. The analytic pole mechanism and arithmetic sign criterion remain written.

The [exact arithmetic feedback kernel](successor-feedback-arithmetic-kernel.md) gives a factorial endpoint-versus-cell budget and a linear moving cutoff for its negative prime-power coefficients. Its [global scaling proof](successor-feedback-kernel-scaling.md) retains the collective endpoint constant. After division inversion, the [linear positive exterior](successor-feedback-linear-inverse-core.md) forces negative logarithmic mass at moving nonterminal states. The [weighted-Mertens moment proof](successor-division-kernel-moments.md) establishes two cancelled logarithmic moments and an ordered positive-negative-positive shape, plus a distinct direct beta-integral comparison. The exact total feedback sign remains open. The [complete discrete curved-log comparison](successor-division-curved-log-comparison.md) proves a positive normalized limit for each fixed exponent between zero and one half, with the full Jordan-divisor readout. The [two-order cancellation proof](successor-division-two-order-cancellation.md) gives exact seed and endpoint contributions and isolates the signed logarithmic quadrature defect; its unconditional Mertens bound does not determine the feedback sign.

The [historical presieved completion](presieved-prime-pair-completion.md#9-an-independent-cyclotomic-and-sturm-proof-of-the-finite-example) now also retains its independent truncated-power/cyclotomic and exact Sturm proof of the scalar optimum, with a separately passing mathematical certificate. The general scalar obstruction and the single finite nonuniform repair retain their different scopes.

The [prolate projection certificate](prolate-projection-certificate.md) gives a distinct fixed-support reduction: an exact rational rank-146 polynomial projection lies within $10^{-8}$ of the first continuous concentration modes. Full infinite-tail inertia and residual checks yield a complement bound above $0.353891999999999$ after both poles are adjoined. The retained Weil matrix and mixed Gram remain unevaluated.

The [actual feedback driver](successor-feedback-tail-Abel-poles.md#formalized-actual-source-and-ordinary-increments) now has a formal square-root/logarithmic decay bound and an absolutely convergent holomorphic Dirichlet transform on $\Re z>1/2$. [SuccessorFeedbackDecay](BuildingBlocks/SuccessorFeedbackDecay.lean) and [SuccessorFeedbackDirichlet](BuildingBlocks/SuccessorFeedbackDirichlet.lean) derive this from the full arithmetic source; the later analytic continuation and RH sign consumer remain written.

The [local reflection and filter identities](actual-W-positive-primitive-analysis.md#formal-local-reflection-and-the-literal-exponential-filter) are formalized in [ReflectionEnergy](BuildingBlocks/ReflectionEnergy.lean) and [ReflectionFilter](BuildingBlocks/ReflectionFilter.lean). Actual local $L^2$ data suffice for the exact reflected convolution, mixed defect and positive filtered-square kernel; Fubini and integrability are derived. These identities leave the full $W$ sign open.

The [complete same-prime history theorem](full-history-same-prime-residual.md) retains every proper power and proves $-s(v)\le\int s(v-r)d\mu-s(v)\le0$ for every causal probability law. The residual is strictly negative after $\log4$ when positive delays have positive mass. Its finite-sum, measurability and integral proof is formalized; PNT constants and full $W$ consumers remain written. The same dependency chain proves actual chronological divisibility monotonicity and the product-event Turán bound.

The [formal prime-block chain](actual-W-positive-primitive-analysis.md#formal-prime-block-calibration-distinct-pairs-and-density-terms) now identifies the full-power sum with the existing $\psi$, calibrates the same-prime filter, expands the actual source into ordered distinct pairs and both density orders, and evaluates each normalized coefficient with exact endpoints. Local $L^2$ and all integral exchanges are derived. The [final identification](actual-W-positive-primitive-analysis.md#formal-identification-with-the-original-v-and-w) now proves both the finite-$V$ assembly and full harmonic aggregation for the original $W$, with no identification premise.

The [quadratic logarithmic endpoint](successor-division-quadratic-log-readout.md) has unconditional normalized limit $\pi^{3/2}$, using the classical full Selberg weight. The distinct [coherent lattice identity](actual-coherent-division-lattice-remainder.md), [mean-removal refinement](actual-coherent-successor-quadrature-refinement.md) and [dual cosine/centered ODE proof](actual-division-lattice-dual-cosine.md) retain the entire physical correction, fractional cell and periodic curvature. The signed first-logarithm comparison remains unproved.

The [signed finite division boundary](signed-division-core-boundary.md) proves a negative cofactor budget with a uniform moving-cutoff asymptotic and the complete factorial endpoint. [Exact lattice-port cancellation](finite-division-lattice-port-cancellation.md) identifies the remaining exterior as positive quadrature tending to zero. [Integer-birth convex interpolation](actual-integer-birth-positive-quadrature.md) then gives $E(e^{-t})=b_t\mathscr D_K-C+b_t\Gamma_K+D$, with $\Gamma_K\ge0$ and $D\asymp t\log(1/t)>0$. The constant-scale finite-core lower bound remains unproved. These are distinct written arithmetic proofs with all prime powers retained.

The [formal floor/index/clock corrections](successor-feedback-tail-Abel-poles.md#formal-floor-index-and-clock-corrections) now retain the literal floor and initial driver, continue the index error to $\Re z>-1/2$, and prove the bounded actual clock discrepancy has an absolutely convergent holomorphic Mellin error on $\Re s>0$. The full pole/sign consumer remains written.

The [actual theta collision proof](theta-heat-collision.md) retains the modular endpoint and certifies one ordinary double zero in a strictly negative-time box. Its collision direction and signed fourth-moment obstruction are exact. The [coefficient-flow proof](theta-coefficient-flow.md) refutes favorable normalized-quadratic monotonicity on actual coefficients, then gives conditional adjacent-defect and reciprocal-cubic repairs, certified for every $t\in[0,1/2]$ and shift $0\le n\le8$. Higher shifts, degrees and global descent remain open. Complete-tail Arb and exact symbolic certificates are included; the classical theta/heat normalization is attributed to its literature.

The [original V/W identity](actual-W-positive-primitive-analysis.md#formal-identification-with-the-original-v-and-w) is formalized through [OriginalWIdentification](BuildingBlocks/OriginalWIdentification.lean): every full-power source term, density order, same-prime subtraction and harmonic multiple agrees with the central Mellin definitions, including $x\le1$. The open sign bound is unchanged.

The [prime hard-wall proof](prime-hard-wall.md) retains exact integer occupations and exhibits both marginal covariance signs despite conditional repulsion. It gives positive-slack and logistic representations, explicit Möbius and full-power cutoff errors, and a positive-temperature mixture obstruction. The limiting contour loses uniform absolute control; no critical-strip bound follows. The squarefree Möbius, full-power Liouville and Mangoldt readouts remain distinct.

The [signed birth-budget comparison](signed-birth-budget-to-canonical-scattering.md) bounds the actual canonical scattering norm by $(1+\log N)\sqrt{1+J_N+D_c(N)}$, with exact seed, gamma, all admitted powers and signed source work. Its [square-tail proof](admitted-prime-square-counterphase.md) retains an explicit continuum phase costing $O_\chi(\log\log N)$, plus a vanishing relative error. The [clock-action theorem](total-clock-dissipation-and-signed-work.md) identifies finiteness of the full accumulated dissipation with RH; that finiteness is not proved unconditionally.

The [local charge square mean](critical-charge-local-square-mean.md) is proved under RH without spacing, simplicity or independent-ordinate assumptions. The [two-sided charge oscillation construction](critical-natural-charge-two-sided-unboundedness.md) is unconditional, gives an alternate finite-frequency proof of a classical consequence, and derives the exact scalar-work liminf and sequential profile closure. Scalar work and process-weighted source work retain different clock terms.

The [formal Gamma and Abel-clock conversion](successor-feedback-tail-Abel-poles.md#formal-gamma-conversion-and-complete-abel-clock-remainder) now proves the actual integral equals $\Gamma(z)D_e(z)$ plus the complete endpoint/index/clock remainder. That remainder is holomorphic on $\Re z>0$; the floor-kernel zeta continuation remains separate.

The [complete cusp asymptotic](successor-quadrature-cusp-asymptotic.md) sharpens the correction to $D(t)=\zeta(3/2)t\log(1/t)/(4\pi)+O(t)$ and gives the same leading term for the mean-removed error $\epsilon(t)$. The proof controls every distance cell behind each integer birth uniformly before summing all prime powers. Chebyshev and the factorial identity suffice; the finite-core sign remains open.

The [literal positive-age Laplace profile](successor-feedback-tail-Abel-poles.md#formal-positive-age-laplace-profile) is now formalized: $H(h)=E(1-e^{-h})$, its initial value and Jacobian are exact, and its absolutely convergent transform agrees with the complete Gamma/index/clock formula for $\Re s>1/2$.

The [analytic zero-moment bound](zero-three-halves-moment-analytic-bound.md) proves $\sum_\rho m_\rho/|\gamma_\rho|^{3/2}<.509$ under RH, using the paired canonical product and a direct gamma/Jensen estimate. It supplies the [uniform common-halfline resolvent converse](successor-resolvent-common-halfline-RH-converse.md), with the older zero-counting argument retained as an alternate proof. The [endpoint extension](successor-resolvent-all-ages-RH-converse.md) gives positivity at every positive age for all sufficiently large $r<1$. Together with the forward criterion this is an RH equivalence; the required sign remains unproved unconditionally.

The [factorial-potential interpolation](factorial-potential-integer-interpolation.md) has a complete correction tending to a negative constant below $-1/4000$, despite eventual cell convexity. The distinct [positive observation of the common-inner history](coherent-core-positive-observation-inner-history.md) retains an explicit unit seed and gives an actual one-step ordering of size $\kappa\pi^{3/2}\sqrt t/2$. Its [original finite-source port](positive-history-observation-original-cutoff-port.md) is signed and has a Chebyshev cutoff $N\asymp t^{-2}\log^2(2/t)$ for vanishing error. The [mixed integer feedback kernel](mixed-integer-feedback-kernel.md) preserves its positive contact, renewal killing and both terminal terms. No collective core lower bound follows from these exact representations.

The [literal floor-kernel formalization](successor-feedback-tail-Abel-poles.md#formal-literal-floor-kernel) retains the upper endpoint $y-1$, proves absolute finite integrability for $\Re z\ge0$ and parameter analyticity for $\Re z>0$, and gives the exact continuous-kernel discrepancy. The later spatial derivative and arithmetic continuation remain separate.

The [explicit ground masses](theta-groundstate-explicit-mass-and-gap-bounds.md) turn the continuous residual gap into a positive fixed-core lower enclosure. The [complete cross-arrival profile](theta-full-cross-arrival-covariance-repair.md) gives a joint covariance bound with the exact same-half denominator. Its [density calibration](theta-cross-arrival-density-calibration.md) separates a small continuous correction from the signed prime error, while the [normalized tail proof](theta-ground-normalized-cross-arrival.md) retains the actual fixed-ground bias. The [positive profile rank](theta-cross-profile-positive-rank-repair.md) and [separate continuous/prime ranks](theta-prime-component-cross-profile-bound.md) improve the full affine comparison by explicit nonnegative quantities. A passing arithmetic profile estimate and the final affine sign remain open.

The [actual weak score tests](theta-cross-profile-weak-score-tests.md) justify the quotient operator domains without a lower bound on the ground state. [Score-action matching](theta-ground-score-action-covariance-repair.md) retains an exact additional rank, and the [affine gap identity](theta-score-matched-affine-gap.md) keeps the optimizer displacement and both known actions. The [full-form proof](theta-prime-profile-full-form-domain.md) places the actual prime profile and bounded-model affine optimizer in the complete form domain. This makes the [conditional edge-energy estimator](theta-affine-comparison-conditional-edge-energy.md) a finite upper bound for the true affine gap, with one common score minimization and separate continuous/prime cross-edge variances. Its arithmetic smallness remains open.

[ConditionalScoreQuadratic](BuildingBlocks/ConditionalScoreQuadratic.lean) certifies the [common-score form algebra and exact separate-optimization penalty](theta-common-score-separate-optimization-penalty.md), including degenerate score cases and the bilinear remainder on a common domain. The actual analytic edge identification and quantitative residual smallness remain further obligations.

[Exponential weak prime-tail prerequisites](theta-exponential-weak-prime-tail-lean-prerequisites.md) formalizes Bochner overlap domination and absolute convergence of the complete Mangoldt-weighted row in both shift orientations, assuming the stated exponential ground moment and measurability. The actual weak ground equation and covariance smallness remain open formalization and arithmetic obligations. [The prime-cutoff limit](theta-exponential-weak-prime-cutoff-limit.md) additionally compiles convergence through the full series along natural-number radii; the archimedean and logarithmic-form limits remain written.

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

The [centered Goldbach heat criterion](centered-goldbach-heat-lyapunov.md) identifies the finite-horizon critical heat energy with an exact weighted sum of the centered coefficients $R_\Lambda(k)-2\psi(k-1)+(k-1)$. Its zero Lyapunov exponent and polynomial horizon-doubling condition are equivalent to RH. The [successor critical-scale calculation](goldbach-successor-critical-scale-neutrality.md) proves that literal successor leakage is exactly of order $t^{-1}$ and therefore cannot be discarded from this centered energy. `GoldbachSuccessorTransfer.lean` checks the endpoint and compensation algebra. `PrimeStateAndRenewalArch.lean` checks the finite projector estimates and the exact maximizer geometry of each renewal cell. None of these results proves the open doubling estimate.

The [successor heat transfer](successor-heat-lyapunov-transfer.md) gives the exact Volterra transform of the full transported prime-power heat source. Its critical profile differs from the original by an unconditional $L^2$ function, so both Lyapunov growth and polynomial horizon doubling transfer in both directions. The doubling estimate remains open; this amplitude-level analytic result is not formalized in Lean.

The [original integer-birth feedback bridge](actual-integer-birth-positive-quadrature.md#formal-identification-with-the-original-feedback) now identifies the existing relative driver with the complete $\Lambda$-weighted birth difference in Lean. The half-density integral and absolute countable Fubini prerequisites are proved, and the exact Abel identity retains $b_j\psi(j)$ at every clock. The original $E$ is unchanged; its near-one positivity remains open.

The [max-to-sum process comparison](max-sum-process-transfer.md) proves the sharp $\pi/4$ upper bound and a reverse bound after complete prime-history damping, with the original frozen endpoint retained. Its RH equivalence cites the established fixed-clock original-source theorem. The [heat-generator identity](heat-generator-origin-flux.md) retains the negative-age origin flux on finite horizons and the signed birth pairing; three actual work intervals have an exact rational certificate. These analytic statements remain written, and the required subpower energy estimate remains open.

The [exponential weak ground row](theta-ground-exponential-weak-cross-row.md) admits the actual coherent-core sources despite their divergent individual theta norms. Its complete core-arrival and pole densities remain. The [continuous Green repair](theta-continuous-green-weak-row-repair.md) removes the actual slow resolvent mode by exact moment correction, but restores a growing correction for the scaling family. These are written domain and identity results; they provide no sign for the remaining prime row.

The [integer-history low-band identity](integer-history-low-band-pairing.md) joins the actual weighted prime prefix and frozen endpoint to factorial forcing and complete Euler edge memory. Its Bernoulli synthesis retains the origin and terminal cancellation. The [coupled Bernoulli energy](coupled-bernoulli-history-energy.md) exposes partial-divisor cross terms in the original max-kernel norm, with exact small-source rational certificates. Coprime and same-prime cross terms can be negative; the positive total and unconditional PNT bounds still do not control the missing RH-scale pairing. Both are written proofs.

The [shrinking even physical trial](theta-shrinking-even-negative-trial.md), with Trudgian's full PNT error, and [two-endpoint crossing bound](theta-internal-exterior-crossing-sharp-bound.md) prove [normalized and physical ground concentration](theta-ground-physical-mass-concentration.md). This does not sign the full Weil form. [Outward sampling](theta-ground-outward-prime-sampling.md) and [symmetric displacement](theta-ground-symmetric-prime-displacement.md) retain the exact weighted norm and signed hard-boundary correction.

The [common-score radius identity](theta-common-score-radius-transport-obstruction.md) separates physical energy contraction from the changing comparison form and optimizer. [Actual-grid counterprofiles](theta-lost-retained-prime-sampling-obstruction.md) show that the available concentration and logarithmic-energy hypotheses alone do not control normalized lost–retained prime sampling. The [mollified quadrature theorem](theta-ground-mollified-prime-quadrature-closure.md) gives a quantitative conditional repair, with uniform anti-spikiness and a PNT-compatible translation modulus still unproved for the actual ground. These are written results, not Lean proofs or a full-gap conclusion.

The [effective-PNT subquadratic proof](centered-W-subquadratic-pnt.md) establishes $V(x)=o(x^2)$ and $W(x)=o(x^2)$ by an endpoint-exact double Stieltjes formula and two dominated-convergence arguments. The complete same-prime subtraction is bounded by $O(x^{3/2}\log^2x)$. The corrected [projector allocation](prime-state-projector-boundary.md) retains the separate $n=1$ sector, so its leading cancellation involves state $1$, primes and composites. These asymptotics are written proofs with classical PNT input, not RH-scale sign bounds.


The [formal signed heat identity](centered-goldbach-heat-lyapunov.md#formal-signed-heat-energy-and-the-actual-series) proves the finite gamma-integral quadratic form, its complete bilinear comparison and the actual positive-time series with $a_1=-1$. The [formal continuous Abel derivative](successor-feedback-tail-Abel-poles.md#formal-continuous-abel-derivative-and-cancellation) identifies the literal smooth kernel derivative and proves its zero-mass $L^1$ cancellation for $\Re z>1/2$. The critical arithmetic estimate and zeta continuation remain separate.


The [formal infinite Goldbach heat identity](centered-goldbach-heat-lyapunov.md#formal-density-cost-and-the-infinite-identity) proves absolute ordered-pair convergence, the complete gamma-integral equality and literal square-cutoff convergence for real $s>2$. The actual discrete and mixed density conventions have mutually comparable finite-horizon energies, with factor $2$ and additive cost $1$. Neither result supplies the missing critical-scale bound.


The [actual heat-to-scaling derivative](actual-heat-scaling-derivative-bridge.md) has two-sided band-energy bounds, exact complex-square convolution errors and a signed whole-line Hermitian pairing. Its source-cutoff and ground-normalization costs remain explicit. The [killed-ground range obstruction](heat-to-killed-ground-range-obstruction.md) proves that the same heat filter cannot reconstruct the actual nonzero killed ground, its odd history or either pole-corrected target with bounded $L^2$ input cost. Finite-total-cost signed Gram factorizations are excluded as well; finite scalar observations and other arithmetic maps are not covered.


The [cross-age relative-work theorem](cross-age-common-clock-relative-work.md) keeps both dilation histories and their terminal mismatch. An executed rational certificate for the actual frozen source $N=14$, successor age $j=12$, proves negative uncharged work at time zero and positive work for every sufficiently large time of the complete prime process. The theorem refutes a universal uncharged sign, without a uniform growing-cutoff threshold or a charge-compensated conclusion.


The [factorial terminal comparison](factorial-terminal-neutrality.md) proves asymptotic preservation of the actual evolved-source energy at every fixed clock $c\log N$, with a relative effective-PNT error and a decaying absolute error. Its complete clock correction retains the signed dilation drift and the exact factorial commutator. Terminal smallness does not give an accumulated-work bound.


The [formal additive Goldbach readout](centered-goldbach-heat-lyapunov.md#formal-complete-additive-readout) now identifies the complete actual centered coefficient with $R_\Lambda(k)-2\psi(k-1)+(k-1)$ and proves its absolutely convergent heat expansion for every positive time. The signed coefficients and both initial totals are retained.

## Complete histories and weighted signs

- [binary forcing weighted sign and zero divisor](binary-forcing-weighted-sign-and-zero-divisor.md). Written mathematics; proof status is stated in the note.
- [endpoint smooth kappa frame actual explicit formula](endpoint-smooth-kappa-frame-actual-explicit-formula.md). Written mathematics; proof status is stated in the note.
- [stable binary prime filter mixed work cocycle](stable-binary-prime-filter-mixed-work-cocycle.md). Written mathematics; proof status is stated in the note.
- [finite future forcing full cocycle work transfer](finite-future-forcing-full-cocycle-work-transfer.md). Written mathematics; proof status is stated in the note.
- [critical cofactor memory covariance](critical-cofactor-memory-covariance.md). Written mathematics; proof status is stated in the note.
- [Weighted primitive sign formalization](WeightedPrimitiveSign.lean). Compiled integration-by-parts and affine two-cell certificates; literal factorial endpoint estimates remain hypotheses.

## Odd-centered additive pairs and their window norm

The [odd-centered heat reduction](goldbach-odd-centered-finite-energy-reduction.md) retains every power of two and the odd-lattice density as a finite-energy correction. [GoldbachOddCentering.lean](BuildingBlocks/GoldbachOddCentering.lean) proves the coefficient decomposition and complete even Mangoldt support. [GoldbachOddPairs.lean](BuildingBlocks/GoldbachOddPairs.lean) proves the literal ordered-pair expansion, the state-one value A(2)=4 and the exact odd count at N=2m. The [even coefficient note](goldbach-odd-centered-even-coefficient.md) separately retains the written power-of-two pair classification and proper-power error estimate.

The [symmetric angular coefficient formalization](goldbach-symmetric-angular-coefficient-formalization.md) and [GoldbachWeightedOddPairs.lean](BuildingBlocks/GoldbachWeightedOddPairs.lean) preserve any symmetric real finite weight in the centered expansion. The [balanced window-energy identity](balanced-odd-goldbach-window-energy.md) supplies the corresponding written angular kernel, finite-horizon clipping and absolute infinite expansion for eta>1. The [window/heat transform bridge](odd-source-window-heat-transform-bridge.md) retains the mandatory state-one correction. The [finite-source norm comparison](odd-heat-balanced-window-norm-comparison.md) bounds the positive heat norm by the balanced window norm for each fixed 0<eta<1, with a cutoff-independent constant and exact origin cost. The live terminal window still needs a uniform arithmetic estimate. These results prove neither Goldbach existence nor RH.

The [actual clocked cutoff-window transfer](actual-clocked-window-odd-heat-transfer.md) controls the complete causal process output by the literal finite odd heat energy, with a fixed-band gap and all paired histories retained. The [original frozen-metric map](odd-cutoff-heat-original-frozen-metric-map.md) identifies that heat profile with a Gamma(3/2) convolution of the original frozen source plus a correction of squared norm at most 5. Its unrestricted squared operator norm is pi/4. Both are independently reviewed written proofs, not Lean theorems. No reverse estimate, observation/process commutation, signed Weil positivity or RH-strength bound is claimed.

The [actual paired-history block sign change](actual-paired-history-block-sign-change.md) proves that every finite compact scattering block with at least two distinct primes has both positive and negative correction atoms at every positive history depth. Unique prime factorization excludes coordinate collisions. The origin coefficient and total mass are distinguished. This independently audited written proof limits measure-sign deductions; it provides no sign or upper bound for the full Weil scalar and no RH conclusion.

## Original frozen-source charge and birth energy

The [density and seed charge cancellation](original-density-seed-charge-cancellation.md) retains the original relative charge, its initial kernel cell and the causal source value at zero. [ChargeArcsinBound](BuildingBlocks/ChargeArcsinBound.lean), [ChargeBirthSummability](BuildingBlocks/ChargeBirthSummability.lean), [ChargeOriginalBirth](BuildingBlocks/ChargeOriginalBirth.lean), [ChargeDensityFubini](BuildingBlocks/ChargeDensityFubini.lean) and [ChargeDensityEvaluation](BuildingBlocks/ChargeDensityEvaluation.lean) formalize the charge inequality, complete Mangoldt summability, actual integer charge, density Fubini and total density evaluation. [ChargeFrozenSource](BuildingBlocks/ChargeFrozenSource.lean) uses the existing complete `CoarsePrimitive.psi` and proves the literal frozen-source decomposition and nonnegative initial charge. Strict positivity and the real-density arcsine identification are separately marked written mathematics.

The [exact frozen-birth work](frozen-birth-exact-original-metric-work.md) is formalized in [ChargeFrozenMetric](BuildingBlocks/ChargeFrozenMetric.lean), [ChargeFrozenBirthMetric](BuildingBlocks/ChargeFrozenBirthMetric.lean) and [ChargeFrozenBirthWork](BuildingBlocks/ChargeFrozenBirthWork.lean). The full norm keeps the terminal square, and every birth keeps its density ramp and complete Mangoldt jump. The [triangular Gram structure](frozen-birth-triangular-gram.md), [ChargeFrozenBirthGram](BuildingBlocks/ChargeFrozenBirthGram.lean) and [ChargeFrozenBirthFiniteGram](BuildingBlocks/ChargeFrozenBirthFiniteGram.lean) give the actual cross integral and finite quadratic for arbitrary real coefficients, with an evaluated diagonal and both signed triangular entries. The positive total does not bound the cumulative all-ones history. Original subpower norm and accumulated-action estimates remain open.

[Frozen-source Fourier integrability](frozen-source-fourier-integrability.md) and [ChargeFrozenIntegrability](BuildingBlocks/ChargeFrozenIntegrability.lean) prove a finite exponential majorant, global L¹ membership of the literal frozen source, and absolute convergence of its angular-frequency Fourier integral. Every natural cutoff is covered. [ChargeFrozenFourier](BuildingBlocks/ChargeFrozenFourier.lean) proves the [exact Fourier–Mellin formula](frozen-source-exact-fourier-mellin.md) for N ≥ 2, including the actual density integral and seed −1. [ChargeFrozenSpectralBound](BuildingBlocks/ChargeFrozenSpectralBound.lean) and [ChargeFrozenLogMoment](BuildingBlocks/ChargeFrozenLogMoment.lean) prove the [uniform unconditional spectral envelope and actual logarithmic moment](frozen-source-spectral-logarithmic-bound.md). [ChargeFrozenFourierNorm](BuildingBlocks/ChargeFrozenFourierNorm.lean) certifies [global finite-source L² membership, frequency normalization and autocorrelation prerequisites](frozen-source-plancherel-prerequisites.md). [ChargeFrozenPlancherel](BuildingBlocks/ChargeFrozenPlancherel.lean) and [AngularFourierConvolution](BuildingBlocks/AngularFourierConvolution.lean) certify the [exact physical Plancherel identity](frozen-source-exact-plancherel.md), including the full autocorrelation, angular-frequency Jacobian and physical logarithmic-moment bound. Quantitative PNT and the original RH energy estimate remain further obligations.

The [finite paired scattering formalization](paired-scattering-finite-formalization.md) proves the exact actual local coefficients and the uniform half-strip bound in Lean. The [full-zero proof](dyadic-full-zero-sum-transport-proof.md), [large-history repair](dyadic-full-weil-large-history-repair.md), [linear-age transfer](linear-age-full-signed-scattering-transfer.md) and [uniform paired repair](paired-multiplier-uniform-strip-repair.md) retain every actual zero, observing prime power, archimedean term and compact history. Their complete analytic transfer estimates remain written proofs and recover the signed original readout without bounding or signing it.

The [cutoff-clock net work](clocked-cutoff-net-work-dissipation.md) and [actual square-completion defect](actual-source-square-completion-defect.md) retain the full clock on each new source increment and the frozen constant tail. Actual prefix mass forces a mismatch from the unrestricted maximizer and cancels the leading generic cost. The remaining cumulative signed work has no RH-scale upper bound. These are independently reviewed written proofs, not an RH advance or a process/Weil-form identification.


## Native integer births and clocked cumulative history

The [native birth-probe construction](integer-birth-probe-joint-history-and-work-transfer.md) and [independent proof](integer-birth-probe-independent-review.md) give bounded normalized synthesis cost for a compact translated probe and absolutely summable signed-work transport to the established full-factor scalar. [IntegerBirthHistory](BuildingBlocks/IntegerBirthHistory.lean) compiles the exact coefficient telescope, literal cumulative-history successor identity, original psi error reconstruction, logarithmic remainder strictly between zero and one, and boundary-inclusive finite pairing. [IntegerBirthGram](BuildingBlocks/IntegerBirthGram.lean) compiles the literal dv-metric seed Gram 1/max(m,l), product and finite-square integrability, and the complete finite signed-coefficient energy expansion. Analytic approximation, PNT work tails and inverse clock estimates remain written proofs.

The [clocked cofactor average](actual-clocked-cofactor-row-positive-average.md) preserves the actual odd source, complete kernel histories and terminal atom. Its [native history transfer](clocked-cofactor-native-birth-probe-transfer.md) pays the deterministic seed/parity/power correction. The [terminal metric calculation](clocked-native-probe-terminal-metric.md) shows that this exact row probe has squared norm asymptotic G(0)^2 b/s^10 and growing normalized birth synthesis cost of order b/s^5. These written results retain the terminal cancellation; neither positive probe geometry nor the compiled Gram square supplies the missing signed arithmetic upper-work bound. RH and the full analytic Lean formalization remain unfinished.

The [unit terminal-cell readout](native-terminal-unit-probe-exact-error-readout.md) distinguishes frozen and drifting density conventions exactly. Its normalized readout is E(b)/sqrt(b(b+1)), with the drifting convention retaining the explicit logarithmic remainder. Bounded unit readout does not control the unnormalized terminal row. This is independently reviewed written mathematics.

The [growing compact Euler product bound](compact-euler-growing-product-admission-bound.md) gives uniform positive-weight norm and inverse bounds at every fixed depth M>=3. At depth M>=5, a coarse source energy bound pays an absolutely summable dyadic signed archimedean admission error. The depth-two inverse instead grows like log P. These independently reviewed written estimates preserve the complete factors and leave the full signed arithmetic row open; finite arithmetic support is asserted only for compact test packets.

The [finite centered additive heat formalization](finite-centered-additive-heat-formalization.md) compiles the literal Lambda heat source, density cutoff, seed, successor, square membership and complete signed source Gram, with both rectangular Fubini steps and the exact density square. Six Lean modules also certify the classical gamma weight comparison and actual L2 heat-profile continuity. The actual Fourier/Plancherel identification, infinite limits and RH-strength arithmetic bound remain separate obligations.

- [Three narrow windows with global pole-moment carriers](three-window-global-pole-null-weil-bound.md): independently reviewed written Weil positivity on a restricted support family, retaining prime 2, power 4 and all inter-window pole moments; seven scalar budget declarations compiled. No growing-family or RH claim.

- [Global pole constraints and complete binary histories](binary-global-pole-history-extremizer.md), with the [gamma-plus-binary partial-form counterexample](gamma-binary-partial-form-counterexample.md): independently reviewed written constrained extremizers and a failure of a single-place positive completion; all powers of 2 retained, five scalar inputs compiled, full other-place row unestimated.

[Local compact scattering signs](compact-local-scattering-no-contraction.md) compiles both multiplier signs at the original complex-power frequencies for every prime and positive integer depth. The compact pole-null test realization remains written. Uniform local contraction fails; actual-source signed work and full arithmetic cancellation remain unproved.

[Literal physical theta foundation](physical-theta-series-lean-foundation.md) defines the actual full series and compiles all-real pointwise absolute convergence, summand continuity, full-series measurability, and positivity on u ≥ 0. Parity, full-line positivity, exponential moments, the xi transform and the killed ground remain further obligations.

[The direct finite-packet proof](compact-local-scattering-no-contraction.md#exact-finite-physical-construction-avoiding-the-fourier-limit) realizes both local scattering signs without a Fourier test limit. [CompactScatteringPackets](BuildingBlocks/CompactScatteringPackets.lean) compiles support nonoverlap, complete integrated diagonal norm identities and a finite gain threshold. Smooth pole-null bump existence and the exact operator assembly remain written.

[Finite scattering coefficients](BuildingBlocks/CompactScatteringCoefficients.lean) compiles the complete finite-box history stencil, all interior input indices, its exact phase factorization and strict prime-specialized interior gain. The physical translated-operator regrouping is now compiled in [CompactScatteringOperator](BuildingBlocks/CompactScatteringOperator.lean), together with complete norm gain for an explicit finite phase packet under its stated bump support, integrability and positive-mass premises.

[Theta seed differential foundation](physical-theta-seed-differential-foundation.md) compiles both real Gaussian-seed derivatives, the exact per-term quarter-shifted identity, pointwise seed and curvature summability, and scalar sum reconstruction. Subsequent modules below prove infinite derivative interchange and actual theta parity.

[Actual theta derivative interchange](physical-theta-local-derivative-interchange.md) compiles summable local bounds, both infinite-series differentiations and the genuine seed-sum differential identity. It also proves continuity of the literal theta series on every real input. The subsequent Poisson module proves parity; moments and the killed-ground construction remain unfinished.

[True theta parity via Gaussian Poisson summation](physical-theta-true-poisson-parity.md), compiled in [PhysicalThetaParity.lean](BuildingBlocks/PhysicalThetaParity.lean), proves the exact integer Gaussian dictionary, actual derivative parity, literal Phi evenness and strict positivity on the full real line. Exponential moments, the xi transform, the actual killed-ground equation and arithmetic residual smallness remain unfinished.
[Narrow pole-null carrier](narrow-pole-null-scattering-carrier.md) constructs a smooth compact nonzero carrier with both pole moments zero, and integrates its positive square mass with the complete finite prime scattering gain theorem. The regularity module also proves smoothness, compact support and both pole cancellations for the assembled finite sum.

[Actual theta exponential moments](physical-theta-exponential-moments.md), compiled in [PhysicalThetaMoments.lean](BuildingBlocks/PhysicalThetaMoments.lean), proves integrability of exp(beta |u|) Phi(u) for every fixed real beta from a literal Gaussian bound. It also proves bounded measurable multiplier and exterior-indicator consumers. This closes the moment-integrability prerequisite listed above; actual killed-ground construction, boundedness, the full ground equation, xi identification and arithmetic residual smallness remain unfinished.
[Growing-prime scattering bounds](growing-prime-scattering-lean-bounds.md) formalizes complete complex-power histories, finite block bounds, interior-gap defect budgets and exact infinite weighted comparisons. Actual zero-weight identification and the signed arithmetic estimate remain separate.
[Literal theta exterior prime convergence](theta-ground-exponential-weak-cross-row.md) now derives the complete prime-overlap convergence for bounded measurable exterior multipliers from actual theta moments, with overlap measurability also proved for continuous exponential tests. Actual ground identification and the signed estimate remain separate.
[Mean-zero kernel metric identity](mean-zero-kernel-metric-identity.md) compiles the exact finite gauge cancellation between the primitive covariance kernel and inverse-Neumann kernel. Its operator-domain interpretation remains separate from the finite algebra and the RH sign problem.

[Literal complete core arrival](physical-ground-complete-core-arrival-foundation.md) compiles the complete prime-arrival series, almost-everywhere absolute convergence and an explicit local bound from the bounded exterior source. It also gives a written direct logarithmic bound for the continuous arrival and full core L2 regularity. The continuous and L2 consumers, actual ground construction and eigenvalue equation remain unformalized. No arithmetic sign or RH conclusion follows.

[Full physical history Mellin weights](full-physical-history-mellin-weights.md) compiles the exact complex Mellin multiplier of the complete physical history, the reflected-conjugate cross weight and finite history compositions. Its infinite-sum consumers retain explicit summability and gap premises. Actual zeta-zero and explicit-formula consumers and the signed arithmetic estimate remain unfinished.

[Physical correlation Mellin and arithmetic cutoff](physical-correlation-mellin-arithmetic-cutoff.md) formalizes the exact reflected-conjugate correlation transform, weighted integrability, full physical-history multiplier and joint finite-translate prime-power cutoff. The infinite arithmetic and explicit-formula consumers and signed estimate remain unfinished.

[Continuous arrival kernel foundation](physical-continuous-arrival-kernel-lean-foundation.md) compiles the literal kernel bounds, its logarithmic boundary primitive and far-tail integrability. The source parameter integral, full core L2 consumer and actual weak-ground equation remain further obligations.

[Complete arithmetic correlation support](complete-arithmetic-correlation-support.md) compiles automatic absolute convergence and a stable cutoff for the full prime-power correlation row from literal compact supports. It includes the full joint finite-translate row and common-cutoff consumers for actual physical histories. The complete explicit formula and signed arithmetic estimate remain unfinished.

[Continuous arrival measurability and squared boundary](physical-arrival-boundary-measurability-lean-foundation.md) compiles source and parameter-integral measurability, squared-logarithm integrability at both core boundaries and the full logarithmic squared majorant. Absolute convergence and the majorant inequality for the actual arrival remain separate consumers.

The [complete arithmetic correlation](complete-arithmetic-correlation-support.md) now exports the full row as the exact prime-power sum and derives a shared prime-power cutoff for original and transformed physical sources. Every exponent and both observing orientations remain.

[Complete prime arrival core regularity](physical-prime-arrival-core-regularity.md) now compiles almost-everywhere strong measurability and actual core L2 membership from the literal bounded exterior source, retaining every prime power and both orientations. The full continuous arrival and weak-ground equation remain separate consumers.

[Actual continuous source interior convergence](physical-continuous-source-interior-convergence.md) now compiles absolute integrability of the literal continuous arrival at every interior core point from a bounded measurable exterior multiplier. This resolves the total-integral convention there. Its quantitative boundary bound, full continuous core L2 consumer and weak-ground equation remain unfinished.

[Actual completed-zeta boundary and xi](actual-completed-zeta-boundary-and-xi.md) compiles gamma normalization, the complete von Mangoldt right-boundary logarithmic derivative and an entire xi with correct pole values and actual positive-half-plane zeta-zero correspondence. Contour limits, multiplicity residues, the full explicit formula and the signed estimate remain unfinished.

[Complete literal core arrival L2](physical-complete-core-arrival-l2-lean.md) now compiles the quantitative boundary bound for the actual continuous integral and L2 membership of its sum with the complete prime arrival on the closed core. This closes the continuous and full-core regularity obligations mentioned above, under the stated bounded measurable multiplier hypotheses. Actual killed-ground construction, its operator equation, the full Weil identity and the arithmetic sign estimate remain unfinished.

[Actual xi multiplicities and local logarithmic derivative](actual-completed-zeta-boundary-and-xi.md) now proves finite actual zero orders, xi/zeta order equality on the positive half-plane away from 1, isolated xi zeros, and the punctured logarithmic-derivative limit with the actual multiplicity. The xi right-boundary formula retains both rational pole corrections and every von Mangoldt term. Global contour limits, infinite residue sums, the full explicit formula and the signed arithmetic estimate remain unfinished.

[Ground-clock mixed commutator cancellation](theta-ground-mixed-commutator-cancellation.md) retains the actual two-path rate defect and both holding rows. Four compiled pointwise identities establish the full algebra and reversal antisymmetry. The real quadratic commutator cancels in the written finite-cutoff operator argument; it cannot pay the conditional residual. Continuum substitutions and operator limits remain unformalized, and the symmetric mixed product remains an unresolved estimate.
