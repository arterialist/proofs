# Full-history cofactor drift at odd totals

**Status:** unconditional written analytic theorem, 18 September 2026.
The exact finite successor identity is compiled in
[GoldbachCofactorOddStepFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean).
The short-interval and explicit-Chebyshev estimates below are not
formalized in Lean. This strengthens the constant in the
[earlier odd-total drift theorem](goldbach-odd-total-strict-negative-drift.md).
It is a local step sign, not an RH proof or a literature-priority claim.

Write `Lambda` for the actual von Mangoldt function, including
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
\le \frac{\log(4/3)}{12}-\frac{13}{30}
=-0.4093598272\ldots<0.
\quad}                                                    \tag{2}
\]

Hence each fixed `0<c<13/30-log(4/3)/12` satisfies
`Q_(s+1)-Q_s <= -c log s` for all sufficiently large even `s`.
The nonelementary inputs are the unconditional short-interval prime
theorem of [Guth and Maynard, Corollary 1.3](https://arxiv.org/pdf/2405.20552),
ordinary PNT, and the explicit bound of
[Trudgian, Theorem 1](https://arxiv.org/pdf/1401.2689).

## Exact step and the surviving birth

Set `n=s+1`, so `n` is odd. The compiled finite identity gives

\[
\begin{split}
Q_{s+1}-Q_s={}&\Lambda(n-2)q_2\\
 &+\sum_{h=3}^{n-2}\Lambda(n-h)
 \left(\frac{\Lambda(h)}h-
       \frac{\psi(h-1)}{(h-1)h}\right),\\
q_2={}&\frac{\log2-2}{2}<0.
\end{split}                                                 \tag{3}
\]

All terms, including the `h=2` endpoint, remain present. For even
`h`, the only possible positive prime-power source is `h=2^k`.
At `h=4` its *net* coefficient is

\[
\frac{\Lambda(4)}4-\frac{\psi(3)}{12}
=\frac{\log(4/3)}{12}=:a_4>0.                    \tag{4}
\]

Every later even prime-power coefficient is nonpositive. Indeed,
`psi(7)=log 420>7 log 2` and
`psi(15)=log 360360>15 log 2`, settling `h=8,16`.
For `h=2^k>=32`, put `x=h-1>=31`. Trudgian gives, for all real
`x>=23`,

\[
\left|\frac{\psi(x)}x-1\right|
\le \sqrt{\frac8{17\pi}}\,z^{1/2}e^{-z},
\qquad z=\sqrt{\frac{\log x}{6.455}}.
\tag{5}
\]

The maximum of `z^(1/2)e^(-z)` over `z>0` occurs at `z=1/2`.
Thus the right side of (5) is at most
`sqrt(4/(17*pi*e))<1/5`, using `pi>3` and `e>2`.
Also `log 2<4/5`, since
`e^(4/5)>1+4/5+(4/5)^2/2>2`. It follows that
`psi(h-1)/(h-1)>log 2`.
For all other even `h`, `Lambda(h)=0` and the coefficient in (3)
is nonpositive. The retained prefix history therefore pays every
even prime-power birth after `h=4`.

For odd `h`, the complement `n-h` is even and can carry a nonzero
Mangoldt weight only when it is `2^k`. Dropping its negative prefix
part gives the complete positive budget

\[
\sum_{\substack{3\le h\le n-2\\2\nmid h}}
 \frac{\Lambda(n-h)\Lambda(h)}h
 \le \log2\sum_{\substack{2^k\le n-3\\k\ge1}}
       \frac{\Lambda(n-2^k)}{n-2^k}
 \le\frac{\log2}{e}+O\!\left(\frac{\log^2 n}{n}\right).
\tag{6}
\]

Powers `2^k<=n/2` leave a denominator at least `n/2` and number
`O(log n)`. There is at most one power of two in `(n/2,n)`;
`Lambda(h)/h<=log h/h<=1/e` handles its complement. The negative
endpoint `Lambda(n-2)q_2` in (3) is dropped only for the upper bound.

## The full remaining history

Fix `17/30<theta<99/100` and set `a=n^theta`. Define

\[
A_n(u)=\sum_{1\le h\le u}\Lambda(n-h),
\qquad a\le u\le n-2.                               \tag{7}
\]

We claim, uniformly on this entire range,

\[
A_n(u)=u(1+o(1)).                                  \tag{8}
\]

For `a<=u<=b_0:=n^0.99/2`, apply Guth--Maynard with
`x=n-u`, `y=u`. Choose fixed `epsilon>0` with
`17/30+epsilon<theta`. For large `n` both
`x^(17/30+epsilon)<=u<=x^0.99` hold. Their theorem gives the
prime count with relative `o(1)` error. Multiplying by `log p`
and adding all proper prime powers gives (8): the latter have total
weight `O(sqrt(n) log^2 n)=o(a)`, while a possible terminal
`Lambda(n)` changes the sum by at most `log n`.

For `b_0<=u<=n/2`, divide `[n-u,n]` into
`m=ceil(u/b_0)` equal intervals of length `ell=u/m`.
Then `b_0/2<=ell<=b_0`, and each left endpoint lies in `[n/2,n]`.
For all large `n`, each length satisfies
`x^(17/30+epsilon)<=ell<=x^0.99`; the upper inequality follows
from `b_0=n^0.99/2<=(n/2)^0.99`. Applying the same theorem to
each interval and summing gives (8) uniformly. Prime powers are
bounded once over the full interval; choices of open or closed
subinterval endpoints cost at most `O(m log n)=o(u)`.

For `n/2<=u<=n-2`, ordinary PNT gives (8) directly from
`A_n(u)=psi(n-1)-psi(n-floor(u)-1)`. In fact
`sup_{0<=t<=n}|psi(t)-t|=o(n)`, so the error is `o(n)=o(u)`
uniformly. The floor and endpoint cost `O(1)`.

Partial summation of (8) now yields

\[
\sum_{a\le h\le n-2}\frac{\Lambda(n-h)}h
=\log\frac{n-2}{a}+o(\log n)
=(1-\theta+o(1))\log n.                         \tag{9}
\]

The odd `h` in (9) contribute `o(1)`: `n-h=2^k`, with
`O(log n/n)` from `2^k<=n/2` and at most `O(1/a)` from
`2^k>n/2`. The even powers of two in (9) also contribute `o(1)`,
since

\[
\sum_{\substack{2^k\ge a\\2^k\le n-2}}
  \frac{\Lambda(n-2^k)}{2^k}
\le \log n\sum_{2^k\ge a}2^{-k}
=O\!\left(\frac{\log n}{a}\right).
\tag{10}
\]

Thus (9) remains true after restricting to even `h` that are not
powers of two. Ordinary PNT also gives
`psi(h-1)/(h-1)=1+o(1)` uniformly for `h>=a`. The negative
prefix part of (3) on precisely those terms is therefore

\[
\sum_{\substack{a\le h\le n-2\\2\mid h,
                    \,h\ne2^k}}
 \frac{\Lambda(n-h)\psi(h-1)}{(h-1)h}
=(1-\theta+o(1))\log n.                          \tag{11}
\]

All excluded even terms have a nonpositive *net* coefficient by
the sign checks above, apart from `h=4`; all odd positive terms
are bounded by (6).
Equations (3)--(4), (6), and (11) imply

\[
Q_{s+1}-Q_s
\le a_4\Lambda(n-4)-(1-\theta+o(1))\log n+O(1)
\le\left(a_4-1+\theta+o(1)\right)\log n.            \tag{12}
\]

Take the limsup and then let `theta` decrease to `17/30`.
Since `log n/log s ->1`, (12) proves (2).

This is a pointwise even-to-odd decrease, not a bound on `Q_s`.
The odd-to-even Goldbach row compensates it on average: PNT gives
`Q_s=o(s)`, hence the mean two-step change on a long dyadic parity
progression is `o(1)`. A one-step sign can coexist with an
off-line-zero-sized oscillation through that rebound. The theorem
concerns the arithmetic cofactor (1); it makes no claim about the
separate gamma or pole terms of the complete Weil form. No RH
conclusion follows.
