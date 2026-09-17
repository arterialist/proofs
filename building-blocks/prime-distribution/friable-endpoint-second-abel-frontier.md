# Signed endpoint beyond the square-root layer

> **Audit status.** The near-linear extension derived below is a candidate
> theorem awaiting independent audit. It must not be cited as published or
> established outside this scratch branch until that audit accepts the
> uniform PNT, floor-residue, and transition-layer assembly.

## Verdict

The one-logarithm loss in the first friable layer is caused by applying
absolute values before a second Abel summation. It is not an obstruction for
all `P^2 >= X`. Keeping the Möbius signs exposes the zero of `1/zeta(s)` at
`s=1` and recovers the second logarithm as long as `X/P` tends to infinity
fast enough.

With the usual classical zero-free-region estimates, the argument below
proves endpoint decay in the explicit near-linear but still `o(X)` range

\[
 P\le {X\over (\log X)^2\,\exp\{C(\log\log X)^2\}},
\tag{1}
\]

for a sufficiently large absolute `C`. In particular it covers every fixed
range `P<=X^(1-epsilon)`. It does not cover `P` comparable to `X`.

## Exact endpoint consumer

Let

\[
 q=e^{-2/X},\qquad
 E_{X,P}(j)=q^{-j/2}
 \sum_{\substack{d\mid P^\#\\d\ge j}}\mu(d)q^d.
\]

Writing

\[
 M(t,P)=\sum_{\substack{n\le t\\P^+(n)\le P}}\mu(n),
\]

the exact Stieltjes formula, with the literal left prefix, is

\[
 q^{j/2}E_{X,P}(j)
 =-e^{-2j/X}M(j-1,P)
 +{2\over X}\int_j^\infty e^{-2t/X}M(t,P)\,dt.
\tag{2}
\]

The norm remains

\[
 V_{\rm end}=(1-q)\sum_{j\ge1}|E_{X,P}(j)|^2.
\tag{3}
\]

For one divisor face its literal squared norm is
`q^d-q^(2d)`. No diagonal, transition layer, or integer endpoint has been
replaced in (2)--(3).

A useful exact dyadic reduction follows directly from (3). For any integer
cut points `1=J_0<J_1<...<J_K`,

\[
 V_{\rm end}=(1-q)\sum_{k<K}
 \sum_{J_k\le j<J_{k+1}}q^{-j}|S_{X,P}(j)|^2
 +(1-q)\sum_{j\ge J_K}q^{-j}|S_{X,P}(j)|^2,
\tag{4}
\]

where `S=q^(j/2)E`. Formula (2) reduces every block to the same friable
prefix `M(t,P)`. There is no orthogonality between divisor faces; (4) only
splits the `j` indices.

## Exact first-layer Buchstab identity

Suppose `P<t<P^2`. Every squarefree integer at most `t` has at most one
prime factor larger than `P`. Unique factorization therefore gives

\[
 \boxed{
 M(t,P)=M(t)+\sum_{P<p\le t}M(t/p).}
\tag{5}
\]

Equivalently, retaining the floor and the strict lower prime endpoint,

\[
 \boxed{
 M(t,P)=M(t)+
 \sum_{m\le\lfloor t/P\rfloor}\mu(m)
 \{\pi(t/m)-\pi(P)\}.}
\tag{6}
\]

These are finite identities. In (5), `m<t/p<P`, so `p` cannot divide `m`
and every prime factor of `m` is below `p`. This proves the sign in (5).

Applying the classical PNT to (6) leaves the continuous main weight

\[
 f_t(u)=\operatorname{li}(t/u)-\operatorname{li}(P),
 \qquad 1\le u\le t/P.
\]

With `N=floor(t/P)`, the PNT error is exactly

\[
 \sum_{m\le N}\mu(m)E(t/m)-E(P)M(N),\qquad E(v)=\pi(v)-\operatorname{li}(v).
\]

It is bounded by
`O(t(1+log(t/P))e^{-c sqrt(log P)})`. The Abel floor residue is
`M(N)f_t(N)` and is `O(P/log P)` by the mean-value theorem. Neither term is
dropped.

## Where the cited theorem loses a logarithm

If one estimates (5) term by term, then

\[
 \sum_{P<p\le t}|M(t/p)|\ll t/\log P,
\]

which is precisely the first-layer bound in the friable theorem. Rankin
tilting has the same defect: replacing `mu(m)` by `|mu(m)|m^sigma` destroys
the zero-frequency cancellation before the endpoint consumer sees it.

Instead apply Abel summation to the main term in (6). Exactly,

\[
 \sum_{m\le N}\mu(m)f_t(m)
 =M(N)f_t(N)+t\int_1^N{M(u)\over u^2\log(t/u)}\,du.
\tag{7}
\]

Put `R_t=log t` and `Y=t/P`. The exact identity

\[
 {1\over R_t-\log u}
 ={1\over R_t}+{\log u\over R_t(R_t-\log u)}
\tag{8}
\]

separates the lost mode. The first integral is small because

\[
 \int_1^\infty {M(u)\over u^2}\,du=0,
\tag{9}
\]

the boundary value `1/zeta(1)=0`. Thus it equals the negative tail from
`Y` to infinity. The second integral costs one further denominator
`log P`; the zero-free-region estimate for `M(u)` makes
`integral |M(u)| log(u)/u^2 du` finite. Consequently

\[
 |M(t,P)|\ll t\left{
 {1\over(\log t)(\log P)}
 +{e^{-c\sqrt{\log Y}}\over\log t}
 +(1+\log Y)e^{-c\sqrt{\log P}}
 +e^{-c\sqrt{\log t}}
 \right}
\tag{10}
\]

through the literal first layer, with the PNT errors and floor residue
included in the last two terms. For `log P` comparable with `log t`, (10)
recovers `t/log^2 t`.

This also explains the next coefficient: differentiating
`1/zeta(s)=s integral M(u)u^(-s-1)du` at `s=1` gives
`integral M(u)log(u)/u^2 du=-1`. The second-log term is generally present;
the first-log term vanishes.

## Uniform endpoint range

Let `R=log X` and split the first layer at

\[
 U=P H,\qquad H=\exp\{C(\log R)^2\}.
\]

For `t<=U`, retain the one-log friable bound. Its endpoint amplitude is at
most

\[
 O(U/\log P)+O(U^2/(X\log P)).
\tag{11}
\]

Condition (1), after increasing `C`, makes (11) `O(X/R^2)`. Its normalized
initial-block energy is bounded by the square of this amplitude times the
block mass `U/X`; together with the later two-log tail this gives
`O(R^-4+(log P)^-4)`. For `t>=U`,
formula (10) has `Y>=H`, so its zero-mode tail is
`O(t/(R log P))`. For `t>=P^2`, the all-cases two-log friable estimate
supplies `O(t/(log P)^2)`, including every integer transition layer. The tail beyond
`X log X` is paid by the Abel exponential.

Substitution in (2), followed by the exact block sum (4), gives on the later
block

\[
 |E_{X,P}(j)|\ll {X\over (\log P)^2}(1+j/X)e^{-j/X}
\]

outside an initial block whose contribution is already covered by (11).
Therefore

\[
 \boxed{{R^2\over X^2}V_{\rm end}(X,P)
 =O\!\left({R^2\over(\log P)^4}\right)+o(1)=o(1)}
\tag{12}
\]

uniformly in (1), after union with the existing sign-free estimate for
small `P`. Outside the sign-free range, `log P` is much larger than
`sqrt(log X)`, so the displayed term tends to zero. This is the bounded
endpoint theorem. It changes no non-endpoint
consumer and makes no assertion for `P` comparable to `X`.

## Three translations of the lost logarithm

1. **Buchstab renewal.** Equation (5) is the first renewal step. It succeeds
   only when the complete cofactor sum is retained. Bounding each prime face
   separately reproduces `t/log P` and fails.
2. **Mellin coboundary.** Equations (7)--(9) identify the constant kernel as
   an exact coboundary killed by `1/zeta(1)=0`. This survives and yields the
   second logarithm. It stops when `Y=t/P` is too short for the truncated
   zero moment to approximate (9).
3. **Rankin tilt.** A positive tilt controls support but replaces the signed
   moment by an Euler-product majorant. It cannot see (9), so it fails at the
   sign-free Lambert-W frontier and cannot prove (12).
4. **Dyadic/Littlewood--Paley blocks.** Splitting (4) is exact, but declaring
   the blocks or divisor faces orthogonal is false. The endpoint Gram has
   positive off-diagonal entries. Squaring blockwise before (7) again loses
   the cross cancellation and only recovers the one-log bound.

At full admission `P=X`, `Y` is of order one on the Abel-effective scale,
so (9) cannot be approximated by its truncated integral. The known coherent
endpoint mode of size `X/log X` is the exact adversarial witness against all
four attempted extensions to `P` comparable with `X`.

As a finite check, direct evaluation of the exact Gram
`q^max(d,e)-q^(d+e)` over every divisor face gives the normalized endpoint
energies `0.037947` at `(X,P)=(20,19)`, `0.036579` at `(30,29)`, and
`0.042076` at `(40,31)`. These are small computations, not asymptotics, but
they immediately falsify any proposed argument that forces the full-admission
endpoint to vanish merely by Rankin weights or dyadic orthogonality.

## Lean scope

`FriableEndpointCancellationFinite.lean` proves actual-Mobius constant-mode
extraction and cancellation, the cross term retained when two blocks are
squared, exact finite endpoint-energy splitting, the literal
`q^d-q^(2d)` face geometry, and the post-extraction absolute bound. Its
analytic inputs (PNT, zero-free Mertens, (9), and the friable two-log layer)
remain explicitly cited inputs rather than new axioms.
