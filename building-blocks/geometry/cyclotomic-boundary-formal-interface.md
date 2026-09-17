# A conditional formal interface for cyclotomic boundary estimates

This Lean package formalizes finite cyclotomic products, actual reduced rational phases, clipped derivative deficits and a conditional two-boundary reduction. The complete geometric and angular inputs are explicit theorem parameters. The package does not formalize the full written angular theorem or an interior cancellation estimate.

Let $F_N=\prod_{k=1}^N\Phi_k$, with the ordinary cyclotomic polynomials. At a primitive root $\alpha$ of conductor $n\le N$, the factors with $k\ne n$ do not vanish; hence the root is simple. For $n<N$,

```math
\log|F_N'(\alpha)|=\log|F_{N-1}'(\alpha)|+\log|\Phi_N(\alpha)|.
```

The clipped deficit is $[-\log|F_N'(\alpha)|]_+$. Its change has absolute value at most $|\log|\Phi_N(\alpha)||$. These facts are formalized in [CyclotomicPrefix](../../formalization/BuildingBlocks/CyclotomicPrefix.lean) and [CyclotomicOldFactor](../../formalization/BuildingBlocks/CyclotomicOldFactor.lean).

The old-factor estimate uses the explicit premise `OldFactorRegularizedIdentity`: the Möbius sum for $\log|\Phi_N(\alpha)|$ replaces a vanishing chord term by its radial finite part $\log d$ when $n\mid d$. `ActualOldFactorIdentities X` requires this identity for every relevant label up to $X$. It is not discharged by this extraction. [CyclotomicDivisorPairs](../../formalization/BuildingBlocks/CyclotomicDivisorPairs.lean) supplies finite divisor-pair algebra.

The modules [CyclotomicFareyBasic](../../formalization/BuildingBlocks/CyclotomicFareyBasic.lean), [CyclotomicFareyEndpoints](../../formalization/BuildingBlocks/CyclotomicFareyEndpoints.lean) and [CyclotomicFareyPartition](../../formalization/BuildingBlocks/CyclotomicFareyPartition.lean) define actual reduced phases and positive cyclic gaps, including the conductor-one endpoint. The hypotheses `FareyNeighborEnumeration` and `FareyGapPartition N` supply the enumeration and full cyclic partition. The mass and boundary consequences are proved in [CyclotomicFareyMass](../../formalization/BuildingBlocks/CyclotomicFareyMass.lean), [CyclotomicFareyBounds](../../formalization/BuildingBlocks/CyclotomicFareyBounds.lean) and [CyclotomicFareyGeometry](../../formalization/BuildingBlocks/CyclotomicFareyGeometry.lean). In particular the selected small-conductor and recent-conductor masses obey the stated bounds once those inputs hold.

Write $H_X=\sum_{n=1}^X1/n$. The resulting theorem in [CyclotomicBoundaryBridge](../../formalization/BuildingBlocks/CyclotomicBoundaryBridge.lean) is, for integer $X\ge1$,

```math
|O_{\rm controlled}(X)|\le2\sqrt X\log X\,H_X(1+3H_X),
```

provided `ActualOldFactorIdentities X`, `FareyNeighborEnumeration` and `FareyGapPartition N` for $3\le N\le X$ are supplied. It treats conductors $n\le\lfloor\sqrt X\rfloor$ and recent conductors $N-n\le\sqrt N$; the partition in [CyclotomicInteraction](../../formalization/BuildingBlocks/CyclotomicInteraction.lean) counts their union without duplication. The signed remaining interaction is retained exactly. [CyclotomicBoundarySums](../../formalization/BuildingBlocks/CyclotomicBoundarySums.lean) proves the finite harmonic estimates used in this bound.

Finally, `AngularConsumerInequality X` is the additional premise

```math
B_X\le O_X+\frac12\log X(1+\log X)^3,
```

where $B_X$ is the actual Farey-weighted clipped deficit. With it, `weightedDeficit_le_interior_of_angularConsumer` proves

```math
B_X\le O_{\rm interior}(X)
+2\sqrt X\log X\,H_X(1+3H_X)
+\frac12\log X(1+\log X)^3.
```

The theorem neither supplies its angular premise nor bounds $O_{\rm interior}$. The value of this interface is to preserve the exact labels, endpoints, clipping and pending hypotheses in the formal argument.

The classical ingredients are the cyclotomic product and Möbius identities, elementary Farey geometry and harmonic summation; see [Bzdęga–Herrera-Poyatos–Moree, preliminary cyclotomic identities](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf) for the cyclotomic background and [the written angular-boundary theorem](../analytic-methods/angular-height-boundary.md) for the analytic consumer. All linked extracted modules compile with Lean 4.24.0 and the pinned mathlib. No originality, first-formalization or full-RH claim is made.
