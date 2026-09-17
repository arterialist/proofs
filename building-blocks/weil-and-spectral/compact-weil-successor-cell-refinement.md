# Exact successor-cell refinement of the compact Weil form

The [resolved divisor packets](compact-weil-boundary-packet-growing-positive-space.md)
give finite prime-power matrices on useful but sparse subspaces.
Here the elementary \(+1\) clock gives a different finite model:
its cells tile the entire Weil window, and every admitted
integer-dilation shift refines a cell into consecutive successor
cells. The resulting step spaces approximate each fixed compact
test in the form topology. The full prime, gamma, and pole terms
remain signed; no positivity is inferred.

For an integer \(N\ge2\), set
\[
 L=\tfrac12\log(N+1),\qquad
 I_n=(L-\log(n+1),\,L-\log n],\qquad
 \ell_n=|I_n|=\log(1+1/n),\quad 1\le n\le N.
 \tag{1}
\]
The intervals partition \((-L,L]\). Endpoints of intervals have
measure zero, so we identify this partition with the Weil window
\([-L,L]\). Define \(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\) and
\(S_N=\operatorname{span}\{e_1,\ldots,e_N\}\).
These functions are orthonormal in \(L^2([-L,L])\).
We use \(U_yf(x)=f(x-y)\) and \(M_L=\mathbf1_{[-L,L]}\).

**Theorem 1 (exact refinement).** For every integer \(d\ge2\),
\[
 M_LU_{-\log d}e_n
 =\sum_{r=dn}^{\min(d(n+1)-1,N)}
       \sqrt{\frac{\ell_r}{\ell_n}}\,e_r ,
 \tag{2}
\]
with an empty sum when \(dn>N\). If \(d(n+1)\le N+1\),
the column has norm one; otherwise (2) is the exact left-boundary
truncation. The reverse-shift **compression** to \(S_N\) is the
adjoint of the matrix in (2). The reverse shift itself need not
preserve \(S_N\).

Indeed,
\[
 I_n-\log d
 =(L-\log(d(n+1)),\,L-\log(dn)]
 =\bigcup_{r=dn}^{d(n+1)-1}I_r
 \tag{3}
\]
as a disjoint union up to endpoints. Intersecting with the window
keeps exactly the cells with \(r\le N\), proving (2).
The full-column norm is one because
\(\sum_{r=dn}^{d(n+1)-1}\ell_r
 =\log((n+1)/n)=\ell_n\).
Write \(R_{d,N}=M_LU_{-\log d}|_{S_N}\). Distinct columns have
disjoint child sets, so
\(R_{d,N}^{*}R_{d,N}\) is diagonal. Its \(n\)-th entry is zero
when \(dn>N\), and otherwise equals
\[
 \frac{\log\!\left(\min\{d(n+1),N+1\}/(dn)\right)}
      {\log((n+1)/n)}.                                  \tag{3a}
\]
The child interval rule is the exact successor relation
\(d[n,n+1)=\bigcup_{j=0}^{d-1}[dn+j,dn+j+1)\), an interval
realization of \(M_dS=S^dM_d\), where \(S(n)=n+1\) and
\(M_d(n)=dn\).
Adjointness follows from that of the two translations and the
orthogonal compression \(P_{S_N}M_L(\cdot)M_LP_{S_N}\).

## The complete finite Weil matrix

Write a step function in its physical cell values,
\[
 f_z(x)=\sum_{n=1}^N z_n\mathbf1_{I_n}(x),
 \qquad
 \|f_z\|_2^2=\sum_{n=1}^N\ell_n|z_n|^2.
 \tag{4}
\]
The exact compressed prime-power term in the
[complete compact Weil form](compact-weil-boundary-packet-growing-positive-space.md)
is
\[
 \boxed{\quad
 \langle f_z,K_L f_z\rangle
 =2\operatorname{Re}\sum_{d=2}^{N}
       \frac{\Lambda(d)}{\sqrt d}
       \sum_{r=d}^{N}
       \ell_r\,\overline{z_r}\,
                    z_{\lfloor r/d\rfloor}.
 \quad}
 \tag{5}
\]
Every von Mangoldt prime power with \(d<N+1=e^{2L}\)
is included. Equation (5) follows from (2) because, on cell \(I_r\),
the left-shifted step function has the constant value
\(z_{\lfloor r/d\rfloor}\) when \(r\ge d\), and is zero otherwise.

The two pole moments are finite telescoping rows:
\[
 \begin{aligned}
 E_+(f_z)
 &=2e^{L/2}\sum_{n=1}^N z_n
             \bigl(n^{-1/2}-(n+1)^{-1/2}\bigr),\\
 E_-(f_z)
 &=2e^{-L/2}\sum_{n=1}^N z_n
             \bigl(\sqrt{n+1}-\sqrt n\bigr).
 \end{aligned}
 \tag{6}
\]
For the gamma term, put
\[
 J_n(t)=
 \begin{cases}
 \displaystyle
 \frac{e^{it(L-\log n)}
       -e^{it(L-\log(n+1))}}{it},&t\ne0,\\[1.2ex]
 \ell_n,&t=0.
 \end{cases}
 \tag{7}
\]
Then \(\widehat f_z(t)=\sum z_nJ_n(t)\), and the exact complete
form on \(S_N\) is
\[
 \begin{aligned}
 Q_L(f_z)
 ={}&2\operatorname{Re}
        \bigl(E_+(f_z)\overline{E_-(f_z)}\bigr)\\
 &+\frac1{2\pi}\int_{\mathbb R}
        H(t)\left|\sum_{n=1}^N z_nJ_n(t)\right|^2dt\\
 &-2\operatorname{Re}\sum_{d=2}^{N}
       \frac{\Lambda(d)}{\sqrt d}
       \sum_{r=d}^{N}
       \ell_r\,\overline{z_r}\,
                    z_{\lfloor r/d\rfloor},
 \end{aligned}
 \tag{8}
\]
where \(H(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi\).
The gamma integral converges absolutely:
\(H(t)=O(\log(2+|t|))\) and the Fourier transform of a compact
step function is \(O_z(1/|t|)\).
Thus (8) is a well-defined extension of the smooth-test form.

For comparison with a graph square, let
\(a_{r,d}=\Lambda(d)\ell_r/\sqrt d\) and
\[
 \mathcal E_N^{\rm cell}(z)
 =\sum_{d=2}^{N}\sum_{r=d}^{N}
     a_{r,d}|z_r-z_{\lfloor r/d\rfloor}|^2\ge0.
 \tag{9}
\]
Expansion gives
\[
 \langle f_z,K_Lf_z\rangle
 =\sum_{d=2}^{N}\sum_{r=d}^{N}a_{r,d}
   \bigl(|z_r|^2+|z_{\lfloor r/d\rfloor}|^2\bigr)
   -\mathcal E_N^{\rm cell}(z).
 \tag{10}
\]
Unlike the resolved packet graph, the edge weight here is
\(\Lambda(d)\ell_r/\sqrt d\), not \(\Lambda(d)/(rd)\).
Its child-vertex degree is
\(\ell_r\sum_{d\le r}\Lambda(d)/\sqrt d\).
The [Balazard bound](compact-weil-divisor-graph-dirichlet-energy.md)
for \(\sum\Lambda(d)/d\) therefore does not make the
diagonal remainder in (10) nonnegative against the gamma term.
The pole is also of leading size on coherent cells. For
\(z_n=1\), exactly
\[
 \mathcal E_N^{\rm cell}(z)=0,\quad
 \langle f_z,K_Lf_z\rangle
 =2\sum_{d=2}^N\frac{\Lambda(d)}{\sqrt d}
       \log\frac{N+1}{d},\quad
 2E_+(f_z)E_-(f_z)
 =8\bigl(e^L-2+e^{-L}\bigr).
 \tag{11}
\]
Both terms in (11) must be retained in any proposed sign argument.

## Moving-window form approximation

For fixed \(f\in C_c^\infty(\mathbb R)\), let \(P_Nf\) be its
cellwise-average projection onto \(S_N\), extended by zero outside
\([-L,L]\). Then, for every \(0<s<1/2\),
\[
 P_Nf\longrightarrow f\quad\text{in }H^s(\mathbb R),
 \qquad
 Q_{L_N}(P_Nf)\longrightarrow Q(f).
 \tag{12}
\]
Here \(Q(f)\) is the complete Weil form on the fixed compact test.

To prove the first assertion, choose a fixed interval containing
\(\operatorname{supp}f\). Cells meeting that interval have
\(n\asymp_f\sqrt N\) and maximum length \(O_f(N^{-1/2})\).
Thus the cell-average error \(u_N=P_Nf-f\) has fixed compact
support for large \(N\) and \(\|u_N\|_2\to0\).
The total variation of \(P_Nf\) is uniformly bounded: differences
of averages on adjacent cells are bounded by the integral of
\(|f'|\) across their union, and each cell enters at most twice.
Consequently \(\operatorname{TV}(u_N)=O_f(1)\), and
\[
 |\widehat u_N(t)|
 \le \min\{\|u_N\|_1,\operatorname{TV}(u_N)/|t|\}.
 \tag{13}
\]
Split the \(H^s\) Fourier integral at
\(|t|=\|u_N\|_2^{-1}\). Its lower-frequency part is bounded by
\(O(\|u_N\|_2^{\,2-2s})\) using Plancherel; its upper-frequency
part is \(O_f(\|u_N\|_2^{\,1-2s})\) by (13).
Both tend to zero when \(s<1/2\).

Since \(|H(t)|\le C_s(1+|t|^{2s})\), this convergence passes the
gamma quadratic in (8) to the limit. All functions \(P_Nf\) are
supported in one fixed compact interval for large \(N\).
Only finitely many shifts \(\log d\) can pair two points of that
interval, so \(L^2\) convergence passes the complete prime sum.
The pole moments also converge by \(L^2\) convergence on the
fixed interval. This proves (12).

Therefore a nonnegative bound for (8) on **every** \(S_N\) along
an unbounded sequence of \(N\)'s would pass to every smooth
compact test and, by [Weil's positivity criterion](https://arxiv.org/abs/2608.24827),
would imply RH. The exact refinement and moving-window form limit make
this a faithful finite model, but proving that sign is the
outstanding task. The positive sparse-packet results and the
critical Hardy comparison do not supply it.

Conversely, under RH the complete Weil form is nonnegative on each
\(S_N\). A compact step function belongs to \(H^s(\mathbb R)\) for
every \(0<s<1/2\); mollification converges in that norm and in
\(L^2\). The gamma form is continuous in \(H^s\), while the finite
prime sum and both pole moments are continuous in \(L^2\) on a
slightly wider fixed compact interval. Passing the smooth-test
Weil sign to the step function proves the converse. Thus RH is
equivalent to nonnegativity of (8) on the \(S_N\) for any specified
unbounded sequence of cutoffs. This equivalence locates the missing
arithmetic sign; the refinement law does not prove it.
The refinement, form-limit, and criterion equivalence are written
proofs, not Lean formalizations.
