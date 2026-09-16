# Exact successor-cell prime refinement and a terminal-source collar limit

Written mathematical audit, 17 September 2026. The cells below tile
the entire localized Weil window and turn every admitted prime-power
translation into an exact division/refinement row. This differs from
the sparse resolved packets in the
[growing positive-space theorem](compact-weil-boundary-packet-growing-positive-space.md).
The [actual terminal prime-lag reversal](actual-terminal-prime-natural-lag-phase-reversal.md)
does **not** give a negative or positive test for the corresponding
window edge: its full autocorrelation is carried at Laplace scales
discarded by that narrow edge. The pole and gamma terms remain in
the matrix throughout.

## Cells, endpoints, and the complete prime matrix

For an integer \(N\ge2\), set
\[
 L=\tfrac12\log(N+1),\quad
 I_n=(L-\log(n+1),\,L-\log n],\quad
 \ell_n=\log(1+1/n),\quad
 e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\quad(1\le n\le N).
 \tag{1}
\]
The cells partition \((-L,L]\) exactly. With
\(U_yf(v)=f(v-y)\), the left translation by \(\log d\) satisfies
\[
 I_n-\log d
 =\bigsqcup_{r=dn}^{d(n+1)-1} I_r.
 \tag{2}
\]
The union is fully inside the window precisely when
\(d(n+1)\le N+1\). Otherwise the window clips it at the left
endpoint; no fractional terminal cell is hidden:
\[
 \mathbf1_{(-L,L]}U_{-\log d}e_n
 =\sum_{r=dn}^{\min(N,d(n+1)-1)}
      \sqrt{\frac{\ell_r}{\ell_n}}\,e_r,
 \tag{3}
\]
where an empty sum is zero. Thus for cell values
\(f(v)=b_n\) on \(I_n\),
\[
 \langle f,U_{-\log d}f\rangle
   =\sum_{r=d}^N\ell_r\overline{b_r}\,
       b_{\lfloor r/d\rfloor}.
 \tag{4}
\]
For each fixed \(d\), the full interior columns of (3) have
norm one and disjoint child supports. The opposite compressed
shift is the adjoint of (3); a single right-translated child
need not itself be a step function.

Let \(V_N=\operatorname{span}\{e_1,\ldots,e_N\}\). Every
\(e_n\) lies in the logarithmic gamma form domain: its Fourier
transform is \(O_n((1+|\xi|)^{-1})\), while the archimedean
multiplier grows only as \(O(\log(2+|\xi|))\). With
\[
 H(\xi)=\Re\psi(1/4+i\xi/2)-\log\pi,\qquad
 E_\pm(f)=\int_{-L}^L e^{\pm v/2}f(v)dv,
 \tag{5}
\]
the *complete* localized Weil form on \(V_N\) is exactly
\[
 \boxed{\quad
 Q_L(f)
 =2\Re(E_+(f)\overline{E_-(f)})
  +\frac1{2\pi}\int_{\mathbb R}
       H(\xi)|\widehat f(\xi)|^2d\xi
  -2\Re\sum_{d=2}^N\frac{\Lambda(d)}{\sqrt d}
       \sum_{r=d}^N\ell_r\overline{b_r}
          b_{\lfloor r/d\rfloor}.
 \quad}                                                   \tag{6}
\]
The finite sum retains every prime power with
\(\log d<2L=\log(N+1)\), both orientations, and the complete
boundary truncation. The pole in (6) has either sign for general
complex tests; the gamma multiplier is negative at low frequency.
Replacing the last term by positive difference squares also
introduces the exact diagonal
\[
 -2\Re\langle f,B_df\rangle
  =\|f-B_df\|_2^2-\|f\|_2^2-\|B_df\|_2^2,
 \tag{7}
\]
where \(B_d\) is (3). The two negative norms in (7) cannot be
dropped or paid by Balazard's scalar divisor bound alone.

On each fixed compact subinterval of the real line, the mesh
\(\max\ell_n\) is \(O(N^{-1/2})\): the relevant labels have
\(n\asymp\sqrt N\). In fact, let \(P_N\) take cell averages
and zero-extend them outside \((-L,L]\). For every fixed
\(f\in C_c^\infty(\mathbb R)\) and \(0<s<1/2\),
\[
 \|P_Nf-f\|_{H^s(\mathbb R)}
   =O_{f,s}(N^{-(1-s)/2})\longrightarrow0.          \tag{8}
\]
Here is a direct form-domain check. On a fixed support collar the
cell lengths are comparable to \(h=N^{-1/2}\), and the
\(L^2\) cell-average error is \(O_f(h)\). In the Gagliardo
\(H^s\) seminorm, pairs at distance at least \(h\) contribute
\(O_f(h^{2-2s})\) to the square. At shorter distance, the
same-cell differences are \(O_f(|x-y|)\); adjacent-cell jumps
are \(O_f(h)\), and each of the \(O_f(h^{-1})\) interfaces
has integral \(O_s(h^{3-2s})\). This gives the same squared
bound and proves (8). Since
\(|H(\xi)|\ll_s1+|\xi|^{2s}\), the gamma form converges;
the poles converge on the common compact support. Only finitely
many prime shifts can meet that support, and their overlaps
converge in \(L^2\). Thus
\[
 Q_{L_N}(P_Nf)\longrightarrow Q_W(f)
 \qquad(f\in C_c^\infty(\mathbb R)).
 \tag{9}
\]
The dense cell route is therefore a genuine full-form route, not
a sparse-support artifact. Establishing a nonnegative lower
bound for (6) on all these vectors would still be the missing
Weil/RH sign estimate; (8)--(9) do not provide it.

## What the actual terminal lag sees after the hard window

Let \(d\sigma_N\) be the literal zero-charge terminal source and
\[
 F_N(t)=\int_{[1,N]}e^{-tx}d\sigma_N(x),\qquad
 b_N(v)=e^{-v/2}F_N(e^{-v}),\qquad
 V_N^{\rm TV}=|\sigma_N|([1,N]).
 \tag{10}
\]
Here \(V_N^{\rm TV}\) is a scalar total variation, distinct from
the cell space \(V_N\). Since the source is supported in
\([1,N]\),
\[
 |F_N(t)|\le V_N^{\rm TV}e^{-t},\qquad
 V_N^{\rm TV}
 \le\psi(N)+N+|\psi(N)-N|
 \le2N(1+\log N).
 \tag{11}
\]
The complete, unwindowed autocorrelation at the real lag \(k=N\)
is
\[
 q_N(N)
  =\frac1N\int_0^\infty F_N(t)F_N(t/N)dt.
 \tag{12}
\]
For \(M_L=\mathbf1_{(-L,L]}\), its hard-window counterpart is
exactly
\[
 \begin{aligned}
 q_N^{\rm win}(N)
 &:=\frac{C_{M_Lb_N}(\log N)}{\sqrt N}\\
 &=\frac1N\int_{N/\sqrt{N+1}}^{\sqrt{N+1}}
       F_N(t)F_N(t/N)dt .
 \end{aligned}                                             \tag{13}
\]
The interval in (13) has length \(1/\sqrt{N+1}\) and sits near
\(\sqrt N\). Equations (11)--(13) give the unconditional bound
\[
 \boxed{\quad
 |q_N^{\rm win}(N)|
 \le\frac{(V_N^{\rm TV})^2}{N\sqrt{N+1}}\,
      e^{-N/\sqrt{N+1}}.
 \quad}                                                   \tag{14}
\]
At the certified prime \(N=18553\), the exact calculation in the
[natural-lag theorem](actual-terminal-prime-natural-lag-phase-reversal.md)
gives \(q_N(N)>11349/N^2\). By contrast, (11) and (14) give
\(|q_N^{\rm win}(N)|<10^{-38}\): use
\(\log N<11\), \(N/\sqrt{N+1}>130\),
\(\sqrt N<137\), and \(e^{130}>10^{43}\).
The complete positive lag signal is therefore absent from this
hard-window prime edge.

The cell projection of \(M_Lb_N\) has the same limitation.
At \(d=N\), (3) has only the arrow \(e_1\to e_N\),
with coefficient \(\sqrt{\ell_N/\ell_1}\). If
\(\bar b_n=\ell_n^{-1}\int_{I_n}b_N(v)dv\), its prime
autocorrelation is
\(\ell_N\overline{\bar b_N}\bar b_1/\sqrt N\).
The left value \(\bar b_N\) contains
\(F_N(t)\) only for \(t\asymp\sqrt N\). More precisely,
the two cell suprema from (11) give
\[
 \left|\frac{\ell_N\overline{\bar b_N}\bar b_1}{\sqrt N}\right|
 \le\frac{\sqrt2\,\ell_N(V_N^{\rm TV})^2}{\sqrt N}
       e^{-N/\sqrt{N+1}}
 \le\frac{\sqrt2\,(V_N^{\rm TV})^2}{N\sqrt N}
       e^{-N/\sqrt{N+1}}.
 \tag{15}
\]
This projected edge is exponentially small as well.

The source-specific conclusion is limited: the full-source
\(q_N(N)>0\) certificate cannot be inserted as the sign of
the \(d=N\) edge of (6). It does not refute the dense
successor-cell method, nor does it compare the gamma and pole
terms of \(b_N\) with those of \(M_Lb_N\); those terms remain
explicit in (6) and are not discarded. Positivity of (6) on
all growing cell spaces, or a suitable source-specific signed
bound, remains unproved. This is written mathematics, not a
Lean formalization or an RH proof.
