# Even-only cumulative Goldbach criterion: an exact parity reduction

Let

\[
G(N)=\sum_{\substack{m,n\geq1\\m+n=N}}\Lambda(m)\Lambda(n),\qquad
S(x)=\sum_{N\leq x}G(N),\qquad
S_{\rm even}(x)=\sum_{\substack{N\leq x\\2\mid N}}G(N).
\]

These are **ordered** additive pairs and include every prime power. For a
finite source cutoff `Y`, the same statements hold with both `m,n≤Y` and
the moving conditions stated below. The complete coefficients agree with
the truncated ones at every `N≤Y+1`; hence `Y≥⌊x⌋−1` suffices for the
complete cumulative sum through `x`.

## Exact odd formula and bound

If `N≥3` is odd, precisely one of `m,n` is even. The only even integer
with nonzero von Mangoldt weight is a power `2^k`, `k≥1`, and its weight
is `log 2`. Exchanging the ordered indices gives the **exact** formula

\[
G_Y(N)=2\log2
\sum_{\substack{k\geq1,\ 2^k<N\\2^k\leq Y,\ 1\leq N-2^k\leq Y}}
\Lambda(N-2^k).
\tag{1}
\]

The remaining `Λ(N−2^k)` includes all odd prime powers. Since there are
at most `\log N/\log2` admissible exponents and
`0≤Λ(j)≤\log j≤\log N` for `1≤j<N`, (1) yields the uniform finite bound

\[
0\leq G_Y(N)\leq 2(\log N)^2.
\tag{2}
\]

In particular, for real `x≥3`,

\[
0\leq S(x)-S_{\rm even}(x)
=\sum_{\substack{3\leq N\leq x\\N\ {
m odd}}}G(N)
\leq 2\lfloor x\rfloor(\log x)^2.
\tag{3}
\]

There is no parity-sensitive error hidden here: (3) is an absolute,
unconditional bound, smaller than `x^{3/2+ε}` for every `ε>0`.

## Known converse and derived even-only version

[Bhowmik and Halupczok, Section 4, Theorem 2](https://arxiv.org/pdf/1809.06920)
state the established equivalence between RH and, for every `ε>0`,

\[
\sum_{N\leq x}\bigl(G(N)-J(N)\bigr)
=O_\varepsilon(x^{3/2+\varepsilon}),
\tag{4}
\]

where `J(N)` is the Goldbach singular-series main term (zero at odd
`N`). They also give
`\sum_{N\leq x}J(N)=x^2/2+O(x\log x)`, so (4) is equivalent to

\[
S(x)=x^2/2+O_\varepsilon(x^{3/2+\varepsilon})
\quad\text{for every }\varepsilon>0.
\tag{5}
\]

The analytic converse in (4)–(5) is the cited theorem, **not** a result
of the finite parity algebra. Applying (3) to (5) gives the exact derived
corollary

\[
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
S_{\rm even}(x)=x^2/2+O_\varepsilon(x^{3/2+\varepsilon})
\text{ for every }\varepsilon>0.}
\tag{6}
\]

The quantifier “for every `ε>0`” matters. A single bound at some
larger exponent is not the same criterion. Formula (6) is a parity
rephrasing of the already known full-average theorem; it supplies no
new estimate for its error.

## Relation to the finite heat-shell inequality

The [even-compensation inequality](centered-goldbach-even-compensation.md)
uses **centered** coefficients, an exponential shell kernel, and a
signed upper-cutoff transition. Formula (3) concerns the **uncentered**
cumulative raw coefficients after the source cutoff is complete through
the stated horizon. It cannot discard the heat-shell transition or
turn positivity into an RH-scale upper bound.

The [odd-power Lean module](../../formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean)
proves (1) with the equivalent cutoff condition `2^k≤N` and
`N−2^k∈[1,Y]`, and proves (2) for the actual bounded von Mangoldt
coefficient, uniformly in `Y`. The condition `N−2^k≥1` forces
`2^k<N`, so the displayed form is identical. It builds on the
[adjacent-total module](../../formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean)
and [even-support theorem](../../formalization/BuildingBlocks/GoldbachOddCentering.lean).
The cumulative estimate (3) and analytic equivalence (6) remain
written deductions, not Lean theorems. Public theorem axiom reports
contain only `propext`, `Classical.choice`, and `Quot.sound`.
