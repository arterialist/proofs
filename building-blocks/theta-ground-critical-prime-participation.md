# Critical-window prime participation forced by the actual theta ground

The actual killed ground cannot place most of its physical mass on a sparse collection of prime-grid cells while keeping its negative physical energy. On the favorable radii already furnished by the [critical-subsequence theorem](theta-ground-critical-subsequence-prime-average.md), this observation has a finite-window quantitative form. It counts complete prime-power overlaps of the actual ground history, rather than merely prime-power labels in the window.

Fix \(d>2\) and \(D>2d\). For each sufficiently large starting \(r\), choose a favorable radius \(R\in[r,r+1/r]\) from the critical-subsequence theorem with physical concentration inside
\[
 T=R+dR e^{-R}.
\]
The same theorem supplies a nonnegative even normalized actual ground \(\psi_R\), its positive-half physical history \(g_R=\Phi\psi_R1_{u>R}\), \(q_+=\|g_R\|_2^2>0\), and effective width
\[
 \ell_R=\frac{(\int_R^\infty g_R)^2}{q_+}
 \le(d+o(1))R e^{-R}.
\tag{1}
\]
Put \(U=R+D R e^{-R}\), and define the finite weighted participation sum
\[
 \mathcal N_R(D)
 =\sum_{\substack{e^{2R}<n\le e^{2U}\\ \Lambda(n)>0}}
   \frac{(g_R*g_R)(\log n)}{q_+}.
\tag{2}
\]
The convolution is nonnegative and each quotient in (2) is at most one by Cauchy–Schwarz. Every prime power is retained; no primality-only replacement is made.

**Claim.** Along these favorable radii,
\[
 \boxed{\qquad
 \mathcal N_R(D)\ge\bigl(\tfrac12-o(1)\bigr)e^R .
 \qquad}
\tag{3}
\]
The interval in (2) has additive length
\[
 e^{2U}-e^{2R}=(2D+o(1))R e^R .
\tag{4}
\]
Thus the actual ground has at least order \(e^R\) units of normalized overlap with prime-power translations in a window of square-root-times-logarithm length. Formula (3) does not say that every prime in the window is used, or bound the signed profile variance needed for the full affine covariance.

## Ground energy supplies an order-\(R\) prime return

Write \(P_R=\sum_{n>e^{2R}}\Lambda(n)n^{-1/2}(g_R*g_R)(\log n)\), including the complete far tail. The exact [ground sign-prime identity](theta-ground-sign-prime-convolution.md) and the [same-half suppression](theta-ground-same-half-prime-suppression.md) give
\[
 P_R=A[g_R]+\delta_R/2-S_{\rm same}(R)-C_R,
 \qquad \delta_R>0.
\tag{5}
\]
The first-order [gap-or-collar proof](theta-ground-first-order-gap-collar-dichotomy.md) applies its sharp nonnegative Fourier cap on precisely these favorable collars:
\[
 \frac{A[g_R]}{q_+}
 \ge\log(1/\ell_R)-1-\log2+o(1)
 \ge R-\log R-O_d(1).
\tag{6}
\]
No pointwise density substitution for \(P_R\) occurs in (5) or (6).

The same critical-collar concentration gives
\[
 H_R^2=4e^R\ell_R q_+(1+o(1))=O_d(Rq_+).
\tag{7}
\]
The existing complete same-half and continuous bounds are
\(S_{\rm same}(R)/H_R^2\to0\) superexponentially and \(C_R/H_R^2=O(e^{-2R})\). Equation (7) therefore makes both costs \(o(Rq_+)\). Dropping the positive \(\delta_R/2\) in (5) yields
\[
 \frac{P_R}{q_+}\ge(1-o(1))R.
\tag{8}
\]
This uses the actual ground equation, all prime powers, and the physical width premise proved along the selected radii.

## The remote prime-power tail is negligible

Let \(P_R^{>2U}\) denote the part of \(P_R\) with \(\log n>2U\). Such an edge between two positive-half points has at least one endpoint beyond \(U\). After the established unitary theta conjugation, the [complete two-endpoint prime block estimates](theta-internal-exterior-crossing-sharp-bound.md) bound all these edges by a constant times
\[
 B_{R,U}+F_U,\qquad
 B_{R,U}=C e^{2R+3U}
       \exp[-\tfrac\pi2(e^{2R}+e^{2U})],
 \qquad
 F_U=C e^{5U}\exp[-\pi e^{2U}].
\tag{9}
\]
The estimates include both displacement directions and every integer prime power. They are operator bounds in the normalized ground Hilbert space, whose vector has norm one. Positivity allows restriction to the cross-half edges counted by \(P_R^{>2U}\).

The favorable-radius normalized ground-tail estimate gives at least half its norm inside \(R<|u|<T\). Since \(\omega^2=\Phi/(2\cosh(u/2))\) eventually decreases, the positive-half physical norm obeys
\[
 q_+\ge\tfrac14\omega(T)^2
 \ge c\,e^{4T}\exp[-\pi e^{2T}]
 \quad\text{for large }R.
\tag{10}
\]
Put \(s_R=R e^{-R}\). Using \(T=R+ds_R\), \(U=R+Ds_R\), the logarithm of the first ratio in (9)–(10) has leading term
\[
 \pi e^{2R}\left[e^{2ds_R}
       -\frac{1+e^{2Ds_R}}2\right]+O(R)
 =-\pi(D-2d+o(1))R e^R .
\tag{11}
\]
The second ratio has leading term
\(-2\pi(D-d+o(1))R e^R\). Since \(D>2d\), both decay faster than \(\exp(-c_{d,D}R e^R)\). Consequently
\[
 P_R^{>2U}/q_+\le C\exp(-c_{d,D}R e^R)=o(1),
 \qquad
 \frac{P_R-P_R^{>2U}}{q_+}\ge(1-o(1))R.
\tag{12}
\]
No remote prime-power contribution has been deleted without a bound.

## Remove the Mangoldt weights without losing the window

For every \(e^{2R}<n\le e^{2U}\),
\[
 0<\frac{\Lambda(n)}{\sqrt n}
 \le\frac{\log n}{\sqrt n}
 \le(2+o(1))R e^{-R}.
\tag{13}
\]
The last inequality uses \(U-R=O(R e^{-R})\). Equations (2), (12), and (13) imply
\[
 (1-o(1))R
 \le\frac{P_R-P_R^{>2U}}{q_+}
 \le(2+o(1))R e^{-R}\mathcal N_R(D),
\]
which proves (3).

## A positive fraction of labels have substantial overlap

The arithmetic window is short enough to turn (3) into a statement about individual labels. Let \(X=e^{2R}\) and \(Y=e^{2U}-e^{2R}=(2D+o(1))R e^R\). The arbitrary-interval [Brun–Titchmarsh bound of Yamada, Theorem 2](https://arxiv.org/pdf/2312.16090) with modulus one gives
\[
 \#\{p:X<p\le X+Y\}
 <\frac{2Y}{\log Y+0.8601}
 =(4D+o(1))e^R.
\tag{14}
\]
Proper prime powers add only \(O_D(R)\) labels. For squares, their bases lie in an interval of length \(Y/(2\sqrt X)+O(1)=O_D(R)\). For each exponent \(k\ge3\), the corresponding base interval has length \(O_D(R e^{-R/3})<1\) eventually; there are only \(O(R)\) possible exponents. Hence the total number \(M_R\) of prime-power labels in (2) is at most \((4D+o(1))e^R\).

Every normalized overlap in (2) lies in \([0,1]\). Labels with overlap below \(1/(16D)\) contribute at most
\((1/(16D))M_R\le(1/4+o(1))e^R\). By (3), the remaining labels must number at least
\[
 \boxed{\quad
 \#\left\{n:
 \begin{array}{c}
 e^{2R}<n\le e^{2U},\ \Lambda(n)>0,\\[2pt]
 (g_R*g_R)(\log n)\ge q_+/(16D)
 \end{array}\right\}
 \ge\bigl(\tfrac14-o(1)\bigr)e^R .
 \quad}
\tag{15}
\]
Thus many actual prime-power translations have individually substantial overlap with the actual minimizing ground history. The sieve input is an upper count, not an RH-sized prime theorem in every short interval. The favorable radii still come from the separate complete-PNT average in the critical-subsequence theorem.

## A sharper logarithmic-energy budget on these radii

The same finite count also bounds the complete prime return from above. By Cauchy–Schwarz, every convolution value in (2) is at most \(q_+\). Equations (12)–(14) therefore give
\[
 \frac{P_R}{q_+}
 \le(2+o(1))R e^{-R}M_R+o(1)
 \le(8D+o(1))R .
\tag{16}
\]
Use (5) in the opposite direction, retaining its positive same-half and continuous corrections and subtracting the nonnegative \(\delta_R/2\). Their ratios to \(q_+\) are \(o(R)\) as above. Consequently
\[
 R-\log R-O_d(1)
 \le \frac{A[g_R]}{q_+}
 \le(8D+o(1))R,\qquad
 \frac{\|g_R\|_{\mathcal H}^2}{q_+}\le C_D R.
\tag{17}
\]
The last step uses the established equivalence of the positive logarithmic Fourier norm and \(A[g_R]+O(q_+)\). This improves the general \(Ce^R\) relative budget for these selected actual grounds.

The Fourier cap also gives a physical-mass consequence. Split at \(|\xi|=L=\exp(4C_D R)\). The high-frequency mass is at most \(q_+/4\) by (17), while the low-frequency mass is at most \(L(\int g_R)^2/\pi\). Hence, after enlarging a constant,
\[
 \boxed{\qquad
 \ell_R=\frac{(\int g_R)^2}{q_+}
 \ge c_D e^{-C'_D R}.
 \qquad}
\tag{18}
\]
This is exponentially rather than superexponentially small in \(R\), but it remains far below the critical upper width \(O(R e^{-R})\) and does not furnish the missing PNT-compatible translation modulus.

## A robust microscopic covering bound

The substantial-overlap labels in (15) also rule out a ground history carried by only polynomially many prime-grid cells. Set
\[
 a_R=\frac1{8e^{2U}},\qquad
 \tau_D=\frac1{16D},\qquad
 \varepsilon_D=\frac1{4096D^2}.
\]
Suppose a measurable set \(E\subset(R,\infty)\) is a union of at most \(K\) intervals, each of length at most \(a_R\), and carries all but \(\varepsilon_D\) of the positive-half physical squared mass:
\[
 \|1_{E^c}g_R\|_2^2\le\varepsilon_D q_+.
\tag{19}
\]
Put \(g_E=1_Eg_R\). Pointwise Cauchy–Schwarz for convolution gives
\[
 |(g_R*g_R)(t)-(g_E*g_E)(t)|
 \le2\|g_R-g_E\|_2\|g_R\|_2
 \le2\sqrt{\varepsilon_D}\,q_+
 =\tfrac12\tau_Dq_+.
\tag{20}
\]
Thus every label counted in (15) also has \((g_E*g_E)(\log n)>0\).

For any ordered pair of the covering intervals, their sum has logarithmic width at most \(2a_R\). Its intersection with \((2R,2U]\) corresponds to an interval of integer labels of length at most
\[
 e^{2U}(e^{2a_R}-1)=\tfrac14+o(1)<1.
\]
So each ordered cell pair reaches at most one integer label in the window, regardless of whether that label is a prime power. At most \(K^2\) labels can have \((g_E*g_E)(\log n)>0\). Equation (15) forces
\[
 \boxed{\qquad K\ge\bigl(\tfrac12-o(1)\bigr)e^{R/2}.\qquad}
\tag{21}
\]
This is a robust resolution-\(a_R\) covering constraint for the actual ground: even after discarding up to \(\varepsilon_D\) of its physical \(L^2\) mass, exponentially many microscopic cells are needed. It is stronger in this different sense than the all-radius cap on each single microscopic interval. It does not give a lower bound on the Lebesgue width inside each occupied cell or a modulus of continuity.

The [many-cell anti-spike counterprofile](theta-antispike-grid-counterprofile.md) satisfies the available geometric and logarithmic-energy bounds but has only one active prime-power pair, and its physical form is positive. The present theorem identifies a property it lacks: the actual minimizing ground must realize a macroscopic total prime-overlap score on the critical additive scale along favorable radii. The overlap can still fluctuate sharply from label to label; (3) is not a prime-density quadrature theorem, a bound on the score-matched conditional covariance, or RH. This is written analysis, with no Lean formalization claimed.
