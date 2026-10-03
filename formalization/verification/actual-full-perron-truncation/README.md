# Actual full-numerator Perron truncation verification

The [native module](../../BuildingBlocks/ActualFullPerronTruncation.lean) proves the finite-height error inequality in [the truncation note](../../../building-blocks/prime-distribution/actual-full-perron-truncation-bound.md). For every real \(c>2,x>0,T>0\),
\[
\left\|N_{\rm full}(x)-\frac1{2\pi}\int_{-T}^{T}
\operatorname{perronKernel}(c,x,t)dt\right\|
\le\frac{x^c\operatorname{verticalAllowance}(c-1)}{\pi T}.
\]
The primary declaration is `ActualFullPerronTruncation.fullNumerator_truncation_error_le_of_pos`; `fullNumerator_truncation_error_le` specializes it to \(T\ge1\). Both statements retain the literal existing `ActualFullCenteredMellin.fullNumerator`, its actual `perronKernel` and allowance. There is no supplied upper, growth, unknown-zero, integrability or inversion premise.

Generic auxiliaries prove the complete complement identity, null-endpoint interval conversion and two-tail integral bound. The actual assembly uses the existing native inversion, absolute convergence and pointwise majorant, proves its allowance nonnegative and retains the exact scalar \(1/(2\pi)\). The negative and positive tails each cost \(1/T\); the resulting coefficient is \(1/\pi\).

The code is a role-neutral copy of the separately accepted private proof, with unchanged statements and proof bodies after namespace renames. Independent comparisons of the complete source, mathematical normalization and scope passed. The final source passed the required full repository build, with 8,052 jobs.

The [audit](../ActualFullPerronTruncationAudit.lean) covers all 26 public theorems in the module, including generic interval/tail helpers and both actual target ranges. Every declaration reports exactly `[propext, Classical.choice, Quot.sound]`, with no custom axiom or placeholder. [axioms.txt](axioms.txt) preserves the completed raw transcript; [acceptance.json](acceptance.json) binds its hash, the source, toolchain, documentation and actual inverse dependency.

The pinned analytic input is [Mathlib's improper-integral library](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/SpecialFunctions/ImproperIntegrals.lean). The actual inverse and vertical majorant are separately verified in [the full Mellin inverse record](../actual-full-centered-mellin-inversion/README.md). The runtime is Lean4.24.0, compiler797c613eb9b6d4ec95db23e3e00af9ac6657f24b, with Mathlib f897ebcf72cd16f89ab4577d0c826cd14afaafc7. Run from the repository root:

```sh
lake build
lake env lean formalization/verification/ActualFullPerronTruncationAudit.lean
```

The bound holds at every real positive cutoff and height; it has no eventual onset. \(T=0\) and \(c=2\) are excluded. No uniform allowance as \(c\downarrow2\), novelty, stronger prime-error rate, eventual sign or RH conclusion is claimed. This is quantitative approximation support. The existing global contour upper remains written and unformalized; its stronger arithmetic/RH obligations remain open.
