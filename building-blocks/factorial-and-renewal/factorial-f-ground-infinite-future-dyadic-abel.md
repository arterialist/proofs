# Infinite-future factorial-ground spatial jump: endpoint cancellation and dyadic Abel reduction

Written original-metric result by RH Agent3, independently audited by the coordinating agent, 2026-09-16. This treats the **future** term in the [fixed-clock moving spatial kernel](factorial-f-ground-moving-kernel-variation.md), at one common later clock (s=c\log(2Y-1)). It keeps the actual arithmetic source (dE=d\psi-dx), all observing prime powers, the complete positive jump law, the coupled factorial ground (F), and atoms at the split point. It proves an exact reduction and a sharper bound for the (F)-correction, not a sign or RH theorem.

## Stieltjes boundary at \(2Y\)

Put (Z=2Y), (j=j_s), and
\[
U_Y(x)=\frac{j(\log(x/Y))^2}{xF(x)},\qquad
U_Z(x)=\frac{j(\log(x/Z))^2}{xF(x)},\qquad
V(x)=U_Y(x)-U_Z(x). \tag{1}
\]
The fixed-clock spatial jump is (J_Y=G_{Y,s}-G_{Z,s}=J_Y^{\rm loc}+J_Y^{\rm fut}), with
\[
J_Y^{\rm loc}=\int_{[Y,Z)}U_Y\,dE,
\qquad J_Y^{\rm fut}=\int_{[Z,\infty)}V\,dE. \tag{2}
\]
The (Z) atom is in the future integral, and (U_Z(Z)=j(0)^2/(ZF(Z))=0). Stieltjes integration by parts, with right-continuous (E=\psi-x), gives the **separate** exact identities
\[
\begin{aligned}
J_Y^{\rm loc}
&= U_Y(Z)E(Z-)-\int_Y^Z E(x)U_Y'(x)\,dx,\\
J_Y^{\rm fut}
&=-V(Z)E(Z-)-\int_Z^\infty E(x)V'(x)\,dx.
\end{aligned} \tag{3}
\]
At (Z), (V(Z)=U_Y(Z)), so the boundary values cancel *exactly*. This remains true when (Z=p^h): using (E(Z)) in only one line would add a false (\Lambda(Z)U_Y(Z)). The infinite boundary vanishes by PNT, the Hardy-profile (H^1) regularity, and the finite-source tail. Consequently
\[
\boxed{J_Y=-\int_Y^\infty E(x)
\left[U_Y'(x)-{\bf1}_{x>Z}U_Z'(x)\right]dx.} \tag{4}
\]
The local term itself has the exact no-jump factor and bound
\[
J_Y^{\rm loc}=e^{-2\lambda s}\int_{[Y,Z)}
\frac{Y\log^2(x/Y)}{x^2F(x)}dE(x),\qquad
|J_Y^{\rm loc}|\ll e^{-2\lambda s}e^{-a\sqrt{\log Y}}. \tag{5}
\]
Thus local/future boundary cancellation does **not** transfer an unsuppressed atom into (4).

## Exact dyadic discrepancy and density annihilation

Let (\kappa_F=\lim F=1+\gamma>0), (r(x)=E(x)/(xF(x))), and
\[
D(x)=2\psi(x)-\psi(2x)
=\sum_{p^h\le x}\log p-\sum_{x<p^h\le2x}\log p,
\qquad K_s(t)=j(t)^2-2j(t)j'(t). \tag{6}
\]
The factorial-ground score identity applied after (4) gives, without dropping either orientation,
\[
\boxed{J_Y=\int_0^\infty [r(Ye^t)-r(2Ye^t)]
\{[1-r(Ye^t)-r(2Ye^t)]j(t)^2-2j(t)j'(t)\}\,dt.} \tag{7}
\]
Define the **actual weighted dyadic Chebyshev correlation**
\[
\mathcal D_{Y,s}:=\int_0^\infty
\frac{D(Ye^t)}{Ye^t}K_s(t)\,dt. \tag{8}
\]
It is an averaged statement; no pointwise RH-strength bound on (D(x)) is assumed. Abel integration by parts is exact because (K_s=j^2-(j^2)'), (j(0)=0), and (D(x)/x\to0):
\[
\mathcal D_{Y,s}
=\int_{[Y,\infty)}\frac{j(\log(x/Y))^2}{x}\,dD(x). \tag{9}
\]
Since (dD(x)=2d\psi(x)-d[\psi(2x)]), switching the second prime-power sum by (m=2x) yields
\[
\boxed{\frac{\mathcal D_{Y,s}}{2\kappa_F}
=\frac1{\kappa_F}\sum_{m=p^h\ge Y}\frac{\Lambda(m)}m
\left[j\!\left(\log\frac mY\right)^2
-j\!\left(\log\frac m{2Y}\right)^2\right],} \tag{10}
\]
where (j(t)=0) for (t<0); the (m=Y) and shifted (m=2Y) endpoint values vanish where appropriate. The continuum-density contribution to the corresponding *constant-(F)* spatial jump cancels exactly, because
\[
\int_Y^\infty\frac{j(\log(x/Y))^2}{x}dx
=\int_{2Y}^\infty\frac{j(\log(x/(2Y)))^2}{x}dx
=\int_0^\infty j(t)^2dt. \tag{11}
\]
Thus (9)--(11) are a literal prime-power/density Abel identity, not an extra positivity estimate. The dyadic identity does not create a zero-mean window kernel: (\int_0^\infty K_s(t)dt=\int_0^\infty j(t)^2dt>0) (indeed (\asymp s^{-1}) by the complete clock's low-frequency law). A constant normalized discrepancy mode would survive it. The actual (D) may cancel, but that cancellation is arithmetic rather than forced by integration by parts.

## Coupled-(F) correction and its true heavy-age size

Equation (7) splits **exactly** as
\[
\boxed{J_Y=\frac{\mathcal D_{Y,s}}{2\kappa_F}+\mathcal R_{Y,s},} \tag{12}
\]
where, writing (x=Ye^t), (e_1=E(x)/x), (e_2=E(2x)/(2x)), (F_1=F(x)), (F_2=F(2x)), and (r_i=e_i/F_i),
\[
\begin{aligned}
\mathcal R_{Y,s}=\int_0^\infty\Big\{&
 [e_1(F_1^{-1}-\kappa_F^{-1})
 -e_2(F_2^{-1}-\kappa_F^{-1})]K_s(t)\\
&-(r_1-r_2)(r_1+r_2)j(t)^2\Big\}\,dt. \tag{13}
\end{aligned}
\]
Equivalently, (\mathcal R_{Y,s}=\int_{[Y,\infty)}[j(\log(x/Y))^2-j(\log(x/(2Y)))^2](F(x)^{-1}-\kappa_F^{-1})\,dE(x)/x\). In particular (F) is **not** silently replaced by its limit in the actual jump.

There is a useful unconditional sharpening of the crude uniform estimate for (13). The classical zero-free-region PNT and (F'=-E/x^2) give, for some fixed (\nu_0>0),
\[
\omega(R):=\sup_{x\ge R}\left(\frac{|E(x)|}{x}
+\left|F(x)^{-1}-\kappa_F^{-1}\right|\right)
\ll e^{-\nu_0\sqrt{\log R}},\qquad
|\text{integrand of (13)}|\ll\omega(Ye^t)^2(j^2+2|jj'|). \tag{14}
\]
The exponent (\nu_0) may be smaller than the PNT exponent for (E/x), since integrating (F'\) costs a polynomial in (\sqrt{\log R}\). Fix (0<\theta<1), (a_s=\theta s\log s), and (q=s^{-r}) with (\theta/2<r<1/2). The exact complete-law Laplace exponent (\Phi(q)=2q\log(1/q)+O(q)) implies
\[
\mathsf P_s(S_s\le a_s)
\le\exp[-(2r-\theta+o(1))s^{1-r}\log s]. \tag{15}
\]
For (t\le a_s), (j=h*\mathsf P_s) and (j'=h'*\mathsf P_s) only use ages at most (a_s); positive-law Minkowski bounds their restricted (L^2(dt)) norms by the probability in (15) times (\|h\|_2,\|h'\|_2). For (t>a_s), (14) gains two copies of (\omega(Ye^{a_s})\). Explicitly,
\[
\widehat j_s(\xi)=\frac{e^{-s\Phi(i\xi)}}{(1/2+i\xi)^2},\qquad
\widehat{j_s'}(\xi)=i\xi\widehat j_s(\xi).
\]
Since (\Re\Phi(i\xi)\asymp|\xi|) at zero and has a gap away from zero, Plancherel gives (\|j\|_2^2+\|j'\|_2^2\ll s^{-1}). Hence for every fixed
\[
0<\kappa<\nu_0\sqrt{\theta c}
\quad\text{and }s=c\log(2Y-1),
\]
the early term from (15) is negligible and the late term proves
\[
\boxed{|\mathcal R_{Y,s}|\ll_{c,\theta,\kappa}
s^{-1}e^{-2\kappa\sqrt{\log Y\log\log Y}}.} \tag{16}
\]
No RH input or absolute interchange of an infinite signed prime-history expansion is used. The full process remains inside (j,j').

Combining (5), (12), and (16) isolates the infinite future term itself:
\[
\boxed{J_Y^{\rm fut}
=\frac{\mathcal D_{Y,s}}{2\kappa_F}
+O_{c,\theta,\kappa}\!\left(
s^{-1}e^{-2\kappa\sqrt{\log Y\log\log Y}}
+Y^{-2c\lambda+o(1)}\right).} \tag{17}
\]
This is a sharper source-specific reduction than the uniform (O(\omega(Y)^2/s)) correction: the coupled-(F) error has **two** heavy-age ground factors, while the established absolute estimate for (J_Y) has one and a factor (s^{-2}). For any fixed one-factor exponent below (\nu_0\sqrt c), choosing (\theta) near one and (\kappa) appropriately makes (16) smaller than that absolute scale despite its (s^{-1}) prefactor.

The joint cancellation of local and future supplies no **automatic** signed reserve: (3) cancels the artificial endpoint exactly, while (10) is an exact Abel rewrite of the same moving prime-power difference. To improve the one-factor heavy-age scale by arithmetic means, the remaining precise target is a one-sided or absolute bound for **the averaged** \(\mathcal D_{Y,s}\), together with the explicit error (16); a pointwise bound on \(D(x)\) is neither invoked nor necessary. This is a conditional arithmetic target, not a claim that the actual \(\mathcal D_{Y,s}\) lacks further cancellation. The local interval and every fixed-ratio future collar are already power suppressed, so a possible large contribution must come from long-age, moving prime-power observations rather than the \(2Y\) endpoint.
