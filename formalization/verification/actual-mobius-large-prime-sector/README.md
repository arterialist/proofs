# Actual Möbius-square large-prime sector

The [finite module](../../BuildingBlocks/ActualMobiusLargePrimeSector.lean)
uses the existing actual coefficient `ArithmeticFunction.moebius *
ArithmeticFunction.moebius`. It proves the weighted large-prime-sector
bijection and complete complementary partition for every natural cutoff
and every real weight. Prime maximality, uniqueness, quotient coprimality,
the unit and the zero/one cutoffs are included. Nonsquarefree small
cofactors are retained.

The [mathematical note](../../../building-blocks/prime-distribution/signed-largest-prime-mobius-convolution-moments.md)
also gives a written signed largest-prime moment asymptotic and complete
signed cofactor limit for each fixed integer convolution order and each
fixed positive power. PNT, Abel summation, Euler products, dominated
infinite sums and asymptotic passage are not formalized in this module.
The full signed RH estimate remains open.

From the repository root, with its pinned dependencies available, run:

```sh
lake build
lake env lean formalization/verification/ActualMobiusLargePrimeSectorAudit.lean
```

The [audit source](../ActualMobiusLargePrimeSectorAudit.lean) prints the
transitive axioms of sixteen declarations. [acceptance.json](acceptance.json)
binds the checked module and audit source hashes to the root build and
axiom results; [axioms.txt](axioms.txt) contains the exact audit output.
Only `propext`, `Classical.choice` and `Quot.sound` are permitted. The two
weighted identities use exactly those three; two elementary quotient
lemmas use the smaller set `propext`, `Quot.sound`.

These checks cover finite arithmetic. They do not kernel-check the
general-order asymptotics, a cofactor convergence rate, a zero-free strip,
or RH. No effective onset, growing-parameter uniformity or mathematical
priority claim is made.
