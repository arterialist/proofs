# Zeta zeros force oscillations around the actual theta ground's flat tail

The actual fixed-core killed theta ground tends to a positive constant at each end. Its deviation cannot generally approach that constant from one side: every zeta zero whose exponential moment survives in the ground produces a quantitative oscillation in the far-tail deviation. A known critical-line zero and the proved physical-mass concentration give unconditional instances for unboundedly many core radii. This constrains the *actual* ground equation, with every prime power and both poles present; it does not prove RH or the full affine covariance estimate.

Fix \(R>0\) and the normalized positive even killed ground \(\psi_R\), extended by zero on \(C=[-R,R]\). Use
\[
 G_R=\Phi\psi_R1_O,\quad b(u)=2\cosh(u/2),\quad
 \delta_R=1/2-\alpha_R>0,\quad
 \mu_R=\int bG_R,\quad c_R=\frac{\mu_R}{2\delta_R}.
\]
The [flat-tail theorem](theta-killed-ground-flat-tail-and-pole-balance.md) proves \(\psi_R(u)\to c_R\) as \(|u|\to\infty\). The ground is bounded, so \(G_R\) has every exponential moment. Put
\[
 M_R(z)=\int_{\mathbb R}e^{zu}G_R(u)du,
 \qquad L_R(z)=\int_R^\infty e^{-zu}b(u)[\psi_R(u)-c_R]du
 \quad(\Re z>1/2).
\tag{1}
\]
The moment is entire; the Laplace integral is initially absolute on the stated half-plane. Since the ground is even, \(M_R(z)=\int_R^\infty G_R(u)(e^{zu}+e^{-zu})du\).

## Meromorphic continuation of the complete weak ground row

For \(\Re z>1/2\), the [exponential weak-ground theorem](theta-ground-exponential-weak-cross-row.md) defines the full mixed Weil row
\(Q_R(z)=Q_W(G_R,e^{-z|\cdot|})\), with the physical archimedean form, complete prime shifts, and both pole products. Write \(\ell_n=\log n\). Its physical prime pairing is
\[
 S_R(z)=\int G_R(u)\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       [e^{-z|u+\ell_n|}+e^{-z|u-\ell_n|}]du.
\]
For \(\ell_n\ge|u|\), the bracket equals \(n^{-z}(e^{zu}+e^{-zu})\). Therefore the exact decomposition is
\[
 \boxed{\quad
 S_R(z)=2M_R(z)\left(-\frac{\zeta'}{\zeta}\right)(z+1/2)
            +H_R(z),
 \quad}                                                       \tag{2}
\]
where \(H_R\) is the integral of the difference of the two brackets, summed only over \(\ell_n<|u|\). For each fixed \(u\) that sum is finite. On any compact set of \(z\), its absolute value is \(O(e^{C|u|})\) by \(\Lambda(n)\le\log n\) and \(n<e^{|u|}\). The theta tail of \(G_R\) makes the integral locally uniform. Thus \(H_R\) is **entire**, with no prime power omitted.

The archimedean mixed pairing also continues holomorphically through \(\Re z\ge0\). In the physical jump representation it is a local multiplication pairing plus
\[
 \frac12\iint r(|u-v|)[G_R(u)-G_R(v)]
       [e^{-z|u|}-e^{-z|v|}]du\,dv,
 \qquad r(t)=\frac{e^{-t/2}}{1-e^{-2t}}.
\tag{3}
\]
Near the diagonal, the difference in the second bracket cancels \(r(t)=O(1/t)\), while \(G_R\) is bounded. At large separation, one endpoint has a theta factor and \(r(t)=O(e^{-t/2})\), so the integral and every fixed \(z\)-derivative converge locally uniformly for \(\Re z>-1/2\). Equation (3) agrees with the original form on \(\Re z>1/2\), and supplies the asserted continuation without assigning a theta norm to \(e^{-z|u|}/\Phi\).

The exact two-pole term is
\[
 P_R(z)=\mu_R\left(\frac1{z-1/2}+\frac1{z+1/2}\right).
\tag{4}
\]
At \(z=1/2\), the pole of \(-\zeta'/\zeta(z+1/2)\) in (2) has residue \(2M_R(1/2)=\mu_R\); its negative in \(Q_R=A-S_R+P_R\) cancels (4). This is the same [compensated half-pole value](theta-ground-critical-half-pole-abel-row.md) obtained from the complete PNT error. There is no real singularity at \(z=0\), since \(\zeta(1/2)\ne0\). Hence \(Q_R\) continues meromorphically through \(\Re z\ge0\), holomorphic at every real \(z\ge0\).

If \(\rho\) is a nontrivial zeta zero of multiplicity \(m_\rho\) with \(\Re\rho\ge1/2\), set \(z_\rho=\rho-1/2\). Equation (2) gives
\[
 \operatorname{Res}_{z=z_\rho}Q_R(z)
 =2m_\rho M_R(z_\rho).
\tag{5}
\]
This is a genuine pole when \(M_R(z_\rho)\ne0\); nonvanishing is not assumed for every core. The core arrival and the smooth pole cancellation cannot remove a nonzero residue at a nonreal \(z_\rho\).

The exact weak ground equation from the same source gives, initially on \(\Re z>1/2\),
\[
 Q_R(z)=-C_R(z)-2\delta_RL_R(z),\qquad
 C_R(z)=\int_Ce^{-z|u|}[\mathcal B_R(u)-\mu_Rb(u)/2]du.
\tag{6}
\]
The complete core arrival \(\mathcal B_R\) is locally integrable; compactness makes \(C_R\) entire. Thus \(L_R\) has the meromorphic continuation supplied by (2)--(6), is holomorphic at every real \(z\ge0\), and at a zero detected by (5) has
\[
 \boxed{\quad
 \operatorname{Res}_{z=z_\rho}L_R(z)
 =-\frac{m_\rho M_R(z_\rho)}{\delta_R}.
 \quad}                                                       \tag{7}
\]

## A quantitative oscillation consequence

Let \(\sigma=\Re z_\rho\ge0\), \(\gamma=\Im z_\rho\ne0\), and assume \(M_R(z_\rho)\ne0\). Then
\[
 \boxed{\begin{aligned}
 \limsup_{u\to\infty}e^{-\sigma u}b(u)[\psi_R(u)-c_R]
 &\ge\frac{m_\rho|M_R(z_\rho)|}{\delta_R},\\
 \liminf_{u\to\infty}e^{-\sigma u}b(u)[\psi_R(u)-c_R]
 &\le-\frac{m_\rho|M_R(z_\rho)|}{\delta_R}.
 \end{aligned}}                                                \tag{8}
\]
Equivalently, since \(b(u)\sim e^{u/2}\), the deviation has both signs at least on the scale \(e^{-(1-\Re\rho)u}\). The constants in (8) depend on the fixed core and zero; they are not uniform as \(R\) moves.

Here is the one-sided Laplace argument. Put \(v(u)=e^{-\sigma u}b(u)[\psi_R(u)-c_R]\). By (7), its Laplace transform \(L_R(z+\sigma)\) has a nonzero pole at \(z=i\gamma\), with residue \(r=-m_\rho M_R(z_\rho)/\delta_R\), and is holomorphic on the nonnegative real axis. If \(v(u)\le C\) for all \(u\ge U\), the nonnegative function \((C-v(u))1_{u\ge U}\) has a finite Laplace abscissa at most \(1/2-\sigma\), or at most zero if this number is negative. The nonreal pole forces its abscissa to be at least zero. Landau's theorem for nonnegative Laplace transforms and the absence of a positive-real pole force the abscissa to be exactly zero. Its Laplace transform is therefore defined for \(\Re z>0\), and positivity gives
\[
 |\widehat{(C-v)1_{[U,\infty)}}(\epsilon+i\gamma)|
 \le\widehat{(C-v)1_{[U,\infty)}}(\epsilon).
\]
Multiply by \(\epsilon\) and let \(\epsilon\downarrow0\). The nonreal residue makes the left limit \(|r|\), while the right limit is \(C\), because \(L_R\) is regular at the real point \(\sigma\). Every eventual upper bound obeys \(C\ge|r|\), proving the limsup bound. Apply the same argument to \(-v\) for the liminf bound. This is the classical positive-Laplace residue argument, also used for the [actual coherent-core fluctuations](coherent-core-critical-zero-fluctuation.md).

## Actual-ground nonvanishing on large cores

The proved [physical-mass concentration](theta-ground-physical-mass-concentration.md), equations (13)--(14), shows for each fixed \(z\) with \(\Re z>0\) that \(M_R(z)\ne0\) for every sufficiently large \(R\). Therefore, **if** an offcritical zero \(\Re\rho>1/2\) exists, its stronger-scale inequalities (8) hold for all sufficiently large actual grounds. This conditional implication does not assert that such a zero exists.

For a critical-line zero \(\rho=1/2+i\gamma\), the same concentration gives the uniform fixed-\(\gamma\) estimate
\[
 \frac{M_R(i\gamma)}{m_R}-\cos(\gamma R)\longrightarrow0,
 \qquad m_R=\int_{\mathbb R}G_R>0.
\tag{9}
\]
Indeed the physical mass outside \(|u|\in(R,R+6e^{-\sqrt R/8})\) is negligible and the phase changes by \(O_\gamma(e^{-\sqrt R/8})\) inside. Hence \(M_R(i\gamma)\ne0\) at every sufficiently large \(R\) with \(|\cos(\gamma R)|\ge1/2\). [Hardy's critical-line theorem](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014) supplies a fixed such zero. In particular, for the unbounded sequence \(R_k=2\pi k/\gamma\), the actual ground has the unconditional two-sided bound
\[
 \boxed{\begin{aligned}
 \limsup_{u\to\infty}b(u)[\psi_{R_k}(u)-c_{R_k}]&\ge
       \frac{m_\rho|M_{R_k}(i\gamma)|}{\delta_{R_k}}>0,\\
 \liminf_{u\to\infty}b(u)[\psi_{R_k}(u)-c_{R_k}]&\le
       -\frac{m_\rho|M_{R_k}(i\gamma)|}{\delta_{R_k}}<0
 \end{aligned}}\quad(k\text{ sufficiently large}).
\tag{10}
\]
Thus \(\psi_{R_k}-c_{R_k}\) takes both signs arbitrarily far out, even while it tends to zero. The theorem does not transfer this tail oscillation to the near-core signed affine covariance, and it supplies no RH proof. All conclusions are written analysis, with no Lean formalization claimed.
