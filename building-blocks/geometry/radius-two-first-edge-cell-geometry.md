# First radius-two edge-cell geometry and integral ledger

The canonical rational window at radius two is

\[
 W_M=\{u:|u|\le M,\quad |u|\ge 2+M^{-1}\}.
\]

The labelled start cell at \(M=4,L=0\) is
\(I_k=[k-4,k-3)\), \(0\le k<8\). For a prime power
\(q\in\{2,3,4\}\), orientation \(\sigma\in\{+,-\}\), and
\(d_q=\log q\), the actual edge parameter interval is

\[
 D_{q,\sigma,k}
   =I_k\cap W_4\cap(W_4-\sigma d_q).
\tag{1}
\]

Endpoints of half-open cells are immaterial to the continuous edge
measure. The following are the sixteen nonempty intervals (all endpoints
are exact):

| \(q\) | \(\sigma\) | \(k\) | start interval \(D_{q,\sigma,k}\) |
|---:|:---:|---:|:---|
| 2 | + | 0 | \((-4,-3)\) |
| 2 | + | 1 | \((-3,-9/4-\log2)\) |
| 2 | + | 6 | \((9/4,3)\) |
| 2 | + | 7 | \((3,4-\log2)\) |
| 2 | − | 0 | \((-4+\log2,-3)\) |
| 2 | − | 1 | \((-3,-9/4)\) |
| 2 | − | 6 | \((9/4+\log2,3)\) |
| 2 | − | 7 | \((3,4)\) |
| 3 | + | 0 | \((-4,-9/4-\log3)\) |
| 3 | + | 6 | \((9/4,4-\log3)\) |
| 3 | − | 1 | \((-4+\log3,-9/4)\) |
| 3 | − | 7 | \((9/4+\log3,4)\) |
| 4 | + | 0 | \((-4,-9/4-\log4)\) |
| 4 | + | 6 | \((9/4,4-\log4)\) |
| 4 | − | 1 | \((-4+\log4,-9/4)\) |
| 4 | − | 7 | \((9/4+\log4,4)\) |

Lean proves that this list has sixteen distinct labels, all intervals
have positive length, and every point in each listed interval satisfies
(1), using proved bounds
\(2/3<\log2<3/4\), \(1<\log3<3/2\), and
\(4/3<\log4<3/2\). It also checks all
\(3\cdot2\cdot8=48\) possible labels: every label with an actual cell
point occurs in this list, and every actual cell point for a listed
label lies in its displayed closed interval. Hence exactly sixteen
labelled cells are nonempty. The endpoint convention does not affect
the continuous edge integrals.

At \(M=2\), \(W_2=\varnothing\). At \(M=3\), each exterior component
has length \(2/3\), shorter than the smallest displacement \(\log2\),
while opposite components are separated by more than \(\log3\). Lean
proves no directed \(q=2,3\) edge occurs at either orientation. The
module also proves the stronger \(M=3\) exclusion for \(q=4\), although
\(q=4\) is not admitted until \(M=4\).

For each listed interval \(D=[l,h]\) in the sense of integration, put
\(v=u+\sigma\log q\), \(q=p^k\), and

\[
 \omega_{q,\sigma}(u)=
 \frac{\log p}{p^{k/2}}\,
 \frac{\psi_2(u)\psi_2(v)\Phi(u)\Phi(v)}
      {(a+\ell(u))(a+\ell(v))}.
\tag{2}
\]

Here \(a=\gamma(O)\) and \(\ell\) is the full prime-power departure rate;
no \(q\le4\) truncation is made inside either denominator. Its cell mass
and observation of a vertex source \(F\) are exactly

\[
 m_D=\int_l^h\omega_{q,\sigma}(u)\,du,\qquad
 \mathfrak o_D(F)=
 \frac1{\sqrt{2m_D}}\int_l^h
       \bigl(F(v)-F(u)\bigr)\omega_{q,\sigma}(u)\,du.
\tag{3}
\]

Thus the two Galerkin target columns and complete crossing action from
the [range audit](../dynamics-and-feedback/collective-lambert-first-source-galerkin-audit.md)
are the explicit interval integrals

\[
 b_{\lambda,D}(\theta)=\mathfrak o_D(Y_\lambda(\theta)),
 \qquad
 T_{D,j}=\mathfrak o_D(\mathcal S_2\phi_j),
 \quad \lambda=1,2,\quad j=0,\ldots,4.
\tag{4}
\]

To make (4) independent of an undefined source convention, its vertex
functions are exactly

\[
\begin{aligned}
 Z_1(\theta,u)&=d(u)\,
   1_{\Theta_X(e^u)}(\theta)\,
   h(e^u)c_{1,X}(e^u)e^{i\theta},\\
 Z_2(\theta,u)&=d(u)\,
   1_{\Theta_X(e^u)}(\theta)\,
   h(e^u)s_X(e^u)c_{1,X}(e^u)e^{2i\theta},\\
 d(u)&=\left[
   \frac{e^uw(e^u)}
        {\rho(u)\psi_2(u)b(u)\Phi(u)}\right]^{1/2},
 \qquad
 Y_\lambda=Z_\lambda-a^{-1}\int_OZ_\lambda\,d\gamma.
\end{aligned}
\tag{5}
\]

For each even core hat \(\phi_j\), put
\[
\begin{aligned}
 B_2\phi_j(u)
 &=\frac1{b(u)}\int_Cr(|u-v|)\Phi(v)\phi_j(v)\,dv\\
 &\quad+\frac1{b(u)}
  \sum_{p}\sum_{k\ge1}\frac{\log p}{p^{k/2}}
  \sum_{\epsilon=\pm1}
  1_C(u+\epsilon k\log p)\,
  \Phi(u+\epsilon k\log p)\phi_j(u+\epsilon k\log p),\\
 \mathcal S_2\phi_j(u)
 &=\rho(u)^{-1}
   \left(B_2\phi_j(u)
       -\frac{\langle B_2\phi_j,\psi_2\rangle_\nu}
              {\langle1_O,\psi_2\rangle_\nu}\right).
\end{aligned}
\tag{6}
\]
This is the published
[core-to-exterior operator](../theta-and-heat/theta-killed-core-return-comparison.md#1-a-hard-spatial-split-is-legitimate-despite-the-infinite-activity)
and its ground centering. Substituting (5) and (6) into (3) is an
explicit interval-integral formula for every \(b_{\lambda,D}\) and
\(T_{D,j}\). The continuous and all-power crossing terms remain inside
the same difference and integral before squaring. The ground profile
\(\psi_2\), complete \(\ell\), and these target/action integrals have no
validated enclosures in the repository. This geometry does not establish
either source range equation, the finite Schur test, or RH.

[RadiusTwoEdgeCellGeometry.lean](../../formalization/BuildingBlocks/RadiusTwoEdgeCellGeometry.lean)
contains the checked finite geometry and the definition (3) as an
interval integral with the exact \(q\)-weights. It introduces no analytic
eigenfunction data.
