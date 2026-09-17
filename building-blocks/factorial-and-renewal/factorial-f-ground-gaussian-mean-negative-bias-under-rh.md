# Conditional negative Gaussian mean of the actual full factorial-ground score

2026-09-16. **Status:** a conditional consequence of RH, the actual Euler-product explicit formula, and a published unconditional mean-square lower bound for the prime error. It does not prove RH or give an unconditional RH-scale upper estimate. The score retains the original \(F\), every \(\Lambda\) prime-power atom, the density \(-dx\), and the literal dyadic endpoint convention.

Let \(E(x)=\psi(x)-x\), \(F(x)\to\kappa_F=1+\gamma_{\rm E}>0\), \(e(u)=E(e^u)e^{-u}\), \(r(u)=e(u)/F(e^u)\), \(H(t)=t^2e^{-t}\mathbf1_{t\ge0}\), \(K=H-H'=2t(t-1)e^{-t}\mathbf1_{t\ge0}\), and \(L=\log2\). The exact full score is
\[
G_F(u)=\int_{[e^u,\infty)}\frac{H(\log(x/e^u))}{xF(x)}dE(x),
\qquad J_F(e^u)=G_F(u)-G_F(u+L).                    \tag{1}
\]
Fix \(u_0>\log2\), set \(c=1/10\), and for \(U\to\infty\) define the truncated Gaussian average
\[
g_U(u)=\frac{e^{-(u-U)^2/(2cU)}}{\sqrt{2\pi cU}},
\qquad
\mathcal A_U q=\int_{u_0}^\infty g_U(u)q(u)du,
\qquad
V_U=\mathcal A_U(e^2).                                  \tag{2}
\]
The Gaussian is not renormalized after truncation; the missing mass below \(u_0\) is \(O(e^{-U/(2c)+O(1)})\).

**Theorem (conditional mean bias).** If RH holds, then
\[
\boxed{\mathcal A_U[J_F(e^{\cdot})]
=-\left(\frac1{8\kappa_F^2}+o(1)\right)V_U,\qquad
V_U=(C_\zeta+o(1))e^{-(1-c/2)U},}                         \tag{3}
\]
Here
\[
C_\zeta=\sum_{\rho\text{ distinct}}\frac{m_\rho^2}{|\rho|^2}
=2\sum_{\gamma>0}\frac{m_\gamma^2}{1/4+\gamma^2}>0,
\qquad S_U=e^{-(1-c/2)U}.                              \tag{3a}
\]
Consequently \(\mathcal A_U[J_F(e^{\cdot})]\sim-C_\zeta S_U/(8\kappa_F^2)\), so this broad logarithmic average of the actual score is strictly negative for all sufficiently large \(U\). The coefficient \(1/8\) comes from the literal \(Y\) versus \(2Y\) difference, not from a frozen-ground approximation to the score.

## Exact identity and the positive variance floor

The ground equation is \(F'_u=-e\) almost everywhere, so \(r=-(\log F)'\). The exact Stieltjes integration-by-parts identity \(G_F=T_Kr-T_Hr^2\), followed by integration by parts in the advanced kernel, gives
\[
\boxed{G_F=T_{K'}\log(F/\kappa_F)-T_Hr^2,\qquad
T_Aq(u)=\int_0^\infty A(t)q(u+t)dt.}                    \tag{4}
\]
Here \(K(0)=K(\infty)=0\). Thus the second term is a negative positive-energy term, while the first has no sign.

The variance \(V_U\) is the exact actual-source prime-pair statistic
\[
V_U=\int_{e^{u_0}}^\infty g_U(\log x)\frac{E(x)^2}{x^3}dx. \tag{5}
\]
Expanding \(E^2=(\sum_{n\le x}\Lambda(n)-x)^2\) gives a finite sum of three separately convergent prime-pair, prime-density, and density-density terms, as detailed in [the log-curvature variance note](factorial-f-ground-log-curvature-gaussian-prime-variance.md). [Brent, Platt, and Trudgian](https://arxiv.org/abs/2008.06140) prove unconditionally that \(\int_X^{2X}E(x)^2dx\ge X^2/5374\) for every sufficiently large \(X\). Apply this on dyadic blocks whose logarithms lie within \(\sqrt U\) of \(u_*=(1-c)U\). On each such block \([X,2X]\), the weight in (5) is at least a fixed multiple of \(g_U(\log X)/X^3\), so the block contributes \(\gg g_U(\log X)/X\). There are \(\asymp\sqrt U\) disjoint blocks; completing the square gives
\[
g_U(u)e^{-u}=e^{-(1-c/2)U}
\frac{e^{-(u-u_*)^2/(2cU)}}{\sqrt{2\pi cU}}.
\]
Their sum proves \(V_U\gg e^{-(1-c/2)U}\), without RH. The same Brent--Platt--Trudgian theorem proves on RH that \(\limsup_{X\to\infty}I(X)/X^2\le0.8603\). Set \(a(v)=e^v e(v)^2=E(e^v)^2/e^v\). For \(X=e^y\),
\[
\frac{I(X)}{4X^2}\le\int_y^{y+L}a(v)dv
=\int_X^{2X}\frac{E(x)^2}{x^2}dx\le\frac{I(X)}{X^2}. \tag{5a}
\]
Under RH, every sufficiently late length-\(L\) block therefore has \(a\)-mass between fixed positive constants. With \(S_U=e^{-(1-c/2)U}\), \(W=(1-c)U\), and \(g_{W,cU}\) the Gaussian density with mean \(W\) and variance \(cU\), completing the square gives
\[
V_U=S_U\int_{u_0}^\infty g_{W,cU}(v)a(v)dv.       \tag{5b}
\]
Summing the bounded block masses against this broad Gaussian proves \(V_U\asymp S_U\) on RH. Its lower half is unconditional.

The sharper limit in (3) is a specialization of classical explicit-formula mean-square theory. Here is a direct proof that also checks the moving Gaussian and the high-zero tail. Set \(A(v)=e^{-v/2}E(e^v)\), so \(a(v)=A(v)^2\). Under RH the truncated explicit formula of [Akbary, Ng, and Shahabi](https://arxiv.org/abs/1306.1657), equation (1.5), gives, uniformly on \(v\ge u_0\),
\[
A(v)=-\sum_{|\gamma|\le T}\frac{m_\gamma e^{i\gamma v}}{1/2+i\gamma}
+O\left(\frac{e^{v/2}(v+\log T)^2}{T}+ve^{-v/2}\right). \tag{5c}
\]
The stated error includes the \(O(\log x)\) allowance at prime-power jumps. Take \(T=e^{2U}\) and restrict first to \(|v-W|\le U^{3/4}\), where \(W=(1-c)U\). The error in (5c) tends uniformly to zero there. The complementary Gaussian tail contributes \(o(1)\) to the second moment: the RH bound \(A(v)\ll(1+v)^2\) and the truncated zero-sum bound \(\sum_{|\gamma|\le T}m_\gamma/|\rho|\ll(1+\log T)^2\) suffice.

To control the remaining high zeros uniformly in \(U\), group their signed ordinates into unit bins. The zero-count estimate gives bin masses
\(b_k=\sum_{k\le\gamma<k+1}m_\gamma/|\rho|\ll\log(2+|k|)/(1+|k|)\). Gaussian integration of a pair of modes has absolute value \(e^{-cU(\gamma-\gamma')^2/2}\). Therefore, for \(cU\ge1\), the high-zero Gaussian mean square is at most
\[
\sum_{k,l}b_kb_l e^{-(|k-l|-1)_+^2/2}
\ll\sum_{|k|>R-1}b_k^2
\ll\frac{\log^2 R}{R},                                \tag{5d}
\]
when only \(|\gamma|>R\) are retained, uniformly in \(T\) and in the moving center \(W\). For a fixed finite set of zeros, the same Gaussian pair integral tends to zero off the diagonal and to one on it. Cauchy--Schwarz and the bounded Gaussian second moment of \(A\) (from (5a)) then allow \(R\to\infty\), proving
\[
\int_{u_0}^\infty g_{W,cU}(v)A(v)^2dv\longrightarrow
\sum_{\rho\text{ distinct}}m_\rho^2/|\rho|^2=C_\zeta. \tag{5e}
\]
The lower cutoff contributes \(o(1)\). No simplicity or linear-independence assumption on the ordinates is used.

## The curvature term is smaller on RH

Let \(f(u)=F(e^u)-\kappa_F\). Integrating the classical explicit formula for \(E\) once gives an **absolutely convergent** ground spectrum
\[
f(u)=-\sum_\rho\frac{e^{(\rho-1)u}}{\rho(1-\rho)}
-(\log2\pi)e^{-u}
+\sum_{k\ge1}\frac{e^{-(2k+1)u}}{2k(2k+1)}.       \tag{6}
\]
Absolute convergence follows from \(N(T)=O(T\log T)\) and \(|\rho(1-\rho)|^{-1}\ll(1+|\Im\rho|)^{-2}\). Under RH, (6) reads
\[
f(u)=e^{-u/2}q(u)-(\log2\pi)e^{-u}+O(e^{-3u}),
\quad
q(u)=-\sum_{\gamma}\frac{m_\gamma e^{i\gamma u}}
{(1/2+i\gamma)(1/2-i\gamma)},                       \tag{7}
\]
where the sum over distinct signed ordinates is absolutely and uniformly convergent. In particular \(f=O(e^{-u/2})\). Expanding \(\log(F/\kappa_F)=f/\kappa_F-f^2/(2\kappa_F^2)+O(f^3)\) is uniform on a late tail.

For a mode \(e^{(-a+i\nu)u}\), the full-line Gaussian moment is
\[
\int_{\mathbb R}g_U(u)e^{(-a+i\nu)u}du
=\exp\!\left[(-a+i\nu)U+\frac{cU}{2}(-a+i\nu)^2\right]. \tag{8}
\]
For \(a\in[1/2,3]\), replacing \(\mathbb R\) by \([u_0,\infty)\) costs \(O(e^{-U/(2c)+O(1)})\), uniformly in \(\nu\), because the modulus on \(( -\infty,u_0]\) is monotone increasing toward \(u_0\) when \(U\) is large and \(1/c>a\). This is used only for the critical-zero series \(q\), its square, and bounded decay exponents. The entire trivial-zero tail \(k\ge1\) in (6) is treated together by \(O(e^{-3u})\) on \(u\ge u_0\); no full-line Gaussian moment is applied termwise to arbitrarily large \(2k+1\).

The multiplier of \(T_{K'}\) is bounded for these modes; \(T_{K'}e^{-u}=0\) exactly because
\(\int_0^\infty K'(t)e^{-t}dt=\int_0^\infty K(t)e^{-t}dt=0\). [Platt and Trudgian](https://arxiv.org/abs/2004.09765) rigorously verify the low zeros, in particular \(|\gamma|>14\). Thus the critical-zero modes in the **linear** \(f\) term of (7), after (8), are \(o(S_U)\) where \(S_U=e^{-(1-c/2)U}\): their magnitude is at most
\[
\exp\left[-\left(\tfrac12-\tfrac c8+\tfrac c2\gamma^2\right)U\right]
=o(S_U).
\]
The remaining trivial-zero modes are smaller as well.

The leading **quadratic** term is \(f(u)^2=e^{-u}q(u)^2+O(e^{-3u/2})\). Since \(q\) has absolutely summable Fourier coefficients, so does \(q^2\). Its frequency-zero coefficient is annihilated exactly by \(T_{K'}e^{-u}=0\). Every nonzero frequency \(\nu\) in \(q^2\) gains, after (8), the factor \(e^{-c\nu^2U/2}\) relative to \(S_U\). The kernel and dyadic multipliers are bounded, so dominated convergence over the absolutely summable coefficients gives \(o(S_U)\), even if nonzero frequency differences approach zero. The \(O(e^{-3u/2})\) remainder has Gaussian average \(O(e^{-(3/2-9c/8)U})=o(S_U)\). Therefore
\[
\boxed{\mathcal A_U\Delta_L T_{K'}\log(F/\kappa_F)=o(S_U)=o(V_U).} \tag{9}
\]

## The energy coefficient is \(1/8\)

Swapping the nonnegative \(H\)-integral with the Gaussian average gives
\[
\mathcal A_U\Delta_LT_Hr^2
=\int_{u_0}^\infty r(v)^2W_U(v)dv,
\]
where, with Gaussian values below \(u_0\) set to zero,
\[
W_U(v)=\int_0^\infty H(t)
\left[g_U(v-t)\mathbf1_{v-t\ge u_0}
      -g_U(v-L-t)\mathbf1_{v-L-t\ge u_0}\right]dt.   \tag{10}
\]
There is a direct ratio proof that uses the bounded block masses in (5a). For fixed \(h\ge0\), change variables \(v=u+h\) and complete the square to obtain, up to an exponentially small lower-cutoff error,
\[
\mathcal A_U[e(\cdot+h)^2]
=e^{-h}S_U\int g_{W+h,cU}(v)a(v)dv.                \tag{11}
\]
Gaussian convolution with a positive measure whose every late length-\(L\) block has bounded mass is uniformly translation-continuous for fixed \(h\) as its variance tends to infinity: summing the difference of the two Gaussian densities over blocks costs \(O(h/\sqrt U)\), while (5b) is bounded below. Thus the ratio of (11) to \(V_U\) tends to \(e^{-h}\). The block upper bound also gives a majorant \(\mathcal A_U[e(\cdot+h)^2]/V_U\ll e^{-h}\) uniformly for \(h\ge0\). Dominated convergence against \(H(t)dt\), with \(h=t\) and \(h=L+t\), proves
\[
\frac{\mathcal A_U\Delta_LT_He^2}{V_U}
\longrightarrow(1-e^{-L})\int_0^\infty H(t)e^{-t}dt
=\frac12\cdot\frac14=\frac18.                    \tag{11a}
\]
Finally \(F(e^v)\to\kappa_F\) uniformly on late tails. The bounded block masses give only \(o(V_U)\) weight to any fixed early interval under these shifted Gaussian integrals, so replacing \(e^2\) with \(r^2=e^2/F^2\) multiplies the limit by \(\kappa_F^{-2}\). Equivalently, with \(V_U^F:=\mathcal A_U(r^2)\),
\[
\mathcal A_U\Delta_LT_Hr^2
=\left(\frac18+o(1)\right)V_U^F,
\qquad
V_U^F=\left(\kappa_F^{-2}+o(1)\right)V_U.             \tag{12}
\]
Combining (4), (9), and (12) proves (3). The signed dyadic score is not eventually negative pointwise; the theorem concerns only this broad Gaussian log average under RH.
