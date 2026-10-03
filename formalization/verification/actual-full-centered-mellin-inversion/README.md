# Actual full-numerator inverse Mellin verification

The [native module](../../BuildingBlocks/ActualFullCenteredMellinInversion.lean) proves inverse Mellin and absolute Perron reconstruction of the actual full numerator in [the complete bound](../../../building-blocks/prime-distribution/complete-prime-error-exact-log-vk-bound.md). This is identity and convergence coverage, with no new arithmetic upper or RH conclusion.

For every real \(c>2\) and \(x>0\), `ActualFullCenteredMellinInversion.mellinInv_fullNumerator` proves
\[
\operatorname{mellinInv}(-c)(\operatorname{mellin}N_{\rm full})(x)=N_{\rm full}(x).
\]
`fullNumerator_eq_closed_perron` proves
\[
N_{\rm full}(x)=\frac1{2\pi}\int_{\mathbb R}x^{c+it}
\frac{\zeta(c+it-1/2)}{(c+it)(c+it-1)}
\left[\frac1{c+it-2}+\frac{\zeta'}{\zeta}(c+it-1)+1\right]^2dt.
\]
`integrable_closed_perron` separately proves absolute integrability. The exact \(t\mapsto-t\) reparameterization and the real scalar \(1/(2\pi)\) are checked.

The numerator is the existing literal finite Mangoldt/convolution row, with the baseline constant, every proper prime power, square-root cofactor and real floor retained. Global continuity is proved by locally fixed finite sums whose new birth terms are zero; it includes \(x=1\) and every integer. Ordinary actual Dirichlet-series convergence supplies the forward Mellin and vertical premises. The module proves the full transformed factor is bounded by \(K_\sigma/(1+t^2)\) for \(\sigma>1\), with \(K_\sigma\) defined by convergent absolute Dirichlet-series masses. No uniform allowance as \(\sigma\downarrow1\) is claimed.

The final actual reconstruction theorems require only the stated \(c>2,x>0\) domain. They have no caller hypothesis for continuity, an unknown zero, an arithmetic upper, vertical integrability or an inversion evaluator. Generic auxiliary series lemmas retain their natural summability hypotheses; those are discharged for the actual target.

The pinned primary analytic theorem is [Mathlib's `mellin_inversion`](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/MellinInversion.lean#L88), by Lawrence Wu, derived there from Fourier inversion. The runtime is Lean 4.24.0, compiler commit797c613eb9b6d4ec95db23e3e00af9ac6657f24b, with Mathlib f897ebcf72cd16f89ab4577d0c826cd14afaafc7. Run from the repository root:

```sh
lake build
lake env lean formalization/verification/ActualFullCenteredMellinInversionAudit.lean
```

The private producer check and separate mathematical/source reviews passed. The role-neutral public module then passed the full repository build and an independent root audit of all 32 public theorem declarations. Every row is exactly `[propext, Classical.choice, Quot.sound]`; the new companion has no placeholders or custom axioms. [axioms.txt](axioms.txt) preserves the raw transcript, and [acceptance.json](acceptance.json) binds its explicit path and hash to the source and toolchain. Separate peer review reconstructed the actual premises and checked the private source/evidence without recompiling.

This closes initial inversion for the complete \(a=1\) numerator only. The \(a=0\) literal Eq22 residual identification/inversion, zero-avoiding contour, zero-free and density input applications, exact-log saddle and same-prime asymptotic retain their stated written status. The existing complete upper is proved in written analysis and remains unformalized; the stronger fixed-power estimate and eventual signed RH premise remain open. No boundary \(c=2\), contour shift, novelty or RH proof is claimed.
