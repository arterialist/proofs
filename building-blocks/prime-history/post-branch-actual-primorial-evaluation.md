# Actual primorial-prefix evaluation of the post-branch kernel

The finite operator obstruction in the companion Schur audit uses arbitrary
vectors.  Here the vector is the actual primorial-divisor Möbius prefix.  Its
first admissible stages excite the post-cutoff region, and their combined
quadratic values are positive, but these finite signs do not estimate a
growing prime stage.

Let `p` be the admitted prime, `D=(p^-)#`, `1<X<D`, `q=e^(-2/X)`, and
`L=log X`.  For `e,a|D`, set `d=pe`, `m(n,d)=min(n,Xd)`, and define the
polynomial form

\[
 H_{X,q}(d,n)=
 {q^{n+Xd-m(n,d)}-q^{n+Xd}+(1-q)(n-m(n,d))q^n\over2d}.        \tag{1}
\]

It equals the sampled kernel in the post-branch reduction because
`q^(Xd)=e^(-2d)`.  The max-based endpoint covariance is

\[
 G_q(x,y)=q^{\max(x,y)}-q^{x+y}.                                   \tag{2}
\]

All ordered divisor orientations are present in the exact finite sum

\[
\boxed{\begin{aligned}
 R_{X,p}^{G}={}&
 2{L\over X}\sum_{e,a\mid D}\mu(e)\mu(a)
       \bigl[H_{X,q}(pe,a)-H_{X,q}(pe,pa)\bigr]\\
 &+\left({L\over X}\right)^2
 \sum_{e,a\mid D}\mu(e)\mu(a)
       \bigl[G_q(pe,pa)-2G_q(e,pa)\bigr].
\end{aligned}}                                                     \tag{3}
\]

Thus (3) is a pair of rational polynomials in `q`, multiplied by `L/X`
and `(L/X)^2`.  With

\[
 c_D(n)=\mu(n)1_{n\mid D},\qquad
 M_D(u)=\sum_{n\le u}c_D(n),
\]

the full divisor sum vanishes at its terminal prefix.  Finite double Abel
therefore gives the independently checkable identity

\[
 R_{X,p}^{G}=
 \sum_{1\le u,v<D}M_D(u)M_D(v)
 \Delta_1\Delta_2\mathcal K_{X,p}(u,v),                           \tag{4}
\]

where `mathcal K` is exactly the ordered kernel in (3).  No orientation or
endpoint is dropped.

## Certified first stages

The [rational interval runner](../../formalization/verification/post_branch_actual_primorial.py)
enumerates squarefree divisors with their Möbius signs, builds the two
polynomials in (3), bounds `q=e^(-2/X)` by alternating-series rational
partial sums, and bounds `log X` by the positive atanh series after binary
range reduction.  It certifies strict positivity at every displayed stage:

| `p` | `D` | admissible `X` | enclosed value, displayed midpoint |
|---:|---:|:---|:---|
| 5 | 6 | 2, 3, 4, 5 | 0.002119014, 0.010343612, 0.017379959, 0.020518810 |
| 7 | 30 | 2, 3, 4, 5, 6, 10 | 0.000356575, 0.003664730, 0.008993580, 0.013230611, 0.015591417, 0.017214939 |

The decimals are display values; strict signs are asserted against exact
`Fraction` intervals.  At `p=5` the same runner evaluates the actual prefix
form (4) independently and splits it into `u,v<X` (head), one index on
each side (cross), and `u,v>=X` (tail):

| `X` | head | cross | tail |
|---:|---:|---:|---:|
| 2 | 0.001171640564 | 0.000947333048 | 0.000000040219 |
| 3 | 0.006759029353 | 0.003577070299 | 0.000007512680 |
| 4 | 0.011150329515 | 0.006223286799 | 0.000006342871 |
| 5 | 0.012325579101 | 0.008188800484 | 0.000004430137 |

Each of these twelve block signs is separately certified positive.  In
particular, at `X=2` the actual vector is

\[
 (M_6(1),\ldots,M_6(5))=(1,0,-1,-1,-1),                         \tag{5}
\]

and the cutoff tail is nonzero.  Its contribution is small but strictly
positive, and its cross with the head is substantially larger.  The
cutoff-tail region therefore participates in the actual packet in this
example, though the universal infinite-norm argument cannot be substituted
for an estimate of the actual packet.

The ordinary Mertens prefix differs from (5) at `n=5`, where it is `-2`.
The two prefixes agree only for `n<p`; neither the certified signs nor (4)
compare the actual post-branch form to the centered consumer
`X^(-1) sum_(n<X) M(n)^2` at growing `p`.

[PostBranchActualPrimorialFinite.lean](../../formalization/BuildingBlocks/PostBranchActualPrimorialFinite.lean)
uses Mathlib's actual Möbius function to prove all six `D=6` coefficients,
the terminal-zero prefix (5), and the exact double-Abel formula for an
arbitrary kernel.  The strict analytic signs are the separate rational
interval certificate.  The studied kernel is the main mixed row plus the
max-based endpoint quadratic; additional `J`, second-log, PNT, lower-atom,
and rough-source rows are not included.  No asymptotic sign, range
extension, or RH claim follows from these finite evaluations.
