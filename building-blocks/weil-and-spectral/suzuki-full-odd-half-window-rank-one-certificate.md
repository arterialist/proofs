# Certified full odd Weil positivity at the first-prime window

Let \(A_a^{\rm odd}\) be the odd restriction of [Suzuki's localized Weil form](https://arxiv.org/html/2606.09096v1), including its polar rank one. In the notation of the [parity reduction](suzuki-parity-rank-one-reflected-prime-obstruction.md), \(A_a^{\rm odd}=L_a^{\rm odd}-2|s_a\rangle\langle s_a|\). The [Arb certificate](../../certificates/suzuki_full_odd_half_window_rank_one.py) proves the unconditional single-window bound
\[
\boxed{A_{1/2}^{\rm odd}\ge\frac7{10^6}I.}
\tag{1}
\]
Consequently the exact odd rank-one return satisfies \(\tau_{1/2}<1\). By zero extension, (1) also holds for every \(0<a\le1/2\). This makes no assertion for larger windows or for RH.

[Zhu's 2026 compact-window theorem](https://arxiv.org/html/2608.24827v2) already certifies the full Weil form on \([-0.8,0.8]\) for arbitrary complex tests, stronger than (1). The present result is an independent verification in Suzuki's odd operator coordinates; it is not a new finite-window positivity frontier.

Under the unitary map from odd functions on \((-a,a)\) to \(L^2(0,a)\), put \(h(x)=\sqrt2\sinh(x/2)\). At \(a=1/2\), only the \(n=2\) prime shift has positive-measure overlap. With \(w=(\log2)/\sqrt2\) and \(J\) the partial reflection on \((\log2-a,a)\), the full odd form is
\[
 A_{1/2}^{\rm odd}=\mathcal A+wJ-2|h\rangle\langle h|,
 \qquad
 \langle u,\mathcal Au\rangle=\frac2\pi\int_0^\infty
 \bigl(\Re\psi(1/4+it/2)-\log\pi\bigr)
 \left|\int_0^a u(x)\sin(tx)dx\right|^2dt.
\tag{2}
\]
The [pole-free certificate](suzuki-reflected-two-half-window-positive-certificate.md) derives the reflected-prime coefficient and the monotonicity of the digamma multiplier.

Choose the rational baseline \(M=13/10\), cutoff \(T=24\), and \(C=MI+wJ\). Arb proves \(m(24)>M\) and \(C>(4/5)I\). The script constructs a rational step majorant \(q(t)\ge(M-m(t))_+\) on 50,000 cells of width \(24/50000=3/6250\). Every cell weight has denominator \(10^{12}\), is derived from an outward Arb endpoint, and passes a strict interval comparison. Its verified mass is \(23.8400629870614432\ldots<50\). If
\[
 (Bv)(x)=\sqrt{2/\pi}\int_0^{24}\sqrt{q(t)}\sin(tx)v(t)dt,
\]
then \(A_{1/2}^{\rm odd}\ge C-BB^*-2|h\rangle\langle h|\).

Replace \(\sin(tx)\) by its 26-term odd Taylor polynomial to obtain the rank-26 operator \(B_N=UV\). Here \(tx\le12\), so the alternating-tail estimate gives
\[
 |\sin(tx)-p_{26}(tx)|\le R=\frac{12^{53}}{53!},
 \qquad \delta:=\|C^{-1/2}(B-B_N)\|<5R<10^{-11}.
\tag{3}
\]
The Hilbert–Schmidt factor 5 follows from \(2a=1\), \(\pi>3\), \(\int q<50\), and \(C>4I/5\).

Set \(G_U=U^*C^{-1}U\), \(G_V=VV^*\), and take its verified Cholesky factor \(G_U=HH^*\). Define \(Q=H^*G_VH\), \(g=U^*C^{-1}h\), and \(z=H^*G_Vg\). The script computes \(G_U\), \(g\), and \(s_0=\langle h,C^{-1}h\rangle\) from exact polynomial/exponential antiderivatives, using
\[
 C^{-1}=M^{-1}I\quad(0<x<\log2-a),\qquad
 C^{-1}=\frac{MI-wJ}{M^2-w^2}\quad(\log2-a<x<a).
\]
Every transcendental number and matrix operation is enclosed by 1024-bit Arb balls. Verified Cholesky proves \((99/100)I-Q>0\), so \(P:=C-B_NB_N^*\ge(1/100)C\). The smallest positive pivot enclosure here centers at \(0.04540767413146\ldots\).

To include the pole, verified Cholesky also proves positivity of the \(27\times27\) block matrix
\[
 \begin{pmatrix}
 I-Q&\sqrt2z\\
 \sqrt2z^*&\frac{999}{1000}-2(s_0+g^*G_Vg)
 \end{pmatrix}>0.
\tag{4}
\]
Its smallest positive pivot enclosure centers at \(0.00124627170041476\ldots\). The Schur complement of its upper-left block is \(999/1000-\tau_N\), where Woodbury's identity gives
\[
 \tau_N:=2\langle h,P^{-1}h\rangle
 =2\bigl(s_0+g^*G_Vg+z^*(I-Q)^{-1}z\bigr).
\]
Thus \(\tau_N<999/1000\) and \(P-2|h\rangle\langle h|>(1/1000)P\ge10^{-5}C\).

From (3), \(\|C^{-1/2}(BB^*-B_NB_N^*)C^{-1/2}\|<2\delta+\delta^2<3\cdot10^{-11}\). Therefore
\[
 A_{1/2}^{\rm odd}>(10^{-5}-3\cdot10^{-11})C
 >\frac45(10^{-5}-3\cdot10^{-11})I
 >\frac7{10^6}I,
\]
which proves (1). The same estimates give \(\tau_{1/2}\le\tau_N/(1-3\cdot10^{-9})<1\).

The rational inputs are \(a=1/2\), \(M=13/10\), \(T=24\), 50,000 cells, denominator \(10^{12}\), Taylor rank 26, matrix ceiling \(99/100\), Schur ceiling \(999/1000\), error threshold \(10^{-11}\), and final bound \(7/10^6\). The script ran with `python-flint==0.9.0` (FLINT 3.6.0). From the repository root, run `PYTHONPATH=/tmp/suzuki-arb python3 certificates/suzuki_full_odd_half_window_rank_one.py` after installing that package into `/tmp/suzuki-arb`.
