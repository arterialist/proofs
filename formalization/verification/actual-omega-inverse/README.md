# Actual omega inverse: verification scope

3 October 2026. The native module constructs the actual Dirichlet inverse of Mathlib's distinct-prime-factor count plus the positive-integer constant-one arithmetic function. Its inverse equation is proved from a well-founded proper-divisor recurrence. No supplied inverse, analytic estimate or probabilistic independence premise is used in the final identities.

The [module](../../BuildingBlocks/ActualOmegaInverse.lean) proves the global inverse and uniqueness, the literal prime-indicator identity for omega, g(1)=1, g(p)=-2 and g(p²)=2 at every prime. It proves g*(unit+primeIndicator)=mu using Mathlib's actual Möbius function. The complete M/G prime-cofactor formula holds for every natural cutoff and every real cutoff; Mathlib's floor identity and the empty x<1 region are paid. The uniqueness theorem alone appropriately assumes that its competing function is another inverse.

All 28 theorem declarations in the module are covered in source order by the [public audit](../ActualOmegaInverseAudit.lean). Each has exactly `propext`, `Classical.choice`, and `Quot.sound`; the [raw output](axioms.txt) and [hash-bound acceptance](acceptance.json) record this. The current root full build passed with 8053 jobs. The public mathematical bodies and statements match the independently compiled private producer after namespace/header changes and moving inspection commands into the audit.

Reproduce from the repository root using the pinned Lean 4.24.0 and Mathlib revision:

```sh
lake build
lake env lean formalization/verification/ActualOmegaInverseAudit.lean
```

The [weighted squarefree and low-length bounds](../../../building-blocks/factorial-and-renewal/ordered-prime-word-squarefree-bound.md), factorial-word identification, positive convolution/factorial integral, infinite tails, convergence abscissae and Kronecker/Rouché auxiliary-pole argument remain written mathematics. Separate agent contexts checked their proofs and primary sources, and the coordinator reconstructed them. The arithmetic leaf does not kernel-check those analytic results. The [source audit](../../../reviews/papers/schmidt-factorial-word-normalization-audit.md) is version-specific and makes no source-wide refutation or priority claim.

No stronger ordinary Mertens, prime-error or complete signed-energy upper, eventual W sign, RH criterion premise or RH conclusion is proved by this bundle.
