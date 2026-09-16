# The coherent-core kernel detects offcritical poles in the actual weak ground row

The actual exponential weak-ground identity can be tested with the coherent-core kernel itself. Its clock transform retains every right-of-line zeta-zero pole that the fixed killed ground detects. This is a written pole-detection statement, not an estimate of the mixed row or a proof of RH.

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

In particular, if the mixed row has finite Cesàro square mean along any unbounded set of actual core radii,
$$
\limsup_{T\to\infty}\frac1T\int_0^T|\mathcal T_R(V)|^2dV<\infty
\quad\text{for each radius in that set},
\tag{6}
$$
then RH follows. No estimate (6) is established here. Its role is to locate a signed physical consumer of the actual arithmetic pole, not to replace the missing arithmetic bound.

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

Finally, if (6) holds, Cauchy--Schwarz makes the literal Laplace transform of $\mathcal T_R$ holomorphic for every $\Re z>0$. A hypothetical right-of-line zero would, by (4) and large-core nonvanishing of $M_R$, produce a pole at one such $z$ for a radius in the unbounded set. This contradiction excludes all zeros with $\Re\rho>1/2$; the functional equation excludes left-of-line zeros. The result is a one-way RH criterion, not an unconditional mixed-row bound. No Lean formalization is claimed.
