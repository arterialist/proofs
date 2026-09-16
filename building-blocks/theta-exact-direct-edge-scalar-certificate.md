# Exact scalar certificate for the plus optimizer allowance

This note reduces the remaining optimizer question to one auditable scalar.
It applies no pointwise ground bound and takes no absolute values across the
Woodbury combination.  The common score subtraction, the separate
continuous and prime crossing means, both prime orientations, and every
prime power remain present.

The target is

\[
 n[v_U]<a_+^{\rm low}:=0.46511165192687.                      \tag{1}
\]

The decimal in (1) is a previously certified rational lower endpoint for
the exact Suzuki allowance \((1+k_0)/4\), not numerical quadrature.

## 1. Substitute the affine coefficient first

Put

\[
 t_s=\frac{1/2+\delta U(y,q)}{U(q,q)},\qquad
 z=M^{-1}(\delta S_y-t_sS_q).                                \tag{2}
\]

The exact score relation gives

\[
                         n[v_U]=n[z].                          \tag{3}
\]

Thus no estimate of the score vector \(\varphi=y/\psi\) is added to the
residual.  Define the nonnegative component forms \(A_c,A_p\), their sign
profiles \(w_c,w_p\), and

\[
 d_c=A_c[\varepsilon],\qquad d_p=A_p[\varepsilon],
 \qquad \varepsilon=\operatorname {sgn}.                     \tag{4}
\]

Let

\[
 b_i=\langle z,w_i\rangle_\gamma,qquad
 g_i=\langle\varphi,w_i\rangle_\gamma,qquad i=c,p,           \tag{5}
\]

and

\[
 b_0=A_c(z,\varphi)+A_p(z,\varphi),                           \tag{6}
\]

\[
 d_y=A_c[\varphi]+A_p[\varphi]
       -\frac{|g_c|^2}{d_c}-\frac{|g_p|^2}{d_p}.              \tag{7}
\]

When \(d_y>0\), the exact conditional-edge identity is

\[
\boxed{
\begin{aligned}
 \Theta_{\rm edge}:={}&A_c[z]+A_p[z]
 -\frac{|b_c|^2}{d_c}-\frac{|b_p|^2}{d_p}\\
 &-\frac{\left|b_0-b_cg_c/d_c-b_pg_p/d_p\right|^2}{d_y},\\
 n[v_U]={}&\Theta_{\rm edge}.
\end{aligned}}                                                \tag{8}
\]

If \(d_y=0\), residual Cauchy--Schwarz makes the last numerator zero and
the last quotient in (8) is defined to be zero.  Formula (8) is therefore
valid with this convention in both cases.

This is already a finite scalar certificate:

\[
                         \boxed{\Theta_{\rm edge}<a_+^{\rm low}.} \tag{9}
\]

No determinant positivity or theta-to-Suzuki intertwiner is assumed.

## 2. Edge-integral realization of every term

For \(i=c,p\), let \(J_i\) be its actual nonnegative residual conductance,
let \(m_i=J_i(O_+,O_-)\), and normalize its one-orientation crossing
restriction to \(\pi_i\).  For any \(F,G\), define

\[
 \operatorname{Same}_i(F,G)
 =\frac12\int_{\rm same\ half}
 (F(u)-F(v))\overline{(G(u)-G(v))}\,J_i(du,dv),               \tag{10}
\]

\[
 \operatorname{Cross}_i(F,G)
 =m_i\operatorname{Cov}_{\pi_i}
       (\Delta_\times F,\Delta_\times G).                    \tag{11}
\]

Then

\[
 R_i(F,G)=\operatorname{Same}_i(F,G)
             +\operatorname{Cross}_i(F,G),                   \tag{12}
\]

For (d_y>0), (8) is equivalently

\[
 \Theta_{\rm edge}=R_c[z-s_*\varphi]+R_p[z-s_*\varphi],
 \qquad
 s_*=\frac{b_0-b_cg_c/d_c-b_pg_p/d_p}{d_y}.                  \tag{13}
\]

When (d_y=0), the residual (arphi)-direction vanishes and this display is
read without the (s_*\varphi) projection, consistently with the convention
after (8).

The prime same-half part in (10) is literally

\[
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \int_{\substack{u,u+\log n\in O_2\\\text{same half}}}
 \psi(u)\psi(u+\log n)\Phi(u)\Phi(u+\log n)
 \Delta_nF(u)\overline{\Delta_nG(u)}\,du.                   \tag{14}
\]

The prime crossing covariance in (11) is formed from

\[
 \sum_{\log n>4}\frac{\Lambda(n)}{\sqrt n}
 \int_2^{\log n-2}
 \psi(u)\psi(u-\log n)\Phi(u)\Phi(u-\log n)(\cdots)\,du.    \tag{15}
\]

Thus (14)--(15) retain every proper power, both displacement orientations,
and the crossing mean before squaring.  The continuous component uses the
actual residual Carleman conductance after its two established minorants;
its same-half and crossing terms use the same definitions (10)--(11).

## 3. Woodbury coefficients without lost mixed terms

Let \(R_0=K_0^{-1}\), let \(W=(w_c,w_p,v_*)\), and put

\[
 C=D+W^*R_0W,\qquad
 z_0=R_0(\delta S_y-t_sS_q),qquad
 r=C^{-1}W^*z_0.                                             \tag{16}
\]

Then

\[
                         z=z_0-R_0Wr.                         \tag{17}
\]

Insert (17) into (10)--(15) before integration.  If
\(Z_0=z_0\) and \(Z_j=(R_0W)_j\), define the conditional edge Gram matrix

\[
 G_{jk}=R_c[PZ_k,PZ_j]+R_p[PZ_k,PZ_j],                        \tag{18}
\]

where the single common projection is

\[
 PF=F-s(F)\varphi,qquad
 s(F)=\frac{R_c(F,\varphi)+R_p(F,\varphi)}{d_y}.              \tag{19}
\]

With \(c=(1,-r^T)^T\), equations (13), (17)--(19) give

\[
                         \boxed{\Theta_{\rm edge}=c^*Gc.}    \tag{20}
\]

Equation (20) is the desired mixed prime/continuous Woodbury expression.
In particular, its off-diagonal entries are evaluated before the quadratic
sum.  Replacing them by \(|G_{jk}|\le\sqrt{G_{jj}G_{kk}}\) returns the
failed enormous ceiling and is not part of this certificate.

## 4. First precise unevaluated scalar

The existing normalized continuous-row theorem evaluates all purely
continuous source rows in terms of certified theta integrals and normalized
ground moments.  After the coherent Woodbury combination is formed, its
first unbounded arithmetic entry is

\[
\boxed{
 \mathcal C_P=\int_{O_2}\Gamma_c(P)(u)\,\psi(u)^2d\nu(u),}    \tag{21}
\]

where, on \(u>2\),

\[
 P(u)=e^{u/2}\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       H(u-\log n),                                          \tag{22}
\]

\[
 H(v)=(1-k)\Phi'(v)1_{[-2,2]}(v)
       -2\eta_p\Phi(v)\psi(v)1_{\{v<-2\}}.                  \tag{23}
\]

The two terms in \(H\) must remain combined before differences and squares
are taken.  Its signed moment is known, but no current theorem bounds (21).
Splitting (23) by the triangle inequality would again lose the possible
prime-profile cancellation.

The next scalar is the direct complete-prime row

\[
 \mathcal P_z=\int_{O_2}\Gamma_p(z)(u)\,\psi(u)^2d\nu(u),     \tag{24}
\]

with both orientations and crossing centering retained through (14)--(15).
The exact normalized upper budget can be written

\[
 \left[\frac{\mathcal B+\sqrt{\mathcal C_P}}{\kappa}
       +|A_\varepsilon|C_{\varepsilon,2}\right]^2
 +\mathcal P_z
 <\mathcal A_+,                                               \tag{25}
\]

where

\[
 \mathcal A_+=a_+^{\rm low}+V_f+\frac{m_C^2}{Q}
               -2kz_y+k^2\mathcal E_y.                       \tag{26}
\]

All quantities in \(\mathcal B,\kappa,A_\varepsilon,V_f,Q,k,z_y,
\mathcal E_y\) are the specified actual Gram/theta data.  Formula (25) is
a sufficient row-energy certificate; formula (9) or (20) is exact.

At present (21) is the first precise unevaluated scalar after assembling
the coherent prime input.  Neither its finiteness nor the pointwise ground
bound supplies an upper value small enough for (25).  Therefore no
auditable proof of (1) follows from the published estimates.  Conversely,
the lack of such an upper value is not a failure witness for (1).

The shortest valid continuation is one of:

1. directly enclose the single assembled scalar \(c^*Gc\) in (20), using
   interval bounds for the normalized ground edge measures; or
2. prove a cancellation-aware bound for (21), followed by (24), that makes
   the left side of (25) smaller than the explicit budget (26).

Both routes preserve the common score coefficient and both crossing means.
No RH-strength spectral assertion is used.
