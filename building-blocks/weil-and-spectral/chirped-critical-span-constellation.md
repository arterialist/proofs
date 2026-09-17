# A critical-span chirped positive constellation for actual zeta

**Status:** unconditional written analytic proof, 18 September 2026. The
finite Hermitian row-budget step is
[Lean-compiled](../../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean);
the actual-prime, archimedean, and pole estimates remain written. This
extends the [subcritical chirped constellation](chirped-prime-annulus-constellation.md)
from spans at most `alpha log T`, fixed `alpha<2`, to `2 log T-B` for a
fixed profile-dependent constant `B`. It uses the complete actual-zeta
Weil form, including every von Mangoldt prime power, both poles, the
archimedean term, and literal support endpoints. The normalization is
[the complete form used in the subcritical theorem](actual-signed-annulus-bump-gram.md#exact-prime-orientation-and-analytic-remainder).
No literature-priority claim is made. The tests depend
on `T`; this does not prove RH or a pointwise prime-phase bound for a
fixed profile.

Fix `0<w<log 2`, a nonzero real `a in C_c^infinity((0,w))` with
`||a||_2=1`, and `0<eta<1/(8w)`. For large `T` put

\[
 u_T(x)=a(x)e^{i\eta T x^2-iTx},\qquad
 q_T(x)=\frac{(\partial_x^2-1/4)u_T(x)}
                  {\|(\partial_x^2-1/4)u_T\|_2}.
\tag{1}
\]

**Theorem.** For every fixed `0<epsilon<1` there are constants
`B=B(a,w,eta,epsilon)>0` and `T_0` such that, whenever `T>=T_0` and

\[
0\le x_1<\cdots<x_M\le 2\log T-B,\qquad x_{j+1}-x_j>w,
\]

the complete Hermitian Weil form satisfies, for every complex vector
`(c_j)`,

\[
\boxed{\quad
 Q\!\left(\sum_{j=1}^M c_j\tau_{x_j}q_T\right)
 \ge (1-\epsilon)\log T\sum_{j=1}^M|c_j|^2.
\quad}                                                     \tag{2}
\]

The bound is uniform over the center set, including `M` of order
`log T`. For large `T`, the right endpoint is positive and the allowed
interval is nonempty. This reaches the critical coefficient `2` in the
span while retaining a fixed additive deficit `B`.

## Pole-null packet and its frequency band

Write `theta_T(x)=eta T x^2-Tx`. Direct differentiation gives

\[
(\partial_x^2-1/4)u_T=e^{i\theta_T(x)}
 \left[-T^2(1-2\eta x)^2a
       +iT\{2\eta a-2(1-2\eta x)a'\}+a''-a/4\right].       \tag{3}
\]

Since `1-2 eta x>3/4` on the support, the denominator in (1) is
`T^2(A+O(T^-1))`, where
`A=||(1-2 eta x)^2 a||_2>0`. Hence
`q_T=e^{i theta_T}b_T`, where `b_T` is supported in `(0,w)`,
`||b_T||_2=1`, and `||b_T||_{C^m}=O_{a,eta,m}(1)` for every fixed `m`.
Integration by parts gives exactly

\[
E_+(q_T)=\int q_T(x)e^{x/2}dx=0,
\qquad E_-(q_T)=\int q_T(x)e^{-x/2}dx=0.          \tag{4}
\]

The same holds for every translate, so **both pole terms vanish** in
the complete form, without a limit argument.

Use `hat f(s)=int f(x)e^(isx)dx`. The phase of `hat q_T(s)` has derivative
`s-T+2 eta T x`. Its stationary frequencies lie in `[3T/4,T]`.
For `s` outside `[T/4,2T]`, repeated integration by parts, using the
uniform derivative bounds on `b_T`, gives for every integer `m>=1`

\[
 |\widehat q_T(s)|\le C_m(T+|s|)^{-m}.                 \tag{5}
\]

The digamma multiplier
`h(s)=Re psi(1/4+is/2)-log pi` obeys
`h(s)=log(|s|/(2pi))+O(1/|s|)` at large `|s|` and
`|h(s)|=O(log(2+|s|))` globally. Consequently
`|h(s)-log(T/(2pi))|<=C` on `[T/4,2T]`, for an absolute `C` and
large `T`. Let `f=sum_j c_j tau_(x_j) q_T`. Its translates have
disjoint supports, so `||f||_2^2=sum_j|c_j|^2` and

\[
\widehat f(s)=\widehat q_T(s)\sum_jc_je^{isx_j},\qquad
\left|\sum_jc_je^{isx_j}\right|^2\le M\sum_j|c_j|^2.
\]

Equation (5), `M<=1+(2 log T-B)/w=O_w(log T)`, and Plancherel show
that the off-band contribution of the residual multiplier is `o(1)`
times `sum|c_j|^2`, uniformly in the center set. On-band its
quadratic form has norm at most `C||f||_2^2`. Thus the **whole**
archimedean form, not an entrywise estimate multiplied by `M`, has
the lower bound

\[
 Q_{\rm gamma}(f)\ge
 \bigl(\log(T/(2\pi))-C-o(1)\bigr)\sum_j|c_j|^2.
\tag{6}
\]

## Complete prime-power row bound

Let `C_T(y)=int q_T(x+y) overline(q_T(x)) dx`. The self-correlations
at positive prime shifts vanish because `w<log 2`. For a pair of
centers at distance `d>w`, only the orientation from the earlier to
the later packet can meet a positive shift, and its exact cross sum is

\[
 P_T(d)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                  C_T(\log n-d).                          \tag{7}
\]

The sum is finite; no prime power or endpoint is deleted. One may use
the inclusive band `|log n-d|<=w`, since `C_T(+-w)=0` for the fixed
compact support. From
`q_T=e^{i theta_T}b_T`,

\[
C_T(y)=e^{i\eta T y^2-iTy}
 \int b_T(x+y)\overline{b_T(x)}e^{2i\eta Txy}dx,
\]

so integration by parts in `x`, and Cauchy--Schwarz for small `y`,
give `|C_T(y)|<=C_m(1+T|y|)^(-m)` uniformly in `T` and `y`.
On the support of (7), `n` lies in `[e^{d-w},e^{d+w}]` and
`|log n-d|>=e^{-w}|n-e^d|/e^d`. Since
`0<=Lambda(n)<=log n<=d+w` and, for `m>1`,

\[
 \sum_{n\in\mathbb Z}(1+T|n-N|/N)^{-m}
       \le C_m(1+N/T)\qquad(N>0),
\]

we obtain an absolute-prime bound with a profile-dependent constant:

\[
 |P_T(d)|\le C_{a,w,\eta}(d+w)
                  \left(e^{-d/2}+\frac{e^{d/2}}T\right).
\tag{8}
\]

For any row indexed by `j`, divide the other centers into distance
shells of width `w`. There are at most two centers per shell. The
first term of (8) therefore has a uniformly bounded row sum.
For the increasing second term, use reverse shells of width `w` from
the maximal distance `D=2 log T-B`. A geometric series gives

\[
 \sum_{k\ne j}|P_T(|x_k-x_j|)|
 \le C_0+C_1(D+w)e^{D/2}/T
 \le C_0+C_2 e^{-B/2}\log T.                  \tag{9}
\]

The constants depend only on the fixed profile, `w`, and `eta`.
The prime quadratic form is
`-2 Re sum_(j<k) c_k overline(c_j) P_T(x_k-x_j)`.
Using `2|c_jc_k|<=|c_j|^2+|c_k|^2`, (9) bounds it below by the
negative of the right side of (9) times `sum|c_j|^2`. Choose `B`
so large that `C_2 e^(-B/2)<epsilon/2`. Then (4), (6), and (9)
give (2) for large enough `T`, absorbing the fixed constants and
`log(2pi)` into the remaining `epsilon log T/2`.
The [finite Lean theorem](../../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean)
formalizes this row-budget-to-Gram-margin implication for an arbitrary
complex Hermitian matrix. It does not formalize (8), (9), or the
identification of that matrix with the actual prime-power sum.

## Scope and off-line-mode check

The proof uses only the complete explicit formula, elementary
`Lambda(n)<=log n`, smooth integration by parts, the digamma
asymptotic, and finite row sums. It proves a stronger **structured**
signed positivity range than the subcritical theorem, without any
prime-phase estimate. It does not sign every compact test of this
diameter. In particular, at `T=gamma` for a hypothetical zero ordinate,
`hat q_T(gamma)=O_m(T^-m)` for every `m`: the phase derivative there
is `2 eta T x`, bounded away from zero on the fixed compact support
of `a`. Thus this packet has negligible loading on that selected zero
at its nominal carrier. No selected-zero contradiction or RH-scale
law follows from (2).
