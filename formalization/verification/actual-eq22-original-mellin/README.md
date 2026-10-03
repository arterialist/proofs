# Original Eq. 22 Mellin verification

The native companion proves the initial Mellin identity and absolute Perron reconstruction of the literal residual in [the Eq. 22 note](../../../building-blocks/prime-distribution/actual-eq22-zero-cluster-bound.md). It closes arithmetic identification and convergence obligations. The analytic upper estimate and eventual signed RH premise remain unproved in Lean.

`ActualEq22OriginalMellin.original` is the complex cast of `ActualVolterraIdentity.Rnum - ActualEq22Residual.Tnum`. It is defined from the original finite arithmetic quantities. `original_eq_forward` identifies it with the independently constructed Mellin readout at every real cutoff, including the empty region below one.

For every real \(x\ge1\), `ActualEq22ArithmeticIdentity.literal_identity` proves
\[
C(x)=N_{\rm full}(x)+2A_{\rm old}(x)+Z(x),
\]
where \(A_{\rm old}\) is the complete square-root cofactor aggregate of
\(\sum_{n\le y}(y-n)\Lambda(n)-(y^2-1)/2\), and \(Z\) is the corresponding aggregate of \(y-1\). The native ordered-pair reassociation retains every proper prime power and same-prime interaction. A generic helper accepts a pair-row identity; `literal_identity` discharges it using `ActualEq22PairDilation.Tnum_eq_Dnum_sub_full_pair`.

For every complex \(s\) with \(\Re s>1\), `hasMellin_original` proves
\[
\operatorname{mellin}C(-s-1)=
\frac{\zeta(s+1/2)}{s(s+1)}
\left[\frac1{s-1}+\frac{\zeta'}{\zeta}(s)\right]^2,
\]
together with its absolute Mellin convergence. For every real \(c>2\) and \(x>0\), `original_eq_closed_perron` proves
\[
C(x)=\frac1{2\pi}\int_{\mathbb R}x^{c+it}
\frac{\zeta(c+it-1/2)}{(c+it)(c+it-1)}
\left[\frac1{c+it-2}+\frac{\zeta'}{\zeta}(c+it-1)\right]^2dt.
\]
`original_closed_perron_integrable` separately proves absolute integrability. The final theorems require only their stated numeric domains. They have no caller premise for an unknown zero, arithmetic upper bound, symbol map, physical identification, continuity, integrability or inversion evaluator.

The five native modules are [pair dilation](../../BuildingBlocks/ActualEq22PairDilation.lean), [forward Mellin](../../BuildingBlocks/ActualEq22ForwardMellin.lean), [arithmetic identification](../../BuildingBlocks/ActualEq22ArithmeticIdentity.lean), [initial inversion](../../BuildingBlocks/ActualEq22MellinInversion.lean), and [the literal original object](../../BuildingBlocks/ActualEq22OriginalMellin.lean). Generic auxiliary premises remain explicit and are discharged in the final actual targets. Global continuity is proved for the aggregate residual; no blanket continuity claim is made for every totalized core at zero.

`original_normalized_eq_closed_perron` replaces `Tnum` by the already native `Tnormalized` for every real \(x\ge1\). The cutoff probability interpretation in the research note has its separate \(x>1\) domain. No inverse theorem at \(x\le0\), boundary \(c=2\), uniform allowance as \(c\downarrow2\), or contour shift is claimed.

The analytic inversion theorem is [Mathlib's `mellin_inversion`](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/MellinInversion.lean#L88), by Lawrence Wu, derived there from Fourier inversion. The companion proves its actual continuity and convergence premises before applying it.

The runtime is Lean 4.24.0, compiler commit `797c613eb9b6d4ec95db23e3e00af9ac6657f24b`, with Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Run from the repository root:

```sh
lake build
lake env lean formalization/verification/ActualEq22OriginalMellinAudit.lean
```

The private bundle passed separate arithmetic, analytic, normalization and scope reviews. Independent public comparisons confirm that all five proof bodies and statements match the accepted originals after namespace and import changes. The final source passed the required full repository build, with 8,051 jobs. Two unused-variable linter warnings in the forward module do not affect the checked declarations.

The [audit source](../ActualEq22OriginalMellinAudit.lean) covers all 79 public theorems in the five modules. The completed root audit reports exactly `[propext, Classical.choice, Quot.sound]` for every declaration, with no custom axiom or placeholder. [axioms.txt](axioms.txt) preserves the raw transcript, and [acceptance.json](acceptance.json) binds the current source, toolchain, documentation and audit hashes. The earlier private audit covered 56 selected declarations; it is not substituted for this complete public audit.

The zero-free and density applications, zero-avoiding contour, exact-log saddle, complete analytic upper and same-prime asymptotic remain written mathematics. The stronger fixed-power bound, eventual complete \(W\) sign, coarse-energy premise and RH remain open. No novelty or RH-frontier claim is made.
