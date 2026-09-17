# Total admission energy at p=5, X=2

The complete normalized sampled energy rises when the prime 5 is admitted
to the old primorial packet `D=6` at the fixed clock `X=2`.  This is a
finite-stage statement.  The exact source includes every odd Möbius
coefficient, so the old nonendpoint row is infinite; the certificate below
bounds its tail rather than dropping it.

## Exact sampled rows and Green atoms

Use the [published literal sampled row](../analytic-methods/simultaneous-nonendpoint-remainder-adversarial-audit.md#literal-row-and-normalization)
with `q=e^(-1)`, `h=(log 2)/2`, and

\[
 c_2(n)=\mu(n)1_{(n,2)=1}.
\]

For each positive integer `m`, define the closed-support atom

\[
 v_m(j)=q^{m-j/2}1_{1\le j\le m},\qquad j\ge1,
\]

in the sampled Hilbert space with

\[
 \langle u,v\rangle_q=(1-q)\sum_{j\ge1}u(j)v(j).
\]

The exact geometric sum gives

\[
 \langle v_m,v_n\rangle_q
 =G_q(m,n)=q^{\max(m,n)}-q^{m+n}.                           \tag{1}
\]

The old packet has divisors `e=1,2,3,6`, with respective actual Möbius
coefficients `+1,-1,-1,+1`.  Separate its endpoint and nonendpoint rows,
and the two newly admitted rows, as

\[
\begin{aligned}
 E&=h\sum_{e\mid6}\mu(e)v_e,\\
 Z&=h\sum_{e\mid6}\mu(e)
       \sum_{\substack{n\ge3\\n\text{ odd}}}\mu(n)v_{en},\\
 W&=-h\sum_{e\mid6}\mu(e)v_{5e},\\
 T&=-h\sum_{e\mid6}\mu(e)
       \sum_{\substack{n\ge3\\n\text{ odd}}}\mu(n)v_{5en}.
\end{aligned}                                                     \tag{2}
\]

Squareful odd integers remain in both inner sums with coefficient zero.
The old normalized row is `E+Z`; the new row is `E+Z+W+T`.  Formula (2)
uses every integer ceiling exactly through `j<=en` or `j<=5en`.  It is
valid at this small clock even though the uniform growing-stage estimates
elsewhere require a separate range for the admitted prime.

## Every term of the total difference

The complete energy increment is

\[
\boxed{\begin{aligned}
 \Delta\mathcal E_{2;3\to5}
 &:=\|E+Z+W+T\|_q^2-\|E+Z\|_q^2\\
 &=\underbrace{2\langle T,E+W\rangle_q
       +2\langle E,W\rangle_q+\|W\|_q^2}_{R^{\mathrm{source}}_{2,5}}\\
 &\quad+2\langle Z,W\rangle_q
       +2\langle Z,T\rangle_q+\|T\|_q^2.
\end{aligned}}                                                    \tag{3}
\]

The underbraced term is exactly the scoped main-plus-endpoint quantity
after restoring its [literal prime and rough source](post-branch-full-source-p5-x2.md);
that earlier note proved

\[
 R^{\mathrm{source}}_{2,5}
 \approx0.002119547894964517.
\]

Equation (3) adds the previously excluded old nonendpoint cross
`2<Z,W>` and both remaining admitted-nonendpoint terms.  It is the total
energy difference, without another unlisted cross or square.

For any finite truncation of the odd `n` sums in (2), each term in (3) is
an explicit finite integer-coefficient polynomial in `q` times `h^2`, by
(1).  The [checker](../../formalization/verification/post_branch_total_admission_p5_x2.py)
asserts the coefficientwise identity between that four-part polynomial and
the directly squared new row minus the squared old row before numerical
evaluation.

## Rigorous infinite-source tail

The checker truncates both nonendpoint rows after `n=60`.  The single-atom
bound from (1) is

\[
 \|v_m\|_q^2=q^m-q^{2m}\le q^m.
\]

The rational exponential certificate gives `q<3/8`, hence
`sqrt(q)<5/8` and `q^(5/2)<1/10`; the logarithm certificate gives
`h<1/2`.  By the triangle inequality, with `Z_60,T_60` the truncated
rows,

\[
\begin{aligned}
 \eta_Z:=\|Z-Z_{60}\|_q
 &\le {16\over3}(5/8)^{61}
 <1.887\times10^{-12},\\
 \eta_T:=\|T-T_{60}\|_q
 &\le {20\over9}10^{-61}
 <2.223\times10^{-61}.                                             \tag{4}
\end{aligned}
\]

The same elementary enlargement to all `n>=3` gives

\[
 \|E\|_q\le1.25,\quad \|W\|_q\le0.2,
 \quad\|Z_{60}\|_q<1.303,\quad\|T_{60}\|_q<0.002223.          \tag{5}
\]

Consequently the four displayed pieces of (3), evaluated at the cutoff,
have absolute tail errors bounded respectively by

\[
\begin{aligned}
 \epsilon_R&\le2\eta_T(1.25+0.2),\\
 \epsilon_{ZW}&\le2\eta_Z(0.2),\\
 \epsilon_{ZT}&\le2(\eta_Z\,0.002223+1.303\eta_T+\eta_Z\eta_T),\\
 \epsilon_{T^2}&\le2(0.002223)\eta_T+\eta_T^2.                  \tag{6}
\end{aligned}
\]

These are sign-free Hilbert bounds.  They cover every omitted prime,
rough composite, and prime power (the last with its exact zero Möbius
coefficient); no unproved cancellation is used.

## Certified values

The checker encloses `q=e^(-1)` and `log 2` by exact rational series,
converts those enclosures outward to 80-digit directed Decimal intervals,
evaluates the finite integer-coefficient polynomials with outward rounding,
and adds (6).  Its asserted intervals are:

| Term in (3) | Certified interval |
|:---|:---|
| scoped `R_source` | `[0.002119547894964517360, 0.002119547894964517360]` at displayed precision |
| `2<Z,W>` | `[0.002732259015878510239, 0.002732259017387790086]` |
| `2<Z,T>` | `[0.00000006297268606201765788, 0.00000006297270283766315140]` |
| `||T||²` | `[0.00000003674788260797648482, 0.00000003674788260797648483]` |
| **Total** | **`[0.004851906631411697593, 0.004851906632937753085]`** |

The scoped and `||T||²` printed endpoints coincide or nearly coincide
only after decimal rounding; their internal directed intervals are not
collapsed.  Every term and the total are strictly positive at this stage.

[PostBranchTotalAdmissionFinite.lean](../../formalization/BuildingBlocks/PostBranchTotalAdmissionFinite.lean)
formalizes the complete Hilbert-space expansion (3) and finite interval
addition.  The infinite-source bounds and transcendental numerical
enclosures are checked by the companion script, not asserted as Lean
theorems.  This finite rise proves no monotonicity or asymptotic sign
statement for later prime admissions and no RH consequence.
