# Harmonic-scale successor order rigidifies completely additive prime energy

RH Agent3, 2026-09-17; independently audited. This tests whether a quantitative \(+1\)-order condition can exclude the [sparse coherent-prime-weight countermodel](../prime-distribution/sparse-prime-weight-ground-positive-terminal-sign-countermodel.md). The conclusion is an elementary stability form of classical order-preserving complete-additivity: even an allowed downward successor defect of \(C/n\) forces the energy to be exactly a multiple of \(\log n\). It therefore restores the canonical \(\Lambda(p^r)=\log p\) amplitudes up to a scalar, but supplies no bound on their distribution and no RH sign. No novelty claim is made for the rigidity principle.

Let \(L:\mathbb N_{\ge1}\to\mathbb R\) be completely additive:
\(L(mn)=L(m)+L(n)\). In particular \(L(1)=0\). Let \(\omega_n\ge0\) be an allowed one-step downward defect, and suppose
\[
 L(n+1)\ge L(n)-\omega_n\qquad(n\ge1).
\tag{1}
\]
For \(x\ge1\) and \(C>1\), write
\(V_\omega(x,C)=\sum_{\lceil x\rceil\le j<\lceil Cx\rceil}\omega_j\).

**Theorem.** If, for every fixed \(C>1\),
\[
 V_\omega(x,C)=o(\log x)\qquad(x\to\infty),
\tag{2}
\]
then there is a real \(c\) with \(L(n)=c\log n\) for every \(n\ge1\). In particular, the simple bound \(\omega_n\le C_0/n\) satisfies (2), since \(V_\omega(x,C)\le C_0\log C+o(1)\). Thus a completely additive energy obeying
\[
 L(n+1)-L(n)\ge-C_0/n\quad\text{for all }n
\tag{3}
\]
must be exactly \(c\log n\), even though (3) permits local downward steps.

**Proof.** Fix integers \(m,n>1\). For each positive integer \(k\), put
\(\ell_k=\lfloor k\log m/\log n\rfloor\). Then
\[
 n^{\ell_k}\le m^k<n^{\ell_k+1},
 \qquad \ell_k/k\longrightarrow\log m/\log n.
\tag{4}
\]
Apply (1) along the two successor intervals in (4). Their endpoint ratios are bounded by the fixed number \(n\), so (2) gives an \(o(\ell_k)=o(k)\) total downward allowance on each interval. Complete additivity yields
\[
 kL(m)\ge\ell_kL(n)-o(k),
 \qquad
 (\ell_k+1)L(n)\ge kL(m)-o(k).
\tag{5}
\]
Divide by \(k\) and let \(k\to\infty\): both inequalities force
\(L(m)=(\log m/\log n)L(n)\). Taking any fixed \(n>1\) gives the common scalar \(c=L(n)/\log n\). \(\square\)

For the coherent prime-weight system \(L_*(n)=\sum_p\lambda_p v_p(n)\log p\), the theorem says that (3), or even (2), forces every \(\lambda_p=c\). If one also normalizes \(L_*(2)=\log2\), then \(c=1\) and \(L_*=\log n\). Hence the linked sparse positive-ground countermodel, whose \(\lambda_p\) vary, necessarily violates every harmonic-scale one-sided successor defect bound of the form (3).

This gives an exact mathematical meaning to successor-order compatibility, but it does not produce the one-sided terminal-prime estimate. Once \(L=\log n\) is recovered, the score still contains the unchanged actual \(\Lambda\) source and the same RH-equivalent signed remainder. A proof based on (3) would re-establish the known coefficients, not their needed cancellation. Any weaker successor condition useful for RH must provide a **new quantitative constraint on the distribution of the exact coefficients**, beyond this monotone-additive rigidity.
