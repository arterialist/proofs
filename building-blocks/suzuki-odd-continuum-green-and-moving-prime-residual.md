# The odd continuum Green kernel and a fixed-packet RH-strength prime residual

Suzuki's localized Weil form has an exact positive continuum-prime plus pole combination on its odd half-line. Replacing the actual prime powers by their density is therefore tempting. This note keeps the signed difference. A single fixed-shape odd packet translated toward the two window edges shows that even a uniform one-sided bound for that difference is RH-strength. The calculation does not prove that bound or RH.

Use the normalization of [Suzuki's localized form](https://arxiv.org/html/2606.09096v1) and the [parity reduction](suzuki-parity-rank-one-reflected-prime-obstruction.md). An odd test on \((-a,a)\) is identified unitarily with \(u\in L^2(0,a)\) by \(f(x)=\operatorname{sgn}(x)u(|x|)/\sqrt2\). Its pole vector is \(h(x)=\sqrt2\sinh(x/2)\), and the pole form is \(-2|\langle h,u\rangle|^2\). Every prime power has weight \(\Lambda(n)/\sqrt n\).

## Exact continuum cancellation

Replace the complete Chebyshev measure \(d\Psi(X)=\sum_{n\ge2}\Lambda(n)\delta_n\) by \(dX\) in the prime-shift term. The odd density-prime kernel on \((0,a)^2\) is
\[
 e^{|x-y|/2}-e^{(x+y)/2}.
\]
Thus its *negative* quadratic form, combined with the odd pole, is
\[
 \begin{aligned}
 \mathcal G_a[u]
 &=\iint_{(0,a)^2}u(x)\overline{u(y)}
       \left(e^{-|x-y|/2}-e^{-(x+y)/2}\right)dx\,dy\\
 &=\int_0^a e^{-t}|F_t|^2dt-2|\langle h,u\rangle|^2,
 \qquad F_t=\int_t^a e^{x/2}u(x)dx.
 \end{aligned}                                                    \tag{1}
\]
Indeed \(\int_0^a e^{-t}F_tdt=\sqrt2\langle h,u\rangle\), and \(\int_0^a e^{-t}dt=1-e^{-a}\). The elementary variance identity gives
\[
 \boxed{\quad
 \mathcal G_a[u]
 =e^{-a}\int_0^a e^{-t}|F_t|^2dt
  +\frac12\iint_{(0,a)^2}e^{-s-t}|F_s-F_t|^2ds\,dt\ge0.
 \quad}                                                          \tag{2}
\]
The kernel in (1) is the Dirichlet Green kernel of \(-\partial_x^2+1/4\) on \((0,\infty)\), compressed to \((0,a)\). If \(u\in H^1_0(0,a)\), operator Cauchy--Schwarz also gives
\[
 \mathcal G_a[u]\ge
 \frac{\|u\|_2^4}{\|u'\|_2^2+\|u\|_2^2/4}.
\tag{3}
\]
This is a low-frequency payment. It says nothing about the sign of the actual signed prime-minus-density remainder.

## One fixed packet, translated with the window

Choose a nonzero real nonnegative profile \(\phi\) supported in \([1/4,3/4]\) with \(\phi\in C_c^2(\mathbb R)\), and put
\[
 W=\phi*\phi,\quad
 I_-=\int\phi(s)e^{-s/2}ds,\quad
 I_+=\int\phi(s)e^{s/2}ds,\quad
 F(z)=\int\phi(s)e^{-zs/2}ds.
\]
For \(a>3/2\) take the odd window test
\[
 f_a(x)=\frac{\operatorname{sgn}x}{\sqrt2}\phi(a-|x|).
\tag{4}
\]
The two packets have fixed shape and sit near \(\pm a\). Their archimedean self-energy \(A_{\rm arch}[\phi]\) is independent of \(a\); their archimedean cross is
\[
 J_a=\iint\phi(s)\phi(t)
       \frac{e^{-(2a-s-t)/2}}{1-e^{-2(2a-s-t)}}ds\,dt
 =O_\phi(e^{-a}).
\tag{5}
\]
There is no same-half prime interaction: the packet diameter is \(1/2<\log2\). The opposite-half prime interaction is exactly
\[
 P_\phi(a)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                    W(2a-\log n).
\tag{6}
\]
Every prime power is included, and the support of \(W\) restricts this to the finite interval \(e^{2a-3/2}\le n\le e^{2a-1/2}\). Its density replacement is
\[
 \int_1^\infty X^{-1/2}W(2a-\log X)dX
 =e^aF(1)^2=e^aI_-^2.
\tag{7}
\]
The odd pole is exactly
\(-2|\langle h,u_a\rangle|^2
  =-e^aI_-^2+2I_-I_+-e^{-a}I_+^2\).
Consequently, with the **signed** complete prime discrepancy
\[
 D_\phi(a)=P_\phi(a)-e^aF(1)^2,
\tag{8}
\]
the full localized Weil form has the exact readout
\[
 \boxed{\quad
 Q_W(f_a)=A_{\rm arch}[\phi]+2I_-I_+
          +D_\phi(a)+J_a-e^{-a}I_+^2.
 \quad}                                                          \tag{9}
\]
The archimedean, Green and same-half costs are bounded as \(a\to\infty\). The unresolved term is one smoothed Chebyshev discrepancy at \(X\asymp e^{2a}\), not a large-frequency cost of the fixed packet.

## Exact transform and one-sided RH criterion

For \(\Re z>1\), use (8) to define \(D_\phi(a)\) also on \(0\le a\le3/2\), where (7) need not be read as an integral restricted to \(X>1\). Integrate this algebraic expression against \(e^{-za}da\) on \(a\ge0\). Since \(W\) is supported at positive arguments, the change of variables \(v=2a-\log n\) introduces no omitted prime or lower-endpoint term and gives
\[
 \boxed{\quad
 \widehat D_\phi(z)
 =\frac12F(z)^2\left(-\frac{\zeta'}{\zeta}\right)
                  \left(\frac{z+1}{2}\right)
   -\frac{F(1)^2}{z-1}.
 \quad}                                                          \tag{10}
\]
The prime sum is complete. At \(z=1\), the zeta pole contributes \(F(z)^2/(z-1)\), so the explicit density term cancels its pole. Every nontrivial zero \(\rho\) with \(\Re\rho>1/2\) instead gives a pole at \(z_\rho=2\rho-1\), with residue \(-m_\rho F(z_\rho)^2\) when \(F(z_\rho)\ne0\).

One concrete profile detects *all* such zeros. Let \(q(s)=e^{-s}\mathbf1_{(0,1/8)}(s)\) and \(\phi(s)=q^{*4}(s-1/4)\). It is nonnegative, supported in \([1/4,3/4]\), belongs to \(C_c^2\), and has
\[
 F(z)=e^{-z/8}
 \left(\frac{1-e^{-(1+z/2)/8}}{1+z/2}\right)^4\ne0
 \qquad(\Re z\ge0).
\tag{11}
\]
The apparent singularity at \(z=-2\) is removable and lies outside this region.

For this single fixed \(\phi\), the following two statements are equivalent:
\[
 \boxed{\quad
 \mathrm{RH}
 \quad\Longleftrightarrow\quad
 D_\phi(a)\text{ is bounded below for all sufficiently large }a.
 \quad}                                                          \tag{12}
\]
To prove the reverse implication, Chebyshev's estimate gives \(D_\phi(a)=O_\phi(e^a)\). If \(D_\phi(a)\ge-C\) eventually, then \((D_\phi+C)\mathbf1_{[a_0,\infty)}\) is nonnegative and has a Laplace transform of finite abscissa at most one. An off-critical zero with \(\Re\rho>1/2\) gives, by (10)--(11), a nonreal pole with positive real part. The abscissa is therefore positive. Landau's theorem for nonnegative Laplace transforms forces a singularity at that **positive real** abscissa. But (10), after adding \(C e^{-a_0z}/z\) and an entire finite-interval correction, is analytic on every positive real \(z\): \(z=1\) is canceled and \(\zeta\) has no real zero for \((z+1)/2>1/2\). This contradiction excludes every zero to the right of the critical line. The functional equation excludes zeros to its left.

Conversely, under RH the zeros side of Weil's explicit formula gives \(Q_W(f_a)=\sum_{\gamma>0}2|\widehat f_a(\gamma)|^2\). The transform of the fixed profile in (11) decays as \(O((1+|\gamma|)^{-4})\), uniformly under translation, so the standard zero count makes this sum \(O_\phi(1)\), uniformly in \(a\). Equation (9) then gives \(D_\phi(a)=O_\phi(1)\). Thus even eventual positivity of the single translated-test family (4) would imply RH; under RH it holds automatically.

The same argument applied to \(-D_\phi\) shows a sharper conditional statement: if RH fails, then \(\liminf_{a\to\infty}D_\phi(a)=-\infty\) and \(\limsup_{a\to\infty}D_\phi(a)=+\infty\). Equation (9) transfers the negative excursions to this one moving odd Weil test.

A critical-line zero gives an unconditional quantitative statement as well. Fix any zero \(\rho=1/2+i\gamma\) with \(\gamma\ne0\) and multiplicity \(m_\rho\). At \(z=2i\gamma\), (10) has residue \(-m_\rho F(2i\gamma)^2\), which is nonzero by (11). The same positive-Laplace comparison, now made at real abscissa zero, yields
\[
 \boxed{\quad
 \limsup_{a\to\infty}D_\phi(a)\ge m_\rho|F(2i\gamma)|^2,
 \qquad
 \liminf_{a\to\infty}D_\phi(a)\le-m_\rho|F(2i\gamma)|^2.
 \quad}                                                        \tag{12a}
\]
For example, if \(D_\phi(a)\le C\) eventually, the nonnegative transform of \((C-D_\phi)\mathbf1_{[a_0,\infty)}\) has abscissa zero: the nonreal pole forbids a negative abscissa, while Landau's theorem and the absence of a positive-real singularity forbid a positive one. Its modulus at \(\epsilon+2i\gamma\) is at most its value at \(\epsilon>0\). Multiply by \(\epsilon\) and let \(\epsilon\downarrow0\); the two sides tend to \(m_\rho|F(2i\gamma)|^2\) and \(C\), respectively. Apply the same argument to \(-D_\phi\) for the lower bound. [Hardy's theorem](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014) supplies such a zero, so the two-sided fixed-amplitude oscillation is unconditional. By (9), the translated odd Weil row oscillates on both sides of its constant baseline \(A_{\rm arch}[\phi]+2I_-I_+\) by at least this amplitude. If RH fails, the preceding unbounded-excursion statement is stronger.

The same packet gives a square-mean criterion for the complete prime discrepancy:
\[
 \boxed{\quad
 \mathrm{RH}\quad\Longleftrightarrow\quad
 \limsup_{A\to\infty}\frac1A\int_0^A|D_\phi(a)|^2da<\infty.
 \quad}                                                        \tag{12b}
\]
Under RH, the uniform bound following (12) proves the forward direction. Conversely, a finite square mean makes the *literal* integral \(\widehat D_\phi(z)\) absolutely convergent and holomorphic for every \(\Re z>0\) by Cauchy--Schwarz and \(\int_0^A|D_\phi|^2=O(A)\). An offcritical zero would give a nonzero pole there by (10)--(11), a contradiction. The functional equation completes the reverse implication. Thus (12b) is an RH-equivalent positive energy target, with no unconditional bound asserted.

Even without assuming RH, each finite set \(\mathcal Z\) of distinct critical-line zeros gives
\[
 \limsup_{A\to\infty}\frac1A\int_0^A|D_\phi(a)|^2da
 \ge\sum_{\rho=1/2+i\gamma\in\mathcal Z}
       m_\rho^2|F(2i\gamma)|^4,
\tag{12c}
\]
where conjugate ordinates are counted separately. If the left side is finite, the literal transform converges on \(\Re z>0\); in the Abel weight \(\epsilon e^{-\epsilon a}da\), the exponentials \(e^{2i\gamma a}\) have limiting identity Gram matrix, while their pairings with \(D_\phi\) tend to the residues \(-m_\rho F(2i\gamma)^2\). Finite-dimensional projection gives the right side as a lower Abel square mean, and integration by parts bounds that Abel mean by the Cesàro limsup. If the left side is infinite, (12c) is immediate.

Under RH the lower bound has an exact limit. With the Fourier convention used in the zero-side formula, direct transformation of (4) gives
\[
 \widehat f_a(\gamma)=\frac{e^{i\gamma a}F(2i\gamma)
             -e^{-i\gamma a}\overline{F(2i\gamma)}}{\sqrt2}.
\]
The decay \(F(2i\gamma)=O((1+|\gamma|)^{-4})\) makes the following zero sums absolutely and uniformly convergent in \(a\). Substituting this transform into the RH zero-side formula and comparing with (9) leaves a constant \(2\sum_{\gamma>0}m_\rho|F(2i\gamma)|^2-A_{\rm arch}[\phi]-2I_-I_+\). This constant vanishes: by (10), \(\widehat D_\phi\) is regular at \(z=0\), so its Abel mean \(\lim_{\epsilon\downarrow0}\epsilon\widehat D_\phi(\epsilon)\) is zero; the nonzero-frequency terms and \(J_a-e^{-a}I_+^2=O(e^{-a})\) also have zero Abel mean. Hence
\[
 A_{\rm arch}[\phi]+2I_-I_+
   =2\sum_{\gamma>0}m_\rho|F(2i\gamma)|^2,
\tag{12d}
\]
and, for \(a>3/2\),
\[
 D_\phi(a)=-2\sum_{\gamma>0}m_\rho
       \Re\!\left(e^{2i\gamma a}F(2i\gamma)^2\right)
       -J_a+e^{-a}I_+^2.
\tag{12e}
\]
Orthogonality of distinct frequencies in long Cesàro averages, followed by uniform convergence, now proves the sharper conditional identity
\[
 \boxed{\quad
 \lim_{A\to\infty}\frac1A\int_0^A|D_\phi(a)|^2da
 =2\sum_{\gamma>0}m_\rho^2|F(2i\gamma)|^4<\infty
 \qquad(\mathrm{RH}).
 \quad}                                                        \tag{12f}
\]
The exponentially decaying term in (12e) is itself exact. Expanding the denominator in (5) geometrically gives
\[
 J_a-e^{-a}I_+^2
 =\sum_{k\ge1}e^{-(4k+1)a}
       \left(\int\phi(s)e^{(2k+1/2)s}ds\right)^2
 =\sum_{k\ge1}e^{-(4k+1)a}F(-4k-1)^2.
\]
These are precisely the negative powers attached to the trivial zeta zeros \(\rho=-2k\) under \(z=2\rho-1\). They contribute zero to the mean in (12f). No simplicity or spacing assumption on nontrivial zeros is used.

The energy in (12b) has an exact additive-pair reading. Set \(X=e^{2a}\), \(w_X(n)=n^{-1/2}W(\log(X/n))\), and define the complete ordered weighted Goldbach count
\[
 R_X(N)=\sum_{n+m=N}\Lambda(n)\Lambda(m)w_X(n)w_X(m).
\]
The weight is supported on \(Xe^{-3/2}\le n\le Xe^{-1/2}\), so every sum below is finite. Expanding the literal square gives
\[
 \boxed{\quad
 D_\phi(\tfrac12\log X)^2
 =\sum_N R_X(N)
  -2\sqrt X F(1)^2\sum_n\Lambda(n)w_X(n)
  +XF(1)^4.
 \quad}                                                        \tag{12g}
\]
Consequently, (12b) is equivalent to a bounded logarithmic average of the right side of (12g), namely \((\log Y)^{-1}\int_1^Y(\cdots)dX/X\). This retains all prime powers, ordered additive pairs, the linear compensation and the density square. Ordinary Goldbach existence does not bound this centered pair energy.

There is also a direct fixed-source reading. Let \(E(x)=\Psi(x)-x\), \(H(u)=e^{-u/2}E(e^u)\), and \(L(v)=W'(v)+W(v)/2\). For \(a>3/2\), the support of \(W(2a-\log x)\) lies strictly above \(x=1\), so Stieltjes integration by parts has no lower endpoint:
\[
 \begin{aligned}
 D_\phi(a)
 &=\int_1^\infty x^{-1/2}W(2a-\log x)\,dE(x)\\
 &=\int_{1/2}^{3/2}H(2a-v)L(v)\,dv.
 \end{aligned}                                                   \tag{12h}
\]
The compact filter is genuinely signed. Since \(e^{v/2}L(v)=(e^{v/2}W(v))'\), its weighted integral is zero, while \(L\not\equiv0\); therefore it has both signs. For a formal error mode \(E(x)=c x^\rho\), (12h) gives exactly \(c\rho F(2\rho-1)^2e^{(2\rho-1)a}\). The zeta-zero coefficient \(c=-m_\rho/\rho\) thus becomes the residue amplitude \(-m_\rho F(2\rho-1)^2\) in (10), with no endpoint or prime power discarded. The RH-equivalent energy (12b) is a fixed signed-filter mean-square target for the actual critical-scale Chebyshev error \(H\), not a consequence of positivity of \(d\Psi\).

The additive-pair expansion also yields a one-sided local Goldbach criterion. Put \(P_X=\sum_n\Lambda(n)w_X(n)\ge0\), \(M_X=\sqrt X F(1)^2>0\), and \(\mathcal G_\phi(X)=\sum_N R_X(N)=P_X^2\). Either one of the following estimates, separately, is equivalent to RH when it holds for all sufficiently large \(X\) with some fixed \(C<\infty\):
\[
 \boxed{\quad
 \mathcal G_\phi(X)\ge XF(1)^4-C\sqrt X,
 \qquad\text{or}\qquad
 \mathcal G_\phi(X)\le XF(1)^4+C\sqrt X.
 \quad}                                                        \tag{12i}
\]
Indeed \(D_\phi(\tfrac12\log X)=(\mathcal G_\phi(X)-M_X^2)/(P_X+M_X)\). Since the denominator is at least \(M_X\), the lower or upper estimate gives, respectively, an eventual lower or upper constant bound on \(D_\phi\). The lower bound implies RH by (12); the upper bound does so by the identical positive-Laplace argument for \(-D_\phi\). Conversely RH gives \(D_\phi=O(1)\), so \(\mathcal G_\phi-M_X^2=2M_XD_\phi+D_\phi^2=O(\sqrt X)\). This local count keeps every ordered prime-power pair inside one fixed multiplicative window; ordinary Goldbach existence supplies no estimate at its required \(\sqrt X\) secondary scale.

That secondary scale has an unconditional two-sided lower calibration. For any Hardy zero \(\rho=1/2+i\gamma\), put \(A_\gamma=m_\rho|F(2i\gamma)|^2>0\). The PNT bound (13) gives \(D_\phi(\tfrac12\log X)/\sqrt X\to0\), so
\[
 \frac{\mathcal G_\phi(X)-XF(1)^4}{\sqrt X}
 =\left(2F(1)^2+\frac{D_\phi(\tfrac12\log X)}{\sqrt X}\right)
       D_\phi(\tfrac12\log X).
\]
Combining this exact factorization with (12a) yields
\[
 \boxed{\quad
 \limsup_{X\to\infty}\frac{\mathcal G_\phi(X)-XF(1)^4}{\sqrt X}
 \ge2F(1)^2A_\gamma,
 \qquad
 \liminf_{X\to\infty}\frac{\mathcal G_\phi(X)-XF(1)^4}{\sqrt X}
 \le-2F(1)^2A_\gamma.
 \quad}                                                        \tag{12j}
\]
Thus neither one-sided estimate in (12i) can hold with \(C<2F(1)^2A_\gamma\). This is an actual ordered prime-power Goldbach fluctuation, not a bound sufficient for RH.

## Why the ordinary PNT does not pay this residual

The complete unconditional bound \(|\Psi(X)-X|\le CXe^{-c\sqrt{\log X}}\), as in [Trudgian's Theorem 1](https://arxiv.org/pdf/1401.2689), and Stieltjes integration by parts in (8) yield only
\[
 |D_\phi(a)|\le C_\phi e^a e^{-c'\sqrt a}.
\tag{13}
\]
Indeed the derivative of \(X^{-1/2}W(2a-\log X)\) is \(O_\phi(X^{-3/2})\) on \(X\asymp e^{2a}\). The bound (13) grows, while every other term in (9) stays bounded. The signed phase information needed to control (8) is exactly the missing RH-strength ingredient for this packet. A raw norm bound on the remainder, or the positive Green kernel (1) alone, cannot furnish it.

The continuum identity is elementary Green-kernel and variance algebra. The pole and prime normalizations follow Suzuki's form; the zero-side is also displayed in [Zhu, equation (7)](https://arxiv.org/html/2608.24827v2). The one-sided transform argument is the classical positive-Laplace principle used, for example, in [Suzuki's weighted Chebyshev analysis](https://arxiv.org/pdf/2411.07436). This note packages those methods for this one translated odd test and makes no novelty or Lean-formalization claim.
