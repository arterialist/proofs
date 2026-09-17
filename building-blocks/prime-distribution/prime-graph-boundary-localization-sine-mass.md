# The prime graph energy localizes near-maximizers at the spatial boundary

This note uses the actual prime shifts, including every prime power. It turns the weighted graph identity into a conditional spatial and Fourier concentration estimate. The condition is that the graph energy is small compared with \(e^a\|f\|_2^2\); no such smallness is asserted for every test. The graph energy belongs to the raw prime operator, so its relation to the signed arithmetic remainder is stated explicitly below.

On \(I_a=(-a,a)\), let
\[
(P_af)(x)=\sum_{\log n<2a}\frac{\Lambda(n)}{\sqrt n}
\bigl(f(x+\log n)+f(x-\log n)\bigr),
\qquad \phi(x)=\cosh(x/2).
\]
Functions are zero outside \(I_a\). Write \(V_a=P_a\phi/\phi\) and
\[
\mathcal D_a[f]
=\int_{I_a}V_a(x)|f(x)|^2dx-\langle f,P_af\rangle
=\sum_{\log n<2a}\frac{\Lambda(n)}{\sqrt n}
\int_{-a}^{a-\log n}\phi(x)\phi(x+\log n)
\left|\frac{f(x)}{\phi(x)}-
\frac{f(x+\log n)}{\phi(x+\log n)}\right|^2dx\ge0.
\tag{1}
\]
The [weighted-row calculation](prime-shift-weighted-schur-window-asymptotic.md) gives a number \(\epsilon_a\to0\) such that
\[
(1-\epsilon_a)e^a\le V_a(x)\le(1+\epsilon_a)e^a
\quad\text{for almost every }x\in I_a.
\tag{2}
\]

**Theorem.** There are absolute constants \(L_0,C>0\) such that, for all sufficiently large \(a\), all \(L_0\le L\le a/2\), and all \(f\in L^2(I_a)\), if \(b=a-L\) and \(f_{\rm in}=1_{(-b,b)}f\), then
\[
\boxed{\|f_{\rm in}\|_2^2
\le C\left[\frac{\mathcal D_a[f]}{e^a}
+(e^{-L}+\epsilon_a)\|f\|_2^2\right].}
\tag{3}
\]
Moreover,
\[
\boxed{\|f\|_1^2
\le C\left[\frac{a\mathcal D_a[f]}{e^a}
+(L+a e^{-L}+a\epsilon_a)\|f\|_2^2\right].}
\tag{4}
\]
If \(f\) is the odd extension of \(u/\sqrt2\) from \((0,a)\), then for every interval \(J\subset[0,\infty)\), with \(S_u(t)=\int_0^a u(x)\sin(tx)dx\),
\[
\boxed{\frac2\pi\int_J|S_u(t)|^2dt
\le C|J|\left[
\frac{a\mathcal D_a[f]}{e^a}
+(L+a e^{-L}+a\epsilon_a)\|u\|_2^2\right].}
\tag{5}
\]
In particular, if \(\mathcal D_a[f]=o(e^a\|f\|_2^2)\), then with \(L=\sqrt a\) the fraction of sine spectral mass in **each individual** interval of length \(O(1/a)\) tends to zero, uniformly in that interval's location.

**Proof.** Split \(I_a=I\sqcup O\), with \(I=(-b,b)\) and the disconnected exterior \(O=(-a,-b)\cup(b,a)\). Let \(P_{XY}=1_XP_a1_Y\). The weighted Schur bound and (2) give
\[
\|P_{II}\|\le C_b\le2e^b,
\qquad
\|P_{OO}\|\le C_a\le(1+\epsilon_a)e^a
\tag{6}
\]
for large \(a\), uniformly because \(b\ge a/2\). Here \(C_c=\operatorname*{ess\,sup}_{|x|<c}(P_c\phi)(x)/\phi(x)\), and \(P_{II}=P_b\) on the inner interval.

For the cross block, the Schur row from \(O\) into \(I\) is at most
\[
A:=\operatorname*{ess\,sup}_{x\in I}
\frac{P_a(\phi 1_O)(x)}{\phi(x)}
\le C_a\le(1+\epsilon_a)e^a.
\]
For \(y\in(b,a)\), only the shift \(y-\log n\) can land in \(I\). Thus, with \(\Psi(X)=\sum_{n<X}\Lambda(n)\) and \(H(X)=\sum_{n<X}\Lambda(n)/n\), the reverse row equals, up to immaterial endpoint conventions,
\[
\begin{aligned}
\frac{P_a(\phi 1_I)(y)}{\phi(y)}
&=\frac{e^y\displaystyle\sum_{e^{y-b}<n<e^{y+b}}\Lambda(n)/n
+\displaystyle\sum_{e^{y-b}<n<e^{y+b}}\Lambda(n)}{e^y+1}\\
&\le H(e^{y+b})+e^{-y}\Psi(e^{y+b})
\le C(a+e^b)\le C'e^b.
\end{aligned}
\tag{7}
\]
The penultimate bound uses \(H(X)=O(1+\log X)\) and \(\Psi(X)=O(X)\); the last uses \(b\ge a/2\). Evenness of \(\phi\) and reflection symmetry of \(P_a\) give the same bound for \(y\in(-a,-b)\). The two-weight Schur argument applies to the whole disconnected \(O\): the row bound \(A\) already sums both components, and (7) bounds each reverse row. Hence
\[
\|P_{IO}\|=\|P_{OI}\|
\le\sqrt{A\,\operatorname*{ess\,sup}_{y\in O}
P_a(\phi1_I)(y)/\phi(y)}
\le C e^{(a+b)/2}.
\tag{8}
\]

Put \(x=\|f_{\rm in}\|_2\), \(y=\|1_Of\|_2\). Equations (2), (6), and (8) imply
\[
\frac{\mathcal D_a[f]}{e^a}
\ge(1-\epsilon_a-2e^{-L})x^2
-2Ce^{-L/2}xy-2\epsilon_a y^2.
\tag{9}
\]
Choose \(L_0\) large enough that \(2e^{-L_0}\le1/8\), then take \(a\) large enough that \(\epsilon_a\le1/8\). Applying
\(2Ce^{-L/2}xy\le x^2/4+4C^2e^{-L}y^2\) to (9) gives
\[
\frac{\mathcal D_a[f]}{e^a}
\ge\frac12x^2-(4C^2e^{-L}+2\epsilon_a)y^2,
\]
which proves (3). Cauchy–Schwarz on the sets of lengths \(2b\) and \(2L\) gives
\[
\|f\|_1^2\le
\bigl(\sqrt{2b}\,x+\sqrt{2L}\,y\bigr)^2
\le4a x^2+4L y^2;
\]
inserting (3) proves (4).

For the odd half-line normalization, \(\|f\|_2=\|u\|_2\) and \(\|f\|_1=\sqrt2\|u\|_1\). The elementary bound \(|S_u(t)|\le\|u\|_1\) yields
\(\frac2\pi\int_J|S_u|^2\le |J|\|f\|_1^2/\pi\); now (4) proves (5). \(\square\)

For a test supported in \((-b,b)\), (2) and (6) immediately give
\(\mathcal D_a[f]\ge[(1-\epsilon_a)e^a-2e^b]\|f\|_2^2\). In particular, the interior test in the [prime-phase density obstruction](prime-phase-density-paley-wiener-obstruction.md), supported below \(3a/4\) before a vanishing pole correction, has \(\mathcal D_a[f]=(1+o(1))e^a\|f\|_2^2\). Its Fourier mass on a rare phase interval is therefore consistent with (5).

For clarity, this is a statement about the **raw prime graph**. In the [actual odd continuum decomposition](../weil-and-spectral/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md),
\(\mathcal R_a^{\rm odd}=P_a^{\rm odd}+\mathcal G_a\) and
\(\mathcal G_a=2|h_a\rangle\langle h_a|+\mathcal K_a\), where
\(0\le\mathcal K_a\le4I\). If \(f\) is the odd extension of \(u/\sqrt2\), then
\[
\langle u,\mathcal R_a^{\rm odd}u\rangle
=\int_{I_a}V_a|f|^2-\mathcal D_a[f]
+2|\langle h_a,u\rangle|^2+\langle u,\mathcal K_a u\rangle.
\tag{10}
\]
Thus on the pole-null class the graph energy measures the deficit from the \(e^a\) raw-prime row, and the remaining continuum term is bounded by \(4\|u\|_2^2\). Equation (10) does **not** give a uniform upper bound on the signed remainder at the logarithmic archimedean scale. When the raw-prime expectation is small, the large row term and graph energy nearly cancel; the theorem describes tests for which that cancellation is small. To prove the odd Weil sign one would still need the archimedean form to pay for the resulting positive remainder.
Equivalently, on that pole-null class the exact full odd form is
\[
\langle u,A_a^{\rm odd}u\rangle
=\langle u,\mathcal A_a u\rangle
-\int_{I_a}V_a|f|^2+\mathcal D_a[f].
\tag{10a}
\]

## The resonant union can still carry fixed mass

The gap between one interval and a union is real. Use the full prime-power comb from the [phase-density note](prime-phase-density-paley-wiener-obstruction.md):
\[
W_a=\sum_{2\le n<e^{2a}}\frac{\Lambda(n)}{\sqrt n},\qquad
Q_a(t)=\sum_{2\le n<e^{2a}}\frac{\Lambda(n)}{\sqrt n}\cos(t\log n),
\qquad E_a=\{t\ge0:Q_a(t)\ge0.97W_a\}.
\tag{11}
\]
The upper natural density of \(E_a\) is \(\le\exp(-c e^{2a}/a^2)\), but the following stronger obstruction holds.

**Proposition.** There are real \(u_a\in C_c^\infty(0,a)\) with \(\|u_a\|_2=1\) and \(\langle h_a,u_a\rangle=0\) such that their odd extensions \(f_a\) satisfy
\[
\frac{\mathcal D_a[f_a]}{e^a}\longrightarrow0,
\qquad
\liminf_{a\to\infty}\frac2\pi\int_{E_a}|S_{u_a}(t)|^2dt>0.
\tag{12}
\]
One may use carriers with \(\log t_a=O(e^{2a}\log a/a)\). Alternatively, the prime-torus recurrence permits carriers arbitrarily high; no lower bound on the Dirichlet choice is asserted.

**Proof.** Simultaneous Dirichlet approximation of the \(r_a=O(e^{2a}/a)\) admitted prime-power logarithms with denominator parameter \(Q=\lceil a^8\rceil\) gives \(1\le q\le Q^{r_a}\) with \(q\log n\) within \(2\pi/Q\) of \(2\pi\mathbb Z\) for every admitted \(n\). Multiply \(q\) by \(\lceil a^2/q\rceil\) if \(q<a^2\), and leave it unchanged otherwise. The result \(t_a\) satisfies \(t_a\ge a^2\), the stated logarithmic bound, and
\[
\delta_a:=\max_{\Lambda(n)>0,n<e^{2a}}
|e^{it_a\log n}-1|=O(a^{-6}).
\tag{13}
\]
For the alternative high-carrier choice, the prime logarithms are rationally independent, so their torus flow returns to the phase neighborhood in (13) at arbitrarily large times. Prime powers follow from the corresponding prime coordinates after shrinking that neighborhood. The rest of the proof needs only (13) and \(t_a\to\infty\).

Let \(g_a=\phi1_{I_a}/\sqrt{a+\sinh a}\) and \(F_a(x)=\sqrt2g_a(x)\sin(t_ax)\). Then \(F_a\) is odd and \(\|F_a\|_2\to1\). Since
\(|\sin(t_a(x+\log n))-\sin(t_ax)|\le\delta_a\), the graph identity (1) gives
\[
\mathcal D_a[F_a]
\le\delta_a^2\frac{\langle\phi,P_a\phi\rangle}{a+\sinh a}
\le\delta_a^2 C_a=o(e^a).
\tag{14}
\]

The prime number theorem and partial summation give, uniformly for \(|s|\le0.05\),
\[
\frac{Q_a(t_a+s)}{W_a}
=A(s)\cos(2as-\vartheta(s))+o(1),
\quad A(s)=(1+4s^2)^{-1/2},\quad\vartheta(s)=\arctan(2s).
\tag{15}
\]
Indeed \(\sum_{n<e^{2a}}\Lambda(n)n^{-1/2+is}
=e^{a+2ias}/(1/2+is)+o(e^a)\) uniformly for bounded \(s\), and (13) changes the normalized sum by at most \(\delta_a\). With the convention \(\widehat F(t)=\int F(x)e^{itx}dx\), the two endpoint layers of \(g_a\) give
\[
\widehat g_a(s)=\sqrt2\operatorname{Re}
\frac{e^{ias}}{1/2+is}+o(1),\qquad
|\widehat F_a(t_a+s)|^2
=4A(s)^2\cos^2(as-\vartheta(s))+o(1)
\tag{16}
\]
uniformly in the same interval. For the second formula, \(\widehat g_a(2t_a+s)=O(t_a^{-1})\) follows from the uniformly bounded variation of zero-extended \(g_a\).

Let \(B_a=\{s\in[-0.05,0.05]:\cos(2as-\vartheta(s))\ge0.99\}\). Since \(A(s)\ge1/\sqrt{1.01}\), equation (15) puts \(t_a+B_a\subset E_a\) for large \(a\). The phase has derivative \(2a+O(1)\), so periodic averaging gives
\[
\operatorname{meas}(B_a)\longrightarrow
\frac{0.1}{\pi}\arccos(0.99)>0.
\tag{17}
\]
On \(B_a\), the distance of \(as-\vartheta(s)\) from \(\pi\mathbb Z\) is less than
\((\arccos(0.99)+\arctan(0.1))/2<0.121\). Equation (16) is therefore bounded below by a positive constant on \(B_a\). The odd positive-frequency mass equals \(\pi^{-1}\int|\widehat F_a(t)|^2dt\), which proves a fixed lower bound on its mass in \(E_a\).

Choose an even smooth cutoff that is zero on \(|x|<1\), one on \(2<|x|<a-\eta_a\), and tapers monotonically to zero over \(a-\eta_a<|x|<a\), where \(\eta_a\downarrow0\). This changes \(F_a\) by \(o(1)\) in \(L^2\): the central loss is \(O(e^{-a/2})\), and the endpoint loss is \(O(\sqrt{\eta_a})\). Since (1) has operator norm \(O(e^a)\), (14) changes by \(o(e^a)\); Plancherel keeps the spectral lower bound. For the resulting half-line function \(u_a^{\rm pre}\), integration by parts gives \(\langle h_a,u_a^{\rm pre}\rangle=O(e^{a/2}/t_a)\), uniformly in the monotone taper. Choose \(b_a\in C_c^\infty(a-1,a-1/2)\) with \(\langle h_a,b_a\rangle=1\) and \(\|b_a\|_2=O(e^{-a/2})\). Subtracting \(\langle h_a,u_a^{\rm pre}\rangle b_a\) changes the \(L^2\) norm by \(O(t_a^{-1})\). Normalize. This gives the compact pole-null tests in (12). \(\square\)

The proposition rules out summing the single-interval estimate (5) over the whole resonant set. In particular, no uniform bound of the form
\(\frac2\pi\int_{E_a}|S_u|^2\le o(1)\|u\|_2^2+C\mathcal D_a[f]/e^a\)
can hold even on compact pole-null odd tests. At these recurrent carriers, \(E_a\) contains \(\asymp a\) resonant components in one bounded frequency band, and the Fourier fringes of a boundary-localized graph near-null test follow them. The quantitative Dirichlet construction gives only an **upper** bound on \(\log t_a\), so by itself it does not compare the carrier with the \(e^a\) archimedean scale. If desired, Kronecker recurrence allows a later carrier with \(\log t_a\ge2e^a\), where the archimedean multiplier exceeds the raw-prime row; this loses the stated quantitative upper bound. The localization theorem and proposition give no all-scale sign for the odd Weil form. The prime shifts follow [Suzuki's Fourier formula, §2.4](https://arxiv.org/html/2606.09096v1); the row asymptotic and graph identity are proved in the linked local note. No novelty or priority is claimed.
