# Cross-horizon Haar and coarse-mode obstruction: finite Lean report

The module [CrossHorizonHaarFinite.lean](../../formalization/BuildingBlocks/CrossHorizonHaarFinite.lean) proves the exact finite Haar algebra for balanced real packets and then instantiates it with the actual finite Möbius clock. It contains no limiting, asymptotic, or RH assertion.

## Abstract dyadic packet

`DyadicPacket k` is a balanced binary packet with exactly `2^k` real leaves. Its recursively defined quantities are:

- `total`, the sum of all leaves;
- `squareEnergy`, the sum of their squares;
- `haarCoefficients`, every nonconstant unnormalized Haar coefficient, root first;
- `haarDetailEnergy`, the sum of coefficient squares divided by their block lengths;
- `coarseEnergy = total^2 / 2^k`.

The theorem `squareEnergy_eq_coarse_add_haar` proves exactly

\[
\sum_{n=0}^{2^k-1}x_n^2
=\frac{(\sum_nx_n)^2}{2^k}
+\sum_{I\text{ dyadic}}\frac{(\sum_{I_L}x_n-\sum_{I_R}x_n)^2}{|I|}.
\]

All normalizations are built into the recursive definition; there is no appeal to an external orthogonality theorem.

## Gauge invariance and the obstruction

`gaugeShift c` adds the same real number `c` to all leaves. The module proves

```text
haarCoefficients (gaugeShift c p) = haarCoefficients p
haarDetailEnergy (gaugeShift c p) = haarDetailEnergy p
```

while the total changes by exactly `2^k c`. Thus a common cutoff-gauge shift is invisible to every nonconstant coefficient and can only change the root mode.

For two adjacent blocks of length `2^k`, `child_coarse_recursion` proves

\[
C(L)+C(R)=C(L\mathbin\Vert R)
+\frac{(\sum L-\sum R)^2}{2^{k+1}}.
\]

Consequently recursive refinement exposes one new nonnegative detail but carries the parent coarse projection forward unchanged as the remaining root term. `coarse_remainder_conserved` states this directly:

\[
\text{square energy}-\text{all Haar detail energy}=\text{coarse energy}.
\]

The coarse energy is nonnegative and vanishes exactly when the packet sum vanishes. This is the precise finite obstruction: estimates for nonconstant Haar coefficients alone cannot control the block sum.

## Literal Möbius clock specialization

`mobiusClockValue D T N q` is

\[
\sum_{D<d<T,\ d\le N}\mu(d)(1-q^{\lfloor N/d\rfloor}),
\]

using Mathlib's `ArithmeticFunction.moebius`. `mobiusClockPacket D T H k q` packages its values on the literal half-open horizon block

\[
H\le N<H+2^k.
\]

The helper theorem `total_ofSequence` proves the endpoint identification rather than leaving it as a comment. The module then specializes both the exact Haar decomposition and common-gauge invariance to this actual clock packet.

## Compilation and axioms

The module compiles with Lean 4.24 in the repository environment. Every printed theorem has exactly the axiom list

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorry`, `admit`, or new axiom.
