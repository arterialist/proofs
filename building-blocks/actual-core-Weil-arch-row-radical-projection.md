# The full archimedean row and radical projection for the actual core

This note calculates the complete archimedean-plus-pole cross row of the actual two-source family. It proves its constant-scale asymptotic, extends the theta radical identity to the specific exponential/BV sources, and computes the nonzero prime-port correction caused by removing their pole coordinates. These are exact source-space statements. They provide no theta Hilbert-space bound and no sign for the remaining Weil cross row.

We use [the actual cross-family construction](actual-core-explicit-weil-cross-family.md), the [complete kernel](successor-feedback-kernel-scaling.md), and the normalization of [the public theta Weil form](theta-weil-jump-form.md). Here $t>0$ is the geometric successor parameter, and $\beta\in(1/2,1)$ is fixed.

## 1. Kernel and source conventions

Write
$$
f(z)=-\sqrt zK(z),\qquad h_t(v)=f(te^{|v|}),
\quad u(v)=\sqrt{2\beta}e^{-\beta v}\mathbf1_{v\ge0},
\quad z_t=\frac{\beta h_t-h_t'}{\sqrt{2\beta}}.
\tag{1}
$$
The derivative in (1) is weak. Since $h_t$ is continuous, it contributes no delta mass there. The literal identity is
$u*\widetilde z_t=h_t$; the reverse cross correlation is also $h_t$ because this kernel is real and even.

The full kernel, not just its leading approximation, satisfies
$$
K'(z)=-\frac{b(z)}{2z},\quad
b'(z)+b(z)=\frac1{2z^{3/2}},\quad
zK''(z)+(1+z)K'(z)=-\frac1{4z^{3/2}}.
\tag{2}
$$
Thus its normalized form obeys
$$
z^2f''(z)+z^2f'(z)+(1/4-z/2)f(z)=1/4.
\tag{3}
$$
The exact integral for $b$ at zero, together with $\int_0^\infty K=0$, gives
$$
f(z)=1-c_0\sqrt z+2z+O(z^2),\qquad
c_0=\pi^{3/2}/2,
\tag{4}
$$
and $f(z)=O(z^{-1})$, $zf'(z)=O(z^{-1})$ at infinity. Differentiating the explicit $b$ expression in (2) also gives the differentiated version of (4). Consequently
$$
\rho(z):=f(z)-1+c_0\sqrt z
\quad\text{satisfies}\quad
\rho(0)=0,\quad \sup_{z>0}|\rho'(z)|<\infty.
\tag{5}
$$
Indeed $\rho'(z)=2+O(z)$ at zero and is bounded at infinity by the stated decay of $f'$ and the derivative of $c_0\sqrt z$. In particular $|\rho(z)|\le Cz$ globally. Also $f$ and $zf'$ are globally bounded. These facts provide the uniform domination used below.

## 2. The exact archimedean and pole row

To avoid confusing the two psi functions, denote the digamma function by $\psi_{\!D}$. Put
$$
\mathfrak a(\xi)=\Re\psi_{\!D}(1/4+i\xi/2)-\log\pi,
\quad a_*:=\mathfrak a(0),\quad
r(a)=\frac{e^{-a/2}}{1-e^{-2a}}.
$$
Let $A$ be the Fourier multiplier $\mathfrak a$, and use the real polarized forms
$$
\mathcal A(f,g)=\langle Af,g\rangle,
\quad\mathcal B(f,g)=M_+(f)M_-(g)+M_-(f)M_+(g),
$$
where $M_\pm(f)=\int e^{\pm v/2}f(v)dv$.
For the fixed causal $u$, its literal pole row is
$$
(Bu)(v)=\sqrt{2\beta}\left[
\frac{e^{-v/2}}{\beta-1/2}+
\frac{e^{v/2}}{\beta+1/2}\right].
\tag{6}
$$
For $v\ne0$ the archimedean row is explicitly
$$
(Au)(v)=
\begin{cases}
-\sqrt{2\beta}e^{-\beta v}\displaystyle\int_{-v}^{\infty}r(a)e^{-\beta a}da,&v<0,\$$2mm]
u(v)\left[a_*+\displaystyle\int_0^v r(a)(2-e^{-\beta a}-e^{\beta a})da
+\displaystyle\int_v^\infty r(a)(2-e^{-\beta a})da\right],&v>0.
\end{cases}
\tag{7}
$$
This follows from
$Af=a_*f+\int_0^\infty r(a)[2f-f(\cdot+a)-f(\cdot-a)]da$.
The local logarithmic singularity in (7) is integrable and belongs to $L^2$; equivalently $\mathfrak a\widehat u\in L^2$. No delta contact is removed from the definition of $u$. Formula (7) is its multiplier action away from the single jump.

The full cross row against $z_t$ is independent of $\beta$, because the correlation in (1) is exactly $h_t$:
$$
\begin{aligned}
\mathcal G_t&:=\mathcal A(u,z_t)+\mathcal B(u,z_t)\\
&=a_*h_t(0)+2\int_0^\infty r(a)[h_t(0)-h_t(a)]da+2H_t,
\quad H_t=M_+(h_t)=M_-(h_t).
\end{aligned}
\tag{8}
$$
All terms are finite at fixed $t$. Near zero the difference in the integral is $O_t(a)$, cancelling the $1/a$ singularity. At infinity $r$ decays and $h_t(a)=O_t(e^{-a})$. The source pole moments converge because $\beta>1/2$ and $z_t$ has exponential rate one.

Set
$$
r_2(a)=\frac{e^{-5a/2}}{1-e^{-2a}},\qquad r(a)=e^{-a/2}+r_2(a).
$$
Use the exact identity from the actual kernel,
$$
H_t=-t^{-1/2}\int_t^\infty K(z)dz
-\sqrt t\int_t^\infty K(z)\frac{dz}{z}.
$$
The second integral cancels exactly with the $e^{-a/2}$ portion of the archimedean correlation. Hence
$$
\boxed{\mathcal G_t=(a_*+4)f(t)
+2\int_0^\infty r_2(a)[f(t)-f(te^a)]da
-\frac2{\sqrt t}\int_t^\infty K(z)dz.}
\tag{9}
$$
Both pole evaluations and the complete small-jump activity are included. This cancellation is made before any asymptotic estimate.

## 3. Constant-scale asymptotic with a uniform remainder

By (4) and the exact zero moment of $K$,
$$
-\frac2{\sqrt t}\int_t^\infty K(z)dz
=-4+2c_0\sqrt t+O(t).
\tag{10}
$$
Write $f(z)=1-c_0\sqrt z+\rho(z)$. The global Lipschitz bound (5) proves
$$
\left|\int_0^\infty r_2(a)[\rho(t)-\rho(te^a)]da\right|
\le Ct\int_0^\infty r_2(a)(e^a-1)da=O(t).
\tag{11}
$$
The integrand on the right is bounded near zero and decays at infinity. This verifies uniformity through the moving region $te^a\asymp1$; no expansion valid only on a fixed $a$ interval is integrated over the whole line.

The [digamma integral](https://dlmf.nist.gov/5.9.E16) and [recurrence](https://dlmf.nist.gov/5.5.E2) give
$$
J:=\int_0^\infty r_2(a)(e^{a/2}-1)da
=\frac12[\psi_{\!D}(5/4)-\psi_{\!D}(1)]
=\frac12[\psi_{\!D}(1/4)+4+\gamma_E].
\tag{12}
$$
Insert (10)–(12) in (9). The constant is $(a_*+4)-4=a_*$, and the coefficient of $c_0\sqrt t$ is
$-(a_*+4)+2J+2=2+\gamma_E+\log\pi$. Therefore
$$
\boxed{\mathcal G_t=a_*+
c_0(2+\gamma_E+\log\pi)\sqrt t+O(t).}
\tag{13}
$$
In particular the apparent $\sqrt t\log(1/t)$ contributions in the separate archimedean and pole terms cancel. The full functional equation gives
$$
a_*=-2\frac{\zeta'(1/2)}{\zeta(1/2)}.
\tag{14}
$$
This agrees with the exact constant in [the feedback calibration](successor-feedback-RH-converse.md).

Use $\mathcal W(f,g)=\mathcal A(f,g)+\mathcal B(f,g)-\mathcal P(f,g)$, where the full prime port is
$$
\mathcal P(f,g)=\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
\left[\int f(v+\log q)g(v)dv+\int f(v-\log q)g(v)dv\right].
\tag{15}
$$
For the original sources, $\mathcal P(u,z_t)=-2Q(t)$ exactly. Thus the complete arithmetic identity remains
$$
\boxed{E(e^{-t})=\frac{b_t}{2}\mathcal W(u,z_t)
-\frac{b_t}{2}\mathcal G_t-C(t)+D(t),
\quad b_t=\frac{t}{1-e^{-t}}.}
\tag{16}
$$
The literal causal correction $C$ and positive integer interpolation correction $D$ have not changed. From their accepted estimates, $C(t)\to1$, $D(t)=O(t\log(2/t))$, and $|Q(t)|=O(t^{-1/2})$. Since $b_t-1=O(t)$, equations (13)–(16) yield the unconditional calibration
$$
E(e^{-t})=\frac12\mathcal W(u,z_t)+C_*+o(1),
\qquad C_*:=\frac{\zeta'(1/2)}{\zeta(1/2)}-1.
\tag{17}
$$
The potentially signed, constant-scale cross row remains present in (17).

## 4. Radical extension on these source functions

Let $\Phi$ be the actual theta kernel normalized by
$\widehat\Phi(\omega)=\xi(1/2+i\omega)$ in the plus Fourier convention. Its real evenness removes any convention conflict in the formulas below. Its pole moments are
$$
M_\pm(\Phi)=1/2,\qquad M_\pm(\Phi')=\mp1/4.
\tag{18}
$$
The compact-test identity $\mathcal W(\Phi^{(j)},g)=0$ for $j=0,1$ extends to $g=u,z_t$ and their finite theta corrections.

Here is a source-space justification, independent of any theta quotient norm. Choose $\beta'\in(1/2,\beta)$. For fixed $t$, the sources have a bound $C_t e^{-\beta'|v|}$, are in $L^2$, and are locally BV. Smooth compact approximants can be chosen to converge in $L^2$ and in the two exponential-moment integrals, with the same exponential envelope. The archimedean pairings converge since $A\Phi^{(j)}\in L^2$. For the prime pairings, superexponential theta decay gives the uniform bound
$$
\int |\Phi^{(j)}(v\pm a)g(v)|dv
\le C_t e^{-\beta'a}\int e^{\beta'|v|}|\Phi^{(j)}(v)|dv.
$$
The dominating series is
$\sum_q\Lambda(q)q^{-1/2-\beta'}<\infty$.
The pole pairings converge by the same envelope. Passing through the compact radical identity proves the claimed extension with all prime powers retained. Local smoothing also converges in $H^s$ for any fixed $0<s<1/2$, which dominates the logarithmic Fourier form if a simultaneous source-space form approximation is desired.

This argument does not claim $u/\Phi$ or $z_t/\Phi$ belongs to the theta-weighted Hilbert space. The [independent cutoff calculation](coherent-core-theta-domain-and-cutoff.md) retains the divergent theta cross norm and its cancelling jump term; none of those separate quantities is used here as a finite norm.

For a real source $g$, set
$$
\alpha(g)=M_+(g)+M_-(g),\qquad
\delta(g)=2[M_-(g)-M_+(g)],
\quad g^\circ=g-\alpha(g)\Phi-\delta(g)\Phi'.
\tag{19}
$$
Then $M_\pm(g^\circ)=0$ exactly, and the established radical extension gives
$$
\boxed{\mathcal W(u,z_t)=\mathcal W(u^\circ,z_t^\circ),
\qquad \mathcal B(u^\circ,z_t^\circ)=0.}
\tag{20}
$$
Writing $d_\beta=\beta^2-1/4>0$, the coefficients are explicitly
$$
\alpha_u=\frac{2\beta\sqrt{2\beta}}{d_\beta},\qquad
\delta_u=-\frac{2\sqrt{2\beta}}{d_\beta},\qquad
\alpha_z=\sqrt{2\beta}H_t,\qquad
\delta_z=-\frac{2H_t}{\sqrt{2\beta}}.
\tag{21}
$$
The variable correction is $O_\beta(\sqrt t\log(1/t))$, but the fixed-reference correction is of order one. Both exponential transforms of each corrected source vanish, so the cross-kernel transform also has vanishing first derivative at both pole parameters. This removes the earlier pole-projection defect exactly through the actual radical, rather than treating a large derivative as a small error.

## 5. The prime cross terms that the projection retains

The prime port itself is not radical-invariant. The exact expansion of (20) includes
$$
\begin{aligned}
\mathcal P(u^\circ,z_t^\circ)-\mathcal P(u,z_t)
={}&-\alpha_u\mathcal P(\Phi,z_t)
-\delta_u\mathcal P(\Phi',z_t)\\
&-\alpha_z\mathcal P(u,\Phi)
-\delta_z\mathcal P(u,\Phi')\\
&+\alpha_u\alpha_z\mathcal P(\Phi,\Phi)
+\delta_u\delta_z\mathcal P(\Phi',\Phi').
\end{aligned}
\tag{22}
$$
The two omitted mixed theta terms are exactly zero by parity, $\mathcal P(\Phi,\Phi')=0$. Every port in (22) is its complete series (15).

There is a nonzero constant-scale correction in (22). Put
$$
\mu_0:=\int_{\mathbb R}\Phi(v)dv=\xi(1/2)>0,
\qquad c_\beta=\frac{\beta}{\sqrt{2\beta}}.
$$
Equations (2)–(5) imply
$$
|z_t(v)-c_\beta|\le C_\beta
\min(\sqrt t\,e^{|v|/2},1).
\tag{23}
$$
The public theta kernel calculation gives
$|A\Phi(v)|+|A\Phi'(v)|\le Ce^{-|v|/2}$. For the derivative insertion this follows directly by applying the same compensated digamma integral to $\Phi'$, not by differentiating an asymptotic remainder: split at displacement one, use theta derivative decay on the local compensated part, and exponential convolution bounds on the remaining kernel. Also
$$
\int A\Phi=a_*\mu_0,\qquad \int A\Phi'=0.
$$
Splitting the integral at $|v|=\log(1/t)$ in (23) proves
$$
\mathcal A(\Phi,z_t)=c_\beta a_*\mu_0
+O_\beta(\sqrt t\log(2/t)),\qquad
\mathcal A(\Phi',z_t)=O_\beta(\sqrt t\log(2/t)).
\tag{24}
$$
The corresponding pole pairings have the same error scale, because $H_t=O(\sqrt t\log(1/t))$. The radical identity therefore turns (24) into the same formulas for $\mathcal P(\Phi,z_t)$ and $\mathcal P(\Phi',z_t)$. All other variable coefficients in (22) tend to zero, and their fixed ports converge absolutely. Hence
$$
\boxed{\mathcal P(u^\circ,z_t^\circ)-\mathcal P(u,z_t)
=L_\beta+O_\beta(\sqrt t\log(2/t)),}
\tag{25}
$$
$$
\boxed{L_\beta=-\frac{2\beta^2}{\beta^2-1/4}
a_*\xi(1/2)>0.}
\tag{26}
$$
This is a full-prime statement obtained through an exact radical identity and absolutely convergent mixed ports. It does not discard the repeated powers or exchange a termwise small-$t$ limit with an undominated prime sum.

In particular
$$
\mathcal P(u^\circ,z_t^\circ)=-2Q(t)+L_\beta
+O_\beta(\sqrt t\log(2/t)),
$$
while the projected archimedean row changes by the same leading constant. Indeed (20) implies exactly
$$
\mathcal A(u^\circ,z_t^\circ)-\mathcal A(u,z_t)
=\mathcal P(u^\circ,z_t^\circ)-\mathcal P(u,z_t)+2H_t.
\tag{27}
$$
Thus the two leading changes cancel in the full Weil form, as required.

## 6. What the construction supplies

The pole-null representation is now exact:
$$
\boxed{E(e^{-t})=
\frac{b_t}{2}\left[\mathcal A(u^\circ,z_t^\circ)
-\mathcal P(u^\circ,z_t^\circ)\right]
-\frac{b_t}{2}\mathcal G_t-C(t)+D(t).}
\tag{28}
$$
It uses the actual theta radical to remove the pole coordinates without changing the full source cross row. Equations (9), (13), and (22) give the explicit gamma, pole, and prime corrections needed to connect that row to the original arithmetic core. The positive interpolation defect $D$ and literal causal return $C$ remain exact.

The projected row is still a cross term of two distinct sources. The construction supplies no positive-square representation or lower bound for it. In particular, the positive constant $L_\beta$ in the projected prime port is also present in the projected archimedean port and cannot be counted as a new arithmetic gain. The outcome is a full constant calibration and a domain-qualified radical repair of the pole projection, with the specific residual cross terms retained. It does not prove the coherent-core sign or RH.

## Dependencies and formal scope

The [explicit two-source factorization](actual-core-explicit-weil-cross-family.md), [correlated theta cutoff](coherent-core-theta-domain-and-cutoff.md), [complete scaling kernel](successor-feedback-kernel-scaling.md) and [actual theta Weil normalization](theta-weil-jump-form.md) fix every term. The digamma integral and recurrence are classical; the displayed calculation keeps their complete prime, gamma and pole compensation. The extension of the radical to this exponential/BV source pair and its constant-scale correction are written proofs. No Lean formalization, finite theta norm for the uncut pair, or arithmetic gain from the projection is asserted.

The [signed screw-increment readout](actual-core-screw-increment-readout.md) expresses this full row through the classical actual $H_1$ kernel, with the origin atom and both signs of the full observation weight retained. The radical projection leaves that exact signed budget unchanged.
