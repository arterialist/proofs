# What Liu's fixed-window split costs as the support grows

RH Agent3, 2026-09-17. **Status:** written analytic audit and an exact finite test for the preconditioner. The finite Weil certificate, a new positive window, RH, and Lean formalization are not established here.

Vincent Liu's [frozen 15 September 2026 manuscript](https://github.com/luciferyu666/certified-weil-positivity/blob/b6cd2183c1e79c6c27a34267812a7b2d73ed1b59/frozen-source/publication/manuscript.tex) claims a fixed-window bound at half-width \(L=17/16\), with Fourier cutoff \(\Omega=256\), a \(448\)-mode Legendre core, and lower constant \(2^{-49162}\). I examine the analytic split used in that theorem. This note does not audit its finite integer matrices and does not assert positivity on another window.

## The source normalization

Write \(I_L=(-L,L)\), extend \(f\in L^2(I_L)\) by zero, and set
\[
 A(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi,
 \qquad
 (P_Lf)(u)=\sum_{\log n<2L}\frac{\Lambda(n)}{\sqrt n}
       \bigl(f(u+\log n)+f(u-\log n)\bigr).
\tag{1}
\]
Every prime power is present. Liu writes \(M_L=\frac72I-\sum c_nJ_{\log n}\), where \(c_n=2\Lambda(n)/\sqrt n\) and \(J_a=(S_a+S_a^*)/2\). Thus his \(M_L\) is exactly \(\frac72I-P_L\), with no factor of two missing. His Theorem B separates
\[
 Q(f)=\langle f,(M_L+K_L)f\rangle+T_{L,\Omega,7/2}(f),
 \quad
 T_{L,\Omega,b}(f)=\frac1{2\pi}\int_{|t|>\Omega}(A(t)-b)|F_f(t)|^2\,dt.
\tag{2}
\]
The finite block theorem first requires \(M_L\succeq mI\) for some \(m>0\). The tail step requires \(A(t)-b\ge C>0\) beyond the cutoff.

## The constant \(7/2\) baseline fails by \(L=\log4\)

At \(L=\log4\), the active prime powers are
\(\mathcal N=\{2,3,4,5,7,8,9,11,13\}\). The endpoint \(n=16\) has zero overlap. For the nonnegative test \(\phi(u)=\cosh(u/2)\), a direct integration gives
\[
 \|\phi\|_2^2=L+\sinh L,
 \qquad
 \langle\phi,P_L\phi\rangle
 =2\sum_{\log n<2L}\frac{\Lambda(n)}{\sqrt n}
 \left[\sinh\!\left(L-\frac{\log n}{2}\right)
 +\left(L-\frac{\log n}{2}\right)\cosh\!\left(\frac{\log n}{2}\right)\right].
\tag{3}
\]
At \(L=\log4\), this becomes
\[
 \langle\phi,P_L\phi\rangle
 =\sum_{n\in\mathcal N}\Lambda(n)
 \left[\frac{16-n}{4n}+\frac{n+1}{n}\log\frac4{\sqrt n}\right],
 \qquad \|\phi\|_2^2=\log4+\frac{15}{8}.
\tag{4}
\]
In fact, exact rational bounds for the logarithms give
\[
 \langle\phi,P_{\log4}\phi\rangle
 -\frac72\|\phi\|_2^2>\frac3{20}.
\tag{5}
\]
Here is a short way to check the strict inequality without floating-point arithmetic. For \(m=2,3,5,7,11,13\), put \(x_m=(m-1)/(m+1)\) and
\[
 \ell_m^-=2\sum_{j=0}^{7}\frac{x_m^{2j+1}}{2j+1},\qquad
 \ell_m^+=\ell_m^-+\frac{2x_m^{17}}{17(1-x_m^2)}.
\]
The series for \(2\operatorname{artanh}x_m=\log m\) proves \(\ell_m^-<\log m<\ell_m^+\). Form intervals for \(\log4=2\log2\), \(\log8=3\log2\), and \(\log9=2\log3\) by multiplying these bounds. In (4), use the lower bound for \(\Lambda(n)\), the lower bound for \(2\log2-\frac12\log n\), and the upper bound for \(\frac72(2\log2+15/8)\). The resulting rational difference exceeds \(3/20\); its decimal interval is \(0.1513<\text{difference}<0.2340\). The lower endpoint alone proves (5).

Consequently \(M_{\log4}\) has a negative quadratic value. Smooth nonnegative functions approximating \(\phi\) in \(L^2(I_{\log4})\) retain the sign. Embedding the same test in every larger \(I_L\) does not change its old overlaps, and new prime shifts have nonnegative quadratic values on a nonnegative test. Hence
\[
 \boxed{\quad \tfrac72I-P_L\not\succeq0\quad\text{for every }L\ge\log4.\quad}
\tag{6}
\]
This is a failure of the positive preconditioner in (2), not a negative test for the full Weil form. It leaves a local continuation from \(17/16\) to just below \(\log3\) open; no new prime power enters on that interval.

The long-window cost is stronger. The [exact weighted-Schur calculation](prime-shift-weighted-schur-window-asymptotic.md) gives
\[
 \sup_{\|f\|_2=1}\langle f,P_Lf\rangle=\|P_L\|=(1+o(1))e^L.
\tag{7}
\]
The equality between the spectral supremum and the norm follows from
\(|\langle f,P_Lf\rangle|\le\langle|f|,P_L|f|\rangle\).
For any replacement baseline \(b_LI-P_L\succeq m_0I\) with fixed \(m_0>0\), one therefore needs \(b_L\ge(1+o(1))e^L\). Since \(A(t)=\log(|t|/(2\pi))+O(1/|t|)\), a positive exterior floor \(A(t)-b_L\ge C_0>0\) for all \(|t|>\Omega_L\) forces
\[
 \log\Omega_L\ge b_L+\log(2\pi)+C_0+o(1),\qquad
 \Omega_L\ge\exp\bigl((1+o(1))e^L\bigr).
\tag{8}
\]
This is a cost of the positive-baseline and positive-tail split. It does not bound the cutoff required by other treatments of the signed prime and gamma terms.

## The scalar tail floor and rank-two payment

Let \(B_{L,\Omega}\) be the sinc-band operator on \(I_L\). For every \(L,\Omega\ge1\), the elementary interpolation argument behind Liu's Appendix B.1 extends to give
\[
 I-B_{L,\Omega}\succeq\delta_{L,\Omega}I,
 \qquad
 \delta_{L,\Omega}=\frac{1}{32N\,72^{2N}},
 \qquad N=\lceil32L\Omega\rceil.
\tag{9}
\]
This is deliberately coarser than Liu's \(2^{-49158}\) at \((17/16,256)\). It shows that the same elementary mechanism supplies a strictly positive scalar tail on each fixed window, with
\(\log(1/\delta_{L,\Omega})=O(L\Omega)\).

For completeness, normalize \(\|f\|_2=1\) and let \(E=(2\pi)^{-1}\int_{|t|>\Omega}|F_f(t)|^2dt\). If \(E<1/2\), some \(t_0\in[-\Omega,\Omega]\) satisfies \(|F_f(t_0)|>\sqrt{\pi/(2\Omega)}\). Put \(h=\Omega/(2N)\) and choose \(x_j\in[\Omega+2jh,\Omega+(2j+1)h]\), \(0\le j<N\), with \(|F_f(x_j)|\le\sqrt{4\pi N E/\Omega}\). Then \(|x_j-x_k|\ge h|j-k|\) and \(|t_0-x_j|\le3\Omega\). Rotate \(F_f\) by a constant phase and interpolate its real part. The sum of absolute Lagrange basis values at \(t_0\) is at most
\[
 \frac{(6\Omega/h)^{N-1}}{(N-1)!}
 =\frac{(12N)^{N-1}}{(N-1)!}\le72^N.
\]
The remainder is at most \(\sqrt{2L}(3\Omega L)^N/N!\le\sqrt{2L}\,2^{-N}<\frac12\sqrt{\pi/(2\Omega)}\), using \(N\ge32L\Omega\). Therefore \(E\ge(32N72^{2N})^{-1}\). The case \(E\ge1/2\) is immediate.

If (8) makes \(A-b_L\ge C_0>0\) on the exterior, (9) gives the raw tail lower bound \(T_{L,\Omega,b_L}\succeq C_0\delta_{L,\Omega}I\). The first two normalized Legendre modes have exterior masses \(e_0,e_1=O((L\Omega)^{-1})\). For example, direct integration gives \(e_0\le2/(\pi L\Omega)\) and \(e_1\le24/(\pi L\Omega)\). Thus Liu's fixed coefficients \(81,27\) satisfy \(81e_0<C_0\) and \(27e_1<C_0\) once \(L\Omega\) is large. With \(S=I-B_{L,\Omega}-\delta_{L,\Omega}I\) and \(h_j=Sv_j\), the same parity and square-completion argument then gives
\[
 T_{L,\Omega,b_L}\succeq
 \frac{C_0\delta_{L,\Omega}}2 I
 81|h_0\rangle\langle h_0|+27|h_1\rangle\langle h_1|.
\]
The explicit scalar lower margin has logarithm of reciprocal \(O(L\Omega)\). It is not a lower bound for the full Weil form until the remaining finite sign test succeeds.

No positive rank-two payment can keep that scalar floor uniform as \(\Omega\to\infty\). More precisely, let \(b_L\ge0\), \(\tau_L\ge0\), and let \(U_L\succeq0\) have rank at most two. Suppose
\[
 T_{L,\Omega_L,b_L}\succeq\tau_LI+U_L,
 \qquad \Omega_L\longrightarrow\infty.
\tag{10}
\]
Fix any three-dimensional \(V\subset C_c^\infty((-1,1))\). For every \(L\ge1\), there is a unit \(f_L\in V\cap\ker U_L\). Fourier transforms of the unit sphere of \(V\) have uniform rapid decay. Also \(A_+(t)\le C\log(2+|t|)\) and \(A(t)-b_L\le A_+(t)\). Evaluating (10) on \(f_L\) yields, for every fixed \(q>0\),
\[
 \boxed{\quad 0\le\tau_L\le C_{V,q}\Omega_L^{-q}.\quad}
\tag{11}
\]
Thus the analytic scalar margin reported by a fixed-rank tail supplier tends to zero faster than every power of the cutoff. This does not prove that the full \(Q\) lacks a uniform lower bound. A different positive contribution from the compact-band and prime terms could change the final bound.

## The finite core must follow the bandwidth

The sinc operator has \(0\preceq B_{L,\Omega}\preceq I\) and
\(\operatorname{tr}B_{L,\Omega}=2L\Omega/\pi\). If \(P\) is any rank-\(d\) projection and
\(r^2=\sup_{|t|\le\Omega}\|(I-P)e^{itu}\|_{L^2(I_L)}^2\), then
\[
 \frac{2L\Omega}{\pi}-d
 \le\operatorname{tr}((I-P)B_{L,\Omega})
 =\frac1{2\pi}\int_{-\Omega}^{\Omega}\|(I-P)e^{itu}\|^2dt
 \le\frac{\Omega r^2}{\pi}.
\]
Consequently
\[
 \boxed{\quad d\ge\frac{\Omega}{\pi}(2L-r^2).\quad}
\tag{12}
\]
For the small projection residual required by Liu's cross and complement estimates, this is a necessary \(d\ge(2/\pi-o(1))L\Omega\) condition. It applies to any basis. Conversely, the Bernstein ellipse of radius \(3/2\) gives the Legendre bound
\[
 r^2\le72L\exp(5L\Omega/6)(2/3)^{2d},
\tag{13}
\]
so \(d=O(L\Omega+\log(1/r))\) suffices for this approximation step. The cutoff in (8) makes the required core at least of order \(L\exp((1+o(1))e^L)\) within this split.

The comparison to the actual \(F\)-ground flux is instructive. Its [prime-power collar calculation](factorial-f-ground-flux-collar-direction-obstruction.md) keeps a signed \(d\psi-dx\) term, and the [moving Goldbach unit-cell calculation](factorial-f-ground-complete-clock-weighted-flux-energy.md) keeps the additive endpoint. The positive Schur row in (7) pays for every prime shift separately and loses such cancellation. Equation (5) of the [prime-shift note](prime-shift-weighted-schur-window-asymptotic.md) records exactly the graph energy lost in that payment. The present obstruction only says that Liu's fixed-baseline, positive-exterior, fixed-rank route cannot give a uniform analytic margin or fixed-size certificate as \(L\to\infty\). It gives no RH proof and no Goldbach error bound.
