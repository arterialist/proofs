# Theta jump eigenfunction regularity and zero isolation

This chapter proves localization, smoothness, complete zero-sum identities and form-norm expansions for hypothetical subthreshold eigenvectors of the actual theta jump operator. It also gives two-sided theta-tail bounds for zero isolators and explains the additional threshold modes that repeated zeros can create. All statements are written analysis; they neither exclude subthreshold eigenvectors nor prove the sharp gap.

Use the full kernel, closed form $E=E_{\rm jump}$ and selfadjoint operator $\mathcal L$ from the [ground-state chapter](theta-weil-jump-form.md), with
$$
\lambda=\tfrac12,\quad m(u)=2\cosh(u/2)\Phi(u),\quad d\nu=m(u)du,
\quad \tau(u)=\tanh(u/2),\quad \beta(h)=\nu(\tau h).
$$
The Hilbert inner product is linear in its first argument. Write $U h(z)=\int\Phi(u)h(u)e^{izu}du$, $\Xi(z)=\xi(1/2+iz)$, $\mu_\pm=(1\pm\tau)\nu$, and $s=\Phi'/\Phi$. The score projection is $Ph=h+2\beta(h)s$, and $R(h)=E(h)-\lambda\operatorname{Var}_\nu h$.

The earlier chapter proves the exact conjugated identity
$$
E(h)-\lambda\|h\|_\nu^2
=\mathcal A(\Phi h)-\langle\sqrt m\,h,K_{\rm p}\sqrt m\,h\rangle,
$$
where $\mathcal A$ has multiplier $a(t)=\Re\psi(1/4+it/2)-\log\pi$ and $K_{\rm p}$ contains every prime power. Its exterior bound is $E(h)\ge(\lambda-\delta_R)\|h\|_\nu^2$ for $h$ supported outside $[-R,R]$, with $\delta_R\le Ce^{-c e^{2R}}$. The tail norm $\Gamma_R$ of the prime off-diagonal operator obeys the same kind of bound. Equation and section numbers below continue that chapter so that the dependency of each estimate remains explicit.

## 13. Subthreshold eigenfunctions satisfy a stronger weighted tail condition

Choose a real smooth cutoff $\eta_R$ which is zero on $[-R,R]$, one outside $[-R-1,R+1]$, and has a Lipschitz bound $L_0$ independent of $R$. It preserves the form domain: the usual product increment inequality reduces the additional energy to the row integral of $|\Delta\eta_R|^2$. This is bounded because its square removes the archimedean diagonal singularity, while the prime departure rate is bounded.

Put $\omega(u)=\sqrt{\Phi(u)/(2\cosh(u/2))}$. After the conjugation $H=\sqrt m\,h$, the archimedean kernel of the first commutator is

$$
r(|u-v|)\,\omega(u)\omega(v)\,[\eta_R(u)-\eta_R(v)].
$$

Whenever the cutoff difference is nonzero, at least one endpoint is outside $[-R,R]$. Its magnitude is bounded by $\min(1,L_0|u-v|)$. Schur's test and the prime shift bound give a bounded commutator $B_R=[\mathcal L,\eta_R]$, with

$$
\|B_R\|\le\varepsilon_R:=
2\Gamma_R+
\Bigl(\sup_{\mathbb R}\omega\Bigr)
\Bigl(\sup_{|u|>R}\omega(u)\Bigr)
\,2\int_0^\infty r(a)\min(1,L_0a)\,da
\le C e^{-c e^{2R}}.
\tag{13.1}
$$

No derivative of an eigenfunction is used. On the core, expanding the form gives

$$
E(\eta_Rh,g)-E(h,\eta_Rg)=\langle B_Rh,g\rangle.
$$

Continuity extends this to the full form domain. If $h\in\operatorname{Dom}\mathcal L$, the representation theorem for closed forms therefore gives

$$
\eta_Rh\in\operatorname{Dom}\mathcal L,\qquad
\mathcal L(\eta_Rh)=\eta_R\mathcal Lh+B_Rh.
\tag{13.2}
$$

Now suppose $\mathcal Lh=\kappa h$, $0<\kappa<\lambda$. For $R$ large enough that $\lambda-\kappa-\delta_R>0$, use the exterior bound (11.4) in the [ground-state chapter](theta-weil-jump-form.md) on $\eta_Rh$, followed by (13.2):

$$
(\lambda-\kappa-\delta_R)\|\eta_Rh\|^2
\le\Re\langle B_Rh,\eta_Rh\rangle
\le\varepsilon_R\|h\|\|\eta_Rh\|.
$$

Consequently

$$
\boxed{
\|1_{\{|u|>R+1\}}h\|_{L^2(\nu)}
\le\frac{\varepsilon_R}{\lambda-\kappa-\delta_R}
\|h\|_{L^2(\nu)}.
}
\tag{13.3}
$$

This has a useful integrability consequence. For sufficiently large $T$, the squared tail is at most $C_h e^{-d e^{2T}}$, with some $d>0$. Integration of this tail distribution against the derivative of $e^{\alpha e^{2T}}$, with $0<\alpha<d$, proves

$$
\boxed{
\int_{\mathbb R}|h(u)|^2
\exp\!\bigl(\epsilon\pi e^{2|u|}\bigr)\,d\nu(u)<\infty
\quad\text{for some }\epsilon>0.
}
\tag{13.4}
$$

This stronger weighted condition does not imply that the entire transform
$U h(z)=\int\Phi(u)h(u)e^{izu}\,du$ is divisible by
$(z^2+1/4)\Xi(z)$. Thus a synthesis theorem whose hypotheses include that divisibility cannot be applied to a subthreshold eigenvector on the basis of (13.4) alone.

There is a separate extension of the return law requiring only $h\in L^2(\nu)$:

$$
\int_U^{U+1}|K_u(h)-\lambda\mu_-(h)|^2du\longrightarrow0
\qquad(U\to+\infty).
\tag{13.5}
$$

Indeed $d\mu_\pm/d\nu=1\pm\tau\le2$, so both moments exist. Cauchy–Schwarz for the prime destination measure gives
$|K_u h|^2\le b(u)K_u(|h|^2)$.
After integrating over the moving unit interval and changing the destination variable, Chebyshev's bounds

$$
\sum_{e^a\le q\le e^{a+1}}\frac{\Lambda(q)}q\le C,\qquad
\sum_{q\le x}\Lambda(q)\le Cx
$$

bound the destination density by
$C\Phi(v)(e^{-v/2}+e^{v/2-U})\le C m(v)$ for $U\ge0$.
Thus $h\mapsto K_{U+\cdot}h$ is uniformly bounded from $L^2(\nu)$ to $L^2(0,1)$. Density of compact smooth tests and their PNT return law prove (13.5). Reflection gives the other tail.

Neither (13.3) nor (13.5) alone establishes a pointwise envelope for an eigenfunction. The local logarithmic Fourier estimate alone does not provide continuity or control of its archimedean generator in an unweighted moving-window norm. Sections 16–17 resolve these regularity and tail-limit questions by weighted translations and the complete zero-mode expansion. No eigenfunction is excluded by the localization estimates themselves.

## 14. The complete zero sum is valid for subthreshold eigenfunctions

Let $\mathcal Lh=\kappa h$, $0<\kappa<\lambda$, and set
$F(z)=\int\Phi(u)h(u)e^{izu}\,du$.
This transform is entire already for $h\in L^2(\nu)$: Cauchy–Schwarz and theta decay control its integral and all complex derivatives on compact sets. The stronger eigenfunction localization gives more than this elementary entire continuation.

For every real smooth multiplier $p$ satisfying
$|p(u)|+|p'(u)|\le C e^{A|u|}$, the commutator
$[\mathcal L,p]$ extends to a bounded operator. After conjugation, its archimedean kernel is

$$
r(|u-v|)\omega(u)\omega(v)\,[p(u)-p(v)].
$$

Use
$$
|p(u)-p(v)|
\le C_A(e^{A|u|}+e^{A|v|})\min(1,|u-v|).
$$
The last factor cancels the diagonal singularity; the exponential factors are absorbed by theta decay. The prime part is a sum of weighted translations whose coefficient suprema are bounded by
$C_A\Lambda(q)q^{-1/2}e^{-c_Aq}$, hence summable over every prime power.
For $p_R=\chi_Rp$, the commutators converge to $[\mathcal L,p]$ in operator norm. The discarded kernels have a theta-decaying endpoint outside an expanding compact set and a common summable majorant.

The stronger weighted norm of $h$ gives $p_Rh\to ph$ in $L^2(\nu)$. Closedness of the operator, applied to
$\mathcal L(p_Rh)=\kappa p_Rh+[\mathcal L,p_R]h$, proves

$$
ph\in\operatorname{Dom}\mathcal L,\qquad
\mathcal L(ph)=\kappa ph+[\mathcal L,p]h.
\tag{14.1}
$$

This is a statement about these eigenfunctions, not preservation of the entire operator domain by an unbounded multiplier.

Apply (14.1) to $p=e^{-bu}$ and $p=u e^{-bu}$, uniformly for $b$ in a fixed bounded interval. The exact arithmetic form identity and $a(t)=\log|t|+O(1)$ give

$$
\sup_{|b|\le B}\int_{\mathbb R}\log(2+|t|)
\bigl(|F(t+ib)|^2+|F'(t+ib)|^2\bigr)\,dt<\infty
\quad(B<\infty).
\tag{14.2}
$$

Here the Fourier bound follows from
$\int\log(2+|t|)|\widehat{\Phi g}(t)|^2dt
\le C(E(g)+\|g\|^2)$;
it uses (11.1), the boundedness of $K_{\rm p}$, and the digamma asymptotic [DLMF 5.11.2](https://dlmf.nist.gov/5.11.E2).

The local unconditional zero count, including multiplicity, is
$\sum_{n\le\Re z<n+1}m_z\le C\log(2+|n|)$.
For each zero, the holomorphic mean-value inequality on a disk of radius $1/4$ bounds $|F(z)|^2$ by its area integral on that disk. Every such disk lies in the strip $|\Im z|\le3/4$. Summing by unit real intervals gives

$$
\sum_{z\in\mathcal Z}m_z|F(z)|^2
\le C\int_{-3/4}^{3/4}\int_{\mathbb R}
\log(2+|t|)|F(t+ib)|^2\,dt\,db<\infty.
\tag{14.3}
$$

No separation or simplicity of zeros is needed. The same argument applies to $F'$.

To identify this sum with the closed Weil form, one must still approximate in both topologies. For $h_R=\chi_Rh$, the multiplier proof gives
$$
\sup_{|b|\le3/4}
\|e^{-bu}(h_R-h)\|_{\operatorname{Dom}\mathcal L}\to0.
$$
For each fixed $R$, approximate $h_R$ in form norm by smooth core vectors and multiply by a guard cutoff to keep their support in a fixed compact set. Multiplication by $e^{-bu}$ is uniformly form bounded on that support for $|b|\le3/4$. Its bound may depend on $R$; choose the approximation accuracy after fixing $R$. A diagonal sequence $h_n\in C_c^\infty$ therefore converges to $h$ in form norm and satisfies
$$
\sum_zm_z|U h_n(z)-F(z)|^2\to0
$$
by the same area-sampling estimate.

Define the continuous pulled-back closed form
$$
\mathcal Q(h,k)=E(h,k)-\lambda\langle h,k\rangle_\nu
+\lambda\nu(h)\overline{\nu(k)}
-\lambda\beta(h)\overline{\beta(k)}.
$$
Passing through the compact-test explicit formula, using the bounded involution $Jv(z)=v(\bar z)$, proves

$$
\boxed{
\mathcal Q(h,k)=\sum_{z\in\mathcal Z}
m_z F_h(z)\overline{F_k(\bar z)}.
}
\tag{14.4}
$$

This holds for two subthreshold eigenvectors, or one such eigenvector and one compact smooth test. The series is absolutely convergent by (14.3). It is not an assertion that zero sampling is bounded on the entire form domain.

Since $\nu h=0$, the eigenvalue equation now has the exact spectral expression

$$
\boxed{
\sum_zm_zF(z)\overline{F(\bar z)}
=-(\lambda-\kappa)\|h\|^2-\lambda|\beta(h)|^2<0
\quad(h\ne0).
}
\tag{14.5}
$$

This establishes compatibility with all zeros; it does not prove that the negative expression is impossible.

## 15. Uniform localization through arbitrary threshold accumulation

Let $A_R$ be the exterior Dirichlet operator on $\{|u|>R\}$. Equation (11.4) of the [ground-state chapter](theta-weil-jump-form.md) and (13.1) above give
$$
A_R\ge\lambda-\delta_R,\qquad
\|[\mathcal L,\eta_R]\|\le\varepsilon_R,\qquad
\delta_R+\varepsilon_R\le C e^{-c e^{2R}}.
$$

For $d>\delta_R$, set $P_d=1_{(0,\lambda-d)}(\mathcal L)$,
$B=\mathcal L|_{\operatorname{Ran}P_d}$, and
$X=\eta_RP_d$, with values in the exterior Hilbert space.
The cutoff domain identity proves
$$
A_RX-XB=1_{\{|u|>R\}}[\mathcal L,\eta_R]P_d.
$$
The two selfadjoint operators have a gap at least $d-\delta_R$. The convergent Sylvester integral
$$
X=\int_0^\infty e^{-tA_R}
\,1_{\{|u|>R\}}[\mathcal L,\eta_R]P_d\,e^{tB}\,dt
$$
therefore yields
$$
\boxed{
\|1_{\{|u|>R+1\}}P_d\|
\le\min\left(1,\frac{\varepsilon_R}{d-\delta_R}\right).
}
\tag{15.1}
$$
There is no eigenbasis sum or dimension factor.

Define the nonnegative deficit operator with the constant mode excluded,
$$
T=(\lambda-\mathcal L)1_{(0,\lambda)}(\mathcal L).
$$
The spectral theorem gives $T=\int_0^\lambda P_d\,dd$ in the strong operator sense. Integrating (15.1), with the trivial bound for $d\le\delta_R$, proves
$$
\boxed{
\|1_{\{|u|>R+1\}}T\|
\le\delta_R+\varepsilon_R
\left[1+\log\frac{\lambda-\delta_R}{\varepsilon_R}\right]
}
\tag{15.2}
$$
for sufficiently large $R$.
The logarithm is absorbed by decreasing the positive constant in the superexponential exponent. After the shift $R+1$, this gives
$\|1_{\{|u|>r\}}T\|\le C e^{-c_*e^{2r}}$.
Integrating squared tails, uniformly over input vectors, yields

$$
\boxed{
T:L^2(\nu)\longrightarrow
L^2\!\left(e^{\epsilon\pi e^{2|u|}}\,d\nu\right)
\quad\text{boundedly, for some }\epsilon>0.
}
\tag{15.3}
$$

Its range, with norm $\|g\|_{\operatorname{Ran}T}=\inf_{Tf=g}\|f\|$, is preserved by every bounded spectral function of $\mathcal L$. The factor $\lambda-\mathcal L$ is essential: (15.3) does not give the same bounded weighted map for the full projection $1_{(0,\lambda)}(\mathcal L)$ when eigenvalues accumulate at $\lambda$.

These estimates cover all possible threshold accumulation. They provide regularity of the deficit operator, not its vanishing.

## 16. Weighted translations give smoothness and strip-Schwartz decay

For a hypothetical eigenvector $\mathcal Lh=\kappa h$, $0<\kappa<\lambda$, use the Lebesgue-space variables
$$
d=\lambda-\kappa>0,\quad H=\sqrt m\,h,\quad
\omega=\sqrt{\Phi/(2\cosh(u/2))},\quad f=\omega H=\Phi h.
$$
Write
$$
\mathscr D=\mathcal L-\kappa
=d+\omega(A-S)\omega=d+\omega A\omega-K_{\rm p},
$$
where
$$
Sf(u)=\sum_{q\ge2}\frac{\Lambda(q)}{\sqrt q}
[f(u+\log q)+f(u-\log q)].
$$
Both $A$ and this complete prime-power translation sum commute with translations. The letter $\mathscr D$ denotes an operator here, not a derivative.

The closed form domain in these variables is exactly
$$
\{v\in L^2(du):\omega v\in H^{\log/2}\},
\qquad
\|g\|_{H^{\log/2}}^2
=\int\log(2+|t|)|\widehat g(t)|^2dt.
\tag{16.1}
$$
To check the maximal-domain assertion, use (11.1) and boundedness of all lower-order terms. Physical cutoffs approximate $g=\omega v$ in $H^{\log/2}$ and $v$ in $L^2$. On a fixed compact set $\omega^{-1}$ is smooth and bounded; mollify the compactly supported $g$ and divide by $\omega$. This proves density of the original compact smooth core in the displayed domain.

A useful coercive estimate keeps a finite-frequency error:
$$
\langle v,\mathscr Dv\rangle
\ge\frac d2\|v\|_2^2-C\|P_{\le M}(\omega v)\|_2^2.
\tag{16.2}
$$
Indeed,
$$
|\langle v,K_{\rm p}v\rangle|
\le\Gamma_R\|v\|^2+\|K_{\rm p}\|\|1_{[-R,R]}v\|^2
\le\Gamma_R\|v\|^2+C_R\|\omega v\|^2.
$$
Choose $R$ with $\Gamma_R<d/2$, and then choose $M$ so that $a(t)\ge C_R$ outside $[-M,M]$. The global lower bound for $a$ proves (16.2). This is a frequency estimate on $\omega v$; it does not assume a frequency restriction on $v$.

Let $U_tg(u)=g(u+t)$, $\omega_t(u)=\omega(u+t)$, and
$$
V_tv=\frac{U_t(\omega v)}{\omega}.
$$
If $v$ has a positive theta-weighted $L^2$ margin, then $V_tv\in L^2$ for sufficiently small $|t|$, because
$$
\left|\log\frac{\omega_t(u)}{\omega(u)}\right|
\le C|t|(1+e^{2|u|}).
$$
Its form regularity is preserved exactly:
$\omega V_tv=U_t(\omega v)$. Translation commutation gives
$$
\boxed{
\mathscr D V_tv=
\frac{\omega}{\omega_t}U_t(\mathscr Dv)
+d\left(\frac{\omega_t}{\omega}-\frac{\omega}{\omega_t}\right)U_tv.
}
\tag{16.3}
$$
For the localized vectors used below, the series defining $S$ converges in $L^2_{\rm loc}$, since translated theta tails dominate all coefficients. Thus (16.3) first holds distributionally. Whenever its right side is $L^2$, the form representation and (16.1) place $V_tv$ in the operator domain.

For the eigenvector, $\mathscr DH=0$. The right side of (16.3), divided by $t$, is uniformly $L^2$-bounded using the stronger weighted localization of $H$. Moreover,
$$
\left\|P_{\le M}\omega\frac{V_tH-H}{t}\right\|_2
=\left\|P_{\le M}\frac{U_tf-f}{t}\right\|_2
\le M\|f\|_2.
$$
Equation (16.2) therefore bounds $(V_tH-H)/t$ in $L^2$. Weak closure of the operator graph, together with distributional difference-quotient convergence, gives
$$
H_1:=f'/\omega\in\operatorname{Dom}\mathscr D,\qquad
\mathscr DH_1=2d(\omega'/\omega)H.
\tag{16.4}
$$
This derives the first weak derivative instead of assuming it.

Localization also propagates through the inhomogeneous equations. If
$\mathscr Dv=g$ and $g$ has some positive theta-weighted margin, choose a sufficiently small $a>0$ and bounded smooth caps $p_R$ increasing to
$p(u)=\exp(a\pi\cosh(2u))$.
The commutators $[\mathscr D,p_R]$ have uniformly bounded operator norm. For the archimedean part, the factor
$\omega(u)\omega(v)[p_R(u)-p_R(v)]$ removes the diagonal singularity; for small $a$, $\omega p$ and the corresponding derivative weights still decay superexponentially. The prime coefficient suprema remain summable. The caps can be chosen with $0\le p_R\le p$ and $|p_R'|\le|p'|$, giving bounds independent of $R$.

Apply (16.2) to $p_Rv$. Its right-hand side under $\mathscr D$ is
$p_Rg+[\mathscr D,p_R]v$, uniformly bounded in $L^2$, while its finite-frequency term is bounded by
$\|\omega p\|_\infty\|v\|_2$.
It follows that $pv\in L^2$. Thus (16.4) gives a positive, possibly smaller, localization margin for $H_1$.

Inductively put $H_j=f^{(j)}/\omega$. The differentiated equation is
$$
\mathscr DH_j=
-\sum_{r=1}^j\binom jr
\left[\omega^2\left(\frac d{\omega^2}\right)^{(r)}\right]H_{j-r}.
\tag{16.5}
$$
The coefficients and each fixed derivative grow at most exponentially. If $H_0,\ldots,H_j$ have been constructed, the derivative of the right side uses only those same vectors, since
$H_\ell'=H_{\ell+1}-(\omega'/\omega)H_\ell$ for $\ell<j$.
Equation (16.3) and (16.2) therefore construct $H_{j+1}$ by weak graph closure; the capped-weight argument supplies its localization. Every fixed stage retains a positive margin, without asserting a margin uniform in the derivative order.

Consequently $h$ has a smooth representative and, for every $j\ge0$ and $B<\infty$,
$$
\|e^{B|u|}f^{(j)}\|_1
\le\|H_j\|_2\|e^{B|u|}\omega\|_2<\infty.
$$
Repeated integration by parts proves
$$
\boxed{
\sup_{|\Im z|\le B}(1+|\Re z|)^N|U h(z)|<\infty
\quad\text{for every fixed }B,N.
}
\tag{16.6}
$$
This is an eigenfunction regularity theorem based on the spectral margin and exact translation structure. Operator-domain membership alone would not give it.

## 17. An absolute expansion in simple zero modes, in form norm

For an actual zero $z$ of $\Xi$, define its evaluation representer
$$
k_z(u)=\frac{e^{-i\bar z u}}{2\cosh(u/2)},\qquad
U g(z)=\langle g,k_z\rangle_\nu.
$$
The mean of $k_z$ is $\Xi(-\bar z)=0$. Its $L^2(\nu)$ norm is bounded uniformly over the whole zero strip, including arbitrarily large real parts.

These modes also belong to the closed form domain, with
$$
\|k_z\|_{\rm form}
\le C\sqrt{\log(2+|\Re z|)}.
\tag{17.1}
$$
To see this directly, put $w=\omega^2=\Phi/(2\cosh(u/2))$.
Then $\Phi k_z=w e^{-i\bar z u}$, whose Fourier transform is
$\widehat w(t-\bar z)$. The function $\widehat w$ is Schwartz on every fixed horizontal strip. The archimedean form is therefore bounded by $C\log(2+|\Re z|)$, uniformly for $|\Im z|\le1/2$; the prime off-diagonal term is bounded by $\|K_{\rm p}\|\|k_z\|^2$. Equation (11.1) gives (17.1). Compact cutoffs justify domain membership.

For a subthreshold eigenvector, (16.6) and the unconditional zero count imply
$$
\sum_{z\in\mathcal Z}m_z|F_h(z)|\,\|k_{\bar z}\|_{\rm form}<\infty.
$$
The series below thus converges absolutely in form norm. Test it against compact smooth $g$ in the extended explicit formula (14.4), and use the eigenvalue equation. Density identifies its sum:
$$
\boxed{
\sum_{z\in\mathcal Z}m_zF_h(z)k_{\bar z}
=-(\lambda-\kappa)h-\lambda\beta(h)\tau.
}
\tag{17.2}
$$
All zeros, including every off-real zero, remain in this sum. Multiplicity appears as the scalar weight $m_z$; derivatives of evaluation modes are not needed in this particular representation.

For even $h$, $\beta(h)=0$. Grouping the symmetric zeros makes (17.2) a form-norm expansion in finite combinations of simple cosine zero modes. In the odd sector the additional $\tau$ term remains; it cannot be set to zero by a parity argument.

This is stronger than Hilbert-norm synthesis for the eigenvectors at issue: finite mode sums converge in the topology of the actual energy, so their quadratic forms converge as well. It does not establish positivity on those finite spans.

The series also resolves the pointwise tail problem. For each fixed derivative order $j$,
$$
\sup_u|k_z^{(j)}(u)|\le C_j(1+|z|)^j
\quad(|\Im z|\le1/2).
$$
Thus (16.6) makes (17.2) uniformly convergent with every fixed number of derivatives. Every actual zero lies in the strict strip $|\Im z|<1/2$, so $k_z^{(j)}(u)\to0$ at both ends, for each fixed $z,j$. Dominated convergence of the series gives
$$
\boxed{
\begin{aligned}
\lim_{u\to+\infty}h(u)&=-\frac{\lambda\beta(h)}{\lambda-\kappa}
=\frac{\lambda}{\lambda-\kappa}\mu_-(h),\\
\lim_{u\to-\infty}h(u)&=\frac{\lambda\beta(h)}{\lambda-\kappa}
=\frac{\lambda}{\lambda-\kappa}\mu_+(h),\\
\lim_{|u|\to\infty}h^{(j)}(u)&=0\qquad(j\ge1).
\end{aligned}
}
\tag{17.3}
$$
Here $\mu_\pm(h)=\nu(h)\pm\beta(h)=\pm\beta(h)$, since the eigenvector has mean zero. In particular $h$ and all its derivatives are bounded. The earlier bounded-$C^1$ archimedean return estimate now applies and gives $\mathcal L_{\rm arch}h(u)\to0$, rather than assuming this to obtain regularity.

An individual hypothetical off-real zero mode satisfies the same smoothness, weighted integrability, and Fourier decay conditions. The unproved restriction must therefore concern the collective equation (17.2), rather than the regularity of each separate mode.

## 18. Zero isolation preserves the actual theta tails up to the multiplicity

The isolators from [section 12 of the ground-state chapter](theta-weil-jump-form.md) admit stronger domain control than was needed for the index proof. Let $z_0$ be a zero of exact multiplicity $m$, and let $1\le j\le m$. In the plus Fourier convention, the inverse transform $f_j$ of $\Xi(z)/(z-z_0)^j$ satisfies
$$
(i\,d/du-z_0)f_j=f_{j-1},\qquad f_0=\Phi.
$$
It has the two exact representations
$$
\boxed{
\begin{aligned}
f_j(u)&=\frac{i^j}{(j-1)!}\int_0^\infty
t^{j-1}e^{iz_0t}\Phi(u+t)\,dt,\\
f_j(u)&=\frac{(-i)^j}{(j-1)!}\int_0^\infty
t^{j-1}e^{-iz_0t}\Phi(u-t)\,dt.
\end{aligned}
}
\tag{18.1}
$$
Their equality uses every vanishing moment
$\Xi^{(r)}(z_0)=\int(iu)^r e^{iz_0u}\Phi(u)\,du=0$, $r<j$.
The first formula controls the positive tail and the second controls the negative tail. No one-sided exponential remainder is discarded.

The actual theta logarithmic slope gives, for sufficiently large $U$,
$\Phi(U+t)/\Phi(U)\le\exp(-c e^{2U}t)$, $t\ge0$.
Since $|\Im z_0|<1/2$, (18.1) implies
$$
\left|\frac{f_j(u)}{\Phi(u)}\right|
\le(c e^{2|u|}-|\Im z_0|)^{-j}
=O_j(e^{-2j|u|})
\quad(|u|\to\infty).
\tag{18.2}
$$
There is also a uniform bound independent of zero height and multiplicity. Put
$$
C_\Phi=\sup_{U\ge0}
\frac{\displaystyle\int_0^\infty e^{3t/2}\Phi(U+t)\,dt}
{\Phi(U)}<\infty.
$$
Finiteness follows from continuity on a compact interval and the preceding tail estimate. The inequality
$t^{j-1}/(j-1)!\le e^t$ gives
$$
\|f_j/\Phi\|_\infty\le C_\Phi.
\tag{18.3}
$$
The first-order equation, together with the theta logarithmic slope and (18.2), gives
$\|(f_j/\Phi)'\|_\infty\le C(1+|z_0|)$.
Thus these quotients belong directly to the actual closed form domain; the near-diagonal energy is controlled by the derivative bound, and all long archimedean and prime-power jumps converge by theta decay. Their compact cutoffs converge in form norm. Higher fixed derivatives have at most exponential growth, so $f_j$ also belongs to the weighted smooth domain of the full explicit formula.

This tail preservation stops at the true multiplicity. If the two formulas in (18.1) are used at $j=m+1$, their difference is exactly
$$
i\,c_0e^{-iz_0u},\qquad
c_0=\Xi^{(m)}(z_0)/m!\ne0.
\tag{18.4}
$$
Hence no solution at that next step has both theta-decaying tails. This is the physical counterpart of the pole in $\Xi(z)/(z-z_0)^{m+1}$.

There is a threshold consequence when $m>1$. For $j<m$, $\Xi(z)/(z-z_0)^j$ still vanishes at every distinct zero. Hence its polarized Weil form vanishes against every compact test. After the score projection and subtraction of the mean, $f_j/\Phi$ is therefore an actual $\lambda$-eigenvector. In the even sector, combine the two isolators at $z_0$ and $-z_0$ first; only centering is then required. The resulting transform has zero order $m-j$ at $z_0$, whereas every vector in the closed span of the even derivative equality modes has a transform divisible by $(z^2+1/4)\Xi(z)$ with the full multiplicity. Continuity of derivative evaluations in $L^2(\nu)$ preserves that divisibility under closure. The reduced-order vectors are thus outside that old equality span, and different $j<m$ are independent modulo it by their vanishing orders. Repeated zeros can create additional threshold modes; the old derivative span must not be identified with the entire $\lambda$-eigenspace without further work.

For the normalized isolator $I_{z_0}=\Xi/[c_0(z-z_0)^m]$, its physical quotient has norm at most $C_\Phi/|c_0|$. The normalization therefore has an explicit conditioning cost.

For a nonreal conjugate pair, $F=I_{z_0}-I_{\bar z_0}$ has $Q(f)=-2m$. Its actual quotient $h=f/\Phi$ has
$$
\beta(h)=F(-i/2)-F(i/2),\qquad
\nu h=F(-i/2)+F(i/2).
$$
The vector $g=Ph-\nu h$ is in the form domain, has mean zero, and satisfies $R(g)=-2m$. With
$C_P=1+2\|\tau\|_\nu\|s\|_\nu$, its norm is at most
$2C_PC_\Phi/|c_0|$. Therefore
$$
\gamma_{\rm jump}
\le\lambda-\frac{m|c_0|^2}{2C_P^2C_\Phi^2}
\quad\text{if that nonreal pair exists}.
\tag{18.5}
$$

There is a cleaner even witness for its four-point quartet:
$$
F_e=I_{z_0}+I_{-z_0}-I_{\bar z_0}-I_{-\bar z_0}.
$$
It is even, has $Q(f_e)=-4m$, and its quotient has $\beta(h_e)=0$.
Centering $g_e=h_e-\nu h_e$ is an orthogonal contraction and gives
$\|g_e\|\le4C_\Phi/|c_0|$.
Consequently
$$
\boxed{
\gamma_{\rm even}
\le\lambda-\frac{m|c_0|^2}{4C_\Phi^2}
\quad\text{for every hypothetical off-critical quartet}.
}
\tag{18.6}
$$
Here $\gamma_{\rm even}$ is the infimum of the Rayleigh quotient over even mean-zero form vectors, equivalently over their compact-core approximants after centering. The witnesses are nonzero because their $R$-value is strictly negative.

These are zero-dependent bounds through the actual derivative $c_0$; no height-only lower bound for the deficit is asserted. They also show why the new regularity constraints do not by themselves exclude off-critical zeros: conditional on such a zero, its isolator already supplies a smooth, theta-regular negative witness in the actual form domain. A global positivity argument must control the collective arithmetic form, including this interpolation cost.

