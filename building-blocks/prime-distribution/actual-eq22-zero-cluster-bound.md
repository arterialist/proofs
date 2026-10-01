# A zero-cluster bound for the actual Eq. 22 prime-error residual

For real \(x>1\), let \(Z_x\), \(E_xR\), \(T\), and \(F=B/2-M\) be the
complete cutoff and prime-power quantities in [the actual half-density
identity](actual-half-density-second-order-gap.md). In particular, every
\(\Lambda(p^j)=\log p\) is retained, and a term entering at \(x=p^j\) has
zero endpoint weight. The residual is

\[
C(x)=Z_x(E_xR-T)
=x^2\int_1^x F(y)y^{-3}\,dy
-\sum_{q=p^j<x}\Lambda(q)qF(x/q).
\]

Put \(\Phi(x)=(\log x)^{3/5}/(\log\log x)^{1/5}\) for sufficiently large
\(x\), and
\[
d=0.212580726073\ldots,\qquad
c_M=2^{2/5}d=0.280501949731\ldots.
\]
The direct pointwise prime-number-theorem estimate gives only
\(C(x)\ll_\varepsilon x^2e^{-(d-\varepsilon)\Phi(x)}\).

**Theorem.** For every fixed \(\varepsilon>0\) and all sufficiently large
real \(x\), the literal residual and the complete centered row
\(N_{\rm full}=C+2F+Z_x\) satisfy
\[
\boxed{\ |C(x)|+|N_{\rm full}(x)|
\ll_\varepsilon x^2e^{-(c_M-\varepsilon)\Phi(x)}.\ }
\]
There are no exceptional cutoffs or omitted prime powers. The proof is
written analysis, independently checked at the Mellin, contour, and
constant steps. The [Lean module](../../formalization/BuildingBlocks/ActualEq22Residual.lean)
checks the exact finite cofactor/Volterra reduction and the centered
convolution algebra; it does not formalize the analytic contour estimate.

The [Gaussian recovery estimate](gaussian-recovery-complete-critical-numerator.md)
quantifies recovery of the literal full numerator from a logarithmic
Gaussian average, including every integer seam. Its arithmetic coefficient
bound is checked in Lean; the integral recovery argument remains written
analysis. It supplies no stronger global signed upper for this row.

## Proof

Put
\[
 H_a(s)=\frac{\zeta(s-\tfrac12)}{s(s-1)}(g(s)+a)^2,
 \qquad
 g(s)=\frac1{s-2}+\frac{\zeta'}{\zeta}(s-1),              \tag{1}
\]
where `a=0` gives the Mellin transform of `C`, and `a=1` gives the
Mellin transform of the complete centered row `N_full=C+2F+Z`.  Both
identities initially hold on `Re s>2`.  The apparent singularity of `g` at
`s=2` is removable.  On `sigma_x=2+1/log x`, Mellin inversion is absolutely
convergent and gives
\[
 C(x)=\frac1{2\pi i}\int_{\sigma_x-i\infty}^{\sigma_x+i\infty}
 H_0(s)x^s\,ds,                                             \tag{2}
\]
with the identical formula for `N_full` and `H_1`.  Indeed the Dirichlet
series gives `|g(s)|<<log x` on this line, while the two denominator factors
give `O(|t|^(-2))`.  The literal Riesz kernels are continuous at integer and
prime-power seams because their equality weights vanish, so (2) holds for
every real `x>1`, not only away from jumps.

### Zero-cluster contour lemma

Let
\[
 u(T)=(\log T)^{-2/3}(\log\log T)^{-1/3},\qquad
 A_0=1/48.0712256382.
\]
Bellotti's [primary theorem](https://arxiv.org/abs/2306.10680) gives the
asymptotic denominator `48.0718`, not
the longer decimal above.  The exact degree-110 certificate in
`unique-contributions/asymptotic-zeta-zero-free-48-0712256382/` proves
`R_2<48.0712256382` by rational autocorrelations and a rational cubed
comparison in the Mossinghoff--Trudgian--Yang formula, using Bellotti's
`B=4.43795`.  The independent reconstruction is in
the certificate's reproducible `audit.py`.  The published input plus this
exact certificate gives, at all sufficiently large heights,
\[
 \beta\le1-A_0u(|\gamma|).                                  \tag{3}
\]
It gives
\[
 d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5}
   =0.212580726073117\ldots,\quad
 2^{2/5}d=0.280501949731323\ldots,\quad
 2^{3/5}d=0.322212128229832\ldots .
\]
Bellotti's displayed denominator by itself gives
`d=0.212579202120942...` and `2^(2/5)d=0.280499938864373...`.

Fix `A_1<A_0`, put `L=log x`, and choose a fixed large dyadic `Q_0`.  Let
`H=Q_J` be the first member of `Q_j=2^jQ_0` with
`Q_J>=exp(K Phi(x))`; then `H<2exp(K Phi(x))`.  For `0<=j<J`, set
\[
 \eta_j=A_1u(4Q_j),\qquad
 r_j=\{L\log^3(3Q_j)\}^{-1},\qquad
 b_j=2-2\eta_j+r_j.                                      \tag{4}
\]
For large `x`, uniformly in these blocks,
\[
 r_j<\tfrac14\min\{\eta_j,(A_0-A_1)u(4Q_j)\}.             \tag{5}
\]

Choose the block boundaries once for both adjacent blocks.  At an internal
anchor `Q_j`, write `r_j^*=max(r_{j-1},r_j)`.  The zero ordinates whose
`4r_j^*`-neighborhoods meet `[Q_j,Q_j+1]` number `O(log Q_j)`, with
multiplicity.  Their excluded total length is
`O(r_j^* log Q_j)=O(1/(L log^2 Q_j))<1`.  Hence one can choose
\[
 Y_j\in[Q_j,Q_j+1],\qquad
 \operatorname {dist}(Y_j,\{\gamma:\zeta(\beta+i\gamma)=0\})
       \ge4r_j^*.
\]
The same `Y_j` is the upper endpoint of the lower block and the lower
endpoint of the upper block.  Choose one terminal ordinate
`\mathcal H\in[H,H+1]` by the same rule with radius `4r_{J-1}`, and set
`Y_J=\mathcal H`.  Use `-Y_j` and `-\mathcal H` below the real axis.

On `I_j=[Y_j,Y_{j+1}]`, call a zero near when
`Q_j/2<=gamma<=4Q_j` and `beta>1-2eta_j`.  Ingham's density estimate gives
\[
 \mathcal N_j
 \ll Q_j^{6\eta_j/(1+2\eta_j)}(\log Q_j)^5.               \tag{6}
\]
The source is A. E. Ingham, ["On the estimation of
`N(sigma,T)`"](https://academic.oup.com/qjmath/article-abstract/os-11/1/201/1574975),
*Quarterly Journal of Mathematics* os-11 (1940), 201--202, which proves
`N(sigma,T)<<T^(3(1-sigma)/(2-sigma))log^5 T`.

For a near zero `rho=beta+i gamma`, write `a_rho=1+beta` and define
\[
 h_{\rho,j}(t)=
 \begin{cases}
 a_\rho+r_j,&|t-\gamma|\le r_j,\\
 b_j+(a_\rho+r_j-b_j)_+(2-|t-\gamma|/r_j),
    &r_j<|t-\gamma|<2r_j,\\
 b_j,&|t-\gamma|\ge2r_j.
 \end{cases}
\]
Set
\[
 \lambda_j(t)=\max\bigl(\{b_j\}\cup
             \{h_{\rho,j}(t):\rho\text{ near}\}\bigr),
 \qquad \Gamma_j^+(t)=\lambda_j(t)+it.                    \tag{7}
\]
For a far zero at its own ordinate, `b_j>=1+beta+r_j`.  For a near zero,
(7) places the graph at least `r_j` to its right when
`|t-gamma|<=r_j`; outside this interval the vertical separation is at least
`r_j`.  The whole graph is therefore at distance at least `r_j` from every
zero in the local window, and every pole `1+rho` lies strictly to its left.
Equations (3) and (5) give
\[
 \lambda_j(t)\le2-\eta_j,                                  \tag{8}
\]
while outside the bump supports `lambda_j=b_j`.  The maximum of the tents
has total variation no larger than the sum of their variations.  Thus the
total bumped arc length is `O(mathcal N_j(eta_j+r_j))`, even with coincident
ordinates or multiple zeros.

The boundary choice leaves a zero-free collar of width `2r_j^*` around
each `Y_j`, and no bump enters that collar.  Replace the two constant
baselines there by their linear interpolation.  Its real part lies between
`b_{j-1}` and `b_j`, its distance from every zero is at least `2r_j^*`, and
its length is `O(r_j^*+|b_j-b_{j-1}|)`.  These interpolations join the block
graphs into one continuous graph `Gamma^+` from the fixed low-height piece
to `\mathcal H`.  Reflection gives `Gamma^-`.

The unconditional local partial-fraction formula, in the form of
[Titchmarsh's Theorem 9.6(A)](https://sites.math.rutgers.edu/~zeilberg/EM18/TitchmarshZeta.pdf)
and uniformly in this fixed strip, is
\[
 \frac{\zeta'}{\zeta}(w)
 =\sum_{|\gamma-\Im w|\le1}\frac{m_\rho}{w-\rho}
  +O(\log^2(3+|\Im w|)).                                   \tag{9}
\]
The unit-window zero count, with multiplicity, is `O(log T)`.  Equations
(5), (7), and (9) therefore give on the complete graph
\[
 |g(s)+a|\ll L\log^4(3T),\qquad a\in\{0,1\}.              \tag{10}
\]
No simplicity or separation of zeros is used.  Also
`zeta(s-1/2)<<1` there, because `Re(s-1/2)>1` by a fixed margin, and
`|s(s-1)|` is comparable to `T^2`.  The near and far parts of this block
are consequently bounded by
\[
\begin{aligned}
 I_{\rm near}(T)&\ll
 x^2 e^{-\eta_TL}\frac{\mathcal N(T)}{T^2}
 L^2\log^{O(1)}(3T),\\
 I_{\rm far}(T)&\ll
 x^2 e^{-2\eta_TL}\frac1T
 L^2\log^{O(1)}(3T).                                      \tag{11}
\end{aligned}
\]
Here `T=Q_j`, `eta_T=eta_j`, and `N(T)=mathcal N_j`.  The factor
`exp(r_T L)` is bounded by (5).  Formula (11) is the grouped
estimate that the earlier individual-residue calculation lacked; in
particular, reciprocal zero gaps never appear.

On each shared collar, the interpolated graph is bounded by the far
expression in (11) with `1/T^2` in place of `1/T`.  No internal join returns
a near `1/T` term.

For clarity, orient the truncated closed contour as follows.  Ascend the
original line `Re s=sigma_x` from `-\mathcal H` to `\mathcal H`, move left
along the top segment, descend the single graph `Gamma^+ union Gamma^-`,
then move right along the bottom segment.  At each zero-derived pole
ordinate, the graph lies at least the relevant `r_j` to its right.  The pole
at `s=3/2` and the poles at `0,1` lie to the left of the fixed low-height
piece, and `s=2` is removable.  The region between the graph and the
original line has no poles.  Cauchy's theorem therefore equates the upward
original-line integral to the upward graph integral plus the two terminal
joins, with no residue term.

The zero-avoiding choice of `\mathcal H` gives
\[
 \int_{\text{top and bottom}}|H_a(s)x^s\,ds|
 \ll x^2L^2\log^{O(1)}H/H^2.                              \tag{12}
\]
The tails of (2) on the original line are
\[
 \ll x^2L^2/H.                                             \tag{13}
\]
At bounded height, compact zero avoidance permits a fixed line
`Re s=2-kappa`, with `0<kappa<1/2`, to the right of every pole; its
contribution is `O(x^(2-kappa))`.  Choose `Y_0` by the same zero-avoidance
rule and join this fixed line horizontally to the first baseline.  The join
has a fixed power saving as well.  The real pole at `s=3/2` remains to the
left.  This accounts for all low pieces and the removable point `s=2`.

### Optimization

For `T<=H`, equation (6) gives
\[
 \log\mathcal N(T)
 \ll u(4T)\log T+\log\log T=o(\Phi(x))                    \tag{14}
\]
uniformly at all relevant optimizer heights.  The powers of `L`, the
logarithms in (11), and the `O(Phi(x))` dyadic blocks also cost
`exp(o(Phi(x)))`.  The same elementary optimization already used for the
terminal Riesz moment is
\[
 \min_T\{aA_1u(T)L+k\log T\}
 =\left((A_1/A_0)^{3/5}a^{3/5}k^{2/5}d+o(1)\right)\Phi(x).
                                                                    \tag{15}
\]
The near term in (11) has `(a,k)=(1,2)`, while the far term has
`(a,k)=(2,1)`.  Hence their limiting constants as `A_1` tends to `A_0`
are respectively
\[
 c_M=2^{2/5}d=0.280501949731\ldots,
 \qquad 2^{3/5}d=0.322212128230\ldots .                    \tag{16}
\]
Choose `A_1` sufficiently close to `A_0` and then choose `K>c_M` in
(12)--(13).  Equations (2)--(16) prove, for each fixed `epsilon>0`,
\[
 \boxed{
 |C(x)|+|N_{\rm full}(x)|
 \ll_\epsilon x^2
   \exp[-(c_M-\epsilon)\Phi(x)]
 }
 \qquad(x\ge x_\epsilon).                                 \tag{17}
\]

This proof retains every zero multiplicity in (9), every prime power in the
initial Mellin identity, both density rows, and the real cutoff convention.
It uses absolute values only after the arithmetic has assembled into the
complete squared logarithmic derivative.  That is why it improves the
direct one-error VK constant `d`, while a termwise Stieltjes estimate does
not.

### Exact consequence and limit

Let `Dcal(x)=mathcal D(x)` denote the literal same-prime allocation term in
`combined-prime-density-covariance.md`, including all proper powers, and put
\[
 T_*(x):=Z_x\mathcal D(x).
\]
The critical-sign numerator satisfies exactly
\[
 W(x)=N_{\rm full}(x)-T_*(x)
     =C(x)+2F(x)+Z_x-T_*(x).                               \tag{18}
\]
This is the normalization `W/Z_x=N_full/Z_x-mathcal D`; `T_*` is not the
mixed density-overlap term called `T` in the original Eq22 formula.  Thus
(17) gives the source-specific full-row statement
\[
 W(x)=-T_*(x)
 +O_\epsilon\!\left(x^2e^{-(c_M-\epsilon)\Phi(x)}\right). \tag{19}
\]
This is a genuine improvement of the previous `d`-constant envelope for
the signed complete row, but it does **not** prove eventual negativity:
\[
 \frac{x^2e^{-(c_M-\epsilon)\Phi(x)}}
      {x^{3/2}\log^2x}
 =\frac{x^{1/2}}{\log^2x}e^{-(c_M-\epsilon)\Phi(x)}
 \longrightarrow\infty.                                  \tag{20}
\]
It likewise supplies no fixed-power bound and no
`CoarsePrimitiveBound`.  Treating (19) as an eventual-sign result would
reverse the scale comparison in (20).

### Conditional target implication

The scale needed to affect RH is much smaller than (17).  Suppose, as a
separate hypothesis, that for every `epsilon>0`
\[
 C(x)=O_\epsilon(x^{3/2+\epsilon})                       \tag{21}
\]
for all real `x>=1`.  Then
\[
 \int_1^\infty C(x)x^{-s-1}\,dx
\]
is holomorphic on `Re s>3/2`: for a fixed point in this half-plane, choose
`epsilon<Re s-3/2` and use local uniform domination.  On `Re s>2` this
integral equals `H_0(s)` in (1), so it gives a holomorphic continuation of
`H_0` to `Re s>3/2`.

If `rho=beta+i gamma` is a zeta zero of multiplicity `m_rho` with
`beta>1/2`, then at `s_0=1+rho`
\[
 g(s)=\frac{m_\rho}{s-s_0}+O(1).
\]
The coefficient of `(s-s_0)^(-2)` in `H_0` is
\[
 \frac{m_\rho^2\zeta(\rho+1/2)}{(1+\rho)\rho}.             \tag{22}
\]
It is nonzero.  The denominator does not vanish for a nontrivial zero, and
`Re(rho+1/2)>1`, where zeta has no zeros.  Thus `H_0` has a genuine double
pole in the claimed holomorphic half-plane, a contradiction.  Equation
(21) excludes every zero with `beta>1/2`; the functional equation then
excludes `beta<1/2`.  Hence (21) implies RH.  This proves only the target
implication.  The unconditional estimate (17) is `x^(2-o(1))` and does not
approach (21).

## Formalization and scope

The [Lean module](../../formalization/BuildingBlocks/ActualEq22Residual.lean)
checks the literal finite cofactor reindexing, including all prime powers
and zero endpoint weights, and the all-real Volterra reduction that defines
\(C\). It also checks the centered convolution identities under explicitly
named symbol-map hypotheses. The separate
[scalar optimization module](../../formalization/BuildingBlocks/ActualEq22ScalarOptimization.lean)
kernel-checks the sharp minimum of the near and far leading costs in
(15)--(16), including the exact relation \(c_M=2^{2/5}d\). These proofs use
only Lean's standard logical axioms. Mellin inversion, the zero-free and
density inputs, the uniform asymptotic reduction to the scalar cost, the
contour estimate (17), and the conditional RH implication (21) are written
analysis and are not Lean theorems.

The constant \(c_M\) already occurs in bounds for other Riesz moments.
The statement here applies it to the literal signed Eq. 22 residual and
complete centered row. Equation (17) does not establish the fixed-power
target (21), an eventual sign for \(W\), or RH.
