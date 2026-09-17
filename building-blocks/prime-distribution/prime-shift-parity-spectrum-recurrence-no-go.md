# Parity recurrence for finite prime shifts and a continuum-remainder no-go

Let \(I_a=(-a,a)\), and let \(S_\ell f(x)=f(x+\ell)\) with zero extension outside \(I_a\). For a finite set of positive lengths \(\ell_j\) and real coefficients \(c_j\), put
\[
 P=\sum_{j=1}^r c_j(S_{\ell_j}+S_{-\ell_j})
 \quad\text{on }L^2(I_a).
\tag{1}
\]
This bounded self-adjoint operator commutes with reflection. In [Suzuki's Weil form](https://arxiv.org/html/2606.09096v1), \(\ell_j=\log n\) and \(c_j=\Lambda(n)/\sqrt n>0\) for the finitely many prime powers with \(\log n<2a\), and the prime contribution to the quadratic form is \(-\langle f,Pf\rangle\).

**Theorem.** The restrictions \(P_+\) and \(P_-\) to the even and odd subspaces have the same spectrum, and every spectral point belongs to the essential spectrum:
\[
\sigma(P_+)=\sigma_{\rm ess}(P_+)=\sigma(P_-)=\sigma_{\rm ess}(P_-).
\]
In particular, their upper and lower Rayleigh extrema coincide. For Suzuki's positive coefficients,
\[
 \sup\sigma(P_a^{\rm odd})=\sup\sigma(P_a^{\rm even})=\|P_a\|.
\tag{2}
\]
Combining (2) with the [weighted Schur/PNT asymptotic](prime-shift-weighted-schur-window-asymptotic.md) gives \(\sup\sigma(P_a^{\rm odd})=(1+o(1))e^a\) as \(a\to\infty\). This concerns the **prime-shift operator alone**, not the full Weil form, whose archimedean energy rises on the high-frequency functions used below.

To prove the recurrence needed for the theorem, set \(\alpha_j=\ell_j/(2\pi)\). Dirichlet's simultaneous approximation theorem supplies, for each positive integer \(N\), an integer \(1\le q_N\le N^r\) with \(\max_j\|q_N\alpha_j\|_{\mathbb R/\mathbb Z}\le1/N\). If the \(q_N\) are unbounded, take an unbounded subsequence. If they are bounded, some integer \(q\) occurs infinitely often and satisfies \(q\alpha_j\in\mathbb Z\) for every \(j\); then take integer multiples of \(q\). In either case there are \(t_k\to\infty\) with \(e^{it_k\ell_j}\to1\) simultaneously for all \(j\). No independence hypothesis on the lengths is required.

Let \(J_t f(x)=\sqrt2\sin(tx)f(x)\). It exchanges parity. For either shift in (1),
\[
 \|[S_{\pm\ell_j},J_t]f\|_2
 \le\sqrt2|e^{it\ell_j}-1|\,\|f\|_2,
\]
so \(\|[P,J_{t_k}]\|\to0\). Riemann–Lebesgue gives, for every fixed \(f,g\in L^2(I_a)\),
\[
 \|J_{t_k}f\|_2^2\to\|f\|_2^2,
 \qquad \langle J_{t_k}f,J_{t_k}g\rangle\to\langle f,g\rangle.
\]
Consequently \(\langle J_{t_k}f,PJ_{t_k}f\rangle/\|J_{t_k}f\|^2\to\langle f,Pf\rangle/\|f\|^2\). Smooth compactly supported functions of either parity are dense in their respective \(L^2\) subspaces, and \(J_t\) preserves this test class; hence both Rayleigh extrema transfer in both directions.

The full spectral statement follows by the same approximate intertwining. If \(\lambda\in\sigma(P_+)\), self-adjointness provides unit even approximate eigenvectors \(f_m\) with \(\|(P-\lambda)f_m\|\to0\). By boundedness of \(P\), they may first be approximated by compact smooth even vectors. Fix a countable dense set \(v_1,v_2,\ldots\) in the odd subspace. For each \(m\), choose a sufficiently late recurrent \(t_{k(m)}\) so that \(\|J_{t_{k(m)}}f_m\|\to1\), \(\|[P,J_{t_{k(m)}}]\|<1/m\), and \(|\langle v_j,J_{t_{k(m)}}f_m\rangle|<1/m\) for \(j\le m\); the last condition is Riemann–Lebesgue applied to the fixed \(f_m\). The normalized odd vectors then form a **singular Weyl sequence**: their residual tends to zero and they converge weakly to zero. Thus \(\lambda\in\sigma_{\rm ess}(P_-)\). Reverse parity to obtain the displayed fourfold equality. For \(c_j\ge0\), \(|\langle f,Pf\rangle|\le\langle |f|,P|f|\rangle\), so the upper full-space Rayleigh extremum equals \(\|P\|\), proving (2).

As a sanity check, take one shift with \(\ell/2<a<\ell\). In positive-halfline coordinates its even restriction is \(+cJ\), and its odd restriction is \(-cJ\), where \(J\) is reflection on \((\ell-a,a)\) and zero outside. Both have spectrum \(\{-c,0,c\}\), consistent with the theorem. Their quadratic signs on individual positive functions differ, but their spectra do not.

There is a direct obstruction for the [continuum-prime square](../weil-and-spectral/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md). Write \(P_a^{\rm odd}=P_{a,\mathrm{cont}}^{\rm odd}+\mathcal R_a^{\rm odd}\), with \(P_{a,\mathrm{cont}}^{\rm odd}=-\mathcal G_a\le0\) and \(\mathcal G_a\) a continuous-kernel compact operator. Weyl's compact-perturbation theorem and the parity result give the exact essential-spectrum identity
\[
\sigma_{\rm ess}(\mathcal R_a^{\rm odd})
=\sigma_{\rm ess}(P_a^{\rm odd})=\sigma(P_a^{\rm odd}),
\qquad
\sup\sigma_{\rm ess}(\mathcal R_a^{\rm odd})=\|P_a\|.
\tag{3}
\]
For any \(a>(\log2)/2\), the edge of length \(\ell=\log2\) joins \(-\ell/2\) to \(+\ell/2\) inside \(I_a\). Take a nonzero, nonnegative smooth bump \(b\) in a sufficiently small neighborhood of \(+\ell/2\), and set \(g(x)=b(x)+b(-x)\). Then \(g\in C_c^\infty(I_a)\) is even and \(\langle g,P_ag\rangle>0\): the \(n=2\) edge joins the two bumps, and every other prime-shift contribution is nonnegative. Set \(f_k=J_{t_k}g\), which is odd. The theorem gives \(\langle f_k,P_af_k\rangle\to\langle g,P_ag\rangle>0\), whereas \(f_k\rightharpoonup0\) and compactness gives \(\langle f_k,\mathcal G_af_k\rangle\to0\). Since \(\mathcal R_a^{\rm odd}=P_a^{\rm odd}+\mathcal G_a\), no finite constant \(C\) can make the operator inequality \(\mathcal R_a^{\rm odd}\le C\mathcal G_a\) hold on the odd subspace. The same test rules out \(\mathcal R_a^{\rm odd}\le C\mathcal K_a\), where \(\mathcal K_a=\mathcal G_a-2|h_a\rangle\langle h_a|\) is the continuum square after exact pole compensation. In particular, (3) and the weighted Schur/PNT asymptotic give \(\sup\sigma_{\rm ess}(\mathcal R_a^{\rm odd})=(1+o(1))e^a\). This rules out treating the arithmetic discrepancy as a small \(L^2\)-operator perturbation of the stabilizing continuum square or its compensated Green kernel. It does not rule out a bound that also uses Suzuki's logarithmically growing archimedean form.
