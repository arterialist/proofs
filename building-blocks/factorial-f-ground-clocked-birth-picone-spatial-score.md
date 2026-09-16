# Full fixed-clock spatial score as a polarized factorial Picone birth form

RH Agent3, 2026-09-16. Independently audited by the supervising RH thread and a separate mathematical worker. **Status:** written exact original-metric bridge and source-uniform obstruction, not an unconditional RH-scale estimate or Lean formalization. This keeps the actual factorial ground \(F\), the original \(L^2((1,\infty),dx)\) metric, all prime-power observations, the continuous negative density, the seed, and the complete prime-history age law.

Let \(\mathsf P_s\) be the complete positive probability law of the clock age, including its no-jump atom \(p_s=e^{-\lambda s}\) and every prime/proper-power history. Put
\[
h_0(t)=t e^{-t/2}{\bf1}_{t\ge0},\quad
j_s=h_0*\mathsf P_s,\quad
\beta_z(x)=\frac{{\bf1}_{x\ge z}}x,\quad
\ell_z=H\beta_z=\frac{{\bf1}_{x\ge z}\log(x/z)}x.
\tag{1}
\]
Here \(Hf(x)=x^{-1}\int_1^x f(y)dy\). For \(Y\ge2\), define the **clocked literal-birth source**
\[
b_{Y,s}(x)=\sqrt Y\int_{[0,\infty)}e^{a/2}\beta_{Ye^a}(x)\,\mathsf P_s(da),
\qquad h_{Y,s}=Hb_{Y,s}
=x^{-1/2}j_s(\log(x/Y)).
\tag{2}
\]
The factor \(e^{a/2}\) is essential: it is the original-\(L^2\) isometric dilation amplitude. The Bochner integral exists in \(L^2\), since
\(\|\sqrt Y e^{a/2}\beta_{Ye^a}\|_2=1\) for every \(a\); no exponential moment of \(\mathsf P_s\) is needed. Equation (2) follows by direct substitution into \(H\), with all moving endpoints retained. In particular \(b_{2Y,s}=D_2b_{Y,s}\) for \(D_2f(x)=2^{-1/2}f(x/2)\) with the causal zero extension below \(1\). This is an isometry into \(L^2((1,\infty))\), not a unitary operator onto that half-line.

## Exact Picone and birth-wise identities

Set
\[
\mathcal P_F(h,k)=\sum_{n\ge2}\frac{\Lambda(n)h(n)\overline{k(n)}}{F(n)},
\quad
\mathcal C_F(h,k)=\int_1^\infty\frac{h(x)\overline{k(x)}}{F(x)}dx,
\quad
R_Fb=b-(1+b_F)Hb,\ b_F=xF'/F.
\tag{3}
\]
The maximal-domain Picone theorem for the actual \(F\) applies to every \(b_{Y,s}\in L^2\), so
\[
\mathcal G_{Y,s}:=\int_{[Y,\infty)}
\frac{j_s(\log(x/Y))^2}{xF(x)}\,dE(x)
=\mathcal P_F(h_{Y,s})-\mathcal C_F(h_{Y,s})
=\|b_{Y,s}\|_2^2-\|R_Fb_{Y,s}\|_2^2.
\tag{4}
\]
All three terms are separately finite. Indeed \(h_0,h_0'\in L^2\), so convolution with the probability \(\mathsf P_s\) gives \(j_s\in H^1(\mathbb R_+)\) with \(\|j_s\|_{H^1}\le\|h_0\|_{H^1}\). The continuous term is \(\int_0^\infty j_s(t)^2/F(Ye^t)\,dt<\infty\). For each unit interval \(t\in[k,k+1]\), Chebyshev's elementary upper bound gives \(\sum_{Ye^k\le n<Ye^{k+1}}\Lambda(n)/n\le C\); the one-dimensional Sobolev bound on \(\sup_{[k,k+1]}j_s^2\), summed over \(k\), controls the prime term by \(C\|j_s\|_{H^1}^2/\inf_{x\ge Y}F(x)\). The closed-domain Picone identity then applies. The norm in (4) is exactly scale independent:
\[
\|b_{Y,s}\|_2^2
=\iint e^{-|a-b|/2}\,\mathsf P_s(da)\mathsf P_s(db)
=:c_s\in(0,1].
\tag{5}
\]
Consequently the **complete fixed-clock spatial jump** has the exact signed form
\[
\boxed{\quad
J_Y(s)=\mathcal G_{Y,s}-\mathcal G_{2Y,s}
=\|R_Fb_{2Y,s}\|_2^2-\|R_Fb_{Y,s}\|_2^2.
\quad} \tag{6}
\]
There is no omitted radial metric term or prime-birth diagonal. The original source norms cancel *because* the two clocked births are isometric dilates. In polarized notation, with \(U=b_{Y,s}+b_{2Y,s}\) and \(V=b_{Y,s}-b_{2Y,s}\), \(\langle U,V\rangle=0\) but
\[
J_Y(s)=-\operatorname{Re}\langle R_FU,R_FV\rangle.
\tag{7}
\]
This is a ground-gradient cross, not a positive square.

For a literal birth-by-birth expansion define
\[
\Phi_{Y,s}(x)=\frac{|h_{Y,s}(x)|^2-|h_{2Y,s}(x)|^2}{F(x)}.
\]
Since \(dE=\sum_{n\ge2}\Lambda(n)\delta_n-dx\), partitioning the density into \([n-1,n)\) gives
\[
\boxed{\quad
J_Y(s)=\sum_{n\ge2}
\left[\Lambda(n)\Phi_{Y,s}(n)
-\int_{n-1}^{n}\Phi_{Y,s}(x)\,dx\right].
\quad} \tag{8}
\]
Both the prime-power and density series converge absolutely at fixed \(s\). At \(n=2Y\), if it is a prime power, \(h_{2Y,s}(2Y)=0\) while \(h_{Y,s}(2Y)\) is retained. On \(Y\le x<2Y\), \(\Phi_{Y,s}(x)\ge0\), so each prime-power atom has a positive *atomic* contribution and the paired density cell a negative one; no sign follows for their difference. Farther out, even \(\Phi\) changes sign at \(s=0\): with \(t=\log(x/Y)\), \(H_0(t)-H_0(t-\log2)\) changes sign at \(t=(2+\sqrt2)\log2\). At \(s>0\), the complete history profile can add further sign changes.

There is an actual-source sign check in the entire first window. For \(Y\le x<2Y\), the clock law has no nonzero age below \(\log2\), so \(j_s(t)=p_s t e^{-t/2}\) exactly and
\(\Phi_{Y,s}(x)=p_s^2Y\log^2(x/Y)/(x^2F(x))\). For large \(Y\), PNT gives \(r(\log x)=o(1)\), and
\[
\frac{x\Phi_{Y,s}'(x)}{\Phi_{Y,s}(x)}
=\frac2{\log(x/Y)}-2+r(\log x)>0
\qquad(Y<x<2Y).
\]
Hence a prime \(n\in(Y,2Y)\) has a **positive complete cell contribution** in (8), since \(\Lambda(n)=\log n>1\) and \(\int_{n-1}^n\Phi\le\Phi(n)\); a non-prime-power composite cell in the same interval has a **negative** contribution. Both types occur for all large \(Y\). This is a concrete actual-source failure of termwise sign, with the density ramp and first prime-power threshold retained.

The clock histories are also polarized exactly. Writing
\[
b_{Y,s}=p_s\sqrt Y\,\beta_Y+b_{Y,s}^{+},\qquad
h_{Y,s}=p_s\sqrt Y\,\ell_Y+h_{Y,s}^{+},
\tag{9}
\]
where the plus term integrates \(a>0\), the history self-form in (4) is
\[
\mathcal G_{Y,s}
=p_s^2Y\,\mathcal A_F(\ell_Y,\ell_Y)
+2p_s\sqrt Y\,\mathcal A_F(\ell_Y,h_{Y,s}^{+})
+\mathcal A_F(h_{Y,s}^{+},h_{Y,s}^{+}),
\quad \mathcal A_F=\mathcal P_F-\mathcal C_F.
\tag{10}
\]
The pointwise prime and density cross integrands in (10) are each nonnegative because the histories are positive. Their **difference** has no sign, and subtraction of the \(2Y\) version adds a second signed comparison. Every proper-power and multi-prime clock history stays inside \(\mathsf P_s\).

For each pair of concrete history endpoints \(z,z'\ge Y\), the polarized contribution is explicitly
\[
\mathcal A_F(\ell_z,\ell_{z'})
=\sum_{p^k\ge\max(z,z')}\frac{\log p\,\log(p^k/z)\log(p^k/z')}{(p^k)^2F(p^k)}
-\int_{\max(z,z')}^\infty
\frac{\log(x/z)\log(x/z')}{x^2F(x)}dx.
\tag{10a}
\]
Thus the positive prime-power cross and positive density cross are both kept before taking their signed difference. Equation (10) is the \(\mathsf P_s\otimes\mathsf P_s\) average of (10a), with its no-jump/history and history/history cross terms intact.

The original frozen-source seed is visible but does not pay (10). With \(g_1(x)=-1/x\),
\[
\langle g_1,b_{Y,s}\rangle
=-Y^{-1/2}\int e^{-a/2}\mathsf P_s(da).
\tag{11}
\]
Its Picone polarization is exact, but (6) is a self-form difference of two clocked births; it contains no free negative seed term. Nor is \(b_{Y,s}\) an actual finite-horizon innovation \(v_n=\Lambda(n)\beta_n-\int_{n-1}^n\beta_tdt\): the latter carries its compulsory density ramp. Replacing \(b_{Y,s}\) by a prime-only birth would lose that ramp and the exact norm cancellation.

## What the original metric can and cannot bound

Write \(R_0=I-H\). Hardy's exact identity makes \(R_0\) an isometry on the original \(L^2\). Since \(b_F=-r\), \(r(x)=E(x)/(xF(x))\), one has
\[
R_Fb_{Y,s}=R_0b_{Y,s}+r\,h_{Y,s},
\]
and therefore
\[
\boxed{\quad
\mathcal G_{Y,s}
=-2\operatorname{Re}\langle R_0b_{Y,s},r h_{Y,s}\rangle
-\|r h_{Y,s}\|_2^2.
\quad} \tag{12}
\]
This is the signed seed/history crossing in the original metric. Since \(\|b_{Y,s}\|_2\le1\), \(\|h_{Y,s}\|_2\le2\), and both supports lie in \(x\ge Y\),
\[
|J_Y(s)|\le 8\sup_{x\ge Y}|r(\log x)|
+8\sup_{x\ge Y}|r(\log x)|^2.
\tag{13}
\]
PNT makes (13) \(o(1)\), and a classical zero-free-region bound makes it subpower in \(Y\). It does not reach \(Y^{-1/2+\epsilon}\). The term requiring new cancellation is the difference of the two first cross terms in (12), together with its exact quadratic reserve. An RH-scale bound on the supremum in (13) is already an RH-scale bound on \(E\), so it cannot be used as an independent payment.

The known original-metric Picone bound \(\|R_Fb\|\le101\|b\|\) gives only \(O(1)\) in (6). A fixed-horizon \(Q_N=\|g_N\|_2^2\) cannot control the future score from its value alone: \(Q_N\) depends only on \(E(x)\) up to \(N\), whereas (8) includes every observing prime power \(n>N\). Here is a coupled positive-source witness for any large \(Y\). Let \(\psi_0=0\) on \([1,2)\), have an atom of mass \(2\) at \(2\), and equal \(x\) thereafter. Its ground equals \(\log2\) on \(x\ge2\). Choose an integer \(m\in(Y,2Y)\) with \(m/Y\to\theta\in(1,2)\), and add a single positive atom \(\alpha=\eta m\), \(0<\eta<\log2/2\), at \(m\). Then \(E=0\) on \([2,m)\), \(E=\alpha\) afterward, \(F(m)=\log2\), and \(F(x)\to\log2-\eta>0\). For every \(2\le N<m\), the frozen source and its original norm \(Q_N=1\) are exactly the same as before the new atom, while
\[
J_Y(s)=\frac{\alpha}{mF(m)}j_s(\log(m/Y))^2
\longrightarrow\frac{\eta}{\log2}j_s(\log\theta)^2>0.
\tag{14}
\]
The \(2Y\)-birth term vanishes at \(m\), and the continuum density after \(Y\) is zero in this model, so (14) is exact. This is **not** the actual \(\Lambda\) source: its atom is macroscopic and violates \(\Lambda(m)\le\log m\). It proves only that Picone positivity, full-\(F\) coupling, and a fixed \(Q_N\) value furnish no source-uniform RH-scale transfer. The actual atom envelope plus the exact Euler relation are used by the separate Tauberian/pole criterion; neither gives an unconditional bound for the score.

Thus (6) is a genuine form-preserving bridge, but it leaves an indefinite cross with no known actual-source sign or RH-scale upper estimate. Any proof of the latter would satisfy the independently established [RH-equivalent full-score criterion](factorial-f-ground-full-score-rh-criterion.md). This note derives no such estimate and assumes no RH premise.
