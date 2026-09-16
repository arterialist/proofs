# Adversarial audit of the second-Abel endpoint frontier

## Verdict

Accept after two written repairs.  The first-layer sign, the zero-moment
cancellation, and the claimed near-linear range are correct.  The source note
does not show the summed PNT error, and its initial-block discussion bounds an
amplitude but does not write the resulting energy estimate.  The calculations
below fill both gaps.  They leave the range

\[
 P\le \frac{X}{(\log X)^2
   \exp\{C(\log\log X)^2\}}                                           \tag{1}
\]

unchanged for a sufficiently large constant `C`.  Hence the corrected result
covers every fixed `P<=X^(1-epsilon)`.  It remains an endpoint theorem and does
not address full admission.

## The first-layer sign and endpoints

For `P<t<=P^2`, an integer `n<=t` has at most one prime factor larger than
`P`.  If `n=pm` with `p>P`, then `m<t/p<P`, so `p` does not divide `m` and

\[
 \mu(pm)=-\mu(m).
\]

The full Mertens sum is therefore

\[
 M(t)=M(t,P)-\sum_{P<p\le t}M(t/p),
\]

which proves the claimed plus sign

\[
 \boxed{M(t,P)=M(t)+\sum_{P<p\le t}M(t/p).}                            \tag{2}
\]

Changing the order of the finite sum gives, with
`N=floor(t/P)`,

\[
 M(t,P)=M(t)+\sum_{m\le N}\mu(m)
   \{\pi(t/m)-\pi(P)\}.                                                \tag{3}
\]

The strict prime endpoint is correct.  Equality `t=P^2` causes no extra
two-large-prime term, since two primes strictly larger than `P` have product
strictly larger than `P^2`.

## Exact Abel summation and the floor term

Put

\[
 f(u)=\operatorname{li}(t/u)-\operatorname{li}(P),\qquad Y=t/P.
\]

Finite Abel summation gives

\[
 \sum_{m\le N}\mu(m)f(m)
 =M(N)f(N)+t\int_1^N
   \frac{M(u)}{u^2\log(t/u)}\,du.                                     \tag{4}
\]

Thus the floor term does not vanish unless `Y` is an integer.  Since
`0<=Y-N<1`,

\[
 0\le t/N-P\le P/N,
 \qquad
 |f(N)|\ll \frac{P}{N\log P}.                                        \tag{5}
\]

The trivial estimate `|M(N)|<=N` gives

\[
 |M(N)f(N)|\ll P/\log P.                                              \tag{6}
\]

On the later range used below, `Y>=H` with `H` larger than `log t`, this is
at most `t/(log t log P)`.  A zero-free Mertens estimate makes it smaller,
but is not needed for this boundary.

## The zero moment and the recovered logarithm

The classical estimate

\[
 |M(u)|\ll u\exp\{-a\sqrt{\log u}\}
\]

makes both integrals

\[
 \int_1^\infty\frac{|M(u)|}{u^2}\,du,
 \qquad
 \int_1^\infty\frac{|M(u)|\log u}{u^2}\,du                           \tag{7}
\]

finite.  Therefore the limit at `s=1` in

\[
 \frac1{\zeta(s)}=s\int_1^\infty M(u)u^{-s-1}\,du
\]

is legitimate and proves

\[
 \int_1^\infty M(u)u^{-2}\,du=0.                                    \tag{8}
\]

Writing `R_t=log t`, the exact kernel identity yields

\[
\begin{aligned}
 t\int_1^N\frac{M(u)}{u^2(R_t-\log u)}\,du
 ={}&-\frac{t}{R_t}\int_N^\infty\frac{M(u)}{u^2}\,du\\
 &+\frac{t}{R_t}\int_1^N
 \frac{M(u)\log u}{u^2(R_t-\log u)}\,du .                            \tag{9}
\end{aligned}
\]

Since `R_t-log u>=log P`, (7) bounds the second line by
`O(t/(R_t log P))`.  The first line is

\[
 \ll \frac{t}{R_t}
 (1+\sqrt{\log N})^A e^{-a\sqrt{\log N}}                             \tag{10}
\]

for an absolute exponent `A`.  It may be written with a smaller exponential
constant as `O(t R_t^(-1)e^(-a' sqrt(log N)))`.

Differentiating the same Mellin identity at `s=1` gives

\[
 \int_1^\infty M(u)\log u\,u^{-2}\,du=-1,                            \tag{11}
\]

so the second-order term need not cancel.  The gain stops at two logarithms.

## The PNT error after the cofactor sum

Let `E(v)=pi(v)-li(v)` and assume

\[
 |E(v)|\le C v e^{-c\sqrt{\log v}}.
\]

The error in replacing (3) by its `li` main term is exactly

\[
 \sum_{m\le N}\mu(m)E(t/m)-E(P)M(N).                                 \tag{12}
\]

Every `t/m` is at least `P`.  Absolute summation, retaining all squarefree
and nonsquarefree cofactors through the actual `mu(m)`, gives

\[
 \left|\sum_{m\le N}\mu(m)E(t/m)\right|
 \ll t(1+\log Y)e^{-c\sqrt{\log P}},                                  \tag{13}
\]

and the trivial bound on `M(N)` gives

\[
 |E(P)M(N)|\ll t e^{-c\sqrt{\log P}}.                                \tag{14}
\]

Together with the ordinary `M(t)` term, equations (4)-(14) prove, uniformly
for `Y>=H`,

\[
 |M(t,P)|\ll t\left\{
 \frac1{\log t\log P}
 +\frac{e^{-a'\sqrt{\log Y}}}{\log t}
 +(1+\log Y)e^{-c\sqrt{\log P}}
 +e^{-a\sqrt{\log t}}
 \right\}.                                                           \tag{15}
\]

This is the corrected version of the claimed first-layer estimate.  The
extra harmless `1` and the ordinary Mertens term should be displayed.

## Uniformity and the transition at `P^2`

Take

\[
 R=\log X,\qquad
 H=\exp\{C(\log R)^2\},\qquad U=PH.                                  \tag{16}
\]

Increasing `C` makes the last three terms in (15) at most the required
two-log scale for `t>=U`.  For `t<=U`, retain the uniform one-log first-layer
bound.  Its contribution to the endpoint amplitude is

\[
 A_0\ll \frac{U}{\log P}+\frac{U^2}{X\log P}.                         \tag{17}
\]

Condition (1) gives `U<=X/R^2`, so `A_0=O(X/R^2)` after weakening constants.

At `t=P^2`, identity (2) remains valid.  Beyond it, the cited all-cases
friable estimate supplies `M(t,P)<<t/(log P)^2`, including its transition
terms, whenever its published uniformity region holds.  Outside the existing
sign-free range, `log P` is much larger than every required fixed power of
`log(XR)`, so that region covers `P^2<=t<=XR`.  The tail `t>XR` is paid by
the Abel exponential and does not require a friable estimate.  Thus no
uncontrolled layer remains.

For near-linear `P`, one has `P^2>XR`, so the Abel-effective range lies
entirely in the first layer and (15) alone does the work.

## The missing initial-block energy calculation

For `j<U`, the Stieltjes formula contains both the early amplitude (17) and
the later two-log tail `O(X/(log P)^2)`.  Since `U=o(X)`, multiplication by
`q^(-j/2)` changes these bounds by an absolute factor.  The initial block
therefore contributes at most

\[
 V_{<U}\ll \frac UX
 \left\{A_0+\frac{X}{(\log P)^2}\right\}^2.                            \tag{18}
\]

After multiplying by `R^2/X^2` and using `U<=X/R^2`, this is

\[
 \frac{R^2}{X^2}V_{<U}
 \ll R^{-4}+\frac1{(\log P)^4}=o(1)                                  \tag{19}
\]

outside the sign-free small-`P` range.  On `j>=U`, (15) and the later-layer
bound give

\[
 |E_{X,P}(j)|\ll \frac X{(\log P)^2}
 (1+j/X)e^{-j/X},                                                     \tag{20}
\]

and hence

\[
 \frac{R^2}{X^2}V_{\ge U}
 \ll \frac{R^2}{(\log P)^4}=o(1).                                   \tag{21}
\]

Equations (19)-(21) complete the claimed endpoint estimate.

## Scope

The corrected proof accepts (1), and therefore every fixed
`P<=X^(1-epsilon)`, as an endpoint-small range.  It does not reach `P` of
order `X`: then `Y=t/P` stays bounded on the Abel-effective scale, the
truncated zero moment in (9) does not approximate (8), and the coherent
`X/log X` endpoint mode remains.

The theorem uses the classical zero-free Mertens and PNT bounds plus the
published two-log estimate outside the first layer.  It proves no new
Mertens estimate and has no RH consequence by itself.
