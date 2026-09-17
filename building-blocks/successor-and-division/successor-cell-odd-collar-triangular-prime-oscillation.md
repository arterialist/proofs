# An exact odd successor-cell collar and its signed prime fluctuation

RH Agent3, 17 September 2026. The complete successor-cell Weil matrix has an
explicit boundary vector whose prime row is one triangularly weighted actual
von Mangoldt sum. For this vector the continuum prime main term cancels the
large pole exactly, and the first cross-gamma term cancels the small pole
exactly. The remaining centered prime row has unconditional excursions of
both signs, bounded away from zero along the **integer** successor cutoffs.
This constrains any proposed one-sided payment of the row; it does not sign
the full Weil form or prove RH. It is the box-profile, exact-cell counterpart
of the [smooth odd packet analysis](../weil-and-spectral/suzuki-odd-continuum-green-and-moving-prime-residual.md).

## Exact full-form row

Let \(m\ge3\), \(X=2m\), \(N=X-1\), \(a=\frac12\log X\), and
\(h=\log2\). Use the cells \(I_n=(a-\log(n+1),a-\log n]\) of the
[complete successor-cell form](../weil-and-spectral/compact-weil-successor-cell-refinement.md).
The right collar is \(I_1=(a-h,a]\), while the left collar is exactly
\(\bigcup_{r=m}^{2m-1}I_r=(-a,-a+h]\). Therefore the odd function
\[
 f_m(v)=\frac1{\sqrt2}\mathbf1_{(a-h,a]}(v)
       -\frac1{\sqrt2}\mathbf1_{(-a,-a+h]}(v)                 \tag{1}
\]
belongs to the actual finite space \(S_{2m-1}\), with physical cell
values \(b_1=1/\sqrt2\), \(b_m=\cdots=b_{2m-1}=-1/\sqrt2\), and all
other values zero. Its \(L^2\) norm squared is \(h\). Both endpoints
are exact cell endpoints; no partial cell is being suppressed.

Put \(W(u)=u\) for \(0\le u\le h\), \(W(u)=2h-u\) for
\(h\le u\le2h\), and \(W(u)=0\) otherwise. Equivalently,
\(W=\mathbf1_{(0,h)}*\mathbf1_{(0,h)}\). The contribution of the
prime-power portion to the full Weil form (both orientations included) is
\[
 \begin{aligned}
 P_X&=\sum_{X/4<d<X}\frac{\Lambda(d)}{\sqrt d}
                 W\!\left(\log\frac Xd\right)\\
 &=\sum_{m/2<d<m}\frac{\Lambda(d)}{\sqrt d}
                   \log\frac{2d}{m}
   +\sum_{m\le d<2m}\frac{\Lambda(d)}{\sqrt d}
                   \log\frac{2m}{d}.                         \tag{2}
 \end{aligned}
\]
Here \(d\) ranges over **all integers**, with \(\Lambda(d)\) retaining
every prime power. To see (2) directly in the floor-division matrix,
a nonzero child-parent product requires
\(m\le r\le2m-1\) and \(\lfloor r/d\rfloor=1\). Its cell lengths sum to
\[
 \sum_{r=\max(m,d)}^{\min(2m-1,2d-1)}\ell_r
 =\begin{cases}
   \log(2d/m),&m/2<d<m,\\
   \log(2m/d),&m\le d<2m,\\
   0,&\text{otherwise}.
  \end{cases}                                                   \tag{3}
\]
Each nonzero cell product is \(-1/2\); the factor two for the two
prime orientations makes the compressed prime operator's quadratic
value \(-P_X\), hence the Weil form contains \(+P_X\). There are no
same-collar prime overlaps: its width is \(\log2\), the smallest
positive prime-power translation.

Define
\[
 I_-=\int_0^h e^{-s/2}ds=2(1-2^{-1/2}),\qquad
 I_+=\int_0^h e^{s/2}ds=2(\sqrt2-1).                     \tag{4}
\]
The pole moments of (1) satisfy \(E_-=-E_+\), and their *complete*
quadratic contribution is
\[
 2E_+E_-=-\sqrt X I_-^2+2I_-I_+-X^{-1/2}I_+^2.       \tag{5}
\]
Its leading coefficient is \(I_-^2=6-4\sqrt2\). For \(X>4\), the full continuous-density
replacement of (2), including its lower endpoint, is precisely
\[
 \int_1^\infty x^{-1/2}W(\log(X/x))dx
 =\sqrt X\int_0^{2h}e^{-u/2}W(u)du
 =\sqrt X I_-^2.                                         \tag{6}
\]

Write \(H(\xi)=\Re\psi(1/4+i\xi/2)-\log\pi\),
\(H_0=\psi(1/4)-\log\pi\), and \(\alpha_k=k+1/4\). The self part of
the full gamma quadratic (two collars, each of amplitude \(1/\sqrt2\))
is the fixed finite constant
\[
 A_h=hH_0+\frac12\sum_{k=0}^\infty
       \frac{1-2^{-2\alpha_k}}{\alpha_k^2}.              \tag{7}
\]
Indeed the digamma integral and Plancherel give, for a single interval
of length \(h\),
\[
 hH_0+\int_0^\infty\frac{e^{-t/4}}{1-e^{-t}}
                       \min(h,t/2)dt=A_h;
\]
the series in (7) follows by expanding \((1-e^{-t})^{-1}\). The
discontinuities cause no domain problem: the Fourier transform of
each collar is \(O((1+|\xi|)^{-1})\), and \(H(\xi)=O(\log(2+|\xi|))\).

The cross-gamma part is
\[
 J_a=\int_0^h\!\int_0^h
 \frac{e^{-(2a-s-t)/2}}{1-e^{-2(2a-s-t)}}\,ds\,dt.
\]
Expanding its denominator shows that its first term is exactly
\(X^{-1/2}I_+^2\), the negative final term in (5). The rest is
strictly positive:
\[
 R_X:=J_a-X^{-1/2}I_+^2
 =\sum_{k=1}^\infty X^{-2k-1/2}
       \left(\int_0^h e^{(2k+1/2)s}ds\right)^2
 >0,\qquad R_X=O(X^{-5/2}).                             \tag{8}
\]
The estimate is as \(X\to\infty\); the series converges for every
\(X>4\). The cross-gamma kernel and normalization follow from the
same [complete Weil form](https://arxiv.org/html/2606.09096v2) as the
successor-cell matrix.

Combining (2), (5), and (7)--(8) yields the exact scalar identity
\[
 \boxed{\quad Q_a(f_m)=C_h+D_X+R_X,\qquad
 C_h=A_h+2I_-I_+,\qquad
 D_X=P_X-(6-4\sqrt2)\sqrt X.\quad}                    \tag{9}
\]
Every pole and gamma component, both prime orientations, all admitted
prime powers, and both boundary collars occur in (9). In particular,
the apparently useful nonnegative graph-cut part alone cannot sign
\(D_X\): here the prime row itself is positive, while its continuum
main term is paid by a **negative** odd pole.

There is also a direct actual-source expression. Put
\(E(x)=\psi(x)-x\), with \(\psi\) right-continuous. Stieltjes
integration by parts has no leftover endpoint or midpoint atom,
because the triangular weight is continuous and vanishes at
\(X/4\) and \(X\). It gives
\[
 \begin{aligned}
 D_X={}&\int_{X/2}^{X} \frac{E(x)}{x^{3/2}}
           \left(1+\frac12\log\frac Xx\right)dx\\
       &+\int_{X/4}^{X/2}\frac{E(x)}{x^{3/2}}
           \left(-1+\frac12\log\frac{4x}{X}\right)dx.
 \end{aligned}                                                 \tag{9a}
\]
The upper-band kernel is strictly positive and the lower-band
kernel strictly negative, since \(h/2<1\). Equation (9a) retains
the actual complete Chebyshev error, including all prime powers,
and shows exactly which adjacent bands must cancel at critical scale.

## The actual centered row changes sign at integer cutoffs

Extend \(D_X\) algebraically to real \(X>0\) by (2), with the same
\(W\), and put \(D(a)=D_{e^{2a}}\) for \(a\ge0\). For small \(a\)
the subtracted term is simply the algebraic \(e^aI_-^2\); its
interpretation as the integral in (6) begins at \(X>4\). Let
\[
 F(z)=\int_0^h e^{-zs/2}ds
     =\frac{2(1-2^{-z/2})}{z},\qquad F(0)=h.              \tag{10}
\]
Finite-support convolution and the absolutely convergent complete
von Mangoldt Dirichlet series give, for \(\Re z>1\),
\[
 \boxed{\quad
 \int_0^\infty D(a)e^{-za}da
 =\frac12F(z)^2\left(-\frac{\zeta'}\zeta\right)
                    \!\left(\frac{z+1}{2}\right)
       -\frac{F(1)^2}{z-1}.\quad}                         \tag{11}
\]
At \(z=1\) the two pole residues cancel. The right side has no
singularity at any positive real \(z\), since \(\zeta(s)\) has no
real zeros for \(s>1/2\); it is regular at \(z=0\) as well.
At a critical zero \(\rho=1/2+i\gamma\) of multiplicity \(r\),
it has residue \(-rF(2i\gamma)^2\) at \(z=2i\gamma\), provided
\(\gamma h\notin2\pi\mathbb Z\). The rigorously located first
critical zero has \(14<\gamma_1<15\); this interval is disjoint
from the resonance lattice \(2\pi\mathbb Z/h\). See
[Johansson's rigorous zero computation](https://arxiv.org/pdf/1309.2877)
and the [first-zero description](https://arxiv.org/abs/math/0112196).
Set
\[
 A_1=r_1|F(2i\gamma_1)|^2
    =\frac{4r_1\sin^2(\gamma_1h/2)}{\gamma_1^2}>0.     \tag{12}
\]

The positive-Laplace argument gives the unconditional result
\[
 \boxed{\quad
 \limsup_{m\to\infty}D_{2m}\ge A_1,
 \qquad \liminf_{m\to\infty}D_{2m}\le-A_1.\quad}         \tag{13}
\]
Here are the analytic and sampling details. Chebyshev's bound gives
\(D(a)=O(e^a)\). If \(D(a)\le C\) eventually, the nonnegative
function \(C-D(a)\) on a late half-line has a Laplace transform of
finite abscissa \(c\le1\). Its nonreal pole at \(2i\gamma_1\)
forces \(c\ge0\). If \(c>0\), the positive-Laplace Landau theorem
would force a real singularity at \(c\), contrary to (11). Thus
\(c=0\). The modulus of its transform at \(\epsilon+2i\gamma_1\)
is at most its transform at \(\epsilon>0\). Multiplying by
\(\epsilon\) and letting \(\epsilon\downarrow0\) gives
\(A_1\le C\), because (11) is regular at zero. This proves the
limsup assertion; apply the same argument to \(-D\) for the liminf.
The initial finite interval merely contributes an entire transform.
This is the same classical argument used for the
[smooth odd packet](../weil-and-spectral/suzuki-odd-continuum-green-and-moving-prime-residual.md),
but (10) requires no hypothetical zero-detecting smooth profile.

For comparable \(X,Y\ge6\) with \(|X-Y|\le2\), the triangle \(W\)
is globally one-Lipschitz and Chebyshev's bound yields
\[
 |P_X-P_Y|
 \le |\log(X/Y)|
       \sum_{\min(X,Y)/4\le d\le\max(X,Y)}
                    \frac{\Lambda(d)}{\sqrt d}
 \ll |X-Y|/\sqrt X.
\]
The same estimate holds for the difference of the density main
terms. Thus \(|D_X-D_Y|\ll X^{-1/2}\) at the nearest even integer,
and the continuous-\(a\) excursions pass to precisely the odd
successor cutoffs \(N=2m-1\), proving (13).

Equation (13) rules out a universal eventual sign for the *centered*
prime row in (9), even though its uncentered prime sum \(P_X\) is
nonnegative. It does not say that \(Q_a(f_m)\) changes sign: the fixed
archimedean and pole constant \(C_h\) remains. Any RH-strength lower
comparison for this scalar row must pay the signed \(D_X\) rather than
discarding it. The child support and piecewise logarithmic overlap
weights in (3) are formalized in
[SuccessorCellTransferFinite.lean](../../formalization/BuildingBlocks/SuccessorCellTransferFinite.lean).
The full Weil row, analytic oscillation, and RH implications remain
written mathematics, not Lean formalizations or an RH proof.
