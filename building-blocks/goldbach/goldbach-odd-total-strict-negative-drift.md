# Strict negative cofactor drift at every large odd total

**Status:** unconditional written analytic theorem, 18 September 2026.
The exact finite successor identity is compiled in
[GoldbachCofactorOddStepFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean),
as are the earlier parity support and endpoint lemmas. The
short-interval prime theorem and the limiting inequality below are
not formalized in Lean. This improves the earlier finite upper bound
`Q_(s+1)-Q_s <= 2 log(s+1)` to a strict eventual negative bound at
every even `s`; no literature-priority claim is made.

Write `Lambda` for the actual von Mangoldt function, with
`Lambda(p^j)=log p` for every `j>=1`, and put

\[
\psi(y)=\sum_{m\le y}\Lambda(m),\qquad
q_y=\frac{\psi(y)-y}{y},\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}\quad(s\ge4).
\tag{1}
\]

**Theorem.** Along the even integers,

\[
\boxed{\quad
\limsup_{\substack{s\to\infty\\2\mid s}}
\frac{Q_{s+1}-Q_s}{\log s}
\le \frac{\log2}{2}-\frac{127}{300}<0.
\quad}                                                    \tag{2}
\]

The constant is about `-0.07676`. In particular, every fixed
`0<c<127/300-(log 2)/2` satisfies
`Q_(s+1)-Q_s <= -c log s` for all sufficiently large even `s`.
The proved input beyond elementary arithmetic is the unconditional
uniform prime theorem in intervals of length
`x^(17/30+epsilon)` from [Guth and Maynard, Corollary 1.3](https://arxiv.org/html/2405.20552).
No hypothesis about zeros is used.

## Exact step and the parity budget

Set `n=s+1`, so `n` is odd. The compiled finite identities give

\[
\begin{split}
Q_{s+1}-Q_s={}&\Lambda(n-2)q_2\\
 &+\sum_{h=3}^{n-2}\Lambda(n-h)
 \left(\frac{\Lambda(h)}h-
       \frac{\psi(h-1)}{(h-1)h}\right),\\
q_2={}&\frac{\log2-2}{2}<0.
\end{split}                                                 \tag{3}
\]

The first term is nonpositive. Every term in the second, Chebyshev
part has a nonpositive sign, because `Lambda>=0` and `psi>=0`.
Since `n` is odd, an even `h` has an odd complement `n-h`, while an
odd `h` has an even complement. The positive prime-power terms on
even `h` satisfy the exact geometric budget

\[
\sum_{\substack{4\le h\le n-2\\2\mid h}}
 \frac{\Lambda(n-h)\Lambda(h)}h
 \le(\log n)(\log2)\sum_{k\ge2}2^{-k}
 =\frac{\log2}{2}\log n.                             \tag{4}
\]

Here an even prime power is `2^k`. The starting exponent is `k=2`
because `h>=3`; the `h=2` contribution is the retained, negative
endpoint in (3). No odd prime power is discarded.

For odd `h`, the complement `n-h` can carry a nonzero Mangoldt
weight only when it is `2^k`. These remaining positive terms obey

\[
\sum_{\substack{3\le h\le n-2\\2\nmid h}}
 \frac{\Lambda(n-h)\Lambda(h)}h
 \le \log2\sum_{\substack{2^k\le n-3\\k\ge1}}
       \frac{\Lambda(n-2^k)}{n-2^k}
 \le\frac{\log2}{e}+O\!\left(\frac{\log^2 n}{n}\right).
\tag{5}
\]

Indeed, the powers `2^k<=n/2` leave a denominator at least `n/2`;
there are `O(log n)` of them. The interval `(n/2,n)` contains at
most one power of two, and `Lambda(h)/h<=log h/h<=1/e` for its
remaining `h>=3`.

## A negative mass that beats the budget

Fix any `17/30<theta<99/100`. Let
`a=n^theta` and `b=n^(99/100)/2`. For large `n`, these satisfy
`3<a<b<n-2`. Guth and Maynard's theorem, applied backward from
`n` with interval length `u in [a,b]`, gives uniformly

\[
A_n(u):=\sum_{0<h\le u}\Lambda(n-h)=u(1+o(1)).      \tag{6}
\]

For precision, use their prime-counting theorem with left endpoint
`x=n-u`. Throughout this range, `u>=x^(17/30+epsilon)` for a fixed
positive `epsilon<theta-17/30`, and `u<=x^0.99` for all large `n`.
For primes in `[n-u,n]`, `log p=log n+O(u/n)=log n+o(1)`, while all
proper prime powers contribute `O(sqrt(n) log^2 n)=o(a)`.
Whether the terminal integer `n` is prime changes (6) by at most
`log n=o(a)`.

Partial summation, using the uniform estimate (6), now yields

\[
\sum_{a\le h\le b}\frac{\Lambda(n-h)}h
 =\log(b/a)+o(\log n)
 =\left(\frac{99}{100}-\theta+o(1)\right)\log n.
\tag{7}
\]

The sum can be restricted to even `h` without changing its leading
term. For odd `h`, `n-h` is even; a nonzero `Lambda(n-h)` then forces
`n-h=2^k`. The interval `[n-b,n-a]` lies inside `(n/2,n)` for large
`n`, so it contains at most one such power. Its weighted
contribution is `O(1/a)`.

Ordinary PNT gives `psi(h-1)/(h-1)=1+o(1)` uniformly for `h>=a`.
Consequently the *negative* part of (3) from this single band is

\[
\sum_{\substack{a\le h\le b\\2\mid h}}
 \frac{\Lambda(n-h)\psi(h-1)}{(h-1)h}
 =\left(\frac{99}{100}-\theta+o(1)\right)\log n.
\tag{8}
\]

All other Chebyshev-prefix terms in (3) remain nonnegative before
subtraction. Equations (3)--(5) and (8) therefore give the explicit
upper comparison

\[
Q_{s+1}-Q_s
\le\left(\frac{\log2}{2}-\frac{99}{100}+\theta+o(1)\right)
    \log n.                                               \tag{9}
\]

Let `theta` decrease to `17/30` after taking the limsup. Since
`99/100-17/30=127/300` and `log n/log s -> 1`, this proves (2).

This is a pointwise **step sign**, not a bound on `Q_s` itself. To
test an off-line-sized mode, take any `1/2<beta<1`, real `gamma`,
and `F(s)=s^beta cos(gamma log s)`. The abstract sequence
`B_(2m)=F(2m)`, `B_(2m+1)=F(2m)-c log(2m)` obeys the same strict
even-to-odd decrease while retaining the size and oscillation of
`F`. Its odd-to-even step pays the logarithmic parity correction.
This is a compatibility test, not a model for the actual `Q_s`.
The theorem does not improve the current pointwise
Vinogradov--Korobov-scale bound for `Q_s` or prove RH. It concerns
the arithmetic cofactor (1); it makes no claim about the separate
gamma or pole terms of the complete Weil form.
