# Goldbach norm duality for the actual scaling kernel and theta ground row

This proof combines the [Mellin–Barnes Goldbach identity](goldbach-multiplicative-spectral-bridge.md), [actual scaling kernel](successor-feedback-kernel-scaling.md), and [prime-state hard wall](prime-state-hard-wall.md). Additive Goldbach coefficients remain additive. Their norm controls a multiplicative Dirichlet transform; they are not the distinct-prime coefficients of the original $V/W$.

## A bounded dual functional, with its exact gamma cancellation

For a finite real sequence a, write
$$
 A(s)=\sum a_n n^{-s},\qquad
 E_a(2c)=\sum_{m,n}\frac{a_ma_n}{(m+n)^{2c}}
 =\frac1{2\pi\Gamma(2c)}\int|\Gamma(c+i\tau)A(c+i\tau)|^2d\tau.
\tag{1}
$$
The equality and nonnegativity hold for every c>0, despite the possibly signed coefficients.

Let K be the full actual scaling kernel from the coherent-core construction. Its Mellin transform on the exact absolute strip 1/2<Re s<3/2 is
$$
 \boxed{\quad
 \mathcal M K(s)=\frac{\pi^{3/2}}{2s\Gamma(1-s)\cos(\pi s)},
 \qquad
 \frac{\mathcal M K(s)}{\Gamma(s)}
       =\frac{\sqrt\pi}{2s}\tan(\pi s).
 \quad}
\tag{2}
$$
At s=1 the expression is interpreted by its removable value zero. To prove (2), use the actual kernel identities
$$
 K'(u)=-b_0(u)/(2u),\qquad
 \mathcal L b_0(p)=-\sqrt\pi\,\frac{p^{1/2}}{1+p}.
$$
For 1/2<Re s<1, Fubini applied to the absolute Mellin integral gives
$$
 \mathcal M b_0(s)=\frac1{\Gamma(1-s)}
       \int_0^\infty p^{-s}\mathcal L b_0(p)dp
 =\frac{\pi^{3/2}}{\Gamma(1-s)\cos\pi s}.
$$
Integration by parts gives $\mathcal M K=\mathcal M b_0/(2s)$. Both sides continue holomorphically throughout the absolute strip, using the actual small- and large-argument kernel expansions. Euler's gamma reflection formula proves the second equality. This calculation retains the zero moment of K.

For 1/2<c<3/2, define
$$
 C_c^2=\frac1{2\pi}\int_{\mathbb R}
       \left|\frac{\mathcal M K(c+i\tau)}{\Gamma(c+i\tau)}\right|^2d\tau.
$$
It is finite, and the explicit estimate
$$
 C_c^2\le\frac{\pi}{8c}\max(1,\tan^2\pi c)
\tag{3}
$$
follows from
$|\tan(x+iy)|^2=(\sin^2x+\sinh^2y)/(\cos^2x+\sinh^2y)$.
Mellin inversion and Cauchy–Schwarz now prove the closed finite-arithmetic lemma
$$
 \boxed{\quad
 \left|\sqrt t\sum_n a_nK(tn)\right|
 \le C_c\,t^{1/2-c}\sqrt{\Gamma(2c)E_a(2c)}.
 \quad}
\tag{4}
$$
The gamma weight does not create an exponentially growing dual norm: it cancels exactly as in (2). For infinite coefficients the same conclusion holds whenever the Dirichlet representation and its norm limit are justified. For the actual coefficients $a_n=\Lambda(n)-1$, all such passages are unconditional for 1<c<3/2 by absolute convergence.

The actual readout is
$$
 Q_{\rm ar}(t)=Q_a(t)+D_1(t),\qquad
 D_1(t)=\sqrt t\sum_{n\ge1}K(tn).
\tag{5}
$$
This identity includes a_1=-1 and the compensating n=1 term in D_1; neither the initial source nor the discrete density is removed. Moreover D_1(t)=O(1) as t decreases to zero. Indeed $\sqrt t\int_0^\infty K(tx)dx=0$, and the error between sum and integral is bounded by
$\sqrt t[\int_0^1|K(tx)|dx+\int_1^\infty t|K'(tx)|dx]$, which is bounded by the exact endpoint expansions.

## An actual mixed-ground-row estimate

For the normalized actual physical ground G_R, set
$$
 I_{G_R}(t)=\int G_R(v)
 [Q_{\rm ar}(te^{|v|})+Q_{\rm ar}(te^{-|v|})]dv,
$$
$$
 L_{G_R,c}=2\int G_R(v)\cosh((c-1/2)v)dv.
$$
Applying (4) at both scales and retaining (5) gives, unconditionally for 1<c<3/2,
$$
 \left|I_{G_R}(t)-\int G_R(v)
 [D_1(te^{|v|})+D_1(te^{-|v|})]dv\right|
 \le C_c t^{1/2-c}L_{G_R,c}
       \sqrt{\Gamma(2c)E_a(2c)}.
\tag{6}
$$
The factor L is bounded uniformly over normalized grounds by a fixed theta moment, using Cauchy–Schwarz in nu. The previously proved exact transfer is
$$
 Q_{\rm W}(G_R,h_t)=I_{G_R}(t)+a_0\int G_R+O_\theta(\sqrt t).
\tag{7}
$$
Consequently (6) is a genuine upper and lower absolute estimate for the specified mixed Weil row, with all deterministic compensation displayed. Its power t^(1/2-c) grows as t decreases, even on the unconditional lines arbitrarily close to c=1. It therefore gives no constant-scale sign interval and no conditional edge-variance estimate.

## Lifting the hard-wall projector without deleting proper powers

The hard-wall theorem gives r(m)=1 on primes and 0≤r(m)≤c_*<1 on composites. The raw projector r(m)^k selects primes, not the von Mangoldt function. Define instead the exact root lift
$$
 \lambda_k(n)=\sum_{\substack{j\ge1,\ m\ge2\\m^j=n}}
                    (\log m)r(m)^k,
 \qquad \lambda_k(1)=0.
\tag{8}
$$
For every n, the prime-base terms are precisely Lambda(n), including all proper prime powers. Thus
$$
 0\le\lambda_k(n)-\Lambda(n)
 \le c_*^k\sum_{m^j=n}\log m.
$$
For c>1 this gives the locally uniform Dirichlet estimate
$$
 \left|\sum_{n\ge1}\frac{\lambda_k(n)-\Lambda(n)}{n^{c+i\tau}}\right|
 \le c_*^kD_c,
 \qquad D_c=\sum_{m\ge2}\frac{\log m}{m^c-1}<\infty.
\tag{9}
$$
Apply the Goldbach norm to $a^{(k)}_n=\lambda_k(n)-1$, so the initial coefficient is still -1. The difference satisfies
$$
 \|A^{(k)}-A\|_{\mathrm{Gold},c}\le2^{-c}c_*^kD_c,
 \qquad
 |\sqrt{E_{a^{(k)}}(2c)}-\sqrt{E_a(2c)}|
 \le2^{-c}c_*^kD_c.
\tag{10}
$$
Here the norm is the weighted vertical norm in (1). The factor 2^(-c) follows by applying the beta identity to m=n=1:
$(2\pi\Gamma(2c))^{-1}\int|\Gamma(c+i\tau)|^2d\tau=2^{-2c}$.
Equations (4) and (10) give an exponentially convergent approximation of the centered scaling readout and of (6), for every fixed unconditional line c>1. This is a quantitative, all-power-preserving composition of the hard-wall projector with the additive Goldbach norm.

There is a precise finite-cutoff version below that line, but its degree is not
uniform. Truncate (8) at $n\le N$, and write
$e_k(n)=\lambda_k(n)-\Lambda(n)$. For every fixed $0<c<1$, positivity and
the root parametrization give
$$
 \sum_{n\le N}\frac{e_k(n)}{n^c}
 \le c_*^k\sum_{2\le m\le N}\log m
       \sum_{1\le j\le \log N/\log m}m^{-jc}
 \le C_c c_*^kN^{1-c}\log N.                 \tag{11}
$$
For $c=1$, the last bound is $C c_*^k\log^2N$. The truncated Goldbach
norm has kernel $(m+n)^{-2c}$. By its feature-space triangle inequality,
$$
 \|e_k1_{[1,N]}\|_{\mathrm{Gold},c}
 \le\sum_{n\le N}e_k(n)(2n)^{-c}
 \le C_c c_*^kN^{1-c}\log N.                 \tag{12}
$$
Thus a sufficient degree for vanishing positive-majorant error at a fixed
$c<1$ is
$$
 k_N>\frac{(1-c)\log N+\log\log N+\omega(1)}{-\log c_*}. \tag{13}
$$
The degree necessarily tends to infinity in this argument. Consequently the
finite projectors do not define one fixed coefficient sequence whose positive
Goldbach norm is uniformly controlled as $N\to\infty$. Any improvement of
(11)--(13) to a fixed-degree or uniformly bounded critical-strip construction
would have to use cancellation unavailable to the positive hard-wall
majorant.

These are norm convergence estimates, not monotonicity of the centered energy. Positive coefficient errors in (9) can have a negative mixed pairing with the centered coefficients in the quadratic form. The separate prime-state allocation boundary in [prime-state allocation](prime-state-projector-boundary.md) also has explicit macroscopic x^2 log x and x^2 terms that require their stated state-$1$, prime and composite compensation. None of those terms is identified with, or absorbed into, the Goldbach norm here.

## The precise boundary that remains

For actual centered coefficients, the meromorphic transform is
$A(s)=-\zeta'(s)/\zeta(s)-\zeta(s)$.
A nontrivial zero rho of multiplicity m gives a pole -m/(s-rho); the gamma factor and the subtraction zeta do not remove it. Thus finiteness of the positive norm in (1) on every line 1/2<c<1 is exactly the RH criterion proved in the imported source. Signed continuation of the additive Dirichlet series is not continuation of this nonnegative norm.

The statement concerns every such line, not merely one line below c=1. Finiteness on a single line, or crossing c=1 by a small amount, does not alone imply RH. Conversely, even assuming finiteness of the meromorphic norm on one new line is not by itself a proof that the original arithmetic scaling readout has the Mellin inversion (4) on that line: shifting its original line must account for any enclosed zero poles, or provide an appropriate arithmetic limit theorem. The unconditional conclusions (4), (6), and (8)–(10) need no such crossing.

The hard-wall bound supplies (9) only for c>1; its positive majorant D_c diverges at and below one. Equations (11)--(13) quantify the resulting cutoff-dependent degree below one. No cancellation estimate for the root-lift contamination in the critical strip has been obtained from the gap c_*. Therefore the construction gives a bounded kernel duality, a complete prime-power projector approximation, and a quantitative actual ground-row bound in the initial domain. It does not supply the RH-equivalent positive-norm continuation or a signed bound for the remaining ground-row average.

## Dependencies and formal scope

Mellin inversion and the integral pairing are classical [Mellin-transform methods](https://dlmf.nist.gov/2.5); the exact gamma cancellation uses [Euler reflection](https://dlmf.nist.gov/5.5#E3). The actual kernel is the one in the [coherent-core observation](coherent-core-positive-observation-inner-history.md). The mixed-ground formula retains the full weak Weil row and is not an identification of physical and theta norms. All analytic norm and root-lift conclusions here are written proofs. [PrimeStateAndRenewalArch.lean](BuildingBlocks/PrimeStateAndRenewalArch.lean) proves the finite projector bound under the stated coordinate hypotheses; it does not yet derive the actual divisor-state hard wall or the analytic root-lift limit.
