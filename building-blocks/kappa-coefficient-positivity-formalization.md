# Formalization of the kernel coefficient

[`KappaCoefficientPositivity.lean`](BuildingBlocks/KappaCoefficientPositivity.lean) defines

\[
\kappa_m=m\log m-(2m+1)\log(m+1)+(m+1)\log(m+2)
\]

for natural `m`, using Mathlib's `log 0 = 0`, hence the intended `0 log 0 = 0` convention. It proves `kappa 0 = log 2` and `0 < kappa m` for every natural `m`.

The proof is not an assumed positivity premise. Set

\[
\tau(x)=x(\log(x+1)-\log x).
\]

Lean verifies

\[
\tau'(x)=\log(x+1)-\log x-\frac1{x+1}>0\qquad(x>0),
\]

where strict positivity follows from Mathlib's strict inequality
`log y < y-1` applied to `y=x/(x+1)`. Thus `tau` is strictly increasing on `(0,∞)`. Direct ring algebra gives

\[
\kappa_m=\tau(m+1)-\tau(m).
\]

The endpoint `m=0` is checked separately and all positive indices follow from strict monotonicity.

The same identity yields the exact finite telescoping formula

\[
\sum_{m=0}^{N}\kappa_m
=(N+1)\log\frac{N+2}{N+1}.
\]

Using Mathlib's proved limit for `x log(1+1/x)`, the module also certifies

\[
\sum_{m=0}^{\infty}\kappa_m=1
\]

as `HasSum kappa 1`.

The module compiles in the local `proofs` environment. Printed axiom reports contain only `propext`, `Classical.choice`, and `Quot.sound`; there is no `sorryAx` and no new axiom.
