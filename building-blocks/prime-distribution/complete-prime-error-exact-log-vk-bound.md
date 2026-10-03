# An exact-log bound for the complete prime-error row

The complete arithmetic row admits a Vinogradov--Korobov upper bound with its exact leading coefficient and two diverging smaller-scale savings. This removes the arbitrary fixed leading loss in the repository's [zero-cluster bound](actual-eq22-zero-cluster-bound.md). The result covers every sufficiently large real cutoff, retains every prime power and cofactor, and gives a stronger allowance for the complete signed object. The contour estimate is a written analytic proof, not a kernel-checked upper bound. It does not prove its eventual sign, a fixed zero-free strip or RH. No literature-priority claim is made.

## Actual sum, bound and range

Let \(\Lambda\) be the actual von Mangoldt function and
\(b(n)=\sum_{ab=n}\Lambda(a)\Lambda(b)\), with positive integer factors. For real \(y>1\), put
\[
U(y)=\sum_{n\le y}\left[(y-n)b(n)-\Lambda(n)\frac{y^2-n^2}{n}\right]
       +\frac{y^2}{2}\log y+\frac{y^2}{4}-\frac14,
\qquad U(y)=0\quad(y\le1),
\]
and define the complete square-root aggregate
\[
N_{\rm full}(x)=\sum_{d\le x}\sqrt d\,U(x/d). \tag{1}
\]
All sums use positive integers at the literal real cutoff. The equality term has zero weight. In particular \(\Lambda(p^j)=\log p\) at every proper power, and every positive cofactor \(d\) is included. The continuous baseline and its constant term remain in (1).

For sufficiently large \(x\), write
\[
L=\log x,\qquad R=\log L,\qquad M=\log R,
\qquad \Phi(x)=L^{3/5}R^{-1/5}.
\]
Use the fixed constants
\[
A_0=\frac1{48.0712256382},\qquad
d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5},\qquad
c=2^{2/5}d=0.280501949731\ldots,
\qquad \kappa_0=\frac c3\log\frac5c>0. \tag{2}
\]
The exact expressions in (2), rather than rounded decimals, define the constants.

**Theorem.** For every fixed \(0<\kappa<\kappa_0\), there are constants \(C_\kappa>0\) and \(x_\kappa\) such that, for every real \(x\ge x_\kappa\),
\[
\boxed{\quad
|N_{\rm full}(x)|\le C_\kappa x^2
\exp\left[-c\Phi(x)-\frac c{15}\frac{\Phi(x)M}{R}
                        -\kappa\frac{\Phi(x)}R\right].\quad} \tag{3}
\]
The onset includes positivity of the iterated logarithms. No effective onset, uniform \(\kappa\)-endpoint or larger leading coefficient is asserted. The same estimate holds for \(|C(x)|+|N_{\rm full}(x)|\), where \(C\) is the literal complete Eq22 residual defined in the [previous contour theorem](actual-eq22-zero-cluster-bound.md).

The previous complete bound was
\(O_\varepsilon(x^2e^{-(c-\varepsilon)\Phi(x)})\) for every fixed \(0<\varepsilon<c\). The envelope in (3) divided by that envelope tends to zero. The analogous [tertiary Goldbach bound](../goldbach/goldbach-cofactor-tertiary-vk-gain.md) concerns a different additive cofactor sum and the printed zero-free denominator \(48.0718\); its formula alone does not establish (3).

## Fixed arithmetic inputs and a uniform contour

The [degree-110 exact certificate](../../unique-contributions/asymptotic-zeta-zero-free-48-0712256382/README.md), combined with [Mossinghoff--Trudgian--Yang, Section 8, formula (8.2)](https://arxiv.org/abs/2212.06867) and the zeta bound with \(B=4.43795\) in [Bellotti's Theorem 1.1](https://arxiv.org/abs/2306.10680), gives
\[
\beta\le1-A_0u(|\gamma|),\qquad
u(T)=(\log T)^{-2/3}(\log\log T)^{-1/3}, \tag{4}
\]
for every sufficiently high actual zero \(\rho=\beta+i\gamma\). The certificate's denominator is distinguished from Bellotti's printed \(48.0718\). Its rational audit checks the finite polynomial and constant comparison; it does not formalize the analytic zero-free theorem.

The moving near-one density threshold is paid by [Chourasiya--Simonič, arXiv2507.15184v2, Corollary 1 and the last row of Table 1](https://arxiv.org/html/2507.15184#S1). For every \(T\ge3\cdot10^{12}\) and \(31/32\le\sigma\le1\),
\[
N(\sigma,T)\le46.06T^{3(1-\sigma)/(2-\sigma)}
                  (\log T)^{(7-5\sigma)/(2-\sigma)}
                +4.897\log^2T+86.84\log T. \tag{5}
\]
Here \(N(\sigma,T)\) counts zeros with \(\beta\ge\sigma\) and \(0<\gamma\le T\), with multiplicity. Reflection pays the corresponding lower contour separately. The fixed interval in (5) prevents a hidden fixed-\(\sigma\) constant from being used as \(\sigma\) tends to one. This proof uses the cited theorem; it does not reproduce its upstream numerical verifications.

The complete Mellin identity and inversion from the [zero-cluster construction](actual-eq22-zero-cluster-bound.md) use
\[
H_a(s)=\frac{\zeta(s-1/2)}{s(s-1)}[g(s)+a]^2,
\qquad g(s)=\frac1{s-2}+\frac{\zeta'}{\zeta}(s-1),\qquad a=0,1. \tag{6}
\]
The parameters \(a=0\) and \(a=1\) correspond to \(C\) and \(N_{\rm full}\). Initially \(\Re s>2\), inversion is absolutely convergent. The point \(s=2\) is removable. The zero-derived poles are \(1+\rho\); the full cofactor multiplier \(\zeta(s-1/2)\) is retained. Real integer seams cause no exceptional cutoffs because the Riesz weights vanish there.

Choose a fixed sufficiently large \(Q_0\), beyond the onset of (4), the range of (5), and with \(2A_0u(4Q_0)\le1/32\). Set \(Q_j=2^jQ_0\) and change the contour's clearance coefficient to
\[
A_1(x)=A_0(1-R^{-2}),\qquad
\eta_j=A_1(x)u(4Q_j),\qquad
r_j=\frac1{L\log^3(3Q_j)}. \tag{7}
\]
For large \(x\), \(A_0/2\le A_1<A_0\). Uniformly for all \(Q\ge Q_0\),
\[
\frac{r_Q}{(A_0-A_1)u(4Q)}
=\frac{R^2}{A_0L}\frac1{\log^3(3Q)u(4Q)}
\le C(Q_0)\frac{R^2}L\longrightarrow0. \tag{8}
\]
The last factor is bounded on the whole half-ray and tends to zero at infinity. The ratio \(r_Q/[A_1u(4Q)]\) also tends uniformly to zero. Thus the radius condition in the earlier graph construction holds with a fixed numerical margin for every block, including the fixed-height head.

The graph starts with baseline \(2-2\eta_j+r_j\) and rises to the right of each near pole within its \(2r_j\) ordinate neighborhood. A near peak is at most
\(2-A_0u(4Q_j)+r_j\le2-A_1u(4Q_j)\). Its distance from every pole is paid by \(r_j\), rather than by \(A_0-A_1\). Local zero counting and the partial-fraction formula therefore retain the uniform bound
\[
|g(s)+a|\ll L\log^4(3Q_j),\qquad a\in\{0,1\}. \tag{9}
\]
The strip is fixed; \(\zeta(s-1/2)\) is bounded there because its real argument stays above one by a fixed margin. No inverse-gap constant is hidden in (9).

Coincident ordinates and multiplicities do not change the graph estimate. The total variation of the maximum of the tents is bounded by the sum of their variations. Their bumped arc length is consequently \(O(N_j(\eta_j+r_j))\), with \(N_j\le N(1-2\eta_j,4Q_j)\). Common zero-avoiding boundaries and their collar interpolations join adjacent graphs into one contour; the collars have the far-piece estimate below with \(Q_j^{-2}\) in place of \(Q_j^{-1}\).

The resulting complete block estimates are
\[
\begin{aligned}
I_{\rm near}(Q)&\ll x^2e^{-A_1u(4Q)L}\frac{N_Q}{Q^2}
                         L^2\log^{O(1)}(3Q),\\
I_{\rm far}(Q)&\ll x^2e^{-2A_1u(4Q)L}\frac1Q
                         L^2\log^{O(1)}(3Q). \tag{10}
\end{aligned}
\]
The constants in (9)--(10) are independent of the changing \(A_1\). The original contour remains to the right of every zero-derived pole and crosses none; individual residues or reciprocal zero gaps are not used.

## Exact logarithms and every remaining piece

On a fixed compact interval \(0<a\le z\le b\), put \(Q=e^{z\Phi}\) and
\(G(z)=A_0(5/3)^{1/3}z^{-2/3}\). The exact logarithms give, uniformly,
\[
\frac{A_1u(4e^{z\Phi})L}{\Phi}
=G(z)\left[1+\frac{M-5\log z}{9R}
                +O_{a,b}\!\left(\frac{M^2}{R^2}\right)\right]. \tag{11}
\]
Indeed \(\log\log(4e^{z\Phi})=(3R-M)/5+\log z+O(1/\Phi)\). The fixed shift \(\log4\) is negligible at the displayed scale, and the replacement \(A_0\mapsto A_1\) costs only \(O(R^{-2})\).

The function \(2z+G(z)\) has a unique strict minimum at
\[
z_0=c/5,\qquad G(z_0)=3c/5.
\]
The first two derivatives of the perturbation in (11) are uniformly \(O(M/R)\). Its minimizer is \(z_0+O(M/R)\), and the displacement changes the minimum only by \(O(M^2/R^2)\). Hence
\[
\min_z\left[2z+\frac{A_1u(4e^{z\Phi})L}{\Phi}\right]
=c+\frac c{15}\frac MR+\frac{\kappa_0}R
                  +O\!\left(\frac{M^2}{R^2}\right). \tag{12}
\]
The compact interval is chosen with \(z_0\) in its interior and fixed gaps at its endpoints.

At the same heights, (5) gives
\[
\log(1+N_Q)=O(u(Q)\log Q+\log\log Q)
=O(\Phi^{1/3}R^{-1/3}+R)=o(\Phi/R). \tag{13}
\]
All polynomial factors in (10), and the \(O(\Phi)\) dyadic blocks, have logarithmic cost \(O(R)=o(\Phi/R)\). Since \(M^2/R\to0\), the near sum in (10) is bounded by (3) for every fixed \(\kappa<\kappa_0\).

For completeness, choose fixed \(a\) small enough that \(G(a)>c+1\), fixed \(b>c+1\), and fixed terminal \(K>b+1\). Below \(e^{a\Phi}\), monotonicity of \(u\) and the convergent dyadic total-count bound \(\sum_Q N(4Q)Q^{-2}\log^{O(1)}(3Q)<\infty\) give a fixed leading gap. Above \(e^{b\Phi}\), ordinary zero counting gives a contribution at most \(x^2\exp[-b\Phi+O(R)]\). The far rate \(z+2G(z)\) has minimum \(2^{3/5}d>c\), so its fixed leading gap absorbs both smaller-scale savings. The shared collars are smaller than the far terms.

Take the last dyadic height between \(e^{K\Phi}\) and \(2e^{K\Phi}\), and choose its common zero-avoiding terminal ordinate. The horizontal joins cost \(O(x^2L^2\log^{O(1)}H/H^2)\); the original-line tails cost \(O(x^2L^2/H)\). Both have a fixed leading gap. A fixed low-height line remains to the right of the finitely many low zero-derived poles and to the right of \(3/2\). Its piece and joining segment have a fixed power saving after polynomial logarithms are absorbed. The poles at \(0,1,3/2\) stay to its left, and the filled point \(2\) contributes no residue. These estimates retain every head, collar, far, terminal and tail contribution. Together with (10)--(13), they prove (3) for both values of \(a\) in (6).

## Signed consumer and verification limits

Define the complete same-prime allocation
\[
\Delta(x)=\sum_{d\le x}\sqrt d\sum_{n\le x/d}
 (x/d-n)\Lambda(n)[\log n-\Lambda(n)].
\]
The actual object in the [kernel-checked criterion](../zeta-and-zeros/actual-critical-sign-criterion.md) satisfies exactly
\[
W(x)=N_{\rm full}(x)-\Delta(x). \tag{14}
\]
Thus (3) improves the complete signed allowance for \(|W+\Delta|\). It supplies no sign for \(W\). The existing written asymptotic is \(\Delta(x)\sim x^{3/2}\log^2x/6\), while the envelope in (3) divided by that scale tends to infinity: its logarithm is \(\frac12L-o(L)\). The arithmetic premise of `ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos` remains unproved. No full primitive-energy saving or RH conclusion follows.

The [native Lean 4.24 companion](../../formalization/BuildingBlocks/ActualFullCenteredMellin.lean) proves the actual core and aggregate Mellin identities, absolute convergence, support below one, real-valuedness, the all-real cofactor dictionary and the exact split (14). `N_eq_real_cutoff` retains the literal ordered Mangoldt convolution and baseline; `fullNumerator_eq_Icc` retains every cofactor; `W_eq_fullNumerator_sub_allocation` uses the existing actual criterion object. The full numerator identity has domain Re(s)>1, while the complete proper-power allocation identity has domain Re(s)>1/2. No analytic upper estimate is assumed or proved in this module.

The [public axiom audit](../../formalization/verification/ActualFullCenteredMellinAudit.lean) prints all 24 public theorem dependencies. Its independent root replay agrees exactly with the producer replay; every row uses only `propext`, `Classical.choice` and `Quot.sound`. The required full repository `lake build` passed. The [verification record](../../formalization/verification/actual-full-centered-mellin/README.md) binds the source, toolchain and audit evidence.

The new contour estimate, exact-log expansion, zero-free and density inputs, and same-prime asymptotic remain written mathematics. The [independent analytic audit](../../reviews/papers/complete-prime-error-exact-log-bound-audit.md) checks every contour piece and the stated limits. No unconditional kernel proof of (3), effective constant or onset, whole-source proof replay, or novelty claim is supplied.
