# A sharp max-to-sum energy transfer after complete prime-history evolution

This note gives an unconditional positive comparison between the original
frozen-source norm and an additive Goldbach kernel. It keeps the complete
multiplicative-history semigroup. The comparison produces a new equivalent
positive-energy criterion for RH at sufficiently long logarithmic clock
rate. It does not prove the required subpower estimate.

Let $\nu$ be a finite real signed measure with compact support in
$[1,\infty)$.
Define its original physical source by
$$
g_\nu(x)=\int\frac{\mathbf1_{x\ge y}}x\,\nu(dy).
\tag{1}
$$
Two positive quadratic energies are
$$
\mathcal M(\nu)=\|g_\nu\|_{L^2(dx)}^2
=\iint\frac{\nu(dx)\nu(dy)}{\max(x,y)}
\tag{2}
$$
and
$$
\mathcal S(\nu)=\iint\frac{\nu(dx)\nu(dy)}{x+y}
=\int_0^\infty\left|\int e^{-tx}\nu(dx)\right|^2dt.
\tag{3}
$$
The first equality in (3) follows from
$(x+y)^{-1}=\int_0^\infty e^{-t(x+y)}dt$. Both forms are nonnegative
even though $\nu$ is signed.

## 1. Exact logarithmic multipliers and the sharp comparison

Push the weighted measure $x^{-1/2}\nu(dx)$ to the logarithmic line:
$$
\mu(du)=e^{-u/2}\nu(d e^u).
\tag{4}
$$
Then
$$
\frac1{\max(e^u,e^v)}
=e^{-(u+v)/2}e^{-|u-v|/2},
$$
and
$$
\frac1{e^u+e^v}
=e^{-(u+v)/2}\frac1{2\cosh((u-v)/2)}.
$$
With Fourier transform
$\widehat f(\xi)=\int e^{-i\xi u}f(u)du$, the two translation kernels
have transforms
$$
\widehat{k_{\max}}(\xi)=\frac1{\xi^2+1/4},\qquad
\widehat{k_+}(\xi)=\frac{\pi}{\cosh(\pi\xi)}.
\tag{5}
$$
Approximation of finite measures by smooth compact densities, followed by
dominated convergence against the integrable multipliers, gives
$$
\mathcal M(\nu)=\frac1{2\pi}\int_{\mathbb R}
\frac{|\widehat\mu(\xi)|^2}{\xi^2+1/4}\,d\xi,
$$
$$
\mathcal S(\nu)=\frac1{2\pi}\int_{\mathbb R}
\frac{\pi|\widehat\mu(\xi)|^2}{\cosh(\pi\xi)}\,d\xi.
\tag{6}
$$

The elementary bound
$$
\cosh(\pi\xi)\ge1+\frac{\pi^2\xi^2}{2}
\ge1+4\xi^2
\tag{7}
$$
uses only $\pi^2>8$. Hence
$$
\frac{\pi}{\cosh(\pi\xi)}
\le\frac{\pi}{4}\frac1{\xi^2+1/4}.
$$
Substitution in (6) proves the sharp operator inequality
$$
\boxed{0\le\mathcal S(\nu)\le\frac{\pi}{4}\mathcal M(\nu).}
\tag{8}
$$
The constant is sharp for the translation-invariant kernels because the
ratio of their multipliers tends to $\pi/4$ at $\xi=0$.
It is also sharp within the stated measure class: take
$\mu_L=L^{-1/2}\mathbf1_{[0,L]}du$ and push
$e^{u/2}\mu_L(du)$ to $\nu_L$. The two kernel forms tend to
$\int k_{\max}=4$ and $\int k_+=\pi$, respectively, since their
triangular overlap weights are $(1-|r|/L)_+$. Each $\nu_L$ is a
finite signed measure with compact support in $[1,\infty)$.

This is a quadratic-form statement. A pointwise comparison of the kernels
would not justify it for signed $\nu$; the nonnegative Fourier multiplier
difference does.

## 2. Complete prime-history evolution supplies the reverse estimate

Let $T_s$ be the established complete causal prime-history semigroup in
logarithmic age. Write
$$
\rho(\xi)=\operatorname{Re}\Phi(i\xi)\ge0,
\qquad
\widehat{T_sf}(\xi)=e^{-s\Phi(i\xi)}\widehat f(\xi).
\tag{9}
$$
Every prime power occurs in $\Phi$, and its total mass $\lambda$
retains the no-jump atom of mass $e^{-\lambda s}$.
For the established unitary logarithmic map $U$, Fubini's theorem gives
$$
\widehat{Ug_\nu}(\xi)
=\frac{\widehat\mu(\xi)}{1/2+i\xi}.
$$
For the evolved source define
$$
\mathcal M_s(\nu)=\|T_sUg_\nu\|_2^2
=\frac1{2\pi}\int
\frac{e^{-2s\rho(\xi)}|\widehat\mu(\xi)|^2}
     {\xi^2+1/4}\,d\xi,
\tag{10}
$$
and the evolved additive energy
$$
\mathcal S_s(\nu)=\frac1{2\pi}\int
\frac{\pi e^{-2s\rho(\xi)}|\widehat\mu(\xi)|^2}
     {\cosh(\pi\xi)}\,d\xi.
\tag{11}
$$
This is an ordinary evolved $L^2$ norm. Indeed, put
$$
F_\nu(t)=\int e^{-tx}\nu(dx),\qquad
h_\nu(v)=e^{-v/2}F_\nu(e^{-v}).
$$
The Mellin change of variables gives
$$
\widehat h_\nu(\xi)
=\Gamma(1/2+i\xi)\widehat\mu(\xi),
$$
so $|\Gamma(1/2+i\xi)|^2=\pi/\cosh(\pi\xi)$ yields
$$
\boxed{\mathcal S_s(\nu)=\|T_sh_\nu\|_2^2.}
\tag{11b}
$$
Equivalently, if $\eta_s$ is the process probability measure and
$\mu_s=\eta_s*\mu$, then (11) is the positive kernel form
$$
\mathcal S_s(\nu)=
\iint\frac{\mu_s(du)\mu_s(dv)}{2\cosh((u-v)/2)}.
$$
Writing $A,B$ for two independent histories with law $\eta_s$, the
same form in the original variables is
$$
\mathcal S_s(\nu)=\mathbb E_{A,B}
\iint
\frac{e^{(A+B)/2}}{e^A x+e^B y}\,\nu(dx)\nu(dy).
\tag{11a}
$$
The history-dependent kernel is bounded by $(2\sqrt{xy})^{-1}$, so
this identity requires no positive exponential moment of the process.
There is also an exact centered-heat correlation formula. If
$D=A-B$, then
$$
\mathcal S_s(\nu)=\mathbb E_D\int_0^\infty
F_\nu(te^{D/2})F_\nu(te^{-D/2})\,dt
=\mathbb E_D\int_{\mathbb R}
h_\nu(v-D/2)h_\nu(v+D/2)\,dv.
\tag{11c}
$$
Equation (8) remains valid after multiplication by the common
nonnegative process weight:
$$
\boxed{\mathcal S_s(\nu)\le\frac{\pi}{4}\mathcal M_s(\nu).}
\tag{12}
$$

Let $\lambda$ be the total mass of the complete process's Lévy measure.
Its density is integrable and positive almost everywhere on a final
half-line. Hence $\rho$ is continuous, $\rho(\xi)>0$ for
$\xi\ne0$, and the Riemann--Lebesgue lemma gives
$\rho(\xi)\to\lambda>0$ as $|\xi|\to\infty$. Therefore, for every
fixed frequency radius $R>0$,
$$
\delta_R:=\inf_{|\xi|>R}\rho(\xi)>0.
\tag{13}
$$
On the compact band put
$$
m_R:=\inf_{|\xi|\le R}
\frac{\pi(\xi^2+1/4)}{\cosh(\pi\xi)}>0.
\tag{14}
$$
Split (10) at R. On the compact band, the multiplier in (11) is at least
$m_R$ times the multiplier in (10). Off the band, (13) and the initial
energy (6) give
$$
\boxed{
\mathcal M_s(\nu)
\le m_R^{-1}\mathcal S_s(\nu)
+e^{-2\delta_Rs}\mathcal M(\nu).
}
\tag{15}
$$
This is the reverse comparison supplied by the complete multiplicative
history. No commutation with an arithmetic observation or truncation of
the high-frequency no-jump part is assumed.

## 3. Actual frozen source and a positive RH criterion

For the literal cutoff $N\ge2$, take
$$
\nu_N=-\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n
-\mathbf1_{[1,N]}(x)\,dx.
\tag{16}
$$
Its cumulative function is $\psi(\min(x,N))-\min(x,N)$, and (1) is the
original frozen physical source. Thus
$$
\mathcal M(\nu_N)
=\int_1^N\frac{(\psi(x)-x)^2}{x^2}\,dx
+\frac{(\psi(N)-N)^2}{N}.
\tag{17}
$$
Chebyshev's estimate $\psi(x)\le Cx$ gives the unconditional bound
$$
\mathcal M(\nu_N)\le C_0N.
\tag{18}
$$
Every density cell, the initial atom, the frozen endpoint, and all prime
powers are present.

Choose a fixed clock rate
$$
c\ge\frac1{2\delta_R},\qquad s_N=c\log N.
\tag{19}
$$
Equations (15) and (18) give
$$
\boxed{
\mathcal M_{s_N}(\nu_N)
\le m_R^{-1}\mathcal S_{s_N}(\nu_N)
+C_0N^{1-2c\delta_R}.
}
\tag{20}
$$
The last term is bounded, and tends to zero if the clock inequality is
strict. Conversely, (12) gives
$$
\mathcal S_{s_N}(\nu_N)\le\frac{\pi}{4}\mathcal M_{s_N}(\nu_N).
\tag{21}
$$

The [fixed-clock original-source theorem](actual-short-time-psi-correlation.md#5-small-laplace-parameters-sharpen-the-necessary-quantifiers) proves, for every fixed
positive clock rate, RH is equivalent to
$$
\mathcal M_{c\log N}(\nu_N)=O_\epsilon(N^\epsilon)
\quad\hbox{for every }\epsilon>0.
\tag{22}
$$
Consequently, for any fixed c satisfying (19),
$$
\boxed{
\mathrm{RH}\quad\Longleftrightarrow\quad
\mathcal S_{c\log N}(\nu_N)=O_\epsilon(N^\epsilon)
\ \hbox{for every }\epsilon>0.
}
\tag{23}
$$

This is a positive additive-to-multiplicative criterion for the literal
frozen source. At time zero, the kernel $1/(x+y)$ is the additive
Goldbach kernel. At positive process time, its exact logarithmic kernel
form is applied to the process-evolved weighted source. The common
factor $e^{-2c\log N\,\rho(\xi)}$ retains the complete multiplicative
prime-history law. The criterion does not replace the signed centered
coefficients by an absolute majorant.

## 4. Scope

Equation (8) gives unconditional control of additive energy by the
original source norm. Equation (15) shows that prime-history evolution
recovers the missing reverse direction, apart from an explicitly damped
initial energy. This is a global comparison between the two exact
positive forms.

The remaining estimate in (23) is still RH-strength. Positivity of either
quadratic form does not make its actual cutoff growth subpower. The value
of the transfer is that an unconditional bound may now be sought directly
on the evolved additive pair form (11), with the multiplicative process
already incorporated and the discarded high-frequency term quantified.

## Dependencies, attribution and formal scope

The [complete prime-history law](positive-successor-seed-jump-process.md) supplies its finite positive Lévy density and Fourier multiplier. The reverse comparison uses its positive damping away from zero frequency. The RH implication in (23) uses the separately proved [small-Laplace-parameter and Abel reconstruction](actual-short-time-psi-correlation.md): it retains the original frozen-source endpoint and needs no first age moment. That dependency is a written proof, not a new assumption or a consequence of positivity alone. Fourier positivity, the exponential and hyperbolic-secant transforms, and the [gamma reflection identity](https://dlmf.nist.gov/5.5#E3) are classical. The two evolved norm comparisons and their RH consumer here have no Lean formalization.
