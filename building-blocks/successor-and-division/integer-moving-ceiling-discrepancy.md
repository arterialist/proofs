# Integer moving-ceiling discrepancy in the simultaneous Green packet

Let `X` be a positive integer, `q=exp(-2/X)`, `j>=1`, and `d>=1`. The actual dilated tail uses

\[
 T_{d,j}=q^{-j/2}\sum_{n\ge\lceil j/d\rceil}c_X(n)q^{dn}.
\]

## 1. The ceiling is exact

Define

\[
 c(j,d)=\begin{cases}0,&j=0,\\1+\lfloor(j-1)/d\rfloor,&j>0.
 \end{cases}
\]

Then

\[
 c(j,d)\le n\quad\Longleftrightarrow\quad j\le dn.
\tag{1}
\]

Thus replacing the ceiling condition by the multiplicative scan `dn>=j` produces no error. `MovingCeilingFiniteAlgebra.lean` proves (1) and equality of the corresponding finite filters.

Since `c_X(n)=mu(n)1_{(n,X#)=1}`, its exact decomposition is

\[
 c_X=\delta_1-1_{\{n>X:\ n\text{ prime}\}}+r_X,
\tag{2}
\]

where `r_X` is supported on composite integers all of whose prime factors exceed `X`. Hence

\[
 \operatorname{supp}(r_X)\subset(X^2,\infty).
\tag{3}
\]

The coefficient `delta_1` is the endpoint profile already split off as `E_{d,j}`. The `r_X` term is the separately retained `X`-rough composite tail; the ceiling manipulation does not absorb or discard it.

## 2. Endpoint convention error

A discrepancy arises only if the closed atomic lower endpoint in the prime Stieltjes sum is replaced by an open endpoint before applying the continuous density. For each face this changes the sum by exactly one possible boundary atom. This exact finite identity is also formalized:

\[
 \sum_{b\le n\le R}f(n)=f(b)+\sum_{b<n\le R}f(n).
\tag{4}
\]

Normalize the possible atom as in the simultaneous profile. With `L=log X` and `y=j/X`, its absolute value is bounded by

\[
 \frac{L}{X}e^y e^{-2d b/X},
 \qquad b=\max(X,c(j,d)).
\tag{5}
\]

Split the complete divisor packet at `d<y`.

If `d<y`, then `db>=j`, so (5) is at most `(L/X)e^{-y}`. There are fewer than `y` positive integer faces, hence their complete absolute contribution is at most

\[
 \frac{L}{X}y e^{-y}.
\tag{6}
\]

If `d>=y`, the rough-prime cutoff controls the endpoint: `b>=X`, so (5) is at most `(L/X)e^{y-2d}`. Summing over all integers rather than only divisors gives

\[
 \frac{L}{X}e^y\sum_{d\ge\lceil y\rceil}e^{-2d}
 \le\frac{L}{X}\frac{e^{-y}}{1-e^{-2}}.
\tag{7}
\]

Therefore the full actual Möbius boundary packet, without using cancellation, satisfies

\[
 |C_X(y)|\le\frac{L}{X}
 \left(y+\frac1{1-e^{-2}}\right)e^{-y}.
\tag{8}
\]

The sampled Green norm of (8) is `O(L/X)` with an absolute constant. Its square and its cross with the uniformly bounded non-endpoint profile change the energy by `O(L/X)`. This is smaller than the proposed `L^3/X` allowance.

The same argument handles whether `X` itself is prime. Because `(n,X#)=1` excludes `n=X`, the lower rough-prime endpoint is open at `X`; switching conventions introduces precisely the single atom already covered by (5)--(8).

## 3. Sawtooth/coboundary test

Writing

\[
 c(j,d)=j/d+\sigma(j/d),\qquad0\le\sigma<1,
\]

exposes a nonlinear sawtooth on the multiplicative scan. For a nonempty admitted prime set,

\[
 \sum_{d\mid P#}\mu(d)=0.
\tag{9}
\]

Consequently any part of the rounding defect that is constant in `d` cancels exactly. This is the zero-frequency component. It matches the role of the coarse Haar root in `CrossHorizonHaarFinite`: constant gauge data lives entirely in the conserved root, while nonconstant Haar coefficients are gauge invariant. Here the Möbius divisor packet kills that constant root by (9).

The remaining function `sigma(j/d)` depends nonlinearly on `d`. It is a mean-zero/detail-type defect after removal of the constant component, but neither the Haar identities nor Möbius inversion gives a favorable bound for its signed correlation with the exponential face weights. An attempted renewal gain therefore stops at a genuine signed sawtooth sum. The absolute estimate (8) already suffices for the simultaneous expansion, so no unproved cancellation is needed or claimed.

## Scope

The moving ceiling and endpoint-convention error are now controlled uniformly over all admitted faces, independently of `P`. The only untouched arithmetic term from (2) is the explicitly isolated `X`-rough composite tail, whose support starts beyond `X²`; its exponential estimate belongs to the separate rough-tail argument. The remaining principal analytic obligation is the uniform zero-free-region PNT remainder after partial summation. No result here addresses natural `P` comparable to `X`.
