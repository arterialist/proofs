# An all-radius relative energy bound for the actual theta ground

The endpoint short-interval trial places the actual killed ground in a collar of width \(O(e^{-19R/20})\). That collar also limits how many prime labels can join two points carrying most of its mass. The resulting relative logarithmic-energy bound improves \(O(e^R)\) to \(O(e^{R/20})\) at every sufficiently large radius. It uses the full ground equation; the estimate is not a prime-density substitution for the unknown ground profile.

Write \(X=e^{2R}\), \(w=8X^{-19/40}=8e^{-19R/20}\), \(T=R+6w\), and \(U=R+16w\). Let \(\psi_R\) be the even positive killed ground with \(\|\psi_R\|_\nu=1\), and put

\[
 g_R=\Phi\psi_R1_{u>R},\qquad q_R=\|g_R\|_2^2,\qquad m_R=\int_R^\infty g_R(u)\,du.
\]

The [endpoint trial and crossing estimate](theta-ground-power-scale-prime-concentration.md) give

\[
 \|\psi_R1_{\{|u|>T\}}\|_\nu\le e^{-\pi Xw},
 \qquad q_R\ge\tfrac14\omega(T)^2,
 \qquad \omega^2=\Phi/b.
\tag{1}
\]

The second inequality follows from evenness: at least one quarter of the normalized mass lies on \(R<u<T\) for large \(R\), and \(\omega\) decreases there. The same endpoint result gives \(\int_U^\infty g_R/m_R\to0\). Hence Cauchy–Schwarz on \((R,U)\) yields

\[
 m_R^2\le(1+o(1))(U-R)q_R=O(wq_R).
\tag{2}
\]

## Remote prime edges

Cut the positive history at \(U\), writing \(g_c=g_R1_{u<U}\) and \(g_e=g_R-g_c\). The complete prime pairing involving \(g_e\), either within one half or across the two halves, is bounded by the normalized prime blocks of the [two-endpoint crossing theorem](theta-internal-exterior-crossing-sharp-bound.md), equations (1) and (10). Nonnegative kernels permit using its full crossing bound for the prime suboperator. The two relevant norms are at most

\[
 B_{R,U}\le C e^{2R+3U}e^{-\pi(X+e^{2U})/2},
 \qquad F_U\le C e^{5U}e^{-\pi e^{2U}}.
\tag{3}
\]

Divide by the lower bound for \(q_R\) in (1). The first exponential ratio has exponent

\[
 \pi X\left(e^{12w}-\frac{1+e^{32w}}2\right)+O(R)
 \le-3\pi Xw+O(R)
\]

for small \(w\). The far-far ratio has exponent \(\pi X(e^{12w}-e^{32w})+O(R)\). Since \(Xw=8e^{21R/20}\), both ratios are \(O(e^{-cXw})\) for a fixed \(c>0\). In particular, if \(P_R^c\) is the opposite-half prime convolution of \(g_c\), then

\[
 0\le P_R-P_R^c+S_{\rm same}(R)\le q_R O(e^{-cXw}).
\tag{4}
\]

This removes neither proper prime powers nor their remote arrivals; (4) bounds them in the original theta Hilbert space.

## Count the near prime labels

Because \(U-R=16w<\log2\), \(g_c\) has no same-half prime overlap. Its opposite-half convolution only samples labels in

\[
 X<n\le X+Y,
 \qquad Y=X(e^{32w}-1)\asymp X^{21/40}.
\tag{5}
\]

At every displacement, Cauchy–Schwarz gives \((g_c*g_c)(\log n)\le q_R\). [Yamada's arbitrary-interval Brun–Titchmarsh theorem, Theorem 2](https://arxiv.org/pdf/2312.16090) gives

\[
 \pi(X+Y)-\pi(X)<\frac{2Y}{\log Y+0.8601}.
\tag{6}
\]

Here \(\log Y=(21/40)\log X+O(1)\). Each prime label contributes at most \(\log(X+Y)/\sqrt X\), so its total weighted contribution is \(O(Y/\sqrt X)=O(X^{1/40})\). For proper powers, squares have at most \(O(Y/\sqrt X+1)=O(X^{1/40})\) possible bases. Each exponent at least three has at most two possible bases in the interval for large \(R\), and there are \(O(\log X)\) such exponents. Their combined weighted contribution is \(O((\log X)X^{-19/40}+(\log X)^2X^{-1/2})\). Thus the complete near sum obeys

\[
 \frac{P_R^c}{q_R}
 \le\sum_{X<n\le X+Y}\frac{\Lambda(n)}{\sqrt n}
 \le C X^{1/40}=C e^{R/20}.
\tag{7}
\]

The continuous opposite-half term satisfies \(C_R=\int_{2R}^\infty r(t)(g_R*g_R)(t)dt\le2e^{-R}m_R^2\) for large \(R\), so (2) gives \(C_R/q_R=O(e^{-R}w)\). The exact [ground sign-prime identity](theta-ground-sign-prime-convolution.md), with \(\delta_R=1/2-\alpha_R>0\), reads

\[
 P_R=A[g_R]-S_{\rm same}(R)+\delta_R/2-C_R.
\]

Equations (4) and (7) therefore prove the all-radius estimate

\[
 \boxed{\quad
 \frac{A[g_R]}{q_R}\le C e^{R/20},
 \qquad \frac{\|g_R\|_{\mathcal H}^2}{q_R}\le C e^{R/20}.
 \quad}
\tag{8}
\]

The second bound uses the established equivalence of the physical logarithmic norm with \(A[g_R]+O(q_R)\). The first bound is an upper budget. The existing effective-width argument gives the separate lower bound \(A[g_R]/q_R\ge(19/20-o(1))R\).

## Physical mass without the earlier \(e^R\) loss

Positivity gives \(|\widehat g_R(\xi)|\le m_R/\sqrt{2\pi}\). Split Plancherel at \(L=\exp(C_1e^{R/20})\), choosing \(C_1\) so the high-frequency part, controlled by (8), is at most \(q_R/2\). The low-frequency part is at most \(Lm_R^2/\pi\). Hence

\[
 \boxed{\qquad
 m_R\ge c\exp[-C e^{R/20}]\sqrt{q_R},
 \qquad \frac{m_R^2}{q_R}\ge c\exp[-C e^{R/20}].
 \qquad}
\tag{9}
\]

Together with (1), this improves the physical-mass lower loss used in earlier concentration arguments from \(e^{Ce^R}\) to \(e^{Ce^{R/20}}\). It still does not give a translation modulus at the spacing \(e^{-2R}\) of adjacent integer logs. The Fourier estimate would require \(\log(1/\Delta)\gg e^{R/20}\). The [prime-power discrepancy lower bound](theta-ground-mollified-prime-quadrature-closure.md) forces \(\Delta\gg e^{-2R}\) in the proposed mollified quadrature, and therefore \(\log(1/\Delta)=O(R)\). The fixed \(1/8\) sign threshold and the affine covariance residual remain open.

There is also a sharper denominator for the moving-radius covariance calculation. Its clock mass is \(a_R^{\rm clk}=\int_{O_R}\rho\psi_R\,d\nu=2\int_R^\infty e^{-u/2}g_R(u)du\). At least half of \(m_R\) lies below \(T\) eventually. Equations (1) and (9), with the positive first theta term, therefore give

\[
 a_R^{\rm clk}\ge c e^{-T/2-Ce^{R/20}}\omega(T),
 \qquad
 -\log a_R^{\rm clk}
 \le\frac{\pi}{2}e^{2R}+(48\pi+o(1))e^{21R/20}.
\tag{10}
\]

This specifies the leading theta exponent in the earlier coarse bound \(a_R^{\rm clk}\ge\exp(-C e^{2R})\). It does not control the separate affine residual numerator.

The [many-cell counterprofiles](theta-antispike-grid-counterprofile.md) fit inside this narrower collar: their width is \(O(R^2e^{-2R})\), their relative logarithmic energy is \(O(R^3)=o(e^{R/20})\), and their physical mass exceeds the lower scale in (9). Their signed prime sampling still has either sign. They fail the killed-ground energy equation, so the new bounds do not settle that signed sampling problem.

This is written analysis. The prime upper bound is classical, and every actual prime-power edge is either counted in (7) or bounded in (4); no Lean formalization of these estimates is claimed.
