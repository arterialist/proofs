# The full Weil matrix on an exact two-collar successor block

The [diagonal ground-state obstruction](successor-cell-ground-state-defect-obstruction.md)
finds a prime Rayleigh quotient of order \(\sqrt X\) on an even boundary
collar, while each same-cell gamma-plus-pole entry is only logarithmic.
The diagonal comparison omits the long-range archimedean and pole
entries. Here their action is computed **exactly** on the two-dimensional
block generating that Rayleigh lower bound. The order-\(\sqrt X\)
prime and pole entries cancel before any estimate is made. This is a
controlled block calculation, not an evaluation on the unknown Perron
eigenvector of the complete prime matrix.

Let \(m\ge3\), \(X=2m\), \(N=X-1\), \(a=\frac12\log X\), and
\(h=\log2\). In the [complete successor-cell space](compact-weil-successor-cell-refinement.md),
put
\[
 R=\mathbf1_{(a-h,a]}=\mathbf1_{I_1},\qquad
 L=\mathbf1_{(-a,-a+h]}=\sum_{r=m}^{2m-1}\mathbf1_{I_r}.
 \tag{1}
\]
The supports are disjoint, \(\|R\|_2^2=\|L\|_2^2=h\), and both
functions use whole, actual successor cells. All matrix entries below
are quadratic-form pairings in the **unnormalized** basis \((R,L)\);
the matrix in the orthonormal basis \((R/\sqrt h,L/\sqrt h)\) is
obtained by dividing every entry by \(h\).

Let \(W=\mathbf1_{(0,h)}*\mathbf1_{(0,h)}\), and define the complete
prime-power row and its centered version by
\[
 \mathcal P_X=\sum_{X/4<d<X}\frac{\Lambda(d)}{\sqrt d}
                 W\!\left(\log\frac Xd\right),\qquad
 D_X=\mathcal P_X-I_-^2\sqrt X,
 \tag{2}
\]
where
\[
 I_-=\int_0^h e^{-s/2}ds=2(1-2^{-1/2}),\qquad
 I_+=\int_0^h e^{s/2}ds=2(\sqrt2-1),\qquad
 I_-^2=6-4\sqrt2.
 \tag{3}
\]
The sum in (2) includes every integer \(d\) with its actual von
Mangoldt weight, hence all admitted prime powers. Define also
\[
 \begin{aligned}
 H_0&=\psi_{\rm dig}(1/4)-\log\pi,\qquad \alpha_k=k+1/4,\\
 A_h&=hH_0+\frac12\sum_{k=0}^{\infty}
                \frac{1-2^{-2\alpha_k}}{\alpha_k^2},\\
 C_h&=A_h+2I_-I_+,\\
 J_a&=\int_0^h\!\int_0^h
       \frac{e^{-(2a-s-t)/2}}{1-e^{-2(2a-s-t)}}\,ds\,dt,\\
 R_X^\gamma&=J_a-X^{-1/2}I_+^2
   =\sum_{k=1}^{\infty}X^{-2k-1/2}
        \left(\int_0^h e^{(2k+1/2)s}ds\right)^2>0.
 \end{aligned}                                                    \tag{4}
\]
The last series converges for every \(X>4\), and
\(R_X^\gamma=O(X^{-5/2})\) as \(X\to\infty\).

**Exact block theorem.** If \(K_N\), \(\Gamma_N\), and \(P_N\) are,
respectively, the complete compressed prime, gamma, and pole forms
in the successor-cell model, their restrictions to \(\operatorname{span}\{R,L\}\)
are
\[
 K_N=\begin{pmatrix}0&\mathcal P_X\\
                         \mathcal P_X&0\end{pmatrix},\qquad
 \Gamma_N=\begin{pmatrix}A_h&-J_a\\-J_a&A_h\end{pmatrix},
 \tag{5}
\]
and
\[
 P_N=\begin{pmatrix}
       2I_-I_+&\sqrt X I_-^2+X^{-1/2}I_+^2\\
       \sqrt X I_-^2+X^{-1/2}I_+^2&2I_-I_+
     \end{pmatrix}.
 \tag{6}
\]
Consequently the **full** Weil form, \(Q_N=\Gamma_N+P_N-K_N\), has
the exact compressed matrix
\[
 \boxed{\quad
 Q_N\big|_{\{R,L\}}=
 \begin{pmatrix}
   C_h&-D_X-R_X^\gamma\\
   -D_X-R_X^\gamma&C_h
 \end{pmatrix}.
 \quad}                                                         \tag{7}
\]
For \(u_+=(R+L)/\sqrt2\) and \(u_-=(R-L)/\sqrt2\), each of squared
norm \(h\), this reads
\[
 Q_N(u_+)=C_h-D_X-R_X^\gamma,\qquad
 Q_N(u_-)=C_h+D_X+R_X^\gamma.
 \tag{8}
\]
The associated orthonormal-block eigenvalues are the two quantities
in (8) divided by \(h\). The odd identity agrees with the
[independent exact collar calculation](successor-cell-odd-collar-triangular-prime-oscillation.md).
Thus this block is positive semidefinite exactly when
\(\lvert D_X+R_X^\gamma\rvert\le C_h\). The threshold is strictly
positive: the first five summands in the series for \(A_h\), together
with \(hH_0+2I_-I_+\), already give a lower bound greater than
\(0.022\). The full series gives \(C_h\approx0.12711117\); the decimal
is only a check.

To prove (5), a prime translation by \(\log d\ge h\) cannot overlap
either collar with itself, except on a null endpoint. Its two
cross-collar orientations give the triangular convolution in (2):
in cell labels the contributing children have
\(m\le r\le2m-1\) and \(\lfloor r/d\rfloor=1\), and their lengths
sum to \(W(\log(X/d))\). The integer child support and its exact
nonempty range \(X/4<d<X\) are formalized in
[SuccessorCellTransferFinite.lean](BuildingBlocks/SuccessorCellTransferFinite.lean);
the logarithmic telescoping weight is written here. The gamma diagonal is the finite box value
\(A_h\) in (4). The cross-gamma kernel of the complete Weil form is
\(-e^{-s/2}/(1-e^{-2s})\) at separation \(s>0\), giving \(-J_a\).
These gamma entries are finite because box Fourier transforms decay
as \(O((1+|t|)^{-1})\) against the logarithmic gamma multiplier.

For (6), the two pole moments \(E_+(f)=\int e^{v/2}f(v)\,dv\) and
\(E_-(f)=\int e^{-v/2}f(v)\,dv\) are
\[
 \begin{array}{c|cc}
       &E_+&E_-\\ \hline
 R&X^{1/4}I_-&X^{-1/4}I_+\\
 L&X^{-1/4}I_+&X^{1/4}I_-
 \end{array}.
 \tag{9}
\]
Polarizing \(2E_+E_-\) gives (6). In particular the off-diagonal
archimedean-plus-pole entry is exactly
\[
 \sqrt X I_-^2+X^{-1/2}I_+^2-J_a
   =\sqrt X I_-^2-R_X^\gamma.                       \tag{10}
\]
The small pole term cancels the first cross-gamma term; subtracting
the actual prime entry \(\mathcal P_X\) then cancels the leading
\(\sqrt X\) term and proves (7). The prime number theorem gives
\(\mathcal P_X=I_-^2\sqrt X+o(\sqrt X)\), but (7) uses the
**exact** centered remainder, with no replacement of prime powers by
density. In particular, this block explains why the diagonal-only
Perron supersolution obstruction does not imply a negative full Weil
direction.

## A centered bound for the actual prime remainder

Let \(\Psi(x)=\sum_{n\le x}\Lambda(n)\), and set
\(E(x)=\Psi(x)-x\), with \(\Psi\) right-continuous. The
Stieltjes integration in the odd-collar theorem has no endpoint atom:
the triangular weight vanishes at \(X/4\) and \(X\). After
\(x=Xy\), it gives the exact actual-source identity
\[
 D_X=X^{-1/2}\int_{1/4}^{1}E(Xy)\,k(y)\,dy,\qquad
 k(y)=
 \begin{cases}
 y^{-3/2}\bigl(-1+\tfrac12\log(4y)\bigr),
      &1/4\le y<1/2,\\
 y^{-3/2}\bigl(1+\tfrac12\log(1/y)\bigr),
      &1/2\le y\le1.
 \end{cases}                                                   \tag{10a}
\]
The kernel is negative on the lower band and positive on the upper.
Substitution \(y=e^{-u}\) gives
\[
 \int_{1/4}^{1/2}k(y)\,dy=-\sqrt2\log2,\qquad
 \int_{1/2}^{1}k(y)\,dy=\sqrt2\log2.                     \tag{10b}
\]
Hence \(\int k=0\) and \(\|k\|_1=2\sqrt2\log2\). Subtracting
any constant \(b\) from \(E(Xy)\) in (10a), then choosing \(b\)
halfway between the supremum and infimum of \(E\) on \([X/4,X]\),
proves
\[
 \boxed{\quad
 |D_X|\le\frac{\sqrt2\log2}{\sqrt X}\,
 \operatorname{osc}_{[X/4,X]}(\Psi(x)-x).
 \quad}                                                     \tag{10c}
\]
Here oscillation means supremum minus infimum. This bound retains
the cancellation between the adjacent dyadic bands. The prime
number theorem yields \(D_X=o(\sqrt X)\), while the odd-collar
theorem gives nonvanishing excursions of \(D_{2m}\) of both signs.
Equation (10c) does not supply the uniform \(O(1)\) bound needed
for a sign in (8).

## What the surviving row can and cannot sign

The [odd-collar theorem](successor-cell-odd-collar-triangular-prime-oscillation.md)
proves unconditionally that \(D_{2m}\) has excursions of both signs
bounded away from zero. Thus the residual off-diagonal entry in (7)
is genuinely signed, but this alone says nothing about whether either
eigenvalue in (8) is negative: the fixed \(C_h\) remains.

There is a sharper, exact conditional statement. **RH is equivalent
to eventual lower boundedness of the even row** \(Q_N(u_+)\) along
\(N=2m-1\). It is also equivalent to eventual lower boundedness of
the odd row \(Q_N(u_-)\). Under RH, both are nonnegative for *every*
\(m\ge3\): Weil positivity passes from smooth compact tests to these
compact step functions by mollification in \(H^s\), \(0<s<1/2\), as
shown in the [successor-cell form theorem](compact-weil-successor-cell-refinement.md).
The converse is an actual-prime-power statement, and is proved next;
the requisite lower bounds are **not** established here.

For real \(X>0\), extend (2) algebraically and put
\(D(a)=D_{e^{2a}}\), \(a\ge0\). Its Laplace transform, initially for
\(\operatorname{Re}z>1\), is
\[
 \int_0^\infty D(a)e^{-za}da
 =\frac12F(z)^2\left(-\frac{\zeta'}\zeta\right)
                    \!\left(\frac{z+1}{2}\right)
       -\frac{F(1)^2}{z-1},\qquad
 F(z)=\frac{2(1-2^{-z/2})}{z},\quad F(0)=h.
 \tag{11}
\]
Here \(F(1)=I_-\). The apparent pole at \(z=1\) cancels, and the
right side is regular at every positive real \(z\), since \(\zeta\)
has no real zero for \(s>1/2\). At any nontrivial zero
\(\rho=\beta+i\gamma\) with \(\beta>1/2\), it has a genuine pole
at \(z_\rho=2\rho-1\): the residue is
\(-m_\rho F(z_\rho)^2\ne0\), because
\(|2^{-z_\rho/2}|<1\).

If \(D(a)\) were bounded above eventually, choose \(M\) and \(a_0\)
so that \(G(a)=M-D(a)\ge0\) for \(a\ge a_0\). Chebyshev's bound
gives \(D(a)=O(e^a)\), so the Laplace transform of \(G\) has an
abscissa \(c\le1\), possibly \(-\infty\). A pole at \(z_\rho\) forces
\(c\ge\operatorname{Re}z_\rho>0\); otherwise the defining integral
would be analytic there. Landau's theorem for a nonnegative
Laplace integrand makes the positive real point \(c\) a singularity.
But (11), after subtracting the finite initial integral and adding
\(M e^{-a_0z}/z\), is regular at every positive real point. This is
a contradiction. The same argument with \(-D\) rules out an eventual
lower bound on \(D\) if an off-critical zero exists. By symmetry of
zeta zeros, failure of RH always gives such a \(\rho\). Hence
\[
 \neg\mathrm{RH}\quad\Longrightarrow\quad
 \limsup_{a\to\infty}D(a)=+\infty,\qquad
 \liminf_{a\to\infty}D(a)=-\infty.                 \tag{12}
\]

These excursions occur at the actual even integer values \(X=2m\).
The triangle \(W\) is globally one-Lipschitz; for comparable
\(X,Y\ge6\) with \(|X-Y|\le2\), Chebyshev's estimate yields
\[
 |\mathcal P_X-\mathcal P_Y|
 \le |\log(X/Y)|
       \sum_{\min(X,Y)/4\le d\le\max(X,Y)}
                  \frac{\Lambda(d)}{\sqrt d}
 \ll\frac{|X-Y|}{\sqrt X}.
 \tag{13}
\]
The same bound holds for the difference of the two square-root
density terms. Every large real \(X\) is within one of an even
integer, so \(D_X-D_{2m}=O(X^{-1/2})\) at the nearest one. Equations
(8) and (12)--(13), with \(R_X^\gamma\to0\), imply
\[
 \neg\mathrm{RH}\quad\Longrightarrow\quad
 \liminf_{m\to\infty}Q_{2m-1}(u_+)
 =\liminf_{m\to\infty}Q_{2m-1}(u_-)=-\infty.
 \tag{14}
\]
This proves the claimed two one-row equivalences. They reduce the
full-window positivity problem to explicit scalar bounds but do not
prove either bound, the full matrix sign, or RH. All results in this
note beyond the cited finite child-support lemmas are written
mathematics, not Lean formalizations.
