# Dyadic prime-cell cancellation in the complete fixed-clock Picone score

RH Agent3, 2026-09-16. Independently audited by the supervising RH thread and a separate mathematical worker. **Status:** two written unconditional partial payments of the complete original-\(F\) spatial score; the remaining score has no RH-scale bound, and this is not Lean formalized. The fixed clock \(s\ge0\) retains the full all-prime and prime-power history law.

Write \(Y\ge4\), \(j_s=h_0*\mathsf P_s\), \(h_0(t)=te^{-t/2}{\bf1}_{t\ge0}\), and
\[
\Phi_{Y,s}(x)=
\frac{j_s(\log(x/Y))^2{\bf1}_{x\ge Y}
-j_s(\log(x/(2Y)))^2{\bf1}_{x\ge2Y}}{xF(x)}.
\tag{1}
\]
The complete score is
\[
J_Y(s)=\sum_{p^k\ge Y}\log p\,\Phi_{Y,s}(p^k)
-\int_Y^\infty\Phi_{Y,s}(x)dx.
\tag{2}
\]
This is the birth-by-birth Picone identity in the [companion form note](factorial-f-ground-clocked-birth-picone-spatial-score.md), with the atom at \(2Y\) in the old-base term and no deleted density cell. The source metric and full \(F\) remain unchanged.

## An exact dyadic and prime-power decomposition

Let \(I_j=[2^jY,2^{j+1}Y)\), \(j\ge0\), and define
\[
P_j=\sum_{p\in I_j}\log p\,\Phi_{Y,s}(p),\quad
D_j=\int_{I_j}\Phi_{Y,s}(x)dx,\quad
P_j^{\rm pow}=\sum_{\substack{p^k\in I_j\\k\ge2}}\log p\,\Phi_{Y,s}(p^k).
\]
Then the absolutely convergent, endpoint-exact decomposition is
\[
\boxed{\quad J_Y(s)=\sum_{j\ge0}(P_j-D_j)+
\sum_{j\ge0}P_j^{\rm pow}.\quad} \tag{3}
\]
The terms \(P_j,D_j\) are individually signed for \(j\ge1\). On \(I_0=[Y,2Y)\), the minimum positive age is \(\log2\), so \(j_s(t)=p_s t e^{-t/2}\), \(p_s=e^{-\lambda s}\), and
\[
\Phi_{Y,s}(x)
=p_s^2\,\frac{Y\log^2(x/Y)}{x^2F(x)}
=:W_{Y,s}(x)\ge0
\qquad(Y\le x<2Y).
\tag{4}
\]
This is exact for every fixed \(s\); all later histories remain in \(j\ge1\).

**Proposition 1 (all proper-power observation atoms paid).** Uniformly in \(s\ge0\),
\[
\boxed{\quad
\left|\sum_{j\ge0}P_j^{\rm pow}\right|
\ll \frac{\log^2(2Y)}{\sqrt Y}.
\quad} \tag{5}
\]
Indeed \(\sup_t j_s(t)\le\sup_t h_0(t)=2/e\), since \(\mathsf P_s\) is a probability law, and \(F\ge c_F>0\) for \(x\ge2\). On \(I_j\), \(M=2^jY\), this gives \(|\Phi(x)|\le C/M\). The number of proper powers \(p^k\in[M,2M)\) is at most
\[
\sum_{2\le k\le\log_2(2M)}(2M)^{1/k}
\ll \sqrt M\log(2M).
\]
Their total von Mangoldt weight is at most \(C\sqrt M\log^2(2M)\). Hence \(|P_j^{\rm pow}|\ll M^{-1/2}\log^2(2M)\), and the geometric sum over \(j\) proves (5). This does **not** remove proper-power histories from \(j_s\) or from the actual ground \(F\); it pays only their observing atoms.

**Proposition 2 (a growing lower endpoint collar paid).** For \(1\le h\le Y\), the complete score from \([Y,Y+h)\) is bounded by
\[
\boxed{\quad
\left|\int_{[Y,Y+h)}W_{Y,s}(x)dE(x)\right|
\ll p_s^2\frac{h^2}{Y^3}
\bigl((h+2)\log(2Y)+h\bigr).
\quad} \tag{6}
\]
Here \(W_{Y,s}(Y)=0\), \(W_{Y,s}(x)\le C p_s^2h^2/Y^3\), there are at most \(h+2\) integer locations, and \(\Lambda(n)\le\log(2Y)\); the density mass has length \(h\). No PNT cancellation is used. In particular, for any fixed \(0<\eta<5/6\), taking \(h=Y^{5/6-\eta}\) pays a growing collar with
\[
\int_{[Y,Y+h)}W_{Y,s}\,dE
=O_\eta(Y^{-1/2-2\eta})
\tag{7}
\]
uniformly in \(s\) after absorbing \(\log Y\). This is stronger than the RH target on that collar. The double zero of \(j_s(t)^2\) at the hard lower endpoint is essential. The upper endpoint \(2Y\) has no corresponding zero of the old-base weight.

## The remaining order-one prime/density cancellation

The full first-block signed score is exactly
\[
L_Y(s):=\int_{[Y,2Y)}W_{Y,s}\,dE
=W_{Y,s}(2Y)E((2Y)^-)-W_{Y,s}(Y)E(Y^-)
-\int_Y^{2Y}E(x)W_{Y,s}'(x)dx.
\tag{8}
\]
The \(2Y\) prime-power atom is excluded from this block and retained in the next block; \(W(Y)=0\). The endpoint carrier \(W(2Y)E((2Y)^-)\) is not paid by (6). The classical PNT error gives only a subpower bound for (8), not \(Y^{-1/2+\epsilon}\).

The opposing cell signs do not create a one-sided estimate. For all large \(Y\),
\[
\frac{xW_{Y,s}'(x)}{W_{Y,s}(x)}
=\frac2{\log(x/Y)}-2+r(\log x)>0
\qquad(Y<x<2Y),
\tag{9}
\]
where \(r(u)=E(e^u)/(e^uF(e^u))=o(1)\) by PNT. Thus each prime cell \(n\in(Y,2Y)\) contributes
\(\log n\,W(n)-\int_{n-1}^{n}W>0\), while each non-prime-power composite cell contributes \(-\int_{n-1}^{n}W<0\). Proper powers are not assigned a uniform cell sign, since \(\Lambda(2^k)=\log2<1\). The sign alternation is real, but both sides have order-one total mass. In fact \(F(Yv)\to\kappa_F\) uniformly on \(1\le v\le2\), and PNT weighted by the fixed smooth shape gives
\[
\sum_{Y\le p<2Y}\log p\,W_{Y,s}(p)
=\int_Y^{2Y}W_{Y,s}(x)dx+o(1)
=\frac{p_s^2}{\kappa_F}
\left(1-\log2-\frac{(\log2)^2}{2}\right)+o(1).
\tag{10}
\]
The proper-power total is \(O(Y^{-1/2}\log^2Y)\) by (5). Thus the prime and density masses cancel at leading order, but (9) supplies no sign or power rate for their difference.

For a possible explicit-formula test, freeze \(F=\kappa_F\) only in the **linearized diagnostic**, not in (1)--(10). A formal Chebyshev zero mode \(E(x)=c_\rho x^\rho\), \(1/2<\Re\rho<1\), contributes to the first block
\[
\frac{p_s^2c_\rho\rho}{\kappa_F}\,
Y^{\rho-1}C(\rho),\qquad
C(\rho)=\int_1^2v^{\rho-3}\log^2v\,dv
=\int_0^{\log2}t^2e^{(\rho-2)t}dt.
\tag{11}
\]
This is a diagnostic conditional on a justified explicit-formula expansion and a power domain for the \(F\) correction. The kernel is not identically blind: two integrations by parts show, uniformly for \(1/2\le\Re\rho\le1\), that \(C(\rho)\ne0\) whenever \(|\rho-2|\ge12\). Indeed, with \(z=\rho-2\), \(L=\log2\),
\[
C(\rho)=\frac{L^2e^{zL}}z-\frac{2Le^{zL}}{z^2}
+\frac{2(e^{zL}-1)}{z^3},
\]
whose leading modulus is at least \(L^2 2^{-3/2}/|z|\), while the remainder is at most \(2L/|z|^2+4/|z|^3\), smaller for \(|z|\ge12\). Low-height zeros and nonlinear interactions are not ruled out by this kernel calculation, so no local RH criterion is claimed.

Equations (3), (5), and (7) leave a precise actual-source obligation: the signed prime-minus-density correlation on the remainder of \([Y,2Y)\) and all later dyadic blocks, retaining the complete clock and \(F\), must gain beyond PNT. Its first-block prime and density pieces are each asymptotic to the same positive constant (10), while the surviving upper endpoint carrier in (8) can have either sign. The paid proper powers and lower collar are genuinely smaller than the RH scale; no estimate here bounds the remaining correlation or proves RH.
