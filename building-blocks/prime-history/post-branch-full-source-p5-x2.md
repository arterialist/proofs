# Full source correction at the first post-branch stage

The earlier actual primorial test evaluated the main mixed row plus the
max-based endpoint quadratic.  At `p=5`, `D=6`, `X=2`, the literal source
adds a prime row and a rough-composite row to that same scoped
mixed-plus-endpoint quantity.  Their exact finite-dilation
sum changes that tested value by a certified positive
`5.34063263906828 × 10^(-7)`.  This is a single finite stage, not a
growing-stage estimate.

## Literal source and finite-dilation identity

The source and normalization are those of the
[literal simultaneous row](../analytic-methods/simultaneous-nonendpoint-remainder-adversarial-audit.md#literal-row-and-normalization),
while the sampled main pairing and endpoint quadratic are those of the
[post-branch reduction](post-branch-wedge-double-abel-obstruction.md#combined-kernel-with-the-endpoint-quadratic).

Put `q=e^(-1)` and `h=(log 2)/2`.  At `X=2`, the rough coefficient is

\[
 c_2(n)=\mu(n)1_{(n,2)=1}
 =\delta_1(n)-1_{\{n>2:\ n\text{ prime}\}}+r_2(n),              \tag{1}
\]

where `r_2(n)=mu(n)` on odd composites and zero elsewhere.  In particular,
every odd prime power with exponent at least two remains in the source with
coefficient exactly zero.  The old divisor packet is

\[
 (e,\mu(e))\in\{(1,1),(2,-1),(3,-1),(6,1)\};                   \tag{2}
\]

the new packet consists of the opposite-oriented `5e` faces.  Define

\[
 G_q(x,y)=q^{\max(x,y)}-q^{x+y},
 \qquad
 F_{e,a}(u)=G_q(5eu,a)-G_q(5eu,5a).                             \tag{3}
\]

The exact normalized mixed-plus-endpoint admission contribution is

\[
\boxed{\begin{aligned}
 R^{\rm full}_{2,5}={}&B_{\mathrm{end}}+B_{\rm prime}+B_{\rm rough},\\
 B_{\rm end}={}&h^2\sum_{e,a\mid6}\mu(e)\mu(a)
             \{G_q(5e,5a)-2G_q(e,5a)\},\\
 B_{\rm prime}={}&2h^2\sum_{e,a\mid6}\mu(e)\mu(a)
             \sum_{r>2\atop r\ {\mathrm{prime}}}F_{e,a}(r),\\
 B_{\rm rough}={}&-2h^2\sum_{e,a\mid6}\mu(e)\mu(a)
             \sum_{n>1\atop n\ {\mathrm{odd\ composite}}}\mu(n)F_{e,a}(n).
\end{aligned}}                                                     \tag{4}
\]

This follows by expanding `2<Delta Z_nonendpoint,E_old+W>` and the exact
endpoint quadratic.  Every one of the sixteen ordered old-divisor pairs is
retained.  The old endpoint has its closed `j<=a` support and the new
endpoint its closed `j<=5a` support; the rough prime condition is open at
`2`.

For comparison, the studied main mixed row is

\[
 B_{\rm main}=2h\sum_{e,a\mid6}\mu(e)\mu(a)
        \{H_{2,q}(5e,a)-H_{2,q}(5e,5a)\},                           \tag{5}
\]

where `H` is the exact sampled integral of `F`:

\[
 H_{2,q}(5e,b)=\int_1^\infty G_q(10ev,b)\,dv.                  \tag{6}
\]

Thus the previous quantity was `B_end+B_main`; its omitted source
correction is exactly `B_prime-B_main+B_rough`.

## Prime density, second logarithm, lower atom, and PNT remainder

This is the exact finite-stage specialization of the published
[prime-density expansion](../analytic-methods/simultaneous-nonendpoint-remainder-adversarial-audit.md#1-prime-main-term-and-second-log-remainder)
and its [lower-atom convention](../analytic-methods/simultaneous-nonendpoint-remainder-adversarial-audit.md#2-moving-ceiling-and-lower-atom).

To display every part of the prime correction, let

\[
 \operatorname{Li}_2(t)=\int_2^t{du\over\log u},
 \qquad E(t)=\pi(t)-\operatorname{Li}_2(t),                         \tag{7}
\]

with `pi(2)=1`, both cumulative measures zero below `2`, and a Stieltjes
interval **closed** at `2`.  For each
`F=F_(e,a)`, the exact open-prime row is

\[
 \sum_{r>2\atop r\ {\mathrm{prime}}}F(r)
 =\int_2^\infty{F(u)\over\log u}\,du
  +\int_{[2,\infty)}F(u)\,dE(u)-F(2).                              \tag{8}
\]

The final `-F(2)` is the lower-atom subtraction.  It cancels the prime-two
atom included in the Stieltjes `E` term, so no prime at the open rough
boundary is counted.  Substitute `u=2v` in the first integral and use the
exact identity

\[
 {L\over L+\log v}
 =1-{\log v\over L}
  +{(\log v)^2\over L(L+\log v)},\qquad L=\log2.                 \tag{9}
\]

Writing `Sigma` for the complete signed `e,a|6` sum, equations (5)--(9)
give the exact decomposition

\[
\boxed{\begin{aligned}
 B_{\rm prime}-B_{\rm main}={}&B_J+B_2+B_{\rm PNT}+B_{\rm atom},\\
 B_J={}&-\Sigma\int_1^\infty F(2v)\log v\,dv,\\
 B_2={}&\Sigma\int_1^\infty F(2v)
              { (\log v)^2\over L+\log v}\,dv,\\
 B_{\rm PNT}={}&2h^2\,\Sigma\int_{[2,\infty)}F(u)\,dE(u),\\
 B_{\rm atom}={}&-2h^2\,\Sigma F(2).
\end{aligned}}                                                     \tag{10}
\]

Here `2L/X=L` at `X=2`; multiplying (9) by `L` yields the two
coefficients displayed in (10).  The signed `J`, second-
log, and Stieltjes PNT integrals are left in exact symbolic form; their
individual signs are not asserted.  Their **combined** prime correction is
certified below.  The lower atom alone is certifiably positive.

## Rational interval certificate

The [checker](../../formalization/verification/post_branch_full_source_p5_x2.py) constructs
polynomials in `q` for the endpoint, sampled main, lower atom, and source
atoms through `n=30`.  It encloses `q=e^(-1)` and `L=log 2` by rational
series.  For `n>30`, both endpoint indices are at most `30`, while
`5en>30`; hence

\[
 |F_{e,a}(n)|\le q^{5en}\le q^{5n}.
\]

Using `q<3/8` and all sixteen ordered pairs, the prime and rough tails
each have absolute contribution at most

\[
 32h^2{(3/8)^{155}\over1-(3/8)^5}
 <3.66\times10^{-66}.                                             \tag{11}
\]

The following displayed decimals are enclosed by exact rational
intervals; the checker asserts every stated sign:

| component | value |
|:---|---:|
| `B_end` | `+0.002119487526846502` |
| `B_prime` | `+0.000000060368118015305` |
| `B_rough` | `+1.148891648148771 × 10^(-34)` |
| `B_main` | `-0.000000473695145891523` |
| `B_prime-B_main` | `+0.000000534063263906828` |
| `B_atom` | `+0.000001874164986491395` |
| `B_J+B_2+B_PNT` | `-0.000001340101722584567` |
| `R_full` | `+0.002119547894964517` |
| `B_end+B_main` | `+0.002119013831700611` |

The full literal correction is positive:

\[
 R^{\rm full}_{2,5}-(B_{\rm end}+B_{\rm main})
 \in(5.34063263906827,5.34063263906830)\times10^{-7}.            \tag{12}
\]

The rough-composite row is nonzero and positive, although its value here is
tiny.  Equation (10) keeps the PNT and second-log terms signed; the table
does not assign their combined sign to either separately.

The finite prime/rough partition and the exact endpoint-correction
algebra are formalized in
[PostBranchFullSourceFinite.lean](../../formalization/BuildingBlocks/PostBranchFullSourceFinite.lean).
This calculation excludes the old nonendpoint cross `2<Z_old,W>` and the
other energy terms unrelated to (4), exactly as the earlier studied
post-branch quantity did.  No asymptotic or RH conclusion follows.
