# Finite full-kappa slope resummation

[`FullKappaSlopeFinite.lean`](../../formalization/BuildingBlocks/FullKappaSlopeFinite.lean) formalizes the finite algebra from [the full-slope note](../prime-distribution/full-kappa-slope-resummation-and-major-arc-positive-packet.md). It imports the certified coefficient positivity module and does not formalize or assert the later prime-packet asymptotic.

The module defines

\[
g_m=m\log\frac{m}{m+1},\qquad g_0=0,
\]

through the already certified telescoping primitive and proves the displayed logarithmic formula. It then proves

\[
\kappa_m=g_m-g_{m+1}.
\]

For

\[
P(n)=\sum_{m=0}^{n-1}g_m,qquad
H(n)=\sum_{m=1}^n g_m,
\]

Lean proves

\[
H(n)=\log(n!)-n\log(n+1)
=\log\frac{n!}{(n+1)^n}.
\]

The rectangular kernel is defined for all naturals by

\[
K(A,B)=\sum_{a=0}^{A-1}\sum_{b=0}^{B-1}\kappa_{a+b}.
\]

This gives the endpoint conventions `K 0 B = K A 0 = 0` definitionally. Finite telescoping proves the all-natural prefix formula

\[
K(A,B)=P(A)+P(B)-P(A+B).
\]

For `A,B≥1`, conversion from `P` to `H` gives exactly

\[
K(A,B)=H(\min(A,B)-1)+H(\max(A,B)-1)-H(A+B-1).
\]

The module also proves symmetry, strict positivity for every nonempty rectangle, strict increase when appending a row or column to a nonempty opposite side, and weak coordinatewise monotonicity for arbitrary natural endpoints.

Compilation under Lean 4.24 succeeds. Printed axiom reports contain only `propext`, `Classical.choice`, and `Quot.sound`; there is no `sorryAx` or new axiom.
