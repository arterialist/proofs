# The actual score-crossing source has a full clock action

The [full-form crossing proof](theta-prime-profile-full-form-domain.md) places the weighted score-crossing source \(S_f=(B\sigma_C)/\rho\) in \(D(K^{1/2})\). Its explicit physical formula permits a stronger conclusion:
\[
 \boxed{\qquad S_f\in D(K),\qquad
          \varphi=\sigma_O/\psi\in D(K^2).\qquad}
\tag{1}
\]
Here \(K\) is the complete actual ground clock on \(L^2(\gamma)\), with \(\gamma=\rho\psi\nu\), and \(\psi\) is the bounded even killed ground at a fixed \(R>0\). This theorem does not put the prime sign profile \(w_p\) or the affine comparison optimizer \(v_U\) in \(D(K)\), and it does not bound their residual energy.

## A rate-integrability test

Let \(q_O(u,dv)\) be the original internal theta jump rate, with continuous density \(\Phi(v)r(|u-v|)/b(u)\) and prime atoms \(\Lambda(n)\Phi(u\pm\log n)/(b(u)\sqrt n)\). For an odd potential \(F\) define
\[
 D_F(u)=\int_O|F(u)-F(v)|q_O(u,dv).
\]
The full ground-clock action, whenever the integral is absolutely defined, is
\[
 V_F(u)=\rho(u)^{-1}
       \int_O\psi(v)[F(u)-F(v)]q_O(u,dv).
\tag{2}
\]
The rank-one part of \(K\) vanishes on odd potentials. Since \(\psi\le P_\infty\), the following sufficient test follows from the closed-form representation theorem:
\[
 F\in V_K,\qquad
 \int_O D_F(u)^2\,\frac{\psi(u)}{\rho(u)}\,d\nu(u)<\infty
 \quad\Longrightarrow\quad
 F\in D(K),\quad KF=V_F.
\tag{3}
\]
For bounded form tests, symmetry and absolute Fubini identify the edge form with \(\langle V_F,\cdot\rangle_\gamma\). Truncation in the form norm extends the pairing to all form tests. The second condition in (3) also makes \(V_F\in L^2(\gamma)\); the factor \(P_\infty\) is harmless at this fixed core. We verify the form membership and rate condition separately below, without differentiating \(\psi\).

## The continuous crossing source

Put \(g_C=\Phi'1_{[-R,R]}\). The physical crossing formula gives, on \(O\),
\[
 F_c(u):=S_{f,c}(u)
 =-e^{|u|/2}Ag_C(u)
 =e^{|u|/2}\int_{-R}^{R}g_C(v)r(|u-v|)\,dv .
\tag{4}
\]
It is odd. On \(u=R+s\), \(0<s<1\), use
\(r(t)=1/(2t)+O(1)\), \(r'(t)=-1/(2t^2)+O(1)\),
and \(g_C(R-t)=g_C(R)+O_R(t)\). Direct integration yields
\[
 F_c(R+s)=\frac12e^{R/2}g_C(R)\log(1/s)+B_R(s),
 \quad |B_R(s)|\le C_R,\quad
 |B_R'(s)|\le C_R(1+|\log s|).
\tag{5}
\]
Reflection gives the other boundary. The exact series
\(r(t)=\sum_{j\ge0}e^{-(2j+1/2)t}\) shows that \(F_c\) and its derivative are bounded away from the two hard boundaries, and \(F_c\) tends to a finite constant at each infinite end.

The logarithm in (5) has an integrable absolute jump-rate singularity. Indeed, for \(0<s<1/2\), splitting the \(t\)-integral at \(s/2\) and \(2s\) gives
\[
 \int_0^1\frac{|\log s-\log t|}{|s-t|}\,dt
 \le C(1+\log^2(1/s)).
\tag{6}
\]
The middle region uses \(|\log s-\log t|\le C|s-t|/s\); the far region integrates \(\log(t/s)/t\). The remainder \(B_R\) costs at most \(C(1+|\log s|)\). Opposite-half endpoints are separated by \(2R\). The continuous part of \(D_{F_c}\) is therefore bounded near either boundary by \(C_R(1+|\log s|^2)\), and it has at most exponential growth at infinity. Its square is integrable against \(\psi\,d\nu/\rho\).

The same splitting with the difference squared proves finite continuous ground energy: the local double integral of
\(|\log s-\log t|^2/|s-t|\) over \((0,1)^2\) is finite. The bounded tails and theta weight pay the remaining edges. Thus the continuous part of the condition \(F_c\in V_K\) holds.

For the prime rate, the departure part is bounded by
\(B_p|F_c(u)|\), where \(B_p\) is the full original prime-departure bound. The arrival terms are translated copies of \(F_c\). Their weighted \(L^2\) norms are summable over every prime power. To see the theta factor explicitly, after squaring one translated arrival and using \(\psi\le P_\infty\), its measure factor is bounded by
\[
 C_R\frac{\Lambda(n)^2}{n}
 e^{|u|/2}\Phi(u)\Phi(u\pm\log n)^2
 |F_c(u\pm\log n)|^2\,du .
\tag{7}
\]
At least one of \(|u|\), \(|u\pm\log n|\) is at least \((\log n)/2\). If the high endpoint is \(u\), split \(e^{|u|/2}\Phi(u)\) into a bounded factor and \(O(e^{-cn})\), then integrate \(\Phi(v)^2|F_c(v)|^2\) at \(v=u\pm\log n\). If the high endpoint is \(v\), split \(\Phi(v)^2\) into \(O(e^{-cn})\) and an integrable theta factor, and use \(e^{|u|/2}\le\sqrt n\,e^{|v|/2}\). The logarithms in (5) are locally square-integrable. The resulting norm is a polynomial in \(n\) times \(e^{-cn/2}\); Minkowski's inequality and \(\Lambda(n)\le\log n\) make the series of arrival norms finite. The prime edge energy is finite by the same translated \(L^2\) bounds and the bounded departure rate. Equation (3) proves
\[
 F_c\in D(K).
\tag{8}
\]

## Every compact core translate, then the full prime source

The other physical crossing formula is
\[
 S_{f,p}=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}F_n,\qquad
 F_n(u)=1_O(u)e^{|u|/2}
       [g_C(u-\log n)+g_C(u+\log n)].
\tag{9}
\]
Each \(F_n\) is odd. It is piecewise \(C^1\), has finitely many finite jumps, and is compactly supported. Its physical product \(\Phi F_n\) is compactly supported and of bounded variation, so its Fourier transform is \(O((1+|\xi|)^{-1})\); the physical logarithmic-form criterion gives \(F_n\in V_K\). At a jump \(s_j\), the continuous absolute rate grows at most
\(C_n(1+|\log|u-s_j||)\), which is locally square-integrable. The prime rate has bounded departure and summable translated arrivals as in (7). Thus (3) puts every \(F_n\) in \(D(K)\).

For completeness, this domain conclusion survives the infinite Mangoldt sum. For \(n>e^{3R}\), the support of \(F_n\) lies where
\(|u|\ge\log n-R\), and its amplitude, one-sided derivative and jumps are \(O_R(\sqrt n)\). The theta envelope on that support, the two-endpoint bound for arrivals into it, and the logarithmic jump estimate above give fixed \(c_R,C_{R,\psi}>0\) and a fixed integer \(M\) such that
\[
 \left\|\frac{\Lambda(n)}{\sqrt n}F_n\right\|_{L^2(\gamma)}
 +\left\|K\!\left(\frac{\Lambda(n)}{\sqrt n}F_n\right)
                                      \right\|_{L^2(\gamma)}
 \le C_{R,\psi}(1+\log n)^M e^{-c_R n}.
\tag{10}
\]
Here are the two estimates behind (10). Put a fixed-width collar around \(\operatorname{supp}F_n\). Inside that collar, \(|u|\ge\log n-R-O(1)\), so the outer \(L^2(\psi\nu/\rho)\) weight contains \(\Phi(u)=O(e^{-c_Rn^2})\). The near-diagonal difference is handled before either term is separated: local integration at the finitely many jump points costs at most \(C_R\sqrt n(1+|\log|u-s_j||)\), and its square is integrable. Outside the collar \(F_n(u)=0\) and \(\operatorname{dist}(u,\operatorname{supp}F_n)\) is bounded below. The arrival integral then contains \(\Phi(v)=O(e^{-c_Rn^2})\) on the support of \(F_n(v)\); the exponential tail of \(r\) handles separated endpoints.

For a prime arrival of displacement \(m\), the square of its \(L^2(\gamma)\) norm is bounded, after translating \(v=u\pm\log m\), by
\[
 C_{R,\psi}\frac{\Lambda(m)^2}{m}
 \int_{\operatorname{supp}F_n}
 e^{|u|/2}\Phi(u)\Phi(v)^2|F_n(v)|^2\,dv .
\tag{10a}
\]
On this support \(|v|\ge\log n-R\), \(|v|\le\log n+R\), and \(|F_n(v)|\le C_R\sqrt n\). For \(m\le n^2\), \(|u|\le3\log n+R\), so the prefactors are polynomial in \(n\), while \(\Phi(v)^2=O(e^{-c_Rn^2})\). The weighted sum of these \(m\) is still polynomial times \(e^{-c_Rn^2}\). For \(m>n^2\),
\[
 |u|\ge\log m-\log n-R,\qquad
 \Phi(u)\le C_R\exp(-c_Rm^2/n^2).
\]
The remaining \(e^{|u|/2}\), \(F_n\), and \(\Lambda(m)/\sqrt m\) factors grow only polynomially in \(m,n\); summing the Gaussian tail from \(m>n^2\) is polynomial times \(e^{-c_Rn^2}\). This proves an estimate stronger than (10) for the prime arrivals. The prime departure is bounded by \(B_p|F_n|\) and is paid by the same high-support theta weight. This bound uses only the fixed-core \(P_\infty\), never a derivative of the ground.

Equation (10) makes the complete series in (9) absolutely convergent in the graph norm of \(K\). Its \(L^2(\gamma)\) limit is the actual prime crossing source from the full-form proof. Closedness gives \(S_{f,p}\in D(K)\). Together with (8),
\[
 \boxed{\qquad S_f=S_{f,c}+S_{f,p}\in D(K).\qquad}
\tag{11}
\]

The actual score action is
\(K\varphi=S_f+\delta S_y-\tfrac14S_q\).
The [exponential-growth operator test](theta-suzuki-variation-full-clock-consumer.md) already proves \(S_y,S_q\in D(K)\), and \(\varphi\in D(K)\) was established before. Equation (11) therefore proves the second assertion in (1). The [action-rank domain criterion](theta-affine-action-rank-domain-obstruction.md) now has only the sign-side second-power input \(\varepsilon\in D(K^2)\) outstanding in its sufficient condition for \(v_U\in D(K)\). Even that operator-domain upgrade would not estimate \(n[v_U]\) below the Suzuki allowance.

These are written operator-domain estimates. The finite coefficient and score-action algebra has Lean coverage in the linked modules, but the singular-rate bounds and complete graph-norm convergence here are not Lean-formalized. No RH conclusion follows.
