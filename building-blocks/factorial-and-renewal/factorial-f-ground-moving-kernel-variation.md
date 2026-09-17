# Adjacent-scale variation of the full-prime-power F-ground kernel

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 exact variation, quantitative bound, and structural sign audit, 2026-09-16. This addresses only the moving scalar \(\mathcal G_{Y,s}\) in [factorial-f-ground-prefix-block-rank-one.md](factorial-f-ground-prefix-block-rank-one.md). It does not replace the actual later-clock drift, establish an infinite terminal limit, sign the arithmetic kernel, or prove RH.

Let \(Y\ge3\), \(s=c\log(Y-1)\), \(s'=c\log(2Y-1)\), \(\ell=\log2\), and \(E=\psi-x\), with \(dE=d\psi-dx\). For the complete all-prime clock law \(\eta_s\), set
\[
j_s(t)=\int_{[0,t]}(t-v)e^{-(t-v)/2}\eta_s(dv),\quad j_s(t)=0\ (t<0),\qquad
W_{Z,s}(x)=\frac{j_s(\log(x/Z))^2}{xF(x)}. \tag{1}
\]
The exact original-metric kernel is
\[
\mathcal G_{Z,s}=ZQ(T_s\beta_Z,T_s\beta_Z)
=\int_{[Z,\infty)}W_{Z,s}(x)\,dE(x)
=\sum_{m\ge Z}\Lambda(m)W_{Z,s}(m)
-\int_Z^\infty W_{Z,s}(x)dx. \tag{2}
\]
Every observing prime power, the continuum density, the actual \(F\), and all jump histories are present. Since \(j_s(0)=0\), an atom exactly at a moving lower endpoint contributes zero, but an atom at \(2Y\) contributes to the old kernel and is retained below.

## Exact clock, dilation, and endpoint split

Write \(\Delta_Y\mathcal G=\mathcal G_{2Y,s'}-\mathcal G_{Y,s}\). Insert \(\mathcal G_{2Y,s}\) to obtain
\[
\boxed{\Delta_Y\mathcal G=\mathcal T_Y+\mathcal D_Y,\qquad
\mathcal T_Y=\int_s^{s'}\partial_\tau\mathcal G_{2Y,\tau}\,d\tau,\qquad
\mathcal D_Y=\mathcal G_{2Y,s}-\mathcal G_{Y,s}.} \tag{3}
\]
The clock part is the exact signed jump-Stokes response. Put \(t=\log(x/(2Y))\), \(\Delta_vj_\tau(t)=j_\tau(t-v)-j_\tau(t)\). Since \(\partial_\tau j_\tau=\int\Delta_vj_\tau\,\nu(dv)\),
\[
\boxed{\displaystyle
\mathcal T_Y=\int_s^{s'}d\tau\int\nu(dv)
\int_{[2Y,\infty)}\frac{
j_\tau(t-v)^2-j_\tau(t)^2-|\Delta_vj_\tau(t)|^2
}{xF(x)}\,dE(x).} \tag{4}
\]
Thus the prime-power and density observers occur inside the clock flux, not only in a terminal score. No finite-jump truncation is used.

At a fixed clock, the physical dilation is exact without differentiating the arithmetic measure:
\[
\boxed{\begin{aligned}
\mathcal D_Y={}&-\int_{[Y,2Y)}W_{Y,s}(x)\,dE(x)\\
&+\int_{[2Y,\infty)}
\frac{j_s(\log(x/(2Y)))^2-j_s(\log(x/Y))^2}{xF(x)}\,dE(x).
\end{aligned}} \tag{5}
\]
The first line is the newly excluded physical interval: explicitly it is
\[
-\sum_{Y\le m<2Y}\frac{\Lambda(m)j_s(\log(m/Y))^2}{mF(m)}
+\int_Y^{2Y}\frac{j_s(\log(x/Y))^2}{xF(x)}dx. \tag{6}
\]
The second line of (5) is the shifted **tail**, with every prime power \(m\ge2Y\) and the corresponding negative density integral. At \(m=2Y\) its numerator is \(-j_s(\log2)^2\), as required: the new step has zero Hardy value at its own endpoint, while the old step need not. Equations (4)--(6) are the requested clock, physical-scale, prime-power, and density decomposition.

Two equivalent forms show the F-ground response directly. For fixed \(s\), differentiation in \(h=\log Z\) is legitimate after a finite observation cutoff; crossing an atom produces no extra boundary term because \(j_s(0)=0\). Passing the cutoff using the finite-source Hardy tail gives
\[
\mathcal D_Y=-\int_{\log Y}^{\log(2Y)}dh
\int_{[e^h,\infty)}
\frac{2j_s(\log(x/e^h))j_s'(\log(x/e^h))}{xF(x)}\,dE(x). \tag{7}
\]
Alternatively, Stieltjes integration by parts in (2), with vanishing lower and infinite boundary terms, and \(F'=-E/x^2\), gives the score form
\[
\boxed{\displaystyle
\mathcal G_{Z,s}=\int_0^\infty r(Ze^t)
\bigl[(1-r(Ze^t))j_s(t)^2-2j_s(t)j_s'(t)\bigr]dt,
\quad r(x)=\frac{E(x)}{xF(x)}=-b_F(x).} \tag{8}
\]
Thus (5) is also an exact change in the sampled original ground \(r\), not a universal translation-invariant conductance. Equation (8) includes the discrete prime-power jumps through the actual discontinuous \(E\); it must not be used to discard the explicit endpoint terms in (5)--(6).

## Size of the variation

There is a genuine additional clock factor in the **absolute variation**. Put \(\chi_{Z,\tau}=\sqrt Z\,T_\tau\beta_Z\), so \(\mathcal G_{Z,\tau}=Q(\chi_{Z,\tau},\chi_{Z,\tau})\). Its exact log-Fourier transform is
\[
\widehat{U\chi_{Z,\tau}}(\xi)=
\frac{Z^{-i\xi}e^{-\tau\Phi(i\xi)}}{1/2+i\xi}. \tag{9}
\]
The multiplier difference \(e^{-i\xi\ell}-1\) for \(Z:Y\to2Y\) costs one \(|\xi|\), and the clock difference costs \((s'-s)|\Phi(i\xi)|\). With \(\rho(\xi)\asymp|\xi|\), \(|\Phi(i\xi)|\ll |\xi|\log(2/|\xi|)\) near zero and a spectral gap outside, Plancherel gives
\[
\|\chi_{Y,s}\|_2+\|\chi_{2Y,s'}\|_2\ll_c s^{-1/2},\qquad
\|\chi_{2Y,s'}-\chi_{Y,s}\|_2
\ll_c\frac{\log s}{s^{3/2}}. \tag{10}
\]
The second estimate keeps the full histories and the exact adjacent baseline \(s'=c\log(2Y-1)\); \(s'-s=c\log((2Y-1)/(Y-1))=c\log2+O_c(Y^{-1})\).

Let \(\nu_0>0\) be an available PNT-ground constant such that \(\sup_{x\ge R}|b_F(x)|\ll e^{-\nu_0\sqrt{\log R}}\). For any \(0<\kappa<\nu_0\sqrt c\), the quantitative heavy-age split at \(R=Y\exp(a s\log s)\), with \(a<1\) near \(1\), applies to \(\chi_{Y,s}\), \(\chi_{2Y,s'}\), and their difference. For the difference, first write it as \(T_s\) applied to the right-supported input \(T_{s'-s}(\sqrt{2Y}\beta_{2Y})-\sqrt Y\beta_Y\); its input norm is \(O(1)\), and its support begins at \(Y\). The same is true after \(H\) or \(V\), since these commute with the clock and preserve causal support. The early probability is \(e^{-d s^{1-r}\log s}\) for some \(a/2<r<1/2\); on the late side \(|b_F|\ll e^{-\kappa\sqrt{\log Y\log\log Y}}\). Polarizing \(Q\), then using (10), proves
\[
\boxed{\displaystyle
|\mathcal G_{2Y,s'}-\mathcal G_{Y,s}|
\ll_{c,\kappa}
\frac{\log s}{s^2}
e^{-\kappa\sqrt{\log Y\log\log Y}}.} \tag{11}
\]
The early component is smaller than the displayed scale by every fixed power of \(s\). The clock and physical-dilation pieces (4)--(5) separately satisfy this order, with the physical piece lacking the \(\log s\) numerator. This is an absolute continuity estimate for the scalar ground kernel, not a sign or cancellation theorem.

## Sign test and the remaining zero-mode sum

No sign of (3) follows from the Picone relation and positive clock law alone. To see this with a ground-coupled model, choose \(m\) strictly between \(Y\) and \(2Y\), a nonzero real \(\alpha\) small enough to keep \(F_*>0\), and set
\[
E_*(x)=\alpha1_{x\ge m},\qquad
F_*(x)=F_\infty+\frac{\alpha}{\max(x,m)}. \tag{12}
\]
Then \(F_*'=-E_*/x^2\), \(dE_*=\alpha\delta_m\), and, for the same complete positive clock law,
\[
\mathcal G^*_{2Y,s'}=0,\qquad
\mathcal G^*_{Y,s}=\frac{\alpha}{mF_*(m)}j_s(\log(m/Y))^2\ne0. \tag{13}
\]
The no-jump atom makes \(j_s(t)>0\) for every \(t>0\). Thus \(\mathcal G^*_{2Y,s'}-\mathcal G^*_{Y,s}\) has sign \(-\operatorname{sgn}\alpha\): both signs occur for admissible positive \(F_*\), even with \(E_*(x)=O(1)\). This is only a structural no-go for generic \(E\); the actual arithmetic source may obey additional signed constraints.

For full dyadic blocks \(Y_t=2^tA\), let \(G_t=\mathcal G_{Y_t,s_{Y_t-1}}\) and \(M_t=\int_{(A-1,2Y_t-1]}y^{-1/2}dE(y)\). The exact baseline rank-one summation remains
\[
\sum_{t=0}^T G_t(M_t^2-M_{t-1}^2)
=G_TM_T^2-\sum_{t=0}^{T-1}(G_{t+1}-G_t)M_t^2,
\qquad M_{-1}=0. \tag{14}
\]
Equation (3)--(8) gives the **exact** clock/dilation/endpoint content of each variation in the second term. The source-specific PNT bound \(|M_t|^2\ll_A Y_t\Delta_{Y_t}^2\) and (11) yield only
\[
\left|\sum_{t<T}(G_{t+1}-G_t)M_t^2\right|
\ll_{A,c,\kappa}\sum_{t<T}
\frac{Y_t\Delta_{Y_t}^2\log\log Y_t}{(\log Y_t)^2}
e^{-\kappa\sqrt{\log Y_t\log\log Y_t}}. \tag{15}
\]
The positive majorant in (15) grows at the terminal dyadic scale and supplies neither convergence nor a signed cancellation. It is lower by roughly one \(\log Y_t\) factor than the unsigned baseline envelope, but the boundary \(G_TM_T^2\), the true later-clock drifts, and the rank-one residuals remain separate. A closing argument would need an arithmetic estimate of the signed sum in (14) together with those other terms; generic ground coupling does not fix its sign.
