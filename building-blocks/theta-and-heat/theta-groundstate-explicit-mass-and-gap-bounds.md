# Explicit ground-state mass bounds and a continuous-remainder gap

The bounded ground-state barrier and actual hard-crossing estimates give positive lower bounds for the exterior ground-state mean, the weighted total mass, and the two finite bridge masses. Substituting these bounds into the continuous-remainder comparison removes its unknown bridge mass. The constants are fixed-core quantities and are not numerically evaluated here.

Fix $R>0$, $C_R=[-R,R]$, $O_R=\mathbb R\setminus C_R$, and the actual killed ground state
$$
 L_{O_R}\psi=\alpha\psi,\qquad
 \|\psi\|_{L^2(O_R,\nu)}=1,\qquad
 \psi>0,\qquad 0<\alpha<\lambda=\tfrac12.
$$
The ground state is even. Choose any proved finite bound
$$
 P_\infty\ge\|\psi\|_\infty
 \tag{1}
$$
from [groundstate bounded weighted crossing](theta-groundstate-bounded-weighted-crossing.md). Define
$$
 \rho(u)=\frac{e^{-|u|/2}}{2\cosh(u/2)}
        =\frac1{e^{|u|}+1},\qquad
 d\gamma=\rho\psi\,d\nu,\qquad
 a=\gamma(O_R),\qquad \mu=\int_{O_R}\psi\,d\nu.
 \tag{2}
$$

## A controlled amount of ground-state mass lies in a finite strip

For a larger radius $S>R$, use the established actual estimates
$$
 L_{O_S}\ge d_S=\lambda-\delta_S,\qquad
 \|B_S\|\le b_S,
 \tag{3}
$$
where $B_S$ is the full hard-crossing operator at $S$. The bounds in the public theta form and [killed core return comparison](theta-killed-core-return-comparison.md) have
$\delta_S\to0$, $b_S\to0$, retaining all prime powers and the singular continuous crossing kernel. Choose a finite $S$ such that
$$
 d_S>\alpha+b_S.
 \tag{4}
$$
Such $S$ exists because $\alpha<\lambda$.

Extend $\psi$ by zero on $C_R$, and split it as
$$
 \psi=\psi_{\rm strip}+\psi_{\rm far},\qquad
 \psi_{\rm strip}=1_{\{R<|u|\le S\}}\psi,\quad
 \psi_{\rm far}=1_{\{|u|>S\}}\psi.
$$
Both pieces are in the full form domain. This is an application of the established hard-projection domain theorem at $S$, not a differentiation of the indicators. The energy of the zero extension is exactly $\alpha$. Put
$$
 s=\|\psi_{\rm strip}\|_\nu,\qquad
 t=\|\psi_{\rm far}\|_\nu,\qquad s^2+t^2=1.
$$
The strip killed form is nonnegative. Applying (3) to the far part and using the exact hard-block cross term gives
$$
 \alpha
 =E_{C_S}[\psi_{\rm strip}]+E_{O_S}[\psi_{\rm far}]
      -2\operatorname{Re}\langle B_S\psi_{\rm strip},\psi_{\rm far}\rangle
 \ge d_St^2-2b_Sst
 \ge d_St^2-b_S.
 \tag{5}
$$
The strip vector vanishes on the smaller core $C_R$, which does not change the validity of the $C_S$ bound. The last step is $2st\le s^2+t^2=1$. Therefore
$$
 \boxed{\quad
 \int_{\{R<|u|\le S\}}\psi^2\,d\nu=s^2
 \ge m_0:=1-\frac{\alpha+b_S}{d_S}>0.
 \quad}
 \tag{6}
$$
All crossing histories remain in (5). No claim that the crossing term has a favorable sign was used.

## Positive lower bounds for the actual masses

Since $0\le\psi\le P_\infty$, one has $\psi^2\le P_\infty\psi$. Also $\rho(u)\ge\rho(S)$ on the strip. Thus (6) gives
$$
 \boxed{\quad
 \mu\ge\mu_0:=\frac{m_0}{P_\infty},\qquad
 a\ge a_0:=\frac{\rho(S)m_0}{P_\infty}.
 \quad}
 \tag{7}
$$
Let
$$
 b=\gamma((R,S)).
$$
Evenness of $\psi,\rho,\nu$ makes the positive and negative strip masses equal and divides the strip $L^2$ mass equally. Consequently
$$
 \boxed{\quad
 b\ge b_0:=\frac{\rho(S)m_0}{2P_\infty}>0,\qquad
 a_0=2b_0.
 \quad}
 \tag{8}
$$
Endpoint choices do not affect these integrals since $\nu$ has a density.

Cauchy--Schwarz and the ground-state normalization provide a ground-state-independent upper bound
$$
 a\le\bar a:=
 \left(\int_{O_R}\rho^2\,d\nu\right)^{1/2}
 \le\rho(R)\sqrt{\nu(O_R)}.
 \tag{9}
$$
Also $b\le a/2$, by reflection and inclusion in one exterior half-line. In particular $2b_0\le a\le\bar a$. The quantities in (7)--(9) involve only the proved bound $P_\infty$, the actual tail/crossing inputs and $\alpha$, and explicit theta integrals.

The odd-column denominator in the signed finite-block comparison has an additional elementary lower bound. For $q=\tau_O$,
$$
 \frac{q(u)}{\rho(u)}
 =\operatorname{sgn}(u)(e^{|u|}-1).
$$
Hence
$$
 d_Q=\frac1a\int_O|q/\rho|^2d\gamma
 \ge(e^R-1)^2>0.
 \tag{9a}
$$
This removes a separate unknown positive denominator from that comparison without any pointwise lower bound on $\psi$.

## A positive gap bound with no unknown bridge mass

The full continuous-remainder source [continuous remainder explicit gap](theta-continuous-remainder-explicit-gap.md) proves
$$
 E_{\rm c}^{\rm rem}(F)\ge\eta_0\|F\|_\gamma^2,\qquad
 \gamma F=0,\qquad
 \eta_0=\frac{2h\beta b^2}{ha/2+2\beta b},
 \tag{10}
$$
for
$$
 h=e^R-1>0,\qquad \beta=\frac1{e^{4S}-1}>0.
$$
Its bridge intervals are precisely $(R,S)$ and $(-S,-R)$. The source proves all factors in (10) from its two-cell matrix; no additional factor of two is introduced here.

For $b>0,a>0$, the expression in (10) decreases with $a$ and increases with $b$. The latter claim follows directly by differentiating
$b^2/(ha/2+2\beta b)$, whose derivative has positive numerator
$ha\,b+2\beta b^2$. Equations (8)--(9) therefore give
$$
 \boxed{\quad
 \eta_0\ge
 \underline\eta:=
 \frac{2h\beta b_0^2}{h\bar a/2+2\beta b_0}>0.
 \quad}
 \tag{11}
$$
A slightly smaller expression follows just from $b\le a/2$:
$$
 \eta_0\ge
 \frac{2h\beta b_0^2}{\bar a(h/2+\beta)}>0.
 \tag{12}
$$
Both bounds have removed the unknown actual values of $a$ and $b$ from the lower gap constant.

Every internal prime-power edge is added to the continuous remainder, so the complete centered remainder generator also satisfies
$$
 A_{\rm rem}|_{1^\perp}\ge\underline\eta.
 \tag{13}
$$
Using the exact covariance-clock identity yields, for every centered weighted source,
$$
 \mathcal C(f,f)\le\frac{J_W(f)}{a+\underline\eta}
 \le\frac{J_W(f)}{a_0+\underline\eta}.
 \tag{14}
$$
The actual source map is bounded on all core $L^2$ inputs by the weighted crossing theorem, so (14) applies to their full centered and affine source combinations.

There is also a bound for the improvement over the old rank-one denominator with no unknown mass in its coefficient. Since $a\le\bar a$, monotonicity gives
$$
 \boxed{\quad
 \frac1aJ_W(f)-\mathcal C(f,f)
 \ge\frac{\underline\eta}
          {\bar a(\bar a+\underline\eta)}J_W(f).
 \quad}
 \tag{15}
$$
Equivalently the exact covariance is at most the fraction
$\bar a/(\bar a+\underline\eta)<1$ of the old bound $J_W(f)/a$. The corresponding affine comparisons must still be obtained by minimizing over the complete source $f-cq$; no scalar affine term may be removed when using (14)--(15).

These are symbolic lower enclosures in terms of proved fixed-core data. Evaluating them requires actual upper enclosures for $P_\infty,\alpha,b_S,\delta_S$ and the theta mass integral, with (4) checked. Their positivity proves no large-core signed Schur comparison and supplies no threshold-uniform estimate.

## Attribution and formal scope

The closed-form variational inverse, nonnegative-form Cauchy–Schwarz, finite-rank inverse identities and affine completion of squares used here are classical. The actual theta ground state, full continuous kernel, every prime power and stated fixed-core domains remain part of the theorem. These are written proofs; no Lean formalization of this profile comparison or evaluation of the required arithmetic smallness is asserted.
