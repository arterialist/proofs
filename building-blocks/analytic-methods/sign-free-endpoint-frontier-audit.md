# R39 sign-free endpoint frontier: audit and finite formalization

## Scope and verdict

The exact endpoint-vector argument does prove a substantially larger **endpoint-only** range than the elementary face count. Let

\[
R=\log X,\qquad s=\log R,\qquad L=\log P,\qquad A=R/L.
\]

For every fixed `0<ρ<1`, the sign-free endpoint contribution tends to zero uniformly when

\[
\boxed{
 \log P\le \rho\,R\frac{W(2s)}{2s},
 \qquad
 P\le X^{\rho W(2\log\log X)/(2\log\log X)}.}
\]

This follows from the exact packet scaling, finite Euler product, and standard PNT with its classical zero-free-region error. It does not use Möbius cancellation.

Two qualifications are necessary.

1. This is a proved sufficient interior range, not a proved maximal sign-free frontier. The clustered-vector obstruction becomes a numerical boundary only after a squarefree smooth-number estimate that the source note does not prove. The exact all-positive Gram sum may also be smaller than its reciprocal-power majorant.
2. Endpoint decay does not establish the full simultaneous discrepancy formula. The second-log envelope, sampled-to-continuous estimate, and moving-ceiling error are now proved separately. The common-constant rough-prime PNT approximation remains open, so the endpoint theorem still cannot be combined with the proposed expansion to obtain a full energy limit.

## Exact finite packet bound

For `q=e^{-2/X}` and one divisor face,

\[
r(d)^2=\|v_d\|^2=q^d-q^{2d}
=e^{-2d/X}(1-e^{-2d/X}).
\]

For a finite set `Q` of admitted primes, unique factorization indexes all divisors of `∏Q` by subsets `A⊆Q`. There are exactly `2^{|Q|}` faces. The uniform estimate `r(d)≤1/2` gives

\[
V_{\rm end}\le \frac14 4^{|Q|}.
\]

After multiplying by the actual energy normalization `R²/X²`, the exact elementary criterion is

\[
|Q|\log4+2s-2R\longrightarrow-\infty.
\]

For `Q={p:p≤P}`, PNT gives the simpler frontier

\[
P<(1/\log2-o(1))R s.
\]

All factors here are fixed: the norm estimate contributes `1/4`, squaring the `2^{π(P)}` face count contributes `4^{π(P)}`, and the normalized energy contributes `R²/X²`.

## Reciprocal-power improvement with constants

Put `z=d/X`. Since

\[
r(d)\le e^{-z}
\]

and `sup_{z>0} z^βe^{-z}=(β/e)^β`, for every `0<β≤1`,

\[
r(d)\le C_\beta(X/d)^\beta,
\qquad C_\beta=(\beta/e)^\beta.
\]

This corrects no constant in the proposal; its displayed `C_β` is valid, and `C_β` stays uniformly bounded when `β→1`.

Finite Minkowski and the exact subset product give

\[
V_{\rm end}
\le C_\beta^2X^{2\beta}
\left(\sum_{d\mid\prod Q}d^{-\beta}\right)^2
=C_\beta^2X^{2\beta}
\prod_{p\in Q}(1+p^{-\beta})^2.
\]

For `Q={p≤P}`, write `β=1-δ` and `y=δL`. Using `log(1+u)≤u`, the logarithm of the normalized upper bound is

\[
\log N_{X,P}
\le 2\log C_\beta-2Ay
+2S(P,\delta)+2s,
\quad
S(P,\delta)=\sum_{p\le P}p^{-1+\delta}.
\]

Uniform PNT partial summation, in the regime used below, yields

\[
S(P,\delta)
=\log L+B_1+I(y)+O(1),
\qquad
I(y)=\int_0^y\frac{e^v-1}{v}\,dv.
\]

The uniformity is legitimate here. The zero-free-region error contributes a bounded integral because `y=O(log A+log log A)=o(sqrt L)` in the frontier range. The term `log L` must be retained.

The exact optimized criterion supplied by this majorant is

\[
\boxed{
A y_A-I(y_A)-\log L-s\longrightarrow+\infty,}
\]

where `y_A>0` solves

\[
\frac{e^{y_A}-1}{y_A}=A.
\]

As `A→∞`,

\[
y_A=\log A+\log\log A+o(1),
\qquad I(y_A)=A(1+o(1)).
\]

Since `log L=s-log A`, a clean sufficient condition is

\[
A\log A>(2+\varepsilon)s.
\]

Solving the leading equality gives

\[
A_0=\frac{2s}{W(2s)},
\qquad
L_0=R\frac{W(2s)}{2s}.
\]

Taking `L≤ρL₀` with fixed `ρ<1` supplies a fixed margin and proves the stated range. Writing only `L∼L₀` is insufficient: the side of approach and the lower-order margin matter.

## Cubical orientation does not improve the norm automatically

For squarefree subset faces the Möbius orientation is `(-1)^{|A|}`. Adding a new prime `p` gives the exact codimension-one pairing

\[
\sum_{A\subseteq Q\cup\{p\}}(-1)^{|A|}v_A
=\sum_{A\subseteq Q}(-1)^{|A|}(v_A-v_{A\cup\{p\}}).
\]

This is a finite-difference identity, not a contraction. For the actual endpoint vectors, pairing a divisor `e` with `pe` leaves the interval `e<j≤pe` supported only by `v_{pe}`. No common boundary value cancels there.

There is also a sharp abstract obstruction: choosing `v_A=(-1)^{|A|}x` makes every oriented summand equal to `x`, so the norm grows like `2^{|Q|}\|x\|`. The Lean module formalizes both the pairing identity and this aligned example. Any improvement from cubical language alone would silently assume orthogonality or a contraction of the face map.

The coefficient-space alternating character has zero scalar mean when `Q` is nonempty, so the obstruction is not literally a constant coefficient in the prime cube. After the face map into the clock Hilbert space, however, the target endpoint packet itself is the root/coarse projection of the signed Hilbert-valued face list. Haar details do not control that root. Dropping it would be exactly the invalid step identified by the earlier finite Haar audit.

## What is formalized

`SignFreeEndpointFrontierFinite.lean` proves:

- the exact powerset/Euler-product identity;
- the weighted Minkowski bound with actual `ArithmeticFunction.moebius` coefficients;
- its squared, externally normalized form;
- the exact `2^{|Q|}` face count and uniform quarter bound;
- the codimension-one oriented cube pairing;
- an aligned-vector theorem showing that orientation alone supplies no cancellation.

The analytic PNT optimization is kept in this report rather than encoded as a finite theorem. The one-face exponential envelope is an explicit hypothesis of the Lean weighted theorem, so no analytic estimate is hidden in a combinatorial declaration.

Lean 4.24 compiles the module without warnings. Every printed theorem depends only on

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorry`, `admit`, or new axiom.
