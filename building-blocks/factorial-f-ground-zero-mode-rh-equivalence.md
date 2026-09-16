# The rank-one zero mode is itself an RH-equivalent source observable

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 analytic classification, 2026-09-16. This note prevents a scalar reduction of the true later-clock Picone matrix from being mistaken for a new unconditional bound. Fix an integer \(A\ge3\) and let
\[
M_A(Y)=\int_{(A-1,Y]}y^{-1/2}\,dE(y)
=\sum_{A\le n\le Y}\frac{\Lambda(n)}{\sqrt n}
-2\bigl(\sqrt Y-\sqrt{A-1}\bigr),\qquad Y\ge A-1, \tag{1}
\]
where \(E=\psi-x\), every prime power is included, and the lower endpoint is open. This is the exact prefix zero mode in the preceding prefix–block rank-one note.

The family of estimates
\[
M_A(Y)=O_\epsilon(Y^\epsilon)\quad\text{for every }\epsilon>0 \tag{2}
\]
is equivalent to RH. In the forward direction, integration by parts against \(dM_A(y)=y^{-1/2}dE(y)\) gives
\[
E(Y)-E(A-1)
=Y^{1/2}M_A(Y)-\frac12\int_{A-1}^{Y}M_A(y)y^{-1/2}\,dy. \tag{3}
\]
Thus (2) yields \(E(Y)=O_\epsilon(Y^{1/2+\epsilon})\). In the half-plane \(\Re s>1\),
\[
\int_1^\infty E(x)x^{-s-1}dx
=\frac{-\zeta'(s)/\zeta(s)}s-\frac1{s-1}. \tag{4}
\]
The bound for \(E\) makes the left side holomorphic in every compact subset of \(\Re s>1/2\). Equation (4) then excludes zeta zeros in that open half-plane; the functional equation gives RH.

Conversely, the classical explicit-formula consequence of RH, \(E(Y)=O(Y^{1/2}\log^2(2Y))\), inserted into
\[
M_A(Y)=Y^{-1/2}E(Y)-(A-1)^{-1/2}E(A-1)
+\frac12\int_{A-1}^{Y}E(y)y^{-3/2}\,dy, \tag{5}
\]
gives \(M_A(Y)=O_A(\log^3(2Y))\), hence (2).

The zero-mode addition \(M_A(2Y-1)=M_A(Y-1)+M_Y(2Y-1)\) is exact and useful for locating the block kernel variation. But assuming (2) to control the rank-one baseline would already assume an RH-equivalent arithmetic estimate. The proven PNT envelope only gives \(M_A(Y)\ll_A\sqrt Y\,e^{-a\sqrt{\log Y}}\); heavy-age smoothing acts on the observing ground kernel and does not independently improve this source zero mode. No RH claim follows from the current rank-one identities.
