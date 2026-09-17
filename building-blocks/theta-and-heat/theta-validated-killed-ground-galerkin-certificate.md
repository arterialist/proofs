# A validated Galerkin certificate for the killed theta ground

This note specifies an a posteriori certificate sufficient to enclose the
radius-two killed ground, its spectral separation, and the finite Gram data
defining \(k\) and \(\eta_p\). It proves error propagation from the certificate
fields. No validated eigenpair or numerical interval is claimed.

## 1. Operator and finite section

Let
\[
 \mathcal H=L^2(O_2,\nu),\qquad D=L_{O_2},\qquad
 q(u,v)=E_{O_2}(u,v)
\]
be the actual selfadjoint killed operator and its closed form. It contains
the continuous kernel, both prime orientations, every prime power, and core
killing. Its normalized positive ground satisfies
\[
 D\psi=\alpha\psi,\qquad \|\psi\|=1,\qquad \psi>0.             \tag{1}
\]

Choose a finite rational piecewise-polynomial space
\(V_h\subset D(q)\), even under reflection and with zero core trace. Let
\(G_h,Q_h\) be interval matrices enclosing the mass and full form. Enumerate
every prime power whose displacement meets two basis supports; enclose the
remaining shifts with an all-integer theta tail. Split the continuous
diagonal at a rational \(h_0>0\), using the squared basis increment against
\(r(t)\) on \(|t|\le h_0\).

An interval generalized eigensolve produces a rational vector \(c_h\), a
normalized \(\phi_h\in V_h\), and an interval \(I_1\) for its Ritz value
\(\lambda_h=q[\phi_h]\).

## 2. Required spectral certificate

The certificate must contain these outward rational bounds.

1. A strong residual
   \[
   \|(D-\lambda_h)\phi_h\|_{\mathcal H}\le\varepsilon_{\rm op}. \tag{2}
   \]
   A form-dual residual alone is insufficient unless accompanied by a
   certified resolvent conversion.
2. Rational numbers
   \[
   a_1<\lambda_h<b_1<\beta_2<1/2                              \tag{3}
   \]
   such that \(D\) has exactly one eigenvalue in \(I_1=[a_1,b_1]\) and
   \[
   \sigma(D)\setminus I_1\subset[\beta_2,\infty).              \tag{4}
   \]
3. A nonnegative, nonzero eigenvector in \(I_1\). Positivity improvement
   then identifies it with the simple ground (1).

Put \(g=\beta_2-b_1>0\), and require \(\varepsilon_{\rm op}<g\).
This comparison of the residual with the gap is needed to identify the
eigenvalue near \(\lambda_h\) with the ground eigenvalue in (10).
The known distance \(1/2-\alpha>d_0\) does not establish (4), because
another discrete eigenvalue may lie below \(1/2\).

One finite proof of (4) is a complement coercivity certificate. Provide
rational \(\beta_h,\beta_\infty,\tau\) such that
\[
 q[x]\ge\beta_h\|x\|^2\quad(x\in\phi_h^\perp\cap V_h),\qquad
 q[y]\ge\beta_\infty\|y\|^2\quad(y\in(1-P_h)D(q)),             \tag{5}
\]
\[
 |q(x,y)|\le\tau\|x\|\,\|y\|.                                \tag{6}
\]
Then
\[
 \beta_2^{\rm cert}=\frac{\beta_h+\beta_\infty
 -\sqrt{(\beta_h-\beta_\infty)^2+4\tau^2}}2                  \tag{7}
\]
is a lower bound on the complement. A rational lower enclosure of (7)
above \(b_1\) proves (4). All hard crossings between \(V_h\) and its
complement must be included in \(\tau\).

## 3. Eigenpair enclosure

Let \(P_\alpha\) be the ground projection. The spectral theorem gives
\[
 \|(1-P_\alpha)\phi_h\|\le\varepsilon_{\rm op}/g.              \tag{8}
\]
After choosing the positive sign,
\[
 \boxed{\|\psi-\phi_h\|\le
 \epsilon_\psi:=\sqrt2\,\varepsilon_{\rm op}/g,}              \tag{9}
\]
\[
 \boxed{|\alpha-\lambda_h|\le\varepsilon_{\rm op},\qquad
        \lambda_2(D)\ge\beta_2.}                              \tag{10}
\]
Indeed write \(\phi_h=a\psi+z\), \(z\perp\psi\), and use
\(\|z\|\le\varepsilon_{\rm op}/g\) and
\(1-a\le\|z\|^2/(1+a)\). The residual places some spectral value
within \(\varepsilon_{\rm op}\) of \(\lambda_h\); since every other
spectral value is at least \(\beta_2\), the required
\(\varepsilon_{\rm op}<g\) makes that value \(\alpha\).

## 4. Strong norm required by prime profiles

The translated pointwise products need more than (9). The certificate must
also specify a weighted Banach norm \(X\), for example
\[
 \|f\|_X=\|f\|_{\mathcal H}
 {}+\sup_{u\in O_2}e^{3e^{2|u|}/4}|f(u)|,
\]
and a rational
\[
 \boxed{\|\psi-\phi_h\|_X\le\epsilon_X.}                      \tag{11}
\]
This can be proved from the residual equation using the reduced resolvent
bound \(1/g\), continuous boundary regularity, and the complete prime theta
tail. The global bound \(P_*\) alone does not give a small error.

## 5. Operator and inverse perturbation

Write \(M(\psi,\alpha)\), \(w_c(\psi)\), \(w_p(\psi)\),
\(F(\psi,\alpha)\), and \(v_*(\psi,\alpha)\) for the exact data. The
certificate supplies rational Lipschitz bounds, for example
\[
 \|M-M_h\|\le L_M(\epsilon_X+\varepsilon_{\rm op})=:\delta_M, \tag{12}
\]
and similarly
\[
 \|w_i-w_{i,h}\|\le\delta_{w_i},\quad
 \|F-F_h\|\le\delta_F,\quad
 \|v_*-v_{*,h}\|\le\delta_v.                                 \tag{13}
\]
These constants use the same finite prime split and theta tails as \(Q_h\).

If
\[
 M_h\ge m_hI,\qquad \delta_M<m_h,                             \tag{14}
\]
then the resolvent identity gives
\[
 \|M^{-1}\|\le\frac1{m_h-\delta_M},\qquad
 \|M^{-1}-M_h^{-1}\|\le
 \frac{\delta_M}{m_h(m_h-\delta_M)}.                          \tag{15}
\]

## 6. All eight Gram entries

The five Woodbury entries are
\[
 A_{cc},A_{cp},A_{pp},b_c,b_p,                               \tag{16}
\]
and the three score-rank entries are
\[
 d_y,\qquad h_y=\langle M^{-1}v_*,v_*\rangle,\qquad
 j_y=\langle M^{-1}S,v_*\rangle.                             \tag{17}
\]

For a generic inverse Gram entry
\[
 G(x,y)=\langle M^{-1}x,y\rangle,
\]
with \(\|x-x_h\|\le\delta_x\), \(\|y-y_h\|\le\delta_y\), (15) gives
\[
\boxed{\begin{aligned}
 |G(x,y)-G_h(x_h,y_h)|\le{}&
 \frac{\delta_M}{m_h(m_h-\delta_M)}\|x_h\|\,\|y_h\|\\
 &+\frac{\delta_x\|y_h\|+\delta_y\|x_h\|+\delta_x\delta_y}
 {m_h-\delta_M}.
\end{aligned}}                                                \tag{18}
\]
For \(A_{cc}=d_c+G(w_c,w_c)\), add the certified radius for \(d_c\).
Apply (18) to \((w_c,w_c),(w_p,w_c),(w_p,w_p),(F,w_c),(F,w_p)\)
to enclose the five entries (16). Apply it to \((v_*,v_*)\) and
\((S,v_*)\) for \(h_y,j_y\). Enclose \(d_y\) directly from its complete
continuous and prime edge Gram. This proves error propagation for all eight
entries.

## 7. Determinants and coefficient intervals

From outward intervals, compute
\[
 \underline\Delta_A=\underline A_{cc}\underline A_{pp}
 -\max(|\underline A_{cp}|,|\overline A_{cp}|)^2.             \tag{19}
\]
Accept
\[
 \eta_p=(A_{cc}b_p-A_{cp}b_c)/\Delta_A                       \tag{20}
\]
only if \(\underline\Delta_A>0\). Likewise put
\[
 \underline D_y=\underline d_y+\underline h_y                \tag{21}
\]
and accept \(k=j_y/D_y\) only if \(\underline D_y>0\). If the interval
contains zero, one may set \(k=0\) only after separately proving exact
vanishing of \(d_y\) and \(v_*\).

## 8. Replay artifact

A replayable certificate must contain:

1. rational basis definitions, \(G_h,Q_h\), theta heads and tails, and the
   complete finite prime-power list;
2. \(c_h,I_1,\varepsilon_{\rm op}\);
3. \(\beta_h,\beta_\infty,\tau\), with the lower enclosure (7);
4. \(\epsilon_\psi,\epsilon_X\);
5. \(m_h,\delta_M\) and every source/profile error in (13);
6. midpoint and radius for all eight entries;
7. positive lower endpoints (19), (21);
8. rational intervals for \(k,\eta_p\), followed by the exact direct-edge
   scalar \(c^*Gc\).

Every infinite sum must list its finite prime-power head and all-integer
tail. Every continuous integral must list its diagonal strip and
off-diagonal interval enclosure.

No such numerical artifact currently exists. This theorem shows that an
artifact with these fields validates the ground eigenfunction, second
spectral value, all eight Gram entries, and both coefficients. It does not
claim the hypotheses have been verified and makes no RH assertion.
