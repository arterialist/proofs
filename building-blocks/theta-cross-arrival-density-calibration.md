# Exact density calibration of the full cross-arrival profile

The cross-prime density model has an exact coefficient fixed by the actual ground-state masses. Its continuous correction is uniformly small, including at $R=2$. The arithmetic error is a specific full prime-comb discrepancy with the actual ground state inside the test. Current boundedness estimates control its norm but do not prove the relative smallness needed for a passing affine comparison.

Keep the notation of [full cross arrival covariance repair](theta-full-cross-arrival-covariance-repair.md):
$$
 \rho=(e^{|u|}+1)^{-1},\quad d\gamma=\rho\psi\,d\nu,\quad
 a=\gamma(O),\quad \mu=\int_O\psi\,d\nu,\quad
 K\varepsilon=\varepsilon T,\quad \varepsilon=\operatorname{sgn}u.
$$
The ground state $\psi$ and $\gamma$ are even. Every occurrence of $\psi$ below is this actual full killed ground state.

## Exact density and continuous correction

Let $g_-(v)=e^{v/2}\Phi(v)\psi(v)$ for $v<-R$, and zero elsewhere. For $u>R$, the complete cross-prime profile is
$$
 T_{\rm p}(u)=2\sum_{n\ge2}\Lambda(n)g_-(u-\log n).
 \tag{1}
$$
Replacing the arithmetic measure by Lebesgue measure on $[1,\infty)$ gives exactly
$$
 \begin{split}
 T_{\rm p,dens}(u)
 &=2\int_1^\infty g_-(u-\log t)\,dt\\
 &=2e^u\int_{-\infty}^{-R}e^{-v/2}\Phi(v)\psi(v)\,dv
 =C e^u,\qquad C=\mu-a.
 \end{split}
 \tag{2}
$$
The support restricts the integral to $t>e^{u+R}>1$, so the lower endpoint contributes no error. Evenness and $d\nu=2\cosh(v/2)\Phi(v)\,dv$ prove $C=\mu-a$.

The entire continuous cross profile is
$$
 T_{\rm c}(u)
 =2\int_{-\infty}^{-R}
   \frac{e^{v/2}\Phi(v)\psi(v)}{1-e^{-2(u-v)}}\,dv
 =a+R_{\rm c}(u),
$$
$$
 0\le R_{\rm c}(u)
 \le\frac{a e^{-2(u+R)}}{1-e^{-4R}}
 \le a\kappa_R,\qquad \kappa_R=(e^{4R}-1)^{-1}.
 \tag{3}
$$
Subtract one from the denominator factor, use $v<-R$, and integrate its positive bound to obtain (3). Reflect every profile evenly to the negative half-line. The actual identity is therefore
$$
 \boxed{\quad T=T_0+R_{\rm c}+\mathcal P,\qquad
 T_0=C e^{|u|}+a,\qquad
 \mathcal P=T_{\rm p}-C e^{|u|}.\quad}
 \tag{4}
$$
The arithmetic error $\mathcal P$ is signed. Every prime power remains in $T_{\rm p}$.

## Exact model normalization and a small continuous error

For $Z=e^{|u|}-1$, the actual mass identities give
$$
 \int e^{|u|}\,d\gamma=C,\qquad
 H=\int Z\,d\gamma=C-a=\mu-2a,\qquad C\ge e^Ra.
$$
In particular the model sign energy is
$$
 E_0=\int T_0\,d\gamma=C^2+a^2.
 \tag{5}
$$
Equation (3) and Cauchy--Schwarz give
$$
 \|R_{\rm c}\|_\gamma\le a^{3/2}\kappa_R,\qquad
 0\le\int R_{\rm c}\,d\gamma\le a^2\kappa_R,\qquad
 \|T_0\|_\gamma\ge E_0/\sqrt a.
$$
Hence the following relative estimates do not require an unknown ground-state mass:
$$
 \boxed{\quad
 \frac{\|R_{\rm c}\|_\gamma}{\|T_0\|_\gamma}
 \le\frac{\kappa_R}{e^{2R}+1},\qquad
 \frac{\int R_{\rm c}\,d\gamma}{E_0}
 \le\frac{\kappa_R}{e^{2R}+1}.
 \quad}
 \tag{6}
$$
At $R=2$, the elementary $e>2$ gives a common upper bound
$$
 \frac{\kappa_2}{e^4+1}<\frac1{255\cdot17}=\frac1{4335}.
 \tag{7}
$$
This is a proved density calibration for the continuous correction. It does not bound the prime discrepancy in (4).

## Joint profile errors for both actual sources

Write
$$
 \epsilon_{\rm p}=\|\mathcal P\|_\gamma,\qquad
 \epsilon=\epsilon_{\rm p}+a^{3/2}\kappa_R.
$$
Then
$$
 |E_s-E_0|\le\sqrt a\,\epsilon,\qquad
 \bigl|\|T\|_\gamma^2-\|T_0\|_\gamma^2\bigr|
 \le2\|T_0\|_\gamma\epsilon+\epsilon^2.
 \tag{8}
$$
If $\sqrt a\,\epsilon<E_0$, this supplies $E_s\ge E_0-\sqrt a\,\epsilon>0$.

Retain both sources from the true score calibration:
$$
 S_q=q/\rho=\varepsilon Z,\qquad
 S_y=\sigma_O/\rho=\varepsilon Y,\qquad Y=\varepsilon\sigma_O/\rho.
$$
The even profiles $Z,Y$ belong to $L^2(\gamma)$. Thus
$$
 |\langle Z,T-T_0\rangle_\gamma|\le\|Z\|_\gamma\epsilon,\qquad
 |\langle Y,T-T_0\rangle_\gamma|\le\|Y\|_\gamma\epsilon.
 \tag{9}
$$
Their actual source means are unchanged. Equations (8)--(9) control the profile moments entering both exact residuals
$$
 e_i=S_i-\frac{\langle S_i,\varepsilon\rangle_\gamma}{E_s}
                 K\varepsilon,\qquad i\in\{y,q\}.
$$
They are inputs to the joint affine comparison in [full cross arrival covariance repair](theta-full-cross-arrival-covariance-repair.md). Neither source is replaced by a homogeneous score-zero variant, and every factor of $\delta=\lambda-\alpha$ in the true score identity remains necessary.

## The current arithmetic bound does not give relative smallness

The known actual estimates imply $\epsilon_{\rm p}<\infty$. If $P_\infty\ge\|\psi\|_\infty$ and $B_{\rm p}$ bounds the full original prime departure rate, then
$$
 0\le T_{\rm p}\le2P_\infty B_{\rm p}/\rho.
$$
With
$$
 Z_0^2=\int_O\frac{\psi}{\rho}\,d\nu,\qquad
 I_2=\int_O e^{2|u|}\,d\gamma,
$$
the resulting explicit bound is
$$
 \boxed{\quad
 \epsilon_{\rm p}\le2P_\infty B_{\rm p}Z_0+C\sqrt{I_2}.
 \quad}
 \tag{10}
$$
Both constants are controlled by the proved barrier and theta tails:
$Z_0^2\le P_\infty\int\rho^{-1}d\nu$ and
$I_2\le P_\infty\int e^{2|u|}\rho\,d\nu$.

This particular bound cannot certify even
$\epsilon_{\rm p}\le\|T_0\|_\gamma/2$. Its second summand alone satisfies
$$
 C\sqrt{I_2}\ge
 \frac{\|T_0\|_\gamma}{1+e^{-2R}}
 >\frac12\|T_0\|_\gamma.
 \tag{11}
$$
Indeed $\|T_0\|_\gamma\le C\sqrt{I_2}+a^{3/2}$, while
$\sqrt{I_2}\ge C/\sqrt a$ and $C\ge e^Ra$ give
$a^{3/2}/(C\sqrt{I_2})\le e^{-2R}$.
This is a limitation of the available upper estimate, not a lower bound on the actual error.

The missing arithmetic input is cancellation in
$$
 \mathcal P(u)=2\left[
 \sum_{n\ge2}\Lambda(n)g_-(u-\log n)
 -\int_1^\infty g_-(u-\log t)\,dt\right]
 \tag{12}
$$
in the norm $\|\cdot\|_\gamma$, or sharper signed moment bounds than (9). Boundedness of $\psi$ gives no small-error partial-summation estimate for this test without a quantified variation or regularity bound on its actual translates. No such additional estimate is supplied here. Thus the small continuous correction (6) does not yet produce a passing full affine score comparison.

## The precision required by this particular score-covariance upper bound

The normalized residual relevant to the true $q$ covariance is not merely $\|T-T_0\|$. Its exact dimensionless value is
$$
 \epsilon_{\rm shape}^2=
 \frac{\displaystyle\int
       \left(Z-\frac H{E_s}T\right)^2d\gamma}
      {\displaystyle\int Z^2d\gamma}.
 \tag{13}
$$
Equivalently it is the expectation of
$\left|1-HT/(E_sZ)\right|^2$ under the probability measure proportional to $Z^2d\gamma$. Here $Z>0$ on the exterior. The complete prime-profile repair gives
$$
 \mathcal C(q,q)\le
 \frac{H^2}{E_s}
 +\frac{2Q(q,q)}{e^R+1}\epsilon_{\rm shape}^2.
 \tag{14}
$$
Since $Q(q,q)\ge(e^R-1)^2$, a necessary condition for the right side of (14) to certify $\mathcal C(q,q)\le c_*$ is
$$
 \epsilon_{\rm shape}^2\le
 \frac{c_*(e^R+1)}{2(e^R-1)^2}.
 \tag{15}
$$
For fixed $c_*$, this demands $O(e^{-R})$ relative squared profile error. At $R=2$, the coefficient $2(e^2-1)^2/(e^2+1)$ is greater than $8$. For instance $e>8/3$ gives $e^2>7$, and the coefficient is increasing for $e^2>1$. Thus $\epsilon_{\rm shape}^2\ge1/4$ already prevents (14) from certifying $\mathcal C(q,q)\le2$.

This is a necessary precision condition for this upper bound, not a necessary condition for the true covariance inequality. The joint affine score test still retains the $y$ residual and all $\delta$-dependent cross terms.

## Attribution and formal scope

The closed-form variational inverse, nonnegative-form Cauchy–Schwarz, finite-rank inverse identities and affine completion of squares used here are classical. The actual theta ground state, full continuous kernel, every prime power and stated fixed-core domains remain part of the theorem. These are written proofs; no Lean formalization of this profile comparison or evaluation of the required arithmetic smallness is asserted.
