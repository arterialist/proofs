# A Brun–Titchmarsh extension of the actual-zeta chirped constellation

**Status:** unconditional written analytic proof, 18 September 2026.
The finite Hermitian row-bound implication is
[Lean-compiled](../../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean);
the Brun–Titchmarsh input, the weighted prime-power estimate, the
correlation bound, and the complete explicit-formula assembly are written
mathematics. This improves the
[critical-span theorem](chirped-critical-span-constellation.md) by
`2 log log T` in support span. It is a result for a structured,
`T`-dependent subspace, not an RH proof or a pointwise prime-phase
cancellation estimate. No literature-priority claim is made.

Keep the fixed profile `a`, width `0<w<log 2`, chirp parameter
`0<eta<1/(8w)`, and pole-null packet

\[
q_T(x)=\frac{(\partial_x^2-1/4)
                 \{a(x)e^{i\eta T x^2-iTx}\}}
               {\|(\partial_x^2-1/4)
                 \{a(x)e^{i\eta T x^2-iTx}\}\|_2}
\tag{1}
\]

from that theorem. The complete actual-zeta Weil form `Q` is normalized
as in its [exact geometric formula](actual-signed-annulus-bump-gram.md#exact-prime-orientation-and-analytic-remainder).

**Theorem.** Given `0<epsilon<1`, there are fixed constants
`B=B(a,w,eta,epsilon)>0` and `T_0` such that, for `T>=T_0`, every
ordered center set satisfying

\[
0\le x_1<\cdots<x_M\le
D_T:=2\log T+2\log\log T-B,
\qquad x_{j+1}-x_j>w,
\tag{2}
\]

and every complex coefficient vector satisfy

\[
\boxed{\quad
Q\left(\sum_{j=1}^M c_j\tau_{x_j}q_T\right)
\ge(1-\epsilon)\log T\sum_{j=1}^M|c_j|^2.
\quad}
\tag{3}
\]

The statement includes every `Lambda(p^k)=log p`, both poles, the
archimedean term, and exact support endpoints. It is uniform in the
center set; `M=O_w(log T)` is allowed.
For any fixed real `A`, the same argument gives the sharper additive
margin `Q(f)>=(log T-C_A) sum_j |c_j|^2` whenever the centers span at
most `2 log T+A` and `T` is sufficiently large. The row estimate below
is then `O_A(1)`.

## Short-interval mass with all prime powers

We use [Montgomery and Vaughan's arbitrary-interval Brun–Titchmarsh
bound, equation (1.12)](https://personal.science.psu.edu/rcv4/personal/Publications/large_sieve.pdf):
for every real `u>0` and `h>1`, with the usual prime-counting function,

\[
\pi(u+h)-\pi(u)
<\frac{2h}{\log h}.
\tag{4}
\]

The only range needed below is

\[
T^{3/2}\le N\le e^w T^2(\log T)^2,
\qquad u\asymp_w N,
\qquad N/T\le h\ll_w N.
\tag{5}
\]

For large `T`, `h>=T^{1/2}` and `log(u+h)=O_w(log T)`, while
`log h>=\tfrac12 log T`. Thus (4), weighting each prime by at most
`log(u+h)`, bounds the ordinary-prime contribution to
`psi(u+h)-psi(u)` by `O_w(h)`.

For higher powers, each exponent `k>=2` gives at most

\[
(u+h)^{1/k}-u^{1/k}+1
\le \frac{h}{k u^{1-1/k}}+1
\ll_w h/\sqrt N+1
\]

possible integer bases. There are `O(log N)` exponents because every
base is at least two, and each von Mangoldt weight is at most
`log(u+h)=O_w(log N)`. Their **complete** contribution is therefore

\[
O_w\bigl((h/\sqrt N+1)(\log N)^2\bigr)=O_w(h),
\]

uniformly in (5): `h>=T^{1/2}` absorbs the logarithms. Consequently

\[
\boxed{\quad \psi(u+h)-\psi(u)\le C_w h
\quad}\tag{6}
\]

for all intervals in (5). No prime power is discarded. The inclusive
versus half-open endpoint convention costs at most `O(log N)`, also
absorbed by `h>=T^{1/2}`.

## Improved complete prime row

The packet autocorrelation satisfies, for every integer `m>=1`,

\[
|C_T(y)|\le C_m(1+T|y|)^{-m},
\qquad C_T(y)=\int q_T(x+y)\overline{q_T(x)}\,dx,
\tag{7}
\]

as proved in the preceding theorem. For a pair of centers separated by
`d>w`, put `N=e^d`. The exact oriented cross is the finite sum

\[
P_T(d)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                  C_T(\log n-d).
\tag{8}
\]

Suppose first that `d>=\tfrac32 log T`. On its support,
`e^{-w}N<=n<=e^wN`, and
`|\log(n/N)|\ge e^{-w}|n-N|/N`. Set `H=N/T`.
Split the support into the central interval `|n-N|<=H` and the
dyadic shells `2^rH<|n-N|<=2^{r+1}H`. Each side of a nonempty shell
is contained in an interval of length at most `2^rH` (enlarge an
endpoint fragment to that length). Its left endpoint is comparable
to `N`, and its length is at least `H`. By (6), the complete Mangoldt
mass in the central interval is `O_w(H)`, and that in the `r`th
shell is `O_w(2^rH)`. Since `n^{-1/2}\ll_w N^{-1/2}`, (7), with any
fixed `m>1`, gives

\[
|P_T(d)|\ll_{a,w,\eta}
\frac{H}{\sqrt N}\left(1+\sum_{r\ge0}2^{r(1-m)}\right)
\ll_{a,w,\eta}\frac{e^{d/2}}{T}.
\tag{9}
\]

For `d<=\tfrac32 log T`, the elementary complete-prime lattice bound
from the preceding theorem remains valid:

\[
|P_T(d)|\ll_{a,w,\eta}(d+w)
       \left(e^{-d/2}+e^{d/2}/T\right).
\tag{10}
\]

Fix a row of the Gram matrix. The center gaps exceed `w`, so each
distance shell of width `w` has at most two other centers. Summing
(10) over distances below `\tfrac32 log T` gives `O(1)`: the
increasing part is at most
`O((log T)T^{-1/4})=o(1)`. Summing (9) in reverse
geometric shells up to `D_T` gives

\[
\boxed{\quad
\sup_j\sum_{k\ne j}|P_T(|x_k-x_j|)|
\le C_0+C_1e^{D_T/2}/T
=C_0+C_1e^{-B/2}\log T.
\quad}\tag{11}
\]

The constants do not depend on the number or positions of the centers.

## Complete-form assembly and limit

The differential factor in (1) annihilates both pole transforms
exactly. The gamma multiplier contributes at least
`(log(T/(2pi))-C-o(1)) sum_j |c_j|^2`: the packet Fourier transform
is rapidly small outside `[T/4,2T]`, and the disjoint translates have
`L^2` norm squared exactly `sum_j |c_j|^2`. The off-band remainder is
uniform because `M=O(log T)`. All of these estimates are unchanged
from the preceding theorem, since (2) is still `O(log T)` long.

The prime quadratic form is
`-2 Re sum_(j<k) c_k overline(c_j) P_T(x_k-x_j)`.
The row estimate (11), or the
[Lean-checked finite Hermitian inequality](../../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean),
bounds it below by the negative of the right side of (11) times
`sum_j |c_j|^2`. Choose `B` so that `C_1 e^{-B/2}<epsilon/2`,
then take `T` large enough to absorb `C_0`, the fixed gamma constant,
and `log(2pi)` into `epsilon log T/2`. This proves (3).

The extra `2 log log T` is the full scale obtainable from this
absolute short-interval row estimate while the diagonal gamma margin
is `~log T`: at the new endpoint, `e^{D_T/2}/T` itself has order
`log T`. The result still signs only the specified chirped packet
subspace. Its nominal Fourier loading at a hypothetical zero
ordinate `gamma=T` is rapidly small, so (3) does not exclude a
selected off-line zero.

This remains true if the carrier is retuned to make a chosen ordinate
stationary. For a fixed `0<delta<1/2`, define
`F_±(gamma,delta;f)=int f(x)e^(i gamma x ± delta x) dx`.
The quadratic phase has second derivative `2 eta T`, so the
second-derivative oscillatory-integral bound gives
`|F_±(gamma,delta;q_T)|=O_delta(T^(-1/2))`, uniformly in real
`gamma`. Cauchy–Schwarz and the center gaps in (2) then give, for
`f=sum_j c_j tau_(x_j) q_T`,

\[
|F_+(\gamma,\delta;f)F_-(\gamma,\delta;f)|
\ll_{\delta,w} T^{-1}e^{\delta D_T}\sum_j|c_j|^2
=O_{\delta,w}\!\left(
 T^{2\delta-1}(\log T)^{2\delta}\right)\sum_j|c_j|^2
=o(1)\sum_j|c_j|^2.
\tag{12}
\]

Indeed, the squared geometric sums of translation factors are
`sum_j e^(2 delta x_j) <<_(delta,w) e^(2 delta D_T)` and
`sum_j e^(-2 delta x_j) <<_(delta,w) 1`. Thus even a selected
off-line pair of transform values is too small on this family to
challenge the `~log T` Gram margin. A different signed arithmetic
estimate, rather than further absolute counting at this span, is
needed to reach that mode.

An [exact endpoint conservation identity](chirped-prime-cross-endpoint-conservation.md)
does give an `O(T^-1)` signed integral of `e^(-d/2)P_T(d)` over every
separation interval. Its pole-null cancellation is global in `d` and
does not replace the pointwise row estimate used above.
