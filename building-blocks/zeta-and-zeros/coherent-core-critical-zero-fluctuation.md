# Critical-zero fluctuations of the actual coherent core

This is an unconditional written consequence of the complete prime-power
source, the exact Mellin multiplier, and the classical positive-Laplace
theorem. It bounds fluctuations around the core's real transform residue; it gives no
positive lower bound for the core and no proof of RH. Lean formalization
remains open.

Use the kernel \(K=k\) of the [continuous-shift Mellin calculation](actual-Abel-feedback-Mellin-kernel.md)
and the actual core
\[
 Q(t)=\sqrt t\sum_{n\ge2}\Lambda(n)K(tn),\qquad 0<t\le1.
\]
Set \(q(v)=Q(e^{-v})\) for \(v\ge0\), and let
\[
 a_0=\frac{\zeta'(1/2)}{\zeta(1/2)},\qquad
 M_K(s)=\frac{\sqrt\pi\,\Gamma(s)\tan(\pi s)}{2s}.
\]
The value \(a_0\) is finite and real. For any critical-line zero
\(\rho=1/2+i\gamma\) of multiplicity \(m_\rho\), put
\(d_\rho=m_\rho|M_K(\rho)|>0\).

**Theorem.** Every such zero gives
\[
 \boxed{\quad
 \limsup_{v\to\infty}q(v)\ge a_0+d_\rho,
 \qquad
 \liminf_{v\to\infty}q(v)\le a_0-d_\rho.
 \quad}                                                     \tag{1}
\]
In addition, with \(E(T)=\int_0^T|q(v)-a_0|^2\,dv\),
\[
 \boxed{\quad\limsup_{T\to\infty}\frac{E(T)}T\ge
 \sum_{\substack{\rho:\,\Re\rho=1/2}}m_\rho^2|M_K(\rho)|^2>0.\quad}
                                                               \tag{2}
\]
The sum runs over distinct critical-line zeros, includes both signs of
each ordinate, and may be read in the extended-real sense. Its
positivity needs only one critical-line zero.
By [Hardy's critical-line theorem](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014),
these are unconditional constraints on the actual \(Q\). The statements
allow infinite limsup or liminf. The estimate does not place
\(a_0-d_\rho\) below zero, so (1) does not assert a sign change of
\(Q\).

**Proof.** The complete one-sided Mellin identity in the linked kernel
calculation, with \(s=z+1/2\), reads initially on \(1/2<\Re z<1\)
\[
 \widehat q(z)=\int_0^\infty q(v)e^{-zv}\,dv
 =-\frac{\zeta'(s)}{\zeta(s)}M_K(s)-J(s),                 \tag{3}
\]
where \(J\) is holomorphic for \(\Re s<3/2\). Chebyshev's bound gives
\(q(v)=O(e^{v/2})\), so the defining integral is valid for
\(\Re z>1/2\). The right side continues meromorphically through
\(0<\Re z<1\). It is regular on the positive real interval
\((0,1/2]\): zeta has no real zero on \((1/2,1)\), and the zero of
\(M_K\) at \(s=1\) cancels the zeta pole. The same formula continues
locally to the boundary points \(z=0\) and \(z=i\gamma\), with residues
\[
 \operatorname{Res}_{z=0}\widehat q(z)=a_0,
 \qquad
 \operatorname{Res}_{z=i\gamma}\widehat q(z)
       =-m_\rho M_K(\rho).                              \tag{4}
\]
Indeed \(M_K(1/2+z)=-z^{-1}+O(1)\); at \(\rho\), the gamma
factor has no zero and \(\tan(\pi\rho)\ne0\). The second residue is
nonzero even if the zeta zero has multiplicity greater than one, because
the logarithmic derivative always has a simple pole of residue
\(-m_\rho\).

Suppose \(q(v)\le C\) for all \(v\ge V\). Then
\(h_C(v)=(C-q(v))\mathbf1_{[V,\infty)}(v)\ge0\) has a Laplace transform
whose abscissa is at most \(1/2\) by Chebyshev. Equation (4) forces
that abscissa to be at least zero. If it were positive,
[Landau's positive-Mellin theorem](https://arxiv.org/html/2411.07436#S2.SS4)
would force a singularity at the positive real abscissa. Yet (3) gives
the continuation
\[
 \widehat h_C(z)=\frac{Ce^{-Vz}}z-\widehat q(z)
                 +\int_0^V q(v)e^{-zv}\,dv,             \tag{5}
\]
which is regular at every positive real \(z\le1/2\). Thus the
abscissa is zero and (5) is the convergent transform for \(\Re z>0\).
Positivity now gives
\(|\widehat h_C(\varepsilon+i\gamma)|
 \le\widehat h_C(\varepsilon)\). Multiply by \(\varepsilon\) and
use (4). The left limit is \(d_\rho\), while the right limit is
\(C-a_0\). Hence every eventual upper bound satisfies
\(C\ge a_0+d_\rho\). Applying the same argument to
\((q-C)\mathbf1_{[V,\infty)}\) shows that every eventual lower bound
\(C\) satisfies \(C\le a_0-d_\rho\). This proves (1).

For (2), suppose its left side is finite; otherwise there is nothing
to prove. Then \(E(T)=O(T)\), so \(q-a_0\) has an absolutely convergent
Laplace transform for every \(\Re z>0\) by Cauchy--Schwarz with an
exponential weight. Fix finitely many distinct critical ordinates
\(\gamma_1,\ldots,\gamma_N\), with residues
\(r_j=-m_jM_K(1/2+i\gamma_j)\). In the probability measure
\(\varepsilon e^{-\varepsilon v}dv\), the functions
\(\phi_j(v)=e^{i\gamma_jv}\) have Gram matrix
\[
 G_{jk}(\varepsilon)
 =\frac{\varepsilon}{\varepsilon-i(\gamma_j-\gamma_k)}
 \longrightarrow\delta_{jk}.
\]
Their inner products with \(q-a_0\) are
\(c_j(\varepsilon)=\varepsilon\int_0^\infty
(q(v)-a_0)e^{-(\varepsilon+i\gamma_j)v}dv\to r_j\)
by (4). The finite-dimensional projection inequality, followed by
\(G(\varepsilon)^{-1}\to I\), gives
\[
 \liminf_{\varepsilon\downarrow0}
 \varepsilon\int_0^\infty|q(v)-a_0|^2e^{-\varepsilon v}dv
 \ge\sum_{j=1}^N|r_j|^2.                            \tag{6}
\]
If \(L=\limsup E(T)/T<\infty\), Stieltjes integration by parts gives
\[
 \varepsilon\int_0^\infty e^{-\varepsilon v}dE(v)
 =\varepsilon^2\int_0^\infty e^{-\varepsilon T}E(T)dT
 \le L+o(1).
\]
Equation (6) forces \(L\ge\sum_{j=1}^N|r_j|^2\). Taking the
supremum over all finite subsets proves (2). \(\square\)

The constant \(a_0\) is the real residue of the meromorphically continued
core transform; an unconditional Abel mean at the boundary is not asserted.
The exact geometric feedback has its additional
integer lower-boundary correction \(C(t)\to1\); no correction was
dropped or folded into \(Q\) here. This theorem rules out a finite limit
for the actual coherent core and rules out a vanishing
logarithmic mean-square fluctuation. It does not decide the whole-interval
sign criterion for the original feedback. The existing
[RH-conditional zero-series expansion](../successor-and-division/successor-feedback-RH-converse.md)
gives a stronger full-spectrum variance once RH is assumed; the bounds
above require no such assumption.
