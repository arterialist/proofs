# Separate positive profile bounds for the continuous and prime components

The positive rank construction in [cross profile positive rank repair](theta-cross-profile-positive-rank-repair.md) can be applied separately to the remaining continuous form and the entire prime form. Keeping the two ranks gives a stronger comparison than merging their sign profiles. Keeping just the prime rank also isolates an arithmetic perturbation whose scalar mean is exactly the prime-quadrature remainder, without adding the known continuous correction to that error.

Use the actual fixed-core notation
$$
 K=a+A_{\rm rem}\ge K_0
 =aI+(\kappa-a)(I-P_{1,\varepsilon}),\quad
 \kappa=a(e^R+1)/2,
$$
$$
 K\varepsilon=\varepsilon(T_{\rm c}+T_{\rm p}),
 \qquad E_{\rm c}=\int T_{\rm c}\,d\gamma=4C_R,
 \qquad p=\int T_{\rm p}\,d\gamma=4P_R.
\tag{1}
$$
The profiles contain the complete continuous cross kernel and every prime-power cross arrival. The same-half edges are also retained in the actual forms below.

## Separate components and a strictly stronger retained rank sum

The exact nonnegative form decomposition is
$$
 K-K_0=A_{\rm c}+A_{\rm p}.
\tag{2}
$$
Here $A_{\rm p}$ is the complete prime ground form on $L^2(\gamma)$. The continuous form $A_{\rm c}$ subtracts the original rank minorant and the uniform same-half continuous minorant already present in $K_0$. The remaining conductance is nonnegative. Both are their maximal closed forms. The full form domain lies in their intersection.

The separated cross-rate and bounded-ground-state estimates place $\varepsilon$ in both operator domains. The form calculation for its action gives
$$
 w_{\rm c}:=A_{\rm c}\varepsilon
   =\varepsilon(T_{\rm c}-a),\qquad
 w_{\rm p}:=A_{\rm p}\varepsilon
   =\varepsilon T_{\rm p},
$$
$$
 d_{\rm c}:=\langle w_{\rm c},\varepsilon\rangle
      =E_{\rm c}-a^2>0,\qquad
 \langle w_{\rm p},\varepsilon\rangle=p>0.
\tag{3}
$$
The same-half subtractions act as zero on $\varepsilon$. Subtraction of the rank minorant contributes $a\varepsilon$ because $\varepsilon$ is centered. Strict $d_{\rm c}>0$ follows from the positive higher continuous cross terms. Strict $p>0$ follows by selecting any prime power $n>e^{2R}$: its cross interval is nonempty, and the actual ground state is positive almost everywhere on both halves. Every prime profile lies in $L^2(\gamma)$ by the existing bounded departure and theta-tail estimates.

Apply nonnegative-form Cauchy--Schwarz to each component. This proves
$$
 \boxed{\quad
 K\ge K_{\rm cp}:=K_0+
       \frac{w_{\rm c}\otimes w_{\rm c}}{d_{\rm c}}
       +\frac{w_{\rm p}\otimes w_{\rm p}}p.
 \quad}
\tag{4}
$$
All comparison operators on the right are bounded and strictly positive. If $d=d_{\rm c}+p=E_s-a^2$ and $w=w_{\rm c}+w_{\rm p}$, the exact tensor identity is
$$
 \boxed{\quad
 \frac{w_{\rm c}\otimes w_{\rm c}}{d_{\rm c}}
 +\frac{w_{\rm p}\otimes w_{\rm p}}p
 -\frac{w\otimes w}{d}
 =\frac{d_{\rm c}p}{d}
 \left(\frac{w_{\rm c}}{d_{\rm c}}-
       \frac{w_{\rm p}}p\right)
 \otimes
 \left(\frac{w_{\rm c}}{d_{\rm c}}-
       \frac{w_{\rm p}}p\right)\ge0.
 \quad}
\tag{5}
$$
Thus $K_{\rm cp}\ge K_*$ from the combined-profile source. The extra rank vanishes exactly when the two normalized profiles coincide. Its nonzero value is an operator improvement; it does not imply a strictly improved value on every source.

For completeness its inverse needs only a two-by-two matrix. Let $V:\mathbb C^2\to L^2(\gamma)$ have columns
$w_{\rm c}/\sqrt{d_{\rm c}}$ and $w_{\rm p}/\sqrt p$. Then
$$
 K_{\rm cp}^{-1}=K_0^{-1}
 -K_0^{-1}V(I_2+V^*K_0^{-1}V)^{-1}V^*K_0^{-1}.
\tag{6}
$$
The middle matrix is positive definite. Multiplication verifies this identity; variational inversion of (4) shows it is a joint upper bound for the exact covariance on every centered weighted source. It can therefore be used before the full affine minimization, retaining both exterior score and pole sources.

## A prime-only bound whose reference needs no continuous-error estimate

Dropping the nonnegative continuous rank in (4) gives another valid comparison,
$$
 K\ge K_{{\rm p},*}:=K_0+v_{\rm p}\otimes v_{\rm p},
 \qquad v_{\rm p}=w_{\rm p}/\sqrt p.
\tag{7}
$$
This prime-profile comparison and the combined-profile comparison need not be ordered. Equation (4) dominates both. All actual continuous edges remain in $K$, and its known same-half budget remains in $K_0$.

Set
$$
 Z=e^{|u|}-1,\quad S_q=\varepsilon Z,\quad
 H=\int Z\,d\gamma,\quad c=2G(-1/2)=H+a,
$$
$$
 S_0=\varepsilon(Z-H/a),\qquad B=\|S_0\|_\gamma^2.
$$
The prime-density profile alone is $T_{{\rm p},0}=c e^{|u|}$, with total $p_0=c^2$. Therefore its normalized rank vector is precisely
$$
 v_0=\varepsilon e^{|u|}=S_q+\varepsilon.
\tag{8}
$$
The reference operator $K_0+v_0\otimes v_0$ is the same reference used in the positive-rank source. In particular, with
$$
 E_0=c^2+a^2,\quad b=c+a,\quad
 t_0=\frac{\kappa Hc+a^2B}{\kappa E_0+a^2B},\quad
 m_0=\frac{b^2\kappa}{\kappa E_0+a^2B},
$$
its pole covariance is exactly $U_0=2-m_0<2$. This calibration makes no density substitution for any continuous part.

Define the centered actual prime profile and comparison-metric error by
$$
 z_{\rm p}=\varepsilon(T_{\rm p}-p/a),\qquad
 \mathcal D_{\rm p}^2
 =\langle K_0^{-1}(v_{\rm p}-v_0),v_{\rm p}-v_0\rangle,
$$
$$
 \mathcal M_{\rm p}
 =\langle K_0^{-1}(S_q-t_0v_0),v_{\rm p}-v_0\rangle.
$$
The exact decomposition into its sign and centered parts gives
$$
 \mathcal D_{\rm p}^2
 =\frac{(\sqrt p-c)^2}{a^2}
  +\frac1\kappa\left\|\frac{z_{\rm p}}{\sqrt p}-S_0\right\|_\gamma^2.
\tag{9}
$$
Evaluating the one-scalar variational inverse at $t_0$ proves the actual upper bound
$$
 \boxed{\quad
 \mathcal C(q,q)\le
 \langle K_{{\rm p},*}^{-1}S_q,S_q\rangle
 \le 2-m_0-2t_0\mathcal M_{\rm p}
                  +t_0^2\mathcal D_{\rm p}^2.
 \quad}
\tag{10}
$$
Thus $t_0^2\mathcal D_{\rm p}^2-2t_0\mathcal M_{\rm p}\le m_0$ is a sufficient actual arithmetic criterion for $\mathcal C(q,q)\le2$. The signed mixed term is retained.

Its scalar mass error is exactly the ground prime-quadrature error:
$$
 \boxed{\quad
 p-c^2=4\left(P_R-G(-1/2)^2\right)=4\mathcal R_g.
 \quad}
\tag{11}
$$
The full profile error in (9) remains the actual sum-minus-density function $T_{\rm p}-c e^{|u|}$; it cannot be replaced by (11) alone. Equations (9)--(11) avoid charging the known positive continuous correction to the arithmetic error. They do not supply a passing bound on that arithmetic error. Nor would this one pole-covariance conclusion alone establish the full affine score inequality or the Riemann hypothesis.

## A positive continuous margin independent of the pole spread

The already proved continuous-remainder gap can also be retained with the prime rank. This gives a density-reference margin independent of $B$ and a sufficient inequality in which a positive arithmetic mean error helps pay the profile error.

In this paragraph use $A_{\rm c}^{\rm rem}$ for the continuous form after subtracting only the original rank minorant, before subtracting the same-half term in (2). The continuous-gap source proves, on $1^\perp\subset L^2(\gamma)$, both
$$
 A_{\rm c}^{\rm rem}\ge\eta I,\qquad
 A_{\rm c}^{\rm rem}\ge hA(I-P_{1,\varepsilon}),
 \quad h=e^R-1,\quad A=a/2,
$$
where $\eta>0$ can be the explicitly proved lower constant
$$
 \eta_0=\frac{2h\beta b_I^2}{hA+2\beta b_I},\qquad
 b_I=\gamma((R,R+\ell)),\qquad
 \beta=(e^{4(R+\ell)}-1)^{-1}.
$$
Fix $0<\theta\le1$. A convex combination of these two valid form bounds gives
$$
 K\ge B_\theta+\frac{w_{\rm p}\otimes w_{\rm p}}p,
 \qquad
 B_\theta=s_\theta I+(1-\theta)hA(I-P_{1,\varepsilon}),
$$
$$
 s_\theta=a+\theta\eta,\qquad
 k_\theta=s_\theta+(1-\theta)hA.
\tag{CM1}
$$
These comparisons and inverses are restricted to the centered space. Its sign direction has inverse denominator $s_\theta$, while the orthogonal remainder has denominator $k_\theta$. No continuous edge is counted twice: the convex combination uses fractions $\theta$ and $1-\theta$ of the same continuous form.

The exact rank variational formula is
$$
 \left\langle
  \left(B_\theta+\frac{w_{\rm p}\otimes w_{\rm p}}p\right)^{-1}
     S_q,S_q\right\rangle
 =\min_{t\in\mathbb R}
 \left[\|S_q-tw_{\rm p}\|_{B_\theta^{-1}}^2+pt^2\right].
\tag{CM2}
$$
Choose the actual mean-calibrated coefficient $t=c/p$. Since
$S_q=(H/a)\varepsilon+S_0$ and
$w_{\rm p}=(p/a)\varepsilon+z_{\rm p}$, the remaining sign component is exactly $-\varepsilon$. Equations (CM1)--(CM2) prove the actual bound
$$
 \boxed{\quad
 \mathcal C(q,q)\le
 \frac{c^2}p+\frac a{s_\theta}
 +\frac1{k_\theta}
       \left\|S_0-\frac c pz_{\rm p}\right\|_\gamma^2.
 \quad}
\tag{CM3}
$$
In the prime-density reference $T_{\rm p}=c e^{|u|}$, one has $p=c^2$ and $z_{\rm p}=cS_0$. The reference inverse therefore satisfies
$$
 \boxed{\quad U_{\theta,0}(q,q)
 \le1+\frac a{a+\theta\eta}
 =2-\frac{\theta\eta}{a+\theta\eta}<2.
 \quad}
\tag{CM4}
$$
This positive margin is independent of $B$. It depends on the actual fixed-core bridge mass through $\eta$; no lower bound uniform over varying cores is claimed. For example, with $\vartheta=b_I/A$, the stated explicit gap gives
$\eta_0/a=h\beta\vartheta^2/(h+2\beta\vartheta)>0$.

For the actual arithmetic error put
$$
 r_{\rm p}=T_{\rm p}-c e^{|u|},\qquad
 \Delta=p-c^2=4\mathcal R_g,\qquad
 r_0=\varepsilon(r_{\rm p}-\Delta/a).
$$
Then $z_{\rm p}=cS_0+r_0$, and
$S_0-(c/p)z_{\rm p}=(\Delta S_0-cr_0)/p$. Consequently the following explicit arithmetic comparison is sufficient for the actual pole covariance to be at most two:
$$
 \boxed{\quad
 \frac{\|\Delta S_0-cr_0\|_\gamma^2}{k_\theta p^2}
 \le \frac{\Delta}p+
       \frac{\theta\eta}{a+\theta\eta}
 \quad\Longrightarrow\quad \mathcal C(q,q)\le2.
 \quad}
\tag{CM5}
$$
The sign of $\Delta$ is retained. A positive excess in the actual prime convolution contributes to the available margin. The profile defect on the left removes the affine change associated with that excess. Positivity of the primitive of a transformed arithmetic source does not establish (CM5); the actual ground-weighted profile is required.

The right side of (CM1) supplies a joint covariance upper form for $y,q$, so it also has the same full affine consumer as (6). Inequality (CM5) has not been verified for the actual ground state at a specified core. Even if it were, the scaled exterior score and mixed covariance terms in the full affine problem would still have to be controlled.

The existing estimates do not yet verify even the scalar prerequisite for this particular trial. Since the left side of (CM5) is nonnegative, write
$m_\theta=\theta\eta/(a+\theta\eta)$. A necessary condition for (CM5) is
$$
 \frac{\Delta}{p}\ge-m_\theta,
 \qquad\text{equivalently}\qquad
 \frac{P_R}{G(-1/2)^2}\ge\frac1{1+m_\theta}.
\tag{CM6}
$$
With the displayed choice $\eta=\eta_0$, its formula gives
$\eta_0/a\le\beta$, hence
$$
 m_\theta\le\frac\beta{1+\beta}=e^{-4(R+\ell)}.
\tag{CM7}
$$
Thus a negative relative prime-quadrature error must have magnitude at most
$e^{-4(R+\ell)}/(1+e^{-4(R+\ell)})$, even before paying the profile defect. Positivity of $P_R$ only gives $\mathcal R_g/G(-1/2)^2>-1$; the actual negative ground-energy identity does not improve it to (CM6) using the presently established bounds. Equations (CM6)--(CM7) describe the precision needed by this explicit continuous-gap trial, not a necessary condition for the exact covariance or for the stronger two-rank comparison (4).

## Exact additional affine gain from keeping both component ranks

The gain from the two separate ranks can be evaluated after the complete affine optimization. Define
$$
 r_*=\sqrt{\frac{d_{\rm c}p}{d}}
       \left(\frac{w_{\rm c}}{d_{\rm c}}-\frac{w_{\rm p}}p\right),
 \qquad K_{\rm cp}=K_*+r_*\otimes r_*.
 \tag{CG1}
$$
The vector is orthogonal to both $1$ and $\varepsilon$. Orthogonality to $1$ follows by parity, and orthogonality to $\varepsilon$ follows from
$\langle w_{\rm c},\varepsilon\rangle=d_{\rm c}$ and
$\langle w_{\rm p},\varepsilon\rangle=p$.
In particular the extra rank preserves
$K_{\rm cp}\varepsilon=K_*\varepsilon=K\varepsilon$.

Put
$$
 D_* =1+\langle K_*^{-1}r_*,r_*\rangle_\gamma>0,\qquad
 \ell(f)=\langle K_*^{-1}(f/\rho),r_*\rangle_\gamma.
 \tag{CG2}
$$
These are bounded expressions on every actual weighted source. Sherman--Morrison, applied to the bounded positive operator $K_*$, gives the joint covariance identity
$$
 U_{\rm cp}(f,g):=
 \langle K_{\rm cp}^{-1}(f/\rho),g/\rho\rangle_\gamma
 =U_*(f,g)-\frac{\ell(f)\overline{\ell(g)}}{D_*}.
 \tag{CG3}
$$
Since $K_*^{-1}K\varepsilon=\varepsilon$ and $r_*\perp\varepsilon$, the functional can equivalently be written
$\ell(f)=\langle K_*^{-1}e_f,r_*\rangle_\gamma$.
Thus the additional observation acts on the full profile residual while preserving the exact sign channel.

For a source $f$ and affine scalar $m$, let
$$
 C_*=U_*(q,q)>0,\quad C_{\rm cp}=U_{\rm cp}(q,q)>0,\qquad
 t_*=\frac{U_*(f,q)+m}{C_*}.
$$
The optimized affine costs satisfy
$$
 \boxed{\quad
 \operatorname{Cost}_{U_*}(f,m)
 -\operatorname{Cost}_{U_{\rm cp}}(f,m)
 =\frac{C_*\,|\ell(f-t_*q)|^2}{D_*C_{\rm cp}}\ge0.
 \quad}
 \tag{CG4}
$$
Indeed put $t=t_*+s$ in the affine variational expression. The old part is its minimum plus $C_*|s|^2$, and (CG3) subtracts
$|\ell(f-t_*q)-s\ell(q)|^2/D_*$.
Completing this scalar square gives (CG4) and the exact new optimizer
$$
 t_{\rm cp}=t_*-
 \frac{\ell(f-t_*q)\overline{\ell(q)}}{D_*C_{\rm cp}}.
 \tag{CG5}
$$
This is the same affine rank-update identity proved in [cross profile positive rank repair](theta-cross-profile-positive-rank-repair.md), now applied to the separation of the actual continuous and prime components.

For the true odd-score input take $f=\delta y$, $m=1/2$, with
$y=\sigma_O$, $\delta=1/2-\alpha$. Define
$$
 F_*=\delta\|\sigma\|^2-\tfrac18-
                  \operatorname{Cost}_{U_*}(\delta y,1/2),
 \qquad
 F_{\rm cp}=\delta\|\sigma\|^2-\tfrac18-
                  \operatorname{Cost}_{U_{\rm cp}}(\delta y,1/2).
$$
Then the complete source obeys
$$
 \boxed{\quad
 F_\alpha[\sigma_C]\ge F_{\rm cp}\ge F_*,
 \qquad
 F_{\rm cp}-F_*=
 \frac{U_*(q,q)}{D_*U_{\rm cp}(q,q)}
 \left|
 \delta\ell(y)-
 \frac{\delta U_*(y,q)+1/2}{U_*(q,q)}\ell(q)
 \right|^2.
 \quad}
 \tag{CG6}
$$
The mixed score and the affine scalar are retained. Nonzero component separation does not force a positive value of (CG6) on every source; it is the displayed residual pairing that determines strict gain. No bound showing that this additional gain pays a negative $F_*$ is supplied here.

## Attribution and formal scope

The closed-form variational inverse, nonnegative-form Cauchy–Schwarz, finite-rank inverse identities and affine completion of squares used here are classical. The actual theta ground state, full continuous kernel, every prime power and stated fixed-core domains remain part of the theorem. These are written proofs; no Lean formalization of this profile comparison or evaluation of the required arithmetic smallness is asserted.

The [score-action match](theta-ground-score-action-covariance-repair.md) adds the actual score quotient while preserving the sign action. The [full-form theorem](theta-prime-profile-full-form-domain.md) establishes the domain of the resulting affine trial, so the [complete conditional edge estimator](theta-affine-comparison-conditional-edge-energy.md) applies to the actual source. Its numerical or arithmetic smallness is not proved.
