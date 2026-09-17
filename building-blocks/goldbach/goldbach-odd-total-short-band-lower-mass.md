# Short-band prime mass strengthens the odd-total cofactor drift

**Status:** unconditional written analytic consequence of published short-interval
prime estimates, 18 September 2026. The exact finite successor identity is
compiled in
[GoldbachCofactorOddStepFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean).
The short-band transfer and the analytic estimates are not formalized in Lean.
This improves the constant in the
[full-history drift theorem](goldbach-odd-total-full-history-drift.md),
without claiming an RH proof or literature priority.

Let `Lambda` be the actual von Mangoldt function, including
`Lambda(p^k)=log p` for every prime power. Set

\[
\psi(y)=\sum_{m\le y}\Lambda(m),\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)
       \frac{\psi(s-m)-(s-m)}{s-m}\quad(s\ge4).
\tag{1}
\]

**Theorem.** Along even `s`,

\[
\boxed{\displaystyle
\limsup_{\substack{s\to\infty\\2\mid s}}
\frac{Q_{s+1}-Q_s}{\log s}
\le \frac{\log(4/3)}{12}-\frac{13}{30}-\frac{3}{800}
=-0.4131098272\ldots<0.}
\tag{2}
\]

The new gain `3/800` uses the last displayed inequality in
[Baker--Harman--Pintz, *The Difference Between Consecutive Primes, II*](https://doi.org/10.1112/plms/83.3.532)
([original PDF, p. 562](https://www.cs.umd.edu/~gasarch/BLOGPAPERS/BakerHarmanPintz.pdf)):
for every sufficiently large real `x`,

\[
\pi(x+x^{21/40})-\pi(x)>
\frac9{100}\frac{x^{21/40}}{\log x}.
\tag{3}
\]

This is a prime-count **lower bound**, not an asymptotic. The other
nonelementary input is the unconditional
[Guth--Maynard short-interval prime theorem, Corollary 1.3](https://arxiv.org/pdf/2405.20552),
at every fixed exponent above `17/30`. The sign of the small even
prime-power coefficients uses the explicit Chebyshev estimate cited and
checked in the full-history theorem.

## The lower-mass band

Fix `eta>0` small enough that
`alpha=21/40+eta < beta=17/30+eta <99/100`, and write
`A=n^alpha`, `B=n^beta` for odd `n=s+1`. We claim

\[
\sum_{\substack{A\le h<B\\2\mid h,\ h\ne2^k}}
\frac{\Lambda(n-h)}h
\ge \frac9{100}\log\frac BA-o(1)
=\frac3{800}\log n-o(1).
\tag{4}
\]

To see the direction and endpoints directly, begin at `x_0=n-B`
and iterate `x_(j+1)=x_j+x_j^(21/40)`, retaining only complete
half-open intervals `(x_j,x_(j+1)]` inside `(n-B,n-A]`.
Write `L_j=x_j^(21/40)` and `H_j=n-x_j`, so `L_j=H_j-H_(j+1)`.
Every `x_j` is asymptotic to `n`. Equation (3) and
`log p>=log x_j` for each prime `p` in the interval imply

\[
\sum_{x_j<p\le x_{j+1}}\Lambda(p)
>\frac9{100}L_j.
\tag{5}
\]

Each such prime is odd for large `n`; hence `h=n-p` is even.
Since `h<H_j`, dividing its weight by `h` makes the contribution
at least `(9/100)L_j/H_j`. The unfilled terminal piece has length
at most `O(n^(21/40))=o(A)`. Also
`max_j L_j/H_j=O(n^(-eta))`. Comparing this sum with the
logarithmic integral, with the terminal piece included, gives

\[
\sum_j\frac{L_j}{H_j}
=\log(B/A)+O\!\left(n^{-\eta}\log n\right)+O(n^{-\eta})
=\log(B/A)+o(1).
\tag{6}
\]

This tile argument uses only ordinary primes to establish the lower
bound. All proper prime powers in `Lambda(n-h)` have nonnegative
weight and remain in the actual cofactor. Among the counted terms,
discarding the possible exceptional `h=2^k` loses at most

\[
\sum_{\substack{2^k\ge A\\2^k<B}}
\frac{\Lambda(n-2^k)}{2^k}
\le \log n\sum_{2^k\ge A}2^{-k}
=O(\log n/A)=o(1),
\tag{7}
\]

which proves (4). Ordinary PNT gives
`psi(h-1)/(h-1)=1+o(1)` uniformly for `h>=A`.
The negative prefix coefficient in the exact step therefore receives
at least `(3/800-o(1)) log n` from this previously unused band.

## Combining the full history

The compiled exact step, with its endpoint intact, is

\[
Q_{s+1}-Q_s=\Lambda(n-2)\frac{\log2-2}{2}
+\sum_{h=3}^{n-2}\Lambda(n-h)
 \left(\frac{\Lambda(h)}h-
       \frac{\psi(h-1)}{(h-1)h}\right).
\tag{8}
\]

The endpoint is negative. The sole positive *net* coefficient with
even `h` is at `h=4`, where it equals
`a_4=log(4/3)/12`. Later even powers of two have nonpositive
net coefficients, and every other even `h` has coefficient
`-psi(h-1)/((h-1)h)`. These facts and the complete `O(1)`
positive budget from odd `h` are established in the
[full-history theorem](goldbach-odd-total-full-history-drift.md).

That theorem's Guth--Maynard/PNT argument, applied from `h>=B`,
gives, after excluding odd `h` and even powers of two,

\[
\sum_{\substack{B\le h\le n-2\\2\mid h,\ h\ne2^k}}
\frac{\Lambda(n-h)\psi(h-1)}{(h-1)h}
=(1-\beta+o(1))\log n.
\tag{9}
\]

The ranges in (4) and (9) are disjoint. Keeping their negative
contributions in (8), and dropping other nonpositive terms, yields

\[
Q_{s+1}-Q_s
\le a_4\Lambda(n-4)
-\left(1-\beta+\frac9{100}(\beta-\alpha)+o(1)\right)
 \log n+O(1).
\tag{10}
\]

Use `Lambda(n-4)<=log n`, `beta-alpha=1/24`, take the limsup,
and then let `eta` decrease to zero. Since `log n/log s->1`,
this is (2). The gain is exactly `(9/100)(1/24)=3/800`.

This pointwise even-to-odd drift still allows compensating
odd-to-even steps. For the fast off-line-mode check, a smooth term
`M_s=s^rho cos(gamma log s)` with fixed `1/2<rho<1` and `gamma`
has `M_(s+1)-M_s=O(s^(rho-1))=o(1)`. It can have an
off-line-zero-sized amplitude without changing the logarithmic
one-step bound (2). The statement concerns the arithmetic
cofactor (1), not the separate pole and gamma terms of a complete
Weil form. No RH conclusion follows.
