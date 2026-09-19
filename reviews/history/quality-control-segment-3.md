# Quality control of published history, segment 3

**Baseline:** `356d968c7ac34a23113d6fe0a5e10217cef4316c`

**Scope:** the 329 commits from `f639a5857324f7b8ceca2b2bc9fc92ba822a6e79` through `356d968c7ac34a23113d6fe0a5e10217cef4316c`

Every assigned commit received an inventory disposition, and the ignored
coverage ledger contains exactly 329 entries. The theorem-level audit followed
the substantive mathematical changes into the files present at the baseline and
checked the external sources used by the main analytic arguments. That second
step was a targeted review of the claims each commit introduced; it was not a
line-by-line independent proof of every descendant note. This public note records
the findings that affect the mathematical status of the repository.

## Proper-cofactor dual reduction

Commit `17002b68731a` introduced
[`actual-proper-cofactor-dirichlet-dual-cancellation.md`](../../building-blocks/weil-and-spectral/actual-proper-cofactor-dirichlet-dual-cancellation.md)
as an unconditional resolution of the fixed-cofactor barrier. That conclusion
did not follow from the displayed calculation.

The exact dilation identity
$$
  \int_0^\infty x^{\rho-1}g_N(kx)\,dx
  =k^{-\rho}\int_0^\infty u^{\rho-1}g_N(u)\,du
$$
is valid. Applying the approximate functional equation at one zero also gives a
valid dual-polynomial identity. Neither step estimates the dual polynomial after
it is summed over zeros. The note also lacked uniform control of the explicit
formula, complementary zero ranges, cutoff, cofactor-tail, and interchange
remainders. Consequently its
equation (13) did not have the claimed `O(T^{-δ/2})` error, and it did not prove
an `O(log T)` bound for the complete Weil form.

Two supporting statements were also wrong as written. For fixed `δ > 0`,
`T^δ` eventually exceeds `log T`, so the dual polynomial is not asymptotically
sub-logarithmic. Its exact cutoff is
`y_ρ = |Im ρ|/(2πK)`, which depends on the zero; `|Im ρ| ≍ T` gives only
`y_ρ ≍ T^δ`, not the equality printed in the original zero sum. The general
approximate-functional-equation error has exponent
$$
  T^{1/2-\beta-\delta(1-\beta)},
$$
not merely `T^{-δ(1-β)}` when `β < 1/2`. The original citation to Titchmarsh,
Theorem 4.13, also omitted that theorem's logarithm in the first error term. The
log-free form used here is equation (4.12.4), justified in Theorem 4.15 of
[Titchmarsh's *The Theory of the Riemann Zeta-Function*](https://sites.math.rutgers.edu/~zeilberg/EM18/TitchmarshZeta.pdf).

The corrected note now presents the calculation as an incomplete reduction,
uses an unspecified remainder `R(T)` in the assembled formula, gives the
critical-strip error with its full exponent, and lists the analytic estimates
still needed. This leaves the separate fixed-cofactor barrier open. A subsequent arithmetic cutoff transfer in the linked note bounds the combined prime row and cofactor head; it does not validate the discarded spectral remainder or isolate the prime row.

## Bellotti 2025 source dependency

Commits `6c7142e`, `3a32f0be`, and `41a391af` used the posted 2025 Bellotti
preprint to obtain an
epsilon-free near-edge zero-density estimate and prime-number-theorem constant.
Its proof used
$$
  (\psi*\theta*1)(n)=(\psi*1)(n)(\theta*1)(n),
$$
which confuses Dirichlet convolution with pointwise multiplication. At a prime
`p < min(U,W)`, the two sides already differ. This invalidates the displayed
proof of the cited lemma and leaves its downstream endpoint claims unestablished;
it does not prove those claims false.

The defect is historical at this baseline. Commits `3a983e01`, `6f82e87b`, and
`a2a1732b` removed the disputed dependency and replaced it with Bellotti's 2024
zero-free region, Ingham's density estimate, and Johnston's PNT transfer. The
current repository claims retain an arbitrary fixed epsilon loss and no audited
baseline theorem in this segment depends on the disputed convolution step.

## Conditional Lean bridges and model algebra

The Lean sources added from `DualDirichletOfflineDecay` through the chirped and
Fredholm bridge families generally prove their formal statements, but many are
scalar models or conditional implications rather than analytic bounds for the
Riemann zeta function. For example:

- `DualDirichletOfflineDecay` proves algebra for proposed real exponents. It
  defines no zeta zero, scattering factor, or Dirichlet polynomial.
- `ActualCofactorSpectralNeutralization` defines `scatteringModulus ε T` to be
  `T ^ (-ε)`. Its exact cancellation theorem is therefore a power identity, not
  an exact evaluation of the Riemann scattering multiplier.
- `ChirpedSpectralRHBridge` obtains RH from `h_carrier`, which assumes that every
  right-half zero supplies a configuration containing the required spectral
  upper bound.
- `ChirpedMasterSpectralVanishingBridge` assumes the spectral bound, arithmetic
  lower bound, their Weil identity, and a witness producing the whole system for
  every putative zero.

These are valid ways to formalize reductions. Descriptions such as
"unconditional power suppression," "exact spectral neutralization," and
"end-to-end RH deduction" conceal the hypotheses that contain the unresolved
analysis. The related catalog and module-comment corrections are coordinated in
the repository-wide review so that this segment audit does not overwrite work
assigned to parallel reviewers.

## Verification and limits

The audit reproduced the segment's interval-arithmetic ramp certificates and
checked the principal literature inputs for the repaired Vinogradov--Korobov
bounds, arbitrary-height explicit formula, short-interval prime estimates,
Brun--Titchmarsh bound, Robert--Sargos derivative estimate, and uniform Landau
formula. Exact finite Lean modules were distinguished from the written analytic
arguments they support. These mathematical corrections are additive changes.

This review establishes the status of the claims above and records whether each
assigned commit remains represented at the baseline. It is not a claim that all
written analysis in the 329-commit segment has been independently formalized.
