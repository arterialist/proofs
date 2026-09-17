# A fourth-logarithm negative-index bound for the complete successor-cell Weil form

The [exact successor-cell refinement](compact-weil-successor-cell-refinement.md)
gives an \(N\)-dimensional Hermitian form \(Q_N\) with every admitted
\(\Lambda(p^k)=\log p\), both poles, and the gamma integral. The
[earlier index estimate](compact-weil-successor-cell-negative-index-density.md)
is \(O(N/(\log N)^2)\). A coarse-cell deletion and a prime-dilation
split improve it without a prime number theorem or a zero-free region.
The full spectral theorem is a written analytic proof, not a Lean
formalization or an RH proof. Its high-parent row estimate below has
been formalized separately.

**Theorem.** There are absolute \(c,C>0\) and \(N_0\) such that, for
\(N\ge N_0\), a complex subspace \(V_N\subseteq S_N\) satisfies
\[
 \boxed{\quad
 \operatorname{codim}_{S_N}V_N
 \le C\,\frac{N\log\log N}{(\log N)^4},
 \qquad Q_N(f)\ge c\log N\,\|f\|_2^2
 \quad(f\in V_N).\quad}                                      \tag{1}
\]
Consequently
\[
 \boxed{\quad
 \operatorname{ind}_{\le0}(Q_N)
 \ll \frac{N\log\log N}{(\log N)^4}.\quad}                    \tag{2}
\]
The result counts possible negative directions. It does not bound the
most negative eigenvalue more strongly than the
[PNT-rate magnitude estimate](compact-weil-successor-cell-negative-part-vk-density.md).

## Exact cancellation and the low-frequency subspace

Set \(X=N+1\), \(L=\frac12\log X\), and
\(\ell_n=\log((n+1)/n)\). In the orthonormal cell basis
\(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\), let \(R_d\) be the exact
left-dilation matrix and
\[
 A_N=\sum_{d=2}^{N}\frac{\Lambda(d)}{\sqrt d}R_d,\qquad
 K_N=A_N+A_N^*.
\]
Every \(R_d\) is a contraction; its \(n\)-th column has only the
children \(dn\le r<d(n+1)\), clipped at \(r=N\).
Let \(P_N\) be the continuous prime-density operator, whose kernel
on \((-L,L)\) is \(e^{|x-y|/2}\). The exact pole cancellation and
digamma recurrence in the
[negative-part proof](compact-weil-successor-cell-negative-part-bound.md)
give
\[
 Q_N(f)=\frac1{2\pi}\int_{\mathbb R}
 b(t)|\widehat f(t)|^2\,dt
 -\langle f,(K_N-P_N)f\rangle,\qquad
 b(t)=\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi.                \tag{3}
\]
In particular, (3) includes both poles and the complete gamma term;
the pole contribution has not been dropped.

For sufficiently large \(N\), \(b(t)\ge-C_b\) everywhere and
\(b(t)\ge\frac13\log N\) when \(|t|\ge\sqrt N\). Let \(B_N\)
be the Fourier mass form on \(|t|\le\sqrt N\), compressed to \(S_N\).
As in the earlier index proof,
\[
 0\le B_N\le I,\qquad
 \operatorname{Tr}B_N
 \le\frac{\sqrt N}{\pi}\sum_{n=1}^N\ell_n
 =\frac{\sqrt N\log X}{\pi}.                                \tag{4}
\]
Delete its eigenspaces with eigenvalue greater than \(1/2\).
The resulting space \(W_N\) has codimension \(O(\sqrt N\log N)\).
At least half of every \(f\in W_N\)'s Fourier mass lies outside the
low-frequency interval, so, after increasing \(N_0\),
\[
 \frac1{2\pi}\int b(t)|\widehat f(t)|^2dt
 \ge c_b\log N\,\|f\|_2^2\qquad(f\in W_N)                    \tag{5}
\]
for an absolute \(c_b>0\).

## Remove the small prime dilations

For an integer \(D\ge2\), write \(K_N=K_{\le D}+K_{>D}\)
according to \(d\le D\) and \(d>D\). The elementary Chebyshev
estimate \(\psi(y)=\sum_{d\le y}\Lambda(d)\ll y\), by partial
summation, gives
\[
 \|K_{\le D}\|
 \le2\sum_{2\le d\le D}\frac{\Lambda(d)}{\sqrt d}
 \ll\sqrt D.                                                \tag{6}
\]
This uses the actual nonnegative von Mangoldt weights; proper prime
powers are included. Choose a fixed sufficiently small \(\delta>0\)
and set
\[
 D=\lfloor\delta(\log N)^2\rfloor.                           \tag{7}
\]
For all large \(N\), \(D\ge2\), and (6) is at most
\((c_b/4)\log N\). No integer endpoint is removed: \(d=D\)
belongs to \(K_{\le D}\), and \(d=D+1\) begins \(K_{>D}\).

## A Hilbert–Schmidt tail after the coarse cells

Put \(M=\lceil(\log N)^4\rceil\), and let \(\Pi_M\) project onto
the cells \(n>M\). Its complement has dimension at most \(M\).
For \(r>n\), the exact matrix coefficient of the large-dilation
lower triangle is
\[
 (A_{>D})_{r,n}
 =\sqrt{\frac{\ell_r}{\ell_n}}
   \sum_{\substack{d>D\\r/(n+1)<d\le r/n}}
        \frac{\Lambda(d)}{\sqrt d}.                         \tag{8}
\]
If \(M<n\le\sqrt r\), then
\(\ell_r/\ell_n\le(n+1)/r\), every active \(d\) is greater than
\(r/(n+1)\), and there are at most
\(1+r/[n(n+1)]\) candidate integers. Since \(d\le r\) and
\(\Lambda(d)\le\log r\),
\[
 0\le(A_{>D})_{r,n}
 \le(\log r)\left(\frac1n+\frac{n+1}{r}\right).
\]
Thus these columns contribute at most
\[
 C(\log r)^2\left(\frac1M+\frac1{\sqrt r}\right)             \tag{9}
\]
to the squared norm of row \(r\).

If \(n>\sqrt r\), the interval in (8) has length less than one and
contains at most one integer \(d\). For that integer,
\(n=\lfloor r/d\rfloor\), so
\[
 |(A_{>D})_{r,n}|^2
 \le\frac{n+1}{r}\frac{\Lambda(d)^2}{d}
 \le\frac{2\Lambda(d)^2}{d^2}.
\]
At fixed \(r\), each \(d\) has only that one parent. Chebyshev and
\(\Lambda(d)^2\le(\log d)\Lambda(d)\) imply
\[
 \sum_{d>D}\frac{\Lambda(d)^2}{d^2}
 \ll\frac{\log(2D)}D.                                      \tag{10}
\]
Indeed \(\sum_{d\le y}\Lambda(d)^2\ll y\log y\); Stieltjes
integration by parts bounds its \(d^{-2}\) tail by
\(O(\int_D^\infty(\log y)y^{-2}dy)\).
The finite high-parent inequality preceding (10), with the exact
\(\sqrt{\ell_r/\ell_n}\) coefficient and all von Mangoldt prime powers,
is proved in
[SuccessorHighParentPrimeRow.lean](../../formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean)
as highParent_vonMangoldt_normalized_row_energy_le. This Lean result
does not include the Chebyshev tail estimate (10), the low-parent
estimate (9), or the spectral min--max conclusion.
Summing (9)--(10) over rows, and using the strict triangularity,
gives
\[
 \|\Pi_M K_{>D}\Pi_M\|_{\rm HS}^2
 =2\|\Pi_M A_{>D}\Pi_M\|_{\rm HS}^2
 \ll N\frac{(\log N)^2}{M}
      +\sqrt N(\log N)^2
      +N\frac{\log(2D)}D.                                  \tag{11}
\]

The continuous operator must be retained in the same tail. Its
off-diagonal cell coefficient is, for \(r>n\),
\[
 (P_N)_{r,n}
 =\frac{4(\sqrt{r+1}-\sqrt r)
       (n^{-1/2}-(n+1)^{-1/2})}
       {\sqrt{\ell_r\ell_n}}
 \le\frac2n.                                                \tag{12}
\]
Its diagonal coefficient is at most
\(e^{\ell_n/2}\ell_n\ll1/n\). Hence
\[
 \|\Pi_M P_N\Pi_M\|_{\rm HS}^2\ll\frac NM.                   \tag{13}
\]
Equations (7), (11), and (13) now give the complete residual
\[
 T_N:=\Pi_M(K_{>D}-P_N)\Pi_M,\qquad
 \boxed{\quad
 \|T_N\|_{\rm HS}^2
 \ll\frac{N\log\log N}{(\log N)^2}.\quad}                    \tag{14}
\]
This estimate uses only the exact child intervals, Chebyshev's bound,
and elementary cell geometry. It makes no claim that the individual
large-prime or continuous operators are small before the coarse
cells are removed.

## Min--max conclusion

Inside \(\Pi_MS_N\), delete the eigenspaces of the Hermitian
\(T_N\) with eigenvalue greater than \((c_b/4)\log N\).
By (14), their dimension is at most
\[
 \frac{16\|T_N\|_{\rm HS}^2}{c_b^2(\log N)^2}
 \ll\frac{N\log\log N}{(\log N)^4}.                          \tag{15}
\]
Intersect the remaining space with \(W_N\).
For every vector in this intersection, (3), (5), (6), and the
spectral cutoff on \(T_N\) give
\[
 Q_N(f)\ge(c_b-c_b/4-c_b/4)\log N\,\|f\|_2^2
 =\frac{c_b}{2}\log N\,\|f\|_2^2.
\]
The removed dimensions total
\[
 O\!\left(\sqrt N\log N+(\log N)^4+
          \frac{N\log\log N}{(\log N)^4}\right)
 =O\!\left(\frac{N\log\log N}{(\log N)^4}\right).
\]
The finite-dimensional min--max principle proves (1)--(2).

The quantitative improvement is a **count**, not the RH-scale sign.
An off-critical zero could still produce a single large negative
direction; (2) allows that. The available
[PNT-rate lower bound](compact-weil-successor-cell-negative-part-vk-density.md)
controls magnitude separately but still diverges. To derive RH from
this approach, one needs a new signed constraint on the residual
directions themselves.

For external comparison, Groskin's
[numerical truncated Weil study](https://arxiv.org/abs/2605.20224v4)
and [finite Guinand--Weil dictionary](https://arxiv.org/abs/2607.02828v3)
concern a different Galerkin space and do not supply (1). No
literature-priority claim is made for this successor-cell estimate.
