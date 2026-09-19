# Audit of the recent RH claims

Reviewed 19 September 2026. The requested date range starts at 00:00 MYT on 18 September. Its 146 commits through `59750ee` were inventoried alongside the earlier history. The three history reviews record the mathematical findings: [segment 1](history/quality-control-segment-1.md), [segment 2](history/quality-control-segment-2.md), and [segment 3](history/quality-control-segment-3.md).

The review checks the principal changed claims and gives detailed checks for the high-risk operator, displacement, cofactor and catalog statements below. An inventory disposition is not an independent proof of every theorem. All 379 contribution reports received a language scan; 34 received a theorem-level review. Priority remains provisional where no documented source comparison supports it.

## Conditional implications and actual zero exclusion

The theorem `cumulative_zero_free_to_seven_four_six_five` in [RiemannZetaRatioSurplus.lean](../formalization/BuildingBlocks/RiemannZetaRatioSurplus.lean) excludes zeros with real part greater than $1/2$ and $0<t\le1493/200=7.465$. Its statement has no unproved high-frequency evaluator premise. This is a bounded-height Lean result. It does not improve the published mathematical height-verification frontier; [Platt and Trudgian](https://arxiv.org/abs/2004.09765) verified RH up to $3\cdot10^{12}$ using rigorous computation.

The high-frequency and universal Fredholm implications instead take an evaluation system as an argument. Its fields include the decisive growth and balance inequalities. The module proves that those inequalities are incompatible for a positive off-line displacement. It does not construct an arithmetic evaluator satisfying them. See [ChirpedUniversalFredholmExclusion.lean](../formalization/BuildingBlocks/ChirpedUniversalFredholmExclusion.lean).

The zero-classification theorem `riemann_zeta_zero_trichotomy` explicitly takes `h_rh : RiemannHypothesis`. Its unconditional description in the earlier module summary was wrong. The record and equivalence statements in [RiemannZetaMasterGrandUnification.lean](../formalization/BuildingBlocks/RiemannZetaMasterGrandUnification.lean) organize consequences and equivalent conditions; they do not supply RH.

## The displacement normalization and sign

Let $s=\sigma+it$, $d=\sigma-1/2$, and $\Lambda(s)=\pi^{-s/2}\Gamma(s/2)\zeta(s)$. The exact identity is

$$
\Lambda_0(s)=\Lambda(s)-\frac1{s(s-1)}.
$$

For the displacement $D_\sigma(t)=2d\Re\Lambda_0(s)-t\Im\Lambda_0(s)$, this gives

$$
D_\sigma(t)=R(d,s)+2d\Re\Lambda(s)-t\Im\Lambda(s),\qquad
R(d,s)=\frac{2d(1/4-d^2)}{|s(s-1)|^2}.
$$

The [complex-power kernel](../formalization/BuildingBlocks/RiemannZetaTrigonometricDecomposition.lean) is

$$
x^{s/2-1}+x^{(1-s)/2-1}
=2x^{-3/4}\left[\cosh\frac{d\log x}{2}\cos\frac{t\log x}{2}
+i\sinh\frac{d\log x}{2}\sin\frac{t\log x}{2}\right].
$$

The failed numerical calculation used $x^{-1/2}(\theta(x)-1)$ with the hyperbolic bracket instead of $x^{-3/4}(\theta(x)-1)$. At $d=0.2$, this changes the leading coefficient from the correct $+0.084$ to approximately $-1.793336$. The latter concerns a different function and cannot exclude zeta zeros.

For each fixed $1/2<\sigma<1$, [gamma asymptotics](https://dlmf.nist.gov/5.11.E9) and the polynomial zeta bound from [Euler summation](https://dlmf.nist.gov/25.2.E8) give

$$
D_\sigma(t)-R(d,s)
=O_\sigma\!\left(t^{\sigma/2+3/2}e^{-\pi t/4}\right),\qquad
\lim_{t\to\infty}t^4D_\sigma(t)=2d(1/4-d^2)>0.
$$

This is eventual positivity for each fixed real part. It supplies neither a uniform finite threshold nor positivity at every point. Correct-kernel quadrature at $s=0.75+20i$ gives $D\approx-8.75470256\cdot10^{-7}$ while $R\approx5.85023273\cdot10^{-7}$. That computation is a numerical diagnostic checked by quadrature refinement, not a Lean or interval certificate. The displayed asymptotic argument is written mathematics; the exact decomposition is formalized in [RiemannZetaPoleDominanceTheorem.lean](../formalization/BuildingBlocks/RiemannZetaPoleDominanceTheorem.lean).

At a hypothetical zero, $D=R$ exactly. A lemma refuting a zero from $D\le0$ is a valid conditional statement. The failed step was claiming that inequality for the whole high-frequency region.

## Scalar models and analytic objects

- [DualDirichletOfflineDecay.lean](../formalization/BuildingBlocks/DualDirichletOfflineDecay.lean) proves real-exponent identities, thresholds, and monotonicity. It does not formalize a Gamma-factor estimate or a complex Dirichlet-sum bound. A separately justified classical bound for a short dual sum is not a bound for the entire signed zero sum.
- [ActualCofactorSpectralNeutralization.lean](../formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean) defines powers $T^\varepsilon$ and $T^{-\varepsilon}$ and proves that their product is one. The second power is a model for a scale, not the exact modulus of the zeta scattering factor.
- [ChirpedFredholmDeterminant.lean](../formalization/BuildingBlocks/ChirpedFredholmDeterminant.lean) defines a scalar trace difference $L$ and $\exp(-L)$. Its ordinary real logarithm is $-L$. These definitions do not identify a regularized determinant of a constructed operator. The [Carleman module](../formalization/BuildingBlocks/ChirpedCarlemanResolventBound.lean) uses the same scalar framework.

The recent displacement modules also need narrower descriptions. Modules 326–327 prove a pointwise kernel derivative, individual Gaussian-mode signs and an abstract envelope derivative. They do not prove the corresponding improper integration-by-parts theorem, differentiate the theta series, or establish quartic Fourier decay. Module 328 proves scalar mismatch implications and evaluations of proposed derivative expressions at the origin, without the analytic zeta linkage or higher-derivative hypotheses. Module 329 adds a rational residual upper bound; its assumptions still supply the decisive bound on the arbitrary scalar `D_theta`.

The chirped “Brun–Titchmarsh” and Fourier/zero-sum descriptions likewise overstated elementary real-number inequalities as results about arithmetic or integral objects absent from their declarations. Corrected catalog entries now state the actual domains and input bounds.

These algebraic results can be used in a future analytic argument, but their names and summaries must not claim that argument is already proved. The canonical API for the former grand-unification record is now `RHConsequences`, with limited compatibility names for existing imports.

## Literature and priority

The [Suzuki audit](../building-blocks/weil-and-spectral/suzuki-2026-corollary-1-6-limit-domain-audit.md) concerns the convergence domain and normalizing assumptions in Corollary 1.6 of a specific preprint version. It is not a refutation of all spectral-gap or operator-construction results in that paper. Earlier summaries overstated its scope.

Novel mathematical statements, new proofs, and first formalizations require separate comparisons. A module count, a successful build, or an assertion that all literature was searched does not establish any of those priorities. Directory membership is provisional. Preserve attribution and record the actual sources searched, including known prior formalizations when found.
