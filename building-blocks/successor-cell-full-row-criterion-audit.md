# The exact successor-cell row is an RH criterion, not a clock consequence

The integer \(+1\) clock and floor-division cells give an exact finite Weil row with every actual coefficient \(\Lambda(p^r)=\log p\), the gamma term, and both pole terms. This note states a falsifiable one-row positivity candidate, proves that it is already RH-equivalent, and tests the proposed clock-to-positivity route against a coherent coefficient countermodel and the known diagonal obstruction. It does not establish the candidate for the actual zeta function.

## The source-specific candidate

Use the [exact odd successor-cell collar](successor-cell-odd-collar-triangular-prime-oscillation.md). For \(h=\log2\), set \(W(s)=s\) on \([0,h]\), \(W(s)=2h-s\) on \([h,2h]\), and \(W(s)=0\) elsewhere. At \(X=2m\), put \(a=\tfrac12\log X\) and let \(f_m\) be the odd two-collar box in that note. Its complete Weil row is exactly
\[
\mathcal C_m:=Q_a(f_m)
=C_h+D_X+R_X,\qquad
D_X=\sum_{X/4<n<X}\frac{\Lambda(n)}{\sqrt n}
W\!\left(\log\frac Xn\right)-c_h\sqrt X,
\tag{1}
\]
where \(c_h=(6-4\sqrt2)>0\), \(C_h\) is the fixed gamma-plus-cross-pole constant, and the strictly positive cross-gamma remainder satisfies \(R_X=O(X^{-5/2})\). The sum retains every prime power. The \(-c_h\sqrt X\) term is exactly the leading negative pole payment to the continuous-prime density. The [source note, equations (2)–(9)](successor-cell-odd-collar-triangular-prime-oscillation.md) proves this identity with the cell endpoints and both prime orientations.

The precise candidate is
\[
\boxed{\qquad\mathcal C_m\ge0
\quad\text{for every sufficiently large integer }m.\qquad}
\tag{2}
\]
It would be falsified by actual-prime negative full rows at arbitrarily large cutoffs. It uses the complete gamma and pole coupling.

**Proposition 1.** Candidate (2) is equivalent to RH.

**Proof.** Under RH, the [full Weil form](https://arxiv.org/html/2606.09096v2) is nonnegative on every admissible compact test. The boxes \(f_m\) lie in its logarithmic form domain: their Fourier transforms are \(O_m((1+|t|)^{-1})\), so the gamma integral and the zero-side sum converge. Hence \(\mathcal C_m\ge0\) for every \(m\).

Conversely, (1) and (2) make \(D_{2m}\) bounded below eventually. The exact box weight is Lipschitz, and the Chebyshev bound gives \(|D_X-D_Y|\ll X^{-1/2}\) when \(|X-Y|\le2\) and \(X,Y\) are comparable; thus \(D_X\) is bounded below for all large real \(X\). Define \(D(a)=D_{e^{2a}}\) and
\[
F(z)=\int_0^h e^{-zs/2}ds
=\frac{2(1-2^{-z/2})}{z},\qquad F(0)=h.
\tag{3}
\]
The exact Laplace transform from the [collar note, equation (11)](successor-cell-odd-collar-triangular-prime-oscillation.md) is, initially for \(\Re z>1\),
\[
\int_0^\infty D(a)e^{-za}da
=\frac12F(z)^2\left(-\frac{\zeta'}{\zeta}\right)
 \!\left(\frac{z+1}{2}\right)
 -\frac{F(1)^2}{z-1}.
\tag{4}
\]
The apparent pole at \(z=1\) cancels, and the continuation is analytic at every positive real \(z\). If \(\zeta\) had a zero \(\rho\) with \(\Re\rho>1/2\), then \(z_\rho=2\rho-1\) would be a nonreal pole with positive real part. The factor \(F(z_\rho)\ne0\), since all nonzero zeros of \(F\) lie on the imaginary axis. An eventual lower bound on \(D(a)\) makes \(D(a)+C\) nonnegative on a late half-line. Its Laplace transform has finite abscissa, and [Landau's theorem for nonnegative Laplace transforms, as applied in the collar note](successor-cell-odd-collar-triangular-prime-oscillation.md) would force a singularity at a positive real abscissa at least \(\Re z_\rho\), contrary to (4). Thus no such \(\rho\) exists; the functional equation gives RH. ∎

This proposition is a target identification, not a positivity proof. In particular, replacing \(D_X\) by a continuous density would remove exactly the signed term whose lower bound is equivalent to RH. The same collar note proves that \(D_{2m}\) has unconditional excursions of both signs from a known critical zero. Those excursions do not settle (2), because \(C_h\) remains in the full row.

## Test against coherent prime histories

The [sparse coherent-prime-weight countermodel](sparse-prime-weight-ground-positive-terminal-sign-countermodel.md) keeps the integer successor, actual prime-power support, one amplitude per prime base, PNT, and a positive factorial ground, while breaking a fixed terminal-row sign. The same construction applies directly to (1). The details below make the test of this **exact cell row** explicit.

Let \(c_W=\int_0^{2h}e^{-s/2}W(s)^2ds>0\), choose summable \(\epsilon_j=\epsilon_0 2^{-j}\) and alternating signs \(\sigma_j=(-1)^j\), and choose widely separated even \(X_j=2m_j\to\infty\). Put \(I_j=(X_j/4,X_j)\). For primes \(p\in I_j\), set
\[
\lambda_p=1+\sigma_j\epsilon_j
W\!\left(\log\frac{X_j}{p}\right),\qquad
\Lambda_*(p^r)=\lambda_p\log p\quad(r\ge1),
\tag{5}
\]
and set \(\lambda_p=1\) elsewhere. Choose \(\epsilon_0\) small so that \(1/2\le\lambda_p\le3/2\). Then \(\lambda_p\to1\), and \(\psi_*(x)=\sum_{n\le x}\Lambda_*(n)=x+o(x)\), by comparison with the ordinary PNT.

The complete factorial ground
\[
\mathfrak F_*(x)=
\log x-\sum_{n\le x}\frac{\Lambda_*(n)}n
+\frac{\psi_*(x)}x
\tag{6}
\]
remains strictly positive if the first band is sufficiently late and \(\epsilon_0\) sufficiently small. Indeed, the change from the positive actual ground is bounded uniformly by
\[
\sum_{n\le x}\frac{|\Lambda_*(n)-\Lambda(n)|}{n}
+\frac1x\sum_{n\le x}|\Lambda_*(n)-\Lambda(n)|
\ll \sum_j\epsilon_j+\epsilon_0.
\tag{7}
\]
The first estimate uses \(\sum_{p\in I_j}\log p/(p-1)=O_h(1)\); the second uses \(\psi(x)\ll x\). Below the first band the ground is unchanged, and the actual ground has a positive limit. This is the same uniform perturbation argument as in the linked countermodel.

The actual centered row has \(D_X=o(\sqrt X)\) by PNT. Choose \(X_j\) so large that the bands are disjoint, \(\epsilon_j\sqrt{X_j}\to\infty\), and \(|D_{X_j}|\le j^{-1}c_W\epsilon_j\sqrt{X_j}\). Weighted PNT gives
\[
\sum_{p\in I_j}\frac{\log p}{\sqrt p}
W\!\left(\log\frac{X_j}{p}\right)^2
=c_W\sqrt{X_j}+o(\sqrt{X_j}).
\tag{8}
\]
Perturbed bases from earlier bands enter \(I_j\) only through proper powers, whose total \(\sum(\log p)/p^{r/2}\) weight in one fixed-width terminal band is \(O_h(1)\). Therefore the formal full row formed with \(\Lambda_*\) but the **same** gamma and pole terms satisfies
\[
\mathcal C^*_{m_j}
=C_h+D_{X_j}
 +\sigma_j c_W\epsilon_j\sqrt{X_j}
 +o(\epsilon_j\sqrt{X_j})+O_h(1).
\tag{9}
\]
It has unbounded values of both signs. This is a countermodel to deriving (2) from the \(+1\) clock, prime-power coherence, PNT, and factorial-ground positivity alone. It makes no claim that \(\Lambda_*\) has the Riemann zeta functional equation.

## The diagonal route is already closed

The [successor-cell ground-state defect theorem](successor-cell-ground-state-defect-obstruction.md) compares the complete prime refinement matrix \(K_N\) with the diagonal \(D_N\) of the gamma-plus-pole matrix. It proves
\[
\lambda_{\max}(K_N)\ge c\sqrt N,\qquad
\max_n(D_N)_{nn}=O(\log N)
\tag{10}
\]
along odd cell cutoffs. Consequently **no** positive cell weight \(h\) can satisfy \(K_Nh\le D_Nh\) for all sufficiently large cutoffs. This rules out a universal local edge-square payment using only the diagonal gamma and pole entries. It does not rule out (2): the full off-diagonal gamma and pole interactions remain in (1) and in the exact Weil matrix.

In this audit, the exact row identity (1) is the relation that both uses the actual \(\log p\) amplitudes and couples the full gamma/pole terms. Its one-sided sign is already RH-equivalent; (5)–(9) exclude the qualitative successor and positive-ground mechanism, and (10) excludes diagonal payment. No independent causal-invariance identity or source-specific signed estimate has emerged from this successor-cell route.
