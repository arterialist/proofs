# Uniform sampled-to-continuous Green norm control

This proves the sampling component for the aggregated profiles in the proposed simultaneous expansion. It retains every breakpoint `y=d`; derivatives are used only on the open pieces and all jumps are paid through total variation.

Put

\[
 A=\sum_{d\ge1}\frac{e^{-d}}d=-\log(1-e^{-1}).
\]

For the literal Green row,

\[
 G_d(y)=\frac1{2d}\begin{cases}e^{y-2d},&y\le d,\\e^{-y},&y>d,
 \end{cases}
\]

one has

\[
 \|G_d\|_\infty\le\frac{e^{-d}}{2d},\qquad
 \|G_d'\|_1
 =\frac{2e^{-d}-e^{-2d}}{2d}\le\frac{e^{-d}}d.
\tag{1}
\]

`G_d` is continuous at `d`; its derivative changes sign there. For every divisor packet, including arbitrary Möbius signs,

\[
 \|F_P\|_\infty\le A/2,\qquad
 \operatorname{Var}(F_P)\le A.
\tag{2}
\]

For

\[
 J_d(y)=e^y\int_{\max(1,y/d)}^\infty e^{-2dv}\log v\,dv,
\]

use `log v<=v` for `v>=1`. This gives

\[
 0\le J_d(y)\le
 \begin{cases}
 \dfrac34d^{-1}e^{y-2d},&y\le d,\\
 \dfrac{2y+1}{4d^2}e^{-y},&y>d.
 \end{cases}
\tag{3}
\]

On the second interval Leibniz' rule retains the moving-boundary term:

\[
 J_d'(y)=J_d(y)-\frac{e^{-y}}d\log(y/d),
\tag{4}
\]

whereas `J_d'=J_d` below `d`. The boundary term vanishes at `y=d`, so no derivative atom is lost. Equations (3)--(4) imply the deliberately loose common bounds

\[
 \|J_d\|_\infty\le\frac34\frac{e^{-d}}d,qquad
 \|J_d\|_1\le2\frac{e^{-d}}d,qquad
 \|J_d'\|_1\le4\frac{e^{-d}}d.
\tag{5}
\]

Thus, uniformly over all `P`,

\[
 \|J_P\|_\infty\le3A/4,quad
 \|J_P\|_1\le2A,quad
 \operatorname{Var}(J_P)\le4A.
\tag{6}
\]

The product variation inequality now gives

\[
 \operatorname{Var}(F_P^2)\le A^2,qquad
 \operatorname{Var}(J_P^2)\le6A^2,qquad
 \operatorname{Var}(F_PJ_P)\le\frac{11}{4}A^2.
\tag{7}
\]

All constants come from the complete integer envelope, so restricting to `d|P#` cannot enlarge them.

For any integrable bounded-variation function `f` on `(0,infinity)` and `h>0`, comparison on each cell `((j-1)h,jh]` gives the exact rectangle estimate

\[
 \left|h\sum_{j\ge1}f(jh)-\int_0^\infty f(y)dy\right|
 \le h\operatorname{Var}(f).
\tag{8}
\]

Take `h=1/X`. Since

\[
 0\le2h-(1-e^{-2h})\le2h^2,
\]

we obtain

\[
 \left|(1-e^{-2/X})\sum_{j\ge1}f(j/X)-2\int_0^\infty f\right|
 \le\frac2X\left(\operatorname{Var}(f)+\|f\|_1\right).
\tag{9}
\]

Using (2), (5)--(7), and Cauchy--Schwarz where needed, (9) is `O(1/X)` with one absolute constant for each of `F_P²`, `J_P²`, and `F_PJ_P`, uniformly in `P`. This proves the sampled-norm and sampled-cross-term assertion, including every derivative breakpoint.

The previously proved pointwise majorant `sum_d Q_d(y)<=2(1+y²)e^{-y}` directly supplies the same uniform sampling control for the second-log remainder without differentiating it.

This result does not address the arithmetic approximation of the finite rough-prime row by `-G_d+J_d/log X`. The zero-free-region PNT remainder and the integer moving-ceiling discrepancy are separate. `FiniteSamplingErrorAlgebra.lean` formalizes the finite rectangle-error summation consumer; passage to the infinite BV integral uses standard real analysis and is recorded here with explicit variation budgets.
