# The coherent-core kernel detects offcritical poles in the actual weak ground row

The actual exponential weak-ground identity can be tested with the coherent-core kernel itself. Its clock transform retains every right-of-line zeta-zero pole that the fixed killed ground detects. This is a written pole-detection and oscillation statement, not an unconditional upper estimate of the mixed row or a proof of RH.

Fix a core $C=[-R,R]$, the even normalized killed ground $\psi_R$, and the notation of the [ground-tail zero response](theta-ground-zero-forced-flat-tail-oscillation.md):
$$
G_R=\Phi\psi_R1_O,\quad b(u)=2\cosh(u/2),\quad
\delta_R=\tfrac12-\alpha_R>0,\quad
\mu_R=\int bG_R,\quad c_R=\frac{\mu_R}{2\delta_R},\quad
H_R(u)=b(u)[\psi_R(u)-c_R]\quad(u>R).
$$
The ground is bounded, $\psi_R(u)\to c_R$, and the literal Laplace transform
$$
L_R(z)=\int_R^\infty e^{-zu}H_R(u)\,du
\tag{1}
$$
converges for $\Re z>1/2$. At a detected zeta zero $\rho$ with $\Re\rho>1/2$, its meromorphic continuation has residue
$$
\operatorname*{Res}_{z=\rho-1/2}L_R(z)
=-\frac{m_\rho M_R(\rho-1/2)}{\delta_R},\qquad
M_R(z)=\int_{\mathbb R}e^{zu}G_R(u)\,du.
\tag{2}
$$
For each fixed such $\rho$, the cited physical-mass concentration makes $M_R(\rho-1/2)\ne0$ for every sufficiently large $R$.

Let $K$ be the complete [actual successor scaling kernel](successor-feedback-kernel-scaling.md), and set
$$
f(x)=-\sqrt xK(x),\qquad h_t(v)=f(te^{|v|}),\qquad
\mathcal T_R(V)=Q_W(G_R,h_{e^{-V}}),\quad V\ge0.
\tag{3}
$$
Here $Q_W$ is the **full** physical mixed Weil row, including its archimedean form, all prime powers and both pole products. The [exponential weak-ground theorem](theta-ground-exponential-weak-cross-row.md) makes (3) well defined for each $V$.

**Theorem.** The literal one-sided Laplace transform of $\mathcal T_R$ converges for $\Re z>1/2$ and has a meromorphic continuation to $0<\Re z<1$. If $\rho$ is a zeta zero with $\Re\rho>1/2$, then
$$
\boxed{\quad
\operatorname*{Res}_{z=\rho-1/2}\widehat{\mathcal T}_R(z)
=2m_\rho\,\mathfrak m(\rho-1/2)M_R(\rho-1/2),
\quad}
\tag{4}
$$
where the coherent-kernel multiplier is
$$
\boxed{\quad
\mathfrak m(z)=\int_0^\infty x^{z-1}f(x)\,dx
=\frac{\sqrt\pi\,\Gamma(z+1/2)\cot(\pi z)}{2z+1}
=-M_K(z+1/2),\quad 0<\Re z<1.
\quad}
\tag{5}
$$
It has no zero in $0<\Re z<1/2$. Thus (4) is a genuine nonreal pole whenever $M_R(\rho-1/2)\ne0$.

In particular, the following mixed-row condition is equivalent to RH: the row has finite Cesàro square mean along some unbounded set of actual core radii,
$$
\limsup_{T\to\infty}\frac1T\int_0^T|\mathcal T_R(V)|^2dV<\infty
\quad\text{for each radius in that set},
\tag{6}
$$
Condition (6) implies RH by pole detection. Under RH the row is bounded at every fixed core, as proved below. No unconditional estimate (6) is established here. Its role is to locate a signed physical consumer of the actual arithmetic pole, not to replace the missing arithmetic bound.

## Exact transform and retained core arrival

Put $A_R(u)=\mathcal B_R(u)-\mu_Rb(u)/2$ on $C$, with $\mathcal B_R$ the complete continuous-plus-prime core arrival. Since $\delta_Rc_R=\mu_R/2$, the signed measure in the weak-ground formula simplifies **exactly** to $\delta_RH_R(u)du$ on each exterior half-line and $A_R(u)du$ on $C$. Evenness therefore gives
$$
\mathcal T_R(V)
=-2\delta_R\int_R^\infty H_R(u)f(e^{u-V})\,du
 -\int_C A_R(u)f(e^{|u|-V})\,du.
\tag{7}
$$
The core term is retained. It is uniformly bounded in $V$ because $A_R\in L^1(C)$ and $f$ is bounded. The exterior integral is absolutely convergent for each $V$: $H_R(u)=O_R(e^{u/2})$, while $f(e^{u-V})=O(e^{V-u})$ for $u>V$. Splitting at $u=V$ gives $\mathcal T_R(V)=O_R(e^{V/2})$, which proves the initial Laplace domain.

For $0<\Re z<1$, the small- and large-argument estimates $f(x)=1+O(\sqrt x)$ and $f(x)=O(x^{-1})$ make (5) absolutely convergent. Its value follows from the [complete kernel Mellin calculation](actual-Abel-feedback-Mellin-kernel.md), which gives $M_K(s)=\sqrt\pi\Gamma(s)\tan(\pi s)/(2s)$ on $1/2<\Re s<3/2$. Substitution $s=z+1/2$ and $\tan(\pi(z+1/2))=-\cot(\pi z)$ gives (5). Gamma has no zeros, and the only zero of $\cot(\pi z)$ in the strip $0<\Re z<1$ is the real point $z=1/2$; this lies outside the offcritical parameter strip.

For $1/2<\Re z<1$, absolute Fubini in (7) and the substitution $x=e^{u-V}$ give
$$
\int_0^\infty e^{-zV}f(e^{u-V})dV
=e^{-zu}\left[\mathfrak m(z)-\int_{e^u}^\infty x^{z-1}f(x)dx\right].
\tag{8}
$$
Consequently,
$$
\widehat{\mathcal T}_R(z)
=-2\delta_R\mathfrak m(z)L_R(z)
+2\delta_RJ_R(z)+C_R(z),
\tag{9}
$$
where
$$
J_R(z)=\int_R^\infty H_R(u)e^{-zu}
  \int_{e^u}^\infty x^{z-1}f(x)dx\,du,
\quad
C_R(z)=-\int_0^\infty e^{-zV}\int_C A_R(u)f(e^{|u|-V})du\,dV.
$$
The bound $|f(x)|\le C/x$ for $x\ge e^R$ shows that the integrand of $J_R$ is $O_R(e^{-u/2})$, locally uniformly for $\Re z<1$, including its $z$-derivatives. Hence $J_R$ is holomorphic there. The bounded core term makes $C_R$ holomorphic for $\Re z>0$. Equation (9) therefore supplies the claimed continuation throughout $0<\Re z<1$. Combining it with (2) proves (4).

If (6) holds, Cauchy--Schwarz makes the literal Laplace transform of $\mathcal T_R$ holomorphic for every $\Re z>0$. A hypothetical right-of-line zero would, by (4) and large-core nonvanishing of $M_R$, produce a pole at one such $z$ for a radius in the unbounded set. This contradiction excludes all zeros with $\Re\rho>1/2$; the functional equation excludes left-of-line zeros. No Lean formalization is claimed.

## The RH converse keeps the complete prime and archimedean rows

Let $Q_{\rm core}(s)=\sqrt s\sum_{n\ge2}\Lambda(n)K(sn)$ for $s>0$. For every real $u$ and all shifts $\ell_n=\log n\ge|u|$, the two translated tests in the physical prime pairing have their unreflected values:
$$
\frac{\Lambda(n)}{\sqrt n}
 [h_t(u+\ell_n)+h_t(u-\ell_n)]
=-\Lambda(n)\left[\sqrt{te^u}K(tne^u)
                   +\sqrt{te^{-u}}K(tne^{-u})\right].
$$
The terms with $\ell_n<|u|$ give an exact finite reflection correction. Consequently the **complete** prime pairing is
$$
S_R(t)=-\int_{\mathbb R}G_R(u)
 [Q_{\rm core}(te^u)+Q_{\rm core}(te^{-u})]du
 +E_{\rm flip}(t),
\tag{10}
$$
where the exact reflection correction is
$$
E_{\rm flip}(t)=\int_{\mathbb R}G_R(u)
 \sum_{n<e^{|u|}}\frac{\Lambda(n)}{\sqrt n}
 \bigl[h_t(u+\ell_n)+h_t(u-\ell_n)
       -f(tne^u)-f(tne^{-u})\bigr]du.
$$
Since $f$ is bounded and Chebyshev gives
$$
\sum_{n<e^{|u|}}\frac{\Lambda(n)}{\sqrt n}
 \le C e^{|u|/2},
$$
we have the uniform bound
$$
\sup_{0<t\le1}|E_{\rm flip}(t)|
 \le C\|f\|_\infty\int_{\mathbb R}G_R(u)e^{|u|/2}du<\infty.
\tag{11}
$$
This correction retains every admitted prime power and the absolute-value crossing; dominated convergence also gives $E_{\rm flip}(t)\to0$ as $t\downarrow0$.

The archimedean row is uniformly bounded as well. Polarizing the physical digamma formula in the [theta jump form](theta-weil-jump-form.md) gives, for a finite real constant $c_A$,
$$
A(G_R,h_t)=c_A\langle G_R,h_t\rangle
 +\int_0^\infty r(a)
   \int_{\mathbb R}[G_R(u+a)-G_R(u)]
                    [h_t(u+a)-h_t(u)]du\,da,
\quad r(a)=\frac{e^{-a/2}}{1-e^{-2a}}.
\tag{12}
$$
Explicitly, $c_A=-(\gamma_E+\log\pi)+2\int_0^\infty(e^{-2a}-e^{-a/2})/(1-e^{-2a})\,da$; the integrand is bounded near zero and decays exponentially. This form follows by writing the polarized correlation sum as $2\langle G_R,h_t\rangle-\langle\Delta_aG_R,\Delta_ah_t\rangle$ before integrating, so no divergent diagonal term is isolated.
The scaling estimates $\sup_t\|h_t\|_\infty<\infty$ and $\sup_t\operatorname{Lip}(h_t)<\infty$ follow from $|f(x)|+|xf'(x)|\le C\min(1,x^{-1})$. Thus the inner integral in (12) is bounded by $2\|G_R\|_1\min(2\|f\|_\infty,Ca)$. Since $\int_0^\infty r(a)\min(1,a)da<\infty$, $A(G_R,h_t)=O_R(1)$. Evenness gives the **full two-pole row** $\mu_RH_t$, where $H_t=M_{1/2}(h_t)=M_{-1/2}(h_t)$. The [exact pole calculation](actual-core-explicit-weil-cross-family.md) gives $H_t=O(\sqrt t\log(1/t))$, so this row is bounded too.

Under RH, the published [successor-feedback converse](successor-feedback-RH-converse.md) makes $E(e^{-s})$ bounded as $s\downarrow0$. The exact integer-birth identity $E(e^{-s})+C(s)=b_sQ_{\rm core}(s)+D(s)$ has $C(s)\to1$, $b_s\to1$ and $D(s)=O(s\log(1/s))$. Hence $Q_{\rm core}(s)$ is bounded near zero. Its defining series is continuous on compact positive $s$-intervals, and $K(x)=O(x^{-3/2})$ gives $Q_{\rm core}(s)=O(1/s)$ for $s\ge1$. It is therefore bounded for every $s>0$. Equations (10)--(12), the pole bound, and $Q_W=A-S+P$ now prove
$$
\boxed{\quad\mathrm{RH}\Longrightarrow
\sup_{V\ge0}|\mathcal T_R(V)|<\infty
\quad\text{for every fixed }R>0.\quad}
\tag{13}
$$
Together with (6), this proves the claimed equivalence. In fact RH is equivalent to boundedness of $\mathcal T_R$ for every $R$ in some unbounded set. If RH is false, choose a right-of-line zero. All sufficiently large cores detect it, and the positive-Laplace argument below applied to either eventual bound shows $\limsup_{V\to\infty}\mathcal T_R(V)=+\infty$ and $\liminf_{V\to\infty}\mathcal T_R(V)=-\infty$ for each of those cores. These are logical calibrations, not unconditional bounds.

## Critical-zero oscillation of the same physical row

The continuation also records a nontrivial unconditional fluctuation. The multiplier in (5) has $\mathfrak m(z)=z^{-1}+O(1)$ at $z=0$ and is nonzero at every $z=i\gamma$ with real $\gamma\ne0$. Since $f(x)=1+O(\sqrt x)$ at zero, the compact core part of (7) equals $-\int_CA_R+O_R(e^{-V/2})$ as $V\to\infty$. Its Laplace transform therefore extends meromorphically through $\Re z>-1/2$, with residue $-\int_CA_R$ at zero. The correction $J_R$ is holomorphic there. Consequently the real residue of $\widehat{\mathcal T}_R$ at zero is
$$
a_R=-2\delta_RL_R(0)-\int_CA_R(u)du.
\tag{14}
$$
Here $L_R(0)$ means its holomorphic continuation. Equivalently, $a_R$ is the value at zero of the continued exponential weak row $Q_W(G_R,e^{-z|\cdot|})$ from the ground-tail theorem; it is not an assertion that the unregularized constant test has finite pole moments.

This real residue is **exactly zero**. In the exponential-row continuation, the finite-reflection correction to the prime sum vanishes at $z=0$, since both the actual and unreflected brackets equal $2$ there. The two-pole term $\mu_R[(z-1/2)^{-1}+(z+1/2)^{-1}]$ also vanishes at zero. With $m_R=\int G_R$ and $a_0=\zeta'(1/2)/\zeta(1/2)$, the prime continuation is $S_R(0)=-2a_0m_R$, while (12) gives $A(G_R,1)=c_Am_R$. The quarter-argument digamma identity and the zeta functional equation, also used in the [successor-feedback constant calculation](successor-feedback-RH-converse.md), give
$$
c_A=\psi_{\rm dig}(1/4)-\log\pi
=-\gamma_E-\frac\pi2-3\log2-\log\pi
=-2a_0.
$$
Since $Q_W=A-S+P$, equation (14) therefore reduces to $a_R=(c_A+2a_0)m_R=0$, independently of RH and of the core radius.

Let $\rho=1/2+i\gamma$ be a detected critical-line zero, $\gamma\ne0$. Equation (9), continued to a neighborhood of $i\gamma$, has residue
$$
r_{R,\rho}=2m_\rho\mathfrak m(i\gamma)M_R(i\gamma)\ne0.
\tag{15}
$$
The gamma modulus identity gives $|\mathfrak m(i\gamma)|=\pi\coth(\pi|\gamma|)/(\sqrt{1+4\gamma^2}\sqrt{\cosh(\pi\gamma)})>0$.
The same positive-Laplace argument used in the [ground-tail oscillation theorem](theta-ground-zero-forced-flat-tail-oscillation.md) gives
$$
\boxed{\quad
\limsup_{V\to\infty}\mathcal T_R(V)\ge |r_{R,\rho}|,
\qquad
\liminf_{V\to\infty}\mathcal T_R(V)\le-|r_{R,\rho}|.
\quad}
\tag{16}
$$
For clarity, an eventual upper bound $\mathcal T_R(V)\le C$ makes $(C-\mathcal T_R)1_{[V_0,\infty)}$ nonnegative. Its transform has a nonreal pole at $i\gamma$, but no positive-real singularity: the earlier ground-tail continuation is regular on the positive real axis, as are (5), $J_R$ and the compact core transform. Landau's positive-Laplace theorem forces its convergence abscissa to zero. Positivity then bounds the absolute value of its transform at $\varepsilon+i\gamma$ by its value at $\varepsilon>0$. Multiplying by $\varepsilon\downarrow0$ yields $|r_{R,\rho}|\le C$, using $a_R=0$. Apply the same argument to $\mathcal T_R-C$ for the lower bound. Neither limit in (16) is assumed finite.

For any finite set $\mathcal Z_R$ of distinct detected critical-line zeros, counting conjugates separately, the same Abel-weight projection gives
$$
\limsup_{T\to\infty}\frac1T\int_0^T
 |\mathcal T_R(V)|^2dV
\ge\sum_{\rho\in\mathcal Z_R}|r_{R,\rho}|^2.
\tag{17}
$$
If the left side is finite, its $O(T)$ cumulative square mass makes the literal Laplace transform of $\mathcal T_R$ converge for $\Re z>0$. In the probability measure $\varepsilon e^{-\varepsilon V}dV$, exponentials at distinct ordinates have Gram matrix tending to the identity, while their pairings with $\mathcal T_R$ tend to the residues (15). Finite-dimensional projection and integration by parts give (17), exactly as in the linked ground-tail theorem. If the left side is infinite, (17) is immediate.

The physical-mass concentration cited above detects a fixed Hardy critical zero at all sufficiently large radii with $|\cos(\gamma R)|\ge1/2$, a set of density $2/3$. There $|M_R(i\gamma)|\ge m_R/4$, so $|r_{R,\rho}|\ge m_\rho m_R|\mathfrak m(i\gamma)|/2$. In fact detection, without a fixed relative amplitude, holds for a set of radii of density **one**: from $M_R(i\gamma)/m_R-\cos(\gamma R)\to0$, for each $\eta>0$ all sufficiently late non-detecting radii lie in $\{|\cos(\gamma R)|\le\eta\}$, whose density is $2\arcsin(\eta)/\pi$; let $\eta\downarrow0$. Thus (16) gives unconditional sign changes of the actual full mixed Weil row at arbitrarily late clock times for a density-one set of cores. It does not control the affine covariance residual.

## The RH-conditional full zero series

The exact prime identity also gives a direct asymptotic transfer from the arithmetic core. As $V\to\infty$, $h_{e^{-V}}(v)\to1$ pointwise. The uniform bounded/Lipschitz estimates used in (12) dominate its difference integral, so $A(G_R,h_{e^{-V}})\to c_Am_R$. The reflection correction in (10) tends to zero by (11) and dominated convergence, and the full two-pole row $\mu_RH_{e^{-V}}$ tends to zero. Therefore, **without assuming RH**,
$$
\mathcal T_R(V)=c_Am_R
 +\int_{\mathbb R}G_R(u)
 [Q_{\rm core}(e^{-V+u})+Q_{\rm core}(e^{-V-u})]du
 +o_R(1).
\tag{18}
$$

Under RH, the absolutely convergent zero expansion in the [successor-feedback converse](successor-feedback-RH-converse.md), together with the exact $E+C=b_sQ_{\rm core}+D$ relation, gives
$$
Q_{\rm core}(e^{-W})
=a_0+\sum_\rho b_\rho e^{i\gamma W}+o(1),
\qquad b_\rho=-m_\rho M_K(\rho),\quad
\rho=\tfrac12+i\gamma.
\tag{19}
$$
The sum includes distinct zeros with multiplicities in $b_\rho$ and converges absolutely and uniformly in $W$. For $|u|\le V/2$, both arguments of $Q_{\rm core}$ in (18) tend uniformly to zero, so the $o(1)$ in (19) integrates to $o_R(1)$. On $|u|>V/2$, the global RH bound on $Q_{\rm core}$ and the theta tail of $G_R$ make the integral vanish. Evenness gives $M_R(-i\gamma)=M_R(i\gamma)$, and the constant cancels because $c_A+2a_0=0$. Thus
$$
\boxed{\quad
\mathcal T_R(V)=\sum_\rho r_{R,\rho}e^{i\gamma V}+o_R(1),
\qquad
r_{R,\rho}=2b_\rho M_R(i\gamma)
=2m_\rho\mathfrak m(i\gamma)M_R(i\gamma).
\quad}
\tag{20}
$$
The coefficient sum is absolutely convergent because $|M_R(i\gamma)|\le m_R$ and $\sum_\rho|b_\rho|<\infty$. Conjugate zeros pair to make the row real. Its ordinary Cesàro mean and square mean therefore satisfy
$$
\lim_{T\to\infty}\frac1T\int_0^T\mathcal T_R(V)dV=0,
\qquad
\lim_{T\to\infty}\frac1T\int_0^T|\mathcal T_R(V)|^2dV
=\sum_\rho|r_{R,\rho}|^2.
\tag{21}
$$
For any radius detecting a critical zero, the right side is positive. These are RH-conditional calibrations of the actual mixed row, not unconditional sign or covariance estimates. The analytic statements in this chapter remain unformalized in Lean.
