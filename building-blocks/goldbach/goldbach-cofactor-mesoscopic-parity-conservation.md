# Mesoscopic parity compensation in the actual Goldbach cofactor

**Status:** unconditional written analytic theorem, 18 September 2026.
The exact one-step identity is Lean-compiled in
[GoldbachCofactorOddStepFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean),
and its finite window sum and prefix telescope are compiled in
[GoldbachCofactorWindowFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorWindowFinite.lean).
The short-interval estimate and limiting bounds below are written
analysis, not Lean theorems. No literature-priority claim is made.
The derivation and its source ranges were independently audited in the
“Formalize prime phase transitions” Codex task.

Let `Lambda` be the complete von Mangoldt function, with
`Lambda(p^j)=log p` for every prime power. For integers `s>=4` put

\[
\psi(y)=\sum_{m\le y}\Lambda(m),\qquad
q_y=\frac{\psi(y)-y}{y},\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}.
\tag{1}
\]

Fix `17/30<theta<1`. For a large integer `X`, set
`H=floor(X^theta)` and `D_n=Q_n-Q_(n-1)` for `n>=5`.

**Theorem.** Uniformly as `X->infinity`,

\[
\boxed{\quad Q_{X+H}-Q_X=o_\theta(H).\quad}       \tag{2}
\]

The two parity channels have opposite leading contributions:

\[
\boxed{\begin{aligned}
\sum_{\substack{X<n\le X+H\\n\text{ odd}}}D_n
  &=-\frac H2\log X+O_\theta(H),\\
\sum_{\substack{X<n\le X+H\\n\text{ even}}}D_n
  &=+\frac H2\log X+O_\theta(H).
\end{aligned}}                                             \tag{3}
\]

Thus the actual odd-to-even Goldbach rebound pays the preceding
even-to-odd loss *on every window of this length*, to leading
logarithmic order. The stronger total cancellation (2) follows from
the exact coefficient telescope, not merely by adding the two
`O(H)` remainders in (3).

## Uniform Mangoldt mass on every shifted window

The proof of [Guth--Maynard, Corollary 1.3, Section 13.2](https://arxiv.org/pdf/2405.20552)
gives its short-interval estimate directly for the complete
von Mangoldt sum: for each fixed `epsilon>0` and
`x^(17/30+epsilon)<=y<=x^0.99`, the sum over `[x,x+y]` is
`y+O_epsilon(y exp(-(log x)^(1/4)))`, with endpoint conventions
costing at most `O(log(x+y))`. It counts every proper prime power.

Choose `alpha` strictly between `17/30` and `theta`. For every
real `t` with `H<=t<=X`, let

\[
W_X(t)=\sum_{t<m\le t+H}\Lambda(m).
\tag{4}
\]

If `H<=t^0.99/2`, the cited theorem applies directly: since
`t<=X`, we have `H>=t^alpha` for all sufficiently large `X`.
Otherwise partition `(t,t+H]` into
`M=ceil(2H/t^0.99)` equal pieces. Each piece has length between
`t^0.99/4` and `t^0.99/2`; its left endpoint lies in `[t,2t]`.
For large `t` these lengths satisfy both bounds in Guth--Maynard's
theorem. Summing its estimates and accounting for the at most
`M=O(H^0.01+1)` shared endpoints gives, uniformly in `H<=t<=X`,

\[
W_X(t)=H+O_\theta\!\left(
 H e^{-c_\theta(\log X)^{1/4}}+H^{0.01}\log X\right)
=H+o_\theta(H/\log X)                         \tag{5}
\]

for some `c_theta>0`. Here `t>=H=X^(theta+o(1))` supplies the
uniform exponential. The same bound holds for integer-shifted
windows without deleting either endpoint. Since `t+H<=2t`,
the even-index Mangoldt mass in (4) is at most two powers of two,
or `O(1)`. Consequently

\[
\sum_{\substack{t<m\le t+H\\m\text{ odd}}}\Lambda(m)
=H+o_\theta(H/\log X),\qquad
\sum_{\substack{t<m\le t+H\\m\text{ even}}}\Lambda(m)=O(1),
\tag{6}
\]

uniformly on the same range. No prime-only substitution is made.

## Exact window telescope and moving boundary

Put

\[
c_h=\frac{\Lambda(h)}h-
       \frac{\psi(h-1)}{h(h-1)}=q_h-q_{h-1}
\quad(h\ge3),\qquad
q_2=\frac{\log2-2}{2}.
\tag{7}
\]

The compiled finite identity, with `n=s+1`, is

\[
D_n=\Lambda(n-2)q_2+
     \sum_{h=3}^{n-2}\Lambda(n-h)c_h.              \tag{8}
\]

Set `Y=X-H`. Since `H=o(X)`, `Y>=3` for large `X`. Sum (8) over
`X<n<=X+H`. For `3<=h<=Y`, every `n` in the window admits that
index, and its inner Mangoldt sum is `W_X(X-h)`. Both
`X-h>=H` and `X-h<=X`, so (5) applies. The endpoint contributes
`q_2 W_X(X-2)`. Elementary Chebyshev bounds give

\[
\sum_{h=3}^Y|c_h|=O(\log X),\qquad
\sum_{h=3}^Yc_h=q_Y-q_2.                       \tag{9}
\]

Therefore all these complete-window terms add to

\[
q_2 W_X(X-2)+\sum_{h=3}^Y c_h W_X(X-h)
=Hq_Y+o(H).                                      \tag{10}
\]

The `q_2` endpoint is essential to this cancellation.

The remaining indices satisfy `Y<h<=X+H-2`; their inner sums are
truncated by the birth condition `n>=h+2`. This boundary is retained.
For each such `h`, `n-h` lies in `[2,2H]`, so its inner mass is at
most `psi(2H)=O(H)`. Also `h>=X-H>=X/2`, and applying (5) to the
two adjacent windows covering `(X-H,X+H]` gives

\[
\sum_{Y<h\le X+H}|c_h|
\ll\frac1X\left(
\sum_{Y<h\le X+H}\Lambda(h)+H\right)
=O(H/X).                                           \tag{11}
\]

Hence the complete moving-boundary contribution is
`O(H^2/X)=o(H)`. Ordinary PNT gives `q_Y=o(1)` in (10), proving
(2). Combining the explicit error in (5) with Trudgian's
[explicit `psi` bound](https://arxiv.org/pdf/1401.2689) yields the
more quantitative form, for some `c_theta>0`,

\[
|Q_{X+H}-Q_X|
\ll_\theta H\log X\,e^{-c_\theta(\log X)^{1/4}}
          +\frac{H^2}{X}.                          \tag{12}
\]

The endpoint and partition errors in (5) are absorbed by reducing
`c_theta`, since `H` is a fixed positive power of `X`.

## The two parity channels

For odd `n` and even `h`, `n-h` is odd; for odd `n` and odd `h`,
`n-h` is even. Equation (6) therefore applies to the complete
inner sum for each `h<=Y`. The reverse classification holds for
even `n`. Endpoint `n-2` is odd for odd `n`, even for even `n`.
The boundary estimate (11) applies to each parity separately.

The classical PNT with its zero-free-region remainder, for example
the explicit bound of Trudgian cited above, implies

\[
\sum_{\substack{3\le h\le Y\\h\text{ odd}}}c_h
=\frac12\log Y+O(1),\qquad
\sum_{\substack{3\le h\le Y\\h\text{ even}}}c_h
=-\frac12\log Y+O(1).                         \tag{13}
\]

Indeed `sum_(h<=Y) Lambda(h)/h=log Y+O(1)`, whereas its
even-index part is the convergent power-of-two series.
On either parity, `sum 1/h=(1/2)log Y+O(1)`.
The difference between `psi(h-1)/(h(h-1))` and `1/h` is
absolutely summable by the same PNT remainder. The uniform errors
in (6), multiplied by (9), are `o(H)`; the even-source leakage is
only `O(log X)`. Thus the odd-`n` window sum is
`H[q_2+sum_(h even<=Y)c_h]+o(H)`, and the even-`n` sum is
`H sum_(h odd<=Y)c_h+o(H)`. Since
`log Y=log X+O(H/X)`, equation (13) proves (3).

## What the law does not imply

The previous pointwise Vinogradov--Korobov-scale bound for `Q_s`
does not imply (2) when `H=X^theta`: its endpoint estimate is
larger than `H`. This theorem supplies a local signed conservation
law for actual arithmetic. It is still compatible with an off-line
mode `F(s)=s^beta cos(gamma log s)`, `1/2<beta<1`, because

\[
F(X+H)-F(X)=O_{\beta,\gamma}(H X^{\beta-1})=o(H).
\]

The parity means in (3) cancel at order `H log X` but do not
control a residual at RH scale. No bound on the separate pole or
gamma terms of the complete Weil form is asserted, and no RH
conclusion follows.
