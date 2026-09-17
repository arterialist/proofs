# Full finite-horizon energy in the admission boundary layer

## Exact coefficient and normalization

Let

\[
 c_X(n)=\mu(n)1_{(n,X^\#)=1},\qquad
 c_{X,P}=\sum_{d\mid P^\#}\mu(d)D_dc_X,
 \qquad q=e^{-2/X}.
\]

Unique factorization gives the literal finite coefficient identity

\[
 \boxed{
 c_{X,P}(n)=\mu(n)
 1_{\{p\mid n:\ P<p\le X\}=\varnothing}.}
\tag{1}
\]

If `n` is nonsquarefree, both sides are zero. Thus every prime power is
retained with its actual Möbius coefficient; no prime-power row is silently
discarded. At full admission `P=X`, (1) becomes `c_(X,X)=mu` exactly.

The original complete energy is

\[
 \mathcal E_X(P)={\log^2X\over X^2}(1-q)
 \sum_{j\ge1}\left|q^{-j/2}
 \sum_{n\ge j}c_{X,P}(n)q^n\right|^2.
\tag{2}
\]

## Full boundary background

Write `R=log X` and suppose `Y_X=X/P` is bounded or polylogarithmic. The
nonendpoint row has normalized profile

\[
 -F_\infty+{1\over R}J_\infty+o(R^{-1}),
\]

while the endpoint crossover note gives normalized profile `K_(Y_X)`. Hence
the complete leading profile is

\[
 B_Y=K_Y-F_\infty.
\tag{3}
\]

Because the sampled measure converges to twice Lebesgue measure, the
unconditional explicit background is

\[
 \boxed{
 Q_{\rm full}(Y)=2\|K_Y-F_\infty\|_2^2
 =\mathcal Q(Y)+E_\infty-4\langle K_Y,F_\infty\rangle.}
\tag{4}
\]

The coefficient `-4` is exact: one factor two is the quadratic cross and
the other is the sampled-measure limit. The first density correction is

\[
 \boxed{{4\over R}\langle K_Y-F_\infty,J_\infty\rangle.}
\tag{5}
\]

It contains the positive endpoint-density cross and the previously found
negative nonendpoint correction:

\[
 {4\over R}\langle K_Y,J_\infty\rangle
 -{4\over R}\langle F_\infty,J_\infty\rangle.
\]

All second-log, PNT, sampling, moving-ceiling, rough-composite, and endpoint
transition errors remain the explicit terms already bounded in the assembly
notes. In particular, uniformly for polylogarithmic `Y_X`,

\[
\mathcal E_X(P)=Q_{\rm full}(Y_X)
 +{4\over R}\langle B_{Y_X},J_\infty\rangle
 +4\langle B_{Y_X},R_{X,Y}\rangle
 +2\|R_{X,Y}\|_2^2+o(R^{-1}).
\tag{6}
\]

Here `R_(X,Y)` is the continuous-normalized centered arithmetic residual;
the factors four and two again come from the sampled-measure limit. This
line is an identity once the already bounded sampling remainder is restored,
not an assertion that the signed cross is small at RH scale.

## Exact full-admission cancellation

At `Y=1`, equation (1) says the complete coefficient is exactly `mu`. The
classical zero-free Mertens estimate makes its normalized Abel-Green row tend
to zero. The endpoint and nonendpoint limits already exist in the same norm,
so

\[
 \boxed{K_1=F_\infty\quad\text{in }L^2(0,\infty).}
\tag{7}
\]

Consequently

\[
 Q_{\rm full}(1)=\mathcal Q(1)+E_\infty
 -4\langle K_1,F_\infty\rangle=0.
\tag{8}
\]

This verifies the plateau cancellation on the entire Green packet, not only
pointwise for `0<y<1`. It also verifies the normalization: substituting
`K_1=F_infinity` into (4) gives `2||F||^2+2||F||^2-4||F||^2=0`.
The density correction (5) vanishes at `Y=1` as well.

## The finite residual and its cross

For a finite weighted packet write

\[
 W=B_Y+R_{X,Y}.
\]

The exact identity is

\[
 \|W\|^2=\|B_Y\|^2
 +2\langle B_Y,R_{X,Y}\rangle+\|R_{X,Y}\|^2.
\tag{9}
\]

Thus the complete scalar energy has an explicit background, but away from
`Y=1` it does not isolate the residual quadratic: the signed linear cross in
(9) can cancel it. Recovering `||R||^2` from a scalar energy difference
requires the cross as separate data. This is an exact obstruction to making
the raw energy difference RH-equivalent for every bounded `Y`.

## Direct criterion for the original full-admission consumer

At `P=X`, define the original normalized tail row

\[
 U_X(j)=q^{-j/2}\sum_{n\ge j}\mu(n)q^n.
\]

Its first value contains the coherent Abel total. Center it using only the
same original consumer:

\[
 \widetilde U_X(j)=U_X(j)-q^{(1-j)/2}U_X(1).
\tag{10}
\]

Since `q^(1/2)U_X(1)=sum_(n>=1)mu(n)q^n`, exact subtraction gives

\[
 \boxed{
 \widetilde U_X(j)=-q^{-j/2}
 \sum_{n<j}\mu(n)q^n.}
\tag{11}
\]

Define the centered complete-admission consumer

\[
 \mathfrak C_X=(1-q)\sum_{j=2}^{X}|\widetilde U_X(j)|^2.
\tag{12}
\]

Finite Abel inversion has uniformly bounded convolution norms on `j<=X`,
so absolute constants give

\[
 \boxed{
 c{1\over X}\sum_{n<X}M(n)^2
 \le\mathfrak C_X\le
 C{1\over X}\sum_{n<X}M(n)^2.}
\tag{13}
\]

Therefore a criterion stated directly in the original complete-admission
row is

\[
 \boxed{
 \mathrm{RH}\quad\Longleftrightarrow\quad
 X^{-1-\delta}\mathfrak C_X\longrightarrow0
 \quad\text{for every }\delta>0.}
\tag{14}
\]

Equivalently, `C_X=O_epsilon(X^(1+epsilon))` for every epsilon. The forward
direction is the standard RH Mertens bound; the reverse direction follows
from (13) by dyadic Cauchy and the Mellin representation of `1/zeta`.

The uncentered scalar `mathcal E_X(X)` is not used as an equivalent criterion:
its coherent Abel total is weighted too weakly at the first clock index.
Centering (10) is essential and is an exact operation on the original
consumer, not an imported auxiliary sequence.

## Adversarial checks and cross-field translations

* **Scattering:** `B_Y` is the coherent background channel and
  `R_(X,Y)` the radiation channel. Measuring only total intensity loses the
  phase-sensitive cross in (9); homodyne-style centering (10) recovers it.
* **Renormalization:** `Q_full(Y)` is a finite counterterm. At `Y=1` it is
  exactly zero after endpoint/nonendpoint matching. Subtracting endpoint
  energy `Q(Y)` alone double-counts the plateau and fails (8).
* **Probability:** the coherent Abel total is a common mode. Raw variance
  around zero is not the fluctuation variance; subtracting the first-clock
  common mode produces (12). Treating the two as equal is falsified by the
  nonzero full-admission endpoint energy.
* **Signal processing:** the endpoint and fixed profile are not orthogonal
  bands. The exact cross is `-4<K_Y,F>`, so a power-spectrum addition rule
  predicts a positive background at `Y=1` where the true leading power is
  zero.

## Lean scope

[FullBoundaryEnergyFinite.lean](../../formalization/BuildingBlocks/FullBoundaryEnergyFinite.lean) proves the exact weighted full-energy
expansion, the factor-four background cross, pointwise coherent plateau
cancellation, the signed density-cross decomposition, recovery of the
residual only after supplying its linear cross, the actual Möbius zero on
nonsquarefree prime powers, and the normalization identity. The exact
tail-minus-total centering and its weighted residual energy are formalized in
[FriableEndpointCrossoverFinite.lean](../../formalization/BuildingBlocks/FriableEndpointCrossoverFinite.lean). No analytic or RH premise is hidden in
these finite theorems.
