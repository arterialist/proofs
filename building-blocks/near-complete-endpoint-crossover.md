# Near-complete admission: the exact endpoint crossover

## Result

Set `Y_X=X/P` and keep the literal endpoint

\[
 E_{X,P}(j)=q^{-j/2}\sum_{\substack{d\mid P^\#\\d\ge j}}
 \mu(d)q^d,\qquad q=e^{-2/X}.
\]

When `Y_X` tends to a finite positive `Y`, the normalized endpoint does not
vanish. It converges to an explicit finite-kernel profile built from the
truncated zero moment of the ordinary Mertens function. As `Y` tends to
infinity this deterministic profile decays. At `Y=1`, its coarse component
is exactly the mode that cancels the fixed-profile plateau on the first
horizon. After that coherent mode is removed, the remaining observable is a
weighted Mertens-prefix mean square at precisely RH scale.

This note is independent of the near-linear extension proved in the
[second-Abel endpoint theorem](friable-endpoint-second-abel-frontier.md) and
[its adversarial audit](second-abel-endpoint-frontier-adversarial-audit.md).

## Truncated zero moment

Define

\[
 \tau(z)=\sum_{m\le z}\mu(m)\left({z\over m}-1\right).
\tag{1}
\]

Finite Abel summation gives the exact identity

\[
 \boxed{
 \tau(z)=z\sum_{m\le z}{\mu(m)\over m}-M(z)
 =z\int_1^z {M(u)\over u^2}\,du.}
\tag{2}
\]

The integral uses the standard right-continuous step function and therefore
retains every integer endpoint. Since the complete moment is zero,

\[
 \tau(z)=-z\int_z^\infty {M(u)\over u^2}\,du,
\tag{3}
\]

but replacing the truncated integral by zero at finite `z` is invalid.

For `t=Xv`, `P=X/Y`, and fixed `v,Y`, the exact first-layer identity and the
PNT give

\[
 {\log X\over X}M(Xv,X/Y)
 \longrightarrow
 a_Y(v):={\tau(vY)\over Y}
 =v\int_1^{vY}{M(u)\over u^2}\,du.
\tag{4}
\]

The floor in `tau(vY)` is literal. Formula (4) follows first for compact
`v` intervals; the all-cases first-layer bound supplies an integrable Abel
majorant for passage to the endpoint kernel.

## Explicit crossover kernel

The exact Stieltjes endpoint formula is

\[
 q^{j/2}E_{X,P}(j)
 =-e^{-2j/X}M(j-1,P)
 +{2\over X}\int_j^\infty e^{-2t/X}M(t,P)\,dt.
\tag{5}
\]

Combining (4)--(5) defines

\[
 b_Y(y)=-e^{-2y}a_Y(y)
 +2\int_y^\infty e^{-2v}a_Y(v)\,dv,
\qquad
 K_Y(y)=e^y b_Y(y).
\tag{6}
\]

Thus, at continuity points and in the sampled Green norm,

\[
 {\log X\over X}E_{X,P}(\lfloor Xy\rfloor)
 \longrightarrow K_Y(y),
\tag{7}
\]

and the sharp fixed-ratio endpoint-energy crossover is

\[
 \boxed{
 {\log^2X\over X^2}V_{\rm end}(X,P)
 \longrightarrow
 \mathcal Q(Y):=2\int_0^\infty |K_Y(y)|^2\,dy.}
\tag{8}
\]

The same calculation is uniform when `1<=Y_X<=(log X)^A` for any fixed
`A`: on compact `v` intervals the number of terms in (4) is polylogarithmic,
while the uniform PNT error is exponentially small in `sqrt(log X)`; the
all-cases first-layer estimate controls the Abel tail. Hence in this moving
range

\[
 {\log^2X\over X^2}V_{\rm end}(X,X/Y_X)
 =\mathcal Q(Y_X)+o(1).
\tag{8a}
\]

Thus bounded `Y_X` gives the nonzero finite-kernel crossover, whereas
polylogarithmic `Y_X` tending to infinity gives endpoint decay through the
same formula.

The factor two in (8) is forced by
`(1-e^(-2/X)) sum_j f(j/X)^2 -> 2 integral f^2`. The literal face geometry
remains `q^d-q^(2d)`.

Classical zero-free-region bounds in (3) imply `Q(Y)->0` as `Y->infinity`.
For bounded `Y`, (1) is a finite arithmetic kernel and generally does not
vanish. A direct quadrature of (1), (6), with exact Möbius values gives

| `Y` | 1 | 2 | 5 | 10 | 20 | 50 |
|---:|---:|---:|---:|---:|---:|---:|
| `Q(Y)` | .04618 | .06035 | .02251 | .00579 | .00110 | .000094 |

These figures are diagnostic rather than certified enclosures. In
particular, the increase from `Y=1` to `Y=2` falsifies any monotonicity claim
based only on reducing the admitted prime cutoff.

## What the full-admission endpoint is

The three proposed descriptions are compatible, but apply at different
levels.

1. Before subtraction, the fixed-ratio limit is the explicit finite kernel
   `K_Y` in (6).
2. At `Y=1`, `a_1(y)=0` for `0<y<1`, so `K_1(y)=c e^y` on the first horizon.
   The exact `j=1` identity identifies `c` with the limiting fixed-profile
   coefficient. Hence this coarse endpoint mode cancels the non-endpoint
   plateau there.
3. After subtracting the coherent total mode, the remaining endpoint is
   exactly a weighted Mertens prefix.

For the third statement put

\[
 Z_P(q)=\sum_{d\mid P^\#}\mu(d)q^d,
 \qquad A_n(q)=\sum_{d\le n}\mu(d)q^d.
\]

For every integer `1<=j<=P`, squarefree support gives the finite identity

\[
 \boxed{E_{X,P}(j)-q^{-j/2}Z_P(q)=-q^{-j/2}A_{j-1}(q).}
\tag{9}
\]

No limiting argument enters (9).

## RH-scale renormalized residual

Define the coherent-mode-subtracted boundary observable

\[
 \mathcal D_{X,P}=(1-q)\sum_{j=2}^{P}q^{-j}|A_{j-1}(q)|^2.
\tag{10}
\]

The exact triangular Abel identities

\[
 A_n(q)=q^nM(n)+(1-q)\sum_{k<n}q^kM(k)
\]

and their finite inverse have uniformly bounded convolution norms on
`n<=P<=X`. Therefore absolute constants, depending only on a bounded range
for `X/P`, give

\[
 \boxed{
 c{1\over X}\sum_{n<P}M(n)^2
 \le\mathcal D_{X,P}\le
 C{1\over X}\sum_{n<P}M(n)^2.}
\tag{11}
\]

For `X/P` bounded above and below, the following is consequently an exact
RH-scale vanishing criterion:

\[
 \boxed{
 \mathrm{RH}\quad\Longleftrightarrow\quad
 P^{-1-\delta}\mathcal D_{X,P}\longrightarrow0
 \text{ for every }\delta>0.}
\tag{12}
\]

The forward direction uses `M(n)=O_epsilon(n^(1/2+epsilon))`. Conversely,
(11)--(12) give `sum_(n<P) M(n)^2=O_epsilon(P^(2+epsilon))`; the standard
dyadic Cauchy and Mellin argument continues `1/zeta(s)` to `Re(s)>1/2`.
Thus the deterministic kernel `Q(Y)` is unconditional boundary geometry,
while `D_(X,P)` is the residual carrying RH-scale information. No RH bound
is assumed in (1)--(11).

## Conceptual provocations and failures

* **Renewal theory.** `tau(vY)/Y` is the renewal defect left when the
  Buchstab cofactor horizon has finite length. Sending `Y` to infinity kills
  the defect; setting it to zero for bounded `Y` fails against (1).
* **Scattering theory.** `K_Y` is a Volterra-scattered incoming profile. The
  full-admission plateau cancellation is a coherent channel, while (9) is
  the orthogonal-looking but not actually orthogonal radiation residual.
  Dropping their cross term gives the wrong energy.
* **Renormalization.** `Y` is a boundary-layer scale. `Q(Y)` is the finite
  counterterm and `D_(X,P)` is the renormalized fluctuation. Treating the
  counterterm as monotone is falsified numerically at `Y=1,2`.
* **Wavelets.** Dyadic splitting of (10) localizes Mertens prefixes, but the
  endpoint Gram has positive cross-scale entries. Assuming Parseval across
  these arithmetic blocks would incorrectly turn the RH-equivalent mean
  square into an unconditional estimate.

Rankin tilting also fails here: it replaces the signed truncated moment by a
positive Euler-product majorant and loses both (2) and the coherent
cancellation in (9).

## Lean scope

[FriableEndpointCrossoverFinite.lean](BuildingBlocks/FriableEndpointCrossoverFinite.lean) formalizes the exact discrete identity
`tau(z)=z sum_(m<=z)mu(m)/m-M(z)`, the closed weighted-tail decomposition,
the coherent endpoint residual (9), its indispensable quadratic cross term,
and the corresponding finite weighted-energy identity. It introduces no
analytic or RH axiom.
