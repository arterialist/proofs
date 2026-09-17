# Certified positivity of Suzuki's pole-free odd form at the first reflected prime

For Suzuki's localized form in [equations (1.1), (2.7)](https://arxiv.org/html/2606.09096v1), let \(L_a^{\rm odd}\) denote the pole-free odd operator defined in the [parity reduction](suzuki-parity-rank-one-reflected-prime-obstruction.md), equation (1). The following is an unconditional **single-window** result:

\[
\boxed{L_{1/2}^{\rm odd}\ \ge\ \frac{27}{10000}I.}
\tag{1}
\]

It gives neither the rank-one return bound \(\tau_{1/2}\le1\) nor positivity at all windows. The rational interval computation is [this 1024-bit Arb script](../../certificates/suzuki_odd_half_window_reflected_two.py).

[Zhu's 2026 compact-window certificate](https://arxiv.org/html/2608.24827v2) already proves positivity of the **full** Weil form for all complex tests supported in \([-0.8,0.8]\), a stronger finite-window result. The present calculation is an independent, source-specific odd-sector certificate and is not a positivity frontier.

## Operator reduction

Use the unitary identification of odd \(F\in L^2(-a,a)\) with \(u(x)=\sqrt2F(x)\) on \((0,a)\). Put
\[
 m(t)=\Re\psi(1/4+it/2)-\log\pi,
 \qquad \ell=\log2,\qquad w=\frac{\log2}{\sqrt2}.
\]
For \(a=1/2\), \(e^{2a}=e<3\), so the only prime-power shift is \(n=2\). As \(a<\ell<2a\), set \(E=(\ell-a,a)\) and let \(J u(x)=u(\ell-x)\) for \(x\in E\), zero elsewhere. The odd signs in the cross-zero prime correlation give the **positive reflected operator** \(wJ\). In this normalization the quadratic form is exactly
\[
 \langle u,L_{1/2}^{\rm odd}u\rangle
 =\frac2\pi\int_0^\infty m(t)
       \left|\int_0^a u(x)\sin(tx)\,dx\right|^2dt
     +w\langle u,Ju\rangle .
\tag{2}
\]
The factor \(w\), rather than \(2w\), follows by writing the full-line shift integral as
\(\int F(x+\ell)\overline{F(x)}dx=-\frac12\langle u,Ju\rangle\).

The digamma series shows that \(m\) increases on \([0,\infty)\): for \(t>0\),
\[
 m'(t)=\sum_{n=0}^\infty
 \frac{(n+1/4)t}{2((n+1/4)^2+t^2/4)^2}>0.
\tag{3}
\]
Arb verifies \(m(14)>4/5\). Set \(M=4/5\), \(C=MI+wJ\), and \(k(t)=(M-m(t))_+\). Sine-Plancherel yields \(L_{1/2}^{\rm odd}\ge C-K\), where
\[
 \langle u,Ku\rangle=\frac2\pi\int_0^{14} k(t)
       \left|\int_0^a u(x)\sin(tx)dx\right|^2dt.
\tag{4}
\]
Because \(J\) is a self-adjoint partial reflection with \(\|J\|=1\), Arb's bound \(w<1/2\) gives \(C>(3/10)I\).

## Finite-rank upper bound for the low frequencies

Partition \([0,14]\) into 300 cells of width \(7/150\). On cell \(j\), choose the rational constant \(q_j\) by the script's outward Arb upper endpoint of \(M-m(7j/150)\), rounded upward to denominator \(10^{12}\) with one extra unit. The script asserts \(q_j>M-m(7j/150)\) as an interval comparison. By (3), \(q(t)=q_j\ge k(t)\) throughout the cell. Thus \(K\le K_q=BB^*\), with
\[
 (Bv)(x)=\sqrt{2/\pi}\int_0^{14}\sqrt{q(t)}\sin(tx)v(t)dt,
 \qquad \int_0^{14}q(t)dt<100.
\tag{5}
\]
The computed mass enclosure is \(14.909924620205393\ldots\); the proof uses only the rational bound 100.

Let \(p_{13}(z)=\sum_{j=0}^{12}(-1)^jz^{2j+1}/(2j+1)!\) and replace \(\sin(tx)\) in \(B\) by \(p_{13}(tx)\) to form \(B_{13}\). Since \(tx\le7\), the alternating tail after the 13 terms decreases and
\[
 |\sin(tx)-p_{13}(tx)|\le R:=\frac{7^{27}}{27!}<\frac1{150000}.
\tag{6}
\]
The Hilbert–Schmidt bound, \(\pi>3\), \(C>(3/10)I\), and (5) imply
\[
 \|C^{-1/2}(B-B_{13})\|
 \le R\sqrt{\frac{2a}{\pi}\int q}\sqrt{\frac{10}{3}}
 <12R<10^{-4}.
\tag{7}
\]

Here is the finite matrix computed by Arb. For \(i=0,\ldots,12\), put
\[
 U_i(x)=(x/a)^{2i+1},\qquad
 V_i(t)=\sqrt{\frac{2q(t)}\pi}\,
       \frac{(-1)^i(at)^{2i+1}}{(2i+1)!}.
\]
Then \(B_{13}=UV\). The matrices \(G_U=(\langle U_i,C^{-1}U_j\rangle)\) and \(G_V=(\langle V_i,V_j\rangle)\) are computed from polynomial integrals and rational step moments. Specifically, \(C^{-1}=M^{-1}I\) on \((0,\ell-a)\), while on \(E\)
\[
 C^{-1}=\frac{MI-wJ}{M^2-w^2}.
\tag{8}
\]
This makes every \(G_U\) entry a finite combination of powers of \(\ell\) and rational numbers; every \(G_V\) entry is a finite combination of rational step moments and \(1/\pi\). The script evaluates both as outward Arb balls.

Verified Cholesky gives \(G_U=HH^*\) and proves
\[
 \frac{99}{100}I-H^*G_VH>0.
\tag{9}
\]
The smallest diagonal Cholesky pivot enclosure in (9) is \(0.0319328600657\ldots\) with radius below \(6\cdot10^{-300}\); the smallest pivot for \(G_U\) is \(1.0624216736797\ldots\cdot10^{-15}\) with radius below \(4\cdot10^{-290}\). These are **pivots**, not eigenvalue lower bounds. Since the nonzero spectra of \(B_{13}^*C^{-1}B_{13}\) and \(H^*G_VH\) coincide, (9) gives \(\|C^{-1/2}B_{13}\|^2<99/100\). Combining (7),
\[
 \|C^{-1/2}B\|^2<(\sqrt{99/100}+10^{-4})^2<991/1000.
\]
Consequently \(K_q=BB^*<(991/1000)C\), and (1) follows from
\(L_{1/2}^{\rm odd}\ge C-K_q>(9/1000)C>(27/10000)I\).

## Reproduction and scope

The exact rational inputs are \(a=1/2\), \(M=4/5\), cutoff \(T=14\), 300 cells, denominator \(10^{12}\), Taylor rank 13, comparison \(99/100\), and error threshold \(10^{-4}\). All other nonrational entries (\(\log2\), \(\pi\), digamma values, square roots, and Cholesky entries) are Arb enclosures. The step weights are rational integers derived from outward enclosures, with their defining inequalities asserted individually. On Python 3.14, `python-flint==0.9.0` (bundled FLINT 3.6.0), run:

```sh
python3 -m pip install --target /tmp/suzuki-arb python-flint==0.9.0
PYTHONPATH=/tmp/suzuki-arb python3 certificates/suzuki_odd_half_window_reflected_two.py
```

The script checks every comparison used above and prints `CERTIFIED: L_1/2^odd >= 27/10000 I`. The result is a rigorous positive lower bound for one pole-free odd window; a uniform-in-\(a\) bound and the rank-one inequality \(\tau_a\le1\) remain separate questions.
