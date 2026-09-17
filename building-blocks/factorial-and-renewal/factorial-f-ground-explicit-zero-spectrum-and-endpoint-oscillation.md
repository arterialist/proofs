# Explicit zero spectrum and endpoint oscillation of the full factorial-ground score

2026-09-16. **Status:** an explicit-formula consequence for the actual von Mangoldt source. It proves no unconditional RH-scale upper bound and no new zero-free region. The full original ground is retained in the score; only its linear part is expanded over zeta zeros.

Let \(E(x)=\psi(x)-x\), let \(F\) be the actual continuous factorial ground with \(F(x)\to\kappa_F=1+\gamma_{\rm E}>0\), and put \(e(u)=E(e^u)e^{-u}\), \(H(t)=t^2e^{-t}\mathbf1_{t\ge0}\), \(K=H-H'=2t(t-1)e^{-t}\mathbf1_{t\ge0}\), and \(L=\log2\). For \(Y>1\), define
\[
G_F(Y)=\int_{[Y,\infty)}\frac{H(\log(x/Y))}{xF(x)}\,dE(x),
\qquad J_F(Y)=G_F(Y)-G_F(2Y).                         \tag{1}
\]
All prime-power atoms, the density \(-dx\), and the atom at \(2Y\) in the old-base term are included. Define \(G_\kappa,J_\kappa\) by replacing \(F(x)\) in (1) with the constant \(\kappa_F\), and write \(N_F(Y)=J_F(Y)-J_\kappa(Y)\).

**Exact spectral formula.** For every \(Y>1\), with nontrivial zeros counted with multiplicity,
\[
\boxed{\begin{aligned}
J_F(Y)={}&-\frac2{\kappa_F}\sum_\rho
 \frac{(1-2^{\rho-1})Y^{\rho-1}}{(2-\rho)^3}\\
&-\frac1{4\kappa_F}\sum_{k\ge1}
 \frac{(1-2^{-(2k+1)})Y^{-(2k+1)}}{(k+1)^3}
 +N_F(Y).                                               \tag{2}
\end{aligned}}
\]
Both displayed series converge absolutely for each \(Y>1\), and the zero series converges uniformly for \(Y\ge Y_0>1\) after each summand is bounded by \(Y^{\Re\rho-1}\le1\). The exact nonlinear remainder is
\[
N_F(Y)=\Delta_L\left\{T_K\!\left[e(F^{-1}-\kappa_F^{-1})\right]
                -T_H\!\left[e^2/F^2\right]\right\}(\log Y),
\quad T_Aq(u)=\int_0^\infty A(t)q(u+t)dt,
\quad \Delta_Lq(u)=q(u)-q(u+L).                          \tag{3}
\]
Consequently, on a sufficiently late tail where \(F\) is bounded away from zero,
\[
|N_F(Y)|\ll
\left(\sup_{x\ge Y}\frac{|E(x)|}{x}\right)
\left(\sup_{x\ge Y}|F(x)-\kappa_F|\right)
+\left(\sup_{x\ge Y}\frac{|E(x)|}{x}\right)^2.          \tag{4}
\]

To prove (2), put \(f(t)=t^{-2}\log^2t\,\mathbf1_{t\ge1}\). Its Mellin transform is \(\int_0^\infty f(t)t^{z-1}dt=2/(2-z)^3\) for \(\Re z<2\), and \(f(1)=f'(1)=0\). The frozen test weight is \(P_Y(x)=Y^{-1}f(x/Y)\). For any fixed \(1<c<2\), Mellin inversion and the absolutely convergent Dirichlet series for \(-\zeta'/\zeta\) give
\[
G_\kappa(Y)=\frac1{2\pi i\kappa_F}
 \int_{c-i\infty}^{c+i\infty}
 \frac{2Y^{z-1}}{(2-z)^3}\left(-\frac{\zeta'(z)}{\zeta(z)}\right)dz
 -\frac2{\kappa_F}.                                    \tag{5}
\]
The final constant is exactly the continuous density integral
\(\kappa_F^{-1}\int_Y^\infty P_Y(x)dx=2/\kappa_F\).
Shift the contour left through the pole at \(z=1\), all nontrivial zeros, and the trivial zeros \(z=-2k\). The pole at \(1\) contributes \(2/\kappa_F\), canceling the density term. A zero of multiplicity \(m\) gives residue \(-2mY^{\rho-1}/[\kappa_F(2-\rho)^3]\); a trivial zero at \(-2k\) gives \(-Y^{-(2k+1)}/[4\kappa_F(k+1)^3]\). There is no pole at \(z=0\). The Mellin kernel is \(O(|\Im z|^{-3})\) on fixed vertical strips. Standard zero-avoiding horizontal contours, followed by vertical lines \(\Re z=-(2M+1)\) and \(M\to\infty\), make the remaining integrals vanish for \(Y>1\). Thus
\[
G_\kappa(Y)
=-\frac2{\kappa_F}\sum_\rho\frac{Y^{\rho-1}}{(2-\rho)^3}
 -\frac1{4\kappa_F}\sum_{k\ge1}
      \frac{Y^{-(2k+1)}}{(k+1)^3}.                       \tag{6}
\]
The zero count \(N(T)=O(T\log T)\) makes this zero series absolutely convergent because each term is \(O((1+|\Im\rho|)^{-3})\). Mellin inversion at the cutoff is unambiguous since \(f(1)=0\): an atom at \(x=Y\) has zero coefficient, while the old-base atom at \(x=2Y\) survives subtraction. The \(-\log(2\pi)\) constant in the pointwise explicit formula has zero Stieltjes derivative and produces no separate term. Subtracting (6) at \(2Y\) proves (2). Formula (3) follows by exact Stieltjes integration by parts in (1), and (4) follows from \(H,K\in L^1\).

**What RH would imply at the endpoint.** Under RH, the standard \(E(x)=O(x^{1/2}\log^2x)\) estimate and \(F(x)-\kappa_F=\int_x^\infty E(t)t^{-2}dt\) make \(N_F(Y)=O(Y^{-1}\log^4Y)\). Let \(\Gamma_+\) be the distinct positive ordinates of critical-line zeros, and let \(m_\gamma\) be the multiplicity at \(\rho_\gamma=1/2+i\gamma\). Put
\[
c_\gamma=-\frac{2m_\gamma}{\kappa_F}
 \frac{1-2^{-1/2+i\gamma L}}{(3/2-i\gamma)^3},
\qquad
Q(u)=\sum_{\gamma\in\Gamma_+}
 \bigl(c_\gamma e^{i\gamma u}+\overline{c_\gamma}e^{-i\gamma u}\bigr). \tag{7}
\]
The series is absolutely and uniformly convergent. It defines a real, nonzero, uniformly almost periodic function with Bohr mean zero, and (2) yields the uniform asymptotic
\[
\boxed{\sqrt Y\,J_F(Y)=Q(\log Y)+o(1).}            \tag{8}
\]
The exact Bohr mean square is
\[
\boxed{\lim_{T\to\infty}\frac1T\int_0^TQ(u)^2du
=2\sum_{\gamma\in\Gamma_+}|c_\gamma|^2>0.}       \tag{9}
\]
Distinct frequencies have zero cross mean; absolute convergence permits termwise averaging. Since \(\|Q\|_\infty\le B:=2\sum_{\gamma>0}|c_\gamma|<\infty\), its positive and negative Bohr means are equal and each at least \(\bigl(2\sum|c_\gamma|^2\bigr)/(2B)\). Hence, setting \(M_2=2\sum|c_\gamma|^2\),
\[
\limsup_{Y\to\infty}\sqrt Y\,J_F(Y)\ge\frac{M_2}{2B}>0,
\qquad
\liminf_{Y\to\infty}\sqrt Y\,J_F(Y)\le-\frac{M_2}{2B}<0. \tag{10}
\]
In particular RH gives \(J_F(Y)=O(Y^{-1/2})\) without the logarithmic loss of the pointwise \(E\) bound.

**Unconditional dichotomy and diagonal obstruction.** The independently proved [full-score criterion](factorial-f-ground-full-score-rh-criterion.md) says that \(J_F(Y)=O_\epsilon(Y^{-1/2+\epsilon})\) for every \(\epsilon>0\) implies RH. Thus if RH is false, \(\limsup_{Y\to\infty}\sqrt Y|J_F(Y)|=\infty\); if RH is true, (8)--(10) hold. In either case \(J_F(Y)\ne o(Y^{-1/2})\). More quantitatively, choosing any critical zero \(\rho=1/2+i\gamma\) of multiplicity \(m\), the radial Mellin residue in (2) and Abel averaging yield
\[
\limsup_{Y\to\infty}\sqrt Y|J_F(Y)|
\ge \frac{2m|1-2^{\rho-1}|}{\kappa_F|2-\rho|^3}>0. \tag{11}
\]
This is automatic if the left side is infinite; otherwise the full-score criterion gives RH, and the residue calculation applies to (8).

For example, with \(a_n=\Lambda(n)/(nF(n))\), the full future atomic jump-square diagonal satisfies
\[
\sum_{n\ge Y}a_n^2H(\log(n/Y))
\ll\sum_{n\ge Y}\frac{\log^2n}{n^2}
\ll\frac{\log^2(2Y)}Y=o(Y^{-1/2}).                 \tag{12}
\]
Therefore no all-large-\(Y\) inequality bounding \(|J_F(Y)|\) by a fixed multiple of this diagonal can hold for the actual source. This rules out a diagonal-only global energy payment; it does not rule out a signed cross estimate. The zero expansion is a spectral rewriting of the same arithmetic bottleneck. Obtaining a pointwise RH-scale upper bound from it still requires control of zero locations or cancellation of their phases.

The explicit formula and zero count are recorded in [NIST DLMF §25.16](https://dlmf.nist.gov/25.16). Primary historical source for existence of critical-line zeros: [Hardy, *Sur les zéros de la fonction \(\zeta(s)\) de Riemann* (1914)](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences%2C_tome_158%2C_1914.djvu/1014).
