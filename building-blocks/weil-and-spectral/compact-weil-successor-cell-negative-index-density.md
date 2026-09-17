# A density bound for negative successor-cell Weil eigenvalues

This written proof concerns the complete [successor-cell Weil matrix](compact-weil-successor-cell-refinement.md), with every admitted \(\Lambda(p^j)=\log p\), both poles, and the gamma integral. Chebyshev's bound \(\psi(x)\ll x\) is its only prime-distribution input. The result counts negative directions; it does not prove positivity or RH. No theorem below is formalized in Lean.

For \(N\ge2\), put \(X=N+1\), \(L=\tfrac12\log X\), and let \(S_N\) have the orthonormal cell basis \(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\), where
\[
I_n=(L-\log(n+1),L-\log n],\qquad
\ell_n=\log(1+1/n),\quad 1\le n\le N.
\]
Let \(Q_N\) be the Hermitian form in equation (8) of the refinement note. Write \(\operatorname{ind}_{\le0}(Q_N)\) for the number of its nonpositive eigenvalues, counted with matrix multiplicity.

**Theorem.** There are absolute \(c,C>0\) and \(N_0\) such that, for \(N\ge N_0\), a complex subspace \(V_N\subseteq S_N\) satisfies
\[
\boxed{\quad
\operatorname{codim}_{S_N}V_N\le C\frac{N}{\log N},
\qquad Q_N(f)\ge c\log N\,\|f\|_2^2
\quad(f\in V_N).\quad}                                      \tag{1}
\]
Consequently
\[
\boxed{\operatorname{ind}_{\le0}(Q_N)\le C\frac{N}{\log N}=o(N).} \tag{2}
\]
The estimate applies to the full \(N\)-cell space. It complements the [negative-part magnitude bound](compact-weil-successor-cell-negative-part-bound.md), which controls the size of each negative eigenvalue but does not count them.

## Hilbert–Schmidt bound for the complete prime matrix

Let \(R_d=M_LU_{-\log d}|_{S_N}\) be the exact child-cell operator in the refinement theorem, and set
\[
A_N=\sum_{d=2}^{N}\frac{\Lambda(d)}{\sqrt d}R_d,
\qquad K_N=A_N+A_N^*.
\tag{3}
\]
Thus \(K_N\) is exactly the prime-power matrix in \(Q_N\). In the cell basis, \(R_d\) maps column \(n\) only to rows \(r\) with \(dn\le r\le d(n+1)-1\), clipped at \(N\). In particular \(A_N\) is strictly triangular.

For \(r>n\), put
\[
D_{r,n}=\{d\ge2:dn\le r<d(n+1)\}
        =\{d\ge2:r/(n+1)<d\le r/n\}.
\]
The matrix coefficient is
\[
(A_N)_{r,n}=\sqrt{\frac{\ell_r}{\ell_n}}
       \sum_{d\in D_{r,n}}\frac{\Lambda(d)}{\sqrt d}.
\tag{4}
\]
The interval defining \(D_{r,n}\) has length \(r/[n(n+1)]\), so its number \(m_{r,n}\) of integers obeys
\(m_{r,n}\le1+r/[n(n+1)]\). Cauchy–Schwarz in (4) yields
\[
|(A_N)_{r,n}|^2
\le\frac{\ell_r}{\ell_n}m_{r,n}
       \sum_{d\in D_{r,n}}\frac{\Lambda(d)^2}{d}.
\tag{5}
\]
Fix \(d\) and \(n\le N/d\). On its child rows, \(r<d(n+1)\), hence \(m_{r,n}\le1+d/n\). Exact telescoping of the cell lengths, including a clipped last column, gives
\[
\sum_{r=dn}^{\min(d(n+1)-1,N)}\frac{\ell_r}{\ell_n}\le1.
\tag{6}
\]
Sum (5), exchange the finite nonnegative sums, and use (6):
\[
\begin{aligned}
\|A_N\|_{\mathrm{HS}}^2
&\le\sum_{d=2}^N\frac{\Lambda(d)^2}{d}
             \sum_{n\le N/d}\left(1+\frac dn\right)\\
&\le N\sum_{d=2}^\infty\frac{\Lambda(d)^2}{d^2}
    +\sum_{d=2}^N\Lambda(d)^2H_{\lfloor N/d\rfloor}
 \ll N\log N.
\end{aligned}                                                \tag{7}
\]
Here the first series converges because \(\Lambda(d)\le\log d\). For the second, \(H_m=\sum_{j\le m}1/j\) and
\[
\sum_{d\le y}\Lambda(d)^2
\le(\log y)\psi(y)\ll y\log y.
\]
Exchange the nonnegative sums once more to obtain
\[
\sum_{d=2}^N\Lambda(d)^2H_{\lfloor N/d\rfloor}
=\sum_{j\le N}\frac1j\sum_{2\le d\le N/j}\Lambda(d)^2
\ll N\sum_{j\le N}\frac{\log(N/j)}{j^2}
\ll N\log N.
\]
This proves the last bound in (7). Since \(K_N=A_N+A_N^*\),
\[
\boxed{\|K_N\|_{\mathrm{HS}}^2\ll N\log N.}          \tag{8}
\]
This calculation retains every proper prime power and the exact \(d=N\) endpoint. It requires no estimate for prime pairs.

## Gamma mass away from a small subspace

Write \(H(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi\), the exact gamma multiplier in \(Q_N\). The digamma recurrence and the large-frequency asymptotic in the [negative-part proof](compact-weil-successor-cell-negative-part-bound.md#exact-cancellation-of-the-continuous-prime-density) give
\[
H(t)\ge-C_H\quad(t\in\mathbb R),\qquad
H(t)\ge\tfrac13\log N\quad(|t|\ge T_N:=\sqrt N)
\tag{9}
\]
for all sufficiently large \(N\), after fixing \(C_H\). Define the low-frequency quadratic form on \(S_N\) by
\[
\langle f,B_Nf\rangle
=\frac1{2\pi}\int_{|t|\le T_N}|\widehat f(t)|^2dt.
\]
Plancherel makes \(0\le B_N\le I\). For each basis cell,
\(|\widehat e_n(t)|\le\|e_n\|_1=\sqrt{\ell_n}\); therefore its trace obeys the exact window-length budget
\[
\operatorname{Tr}B_N
\le\frac{T_N}{\pi}\sum_{n=1}^N\ell_n
=\frac{T_N\log X}{\pi}.
\tag{10}
\]
Delete the eigenspaces of \(B_N\) with eigenvalue greater than \(1/2\), and call their orthogonal complement \(W_N\). By (10),
\[
\operatorname{codim}W_N\le2\operatorname{Tr}B_N
\ll\sqrt N\log N.
\tag{11}
\]
Every unit \(f\in W_N\) has at least half of its Fourier mass outside \([-T_N,T_N]\). Equation (9) gives, for an absolute \(c_\Gamma>0\) and sufficiently large \(N\),
\[
\Gamma_N(f):=\frac1{2\pi}\int H(t)|\widehat f(t)|^2dt
\ge c_\Gamma\log N\,\|f\|_2^2
\qquad(f\in W_N).
\tag{12}
\]

## Prime and pole removal

Let \(U_N\) be the span of eigenvectors of \(K_N\) with eigenvalue greater than \((c_\Gamma/2)\log N\). The Hilbert–Schmidt estimate (8) gives
\[
\dim U_N\le
\frac{4\|K_N\|_{\mathrm{HS}}^2}{c_\Gamma^2(\log N)^2}
\ll\frac{N}{\log N}.
\tag{13}
\]
On \(U_N^\perp\), the prime quadratic is at most
\((c_\Gamma/2)\log N\,\|f\|_2^2\).

The two exact pole moments \(E_+(f),E_-(f)\) satisfy
\[
2\operatorname{Re}(E_+(f)\overline{E_-(f)})
=\left|\frac{E_+(f)+E_-(f)}{\sqrt2}\right|^2
 -\left|\frac{E_+(f)-E_-(f)}{\sqrt2}\right|^2.
\tag{14}
\]
Thus the pole term is nonnegative on the kernel of the one complex functional \(E_+-E_-\), a subspace of codimension at most one. Intersect that kernel with \(W_N\cap U_N^\perp\). Equations (11)–(14) give (1), because \(\sqrt N\log N=O(N/\log N)\). The finite-dimensional min–max principle then gives (2).

A hypothetical off-line zeta zero can contribute a negative Weil direction on a sufficiently large compact window, and one direction is compatible with (2). The theorem therefore gives no zero exclusion. The [exact negative-index theorem](../theta-and-heat/theta-weil-jump-form.md#12-exact-negative-index-including-compact-test-realization) counts nonreal zero pairs in the unrestricted form, whereas (2) bounds the *fraction* of negative directions in this particular growing finite model. No literature-priority claim is made.

For context, [Groskin's numerical study](https://arxiv.org/abs/2605.20224) reports negative eigenvalues for a Connes–van Suijlekom Galerkin truncation, and his [finite Guinand–Weil dictionary](https://arxiv.org/abs/2607.02828) analyzes that truncation's relation to zero sums. Those use a different finite test space. The estimate (2) is an analytic upper count for the successor-cell space; this comparison is not a claim that such a count is unavailable elsewhere.
