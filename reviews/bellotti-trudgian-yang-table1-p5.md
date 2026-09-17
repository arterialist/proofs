# Exact counterexample to one Table 1 bound

Bellotti, Trudgian, and Yang, [*Zero-free regions inspired by work of
Heath-Brown*](https://arxiv.org/abs/2603.21490v1), Table 1, state the
certified bound
\[
G_5(1,x)>0.00735709\qquad(x\in\mathbb R).
\]
Their stated coefficients do not satisfy this bound. With
\(y=\cos x=-78647/1000000\), the exact rational evaluation of their
polynomial and all fifteen retained prime powers gives
\[
0.00735649<G_5(1,\arccos y)<0.00735650<0.00735709.
\]
The [integer-arithmetic certificate](bellotti-trudgian-yang-table1-p5.py)
reconstructs the paper's coefficients \(a_k\) from its integers \(c_k\),
checks its printed \(a_0\) and \(a_1\), and proves both strict comparisons by
integer cross-multiplication. It uses the recurrence
\[
U_0=1,\quad U_1=-78647,\quad
U_j=2(-78647)U_{j-1}-1000000^2U_{j-2},
\quad U_j=1000000^jT_j(y).
\]

This refutes the individual \(p=5\) certificate, not the paper's zero-free
theorem. The [independent interval certificate](bellotti-trudgian-yang-ladder-repair.py)
repairs the aggregate estimate and strengthens the prime-power detector
bound used in its Lemma 10.

For each prime \(p<100\), the certificate proves a rational bound
\(G_p(1,x)>m_p\) for every real \(x\). It uses new bounds
\[
m_2=0.234195,\qquad m_3=0.050073,\qquad m_5=0.0073564,
\]
and the paper's remaining 22 numerical bounds. The proof evaluates
\(G_p\) with 128-bit Arb intervals on the grid
\(x_j=2\pi j/32768\), \(0\le j\le16384\), and uses
\[
|G_p''(1,x)|\le M_{2,p}:=
\sum_{m=1}^{15}\sum_{k=1}^{16}a_k(mk)^2p^{-m}.
\]
Linear interpolation between grid points has error less than
\(5M_{2,p}/32768^2\). Every interval evaluation exceeds its proposed
bound by more than this error. Since \(P(mx)\ge0\), the exact identity
\[
\partial_\sigma G_p(\sigma,x)
=-(\log p)\sum_{m=1}^{15}m p^{-m\sigma}P(mx)\le0
\]
extends the bounds from \(\sigma=1\) to the paper's range
\(\sigma_0\le\sigma\le1\). Directed Arb evaluation also gives
\[
\sum_{p<100}m_p\log p>0.235484.
\]

The paper first limits prime powers to \(p^m\le e^{59}\), but its displayed
15-rung sum includes a few terms beyond that limit. Their total is less
than \(2\cdot10^{-9}\): there are at most 375 such terms, and each has
\(p^{-m\sigma}<e^{-59/2}<2\cdot10^{-13}\), \(\log p<5\), and
\(P(mx)<5\). Write \(g(0)=\eta w(0)\) and
\(\kappa=433/859\). The inequality checked in the proof of the paper's
Lemma 11 is \(f(u)\ge\kappa g(0)=f(0)\) for \(0\le u\le59\).
It therefore implies the corrected detector bound
\[
\sum_{n\ge1}\frac{\Lambda(n)}{n^\sigma}f(\log n)P(t\log n)
>f(0)(0.235484-2\cdot10^{-9})>0.1187g(0).
\]
This is a stronger bound for the paper's actual prime-power detector.
It has not been propagated through the remaining zero-free-region estimates.

Original claim and coefficients: Bellotti, Trudgian, and Yang (2026).
Counterexample and replacement certificate: proofs project (17 September 2026).
