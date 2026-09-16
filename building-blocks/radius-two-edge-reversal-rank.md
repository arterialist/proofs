# Reversal and the first radius-two observation rank

The [exact cell ledger](radius-two-first-edge-cell-geometry.md) orders its
sixteen labels as indices \(0,\ldots,15\). Reversing an edge sends
\((q,+,u,u+d_q)\) to \((q,-,u+d_q,u)\). The complete directed measure is

\[
 d\mathsf P_1(q,\sigma;u)=
 1_{E_4}(u)1_{E_4}(u+\sigma d_q)
 \frac{(\log p)p^{-k/2}\psi_2(u)\psi_2(u+\sigma d_q)
       \Phi(u)\Phi(u+\sigma d_q)}
 {(a+\ell(u))(a+\ell(u+\sigma d_q))}\,du,
 \qquad q=p^k\in\{2,3,4\}.
\tag{1}
\]

Here \(E_4\) is the *actual* symmetric vertex cutoff from the canonical
observation construction, including its ground and departure-rate
conditions. Formula (1) is invariant under reversal and translation
of the edge parameter. In particular, this argument keeps the full
prime-power departure rate \(\ell\), the \(q=4=2^2\) edge, and both
orientations. No numerical ground profile is used.

The \(q=3,4\) reversals pair complete cells:

| plus index | minus index | prime power/component |
|---:|---:|:---|
| 8 | 10 | 3, left |
| 9 | 11 | 3, right |
| 12 | 14 | 4, left |
| 13 | 15 | 4, right |

For \(q=2\), reversal cuts across the unit start-cell grid. On the left,
minus cell 4 reverses to the part of plus cell 0 with
\(-4<u<-3-d_2\); minus cell 5 reverses to the remaining part of plus
cell 0 and all of plus cell 1. On the right, minus cell 6 reverses to
the part of plus cell 2 with \(9/4<u<3-d_2\); minus cell 7 reverses to
the remaining part of plus cell 2 and all of plus cell 3. These
statements remain true after intersection with \(E_4\) at both ends.
Consequently reversal does **not** force pairwise equality of the eight
\(q=2\) cell masses. It gives precisely the two aggregate equalities

\[
 m_0+m_1=m_4+m_5,\qquad m_2+m_3=m_6+m_7,             \tag{2}
\]

as well as \(m_8=m_{10}\), \(m_9=m_{11}\), \(m_{12}=m_{14}\), and
\(m_{13}=m_{15}\). A zero-mass cell has zero observation by definition.

For any vertex function \(F\) whose edge difference is integrable, let

\[
 r_i(F)=\int_{D_i}(F(v)-F(u))\,d\mathsf P_1,
 \qquad b_i(F)=\begin{cases}r_i(F)/\sqrt{2m_i},&m_i>0,\\0,&m_i=0.
 \end{cases}                                                   \tag{3}
\]

The exact signed relations are

\[
\begin{aligned}
 r_0+r_1+r_4+r_5&=0,&r_2+r_3+r_6+r_7&=0,\\
 r_8+r_{10}&=0,&r_9+r_{11}&=0,\\
 r_{12}+r_{14}&=0,&r_{13}+r_{15}&=0.
\end{aligned}                                                  \tag{4}
\]

For positive masses, (4) is the corresponding relation with each
\(r_i\) replaced by \(\sqrt{2m_i}\,b_i\). The four complete-cell pairs
also give \(b_{10}=-b_8\), \(b_{11}=-b_9\), \(b_{14}=-b_{12}\), and
\(b_{15}=-b_{13}\). The first two relations are mass-weighted sums, not
pairwise sign rules. They apply equally to each target
\(b_{\lambda,i}(\theta)\) and each crossing-action column \(T_{i,j}\),
because both are observed through the same edge-gradient operator.
Fibrewise centering subtracts a constant and leaves every difference
unchanged.

An exact reduced raw-row choice is

\[
 (r_0,r_1,r_2,r_3,r_4,r_6,r_8,r_9,r_{12},r_{13}).          \tag{5}
\]

The other six rows are reconstructed by (4). Thus the sixteen directed
coordinates have **complex rank at most ten** (real rank at most twenty)
for any symmetric measure (1). This is a ceiling, not an assertion that
the actual ground-dependent target/action matrix has rank ten; some
cells may have zero mass or further dependencies. The corrected
common-plus-observation constraint count is at most \(2+2(10)=22\)
real rows at this stage. Reduction does not evaluate a Gram entry or
establish either weighted-source range equation.

[RadiusTwoEdgeReversalFinite.lean](BuildingBlocks/RadiusTwoEdgeReversalFinite.lean)
compiles the six linear relations and the two-sided reconstruction
identity for the ten raw rows without `sorry` or new axioms. The Lean
module assumes (4) as its analytic input; reversal invariance of (1)
and the interval partition above are the written measure argument.
