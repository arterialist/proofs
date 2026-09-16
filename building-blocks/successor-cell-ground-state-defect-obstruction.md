# The successor-cell ground-state defect is not a positive local potential

The [exact successor-cell Weil matrix](compact-weil-successor-cell-refinement.md)
has positive prime-power refinement weights. A natural proposal is to
turn its prime block into edge squares, then pay the remaining vertex
degree with the diagonal gamma and pole entries. This note computes
that degree and tests every positive ground-state weight. The local
potential is negative at central cells for the constant physical
weight, and no positive weight can make a diagonal-only
archimedean supersolution work at large cutoffs. The conclusion is an
obstruction to that particular proof method, not a negative Weil test.

Let \(N\ge2\), \(L=\frac12\log(N+1)\),
\(\ell_n=\log((n+1)/n)\), and
\(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\), with \(I_n\) as in the
cell-refinement note. Denote by \(K_N\) the exact prime compression
and by \(\Gamma_N,P_N\) the complete gamma and pole matrices in
this orthonormal basis. Put
\[
 D_N=\operatorname{diag}
       \bigl((\Gamma_N+P_N)_{11},\ldots,
             (\Gamma_N+P_N)_{NN}\bigr).
 \tag{1}
\]
This diagonal extracts only the same-cell archimedean and pole
terms. The off-diagonal entries of \(\Gamma_N+P_N\) remain part of
the full Weil matrix.

**Theorem.** As \(N\to\infty\),
\[
 \max_{n\le N}|(D_N)_{nn}|=O(\log(N+1)).
 \tag{2}
\]
Along the odd successor cutoffs \(N=X-1=2m-1\),
\[
 \lambda_{\max}(K_N)
 \ge
 \left(\frac{6-4\sqrt2}{\log2}+o(1)\right)\sqrt X.
 \tag{3}
\]
Consequently, for all sufficiently large such \(N\), there is
**no** vector \(h\in\mathbb R_{>0}^N\) satisfying the pointwise
supersolution inequalities
\[
 K_Nh\le D_Nh.
 \tag{4}
\]
For the particular ground-state vector \(h_n=\sqrt{\ell_n}\),
corresponding to the physical constant function on the window,
and \(n_N=\lfloor\sqrt N\rfloor\), the exact local defect is
\[
 \frac{((D_N-K_N)h)_{n_N}}{h_{n_N}}
 =-4N^{1/4}+o(N^{1/4}).
 \tag{5}
\]
Thus the direct cell-edge square decomposition has a negative
central vertex potential of order \(N^{1/4}\). A proof of a full
Weil sign must retain nonlocal archimedean and pole interactions.

## The exact row and its central defect

Let \(B_{d,N}\) be the left-refinement matrix in the
[cell theorem](compact-weil-successor-cell-refinement.md).
Then
\(K_N=\sum_{2\le d\le N}\Lambda(d)d^{-1/2}
(B_{d,N}+B_{d,N}^*)\), where the scalar weight multiplies
the parenthesized matrices. For \(h_n=\sqrt{\ell_n}\),
the row ratio is exactly
\[
 \boxed{\quad
 \frac{(K_Nh)_n}{h_n}
 =\sum_{2\le d\le n}\frac{\Lambda(d)}{\sqrt d}
  +\sum_{\substack{d\ge2\\dn\le N}}
     \frac{\Lambda(d)}{\sqrt d}\,\beta_{n,d},
 \quad
 \beta_{n,d}
 =\frac{
   \log\!\left(\min\{d(n+1),N+1\}/(dn)\right)}
   {\ell_n}.
 \quad}
 \tag{6}
\]
The first sum counts child rows reaching \(n\). In the second,
\(\beta_{n,d}\in(0,1]\) is the fraction of parent cell \(I_n\)
remaining after the left-boundary truncation. It equals one when
\(d(n+1)\le N+1\). Formula (6) is the exact diagonal degree in
the cell edge-square expansion: with physical cell values \(z_n\),
\[
 \langle f_z,K_Nf_z\rangle
 =\sum_{n\le N}\ell_n
      \frac{(K_Nh)_n}{h_n}|z_n|^2
   -\sum_{d=2}^N\sum_{r=d}^N
     \frac{\Lambda(d)\ell_r}{\sqrt d}
       |z_r-z_{\lfloor r/d\rfloor}|^2.
 \tag{7}
\]
Here (7) uses \(h_n=\sqrt{\ell_n}\) only to express the
physical constant in the orthonormal basis.

The prime number theorem and partial summation give
\[
 S_{1/2}(y)
 :=\sum_{2\le d\le y}\frac{\Lambda(d)}{\sqrt d}
 =2\sqrt y+o(\sqrt y).
 \tag{8}
\]
For \(n=n_N=\lfloor\sqrt N\rfloor\), the second sum in
(6) lies between
\(S_{1/2}((N+1)/(n+1))\) and \(S_{1/2}(N/n)\);
both cutoffs are asymptotic to \(\sqrt N\).
The first sum has the same asymptotic. Hence
\[
 \frac{(K_Nh)_{n_N}}{h_{n_N}}
 =4N^{1/4}+o(N^{1/4}).
 \tag{9}
\]

For a normalized interval indicator of length \(\ell\le\log2\),
its gamma diagonal is
\[
 G(\ell)=\frac1{2\pi}\int_{\mathbb R}
 H(t)\left|
 \widehat{\ell^{-1/2}\mathbf1_{[0,\ell]}}(t)
 \right|^2dt,
 \qquad
 |G(\ell)|\le C+\log(1/\ell).
 \tag{10}
\]
The bound follows by setting \(u=\ell t\), using
\(|H(t)|\le C+\log(2+|t|)\), and integrating
\(\log(2+|u|)\) against the squared unit-box Fourier transform.
Because \(\ell_n\ge1/(n+1)\), every gamma diagonal is
\(O(\log(N+1))\).
The pole diagonal is nonnegative but bounded:
\[
 2E_+(e_n)E_-(e_n)
 =\frac2{\ell_n}
    \left(\int_{I_n}e^{x/2}dx\right)
    \left(\int_{I_n}e^{-x/2}dx\right)
 \le 2e^{\ell_n/2}\ell_n
 \le 2\sqrt2\log2.
 \tag{11}
\]
Equations (9)--(11) prove (2) and (5).

Write \(a_n=\sqrt{\ell_n}z_n\). The decomposition of the
**complete** form is
\[
 Q_L(f_z)
 =\mathcal E_N^{\rm cell}(z)
  +\sum_{n\le N}\ell_n
       \left((D_N)_{nn}
             -\frac{(K_Nh)_n}{h_n}\right)|z_n|^2
  +\langle a,(\Gamma_N+P_N-D_N)a\rangle.
 \tag{12}
\]
The last term is the full off-diagonal gamma and pole matrix.
Discarding it would change the Weil form.

## Obstruction for every positive ground state

Take the *even* companion of the exact odd boundary collar from
[the collar theorem](successor-cell-odd-collar-triangular-prime-oscillation.md):
for \(X=2m\), \(N=X-1\), \(L=\frac12\log X\), and \(h_0=\log2\),
\[
 u_X=\frac1{\sqrt2}\mathbf1_{(L-h_0,L]}
      +\frac1{\sqrt2}\mathbf1_{(-L,-L+h_0]}.
 \tag{13}
\]
This belongs to \(S_N\) and has \(\|u_X\|_2^2=h_0\).
There are no same-collar prime overlaps. The cross-collar
prime quadratic is the positive triangular sum
\[
 \langle u_X,K_Nu_X\rangle
 =P_X
 =\sum_{X/4<d<X}\frac{\Lambda(d)}{\sqrt d}
       W\!\left(\log\frac Xd\right),
 \tag{14}
\]
with \(W=\mathbf1_{(0,h_0)}*\mathbf1_{(0,h_0)}\).
By the prime number theorem and partial summation,
\[
 P_X
 =\sqrt X\int_0^{2h_0}e^{-u/2}W(u)du
   +o(\sqrt X)
 =(6-4\sqrt2)\sqrt X+o(\sqrt X).
 \tag{15}
\]
The Rayleigh quotient of \(u_X\) proves (3).

The nonnegative symmetric matrix \(K_N\) is irreducible:
its \(d=2\) edges connect every \(r\ge2\) to
\(\lfloor r/2\rfloor\), and repeated halving reaches \(1\).
Let \(v>0\) be its Perron eigenvector. If a positive \(h\)
satisfied (4), then, by symmetry,
\[
 \lambda_{\max}(K_N)\langle v,h\rangle
 =\langle v,K_Nh\rangle
 \le\langle v,D_Nh\rangle
 \le\bigl(\max_n(D_N)_{nn}\bigr)\langle v,h\rangle.
 \tag{16}
\]
This contradicts (2)--(3) for large \(N\).
The obstruction holds for any positive row weight, including
power weights and Perron-inspired weights. It concerns the
diagonal-only matrix \(D_N-K_N\), not the complete form (12).

The [odd collar calculation](successor-cell-odd-collar-triangular-prime-oscillation.md)
also identifies the signed remainder after the leading pole and
prime terms cancel: \(Q_L(f_m)=C_{h_0}+D_X+R_X\), with
\(\limsup D_{2m}>0\) and \(\liminf D_{2m}<0\).
That exact actual-prime oscillation rules out replacing the
nonlocal cancellation by an eventually one-sided continuum error.
It does **not** show a negative value of \(Q_L\).

The source-specific issue is visible against the literature:
[Suzuki's complete Weil form](https://arxiv.org/abs/2606.09096)
keeps the pole and archimedean operators, while
[Zhu's bounded-window certificate](https://arxiv.org/abs/2608.24827)
uses a full finite-matrix reduction to prove positivity on
\([-0.8,0.8]\). The present calculation proves no larger
positive window. It identifies why a local Balazard-style
row potential alone cannot certify the growing dense cell spaces.
All claims here are written mathematics, not Lean formalizations.
