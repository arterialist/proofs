# Building blocks

The [arithmetic subject index](arithmetic-subject-index.md) links the cutoff probability, successor/division and phase results to their analytic consumers, with proved and refuted scopes kept explicit.

Results used in the study of prime-counting errors, with their formal verification scope stated individually. No originality or first-formalization claim is made. Throughout, $\gamma$ is the Euler–Mascheroni constant.

## Full cutoff probability and conditional dependence

The [two-history allocation identity](prime-allocation-critical-identity.md) derives the complete arithmetic $W$ from a positive Euler prior with its exact endpoint and continuous density terms. The [prime-score](prime-score-negative-covariance.md) and [density-prime](density-prime-covariance.md) covariance theorems have opposing contributions. Their [combined balance](combined-prime-density-covariance.md) proves leading compensation but leaves the decisive remainder unsigned. An [exact conditioned counterexample](conditional-prime-dependence.md) shows why full-law negative pair covariance does not persist on every prime-revelation branch. These are written proofs, with rational certificates for the stated finite checks, and no Lean formalization claim.

## A formal negative dyadic divisor average

The [renewal and dyadic-average note](division-renewal-dyadic-average.md) proves $\sum_{d=1}^N[\psi(2N/d)-\psi(N/d)-N/d]<-N(3/2-\log4)$ for every integer $N\ge1$. The actual prime-power sum, its factorial identification and the strict margin are formalized in Lean. Distinct written proofs retain the causal renewal, exact dyadic boundary cancellation and signed transfer; none supplies the missing critical two-history sign.

## An actual arithmetic sign sufficient for RH

The [eventual-sign criterion](actual-critical-sign-criterion.md) proves in Lean that eventual nonpositivity of the explicitly defined, complete arithmetic sum $W(x)$ implies full mathlib RiemannHypothesis. Its Mellin identity, Landau theorem, continuation and pole exclusion are proved, including multiple zeros. The eventual sign itself remains unproved.

## Discrete harmonic convolution, regularity and aliasing

The [written proofs](harmonic-convolution.md) give a general cancellation mechanism for the exact integer harmonic operator. Mean-square translation continuity yields a bilinear mean theorem, with spectral conditions allowing continuous and mixed spectra. A separate exponential-variation theorem permits escaping frequencies, while an exact counterexample shows that bounded mean energy and a vanishing primitive alone do not suffice. The arithmetic application retains every dilation and prime power and gives an alternative proof of the known RH-conditional leading term of $W$. Its general lemmas are unconditional; the arithmetic mean-energy input remains unproved. These results are not formalized in Lean.

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

The sequence may depend on $r$. At $N=t^3$, separated tent functions first give a sequence with inverse at least $t^2/64$ for $t\ge256$. The Banach–Steinhaus theorem then yields a fixed sequence for each exponent.

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

The [pole-preserving support flow](signed-support-flow.md) gives a complete smooth parametrization, the exact divisor flux, a first-prime obstruction to scalar differential propagation and a sharp logarithmic finite-step modulus. The [relative determinant calculation](prime-density-relative-determinant.md) continues an independent density reference, identifies the exact trace cost of actual prime discrepancy and proves that unitary mixing cannot reduce that cost. Every regularization retains its required first-order restoration.

## Finite-codimension local Weil extensions

The [local-kernel theorem](local-weil-extension-obstruction.md) proves deficiency indices $(1,1)$ and an $O(T\sqrt{\log T})$ spectral count for every same-space or finite-codimension self-adjoint extension. The prescribed arithmetic kernel requires $\Omega(T\log T)$ surviving poles from classical simple critical-line zeros, so no such extension realizes it. Infinite-codimension realizations and global Weil positivity remain outside this exclusion.

## Prime-support deletion and a central divisor block

The [uniform prime-support theorem](prime-support-removal-asymptotics.md) keeps all prime powers and proves the sharp cost of omitting a fixed amount of lower-prime mass, while negative auxiliary upper-band deletions demonstrate why optimizing support is not the full-support sign criterion. The [central Möbius–divisor estimate](voronoi-mobius-central-block.md) proves $O(L^{19/16}\log^6(2L))$ for one block using classical Voronoï and finite shift estimates. The other divisor blocks and their signed total remain unbounded at the RH scale.

## Reciprocal approximation and elementary prime energy

The [reciprocal quotient-window modules](reciprocal-quotient-windows.md) prove an exact Gram isometry, local coefficient recovery and the failure of any fixed finite coefficient repair under an explicit Mertens oscillation premise. The [prime-energy identities](prime-energy-first-moment.md) retain the terminal square and prove an unconditional bounded signed first moment; the signed drift still needs an upper bound. The [ordered division-rod inequalities](ordered-division-rods.md) bound products by endpoints and total gap, with the strictness and empty-family hypotheses explicit. These are formalized finite tools, not proofs of the missing RH estimates.

## Unitary prime phases

[Unitary prime-phase lift](unitary-prime-phase-lift.md) gives a written joint-spectral extension of half-neighbor rigidity. Finite defect yields a self-adjoint scale generator, an exact spectral energy, and the form domain $\operatorname{Dom}|T|^{1/2}$. The proof allows arbitrary spectral multiplicity and distinguishes concentration on a Borel character set from a topological support assertion. It does not identify the counting isometries or the Weil form with this unitary model.

## Semilocal scattering and signed arithmetic phases

The [scattering subject index](scattering-subject-index.md) connects compact negative parts, exact weighted traces, continuum and rational pole corrections, Brownian signed-tail energy, and the two distinct arithmetic norm estimates. A separate single-observation theorem characterizes RH by a subpower norm bound; that unconditional bound remains open. All results in this group are written analytic proofs.

## Actual successor and product-location cutoffs

The [finite-frequency collection](arithmetic-subject-index.md#actual-finite-frequency-readouts) preserves three distinct full-$W$ approximation methods, with square-root, $3/8$, cube-root and quarter-power frequency scales. It also includes the proof that the actual integrand has both signs and the particular positive dyadic flux. The full arithmetic readout, its density terms, all proper powers and its endpoints are retained; no bound for the remaining signed integral is proved.

The scattering collection also proves the [exact observed growth exponent](zero-abscissa-scattering-growth.md) and constructs [one actual compact pole-null observation](compact-positive-scattering-observation.md) with squared Fourier modulus positive everywhere. The common growth exponent is the unknown zero abscissa minus $1/2$; the theorem does not establish that it vanishes.
