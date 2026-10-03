# A quantitative Perron truncation bound for the complete numerator

The native companion proves an unconditional finite-height approximation inequality for the literal complete numerator \(N_{\rm full}\) in [the exact-log note](complete-prime-error-exact-log-vk-bound.md). Its domain is every real \(c>2\), \(x>0\), and \(T>0\). It retains the complete arithmetic object and both Perron tails. This is approximation support; it supplies no stronger global prime-error estimate, eventual sign or RH conclusion. No originality claim is made.

Let
\[
H_1(z)=\frac{\zeta(z-1/2)}{z(z-1)}
\left[\frac1{z-2}+\frac{\zeta'}{\zeta}(z-1)+1\right]^2,
\qquad K(c,x,t)=x^{c+it}H_1(c+it).
\]
The existing [native inversion](../../formalization/BuildingBlocks/ActualFullCenteredMellinInversion.lean) identifies \(N_{\rm full}\) with the complete Perron integral and proves its absolute convergence. The numerator is the actual finite Mangoldt/convolution row, including the baseline constant, every proper prime power, ordered pair, real floor and square-root cofactor. It is distinct from the original \(a=0\) residual and from \(W=N_{\rm full}-\Delta\).

For \(\sigma>1\), define the convergent actual absolute masses
\[
Z_\sigma=\sum_{n\ge1}n^{-\sigma-1/2},\qquad
L_\sigma=\sum_{n\ge1}\Lambda(n)n^{-\sigma},\qquad
V(\sigma)=Z_\sigma\left[L_\sigma+1+\frac1{\sigma-1}\right]^2.
\]
The Lean definition `ActualFullCenteredMellinVertical.verticalAllowance` uses the corresponding norms of actual Dirichlet-series terms. Its convergence on this domain follows from ordinary actual series convergence. No allowance uniform as \(\sigma\downarrow1\) is claimed.

**Theorem.** For every real \(c>2\), \(x>0\), and \(T>0\),
\[
\boxed{
\left\|N_{\rm full}(x)-\frac1{2\pi}\int_{-T}^{T}K(c,x,t)\,dt\right\|
\le\frac{x^cV(c-1)}{\pi T}.}
\]
`ActualFullPerronTruncation.fullNumerator_truncation_error_le_of_pos` proves this statement. `fullNumerator_truncation_error_le` specializes it to \(T\ge1\). Both targets have only the stated numeric domain hypotheses; they assume no arithmetic upper, unknown-zero statement, integrability or inversion evaluator.

## Proof

The existing actual factor estimate gives
\[
\|K(c,x,t)\|\le\frac{A}{1+t^2},\qquad
A=x^cV(c-1)\ge0.
\]
The difference between the complete integral and its truncation is exactly the integral over the complement of \([-T,T]\). Null endpoints identify the closed-set integral with the oriented interval integral because \(T>0\). The norm integral inequality keeps the positive scalar \(1/(2\pi)\).

On the positive tail, \((1+t^2)^{-1}\le t^{-2}\) and \(\int_T^\infty t^{-2}dt=1/T\). The negative tail has the same integral. Their disjoint union is the complete complement, so
\[
\int_{|t|>T}\frac{dt}{1+t^2}\le\frac2T.
\]
Multiplying by \(A/(2\pi)\) proves the result. All norm-function restrictions and scalar tail integrals are integrable; these premises and the nonnegative allowance are proved internally.

The elementary tail argument is classical. Its analytic inputs are [Mathlib's improper integrals](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/SpecialFunctions/ImproperIntegrals.lean) and the separately checked actual Mellin inverse. The contribution here is native composition for the complete arithmetic numerator, with explicit parameters and normalization.

## Scope checks and verification

Both tails matter. At \(T=1\), the normalized tail of the generic positive majorant \(A/(1+t^2)\) is \(A/4\), which exceeds the incorrect one-tail allowance \(A/(2\pi)\). This checks the coefficient, not actual zeta zeros.

The restriction \(T>0\) also matters for the actual object. At \(x=3/2\), only the unit cutoff is admitted and
\[
N_{\rm full}(3/2)=\frac98\log(3/2)+\frac5{16}>0.
\]
At \(T=0\) the interval integral vanishes and Lean's totalized reciprocal also makes the proposed right-hand side zero. That extension would be false. No integer-height restriction or eventual cutoff is used in the valid theorem.

The [native module](../../formalization/BuildingBlocks/ActualFullPerronTruncation.lean), [complete audit](../../formalization/verification/ActualFullPerronTruncationAudit.lean), and [verification record](../../formalization/verification/actual-full-perron-truncation/README.md) expose the actual target and its dependencies. Independent mathematical, normalization and source checks passed. The public source passed the full repository build and the complete 26-theorem audit; every declaration uses exactly `propext`, `Classical.choice` and `Quot.sound`. The verification record binds the source, transcript and toolchain hashes.

The inequality permits a certified finite-height approximation on the absolute initial line. The finite integral still requires evaluation or an independent estimate. The existing global contour upper remains proved in written analysis and unformalized. Formalization of the contour argument, critical-scale signed cancellation, the eventual \(W\) premise and RH remain open. No boundary \(c=2\), sharp tail optimality for the actual kernel, new zero-free strip, or RH-progress claim is supplied.
