# Microscopic anti-spikiness alone does not control signed prime sampling

The [actual-ground anti-spike theorem](theta-ground-microscopic-interval-antispike.md) bounds the physical \(L^2\) mass of every interval of length at most \(e^{-2R}/4\) inside \(R<|u|<R+R^{-2}\) by \(C/R^2\) of the total. This is new information about the actual eigenfunction. The construction below checks its logical reach: even imposing that bound on smooth comparison profiles, together with the previously proved concentration and relative logarithmic-energy bounds, does not force the normalized lost–retained prime sampling to be small or have one sign. The examples are not killed-ground eigenfunctions.

Use the signed arrival functional from the [lost–retained obstruction](theta-lost-retained-prime-sampling-obstruction.md):
\[
 \mathcal D_R(s;g)=\int_R^{R+s}g(w)
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [g(\log n-w)-g(\log n-w+2s)]\,dw .
\tag{1}
\]
The sum includes every prime power. The positive-half weighted mass is \(G_-(g)=\int_R^\infty e^{u/2}g(u)\,du\). We construct two profiles with opposite values of (1) and
\[
 \left|\mathcal D_R(s;g_\pm)\right|/G_-(g_\pm)^2\longrightarrow\infty.
\tag{2}
\]

## One active prime power and many inactive grid cells

Let \(Q=2^j\to\infty\), \(s=Q^{-2}\), \(h=s/100\), and \(R=\tfrac12\log Q-2s\). Choose a nonnegative even \(\chi\in C_c^\infty(-1,1)\) with \(\|\chi\|_2=1\), and put \(\chi_h(u)=h^{-1/2}\chi(u/h)\). Set \(N=\lceil R^2\rceil\) and
\[
 a=R+s/2,\qquad b_+=\log Q-a=R+7s/2,\qquad
 b_-=b_++2s=R+11s/2,
\]
\[
 c_k=\log(Q+2k)-a,\qquad 1\le k\le N.
\tag{3}
\]
For each sign, take the positive-half history
\[
 g_\pm(u)=A_\pm\left[
 \chi_h(u-a)+\chi_h(u-b_\pm)+
 \sum_{k=1}^{N}\chi_h(u-c_k)\right],
\tag{4}
\]
with \(A_\pm>0\) arbitrary for now, and reflect it evenly for the full physical profile. If desired, choose \(A_\pm\) to normalize \(\psi_\pm=(g_\pm+g_\pm^\vee)/\Phi\) in \(L^2(\nu)\); none of the ratios below depends on that choice.

The centers in (3) are pairwise separated except for the deliberate active pair \(a,b_\pm\). The dummy centers have spacing
\[
 c_{k+1}-c_k=\log\frac{Q+2k+2}{Q+2k}\sim 2/Q,
\]
and \(c_1-b_\pm\sim2/Q\). All centers lie in \(R<u<R+O(N/Q)\), which is contained in \(R<u<R+R^{-2}\) for large \(j\). The first bump lies strictly inside the lost strip \((R,R+s)\), while all others lie outside it.

The arithmetic choice of the dummy centers matters. For \(1\le k\le N\), \(Q<Q+2k<2Q\) eventually. Each \(Q+2k\) is even and is not a power of two, so
\[
 \Lambda(Q+2k)=0.
\tag{5}
\]
Every even prime power has base two, and \(Q,2Q\) are consecutive powers of two. Thus the dummy cells add physical mass without adding an active Mangoldt label to (1).

## The anti-spike and energy checks

All bumps have disjoint supports and \(L^2\) norm one. The full even physical norm is
\[
 q_\pm=\|g_\pm+g_\pm^\vee\|_2^2=2(N+2)A_\pm^2.
\tag{6}
\]
Let \(x_R=e^{2R}=Qe^{-4s}\). Every interval \(I\) in either exterior half with \(|I|\le1/(4x_R)\) meets at most one dummy bump; it may meet both active bumps, whose total squared mass is \(2A_\pm^2\). Hence
\[
 \boxed{\quad
 \frac{\|1_I(g_\pm+g_\pm^\vee)\|_2^2}{q_\pm}
 \le\frac1{N+2}\le\frac1{R^2}.
 \quad}
\tag{7}
\]
This has the same scale and geometry as the proved actual-ground anti-spike conclusion.

The logarithmic Fourier norm of one translated bump is at most
\(C_\chi A_\pm^2[1+\log(1/h)]\). Triangle inequality for its square root, followed by (6), gives
\[
 \frac{\|g_\pm+g_\pm^\vee\|_{\mathcal H}^2}{q_\pm}
 \le C_\chi(N+2)[1+\log(1/h)]
 =O(R^3)=o(e^R).
\tag{8}
\]
Thus these examples satisfy the previously available relative logarithmic-energy budget \(\|G_R\|_{\mathcal H}^2/q_R\le Ce^R\) with room to spare. Their support lies well inside the established \(R+6e^{-\sqrt R/8}\) concentration collar; both the normalized and physical tails beyond that collar vanish. Also
\[
 \frac{\|g_\pm+g_\pm^\vee\|_1}{\sqrt{q_\pm}}
 =\sqrt{2(N+2)h}\int\chi
 \asymp R/Q,
\]
which is much larger than the published \(\exp(-Ce^R)\) lower mass scale. Both profiles vanish near the hard boundary and satisfy its fixed-core upper trace estimate.

## Exact signed sampling and normalization

Only the bump at \(a\) contributes in the outer \(w\)-integral in (1). An arrival from that bump can meet the other active bump at \(n=Q\), or a dummy bump at \(n=Q+2k\). Integer logarithms near these labels are separated by \(\asymp1/Q\), much wider than \(s\) and \(h\); there are no other contributing labels. Equation (5) removes every dummy contribution. The self-arrival would require a logarithm displaced from \(\log Q\) by approximately \(3s\) or \(5s\), much greater than \(2h\), so it also vanishes.

For \(g_+\), the undisplaced \(Q\)-arrival matches \(b_+\) and the displaced one misses. For \(g_-\), only the displaced arrival matches \(b_-\). Evenness of \(\chi\) and \(\|\chi_h\|_2=1\) give the exact values
\[
 \boxed{\quad
 \mathcal D_R(s;g_+)=\frac{\log2}{\sqrt Q}A_+^2,\qquad
 \mathcal D_R(s;g_-)=-\frac{\log2}{\sqrt Q}A_-^2.
 \quad}
\tag{9}
\]
All prime powers were kept in (1); the support and (5) explain why only \(Q\) survives.

Let \(I_h=\int e^{hz/2}\chi(z)\,dz\to\int\chi>0\). Every center in (3) equals \(R+o(1)\), uniformly for \(k\le N\), so
\[
 G_-(g_\pm)=A_\pm\sqrt h\,I_h
 \left(e^{a/2}+e^{b_\pm/2}+\sum_{k=1}^{N}e^{c_k/2}\right)
 =A_\pm\sqrt h\,I_h(N+2)e^{R/2}(1+o(1)).
\]
Because \(e^R=\sqrt Q\,e^{-2s}\) and \(h=Q^{-2}/100\), (9) becomes
\[
 \boxed{\quad
 \frac{\mathcal D_R(s;g_\pm)}{G_-(g_\pm)^2}
 =\pm\frac{100\log2}{(\int\chi)^2}
       \frac{Q}{(N+2)^2}(1+o(1))
 \asymp\pm\frac{Q}{R^4}.
 \quad}
\tag{10}
\]
This proves (2). An arbitrarily small positive theta-decaying tail can make either \(\psi_\pm\) strictly positive almost everywhere while retaining a bound of the form (7) with a slightly larger absolute constant and at least half the magnitude in (10). The perturbation is made separately at each fixed \(Q\); it does not assert an eigenfunction property.

## The missing ground equation is visible in the energy

For the unperturbed full even profiles \(f_\pm=g_\pm+g_\pm^\vee\), the complete prime quadratic form is tiny. Same-half prime shifts vanish because the whole positive packet has diameter \(O(N/Q)<\log2\). For opposite-half shifts, every candidate label is found by adding two centers. Besides \(a+b_+=\log Q\) and the zero-weight labels \(a+c_k=\log(Q+2k)\), the possible sums miss integer logarithms: \(a+b_-=\log Q+2s\), \(2a=\log Q-3s\), \(2b_+=\log Q+3s\), \(2b_-=\log Q+7s\), \(b_\pm+c_k=\log(Q+2k)+(3\text{ or }5)s\), and
\[
 c_i+c_j
 =\log\!\left(Q+2(i+j)+\frac{4ij}{Q}\right)+3s .
\]
The last quantity is more than \(3s>2h\) above the logarithm of the even non-prime-power integer \(Q+2(i+j)\), and remains \(o(1/Q)\) from it uniformly for \(i,j\le N\). All other integer logarithms are separated by \(\asymp1/Q\). Hence only \(Q\) contributes to the plus profile, and no prime power contributes to the minus profile. Counting both ordered active pairs and both translation orientations gives
\[
 \langle f_+,Sf_+\rangle
   =\frac{4\log2}{\sqrt Q}A_+^2,\qquad
 \langle f_-,Sf_-\rangle=0 .
\tag{11}
\]

The support of \(f_\pm\) has Lebesgue measure at most \(4(N+2)h\). The elementary Fourier cap \(\int_{|\xi|\le T}|\widehat f_\pm|^2d\xi\le T|\operatorname{supp}f_\pm|q_\pm/\pi\), with \(T\asymp[(N+2)h]^{-1}\), puts at least three quarters of the mass at frequencies where the archimedean multiplier is at least \(\log T-O(1)\). Since \(\log T=2\log Q-O(\log R)\), it follows that
\[
 \langle f_\pm,Af_\pm\rangle\ge cR\,q_\pm,\qquad
 \langle f_\pm,(A-S)f_\pm\rangle>0
 \quad\text{for all sufficiently large }Q .
\tag{12}
\]
The actual normalized killed ground instead satisfies \(\langle G_R,(A-S)G_R\rangle=-\delta_R<0\). This is the concrete equation-specific constraint that excludes these particular many-cell histories. A useful estimate for the actual ground would have to exploit how its full prime return pays its logarithmic frequency cost, not only how widely its mass is spread.

The actual ground equation is therefore still indispensable. Microscopic interval anti-concentration controls each grid cell but does not control the signed alignment of many cells with the complete Mangoldt arrivals. The [critical-window participation theorem](theta-ground-critical-prime-participation.md) turns that missing energy constraint into a lower bound on substantial actual prime-power overlaps along favorable core radii. The present construction limits a deduction from shape bounds alone; it does not weaken the anti-spike theorem, refute a ground-specific quadrature estimate, or decide the full affine covariance or RH. These are written calculations, without Lean formalization.
