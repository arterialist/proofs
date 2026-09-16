# Literal Picone cross for the actual births at \(p\) and \(2p\)

*Research and initial proof: RH Agent3. Independent mathematical audits and publication: RH Proof.*

This uses the original \(L^2((1,\infty),dx)\) factorial ground, literal frozen-source innovations, the full continuum density, and **all** observing prime powers. It does not use normalized theta cells or assume RH. The conclusion is a leading-order cancellation between the Picone prime and density cross observations, with no sign for their small difference.

## Definitions and exact endpoints

The actual ground from [the original $L^2$ domain theorem](factorial-ground-state-original-l2-domain.md) is
\[
F(x)=\log x-\sum_{m\le x}\frac{\Lambda(m)}m+\frac{\psi(x)}x,
\qquad x^2F'(x)=x-\psi(x)=-E(x)\quad\text{a.e.} \tag{1}
\]
It is continuous, positive for \(x>1\), and \(F(x)\ge1/12\) for \(x\ge2\). All sums include prime powers with the right-continuous endpoint convention. Let \(H g(x)=x^{-1}\int_1^xg(y)dy\). The literal innovation at integer \(n\) is
\[
v_n(x)=\Lambda(n)\frac{1_{x\ge n}}x-\int_{n-1}^{n}\frac{1_{x\ge t}}xdt,
\qquad w_n=Hv_n. \tag{2}
\]
For an odd prime \(p\), \(\Lambda(p)=\log p\) and \(\Lambda(2p)=0\). Define \(a=2p-1\),
\[
d_n=\int_{n-1}^{n}\log(n/t)dt
=1-(n-1)\log\frac n{n-1},
\quad A_p(x)=(\log p-1)\log(x/p)-d_p. \tag{3}
\]
The exact Hardy images on their common support are
\[
w_p(x)=A_p(x)/x\quad(x\ge 2p-1),
\qquad
w_{2p}(x)=-j_p(x)/x, \tag{4}
\]
where \(w_{2p}=0\) below \(a\) and
\[
j_p(x)=
\begin{cases}
(x-a)-a\log(x/a),&a\le x<2p,\\
\log(x/(2p))+d_{2p},&x\ge2p.
\end{cases} \tag{5}
\]
The formulas meet continuously at \(2p\), since \(j_p(2p-)=d_{2p}\). There is no atom at \(2p\), and the value at \(a\) is zero even if \(a\) is a prime power.

Write the signed Picone polarized cross as
\[
Q_p:=\mathcal P_F(w_p,w_{2p})-\mathcal C_F(w_p,w_{2p}),
\quad
\mathcal P_F(h,k)=\sum_{m\ge2}\frac{\Lambda(m)h(m)k(m)}{F(m)},
\quad
\mathcal C_F(h,k)=\int_1^\infty\frac{h(x)k(x)}{F(x)}dx. \tag{6}
\]
Then the **complete exact** prime-minus-density expression is
\[
\boxed{\displaystyle
Q_p=-\sum_{m\ge2p+1}\frac{\Lambda(m)A_p(m)j_p(m)}{m^2F(m)}
 +\int_{2p-1}^{\infty}\frac{A_p(x)j_p(x)}{x^2F(x)}dx.} \tag{7}
\]
The sum runs through *every* prime power \(m\ge2p+1\), including arbitrarily late observations. The density integral includes the half-open birth ramp \([2p-1,2p)\), which cannot be replaced by a point event. Both terms converge absolutely because their summands/integrands are \(O_p((1+\log x)^2/x^2)\).

The original source cross itself also has a simple exact value. Since \(v_p(x)=(\log p-1)/x\) for \(x\ge p\) while \(v_{2p}(x)=-(x-2p+1)/x\) on \([2p-1,2p)\) and \(-1/x\) thereafter,
\[
\boxed{\displaystyle
\langle v_p,v_{2p}\rangle_{L^2(dx)}
=-(\log p-1)\left[\int_{2p-1}^{2p}\frac{x-2p+1}{x^2}dx
+\int_{2p}^{\infty}\frac{dx}{x^2}\right]
=-(\log p-1)\log\frac{2p}{2p-1}.} \tag{8}
\]
Picone polarization gives the exact complementary channel
\[
\langle R_Fv_p,R_Fv_{2p}\rangle
=\langle v_p,v_{2p}\rangle-Q_p,
\qquad R_F=A_FH. \tag{9}
\]
The same cross can be written directly in the requested ground-score coefficient. Put \(b_F(x)=xF'(x)/F(x)=-E(x)/(xF(x))\), \(B_F(x)=1+b_F(x)\), \(c_p=\log p-1\), and
\[
k_p(x)=\begin{cases}x-a,&a\le x<2p,\\1,&x\ge2p.\end{cases}
\]
Since \(R_Fv=v-B_FHv\), expansion of the original \(L^2(dx)\) square, with no potential term dropped, yields the **exact score form**
\[
\boxed{\displaystyle
Q_p=\int_a^\infty
\frac{-c_pj_p(x)B_F(x)-A_p(x)k_p(x)B_F(x)
+A_p(x)j_p(x)B_F(x)^2}{x^2}\,dx.} \tag{9a}
\]
Here \(v_p=c_p/x\) on the integration support and \(v_{2p}=-k_p/x\). Equation (9a) is algebraically identical to the full atomic-minus-density formula (7), by the Picone identity. It makes explicit that the actual \(b_F\) term remains inside the ground-gradient cross; setting \(b_F=0\) is not an admissible simplification.

## Full-observation cancellation and asymptotics

Set \(W_p(x)=w_p(x)w_{2p}(x)/F(x)=-A_p(x)j_p(x)/(x^2F(x))\), extended by zero below \(a\). It is continuous and locally absolutely continuous; \(W_p(a)=0\), and \(E(x)W_p(x)\to0\) at infinity. Since \(dE=d\psi-dx=\sum_{m\ge2}\Lambda(m)\delta_m-dx\), exact Stieltjes integration by parts yields
\[
\boxed{\displaystyle Q_p=\int_{a}^{\infty}W_p(x)dE(x)
=-\int_{a}^{\infty}E(x)W_p'(x)dx.} \tag{10}
\]
No prime-power atom or endpoint is dropped in this identity. It is the cancellation mechanism: the atomic and continuous observations sample the same Hardy-product profile, and their difference is the PNT error \(E\) against its derivative. The factor \(F\) is still the actual ground, not a constant replacement.

The classical quantitative prime number theorem gives, for every fixed \(A>0\), \(|E(x)|\ll_A x/\log^A x\) on \(x\ge2\). From (1), \(|F'(x)|\ll_A1/\log^A x\) divided by \(x\); hence \(F(x)\) has a finite positive limit \(F_\infty\ge1/12\). On \(x\ge a\), (3)--(5) imply, uniformly for \(p\ge5\),
\[
|W_p'(x)|\ll \frac{(\log p)(1+\log(x/p))^2}{x^3}
+\frac{(\log p)(1+\log(x/p))^2|E(x)|}{x^4}. \tag{11}
\]
The short ramp \([a,2p]\) obeys the same loose estimate; the upper bound follows by differentiating its explicit \(j_p\). Inserting (11) into (10), integrating \(x=py\), and choosing the PNT logarithmic exponent sufficiently large gives
\[
\boxed{\displaystyle
Q_p\ll_A\frac{\log p}{p\log^A p}
\quad\text{for every fixed }A>0.} \tag{12}
\]
The implied constant may depend on \(A\). Thus the signed observation cross is smaller by arbitrarily many logarithms than the literal source cross (8); in particular (9) carries the latter's leading negative term. Equation (12) is an *absolute* bound. It supplies no eventual sign for \(Q_p\): the linear \(E W_p'\) term in (10) is not signed by PNT.

More explicitly, (8), (9) and (12) give the original process cross
\[
\langle R_Fv_p,R_Fv_{2p}\rangle
=-\frac{\log p}{2p}+o\!\left(\frac{\log p}{p}\right)<0
\quad\text{for all sufficiently large odd primes }p.\tag{12a}
\]
This is a sign for one actual birth pair. It does not sign the sum of
all birth pairs in the process energy.

The separate observations are much larger and cancel at leading order. For \(p\ge5\), \(A_p(x)>0\) for \(x\ge2p-1\): indeed \(d_p\le1/(p-1)\le1/4\), while \((\log p-1)\log(2-1/p)\ge(\log5-1)\log(9/5)>1/4\). Hence \(W_p<0\) on \(x>a\), so both \(\mathcal C_F(w_p,w_{2p})\) and \(\mathcal P_F(w_p,w_{2p})\) are strictly negative. Scaling \(x=py\), using (3)--(5), \(F(py)\to F_\infty\), and dominated convergence gives
\[
\mathcal C_F(w_p,w_{2p})
=-\frac{\log p}{pF_\infty}
\int_2^\infty\frac{\log y\,\log(y/2)}{y^2}dy
+o\!\left(\frac{\log p}{p}\right)
=-\frac{1+(\log2)/2}{F_\infty}\frac{\log p}{p}
+o\!\left(\frac{\log p}{p}\right). \tag{13}
\]
The ramp contributes only a lower-order term. Combining (12) and (13) yields **the same leading asymptotic** for the full prime-power sum \(\mathcal P_F\). Thus neither separate negative observation is a signed dyadic reserve: its density counterpart cancels it at leading order.

For primes \(p\in[cN,CN]\) with fixed \(0<c<C\), summing (12) gives \(\sum_p|Q_p|\ll_A\log^{-A}N\) after adjusting \(A\). Indeed the whole dyadic-pair observation family is absolutely summable: choosing a stronger exponent in (12) and comparing with the integer series gives \(\sum_{p\ge N}|Q_p|\ll_A\log^{-A}N\) for every fixed \(A>0\). The [theta complete-cone](theta-killed-ground-compact-lower-barrier-dyadic-cone.md) \(q=2\) same-half contribution is instead \(\gg N/\log N\) on a fixed exterior strip. This compares scale only: \(Q_p\) is the actual factorial birth polarization, while the theta edge is a local square for Möbius coefficients \(c_p=-1,c_{2p}=+1\). No identity transfers its positive sign to (7), and the other cross pairs in the accumulated factorial work remain present. The exact obstruction is the all-prime-power minus density cancellation (10), reinforced by \(\Lambda(2p)=0\) in the literal second birth.
