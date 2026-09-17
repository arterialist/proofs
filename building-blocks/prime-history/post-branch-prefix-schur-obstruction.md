# Post-branch prefix Schur comparison

## Result

Let

\[
 A_{X,p}(u,v)={1\over2}\left(
 \Delta_1\Delta_2\mathcal K_{X,p}(u,v)+
 \Delta_1\Delta_2\mathcal K_{X,p}(v,u)\right),\qquad 1\le u,v<D,
\]

where `D=(p^-)#` and `mathcal K` is the studied main-plus-endpoint kernel,
consisting of the main mixed row and max-based endpoint quadratic.  The double-Abel
remainder is the quadratic form of `A` on the primorial-divisor prefix

\[
 M_D(u)=\sum_{n\le u}\mu(n)1_{n\mid D}.                            \tag{1}
\]

On a positive weighted prefix space with diagonal weight matrix `W`, the
sharp finite operator constant is

\[
 C_{\rm op}(W)=\|W^{-1/2}AW^{-1/2}\|_{\rm op}.                    \tag{2}
\]

The absolute Schur constant is

\[
 C_{\rm Sch}(W)=
 \max_u {1\over\sqrt{w_u}}
 \sum_v {|A(u,v)|\over\sqrt{w_v}},                                \tag{3}
\]

and `C_op<=C_Sch`.  For the centered-consumer weight `w_u=1/X` on
`1<=u<X`, this becomes

\[
 C_{\rm op}=X\|A_{<X}\|_{\rm op},\qquad
 C_{\rm Sch}=X\max_{u<X}\sum_{v<X}|A(u,v)|.                       \tag{4}
\]

Formula (4) is the sharp finite operator comparison on the common truncated
space.  It does not compare the full post-branch form with the centered
consumer, because that consumer has zero weight for every `u>=X` while (1)
runs through `u<D`.

## Exact cutoff obstruction

The centered complete-admission consumer is

\[
 \mathfrak C_X={1\over X}\sum_{n<X}M(n)^2,
 \qquad M(n)=\sum_{k\le n}\mu(k).                                 \tag{5}
\]

Treating (5) as a quadratic seminorm on a vector indexed by `1<=n<D`, its
nullspace contains every coordinate supported at `n>=X`.  Therefore, if
`A(j,j) != 0` for one such `j`, then no finite `C` can satisfy

\[
 |x^{\mathsf T}Ax|\le {C\over X}\sum_{n<X}x_n^2                  \tag{6}
\]

for all prefix vectors: take `x=t e_j`.  The left side is
`t^2|A(j,j)|`, while the right side is zero.  This is an infinite norm,
not merely a Schur estimate that grows too quickly.

The smallest nondegenerate kernel already has this obstruction.  At

\[
 p=5,\quad D=6,\quad X=2,\quad q=e^{-1},\quad L=\log2,
\]

the rational interval certificate proves

\[
\begin{aligned}
 A(1,1)&\in
 [0.00117164056413210,0.00117164056413212],\\
 A(2,2)&\in
 [0.00000634286504474,0.00000634286504475].                       \tag{7}
\end{aligned}
\]

The common block `n<X` consists only of `n=1`, so both constants in (4)
are exactly

\[
 2A(1,1)\in
 [0.00234328112826420,0.00234328112826424].                        \tag{8}
\]

Thus the truncated norm is small in this one finite example, but the full
norm relative to (5) is already infinite because of `A(2,2)>0`.  No decay
claim follows from (8).

## The two Mertens prefixes are different

The vector in (1) is not the ordinary Mertens vector in (5).  They agree
only below the next admitted prime:

\[
 M_D(n)=M(n)\qquad(1\le n<p),                                    \tag{9}
\]

because every squarefree integer below `p` uses only primes dividing `D`,
while nonsquarefree integers have zero Möbius coefficient.  Past `p`, the
ordinary prefix includes squarefree integers having a prime factor at least
`p`, and the primorial-divisor prefix omits them.

For the example above,

\[
 (M_D(1),\ldots,M_D(5))=(1,0,-1,-1,-1),
\]

whereas

\[
 (M(1),\ldots,M(5))=(1,0,-1,-1,-2).                              \tag{10}
\]

The coordinate family used to disprove (6) is an operator test, not a claim
that arbitrary coordinate vectors occur as actual arithmetic prefixes.
Transferring the actual quadratic form to (5) would require a separate
arithmetic map from `M_D` to the ordinary `M`; the equality (9) supplies
only the short initial block.  Neither the Schur inequality nor the current
Möbius identities provide that map.

## Formal finite scope

[PostBranchPrefixSchurFinite.lean](../../formalization/BuildingBlocks/PostBranchPrefixSchurFinite.lean)
proves the finite absolute row-and-column Schur bound, evaluates a coordinate
quadratic form, and proves that a nonzero tail diagonal excludes every finite
cutoff-energy bound.  The transcendental signs and intervals in (7)--(8) are
certified by
[post_branch_kernel_p5_x2.py](../../formalization/verification/post_branch_kernel_p5_x2.py)
using rational enclosures for `e^(-1)` and `log 2`.

The result is an obstruction to this operator comparison.  It gives no
asymptotic estimate for the actual primorial-prefix vector, no wider
prime-admission sign transfer, and no RH conclusion.
