# Actual zeta Weil formula: convention adapter

This standalone Lean package exposes the actual-zeta explicit formula from
[Anthropic's zeta23 formalization](https://github.com/anthropics/formal-math/tree/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23)
in minus-Fourier and bilateral-Laplace conventions. It supplies identities and
convergence facts, not a new inequality or an RH proof.

The mathematical source is Levent Alpöge and Ralph Furman's [*More than two
thirds of the zeta zeros are simple and on the critical line*](https://arxiv.org/abs/2608.13637).
The upstream project attributes its Lean code to Claude (Anthropic), with the
paper authors directing and reviewing the formalization and Eric Easley
orchestrating it. This package adds a separately authored convention adapter;
it copies no upstream implementation files.

The dependency is pinned to commit
`fbdc36bbf17d20af3fd0447c6d1a8a02773c9844`, with Lean `4.33.0-rc2` and Mathlib
`51e6992efd06126df61a496bebf8f49482a4e129`. This package has its own toolchain;
the main repository remains on Lean 4.24. The upstream sources are fetched by
Lake from the `zeta23` subdirectory and are not vendored here.

## Formula and range

Put

\[
 H_f(z)=\int_{\mathbb R}f(u)e^{-izu}\,du,\qquad
 L_f(w)=\int_{\mathbb R}f(u)e^{wu}\,du.
\]

For every complex-valued compactly supported \(C^2\) test \(k\), the package
proves the complete formula

\[
\begin{aligned}
 \sum_\rho m_\rho L_k(\rho-\tfrac12)
 ={}&L_k(\tfrac12)+L_k(-\tfrac12)\\
 &-\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       \bigl(k(\log n)+k(-\log n)\bigr)\\
 &+\frac1{2\pi}\int_{\mathbb R}L_k(ir)
       \left(\operatorname{Re}\psi_\Gamma(\tfrac14+ir/2)-\log\pi\right)dr.
\end{aligned}
\]

The zeros and multiplicities are those of Mathlib's `riemannZeta` and
`analyticOrderAt`, with \(0<\operatorname{Re}\rho<1\). Both pole contributions,
the complete digamma bracket, and every actual prime power are retained.
The zero sum is absolutely convergent. Separate theorems establish
integrability of the gamma term and summability of the finite prime row.

For arbitrary complex compact \(C^2\) functions \(f,g\), the same formula
applies to \(k=f*\widetilde g\), where
\(\widetilde g(u)=\overline{g(-u)}\). Its zero-side summand is

\[
 m_\rho L_f(\rho-\tfrac12)
       \overline{L_g(\tfrac12-\overline\rho)}.
\]

The reflected conjugate argument is essential off the critical line; this is
not an absolute square there. For the minus transform the frequency is
\(-\gamma_\rho\), with \(\gamma_\rho=(\rho-1/2)/i\). The adapter proves these
sign changes explicitly.

The localized pair-density theorem additionally takes \(L>0\) and both
supports in \([-L/2,L/2]\). It includes absolute convergence of the zero sum
and integrability of the transform-weighted complete-density integrand
\(L_f(ir)\overline{L_g(ir)}\nu_{e^L}(r)\).

## API

All declarations are in namespace `ActualWeil`, in [ActualWeil.lean](ActualWeil.lean).

| Declaration | Checked statement |
| --- | --- |
| `actual_carrier`, `actual_multiplicity` | Literal Mathlib zero set and analytic multiplicity |
| `minusTransform_eq_source`, `bilateralLaplace_eq_source` | Exact transform dictionaries |
| `actual_explicit_formula`, `actual_laplace_explicit_formula` | Complete single-test formula and absolute zero-sum convergence |
| `actual_hermitian_explicit_formula`, `actual_laplace_hermitian_formula` | Full complex Hermitian pair formula |
| `integrable_gamma_source`, `integrable_gamma_minus`, `integrable_gamma_laplace` | Explicit gamma-integral convergence |
| `summable_prime_row` | Finite arithmetic row for a compact test |
| `actual_laplace_pair_density` | Complete localized density identity and convergence |

The actual explicit-formula proof is
[WeilEF/Main.lean](https://github.com/anthropics/formal-math/blob/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23/Zeta23/WeilEF/Main.lean).
The complex convolution and density normalization come from
[ExplicitFormula.lean](https://github.com/anthropics/formal-math/blob/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23/Zeta23/ExplicitFormula.lean)
and [ExplicitFormula/Bridge.lean](https://github.com/anthropics/formal-math/blob/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23/Zeta23/ExplicitFormula/Bridge.lean).
The gamma facts used by the convergence helpers are constructed in
[GammaFacts/Complete.lean](https://github.com/anthropics/formal-math/blob/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23/Zeta23/GammaFacts/Complete.lean).

## Build

Run from this standalone directory:

```sh
cd formalization/integrations/anthropic-weil
xargs lake exe cache get < cache-roots.txt
lake build ActualWeil
```

The checked-in `lake-manifest.json` pins Zeta23, Mathlib, and their
transitive dependencies; ordinary builds use those resolved revisions.
Run `lake update` only when intentionally changing dependency pins, then
review the regenerated manifest.

The cache command requests the Mathlib import closure of the three upstream
modules used by this adapter. It is optional if those dependencies will be
built from source. The target is `ActualWeil`; it does not request the
upstream project's default zero-proportion or xi-prime theorem collection.

## Verification and limits

The upstream 59-module source closure was locally built on the exact pin.
Its files were checked bytewise against the pinned repository. The adapter
was checked against those compiled modules, and all nineteen declarations
listed in the [`#print axioms` block](ActualWeil.lean#L320-L338) report only
`propext`, `Classical.choice` and `Quot.sound`. There are no placeholders or
custom axioms in this adapter.

The standalone package configuration was checked with `lake update`, and
`lake env lean ActualWeil.lean` passed from this directory using verified
compiled dependencies. Local cache symlinks are ignored; the public manifest
contains normal pinned Git dependencies. A clean `lake build ActualWeil`
of this new package was not repeated; the commands above reproduce it.

This package does not provide positivity, a trace-moment saving, the full
critical-sign inequality, or `CoarsePrimitiveBound`. It defines generic
spectral sums and arithmetic-side expressions for the explicit formula, but
does not construct the main research route's target-specific `h_spec` and
`h_arith` test maps or prove their bounds. Extensions to noncompact Schwartz
or discontinuous BV tests also require their own arguments.

See [LICENSE](LICENSE) and [NOTICE](NOTICE) for Apache-2.0 licensing and
upstream attribution. The explicit formula is an existing result; this
package is a reusable formal interface to it.
