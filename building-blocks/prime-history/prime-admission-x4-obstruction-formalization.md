# Formalized finite `X=4` prime-admission obstruction

[`PrimeAdmissionX4Obstruction.lean`](../../formalization/BuildingBlocks/PrimeAdmissionX4Obstruction.lean) imports the existing coefficient-positivity, largest-prime packet, and energy-flux modules. It makes no growing-`X` assertion.

The module certifies:

- `D4=2`, `T4=6`, and the strict bulk is exactly `{3,4,5}`;
- the actual Mathlib Möbius values `μ(3)=-1`, `μ(4)=0`, and `μ(5)=-1`;
- the squarefree bulk is `{3,5}`;
- under the supplied largest labels, both quotient packets are exactly `{1}`;
- the first-stage coefficient is supported at `3`, while the second-stage coefficient is supported at `3,5`;
- for a symmetric Gram `G`, the exact energy expansions are
  `E₀=0`, `E₁=G 3 3`, and
  `E₂=G 3 3 + G 5 5 + 2 G 3 5`;
- hence the first flux is `G 3 3`, the second is
  `G 5 5 + 2 G 3 5`, and the second cross-only flux is `2 G 3 5`.

The analytic input is the explicit structure `PositiveAffineGram4 G`. It requires symmetry on the finite bulk and requires every relevant Gram entry to dominate the retained literal kernel term

\[
\kappa_0\exp(-\max(d,e)/2).
\]

The imported theorem `kappa_pos 0` and positivity of the exponential prove this lower term is strictly positive. The module then proves the first total flux, second total flux, and second cross-only flux are all strictly positive.

This hypothesis records exactly what the full positive affine kernel supplies when its remaining terms are nonnegative. The module does not claim convergence of the infinite affine sum, a uniform estimate, a growing-`X` result, or RH.

Compilation succeeds. Printed theorem axioms contain only `propext`, `Classical.choice`, and `Quot.sound`; there is no `sorryAx`, compiler-trust axiom, or new axiom.
