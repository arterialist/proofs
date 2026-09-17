# Near-null prime graph states can leave a growing set of primes out of phase

The weighted graph identity for the actual odd Weil prime operator measures an **average** across prime-power shifts. It does not force every prime coordinate to return to phase zero. This note makes that distinction quantitative, including exact pole-nullity and all admitted prime powers. It does not give a negative Weil form or an RH result.

Let \(a\to\infty\), \(N=e^{2a}\), \(\phi(x)=\cosh(x/2)\), and \(Z_a=\int_{-a}^a\phi(x)^2dx=a+\sinh a\). Use the full weighted row \(S_a[F]=\int (P_a\phi/\phi)|F|^2\) and graph deficit \(D_a[F]=S_a[F]-\langle F,P_aF\rangle\) from the [prime graph identity](prime-shift-weighted-schur-window-asymptotic.md). Every \(p^r<N\) appears with \(\Lambda(p^r)/\sqrt{p^r}\).

**Theorem.** There are real \(C_c^\infty(0,a)\) half-line tests \(u_a\) with exact pole moment \(\langle\sqrt2\sinh(x/2),u_a\rangle=0\), whose normalized odd extensions \(F_a\) satisfy
\[
S_a[F_a]=(1+o(1))e^a,\qquad
D_a[F_a]=4\log a+O(1),
\tag{1}
\]
while their carrier frequencies \(t_a\to\infty\) obey
\[
\max_{p\le3a}|e^{it_a\log p}+1|\longrightarrow0.
\tag{2}
\]
Thus \(D_a[F_a]/S_a[F_a]=O(e^{-a}\log a)\), although every prime up to \(3a\) is maximally far from phase one. More generally, for \(Y=e^{\eta a}\) with fixed \(0<\eta<1\), the same construction has \(D_a[F_a]=4\eta a+O(1)\) while every \(p\le Y\) has phase tending to \(-1\).

To see the exact graph calculation, prescribe a torus phase \(\theta_p\) to every prime \(p<N\). Unique factorization makes their logarithms rationally independent, so the continuous Kronecker flow supplies arbitrarily large \(t\) approaching all these phases simultaneously. Before smoothing and pole correction, put
\[
F_{a,t}(x)=\sqrt{2/Z_a}\,\phi(x)\sin(tx)\mathbf1_{(-a,a)}(x).
\]
At fixed \(a\), as \(t\to\infty\) along the chosen recurrence, \(\|F_{a,t}\|_2^2\to1\). Direct integration of the graph edge gives
\[
I_a(\ell):=\int_{-a}^{a-\ell}\phi(x)\phi(x+\ell)dx
=\sinh(a-\ell/2)+(a-\ell/2)\cosh(\ell/2).
\tag{3}
\]
Oscillatory averaging in the exact graph identity therefore yields
\[
D_a[F_{a,t}]\longrightarrow
\frac2{Z_a}\sum_{p^r<N}\frac{\log p}{p^{r/2}}
I_a(r\log p)\bigl(1-\cos(r\theta_p)\bigr).
\tag{4}
\]
The [uniform weighted-row asymptotic](prime-shift-weighted-schur-window-asymptotic.md) similarly gives \(S_a[F_{a,t}]=(1+o(1))e^a\) after the diagonal choice in \(a\).

Choose \(\theta_p=\pi\) for \(p\le Y\) and zero for the remaining primes. Only odd powers of the selected primes contribute to (4). Since \(Z_a\sim e^a/2\), equation (3) gives, after multiplication by \((\log p)p^{-r/2}\), the main term \((\log p)p^{-r}\) and a summable error \(o(1)\) whenever \(Y\le e^{\eta a}\), \(\eta<1\). Hence
\[
D_a=4\sum_{p\le Y}(\log p)\frac{p}{p^2-1}+o(1)
=4\log Y+O(1).
\tag{5}
\]
The last equality is the classical weighted Mertens estimate; replacing \(p/(p^2-1)\) by \(1/p\) changes the sum by a convergent constant. In particular, the exact limiting cost of making only the \(p=2\) phase equal to \(-1\) is \((8/3)\log2\), negligible beside the row \(e^a\).

The conclusion remains valid on compact smooth pole-null tests. For each fixed \(a\), choose a sufficiently late Kronecker return that the finite phase errors and the oscillatory pole moment are as small as required. Smooth the endpoints in the logarithmic form norm, then subtract a vanishing multiple of a fixed compact odd function with nonzero pole moment. The graph and row are bounded quadratic forms at fixed \(a\); a diagonal choice makes these changes \(o(1)\) in (1) and (5). Normalize afterward.

There is a stronger obstruction to a direct use of [consecutive-integer phase rigidity](../successor-and-division/prime-phase-consecutive-integer-rigidity.md). Choose the exceptional angles \(\theta_p\in(\pi/2,3\pi/2)\), \(p\le Y=3a\), so that these angles together with \(2\pi\) are rationally independent, and keep all other prime target phases zero. The target phase of an integer \(n\le N\) then vanishes exactly when \(n\) has no prime factor \(\le Y\). Because only finitely many integers are under consideration, sufficiently accurate recurrence makes the returning integers at a suitable tolerance **exactly** these \(Y\)-rough integers. Formula (4), using \(1-\cos(r\theta_p)\le2\), still gives \(D_a\le4\log a+O(1)\).

If \(K\) numbers \(n_0,n_0+d,\ldots,n_0+(K-1)d\le N\) are all \(Y\)-rough, every prime \(p\le\min(Y,K)\) divides \(d\); otherwise one term in the progression is divisible by \(p\). Thus
\[
\prod_{p\le\min(Y,K)}p\le d\le\frac{N}{K-1}.
\tag{6}
\]
For \(Y=3a\), the prime number theorem gives \(\log\prod_{p\le Y}p=(3+o(1))a>\log N=2a\), so \(K\ge Y\) is impossible. For \(K<Y\), (6) gives \(K\le(2+o(1))a\). Thus an arbitrarily small **relative** full-graph deficit does not provide the long progression of returning integers used by the present finite-difference proof.

These carriers have no useful upper bound on \(\log t_a\); the archimedean form may already dominate the prime operator. The theorem refutes an inference from weighted graph near-nullity to uniform or long-progression phase recurrence, not Weil positivity. A successful odd-sector proof still needs a bound on the signed \(\mathcal A_a-P_a\) at the actual carrier cost. Odd Weil positivity on all windows implies RH by [Yoshida's criterion as summarized by Suzuki](https://arxiv.org/html/2606.09096v2).
