# A positive rank bound retaining the full cross-arrival profile

The exact sign profile contains more usable information than its energy and a residual norm. Positivity of the remaining full clock form retains an additional rank-one form. Its explicit inverse damps the residual component correlated with that profile. In the prime-density reference profile this suffices to put the odd pole covariance strictly below two, without a bound on the spread of the ground history. Applying the result to the actual prime profile still requires a quantitative arithmetic estimate.

All statements here are written analysis. The complete continuous kernel and all prime powers remain in the actual clock.

## The actual clock and a positive rank lower bound

Fix a core radius $R>0$. Use the normalized even exterior ground state, the finite measure $d\gamma=\rho\psi\,d\nu$, and
$$
 a=\gamma(O),\qquad \varepsilon=\operatorname{sgn},\qquad
 \kappa=\frac{a(e^R+1)}2.
$$
The complete covariance-clock theorem and the full-cross-arrival theorem give
$$
 K=a+A_{\rm rem},\qquad
 K\ge K_0:=aI+(\kappa-a)(I-P_{1,\varepsilon}),
 \qquad K\varepsilon=\varepsilon T,
\tag{1}
$$
where $\varepsilon\in D(K)$, $T$ is the actual even full cross-arrival profile, and $P_{1,\varepsilon}$ is the orthogonal projection onto functions constant on each exterior half. The operator $K_0$ is bounded and strictly positive on all of $L^2(\gamma)$. The comparison in (1) is a comparison of closed forms. The norm of $\varepsilon$ is $\sqrt a$, not one.

Set
$$
 E_s=\int T\,d\gamma,\qquad
 d=E_s-a^2,\qquad w=\varepsilon(T-a).
\tag{2}
$$
Here $d>0$. Indeed $E_s=4(C_R+P_R)$, while
$C_R=\sum_{j\ge0}G(2j+1/2)^2>a^2/4$. The strict inequality uses the positive higher continuous terms and the nonzero positive ground history; each prime contribution is nonnegative.

Subtract the bounded form of $K_0$ from the form of $K$. This produces a nonnegative closed form with associated operator $A=K-K_0$ on $D(K)$. Since $\varepsilon\in D(K)$,
$$
 A\varepsilon=w,\qquad
 \langle A\varepsilon,\varepsilon\rangle=d.
$$
Cauchy--Schwarz for this nonnegative form gives, for every form-domain $F$,
$$
 |\langle F,w\rangle_\gamma|^2
 \le d\,\langle AF,F\rangle_\gamma.
$$
Consequently
$$
 \boxed{\quad K\ge K_*:=K_0+\frac{w\otimes w}{d},
 \qquad K_*\varepsilon=K\varepsilon.\quad}
\tag{3}
$$
The tensor convention is $(w\otimes w)F=\langle F,w\rangle w$, with inner products linear in the first argument. The right side is a bounded, strictly positive operator on the entire Hilbert space. Variational inversion, including enlargement from the form domain of $K$ to that of $K_*$, gives
$$
 K^{-1}\le K_*^{-1}.
\tag{4}
$$
This uses the actual full profile in $w$. Replacing its prime terms by a density is not part of (3) or (4).

## Explicit covariance and the correlated residual

Let
$$
 z=\varepsilon\left(T-\frac{E_s}{a}\right),\qquad
 V=\|z\|_\gamma^2.
\tag{5}
$$
Then $z\perp1,\varepsilon$, and $w=(d/a)\varepsilon+z$. All these vectors are in $L^2(\gamma)$ by the proved bounded-ground-state and cross-arrival estimates. Direct inversion of (3) yields
$$
 K_*^{-1}=K_0^{-1}
 -\frac{(K_0^{-1}w)\otimes(K_0^{-1}w)}
 {d+\langle K_0^{-1}w,w\rangle},
\tag{6}
$$
where
$$
 K_0^{-1}w=\frac{d}{a^2}\varepsilon+\frac z\kappa,
 \qquad
 d+\langle K_0^{-1}w,w\rangle
 =\frac{E_sd}{a^2}+\frac V\kappa.
\tag{7}
$$
These formulas can also be checked by multiplying the bounded operators in (3) and (6).

For a centered weighted source $S=f/\rho$, put
$$
 H_f=\langle S,\varepsilon\rangle_\gamma,
 \qquad e_f=S-\frac{H_f}{E_s}K\varepsilon.
\tag{8}
$$
Then $e_f\perp1,\varepsilon$. Using $K_*^{-1}K\varepsilon=\varepsilon$, followed by (6), proves
$$
 \boxed{\begin{split}
 \mathcal C(f,f)\le U_*(f,f)
 &:={\langle K_*^{-1}S,S\rangle}_\gamma\\
 &=\frac{|H_f|^2}{E_s}+\frac{\|e_f\|_\gamma^2}{\kappa}
 -\frac{|\langle e_f,z\rangle_\gamma|^2}
 {\kappa\left(V+\kappa E_sd/a^2\right)}.
 \end{split}}
\tag{9}
$$
Thus (9) subtracts a nonnegative quantity from the earlier full-profile residual bound. If $V>0$, decompose $e_f=e_{\perp}+e_{\parallel}$ by projection onto $z$. The residual part of (9) is exactly
$$
 \boxed{\quad
 \frac{\|e_{\perp}\|_\gamma^2}{\kappa}
 +\frac{\|e_{\parallel}\|_\gamma^2}
 {\kappa+a^2V/(E_sd)}.
 \quad}
\tag{10}
$$
For $V=0$, the subtraction in (9) is zero and that formula remains valid. No invariant-subspace assertion for the actual $K$ is used.

Equations (8)--(9) hold jointly on every finite collection of centered weighted sources. Polarization gives their positive-form covariance upper bound. In particular, let $y=\sigma_O$, $q=\tau_O$, $\delta=1/2-\alpha$, and $S_\sigma=\|\sigma\|_\nu^2$. Both sources are admissible. Applying the joint upper bound before the true affine minimization gives
$$
 \boxed{\quad
 F_\alpha[\sigma_C]\ge
 \delta S_\sigma-\frac18
 -\delta^2U_*(y,y)
 +\frac{|1/2+\delta U_*(y,q)|^2}{U_*(q,q)}.
 \quad}
\tag{11}
$$
The denominator is positive. Both scaled score covariances remain. A bound on $U_*(q,q)$ alone does not establish the sign of (11).

## The pole source and its weighted profile correlation

For $q=\tau_O$, write
$$
 Z=e^{|u|}-1,\qquad S_q=\varepsilon Z,\qquad
 H=\int Z\,d\gamma,
$$
$$
 B=\int\left(Z-\frac Ha\right)^2d\gamma>0,
 \qquad
 J=\int\left(Z-\frac Ha\right)
             \left(T-\frac{E_s}{a}\right)d\gamma.
\tag{12}
$$
If $V>0$, the weighted correlation is $r_\gamma=J/\sqrt{BV}$. Since
$e_q=\varepsilon(Z-H/a)-(H/E_s)z$, its component orthogonal to $z$ has squared norm $B-J^2/V$. Hence
$$
 \boxed{\quad
 U_*(q,q)=\frac{H^2}{E_s}
 +\frac{B(1-r_\gamma^2)}\kappa
 +\frac{(J-HV/E_s)^2}
 {V\left(\kappa+a^2V/(E_sd)\right)}.
 \quad}
\tag{13}
$$
The profile error transverse to the centered $T$ direction still pays the same-half denominator. Error in that direction receives the larger denominator. Thus the earlier requirement that the whole relative profile error be of squared size $O(e^{-R})$ applies only to the earlier, weaker norm bound. It is not a necessary condition for (13).

## An exact density-reference calibration without a spread bound

This paragraph makes a stated density substitution for calibration. It does not replace any prime in the actual theorem above. Keep $\gamma$, $a$, and $H$ fixed, and let
$$
 c=2G(-1/2)=H+a,\qquad b=c+a=H+2a.
$$
The complete prime density plus the leading continuous cross term gives
$$
 T_0=c e^{|u|}+a=cZ+b,
 \qquad E_0=\int T_0\,d\gamma=c^2+a^2,
 \qquad d_0=E_0-a^2=c^2.
\tag{14}
$$
The higher continuous terms and actual prime discrepancy are excluded only from this reference profile. Their exact expressions are retained in [cross arrival density calibration](theta-cross-arrival-density-calibration.md).

Define the positive reference operator by the same explicit construction,
$$
 K_{*,0}=K_0+\frac{w_0\otimes w_0}{d_0},
 \qquad w_0=\varepsilon(T_0-a)=c\varepsilon e^{|u|}.
$$
No comparison between $K$ and $K_{*,0}$ is asserted. The centered reference profile is
$z_0=c\varepsilon(Z-H/a)$. Therefore $V_0=c^2B$, $J_0=cB$, and the transverse term in (13) is exactly zero. Direct substitution gives
$$
 \begin{split}
 U_0(q,q)&:=\langle K_{*,0}^{-1}S_q,S_q\rangle_\gamma\\
 &=\frac{H^2}{E_0}
 +\frac{b^2a^2B}{E_0(\kappa E_0+a^2B)}\\
 &=\boxed{\quad
 2-\frac{b^2\kappa}{\kappa E_0+a^2B}<2.
 \quad}
 \end{split}
\tag{15}
$$
The last identity uses $H=c-a$, $b=c+a$, and $H^2+b^2=2E_0$. All quantities are finite, and the displayed subtraction is strictly positive. No upper bound on $B$, and therefore no concentration assumption on the ground history, was used to prove the strict inequality. If $B$ is large the margin below two may be small.

Equation (15) identifies a cancellation lost by the earlier residual-norm bound. To transfer it to the actual primes, one must control the transverse arithmetic error and the retained parallel term in (13), or directly compare the explicit rank inverses. Neither such a passing actual estimate nor the full two-source sign in (11) is established here. The Riemann hypothesis remains unproved.

## Exact gain after the full affine optimization

The positive rank subtraction improves the full affine comparison by an exact quantity evaluated at the previous affine optimizer. Define the earlier full-profile upper covariance
$$
 \overline U(f,g)=
 \frac{H_f\overline{H_g}}{E_s}
       +\frac{\langle e_f,e_g\rangle_\gamma}{\kappa},
 \qquad
 j(f)=\langle e_f,z\rangle_\gamma,\qquad
 D_n=\kappa\left(V+\kappa E_sd/a^2\right)>0.
$$
The maps $f\mapsto e_f$ and $j$ are linear. Equation (9), polarized before any optimization, states
$$
 U_*(f,g)=\overline U(f,g)
          -\frac{j(f)\overline{j(g)}}{D_n}.
 \tag{AG1}
$$
For the fixed nonzero odd column $q$, put
$$
 C=\overline U(q,q),\qquad
 C_*=U_*(q,q)=C-\frac{|j(q)|^2}{D_n}>0.
$$
Strict positivity follows because $K_*^{-1}$ is strictly positive and $q/\rho\ne0$. No denominator is replaced by a lower estimate during the following identity.

For any centered weighted source $f$ and affine scalar $m$, let
$$
 \overline t=\frac{\overline U(f,q)+m}{C},\qquad
 j_0=j(f-\overline t q).
$$
With the linear-first convention, the affine cost of a positive covariance form $U$ is
$$
 \operatorname{Cost}_U(f,m)
 =\inf_t\left\{U(f-tq,f-tq)-2\operatorname{Re}(t\overline m)\right\}.
$$
Write $t=\overline t+s$. Exact completion of the old affine square followed by (AG1) gives
$$
 \begin{split}
 &U_*(f-tq,f-tq)-2\operatorname{Re}(t\overline m)\\
 &\quad=\operatorname{Cost}_{\overline U}(f,m)
       +C|s|^2-\frac{|j_0-sj(q)|^2}{D_n}\\
 &\quad=\operatorname{Cost}_{\overline U}(f,m)
       -\frac{|j_0|^2}{D_n}
       +C_*|s|^2+
       \frac{2\operatorname{Re}(\overline s\,j_0\overline{j(q)})}{D_n}.
 \end{split}
$$
Thus the new optimizer and the exact cost reduction are
$$
 \boxed{\quad
 t_*=\overline t-
       \frac{j_0\overline{j(q)}}{D_nC_*},\qquad
 \operatorname{Cost}_{\overline U}(f,m)
       -\operatorname{Cost}_{U_*}(f,m)
 =\frac{C\,|j(f-\overline t q)|^2}{D_nC_*}\ge0.
 \quad}
 \tag{AG2}
$$
The factor $C/C_*$ includes the change of affine optimizer. Merely subtracting the rank term at a fixed source would miss this factor.

In the true odd-score calibration take
$$
 f=\delta y,\qquad m=\tfrac12,\qquad
 \mathcal B=\delta\|\sigma\|_\nu^2-\tfrac18.
$$
Define the two sufficient lower expressions
$$
 F_{\rm bar}=\mathcal B-\operatorname{Cost}_{\overline U}(\delta y,1/2),
 \qquad
 F_*=\mathcal B-\operatorname{Cost}_{U_*}(\delta y,1/2).
$$
Then
$$
 \boxed{\quad
 F_\alpha[\sigma_C]\ge F_*,\qquad
 F_*-F_{\rm bar}
 =\frac{\overline U(q,q)}
        {D_nU_*(q,q)}
 \left|
 \delta j(y)-
 \frac{\delta\overline U(y,q)+1/2}{\overline U(q,q)}j(q)
 \right|^2.
 \quad}
 \tag{AG3}
$$
Every scaled score term and the scalar $1/2$ are retained. The gain is strictly positive exactly when the displayed profile pairing is nonzero. Even when the individual pole covariance improves, that pairing may vanish after affine optimization. Conversely, a positive gain in (AG3) does not by itself prove that the new lower expression is nonnegative. It quantifies the additional actual profile correlation available to pay a negative $F_{\rm bar}$.

## A finite-margin perturbation test retaining its signed mixed term

The reference margin in (15) can be transferred by a finite-dimensional calculation involving the actual full profile. No pointwise estimate or relative-RMS assumption is needed to state this test. Let
$$
 S_0=\varepsilon(Z-H/a),\qquad
 v=w/\sqrt d,\qquad v_0=w_0/c=S_q+\varepsilon,
$$
and define the comparison metric
$\langle F,G\rangle_{0^{-1}}=\langle K_0^{-1}F,G\rangle_\gamma$.
For any rank vector $v$, the exact variational formula is
$$
 \langle(K_0+v\otimes v)^{-1}S_q,S_q\rangle
 =\min_{t\in\mathbb R}
       \bigl[\|S_q-tv\|_{0^{-1}}^2+t^2\bigr].
\tag{16}
$$
All vectors here are real; the complex version uses $|t|^2$. Completing the one scalar square proves (16).

The reference optimizer, its value, and its margin below two are
$$
 t_0=\frac{\kappa Hc+a^2B}{\kappa E_0+a^2B}\in(0,1),
 \qquad U_0=2-m_0,\qquad
 m_0=\frac{b^2\kappa}{\kappa E_0+a^2B}>0.
\tag{17}
$$
For example, the denominator minus the numerator in $t_0$ is $\kappa ab>0$. Also
$\|S_q-t_0v_0\|_{0^{-1}}^2=U_0-t_0^2\ge0$.

Set
$$
 \mathcal D^2=\|v-v_0\|_{0^{-1}}^2,
 \qquad
 \mathcal M=\langle S_q-t_0v_0,v-v_0\rangle_{0^{-1}}.
$$
The orthogonal sign and centered components give the exact scalar expressions
$$
 \boxed{\quad
 \mathcal D^2=
 \frac{(\sqrt d-c)^2}{a^2}
 +\frac1\kappa\left\|\frac z{\sqrt d}-S_0\right\|_\gamma^2,
 \quad}
\tag{18}
$$
$$
 \boxed{\quad
 \mathcal M=
 \frac{(H-t_0c)(\sqrt d-c)}{a^2}
 +\frac{1-t_0}{\kappa}
       \left(\frac J{\sqrt d}-B\right).
 \quad}
\tag{19}
$$
Here $J$ is the actual centered $Z,T$ covariance in (12). Thus the full prime profile enters both its size and its signed covariance with the density-reference residual.

Evaluate the actual variational problem (16) at the fixed reference coefficient $t_0$, before optimizing it. Expansion proves
$$
 \boxed{\quad
 U_*(q,q)\le U_0-2t_0\mathcal M+t_0^2\mathcal D^2.
 \quad}
\tag{20}
$$
A positive $\mathcal M$ improves this bound. It must not automatically be treated as an error of unfavorable sign. In particular the concrete sufficient test
$$
 \boxed{\quad t_0^2\mathcal D^2-2t_0\mathcal M\le m_0\quad}
\tag{21}
$$
proves $U_*(q,q)\le2$.

If only an unsigned profile estimate is available, Cauchy–Schwarz in the comparison metric gives the weaker, still sufficient condition
$$
 2t_0\sqrt{U_0-t_0^2}\,\mathcal D
       +t_0^2\mathcal D^2\le m_0.
\tag{22}
$$
Equivalently, it suffices that
$$
 \mathcal D\le
 \frac{\sqrt{2-t_0^2}-\sqrt{U_0-t_0^2}}{t_0}.
\tag{23}
$$
The right side is strictly positive. When $B$ is large, the reference margin can be small; (21)–(23) record that loss explicitly instead of assuming a bounded pole spread.

For completeness, there is a complementary test calibrated directly to the actual sign mean. Write $T=T_0+r$,
$\Delta=\int r\,d\gamma=E_s-E_0$, so $d=c^2+\Delta$. Taking $t=c/\sqrt d$ in (16) gives
$$
 U_*(q,q)\le1+\frac{c^2}{d}
 +\frac{\|\Delta S_0-c\varepsilon(r-\Delta/a)\|_\gamma^2}
              {\kappa d^2}.
\tag{24}
$$
This bound permits a large centered spread when the profile error follows the corresponding affine change. It generally loses the strict reference margin recovered by (20). Neither test has been verified for the actual prime profile here. They are sufficient arithmetic correlation conditions, with all profile terms retained, and a bound on this single pole covariance still does not settle the full two-source inequality (11).

## Attribution and formal scope

The closed-form variational inverse, nonnegative-form Cauchy–Schwarz, finite-rank inverse identities and affine completion of squares used here are classical. The actual theta ground state, full continuous kernel, every prime power and stated fixed-core domains remain part of the theorem. These are written proofs; no Lean formalization of this profile comparison or evaluation of the required arithmetic smallness is asserted.
