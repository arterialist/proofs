# Integer quadrature and the Mellin kernel of the actual Abel feedback

This gives a second proof of the pole mechanism for the completed arithmetic feedback $E(r)$ from [the direct floor-kernel transform](successor-feedback-tail-Abel-poles.md). It controls the entire integer-shift quadrature by Chebyshev's bound and retains the collective lower-boundary correction. The required boundary sign remains unproved. Related weighted-prime sign criteria and the classical positive-Laplace argument appear in [Suzuki, Sections 1.1 and 2.4](https://link.springer.com/article/10.1007/s11139-025-01238-9); those weights differ from the actual kernel derived here.

## 1. Continuous shifts and the exact lower boundary

Use the birth masses $q_j(y)$ and $d_r(y)$ from [the factorial-division construction](actual-Abel-factorial-division-positivity.md). For $u\ge0$ and $y>0$ define
$$
q^0(u,y)=\begin{cases}u^{-1/2}\arcsin\sqrt{u/y},&0<u<y,\\
\pi/(2\sqrt u),&u\ge y,\end{cases}\qquad q^0(0,y)=y^{-1/2}.
\tag{1}
$$
This is half the continuously shifted birth mass when its physical lower boundary is zero. The actual boundary is one. For integers $n\ge2$, the two masses agree when $j<n$, whereas
$$
q_j(n)-q^0(j,n)=-b_j\quad(j\ge n),\qquad
b_j=\frac{\arctan(j^{-1/2})}{\sqrt j}.\tag{2}
$$
Put $r=e^{-t}$, $0<t\le1$. Abel summation of the exact history differences gives
$$d_r(n)=\frac{1-r}{r}\sum_{j\ge0}r^j[q_j(n)-n^{-1/2}].\tag{3}$$
Consequently the complete correction to $E(r)=\sum_n\Lambda(n)d_r(n)$ from (2) is $-C(t)$, where
$$\boxed{C(t)=\frac{1-r}{r}\sum_{j\ge2}r^jb_j\psi(j).}\tag{4}$$
Chebyshev's bound and $b_j\le1/j$ imply $0\le C(t)\le C$ uniformly. PNT further gives $jb_j\to1$, $\psi(j)/j\to1$, and hence $C(t)\to1$ by Abel averaging. The sign consumer below uses only boundedness. Every prime power is present, including the exact lower-boundary term after its return.

Define
$$
k(z)=\int_0^\infty e^{-u}q^0(u,z)\,du-z^{-1/2},\qquad
\mathcal F(A)=\sum_{n\ge2}\Lambda(n)A^{-1/2}k(n/A).\tag{5}
$$
Homogeneity $q^0(cu,cy)=c^{-1/2}q^0(u,y)$ identifies $A^{-1/2}k(n/A)$, for $A=1/t$, with
$$t\int_0^\infty e^{-tu}[q^0(u,n)-n^{-1/2}]\,du.$$
We prove
$$\boxed{E(e^{-t})=\mathcal F(1/t)-C(t)+O(\sqrt t),\qquad0<t\le1.}\tag{6}$$
Thus the actual feedback differs from the continuous source by a bounded term tending to $-1$.

## 2. Complete variation bound for integer quadrature

Write $U(u,n)=q^0(u,n)-n^{-1/2}$. Chebyshev partial summation gives
$$\sum_n\Lambda(n)|U(u,n)|\le C\sqrt u\quad(u>0).\tag{7}$$
For $u\ge1$, split at $n=2u$. On the first part use $|U|\le C/\sqrt n$, and on the second use $|U|\le Cu/n^{3/2}$. For $u<1$ the latter estimate alone is $O(u)\le O(\sqrt u)$.

The function $q^0$ is continuous and locally absolutely continuous in $u$. Its derivative singularity at $u=n$ is integrable. It increases on $(0,n)$ and decreases on $(n,\infty)$. For $u\le n/2$ its derivative is bounded by $Cn^{-3/2}$, its total increase is $O(n^{-1/2})$, and for $u>n$ its absolute derivative is $\pi/(4u^{3/2})$. Therefore
$$
\sum_n\Lambda(n)\int_0^\infty e^{-tu}|\partial_uq^0(u,n)|\,du
\le Ct^{-1/2}.\tag{8}
$$
The increasing part up to $n/2$ is bounded by $\sum_n\Lambda(n)n^{-3/2}\min(n,1/t)$, which is $O(t^{-1/2})$. Its remaining part is bounded by $C\sum_n\Lambda(n)e^{-tn/2}/\sqrt n$. The decreasing part is exactly bounded by $(\pi/4)\int_0^\infty e^{-tu}\psi(u)u^{-3/2}du$. Chebyshev bounds both.

The product rule with (7)–(8) now gives
$$\sum_n\Lambda(n)\operatorname{TV}_{u\ge0}[e^{-tu}U(u,n)]\le Ct^{-1/2}.\tag{9}$$
On each unit cell the left-endpoint quadrature error of an absolutely continuous function is bounded by its variation on that cell. Sum over every cell and every prime power:
$$
t\sum_n\Lambda(n)\left|\sum_{j\ge0}e^{-tj}U(j,n)
-\int_0^\infty e^{-tu}U(u,n)\,du\right|\le C\sqrt t.\tag{10}
$$
By (7) the absolute continuous sum, after multiplication by $t$, is at most $Ct^{-1/2}$. Since $(1-r)/(rt)=1+O(t)$, replacing the coefficient $t$ by $(1-r)/r$ costs another $O(\sqrt t)$. Equations (2)–(4) prove (6). Subtracting $n^{-1/2}$ before quadrature is essential; separate unsubtracted sums diverge.

## 3. Exact Mellin multiplier and one-sided transform

At zero, $k(z)=-z^{-1/2}+O(1)$. At infinity the arcsine expansion and the exponential $u$ tail give
$$k(z)=\frac1{6z^{3/2}}+O(z^{-5/2}).\tag{11}$$
The Mellin transform thus converges absolutely on $1/2<\Re s<3/2$. At fixed $u$, integration by parts in $z$, using
$$\partial_zq^0(u,z)=-\frac{\mathbf1_{z>u}}{2z\sqrt{z-u}},$$
gives
$$
\int_0^\infty z^{s-1}[q^0(u,z)-z^{-1/2}]\,dz
=\frac{\sqrt\pi\Gamma(1/2-s)}{2s\Gamma(1-s)}u^{s-1/2}.\tag{12}
$$
Both endpoint products vanish on this strip. The convergent difference of derivative integrals is the continuation of $\mathrm B(1/2,1/2-s)/(2s)$. At $s=1$ its value is zero, not a pole. Scaling and the endpoint bounds justify Fubini on the original subtracted integrals. Integrating (12) against $e^{-u}$ and using the [gamma reflection identity](https://dlmf.nist.gov/5.5.E3) yields
$$
\boxed{M_k(s)=\int_0^\infty k(z)z^{s-1}\,dz
=\frac{\sqrt\pi\Gamma(s)\tan(\pi s)}{2s},\quad1/2<\Re s<3/2.}\tag{13}
$$
Its zero at $s=1$ cancels the density pole. It is nonzero at every nonreal zeta zero with real part greater than $1/2$, since gamma has no zeros and the zeros of $\tan(\pi s)$ are real integers.

For an exact one-sided transform, absolute Fubini first gives, on $1<\Re s<3/2$,
$$
\int_1^\infty\mathcal F(A)A^{-(s-1/2)}\frac{dA}{A}
=-\frac{\zeta'(s)}{\zeta(s)}M_k(s)-J(s),
$$
$$J(s)=\sum_{n\ge2}\Lambda(n)n^{-s}\int_n^\infty k(u)u^{s-1}\,du.\tag{14}$$
By (11), $J$ is holomorphic for $\Re s<3/2$. On compact subsets each term and its complex derivatives are bounded by $C\Lambda(n)n^{-3/2}$ times a fixed power of $\log n$, a summable series. This proves continuation across the real interval $(1/2,3/2)$ with the $s=1$ singularity canceled. Equivalently, the lower-$A$ part of a full Mellin transform is harmless because $k(n/A)=O((A/n)^{3/2})$ for $0<A<1$.

## 4. The scalar sign consumer and the actual bias correction

Set $e(v)=E(e^{-e^{-v}})$ for $v\ge0$. Equations (6)–(7) give $|e(v)|\le Ce^{v/2}$, and $e(v)-\mathcal F(e^v)$ is bounded. Its Laplace transform therefore has continuation
$$
-\frac{\zeta'(z+1/2)}{\zeta(z+1/2)}M_k(z+1/2)
-J(z+1/2)+H(z),\qquad0<\Re z<1,\tag{15}
$$
where $H$ is holomorphic on $\Re z>0$. The expression has no positive real singularity. At $z=\rho-1/2$, $\Re\rho>1/2$, it has residue $-m_\rho M_k(\rho)\ne0$, with every multiplicity retained.

If $E(r)$ has either weak sign throughout a final interval below one, remove the compact initial part of $e$ and apply the classical positive-Laplace abscissa theorem. Its convergence abscissa is at most $1/2$. A positive abscissa would force a positive real singularity, contrary to (15). The actual transform is therefore holomorphic on $\Re z>0$, contradicting every off-critical pole. Zero symmetry proves RH. This requires an interval of parameters, not favorable values along a sequence.

The proof uses only the bounded correction $C(t)=O(1)$, Chebyshev and classical zeta continuation. PNT is needed only for the stronger normalization $C(t)\to1$. The [direct floor-kernel proof](successor-feedback-tail-Abel-poles.md) gives the same pole multiplier $M(z)$ with
$$M(z)/(z+1/2)=M_k(z+1/2).$$
That identity follows from gamma reflection. The present proof keeps a different useful mechanism: complete integer quadrature and its collective causal-boundary correction.

At $s=1/2$, $M_k$ has residue $-1$. The candidate real constant from that point is $\zeta'(1/2)/\zeta(1/2)$. The actual correction $C(t)\to1$ changes it to $\zeta'(1/2)/\zeta(1/2)-1$. A residue alone does not establish a pointwise limit. The separate [conditional converse](successor-feedback-RH-converse.md) retains all critical-zero oscillations and proves the RH calibration and positive eventual margin. The unconditional boundary sign remains open. This chapter is a written proof, not a Lean formalization of the arithmetic transform, and makes no priority claim for the classical Mellin or Landau arguments.
