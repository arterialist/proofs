# Complete p=5 admission at the first four integer clocks

At each integer clock `X=2,3,4,5`, admitting `p=5` to the old divisor
packet `D=6` raises the **complete normalized sampled energy**.  Exact
interval certificates establish all four strict signs.  The old
nonendpoint/new nonendpoint cross changes sign, so the positive total is
not a termwise positivity principle.  This finite check gives no sign
statement for later clocks or primes.

## Literal source at each clock

Use the [published sampled source and normalization](simultaneous-nonendpoint-remainder-adversarial-audit.md#literal-row-and-normalization)
without imposing an asymptotic stage range.  Put

\[
 q_X=e^{-2/X},\quad h_X={\log X\over X},\quad
 Q_X=X^\#=\prod_{\ell\le X,\ \ell\text{ prime}}\ell,
 \quad c_X(n)=\mu(n)1_{(n,Q_X)=1}.                             \tag{1}
\]

The literal cutoffs are

\[
 (Q_2,Q_3,Q_4,Q_5)=(2,6,6,30).                              \tag{2}
\]

Thus `c_2(3)=-1`, `c_3(3)=c_4(3)=0`,
`c_3(5)=c_4(5)=-1`, and `c_5(5)=0`.  In every row, each prime square and
higher prime power has its actual zero Möbius coefficient.  No prime at
the closed upper cutoff `X` enters the rough source.

For the Green atom `v_m(j)=q_X^{m-j/2}1_{1\le j\le m}`, the sampled
inner product is exactly

\[
 \langle v_m,v_n\rangle_{q_X}
 =q_X^{\max(m,n)}-q_X^{m+n}.                                    \tag{3}
\]

With `e|6` and its actual Möbius sign, define

\[
\begin{aligned}
 E_X&=h_X\sum_{e\mid6}\mu(e)v_e,\\
 Z_X&=h_X\sum_{e\mid6}\mu(e)\sum_{n\ge2}c_X(n)v_{en},\\
 W_X&=-h_X\sum_{e\mid6}\mu(e)v_{5e},\\
 T_X&=-h_X\sum_{e\mid6}\mu(e)\sum_{n\ge2}c_X(n)v_{5en}.
\end{aligned}                                                     \tag{4}
\]

Every integer endpoint is retained through `j<=en` or `j<=5en` in (4).
The old full row is `E_X+Z_X`, and the new full row is
`E_X+Z_X+W_X+T_X`.  Its total admission increment is the exact identity

\[
\begin{aligned}
 \Delta\mathcal E_X
 &:=\|E_X+Z_X+W_X+T_X\|_{q_X}^2
      -\|E_X+Z_X\|_{q_X}^2\\
 &=\underbrace{2\langle T_X,E_X+W_X\rangle
      +2\langle E_X,W_X\rangle+\|W_X\|^2}_{R_X^{\mathrm{source}}}\\
 &\qquad+2\langle Z_X,W_X\rangle
          +2\langle Z_X,T_X\rangle+\|T_X\|^2.                  \tag{5}
\end{aligned}
\]

The first bracket is the scoped quantity evaluated in the
[full-source p=5 audit](post-branch-full-source-p5-x2.md) at `X=2`.
Equation (5) also includes the old-source cross and the two remaining
admitted-source terms, so it is a total energy difference at each clock.

## Finite polynomials and infinite tail

The [certificate](verification/post_branch_total_admission_first_horizons.py)
uses the exact integer Möbius function in (1), truncating only the
nonendpoint source at `n<=120`.  By (3), every truncated term is an
integer-coefficient polynomial in `q_X` times `h_X^2`.  Before evaluating
numbers, the checker asserts coefficientwise equality between the sum of
the four pieces in (5) and the directly squared new row minus the
directly squared old row.

The source tail is bounded without using Möbius cancellation.  At the four
clocks choose the following rational strict majorants for
`q_X^(1/2)` and `q_X^(5/2)`:

| `X` | `r_X` | `s_X` |
|---:|---:|---:|
| 2 | `5/8` | `1/10` |
| 3 | `3/4` | `1/5` |
| 4 | `4/5` | `3/10` |
| 5 | `5/6` | `3/8` |

The rational exponential intervals verify both inequalities in each row.
Since `h_X<1` and `||v_m||<=q_X^(m/2)`, the old and admitted
nonendpoint tails satisfy

\[
 \eta_Z:=\|Z_X-Z_{X,120}\|
 \le {4r_X^{121}\over1-r_X},\qquad
 \eta_T:=\|T_X-T_{X,120}\|
 \le {4s_X^{121}\over1-s_X}.                                       \tag{6}
\]

Similarly, the elementary sign-free norms used to propagate those errors
are

\[
 \|E_X\|\le4r_X,\quad \|W_X\|\le4s_X,\quad
 \|Z_{X,120}\|\le{4r_X^2\over1-r_X},\quad
 \|T_{X,120}\|\le{4s_X^2\over1-s_X}.                              \tag{7}
\]

For example, the scoped term's truncation error is at most
`2 eta_T (||E_X||+||W_X||)`; the old endpoint cross costs
`2 eta_Z ||W_X||`.  The other two errors are exactly the corresponding
Cauchy bounds for the two-source cross and new-source square.  Thus every
omitted rough prime, squarefree composite, and zero-coefficient prime
power is covered.  At the slowest clock `X=5`, the coarse bounds are
`eta_Z<6.300×10^(-9)` and `eta_T<1.837×10^(-51)`.

## Certified finite-stage results

The checker encloses the exponential and logarithm by rational series,
then evaluates the finite polynomials with outward 80-digit Decimal
rounding and adds the tail bounds.  Each lower bound below is strictly
positive:

| `X` | certified total `Delta E_X` |
|---:|:---|
| 2 | `[0.004851906632174725339, 0.004851906632174725339]` at displayed precision |
| 3 | `[0.02132213851810915285, 0.02132213851815797229]` |
| 4 | `[0.03894692577501270119, 0.03894692603268137313]` |
| 5 | `[0.02621613491020098624, 0.02621619538183487231]` |

The internal directed interval at `X=2` is narrower than the displayed
digits, rather than a point interval.  The component pattern is also
certified: the scoped bracket, `2<Z_X,W_X>`, and `||T_X||²` are positive
at all four clocks, while `2<Z_X,T_X>` is positive at `X=2` and strictly
negative at `X=3,4,5`.  The sign reversal of that cross does not reverse
the complete increment.

[PostBranchFirstHorizonsFinite.lean](BuildingBlocks/PostBranchFirstHorizonsFinite.lean)
proves the four literal primorial cutoffs, their source-coefficient changes,
and zero Möbius coefficient on prime squares.  The abstract full-energy
expansion is in
[PostBranchTotalAdmissionFinite.lean](BuildingBlocks/PostBranchTotalAdmissionFinite.lean).
The strict transcendental signs and infinite-tail estimates are separate
from Lean.  No uniform sign beyond these four integer clocks or
asymptotic/RH implication is asserted.
