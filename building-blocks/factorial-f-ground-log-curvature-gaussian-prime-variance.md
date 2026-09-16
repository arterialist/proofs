# Log curvature and the Gaussian prime-error variance in the actual factorial ground

2026-09-16. **Status:** exact original-\(F\) identity and an unconditional lower floor for a positive Gaussian prime-error variance. The floor is not an RH-scale upper estimate for the score. No zero-free strip or RH claim is proved.

Let \(E(x)=\psi(x)-x\), \(F(x)\to\kappa_F>0\) be the actual factorial ground, and for \(u>\log2\) write
\[
e(u)=\frac{E(e^u)}{e^u},\qquad
r(u)=\frac{e(u)}{F(e^u)},\qquad
\phi(u)=\log\frac{F(e^u)}{\kappa_F}.
\]
The ground equation gives \(F'_u=-e\) almost everywhere and therefore \(r=-\phi'\). With \(H(t)=t^2e^{-t}\mathbf1_{t\ge0}\), \(K=H-H'=2t(t-1)e^{-t}\mathbf1_{t\ge0}\), and \(T_Aq(u)=\int_0^\infty A(t)q(u+t)dt\), the exact full-score profile in [the full-score note](factorial-f-ground-full-score-rh-criterion.md) is \(G_F=T_Kr-T_Hr^2\). Since \(K(0)=K(\infty)=0\), integration by parts gives the **exact log-curvature identity**
\[
\boxed{G_F(u)=T_{K'}\phi(u)-T_Hr^2(u),\qquad
 J_F(e^u)=\Delta_{\log2}G_F(u).}                       \tag{1}
\]
The second term is a positive weighted energy with a negative sign. The first is signed; \(\int_0^\infty K'(t)dt=0\), but this does not make it small. The dyadic difference \(\Delta_{\log2}q(u)=q(u)-q(u+\log2)\) also has no sign. Equation (1) retains the actual \(\Lambda\) atoms, their continuous \(-dx\) density, and the exact original \(F\).

There is a useful actual-source spectral check on the ground itself. Integrating the classical explicit formula for \(E\) against \(dt/t^2\) gives, for \(u>0\),
\[
F(e^u)-\kappa_F
=-\sum_\rho\frac{e^{(\rho-1)u}}{\rho(1-\rho)}
 -(\log2\pi)e^{-u}
 +\sum_{k\ge1}\frac{e^{-(2k+1)u}}{2k(2k+1)}.       \tag{2}
\]
The zero series is absolutely convergent because \(N(T)=O(T\log T)\) and \(|\rho(1-\rho)|^{-1}=O(|\Im\rho|^{-2})\). Thus \(F-\kappa_F\), unlike \(E/x\), has an absolutely convergent zero expansion. Squaring (2) legitimately gives an absolutely convergent pair-of-zeros expression for \((F-\kappa_F)^2\). This does not control the signed term in (1): differentiating the series to recover \(e\) loses one power of \(|\Im\rho|\), and the squared-error term below is still an independent arithmetic variance.

## The positive variance and its exact prime-pair form

Fix \(u_0>\log2\) and \(0<c<1\). For \(U\to\infty\) put
\[
g_U(u)=\frac1{\sqrt{2\pi cU}}
       \exp\!\left(-\frac{(u-U)^2}{2cU}\right),
\quad
V_U=\int_{u_0}^\infty g_U(u)e(u)^2du,
\quad
V_U^F=\int_{u_0}^\infty g_U(u)r(u)^2du.             \tag{3}
\]
Both are nonnegative. Since \(F\to\kappa_F\) and the Gaussian mass below any fixed late tail is exponentially small, \(V_U^F\) has the same exponential upper and lower scales as \(V_U\) (constants may depend on \(F,u_0,c\)). In \(x\)-coordinates,
\[
V_U=\int_{x_0}^\infty
       g_U(\log x)\frac{E(x)^2}{x^3}dx,\qquad x_0=e^{u_0}. \tag{4}
\]
Define positive tail kernels
\[
A_U(y)=\int_{\max(x_0,y)}^\infty\frac{g_U(\log x)}{x^3}dx,
\quad
B_U(y)=\int_{\max(x_0,y)}^\infty\frac{g_U(\log x)}{x^2}dx,
\quad
C_U=\int_{x_0}^\infty\frac{g_U(\log x)}x dx.
\]
Expanding \(E(x)^2=(\sum_{n\le x}\Lambda(n)-x)^2\) and using Tonelli for its separate nonnegative pieces gives the exact actual-source **prime-pair variance**
\[
\boxed{V_U=
 \sum_{m,n\ge2}\Lambda(m)\Lambda(n)A_U(\max(m,n))
 -2\sum_{n\ge2}\Lambda(n)B_U(n)+C_U.}               \tag{5}
\]
All three terms are finite for each \(U\). Every prime power is present. Formula (5) makes clear that an upper bound for the positive variance still requires cancellation between large pair and density terms; positivity of \(V_U\) only gives a lower bound.

## Unconditional floor, conditional ceiling, and fixed-power cost

[Brent, Platt and Trudgian](https://arxiv.org/abs/2008.06140) prove unconditionally that, for all sufficiently large \(X\),
\[
I(X):=\int_X^{2X}E(x)^2dx\ge\frac{X^2}{5374}.       \tag{6}
\]
Apply (6) on dyadic blocks \([X_j,2X_j]\), \(X_j=2^j\), with \(u_j=\log X_j\) near the center \(u_*=(1-c)U\). On each block,
\[
\int_{X_j}^{2X_j}g_U(\log x)\frac{E(x)^2}{x^3}dx
\ge\frac{1}{8\cdot5374\,X_j}
       \inf_{u_j\le u\le u_j+\log2}g_U(u).             \tag{7}
\]
For \(|u_j-u_*|\le\sqrt U\), the infimum is comparable to \(g_U(u_j)\), uniformly in \(j,U\); there are \(\asymp\sqrt U\) such disjoint blocks. Completing the square in \(g_U(u)e^{-u}\) shows
\[
g_U(u)e^{-u}
=e^{-(1-c/2)U}
 \frac{\exp[-(u-u_*)^2/(2cU)]}{\sqrt{2\pi cU}}.
\]
Summing (7) over those blocks proves the unconditional, source-specific floor
\[
\boxed{V_U\gg_c e^{-(1-c/2)U},\qquad
       V_U^F\gg_{c,F} e^{-(1-c/2)U}.}                  \tag{8}
\]
This lower bound is compatible with RH and does not upper-bound \(G_F\) or \(J_F\). It says the positive energy in (1) cannot simply be declared negligible under broad averaging.

The same [Brent--Platt--Trudgian theorem](https://arxiv.org/abs/2008.06140) gives, under RH, \(\limsup_{X\to\infty}I(X)/X^2\le0.8603\). Put \(a(v)=e^v e(v)^2=E(e^v)^2/e^v\). For \(X=e^y\),
\[
\frac{I(X)}{4X^2}\le\int_y^{y+\log2}a(v)dv
=\int_X^{2X}\frac{E(x)^2}{x^2}dx\le\frac{I(X)}{X^2}.
\]
Thus the mass of \(a\) on every sufficiently late log-dyadic block lies between fixed positive constants on RH. Completing the square in the Gaussian gives the exact formula
\[
V_U=e^{-(1-c/2)U}
\int_{u_0}^\infty
\frac{e^{-(v-(1-c)U)^2/(2cU)}}{\sqrt{2\pi cU}}a(v)dv.
\]
Summing the bounded block masses against this broad Gaussian proves the stronger conditional ceiling
\[
\boxed{V_U,\ V_U^F\ll_c e^{-(1-c/2)U}.}         \tag{9}
\]
Together with (8), this fixes the conditional exponential scale up to absolute constants. Unconditionally, a Vinogradov--Korobov prime-number-theorem error \(|e(u)|\ll\exp[-c_0u^{3/5}(\log u)^{-1/5}]\) only gives the corresponding stretched-exponential upper bound for \(V_U\), with twice its input exponent constant after an arbitrarily small loss. This is much larger than the fixed-power scale in (8).

**RH-equivalent variance ceiling.** For this fixed \(0<c<1\), the assertion
\[
V_U\ll_\varepsilon \exp[-(1-c/2-\varepsilon)U]
\quad\text{for every }\varepsilon>0                         \tag{9a}
\]
is equivalent to RH. The forward implication of RH is the stronger (9). Conversely, set \(U=(\log X)/(1-c)\). Uniformly for \(x\in[X,2X]\),
\(g_U(\log x)\asymp_c U^{-1/2}e^{-cU/2}\). Equations (4) and (9a) therefore give, for every \(\eta>0\),
\[
I(X)\ll_\eta \sqrt{\log X}\,X^{2+\varepsilon/(1-c)}
\ll_\eta X^{2+\eta},                                  \tag{9b}
\]
by choosing \(\varepsilon<(1-c)\eta\). Cauchy--Schwarz on dyadic blocks now shows \(\int_1^\infty |E(x)|x^{-\sigma-1}dx<\infty\) for every real \(\sigma>1/2\). The Mellin identity
\[
\int_1^\infty E(x)x^{-s-1}dx
=\frac{-\zeta'(s)/\zeta(s)}s-\frac1{s-1}
\]
then continues \(-\zeta'/\zeta\) without zero poles through \(\Re s>1/2\), which implies RH by the functional equation. This is a reweighting of the classical mean-square criterion, not a new upper bound.

The cost of asking for a fixed-power upper bound on this **positive variance** can be proved directly, including prime-power jumps. Suppose for some \(\delta>0\) that \(V_U=O(e^{-\delta U})\) for all large \(U\); replace \(\delta\) by a smaller number below \(1\) if needed. Let \(X=e^U\) and \(A=|E(X)|/X=o(1)\). If \(E(X)>0\), monotonicity of right-continuous \(\psi\) gives
\[
E(x)\ge E(X)-(x-X)\ge\tfrac34 AX
\quad(X\le x\le X(1+A/4)).
\]
If \(E(X)<0\), the same monotonicity gives
\[
E(x)\le E(X)+(X-x)\le-\tfrac34 AX
\quad(X(1-A/4)\le x\le X).
\]
The appropriate one-sided logarithmic interval has length \(\gg A\), contains its endpoint even when \(X\) is a prime power, and satisfies \(|e(u)|\ge A/2\). On that interval \(g_U(u)\gg_c U^{-1/2}\), so
\[
V_U\gg_c\frac{A^3}{\sqrt U}.
\]
Hence \(E(X)/X\ll U^{1/6}e^{-\delta U/3}\), and for every \(\varepsilon>0\),
\[
E(X)=O_\varepsilon(X^{1-\delta/3+\varepsilon}).       \tag{10}
\]
The Mellin identity
\(\int_1^\infty E(x)x^{-z-1}dx
=z^{-1}(-\zeta'/\zeta)(z)-(z-1)^{-1}\)
then excludes zeros of \(\zeta\) in \(\Re z>1-\delta/3\). Thus a fixed-power estimate for (3) would already provide a fixed zero-free strip. Neither (6) nor positivity gives such an upper estimate.

The dyadic score remains subtler than its positive energy. Applying \(\Delta_{\log2}\) to (1) gives a signed difference of two positive energies plus the signed curvature term. The unconditional floor (8) cannot be assigned a sign after this difference; any RH-scale score bound still requires cancellation of these exact terms.
